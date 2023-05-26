Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FF3712AFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 18:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjEZQs2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjEZQs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 12:48:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DF32D9;
        Fri, 26 May 2023 09:48:26 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6525B20FBA9B;
        Fri, 26 May 2023 09:48:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6525B20FBA9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685119705;
        bh=oAXQnJwRTkY9f0udlO0e4Ej6x7Z3Xr0xO8MLKsRFeZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lEqDvOlptHcL74A42gMy8Z16UH/AgtQqixKq2VwbQiNJhnAZ9kZdoX5aDd14GijVs
         Sz5qHZH8K8jqMd+fVqm4yepK4H0Y3SAptrQjfAxok2XpnT0T8LAvVkPmEk5GGwP7AC
         EqT0lSA4Vdio450gO4xBuRLDQp1g6QCKz5PmSCqw=
Date:   Fri, 26 May 2023 09:48:19 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2] tracing/user_events: Prevent same name but different
 args event
Message-ID: <20230526164819.GA74@W11-BEAU-MD.localdomain>
References: <20230526100336.76934-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526100336.76934-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 26, 2023 at 06:03:36PM +0800, sunliming wrote:
> User processes register name_args for events. If the same name but different
> args event are registered. The trace outputs of second event are printed
> as the first event. This is incorrect.
> 
> Return EADDRINUSE back to the user process if the same name but different args
> event has being registered.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace_events_user.c              | 34 +++++++++++++++----
>  .../selftests/user_events/ftrace_test.c       |  6 ++++
>  2 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b1ecd7677642..bd455052ccd0 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1753,6 +1753,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  	int ret;
>  	u32 key;
>  	struct user_event *user;
> +	int argc = 0;
> +	char **argv;
>  
>  	/* Prevent dyn_event from racing */
>  	mutex_lock(&event_mutex);
> @@ -1760,13 +1762,31 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  	mutex_unlock(&event_mutex);
>  
>  	if (user) {
> -		*newuser = user;
> -		/*
> -		 * Name is allocated by caller, free it since it already exists.
> -		 * Caller only worries about failure cases for freeing.
> -		 */
> -		kfree(name);
> -		return 0;
> +		if (args) {
> +			argv = argv_split(GFP_KERNEL, args, &argc);
> +			if (!argv)
> +				return -ENOMEM;

This out of memory case needs a refcount_dec(), otherwise we leak a
refcount here and the event won't ever be able to be deleted afterwards.

I would suggest having an error label for both the mismatch and out of
memory case, which makes a single spot to do the refcount_dec().

IE:
ret = -ENOMEM;
goto error;

Thanks,
-Beau

> +
> +			ret = user_fields_match(user, argc, (const char **)argv);
> +			argv_free(argv);
> +
> +		} else
> +			ret = list_empty(&user->fields);
> +
> +		if (ret) {
> +			*newuser = user;
> +			/*
> +			 * Name is allocated by caller, free it since it already exists.
> +			 * Caller only worries about failure cases for freeing.
> +			 */
> +			kfree(name);
> +			ret = 0;
> +		} else {
> +			refcount_dec(&user->refcnt);
> +			ret = -EADDRINUSE;
> +		}
> +
> +		return ret;
>  	}
>  
>  	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index 7c99cef94a65..6e8c4b47281c 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -228,6 +228,12 @@ TEST_F(user, register_events) {
>  	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
>  	ASSERT_EQ(0, reg.write_index);
>  
> +	/* Multiple registers to same name but different args should fail */
> +	reg.enable_bit = 29;
> +	reg.name_args = (__u64)"__test_event u32 field1;";
> +	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
> +	ASSERT_EQ(EADDRINUSE, errno);
> +
>  	/* Ensure disabled */
>  	self->enable_fd = open(enable_file, O_RDWR);
>  	ASSERT_NE(-1, self->enable_fd);
> -- 
> 2.25.1

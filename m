Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E587146FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjE2JXY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjE2JXX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 05:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DFEAC;
        Mon, 29 May 2023 02:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7402162247;
        Mon, 29 May 2023 09:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F23C4339B;
        Mon, 29 May 2023 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685352201;
        bh=GWbhfro7mScT3pUdsUQtz4ZAPeagy5Rb6k2c8ZAI6OQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIOU/xaGwkDyKcwyDocIkiVQbENBQUi7g8WqE5qVwhsQEKDXoKJAnOaqRk5026r0M
         6oyFDRIKaqfaBYUw5znjcIqLKg5YqJ7kQG15fkIxk29lHxmPMgWriZOU1HpjRvc1xP
         K1Ieza6rVH1Q9zHLYYzJeQ+pcW5U1cpYDq6KtrH45561axeaGeA7l6d1Jn4P4flXoh
         g8PvuHzoF6Agw4qkKi1ijOvsDhq57VDhV6atWntw/7r6SU2zWDcX28ARQWofVWdB0p
         3LahSss88sxsVsd2diXJijydgrAi6UZFgzu3pzXw30uPOKtqzRlIDjUgoyTUlH3HSA
         w78SZsz40txaA==
Date:   Mon, 29 May 2023 18:23:19 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, beaub@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V3] tracing/user_events: Prevent same name but different
 args event
Message-Id: <20230529182319.5b3dff8afcf50922eb46099f@kernel.org>
In-Reply-To: <20230529032100.286534-1-sunliming@kylinos.cn>
References: <20230529032100.286534-1-sunliming@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 29 May 2023 11:21:00 +0800
sunliming <sunliming@kylinos.cn> wrote:

> User processes register name_args for events. If the same name but different
> args event are registered. The trace outputs of second event are printed
> as the first event. This is incorrect.
> 
> Return EADDRINUSE back to the user process if the same name but different args
> event has being registered.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  kernel/trace/trace_events_user.c              | 36 +++++++++++++++----
>  .../selftests/user_events/ftrace_test.c       |  6 ++++
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index b1ecd7677642..e90161294698 100644
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
> @@ -1760,13 +1762,35 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  	mutex_unlock(&event_mutex);
>  
>  	if (user) {
> -		*newuser = user;
> -		/*
> -		 * Name is allocated by caller, free it since it already exists.
> -		 * Caller only worries about failure cases for freeing.
> -		 */
> -		kfree(name);
> +		if (args) {
> +			argv = argv_split(GFP_KERNEL, args, &argc);
> +			if (!argv) {
> +				ret = -ENOMEM;
> +				goto error;
> +			}
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
> +		} else {
> +			ret = -EADDRINUSE;
> +			goto error;
> +		}
> +
>  		return 0;
> +error:
> +		refcount_dec(&user->refcnt);
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
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A9728639
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjFHRVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 13:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbjFHRVu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 13:21:50 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D7A72D61;
        Thu,  8 Jun 2023 10:21:47 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id D83DE20B92C2;
        Thu,  8 Jun 2023 10:21:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D83DE20B92C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686244907;
        bh=VBaFkE6GX3eC/7r1EJyEukf/dkEnREgtJAdwAFf6fgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRUnpGMPyM/oASGKLPfI+Y43/nnlBH8E54/JaJa+Tmz8oum5swWUqwgpBjJEQUTi+
         NHl0IvSGeGD5SSdRshDGqeVHJR2XdclvYsARIhq6LO23qcB0BbdXucXbgf/ozYtzg6
         bGshuHgl/6TvS9jcXwAvIFAULQTCQZcux+67tvzk=
Date:   Thu, 8 Jun 2023 10:21:43 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com
Subject: Re: [PATCH 3/3] selftests/user_events: Add test cases when event is
 disabled
Message-ID: <20230608172143.GB74@W11-BEAU-MD.localdomain>
References: <20230608011554.1181097-1-sunliming@kylinos.cn>
 <20230608011554.1181097-4-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608011554.1181097-4-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 08, 2023 at 09:15:54AM +0800, sunliming wrote:
> When user_events are disabled, it's write operation should be fail. Add
> this test cases.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  tools/testing/selftests/user_events/ftrace_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index d33bd31425db..d3240a97f23d 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -297,6 +297,9 @@ TEST_F(user, write_events) {
>  	io[0].iov_base = &reg.write_index;
>  	io[0].iov_len = sizeof(reg.write_index);
>  
> +	/* Write should fail when event is not enabled */
> +	ASSERT_EQ(-1, writev(self->data_fd, (const struct iovec *)io, 3));
> +

We should also check errno value in this case. See my reply in the other
patch about -EFAULT vs -ENOENT in this case.

Thanks,
-Beau

>  	/* Enable event */
>  	self->enable_fd = open(enable_file, O_RDWR);
>  	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
> -- 
> 2.25.1

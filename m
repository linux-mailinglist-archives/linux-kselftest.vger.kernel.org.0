Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACE57CCE35
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjJQUhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUhK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 16:37:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29F92;
        Tue, 17 Oct 2023 13:37:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74902C433C7;
        Tue, 17 Oct 2023 20:37:07 +0000 (UTC)
Date:   Tue, 17 Oct 2023 16:38:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     shuah@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231017163844.55d828bf@gandalf.local.home>
In-Reply-To: <20231005215712.17942-1-beaub@linux.microsoft.com>
References: <20231005215712.17942-1-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  5 Oct 2023 21:57:12 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> The abi_test currently uses a long sized test value for enablement
> checks. On LE this works fine, however, on BE this results in inaccurate
> assert checks due to a bit being used and assuming it's value is the
> same on both LE and BE.
> 
> Use int type for 32-bit values and long type for 64-bit values to ensure
> appropriate behavior on both LE and BE.
> 
> Fixes: 60b1af8de8c1 ("tracing/user_events: Add ABI self-test")
> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
> ---
> V3 Changes:
> Fix missing cast in clone_check().
> 
> V2 Changes:
> Rebase to linux-kselftest/fixes.

Shuah,

Can you take this patch?

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
>  tools/testing/selftests/user_events/abi_test.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
> index 8202f1327c39..f5575ef2007c 100644
> --- a/tools/testing/selftests/user_events/abi_test.c
> +++ b/tools/testing/selftests/user_events/abi_test.c
> @@ -47,7 +47,7 @@ static int change_event(bool enable)
>  	return ret;
>  }
>  
> -static int reg_enable(long *enable, int size, int bit)
> +static int reg_enable(void *enable, int size, int bit)
>  {
>  	struct user_reg reg = {0};
>  	int fd = open(data_file, O_RDWR);
> @@ -69,7 +69,7 @@ static int reg_enable(long *enable, int size, int bit)
>  	return ret;
>  }
>  
> -static int reg_disable(long *enable, int bit)
> +static int reg_disable(void *enable, int bit)
>  {
>  	struct user_unreg reg = {0};
>  	int fd = open(data_file, O_RDWR);
> @@ -90,7 +90,8 @@ static int reg_disable(long *enable, int bit)
>  }
>  
>  FIXTURE(user) {
> -	long check;
> +	int check;
> +	long check_long;
>  	bool umount;
>  };
>  
> @@ -99,6 +100,7 @@ FIXTURE_SETUP(user) {
>  
>  	change_event(false);
>  	self->check = 0;
> +	self->check_long = 0;
>  }
>  
>  FIXTURE_TEARDOWN(user) {
> @@ -136,9 +138,9 @@ TEST_F(user, bit_sizes) {
>  
>  #if BITS_PER_LONG == 8
>  	/* Allow 0-64 bits for 64-bit */
> -	ASSERT_EQ(0, reg_enable(&self->check, sizeof(long), 63));
> -	ASSERT_NE(0, reg_enable(&self->check, sizeof(long), 64));
> -	ASSERT_EQ(0, reg_disable(&self->check, 63));
> +	ASSERT_EQ(0, reg_enable(&self->check_long, sizeof(long), 63));
> +	ASSERT_NE(0, reg_enable(&self->check_long, sizeof(long), 64));
> +	ASSERT_EQ(0, reg_disable(&self->check_long, 63));
>  #endif
>  
>  	/* Disallowed sizes (everything beside 4 and 8) */
> @@ -200,7 +202,7 @@ static int clone_check(void *check)
>  	for (i = 0; i < 10; ++i) {
>  		usleep(100000);
>  
> -		if (*(long *)check)
> +		if (*(int *)check)
>  			return 0;
>  	}
>  
> 
> base-commit: 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c


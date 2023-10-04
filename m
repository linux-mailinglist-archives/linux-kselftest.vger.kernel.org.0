Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD457B7604
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 02:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbjJDA6I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbjJDA6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 20:58:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA87BBF;
        Tue,  3 Oct 2023 17:58:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3BBC433C7;
        Wed,  4 Oct 2023 00:58:02 +0000 (UTC)
Date:   Tue, 3 Oct 2023 20:59:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, cleger@rivosinc.com,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231003205908.391d17f5@gandalf.local.home>
In-Reply-To: <20230925230829.341-3-beaub@linux.microsoft.com>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
        <20230925230829.341-3-beaub@linux.microsoft.com>
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


Note, this doesn't seem to apply to my tree so I only added the first
patch. I think this needs to go through Shuah's tree.

-- Steve


On Mon, 25 Sep 2023 23:08:29 +0000
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
>  tools/testing/selftests/user_events/abi_test.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
> index 5125c42efe65..67af4c491c0c 100644
> --- a/tools/testing/selftests/user_events/abi_test.c
> +++ b/tools/testing/selftests/user_events/abi_test.c
> @@ -46,7 +46,7 @@ static int change_event(bool enable)
>  	return ret;
>  }
>  
> -static int reg_enable(long *enable, int size, int bit)
> +static int reg_enable(void *enable, int size, int bit)
>  {
>  	struct user_reg reg = {0};
>  	int fd = open(data_file, O_RDWR);
> @@ -68,7 +68,7 @@ static int reg_enable(long *enable, int size, int bit)
>  	return ret;
>  }
>  
> -static int reg_disable(long *enable, int bit)
> +static int reg_disable(void *enable, int bit)
>  {
>  	struct user_unreg reg = {0};
>  	int fd = open(data_file, O_RDWR);
> @@ -89,12 +89,14 @@ static int reg_disable(long *enable, int bit)
>  }
>  
>  FIXTURE(user) {
> -	long check;
> +	int check;
> +	long check_long;
>  };
>  
>  FIXTURE_SETUP(user) {
>  	change_event(false);
>  	self->check = 0;
> +	self->check_long = 0;
>  }
>  
>  FIXTURE_TEARDOWN(user) {
> @@ -131,9 +133,9 @@ TEST_F(user, bit_sizes) {
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
> @@ -195,7 +197,7 @@ static int clone_check(void *check)
>  	for (i = 0; i < 10; ++i) {
>  		usleep(100000);
>  
> -		if (*(long *)check)
> +		if (*(int *)check)
>  			return 0;
>  	}
>  


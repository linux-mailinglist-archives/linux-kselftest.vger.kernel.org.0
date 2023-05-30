Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BE7159BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjE3JSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 05:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjE3JSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 05:18:49 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02BE8;
        Tue, 30 May 2023 02:18:48 -0700 (PDT)
Date:   Tue, 30 May 2023 11:18:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685438326; bh=iu1Nw16K2WBuaMwQflIMrw8Zb5Pee49UbSoz4UZPF9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hpXqt7eFXwb3MXONv8u6XidxCco8p42t2rHmv29axh8znnaLlOdTPSTLoLHy5BeN4
         kGy8DTGTGUdHn1fGcejk4VsysinyFB/DyLhRBYh45HL81i9dUGY3cZG39wuqGZ7MXJ
         OZ0Uqb2Jl5LMvq0C3fgIL5VorPVBbYLGm628g6Ro=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] selftests/nolibc: add sizeof test for the new 64bit
 data types
Message-ID: <c68a6f60-0906-408a-9454-419085df695e@t-8ch.de>
References: <cover.1685428087.git.falcon@tinylab.org>
 <d1f4073e1dd9a51be93ea9e14ebd746b312646a4.1685428087.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f4073e1dd9a51be93ea9e14ebd746b312646a4.1685428087.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-30 14:42:56+0800, Zhangjin Wu wrote:
> These test cases are required to make sure the new added data types are
> really 64bit based.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 20d184da9a2b..43ce4d34b596 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -721,6 +721,14 @@ int run_stdlib(int min, int max)
>  #else
>  # warning "__SIZEOF_LONG__ is undefined"
>  #endif /* __SIZEOF_LONG__ */
> +		CASE_TEST(sizeof_time_t);           EXPECT_EQ(1, 8,                sizeof(time_t)); break;
> +		CASE_TEST(sizeof_timespec);         EXPECT_EQ(1, 16,               sizeof(struct timespec)); break;
> +#ifdef NOLIBC
> +		CASE_TEST(sizeof_itimerspec);       EXPECT_EQ(1, 32,               sizeof(struct itimerspec)); break;
> +#endif
> +		CASE_TEST(sizeof_timeval);          EXPECT_EQ(1, 16,               sizeof(struct timeval)); break;
> +		CASE_TEST(sizeof_itimerval);        EXPECT_EQ(1, 32,               sizeof(struct itimerval)); break;
> +		CASE_TEST(sizeof_off_t);            EXPECT_EQ(1, 8,                sizeof(off_t)); break;

These will break on 32bit glibc configurations.
(At least on x86)

>  		case __LINE__:
>  			return ret; /* must be last */
>  		/* note: do not set any defaults so as to permit holes above */
> -- 
> 2.25.1
> 

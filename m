Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E201E70FF1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 22:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjEXUW2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 16:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjEXUW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 16:22:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE86113;
        Wed, 24 May 2023 13:22:26 -0700 (PDT)
Date:   Wed, 24 May 2023 22:22:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684959744; bh=EZ62Sf3mRrrPLSec0HPbs+OLV5rrKu4uVLhKELY8M5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjChkd239g3RKukdNJOfd4jriqUOjWg6EsxNpjJouusbCRUq1ohoACpbDzB4CYPJE
         /b2S1nQ5oF+NE0YA7lESkIYRuHZYf0jazv61JOm7P1ro1uzDo7b+fcjAL3aPLEzrwg
         1CTfm7DDfvwSbUeJ9IPSeVj1Hns6GkOTyJ5Csi8M=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 11/13] tools/nolibc: sys_select: riscv: use
 __NR_pselect6_time64 for rv32
Message-ID: <83339ea6-6653-41fe-af75-e0d51a4fa920@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <9359ab11b52ef7c1799337f475e1e27c0cb00e3b.1684949268.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9359ab11b52ef7c1799337f475e1e27c0cb00e3b.1684949268.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 01:59:55+0800, Zhangjin Wu wrote:
> rv32 uses the generic include/uapi/asm-generic/unistd.h and it has no
> __NR_pselect6 after kernel commit d4c08b9776b3 ("riscv: Use latest
> system call ABI"), use __NR_pselect6_time64 instead.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index c0335a84f880..00c7197dcd50 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -1041,8 +1041,13 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
>  		struct timeval *t;
>  	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
>  	return my_syscall1(__NR_select, &arg);
> -#elif defined(__ARCH_WANT_SYS_PSELECT6) && defined(__NR_pselect6)
> +#elif defined(__ARCH_WANT_SYS_PSELECT6) && (defined(__NR_pselect6) || defined(__NR_pselect6_time64))
> +#ifdef __NR_pselect6
>  	struct timespec t;
> +#else
> +	struct timespec64 t;
> +#define __NR_pselect6 __NR_pselect6_time64

Wouldn't this #define leak to the users of nolibc and lead to calls to
pselect6_time64 with the ABI of the __NR_pselect6 if userspace is doing
its own raw syscalls?

> +#endif
>  
>  	if (timeout) {
>  		t.tv_sec  = timeout->tv_sec;
> -- 
> 2.25.1
> 

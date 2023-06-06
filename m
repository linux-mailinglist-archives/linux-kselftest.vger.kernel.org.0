Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978A724B83
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjFFShC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbjFFShC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 14:37:02 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE88D11B;
        Tue,  6 Jun 2023 11:36:57 -0700 (PDT)
Date:   Tue, 6 Jun 2023 20:36:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1686076615; bh=OjRLqwrxR3FBsWW4XS2Cc09XFAFldwpVvvt9U+Wh0WI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jUN+GWhoyrtMbFAKRDwmRGykG90E96Ekg0Tfu8T7zUUwutFn9MeQJuZ2SLG3d6UDe
         +LU5lzDLMfsmeBrCSWiGWbK7znlbqv0VHMFVPcppLKCCZ7dUOSXSU4kyKVpwZro48S
         5oCiYmxg1TZDtAe01th4fdo17Nc0/TM9939V4HoQ=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>, w@1wt.eu
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/4] tools/nolibc: sys.h: apply __syscall() helper
Message-ID: <7e76f099-4198-421c-8157-430201970c4c@t-8ch.de>
References: <cover.1686036862.git.falcon@tinylab.org>
 <ee86e33d9f0031da5932b0de798f188535308dd7.1686036862.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee86e33d9f0031da5932b0de798f188535308dd7.1686036862.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On 2023-06-06 16:17:38+0800, Zhangjin Wu wrote:
> Use __syscall() helper to shrink 252 lines of code.
> 
>     $ git show HEAD^:tools/include/nolibc/sys.h | wc -l
>     1425
>     $ git show HEAD:tools/include/nolibc/sys.h | wc -l
>     1173
>     $ echo "1425-1173" | bc -l
>     252
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/sys.h | 336 +++++--------------------------------
>  1 file changed, 42 insertions(+), 294 deletions(-)
> 
> diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> index f6e3168b3e50..0cfc5157845a 100644
> --- a/tools/include/nolibc/sys.h
> +++ b/tools/include/nolibc/sys.h
> @@ -108,13 +108,7 @@ int sys_chdir(const char *path)
>  static __attribute__((unused))
>  int chdir(const char *path)
>  {
> -	int ret = sys_chdir(path);
> -
> -	if (ret < 0) {
> -		SET_ERRNO(-ret);
> -		ret = -1;
> -	}
> -	return ret;
> +	return __syscall(chdir, path);

To be honest I'm still not a big fan of the __syscall macro.
It's a bit too magic for too little gain.

The commit message argues that the patches make the code shorter.

However doing 

__sysret(sys_chdir(path));

instead of

__syscall(chdir, path);

is only three characters longer and the same amout of lines.

Otherwise we would have syscall() _syscall() and __syscall() each doing
different things.

And __syscall does not behave like a regular function.

The rest of the patchset looks great.

Maybe Willy can break the tie?


Thomas


Note: If we figure out a way to build syscall() without macros I would
like that also :-)

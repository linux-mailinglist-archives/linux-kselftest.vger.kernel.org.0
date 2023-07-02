Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFE744FF8
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGBSvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGBSvS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 14:51:18 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAFABC6;
        Sun,  2 Jul 2023 11:51:12 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362Ioxts017366;
        Sun, 2 Jul 2023 20:50:59 +0200
Date:   Sun, 2 Jul 2023 20:50:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 07/14] tools/nolibc: arch-loongarch.h: shrink with
 SYSCALL_CLOBBERLIST
Message-ID: <20230702185059.GG16233@1wt.eu>
References: <cover.1687957589.git.falcon@tinylab.org>
 <a906a8e5bb39d88fee89be8f2bca8bf62307d468.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a906a8e5bb39d88fee89be8f2bca8bf62307d468.1687957589.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 09:22:21PM +0800, Zhangjin Wu wrote:
> my_syscall<N> share a same long clobber list, define a macro for them.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/include/nolibc/arch-loongarch.h | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
> index 292d6a58dc87..fbb4844f7993 100644
> --- a/tools/include/nolibc/arch-loongarch.h
> +++ b/tools/include/nolibc/arch-loongarch.h
> @@ -23,6 +23,10 @@
>   */
>  #define __ARCH_WANT_SYS_PSELECT6
>  
> +#define SYSCALL_CLOBBERLIST			\
> +	"memory", "$t0", "$t1", "$t2", "$t3",	\
> +	"$t4", "$t5", "$t6", "$t7", "$t8"
> +

That's a good idea, but please be careful when adding macro definitions,
we're in code that is used by user space we have no control on, and we're
polluting the end user's macro namespace with plenty of names. While one
could argue that it's unlikely that some program already defines and uses
SYSCALL_CLOBBERLIST, actually with low-level code it's fairly possible.

Till now most of the definitions were for stuff that user-space really
needs (e.g. STDIN_FILENO, various integer limits). If we start to declare
random macros for internal use, at least we should probably prefix them
with _NOLIBC_ or something like this to avoid the risk of collision.

Willy

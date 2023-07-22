Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1475DC60
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGVMIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGVMH5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:07:57 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 095E79B;
        Sat, 22 Jul 2023 05:07:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MC7lkl017328;
        Sat, 22 Jul 2023 14:07:47 +0200
Date:   Sat, 22 Jul 2023 14:07:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 7/8] selftests/nolibc: add test support for powerpc64le
Message-ID: <20230722120747.GC17311@1wt.eu>
References: <cover.1689713175.git.falcon@tinylab.org>
 <dbf7d642e2bce46e0023827cdd0e4438f8bf90e0.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf7d642e2bce46e0023827cdd0e4438f8bf90e0.1689713175.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 05:17:26AM +0800, Zhangjin Wu wrote:
> Here adds test support for little endian 64-bit PowerPC.
> 
> The powernv machine of qemu-system-ppc64le is used for there is just a
> working powernv_defconfig.
> 
> As the document [1] shows:
> 
>   PowerNV (as Non-Virtualized) is the "bare metal" platform using the
>   OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
>   used as an hypervisor OS, running KVM guests, or simply as a host OS.
> 
> [1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 9c375fab84e5..fbdf7fd9bf96 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -19,6 +19,7 @@ endif
>  XARCH           ?= $(or $(XARCH_$(ARCH)),$(ARCH))
>  
>  # ARCH is supported by kernel
> +ARCH_powerpc64le = powerpc

Given that this one will only be used as an alias, I really think you
should call it "ppc64le" and not with that long a name. Everyone knows
that arch under the name ppc64 anyway so it's not like it would cause
any confusion.

Willy

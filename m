Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE175DCB7
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjGVNIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjGVNIJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 09:08:09 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E03B5122;
        Sat, 22 Jul 2023 06:08:07 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MD7xME017467;
        Sat, 22 Jul 2023 15:07:59 +0200
Date:   Sat, 22 Jul 2023 15:07:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 12/14] selftests/nolibc: add tinyconfig target
Message-ID: <20230722130759.GL17311@1wt.eu>
References: <cover.1689759351.git.falcon@tinylab.org>
 <6c58b9bec8fdf593d5dd1d5ba55aabddb0ce02d1.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c58b9bec8fdf593d5dd1d5ba55aabddb0ce02d1.1689759351.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 09:30:30PM +0800, Zhangjin Wu wrote:
> The original tinyconfig target only enables minimal kernel config
> options, it can speed up the kernel build and nolibc test a lot and also
> brings us with smaller kernel image size.
> 
> But the default enabled options are not enough for qemu boot and console
> print, some additional config options should be added for every
> architecture individually.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index eec2935672ad..f42782fa78a9 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -218,6 +218,9 @@ mrproper:
>  defconfig:
>  	$(Q)$(MAKE_KERNEL) $(DEFCONFIG) prepare
>  
> +tinyconfig:
> +	$(Q)$(MAKE_KERNEL) tinyconfig prepare

So for the same reasons as defconfig above, I'd actually keep mrproper
here. And if we figure that tinyconfig is never called by the user
directly but as a dependency from the makefile itself or scripts,
then we likely don't even need to create a visible entry for it.

Willy

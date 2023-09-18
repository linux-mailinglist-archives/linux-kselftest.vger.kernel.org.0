Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE197A4EDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 18:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjIRQ2j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 12:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjIRQ2Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 12:28:24 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 229589EF3;
        Mon, 18 Sep 2023 09:21:26 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 38IGKojo028584;
        Mon, 18 Sep 2023 18:20:50 +0200
Date:   Mon, 18 Sep 2023 18:20:50 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Shuah Khan <shuah@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2] selftests/nolibc: don't embed initramfs into
 kernel image
Message-ID: <ZQh44i/Kev91looW@1wt.eu>
References: <20230917-nolibc-initramfs-v2-1-f0f293a8b198@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917-nolibc-initramfs-v2-1-f0f293a8b198@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Sun, Sep 17, 2023 at 05:21:38PM +0200, Thomas Weiﬂschuh wrote:
> When the initramfs is embedded into the kernel each rebuild of it will
> trigger a full kernel relink and all the expensive postprocessing steps.
> 
> Currently nolibc-test and therefore the initramfs are always rebuild,
> even without source changes, leading to lots of slow kernel relinks.
> 
> Instead of linking the initramfs into the kernel assemble it manually
> and pass it explicitly to qemu.
> This avoids all of the kernel relinks.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

OK, let's try it!

thanks,
Willy

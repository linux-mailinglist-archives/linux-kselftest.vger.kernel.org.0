Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651D1758CA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 06:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGSEeR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 00:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSEeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 00:34:17 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 072AE1B1;
        Tue, 18 Jul 2023 21:34:14 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36J4XrQ3005538;
        Wed, 19 Jul 2023 06:33:53 +0200
Date:   Wed, 19 Jul 2023 06:33:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/8] selftests/nolibc: select_null: fix up for big
 endian powerpc64
Message-ID: <20230719043353.GC5331@1wt.eu>
References: <be205fbd-31c2-4066-bfb1-65b9d0cb57c2@t-8ch.de>
 <20230718235637.347701-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718235637.347701-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Wed, Jul 19, 2023 at 07:56:37AM +0800, Zhangjin Wu wrote:
> It made me recalled I have at last disabled (not enabled for tinyconfig) the following options:
> 
>     CONFIG_ALTIVEC
>     CONFIG_VSX --> This option enables kernel support for the Vector Scaler extensions
> 
> Or we can disable the vsx instructions explicitly:
> 
>     -mno-vsx
> 
> Both of them work well, but I prefer -mno-vsx for to get a faster build, what about you?
> 
>     +CFLAGS_powerpc64 = -m64 -mbig-endian -Wl,-EB,-melf64ppc -mno-vsx
>     +CFLAGS_powerpc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
> 
> So, this patch itself is wrong, let's drop it from the next revision.

Better explicitly disable it in the CFLAGS (2nd option) if we want to
make sure we don't want to rely on this, at least for portability
purposes.

Willy

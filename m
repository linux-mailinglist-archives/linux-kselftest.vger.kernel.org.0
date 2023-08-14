Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8928B77B230
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjHNHQw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 03:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjHNHQl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 03:16:41 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45B3FE71;
        Mon, 14 Aug 2023 00:16:34 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37E7GLEA016686;
        Mon, 14 Aug 2023 09:16:21 +0200
Date:   Mon, 14 Aug 2023 09:16:21 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 5/7] selftests/nolibc: customize CROSS_COMPILE for all
 architectures
Message-ID: <20230814071621.GB14322@1wt.eu>
References: <20230813091625.GG8237@1wt.eu>
 <20230813101805.10885-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813101805.10885-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 06:18:05PM +0800, Zhangjin Wu wrote:
> > Given that we don't support mips64, I'd suggest to ust mips-linux-
> > instead here for now. That doesn't seem right to ask users to
> > download a toolchain for a different architecture than the one
> > supported just because we can adapt to it.
> >
> 
> Agree very much, and the one below from patch 7/7 [1]:
> 
>     +CROSS_COMPILE_arm64     ?= aarch64-linux- aarch64-linux-gnu-
>     +CROSS_COMPILE_arm       ?= arm-linux-gnueabi- arm-none-eabi-
>     +CROSS_COMPILE_mips      ?= mips64-linux- mips64el-linux-gnuabi64-
> 
> It should be:
> 
>     +CROSS_COMPILE_mips      ?= mips-linux- mips-linux-gnu-gcc
> 
> And if necessary, the mips64-linux- line in the commit message of [1] should be
> corrected too.

I just did that (and fixed mips-linux-gnu- instead of mips-linux-gnu-gcc
above).

Thanks,
Willy

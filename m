Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52358712087
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 08:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEZG5L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 02:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjEZG5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 02:57:10 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE46E95;
        Thu, 25 May 2023 23:57:09 -0700 (PDT)
Date:   Fri, 26 May 2023 08:57:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685084228; bh=svHIYYsnUTreXuvX8V5j3gYUDNQ2Qs7ua4MdAIMR+mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUxyoogygvgs87cTjQvR6A7rvVBHtM0GxBqXbkuy2fa+dKd8zPRrhAGUbyeMzZGe/
         So2e2OkGQJexcrinFdfjO4ngF0eba/peYRfnksaujydQhYl3ON+JYjfKe0wiLOwxqG
         iUneCQgPT/JO7dRY+dhnAuPl2uZtI7JKgr6j1E7E=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 05/13] selftests/nolibc: riscv: customize makefile for
 rv32
Message-ID: <4a3b1cdf-91d5-4668-925e-21f8f5c64a92@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <7adb27a7c56dd06d782710a5f684ea6263900f98.1684949268.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7adb27a7c56dd06d782710a5f684ea6263900f98.1684949268.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-25 01:50:57+0800, Zhangjin Wu wrote:
> both riscv64 and riscv32 have the same ARCH value, it is riscv, the
> default defconfig enables 64bit, to support riscv32, let's allow pass
> "ARCH=riscv32" or "ARCH=riscv CONFIG_32BIT=1" to customize riscv32
> setting.

What's the advantage of doing CONFIG_32BIT? For i386/x86_64, arm/arm64
it's not necessary either.
(Let's ignore the "x86" case)

If for riscv the "normal" version is riscv64 then adding a new "riscv32" that
works the same as the other architectures seems nicer and easier.

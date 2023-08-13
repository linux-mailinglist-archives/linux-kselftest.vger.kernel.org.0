Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1825777A5CF
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 11:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjHMJhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 05:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 05:37:38 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 890BA10FD;
        Sun, 13 Aug 2023 02:37:40 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D9bYSP008867;
        Sun, 13 Aug 2023 11:37:34 +0200
Date:   Sun, 13 Aug 2023 11:37:34 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 0/7] selftests/nolibc: customize CROSS_COMPILE for all
 supported architectures
Message-ID: <20230813093734.GJ8237@1wt.eu>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sat, Aug 12, 2023 at 04:27:01AM +0800, Zhangjin Wu wrote:
> Hi, Willy
> 
> Here is v2 of the customized CROSS_COMPILE support, this helps a lot
> during the testing of the other cross-arch nolibc changes:
> 
>     $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390"
>     $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status; done
> 
> Based on your suggestion, we did this changes:
> 
> - The qemu notes patch [1] is removed, welcome your doc file ;-)
> - Arnd's crosstools are customized by default
> - Import cc-cross-prefix to support local cross toolchains too
> - Use mips64 toolchains for mips like x86_64 toolchains for i386, allow
>   download less toolchains
> - Use HOSTCC for libc-test compiling
(...)

I think it's basically OK (just this mips64 thing). I've picked patch 3
already since it's a fix. Once we agree on what to do there, I can queue
it if that helps (I can modify mips64- to mips- in the patch if that's
OK for you, no need to resend for this, just let me know).

I think that later I'll further extend XARCH with new variants to
support ARMv5 and Thumb2, because we have different code for this
and I continue to manually change the CFLAGS to test both.

Thanks,
Willy

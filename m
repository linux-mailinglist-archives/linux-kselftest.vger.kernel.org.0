Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94397138C5
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1Imp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 04:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjE1Imn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 04:42:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E9C7;
        Sun, 28 May 2023 01:42:41 -0700 (PDT)
Date:   Sun, 28 May 2023 10:42:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685263359; bh=EGbU+HDeb2zPClqYYHwVtF+Aw91kwDU3hoGetLVCJZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFHry4Zgb4fzUMCkqYKBkHBNM0AdSkyUS1A4NvdIfB+O0V0fmjzw94o3MDLD5WA7+
         /dsarczgGGsix8TBAo/ufggHA67Pw+w4LwjPEld0NYsRW1L2+s6bbW+WV2VmMVuEtT
         d4dy2G3mhFSjldk3XD8T5Un/a8aMP1HS+ZEtBNBw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Message-ID: <210e5ed9-be89-4e48-9c1e-3eb5b0dd288a@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <20230528075955.GE1956@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528075955.GE1956@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-28 09:59:55+0200, Willy Tarreau wrote:
> On Thu, May 25, 2023 at 01:33:14AM +0800, Zhangjin Wu wrote:
> > Thanks very mush for your kindly review, discuss and suggestion, now we
> > get full rv32 support ;-)
> > 
> > In the first series [1], we have fixed up the compile errors about
> > _start and __NR_llseek for rv32, but left compile errors about tons of
> > time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
> > latest system call ABI")) and the missing fstat in nolibc-test.c [2],
> > now we have fixed up all of them.
> 
> (...)
> 
> I have read the comments that others made on the series and overall
> agree. I've seen that you intend to prepare a v2. I think we must
> first decide how to better deal with emulated syscalls as I said in
> an earlier message. Probably that we should just add a specific test
> case for EFAULT in nolibc-test since it's the only one (I think) that
> risks to trigger crashes with emulated syscalls. We could also imagine
> dealing with the signal ourselves but I'm not that keen on going to
> implement signal() & longjmp() for now :-/
> 
> Regardless, in order to clean the things up and relieve you from the
> non-rv32 stuff, I've just reverted the two patches that your series
> reverts (1 & 2), and added the EOVERFLOW one (3). I'm pushing this to
> branch 20230528-nolibc-rv32+stkp5.

If you are fine with pushing more stuff to this branch, picking up 
the fix for the duplicated test gettimeofday_bad2 (7) would be nice, too.

Thomas

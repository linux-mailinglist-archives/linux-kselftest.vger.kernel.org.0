Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82F17138E3
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 May 2023 11:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjE1Jl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 May 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1Jl4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 May 2023 05:41:56 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EEAB9;
        Sun, 28 May 2023 02:41:55 -0700 (PDT)
Date:   Sun, 28 May 2023 11:41:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1685266914; bh=KfYW6zrk9bUzHSL1GVXFbu1Ry7vy9dldYOJGxwZi/mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmOHwghuAOKY2uzDsSrgfGLV0frdG3brN0uOXw4bVJU9EFD/8Ql6I+AvKmjLWnP2H
         eYWckRvBRB6El8lYyEOAAY8t3DS4f9hRsLY1T2PZ0SFC5RnpbRnlP7pY4cVrIJIfKi
         ANo3fbMa1tzuy9YRRx5zujJadbLd8YONmH/80As0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH 00/13] tools/nolibc: riscv: Add full rv32 support
Message-ID: <30bf1742-64ff-4f92-beab-332108d0201f@t-8ch.de>
References: <cover.1684949267.git.falcon@tinylab.org>
 <20230528075955.GE1956@1wt.eu>
 <210e5ed9-be89-4e48-9c1e-3eb5b0dd288a@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <210e5ed9-be89-4e48-9c1e-3eb5b0dd288a@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-28 10:42:39+0200, Thomas Weißschuh wrote:
> On 2023-05-28 09:59:55+0200, Willy Tarreau wrote:
> > On Thu, May 25, 2023 at 01:33:14AM +0800, Zhangjin Wu wrote:
> > > Thanks very mush for your kindly review, discuss and suggestion, now we
> > > get full rv32 support ;-)
> > > 
> > > In the first series [1], we have fixed up the compile errors about
> > > _start and __NR_llseek for rv32, but left compile errors about tons of
> > > time32 syscalls (removed after kernel commit d4c08b9776b3 ("riscv: Use
> > > latest system call ABI")) and the missing fstat in nolibc-test.c [2],
> > > now we have fixed up all of them.
> > 
> > (...)
> > 
> > I have read the comments that others made on the series and overall
> > agree. I've seen that you intend to prepare a v2. I think we must
> > first decide how to better deal with emulated syscalls as I said in
> > an earlier message. Probably that we should just add a specific test
> > case for EFAULT in nolibc-test since it's the only one (I think) that
> > risks to trigger crashes with emulated syscalls. We could also imagine
> > dealing with the signal ourselves but I'm not that keen on going to
> > implement signal() & longjmp() for now :-/
> > 
> > Regardless, in order to clean the things up and relieve you from the
> > non-rv32 stuff, I've just reverted the two patches that your series
> > reverts (1 & 2), and added the EOVERFLOW one (3). I'm pushing this to
> > branch 20230528-nolibc-rv32+stkp5.
> 
> If you are fine with pushing more stuff to this branch, picking up 
> the fix for the duplicated test gettimeofday_bad2 (7) would be nice, too.

And the ppoll() argument cleanup (10) for that matter.

Zhangjin:

IMO it would be more convenient to move generic cleanup patches to the
beginning of the series.
When the reviewers are focussing on the real changes they won't be
interrupted by the cleanups. Also the maintainer can more easily pick
them up independently, so they are dealt with and nobody has to worry
about them anymore.

Thomas

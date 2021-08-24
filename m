Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6420F3F5D2C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHXLhJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Aug 2021 07:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236205AbhHXLhI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Aug 2021 07:37:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FA5E61002;
        Tue, 24 Aug 2021 11:36:22 +0000 (UTC)
Date:   Tue, 24 Aug 2021 13:36:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, shuah@kernel.org,
        Christian Brauner <christian@brauner.io>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: openat2: Fix testing failure for O_LARGEFILE
 flag
Message-ID: <20210824113619.a3gyxlerst7tumzn@wittgenstein>
References: <1627475340-128057-1-git-send-email-baolin.wang@linux.alibaba.com>
 <01184d9e-477d-cbe4-c936-62b92e915911@linux.alibaba.com>
 <9411d418-567b-78f0-0e4d-30f08371c55a@linux.alibaba.com>
 <a9dc1616-61b9-c010-950c-521693c74247@linuxfoundation.org>
 <20210824112129.2t6lzqyf2dxllw4a@senku>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210824112129.2t6lzqyf2dxllw4a@senku>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 24, 2021 at 09:21:29PM +1000, Aleksa Sarai wrote:
> On 2021-08-23, Shuah Khan <skhan@linuxfoundation.org> wrote:
> > Hi Baolin,
> > 
> > On 8/22/21 8:40 PM, Baolin Wang wrote:
> > > Hi Shuah,
> > > 
> > > On 2021/7/28 20:32, Baolin Wang wrote:
> > > > Hi,
> > > > 
> > > > > When running the openat2 test suite on ARM64 platform, we got below failure,
> > > > > since the definition of the O_LARGEFILE is different on ARM64. So we can
> > > > > set the correct O_LARGEFILE definition on ARM64 to fix this issue.
> > > > 
> > > > Sorry, I forgot to copy the failure log:
> > > > 
> > 
> > Please cc everybody get_maintainers.pl suggests. You are missing
> > key reviewers for this change.
> > 
> > Adding Christian Brauner and Aleksa Sarai to the thread.
> > 
> > > > # openat2 unexpectedly returned # 3['/lkp/benchmarks/kernel_selftests/tools/testing/selftests/openat2'] with 208000 (!= 208000)
> > 
> > Not sure I understand this. 208000 (!= 208000) look sthe same to me.
> > 
> > > > not ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails with -22 (Invalid argument)
> > > > 
> > > > > 
> > > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > 
> > > Could you apply this patch if no objection from your side? Thanks.
> > > 
> > 
> > Ideally this define should come from an include file.
> 
> The issue is that O_LARGEFILE is set to 0 by glibc because glibc appears
> to hide the nuts and bolts of largefile support from userspace. I
> couldn't find a nice way of doing a architecture-dependent includes of
> include/uapi from kselftests, so I just went with this instead -- but I
> agree that a proper include would be better if someone can figure out
> how to do it.

I'd just add arch-dependent defines for now and call it good. So seems
good enough for me:

Thanks!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

> 
> > Christian, Aleksa,
> > 
> > Can you review this patch and let me know if this approach looks right.
> 
> Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

Return-Path: <linux-kselftest+bounces-8187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F98A71AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1C6B20C1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34961327FD;
	Tue, 16 Apr 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="OZgRk9jl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA7FC1F;
	Tue, 16 Apr 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286153; cv=none; b=lfgGVNEz71VqFFSw5Td0aZFkvvrL23YwcczD4A/O/ngCRFiVzClFeBrhhnODliP5XMLvAR1/ROVTJD5Lyb77dZhl0sN6YgxEv2O3M7xBlv5Xly3hU7XNpQKXnhSzRw2HZGdAECH7TTNYLuU4bGot/FgWRsww6v/7X2ZP33hSE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286153; c=relaxed/simple;
	bh=pU0D7p6Mrsm9UDb/aQ2TM6OzvMKuAB+Zxp5mgw2XPKU=;
	h=From:To:Subject:In-reply-to:References:MIME-Version:Content-Type:
	 Date:Message-ID; b=kcnrGc03xxOxa9wSS7IjoPopez72K6hYATCDYKUBXQKy9bIex4sWND53KrgFk4mFy5MIQznNj+c+HKQMzR1OfdEhhNpAlnUzKT+X+YrieIlTNzwoTtQylvc3whSP+wX08Sxl2ZIA6lWYTFnWSUfn6NHnoMfNAagGu0kEtYDbUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=OZgRk9jl; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=pU0D7p6Mrs
	m9UDb/aQ2TM6OzvMKuAB+Zxp5mgw2XPKU=; h=date:references:in-reply-to:
	subject:to:from; d=openbsd.org; b=OZgRk9jlk6HVVL1liuGCuPFJ2Wd/cE3AWIUi
	1dKj9S2eim+/p7/MEBIVLGnjDzmNcJk3SrhXvjCzQOoINFz8z7XieiAjr7JwyKSuds0gRv
	NLx/0obXLezhwQ2dW1pjWUTMqgg6JizhtP8r3Bs2z0l9RBpLPrDGSyIZOazHXibDrD+N9l
	9fK2g1F/yNU0kgZlVOaVwSQQ34BqYf47mc8L5V/+WvP3gcDClX9TOPTHv1YJYT2Rz5jwKq
	2gmFwm9bqhkpm5QOvXdLUqnW2kw5jlFLScyDbCrEEIg8iPV/YNBuYKastWGrKwTp1eC3Vn
	+qPMY7t2TzUNv+PW0NBHj/bTAw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id a4496a3c;
	Tue, 16 Apr 2024 10:42:30 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
    akpm@linux-foundation.org, torvalds@linux-foundation.org,
    jeffxu@chromium.org, keescook@chromium.org, jannh@google.com,
    sroettger@google.com, willy@infradead.org,
    gregkh@linuxfoundation.org, usama.anjum@collabora.com,
    corbet@lwn.net, surenb@google.com, merimus@google.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
                  akpm@linux-foundation.org,
                  torvalds@linux-foundation.org, jeffxu@chromium.org,
                  keescook@chromium.org, jannh@google.com,
                  sroettger@google.com, willy@infradead.org,
                  gregkh@linuxfoundation.org, usama.anjum@collabora.com,
                  corbet@lwn.net, surenb@google.com, merimus@google.com,
                  rdunlap@infradead.org, jeffxu@google.com,
                  jorgelo@chromium.org, groeck@chromium.org,
                  linux-kernel@vger.kernel.org,
                  linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
                  pedro.falcato@gmail.com, dave.hansen@intel.com,
                  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 2/5] mseal: add mseal syscall
In-reply-to: <v22gngid25vcufvdfbv3pdymq3s72c47pizr23tkrmbbyiqoe4@y5yxseh6thnf>
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-3-jeffxu@chromium.org> <v22gngid25vcufvdfbv3pdymq3s72c47pizr23tkrmbbyiqoe4@y5yxseh6thnf>
Comments: In-reply-to "Liam R. Howlett" <Liam.Howlett@oracle.com>
   message dated "Tue, 16 Apr 2024 10:59:34 -0400."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43378.1713285750.1@cvs.openbsd.org>
Date: Tue, 16 Apr 2024 10:42:30 -0600
Message-ID: <58783.1713285750@cvs.openbsd.org>

Liam R. Howlett <Liam.Howlett@oracle.com> wrote:

> No per-vma change is checked prior to entering a per-vma modification
> loop today. This means that mseal() differs in behaviour in "up-front
> failure" vs "partial change failure" that exists in every other
> function.

I discussed this with Liam and Jeff a while ago (seperate conversations).

A bunch of linux m*() syscalls have weaker atomicity gaurantees than
the other systems I looked into.

Linux is an outlier here. Other systems do two passes over the "entries
in the range", before commiting to success or failure.  When success is
returned, it means the whole range has been changed.  When an error is
identified in the first pass, then no changes are applied, and error is
returned.  I found no partial results in my limited reading of various
VM systems.

Actually the gaurantee of having done nothing upon error, is very common
system call behaviour.  POSIX and defacto standards don't seem to
specify by specific wording as far as I can see, but majority of systems
seem to do so because it matches expectations.

Considering all the system calls, I can't think of any examples.  There
are a few specific ioctl which were designed wrong.

I suspect, for performance reasons, there will be little appetite to
repair the m*() syscalls in Linux.  (I would appreciate if they were
brought up to standard, so I guess that starts the 20 year counter :)

> I think we can all agree that having some up-front and some later
> without any reason will lead to a higher probability of things getting
> missed.

Also as attack surface.  I spent some time thinking about circumstances
where this might help an attack.

The risk is that mprotect() return value is very rarely checked, yet
parts of objects will change. mprotect() is probably the least checked
system call, since people assume it will always succeed entirely; not
the case on Linux.  Even more so not the case once immutable memory
ranges come into play, it's an even more likely error condition now.

I didn't find a particular piece of software (or an old attack) which
would help an attack with the sloppy permission handling aspects, but I only
thought about it for a couple days... there are people with more time
on their hands.


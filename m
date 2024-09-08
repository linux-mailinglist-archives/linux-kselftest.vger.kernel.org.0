Return-Path: <linux-kselftest+bounces-17451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F3970A24
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 23:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4D9B20AE5
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F41779BA;
	Sun,  8 Sep 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhfWjNRB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54C145FE5;
	Sun,  8 Sep 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725831357; cv=none; b=rTZylki1s4c6HsV0BvSh5K16PXlerjyjSVlc0ekDKqoGD5Oqd6NH/IXto2bhGQMkZCvYbXxXv4VHQcwcLaunLsCvezchcpkVha9O5FWGY8OFNkStnXHha251Zvavy+/9tgGoK133H7uhZ05qrMi58vV6e8xZfXftia0zfUox1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725831357; c=relaxed/simple;
	bh=3dCoGsj2JfSBV/BQ2ZN8gTg6XvjszrmLZYr0nuz7h7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DITefhqRcG5lTLFy1nu4RY/DU9nDf2bVcxRjXfUiZj4Ws4EtwUc4P0E0QNVmVfOT3csRnj3Nu89kueyTehZfsIUWZEenWjERD0RABU2QDPyLVrL0kk6/xd42Hb5DkEWTpHbEiajQ7zZf5mv9/TraPqVXYPcDJ3jSS1+U8igZwXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhfWjNRB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso32921465e9.1;
        Sun, 08 Sep 2024 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725831354; x=1726436154; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ebxD+tZxKc5DCOdCTQdYFhvzT6rv4DDDxFg4BZPdZes=;
        b=RhfWjNRBhuF8cVnD/DA3+vcwI53mfCkUXkd67JGOVXmAtGWtT3956vLt7gaRto/MK0
         R1ykfTN7adqr2bbhaloULjRPioLssyGy0gYAowX+Fa05D7ZrclbcIwFpso0Bjy7o92mu
         e/fVMTKH67KJuexTTPxs3GfHJcloyF6ygCOkusENyJweZaogF3n5lzmedBPywS8jvuGy
         ncQ9qlmeEWFZ2FaeirXOQrBwml6VzWcGDPdDr1MYEEentySOTKH/W91Tf5AJ+1Ocr84Z
         j2qVnHnvCpd9W6t+vap6pCeAR9wswhgkd8im5ndEwZEp21DTXrm9EJuXGZ1qxWbxDbJ3
         kTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725831354; x=1726436154;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebxD+tZxKc5DCOdCTQdYFhvzT6rv4DDDxFg4BZPdZes=;
        b=aSe1QxFuoekSjAbfZkf3GXkVrXtsr176NbsavRQP2MD1yDRPCDEwXt6pyQ8oLHSRj7
         CXQOTpdFOsQXZ543z9mCnliHPeA6lEGmNdSEXR77Vvp30QW28UOaSTvqx60ZvAhzyPP2
         m/DvKSgR2rkk+0wj7fHnR6wCfUC1da8O2gQLfa43TWJgiKWkapoMna0YS6Fpl52M9mlI
         GHvgRxLhsR4ACUDkgotDAGXOp4gy+5hluaZVUUhimsefqD7ayh9s5wRNDtJS7vESsZ6W
         EUloEv6vX7VonIE8WF5g617doZvKUaK22UsJZNEKKe4zjoqHPGDDtLhkDLK2HyJiaBqU
         NqoA==
X-Forwarded-Encrypted: i=1; AJvYcCX3MfqxDV0DZeyd2lK23N3jH1Pu/VNQR5pqCenU/5sKzgcoXSSrYOH1vVr3Yq1T/7IgGtfQxbjF1DKsGzQi@vger.kernel.org, AJvYcCXZNUAntMlFpDs4OnbGJSaOGGt25ikN/9elzqWlvTWu0mFhOeBuzB8w7XxO1ydAPDdukl8dH3GDg+XKgCqskpY=@vger.kernel.org, AJvYcCXldu7+350jF1vOlXeAoZHYjDew6S/VIIoqJdHLTH5THL7rPGJ7mwmeFV9C0qsuNbwwQel83DUA+ecwCw3sovdp@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMm0XMtdDnz7OXHtnW5XKQ+vVZX+jhVRGlbHNUBZdQQaxaeAr
	MBCHcwGrnlRIPC6+8bZS3BNNu5YdNU8euA8bGWpyPjk8XzzG8KJs
X-Google-Smtp-Source: AGHT+IEpX/kMHwkTt5gQUGai6vWC2fUNaDyAAgimr1BCXN9cj+uj5X3JVt+PwrdiJYnf3s8A5mQQAQ==
X-Received: by 2002:a05:600c:3483:b0:42c:9999:4fb3 with SMTP id 5b1f17b1804b1-42c9f9d7d6bmr67647945e9.34.1725831352969;
        Sun, 08 Sep 2024 14:35:52 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca8cebd35sm72122655e9.0.2024.09.08.14.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 14:35:52 -0700 (PDT)
Date: Sun, 8 Sep 2024 22:35:50 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
Message-ID: <ihclooyralrg2yugyrkwvw3kay6k7hpdgzczhcxh5dgmakulwb@wpb4kyofz7ot>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
 <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local>

On Sat, Sep 07, 2024 at 08:27:52PM GMT, Lorenzo Stoakes wrote:
> On Fri, Aug 30, 2024 at 04:57:26PM GMT, Jeff Xu wrote:
> > On Fri, Aug 30, 2024 at 12:23 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Fri, Aug 30, 2024 at 07:43:12PM GMT, Lorenzo Stoakes wrote:
> > > > On Fri, Aug 30, 2024 at 06:02:36PM GMT, jeffxu@chromium.org wrote:
> > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > >
> > > > > Add sealing test to cover mmap for
> > > > > Expand/shrink across sealed vmas (MAP_FIXED)
> > > > > Reuse the same address in !MAP_FIXED case.
> 
> Hi Jeff, I really want to find a constructive way forward, but you've
> basically ignored more or less everything I've said here.
> 
> I could respond again to each of your points here, but - from my point of
> view - if your response to 'what is this even testing?' is to just repeat
> in effect the name of the test - we will be stuck in a loop, which will be
> exited with a NACK. I don't want this.
> 
> The majority of these tests, from a VMA/mmap point of view, appear to me to
> be essentially testing 'does basic mmap functionality work correctly',
> which isn't testing mseal.
> 
> Look - I appreciate your commitment to testing (see my work on mm/vma.c - I
> care passionately about testing) - but we must make sure we are actually
> testing what we mean to.
> 
> So I suggest as a constructive way forward - firstly, submit a regression
> test for the change Liam wrapped into his series regarding the -EPERM
> thing.
> 
> This should go in uncontroversially, I will take the time to review it and
> I don't see why that shouldn't be relatively straight forward. I will drop
> the concerns about things like test macros etc. for that.
> 
> Then after that, I suggest we have a discussion about - at a higher level -
> what it is you want to test. And then between me, you, Liam and Pedro -
> ahead of time, list out the tests that we want, with all of us reaching
> consensus.

Hi,

I agree with most of the points. Sitting down here to write unofficial
guidelines for mseal behavior.

mseal should seal regions and mark them immutable, which means their protection
and contents (ish?) (not _only_ backing mapping, but also contents in general
(see madvise below)) should not be changed throughout the lifetime of the address space.

For the general syscall interface, this means:
1) mprotect and munmap need to be blocked on mseal regions.
 1a) munmap _cannot_ tolerate partial failure, per POSIX.
 2b) mmap MAP_FIXED counts as an unmap operation and also needs to be blocked and return -EPERM.

2) Most madvise calls are allowed, except for destructive operations on
read-only anonymous _pages_ (MADV_DONTNEED is destructive for anon, but we also don't care
about blocking these ops if we can do it manually with e.g memset)
 2a) The current implementation only blocks discard on anonymous _regions_, which is slightly
     different. We probably do want to block these on MAP_PRIVATE file mappings, as to block
     stuff like madvise MADV_DONTNEED on program rodata.
 2b) We take into account pkeys when doing the permission checks.

3) mremap is not allowed as we'd change the "contents" of the old region.
 3a) Should mremap expansion be allowed? aka only block moving and shrinking, but allow expansion.
     We already informally allow expansion if e.g mmapping after it + mseal.

4) mlock and msync are allowed.

5) mseal is blocked.

6) Other miscellaneous syscalls (mbind, etc) that do not change contents in any way, are allowed.
 6a) This obviously means PTEs can change as long as the contents don't. Swapping is also ok.

7) FOLL_FORCE (kernel-internal speak, more commonly seen as ptrace and /proc/self/mem from userspace)
   should be disallowed (?)
 7a) This currently does not happen, and seems like a large hole? But disallowing this
     would probably severely break ptrace if the ELF sealing plans come to fruition.

When we say "disallowed", we usually (apart from munmap) allow for partial failure. This
means getting an -EPERM while part of the call succeeded, if we e.g mprotect a region consisting
of [NORMAL VMA][SEALED VMA]. We do not want to test for this, because we do not want to paint ourselves
into a corner - this is strictly "undefined behavior". The msealed regions themselves
will never be touched in such cases. (we do however want to test munmap operation atomicity, but this is
also kind of a munmap-related test, and might not really be something we really want in the mseal tests)

Kernel-internal wise: The VMA and PTE modifications resulting from the above operations are blocked.
Sealed VMAs allow splitting and merging; there was contention about the splitting issue, but it truly
does not make sense to block operations unless they affect a VMA entirely, and that would also force
VMA merging to be ABI ("vma_merge isn't merging these two regions and now my madvise works/doesn't work :(").


Do I have everything right? Am I missing anything? 

-- 
Pedro


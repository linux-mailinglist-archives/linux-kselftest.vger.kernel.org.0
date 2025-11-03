Return-Path: <linux-kselftest+bounces-44679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEFC2E14B
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 22:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CB3B98B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C762C21DE;
	Mon,  3 Nov 2025 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCGCodej"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF42C21CA
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204093; cv=none; b=CKhVN/HiQEruexkEvrwMVA+/TYmKj6BCh3yW/ZjmnSCqjSHzroVtDQJ9U4EEEslYtjVdG5lca2z/b4bTUOUPoAG67jXnPi25/Xp4Oyxd1SuoNAAmUagNQxO6IXht3zowPHeWv0ZMcxcXCDviSKkbtNnSE0fneBpxAYlWwJoBwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204093; c=relaxed/simple;
	bh=lqImQkBIX2RKNa9y7sFTmTERfIUIhbfGh0MuI1pu61o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Png0wwKMDx3jR20Q3LOh6VtR7zWow0vDs+H1oJ62XzNiCHn4XGSczYidVx0De811LnxZ9VkbsWkl94bSWbXGk52poSfd1Cak3bR3fc4WKrz50yQtN7bMZ/DlU/Rc/MgqX854hqYcMFzMw3ghM9elaiDGMhgCPVMN3+26JYhwN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCGCodej; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so7914381a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Nov 2025 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762204091; x=1762808891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1jgaIFuU1qR4r59NFbF5NuManKscXsOZ/dpS/a+5oA=;
        b=eCGCodejYxIbRi6xz1jEs9HBMB7LwkeyOzfAzlVXxjTM1twbMmA1yFNpWKFJaH5PDi
         022sg5dtHoXgDiwJ4GS7iXHb8nHS2G+867udMtu7SrpOtECOzrkQLzZwM/YLP6zcwCHj
         gldTYTQ6OT+DMnBpRRloew+OUe+2rKQGOi8PmCmq43YOyGzfObvz+t2YSer6GAMfl4wJ
         4Pnqf5OPPCNl2Ida9wmsSvT9JutQcI83vYPFB5gbjlj/UC+X4LRwWiTpOMpBhQsvy/tS
         rMtY4caX/ZYkyjy3Z4c5Fu1u01+Tq8rqxJW7CSoK6B3ErZ8bza16gs3IeOQGDmFcmlcx
         VEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204091; x=1762808891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1jgaIFuU1qR4r59NFbF5NuManKscXsOZ/dpS/a+5oA=;
        b=VM0smhWu64ObGdB5mgN8F2Y2ACN4uJ+h7+1RNApWEVybFrVwuzbw+gXBY6FQdzeN1P
         i/Wx41VpPjqCWR6WDObsd7RKMSt04jdSlUV6PD32vo8eesGoCEwGnD1lY23IbykXNTVN
         D/Pj9dznuQ7sYYgjbDhpS1O10/ZmfHQY6gkLsNk7OqmE6FRj9/DYsvUjDDhjIElnLMdF
         seMc3f0VscU1BMlb2cb3ISpEHxcBtg6S0MqdG7DMKpjuC77CMUTYcriB+i+Lj2nSThVf
         2wax/Bo9Mjjl5xJHMKP6fWxDy07setNQIpaGkraVZ5665rQ+EC7LSDhq9ALtCY1TXTFn
         YO8A==
X-Forwarded-Encrypted: i=1; AJvYcCWnAx08tBU6HEWMyyg/6iXLeRa64m1Yekpen/E2M3JDK9vvXltc0WefG5YVUWrBteOMXtGBaQ6SwLzwqUtVDBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkzw5CO15oazcCkaa+RBl+CgzV28g+rsXQ9/ayr2zSfIGGJXs
	g9WXEGHYqANbnKLsyiaZQJeJ3jYStaPNTImlb9i7lRaCCpfieS4V/fwdEwrCzyruH6yxFqOw8G2
	7FchlwQ==
X-Google-Smtp-Source: AGHT+IFmLCYVwXdeteTbsVspNCQQNa07ZbCjVAqI5KUDK7A2fmNFJ3jDRmAVUCA7gp+ckzqh33TY6g3AxJw=
X-Received: from plbmn15.prod.google.com ([2002:a17:903:a4f:b0:261:3bf9:662a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c947:b0:295:1e50:e7cb
 with SMTP id d9443c01a7336-2951e50eb4amr164854455ad.23.1762204090972; Mon, 03
 Nov 2025 13:08:10 -0800 (PST)
Date: Mon, 3 Nov 2025 13:08:06 -0800
In-Reply-To: <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-3-jackabt.amazon@gmail.com> <aPpi1c-8EpWuo87B@google.com>
 <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com>
Message-ID: <aQkZtjLt6lIULffA@google.com>
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
From: Sean Christopherson <seanjc@google.com>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk, 
	jackabt@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 28, 2025, Jack Thomson wrote:
> 
> 
> On 23/10/2025 6:16 pm, Sean Christopherson wrote:
> > On Mon, Oct 13, 2025, Jack Thomson wrote:
> > > From: Jack Thomson <jackabt@amazon.com>
> > > 
> > > When creating a VM using mmap with huge pages, and the memory amount does
> > > not align with the underlying page size. The stored mmap_size value does
> > > not account for the fact that mmap will automatically align the length
> > > to a multiple of the underlying page size. During the teardown of the
> > > test, munmap is used. However, munmap requires the length to be a
> > > multiple of the underlying page size.
> > 
> > What happens when selftests use the wrong map_size?  E.g. is munmap() silently
> > failing?  If so, then I should probably take this particular patch through
> > kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
> > 
> >    3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
> > 
> > If munmap() isn't failing, then that begs the question of what this patch is
> > actually doing :-)
> > 
> 
> Hi Sean, sorry I completely missed your reply.
> 
> Yeah currently with a misaligned map_size it causes munmap() to fail, I
> noticed when tested with different backings.

Exactly which tests fail?  I ask because I'm not sure we want to fix this by
having vm_mem_add() paper over test issues (I vaguely recall looking at this in
the past, but I can't find or recall the details).


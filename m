Return-Path: <linux-kselftest+bounces-43560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8242BF23B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F9F3BD82A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE3276050;
	Mon, 20 Oct 2025 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGgHkTUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394A264FB5
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975530; cv=none; b=oaEnk++PFhfpttIcawL7QZ+g2mSzp6AUiFutD++3xIjRK3HpkpncuBc7pic+noUEREa9hiio3XLF6forGrX0iIpQtiDfxv0+Y92hcBidjQPA1zN0jl/phzBrLfNQMn5EnoAwuPC/jDWDdCrpj+bUnxfDNsG2HqyL3xuYdH5Dzbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975530; c=relaxed/simple;
	bh=nh7KmG91llH0eTJy2kGD6whEVv3qZowTvAaONNXWCzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mC4+SvxI8YfoQMb2t4a/8nFX4JiV8AmwrJv967ARkVkqCcSVRV0k2MYiGaeV6IiN+ZquSO/Fe8BgpE6kt70lWPTT0Uik6WlxSyDHy/7UsTx3qWp2btB3jkTSiFu1l9BJFoz8WFR+8FjRJhWPO1lhhyzsPFsuN8QDVzRDDpNjZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGgHkTUd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so3699751a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760975527; x=1761580327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUxEjev6w4f1umuBxGfAcuaZR32QUUEbuSMBs3oceNE=;
        b=VGgHkTUdhZTj02Irb7NYvhGZfItj+GtjPAlSpLrvrHnKkNp5OVt+BQ95EwoJZAfzHk
         WB2D1/bKrttYimuybRv/06WxtsUw7I1J7SDDK+LDf8ME+notiictwNYi9EyFUk+M/cM9
         KJ1LyTj3K5idElljaGq7GKrWUjQuiZVjTb6Yn/P7w94Vsqxct7svktYODSJSAkbau8I9
         JuFHMUbNnOtBoyf+jtuDTo5/N7x3xD3znQUow0tEs+HY79iFFlj4Z8KdZIY2qL4EcrPE
         SltyuRfv/PylxxFOT8lNfNnBT0GwzfTV0ll1VsMV4tZ69ZoEDZizWL9obNkRzJjRXpqw
         2/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975527; x=1761580327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUxEjev6w4f1umuBxGfAcuaZR32QUUEbuSMBs3oceNE=;
        b=tlbrwmZ+oOPxsL3NRs1VguAK/8sno3r3Lpvgum8ISS+WlhBTTPpc9PXwMhi823SWhB
         BE4dAdj8Xq+yFy52kugqHHdrFIG99DI3Kbfa4HHklEe8t8w1lDy9NtveBSObLMDZZhm3
         KoLsNZSK3AORZ7DAf/Ha3t2tpX8+gMI5ya0Y+9tyAn1OcArt6PG0Uis5WJCGo3PLw6Rc
         7fNxPqriK3tUrjRP5zIS5jBpRg/oKQE0r18sqoBRVidWZWBCOlGSHIAlpRvqeUitfwCm
         2/Ll0bK8HOkhwbMPMZ9jB/SoATd8HzyB/Xj148CdShTjYsMmqjlzEklOPqx4KlDjR1TK
         X/mw==
X-Forwarded-Encrypted: i=1; AJvYcCVXGHw/DSqRA68nO2tOKa2O/7h2044as6ZuywtC+u9aUdzOraiOTUpKZCNsO8pfuOqMQzDNIKfpS6A9kK/7sbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1u0l1iEl7va0IRq7sMYMygZ0ynY1NBI5XbtsoOG8T32faLRLC
	K69fjDvm5rLVjDd9iwmxc+J/WFt3wE8L6dgfLnPPx1SqmZa2bZKTgJBm1fdGC4WyGbj1JGYtw9H
	7B/UT4g==
X-Google-Smtp-Source: AGHT+IHcZobfkAMYLqgP+952/xufHk4lZqraqyIEs0BsZFGgLzowAsqRVArAQbVQNZgQWXn7bmNPNT9qaaI=
X-Received: from pjbds19.prod.google.com ([2002:a17:90b:8d3:b0:33b:51fe:1a84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d85:b0:330:4a1d:223c
 with SMTP id 98e67ed59e1d1-33bcf87f421mr15625676a91.15.1760975526813; Mon, 20
 Oct 2025 08:52:06 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:52:05 -0700
In-Reply-To: <176055105546.1527431.3611256810380818215.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <176055105546.1527431.3611256810380818215.b4-ty@google.com>
Message-ID: <aPZapWWFGyqjA2e3@google.com>
Subject: Re: [PATCH kvm-next V11 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, 
	Shivank Garg <shivankg@amd.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, ackerleytng@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, 
	vannapurve@google.com, chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, 
	michael.day@amd.com, shdhiman@amd.com, yan.y.zhao@intel.com, 
	Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	aik@amd.com, kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Sean Christopherson wrote:
> On Wed, 27 Aug 2025 17:52:41 +0000, Shivank Garg wrote:
> > This series introduces NUMA-aware memory placement support for KVM guests
> > with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> > that enabled host-mapping for guest_memfd memory [1] and can be applied
> > directly applied on KVM tree [2] (branch kvm-next, base commit: a6ad5413,
> > Merge branch 'guest-memfd-mmap' into HEAD)
> > 
> > == Background ==
> > KVM's guest-memfd memory backend currently lacks support for NUMA policy
> > enforcement, causing guest memory allocations to be distributed across host
> > nodes  according to kernel's default behavior, irrespective of any policy
> > specified by the VMM. This limitation arises because conventional userspace
> > NUMA control mechanisms like mbind(2) don't work since the memory isn't
> > directly mapped to userspace when allocations occur.
> > Fuad's work [1] provides the necessary mmap capability, and this series
> > leverages it to enable mbind(2).
> > 
> > [...]
> 
> Applied the non-KVM change to kvm-x86 gmem.  We're still tweaking and iterating
> on the KVM changes, but I fully expect them to land in 6.19.
> 
> Holler if you object to taking these through the kvm tree.
> 
> [1/7] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
>       https://github.com/kvm-x86/linux/commit/601aa29f762f
> [2/7] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
>       https://github.com/kvm-x86/linux/commit/2bb25703e5bd
> [3/7] mm/mempolicy: Export memory policy symbols
>       https://github.com/kvm-x86/linux/commit/e1b4cf7d6be3

FYI, I rebased these onto 6.18-rc2 to avoid a silly merge.  New hashes:

[1/3] mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()
      https://github.com/kvm-x86/linux/commit/7f3779a3ac3e
[2/3] mm/filemap: Extend __filemap_get_folio() to support NUMA memory policies
      https://github.com/kvm-x86/linux/commit/16a542e22339
[3/3] mm/mempolicy: Export memory policy symbols
      https://github.com/kvm-x86/linux/commit/f634f10809ec


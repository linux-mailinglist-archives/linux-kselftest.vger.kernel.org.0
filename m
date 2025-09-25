Return-Path: <linux-kselftest+bounces-42431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333FBA1EAA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 01:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D946F4E2B87
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF02ECD26;
	Thu, 25 Sep 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pt9mBF+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639882ED14D
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841427; cv=none; b=dpfPKochbbPeI0rdWgHTpcO80YkBUhbIblz41XPfGm6+j3PclqYAc0djKHjYAAhG89exAQNElNfxXgicuBVb3wxEEL9erCvRVrqmVEkoXyosYNVCTnIosylhW1ZzQdZtrYWnTTHxt0BvxSBWmKJsWP68oJ0MPZD8XY6HzXJU1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841427; c=relaxed/simple;
	bh=Um8aeiydeRdUMdXziGIJjdPbc6WPGBVZ9bXwXt2CTto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KI8c/cIUeuY6/5Lfi5XAN0p7i1Vzn2oJc0LGUk+zRvs7yEQEGW/LKNPFDt/R2c7WJH0vT7UWOYtI1PTFrDDXLK/ThYL43EydoxBwQgICfs4c9GKF6eRMnUtBV7BI/MmPEWxZyq3mIVhMFZiunZYS3wdVPAPkAbpQiv1yKRFCakU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pt9mBF+E; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so1438550a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758841424; x=1759446224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XtCsq70qhQXvjo5i7WnTkFuUeYKslZCOA6r0Ck9tpm8=;
        b=pt9mBF+Exc7w3tA1MPfM8PPSHlz97ai7tuGQqwRHYHCt8yPMHYcgbbbGcrDDA3xgCY
         G+Tc3Ja6s9x+DVYtDIczbjdSyIFz8oPwf9wzoRI0M0nip7yov9otmrRTyBnxL8XPSWn2
         S0biRBz3G15TmkBCzVwqXnQxTdyDMSDzTdedo9adp+KIqSI5joCX1y+/6N0qJNmYiy7a
         sU38qJpwMnRwnqyhmZ8qb2EaShozy7OawVKOYQAFUEYAqFxtdAWPBzXk49Z5JUYgt5wI
         VllLS3AcU4zrz32/pIh9MHN97soe8TOXdNeBLUp4fqkJ5OdpXPTOl/9GWxQWl4rzCgda
         AEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841424; x=1759446224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtCsq70qhQXvjo5i7WnTkFuUeYKslZCOA6r0Ck9tpm8=;
        b=bu0sHmtTW7wm8u227ZPyhk7Yp5Sdhw6ROaymABUczgkr9wyoN4/qivl/y/B0d8y2an
         GMcexo11YiobZa1O3htdff832XrN0GrnGUXlihgcXti6YZJ/AOn+Z30zBf2PI7s32agA
         Ditpc/dEE0idyxmsmv2F2ZaST5WiEqFgNOy0jiO8GZ6ZmrcgtVhpIplT3gl5UexEMt4t
         Z8QN7S89+6DXwxhHMWga5sVaFbJQgXnIPwPhEf24sxVjJiBDOUhtMDHeBchMMMbPbrxK
         eFa8+IIfMoK6yJEuDpmuU1drf79dhR+drw44DKAgT5dc855fZCmnbVe/TPdpsJx8EbN8
         iezQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUKYLP3g7EXYYOzZUBThi3w6HCNDE6X6ebt06t0U9pbJyda0qwKqTRZ/7seYSHDfFV6fWzHMancdePxGti4wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMUAUEUvuwYNl0Dr7gu1/tEQqbD4WAJW6R7C+IDW4bfEOOx7n
	nQX0RaGGEJ0qqRpbiPI/tkrN5PK4ycIuudffecHGjYlRS1aOOFX4xhypt2lZW27Uaqmu7xotPMY
	0cka//w==
X-Google-Smtp-Source: AGHT+IFCIuxfWzAAq0mG13fuYXVsG7N7KK6Fo0/VQdrpMqaeQ2l1EixZPHW4Wo1ErVxR9DWPn0iSBzBRvc0=
X-Received: from pjbqo8.prod.google.com ([2002:a17:90b:3dc8:b0:330:6d2f:1b62])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b4f:b0:330:852e:2bcc
 with SMTP id 98e67ed59e1d1-3342a2ca0e6mr5749959a91.21.1758841423443; Thu, 25
 Sep 2025 16:03:43 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:03:41 -0700
In-Reply-To: <aNW1l-Wdk6wrigM8@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
 <aNW1l-Wdk6wrigM8@google.com>
Message-ID: <aNXKTUnxHQyds4sh@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Shivank Garg wrote:
> > Add tests for NUMA memory policy binding and NUMA aware allocation in
> > guest_memfd. This extends the existing selftests by adding proper
> > validation for:
> > - KVM GMEM set_policy and get_policy() vm_ops functionality using
> >   mbind() and get_mempolicy()
> > - NUMA policy application before and after memory allocation
> > 
> > These tests help ensure NUMA support for guest_memfd works correctly.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> > ---
> >  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
> >  .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
> >  2 files changed, 122 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > index 90f03f00cb04..c46cef2a7cd7 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
> >  	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
> >  
> >  LDLIBS += -ldl
> > +LDLIBS += -lnuma
> 
> Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
> any of my <too many> systems, and I doubt I'm alone.  Installing the package is
> trivial, but I'm a little wary of foisting that requirement on all KVM developers
> and build bots.
> 
> I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
> prevelant there.

Ugh, and it doesn't play nice with static linking.  I haven't tried running on a
NUMA system yet, so maybe it's benign?

/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/14/../../../x86_64-linux-gnu/libnuma.a(affinity.o): in function `affinity_ip':
(.text+0x629): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking


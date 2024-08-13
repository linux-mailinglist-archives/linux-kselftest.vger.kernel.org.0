Return-Path: <linux-kselftest+bounces-15236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC939509C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845F11F26CA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC111A2C11;
	Tue, 13 Aug 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEuaiS9Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459171A256A
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564996; cv=none; b=DdwO88w5EebWasQ4nxDklDYG/6HSdkbXIMvfWTLHLs1+qmVeH5zWoDkVD7EVSyAPRmZHGKo6c0bHWGqmNsHEHRNqUeY7Ld06OZVPfJq2f1WyW32x2xOZv0EjYbjWXwabbVQH/la1QLT6MhYcHKgSZp+0V7VQszCSTbM9lwsWQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564996; c=relaxed/simple;
	bh=F47EHq77023/lXDUUAO6aOhPpP6rSjWKXO8beR/YKzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LWGGQqQS56RXdvZTWKpbx3qPIBzdObWFBUj9sg5PkOxNVNMdTMN5E3PG5LrVH9TxAprf/xQWmZyRx7zVj1KDJivXOef+CZAlWXyKSNdDNT+a43R/EKtEpwN5lel6TfTDW453gj+H+ysjAwvgPzqjXbZOReiUuX0oWUFTAroDeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEuaiS9Q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a1188b3bc2so4639553a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723564994; x=1724169794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNjHU/ydo2HnfKI/EhoPeOvQeF9OBxuIzvOW3Q9mwY=;
        b=iEuaiS9Qb7yn5SNdbrToERBYer7PDbIuNgcpkyDw/DMFHB3C16IiEcpoGCa/7qA+lz
         p2oo/e/abvxG//chKpjCTuYST5s4AEl+jZ4grR7x+KAjcWwmW+Iswou7N+vHgU0absZh
         gEgN2lPWNctjGkT19HfCgvMs8TgbrUNUO2gY9DUmoE/z934V3YMYOKEhJHLrBtOCxX9r
         VkupIZCjmnUnYVv3cILS2IHI6q4NNRJV6aBxM2EEB/vpXgwHrC+tiWAuZLS9ooakAsXx
         0oL3HveoG+HgceK77BRdBjAF5lrlNIZCHepoUQqfcGkxAS9WxN2kFAmc2oXVEfVONzXC
         /sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564994; x=1724169794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNjHU/ydo2HnfKI/EhoPeOvQeF9OBxuIzvOW3Q9mwY=;
        b=TvRj6XQ4sLxB6bIu4Az58b/dpxNOlA6Z0DlMKG5t15FPuIsyjW0Rx852HZiNS31rqX
         LLoCXuGLtrBEJ9nLIvXgG/3JL57KahyP/Q4xcFOtoVSHEElf2cs3FPRgA8X5t5Pi4b55
         p99n3K/PIyhcB7vjTzNpCR+oU8dZXalYw22aL6Nw14OIrmZYelTpJhqCgZDTvNWsxXeL
         EhhPeZVEi4nsxzb8rMHvD+i//irL5DyMwk2rBh640UOFHLNwDXVzr4UFJ/LoR/9ImpqT
         IUZGbghlFjof04w7+4/Nc/ZoFQ3Ne8dDntp+zCWcFkv4zhmea3s3g0I6LFPSU/xTm3Pe
         9R1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhwliFRbpqzx4dzVp7I1I8puxbkFsoLdpyOmHMw8D3nZFq6EdF8WiKzafEwHOy/nxtaHxOdvUNGTryKu3EK/RRT4RqQ76Q70VdBNQRku2e
X-Gm-Message-State: AOJu0YyPfZKBgHchqqW22n3nBRGucMflepVS5hgIdo+OsAD607Or1kBz
	jg1pUQOypEOQK3V1WWHlYPVA6j/K77yckokXKf//gi3HjHKvq1qvu1diQCQPmGD3wRoDjOMh+GQ
	1Cw==
X-Google-Smtp-Source: AGHT+IFrZp46NTMczg8GibpwuCklDdZnw9n1ZZZOHuXqAFPYRO449Qj5pKywAnxXfAGO7Ccz6pU2oEs5TDs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec85:b0:1fb:7f2c:5652 with SMTP id
 d9443c01a7336-201ca19cadamr3716485ad.7.1723564994439; Tue, 13 Aug 2024
 09:03:14 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:03:13 -0700
In-Reply-To: <Zrt93t29X6A0nmys@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528041926.3989-1-manali.shukla@amd.com> <20240528041926.3989-6-manali.shukla@amd.com>
 <ZlWLupfpODawPX3P@chao-email> <b45bc797-9087-4456-ba18-463c3f638096@amd.com>
 <ZllzCoYvMQOkMo90@chao-email> <Zrt93t29X6A0nmys@google.com>
Message-ID: <ZruDweYzQRRcJeTO@google.com>
Subject: Re: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept test
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de, 
	ajones@ventanamicro.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 13, 2024, Sean Christopherson wrote:
> On Fri, May 31, 2024, Chao Gao wrote:
> > On Thu, May 30, 2024 at 06:49:56PM +0530, Manali Shukla wrote:
> > >>> +	/* Check the extension for binary stats */
> > >>> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
> > >> 
> > >> IIUC, this test assumes that the IDLE_HLT feature is enabled for guests if it
> > >> is supported by the CPU. But this isn't true in some cases:
> > >> 
> > >I understand you are intending to create a capability for IDLE HLT intercept
> > >feature, but in my opinion, the IDLE Halt intercept feature doesn't require
> > >user space to do anything for the feature itself.
> > 
> > Yes, I agree. Actually, I was thinking about:
> > 
> > 1. make the feature bit visible from /proc/cpuinfo by removing the leading ""
> >    from the comment following the bit definition in patch 1
> > 
> > 2. parse /proc/cpuinfo to determine if this IDLE_HLT feature is supported by the
> >    kernel
> 
> Neither of these is sufficient/correct.  E.g. they'll get false positives if run
> on a kernel that recognizes IDLE_HLT, but that doesn't have KVM support for
> enabling the feature.
> 
> The canonical way to check for features in KVM selftests is kvm_cpu_has(), which
> looks at KVM_GET_SUPPORTED_CPUID (by default, selftests VMs enable all features,
> i.e. reflect the result of KVM_GET_SUPPORTED_CPUID into KVM_SET_CPUID2).

Never mind, brain fart.  That only works for features KVM is exposing to the guest,
this is purely a KVM/host feature.

That said, doesn't this test also require that AVIC be enabled?  Oh, or does this
happen to work because KVM uses V_INTR to detect interrupt windows?


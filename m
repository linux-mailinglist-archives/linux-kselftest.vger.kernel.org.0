Return-Path: <linux-kselftest+bounces-31424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EAA993F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6247B3BB939
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD9281374;
	Wed, 23 Apr 2025 15:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xMdCxPPM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BA79F5
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422221; cv=none; b=LcuHmHWWI2wiBdskF0lUtRJnLkUDnHmLDp532y+4I4hawfZepq0099uWXpf/Shzqyvq9jNRWBWqs5Q7EL6JJSxjJ2NRpc9j/vhFQs6OE3f8oT4z7idPOZB5CqYQXlagVj2CjKo/ekJc3lGmOjfWITdPfOOshXkg9tsLghJDIn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422221; c=relaxed/simple;
	bh=Vq6vhsxs40tP9d5NlmjPRy8NhwbWi1gHcz6l7t5TzC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q2j452KAiYmjuYw/tN/cjAeE8GhWBvIm+nZTamImH/egfW5bpQwc3KHEoBvTXM99wXazZ3eM5X9/lNuQ+XDpobLG0kHjmHBbajMvQ11KqesR22PegGukRXkTHJw2N9DY9B0xB3GBgqzduDwH+HFE6ewaYF7K9yk2m64Wit1+ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xMdCxPPM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22410b910b0so51736435ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Apr 2025 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745422218; x=1746027018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuF5aM5uvUzwQnspTEzQdS23ITC9dWctjltafpb1GqA=;
        b=xMdCxPPM5ihdKRIpdHW5+de76Nle+U9DtelaxlpWiaIU31i5ZgcUp5PVyllBDYq0NL
         RARdQK2Pwyv98sbDvDt14RcOoGqg8+zrLOZYGKoTP96jBYBE5sECjssCrooqKH0jOclu
         QvWZ4K3kHU2LGEQ+KSwkky9xjc/Lvro1hw5EVtQ3KTbXd1GPurerOQxw/+L3gRnpPEJP
         pmcGZbGT+dTojTUD+gpZmI1bwxSeogjnlcZdgp+X1oUZhssq50clE9693ZpSjtr3nNZ6
         vbsZipsqNo59nrdFFqSd+kBpPNOuAiTEiCaslQdv5ZMGnpU7yoLrgCvrRwEbmtPMaPI4
         VOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745422218; x=1746027018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuF5aM5uvUzwQnspTEzQdS23ITC9dWctjltafpb1GqA=;
        b=S15IegKoWt03o3GrnkAtPa5y2jLtrOAnhSaNDDZG36yrfXiQk+YEMzyQjw1OhyP92Q
         7TQ7UeYqXiy5nhpK+54LLCgn3yBwYfy83SYoziueP+a8Essc27i/xAlb1xqb+QSSYm5K
         80E6gVox90jlzcQH37caDT3SiUPn9V9u7qvkea0hezRIY6f1qpTJlCfPKnPeZOaCpWcO
         maypJhb6N8w7nIPHRjMAFSxBFY1uk4ybsP2KHPeNZUfUe9vC+uz9oquzsoxOI+8eE7Qv
         yxq0/ZJ7Q5fspnARDRnNovPFiAbJu80ut8hLkiqC/4hWAG3wu8k5XdiplgfDJMN9aZ3E
         bT2A==
X-Forwarded-Encrypted: i=1; AJvYcCUdyO3UZwy7ErNGHbS1g0odsE1pUWLeiwc/1PJ2eq9+fe0CwR5s2Mf4GEy6q/n8Rto5u6bgq/N3nQsFcRn+RYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfbQfoA8R6z/UEUkQsh/wxj6+X6hJyEUlMRlNWOCc39NQwH4H
	/MgCYUHs0SSNjnSjM1i7msS3plUner2H9BlccoSpKzd8VHnk1h7YisWoFvk+uKnUXB7lh8pPovD
	CNA==
X-Google-Smtp-Source: AGHT+IG3ZfaZuHuLl6tG9igc6TROAYnGCS+93+i2EnpH5jq21Q97uLnrdJpiHpiNCS7xZFVke3MttxhmyUA=
X-Received: from pllb3.prod.google.com ([2002:a17:902:e943:b0:21f:14cc:68b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88f:b0:220:f151:b668
 with SMTP id d9443c01a7336-22c535815admr231239285ad.20.1745422218189; Wed, 23
 Apr 2025 08:30:18 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:30:16 -0700
In-Reply-To: <5fb4f5f8-55d2-44a7-808e-76c8a452cd2f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-5-manali.shukla@amd.com> <5fb4f5f8-55d2-44a7-808e-76c8a452cd2f@intel.com>
Message-ID: <aAkHiL_N7QGND8Tj@google.com>
Subject: Re: [PATCH v4 4/5] KVM: SVM: Add support for KVM_CAP_X86_BUS_LOCK_EXIT
 on SVM CPUs
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com, nikunj@amd.com, 
	thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 16, 2025, Xiaoyao Li wrote:
> On 3/24/2025 9:02 PM, Manali Shukla wrote:
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 5fe84f2427b5..f7c925aa0c4f 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -7909,6 +7909,25 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
> >   KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
> >   to KVM_EXIT_X86_BUS_LOCK.
> > +Note! KVM_CAP_X86_BUS_LOCK_EXIT on AMD CPUs with the Bus Lock Threshold is close
> > +enough  to INTEL's Bus Lock Detection VM-Exit to allow using
> > +KVM_CAP_X86_BUS_LOCK_EXIT for AMD CPUs.
> > +
> > +The biggest difference between the two features is that Threshold (AMD CPUs) is
> > +fault-like i.e. the bus lock exit to user space occurs with RIP pointing at the
> > +offending instruction, whereas Detection (Intel CPUs) is trap-like i.e. the bus
> > +lock exit to user space occurs with RIP pointing at the instruction right after
> > +the guilty one.
> > 
> 
> 
> > +The bus lock threshold on AMD CPUs provides a per-VMCB counter which is
> > +decremented every time a bus lock occurs, and a VM-Exit is triggered if and only
> > +if the bus lock counter is '0'.
> > +
> > +To provide Detection-like semantics for AMD CPUs, the bus lock counter has been
> > +initialized to '0', i.e. exit on every bus lock, and when re-executing the
> > +guilty instruction, the bus lock counter has been set to '1' to effectively step
> > +past the instruction.
> 
> From the perspective of API, I don't think the last two paragraphs matter
> much to userspace.
> 
> It should describe what userspace can/should do. E.g., when exit to
> userspace due to bus lock on AMD platform, the RIP points at the instruction
> which causes the bus lock. Userspace can advance the RIP itself before
> re-enter the guest to make progress. If userspace doesn't change the RIP,
> KVM internal can handle it by making the re-execution of the instruction
> doesn't trigger bus lock VM exit to allow progress.

Agreed.  It's not just the last two paragraphs, it's the entire doc update.

The existing documentation very carefully doesn't say anything about *how* the
feature is implemented on Intel, so I don't see any reason to mention or compare
Bus Lock Threshold vs. Bus Lock Detection.  As Xiaoyao said, simply state what
is different.

And I would definitely not say anything about whether or not userspace can advance
RIP, as doing so will likely crash/corrupt the guest.  KVM sets bus_lock_counter
to allow forward progress, KVM does NOT skip RIP.

All in all, I think the only that needs to be called out is that RIP will point
to the next instruction on Intel, but the offending instruction on Intel.

Unless I'm missing a detail, I think it's just this:

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 5fe84f2427b5..d9788f9152f1 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7909,6 +7909,11 @@ apply some other policy-based mitigation. When exiting to userspace, KVM sets
 KVM_RUN_X86_BUS_LOCK in vcpu-run->flags, and conditionally sets the exit_reason
 to KVM_EXIT_X86_BUS_LOCK.
 
+Due to differences in the underlying hardware implementation, the vCPU's RIP at
+the time of exit diverges between Intel and AMD.  On Intel hosts, RIP points at
+the next instruction, i.e. the exit is trap-like.  On AMD hosts, RIP points at
+the offending instruction, i.e. the exit is fault-like.
+
 Note! Detected bus locks may be coincident with other exits to userspace, i.e.
 KVM_RUN_X86_BUS_LOCK should be checked regardless of the primary exit reason if
 userspace wants to take action on all detected bus locks.



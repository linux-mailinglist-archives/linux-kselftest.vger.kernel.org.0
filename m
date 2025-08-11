Return-Path: <linux-kselftest+bounces-38694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E27B2144D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB153E2CBF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1982E11AE;
	Mon, 11 Aug 2025 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pu7u48aC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5862E0B71
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936724; cv=none; b=YLSWupvokEv5ifN3ItzaOoN5O71nKgdv9GlHz7s/b9QX6kPBfuRBB0RhjAGINcGYCvcutAGEJivcVpBj06yC/0A6mTfP1ptpMkEL7Rk1paqP1s7Pdtkw4laTtDgVMz2ZhQDakrPuquPAkcR3DI/OdBcrgtcmbbsMxJ7Whaozsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936724; c=relaxed/simple;
	bh=+RaoGEfqODQpjds3+pa5hzUvYCotn9nVbr9q7E3jVBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XclA6YPxXhj2bonUd7bKVWcL2QwA2uehUbMiZMx+0Qi/nGmWK5hwx3vXmu23zKh/j97sktompIUirEW2fJrR9u0XTXbL+ITdoQEbkKmh9VOTsXg6hxqJ0P3fx1n2AnxUgLxLuKJDjEG68lHo7dbTPe9uSoYwsXAVxZ6T8MTWAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pu7u48aC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31ebadfb7f2so4458829a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 11:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754936722; x=1755541522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkymeW9oJwqBHxAPtMhP6NoKFqSvnGj/TBIK2S4XTUo=;
        b=Pu7u48aChQ7x3AINRl4vlr1YlUJa3elREij6oAYsxdM3mPq5g4/wZGB9WWgJhbRxi7
         B+CvxTPfX+xM5e8WeLqQJvNZ48UfZ4kkOQyfdYjSGbX0h+F1hKF12Xt8lWeuY56wxdOD
         ijelmJC8G9NA+klOXh6Iq74Ww39uk2cpqjM0rc9J4sSgEVVtNkaB0rZ/D1lrA5IVaZGS
         oKTmavfw7gH2kSarBfkLCjxnnaZwn9C+RFCS5J5FV3Fbrxd5b/Jv4Tm2UvGSFApTztc5
         U+phlYpAUhgTnHvtO4AEUncwi+qaeVqhdsNrImcKXoAaU3i3Ho2bzyio1dxBT2nnpNuI
         EAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936722; x=1755541522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkymeW9oJwqBHxAPtMhP6NoKFqSvnGj/TBIK2S4XTUo=;
        b=AewryMexeAgJtN9ovIlYLNCc4wsr6oNR1/OATl+G5BBjaVaP+2Db9oeJq86YWdVvGy
         3+AGJEhEbdSsBDXr84XS767tDxZWMJ9iVW1OKR91T6x3QDQ1JfRcRVtJ4X6OMrlj0mG3
         4kr65AEkoWIydigb194ydMdILWb0Ih3vSkv9/bBuRnX334k8RZyA027ZmFJYHnNfTSBK
         iCFM9oQFy7IGYFNO/Of4uZ0bfs4BjLUoxVXTqA2tngv7sODkKdMz8SfBvuMf153cRZHF
         FXbwge01nznuyBSXIGr3T0L0pbxVIhsiWHyHykWumKaMzQBK8PvCTL4E5idfpDcDNrFB
         xPIA==
X-Gm-Message-State: AOJu0Yzmf3aY4kWQx4yEmf95PQ/8mGj2bb2sN4hiw/JcqHluKSCC7VYl
	K4BqWkjFiNBN2u878fbo+h9hFD5JH5BBRERmD1E5zGgCgpWfrBz3VKJEW5KXD1Ffb20k4CmJ4RW
	xVTQnHw==
X-Google-Smtp-Source: AGHT+IHhf+u8DAgFU8Tb7yj1qaPeuXMKCvgtRgZ1OiwVl9wM0oGpeZSCJHlG1M98vl/B3sySbxtqsUMXd2U=
X-Received: from pjbsj7.prod.google.com ([2002:a17:90b:2d87:b0:31f:232:1fae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4d:b0:312:e6f1:c05d
 with SMTP id 98e67ed59e1d1-321c09df627mr727122a91.2.1754936722399; Mon, 11
 Aug 2025 11:25:22 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:25:20 -0700
In-Reply-To: <20250807201628.1185915-5-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-5-sagis@google.com>
Message-ID: <aJo1kNCUzAe2TFAz@google.com>
Subject: Re: [PATCH v8 04/30] KVM: selftests: Add vCPU descriptor table
 initialization utility
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 07, 2025, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Turn vCPU descriptor table initialization into a utility for use by tests
> needing finer control, for example for TDX TD creation.

NAK.  "needing finer control" is not a sufficient explanation for why _this_
patch is necessary.  There's also zero argument made throughout any of these
patches as to why this pattern:

	vm = td_create();
	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
	td_finalize(vm);

is the best approach.  IMO it is NOT the best approach.  I would much rather we
structure things so that creating TDs can use APIs like this:

static inline struct kvm_vm *td_create_with_vcpus(uint32_t nr_vcpus,
						  void *guest_code,
						  struct kvm_vcpu *vcpus[])
{
	return __vm_create_with_vcpus(VM_SHAPE_TDX, nr_vcpus, 0, guest_code, vcpus);
}

instead of open coding an entirely different set of APIs for creating TDs, which
is not maintanable.


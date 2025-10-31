Return-Path: <linux-kselftest+bounces-44533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775CC25F1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E03444F627D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F83F2EB86D;
	Fri, 31 Oct 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIVFPezx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721402EACF9
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926160; cv=none; b=bqgmVCMx1XhoN/UG42txlZgsd4ek9STHqxF1XE3zX6KTqxMbnHnFWuLbiIj8L04RQtaYuNB1mn4kGxxb38wuAt+Wm8nE9M7+PbWxGuErUeg5kj+RKmig0lQNdDtv/oNtzOebXbz0iZItGycMknL8zdKhVYqNBsM9Y3jBcgT9QTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926160; c=relaxed/simple;
	bh=t8Bki2mZlE4ZDwdVcMbMtVwPgZgWgPVZgc6TnvQRl9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VsZYosECFUwVq26/GQyZofjuv5ZXnXBN4gxYzpkjrf3qmCHmSlTQLcqzTAxT4Ud/jo1IAp+xXr737WVPtk6tIUWKLLQZZpwfd6IXsHx8e1bNo01cjbalRFr47tFtgS4vyBwMTCls03lYejOYkzuu9YRIZZ/XbdwRLVsUkj+4Ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIVFPezx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3405e02ff45so2064779a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761926158; x=1762530958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSE6VWD4vxaaTE+0KBr/ChxCqFBWm8TM2v7b9di8yIw=;
        b=FIVFPezx07D5IdTkgodTZt+ara/8KqP1yM/NoZHCUO5dX8b+CWQA1rdA2GqNExzreD
         UNUrH9hDQjG3VqhGl3c2KAtRjZj0nGij0BEAbhC50QEAvFU2SRCAgXr+uagdl4aCcmuM
         fkNdaiB2yom3IM6fsAB2WUOhIVNE1gICajl+0x7IjroHeCQEWiv3pB60cs9ScVaBn4FP
         uMNLyfic0wWsaptlnVwwhohm2OnMjb6jhRS9fT7RfGhTAYkBV++KeY/EQwu9uCGmR0Fi
         IeCD/HZgUXJcfY2cG7qjyLKEAG8Bf663v4unJvsyqWxiznFP2Xi0NM7tscSCTEHSblk3
         Og5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926158; x=1762530958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSE6VWD4vxaaTE+0KBr/ChxCqFBWm8TM2v7b9di8yIw=;
        b=aHH5hLGkU2g0NQ0JWWowzpgTWV3Sp9Sa5XAPABB9W/jBTUbcIldbfhQNJVHxRv0e9F
         DFt5VnG6bFZ8xszifGkmMH6Jfb/jbZ0G99So+UfLcQpm7jZ8E8HsGUrSFU+lnIazNIhn
         /KZQSODR5YDOuBc9ukIfybFUP8d1WdfeqhLAlz5uPq9WERn4cl0jPeN0ik2G5PTTYxn4
         kTY0Wt16nSZ75q4IvBkISdqQRYXOvGiRRPh2hqwI2aEt3249+U7OX10ZrRL/lAGyQorI
         NYHj7maALyv4jJORhyNYIcp3JC2Hb/DC3w+hMEazryMzDO8+7Ci7Ltp1OAqn3NHL0Fkc
         /jag==
X-Gm-Message-State: AOJu0Ywr5bVJ9f2IMK8lSHODHmIsxAWYltju/2JnzXlCreBuGq2xXZ8H
	S5jhmEWhXoysigtLqrWT5gmWYiVpAaRwAgBNsMVJByqvyHL4Bf8erEskkmqjNiHGQP1f5lurLc/
	8sxmIyg==
X-Google-Smtp-Source: AGHT+IHK5XrSj2/97kQFOhhQkT/88rHDWAg9SuzbdwRpl3MTETpFtRtdCwbGXG4UVT+AGrJf8RWbxI8IFXY=
X-Received: from pjbnm10.prod.google.com ([2002:a17:90b:19ca:b0:32e:d644:b829])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c12:b0:32e:f1c:e778
 with SMTP id 98e67ed59e1d1-34082fce72amr5948234a91.3.1761926157852; Fri, 31
 Oct 2025 08:55:57 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:55:56 -0700
In-Reply-To: <20251028212052.200523-23-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028212052.200523-1-sagis@google.com> <20251028212052.200523-23-sagis@google.com>
Message-ID: <aQTcDH9LRezI30dm@google.com>
Subject: Re: [PATCH v12 22/23] KVM: selftests: Add ucall support for TDX
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 28, 2025, Sagi Shahar wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> ucalls for non-Coco VMs work by having the guest write to the rdi
> register, then perform an io instruction to exit to the host. The host
> then reads rdi using kvm_get_regs().
> 
> CPU registers can't be read using kvm_get_regs() for TDX, so TDX
> guests use MMIO to pass the struct ucall's hva to the host. MMIO was
> chosen because it is one of the simplest (hence unlikely to fail)
> mechanisms that support passing 8 bytes from guest to host.

Uh, I beg to differ.  Stop following the GHCI verbatim.  The protocols defined by
the GHCB and GHCI specs are horrific, but necessary, evils.  They exist to define
guest<=>host ABIs+contracts so that guests can communicate with hypervisors,
without massive fragmentation in the ecosystem.  But as mentioned in an ealier
mail, KVM selftests don't care so much about ABIs and contracts because we control
both the guest and the host.

The GHCI matters only for the guest<=>KVM contract, it matters not at all for
guest<=>VMM communication for KVM selfetsts.

Simply set RCX (the mask of GPRs to preserve) to the maximal value for _all_
TDG.VP.VMCALL invocations.  There's zero reason for KVM selftests guests to hide
state from the host.  Then TDX guests can do port I/O and pass the address of the
ucall structure in RDX, just as regular guests do.  I.e. there's zero need to
change ucall_arch_get_ucall(), at all.  We'll want to modify ucall_arch_do_ucall()
so that we don't need to wire up a #VE handler for every test, but that's easy
enough to do.

Side topic, that's also one of the easiest TDX selftests that can be written:
verify the TDX-Module and KVM honor the spec and preserve registers according to
RCX, e.g. that KVM doesn't clobber registers just because they're not defined to
some magic purpose in the GHCI.

SEV-ES+ will need to come up with a slightly different approach because there's
no way to automagically expose RDI to the host, but that's an SEV-ES+ problem.


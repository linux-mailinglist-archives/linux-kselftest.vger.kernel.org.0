Return-Path: <linux-kselftest+bounces-45544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4F3C57D9D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B225F3AE192
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC9023372C;
	Thu, 13 Nov 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txJkF5FT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98821D3F3;
	Thu, 13 Nov 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763042076; cv=none; b=uP+zi14Gq+Z15wttsGfoNJCptv+GncSNyucBk4xQM9DgLM7ienpNua89ZR4sNEM1wXTHAVd2aX0H9rliQhGLPjfOKlS7cSEa11Mzz/JZKa5Q4uQTy4sTaYQam6YsydMAlzNPupnqJiJBoK+VSmalfPFoa/J75gHcoFuRJ122SRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763042076; c=relaxed/simple;
	bh=+eiYuQTlJMcgq/um/mZzzKGyhjmsIRw7x4ekIWvmY/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQN33V/A6HJhLytYsRW2fL9uflF0Se0MmjGqXcxv0JeE9PGMC9pjBC13v4ECRZiodExfPOG3Jqq0XnMxzJD/MNshK+vbWNZPQaPmRpMMdt68ykfKmqhQRXY9jPvCNFk20Yg7KAlZ8uwaS/0s/8QTD+Hlb0DTl32Qv2e+h/cMrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txJkF5FT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40204C19422;
	Thu, 13 Nov 2025 13:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763042075;
	bh=+eiYuQTlJMcgq/um/mZzzKGyhjmsIRw7x4ekIWvmY/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txJkF5FTgucRclDGl/+nRNJi8tlfSGLE4+IQ9ck78w9qoy9Th7UppRKQGB5QHsYgZ
	 LRC2bLqh4G7rf/o33v+aCv3LApwXMQNb5Y3GsBDqRjuNeDWP2TGlyq/ShP6grhAckk
	 XIJUeEpmvalPFJdjvq6CmUBD5njyBiMEEn7Q8Q3+iP8qdo6ZT5Ose/qcp/txA14otR
	 Ne5b4FbsDVOPXQouMDOaMQUxub3Xl6U2ww8uXC+yIpC33UEMEOgdzvoq8mKulRdet0
	 J8dhLzyKxMgfNgyVdmSTtjBc4fUgFr5k2gbFxjL9hh1W29sJriI6qCgMdUQ6Ll6FIo
	 vLDyjHVViO50A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vJXmT-0000000BIvM-18qS;
	Thu, 13 Nov 2025 14:54:33 +0100
Date: Thu, 13 Nov 2025 14:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, maz@kernel.org, 
	oliver.upton@linux.dev, duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	vsethi@nvidia.com, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
Message-ID: <wuuvrqxezybzdnijarlom4wvxlfgzgjoakwt7ixittz2jb4mal@ngjvq2rrt2ps>
References: <20251013185903.1372553-1-jiaqiyan@google.com>
 <20251020144646.GT316284@nvidia.com>
 <CACw3F528D6odL3MJWb28Y4HVOLo56tMQXBpvti5nhczdpMxOdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F528D6odL3MJWb28Y4HVOLo56tMQXBpvti5nhczdpMxOdQ@mail.gmail.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Hi,

On Mon, Nov 10, 2025 at 09:41:33AM -0800, Jiaqi Yan wrote:
> On Mon, Oct 20, 2025 at 7:46 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 06:59:00PM +0000, Jiaqi Yan wrote:
> > > Problem
> > > =======
> > >
> > > When host APEI is unable to claim a synchronous external abort (SEA)
> > > during guest abort, today KVM directly injects an asynchronous SError
> > > into the VCPU then resumes it. The injected SError usually results in
> > > unpleasant guest kernel panic.
> > >
> > > One of the major situation of guest SEA is when VCPU consumes recoverable
> > > uncorrected memory error (UER), which is not uncommon at all in modern
> > > datacenter servers with large amounts of physical memory. Although SError
> > > and guest panic is sufficient to stop the propagation of corrupted memory,
> > > there is room to recover from an UER in a more graceful manner.
> > >
> > > Proposed Solution
> > > =================
> > >
> > > The idea is, we can replay the SEA to the faulting VCPU. If the memory
> > > error consumption or the fault that cause SEA is not from guest kernel,
> > > the blast radius can be limited to the poison-consuming guest process,
> > > while the VM can keep running.

I like the idea of having a "guest-first"/"host-first" approach for APEI,
letting userspace (likely rasdaemon) to decide to handle hardware errors
either at the guest or at the host. Yet, it sounds wrong to have a flag
called KVM_EXIT_ARM_SEA, as:

    1. This is not exclusive to ARM;
    2. There are other notification mechanisms that can rise an APEI
       errors. For instance QEMU code defines:

    ACPI_GHES_NOTIFY_POLLED = 0,
    ACPI_GHES_NOTIFY_EXTERNAL = 1,
    ACPI_GHES_NOTIFY_LOCAL = 2,
    ACPI_GHES_NOTIFY_SCI = 3,
    ACPI_GHES_NOTIFY_NMI = 4,
    ACPI_GHES_NOTIFY_CMCI = 5,
    ACPI_GHES_NOTIFY_MCE = 6,
    ACPI_GHES_NOTIFY_GPIO = 7,
    ACPI_GHES_NOTIFY_SEA = 8,
    ACPI_GHES_NOTIFY_SEI = 9,
    ACPI_GHES_NOTIFY_GSIV = 10,
    ACPI_GHES_NOTIFY_SDEI = 11,
    ACPI_GHES_NOTIFY_RESERVED = 12

 - even on arm. QEMU currently implements two mechanisms (SEA and GPIO);
 - once we implement the same feature on Intel, it will likely use
   NMI, MCE and/or SCI.

So, IMO, the best would be to use a more generic name like
KVM_EXIT_APEI or KVM_EXIT_GHES - or maybe even name it the way it really
is meant: KVM_EXIT_ACPI_GUEST_FIRST.

That's said, I'd say that we need an implementation on a real userspace
applicaton to be able to test it (rasdaemon being the obvious candidate).

In order to test, the better is to use the new QEMU code (for 10.2) to
allow injecting hardware errors via QMP.

Regards,
Mauro


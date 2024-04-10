Return-Path: <linux-kselftest+bounces-7547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53A89ECBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91038282AF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA47813D296;
	Wed, 10 Apr 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h1g6Sn7v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C08BE8
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735685; cv=none; b=ExTPd9VgzsRID6HztS10zSg187TgIQWtIaKQTgenc99USI6+7/mUBkJqq5OMevb8bWRGkt00iUWxrjcBPJ26SgLxOqjeyR/OYrX21tJELIoo/p5WmOa1959x1MKYM7Nx/N3YAPZVxHTwMsdNXbjcY6hC4rcNkTfO8rALTd5LtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735685; c=relaxed/simple;
	bh=Jd2c0Gd5Zw/HS1VgNj6UNoKrZsDEbPpFbAV2PSqqRvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA1gm+o7bVv0vF2L20izi6AGDb/82VLUCsC5sv+c+qfS+A6zEWTVm3U/QO1vnsZ0FpVHFB0io2bXpBQTRbpLdDdDCVK2AaIVDU2UO7CnNiQw29UKKWd7YnB5hBFyimDzMnuc0M0IcdNETt0b2zbH2YE8PndQWZVTxNBP88++yRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=h1g6Sn7v; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so3756602a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712735682; x=1713340482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xT4TfO1sl44M/nt04uaJynnbnIHdAjwI3dACDF2EjZU=;
        b=h1g6Sn7vovUYnFftOWYNTLp1UEaxGsxEGF70w9VdgXaQ31EktSCxeEsgiHXMQMeSfW
         c5MBTI3xKWvIMDH48XoSSpIcNJzvXSGEOEQuNy5LLAxUyCGWR7xRSw/dN57Y3vg3kMYy
         4Y/eI8s1fVqmDnlJ3sGg75ZRDBxGX/0COguZAu3ateC6VxKFCO1CDk720UExuSVrdZ/C
         TqFNk7pSgp5Z7a31LPjSW5UFtFEAAjIxD4zKCrWFllw8FNTY2f6blVnGlaEAkpEgbznE
         nhgaLAoiNFwn6z4iqF5Ew517ahVdmdra1iM2IsuHHyfqAUMEQ29m4d6c9k6OEeU4OxX4
         IUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712735682; x=1713340482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xT4TfO1sl44M/nt04uaJynnbnIHdAjwI3dACDF2EjZU=;
        b=m9DLzgQn+qYdoGCmNzpq+ZNBQK8Aw0YAbtHKxurV+91Zz4C3O1o+4UTQd3kse7K5d8
         EzomdojmcLsR91goIVDJ6g8xlH2iEbJiBvFpDEDeSUX2I6gpQt0kPUuvt/M+1bwwfouP
         ViNoGTOXVUwbH5OQ8QhbblavMx6LlAJ5VRQgbRORtOEpx9U9Mj+XO8B8BAnEqt2MFSXK
         wUgGtrV5wMuTjrz9nCrpMefykq8UhDwgtz+ATlOKqCFofOimFuC4V7H2t+yLFKOyl4Y5
         O1lyRETIwjR4BmNsQJv/Yfm3MAbRlK9kksh0yJf1KDyxvVe0Il/vtvafaKOdJNoqAoO6
         3IUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGnsUPhOH62OUR6oeFJs+C6QSU+T0nV1tT7STwqZQqsYwRm4MQV0to7g/w2CDFSPHABM3AOSnLuJppZBo2RsEy5owen78RVcdUwf03/3Tx
X-Gm-Message-State: AOJu0YwPbVZJ2ju2/2k7GPWK3qcTv0K0ezl9TnFfyTUJV9P84PuoC8Ff
	IYvCjYuPc21kuQc4B6qWpQim68wdYlYNaTt+/w/wGZJetFugNdiw6Pcvkwz385o=
X-Google-Smtp-Source: AGHT+IHRLBNWYp5osm4g2tE72KL50pB81DvbKh3OKFJcV5WdtGMoowG4LIJqFVgVawpLvyMudGgyRg==
X-Received: by 2002:a50:8e54:0:b0:56e:3293:3772 with SMTP id 20-20020a508e54000000b0056e32933772mr1082442edx.29.1712735682410;
        Wed, 10 Apr 2024 00:54:42 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id x1-20020a056402414100b0056e307db93dsm6132199eda.86.2024.04.10.00.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:54:41 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:54:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Ajay Kaher <akaher@vmware.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Alexey Makhalov <amakhalov@vmware.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Juergen Gross <jgross@suse.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v5 21/22] KVM: riscv: selftests: Add a test for PMU
 snapshot functionality
Message-ID: <20240410-f46f91518afc0e151f375a62@orel>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
 <20240403080452.1007601-22-atishp@rivosinc.com>
 <20240405-4e840120e8117c286cb593f9@orel>
 <8748dbed-d105-4f26-a808-667c3b56c8ec@rivosinc.com>
 <20240410-2a41e43624596a442d6a95cd@orel>
 <4a428500-4e37-4e7d-968d-3da20dd822af@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a428500-4e37-4e7d-968d-3da20dd822af@rivosinc.com>

On Wed, Apr 10, 2024 at 12:28:08AM -0700, Atish Patra wrote:
> 
> On 4/10/24 00:10, Andrew Jones wrote:
> > On Tue, Apr 09, 2024 at 03:52:40PM -0700, Atish Patra wrote:
> > > On 4/5/24 06:11, Andrew Jones wrote:
> > > > On Wed, Apr 03, 2024 at 01:04:50AM -0700, Atish Patra wrote:
> > ...
> > > > > +	probe = guest_sbi_probe_extension(SBI_EXT_PMU, &out_val);
> > > > > +	GUEST_ASSERT(probe && out_val == 1);
> > > > > +
> > > > > +	if (get_host_sbi_spec_version() < sbi_mk_version(2, 0))
> > > > > +		__GUEST_ASSERT(0, "SBI implementation version doesn't support PMU Snapshot");
> > > > > +}
> > > > It's a pity we can't check the SBI spec version that KVM is advertising
> > > > from KVM userspace. Normally we'd want to check something like this at
> > > > the start of the test with TEST_REQUIRE() before running a VCPU in order
> > > > to generate a skip exit.
> > > > 
> > > Agreed. I will send a separate series for that as it is an ABI change.
> > > 
> > > > (We probably should allow reading and even writing the SBI spec version
> > > > from the VMM in order to better support migration.)
> > > > 
> > > How that would work for SBI spec version write use case ? For migraiton, you
> > > can't go back to older SBI versions in the host. Isn't it ?
> > > 
> > > Considering this case your VM is running with PMU snapshot as the host has
> > > SBI v2.0. It can't be migrated to v1.0 and expecting it work. Correct ?
> > > 
> > We can start a VM on a host with SBI v2.0, but tell KVM to tell the VM
> > that it has v1.0. Then, the guest shouldn't use any features from SBI
> > that appear after v1.0 and it should be safe to migrate to a host with
> > v1.0.
> 
> That depends on when the VMM request to KVM to change the version.
> Most of SBI implementation checks the SBI version at the boot and
> enable/disable
> feature based on the SBI version available. If the SBI version supported by
> KVM changes
> to an older one, the calls from VM will fail unexpectedly.

We have to configure KVM's SBI version before the first run of VCPUs,
just like we should make sure ISA/SBI extensions are configured first.

> 
> > A more likely scenario might be this though:
> > 
> >   1. KVM userspace checks and captures the SBI version of the host where
> >      the VM is first being launched, e.g. v2.0
> >   2. The VM gets migrated to another host which supports something later,
> >      e.g. v3.0, but to
> >      - avoid possibly confusing the guest we tell the destination host
> >        that it should expose v2.0 as the SBI version
> >      - allow rollback to the source host without concern that the guest
> >        has already seen v3.0 and started to use something that the
> >        source can't provide
> 
> This makes sense though. As per my understanding, we should not allow
> modifying
> the SBI version that is less that the version VM already boot with.
> However, we can allow modifying the SBI version that is higher or same as
> the VM booted with.

Mostly only 'the same as'. Higher might work, but it's also risky since
there could be guests out there which capture the version on boot and
then for whatever reason do sanity checks against that later on and
freak out when there's a change, even if the change went higher.

> 
> I can't think of a use case for the higher version though.

Maybe only for a coordinated update which uses kexec rather than
a full shutdown+boot cycle, but I'm reaching...

Regarding a full shutdown+boot cycle, in those cases, we're usually
free to make changes as that's the same as a host kernel being shutdown
and then being boot again after a firmware update.

Thanks,
drew


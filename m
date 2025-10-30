Return-Path: <linux-kselftest+bounces-44465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49AFC22BE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DDF1A615ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 23:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AC2E8B97;
	Thu, 30 Oct 2025 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYuRVYaI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1982E5B2A
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868546; cv=none; b=FcxkuP5Mu8nGhkVJlOj/yHju86eFjiww8i4sw1NRLNy4fRfG1Z3Y8STN2SniP6BX4n16424z1zQTeOZwppwTmVmJlsqmBYazQWJqNUDG30BYDJHs49r3bBdVjI2V2zGLp8Toqgn9SdqJgGFgcgg3JHcmXOozymQwAny3udasHtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868546; c=relaxed/simple;
	bh=9N4BK/XLcE+ggWQSPh2OE6B/kuSx/xAv/EPxSXN1nTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOeOy0uCpKK9iZj5IqABUolMP6snVOVLVvHj1gwmZ6nn2EpB0xkSqrm2w269XE6oeDecQubAfzDygV+/3IB9tZ9TRNvRZ+nl6jXIzNKzAjgtHfpeegDCpmmgKVU104ayUkJNXCWbD+qmwd9PAeb1RL3c2pb/6H1GlwQAOkSe56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HYuRVYaI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781010ff051so1372293b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761868544; x=1762473344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaAYwU29hsaKuSwildYHugSsHqA30wW10v1jS2K4RlI=;
        b=HYuRVYaIth3ycVvaHO/Zo+Mi7/2njsR3ycu3o20P32DgNNGOnJaXzuw1P9MIxmW4qj
         XQRKWuF9OZZNSq8A0Zczks3gpfWRkA8CMmbr30IqiqQXY3VyYLkK87hD84TaLm/495mG
         yShHCbBr9sFa+raw67xgaTnw4oblBrSPvxOZ0mgJDupVZfmoM8RijasEz0l2nHqF7G45
         OacVnzW5MHtlvmGp9XXz5DQGPdmP/C13BZ15xnuAoTkO0PkTMU8pfYlCwsPIRorFk8ti
         tXeKAxGn9be4vEWIBlaCatOhEe4y9Z71mdoRqkBtQci1YXdvfkZ/47J9GIG/dgYN70TJ
         wytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761868544; x=1762473344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaAYwU29hsaKuSwildYHugSsHqA30wW10v1jS2K4RlI=;
        b=J3uYON5CdtNE+DX/8hByAzQ6iuN7LgdvYVT5RAaqv/lJf2g8oL0pZtwSWLGUqSU6eh
         vdjqfG5gx3VwqWH2J7811dx12YARxRUQcY186g6kb2ccf+C2Nfi/G0zcHntG4pbFcrp/
         iMcHjFsbc47y9o5OsoIxyP1x4fSIWPUHpaQ87ZTObDUDN2aLZp0RfYCC0luHRVqnUElG
         XvFbKA/DScYa4RHvy5aoipgZph5I3y3RoMPhM+HTYS9Yf0acKPQ3lflfSIZqKZU3daFL
         QsDNTm5XYdW5h66+qIIHGURw/HRoRLCtCyO6YatSn2UlFTimfQ9QqVDMpSHwtJJyGhQZ
         EpmA==
X-Forwarded-Encrypted: i=1; AJvYcCVRAvneyRgrk8tVXC8p6loeD3D4rCK4dWaEH1awyKXutcdK/AVzH1nUiwwFpX+QBXmHL3tj5iyPaVwyIdjfKxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAYc2xb3FbPP5dVPD4nL5imizFJ3p6HdFn1anzwcZ5mHOV979
	/by7EXbKySNhb5zDm89zyQceQrv6e12d3fdLYTGKYO1/NNaLfMmOYfbZhCtLAo00YA==
X-Gm-Gg: ASbGncurdO7qnEGcruGwednk9hEQCbdHvQgzfjyrPJ1rGphgDaZn56j6L7k2uD5g13N
	WK+FYr5HUO0tK9k/JBTmQq7/yUDv0Q+W+dvI9KWzxmG73J44Jm/tk8KEyJ+8w9D/B/Y8WN25Xz+
	MJZfHWVJ7/zmYiSdVUkJ2uJcU5xgOiiH0hoZiZPsEnMZv3ipjQ2DXUSNB/LP7HurCjEwcYaAG1R
	CHwe6qSv7hRO6c7rlPEKX57WRYPSlMaO9uVYRDc2NC5SCSXHxHHBPCbVxNo2faIsaTfwxcDGLQg
	w7RqzY8zCPDboiYxtrBa8OB9WrQrJt8OTHaAhH7iPQbKYt9J1Briwvz2V/swO8Xoycu+ZFXAVCn
	16cnE81TvI6B2YSG7rNcYA2nhAkSvbTzUFASdE9LTvIVeknAsygvHwoIQV4jA5mkZe/nOvO+qzV
	t/laY4Qy0sZb4WmyrDMtyXHRWsSEViYSn1M+pHn8vX4g==
X-Google-Smtp-Source: AGHT+IG56aLk8yrGeGgCtbaq6Yw6OAF6BI/qwUu0DvvYH8sY78VAIY7D5Q0G9DiuTt9gFFUJZqenoA==
X-Received: by 2002:a05:6a20:12c5:b0:347:63e4:770f with SMTP id adf61e73a8af0-348cbda97bemr1956015637.30.1761868544009;
        Thu, 30 Oct 2025 16:55:44 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db09f362sm28679b3a.38.2025.10.30.16.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:55:43 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:55:39 +0000
From: David Matlack <dmatlack@google.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <aQP6-49_FeB2nNEm@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
 <aPSeF_QiUWnhKIma@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPSeF_QiUWnhKIma@wunner.de>

On 2025-10-19 10:15 AM, Lukas Wunner wrote:
> On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> > On 2025-10-18 09:17:33, Lukas Wunner wrote:
> > > On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > > > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > > > linux/pci.h so that they are available to code outside of the PCI core.
> > > > 
> > > > These structs will be used in subsequent commits to serialize and
> > > > deserialize PCI state across Live Update.
> > > 
> > > That's not sufficient as a justification to make these public in my view.
> > > 
> > > There are already pci_store_saved_state() and pci_load_saved_state()
> > > helpers to serialize PCI state.  Why do you need anything more?
> > > (Honest question.)
> > 
> > In LUO ecosystem, currently,  we do not have a solid solution to do
> > proper serialization/deserialization of structs along with versioning
> > between different kernel versions. This work is still being discussed.
> > 
> > Here, I created separate structs (exactly same as the original one) to
> > have little bit control on what gets saved in serialized state and
> > correctly gets deserialized after kexec.
> > 
> > For example, if I am using existing structs and not creating my own
> > structs then I cannot just do a blind memcpy() between whole of the PCI state
> > prior to kexec to PCI state after the kexec. In the new kernel
> > layout might have changed like addition or removal of a field.
> 
> The last time we changed those structs was in 2013 by fd0f7f73ca96.
> So changes are extremely rare.
> 
> What could change in theory is the layout of the individual
> capabilities (the data[] in struct pci_cap_saved_data).
> E.g. maybe we decide that we need to save an additional register.
> But that's also rare.  Normally we add all the mutable registers
> when a new capability is supported and have no need to amend that
> afterwards.

Yeah that has me worried. A totally innocuous commit that adds, removes,
or reorders a register stashed in data[] could lead a broken device when
VFIO does pci_restore_state() after a Live Update.

Turing pci_save_state into an actual ABI would require adding the
registers into the save state probably, rather than assuming their
order.

But... I wonder if we truly need to preserve the PCI save state
across Live Update.

Based on this comment in drivers/vfio/pci/vfio_pci_core.c, the PCI
save/restore stuff in VFIO is for cleaning up devices that do not
support resets:

 648         /*
 649          * If we have saved state, restore it.  If we can reset the device,
 650          * even better.  Resetting with current state seems better than
 651          * nothing, but saving and restoring current state without reset
 652          * is just busy work.
 653          */
 654         if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
 655                 pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
 656
 657                 if (!vdev->reset_works)
 658                         goto out;
 659
 660                 pci_save_state(pdev);
 661         }

So if we just limit Live Update support to devices with reset_works,
then we don't have to deal with preserving the save state.

I will have to double check that reset_works is true for all the devices
we care about supporting for Live Update, but I imagine it will be.
They're all relatively modern PCIe devices.


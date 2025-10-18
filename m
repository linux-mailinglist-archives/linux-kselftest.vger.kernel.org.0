Return-Path: <linux-kselftest+bounces-43510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF0BEDCAF
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 00:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF814E1407
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E4B2566F7;
	Sat, 18 Oct 2025 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAbNi8cy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9914B08A
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 22:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760827996; cv=none; b=kRDROkLnLieLN7taEY9E6c8gMLb3glhbtD2t7e6CkdGE6U6LT+J4vC/T9mhWGNiYrSQ69cr6+K4dcsHknEvrexOH7bHw5Cp2C0GSzRSi3+WtRggLPmQz0E7a+8jAN7cQlHujHHrBB6e1sotVIaeCkUygMhRpyZ6wWowWf1hQ3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760827996; c=relaxed/simple;
	bh=7qLVYcdBi8bpEpnS4F0eADPD2Bf5b4Eo3btCpBmFKVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiuccKdIhRB9RM7PqizTIsoYOcJcbY4OoS50WwRoHcOkIbrB4Bn1oHwUyGz4C2v0SpFpJWBLbvCV15IcNbxn+ttffggSXLAWDeHph47OfCpCVo2+JG7pMgii0NCyqiG0Q2YD0EetY39Mhm1JdNwZgLuXk2T1xpEx3nkpd6knfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAbNi8cy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d67abd215so155245ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760827994; x=1761432794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExoVcTIek9AdjVCMkiYpZILDA0YvBh98/+0VTxUThlI=;
        b=UAbNi8cyjQbjrZyXCTT4a8vAp+AHgWvBfwiir9ZAZjgl1sA3IJj/GvQI3uf8xKsIXM
         lwL8tt0xwwordOaFzkyxegDoovfaXTshVMyFD8oWeZmVLtDhik0U2lcIRq15Dr/LejDq
         snj12IfKQSWfdL5LKVfhXhLE/kAbt6tqzMtOijBiv3pOIeAk0QfXKjmaWBI2Tepg3QFy
         MNxAtm3zcrMgyeCeyodHMq1o48Tvli5QY+z2z1hjktBZJsklS6bZ7dosbbrpApGUB/1E
         ET/hFglPHZzfOfygTVWCPR8kf2gv3DUBA7DigMaY5sGxaOa1kh1Hfxb/ImgVw0794oDG
         rcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760827994; x=1761432794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExoVcTIek9AdjVCMkiYpZILDA0YvBh98/+0VTxUThlI=;
        b=C84g9LxGYigC1pN6dF1L+QqU3J6w2cIDNNAbyhaWE2oOgQEiDWO/SeHuxeH8Gyr40q
         vavR8dOzrBqE/A1xcYbgropy96Tp/pxLKt2xxsAk5dCufEFOHh2QpGwt93KKgcUGoURZ
         hS/1DnJRyjCEpmmotrZiXwBpdGkj9gPrho/wInNROwkRunQfRFKF3YLJdFyTLlchwQEk
         gMYJBktzvBabvPL2E04T132clobdsxmQ0r9h2WQCuZqVPafxiAxKuCIEwDSN6MsKmNB1
         PH4AP5eZub2rNd2XqoeNOc+PqABpHOwI8Y/YXh4OjIS8bqPTo+5Y52OkTbaXcu/9TaKs
         ZmIg==
X-Forwarded-Encrypted: i=1; AJvYcCUsGwMthl4uKa5lZbHTXsp4el/CwjC3xhYabPI5kfyGrkzE2cWaInCGrjrVV6rJOX0UuF6pswFV6Tk9aOVaTUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpaW/1RbqDNTE45ST2qOKcwnMCDaQBT463H3syyqp8cYQFEo7l
	OlntvsqWzcU0oQyVB+fWqEVOy9REbz3GsgfKzZo0yzK1+Bw8Zf8RSH8hqBGQki7O8g==
X-Gm-Gg: ASbGnctuUHg4cXcLRqPukm1QIF6ait2beocw8WngVsKawwoWPG7apEoQuAr03PV5cXT
	orZwjsmG+PAHH9i1ze/tJ/Wv4XACrGLrYh7O/9u0zBEti2yEHmHhk72YUZvndCFi+ZkQzJi8a9Q
	kL5KYKac5br1zGovEeN/xc0gQ0tQmuPan/rkJHQjMx3dbjGk+F/1P1vsKIj3tvLKkchze5ICtLA
	sCUSIaxCWlJR7deu8xPh6ITobjqUwGjjvBIhMJYH1+0M1ZNoHhnwOIZFk7j7V5fz8IoH/WwGscz
	BU7JMGIAJKE3FmmiNe9mmEpulzdWztOcF4DN5k9S2+rY84w3bdwP0zbJ3fIWPAwdwiPDiv5Nj4B
	Qj4vV/71iq5FGz31BAtdc7SjPDyZqbdNn1jnbZI25BKd43UQOj3i+8XqtCwvW2UqkXG/d/q32Li
	ilx6xOsP7AdXzs9AkPQlZcJGEdIz1MxDtFj++f7u1pGJvM7OM=
X-Google-Smtp-Source: AGHT+IHYSWZKJqORVU2MlERhdd7pLQTU+bgumM/RJ5rxntS44MT/2pojFpL/YQ8TyquwryI9b7dpMA==
X-Received: by 2002:a17:903:380d:b0:26a:befc:e7e1 with SMTP id d9443c01a7336-29087a1668emr19722635ad.12.1760827994094;
        Sat, 18 Oct 2025 15:53:14 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a834de75bsm1268723a12.12.2025.10.18.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:53:13 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:53:09 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, graf@amazon.com,
	pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 00/21] VFIO live update support
Message-ID: <20251018225309.GF1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018172130.GQ3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018172130.GQ3938986@ziepe.ca>

On 2025-10-18 14:21:30, Jason Gunthorpe wrote:
> On Fri, Oct 17, 2025 at 05:06:52PM -0700, Vipin Sharma wrote:
> > 2. Integration with IOMMUFD and PCI series for complete workflow where a
> >    device continues a DMA while undergoing through live update.
> 
> It is a bit confusing, this series has PCI components so how does it
> relate the PCI series? Is this self contained for at least limited PCI
> topologies?

This series has very minimal PCI support. For example, it is skipping
DMA disable on the VFIO PCI device during kexec reboot and saving initial PCI
state during first open (bind) of the device.

We do need proper PCI support, few examples:

- Not disabling DMA bit on bridges upstream of the leaf VFIO PCI device node. 
- Not writing to PCI config during device enumeration.
- Not autobinding devices to their default driver. My testing works on
  devices which don't have driver bulit in the kernel so there is no
  probing by other drivers.
- PCI enable and disable calls support.

These things I think should be solved in PCI series.


Return-Path: <linux-kselftest+bounces-44182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE4C14D81
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 14:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0511B2818B
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA87332900;
	Tue, 28 Oct 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K95auNhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24B3314DD
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658140; cv=none; b=Kklu1OOZvdSK8Sa6v4pFFieE+d8XuXSbpoQcUmPGAJHm30Lr0m7bioDjnPo5oxQSnGh8cwwnWjSrv9nlfN0u2+UnbHOJ2I+KDQnDhENyxxysRk9Zc43CrJCzSncjlE6065EHM7U1oG1MWqUJD9TE6+Q5X4obHtbGDzvEcWl0mVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658140; c=relaxed/simple;
	bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1ehZdP+RKCK2a5RVcJO+Uv7p6Gw2D/7IuVnplJV+hfxuoXJCUUqxoINnh2PcF6pAyJVz8L5Bxgkdt0m5DkvEWO27h6NZyvS4a5JkO5wAZsDw8NrwvpXH8uVS3PNABFIttW3gyj8fPwYilbRj0/i2/VcYZukfbv6Aw/2I+XQcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K95auNhv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-89e7a7e0256so470347585a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Oct 2025 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761658137; x=1762262937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
        b=K95auNhvrSFR6PPDg2ibB+mdTp2motrPFwy4va//VFphBGbf/4LZapakAXGoOkez92
         +AhFNhjlkgSbj2HMewM0Dat39X0k7WeXiUlhUIX+BSs49FIoqxxs1QjxEt2dQLPv6SCQ
         bLvy0Rbo8HeAM+TxfWfHlBGlE8Xhouu3jsMCc6LWd8NVW8c00G/buUgePHr4ZjTt4WGE
         B8vDDf7tawyGnwMDnI9CpypUocmYloFMI3NlNOA4sQnCmqD+G094F+7MFS9BHtgWdh0T
         9FscgUMGPE9hiPXfDsLqc85DmN3rfWgzEcOekZ3IQne1k/cWy4aDNSWFfIGosHxZ2gOD
         RAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658137; x=1762262937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
        b=hAIgEWdzszvhJMLuLj/62WoZAR69d/xD37Ta1WC4LJejKTjfxuUEa/VTUFMzLZUdXI
         EFdM/4BLF/wcIgmREBnvfNAGjyk5KWkhwlp0GPvQm4zSOva+F3NY9necbr1RMz3RHbrt
         Q206eK/24mne0q9zogUGyFwRUtD8oNxm73RqfhibfKbacg/OCQyUlw9DGm7daJeWGTin
         OEbdGJSv40q6uER7nDRv1kBpNUg8HvB5jkZKiVtWuOHZ2TM+FC1LsyH+QiazB4Tan3ta
         Fm2shGghhxDORhyEwAA0bBIWWIs3vA7zNmKoVBMOlP0D/DJyWwqVWVr5PQF7kUqw9V7v
         Jrog==
X-Forwarded-Encrypted: i=1; AJvYcCUbRCdStkyEpXrVcdd/18KQiYaW1SNHrVZx//ce9yOLC5kByQpobGdWd5Ge6HLvJKT6R44qE0Bt3feU9CvpatE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MMA6p1YvnazKYxHG9EIe6/b2+G9qsMJdP+pBkWofmUy0Kfcp
	jZIoY6NOWte+k5ldVDrgWAl0654dEnzb/642TxkJ4h66ZPmLiLJ1Jo5zvl3+xGUIAMM=
X-Gm-Gg: ASbGncvYjSUP7U9eeMvF7FFW/U/0qrh/MOaIIHQu8+ZBFsaAWCD7N4qpqJkwIXiVoHL
	BE2QUTEE49NAHAgJUBUB8RuEcW+sw9x6OtLlYOE9Oiyp8uW8hq1A3DcA3EFTWblCQ2pfEDDpvkW
	T9P5b4GtTPeC5iXF++8iGdgG/9yRUiDWFlyKMcu9JIsIuSMGy0gMfQXbSDYtgTF+09CMDJyMoHk
	M1HhfuKtc8h4MYb40M5SC+o1NAWGWuKik4Njp8YEAMYvFwJfM1ZZaIUppZe3FHbmW5FCD5fG2fr
	fyezQ+2iZQuijydZDnDeOiNl697gwP6+xS82NwlGgOLT9APnXoVNrmGd8QJsb5ZZQqWq0Lju0HF
	dqm1KjPDg4ZF9aA/RdeN36by9hJQoI6ZoauB3ReuB6Rpl0gyAjz/yKQPy/BLpIdjTP8kGQnmh+b
	juFW/Pv1/rKreHc7SWz1ivrAXIYUWWve9f3uceGhXT2l3W2yfbEmpljL7X
X-Google-Smtp-Source: AGHT+IGShJMC1iBLkVMVTtmAgFjNgDYF2kS2KrAPaxSmW4rJSZvLRhN0tZlnppqE/frY25q7IEUPHg==
X-Received: by 2002:a05:620a:462a:b0:8a5:6ca3:d56 with SMTP id af79cd13be357-8a6f63c48a7mr436299885a.39.1761658137149;
        Tue, 28 Oct 2025 06:28:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd5617sm829595185a.19.2025.10.28.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:28:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vDjkt-00000004PA5-0Sy6;
	Tue, 28 Oct 2025 10:28:55 -0300
Date: Tue, 28 Oct 2025 10:28:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <20251028132855.GJ760669@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027134430.00007e46@linux.microsoft.com>

On Mon, Oct 27, 2025 at 01:44:30PM -0700, Jacob Pan wrote:
> I have a separate question regarding noiommu devices. I’m currently
> working on adding noiommu mode support for VFIO cdev under iommufd.

Oh how is that going? I was just thinking about that again..

After writing the generic pt self test it occured to me we now have
enough infrastructure for iommufd to internally create its own
iommu_domain with a AMDv1 page table for the noiommu devices. It would
then be so easy to feed that through the existing machinery and have
all the pinning/etc work.

Then only an ioctl to read back the physical addresses from this
special domain would be needed

It actually sort of feels pretty easy..

Jason


Return-Path: <linux-kselftest+bounces-43633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1EBF4069
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 01:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 502074E93D7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D71E26B2B0;
	Mon, 20 Oct 2025 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zo6r6J4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB8C23909F
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761003032; cv=none; b=J1pJy0eD9OjamHQFk5BwBboVB5r/hwtGFG6EYitjas7Yirly0sxCzHlojDW2XTdt6b5asqPHJS2k/BDUZcwLBKRFBTUFO3CqSFXOhNTcjH+sThFeE/oSts631xuuresh8lUXwGb5YpKwX5iuH8E5GodAvgzRp97KrXNAKdRfJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761003032; c=relaxed/simple;
	bh=wBx5HU0NHsSDK23iXznXH3Oj8GG15Qr8iFROxkEtWPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6UiYPly6gJd/HNcMY+tbBM1322x6kExrcF7PV9GdTLfsA9OsBeo7ej7Y+QXNdFFZVeeoaraH+1/QQzqiBjz2ohLDZElLuai449YRXkf7yJS/OYINQYau5OzTTj1VGhWxdvJ34ueugqo6UOApZVN1d5Q0RuMV6PfpVdp5NAeGx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zo6r6J4A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eeafd4882so76425ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761003030; x=1761607830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2EojOJFcibgh1WcpC+qylb2gWt1s0H89duNTff3IMYc=;
        b=zo6r6J4AL4GIdCPnG7fdJSElKnv5fVxae3llaa3Z/Giwm6PznOJ28DnbcuUhb6bOPp
         3b5ZvLHz+R1mQtg2h0d6K+AF+nBje6kres9caqiHV15kuTJKkN6pfswEJ+TOUb6F+n3y
         Sm2zlj/uKfjxrCfyAmKQLlQPhvXEEWYZ7D+79YsPalj49vX9ERJ9gjo7s424ZlI/CAXN
         0HBzS0ynwrAgfb/9ZG2IwC5QYa2HHHZufcyh47u51lxmIizodz4pObTFsXQux5A3/2Wn
         ux8gKBvm3zZiZ6JW3yTmuR9xjqlVtF2tiMhyABvdgz4LIGymD3704/c42/D57M4+eEKo
         K3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761003030; x=1761607830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EojOJFcibgh1WcpC+qylb2gWt1s0H89duNTff3IMYc=;
        b=RrTiPD8HaTVkzLU7RZ1JNla5RXPFjab291XISDjGGpq1SzMb4v7HUJ87MRQpV/OXJ4
         xbo6n8FWtFTJefgom7YIB+zflsOQwFN1ESEg24ygnIYwlXNMgwx2KV0H6yVMm/mUI+4X
         f1xRYySPF0VUs47eo8sV9XRCudcLrIRglIKuwzkvKrj/dC7pDwt2P2ggW9sFE5//IPkA
         9YmrGq8ss0/I1/9ZaerbMITqK9FUCw+34jKTIVW486U/OQD6OUQh5YJlxHCvMCLx08On
         lL14sg27dW+WkBHRZ8TWoz0fNZttelXtLPjc2fwNU9itiaBePx0Ui5zF5TTyVdg61sJK
         bL4A==
X-Forwarded-Encrypted: i=1; AJvYcCUIYRm1pz2HP8BEBpUsfavmsBiYPSY9bUNafvp5izUGuAYbEP3oHfjnK0wSY/MgllJrjYNJ2XODrwMwJHCNv/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/WTW0r7f1g+YTbqRC/1SFk8xWjQfMHn3gkPtR60kR7QW72ck
	XrMdTCBo6LSlK2B9jd0mPA2Gfh1NznerZAnk7keOsh0fAR79Ucr0mCd4TTkT6I3neg==
X-Gm-Gg: ASbGncsS1HCd0g2nz0PUgPkYW1Pt4bBSkE8ilv3b66AtYYa8TesfdvOs04GkdXJyjIC
	6G+MO+xusYctFfuThWeKv9Y/osEU/gQN6PK4ILa/Vc+C4vMPPF2myuFCBie/32OVpzJCg8mgMdd
	onNNGlwuCZFDHDgrzqNgCeaiD+GCsdeCBel5ecaf0fD1MbV7uVeFuP4ZCU3e/3Z3kWSbhQetB2w
	eAX5ant1jLSN6kSbZ6NV+lpNTU5DWsUVtnB+0vY9JOhl1tC3eIr0tSqlFBUjhhKDQueYmAy84S5
	1tObzB3T/iMrW7Pq+T3ktB9pG9HI9hehxInV/uhpX0JFNvL0JxssLLu5NzK3P5eTwJQ+6QLmSMD
	FBIn3b7YpHDmh/axo3vjx01eupw9NDKSvIKyr4WLwr5fYrXOJ9G6xX+KAeTxG35SEoAe4Gj7Boe
	MMoLnWa51EZPUfSr3STPRuLMrqDovSiMZUCw==
X-Google-Smtp-Source: AGHT+IGp67st8Wnp6/nSJ8EGcvRTlOdg+o3GxZOASU21XsdtW7vuEAf7PH3lMWQNe6ILam9RRnzuAA==
X-Received: by 2002:a17:903:9ce:b0:274:506d:7fea with SMTP id d9443c01a7336-292dc92664bmr869085ad.5.1761003029542;
        Mon, 20 Oct 2025 16:30:29 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301108f8sm9508302b3a.66.2025.10.20.16.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:30:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 16:30:24 -0700
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
Message-ID: <20251020233024.GA648579.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018172130.GQ3938986@ziepe.ca>
 <20251018225309.GF1034710.vipinsh@google.com>
 <20251018230641.GR3938986@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018230641.GR3938986@ziepe.ca>

On 2025-10-18 20:06:41, Jason Gunthorpe wrote:
> On Sat, Oct 18, 2025 at 03:53:09PM -0700, Vipin Sharma wrote:
> > 
> > This series has very minimal PCI support. For example, it is skipping
> > DMA disable on the VFIO PCI device during kexec reboot and saving initial PCI
> > state during first open (bind) of the device.
> > 
> > We do need proper PCI support, few examples:
> > 
> > - Not disabling DMA bit on bridges upstream of the leaf VFIO PCI device node.
> 
> So limited to topology without bridges
> 
> > - Not writing to PCI config during device enumeration.
> 
> I think this should be included here
> 
> > - Not autobinding devices to their default driver. My testing works on
> >   devices which don't have driver bulit in the kernel so there is no
> >   probing by other drivers.
> 
> Good enough for now, easy to not build in such drivers.
> 
> > - PCI enable and disable calls support.
> 
> ?? Shouldn't vfio restore skip calling pci enable? Seems like there
> should be some solution here.

I think PCI subsystem when restores/enumerates a preserved device after
kexec, should enable the device and VFIO can skip calling this. By
default enable mostly does:

1. Increments enable_cnt.
2. Enables to bus master of upstream bridges.
3. Reset INTx Disable bit in command register.
4. Enables IO and Memory space bit in command register.
5. Apply fixups.
6. Sets power state to D0.

On a preserved and restored device, I think only item 1 needs to happen,
2-6 should remain same if device config space is not written during
enumeration and state is recreated by reading values in config space.

I believe this should be part of PCI preservation and restoration
series. VFIO can assume that device is enabled and skip the call or check if it is not enabled
then fail the restoration.



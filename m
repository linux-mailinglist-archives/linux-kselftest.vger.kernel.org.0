Return-Path: <linux-kselftest+bounces-46914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22066C9D071
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848283A93F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A12F7ADD;
	Tue,  2 Dec 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4tuE5iw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE62C11E7
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710170; cv=none; b=E6DR/U5fgtO6RSrvsEzO+QXPfeOQel3m43agqR1Iw0VpHr+fsLAPG2Uc2Ulh+yKbqJpntLSNeTGRVSMBEboNKnHNYcGSuOxd+Pajx3cySj7rrNkvJClmwj6AWM9j2iFLjfsc2J7pCrw2RHCdk0Xv+n8zPdjjm6ivh7nXQTXwN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710170; c=relaxed/simple;
	bh=psZAockS1smX2jz734Lq+oNYVMo3hSN9xQqCt2oRORk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeMDxqXSqsatUckTZv4PU/zUZVRZgkV08v6zc7126/1s4iB8cPBjcXVHhFhu4jsfhlQbm4MiUp03Kb+aMNz5o/D+vhGjp8m9GYu0LC/kQJ/hbPxgLhCdWwrm5pDeRFYEqteQN+cwtgqNTO10xFgGlaI9IYfiN2c7m3Vc+otpJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4tuE5iw; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-340ba29d518so3993468a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764710168; x=1765314968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6k+A4j7YgFCIkzTerT25SkFiFrWoSonSfbJHItUpuU=;
        b=K4tuE5iw/UPhRNBsNF1cx0XDlFMbr/Li5JZl4zvKXMRk2d4HRVc4nRpHH+vwrDCZBU
         3qtqNzOfucQtVmm2rGEwYmuZoTflNZgwoO+zd8ugFd7RtPfYjpyDoeZq1ll15LY4J/Ov
         9Z4uIEH+W+8ZEHGJNkB2pyny3DnlTg9c7N/12dyhgLJoVkvX80OYjJ/zkeOg6htJ88gV
         ovjB/Kf7rMYuIS73X8u8Cffw3cM3L52uVs+icGp3Hs4jzlst5cgdZLtK9GJIizY2VumI
         tEAdOuH4hBECZdRoU2UJTxI7F5KPWl/grf5Ax2UZ97mZYoQQnbsgBf7yW34WYi4CZCh4
         dVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764710168; x=1765314968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6k+A4j7YgFCIkzTerT25SkFiFrWoSonSfbJHItUpuU=;
        b=aHanuIi1mbsAqGFJYgR78HX4a9A6wg/e4r+Ss7DKlvBNgP6WONdOHUjeH6KudYJokC
         xHJSCCQmGklHZKL+jTojLtPgo121gE3R3GHWZcBosUMsVfmMwWLk5U/7dTh25BZ8TOo6
         3TIqygi9Zc3LwPv7atVkikUpfnpcByweHVLjgdGA8KhkHg15hxm0yrfbaBxX2pn/0RmA
         S+f3GkfaXQorDdbk37+Ztpc7rfzmV8sK+WPsSPWZq1p2y/DIas2F0PPKqLbI2aa67JRG
         VqundmqJNV1B+x+o1HLpDhTKBt5HFyhRn98enmvdImHNZaMEd4QmQrcZ9vXDmakLica2
         zo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9PfXPpmuLzfjEPXx3QrOIIx3AwCkaJCZG3Tiip8tzhOdOS4ft3ERwejLJcFD3ddR7TSDK5cA0VTIZpvTkXbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+/RzfzS9k3Wd3lDIWdju8FXr25LHvnhU4W4GhLpy4SmBrKAe
	Q8+AWD2B0sUoDwsYfeT3lFfNI8KOUFesI766yRQ/8idBSrbCoPSRlu0q3pvccoTdLw==
X-Gm-Gg: ASbGncszOMv5CFxt4UqZwZd1iRpPuWzbe1pc4m0xNgG/ClOLN93gQ1Eb7Bb4m1HFdfi
	cgfAtH/hnFjRVmdneVxUc2swRhGVRINjDLk3w+5paOC/Nmxu6DP6I99JHA7W1nixN8wpkV8AuXZ
	b8BMqntxl193nk2zOB5/CdU0spHb1sT6KU33CeihiGduQSU7nTOAHma1F+fPyIL9m8a4JPuUE3t
	C/ixT3DIFxAFzzCvc1PrBNXmQ+qjmAc0JI28m5Mw+adrmB7cVhibhNxreR8f8GaQGc8v5nwh06W
	OuCBGacc9/A9YWMKUfWvp7rVjfA5yy8CB8HkUVbQTNCdr9mOQQWUSg0NQmGexAnLOnoDtJJLehc
	zV6FfFcxiy9WchhdDvKL0dAyelEOF9zx5/mL6ve04fmD4Xtmk2WcAAdbBAJ3TsFzoj9yIMbvdFu
	3eik92lWYwPQmr5+OCU50dSbegpjVZbTeYzJlXKw70SqEchbQ=
X-Google-Smtp-Source: AGHT+IFJXXKi/z9g/exKb7UhaYzAGIOAf3+2xvy64dR1yHz7NR+ujWfrh1Xuyci/C1t+g660+I6Fuw==
X-Received: by 2002:a17:90b:4d91:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-349125ff915mr64801a91.10.1764710168053;
        Tue, 02 Dec 2025 13:16:08 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fb434e8esm15829923a12.4.2025.12.02.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:16:06 -0800 (PST)
Date: Tue, 2 Dec 2025 21:16:02 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 03/21] PCI: Require driver_override for incoming Live
 Update preserved devices
Message-ID: <aS9XEm96ifPd_ier@google.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-4-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126193608.2678510-4-dmatlack@google.com>

On 2025-11-26 07:35 PM, David Matlack wrote:
> Require driver_override to be set to bind an incoming Live Update
> preserved device to a driver. Auto-probing could lead to the device
> being bound to a different driver than what was bound to the device
> prior to Live Update.
> 
> Delegate binding preserved devices to the right driver to userspace by
> requiring driver_override to be set on the device.
> 
> This restriction is relaxed once a driver calls
> pci_liveupdate_incoming_finish().
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

After some offline discussion with Jason and Pasha, I will drop this
patch from the next version to avoid hard-coding a policy in the kernel.

Instead, for the time being, it will be the user's responsibility to
only preserve devices that do not have any built-in drivers that will
bind to the device during boot following a Live Update.


Return-Path: <linux-kselftest+bounces-43486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751ABED1E5
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009AB5E380E
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608251A9F91;
	Sat, 18 Oct 2025 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR2NUjUA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5A2A1CA
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799744; cv=none; b=DNn3b2YT9R9EILCX+hddJpr+kI4LtHKYvF589YbuF6KOs9svAm9gQ9vVwqjc5RU6qxbw8ju4zHz2MeJL9T2sqZTLuMDahC9EraJ246WTyoad7GvZM8zz4b3vntmfYevDV98c6YtuI1DqpEdptQjfen64JQwCIhgvxSVMubITlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799744; c=relaxed/simple;
	bh=GUccLFSXbotA/iDSpiMw+QMvX11XGngTX7WaLv4NefM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNZtpObGRlum5pa8Gtr5PUTjB1HYWrc8ZzlTaIZGrubOgWajpx3Nx4SgeWTrRkoN7LSkoqO4zNyLjXQJJ66eoXLH3IxAR7AyGGvCIG1RJmAI0mroo0URiFYsLP3eHMuT0qterbgC/rUfB3bZu+7g03sT3HJWp6o8lt1hnjnbnM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RR2NUjUA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290d48e9f1fso105665ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760799742; x=1761404542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlYuLpH1igkPNR16V+kXqlzDPd/shpYRQgfcrIfBZBU=;
        b=RR2NUjUAJ77pdrDHYOvN4jaSMOMgPnsU9ae663heVzNop2tUnTFkfEjCpMiFSWE3Xw
         KQKBSm4fXJZY6KAlphRul9mG1Wv9xepeQKbeTg1PjlZ4E1hNx3SIBu2gn+KE9OSzxxnZ
         y4YSWRGHHwp5GvdB6gk+0bM48MlkpXUTyjhr8wLjO/KAYAKm+Pow92X8dnSgiK0sP+IV
         Ddp0CPjUiqKTkFALCODS5LD4NtCQNEMgpaBv/ownu7uIwpb3TDm0JeKduGYCfnUBkB9j
         1XPydKmSIhjolij1FAyKEyVhkW2rjTY0jHUDswLbwXM0yDMGk1ccVQeUzWHphk7fUtSC
         QQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799742; x=1761404542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlYuLpH1igkPNR16V+kXqlzDPd/shpYRQgfcrIfBZBU=;
        b=w3BBphG4hhils+RABmYt3mSkg8H0QqfkMB8uK1pUmOPPg59V8ANfVJDAK00JhvoDzF
         PXbkJwLDLjSIWtx3E9ozoHAT3PS4bz5Y8hUpKHg7yL0z+I7s7QGMkLbHOJz02Q4Kr4Jy
         qJqKMomU5QFJ+0hGeX0RG5bBndx0lPNXtfAOyQozO9sm+qLCl8gWv91YGDfAJUPt8IEb
         2MT1oYarYKnO0uY2n73kLTDFW7OdU0rfarU4rhUuI1iF43VtpqiC2HMTo0xTFWyy5yAn
         6Ny96KrqeUhMysQU+7UYTzf7l5i3EcqX4WWAElGXJFYzVwAqNDDdFtDCHvGjxIT+HtZo
         Vyng==
X-Forwarded-Encrypted: i=1; AJvYcCVZnUfrE/ha3ha676WXTFZ3khg0z17V6D009CR7rHtJOHXVBA71Lfrkv4Qq3pOm8n9gU+3kHeMFnVbDUZTmxDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRcFL5A0Zsg7jz3OC16/sj9PljSN6OqYF0CG2vogKqcgOZEoF
	SSfxGGbRt72DQCbBkwtIYtJUkwgIMxZzpOjbxeWsZz+OklIESq+Uzu973PbfMZiBuQ==
X-Gm-Gg: ASbGncufovtOVTC4pyuKv3cSr1EykIel7QKgE7/daks2LSrYeHOgzRvpN8hkQ+/YsGH
	AFXH94jShBUIdp69MEPnHgS46tNNJShvc0qo7SylXoFoY3F4vFoCPfMDZmyIFRyk1B9YdARXdQ8
	ymGuqG0jCfOsz34YFcPy1GFg9RFS6a6na8m+nh2gr6K3T1Y/IK73HKexDja6NrjGnGJOwyURiG9
	tUdt3nnmaLKGQkQYOFi9iLx0TgDv6ZGDBUvAwq+/j28Q+YG48zbAsJDvzcrfbUoRLAxMmkumK8y
	dH7cGdwvwGxAc3ETy7iHZz3dUD2948T+iTp9urCtZzs+gnl3HOG9H0hISCyk50qhv3gI1pk6qdg
	h2uBQPvF37DaSJGB8Z4Hy7eAMRW1Vk//a4RnHDL8ZzAY951ga9Uwaz2bvBcaDB4f9Isj6xyoPe/
	nFxAENx4EgG29KQHgIisZFDgBhc3Zzb9oiUIdCPNPYS5xc
X-Google-Smtp-Source: AGHT+IHn/cXDBeHEtC727RudKIBdwOBJikUhHVFuXlibJ3GijDu2a51IVN94hK+dTzRmzOM6IF+O1A==
X-Received: by 2002:a17:902:db01:b0:290:d7fd:6297 with SMTP id d9443c01a7336-290d7fd6551mr9621395ad.2.1760799741386;
        Sat, 18 Oct 2025 08:02:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddea9e1sm2918623a91.5.2025.10.18.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:02:20 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:02:17 -0700
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org,
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
	david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
	epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 16/21] vfio/pci: Save and restore the PCI state of
 the VFIO device
Message-ID: <20251018150217.GB1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-17-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-17-vipinsh@google.com>

On 2025-10-17 17:07:08, Vipin Sharma wrote:
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -110,14 +110,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  #ifdef CONFIG_LIVEUPDATE
>  void vfio_pci_liveupdate_init(void);
>  int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
> -void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
> +int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev);
>  #else
>  static inline void vfio_pci_liveupdate_init(void) { }
>  int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
>  {
>  	return -EINVAL;
>  }
> -void vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev) { }
> +int vfio_pci_liveupdate_restore_device(struct vfio_pci_core_device *vdev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +

This should also be static inline.

>  #endif /* CONFIG_LIVEUPDATE */
>  
>  #endif
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 


Return-Path: <linux-kselftest+bounces-43485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916EABED1D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FBB3BC6C7
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4132C2369;
	Sat, 18 Oct 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkqYqVGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D028727B
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799599; cv=none; b=dZGbEkgcSqffyvGHa7TslOJzwoEWELxGYSNeOG0nV0CZ/Xga4gieTSZAqGwVeTf/G/3iyNric3IrAWnpjzIagzwALfSwrOlDG+M8QxYckHc3bBYAJ7bkivAiGa9Qq7q51NtRm0Kti8/dyefGB/TJyxba8iWWYDgqq36TWf2QuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799599; c=relaxed/simple;
	bh=RxRGGS34lOYtj1tSF3o9XGto7oo+cPrOhIqsrmS/Bwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPYLq8/t+feMlcUaoX23AAIJw95KZxcOpEJew4vFSaqRUDRGVkqpVA26k9rETGfeP9h02hB5rQl82d1LwuEwr8phlTAfypUdJm9841Nkxv3bGhDwaSxixGxDy08+4r9N2LJGDAxQLKL4YbaIsPTqhGY6c8TAG+ugoNSTUIyX828=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkqYqVGK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27d67abd215so129505ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760799597; x=1761404397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SjKrzbC5Tx+d+FYfgi0Q+xGdmlz3Y5FBshE2AUsLRs=;
        b=OkqYqVGKYHwDdEwQJBt2VkDH5MaQIyGq3FtXkW08/OwuvvPJDWPWk5TwDvn7M3Aqtr
         IZQtMOCZ+F83AY4oBm0UOIBTTHJzCPB8/acfwSYbzppaujUrw5395lpEhzFcQaKGlqVq
         w+yOpAZYLzOE3iBSiZpzQuCDCbhyG3W6byh99Mf5XmLp7XhnP4sZgxu3o3px6Y6YvByz
         7i5rnuI5e4GHQ0wvyLh+d090sdS4MIwW+nTheFVi0jCE2xYE+0romD5W31sYPFBE+R/0
         1qyvW86n5PUnYpJIVkPwOqU/JyVV6f3r8480bWL7qqc/+QrhM5MvKzR5E6HtKrdIXQS2
         Q52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760799597; x=1761404397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SjKrzbC5Tx+d+FYfgi0Q+xGdmlz3Y5FBshE2AUsLRs=;
        b=gbllsP2mg47QJJo7748du93rlBNav0scBLzz+Y6Jwsh6GeXZNiT0ZkcQ4jkrZXkLEd
         hlp8HeyE3yR6z7u8krPwXs8nKV6JJEGZVsJrGpXyYSrviYR8uyKxqWLg1sQIcj8fRKlg
         i6cw4LrfmNrH+JuU5jwwdtP+7u1T7046VAY1fueOCQf9SerXIdbiBXiEsxz4xmRZG95Z
         T+ckIoxoHD2renzSpYhjyWbypSBY9sPa9DbrbJT2aqLU34gy8+Dmq1EuNKK3hGksugMW
         0QIVIC+FrqMabQHgtZwc17RASz40Wfv3od7VDPAQqOG0rUhhgyuHYCyfFQP4AQzFwzpx
         v1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo26JvRdCcqgg76/8i3Mq4f961eNxQxwpFuq2alk2JUwcQozH25970MCoP7lS/G/gBIIh6e1gYbEIAtKpQS6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/1TqkFSxE3dGj81BDbKF3/imAQzqkn0+WJex30K1/SvME1Vu
	v0DM5dboAUGogOjE9JlVMI8+4h17OKMddoS8wKEDXFn7Gb/y5qv/smDxMNrQo3CNoA==
X-Gm-Gg: ASbGnctbLgfGdQ0Bkpf2NXOvsdJ+Ks37oPcnh8NdA3w563nUzmipOusF/v5gQtL7vI7
	tY/wUy95Q1y7zeBqemkPXl1oO44OKHfKMBTQdhiPMVZQBGh25BVpkO3/Nwn6Tcy/5HnZLILEMTw
	b1u4FbXEsBwDCbprDAUXMP3DIkkAlC+TGNR3qj4JwTGZ5MjPB9Rdhlu5yBwB4cqOSDfkcMPw9Zk
	lF5ZmjN7/hvkD7TLdWakWAEikJghtxcgmCMEnaW7hn9NbHdaEfpeqWVG8L4NhrUKzzvLMqdbuOI
	NES82NTSSKeZoEaKIWGseLsv7em1l5ZGth205Ysdj1lTQ8e2ETcEiInwLjefhenWjEhb/7sySRm
	cIEJb5euPoPL/pLVi5pMjPRT/AJCVyTWl0zy2vx1FC/BkXc8GodUTvn4j8tItTAtS145XUZdU9g
	s/phQXRjPtJt+DsLUniWKOQQ3K9ARiS6aomQ==
X-Google-Smtp-Source: AGHT+IEO4meUUEecoQCQ1m49ew5u3IzhZQhIoa/TkD8EI1gJuwGpLMOCNbvdEHLSvt4FD9IHI/8J/w==
X-Received: by 2002:a17:903:2284:b0:26e:ac44:3b44 with SMTP id d9443c01a7336-290879ecc6bmr22769125ad.10.1760799596925;
        Sat, 18 Oct 2025 07:59:56 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2994154b3a.53.2025.10.18.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:59:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 07:59:51 -0700
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
Subject: Re: [RFC PATCH 13/21] vfio/pci: Preserve VFIO PCI config space
 through live update
Message-ID: <20251018145951.GA1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-14-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-14-vipinsh@google.com>

On 2025-10-17 17:07:05, Vipin Sharma wrote:
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -109,8 +109,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  
>  #ifdef CONFIG_LIVEUPDATE
>  void vfio_pci_liveupdate_init(void);
> +int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
>  #else
>  static inline void vfio_pci_liveupdate_init(void) { }
> +int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)

This should be static inline

> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_LIVEUPDATE */
>  
>  #endif
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 


Return-Path: <linux-kselftest+bounces-43507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C4BEDC5D
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 00:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DAC58661C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A028489E;
	Sat, 18 Oct 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqAhIbmV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59727FD54
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760825959; cv=none; b=Nd5rkBeLLFNzDdRKceh74/BbSFRDEF2zdIoj1LmmOlW5omHKmJ6RR1XBKP6+95zMhLM4plNJghTQvmpTI1ebAcQuok5KaR/C0GgkjDeHyEViMaWdW4eqwyWw5NYBt4ArZ2tVgpF8Kf0ObZCTZA/f23bQjHk+cr3FkMapQh3VdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760825959; c=relaxed/simple;
	bh=JlKaawplRif18Nf9EUoPulaOPmERcSHsfxRqy+XDXJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzPGnI0Zg7H2Zm6Ef0nuIQSUQhXKGfqcRaNxHO7Mj0MGKcptyRRZe59JZG7or1kVtMkuGikLexM03E2ERYQZfoBaqPkQUXiODxVLcDEIH1wAfG9Zhi+Z+VJhTL3JWlJU1KsNVznha8drZZgyPXt/llcRVEUoz12P2aAR0NobcXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqAhIbmV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27d67abd215so153585ad.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 15:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760825957; x=1761430757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xqo7yNFtggFSEzPqHQOFVfXHu2D1vZdxkr8I2A3MgfE=;
        b=XqAhIbmVkmact6RhjHTVufMtBw159dsQ9wR52u5a98jegnlGl3YffITbI8ci6c14z0
         UqPbAslyZyREHMwFzfqil3Kbz+ilz0PxoKBCzttIJtkMB1DnsVQN1fP7TsqrUwi2A5XR
         uMNFVWy08UJ2ncZ9kjuXaaa2JnHfFhBJ8/W0Nd3NtDCY83gEhLEypQR693NbDhtyVlYV
         txDJn3lXVC+4x9xhEcOCyaiQuqGiz4U203QIvp5KMZNMESyIbGUWkx8cnbilkb20Omdr
         vDeD9adGAPs57AsvRIHJOISSNr2sdNTxgbAPdZ+/zqnUrr46kmEaeSzLrnY7pyVtxP6F
         LL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760825957; x=1761430757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xqo7yNFtggFSEzPqHQOFVfXHu2D1vZdxkr8I2A3MgfE=;
        b=JzaW5MLh7ZhJMyLvpPj2T2z7ZmQ0l9LHit1rDTwolraCwbp7x9SJeNiyFS4ztDQGPr
         GKPzwTQ8AK9jvqN05XqdKglT3NJIGEpWx5k209KNKA2+8mdDdHd6NkqpTFYem58F/5+J
         MnsZxC7vwSfv6mrTiWEfnEvQl5s1XJQy7VJDP+XZ4WbFO5a/aWJYuhE97z7kl5Q0aCWN
         fWJFG8wXp5/Dha8MsZOI9mai2oxH+18m2mzadkjj0+KYFweJF9G9hKf6ol9C6yoboMsY
         h+bxziL2xINnAjIkLtaLLtQpyUWBLY40KNEMjIq6MnCXfq7+MnEz4mr2KB3PZqJXRkx1
         53Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVNtyMidwGL5Vfp2Kr8jR7NSzr3aAUCEGy9Vnv+tgM0sfn++S8Q33kPLL8EogRi8HQvruFjETfqrBksyKMXklg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQlYop2b/qs+2vwrFHMoca51QJd9+Ju4QmOvrO3kRZ6t1UGHWL
	PxjxyQrtdAmcwUSLxBQnQUdUWQ/PkqZwrUHK4QvYaQ8RIRpWNTDMgIxhz2tWBAdihQ==
X-Gm-Gg: ASbGnctDHwMTLMvhgFeBHgiRS81onGmHIlTngmT9bzt8f6JwKpAR/HlTruhIcMJXx1v
	NoLOyEnlcdFnc7c6sMnPgQQRjq0mhxE2Y3Y3wBlxUBG3hIdccZRScmiOI4639eaSCq562bw1KFL
	kqxLNQNLMjVV1BtWqgsRZopUP3c5fjSzDEr+SSKv9Op/WWfQ2TJJJ+FtXDojdywNY5ogNg2usAc
	YmUXBpmtA8hk3WGjhcmMu7sV7AYWvUICOto/6SJI+5tqcbI9RS/KO8kWwUasSnLbhq7QtYczbW4
	fKNRUU4R9+o3iJpNpK8HK9PZpxVPitoh6i44Fcn/emkhOpivqymetTQHRo3Z467xgmwYVtsIlIO
	D9t++8kEpCF0H1MASUnJzv/HrHgy1hrw2CFOeFikx+iyhE9Eu6hBXyCtIcwLf0fVWVUCPzLN/en
	Jp1bVktLiwkekXLT1+aN3zHInmSqO06mCwCZ2q
X-Google-Smtp-Source: AGHT+IHNOSRoOYuo0/rydKUY7NRTeMMzgSZT/HjwIBsuJ//tdfpp1kxrb6bUECWA8HoYT4POGrda/w==
X-Received: by 2002:a17:902:ce0a:b0:292:64ec:e0f with SMTP id d9443c01a7336-29264ec0f7emr836085ad.6.1760825956380;
        Sat, 18 Oct 2025 15:19:16 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm35204555ad.112.2025.10.18.15.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:19:15 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:19:11 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 11/21] vfio/pci: Skip clearing bus master on live
 update device during kexec
Message-ID: <20251018221911.GC1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-12-vipinsh@google.com>
 <aPM9Eie71YsJKdak@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPM9Eie71YsJKdak@wunner.de>

On 2025-10-18 09:09:06, Lukas Wunner wrote:
> On Fri, Oct 17, 2025 at 05:07:03PM -0700, Vipin Sharma wrote:
> > Set skip_kexec_clear_master on live update prepare() so that the device
> > participating in live update can continue to perform DMA during kexec
> > phase.
> 
> Instead of introducing the skip_kexec_clear_master flag,
> could you introduce a function to check whether a device
> participates in live update and call that in pci_device_shutdown()?
> 
> I think that would be cleaner.  Otherwise someone reading
> the code has to chase down the meaning of skip_kexec_clear_master,
> i.e. search for places where the bit is set.

That is one way to do it. In our internal implementation we have an API
which checks for the device participation in the live update, similar to
what you have suggested.

The PCI series posted by Chris [1] is providing a different way to know
the live update particpation of device. There pci_dev has a new struct
which contains particpation information.

In this VFIO series, my intention is to make minimal changes to PCI or
any other subsystem. I opted for a simple variable to check what device
should do during kexec reboot.

My hunch is that we will end up needing some state information in the
struct pci_dev{} which denotes device participation and whatever that
ends up being, we can use that here.

[1] https://lore.kernel.org/linux-pci/20250916-luo-pci-v2-0-c494053c3c08@kernel.org/
>
> When the device is unbound from vfio-pci, don't you have to
> clear the skip_kexec_clear_master flag?  I'm not seeing this
> in your patches but maybe I'm missing something.  That problem
> would solve itself if you follow the suggestion above.

VFIO subsystem blocks removal from vfio-pci if there is still a
reference to device (references are increased/decreased when device is
opened/closed, check vfio_unregister_group_dev()). LUO also do fget on
the VFIO FD which means we will not get closed callback on the VFIO FD
until that reference is dropped besides the opened file in userspace.

So, prior to kexec, luo will drop reference only if live update cancel
happens and that is the time we are resetting this flag in this patch
series. 


Return-Path: <linux-kselftest+bounces-43509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C448BEDC87
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1384E0F41
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D575284684;
	Sat, 18 Oct 2025 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOUcFzzh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3271E2858
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760827448; cv=none; b=fG2AfiIWTkym6b9ISYmxoSyuDlPhhXXhm28t9BSaL6GmDI/qGk8HFStjrYUxUSkNHbl14+GKWZeJPjWRrExGJs0jeyXEGjWbEQnQfl9wucoPz5aNW7Tq9WWtg9gEA9t6eVBlmd342EsTh//5uN0qp1MJKh1rqKItr5oV1FmZgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760827448; c=relaxed/simple;
	bh=Ta/c9XezGqMf/V2TLVa7goH6OnP4x38duY7+3rqFhAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkVVB5WjahnQfA1bcsBVwloS/Uy0UYdVO0j9Dk9aO6fip6hG/DJ9aTXFKX8a8aub1GGh8hijMwO0TYvf8UL6qJdGge2y5iXoHkcu06xlIZkGEex40DJ9BfitV+Br2hEKHPN8d1iYCeP8tjb/GA8Y3dpgxDioiUrTVgZ+5MsgfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOUcFzzh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290da96b37fso128945ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760827446; x=1761432246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bruY5xXBxn9WkfFqW7waoeAALeQlBvbWEZW8ys6H4QY=;
        b=jOUcFzzhXT+03bu6yEL0Pz3ND/zYj1AduL9JRG1BFBtBZFC6srBcnBQiMu04B1OuFR
         40LFfx4v4CGU1jlLx1is2Xgk+vBNcHQDRkuUhXUGHNzr+88yQS022do/L7pzz46mQWDQ
         DVWfBDpjNIVObe7Jb/V0TmJRis6GhnFPSzHalnyNrsfNq7AgXAlUcRWpOXGljzhklAvJ
         9dXo4Pi9QaNZyXY1JYR/A31FuUxxgOiHsSTRXpWSatt0CF9qbVgYBoWtnM2KdTMSEWg9
         +oZYGTnV5KV+Uh0sEy/yHrE+vyoJ0yMkU6OjzeCa22JV30xn/jygjJleFQlb5/jyWn2a
         GKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760827446; x=1761432246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bruY5xXBxn9WkfFqW7waoeAALeQlBvbWEZW8ys6H4QY=;
        b=hilMDUtMZLA5vcTvKVNoHpWiD2js2dlgvhdJpO37IHXrxMS+76LJmNDrrWxXOj1/Pz
         Vk2RySlUqgnMgDgAJro3MNLGVTuV0ZXyUBfuI5xp/VyIwZ+afon8enUd1F27QtGpB4HS
         jxbsF0aizV5rqKVz6vUORoUSLdtsm8WsCO8w8lxD4MkgQeV4ZN8MhHLlFDjzXoPGNN4l
         Wn9BIP3i/v9J3pSUxyKcEFfv6QvMz+rFgz/vYvACyHK4MOauAzq0shxkkHt/rlLslSwq
         k6dQt0/Nk9527ikRq0CCyIyfl+F+EnCcPtSrrudu4tOK8rpPxAALa+QLO3G2HfinGKOw
         1ZNw==
X-Forwarded-Encrypted: i=1; AJvYcCVscTvjMZbFL0G/I/5WdXfJPSdPNv3GXWVY5WreUGFpFoUB+nLFlunRITNciT8DzJ2dGVcDWh3FanQRmPxrzhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGa9rqEkyvE1krC2Dg9HLuYKt7+BU59vUZ7fFY0KtvdeBKEq1c
	gGPPKiz6EoDMvi5zhzh0UQp767aInDyNxjV7vF8DqDYint4Afd7M4rfbvzTHBBQH4Q==
X-Gm-Gg: ASbGncukHAG0OKBSvZbYsd36DWZ+LyjOBm8r6IoQnFKebA463HoQjX7zZ5xXwj+YEX8
	25O/SyvMcdFiXIlfvqFODgQ24S9zNzetxAofBr/LNC3VoLxsgSXHRSZJuIImhLD84JIKmyqrYgJ
	hQUN58lLhtAmTVcDxVPoBRAkwYepB7bJwgegbk6q80xb8zbgG3VmlubHwLG+87qkqitVXJzW++8
	Gjr4kmMu4eas7PfOsy0AFPOaIj623Nc8o2GygpkWoC4lkHKk+TIITmZMMcmrYP0LCKe9HJ+h1CR
	P6TJS4PKCGLHWrQEQsDjBaXBvmvJgpOST6ynO3bE1NfE+YNrUX/1OL6wqjMvfE5Qq1YHrFrvq6X
	xnrKD7lMBMgAVThIYvooAtYB24e9xGbZb5H3kaT4V0GbxJhLuqieqbbmSN24lqnyy1NUCZY76nQ
	22WRf8Ft2dGfi9X7lCn1Tpjbrqp4dzXBA6WrNf
X-Google-Smtp-Source: AGHT+IGOy69p9M6Jz6Mkzq8eaflD/U8wmvlvaJu0hkGofGNsbToyuN5EELyfS2lAWWt4IMDVzBhQ+w==
X-Received: by 2002:a17:902:f603:b0:25b:fba3:afb5 with SMTP id d9443c01a7336-29088bad815mr18397295ad.11.1760827446063;
        Sat, 18 Oct 2025 15:44:06 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de3295dsm3597111a91.15.2025.10.18.15.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 15:44:05 -0700 (PDT)
Date: Sat, 18 Oct 2025 15:44:01 -0700
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
Subject: Re: [RFC PATCH 16/21] vfio/pci: Save and restore the PCI state of
 the VFIO device
Message-ID: <20251018224401.GE1034710.vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-17-vipinsh@google.com>
 <aPNA6q-i2GWTl0-A@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPNA6q-i2GWTl0-A@wunner.de>

On 2025-10-18 09:25:30, Lukas Wunner wrote:
> On Fri, Oct 17, 2025 at 05:07:08PM -0700, Vipin Sharma wrote:
> > Save and restore the PCI state of the VFIO device which in the normal
> > flow is recorded by VFIO when the device FD is opened for the first time
> > and then reapplied to PCI device when the last opened device FD is
> > closed.
> > 
> > Introduce "_ser" version of the struct pci_saved_state{} and struct
> > pci_cap_saved_data{} to serialized saved PCI state for liveupdate. Store
> > PCI state in VFIO in a separate folio as the size is indeterministic at
> > build time to reserve space in struct vfio_pci_core_device_ser{}.
> 
> Unfortunately this commit message is of the type "summarize the code
> changes without explaining the reason for these changes".
> 
> Comparing the pci_saved_state_ser and pci_cap_saved_data_ser structs
> which you're introducing here with the existing pci_saved_state and
> pci_cap_saved_data structs, the only difference seems to be that
> you're adding __packed to your new structs.  Is that all?  Is that
> the only reason why these structs need to be duplicated?  Maybe
> it would make more sense to add __packed to the existing structs,
> though the gain seems minimal.
> 

It allows (in future) to build more validation and compatibility between
layout changes of struct across kernel version. We can add more fields
in the *_ser version which can act as metadata to support in
deserialization.

I do agree in the current form (with the assumption of no layout
changes) we can get away with using the existing structs. I also think
this should be taken care by PCI series instead of VFIO series.

Lets see what others also think, I am open to not adding these *_ser
structs if we should wait for a proper support for struct serialization
and work under assumption that these won't change.


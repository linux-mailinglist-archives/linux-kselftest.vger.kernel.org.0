Return-Path: <linux-kselftest+bounces-32143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8ACAA698D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 05:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB9F1BA6DC1
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF91A239D;
	Fri,  2 May 2025 03:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBR6tDKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D01917CD;
	Fri,  2 May 2025 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746157813; cv=none; b=PH2lkXl0rAwK9I0Kj0Nyn9AyoBHX9ZCvOGeJOr0z3M4rcVk2p/zaVW7mfDqhFusX+rDwCUBY49R2Y75BD3iksyuVxVOFFliRxZFYdEfv5aYppKF26F5v5RfIXSmpQywz1uUWc84HYNqBW+uLpCYHv14zdZeKL+4uKlYW51Cv8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746157813; c=relaxed/simple;
	bh=3c1nlzF8RZhIa2IfkWpFCztfXW4famdPY+LgthBQ6Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQuSEJApiJyDvE4Iirt+8ZRCUBDsgP9XbmFY8f9jt733IzVhtUVxctsOnYbQTUfYBpQcbUDmhw6hMm5YtKXDuDMdF8qErbMA0bkKwV7pXP83XavnqPIZKF+YYBer5nZgPCTfWeG27ZM3Hc3zE3700V+GfkYhms5dzEhPgx4BshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBR6tDKb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3031354f134so1371591a91.3;
        Thu, 01 May 2025 20:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746157812; x=1746762612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9Fmb2BpvFenPgSBSx7aFW99AUa48pruOHMxG4AYI/0=;
        b=fBR6tDKb6ZhxKjwnaP1yus7+YeGppo85BGRAywrM//dJEphUR7dqhycbtHdDOrnPrr
         QgIX283qkX8l+GX5/U9oHjYWGLQAjc9EPV1z+h0wfkqVXbt+mlPFOM62arZ3MQ1Hfnwy
         8+R7Nvv61/SMDPoi6AE/ixykfpc28uBLcjrhooOU6CRtcKI57HYCYYBjgzBI6DxABQ4T
         YcYdPPwqMvg1MPF9wxDyssHl9eaeaM9PqjfmNQDRSgBBuTV8uupcXMPF4UbkIg+75+5m
         9SZx2a6hPBLLXKnaQ8K0EhhyLIkyF86xYdDS0/oyg47ra+mThGCPx+0FASCFkhFlGccM
         Frbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746157812; x=1746762612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9Fmb2BpvFenPgSBSx7aFW99AUa48pruOHMxG4AYI/0=;
        b=jl4LzkE88j/9fZdfnhHNvguadqwAVAHH1e+pHKrD531mdE/EdToaHFXvu0wKsrNIvS
         jovoUAKoO19n83jSB2OIApyIHXjb1Cd4dgByNkqMwvhUlIwdAB+7y50YB5pGb0MtZBTp
         eVwGkGOz4tlCqVKfcSiHtwpfLbFxUMvzcG5VDMjvV7l0ZXB1tpuTAy0NKhLj1WiAFFQn
         L1Zq8Lax3g4qr8n9Veg01DPQ6lK+7bfz16EVhob1SMzeDN0DUhkM3WFGr1D2kMi+qHCa
         Me00j3SWTLogEY01KVFgquO+7dKmgtRft+hTlacSI0WTVci/yD0ClBw5nVUyLB+8uF4x
         efdA==
X-Forwarded-Encrypted: i=1; AJvYcCV8qNlUdxjJ90eCIcra4zIf5ikoTDLY+gLtdOfQ2v/fywtNeWT+lKGYhb6vod/h6vrE80Wa5D03G+vMMbhxrx7j@vger.kernel.org, AJvYcCXCpsdqx3chPR15DeDoXt7hEIDkLyqfzu/xA+TTUPAJHF6sHyEwWsvg5iLbj+IT0+HMmXkeDziCEz6AmG+c@vger.kernel.org, AJvYcCXkDnU/3pPn5UDEkYQxRXwZVkJevBvejt+Z9pPzSDblnHa7WxZsngmQM0NQYa1DPOykI9tEfDElfOo=@vger.kernel.org, AJvYcCXzz/U5Qiy0uf840uY/zKj9V3qPKaxGNgamRXPSpFRwQcKQEmrASKxLrtG2Zcrbo0iC+zFE7sYiEvMLo20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK703ZBqSu7KvQsTiaTZj5r+jEpS/doyPRQiX+w56B+4ls17eO
	IEHZMr4ECjec2Szx1jc4e8ZEPSeTXf3owT0Uk/tvTRJZmbQSDddL
X-Gm-Gg: ASbGncvAhYCH3LD9GbxjSVDFDbuQBaXSfRAexUuLvkB46qI5+BZIjDh7d1Tn23Letc9
	e9Tgf3/e4z7oWL1ywuUbldEbM7c0kLrp+KjTAi3yC0atwpOzVCK+rUtBtq7GijagqqJRhiYaYt9
	okvEWWSgZGjN+eQNo88/bNtvxNNHNq5xFmn/iu3pDjunHn7GLNh7WRoM2xw0u3QO670Um7Qpym4
	7RumEnT2aRqiuIhqy6BJ3joOGsZJsW0ZnKpRDT89TGuGDLUR0q7ZxOB8WgC5zdJSNx7GliBvST7
	SZ9+gGXpIj4YGcka692mGaxuJE0UMauvQ2P1gXND
X-Google-Smtp-Source: AGHT+IFusSWo1BAwwXVBEu66ZFOQHwzVAGyr3p079qazgApC+Wzq8zZL3bsDTFLCQouzn2+zKuFDTg==
X-Received: by 2002:a17:90b:586c:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-30a4e59f952mr2796823a91.14.1746157811349;
        Thu, 01 May 2025 20:50:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4748e852sm1776417a91.23.2025.05.01.20.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 20:50:10 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CE99B420A6AB; Fri, 02 May 2025 10:50:07 +0700 (WIB)
Date: Fri, 2 May 2025 10:50:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, praan@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 16/23] Documentation: userspace-api: iommufd: Update
 vQUEUE
Message-ID: <aBRA75V9l9WlI2Q3@archie.me>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <0beddeaaa4a8a7a45ce93ff21c543ae58be64908.1746139811.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VfsLxvgoTsplys2W"
Content-Disposition: inline
In-Reply-To: <0beddeaaa4a8a7a45ce93ff21c543ae58be64908.1746139811.git.nicolinc@nvidia.com>


--VfsLxvgoTsplys2W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 04:01:22PM -0700, Nicolin Chen wrote:
> +- IOMMUFD_OBJ_VQUEUE, representing a hardware accelerated virtual queue,=
 as a
> +  subset of IOMMU's virtualization features, for the IOMMU HW to directl=
y read
> +  or write the virtual queue memory owned by a guest OS. This HW-acceler=
ation
> +  allows VM to work with the IOMMU HW directly without a VM Exit, i.e. r=
educing
> +  overhead from the hypercalls. Along with this vQUEUE object, iommufd p=
rovides
> +  user space an mmap interface for VMM to mmap a physical MMIO region fr=
om the
> +  host physical address space to the guest physical address space, allow=
ing the
> +  guest OS to control the allocated vQUEUE HW. Thus, when allocating a v=
QUEUE,
> +  the VMM must request a pair of VMA info (vm_pgoff/size) for an mmap sy=
scall.
> +  The length argument of an mmap syscall can be smaller than the given s=
ize for
> +  a partial mmap, but the addr argument of the mmap syscall should never=
 offset
> +  from the returned vm_pgoff, which implies that an mmap will always sta=
rt from

Did you mean never be offset from returned vm_pgoff?

> +  the beginning of the physical MMIO region.
> +

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--VfsLxvgoTsplys2W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaBRA6wAKCRD2uYlJVVFO
o+SZAQDJ/gcFcLrWtK7lcL67yMIrbhi/Ip66m8FOzciKz7X4gAEAu6K/kN2zgCb1
Up14Fvx9ssPG1/hIFF+QXlsxiG4N0Ag=
=Umti
-----END PGP SIGNATURE-----

--VfsLxvgoTsplys2W--


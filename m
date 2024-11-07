Return-Path: <linux-kselftest+bounces-21570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6246F9BFB00
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA71282F24
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC61E6FBF;
	Thu,  7 Nov 2024 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4y7a7+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822453BE;
	Thu,  7 Nov 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940999; cv=none; b=U+H+yWBzGr6ivIXyccQxfBYgg1/Ew2sTV5ydn2g3EH4B4J0V5DvkCsKJuemY/uc5pEcoPDiSy9qcVadKGAVBBuTGRuT7G4of1AToi2fnxoQbT6rw0FsigDu6GlC+f+/PHGTmWsWGoD3NZSn2dLGCp5GpWN28uV41vvr5gGsWv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940999; c=relaxed/simple;
	bh=PLaojtRXC7+p9v3nWjKHwHm1S8O3lMOgiSI9DIAjLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtSsnFP8KgTUYiZcxYJDrjmQRiCZyvxa4Z912qgDJc/XJquyg77vtFj5alvjrmR0GuT8KkGf+MbhEGgwdHyIomkB1RCPWdUWSvafP8UHfnmyfSkKxdgDfY6Oekc/NTfryP+XZyGuniwpj+Ijm8tMXwDqnn+nM7ojhP702CQ2Wsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4y7a7+E; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso309929a12.3;
        Wed, 06 Nov 2024 16:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730940997; x=1731545797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb6nMRvMwSxA+8+ha5/4tfagx7bwoqrFwcZIkWkVlTI=;
        b=h4y7a7+E6T6gxjh7OUzOzqvR3s08hK4prTqFM54akn3hCrZtLwdT0qTXCnaX/GpE0c
         WEzLBR7E/AeyIx5oNA4RKs8xXZCQJPlB6l51bT5ghKmJeurzV0wFXz6zerLms79PkpxD
         5Oprerceio1z8Ph0N9Gfzs9Lam3ZAvw+UclgtSsemr4DfZ68syrcz+nLMaYkwRFZuzSE
         PSgBDkGEPlLTu/TVMOnZwiSxJ1uoYBVH4BoavNlEQr/QNGwHmz6y3ZaMaWLUX0su5V9g
         Epwhl//V7ml5Bzjy/39PxaMX7Ai/Mk7Zm1eBAikYh4bcauEKEps7zyNNMBaB96CyohQ1
         /YSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730940997; x=1731545797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb6nMRvMwSxA+8+ha5/4tfagx7bwoqrFwcZIkWkVlTI=;
        b=JkXTWZu22oOi0jTkGM1Fmw9mqRWfRHT70dN0hrvlJLunkpF6CABs7uSg1nZj2sEp1J
         Z8JOzsmXDEvIMZOwx6o3fntaTedieEBwo9mHZsPAOevwM1QYuY3k8vGPSWUMRmi7m/6i
         2rt/MWzxL7aPugxMD/yVYIBVhAKj+liDLeYv0BxUwgMxxpdk3/puo+78GiCItySGptg7
         Yj0s+xlSss49Nux3dbRiHxe8VEVr3e9uqMvw2iSsKZlsI/EFuum/IZMRa0GMfUeiwpwy
         ahePKm+MFqjvT1UOGecvsEJhQMPiZinMVoVK1UQpiZl1hHvc7OL1j4gkd2q0Bhd+/W35
         +/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkxIUfvPDUoHe12cyTrXc0qN44hFihliZBQorWWbS/uxaz3YQu7QsDwY1Z8T+tiOt4MjaNabWel0o=@vger.kernel.org, AJvYcCWzNkkcmcWeGg8Qkm5Lhj90E24RJ4TTLwPw+z1MWwgro4sz/FNwYcM4iEQ2wpZba9kft431a7KVEm446T7SyZ56@vger.kernel.org, AJvYcCXl9M5q9NCLzDPyvHAg5kgNrS7t+R4DofzjVXAFvvsFYilGPFL9mLsYcIg3uwkCKNTCEEp7IPB96kI6DB19@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/BpEnbJeKUo7ZE1VXVl8SuWxXFK/5aBG1/gGIfCnpUGsLzeRV
	w3QEgdmVMeM/ymhKefqM923pDc5yU6jiA1JlYC4FwPP0jUSPHJP/
X-Google-Smtp-Source: AGHT+IEYiPOYXNXocP1QxbgwprQfTHsIgODY98a2lMIztatnt7OohZLGlw/YHFai1ZjQ5Pw50bk/qw==
X-Received: by 2002:a05:6a21:328c:b0:1db:e1ce:8eaf with SMTP id adf61e73a8af0-1dbe1ce9763mr14975018637.6.1730940997311;
        Wed, 06 Nov 2024 16:56:37 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bb8fsm180679b3a.116.2024.11.06.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 16:56:36 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id AF82B41F52FB; Thu, 07 Nov 2024 07:56:31 +0700 (WIB)
Date: Thu, 7 Nov 2024 07:56:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <ZywQP3_TpdttuCy8@archie.me>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R8eh+sitfrxXSbCw"
Content-Disposition: inline
In-Reply-To: <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>


--R8eh+sitfrxXSbCw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 12:04:29PM -0800, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc to reflect that and add a new graph.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/user=
space-api/iommufd.rst
> index 2deba93bf159..a8b7766c2849 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
>    space usually has mappings from guest-level I/O virtual addresses to g=
uest-
>    level physical addresses.
> =20
> +- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instanc=
e,
> +  passed to or shared with a VM. It may be some HW-accelerated virtualiz=
ation
> +  features and some SW resources used by the VM. For examples:
> +  * Security namespace for guest owned ID, e.g. guest-controlled cache t=
ags
> +  * Non-device-affiliated event reporting, e.g. invalidation queue errors
> +  * Access to a sharable nesting parent pagetable across physical IOMMUs
> +  * Virtualization of various platforms IDs, e.g. RIDs and others
> +  * Delivery of paravirtualized invalidation
> +  * Direct assigned invalidation queues
> +  * Direct assigned interrupts

The bullet list above is outputted in htmldocs build as long-running paragr=
aph
instead.

> +  Such a vIOMMU object generally has the access to a nesting parent page=
table
> +  to support some HW-accelerated virtualization features. So, a vIOMMU o=
bject
> +  must be created given a nesting parent HWPT_PAGING object, and then it=
 would
> +  encapsulate that HWPT_PAGING object. Therefore, a vIOMMU object can be=
 used
> +  to allocate an HWPT_NESTED object in place of the encapsulated HWPT_PA=
GING.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--R8eh+sitfrxXSbCw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZywQOwAKCRD2uYlJVVFO
o7pRAQC/P/MtxGJEcuBrLt3vgwQrT0pU3bttl3Z7gq5Y4j09ngEA5fvElByqOXWd
ra3GriB9y/vGMX6/gPtQqt/qByO1IwE=
=OgKS
-----END PGP SIGNATURE-----

--R8eh+sitfrxXSbCw--


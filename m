Return-Path: <linux-kselftest+bounces-21590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6199BFCED
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 04:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509C61C21913
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 03:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9A74E09;
	Thu,  7 Nov 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjo5hqvz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A06FBF;
	Thu,  7 Nov 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949656; cv=none; b=UWV4uj3aFnvKNUbnKkyBRojP0YJvduz4SzfDY2V6g2oMw6LYqKGOsceE5Lo1WjX+ZQ7HPjJF9U2QeHlFw6uriO2pL7qZZV3FNfPcIbQQp2ZzsLgYIo3udqmYPM8fgweGX6QpS8Mc6dPLT+sa9zDLA/SBHVuUzDTpAkTNByAWIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949656; c=relaxed/simple;
	bh=MfgIsmThhu9LXOQDEMR7hFNs+rsV9Z5JVos+Z0mGxsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2yNn2CbDrOPk8+d5SEIFVh1Q/oaM1wpLT9w9/oUsOTlx2KZQwTfeFv6MIqnApSNjeRbS3K4HdZhC06rsKd+VIsjzZhSvaIggnnyBME3aWRTt/zv+jB5B5wypY2pWj216byAHu6zwfTbbGw+5cPylhHXCjNOLYYoRZjPKq6Ln08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjo5hqvz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca1b6a80aso5835335ad.2;
        Wed, 06 Nov 2024 19:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730949654; x=1731554454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8jNzrElX9RmiBjTI8h4pv70akApgYg9F+hG3zefMUQ=;
        b=Pjo5hqvzeBgJLYQ6ITzLTC6JbEEpdqyPnKJmdBLJloqI59GnepRNto+dWyB8WV4XpM
         gi0/bAGspN7lmq24pgZZhnUcA/jbC9REUY+K8JwQO3dU/UQOQCVjbYo4Sdgo4MYj1c8b
         uzPMB+gYV3/ffkFjaeL9a30TbGuW++5K1KSlsVTxUU3NmgsiGKQ1dxb4Gl8Yt4PGc4MP
         mTRZxteS8AOd8vDzEXFbxIpqqTTdtKmmTXpn6c6JWdPNPL/gjAs48ZIe1klQ/+JbOxz5
         /s9djrUmVGS/qUDgOuj+CcnUT3Dvvzp6PNIboTJ76XHsablyh58+ftDnrXuSk4LSIPzF
         c6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949654; x=1731554454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8jNzrElX9RmiBjTI8h4pv70akApgYg9F+hG3zefMUQ=;
        b=kpDecBy5T6kzrhOgCpP0HbFP5EDObQCpj66fVQUPDXE7A6rV532Lr+9cFdi/eJGIvA
         qIEjzIh0xSdmowssIuttYaME2hCrJlVj5E18llk+NULqjzT8Sg6ydP2pRelfm6k2eDgf
         eDSs3ySOMmn5e36KwNUBDgFyR4cv7DdD3dMFMZ2tAps5hO5SKu/+5Hlf98n5s9/sL5GR
         M+2ysUt0JjFXkKgGv23UJxDToz6hsVXitR++pejSSgt8Yi5No0jTqzslkPOts2dQd7Rp
         juQsQLxivELB95KID4anIx+QNUKEkX9QqtbWllMI3q9fZ6+r/22EfvBj9Wz6Ldl4YUVT
         7Zpg==
X-Forwarded-Encrypted: i=1; AJvYcCVI455pR1yOG/ukx0aynzat/lXjW6zWHdzDfGZe+XHSye03thh5wRcPzDMe2k0m9066Rtc2rszqZ1c=@vger.kernel.org, AJvYcCXCoICHzrFeDH6FE2RDwV7/Q6CY5mUD7OkZiOnFX5ez38zDvTPc0Mc3Xn6cRNgTuReAZLcUvqDLvlw5bn6Bb38x@vger.kernel.org, AJvYcCXNHhbS4yHWYhILHaM8h9lIijG4/GcKrxdWkfLBCq+LojgK8wfo0qOcfpWI4koSyoAcPWel5EYYsJQPyDaN@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYRWbRrAUoTROEBm9In9kNx0QxdO3vlRSrwnk/sV+b/Q19gwE
	tvbY89eqHTz8k6PZCnnPDUaNRycrfs8nVAq4YJ+ElZq4FncYi+bz
X-Google-Smtp-Source: AGHT+IFP7jI8N7MZAQEh3fKVwbjpLCzLZAOp+2qk1ae0Rl9Avg2cfhgX+kUyGo3POLdRxL4zyEhtHA==
X-Received: by 2002:a17:903:985:b0:210:f07d:b3d9 with SMTP id d9443c01a7336-2111af1757amr325782555ad.6.1730949653768;
        Wed, 06 Nov 2024 19:20:53 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc803dsm2208695ad.12.2024.11.06.19.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 19:20:52 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A156F41F52FB; Thu, 07 Nov 2024 10:20:49 +0700 (WIB)
Date: Thu, 7 Nov 2024 10:20:49 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
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
Message-ID: <ZywyEUmL4HvM8B9v@archie.me>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <ZywQP3_TpdttuCy8@archie.me>
 <ZywZcSidYCWkJgrw@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fVTjkEpn9ekAW5rv"
Content-Disposition: inline
In-Reply-To: <ZywZcSidYCWkJgrw@Asurada-Nvidia>


--fVTjkEpn9ekAW5rv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 05:35:45PM -0800, Nicolin Chen wrote:
> On Thu, Nov 07, 2024 at 07:56:31AM +0700, Bagas Sanjaya wrote:
> > On Tue, Nov 05, 2024 at 12:04:29PM -0800, Nicolin Chen wrote:
> > > With the introduction of the new object and its infrastructure, updat=
e the
> > > doc to reflect that and add a new graph.
> > >=20
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  Documentation/userspace-api/iommufd.rst | 69 +++++++++++++++++++++++=
+-
> > >  1 file changed, 68 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/=
userspace-api/iommufd.rst
> > > index 2deba93bf159..a8b7766c2849 100644
> > > --- a/Documentation/userspace-api/iommufd.rst
> > > +++ b/Documentation/userspace-api/iommufd.rst
> > > @@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
> > >    space usually has mappings from guest-level I/O virtual addresses =
to guest-
> > >    level physical addresses.
> > > =20
> > > +- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU ins=
tance,
> > > +  passed to or shared with a VM. It may be some HW-accelerated virtu=
alization
> > > +  features and some SW resources used by the VM. For examples:
> > > +  * Security namespace for guest owned ID, e.g. guest-controlled cac=
he tags
> > > +  * Non-device-affiliated event reporting, e.g. invalidation queue e=
rrors
> > > +  * Access to a sharable nesting parent pagetable across physical IO=
MMUs
> > > +  * Virtualization of various platforms IDs, e.g. RIDs and others
> > > +  * Delivery of paravirtualized invalidation
> > > +  * Direct assigned invalidation queues
> > > +  * Direct assigned interrupts
> >=20
> > The bullet list above is outputted in htmldocs build as long-running pa=
ragraph
> > instead.
>=20
> Oh, I overlooked this list.
>=20
> Would the following change be okay?
>=20
> -------------------------------------------------
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/user=
space-api/iommufd.rst
> index 0ef22b3ca30b..011cbc71b6f5 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -68,2 +68,3 @@ Following IOMMUFD objects are exposed to userspace:
>    features and some SW resources used by the VM. For examples:
> +
>    * Security namespace for guest owned ID, e.g. guest-controlled cache t=
ags
> @@ -75,2 +76,3 @@ Following IOMMUFD objects are exposed to userspace:
>    * Direct assigned interrupts
> +
>    Such a vIOMMU object generally has the access to a nesting parent page=
table
> -------------------------------------------------
>=20
> The outputted html is showing a list with this.

Yup, that's right!

--=20
An old man doll... just what I always wanted! - Clara

--fVTjkEpn9ekAW5rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZywyBQAKCRD2uYlJVVFO
o05dAPoCkLQClFT+zDGmYdVx68XDBEfdBl1CCmp2FZ3jz4uFtAEAqVIZoqERkKzk
iTAIm9NwYZC9ESLhO1HMIWvngDLktgw=
=Xpoe
-----END PGP SIGNATURE-----

--fVTjkEpn9ekAW5rv--


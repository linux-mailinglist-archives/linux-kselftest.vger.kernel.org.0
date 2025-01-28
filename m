Return-Path: <linux-kselftest+bounces-25275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730A3A205DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5489160C00
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301C1DEFE9;
	Tue, 28 Jan 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K41mpj1+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6D1DED6C;
	Tue, 28 Jan 2025 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052497; cv=none; b=ReqkqfOzqeQJaOKAQ1NfiUMVk0cT2YYnfClrEzUpbeZjHC8ax6NhD3mFUFuK1wl29E0pZb3579qOPFxwcfewjJlzPnrM9AJPQIt3ILIwlupEwjUbQqkIfioymHDAt1XWJIbrFwybsEX9jdkSfOjEeM85El8oFQ48NcuTIC0Weo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052497; c=relaxed/simple;
	bh=RSQ/gaKSYUHj2DbU1SSchGtbIQBxw/a/cur2nGw8Xnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCDwKPC1XOgypFfU6cs1gUOygwktNJ0rq1RFCVhivFCM/flTlXw+LBnsXriZm3arLCAat2LlhJ6V7QPfsjHqwSiU4YRNfn9TKZLeFjS8TddGRq16B0dH7DwnZeFxcQLJ3L+tl5LuGyL0r6vEwRA1c9+ihuHhsIJsQ3jZi1Pn0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K41mpj1+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-215770613dbso66425985ad.2;
        Tue, 28 Jan 2025 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738052494; x=1738657294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fMuy/pYgza/riIVTVPhUzUfkiZ2bVUecFPV047zGXs=;
        b=K41mpj1+iTzESlT9FCvGVL0qfMhmxuJRlk/3jNCvCDOo/11ufx1iCYqho2JVVOm9lQ
         biT3+jPhMUIGUcMPE2vuxsyy3HAvsyQdP2xnUIaLlIbLv7DBoyarOysssEddztVCAfzw
         elV+GRRiHpuyqvV/pEzx1vs+Igs9NO05r1uUwtEmWJOWBDJZ/o5crb8yhkkpRvUyXc66
         XFP9AWUfToKT5Pd4bDf9UUP9ECEHDiAZDptCY4cFUJpacruykcoKbKT2gej3l/jpua4z
         SjA//0pGMMKB6uSJAsmvmrzp/gbOdgA9yTieZZT4DWQPljT25wfDLtzSsAVwxYorHEYM
         VRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738052494; x=1738657294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fMuy/pYgza/riIVTVPhUzUfkiZ2bVUecFPV047zGXs=;
        b=wQXTqC0o0HHFmVAY4gI7p0w7HvBBb33EPBlZPNuGELW1zX9YAy7CAC9DT20ioIXETs
         G6EAau5+ang8QwRNB3ESS3kpPnCw1vWQ9pp8xDNVbtT8+ZtVNK7WdeRD7grVDzCYJgzM
         JL5dOD+MpGpiqDOBL3Kb7rdSRFjWovnUL0bU2VJPADVhLF0Uzaj93/2wTd6/rezlT6Ng
         T3F5c3juYenRviRQlfzln67gxv8RRqI8QgLnQEKgUQWhBpAnhQmHkH/9yjE4dSVMg/MX
         o/eWJJgVUswBr6I3F6aDD8+b2QiG38ISyUdfL16ZLbx37uzkMYedjDp2PhmwRftNMcaI
         WqMA==
X-Forwarded-Encrypted: i=1; AJvYcCULfzkRxbPbHKMyJvvCFZ4DDXPYgP9hGjHnaJ/St/9FtvmE1MOlJlTH+teoq6+IvIehtxVMpGJZHpcCTKCHhSIW@vger.kernel.org, AJvYcCUa37zRoBFpDFlpEcDcKgRyOVQeEiwangkMVAS8Hlllfua3VScSPf9gPcXgWi5CXBU6jxB5aPfpbrqF2vF/@vger.kernel.org, AJvYcCUh8Z7In8x3bPXLNjNyNovXDgiU7eQfMeterH9zm4UVcdPQ0qBsgfPX3wa4q+iM2eFKwglT4Xeu5jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy+6EX/gkuk9beMJ1NFlvR+KAOOzdD5q8D+RXhSIUa7J+Iryl
	Gzt2R5zwJ0GJnS/FmsRznT2XGya03cx0SrYqwnzmol3lIblXcjnK
X-Gm-Gg: ASbGncsx9DL2VpgVQawGfUWjY1n9D5CZfl0sDwjm0GX4skvbdO0ck8icraaW/BXzPq5
	wHYJTptIZPkvMSclXYkykx6DTVw2I1WZoBnSSy+r6M18o2XtRmmxtaISxosLdhrugQ/kJv+rgci
	J5CxLb+TN3jDDH+WzzZmWqtYCeppHTn8eTSfLZho0+zDiz0rP5Qzvn4SkIyVh4ys2hKsS5nJqC8
	6v8z9LpFShNDKEDkwT6sCKKo5Z3j7wxd4OBt3mbRiSDasA1n/+zVCAcolZG2ONEA+4hmrKHKFO3
	cuHautHY/3zBFmw=
X-Google-Smtp-Source: AGHT+IGA23Ky/6K1hLSlTaGOzyYMHc1wGHqIfEJ8xAUCi8at04bQFz8GD3I/8Kj7sYnVrWvjXsXjWg==
X-Received: by 2002:a17:902:e80a:b0:216:6769:9ed7 with SMTP id d9443c01a7336-21c355c7dc2mr753720045ad.40.1738052494133;
        Tue, 28 Jan 2025 00:21:34 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9e173sm76602675ad.32.2025.01.28.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:21:33 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 88B8C420A74B; Tue, 28 Jan 2025 15:21:25 +0700 (WIB)
Date: Tue, 28 Jan 2025 15:21:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net, will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 11/14] Documentation: userspace-api: iommufd: Update
 FAULT and VEVENTQ
Message-ID: <Z5iThcDwBmBHZBJd@archie.me>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <300d03449b9420d756c1589e1c24bb8b4d508293.1737754129.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m1sZIbxqV2u1bbA+"
Content-Disposition: inline
In-Reply-To: <300d03449b9420d756c1589e1c24bb8b4d508293.1737754129.git.nicolinc@nvidia.com>


--m1sZIbxqV2u1bbA+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 04:30:40PM -0800, Nicolin Chen wrote:
> diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/user=
space-api/iommufd.rst
> index 70289d6815d2..b0df15865dec 100644
> --- a/Documentation/userspace-api/iommufd.rst
> +++ b/Documentation/userspace-api/iommufd.rst
> @@ -63,6 +63,13 @@ Following IOMMUFD objects are exposed to userspace:
>    space usually has mappings from guest-level I/O virtual addresses to g=
uest-
>    level physical addresses.
> =20
> +- IOMMUFD_FAULT, representing a software queue for an HWPT reporting IO =
page
> +  faults using the IOMMU HW's PRI (Page Request Interface). This queue o=
bject
> +  provides user space an FD to poll the page fault events and also to re=
spond
> +  to those events. A FAULT object must be created first to get a fault_i=
d that
> +  could be then used to allocate a fault-enabled HWPT via the IOMMU_HWPT=
_ALLOC
> +  command by setting the IOMMU_HWPT_FAULT_ID_VALID bit in its flags fiel=
d.
> +
>  - IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instanc=
e,
>    passed to or shared with a VM. It may be some HW-accelerated virtualiz=
ation
>    features and some SW resources used by the VM. For examples:
> @@ -109,6 +116,14 @@ Following IOMMUFD objects are exposed to userspace:
>    vIOMMU, which is a separate ioctl call from attaching the same device =
to an
>    HWPT_PAGING that the vIOMMU holds.
> =20
> +- IOMMUFD_OBJ_VEVENTQ, representing a software queue for a vIOMMU to rep=
ort its
> +  events such as translation faults occurred to a nested stage-1 (exclud=
ing I/O
> +  page faults that should go through IOMMUFD_OBJ_FAULT) and HW-specific =
events.
> +  This queue object provides user space an FD to poll/read the vIOMMU ev=
ents. A
> +  vIOMMU object must be created first to get its viommu_id, which could =
be then
> +  used to allocate a vEVENTQ. Each vIOMMU can support multiple types of =
vEVENTS,
> +  but is confined to one vEVENTQ per vEVENTQ type.
> +
>  All user-visible objects are destroyed via the IOMMU_DESTROY uAPI.
> =20
>  The diagrams below show relationships between user-visible objects and k=
ernel
> @@ -251,8 +266,10 @@ User visible objects are backed by following datastr=
uctures:
>  - iommufd_device for IOMMUFD_OBJ_DEVICE.
>  - iommufd_hwpt_paging for IOMMUFD_OBJ_HWPT_PAGING.
>  - iommufd_hwpt_nested for IOMMUFD_OBJ_HWPT_NESTED.
> +- iommufd_fault for IOMMUFD_OBJ_FAULT.
>  - iommufd_viommu for IOMMUFD_OBJ_VIOMMU.
>  - iommufd_vdevice for IOMMUFD_OBJ_VDEVICE.
> +- iommufd_veventq for IOMMUFD_OBJ_VEVENTQ.
> =20
>  Several terminologies when looking at these datastructures:
> =20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--m1sZIbxqV2u1bbA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ5iTgAAKCRD2uYlJVVFO
ozC2AQDPP1Rr/NEdpC96sqjf+s6u1DgXFgQ1dghVRl94136J4AD/UQWE5HkY2pgd
+/5yHWzPSekTkat+mn1D4NZcmc/8IQI=
=M8Cm
-----END PGP SIGNATURE-----

--m1sZIbxqV2u1bbA+--


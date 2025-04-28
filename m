Return-Path: <linux-kselftest+bounces-31784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC100A9F376
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC833BF1B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CA26FA4E;
	Mon, 28 Apr 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqPswbcY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33354207DEE;
	Mon, 28 Apr 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850697; cv=none; b=UBf03MSHCaBX69Szi1Oi+CyrWV0W2OgunfJH2Th/MOiXfuW8yGMBHkg3hmeoz5vx+svEsquxIqESc/EfgGNXI3enQ166r7Gymq6jPIyw/+Ke/vKk4nlos/wwcWPxs6opIzcRulpGm+F1a31+j4QObgprPYratDXyJA5NciYk4hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850697; c=relaxed/simple;
	bh=NHhnqNyU+X9x0PgjbHhqdTx3NWTApQzLscPiWXWZPWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmarWhr87CMJX9l+aq2aHQjQmTWbQB0TkIwi7TKiuTPtbORX796jmOqtqgSyArxk0cj7k5eNGOJhTZFYsHCbOTO1YPQDdgVB1MLd23cYSEX3rKqmyXiEPWg97z+bDXFA7VP48kDuuTM9wPAw8du0w81Wsn2GbcztkOy81oloK5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqPswbcY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4136927b3a.3;
        Mon, 28 Apr 2025 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745850694; x=1746455494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGHvgmXuRyhO4FY9ie5ulcZe9dpbfqVfa/omQpTJU54=;
        b=mqPswbcYGg8sVn/7UDHvK5aAU+GEZrHkNnDthCw2icPQ7KjEovPnUlDSSW26nIykjp
         3xfkL6dqIbtgIHkv3WIKl52NB5LTN1qLOFKc1EmAYwXzmDA/mGQDSMLPgXk7v1F1tvDR
         HLr27MY4PvU4GsYkB6iUS85k0d/0stQ9CgAIthmj7KJjtNysqvipGUMTHciBtE1aTn73
         tdF64fplQ/eF1E1bhJdoPZLleKFYOI8F6eay7cL7p5BrZyBl29p5+rIFNZvCqiJpnM4s
         K4LvYxS5F6kW8HXWg00Q0kiDCNCXqxjINBaEDYCAyiDAYaLm5WT4Dbuj1ALdCsu5ioR1
         90Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745850694; x=1746455494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGHvgmXuRyhO4FY9ie5ulcZe9dpbfqVfa/omQpTJU54=;
        b=GAfwMC42Fwu1G88qhvBv1DnzDqz+06qqwmL8O9oLd85jrU5h92uWGSth07FEjmiLUD
         LzdIkzvRNY4VTECkkXKVcuaFeyKmIF68EaibMgtTitwRLXBR54Ceu6UB74H4FWa1G1yU
         wWIy+kvkrEUIrPSHlinQUvhSOWnBgnvBhwBPDRxMaGxNKb/sPqU/hv3LsYnlvwNhqM5d
         J5EPtUmuzJGElIsVhRzm1rgHfcadtxY4eOTcSLnE74hvMYwu3rG9+xg5cKM5GEnDDwos
         faK9v5Qi1mSUGYyz8MwooUZHuLXThZN23zZb+tX78x7lNXJqnewp5iwmHlTocMyDbPCa
         +u9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSYcI9SFBjsjQJd/F76kBSvCao3Rab7Ze5snKsYFcBNP1dra4LSRuDVJ3aa3lL8v2vRVESs4JOuavMLMDfJOal@vger.kernel.org, AJvYcCXAu8L0hFaFy6HkSgEea2Of2P2V5XCSTtA7ha+mAOzxbgS4/69pT78prIMgDN3EVjxNVMUDLmRJffhk2Lg=@vger.kernel.org, AJvYcCXFGlBNqBgulh51rhVEXpvjTEe3bN3y/6FeyT+kVrF84l1XqvKGIxIjZGJG4Ag8sdzHt2Se6ZrDJ73UY14U@vger.kernel.org, AJvYcCXwk4zrlVfhX+QFR9e1qoL1JRZUWJPn6ohd5lB4s8+BL9Ga6GXtMVY9ABMmIDs2kkhfeClyIV9BGJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRj8XSHfZFNsb1TeSY1/Q5S6quL+2J9VmpNHVzUtvZbNPTPeo
	0AgPhtYhlnpMprmzy7obftqLOXbZZp3Bt78iIeHFwpI45RcSeM7D
X-Gm-Gg: ASbGnct1HIBuunopt/7OCJSsv76rf5FyVKcjZVIMBlfRxQnOG6uvIp9ukYyWAoBEsVN
	x1OdwNiE82L5AuAim3Lb3JCiTO8tIEKZHP5pOIoWqECDfFouWFDklB733PDm/3HVJmnLiswHcSw
	afOmS1Iia8TyjGysmaG7LeTU8xOtpheviBJ2pqXTVgfc+amCYps3JlPF4jdq/DB4g6b8P49zOKq
	sT2QBPOZfx9omaEDIOmyyfEoM5bzH3dUi/dKofjDvUm187/p36F+FbGC4Q0ED+gOiRyP71MmBmg
	Jr7HdLGOaHqgDpfHfvFuoP1MDWV6d03eeeihhtNo
X-Google-Smtp-Source: AGHT+IGZk7PlsdCZr/j/ecR8nUYCM0KRmxVw7bgRrpwVPA2oV8otwvEl5YVA/3glGzlDDrcVC80bqA==
X-Received: by 2002:a05:6a00:114a:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-73fd9047c3fmr18100251b3a.20.1745850694197;
        Mon, 28 Apr 2025 07:31:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a995sm8016677b3a.112.2025.04.28.07.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:31:33 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6E52850790E2; Mon, 28 Apr 2025 21:31:31 +0700 (WIB)
Date: Mon, 28 Apr 2025 21:31:31 +0700
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
Subject: Re: [PATCH v2 15/22] Documentation: userspace-api: iommufd: Update
 vCMDQ
Message-ID: <aA-RQwyTS1m4CuPw@archie.me>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <820dfdee121292fe4cf891feb86f82ceea521e22.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vD4TXIxpca4CWbLZ"
Content-Disposition: inline
In-Reply-To: <820dfdee121292fe4cf891feb86f82ceea521e22.1745646960.git.nicolinc@nvidia.com>


--vD4TXIxpca4CWbLZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:58:10PM -0700, Nicolin Chen wrote:
> +- IOMMUFD_OBJ_VCMDQ, representing a hardware queue as a subset of a vIOM=
MU's
> +  virtualization feature for a VM to directly execute guest-issued comma=
nds to
> +  invalidate HW cache entries holding the mappings or translations of a =
guest-
> +  owned stage-1 page table. Along with this queue object, iommufd provid=
es the
> +  user space an mmap interface for VMM to mmap a physical MMIO region fr=
om the
> +  host physical address space to a guest physical address space, to excl=
usively
> +  control the allocated vCMDQ HW. Thus, when allocating a vCMDQ, the VMM=
 must
> +  request a pair of VMA info (vm_pgoff/size) for a later mmap call. The =
length
> +  argument of an mmap call could be smaller than the given size for a pa=
ritial
> +  mmap, but the given vm_pgoff (as the addr argument of the mmap call) s=
hould
"... partial mmap, ..."
> +  never be offsetted, which also implies that the mmap will always start=
 from
> +  the beginning of the physical MMIO region.
> +
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vD4TXIxpca4CWbLZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaA+RQwAKCRD2uYlJVVFO
o1eFAQCh6j1PsCslXzfPWuS46AzQ1o7ZR1WP481iUjIyZLhY3QEAixFoHFuftiEx
UNcaIuEJ2lZEhZxTyJA7ccrRXFyIfQo=
=VsW/
-----END PGP SIGNATURE-----

--vD4TXIxpca4CWbLZ--


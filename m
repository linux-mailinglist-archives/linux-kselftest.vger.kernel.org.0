Return-Path: <linux-kselftest+bounces-21660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033379C18A4
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 10:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 448D9B20363
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25131DED55;
	Fri,  8 Nov 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlysotjo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2C1CFEC0;
	Fri,  8 Nov 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056475; cv=none; b=p8Fkzp38drZLAGiZkogkwpVtGkATVsg5V/WGCaWxGHJhfLIQsxruF4IreSczqs8ta9otmI9Yq+WX7Jit0aYkMXH9SElcykdjQdlDTslFL03Fch9eeT35w5/YDi7D6XLRQv0xqvQcSsR3uisogVqEZx5inqNS7Z7IEeHWH1ZSBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056475; c=relaxed/simple;
	bh=r7dhSFhEQTew+9UGW/kckZn/abgjeJ3S6PdMpu3oaMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX8Fd6nkACaq1myDaMjze7HKa9iZ7g6QAld68W4D+o2DWBUy3cHQhtaWp2YkQPw83yXtNFOmLFaelwfRpPx2ONEjJZ7wrzcL58Jvkh6aFVlLH+gbNziKSr/5R3C4Sy8xz+lwd+yqpAj8yKqdbavyWLRokoOJzPhfdXZmR/MnHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlysotjo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cd76c513cso17959285ad.3;
        Fri, 08 Nov 2024 01:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731056473; x=1731661273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6cfQLZyY3ukfMaKhn8AcRbL5Ti2ytAzkKnIriORiIs=;
        b=Rlysotjoj6eHIsovMngZ6xkAvzX7h/i4Rmd2dEiyt2JC9avqPq82dDml8cGmEpLFwR
         opn1i+GxlRPjrdaVYo4J9tQq3zgvRx74ghBmi8l2Ds1tf6UY5462cjTp58YsNuRa/wxU
         B0IbVCg4P9TStPGv+IncMrllC/mmBmBEmyU3GLe85wio4Z+ddsbFCmm0D0P6OKbmdFb0
         4ryKUA544HN5LsTXaJy1AN/YOgMi6hABjIybgN7g4LUaoSaDygBz8qmqI/6dnS6m5P61
         GH0rDodchf7SHUdMixsUo7zyRC1jB9b9eKg4wYKzroo2k8P9ERbVbDtwTbYHBdVovnCv
         M6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056473; x=1731661273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6cfQLZyY3ukfMaKhn8AcRbL5Ti2ytAzkKnIriORiIs=;
        b=EyK58+2v6fZHDrJsG19kzWJkE4r1WtOdb6fyq7yOOK3QMKzHjucYeTfVzsvYFG0cdm
         kXW3MR7f0ztXkdzcL9WmekhPhWmOdD1v7q6tv7NBAacrXDc2687pRQvJxTIky+e6jRlA
         0ItMCxAWeNOgrRaR7Hy+jIGXAk2PTYR+gjPaco1iBLp0MbFjxZEhQqbLcLkQ1Q3Fo5HN
         //kcKh4mnmO50JCQlbAbkGutEvCtjqTFCqHW6dRteurPACTgUWBoFsiSqmMr/U5DTJS1
         Lh96wYmriRQBPQJpP0b/GMVnLA0sBj84w6fuNPl12LfCAOcQkh4DAnCECntcdUjDYgr6
         xtgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+hbD+WYFeOPWSWQsxQslC7ut7Zz3NPMjwdRKkUTEfWsSpiGgzez/I3uHNE5MFeBEZ9PjAkwljvC4=@vger.kernel.org, AJvYcCUD+zVYkM29b3pu/uaSB4h9ukz7tlOqAgN+Y+mu5/Q2d1N7ZQkLjT1dVS35+kFDPrjqxRFh4IXY75VAwuSz@vger.kernel.org, AJvYcCV/cLkshYUSkOGTrVbdSS5kcQ5HHhMp/0gG9Z+t1pU1kyRjxTGF6wt/lg8SYJzHQR+l/yfMM0oJAtU6hudAptBV@vger.kernel.org
X-Gm-Message-State: AOJu0YxdNyqoyKNtbbNBsSMKOe1n0c+CeqgTtrmAnT7ylkM0YxskvlQv
	cp3eWijwD8EFsdEPBgirvhqmL+DvZHLWMmFYP4VBEs3FAbSLIZXQ
X-Google-Smtp-Source: AGHT+IFAKsAR11eiAB06tJVCWRmKkiTYy+qwV59/n1Yu3J0B6yv38u/J2j1MdEsTHqkgJx1Aehln/A==
X-Received: by 2002:a17:903:298c:b0:20c:ee32:759f with SMTP id d9443c01a7336-211835d8bc0mr26836995ad.39.1731056473362;
        Fri, 08 Nov 2024 01:01:13 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf0f5sm25712355ad.79.2024.11.08.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:01:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 63F6841E4B82; Fri, 08 Nov 2024 16:01:10 +0700 (WIB)
Date: Fri, 8 Nov 2024 16:01:10 +0700
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
Message-ID: <Zy3TVlLKAg8QM9yP@archie.me>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <ZywQP3_TpdttuCy8@archie.me>
 <ZywZcSidYCWkJgrw@Asurada-Nvidia>
 <ZywyEUmL4HvM8B9v@archie.me>
 <Zyw8OUTLrG3Yx+Yx@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1FskY10utNP/LXKg"
Content-Disposition: inline
In-Reply-To: <Zyw8OUTLrG3Yx+Yx@Asurada-Nvidia>


--1FskY10utNP/LXKg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 08:04:09PM -0800, Nicolin Chen wrote:
> On Thu, Nov 07, 2024 at 10:20:49AM +0700, Bagas Sanjaya wrote:
> > On Wed, Nov 06, 2024 at 05:35:45PM -0800, Nicolin Chen wrote:
> > > On Thu, Nov 07, 2024 at 07:56:31AM +0700, Bagas Sanjaya wrote:
> > > > On Tue, Nov 05, 2024 at 12:04:29PM -0800, Nicolin Chen wrote:
> > > > > With the introduction of the new object and its infrastructure, u=
pdate the
> > > > > doc to reflect that and add a new graph.
> > > > >=20
> > > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > > ---
> > > > >  Documentation/userspace-api/iommufd.rst | 69 +++++++++++++++++++=
+++++-
> > > > >  1 file changed, 68 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/Documentation/userspace-api/iommufd.rst b/Documentat=
ion/userspace-api/iommufd.rst
> > > > > index 2deba93bf159..a8b7766c2849 100644
> > > > > --- a/Documentation/userspace-api/iommufd.rst
> > > > > +++ b/Documentation/userspace-api/iommufd.rst
> > > > > @@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to users=
pace:
> > > > >    space usually has mappings from guest-level I/O virtual addres=
ses to guest-
> > > > >    level physical addresses.
> > > > > =20
> > > > > +- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU=
 instance,
> > > > > +  passed to or shared with a VM. It may be some HW-accelerated v=
irtualization
> > > > > +  features and some SW resources used by the VM. For examples:
> > > > > +  * Security namespace for guest owned ID, e.g. guest-controlled=
 cache tags
> > > > > +  * Non-device-affiliated event reporting, e.g. invalidation que=
ue errors
> > > > > +  * Access to a sharable nesting parent pagetable across physica=
l IOMMUs
> > > > > +  * Virtualization of various platforms IDs, e.g. RIDs and others
> > > > > +  * Delivery of paravirtualized invalidation
> > > > > +  * Direct assigned invalidation queues
> > > > > +  * Direct assigned interrupts
> > > >=20
> > > > The bullet list above is outputted in htmldocs build as long-runnin=
g paragraph
> > > > instead.
> > >=20
> > > Oh, I overlooked this list.
> > >=20
> > > Would the following change be okay?
> > >=20
> > > -------------------------------------------------
> > > diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/=
userspace-api/iommufd.rst
> > > index 0ef22b3ca30b..011cbc71b6f5 100644
> > > --- a/Documentation/userspace-api/iommufd.rst
> > > +++ b/Documentation/userspace-api/iommufd.rst
> > > @@ -68,2 +68,3 @@ Following IOMMUFD objects are exposed to userspace:
> > >    features and some SW resources used by the VM. For examples:
> > > +
> > >    * Security namespace for guest owned ID, e.g. guest-controlled cac=
he tags
> > > @@ -75,2 +76,3 @@ Following IOMMUFD objects are exposed to userspace:
> > >    * Direct assigned interrupts
> > > +
> > >    Such a vIOMMU object generally has the access to a nesting parent =
pagetable
> > > -------------------------------------------------
> > >=20
> > > The outputted html is showing a list with this.
> >=20
> > Yup, that's right!
>=20
> Thank you! Would it be possible for you to give a Reviewed-by,
> given the condition of squashing this diff?

Alright, here it goes...

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--1FskY10utNP/LXKg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy3TVgAKCRD2uYlJVVFO
owxHAQDaL5k6OGmeg6OIUkQWv58q/7TdrLW4R+pXT2qiFeOTVgEAxgUGl1Wm834W
z966YlZs2fScS9LRewetFnpFHRzY7gU=
=wjrM
-----END PGP SIGNATURE-----

--1FskY10utNP/LXKg--


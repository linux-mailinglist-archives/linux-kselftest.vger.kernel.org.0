Return-Path: <linux-kselftest+bounces-33033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C3AB7DB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70138C23C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9F28E604;
	Thu, 15 May 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jarsZTF3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936E61F09AD;
	Thu, 15 May 2025 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290067; cv=none; b=O7eHSZNn4JgLiDq4tL8VxfDY3QErrOcG9M65TePseZmKm2uwiLv9ktAktDijm9pEA8/3mgtfTYW+Ln6EZIS/0Nq8O99iHPUS1wfu1DBpHehnH5EXWAIhLYuiC1aSbBGKsHG4dMVWpL68mWd0IlFpluNgndcANgUoKtI9/mbPlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290067; c=relaxed/simple;
	bh=Y0utQwgG+0/00zaY4pvw7rTT02GtDjLu32klA2peLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlP9dpipO97e3JTKoazK6Z2j2WMSeHS0bZh6heXJ6JNfPE5lxW63COt2/iLb0xjeHkyN8E//2cDPSakxT+5CYP4m1Qoqi87vQU+CNG4U0W/yX+/JAzra/YPDjbmVkfeueqZ79EuI7m1K7dRbMVYN/4+/aV1fvRXwI90K1UGjfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jarsZTF3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7370a2d1981so503238b3a.2;
        Wed, 14 May 2025 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747290065; x=1747894865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rX9E2fNDjY1FkX+1lQiyuuYgRxE42Kp5wv+1x2j0YrU=;
        b=jarsZTF3MIbZtripDqi5lnGSxmh0wXi9A0h81TKTGLpaK9BE2D7KMivy8Bv6bWiI5E
         1Fk9y27OrVuUCDhggrfXWYBDyR9BtBWX4OB9g377GTZTOcalgavk+bfvX2gXWVSv6Q42
         D1JAkYf7GUhfgpW+97xC48Efs5FNB5Cx2sO3WTtdqQW9rLkbfwgyLe+Hwj5ta9V1pSXG
         4qZEZcrAORlGGmM+MP98q2Q4Isbp9qbEortgfD6ZHot1vkQeOb6kMQnvybpNaPFEUOYQ
         cULFafrXlB6GoyMbOSTOaOuXH89sWP/Bc9jhKbrrZq1yb8O+4uKc1ZIvabMrjQurYwhr
         pLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747290065; x=1747894865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rX9E2fNDjY1FkX+1lQiyuuYgRxE42Kp5wv+1x2j0YrU=;
        b=lsCmpDRXbzdWGIDwazezIHZb4/wDNK/MVSD2nf6TdFEJDjSXEOmFbRlmyQT4LtaZjf
         n9zfNOfOOk87BxMW1qInDUyGd/D6GCfCdgUu1kJ2avXyvKpL/L0kDLM8AC8HAq2VYxiJ
         7T8uv8HVr9hhqLTNvcyW4emgxoJuak3jVEZV3n7roLlQYHCYIGfFjOzRAi30JY8vF9U1
         alo8Wy2/9hhV09bR56Xl/Sf5gbIT20805gTqUMKYV0tDMfaaFwBzOS8f3dBxerr9bIr5
         6gEzrbOAR0hsKD6av1idyaaRiA1cloIp0W83i8XBO9f+c8pQDLuC8AjddbnzvruhQ4UU
         N8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUup7qyXldt5UQN/h9i3Qplesub75LiyuaLOJ1PbQ7bVtZLXeUX4T/iVPL8L5MFDxmkq6je0AHl1ms=@vger.kernel.org, AJvYcCWA3R7uC+xth43KwwATFrrgh8Sn7LTREHVC9dAS9eN4zDS5lTiHTJEoRiN77sSrcIU7ZqEZaC18ZqLHYKocuXrN@vger.kernel.org
X-Gm-Message-State: AOJu0YzyL5mRy1LjCHEm/G/wAuLaLgUF/e7iF9J8aoT8g9LYNi5cA4qg
	PMEq+FRoObvPZXVnhUJ+7IM1NUR3ReIatbuYGuW2LtBNjLDFjama
X-Gm-Gg: ASbGncsGviZGiSUTkWGtWLSK+w15/leyJFZD+wQfRncsQPYx2lgn5PREHE72a0p6Jt3
	m+FJLWg2+TkEwNjSwd1RSwduo7Vd6nObBORt3/jef68IeGFmR94hvwLmEX0cvTWld6bNLguNZv7
	/XU4yOQjEptRqFcLURwLqPsrpClbKkixQGL2eumNEbKq9rkv8kneXaiMWcADjEHUf+vsa2dwtsF
	Fp4eDhHJVnmYSzniqoRfbBxGABA47ffEy0joY1eTzxTDPEUCt74qAJDpnFC8fLcWaUBXTCFwHp+
	ISsmOssLA7mhN4MLHwGBnN+C1OMhTnlwxs5yHqOhmQtnGNCnE5dw6fuy8Y7fPw==
X-Google-Smtp-Source: AGHT+IGC9DxnW6VX8KRj7lnR0AoZt7AFYBd/MB5hYLPAc8e+rz+OD5MDD15P8NLcNibjdHchDrUuSg==
X-Received: by 2002:a05:6a00:1389:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-742984de2a5mr1750626b3a.10.1747290064582;
        Wed, 14 May 2025 23:21:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ab52345sm9796290a12.33.2025.05.14.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 23:21:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 842B9409AAD9; Thu, 15 May 2025 13:21:00 +0700 (WIB)
Date: Thu, 15 May 2025 13:21:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 02/15] genpt: Add Documentation/ files
Message-ID: <aCWHzFZWzeO_9HYe@archie.me>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <2-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <aBrHU-OGbfqk1DSq@archie.me>
 <20250513185310.GA451051@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f31gHTPz9TUWOOq1"
Content-Disposition: inline
In-Reply-To: <20250513185310.GA451051@nvidia.com>


--f31gHTPz9TUWOOq1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 03:53:10PM -0300, Jason Gunthorpe wrote:
> On Wed, May 07, 2025 at 09:37:07AM +0700, Bagas Sanjaya wrote:
> > On Mon, May 05, 2025 at 11:18:32AM -0300, Jason Gunthorpe wrote:
> > > +Since each compilation unit can only access one underlying format at=
 a time,
> > > +code that is intended to be generic across multiple formats has to c=
ompile
> > > +itself multiple times.
> > > +
> > > +In an implementation compilation unit the headers would normally be =
included as
> > > +follows::
> > > +
> > > +	#include <linux/generic_pt/common.h>
> > > +	#include "fmt/defs_amdv1.h"
> > > +	#include "pt_defs.h"
> > > +	#include "fmt/amdv1.h"
> > > +	#include "pt_common.h"
> > > +	#include "pt_iter.h"
> >=20
> > What do you mean by compiling generic code multiple times? Including
> > their headers at multiple places like above?
>=20
> How about like this:
>=20
> Instead the function pointers can end up at the higher level API (ie map/=
unmap,
> etc) and the per-format code can be directly inlined into the per-format
> compilation unit. For something like iommu each format will be compiled i=
nto a
> per-format iommu operations kernel module.
>=20
> For this to work the .c file for each compilation unit will include both =
the
> format headers and the generic code for the implementation. For instance =
in an
> implementation compilation unit the headers would normally be included as
> follows::
>=20
> 	#include <linux/generic_pt/common.h>
> 	#include "fmt/defs_amdv1.h"
> 	#include "pt_defs.h"
> 	#include "fmt/amdv1.h"
> 	#include "pt_common.h"
> 	#include "pt_iter.h"
> 	#include "iommut_pt.h"  /* The iommu implementation */
>=20
> iommu_pt.h includes definitions that will generate the operations functio=
ns for
> map/unmap/etc using the definitions provided by AMDv1. The resulting modu=
le
> will have exported symbols named like pt_iommu_amdv1_init().

Looks good.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--f31gHTPz9TUWOOq1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaCWHxQAKCRD2uYlJVVFO
o0FXAP4iCmmk84hht6kf2sEA0RKGTnBFYncYtLLZAzm6KR5/XQD+JRx9nw4yvScz
7ofsZTjk1W1XHG86xjzZZfrMX+rmDQQ=
=YGBK
-----END PGP SIGNATURE-----

--f31gHTPz9TUWOOq1--


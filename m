Return-Path: <linux-kselftest+bounces-35155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3557AADBEDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 03:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2CB16E3C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992331C84A2;
	Tue, 17 Jun 2025 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzvWAto3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329631BC9F4;
	Tue, 17 Jun 2025 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750125580; cv=none; b=ovKpI78kVkT0Qjy8u9vFRjYSxfULKvlGxzZoMjFrSB115Uad43yvVCgwOMeBO5EBOQMJF8g6brfpNWhDGM/uAu6/nwg3adHtU2Yxdzo8C13R+GmsCg2Z3wkomZ9IhHxi0LBcqJSGic0A6pjEDK6ShUc1oQV6oTZD7SSd3ig5rWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750125580; c=relaxed/simple;
	bh=+Coljb4R4UpMZYUnBt8a/U8959C/WB4Dycfl9OSu1vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd+VLWE/mBNE2fZwmhlzSj4Gj3TjW9FhoUltM2RV0IAUDqofilmz0BAN1cXcQAF4999f3qgIu6t/syJvhbUAg0LoFh0N1AoB7bjRFMiMta+oaJJ6sbFxIKvzC26iFYcipaWfugfzFKHasenrI8HlB1Nlzxklrn3788Mgw7LoU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzvWAto3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235a3dd4f0dso32932615ad.0;
        Mon, 16 Jun 2025 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750125578; x=1750730378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hX1AMDY5tzO+6pgqDEAwgTSbR/ALB7lMXeQZAvSn1M=;
        b=fzvWAto3/KpxKSb6bpw+Etr7075i5RWO78niaZdPuK8nubGIMQDHRb10bz04iXJFeM
         7bGTUL8Y2/AqJMaAIFnysAGeUOs4aaiAQXVs41vS8+JnPlp96B8WuJc3+/2X9ImW+ife
         0bGCllSh4vbF//CbfWpQcuo3yQITIr1exuoyM8N+SFhMDjVsNNho0CpUFDpHfODntP/r
         anwqTchL1J1K+rFdsMMczki3MNa3F2yaYSYaYNbmkxUGu4E/oB3iER5NL8ig10DIzT1j
         6aYmDwgazrux+afwIUZYucPhzWe6lzO/7BCunb55W8RFTyapmGYfaPTplMuWaAMQdwTe
         IQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750125578; x=1750730378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hX1AMDY5tzO+6pgqDEAwgTSbR/ALB7lMXeQZAvSn1M=;
        b=P0oGa4cCyJs45gl1l2yhjP1wYbbyy4FSWiDu7NHk/j8DZwwUPM5phHXOGiQdck1T8g
         CjcpgxS+Ku/eFcfc45u/DAxuLxlPwkDPkXvUGyCec/VPYpRCzHUauzkDe6yK3Dj8NS0o
         ZX5vxzS7FtXIVqKEEOoQlphUmQie6O/rSxE5lf7gNGy/S0K7x146fkL2+3wqa1Svqq1w
         HrM2NeeutHUpGUt4WtRcibZTU6woFzb5OWYzl0pUiwV8maUT0G2yVE374JCidxMeNlSw
         zh2nbupShHd70URS9Ja7+HADoL7mDmUQsrCJKXc90R/VYQPWak6qHmD2pYSmtgMba9ug
         ytaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQyiwLBKFxL48/rXvPsXUWbt9rsvGaUCgYcpZ97bn8j2NiJd4gVjFJZKSJ+R5j6TZJ7E717+D5A181fXDqmTlJ@vger.kernel.org, AJvYcCWIBbY7s5gOjgij9OIBWlioOMo+6q597Q2PXSKDynoePP1ew3Nvw5L9NdqsKbN5Ops8BkWZHTy3aEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbf9iR+8TkgBCwth2xPxJvriH18eitSGL+iSnOPnLZlEwL6jam
	zKrPM3g2FFfNxBfLDb84Qj1OMe+QK0e8tSRT8g2X97Z3RR+63B3jflci
X-Gm-Gg: ASbGnctp0jmWcfygt5HKq09whmjPpVl9kAX3ZTLd6FL/EQf7J6k6o/GGXlSI5gqxjvY
	IiVP6GWRK8TbWMmNYOsRxXGEO0RuH7Gt4odhQwzOXAURJyBFIwLM7boe5E17B35UPhzQM9pGtQ8
	47vbCPMebLUrUr3HDlxGHfgXBHGl9+IJEZ7LYdkdBhNfiLiovGjqDD9UZ5wku7C8wpgCT50KE3i
	aDqcZw6fTok1mUmdRjLiR3C+7jRBlV46gEEAv0wzs5qzoTVz2a916GR8ZNDhQYfN0++G3OxfAM4
	TL4IxIy3O0C3ROck+IVCKSJ+owFMi2U2/HyTEFynTyIN5L9Z/O4MQEopuLze9g==
X-Google-Smtp-Source: AGHT+IENVlr6sfypZBCSgv1TrxLQcdnU8woHB/y1+TMTtAT53FcBiiSN7tzD7G2ULV+Kckou8Pa6UQ==
X-Received: by 2002:a17:902:f551:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-2366aeea034mr181020465ad.0.1750125578166;
        Mon, 16 Jun 2025 18:59:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea9259sm68798855ad.157.2025.06.16.18.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 18:59:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BD1934241812; Tue, 17 Jun 2025 08:59:34 +0700 (WIB)
Date: Tue, 17 Jun 2025 08:59:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 02/15] genpt: Add Documentation/ files
Message-ID: <aFDMBt1J1w8I_A8U@archie.me>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <2-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4/ywsSHr1lDelbCB"
Content-Disposition: inline
In-Reply-To: <2-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>


--4/ywsSHr1lDelbCB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 03:06:05PM -0300, Jason Gunthorpe wrote:
> +The generic tests are intended to prove out the format functions and give
> +clearer failures to speed finding the problems. Once those pass then the=
 entire
                    to speed up finding...
> +kunit suite should be run.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--4/ywsSHr1lDelbCB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaFDMAgAKCRD2uYlJVVFO
o5mNAP9EmUtcal7Izvqw7lP3O9S78LPihsJ1bErtgFPJlzLqWgEAlIEmVujduHqZ
WoGwLnF3VHBf8yd0JdamQ/i9qhWhagE=
=/KQE
-----END PGP SIGNATURE-----

--4/ywsSHr1lDelbCB--


Return-Path: <linux-kselftest+bounces-21528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9579BE850
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B951F21DFA
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677B1DFD91;
	Wed,  6 Nov 2024 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXx6FtH7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06871DF736;
	Wed,  6 Nov 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895797; cv=none; b=In232tsZuFG8nFDIO7IBFY2HRZCp4Evbc2WF6wNHQR3YtqxMp7PGryjUnhBrnK/1XTuSwuHtwSRKYHkp/Phlgke4hCXx9lIM7VE4spcnFAeWCNM7AhLHEL0RTTESjiEgqJRuGIgPSNvJdgHOg/c1FuSzkFDyGVOHVSdrDdJAh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895797; c=relaxed/simple;
	bh=LOcx39WpVkgfByGcE2LRb/j3Yp/QZsre70eNEo5cn4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZATViSbhxNkdIQFkq4GttlexRha0yrXI7N4H5UrqpfKIEz6FQYTK7tZ1vhIJMLRK3egd1ZLwOlWwE0AA1lYbBqomZf0MgIcotIaLiZAgXWqcQjoRtDzclvjL8IkP6j8iDJeQLHt62qCV6GZeVWvwmEyjPzW29sgwjltat868Vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXx6FtH7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720be27db74so639848b3a.1;
        Wed, 06 Nov 2024 04:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730895795; x=1731500595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOcx39WpVkgfByGcE2LRb/j3Yp/QZsre70eNEo5cn4U=;
        b=XXx6FtH7krhWL5ZRyU+Ilk6ciRc8Dycvxx6Ve+9vbJz+C6f5989GGiX+ZfM2tADOlt
         BPClAo87eJXrzVHEzoG+FI/foO5IESSJuY+89pM5Mz78dEI0K8rR/3hpYpIbJt+I1Vu+
         E5DZW2ETXLHiY2bg3YAnTMOikyw3EUybnUqsS4RLRjQRseERAcZYZpqGRhlO2yyv51rz
         oggBuKGw6pfelfbYOOOFuGC21Ldvr5rNb2XVyAbbD1cGZWiwLNkXboYVSRHmnkOHjVGI
         rVn/pmCpkGirklgs1CxoTdzR/L12O8RedL1PnlHK3fmaPOC5B8J3xWg9uCapshsnEam7
         O4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730895795; x=1731500595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOcx39WpVkgfByGcE2LRb/j3Yp/QZsre70eNEo5cn4U=;
        b=PpcM7Z48MZ7zW9Izdz9AqtUwx3FLSv/fAg3ScVlqm8LW0QcaGmbKTEzNrMfN3gGnpD
         m6XFynODXedFSn2ya6/Awj4l1r3ZsTsSbbfApokv7BMhPt2eVpJoNE4/Q8GhbsIncoxb
         6rUz26/x5q5kO/ZXJwGGfcwO6k8ax80LEl/NgukVJFm24IKc67nEvRhGGrxvaEpPt2zD
         pEKwYW0QuCIH+WvjhXepi932VH5Bo+Kp8Pk964mjuyhazjrTzJUDQr6slNbuMMiq73Se
         X5Ave2q0zWMvPAud6jwE7oHowDMqqaIcnU6WY49784qAd6AoomEKJseZWqqTbadZgN+/
         pn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5FwfmjuZ40+r2Bd4kpC88vMNOgFj3jyZnSghjrUpJOtomBqirVB+4TwCpOzyryF74Kr+YlbnuJz+ndhe+@vger.kernel.org, AJvYcCW55TZZZr38Yr4mI6onjG6aWhPW3OzPp5Ux/4H64/ACkDKHK9Ic13EaQyQZ04zkz1VaPqkdR+PFPXpiWmu48paV@vger.kernel.org, AJvYcCXv2+HnnLg2WZjvi3bImgLtHO5nGsoRy7q8Oj/U3ZqvgwLtyIa+bTqMtN+pykSDdbNFI5URptxAm98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtiYv9Qd2nBVMutzLhLdfCD7Zzc+Ozb9zZ3hXaCjNrhoAfnJvg
	we8TZvdZ6xmo9ff1/zCUSLtpFhQMjtrCUF1/QxDs17sMvNuaVNP9
X-Google-Smtp-Source: AGHT+IHlm62VXnUBPd59sCVU+HT7bAgeu3hCGilmSCgsLu4geYKqabYoClmdsAEnS+JE+O9J3JzzKg==
X-Received: by 2002:a05:6a00:2d9f:b0:71e:60d9:910d with SMTP id d2e1a72fcca58-723f79bb0f7mr4043502b3a.6.1730895794957;
        Wed, 06 Nov 2024 04:23:14 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb3cfsm11545357b3a.151.2024.11.06.04.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:23:14 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6E2A9447D1DB; Wed, 06 Nov 2024 19:23:11 +0700 (WIB)
Date: Wed, 6 Nov 2024 19:23:11 +0700
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
Subject: Re: [PATCH v7 10/10] Documentation: userspace-api: iommufd: Update
 vDEVICE
Message-ID: <Zytfr7p_EpJhJn41@archie.me>
References: <cover.1730836308.git.nicolinc@nvidia.com>
 <e1ff278b7163909b2641ae04ff364bb41d2a2a2e.1730836308.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syaj6gmswHEiPKJ3"
Content-Disposition: inline
In-Reply-To: <e1ff278b7163909b2641ae04ff364bb41d2a2a2e.1730836308.git.nicolinc@nvidia.com>


--syaj6gmswHEiPKJ3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 12:05:18PM -0800, Nicolin Chen wrote:
> With the introduction of the new object and its infrastructure, update the
> doc and the vIOMMU graph to reflect that.
>=20

The docs LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--syaj6gmswHEiPKJ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZytfqgAKCRD2uYlJVVFO
oxifAQDdYsaaemlGOg+HrwqFiJ4FGcIBJuGbdcKG/6uUBE3M+QD9HxxzagI26xbd
JHDxjJmzYXAcyjOWhV8j58xav3gTZgU=
=8SqO
-----END PGP SIGNATURE-----

--syaj6gmswHEiPKJ3--


Return-Path: <linux-kselftest+bounces-5720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2072686E17A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5324283B93
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3AA69DFD;
	Fri,  1 Mar 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="od9DJPKg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB03FB88;
	Fri,  1 Mar 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298224; cv=none; b=qoROA6c8jOY8uN7NWIft369vTPd6X173Jbju9WsJXoEam+pxGWo9iRU0onOvHdz13H6xeTDYRB085Wpb9NTRZ6obai3njNWN00WzIODwYbMQTDPC5PZZhj6K9N3ke5SyTSMzCh/0UzxFVFoIpAuA6HRU38HIMEuzurgrRYPt8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298224; c=relaxed/simple;
	bh=XVWHgOv8IhoO1Wovn6/Qb2yGIBl4zlvLX2d0j1c6F7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnxOr7DxHqIF33k2Yi1Qy8hQY4GECk5tL8NFmtEPwOTA1b607shQrrlEBeBrwETk0LUerTiIYARADJuLO2Ct79p3TSuINvY6rJphMzJi26dZrtBTr5iACQP5XXlXWADsg5Eu7sQAhVDbLaBIdK9hsXD3KNJXATipU8zxBOUx5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=od9DJPKg; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709298222; x=1740834222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVWHgOv8IhoO1Wovn6/Qb2yGIBl4zlvLX2d0j1c6F7U=;
  b=od9DJPKgkHf6JgXlsx2hSM72wI9FzzkT92WXTyAt8cLSNVDBH6w79T8m
   GWONungnzTV1IdMMSjye9XnnVJcDpJa/DE/GFJKATsPzFTNMOt9aT4BVl
   6Qf+eg5kRtv7V0Pr4NAfMzI3YA4sDxrhzibpery+XQ66QxckPeDUyC9PO
   hTdNz/lPMf2rd4sgz+HLjeKWHwB6fpBjLCor2iP3ajPynFEA9WlSMx/H/
   hQiciA6xLU+88mSWDlI6w0S9TAZcOewX7B96AnyZD4U1VGnZpRSvNtOxB
   AzLSpDusbGD6ltlG4QstNuH4KOzZeAOX4hg+Mj7e3cNSVXD0q7h3g09Yw
   w==;
X-CSE-ConnectionGUID: B8GzHJbiTdOd45juRr3szA==
X-CSE-MsgGUID: v2RSYSlqTES/9dwmI5yorw==
X-IronPort-AV: E=Sophos;i="6.06,196,1705388400"; 
   d="asc'?scan'208";a="18677917"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 06:03:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 06:03:27 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 1 Mar 2024 06:03:24 -0700
Date: Fri, 1 Mar 2024 13:02:41 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Yangyu Chen <cyy@cyyself.name>
CC: Palmer Dabbelt <palmer@dabbelt.com>, <alexghiti@rivosinc.com>,
	<andy.chiu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>,
	<guoren@kernel.org>, <jszhang@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>, Paul Walmsley
	<paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 0/3] RISC-V: mm: do not treat hint addr on mmap as the
 upper bound to search
Message-ID: <20240301-patient-backpedal-f0e9333d3b8b@wendy>
References: <mhng-67b02dff-5423-466d-bd90-f3ad3a3ab6a9@palmer-ri-x1c9a>
 <tencent_BA062F64BB719A8F42F0435BCD3117B73F05@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TtKYHipymQ1kqmeZ"
Content-Disposition: inline
In-Reply-To: <tencent_BA062F64BB719A8F42F0435BCD3117B73F05@qq.com>

--TtKYHipymQ1kqmeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 01, 2024 at 04:54:05AM +0800, Yangyu Chen wrote:

> Another concern is that if we can't make this decision in time to catch up
> with v6.9 we don't want some bad things to happen as a large number of sv48
> machines might appear this year and they may run on the next v6.9 LTS
> kernel, Shall we change the code in the kernel to use sv48 by default right
> now?

Just pointing out that v6.9 is highly unlikely to be the next lts
kernel, depending on whether or not Linus delays some releases, it'll
most likely be either v6.11 or v6.12.


--TtKYHipymQ1kqmeZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeHR8QAKCRB4tDGHoIJi
0s8fAQDEhn3LtPgIBbJeywYsW5zoE8XHl7tmIMdJIjMWrFfPygEAiml/BgsyQQtP
+pjfl+cmRe2HDnQTEEwjNwMlo/Sz0QQ=
=1CU+
-----END PGP SIGNATURE-----

--TtKYHipymQ1kqmeZ--


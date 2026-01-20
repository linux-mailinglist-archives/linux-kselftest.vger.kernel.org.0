Return-Path: <linux-kselftest+bounces-49441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE782D3C14A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF42A3A78F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 07:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D457D3B5304;
	Tue, 20 Jan 2026 07:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BCtYGoTe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC73AE711;
	Tue, 20 Jan 2026 07:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895849; cv=none; b=ISaVUVcsWGktRKGDIOwq1D7GJkeCwcls0LOfUdfMlVsTtrGm935RRHfhUVNOmXsfQ4NHKXIl8e4K1f1ocI5X9Qo6zgfJOI/GRa3CPi25lboHDSnVM6SsbCQvJiZPR7DWfAW2s1d5ykoD8s98TXiusfD+dLU0FGInf8nHiVLcD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895849; c=relaxed/simple;
	bh=73aF+Gs0h1WhiEj29a8BjiazJYxWxsmFN2pNxL8Wtag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcvILXz/lPgvS5TE49Hqy4vUEUUZ2g5n+ylfHirRYf9Y791jFq6UoMBZs1Y4EBShkMvzBGymS4g/GEuinzpTkLiMR5qb5bmMBUFNKz1pxCJAZYUwrL/F/LS5VMXuDa2ipQO4mr4vCjR28rGk4ACnlzk89gooq+6SBdMScFeQ9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BCtYGoTe; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Jcrt9Ua+MyPDHExSKEJ8bQmAoVgn0rj02MVVo4Wnt30=; t=1768895846;
	x=1769500646; b=BCtYGoTedZ9RHeJGRl08crwtpMeZCohQT51y0DStcRGt7X5yXe8+2E5eTLa9q
	xbjflWCYGpFGqey3t5GzDr4yN1AY3VJYYwiyiALxzQ6wZ62fJb5oTAa7X0IAYRZgFfJBssKUc2PZW
	a9tYNk/vJwROb+IF01Moum/SHa6Zpp0+oow/VD3kxno/OVqPUxoRWxg8MfhQzyT3q8rSC+Cr45XCd
	FQWqCZ905e6yIPql9Y3pSB+IXvkXibofrIdyH2Fg5yS3psXF6ODK6aaxNnkDjd42x89TbCRgyRuMU
	ZEwOLTCMR1yhr45OYy3Zsmwvkm0fFRBnnlBMkABbJnd4eRDbcw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vi6c1-000000044St-19R3; Tue, 20 Jan 2026 08:57:17 +0100
Received: from dynamic-077-011-137-220.77.11.pool.telefonica.de ([77.11.137.220] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vi6c1-000000035uo-0B3R; Tue, 20 Jan 2026 08:57:17 +0100
Message-ID: <a5950b61a63677c789bc91d44357ff8226d3ef77.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/3] sparc: Synchronize user stack on fork and clone
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, 
	kernel@mkarcher.dialup.fu-berlin.de
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com, davem@davemloft.net,
 andreas@gaisler.com, 	brauner@kernel.org, shuah@kernel.org
Date: Tue, 20 Jan 2026 08:57:16 +0100
In-Reply-To: <ed3c9379-55e3-43bb-b2f0-9d51d44a2e40@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
	 <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
	 <e4eb5ddf57ef5f3a01ee76fe397c5f714a9d7626.camel@physik.fu-berlin.de>
	 <6529fbe6e6af7b87fdc92912b0b6a8878796bb6e.camel@physik.fu-berlin.de>
	 <ed3c9379-55e3-43bb-b2f0-9d51d44a2e40@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ludwig,

On Mon, 2026-01-19 at 14:05 +0100, Ludwig Rydberg wrote:
> > >=20
> > > I can therefore confirm that this patch fixes the bug.
> > >=20
> > > Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >=20
>=20
> Thank you for testing the patches. Appreciate it!
>=20
> The test program from Michael was of great help when
> I analyzed the root cause. Thanks for sharing it on the list.

Credits go to Michael for digging the problem up during our last FOSDEM tri=
p ;-).

> I'll send a new version of the series (this patch will however
> remain unchanged, so I'll pick up your test tag).
> If you have the possibility to re-run the clone3-tests on it
> would be great. Thanks!

Absolutely. Will report back later today!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


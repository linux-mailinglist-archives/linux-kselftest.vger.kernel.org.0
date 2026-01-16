Return-Path: <linux-kselftest+bounces-49183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61910D36D86
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C99302BD33
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05EA33F8B7;
	Fri, 16 Jan 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dno15FQI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8155D18E1F;
	Fri, 16 Jan 2026 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768583880; cv=none; b=Qitt2ge7XjpEuDKpQCeB9FJVgpc/DaHfJsATp+zmluYhunfyEIK6FM7GVMWHX/l8HFYJtVmWPdhIIZhCpiWCgBImdUPa3vyj4u0kH2VLvzGJnJTMikgG9SNfsYYZ8+vd9FRNSMHwDGMni5Ncw4l8BknCsiGLQ0Wolfe83UmHLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768583880; c=relaxed/simple;
	bh=6/qTjsjhuP3hyzefKpTltV7dVtp8vhCUOfJYMZao1lQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8UtteaQwHpKZ3NSnhpVsjezEnp4oMPL986XRWAoHO1pCSxgAkaML/shw2yoTbawsOvq3S9HiT1v44n/IpHnqUOipoNaNWqdX9FFG8zYIdvtGb/o1E1iXlU8eu7c8dMos8YG1wQe998u6HDP+fyVv9Fc7rEW9iOaUlH3+N+L27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dno15FQI; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=YoWoU9lL2AVuylrlL8AFtyV6wSIKq6irnPqAlyJiMu8=; t=1768583878;
	x=1769188678; b=dno15FQIzq3+Cwpn0uoAgUrpWbUf9vU5i6p1nkae3jfdb7DuycJgNYKovccin
	Cmpvnqn/v4fq1SPsjEJoDm1lyCEGiCoYFgLClOHogJUd0PhEuBAw+0scyluvMfDaBoybN81flWIK0
	fJ/G1OkN3AyiKDPzpURdFIwGutmVtLF50AxFC4XPUOAHBX7KufCKMvqeiFrNJQdeAqoLtPCoK186U
	0LSiSHrYqMxuLl5XWCGEItB3yMMGKBW+5LlypWPvXqjywSzodQFH3N8pSLlJY08EUz8bS3PUaead0
	PJpOYXN9oBzvU8tZCncR4kSGfi/Dt7SJ5Ei846sMK82uJb5+5A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vgnSN-00000003c1o-1scx; Fri, 16 Jan 2026 18:17:55 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vgnSN-00000000itq-0raw; Fri, 16 Jan 2026 18:17:55 +0100
Message-ID: <028eed419f1ad935b86f3bde678d0b7e02d03d94.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/3] sparc: Synchronize user stack on fork and clone
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net, 
	andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com, kernel@mkarcher.dialup.fu-berlin.de
Date: Fri, 16 Jan 2026 18:17:54 +0100
In-Reply-To: <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
	 <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
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

Hi Ludwig

On Fri, 2026-01-16 at 16:30 +0100, Ludwig Rydberg wrote:
> From: Andreas Larsson <andreas@gaisler.com>
>=20
> Flush all uncommitted user windows before calling the generic syscall
> handlers for clone, fork, and vfork.
>=20
> Prior to entering the arch common handlers sparc_{clone|fork|vfork}, the
> arch-specific syscall wrappers for these syscalls will attempt to flush
> all windows (including user windows).
>=20
> In the window overflow trap handlers on both SPARC{32|64},
> if the window can't be stored (i.e due to MMU related faults) the routine
> backups the user window and increments a thread counter (wsaved).
>=20
> By adding a synchronization point after the flush attempt, when fault
> handling is enabled, any uncommitted user windows will be flushed.

I have only seen now that your series fixes two bugs, one is the previously
reported clone() bug and the other one is adding clone3(). I have only test=
ed
the latter so far, so I will add my Tested-by to the second patch.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


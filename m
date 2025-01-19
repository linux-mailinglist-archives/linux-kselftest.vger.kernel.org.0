Return-Path: <linux-kselftest+bounces-24757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29885A1615A
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF441884AE6
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Jan 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D41DDC2B;
	Sun, 19 Jan 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="HxTQQQkc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618C2905
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Jan 2025 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285584; cv=none; b=qHZzUt/Mj0KTmBJefnmb7cB2cTN8o9NAsFb8xrKT1sug5vSOld73bIWpOeuItFH7dqzEB7cwhMrcTc2gxj6WcAKdZiArBEr/dAQuiFE4vZaL6cn9uMl2Xc9J51mYkWMsFZL1Gdg9hbWXqYLvCsl3l7K2mlGuDLAvuxFCUUOo9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285584; c=relaxed/simple;
	bh=pwmBtDYXeroVjDsWiw64Yh7exGzjc/hd4xLVSVVRVjA=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=oNAUh5Mojya6l9zRvj2XwJ3phshl9DdIui7J/M5XTT66n8XsKt+rIf3dMoY8a6/8qvy2XMvw187FnZv2YkkQbO/jsULa0MKzuVPjNJOb9LWpcG+aJYPE8pViGPTEeknWi6BULrNx/c/Kt8cFBi3UDevLEPM2WX7gu0uJZNvyASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=HxTQQQkc; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1737285581; x=1768821581;
  h=from:in-reply-to:references:date:cc:to:mime-version:
   message-id:subject:content-transfer-encoding;
  bh=pwmBtDYXeroVjDsWiw64Yh7exGzjc/hd4xLVSVVRVjA=;
  b=HxTQQQkc7Ke/iZuQ0N5Pbj5Xez7KmAF2t23R+faGwRSzY7eqpdFFv/OT
   Fqwp0g2qh64r7xWMA5wipXFHEUNbep16RaRdPFpgUtOyzE62SXPcwAWAh
   q9inr4mwmSen8JElsJOvx1xlqJPml4XpYr3YlcvfCkKnPEjxVql8UGixO
   s=;
X-CSE-ConnectionGUID: YyMK0MsvRruTOt1j7Rbi9w==
X-CSE-MsgGUID: 6fX7th4QTBKg3oO63wojBw==
X-IronPort-AV: E=Sophos;i="6.13,217,1732575600"; 
   d="scan'208";a="28594647"
Received: from quovadis.eurecom.fr ([10.3.2.233])
  by drago1i.eurecom.fr with ESMTP; 19 Jan 2025 12:18:29 +0100
From: "Ariel Otilibili-Anieli" <Ariel.Otilibili-Anieli@eurecom.fr>
In-Reply-To: <20241226181203.527121-1-ariel.otilibili-anieli@eurecom.fr>
Content-Type: text/plain; charset="utf-8"
X-Forward: 185.13.181.2
References: <20241226181203.527121-1-ariel.otilibili-anieli@eurecom.fr>
Date: Sun, 19 Jan 2025 12:18:29 +0100
Cc: linux-kselftest@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>
To: "Ariel Otilibili" <ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <786c4-678cdf80-305-3a9adec0@249280156>
Subject: [PING] =?utf-8?q?selftests=3A?= Clear -Wimplicit-function-declaration 
 warnings
User-Agent: SOGoMail 5.11.2
Content-Transfer-Encoding: quoted-printable

Hello,

Is there any news on this patch?

Have a good day,
Ariel

On Thursday, December 26, 2024 19:09 CET, Ariel Otilibili <ariel.otilib=
ili-anieli@eurecom.fr> wrote:

> Hello,
>=20
> This patch clears out warnings seen while compiling the tests; at the=
 time, it closes a test report.
>=20
> Thank you,
>=20
> Link: https://lore.kernel.org/oe-kbuild-all/202412222015.lMBH62zB-lkp=
@intel.com/
>=20
> Ariel Otilibili (1):
>   selftests: Clear -Wimplicit-function-declaration warnings
>=20
>  tools/testing/selftests/pid=5Fnamespace/pid=5Fmax.c   | 1 +
>  tools/testing/selftests/pidfd/pidfd=5Ffdinfo=5Ftest.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> --=20
> 2.43.0
>



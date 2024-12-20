Return-Path: <linux-kselftest+bounces-23658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B19F94D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4317F189353F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20578218AB7;
	Fri, 20 Dec 2024 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BA8OJcge"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471A208AD;
	Fri, 20 Dec 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706024; cv=none; b=PB/UOcKSO4QIBtSfrLe5A1If6e+GNF4cVbNxMcoTkq64RKCGpiRbZIDL7WhG3cIUzxEipTRG8MtpYKtX5gdULDybAjuvODNEeRptXYk3WHI/3gYeBbp5NN2FSQaeadCCsfnS6T/0qhTgUcUF1WIVkxdRn5zti1UY6sBD3LC0SIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706024; c=relaxed/simple;
	bh=HCrEAAyotKxKRWLBaBxhQwY17aOJ/YM4MOqrqDIB0AQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=K5Opqtc6FpSfof3OTKGY1dfWeZqE9Dxwhasb2/jOU+jdwozLWETmYspiqXJIlw/cafzHrVstzoF81CMdK7Kwsww46YZZ2YhXcrJJlS5yvSxUxNf5HW4fjBaxxsyXl8LCc92ErAF1KDxsHauAzfi73k5U7XpqRQ+gQJozLeoO98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BA8OJcge; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3AC231C0002;
	Fri, 20 Dec 2024 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734706014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=24pEqrf3AtOU4unFt++SFGFTIhLGoaZLEbxNJKCl+R8=;
	b=BA8OJcgeH3pw47BeyGLyPP7bKXKACC+R3qH3qX36+fw8ojUVr/KB7eSnMKJ85QunWJeR1Z
	2sjUUjlYbItSXjiDF/UTos4wE3vhF3Veq2QDhN+7h+q+ls/0+jBfFA7ktRzSzREHY6KL+w
	6K9RkDAea6xuh1Ayq8/yN8Ae/X0zrX3fJdLNO7hsZCY94ypWhKHSjyEDlH6dAHD+UZJ6Oo
	Jc9J2M5OQWDtTMoA3LcDXy/ZKimx4zKXFXKb/+Ip5h587p0zRUcm9hXhPSRxc7PuFeZBki
	GYRFyfl4oKZa1j14i0SppIM+9ozlM3zFdJy02xuQ5P+X2EGwp82i1hNx6dZUOg==
Message-ID: <e3d0bd36-c074-4cda-b6e1-5f873453ad30@bootlin.com>
Date: Fri, 20 Dec 2024 15:46:52 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bpf@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: Question about test_xsk.sh
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello all,

I was looking  at other test candidates for conversion to bpf test_progs
framework (to increase automatic testing scope) and found test_xsk.sh, which
does not seem to have coverage yet in test_progs. This test validates the AF_XDP
socket behavior with different XDP modes (SKB, DRV, zero copy) and socket
configuration (normal, busy polling).

The testing program looks pretty big, considering all files involved
(test_xsk.sh, xskxceiver.c, xsk.c, the different XDP programs) and the matrix of
tests it runs. So before really diving into it, I would like to ask:
- is it indeed a good/relevant target for integration in test_progs (all tests
look like functional tests, so I guess it is) ?
- if so, is there anyone already working on this ?
- multiple commits on xskxceiver.c hint that the program is also used for
testing on real hardware, could someone confirm that it is still the case
(similar need has been seen with test_xdp_features.sh for example) ? If so, it
means that the current form must be preserved, and it would be an additional
integration into test_progs rather a conversion (then most of the code should be
shared between the non-test_progs and the test_progs version)

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



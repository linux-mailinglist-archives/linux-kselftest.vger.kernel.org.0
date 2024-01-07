Return-Path: <linux-kselftest+bounces-2706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB08265B0
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 19:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30478281BD0
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B510A25;
	Sun,  7 Jan 2024 18:48:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E010A1F;
	Sun,  7 Jan 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4T7Qxh08bDz1sBq3;
	Sun,  7 Jan 2024 19:40:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4T7Qxg5Slpz1qqlS;
	Sun,  7 Jan 2024 19:40:55 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id xkFHhBBJOFcf; Sun,  7 Jan 2024 19:40:54 +0100 (CET)
X-Auth-Info: /W4ayZJD3y3xzE2nctsIdMXMG3SGQlPURR+PFDNHw9uO7xJQj9/m8RstH8iW2NKE
Received: from igel.home (aftr-62-216-202-6.dynamic.mnet-online.de [62.216.202.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun,  7 Jan 2024 19:40:54 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 7D9912C12EA; Sun,  7 Jan 2024 19:40:54 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: =?utf-8?Q?N=C3=ADcolas?= F. R. A. Prado <nfraprado@collabora.com>,  Mark
 Brown
 <broonie@kernel.org>,  linux-sound@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Jaroslav
 Kysela <perex@perex.cz>,  Takashi Iwai <tiwai@suse.com>,  Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH v1 3/4] ksellftest: alsa: Fix the printf format
 specifier to unsigned int
In-Reply-To: <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr> (Mirsad
	Todorovac's message of "Sun, 7 Jan 2024 16:12:20 +0100")
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
	<20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
X-Yow: --``I love KATRINKA because she drives a PONTIAC.  We're going away now.
 I fed the cat. - Zippy''
Date: Sun, 07 Jan 2024 19:40:54 +0100
Message-ID: <87r0itm1ft.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

s/ksellftest/kselftest/

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


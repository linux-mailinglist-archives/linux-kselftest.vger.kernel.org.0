Return-Path: <linux-kselftest+bounces-44421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F55C20C83
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007EE3A96C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB1283FCE;
	Thu, 30 Oct 2025 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JvDKIzsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2tAE22I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E46266EFC;
	Thu, 30 Oct 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836327; cv=none; b=mFFdQNgSXhj59UsepNRbACdMHhciLi2kJKxKxMzOQJdi1oi2wR187+o7JWgYceqV142+LhQu/QQisSR0G6ky+U+RqstfdXNMNcIMoCu5qLa+j/jR8Xyims0ucHaduDiVXY5QKFYswP+v4V1+0pP/s6lb/VI9HMy8N4nBKng/UYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836327; c=relaxed/simple;
	bh=7ESt1MCF7MRc1rVytZMWxxG28VDhI4fvWiMmCXF/PIw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GzgquPkIxO1fn9kV5BJmGdFhkPrgK8ZHvX49oTuXJpaEYq/4egejktgMs0rrxHYqkmc2JCjFfYJpQH4/rDYTw1svOXfaQoo34pZWQYUZkXdt/kxqU5hVU0E6MSWnb1pBaFEm56FXJGmImFtdV3zLDbG3vy5C5BuI2JWPYjg9jB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JvDKIzsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2tAE22I; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 912101D00112;
	Thu, 30 Oct 2025 10:58:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 10:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761836325;
	 x=1761922725; bh=7ESt1MCF7MRc1rVytZMWxxG28VDhI4fvWiMmCXF/PIw=; b=
	JvDKIzsXGMtuIWF+Ar5slqDzTVdhcl+J9ImEfijl3IlIRHIq82fuR1FQEymC8g8P
	3srF1JsA9HCaE68eCR7Hw+JTJsgDwIud3saJDxSwnjbZRoKFVAvg1ZHWqS/kTizj
	G++0kiJvG5kWzOXZu6JFiY9+cCTZusBzDqMPcsn2xQPxx9GIMnn3NZ6Fgo7NJR6b
	me4B61AeJzP7Ys9RrK9h4Y9vP8i4X2luGaGdZHXgtvAyhAy8hBSpLW8bjS5Cao/w
	OQ+KaKPisFpDWL0BBJh+T1CtPgEU3UAnEB0TVEyUAOW6Tgox9ynL9K+leRU5JqBp
	5v6iKY75X/A66l1OnSG0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761836325; x=
	1761922725; bh=7ESt1MCF7MRc1rVytZMWxxG28VDhI4fvWiMmCXF/PIw=; b=e
	2tAE22IdLybYkXNBg5qw95+rS8J+Q/DuUJhbDLD5fbnAt2ShLVJxj50y/7T12NSl
	DroiIhRIBuIJKSazTfWjYaAdZJgORbsqZkPCiVnIaljUJArAzpcA7zRer4fBAkyV
	qJyuSTKpXnmAEORZjfP4W5NHO4sloQI0B70uG+/6xlsidgeBwbdhhlHRle+ZQzwn
	QiU5375Zn7WL4mTNSlBC4mMZ86gtCD9uCLCwsJrSkNmbO2+X6WHAzCEK5VmW2jNE
	M9bYgC8CRrKsvehO4PvUi0aLk4IFt4ZtXT1kWm+oeGIiNjREwc92BldP31bks54g
	fZltNSWEoMvq4Mq+qqyIQ==
X-ME-Sender: <xms:JX0DaaCJdIm-PGSKJB-Ktsrc_88wp8g9TxIksn8ELhwWlWZTAPoxyg>
    <xme:JX0DafUsU7UvG9UaJPJCy9ttmhocKiOlz2W-bSWd7do3KfxUaLzGWX3TAa2uBPERM
    QAsMn7X2qbtSdQS9ZbGzhIFAq8zsJR61kltE0dxvDT7Ik7kKrhGdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghr
    nhgusgdruggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvle
    ehvddvgeejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifsedufihtrdgvuhdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugiesfigvihhsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:JX0DaRM18pY4ydP8LP-tdFtQRuS_i1IbMKpbFNCVmxHy4YaAzNtYiA>
    <xmx:JX0Dac4EUEyloeBTrhtAVwaEiNLIW6dt_wbauw0heVA04m7KSi6JwQ>
    <xmx:JX0Dab1nhMr-UcsPaWso9WY4aY6XmN5BwyDBmOgTEvFyeMprKGHuVQ>
    <xmx:JX0Dadw6Qa829wEEVxmYIBCGaS_1oUx5JvTMyuKARdu7n75lHLHbUw>
    <xmx:JX0DaWzhlv0lHSZ_B9fS5wS9ZP6hxaIOci5qm2ocvFBYSKkuw0rbgTOc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F38B700063; Thu, 30 Oct 2025 10:58:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHaCJvvWUCWF
Date: Thu, 30 Oct 2025 15:58:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Willy Tarreau" <w@1wt.eu>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-Id: <567fcbb3-1be7-449e-ad55-1aa2c095f03e@app.fastmail.com>
In-Reply-To: <20251029-nolibc-uapi-types-v1-12-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
 <20251029-nolibc-uapi-types-v1-12-e79de3b215d8@weissschuh.net>
Subject: Re: [PATCH 12/12] tools/nolibc: remove time conversions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 17:03, Thomas Wei=C3=9Fschuh wrote:
> Now that 'struct timespec' and 'struct __kernel_timespec' are
> compatible, the conversions are not necessary anymore.
> The same holds true for 'struct itimerspec' and 'struct
> __kernel_itimerspec'.
>
> Remove the conversions.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Ah, I started commenting before I got to the end of the
series. This looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>


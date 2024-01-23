Return-Path: <linux-kselftest+bounces-3433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5283977B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 19:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6221B23B52
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77981AA7;
	Tue, 23 Jan 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="As5VVD6u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3548121F;
	Tue, 23 Jan 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033983; cv=none; b=lkSjjB6TfPZXqu/UjgpCif3GAidRxG0XQPfzoIb3d97u0XRCw70KeeR1mvfaUTgojIb9iY9CV7aBwGeyGYl246IuMriwR+I/qd24LobGjblBG0kzHg8TEkWYv5qQ8JiXcEuNua+5+aqfwXCTVZTJjIwyWdaL0BLrHYJ2ANTgG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033983; c=relaxed/simple;
	bh=sAAfYQK0x1C3nmAGeUMkLNUOvFfmwiojiaQWXaODgME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLiDYrdIx67CIUY1p3pFey5DV3zozYzD2H8X/9NFOeVg0sZg11ZsPWyAtCdPD8bOwS4ww4cSqJYqWYziIXbKE60bLtvRb+VdZ5KoBzVprAbIxkGByxpxuICOXaxirJT6wGQsGEe9BypmHaX6ah+frNeyVXZaBJiTuLIdTb4HJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=As5VVD6u; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Vvlae8MmYS/hHfYFpYsXOF1a17ieOkrJZm/pP7c+WOc=;
	t=1706033980; x=1707243580; b=As5VVD6usQIpr2iu3N8xgS2snDKmi9jDhgZjD4pS3r43KpJ
	5/PzYeEXtDklb5WVelyArs/qVYzBTztMYPldQA/jMizIcOlDCBptd53NT+2j2hG0TP9LZnLUF+gSC
	fGx7GrljM+YwNOM5pvnHCYPFRh9mFV/RfMrYL7zCH2dx2Df4olSf0WAZMdjWLR/GBF35afNJaafDv
	iGFlHuKa/LCpbh7nGpp6abdqrpBfcR9Z22rW5d8qqpnmz5qRpLeI+FLuf8uR/G0/NxspMA0M6QiE2
	1axbVpL3s3hGX+vwP7nXcGXMTf7ajbvoftkZAfOU0QtVqhNX18mjmopDGUSE7X4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSLN2-0000000FAUT-3RsH;
	Tue, 23 Jan 2024 19:19:37 +0100
Message-ID: <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2024-01-22
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>, Lukas
	Bulwahn <lukas.bulwahn@gmail.com>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, David Gow
 <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com
Date: Tue, 23 Jan 2024 19:19:35 +0100
In-Reply-To: <20240123084504.1de9b8ac@kernel.org>
References: <20240122153434.E0254C433C7@smtp.kernel.org>
	 <20240123084504.1de9b8ac@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-23 at 08:45 -0800, Jakub Kicinski wrote:
> On Mon, 22 Jan 2024 15:34:34 +0000 (UTC) Kalle Valo wrote:
> > Lukas Bulwahn (1):
> >       wifi: cfg80211/mac80211: remove dependency on non-existing option
>=20
> BTW we run all kernel's kunit tests on netdev periodically by doing:
>=20
> ./tools/testing/kunit/kunit.py run --all
>=20
> and AFAICT the WiFi tests don't pop up there :(
>=20
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-01-23--=
15-00&executor=3Dkunit
>=20
> Is that on purpose?

No, but honestly, I didn't even really know about it, which is mostly
for lack of bothering to look - because we run them in a different way
now both in upstream hostap and internally (internally we also have
another file with metadata to tie them to other bits of the whole
project that isn't interesting upstream).

Looks like that needs adjustments to the config file there, mostly? I
can see about adding that, probably not that hard, at least for
mac80211/cfg80211.

++kunit folks:

We're also adding unit tests to iwlwifi (slowly), any idea if we should
enable that here also? It _is_ now possible to build PCI stuff on kunit,
but it requires some additional config options (virt-pci etc.), not sure
that's desirable here? It doesn't need it at runtime for the tests, of
course.

johannes


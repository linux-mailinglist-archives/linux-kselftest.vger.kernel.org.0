Return-Path: <linux-kselftest+bounces-6780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20DF890D70
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 23:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D47828B13E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66713BAD4;
	Thu, 28 Mar 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="amT/7IC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED313BACD;
	Thu, 28 Mar 2024 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663922; cv=none; b=rYASPYL5DR7lzDr96nKThCmQTSFm4yayLUQcyu17axy+6QMFY5dL+8gY6HEERy7zTpsI+vreOnc6IYAP5v6D9GOVbggQmXPGGjdB7Vd7KIjcHPiJPay1pDq6VEYAejiblRie7zQPT+TG/lD1w3qqCEVygccSXMSyWH4rvhS/VrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663922; c=relaxed/simple;
	bh=ehbsRbh2x7F3tw4Jrc369T8BwH+Mb2OxM/pImqRP/Qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvTgDpTujnQZicUoIx4cS7aELmzFFGevzBnA9CIJeHe9YZ9o1V1KCxq4F69u6zgi34mQ10JSDvwSKwPdP4+yebtEwurN/BdSz3JOudKTkmG9pjCUBVRuTXkm/OAecN6putiok78Wztw8Jcg46UWl7soOkIEsI8/TiR7CEQHcm7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=amT/7IC5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ehbsRbh2x7F3tw4Jrc369T8BwH+Mb2OxM/pImqRP/Qk=;
	t=1711663919; x=1712873519; b=amT/7IC52/2NyjGDtcGT2vjNUAcYERizCX+MVJ9q7/RLGk0
	WUvdx9kMS9PAOskGyKGRO8GiniVn8Kn5CFOfgL/3ysRX6jroUfvoCIWzy+Tq7ic0sD37OYHIGWqkY
	lCeUiQL+hK5LfXHWAuvlt+PbdKmFLQ2F+MpAC8FGftHh8pfmAnQl40D5fvR8d1PoxCIcy+PoP3Jx2
	OkrSdGozWUHik9C1YZECEqx8nDkD3LukFhbYJHk9fNYPL6uphilaGtB1QlTkAsT3MNg2LrJrj52NI
	iQXQzISWs67IqFD4+RY2QoAFhyftXtAL5tPuwYuo3fEbTka/KhtyprQ4mQg9EEkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpxyW-00000001PRE-2aun;
	Thu, 28 Mar 2024 23:11:56 +0100
Message-ID: <eccb00604d9dae9b67d3d97d0526eb53cd6ffca7.camel@sipsolutions.net>
Subject: Re: kunit alltests runs broken in mainline
From: Johannes Berg <johannes@sipsolutions.net>
To: Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
  SeongJae Park <sj@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>, "x86@kernel.org"
 <x86@kernel.org>
Date: Thu, 28 Mar 2024 23:11:55 +0100
In-Reply-To: <6591ea0d-572b-4deb-b2a7-da58ed91c8f9@linuxfoundation.org>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
	 <20240325185235.2f704004@kernel.org>
	 <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
	 <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
	 <6591ea0d-572b-4deb-b2a7-da58ed91c8f9@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-03-28 at 14:08 -0600, Shuah Khan wrote:
> On 3/26/24 04:09, David Gow wrote:
> > On Tue, 26 Mar 2024 at 15:55, Johannes Berg <johannes@sipsolutions.net>=
 wrote:
> > >=20
> > > On Tue, 2024-03-26 at 01:52 +0000, Jakub Kicinski wrote:
> > > >=20
> > > > I'm late to the party, but FWIW I had to toss this into netdev test=
ing
> > > > tree as a local patch:
> > > >=20
> > > > CONFIG_NETDEVICES=3Dy
> > > > CONFIG_WLAN=3Dy
> > >=20
> > > I'll send this in the next wireless pull, soon.
>=20
> You are welcome to send this with wireless pull if you like
> or I can include it in my pull request.

It's already in net now, and in the pull request to Linus here:
https://lore.kernel.org/netdev/20240328143117.26574-1-pabeni@redhat.com

johannes


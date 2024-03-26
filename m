Return-Path: <linux-kselftest+bounces-6609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59388BBBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 08:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2E61C28AB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 07:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8BE1327F7;
	Tue, 26 Mar 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="V3Cn5kn9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3C4CB2E;
	Tue, 26 Mar 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439717; cv=none; b=dI0AeUXhy25kMSL/HWpWHfDuvNjT7ze3VoBXK83V4mjMoSmxIU4hu7l9dAZmhIO4zqwKCFXvSooofm7zD+C6YKVqvD5cHegF5QLTNJgsw82WiW+HxSXc6cbNSz3U/btC+9zWJIpOhL67HiG0YmipjvY5b3jZYbapNIrRy4P4Bk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439717; c=relaxed/simple;
	bh=GH6L6DVebNLO9qCIIvAyQqQvKLzQMc2f+nrivTepdgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOBKsEgyqd6x71VVUKed4ngqZ/33T3P1GNxhDSkjG6NRV6IcOd9UcT9hkBWrleQecQzMQJa+w+KFxGIDDBss0MwqAA9zi7IYdQPmwYa32o+jmczRWGDRkZm3anHNRiBfXZV/tzt1xnFVgFHU7XZUMKUsbnFmfPEG7bRxOZzHLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V3Cn5kn9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GH6L6DVebNLO9qCIIvAyQqQvKLzQMc2f+nrivTepdgg=;
	t=1711439715; x=1712649315; b=V3Cn5kn9MehIgP4+xVrchyL7yrmvlJ97sjRe62bYfFMiuIx
	91s+0BqJef12RoUaUw/hnu6Fjl8fa9c2whpxTcbtmjfUE6tSFy06wXrdHob0kWdmLU3HyKRQk8iky
	pd7Pzqowqeb2nF09aYq8TNDEuNISMRNsRBTYF/6u2vFKFM+P3e0KmmVmU8YZA38WfKvnrwO5HxWQ2
	CGnHROcmO94soLIL19onjZhdztlIVgq63UXe8r2GezRbjbjq1xVA/xJP5TGLBI0en+tRJdTSYUJAl
	8tpCNnF1y2dmy6g5IrgNFgKtrL2jzIv6uMmBwR7/BGAYT2eXlG5mq5eU387nitkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp1eL-0000000FYMJ-0ma9;
	Tue, 26 Mar 2024 08:55:13 +0100
Message-ID: <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
Subject: Re: kunit alltests runs broken in mainline
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>, "x86@kernel.org"
 <x86@kernel.org>
Date: Tue, 26 Mar 2024 08:55:12 +0100
In-Reply-To: <20240325185235.2f704004@kernel.org>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
	 <20240325185235.2f704004@kernel.org>
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

On Tue, 2024-03-26 at 01:52 +0000, Jakub Kicinski wrote:
>=20
> I'm late to the party, but FWIW I had to toss this into netdev testing
> tree as a local patch:
>=20
> CONFIG_NETDEVICES=3Dy
> CONFIG_WLAN=3Dy

I'll send this in the next wireless pull, soon.

> CONFIG_DAMON_DBGFS_DEPRECATED=3Dy

> The DAMON config was also breaking UML for us, BTW, and I don't see
> any fix for that in Linus's tree. Strangeness.

I noticed that too (though didn't actually find the fix) against net-
next, wireless trees are still a bit behind. I guess it'll get fixed
eventually.

johannes


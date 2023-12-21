Return-Path: <linux-kselftest+bounces-2320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A2481BFB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 21:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4555128A313
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52370760BF;
	Thu, 21 Dec 2023 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mzwvDZ6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE9BA2F;
	Thu, 21 Dec 2023 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DYz9UKukQQi0+UkBLQMWrkToy7MoAxOJpeupjT9wAhk=;
	t=1703191246; x=1704400846; b=mzwvDZ6CFHQKTPzeqMfH/bCrCALbvN+N+1r1b2rZnzVdy/V
	08KzF5tbCOKnLsgIbusyYU62uHrLRvWUHRiJo3DVrans03Ao0uiAG53uZZGPDVXRPUWTE+mvb7HeK
	tY7r8WNV/bIiMjDty4YUCvP8SqT3K4D/wmyDf9dt+gx7T3u9VQmx1596VjgyHFNOxEm7oTrgbPo05
	PGIyFX2mrHIPmOSr3f9zE167IKGbTQ8fvKJrZEhYeJjIUcMQ7PswDcVFUqtRVUy5gkWEGVQtzA+Su
	QqX0Gb2NLSmQyknMW4lgqheOMYLeosv80f0AsUKgyU1aPmVl6Ot6smuOI16qH7WQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGPqT-000000037IZ-1U0F;
	Thu, 21 Dec 2023 21:40:41 +0100
Message-ID: <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
From: Johannes Berg <johannes@sipsolutions.net>
To: Shuah Khan <skhan@linuxfoundation.org>, benjamin@sipsolutions.net, 
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, David Gow <davidgow@google.com>, Brendan
 Higgins <brendanhiggins@google.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 21 Dec 2023 21:40:40 +0100
In-Reply-To: <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
	 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
	 <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-12-21 at 13:06 -0700, Shuah Khan wrote:
> On 12/21/23 12:39, Johannes Berg wrote:
> > >=20
> > > This patchset adds a couple of helpers for kunit as well as tests for
> > > cfg80211 and mac80211 that use them.
> >=20
> > I can take this through the wireless tree, but then I'd like to have
> > ACKs from kunit folks for the kunit patches:
> >=20
>=20
> We have run into conflicts in the past with the kunit tree. I take the
> kunit patches through linux-kselftest tree. I do want to make sure there
> are no conflicts. I don't mind taking these through my tree.

OK, fair enough.

If you can still put it into 6.8, then I think you can also take the
wireless tests, assuming they pass (I haven't run them in the posted
version). I don't think we'll have conflicts there, we don't have much
work in wireless that's likely to land for 6.8.

johannes


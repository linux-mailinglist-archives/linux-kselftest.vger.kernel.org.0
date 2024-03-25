Return-Path: <linux-kselftest+bounces-6546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14588AB80
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F089B1F67351
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFCA127B43;
	Mon, 25 Mar 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A+GtRDey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D7839F9;
	Mon, 25 Mar 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383400; cv=none; b=rEHygo2iyRxuHoMVYZvqAskmtW7Xm4xiieQdr1Pt0wr1zbrnwS3E6cNwinnVCwJ/ULFBqTpe+Tox2i21kYixyage3pWe1hr3Pi245JwuU0eKh17mT2BiPVOYwWGhPBI7aOdCNZ2VYQAvMxocWza0pLW68NxeyuxNpbDBMrnZhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383400; c=relaxed/simple;
	bh=vhysHfkaQ11aFpQ0qHmLTGDQbRzjDgbO6RjYe+i/sVM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nt7luvbfvUD5SK8FgiJCBDOFWHe3jB5DSVsKISmNd1xNFwTMQBw3YFXzr1tlWgCiRojX7z1vJWyhUmk5IQMTslNUpIpNXlLFNS7BNEfeTcjqGIcvneY/n5eswJpM0NnOqguXPa92hh6R+rV5GiExSykShRnq360sBaAaMe9qaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A+GtRDey; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vhysHfkaQ11aFpQ0qHmLTGDQbRzjDgbO6RjYe+i/sVM=;
	t=1711383399; x=1712592999; b=A+GtRDey9cKVu1Ia+XKk4zhU7wCcgSSA+tRxzGof/6V5PHR
	DfzMfEXMZBXnuoL/SZsqyYydwn7nOUPTdEQHW45sqUDxVdJ6EMPb+33NbNevpdwLCafLWiuHZHtYb
	KcZ7zpgHA+4BI7i11L85XWaiUe8YRncMUbCWoU0BZqXCfPirtLVBBL7wXzWjZL7hU/jROqf4gYuO8
	h57eXzj+sP1UxlnN+cJ+cPd1LcnVjF6r4PwwNRi+OnXlQE1A6xCR3kOR+UWJ10cun0MVoeYzU+lCP
	OFdxuj/LYs54RFW9NZyorwWjKAzi6WXM4kqNBtPZMrkiaxlpW4wyaBl782Pq15MQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ron00-0000000DwVC-2aTa;
	Mon, 25 Mar 2024 17:16:36 +0100
Message-ID: <0d314451371764362a43c4368469c2be6a17eb8c.camel@sipsolutions.net>
Subject: Re: kunit alltests runs broken in mainline
From: Johannes Berg <johannes@sipsolutions.net>
To: Mark Brown <broonie@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, x86@kernel.org, linux-wireless@vger.kernel.org
Date: Mon, 25 Mar 2024 17:16:35 +0100
In-Reply-To: <c01d6e1c-1dad-4012-b8b0-dccf19b2e3f2@sirena.org.uk>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
	 <9c9e1297e2548b363fc93e774c8546e6ebf4efd6.camel@sipsolutions.net>
	 <c01d6e1c-1dad-4012-b8b0-dccf19b2e3f2@sirena.org.uk>
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

On Mon, 2024-03-25 at 15:55 +0000, Mark Brown wrote:
> On Mon, Mar 25, 2024 at 04:29:53PM +0100, Johannes Berg wrote:
>=20
> > But I'm not sure why ARCH=3Dum is different?
>=20
> It's probably something to do with it lacking a bunch of features of
> normal architectures, especially around hardware support.

Feels though that should make it *more* likely to not have support for
some hardware driver like iwlwifi, not *less* :-)

Anyway, does it fix it for you as well? if yes, where/how should we get
that in?

johannes


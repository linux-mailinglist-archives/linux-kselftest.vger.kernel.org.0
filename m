Return-Path: <linux-kselftest+bounces-2315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC581BF2F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 20:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804981F23DE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Dec 2023 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2E651B3;
	Thu, 21 Dec 2023 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XnYZpjbl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E5651AD;
	Thu, 21 Dec 2023 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Uc6oIDYJEGCaiWC3Yj2aq0rcmgM1M7i7nlY0QmZvx7A=;
	t=1703187558; x=1704397158; b=XnYZpjblyxZDCp/c2PSlTIWPfYBJXhmzwIwunkMGR1Xj4f3
	w1PVArO3bh4/QkswM7CbMWj24Y8BWZE5HlQZSj8PRKH4qejasUyrQ/zU32yYww+QLa066IG5/Awo8
	0mZ2RcyCut+Mz2Tlba7w+8XEbnxHF43u8buqyEfJf+YrDGL+YqpPAaEyR9Abse7ScbK86OIdmxsWn
	tN++qHAOAjn8dIhfY8QLL8pe4UdCUva58lWTW8eiDB/Z5bXIqT0NhQ4KyLLE1SoOBPDuSxuoEdpFD
	h2aUvh6LkGYE8YDngllB7tqo9VOi6TnQ7JHWmQPxIFWGZ9zJNikQ6fWy7F6kEgmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGOt0-000000034zH-2b5u;
	Thu, 21 Dec 2023 20:39:14 +0100
Message-ID: <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
From: Johannes Berg <johannes@sipsolutions.net>
To: benjamin@sipsolutions.net, linux-wireless@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: Benjamin Berg <benjamin.berg@intel.com>
Date: Thu, 21 Dec 2023 20:39:13 +0100
In-Reply-To: <20231220151952.415232-1-benjamin@sipsolutions.net>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
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

>=20
> This patchset adds a couple of helpers for kunit as well as tests for
> cfg80211 and mac80211 that use them.

I can take this through the wireless tree, but then I'd like to have
ACKs from kunit folks for the kunit patches:

>   kunit: add parameter generation macro using description from array
>   kunit: add a convenience allocation wrapper for SKBs
>=20

Thanks,
johannes


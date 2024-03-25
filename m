Return-Path: <linux-kselftest+bounces-6551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0288ABF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4658A1F399E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D91149016;
	Mon, 25 Mar 2024 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XyYcvfDX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C7148FEA;
	Mon, 25 Mar 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384980; cv=none; b=brgOtau8rUYIHa4rZzPZGO1EGHzOvLAwj7Rc/FYxyxqeMd0tIFw5eqE4oQGkc/mZ2O94Lck1ACevFQJoY/j7CRu857NmgAYmdy+hQiKIcytLbEOjhSMBxf08xIKgOj4j/+9GLMSz5+X9dDEJ68POav5CiOdeOdMCAkljlXlbcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384980; c=relaxed/simple;
	bh=909NTl0XtpQt2F4+Aw+2U/Ww/pTlS7w+khv14zAEWYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=djdFntHMsyFTuPe6mkj9GKekIVz7tfOi0imyKeQTdAQ54EZafX8ozimt1qlifh9TUfTjix5wmqbaO3qEkh0s1zSmq76yOMigpanseYTnJwMvhWunF2ClZmDuyT+KEGT/M2xDbgGZVGuJNKqXb4v69z08SZxmOSxa0J56oJ4iRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XyYcvfDX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7sQubn0e1HFhTaBRnRATyAhK70lmohH3RG+T7rL6M/k=;
	t=1711384978; x=1712594578; b=XyYcvfDX3O8Wvyp022vJDMjZO3Yxr7SjVBexvmK4o1x2G6I
	uFZpO02ARiHba6s4WqUaolrqh1fwzyljtAu6p+WaBmhQDowJ4oanrmROd75CZH2qNsX03FfSnIoEk
	i8wqBhAWN4f9yFhp6EPzUR921XdrY/kLCmkxSugQt5DTHABs3kbRcWNl9GYAzKsiIVJ81850rXNXw
	NvdXiSgr7tkC9P03e1FWbAS3batYfqrXOB1eyfRfASXEng+pkNtnWZth7GgkeSRCMrhYLLsbtUiF2
	Y20t1H+/9pZB4WWepHfP1V69gqp8Gbr29wYoZ5xc6V7W5gbwuN+XG+Fjk8Dgf7DQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ronPU-0000000DxRB-1v73;
	Mon, 25 Mar 2024 17:42:56 +0100
Message-ID: <76b84bd180b3509dfcc1aba86836890ddd3fe3aa.camel@sipsolutions.net>
Subject: Re: kunit alltests runs broken in mainline
From: Johannes Berg <johannes@sipsolutions.net>
To: Mark Brown <broonie@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, x86@kernel.org, linux-wireless@vger.kernel.org
Date: Mon, 25 Mar 2024 17:42:55 +0100
In-Reply-To: <7e2b745a-df07-41cb-a088-966aa46fc175@sirena.org.uk>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
	 <9c9e1297e2548b363fc93e774c8546e6ebf4efd6.camel@sipsolutions.net>
	 <c01d6e1c-1dad-4012-b8b0-dccf19b2e3f2@sirena.org.uk>
	 <0d314451371764362a43c4368469c2be6a17eb8c.camel@sipsolutions.net>
	 <7e2b745a-df07-41cb-a088-966aa46fc175@sirena.org.uk>
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

On Mon, 2024-03-25 at 16:23 +0000, Mark Brown wrote:
> On Mon, Mar 25, 2024 at 05:16:35PM +0100, Johannes Berg wrote:
>=20
> > Anyway, does it fix it for you as well? if yes, where/how should we get
> > that in?
>=20
> Seems to.  Given the breakage I'd expect it to go to Linus urgently, I
> don't know that it super matters exactly how but I guess net will be
> sending a pull anyway and is the source of the breakage? =20

Hmm, yeah ... after the previous discussion I had just put the patch in
there directly in wireless, so I'll just add this fix too.

johannes


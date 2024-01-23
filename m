Return-Path: <linux-kselftest+bounces-3438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEE5839BD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 23:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A7C1F257B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DD4EB50;
	Tue, 23 Jan 2024 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S0lRAysl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52A537F5;
	Tue, 23 Jan 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047587; cv=none; b=CzSaDZYB6eJpcpzIV4MR6CpihPVC5LDfzVhu9GXd0sy2zam8h66AAjD3cgDfIfyahBRg5FJ/FcfIxsnWDFApfDrH6a6TJPAM+QkXzMimNNxmqt2+i8PTdsqYc4zLeMrvDKIIW+UuQ0Y6JoHORWvJdWVp9OiP9C8Khq6QTAMr+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047587; c=relaxed/simple;
	bh=EBG8FKLDL2yNVWwn82X5TrJOhSSQhARDwLMOkbaC8lQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2DUCmVDGg53ZK50AQ8rLtZE3Bc68vayRbEWqPCPSEieayqhsWfYWUCuz89h60ynlzQM5wdLuYy2HP9Lw3N6To76rHGyYHeTyhhtA9GfNxzUr+GwlGRd5viUTMQmvrFJNfjLdxI3xR/DmsE0Ucb3MkP88V+YQPhCXDX9ay9C6qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S0lRAysl; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EBG8FKLDL2yNVWwn82X5TrJOhSSQhARDwLMOkbaC8lQ=;
	t=1706047585; x=1707257185; b=S0lRAysl9QJLH9mzRCts8uJYOAG6U58EfilmPDadRag6sut
	JoTJCtdYw8mqLFOKAULZUeFfEZV2arWqx6GL5ZfhYbuu6c98OrGX7IFAKcDdb2lquntXq6FbX0SFT
	FjOCCERgU0sWfHpMI2vCiEz/8gWcutIQRisIJmufWis+4zZJwjxKj5UoAaAFcPZOHzxXTvhkYqLQf
	mFLT42ZN1ELgJeeJylubU1dy2Y9Q3c0yU5wu+4QCMQr8tK3i1CgXebarjSL04wx368yhK1APVLKRl
	nszYdWeCD3hwspCMP718/yiwrTvUtGzQt3wI6yvuFFJbfpd/JPpMumaNvaHkMRGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rSOuT-0000000FG0g-2jwM;
	Tue, 23 Jan 2024 23:06:22 +0100
Message-ID: <d6940d0a80fcb522910c433fd3644ed5c524f6d5.camel@sipsolutions.net>
Subject: Re: pull-request: wireless-2024-01-22
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, David Gow
 <davidgow@google.com>, Brendan Higgins <brendanhiggins@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com
Date: Tue, 23 Jan 2024 23:06:20 +0100
In-Reply-To: <20240123134255.3eef6fd9@kernel.org>
References: <20240122153434.E0254C433C7@smtp.kernel.org>
	 <20240123084504.1de9b8ac@kernel.org>
	 <d4c1a7c715a1f47dc45c5d033822d8f47e304bd4.camel@sipsolutions.net>
	 <20240123134255.3eef6fd9@kernel.org>
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

On Tue, 2024-01-23 at 13:42 -0800, Jakub Kicinski wrote:
>=20
> > We're also adding unit tests to iwlwifi (slowly), any idea if we should
> > enable that here also? It _is_ now possible to build PCI stuff on kunit=
,
> > but it requires some additional config options (virt-pci etc.), not sur=
e
> > that's desirable here? It doesn't need it at runtime for the tests, of
> > course.
>=20
> but curious to hear about driver testing recommendations.

Not sure I have any recommendations ... The test we posted is checking
an invariant (the devinfo array is sorted in the right way); we used to
have a check for this in the internal driver variant at init time, now
it's a kunit test and we don't have to carry the delta to upstream here.

I think Miri is also working on some additional tests for some driver-
internal logic though.

So not sure, I guess it'd be just like anything else you could use unit
testing for, certain self-contained parts of the code that don't really
otherwise need a device, etc.?

johannes


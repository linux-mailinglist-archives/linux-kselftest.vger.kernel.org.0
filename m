Return-Path: <linux-kselftest+bounces-23182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5B19ECF60
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 16:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12670281CDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9165D19F131;
	Wed, 11 Dec 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="eerERM2m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tXpBswLW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A26163A97
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929614; cv=none; b=kjxaqGT2W8bIgJEBy+ACKXwBDmwetwrLTAdg5N3e7iakodJiQeOeo+iJDB7c6qvF2uOaFwIVXgG7qy69otKnPSD882ZOBii5EQoyChoPcejp/CFcBYRToqI1zgCIABx7PMOvb9W5QPxEUp4kOxYUu5vmOrO2y75OJY9nKB5Fyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929614; c=relaxed/simple;
	bh=IcIWC9dJAg5OtXVaewOoZ6FY1MuR+82QIb3xwe8rpWc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ECZmP/2nca1JvfDD7Qd/JWgk8GegjwYrW3YNBSTO2k0LVmaWe+Yu78QQQ42UOT7WGjywqsAh2n6L9C99J2jpnvUkb3rBW944VanVkwjuzcN63uajj36AObs81k1aOFLoLpmXdnfTqgWpCIRjs5uaaCIQPzmj3ZURKyLI+Nic1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=eerERM2m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tXpBswLW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A1AA2540075;
	Wed, 11 Dec 2024 10:06:50 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 11 Dec 2024 10:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733929610; x=1734016010; bh=oZv29Li8FX
	xwUwDwfrjJqvihl4xMyv2UJxCN1F0EdlY=; b=eerERM2mSO6Wr9a8UWzdrKIQ0R
	16TTse5lWV4BbvDTzqcb5L7+N7IgNe/pyGhKip+wjHkDwz1o5WspYBIG78v1VOP3
	e5mZOepJSmbmoj/fH0xRvJwdQ0vTYeo9Twx60sC7aiV8QWEOydrOKfjCwb7s/h8+
	H49wGsmvRaYjXcNrtV0Zqqm8kdBmq25TR5WB+QSXWunt/86Hxj+uzUVaBww8SRad
	wAb1barAcfssYPwrunOwiEPIk8tdnE0HdjwoL5GWRR1lNr0L2SaObMeJ0GuD2+FC
	lqwGOw6abLdF08L/0eqrtHtaBg8xfkQQAx7OO3nI2io0HARUO+BTca73F/SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733929610; x=1734016010; bh=oZv29Li8FXxwUwDwfrjJqvihl4xMyv2UJxC
	N1F0EdlY=; b=tXpBswLWqIxoF9cOcpdnQx4RWBeLXsOBamGjGcDK0vAxoSlaEVi
	1qyKVREbPsUM7oX73CseJXMrqWjTgOAEt7RM8JCgCQb5J3o7/pBCY3spChrvjFga
	xg0gQ6raefP4wl6gaD6zRPb6NNOZZSxyXIGBcufWtMafKmapWkMC6Usv2SBYDdhf
	1gvOW0P2P94QsKhxDmokIGyO+CoqZ6SgilpqdfrMW5luCz5lXM1embnh6JgZoPbz
	eSxCD8lf5GAJHn6K9dBfaakvb9Ht8MI2l23sYrTgNp5sEMOFRy6y4fWux7w9IIvs
	lNCXao3h52Hrv9sc+Foliq+xKSZWIRc7ZIA==
X-ME-Sender: <xms:iKpZZ3e7IPU-gvObzJxtvXeuk26P66lkjJe6Jec0pAOhULDDtuFXPA>
    <xme:iKpZZ9PXBhObR9W2m8_ZHRXit4VzEYTlTIr2vkkJ6gIrNP1NQEAMS-5nT473eC0xO
    NKw3jS5JnppdSbZEvE>
X-ME-Received: <xmr:iKpZZwjPtSfrMkuP4v3bgSXOfP-55Cvtz-4DFk8IjizB5oDYEsCkMNbaOicxh8pPYTywwEekw84nL6U5ccsggsyXfT-7FakLmuSBZ9l1fMPTTs3JXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfh
    rhhomheppfhitgholhgrshcurfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvth
    eqnecuggftrfgrthhtvghrnhepgfevvdfhfeeujeeggffgfefhleffieeiuddvheffudeh
    udffkeekhfegfffhfeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepnhhitghosehflhhugihnihgtrdhnvghtpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnh
    highessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtoheplhhuihhsrdhhvghrnhgrnhgu
    vgiitdelfeesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgughhofiesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepkhhunhhithdquggvvhesghhoohhglhgvghhrohhu
    phhsrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonh
    drohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggv
    sheslhhishhtshdrlhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhope
    hrsghmsehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:iKpZZ4_CrVAmSkaEFDoFKvmeOI6em3-8a4jGk9YDuIPL2g-jHLldjg>
    <xmx:iKpZZzsV4BCa8ywgxbkQMOJIf445-Z3srFbM4YWQE_o6uoELKJNmAQ>
    <xmx:iKpZZ3Goxr_x3P3BhNvhn2SgSb0kj92vSM9hz2hJiUi5cl1Cv3mWZA>
    <xmx:iKpZZ6PPtNuP9sF6HP6ecAivBkcw53XuKSbDxuNXi8NGylF9tSyolQ>
    <xmx:iqpZZ0lsMlh0Ljl8MaHqgl74ETHzqX3Z71XkU7bTsQH3RMHMsO2e5GoW>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 10:06:48 -0500 (EST)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 72541F3863D;
	Wed, 11 Dec 2024 10:06:47 -0500 (EST)
Date: Wed, 11 Dec 2024 10:06:47 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
cc: davidgow@google.com, Andrew Morton <akpm@linux-foundation.org>, 
    andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com, 
    skhan@linuxfoundation.org, rbm@suse.com, linux-kselftest@vger.kernel.org, 
    linux-kernel-mentees@lists.linuxfoundation.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4] lib/math: Add int_sqrt test suite
In-Reply-To: <Z1kZdw3VybM9zN3+@granite.localdomain>
Message-ID: <3s6r2q3q-4s50-s11o-80qr-7p04185posoo@syhkavp.arg>
References: <20241210172822.97683-1-luis.hernandez093@gmail.com> <9op57qr3-p152-6ns7-52n6-35599801rq22@syhkavp.arg> <Z1kKlhUceHxZrMeS@x13> <n9o7rp0q-3894-544p-7s36-693qo49p9no2@syhkavp.arg> <Z1kZdw3VybM9zN3+@granite.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Dec 2024, Luis Felipe Hernandez wrote:

> On Tue, Dec 10, 2024 at 10:58:02PM -0500, Nicolas Pitre wrote:
> 
> > And for such kind of test, more values to test is not a bad thing. So 
> > I'd suggest keeping { 4294967295, 65535 ] as well in the set as this 
> > represents a nice 
> > edge case.
> > 
> > It wouldn't hurt adding the entire set from 0 to 9 as well. Many 
> > different edge cases in that range.
> 
> I see, agreed, thank you for your suggestions. I'll go ahead and carry
> out the following changes:
> 1. Replace the ULONG_MAX test case with the aforementioned { 2147483648,
> 46340, "large input"} case
> 2. Add the { 4294967295, 65535 } edge case
> 3. Add missing cases between 0 - 9
> 4. Add a couple more cases 
> 
> The updated test cases would be as follows:
> { 0, 0, "edge case: square root of 0" },
> { 1, 1, "perfect square: square root of 1" },
> { 2, 1, "non-perfect square: square root of 2" },
> { 3, 1, "non-perfect square: sqaure root of 3" },
> { 4, 2, "perfect square: square root of 4" },
> { 5, 2, "non-perfect square: square  root of 5" },
> { 6, 2, "non-perfect square: square root of 6" },
> { 7, 2, "non-perfect square: square root of 7" },
> { 8, 2, "non-perfect square: square root of 8" },
> { 9, 3, "perfect square: square root of 9" },
> { 16, 4, "perfect square: square root of 16" },
> { 81, 9, "perfect square: square root of 81" },
> { 256, 16, "perfect square: square root of 256" },
> { 2147483648, 46340, "large input: square root of 2147483648" },
> { 4294967295, 65535, "edge case: ULONG_MAX for 32-bit" },
> 
> I'll incorporate these changes and submit a new revision of this patch.
> Please let me know if there's anything else you'd like me to address.

Looks fine to me.


Nicolas


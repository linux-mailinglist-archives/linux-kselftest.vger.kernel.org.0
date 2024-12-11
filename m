Return-Path: <linux-kselftest+bounces-23143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318A99EC3CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 04:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D29B165E8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 03:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5E20C496;
	Wed, 11 Dec 2024 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="PAn1iSl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRoQNtoR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D52451CC
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889489; cv=none; b=jG2JfkyRgYzI84HdcFHPw6g4HJrMlAZgC6PdtFGlul6DBDuBLIz117GhoQ5dDAg70aS6DMMQgCw8aneYaQ8Cg3chqy11Sr0u9BjKMzdcI4xTWKqRzqifuiI0QTR05IMstSKnh44xUsblE8hcgqr0hRdHBrt1RQ49pfuCH7KviOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889489; c=relaxed/simple;
	bh=d+kJbO6K+9tWyE2tMurMS33oJ9/oMasaidPllJSQs2o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NQe43RbuAKDpLgsN8qVDlZh0jY4xXCUHFcykt5phVcxLxJ5Vhuwc3YJrxbrR3Yl/QAEihHEt/VGwNySGsbUk1ZmPQMxVlUMSrgxH4q4btqzC503WZaiNKVkXpXxopIW3uyWjEWn2dbO7kWnMoXS1guvgE347aLs/ERTVGKdlR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=PAn1iSl1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRoQNtoR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D4A911401D0;
	Tue, 10 Dec 2024 22:58:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 10 Dec 2024 22:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733889485; x=1733975885; bh=FbbrrLOw6A
	AHqANbuGm0G1U8QiPY8DgA54A4YSaCDIs=; b=PAn1iSl1P5kk0mIkW84x1tbKFn
	uYS+7OtCAwIHydnsh9NRMb40F3Tro31ELDu0bxL5H17rK9aLHx3mEMF0vNPFYlcC
	RUrtkKvP+Im/PXoZVjuk/4snX3k/S+2FnkTgfJbiBuN54SI2asC4772BKJaBFmpI
	IhaNhQssdpxsqIXHJiudQ1k7iSxZ2g0MCnFR4MPacjfarAkEwUzGF2dF8X8gOSud
	DmpkWhpMRnc9bPS7UBP5GzSBQ8vGTA1dU38IUqUE84dabAC7aNj+fQlobqVuBb2C
	/ch4RKdAC4CoyOMS3ka5ir9GwkFc1pEoM00waUNTUsWzlUkdwXzQ0sLJlHBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733889485; x=1733975885; bh=FbbrrLOw6AAHqANbuGm0G1U8QiPY8DgA54A
	4YSaCDIs=; b=cRoQNtoR2kzzcC4ogBcTlGh9BZ3yyx36t4W/9G7Hoi+7EJm9k6b
	BZ77VvwlbehcgVvccEWfP7RH4WcWPZARUydT7AqYAOILalnpIV2PWGAZiLr4tPpN
	PxCXkN23QSwNrYCKqU9U2EKJ1MyIGkwfCmPv+biCnT/BIQ5LwlttGpOsrlvBd0tK
	zMZh8h1SN/0bto0BlFrzO/7US7yBoUJneLqvMwWtOyuEfMNoGEs3CLw2+BdBr/ez
	qCNdJijyoX25nFS8PUHRpW9Qmn2EciKu2znbgssjlSIzNSNh/jLuuoogSP1QPtri
	yXYqABKG6JuWQbxLlYA4tQZrI+8wws3EbuQ==
X-ME-Sender: <xms:zA1ZZwWhvwDNWdqkjqs-ztAhdl0WnzQ8nyLJJVnad-d1wNyexgmrjA>
    <xme:zA1ZZ0kp1IrxCKsmKOKXdVLk8SJ8jnZanhTdcOjAn1V-rJ7TTKgTSyhDj6phk1S_R
    z0OlaJCk-vcXkeiKTQ>
X-ME-Received: <xmr:zA1ZZ0aCGQ4xoVKkVQmPkogG9t7s2CPtznAsgkA87fimcCjkqcc1n9-29ScN7RSUi8UAxzi8nwr8lt9DiuOEE9FuNCJY5BzXj2knhuiUdNezGHx-8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeelgdeifecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:zA1ZZ_XHUv3FbtwTwZUxMXlLielg20YKDU_y-T3-AwbtxLetVEU_bA>
    <xmx:zA1ZZ6kFBUSQTAna5rmJT5JSo1eSJZAR_ehjj3MPU65-lxYqa_kxXQ>
    <xmx:zA1ZZ0fb67_ettCh5cVCP5zfmvzqJ_LfKKIsKs2ils15lQ8-F-LCQw>
    <xmx:zA1ZZ8G4f8i-5MXUFs5oB6S_2MGwwJTgIIPU08-63FeEA6lk41jJew>
    <xmx:zQ1ZZzdUTNBsUVCikkHQ2sM9MDKIjisUGWrME3htDOw7PuXWtC9Gizqg>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 22:58:03 -0500 (EST)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id C4B8DF36FE4;
	Tue, 10 Dec 2024 22:58:02 -0500 (EST)
Date: Tue, 10 Dec 2024 22:58:02 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
cc: davidgow@google.com, Andrew Morton <akpm@linux-foundation.org>, 
    andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com, 
    skhan@linuxfoundation.org, rbm@suse.com, linux-kselftest@vger.kernel.org, 
    linux-kernel-mentees@lists.linuxfoundation.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH v4] lib/math: Add int_sqrt test suite
In-Reply-To: <Z1kKlhUceHxZrMeS@x13>
Message-ID: <n9o7rp0q-3894-544p-7s36-693qo49p9no2@syhkavp.arg>
References: <20241210172822.97683-1-luis.hernandez093@gmail.com> <9op57qr3-p152-6ns7-52n6-35599801rq22@syhkavp.arg> <Z1kKlhUceHxZrMeS@x13>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 10 Dec 2024, Luis Felipe Hernandez wrote:

> On Tue, Dec 10, 2024 at 02:59:12PM -0500, Nicolas Pitre wrote:
> > This will fail on a 32-bit system where sizeof(long) == 32 and 
> > ULONG_MAX == 4294967295. (meaning the result would be 65535).
> 
> Thank you for taking the time to review my patch and for pointing out the issue with the ULONG_MAX test case. I failed to think about how a 32-bit system would treat ULONG_MAX == 4294967295.
> 
> To address this, I was thinking of updating the test case to use a large enough value that remains within the bounds of unsigned long for both 32-bit and 64-bit architectures instead. Specifically, 2147483648 (2^31), which has an integer square root of 46340. I believe this would ensure the test remains valid and portable across all supported architectures.
> 
> The updated test case would be as follows:
> { 2147483648, 46340, "large input"}

Sure.

And for such kind of test, more values to test is not a bad thing. So 
I'd suggest keeping { 4294967295, 65535 ] as well in the set as this 
represents a nice 
edge case.

It wouldn't hurt adding the entire set from 0 to 9 as well. Many 
different edge cases in that range.


Nicolas


Return-Path: <linux-kselftest+bounces-16365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A19600F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 07:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFD55B22D16
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 05:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2265C6E614;
	Tue, 27 Aug 2024 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="ipHIFNFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZrpjKe8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE74CB4E;
	Tue, 27 Aug 2024 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735820; cv=none; b=QSl7nbb5ZubYa18M31+BmU/frMsRB8KpTMEh7dLsAAwDSvcqn2j7qFRaccE1VAPJ8Z3s/b7A8mVoaksLYoMB5Q9cVsnqmuxApNrbPSc7dmeIPU8CLJ83qbR5EjJZiWFNcdqob4wofyJD6LpeBweHf+actmsVQQIL81Cbsa/M90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735820; c=relaxed/simple;
	bh=4WVQlOdz4iUXl/ZtOOfq/sz3W/LEnSLvrPuKObENMTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8Aqq20gFD2+cPxZk1cXmU4dOIpN0inT9H5z8s5IziMDeLKGbqkZfHLIKehnYmwzOEUMlnRx2H8+EkjnPwrVX0/KluS/0cMDDxJnOjZPr5St/S8wR6hViveT3zeCqrjz7YBcSSJW+BTsZIM8LWf6Z9ylCJHOt7RRu3MmGDBVnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=ipHIFNFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZrpjKe8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D2FCA1151AF6;
	Tue, 27 Aug 2024 01:16:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 27 Aug 2024 01:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1724735816; x=1724822216; bh=XnEvNey2dg
	8TqK9++0fBtgkojn39VmGvBW+c5uPNs9s=; b=ipHIFNFMnmvaLASurFuE42XJ4H
	O8MrnVSKQUw03hTaOnltaJqp2HuL0JHkUxeSXLdzur4y7mroys9FKIbKrCfi4LVp
	D0+qILxcw7a9fj/0IxAZQKYrcdHSYal0a1hZekhTAc4sxGGymnpDimUjBpX8jk/Q
	3jto+BQFa5NUW/e5k+dquBj7/pVxHj82SIMbnf5nsJsVj2igvaCRxGCQfL1hxOeX
	jFMTuC30i6mEeu1HpC2tjoqC26sZfCf6o6D9Bmwvxh9V/q9gqDb7QDSvXvBCUhI4
	o/iz6qu5U2euvVz8aWdhd57z8mmyjuBXMHNtJ6nIEgvO8nGWN5Y2dqxJArVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724735816; x=1724822216; bh=XnEvNey2dg8TqK9++0fBtgkojn39
	VmGvBW+c5uPNs9s=; b=OZrpjKe8QTwXHNK9igIuz6o4ItQw8i++ZLrkg3NlIlOj
	JonKQ5pjMhe/r13UcnD5S2jnAj5Cjzd7+BjhTWC3NO/F1oqfRY5+KNdUQ8jsXu5e
	h6+CxnqjvHQWJ71mPRTCEAzwVEazXaZJf22sEeqcJTeeE6jacSorkJeJJ7tSsZ7L
	ssquZzyxAMMZo/k0nBd7auR7esQRp/Jtrnvm6i2Cf2kMpYLHQ6LT76bspgsDTgal
	iXEnMomdtYh3NheymhgIH1HUHsX7fJPE7050Ut/t2RrElg4hMbEt+dyxlTy5ye7T
	2j76W9WWWKyjRrmwiad8rdjB/ywbhD+SY/NP0b/7+A==
X-ME-Sender: <xms:SGHNZqMOa9a0hX7KLMIJQ-lb8D6K4Vc1vyJ_22Bp04X-zef5LhfaAA>
    <xme:SGHNZo_J9Zqv91k-y8WN597TfOwg-1szt4m-WEn2OLTHeKLdm7H2bmXNaBGb6kBYC
    MdJpapY9u4H824jOco>
X-ME-Received: <xmr:SGHNZhSk8ZYSMatRbA4Dkc8tNNB0XWYT3sBQUfULlm_5kWWQoTAW83Z5_xgdeOVQNbivpeyDQLtbmk8BOsG1MN1ccbxGm4Xzbo84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgvthgvrhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvg
    hrseifhhhoqdhtrdhnvghtqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudff
    hfevheejffevgfeigfekhfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihh
    ohdqthdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsggvnhhtihhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhikhho
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:SGHNZqtAoD21fPi8acR_pj7bJolz_ursOrpitpBpE8v70B58m_wpHQ>
    <xmx:SGHNZifvPFupfwpZYEphbyaj2WK8BdSdVdYdfnr33GnG5eOGpa2XRA>
    <xmx:SGHNZu15qWJb9jvfWg_3YA5PY1MsqAB7XEpYO_vp2cwp6UxJNp0hCA>
    <xmx:SGHNZm9pzaSWnZqYx0DTBCwFLOZrLSRH8BSOtJtKUCNPVymNlNhhwQ>
    <xmx:SGHNZqRilbTf-yWYtC5G9xsmt_jKTlTcDcvdKSRlmstliBWugxKvN6M0>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 01:16:54 -0400 (EDT)
Date: Tue, 27 Aug 2024 15:16:44 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/3] selftests/hid: Add HIDIOCREVOKE tests
Message-ID: <20240827051644.GA1580781@quokka>
References: <20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org>
 <20240827-hidraw-revoke-v4-3-88c6795bf867@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-hidraw-revoke-v4-3-88c6795bf867@kernel.org>

Thanks for picking this up and adding the tests, much appreciated

On Tue, Aug 27, 2024 at 12:47:53AM +0900, Benjamin Tissoires wrote:
> Add 4 tests for the new revoke ioctl, for read/write/ioctl and poll.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> ---
> 
> new in v4
> ---
>  tools/testing/selftests/hid/hidraw.c | 143 +++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
> 
> diff --git a/tools/testing/selftests/hid/hidraw.c b/tools/testing/selftests/hid/hidraw.c
> index f8c933476dcd..669eada8886b 100644
> --- a/tools/testing/selftests/hid/hidraw.c
> +++ b/tools/testing/selftests/hid/hidraw.c
> @@ -19,6 +19,11 @@
>  	__typeof__(b) _b = (b); \
>  	_a < _b ? _a : _b; })
>  
> +/* for older kernels */
> +#ifndef HIDIOCREVOKE
> +#define HIDIOCREVOKE	      _IOW('H', 0x0D, int) /* Revoke device access */
> +#endif /* HIDIOCREVOKE */
> +
>  static unsigned char rdesc[] = {
>  	0x06, 0x00, 0xff,	/* Usage Page (Vendor Defined Page 1) */
>  	0x09, 0x21,		/* Usage (Vendor Usage 0x21) */
> @@ -516,6 +521,144 @@ TEST_F(hidraw, raw_event)
>  	ASSERT_EQ(buf[1], 42);
>  }
>  
> +/*
> + * After initial opening/checks of hidraw, revoke the hidraw
> + * node and check that we can not read any more data.
> + */
> +TEST_F(hidraw, raw_event_revoked)
> +{
> +	__u8 buf[10] = {0};
> +	int err;
> +
> +	/* inject one event */
> +	buf[0] = 1;
> +	buf[1] = 42;
> +	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
> +
> +	/* read the data from hidraw */
> +	memset(buf, 0, sizeof(buf));
> +	err = read(self->hidraw_fd, buf, sizeof(buf));
> +	ASSERT_EQ(err, 6) TH_LOG("read_hidraw");
> +	ASSERT_EQ(buf[0], 1);
> +	ASSERT_EQ(buf[1], 42);
> +
> +	/* call the revoke ioctl */
> +	err = ioctl(self->hidraw_fd, HIDIOCREVOKE, NULL);
> +	ASSERT_OK(err) TH_LOG("couldn't revoke the hidraw fd");
> +
> +	/* inject one other event */
> +	buf[0] = 1;
> +	buf[1] = 43;
> +	uhid_send_event(_metadata, self->uhid_fd, buf, 6);
> +
> +	/* read the data from hidraw */
> +	memset(buf, 0, sizeof(buf));
> +	err = read(self->hidraw_fd, buf, sizeof(buf));
> +	ASSERT_EQ(err, -1) TH_LOG("read_hidraw");

do you want to check for errno == ENODEV here to avoid false positives?
Shouldn't really happen in this test suite but it costs very little.

Same for the various cases below.

With or without - series:
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter


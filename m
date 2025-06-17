Return-Path: <linux-kselftest+bounces-35179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11460ADC371
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8251894C8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957631C7017;
	Tue, 17 Jun 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlHfEQbn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hosJjpcb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDAF28DEEE
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145718; cv=none; b=s6bh6YI/yQrY66Zkpk/WIQlOEf8TnNwcev0YS9W80Ieg2R8ojGnfs39ujUCOJ1F+oqAdi+WDvPJLDfKdyIKlPnui7axYOtuEKiMrBC1qGPmHRUbaORfk2rCs1fxEVqe/BGdbO1K3sm+bUF6wpOzZdBmYBs2EBRZq7mtQCNoGfF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145718; c=relaxed/simple;
	bh=8Bj6UxJmWo6ZL7eQWEJQVL8ah4qElYvvknHg5mkqSUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roJW/XhmeDPdxJ7qEc7Ftt54M2Z5kkGNMoaIAp4itovT5SP3DTTSQcfJaCZ/dyMUlM9Zx3m191l2iv5X8iPeJMTfA83Lpf4h+yHPs+TUY3eYWHGRS0hsqyweWzQ0qCWjILMqUfKV+aRiMtxts4L2Dl62Prb9hScI3DvFzD0rKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlHfEQbn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hosJjpcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:35:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750145713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+F5zCQcHtpecYVTaX13HkIaVjqaWpGadJi+kEk0pg0=;
	b=KlHfEQbnUIzhTtH8MnJTohw2bPAfn5ZBvhOheogdyLjHu+VddXVLDbxjrqXsaxYZo0CfEy
	2xo1NIv+DH5y+n7yIwh95v0UrCSL8/r39jrgiMKkP0/Z870o+wPHQ0bcaXs+jjf2K01GjU
	fZL3aBn6aqtV4MB+HFXh6Ulc+m6beGvSut56sogjQhqzrcU2zYK/SEWnnuafv2tIV7z60F
	/CzmDWI+ILbOmas5Ko/DgMgGXRLWclc5tGSMgFVwcWS6Htc/qgcAvA4w1Mf891mKNKmy+b
	aptynWfJgzNNUy99c6pHDdba4gw6bug/cqdd9FNcpuoPcalz7BspOgJ/eyaC1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750145713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A+F5zCQcHtpecYVTaX13HkIaVjqaWpGadJi+kEk0pg0=;
	b=hosJjpcbZtj+5uTs+xpw5w7ydEPMCmR8ncWjokfj0pu27hDxOnfkp9T7N7OP36NQWQGPXd
	JPQayiXio3UQPMBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, 
	wad@chromium.org, linux-kselftest@vger.kernel.org, usama.anjum@collabora.com, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
Message-ID: <20250617093230-7c07d08b-5956-4a78-863c-f35cc300815c@linutronix.de>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616122338.32678-4-richard.weiyang@gmail.com>

Good idea.

On Mon, Jun 16, 2025 at 12:23:38PM +0000, Wei Yang wrote:
> Each fixture could support variant. Add fixture with variant to verify
> the behavior, so we can validate for further change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  .../kselftest_harness/harness-selftest.c      | 34 +++++++++++++++++++
>  .../harness-selftest.expected                 | 22 +++++++++---
>  2 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
> index b555493bdb4d..2fd5310b33c7 100644
> --- a/tools/testing/selftests/kselftest_harness/harness-selftest.c
> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
> @@ -118,6 +118,40 @@ TEST_F(fixture_setup_failure, pass) {
>  	TH_LOG("after");
>  }
>  
> +FIXTURE(fixture_variant) {
> +	pid_t testpid;
> +};
> +
> +FIXTURE_VARIANT(fixture_variant)
> +{
> +	int value;
> +};
> +
> +FIXTURE_VARIANT_ADD(fixture_variant, v32)
> +{
> +	.value = 32,
> +};
> +
> +FIXTURE_VARIANT_ADD(fixture_variant, v64)
> +{
> +	.value = 64,
> +};
> +
> +FIXTURE_SETUP(fixture_variant) {
> +	TH_LOG("setup %d", variant->value);
> +	self->testpid = getpid();
> +}
> +
> +FIXTURE_TEARDOWN(fixture_variant) {
> +	TH_LOG("teardown same-process=%d", self->testpid == getpid());
> +}
> +
> +TEST_F(fixture_variant, pass) {
> +	TH_LOG("before");
> +	ASSERT_EQ(0, 0);

Please log the variant value from the test itself and the teardown function.
Also I don't think we need the pid logging and before/after/ASSERT in this test
also, it is already validated in the other ones.

> +	TH_LOG("after");
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	/*
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.expected b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
> index 97e1418c1c7e..ab081c5aba05 100644
> --- a/tools/testing/selftests/kselftest_harness/harness-selftest.expected
> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
> @@ -1,6 +1,6 @@
>  TAP version 13
> -1..9
> -# Starting 9 tests from 4 test cases.
> +1..11
> +# Starting 11 tests from 6 test cases.
>  #  RUN           global.standalone_pass ...
>  # harness-selftest.c:19:standalone_pass:before
>  # harness-selftest.c:23:standalone_pass:after
> @@ -60,5 +60,19 @@ ok 8 fixture_parent.pass
>  # pass: Test terminated by assertion
>  #          FAIL  fixture_setup_failure.pass
>  not ok 9 fixture_setup_failure.pass
> -# FAILED: 4 / 9 tests passed.
> -# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0
> +#  RUN           fixture_variant.v32.pass ...
> +# harness-selftest.c:141:pass:setup 32
> +# harness-selftest.c:150:pass:before
> +# harness-selftest.c:152:pass:after
> +# harness-selftest.c:146:pass:teardown same-process=1
> +#            OK  fixture_variant.v32.pass
> +ok 10 fixture_variant.v32.pass
> +#  RUN           fixture_variant.v64.pass ...
> +# harness-selftest.c:141:pass:setup 64
> +# harness-selftest.c:150:pass:before
> +# harness-selftest.c:152:pass:after
> +# harness-selftest.c:146:pass:teardown same-process=1
> +#            OK  fixture_variant.v64.pass
> +ok 11 fixture_variant.v64.pass
> +# FAILED: 6 / 11 tests passed.
> +# Totals: pass:6 fail:5 xfail:0 xpass:0 skip:0 error:0
> -- 
> 2.34.1
> 


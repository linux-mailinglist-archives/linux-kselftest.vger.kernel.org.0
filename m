Return-Path: <linux-kselftest+bounces-35070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1BADB081
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B0E1885A68
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AA285C8D;
	Mon, 16 Jun 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="MGR5nA4e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278D74420
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Jun 2025 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077971; cv=pass; b=GnSC4JwBh106cdQ5j1qCM087yeypTj32V3hM/FtBHkMOqcTPrEICSq6QZ390UphcxllDtkyW47ER0Gs5Xhw2zlTxRbVe02M2d0T/52QnLRTW7faQRXdMQ2Z4q/SMHexIAt8KGKweIwLOyFnI2ooQbzmpvr5noZJ8zwIfhCeOBLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077971; c=relaxed/simple;
	bh=nXZ5FSNvq8+c+iCU+S++iA1FtK4jHTlydiqpNvVW1ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhswlpYiiB0V5imhthUMPRRu/GhmekMtlbvllcwSgSRB/BTrU81Azfkyk+Hrlpz3mMYA2yipEIzoBC9auxrTpzhIxk5ZeY0Pw+mT3SmVKDEUhDCSfqpwLuPq2T1kqEtIkYeNnHfM/5Nw0fCvNKTg5QK7V/1CMCb4Z1lKop2zoD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=MGR5nA4e; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750077954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XnECskGVeQ5dvmvhEfX2gTwMBsja5dYyP54+LO1C4rgEB77s2p7kcgMbPtnXeWrj2GimiDIEuP461u7k9FxxL/nPT6Kp8ajh/M24bGEN7ZNFeWmc7oL02SQRJue/cjZ4uJNXNpiucqc0qVWp3eRdknu5s8NDtbOV6qUokR4sDhU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750077954; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kzMbBk4yZSDetFEtB+dbSMKG/3mpaLK9Y7y94cAj8ls=; 
	b=ENgp2w2uQi57rXdepNpat+Wtmz7/MtycdKV1Bwffl/YzlVHlcapiK7L2+8QPNY5YsPTktl/mrulPkSS4Xq2VoqD6TRI6M1M8Wn+eqfPRB4ZkXnZ02mLBHX4YkdYSktEc+1/I7chNag6uEoHQc1XpwR92zWU+tYvZ5kFbXMIfjw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750077954;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kzMbBk4yZSDetFEtB+dbSMKG/3mpaLK9Y7y94cAj8ls=;
	b=MGR5nA4eQTkAYwpbWsblB+He13KmRfW9sA/QAOY6yWjMuiUwk0Fpbsvt6sPLy8w4
	nW1ilCyiG8+BRwRT2kIX5ywf5UmGJ4d5xq3SrYIs6PpbD/uG+ptxDoiCqpO/5LRwMPB
	h3PpV/x4p+I4rY1VaiseablQzTZUtFP8DyBLRHDs=
Received: by mx.zohomail.com with SMTPS id 17500779473471013.1509689361076;
	Mon, 16 Jun 2025 05:45:47 -0700 (PDT)
Message-ID: <f5b58230-c5cf-4c4c-afdb-752f3fc5d233@collabora.com>
Date: Mon, 16 Jun 2025 17:45:42 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: harness: Add kselftest harness selftest
 with variant
To: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
 luto@amacapital.net, wad@chromium.org
Cc: linux-kselftest@vger.kernel.org, thomas.weissschuh@linutronix.de,
 skhan@linuxfoundation.org
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-4-richard.weiyang@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250616122338.32678-4-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 6/16/25 5:23 PM, Wei Yang wrote:
> Each fixture could support variant. Add fixture with variant to verify
> the behavior, so we can validate for further change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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



Return-Path: <linux-kselftest+bounces-35407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865EAAE14A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9F3B802E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15322539C;
	Fri, 20 Jun 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="EHxB1cup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD9A923
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Jun 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403593; cv=pass; b=GPZqT7VCuCWG9mJc65qLweLE85iGeNFcjpPXxyBpRDWZtzwfQaAHbmckWhORcuJGuUXK+uO1Bg4Z2zZUZFAKr0L3/mnyZSDDC0K0RZweAHpJ6uTQl7wejuUqObnQWoUZEv1YPRDjpZEFxsP36r9fAum+x21vHmqGLy+dZPyNd8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403593; c=relaxed/simple;
	bh=cZ/kTKODTzpxcmn7kF9lMqkByHhdt4jH/XRz5dvsy1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2WdoO2K34X0cEPR+RF0xK8nHFQEXjJ4YdvPC6SW4I8PMRvii0A7s3kKy7trz1MNZ7aNMb4grsnSJuzG5VuSYX6KufpLybnyWOe8sxnwqsti5NXWzUzxtGokmaOaWDG/XlYJwSJXAmyoEHF8hAQwAznwrtlBQ4nQFRE34op2uMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=EHxB1cup; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750403563; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VGYX1rooXg8k+emYkBxFc7tfJJhCw0OZSqFTCuByzgXZ7RZNJ/gWTaLKxi2wXZoiuSBlBICzblWGxXD+nQB71vogpJ3lkz8NvZOQgNNow3OD8YWAe8VyCXlDJYaeSYRy/61IquIgh15BgYShL+wHlBGNdIJq83PF8tY0ifHdE1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750403563; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SxV9sUml3MVYY3MKp0I1DUJDuBNKxBXB2+iR5uPyizI=; 
	b=IHVWTcXBaTIT3HfNupzZ12tbxMO9efKAa+K+UoXuGu7ZYrH4OkFjNVhiGSLLm/APL9Fw8IF1HufEMrFXwEPu5wG1lNL6Lx7CbKS1dTAcJ9SlByFGZrsJGWecHkYJNgvKZiz3c0c1SImvLinXGxEaEmpgjkTLVTMH2pydrIln+bA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750403563;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SxV9sUml3MVYY3MKp0I1DUJDuBNKxBXB2+iR5uPyizI=;
	b=EHxB1cupV82Sr8F66/CzNRxFrj6Ju8MqBjHPdnsyAQGiRhKQQMS58anKUVAzlSAm
	87ZRFrDG/uTrw+5NFvdzSJ55I0HXow2trBptbvHCmGkIy4yP2wP333Dug2fm3+vJzL0
	nRUF/V40P7Q36ALTdfbvCqd3ZPejOz1jZXZrMLWs=
Received: by mx.zohomail.com with SMTPS id 1750403561123392.23202229615845;
	Fri, 20 Jun 2025 00:12:41 -0700 (PDT)
Message-ID: <c186f47c-3078-45a8-b677-7b5d5273fd5c@collabora.com>
Date: Fri, 20 Jun 2025 12:12:40 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/2] selftests: harness: Add kselftest harness selftest
 with variant
To: Wei Yang <richard.weiyang@gmail.com>, kees@kernel.org,
 luto@amacapital.net, wad@chromium.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, thomas.weissschuh@linutronix.de
References: <20250620032815.14543-1-richard.weiyang@gmail.com>
 <20250620032815.14543-3-richard.weiyang@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250620032815.14543-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 6/20/25 8:28 AM, Wei Yang wrote:
> Each fixture could support variant. Add fixture with variant to verify
> the behavior, so we can validate for further change.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> v2:
>   * remove testpid
>   * print value in teardown and test itself
> ---
>  .../kselftest_harness/harness-selftest.c      | 30 +++++++++++++++++++
>  .../harness-selftest.expected                 | 20 ++++++++++---
>  2 files changed, 46 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
> index b555493bdb4d..2a2a91717fce 100644
> --- a/tools/testing/selftests/kselftest_harness/harness-selftest.c
> +++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
> @@ -118,6 +118,36 @@ TEST_F(fixture_setup_failure, pass) {
>  	TH_LOG("after");
>  }
>  
> +FIXTURE(fixture_variant) {
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
> +}
> +
> +FIXTURE_TEARDOWN(fixture_variant) {
> +	TH_LOG("teardown %d", variant->value);
> +}
> +
> +TEST_F(fixture_variant, pass) {
> +	TH_LOG("test function %d", variant->value);
> +}
> +
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

>  int main(int argc, char **argv)
>  {
>  	/*
> diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.expected b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
> index 97e1418c1c7e..0c19794e018d 100644
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
> @@ -60,5 +60,17 @@ ok 8 fixture_parent.pass
>  # pass: Test terminated by assertion
>  #          FAIL  fixture_setup_failure.pass
>  not ok 9 fixture_setup_failure.pass
> -# FAILED: 4 / 9 tests passed.
> -# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0
> +#  RUN           fixture_variant.v32.pass ...
> +# harness-selftest.c:140:pass:setup 32
> +# harness-selftest.c:148:pass:test function 32
> +# harness-selftest.c:144:pass:teardown 32
> +#            OK  fixture_variant.v32.pass
> +ok 10 fixture_variant.v32.pass
> +#  RUN           fixture_variant.v64.pass ...
> +# harness-selftest.c:140:pass:setup 64
> +# harness-selftest.c:148:pass:test function 64
> +# harness-selftest.c:144:pass:teardown 64
> +#            OK  fixture_variant.v64.pass
> +ok 11 fixture_variant.v64.pass
> +# FAILED: 6 / 11 tests passed.
> +# Totals: pass:6 fail:5 xfail:0 xpass:0 skip:0 error:0



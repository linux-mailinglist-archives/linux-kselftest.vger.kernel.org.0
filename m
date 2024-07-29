Return-Path: <linux-kselftest+bounces-14384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0F93F8C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A01F2289D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5F1552E0;
	Mon, 29 Jul 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QUqEX4Sj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672AA15383A;
	Mon, 29 Jul 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264735; cv=none; b=OFoZB36NUQ/INpgvrGfwg3z0oPtIozIu5W9Ylx1sgw8z9rdovc86ARC0OMwY9JE0ZkBaI/bfj2oTuhxINN39iR61rDHMIttzgmhiP5r5EH+JwXl1ql0ajys/R9rU86XSDUDht8vkjlrPezc8d2PbdL8Xo6LUZRDyfgOmNvrnv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264735; c=relaxed/simple;
	bh=vxcbGccfMSfGNehJ2LcMJTELjJug/egUl7ukelRUedo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQ9XZaIbmtVFJ0cF04wCh2NbECTBL2VXEWDrX3u/cyT70UpQQ1RBhRXGO58SXcDPMNfqvUqApm2MrrNo9pcEjv69or43/8j777kUsa8Y2OVpCAvC1GHGoRLs0DqHDvn77RNCKt3OmeoeAqL5+++H05bu4N50wItHfdF5YCyv3C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QUqEX4Sj; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722264731;
	bh=vxcbGccfMSfGNehJ2LcMJTELjJug/egUl7ukelRUedo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUqEX4Sj2ycGyTrVvE8RkKiPFIGE41YXymnDIF+2nFf/dln7xFJCWydFBFNFKQldk
	 TPvSMzeNJtsiLJrzLhIkcqnFGOZO1ioaQVAuEPcRggzE7R5Fn6UfooYhglsQ6SvEAz
	 /kocTbQJJ583TYKhhUXx1ZdVRnep06tfBLQ4ZyevZ27UDERiqqEV9UktrbRPwi7PB7
	 oZVA+Td1d48Hawk68G+QpsOBJfO6kWoWE43tvXw4ppwrYjChhdyPEXf4CnTJkdv43e
	 ii+sBPVKrCvByhZDFdhlUMjKezvJHQ3nxaEqIx0gq60obYR3vpIVjgJo/vKCm49+mm
	 mO3owTCNZV+Pw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C75B3780480;
	Mon, 29 Jul 2024 14:52:11 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: skhan@linuxfoundation.org
Cc: gregkh@linuxfoundation.org,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	nfraprado@collabora.com,
	shuah@kernel.org
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the test suite
Date: Mon, 29 Jul 2024 16:52:22 +0200
Message-Id: <20240729145222.119830-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9009f4df-ca7e-4961-97e4-446afc4e87d2@linuxfoundation.org>
References: <9009f4df-ca7e-4961-97e4-446afc4e87d2@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shuah,

On 7/23/24 18:17, Shuah Khan wrote:
> On 7/22/24 09:43, Laura Nao wrote:
>> Consider skipped tests in addition to passed tests when evaluating the
>> overall result of the test suite in the finished() helper.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kselftest/ksft.py 
>> b/tools/testing/selftests/kselftest/ksft.py
>> index cd89fb2bc10e..bf215790a89d 100644
>> --- a/tools/testing/selftests/kselftest/ksft.py
>> +++ b/tools/testing/selftests/kselftest/ksft.py
>> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>>   def finished():
>> -    if ksft_cnt["pass"] == ksft_num_tests:
>> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>>           exit_code = KSFT_PASS
> 
> Laura and Nícolas,
> 
> I saw both your emails explaining how this fixes the problem in
> a previous patch.
> 
> However looks like you haven't see my response about the implications
> of the exit_code = KSFT_PASS when tests are skipped.
> 
> if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>>           exit_code = KSFT_PASS
> 
> Let me reiterate in case you missed it:
> 
> There is a reason why you don't want to mark all tests passed
> when there are several skips.Skips are an indication that
> there are several tests and/or test cases that couldn't not
> be run because of unmet dependencies. This condition needs
> to be investigated to see if there are any config options
> that could be enabled to get a better coverage.
> 
> Including skips to determine pass gives a false sense security
> that all is well when it isn't.
> 
> So it is incorrect to set the exit code to KSFT_PASS when there
> are skipped tests.

Just to be clear, the logic in ksft_finished() in kselftest.h (the C
helper) is to exit with KSFT_PASS when there are only passed and skipped 
tests. You're suggesting we change it to exit with KSFT_FAIL in that 
case?

Under this new logic, the runner would effectively treat skips as 
failures, impacting existing kselftests.

> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
> 
> 
>>       else:
>>           exit_code = KSFT_FAIL
> 
> The logic here seems to not take into account when you have a
> conditions where you have a mixed results of passed tests,
> skipped tests, and failed tests.
>
> Please revisit and figure out how to address this and report
> the status correctly.

The logic ensures that if there’s a mix of passed, skipped, and failed 
tests, the exit code returned is KSFT_FAIL. I believe that if there is at 
least one failed test, the overall test should be reported as failed, 
which is what happens in this case.

Thanks,

Laura


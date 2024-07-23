Return-Path: <linux-kselftest+bounces-14081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEC93A24D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D38B1F240AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 14:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAFB15383C;
	Tue, 23 Jul 2024 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UiLG2loR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8715383D;
	Tue, 23 Jul 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743576; cv=none; b=DYCjuGdKN4pQcnyquSCP58JJ3kz3naRAV12gZ5yZPWPJ6IzqSErhJBrbrqQaJHuhseBOrm7qPSRAobPdwemYuyLYzdIBzezl3dDJGzI5+v3v0w/oPNCDaWL1O3U4rkTq5WJrzJrStZN5QmqDhIcmlOaZGsAd3kCQ0Z2zF6OMyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743576; c=relaxed/simple;
	bh=5LfyikNmc6t2ubKu/NIbF+5AkfKO3WK3yLfCxk7MCGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C91eMNuBhU04S62BEIyGnQM71pQgNt5o4Zu+ruDLhmmIJPpuATQhhGl7GkRtkxqORzhuWexQ4cIpnjNda6RgIniHYkcY8R4ifbAP9ojlJE8sPF3+FQs/+2YlA4vTLarzpbMhgBwxvm/dVVzOWzgc0LM/matofWnpZOgzT7AX9Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UiLG2loR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721743573;
	bh=5LfyikNmc6t2ubKu/NIbF+5AkfKO3WK3yLfCxk7MCGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiLG2loR9Vj0x0LT4vx7G+zWRuz/2/Xi5iElgWwWPqIEKVowPDVth1NpXs6gTjdrH
	 +8nrg6JUDRpjeGcq1t4A5EGcqpBfpc3hcRx0xTNim0pCNYMVh4psLNcnap/En1CT02
	 Cz9LCSGYfNIPmyL+YtgtivQbL67t8Fva6rDissrKTIOGd2pBxuN4wBTk7WcqRHK698
	 iD0jlAu4Sd0RYe8ciwziQB2Jw7nFyX618mFSQpN/2Bwm+7+ZRC04C7kL1Y4Qb+JaEu
	 gXgklK/IoednBHhlnzzlkLahesWrL/Hw9nXsVjgcOWz+lA2otC0pSrourqEGFyZkdn
	 aSCw3puYNuxyQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3B44378143B;
	Tue, 23 Jul 2024 14:06:11 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: nfraprado@collabora.com
Cc: gregkh@linuxfoundation.org,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the test suite
Date: Tue, 23 Jul 2024 16:06:22 +0200
Message-Id: <20240723140622.100847-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b558e9dd-3c09-44a2-923d-afe7bc2a7e97@notapiano>
References: <b558e9dd-3c09-44a2-923d-afe7bc2a7e97@notapiano>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/24 20:51, Nícolas F. R. A. Prado wrote:
> On Mon, Jul 22, 2024 at 11:32:35AM -0600, Shuah Khan wrote:
>> On 7/22/24 09:43, Laura Nao wrote:
>>> Consider skipped tests in addition to passed tests when evaluating the
>>> overall result of the test suite in the finished() helper.
>>>
>>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>>> ---
>>>    tools/testing/selftests/kselftest/ksft.py | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
>>> index cd89fb2bc10e..bf215790a89d 100644
>>> --- a/tools/testing/selftests/kselftest/ksft.py
>>> +++ b/tools/testing/selftests/kselftest/ksft.py
>>> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>>>    def finished():
>>> -    if ksft_cnt["pass"] == ksft_num_tests:
>>> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>>
>> Please don't. Counting skips in pass or fail isn't accurate
>> reporting. skips need to be reported as skips.
> 
> Hi Shuah,
> 
> this won't change the skip count, just allow a test suite that has a mix of pass
> and skip results to exit with code 0. That's the same behavior as the C
> ksft_finished() helper in kselftest.h:
> 
> #define ksft_finished()			\
> 	ksft_exit(ksft_plan ==		\
> 		  ksft_cnt.ksft_pass +	\
> 		  ksft_cnt.ksft_xfail +	\
> 		  ksft_cnt.ksft_xskip)
> 

Correct, this patch aligns the behavior of the python helper with both 
the existing C and bash counterparts (ksft_finished() and 
ktap_finished() respectively).

> It was my oversight to not do the same in the python helper.
> 
> Laura,
> 
> I consider this fixing an incorrect behavior, so I'd add this tag:
> 
> Fixes: dacf1d7a78bf ("kselftest: Add test to verify probe of devices from discoverable buses")
> 
> I think the message is good as is, but maybe it could have mentioned that this
> matches the behavior of the C helper, just to make the point above clearer.
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> And just a note for the maintainers, this patch depends on "kselftest: Move ksft
> helper module to common directory"
> https://lore.kernel.org/all/20240705-dev-err-log-selftest-v2-2-163b9cd7b3c1@collabora.com/
> which was picked through the usb tree but is queued for 6.11-rc1.
> 

Right, thanks!

Shuah, please let me know if you have any other concerns with this patch.

Best,

Laura


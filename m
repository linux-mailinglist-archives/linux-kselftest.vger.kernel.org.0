Return-Path: <linux-kselftest+bounces-13973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E13693857E
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 18:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99FFB20A0C
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A21662E8;
	Sun, 21 Jul 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kd0dAsZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E72629F;
	Sun, 21 Jul 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579855; cv=none; b=c10hlqeDZzvT0AeF0gaTEFwpZ8fYQ934ALAKRG2d/0fcPxd0DsOYJ1GAFfgf8A5RFRKuKAN8uvlKdcHbu1j+gdyAIVcUkC9iSDB7AX9+zDd+qg2xILd36DgqIjhbZPHmplZS7mEE/u7wBUNZYJ60pIwJTJQn98Kc85VzlnDXOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579855; c=relaxed/simple;
	bh=dXecPxBEgm8roSDZCBgZpZUR8iqsz6Sib3B9XIYQFq8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jXHMEmyuqRx/RmGNfJD9LU78xOW5OedhSehXvNh9ms9zv5J64/yDUbInLmNBm5ezXV5MTntaaPDOgCNtSzsl46yazP6nrmTupgRRns+uwkOox5XJOirZpXNB7KdbLxB7MKcZzKOtTDkMqnQjC8S8CWIYVj3g1dgvrBUSiJkyhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kd0dAsZI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721579851;
	bh=dXecPxBEgm8roSDZCBgZpZUR8iqsz6Sib3B9XIYQFq8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kd0dAsZI1QsYUaDsyHa67oG0bpHA6YXrv+yuZsgszlPiNrDWceatTlFchTTnroQ+B
	 Lr4Tmeu1ZrAPtT7qrGhcndrSQVTaAtRB1Cx3/Zwy+4wg91lI8J7QEduFj2iapb7VI3
	 NpbfrBQGrVyCwRTWqRR1oj2A8znTwWMaPiPro/L9xH+MUF49YbBlsGslJOfJG7sNqx
	 EbdV5n+OC2zRgdYv6g6yDSyKEIU7nWvE/Ioo9w+2wc1k2DRsSyTFj1UW+FQAEte2IW
	 vvklpMTw8s9+aeqX4lc9nn79ypP1ShsAFhkVC55cLVjsZ7NrLbbh3Y7NnEjF3yZgvv
	 Y6v6ql4Qjj42w==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 70E853780627;
	Sun, 21 Jul 2024 16:37:24 +0000 (UTC)
Message-ID: <87fbfba4-8d4d-44ff-9fe5-e101cce3d6cb@collabora.com>
Date: Sun, 21 Jul 2024 21:37:20 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting
 of pass/fail tests
To: Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
 <9cf7f693-bc6a-415b-99c3-f6c59b871c4f@linuxfoundation.org>
 <77a66e39-7f34-4b3c-ac8d-e48d8c5a2830@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <77a66e39-7f34-4b3c-ac8d-e48d8c5a2830@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/24 9:24 PM, Muhammad Usama Anjum wrote:
> On 7/19/24 9:40 PM, Shuah Khan wrote:
>> On 7/12/24 01:30, Muhammad Usama Anjum wrote:
>>> Use kselftest wrapper to mark tests pass/fail instead of manually
>>> counting.
>>
>> You care combining two changes in the patch.
>>
>> This is needed to return correct exit status. This also
>>> improves readability and mainability.
>>
>> Spelling - "mainability" - checkpatch would have helped you
>> catch this.
> Sorry I'll fix it after following discussion. I use checkpatch with
> spelling checker. I may have missed it for this patch.
> 
>>
>> The change to return the correct error fine and but not the
>> change thaT ADDS DUPLICATE tap header.
>>
>>>
>>
>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>   tools/testing/selftests/x86/vdso_restorer.c | 20 +++++++-------------
>>>   1 file changed, 7 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/x86/vdso_restorer.c
>>> b/tools/testing/selftests/x86/vdso_restorer.c
>>> index fe99f24341554..8e173d71291f6 100644
>>> --- a/tools/testing/selftests/x86/vdso_restorer.c
>>> +++ b/tools/testing/selftests/x86/vdso_restorer.c
>>> @@ -21,6 +21,7 @@
>>>   #include <unistd.h>
>>>   #include <syscall.h>
>>>   #include <sys/syscall.h>
>>> +#include "../kselftest.h"
>>>     /* Open-code this -- the headers are too messy to easily use them. */
>>>   struct real_sigaction {
>>> @@ -44,9 +45,10 @@ static void handler_without_siginfo(int sig)
>>>     int main()
>>>   {
>>> -    int nerrs = 0;
>>>       struct real_sigaction sa;
>>>   +    ksft_print_header();
>>
>> The problem with adding this header here is when
>> make kselftest TARGETS=vDSO is run there will be
>> duplicate TAP 13 headers.
> Usually all TAP compliant tests print TAP 13 header at the start. These
> tests when run from make run_tests have duplicate TAP 13 headers. I don't
> think that this is the issue. Why do you think it is wrong?
> 
> For example, I've attached the logs of vDSO test suite. TAP header is
> printed at the start. Then it is printed again at the start of the test if
> it is TAP compliant e.g., vdso_test_abi and vdso_test_getrandom. These
> tests are already TAP compliant. Other tests in this suite aren't TAP
> compliant.
On CIs (make runtests or make kselftest) is used to run the tests. I'm not
aware of the ancient history. AFAIU following is the format of messages
(make kselftests). The TAP header mention that a new test has started. One
test may have multiple sub-tests. For example:

TAP version 13
1..4
# selftests: vDSO: test1
# TAP version 13
1..5
ok 1
ok 2
ok 3
ok 4
ok 5
# # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: vDSO: test1
# selftests: vDSO: test2
# TAP version 13
1..5
ok 1
ok 2
not ok 3
# # Totals: pass:2 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: vDSO: test2 # exit=1
# selftests: vDSO: test3
ok 1
ok 2
ok 3
not ok 3 selftests: vDSO: test3
# selftests: vDSO: test4
ok 1
not ok 3 selftests: vDSO: test4


The test1 and test2 are TAP compliant and print header and footer of the
tests mentioning total number of tests. The test3 and test4 don't print TAP
header and footer. The boundary between test3 and test4 isn't that clear,
but seems fine. Overall I would say TAP compliant tests have better boundry
when they print header/footer and total number of tests.

Do you agree with above layout's current state because we have both TAP
compliant and non-compliant tests.

-- 
BR,
Muhammad Usama Anjum


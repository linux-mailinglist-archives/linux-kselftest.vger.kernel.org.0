Return-Path: <linux-kselftest+bounces-13972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AB938577
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 18:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B746F1F21106
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53287167271;
	Sun, 21 Jul 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VFFHL6Mt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C4944E;
	Sun, 21 Jul 2024 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721579065; cv=none; b=jPWWrBFdYn8t2915+/0Te0s9MSjMYLtHydgUUy4Mki+ddB4DVRlthogEsn5+F6UiXbOhwDGVE5509GuOBcCYC1PQenr4KspnsS5/d459FJT21e4Q9O0P4Gp89n+CFD+OOgmJn1qYR72yeooSBK5AJDsA8OuUOGaqOLHtrS11q6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721579065; c=relaxed/simple;
	bh=6NGWFtrZr4yeMMMsc6nVXHaS2I4EsUB1yGVa66xtEw8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Cc:Subject:To:
	 References:From:In-Reply-To; b=dMLEWwFhoRavMtQDP6zGkdX3uvyyxZZsbJe40EPcXvMxJTnQaPYcV29sQoGizZBE9gSAwvmdHdG117fE8r4uMi5xE2gO+/Jg9O6+cNd3KtXk13F8/OSR8jemNES8RGq/6HE/B9H0YSfM61yuCphvx5yvaBbV8i/riHU7kQuzQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VFFHL6Mt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721579056;
	bh=6NGWFtrZr4yeMMMsc6nVXHaS2I4EsUB1yGVa66xtEw8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VFFHL6MtSc79lRLfGDeTS0c1Al0fXrsw4nVGsQ+AW10l40ta0o15rZMsSHfnUTtpv
	 Pae/QojDQdgPKYnlTxIFIkgUEQi38RlRlAFa3MDj1BwJNhn5Hryf1U2hYZWzJjYw7W
	 +V3odPnsmSDT4Mw3Pxa391dIErlQR/sMFcI4YMjiltQXb2SM34cFighB7cSQcUkHku
	 9o5SjH75e0CR4t8r6Vsy57Y9DTKawNHDYIbzZqY2AQiZY48LmcP8EacTmginWmmkHU
	 hJ7cvAmOlBP8YUZ20KdewK+8jD23eSP0Gn2nW4lfJ6gADRx7VPXA0GOHN9zd4EvUrX
	 n2cr26BaCIXsg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 544403780627;
	Sun, 21 Jul 2024 16:24:13 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------trJriLgu6faV8PELeO8dX3Bi"
Message-ID: <77a66e39-7f34-4b3c-ac8d-e48d8c5a2830@collabora.com>
Date: Sun, 21 Jul 2024 21:24:05 +0500
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
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <9cf7f693-bc6a-415b-99c3-f6c59b871c4f@linuxfoundation.org>

This is a multi-part message in MIME format.
--------------trJriLgu6faV8PELeO8dX3Bi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/19/24 9:40 PM, Shuah Khan wrote:
> On 7/12/24 01:30, Muhammad Usama Anjum wrote:
>> Use kselftest wrapper to mark tests pass/fail instead of manually
>> counting.
> 
> You care combining two changes in the patch.
> 
> This is needed to return correct exit status. This also
>> improves readability and mainability.
> 
> Spelling - "mainability" - checkpatch would have helped you
> catch this.
Sorry I'll fix it after following discussion. I use checkpatch with
spelling checker. I may have missed it for this patch.

> 
> The change to return the correct error fine and but not the
> change thaT ADDS DUPLICATE tap header.
> 
>>
> 
> 
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/x86/vdso_restorer.c | 20 +++++++-------------
>>   1 file changed, 7 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/testing/selftests/x86/vdso_restorer.c
>> b/tools/testing/selftests/x86/vdso_restorer.c
>> index fe99f24341554..8e173d71291f6 100644
>> --- a/tools/testing/selftests/x86/vdso_restorer.c
>> +++ b/tools/testing/selftests/x86/vdso_restorer.c
>> @@ -21,6 +21,7 @@
>>   #include <unistd.h>
>>   #include <syscall.h>
>>   #include <sys/syscall.h>
>> +#include "../kselftest.h"
>>     /* Open-code this -- the headers are too messy to easily use them. */
>>   struct real_sigaction {
>> @@ -44,9 +45,10 @@ static void handler_without_siginfo(int sig)
>>     int main()
>>   {
>> -    int nerrs = 0;
>>       struct real_sigaction sa;
>>   +    ksft_print_header();
> 
> The problem with adding this header here is when
> make kselftest TARGETS=vDSO is run there will be
> duplicate TAP 13 headers.
Usually all TAP compliant tests print TAP 13 header at the start. These
tests when run from make run_tests have duplicate TAP 13 headers. I don't
think that this is the issue. Why do you think it is wrong?

For example, I've attached the logs of vDSO test suite. TAP header is
printed at the start. Then it is printed again at the start of the test if
it is TAP compliant e.g., vdso_test_abi and vdso_test_getrandom. These
tests are already TAP compliant. Other tests in this suite aren't TAP
compliant.

-- 
BR,
Muhammad Usama Anjum
--------------trJriLgu6faV8PELeO8dX3Bi
Content-Type: text/x-log; charset=UTF-8; name="selftests-vDSO.log"
Content-Disposition: attachment; filename="selftests-vDSO.log"
Content-Transfer-Encoding: base64

bWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvaG9tZS91c2FtYS9yZXBvcy9rZXJuZWwv
bGludXhfbWFpbmxpbmUvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTycKbWFrZVsxXTog
Tm90aGluZyB0byBiZSBkb25lIGZvciAnYWxsJy4KbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rv
cnkgJy9ob21lL3VzYW1hL3JlcG9zL2tlcm5lbC9saW51eF9tYWlubGluZS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy92RFNPJwptYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9ob21l
L3VzYW1hL3JlcG9zL2tlcm5lbC9saW51eF9tYWlubGluZS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy92RFNPJwpUQVAgdmVyc2lvbiAxMwoxLi43CiMgdGltZW91dCBzZXQgdG8gNDUKIyBz
ZWxmdGVzdHM6IHZEU086IHZkc29fdGVzdF9nZXR0aW1lb2ZkYXkKIyBUaGUgdGltZSBpcyAx
NzIxNTc4ODQ2Ljk0Njc2MgpvayAxIHNlbGZ0ZXN0czogdkRTTzogdmRzb190ZXN0X2dldHRp
bWVvZmRheQojIHRpbWVvdXQgc2V0IHRvIDQ1CiMgc2VsZnRlc3RzOiB2RFNPOiB2ZHNvX3Rl
c3RfZ2V0Y3B1CiMgUnVubmluZyBvbiBDUFUgNCBub2RlIDAKb2sgMiBzZWxmdGVzdHM6IHZE
U086IHZkc29fdGVzdF9nZXRjcHUKIyB0aW1lb3V0IHNldCB0byA0NQojIHNlbGZ0ZXN0czog
dkRTTzogdmRzb190ZXN0X2FiaQojIFRBUCB2ZXJzaW9uIDEzCiMgMS4uMTYKIyAjIFt2RFNP
IGtzZWxmdGVzdF0gVkRTT19WRVJTSU9OOiBMSU5VWF8yLjYKIyAjIFRoZSB0aW1lIGlzIDE3
MjE1Nzg4NDYuOTc1NzIxCiMgb2sgMSBfX3Zkc29fZ2V0dGltZW9mZGF5CiMgIyBjbG9ja19p
ZDogQ0xPQ0tfUkVBTFRJTUUKIyAjIFRoZSB0aW1lIGlzIDE3MjE1Nzg4NDYuOTc1NzI2MjU5
CiMgb2sgMiBfX3Zkc29fY2xvY2tfZ2V0dGltZSBDTE9DS19SRUFMVElNRQojICMgVGhlIHZk
c28gcmVzb2x1dGlvbiBpcyAwIDEKIyAjIFRoZSBzeXNjYWxsIHJlc29sdXRpb24gaXMgMCAx
CiMgb2sgMyBfX3Zkc29fY2xvY2tfZ2V0cmVzIENMT0NLX1JFQUxUSU1FCiMgIyBjbG9ja19p
ZDogQ0xPQ0tfQk9PVFRJTUUKIyAjIFRoZSB0aW1lIGlzIDEwNzcwMDguMTA1MjE0NDI0CiMg
b2sgNCBfX3Zkc29fY2xvY2tfZ2V0dGltZSBDTE9DS19CT09UVElNRQojICMgVGhlIHZkc28g
cmVzb2x1dGlvbiBpcyAwIDEKIyAjIFRoZSBzeXNjYWxsIHJlc29sdXRpb24gaXMgMCAxCiMg
b2sgNSBfX3Zkc29fY2xvY2tfZ2V0cmVzIENMT0NLX0JPT1RUSU1FCiMgIyBjbG9ja19pZDog
Q0xPQ0tfVEFJCiMgIyBUaGUgdGltZSBpcyAxNzIxNTc4ODgzLjk3NTczNzk5MgojIG9rIDYg
X192ZHNvX2Nsb2NrX2dldHRpbWUgQ0xPQ0tfVEFJCiMgIyBUaGUgdmRzbyByZXNvbHV0aW9u
IGlzIDAgMQojICMgVGhlIHN5c2NhbGwgcmVzb2x1dGlvbiBpcyAwIDEKIyBvayA3IF9fdmRz
b19jbG9ja19nZXRyZXMgQ0xPQ0tfVEFJCiMgIyBjbG9ja19pZDogQ0xPQ0tfUkVBTFRJTUVf
Q09BUlNFCiMgIyBUaGUgdGltZSBpcyAxNzIxNTc4ODQ2Ljk3MjI3NTczNQojIG9rIDggX192
ZHNvX2Nsb2NrX2dldHRpbWUgQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFCiMgIyBUaGUgdmRzbyBy
ZXNvbHV0aW9uIGlzIDAgNDAwMDAwMAojICMgVGhlIHN5c2NhbGwgcmVzb2x1dGlvbiBpcyAw
IDQwMDAwMDAKIyBvayA5IF9fdmRzb19jbG9ja19nZXRyZXMgQ0xPQ0tfUkVBTFRJTUVfQ09B
UlNFCiMgIyBjbG9ja19pZDogQ0xPQ0tfTU9OT1RPTklDCiMgIyBUaGUgdGltZSBpcyAzODA5
NzcuMjI4MTUxNjQ3CiMgb2sgMTAgX192ZHNvX2Nsb2NrX2dldHRpbWUgQ0xPQ0tfTU9OT1RP
TklDCiMgIyBUaGUgdmRzbyByZXNvbHV0aW9uIGlzIDAgMQojICMgVGhlIHN5c2NhbGwgcmVz
b2x1dGlvbiBpcyAwIDEKIyBvayAxMSBfX3Zkc29fY2xvY2tfZ2V0cmVzIENMT0NLX01PTk9U
T05JQwojICMgY2xvY2tfaWQ6IENMT0NLX01PTk9UT05JQ19SQVcKIyAjIFRoZSB0aW1lIGlz
IDM4MDk3NC43MTQyMDU1ODAKIyBvayAxMiBfX3Zkc29fY2xvY2tfZ2V0dGltZSBDTE9DS19N
T05PVE9OSUNfUkFXCiMgIyBUaGUgdmRzbyByZXNvbHV0aW9uIGlzIDAgMQojICMgVGhlIHN5
c2NhbGwgcmVzb2x1dGlvbiBpcyAwIDEKIyBvayAxMyBfX3Zkc29fY2xvY2tfZ2V0cmVzIENM
T0NLX01PTk9UT05JQ19SQVcKIyAjIGNsb2NrX2lkOiBDTE9DS19NT05PVE9OSUNfQ09BUlNF
CiMgIyBUaGUgdGltZSBpcyAzODA5NzcuMjI0NjgwNDUwCiMgb2sgMTQgX192ZHNvX2Nsb2Nr
X2dldHRpbWUgQ0xPQ0tfTU9OT1RPTklDX0NPQVJTRQojICMgVGhlIHZkc28gcmVzb2x1dGlv
biBpcyAwIDQwMDAwMDAKIyAjIFRoZSBzeXNjYWxsIHJlc29sdXRpb24gaXMgMCA0MDAwMDAw
CiMgb2sgMTUgX192ZHNvX2Nsb2NrX2dldHJlcyBDTE9DS19NT05PVE9OSUNfQ09BUlNFCiMg
IyBUaGUgdGltZSBpbiBob3VycyBzaW5jZSBKYW51YXJ5IDEsIDE5NzAgaXMgNDc4MjE2CiMg
b2sgMTYgX192ZHNvX3RpbWUKIyAjIFRvdGFsczogcGFzczoxNiBmYWlsOjAgeGZhaWw6MCB4
cGFzczowIHNraXA6MCBlcnJvcjowCm9rIDMgc2VsZnRlc3RzOiB2RFNPOiB2ZHNvX3Rlc3Rf
YWJpCiMgdGltZW91dCBzZXQgdG8gNDUKIyBzZWxmdGVzdHM6IHZEU086IHZkc29fdGVzdF9j
bG9ja19nZXRyZXMKIyBjbG9ja19pZDogQ0xPQ0tfUkVBTFRJTUUgW1BBU1NdCiMgY2xvY2tf
aWQ6IENMT0NLX0JPT1RUSU1FIFtQQVNTXQojIGNsb2NrX2lkOiBDTE9DS19UQUkgW1BBU1Nd
CiMgY2xvY2tfaWQ6IENMT0NLX1JFQUxUSU1FX0NPQVJTRSBbUEFTU10KIyBjbG9ja19pZDog
Q0xPQ0tfTU9OT1RPTklDIFtQQVNTXQojIGNsb2NrX2lkOiBDTE9DS19NT05PVE9OSUNfUkFX
IFtQQVNTXQojIGNsb2NrX2lkOiBDTE9DS19NT05PVE9OSUNfQ09BUlNFIFtQQVNTXQpvayA0
IHNlbGZ0ZXN0czogdkRTTzogdmRzb190ZXN0X2Nsb2NrX2dldHJlcwojIHRpbWVvdXQgc2V0
IHRvIDQ1CiMgc2VsZnRlc3RzOiB2RFNPOiB2ZHNvX3N0YW5kYWxvbmVfdGVzdF94ODYKIyBU
aGUgdGltZSBpcyAgICAgICAgICAgMTcyMTU3ODg0Ny4wMDA4NzUKb2sgNSBzZWxmdGVzdHM6
IHZEU086IHZkc29fc3RhbmRhbG9uZV90ZXN0X3g4NgojIHRpbWVvdXQgc2V0IHRvIDQ1CiMg
c2VsZnRlc3RzOiB2RFNPOiB2ZHNvX3Rlc3RfY29ycmVjdG5lc3MKIyBXYXJuaW5nOiBmYWls
ZWQgdG8gZmluZCB2c3lzY2FsbCBnZXRjcHUKIyBbUlVOXQlUZXN0aW5nIGNsb2NrX2dldHRp
bWUgZm9yIGNsb2NrIENMT0NLX1JFQUxUSU1FICgwKS4uLgojIAkxNzIxNTc4ODQ3LjAxMjg4
ODgzMiAxNzIxNTc4ODQ3LjAxMjg5NTg4NiAxNzIxNTc4ODQ3LjAxMjg5NzI4MwojIFtPS10J
VGVzdCBQYXNzZWQuCiMgW1JVTl0JVGVzdGluZyBjbG9ja19nZXR0aW1lIGZvciBjbG9jayBD
TE9DS19NT05PVE9OSUMgKDEpLi4uCiMgCTM4MDk3Ny4yNjUzMDczNzYgMzgwOTc3LjI2NTMw
ODI4NCAzODA5NzcuMjY1MzA5NzUxCiMgW09LXQlUZXN0IFBhc3NlZC4KIyBbUlVOXQlUZXN0
aW5nIGNsb2NrX2dldHRpbWUgZm9yIGNsb2NrIENMT0NLX1BST0NFU1NfQ1BVVElNRV9JRCAo
MikuLi4KIyAJMC4wMDExODgyNDAgMC4wMDExODkxMDIgMC4wMDExODk2MjMKIyBbT0tdCVRl
c3QgUGFzc2VkLgojIFtSVU5dCVRlc3RpbmcgY2xvY2tfZ2V0dGltZSBmb3IgY2xvY2sgQ0xP
Q0tfVEhSRUFEX0NQVVRJTUVfSUQgKDMpLi4uCiMgCTAuMDAxMTkyNjY4IDAuMDAxMTkzMTY5
IDAuMDAxMTkzNjEwCiMgW09LXQlUZXN0IFBhc3NlZC4KIyBbUlVOXQlUZXN0aW5nIGNsb2Nr
X2dldHRpbWUgZm9yIGNsb2NrIENMT0NLX01PTk9UT05JQ19SQVcgKDQpLi4uCiMgCTM4MDk3
NC43NTEzNzExOTcgMzgwOTc0Ljc1MTM3MjU5NCAzODA5NzQuNzUxMzczNTcyCiMgW09LXQlU
ZXN0IFBhc3NlZC4KIyBbUlVOXQlUZXN0aW5nIGNsb2NrX2dldHRpbWUgZm9yIGNsb2NrIENM
T0NLX1JFQUxUSU1FX0NPQVJTRSAoNSkuLi4KIyAJMTcyMTU3ODg0Ny4wMDgyNzYwNzQgMTcy
MTU3ODg0Ny4wMDgyNzYwNzQgMTcyMTU3ODg0Ny4wMDgyNzYwNzQKIyBbT0tdCVRlc3QgUGFz
c2VkLgojIFtSVU5dCVRlc3RpbmcgY2xvY2tfZ2V0dGltZSBmb3IgY2xvY2sgQ0xPQ0tfTU9O
T1RPTklDX0NPQVJTRSAoNikuLi4KIyAJMzgwOTc3LjI2MDY4MDc4OSAzODA5NzcuMjYwNjgw
Nzg5IDM4MDk3Ny4yNjA2ODA3ODkKIyBbT0tdCVRlc3QgUGFzc2VkLgojIFtSVU5dCVRlc3Rp
bmcgY2xvY2tfZ2V0dGltZSBmb3IgY2xvY2sgQ0xPQ0tfQk9PVFRJTUUgKDcpLi4uCiMgCTEw
NzcwMDguMTQyNDExNzA5IDEwNzcwMDguMTQyNDEzMTA2IDEwNzcwMDguMTQyNDE0MDgzCiMg
W09LXQlUZXN0IFBhc3NlZC4KIyBbUlVOXQlUZXN0aW5nIGNsb2NrX2dldHRpbWUgZm9yIGNs
b2NrIENMT0NLX1JFQUxUSU1FX0FMQVJNICg4KS4uLgojIAkxNzIxNTc4ODQ3LjAxMjkzNTgz
NiAxNzIxNTc4ODQ3LjAxMjkzNzMwMyAxNzIxNTc4ODQ3LjAxMjkzODY5OQojIFtPS10JVGVz
dCBQYXNzZWQuCiMgW1JVTl0JVGVzdGluZyBjbG9ja19nZXR0aW1lIGZvciBjbG9jayBDTE9D
S19CT09UVElNRV9BTEFSTSAoOSkuLi4KIyAJMTA3NzAwOC4xNDI0MjQxNDEgMTA3NzAwOC4x
NDI0MjU1MzcgMTA3NzAwOC4xNDI0MjcwMDQKIyBbT0tdCVRlc3QgUGFzc2VkLgojIFtSVU5d
CVRlc3RpbmcgY2xvY2tfZ2V0dGltZSBmb3IgY2xvY2sgQ0xPQ0tfU0dJX0NZQ0xFICgxMCku
Li4KIyBbT0tdCU5vIHN1Y2ggY2xvY2suCiMgW1JVTl0JVGVzdGluZyBjbG9ja19nZXR0aW1l
IGZvciBjbG9jayBDTE9DS19UQUkgKDExKS4uLgojIAkxNzIxNTc4ODg0LjAxMjk1MDY0MiAx
NzIxNTc4ODg0LjAxMjk1MTYyMCAxNzIxNTc4ODg0LjAxMjk1MzAxNwojIFtPS10JVGVzdCBQ
YXNzZWQuCiMgW1JVTl0JVGVzdGluZyBjbG9ja19nZXR0aW1lIGZvciBjbG9jayBpbnZhbGlk
ICgtMSkuLi4KIyBbT0tdCU5vIHN1Y2ggY2xvY2suCiMgW1JVTl0JVGVzdGluZyBjbG9ja19n
ZXR0aW1lIGZvciBjbG9jayBpbnZhbGlkICgtMjE0NzQ4MzY0OCkuLi4KIyBbT0tdCU5vIHN1
Y2ggY2xvY2suCiMgW1JVTl0JVGVzdGluZyBjbG9ja19nZXR0aW1lIGZvciBjbG9jayBpbnZh
bGlkICgyMTQ3NDgzNjQ3KS4uLgojIFtPS10JTm8gc3VjaCBjbG9jay4KIyBbU0tJUF0JTm8g
dkRTTywgc28gc2tpcHBpbmcgY2xvY2tfZ2V0dGltZTY0KCkgdGVzdHMKIyBbUlVOXQlUZXN0
aW5nIGdldHRpbWVvZmRheS4uLgojIAkxNzIxNTc4ODQ3LjAxMjk2MiAxNzIxNTc4ODQ3LjAx
Mjk2NCAxNzIxNTc4ODQ3LjAxMjk2NQojIFtPS10JdGltZXpvbmVzIG1hdGNoOiBtaW51dGVz
d2VzdD0wLCBkc3R0aW1lPTAKIyBbUlVOXQlUZXN0aW5nIGdldGNwdS4uLgojIFtPS10JQ1BV
IDA6IHN5c2NhbGw6IGNwdSAwLCBub2RlIDAgdmRzbzogY3B1IDAsIG5vZGUgMAojIFtPS10J
Q1BVIDE6IHN5c2NhbGw6IGNwdSAxLCBub2RlIDAgdmRzbzogY3B1IDEsIG5vZGUgMAojIFtP
S10JQ1BVIDI6IHN5c2NhbGw6IGNwdSAyLCBub2RlIDAgdmRzbzogY3B1IDIsIG5vZGUgMAoj
IFtPS10JQ1BVIDM6IHN5c2NhbGw6IGNwdSAzLCBub2RlIDAgdmRzbzogY3B1IDMsIG5vZGUg
MAojIFtPS10JQ1BVIDQ6IHN5c2NhbGw6IGNwdSA0LCBub2RlIDAgdmRzbzogY3B1IDQsIG5v
ZGUgMAojIFtPS10JQ1BVIDU6IHN5c2NhbGw6IGNwdSA1LCBub2RlIDAgdmRzbzogY3B1IDUs
IG5vZGUgMAojIFtPS10JQ1BVIDY6IHN5c2NhbGw6IGNwdSA2LCBub2RlIDAgdmRzbzogY3B1
IDYsIG5vZGUgMAojIFtPS10JQ1BVIDc6IHN5c2NhbGw6IGNwdSA3LCBub2RlIDAgdmRzbzog
Y3B1IDcsIG5vZGUgMAojIFtPS10JQ1BVIDg6IHN5c2NhbGw6IGNwdSA4LCBub2RlIDAgdmRz
bzogY3B1IDgsIG5vZGUgMAojIFtPS10JQ1BVIDk6IHN5c2NhbGw6IGNwdSA5LCBub2RlIDAg
dmRzbzogY3B1IDksIG5vZGUgMAojIFtPS10JQ1BVIDEwOiBzeXNjYWxsOiBjcHUgMTAsIG5v
ZGUgMCB2ZHNvOiBjcHUgMTAsIG5vZGUgMAojIFtPS10JQ1BVIDExOiBzeXNjYWxsOiBjcHUg
MTEsIG5vZGUgMCB2ZHNvOiBjcHUgMTEsIG5vZGUgMAojIFtPS10JQ1BVIDEyOiBzeXNjYWxs
OiBjcHUgMTIsIG5vZGUgMCB2ZHNvOiBjcHUgMTIsIG5vZGUgMAojIFtPS10JQ1BVIDEzOiBz
eXNjYWxsOiBjcHUgMTMsIG5vZGUgMCB2ZHNvOiBjcHUgMTMsIG5vZGUgMAojIFtPS10JQ1BV
IDE0OiBzeXNjYWxsOiBjcHUgMTQsIG5vZGUgMCB2ZHNvOiBjcHUgMTQsIG5vZGUgMAojIFtP
S10JQ1BVIDE1OiBzeXNjYWxsOiBjcHUgMTUsIG5vZGUgMCB2ZHNvOiBjcHUgMTUsIG5vZGUg
MApvayA2IHNlbGZ0ZXN0czogdkRTTzogdmRzb190ZXN0X2NvcnJlY3RuZXNzCiMgdGltZW91
dCBzZXQgdG8gNDUKIyBzZWxmdGVzdHM6IHZEU086IHZkc29fdGVzdF9nZXRyYW5kb20KIyBU
QVAgdmVyc2lvbiAxMwojIDEuLjEKIyBfX3Zkc29fZ2V0cmFuZG9tIGlzIG1pc3NpbmchCm5v
dCBvayA3IHNlbGZ0ZXN0czogdkRTTzogdmRzb190ZXN0X2dldHJhbmRvbSAjIGV4aXQ9MQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL2hvbWUvdXNhbWEvcmVwb3Mva2VybmVsL2xp
bnV4X21haW5saW5lL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08nCg==

--------------trJriLgu6faV8PELeO8dX3Bi--


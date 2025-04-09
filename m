Return-Path: <linux-kselftest+bounces-30450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882FEA833FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 00:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1C1189F48D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A15213E81;
	Wed,  9 Apr 2025 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WegrPDXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E219004A
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Apr 2025 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236825; cv=none; b=PTbWnjbLW4K5SQQBrpTPgFAJITH28RkQbGhsLZFWG+rQjDfeYKdOCJEbg5YlHeG9seCjLEODA2Hk5YnzPFfMeQiK63fyIcJnWq+X+gkQ03c8oT5xlDVQzMBAlwz6+2nLRxTK1yp+h/Pj6F0UEP2W5nZYPfFqFYVF2YGamIUSJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236825; c=relaxed/simple;
	bh=xpzRcp4Ka1Tyt+GacK8iEdisWsXft9gHQ0UJH/Jbems=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=sL8w1j1Qw+2c6nu0jG59V+D76Y1TLqJlZMGfbkZfrTYDujBeMwUl9oKKSCCN02omdxQ4UGI3Je0MDD9mkmxVGrszLcfMfgWamIh/EEhipqorUB6dgTY9Nzy55FPJ1lTTzHMqR0QmuecA9yuTZ8/6nPSHNV7/xWiRR3yspKX8E2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WegrPDXk; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86135aeca58so7547139f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Apr 2025 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744236821; x=1744841621; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sOZyIYNshi/uC4rKrNhaWGHmAAtbzVOCXThHt3xXgGA=;
        b=WegrPDXkuctiQR+gbbfpKu2VHihB9jBokCMm1FLKvXZwosCQYrWgd1VJqa+iCO4SGG
         nIo38WTUNFHFehE8pRm7H0ZFXcpXWZmpjIPkh2jKOHFGyu/R8pG1s2SjCizaxXfkuVfZ
         bslqcjZdTXU7HFsBLsoK0fXDDwHwCY/vIx0tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744236821; x=1744841621;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOZyIYNshi/uC4rKrNhaWGHmAAtbzVOCXThHt3xXgGA=;
        b=o+FZFRGyuXNouRGPBZDJ+VwvzF4Uhhn6L65Chs5puqPt3H7imySGq8zSOtfxEVm6Ue
         /LSASdB5AdOn11Kv025jhF7lYssQpu+T8nesagonLCbFy5MziRY/KMeRqkUieaLik3+2
         ZIOxsz982miQer79IPgwGoegjxVE5Y/c9C3TR/KRPX8U8m9/o8JnGveXPt3sfl4ezgrq
         sUqi6xqjrHYEjGtwofRq/Ul7+8f9n+egP1+Vssg92r9sHpuyOd32FpdEHb9JHgQPi8YI
         kazUAIytPxcBiw56ppoFGw/Lzz+xxMZal3dT6jI0cJNjzC24dWS2H3y7AcfhPxHcVgfY
         UTdw==
X-Forwarded-Encrypted: i=1; AJvYcCU4goCeyxKHWik1mOvTXCt29Mejco1g3rEFF8/krv85AuKZp5XqjvVRQa4tt7BRu1Oxbxx8ylpJbnfgp+ay73w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe9pztPc0BazVb0t3Me03OKUmpDWKaSLbwVYxAwEu6R4UZ57DV
	2qSAaS55GCsHy4Fr5e2/TP+a4OuQNItB3H10rIlUltao5KiChE2IOkRoQ9eEtwYpf8RZSWiyHVK
	/
X-Gm-Gg: ASbGncuQBAKQ/RtYZINmvzEBmhWZLOqb8yh42m/USjybHIIpJBAGMaKHM3rZIM1DIQy
	ST434JwgY+Lxs83hj/F4SJe+VhynKufF4XuffBb4IXdAxAf5bGZOih7GRgpBwKmxPLw1l/TeD0U
	VnXUaKXKyIUs2SH9cL5yVtM3K51/Fkcg2utM1ohihiHDaIew1A/5UJ6fLHj+LRgK0txbjeJ/zu1
	VyMebYJSdDVdFG7BAGx4TdEctEF0kl9WdClxJFNU8FOIsnwlPz7bxTC7L+/DGHmTUX7EJO+TzdB
	7v0Eb/RZVt8Mkrlmy2kdY/NtBX7VpQz1ux8ipkd3DDIluOOTLsDsuACCbde/jA==
X-Google-Smtp-Source: AGHT+IEcFbkLjNVeVV2IRBR2ch4Mk83Cf5DzulAWeocqV95gWGdGEQbBdBT5rhoA3QaCfCGk89IjeQ==
X-Received: by 2002:a05:6602:474a:b0:861:6f2a:ae64 with SMTP id ca18e2360f4ac-86170565aaemr3792839f.0.1744236820746;
        Wed, 09 Apr 2025 15:13:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86165426285sm37114939f.12.2025.04.09.15.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 15:13:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------IHEiv8zrIWtWFzS0PBG03iHT"
Message-ID: <aa092d10-f3d5-4714-98be-bd6fabd4225d@linuxfoundation.org>
Date: Wed, 9 Apr 2025 16:13:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.15-rc2

This is a multi-part message in MIME format.
--------------IHEiv8zrIWtWFzS0PBG03iHT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.15-rc2

Fixes tpm2, futex, and mincore tests. Creates a dedicated .gitignore
for tpm2

Details:

selftests: tpm2: test_smoke: use POSIX-conformant expression operator
selftests/futex: futex_waitv wouldblock test should fail
selftests: tpm2: create a dedicated .gitignore
selftests/mincore: Allow read-ahead pages to reach the end of the file

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.15-rc2

for you to fetch changes up to 197c1eaa7ba633a482ed7588eea6fd4aa57e08d4:

   selftests/mincore: Allow read-ahead pages to reach the end of the file (2025-04-08 17:08:50 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.15-rc2

Fixes tpm2, futex, and mincore tests. Creates a dedicated .gitignore
for tpm2

Details:

selftests: tpm2: test_smoke: use POSIX-conformant expression operator
selftests/futex: futex_waitv wouldblock test should fail
selftests: tpm2: create a dedicated .gitignore
selftests/mincore: Allow read-ahead pages to reach the end of the file

----------------------------------------------------------------
Ahmed Salem (1):
       selftests: tpm2: test_smoke: use POSIX-conformant expression operator

Edward Liaw (1):
       selftests/futex: futex_waitv wouldblock test should fail

Khaled Elnaggar (1):
       selftests: tpm2: create a dedicated .gitignore

Qiuxu Zhuo (1):
       selftests/mincore: Allow read-ahead pages to reach the end of the file

  tools/testing/selftests/.gitignore                               | 1 -
  tools/testing/selftests/futex/functional/futex_wait_wouldblock.c | 2 +-
  tools/testing/selftests/mincore/mincore_selftest.c               | 3 ---
  tools/testing/selftests/tpm2/.gitignore                          | 3 +++
  tools/testing/selftests/tpm2/test_smoke.sh                       | 2 +-
  5 files changed, 5 insertions(+), 6 deletions(-)
  create mode 100644 tools/testing/selftests/tpm2/.gitignore
----------------------------------------------------------------
--------------IHEiv8zrIWtWFzS0PBG03iHT
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.15-rc2.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.15-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzLy5naXRpZ25vcmUgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy8uZ2l0aWdub3JlCmluZGV4IGNiMjQxMjRhYzViOS4uNjc0
YWFhMDJlMzk2IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy8uZ2l0aWdu
b3JlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzLy5naXRpZ25vcmUKQEAgLTQsNyAr
NCw2IEBAIGdwaW9ncGlvLWhhbW1lcgogZ3Bpb2luY2x1ZGUvCiBncGlvbHNncGlvCiBrc2Vs
ZnRlc3RfaW5zdGFsbC8KLXRwbTIvU3BhY2VUZXN0LmxvZwogCiAjIFB5dGhvbiBieXRlY29k
ZSBhbmQgY2FjaGUKIF9fcHljYWNoZV9fLwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZnV0ZXgvZnVuY3Rpb25hbC9mdXRleF93YWl0X3dvdWxkYmxvY2suYyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvZnV0ZXhfd2FpdF93b3Vs
ZGJsb2NrLmMKaW5kZXggN2Q3YTZhMDZjZGI3Li4yZDgyMzBkYTkwNjQgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvZnV0ZXhfd2FpdF93
b3VsZGJsb2NrLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rp
b25hbC9mdXRleF93YWl0X3dvdWxkYmxvY2suYwpAQCAtOTgsNyArOTgsNyBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCWluZm8oIkNhbGxpbmcgZnV0ZXhfd2FpdHYg
b24gZjE6ICV1IEAgJXAgd2l0aCB2YWw9JXVcbiIsIGYxLCAmZjEsIGYxKzEpOwogCXJlcyA9
IGZ1dGV4X3dhaXR2KCZ3YWl0diwgMSwgMCwgJnRvLCBDTE9DS19NT05PVE9OSUMpOwogCWlm
ICghcmVzIHx8IGVycm5vICE9IEVXT1VMREJMT0NLKSB7Ci0JCWtzZnRfdGVzdF9yZXN1bHRf
cGFzcygiZnV0ZXhfd2FpdHYgcmV0dXJuZWQ6ICVkICVzXG4iLAorCQlrc2Z0X3Rlc3RfcmVz
dWx0X2ZhaWwoImZ1dGV4X3dhaXR2IHJldHVybmVkOiAlZCAlc1xuIiwKIAkJCQkgICAgICBy
ZXMgPyBlcnJubyA6IHJlcywKIAkJCQkgICAgICByZXMgPyBzdHJlcnJvcihlcnJubykgOiAi
Iik7CiAJCXJldCA9IFJFVF9GQUlMOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbWluY29yZS9taW5jb3JlX3NlbGZ0ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9taW5jb3JlL21pbmNvcmVfc2VsZnRlc3QuYwppbmRleCBlOTQ5YTQzYTYxNDUuLmVm
YWJmY2JlMGI0OSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWluY29y
ZS9taW5jb3JlX3NlbGZ0ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbWlu
Y29yZS9taW5jb3JlX3NlbGZ0ZXN0LmMKQEAgLTI2MSw5ICsyNjEsNiBAQCBURVNUKGNoZWNr
X2ZpbGVfbW1hcCkKIAkJVEhfTE9HKCJObyByZWFkLWFoZWFkIHBhZ2VzIGZvdW5kIGluIG1l
bW9yeSIpOwogCX0KIAotCUVYUEVDVF9MVChpLCB2ZWNfc2l6ZSkgewotCQlUSF9MT0coIlJl
YWQtYWhlYWQgcGFnZXMgcmVhY2hlZCB0aGUgZW5kIG9mIHRoZSBmaWxlIik7Ci0JfQogCS8q
CiAJICogRW5kIG9mIHRoZSByZWFkYWhlYWQgd2luZG93LiBUaGUgcmVzdCBvZiB0aGUgcGFn
ZXMgc2hvdWxkbid0CiAJICogYmUgaW4gbWVtb3J5LgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdHBtMi8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdHBtMi8uZ2l0aWdub3JlCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAw
MDAwMC4uNmQ2MTY1YzVlMzVkCi0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvdHBtMi8uZ2l0aWdub3JlCkBAIC0wLDAgKzEsMyBAQAorIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CitBc3luY1Rlc3QubG9nCitTcGFjZVRlc3Qu
bG9nCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90cG0yL3Rlc3Rfc21v
a2Uuc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90cG0yL3Rlc3Rfc21va2Uuc2gKaW5k
ZXggMTY4ZjRiMTY2MjM0Li4zYTYwZTZjNmY1YzkgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3RwbTIvdGVzdF9zbW9rZS5zaAorKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy90cG0yL3Rlc3Rfc21va2Uuc2gKQEAgLTYsNiArNiw2IEBAIGtzZnRfc2tpcD00
CiAKIFsgLWUgL2Rldi90cG0wIF0gfHwgZXhpdCAka3NmdF9za2lwCiByZWFkIHRwbV92ZXJz
aW9uIDwgL3N5cy9jbGFzcy90cG0vdHBtMC90cG1fdmVyc2lvbl9tYWpvcgotWyAiJHRwbV92
ZXJzaW9uIiA9PSAyIF0gfHwgZXhpdCAka3NmdF9za2lwCitbICIkdHBtX3ZlcnNpb24iID0g
MiBdIHx8IGV4aXQgJGtzZnRfc2tpcAogCiBweXRob24zIC1tIHVuaXR0ZXN0IC12IHRwbTJf
dGVzdHMuU21va2VUZXN0IDI+JjEK

--------------IHEiv8zrIWtWFzS0PBG03iHT--


Return-Path: <linux-kselftest+bounces-46920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D650C9D28F
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 23:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5755A4E3AD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672EC2FD680;
	Tue,  2 Dec 2025 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCM5t/GI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C92FC89C
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 22:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764713369; cv=none; b=DuxHWljoJ+UlDQdXi+3uQH4jIsTPzjpbC4QhJf2+kxUnIVPYDdmxpl9Rqv2BO0c1CwCfwULRpYkZOl2QzVF5q9qLjjaN9/gZ2aJuphEGUZpzKeWP49g3WaN3+a+HMEj+RVr0IDw8K+m+a8N7qMLLgwijs3WyFuiUSYAebu+2FCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764713369; c=relaxed/simple;
	bh=el1eOjuXuvwRkwThbprsjSZEnyJRetS10mImskT/ecY=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=recaZXWuUbwEdlUyCb8bnkD4GZtTImKYtbHBdZzRsr+UiEtqPTGXFiUAJudOKW93snOdsHSSpt8cO4Okht0P1sd2dwjNr9jWzhpfiF4C3rwvHmvD7t9yAdoJJlS+3g/6G6Iz3mzEwu+dz+PZ/9Dh3i29dJjCjGnx2Ah7/AR5EBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCM5t/GI; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-657464a9010so1292680eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 14:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764713366; x=1765318166; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7aGLpi+Vu8mr1rHAvYUDdpimI1Si0fc/PAJkCQ7J6AU=;
        b=MCM5t/GIJPbzx1BNpXvLHBQfKR065y9ONwFbL2ZxhuiHIrwVz8SKFMapPBalIqNUeN
         58LoDFkhtC3skx5O1R6JUG+cDvEVT5wEha/s+Krut+I+KBwzSnCpHqJSGCc2Ax9ISyyg
         6NGQHist1IrY+IHMhoDH9fW21+Vy10iUbElNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764713366; x=1765318166;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aGLpi+Vu8mr1rHAvYUDdpimI1Si0fc/PAJkCQ7J6AU=;
        b=tITgq8R6rUg23ElsbcyjD91Yx7DZt5W8zsHyIvHnlN3QII0W9bUdnPn54xTnGkjEBH
         VFtMtu63vC5vcXFGWnMlRQxQF3BPVCZ7qvoI9QIGp/jxA+Wzng+h+ANQYkMiz4gsq2T7
         OYxaQI6ShAOPIM4d7TGw/q6Qtha0OFarqv+kX270+XnNShJWCkTj/KMz6AxReMMvUexz
         zKgBYLAKIsByDRWkBREjUfLTzsgM3tH0BCQoAuysKh2CINiPQPpoeVpHv9jKFTUhI9Ux
         +ZfI0vpH18ifD/PBs0sFQgXRHZAy4T2C6HV9LTAcxOoZES5kmgDwnrhoYXDU5E4WnRcH
         vEOg==
X-Forwarded-Encrypted: i=1; AJvYcCXF87zBeS/YTe4Q6lXmsvoygkqIOQ7zjBHHNRa4jZh5u3WoAXOQGvhmhP7ITtzDOhrDWX2E6v0ZQrltU32yrZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNalLV6YglMkxFQCUPeI7k8LFOY3ruVS8RZLvDd6toHuloPC1
	qHvu0dT44RnXJmHHXbHrKheFgxg7OqI7mMY/c91X2x8eBPoy91HHw2uU00ZmwTeJ/5Bg8zKQpz0
	qXo6y
X-Gm-Gg: ASbGncvzlZ1TOPhLiTPcycd+s0n+Lfe7fWXQeGvF03WZHDFCb0kWLmvE1oFep+0eMAD
	dAfEkWAuiTY+kcBhsZQ+glPkLn4LhHtwtRmUChwk3vpkgdodIpegrCymf3tdMGSXaHBadKdCEp4
	ARFl8vaH8LbSWq26GsWXia3ug5JbqdWrR8yPc3KZEzGL78v9uhjefUa/zyYCvc+dpuvpmwhkZkM
	aEL6IsJGIIplvwmeQHDMxLtzvDaj80jMykYXYlJHpEocRdLwN1Tg4oHdwYFMjK2GKrANA7TBO7B
	ZeeihpmHJPXggvoAVN5N4+8IjzcxfzsjkvYM9k99K+SCI2l76+e2BXWdTdLT/RuhN+/iek6dkw4
	Unq+Q/qyhh0XSd80K+r/lnVuoJRLTr5qhiHXlwe37Lr1OrGooOnDew6H2RJ0KiU+GgMVDnXtmQP
	Sot4JQYXfQgJCaIurXDhSV4tA=
X-Google-Smtp-Source: AGHT+IEY+WXhoveu7Pmi2bFEhE2y28XFj3wUL8mBEWc5efxMT/JrsQ6kJRaD14MG1fUglUniAol2yw==
X-Received: by 2002:a05:6820:f04:b0:657:71fa:5f6d with SMTP id 006d021491bc7-65972784330mr169284eaf.6.1764713365866;
        Tue, 02 Dec 2025 14:09:25 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc3fb2sm4750092eaf.11.2025.12.02.14.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 14:09:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------olGkcMsyyvQr12XTN0XojxjN"
Message-ID: <180cca32-0d89-499a-bb36-c89e55736156@linuxfoundation.org>
Date: Tue, 2 Dec 2025 15:09:24 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest next update for Linux 6.19-rc1

This is a multi-part message in MIME format.
--------------olGkcMsyyvQr12XTN0XojxjN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest next update for Linux 6.19-rc1

Adds basic test for trace_marker_raw file to tracing selftest.
Fixes invalid array access in printf dma_map_benchmark selftest.
Adds tprobe enable/disable testcase to tracing selftest.
Updates fprobe selftest for ftrace based fprobe.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.19-rc1

for you to fetch changes up to a2f7990d330937a204b86b9cafbfef82f87a8693:

   selftests: tracing: Update fprobe selftest for ftrace based fprobe (2025-11-19 15:55:14 -0700)

----------------------------------------------------------------
linux_kselftest-next-6.19-rc1

Adds basic test for trace_marker_raw file to tracing selftest.
Fixes invalid array access in printf dma_map_benchmark selftest.
Adds tprobe enable/disable testcase to tracing selftest.
Updates fprobe selftest for ftrace based fprobe.

----------------------------------------------------------------
Brendan Jackman (1):
       selftests/run_kselftest.sh: exit with error if tests fail

Masami Hiramatsu (Google) (2):
       selftests: tracing: Add tprobe enable/disable testcase
       selftests: tracing: Update fprobe selftest for ftrace based fprobe

Steven Rostedt (1):
       selftests/tracing: Add basic test for trace_marker_raw file

Zhang Chujun (1):
       selftests/dma: fix invalid array access in printf

  tools/testing/selftests/dma/dma_map_benchmark.c    |   2 +-
  .../ftrace/test.d/00basic/trace_marker_raw.tc      | 107 +++++++++++++++++++++
  .../ftrace/test.d/dynevent/add_remove_fprobe.tc    |  18 +---
  .../test.d/dynevent/enable_disable_tprobe.tc       |  40 ++++++++
  tools/testing/selftests/kselftest/runner.sh        |  14 ++-
  tools/testing/selftests/run_kselftest.sh           |  14 +++
  6 files changed, 176 insertions(+), 19 deletions(-)
  create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/enable_disable_tprobe.tc
----------------------------------------------------------------
--------------olGkcMsyyvQr12XTN0XojxjN
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.19-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.19-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYS9kbWFfbWFwX2JlbmNo
bWFyay5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZG1hL2RtYV9tYXBfYmVuY2htYXJr
LmMKaW5kZXggYjEyZjFmOWJhYmY4Li5iOTI1NzU2MzczY2UgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYS9kbWFfbWFwX2JlbmNobWFyay5jCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYS9kbWFfbWFwX2JlbmNobWFyay5jCkBAIC0xMTgsNyAr
MTE4LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCX0KIAogCXByaW50
ZigiZG1hIG1hcHBpbmcgYmVuY2htYXJrOiB0aHJlYWRzOiVkIHNlY29uZHM6JWQgbm9kZTol
ZCBkaXI6JXMgZ3JhbnVsZTogJWRcbiIsCi0JCQl0aHJlYWRzLCBzZWNvbmRzLCBub2RlLCBk
aXJbZGlyZWN0aW9uc10sIGdyYW51bGUpOworCQkJdGhyZWFkcywgc2Vjb25kcywgbm9kZSwg
ZGlyZWN0aW9uc1tkaXJdLCBncmFudWxlKTsKIAlwcmludGYoImF2ZXJhZ2UgbWFwIGxhdGVu
Y3kodXMpOiUuMWYgc3RhbmRhcmQgZGV2aWF0aW9uOiUuMWZcbiIsCiAJCQltYXAuYXZnX21h
cF8xMDBucy8xMC4wLCBtYXAubWFwX3N0ZGRldi8xMC4wKTsKIAlwcmludGYoImF2ZXJhZ2Ug
dW5tYXAgbGF0ZW5jeSh1cyk6JS4xZiBzdGFuZGFyZCBkZXZpYXRpb246JS4xZlxuIiwKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvMDBiYXNp
Yy90cmFjZV9tYXJrZXJfcmF3LnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L3Rlc3QuZC8wMGJhc2ljL3RyYWNlX21hcmtlcl9yYXcudGMKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAwLi43ZGFmNzI5MjIwOWUKLS0tIC9kZXYvbnVsbAorKysg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kLzAwYmFzaWMvdHJhY2Vf
bWFya2VyX3Jhdy50YwpAQCAtMCwwICsxLDEwNyBAQAorIyEvYmluL3NoCisjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCisjIGRlc2NyaXB0aW9uOiBCYXNpYyB0ZXN0cyBv
biB3cml0aW5nIHRvIHRyYWNlX21hcmtlcl9yYXcKKyMgcmVxdWlyZXM6IHRyYWNlX21hcmtl
cl9yYXcKKyMgZmxhZ3M6IGluc3RhbmNlCisKK2lzX2xpdHRsZV9lbmRpYW4oKSB7CisJaWYg
bHNjcHUgfCBncmVwIC1xICdMaXR0bGUgRW5kaWFuJzsgdGhlbgorCQllY2hvIDE7CisJZWxz
ZQorCQllY2hvIDA7CisJZmkKK30KKworbGl0dGxlPWBpc19saXR0bGVfZW5kaWFuYAorCitt
YWtlX3N0cigpIHsKKwlpZD0kMQorCWNudD0kMgorCisJaWYgWyAkbGl0dGxlIC1lcSAxIF07
IHRoZW4KKwkJdmFsPWBwcmludGYgIlxcJTAzb1xcJTAzb1xcJTAzb1xcJTAzbyIgXAorCQkJ
JCgoJGlkICYgMHhmZikpIFwKKwkJCSQoKCgkaWQgPj4gOCkgJiAweGZmKSkgXAorCQkJJCgo
KCRpZCA+PiAxNikgJiAweGZmKSkgXAorCQkJJCgoKCRpZCA+PiAyNCkgJiAweGZmKSlgCisJ
ZWxzZQorCQl2YWw9YHByaW50ZiAiXFwlMDNvXFwlMDNvXFwlMDNvXFwlMDNvIiBcCisJCQkk
KCgoJGlkID4+IDI0KSAmIDB4ZmYpKSBcCisJCQkkKCgoJGlkID4+IDE2KSAmIDB4ZmYpKSBc
CisJCQkkKCgoJGlkID4+IDgpICYgMHhmZikpIFwKKwkJCSQoKCRpZCAmIDB4ZmYpKWAKKwlm
aQorCisJZGF0YT1gcHJpbnRmIC0tICdYJS4wcycgJChzZXEgJGNudClgCisKKwlwcmludGYg
IiR7dmFsfSR7ZGF0YX0iCit9CisKK3dyaXRlX2J1ZmZlcigpIHsKKwlpZD0kMQorCXNpemU9
JDIKKworCSMgd3JpdGUgdGhlIHN0cmluZyBpbnRvIHRoZSByYXcgbWFya2VyCisJbWFrZV9z
dHIgJGlkICRzaXplID4gdHJhY2VfbWFya2VyX3JhdworfQorCisKK3Rlc3RfbXVsdGlwbGVf
d3JpdGVzKCkgeworCisJIyBXcml0ZSBhIGJ1bmNoIG9mIGRhdGEgd2hlcmUgdGhlIGlkIGlz
IHRoZSBjb3VudCBvZgorCSMgZGF0YSB0byB3cml0ZQorCWZvciBpIGluIGBzZXEgMSAxMGAg
YHNlcSAxMDEgMTEwYCBgc2VxIDEwMDEgMTAxMGA7IGRvCisJCXdyaXRlX2J1ZmZlciAkaSAk
aQorCWRvbmUKKworCSMgYWRkIGEgbGl0dGxlIGJ1ZmZlcgorCWVjaG8gc3RvcCA+IHRyYWNl
X21hcmtlcgorCisJIyBDaGVjayB0byBtYWtlIHN1cmUgdGhlIG51bWJlciBvZiBlbnRyaWVz
IGlzIHRoZSBpZCAocm91bmRlZCB1cCBieSA0KQorCWF3ayAnLy4qOiAjIFswLTlhLWZdKiAv
IHsKKwkJCXByaW50OworCQkJY250ID0gLTE7CisJCQlmb3IgKGkgPSAwOyBpIDwgTkY7IGkr
KykgeworCQkJCSMgVGhlIGNvdW50ZXIgaXMgYWZ0ZXIgdGhlICIjIiBtYXJrZXIKKwkJCQlp
ZiAoICRpID09ICIjIiApIHsKKwkJCQkJaSsrOworCQkJCQljbnQgPSBzdHJ0b251bSgiMHgi
ICRpKTsKKwkJCQkJbnVtID0gTkYgLSAoaSArIDEpOworCQkJCQkjIFRoZSBudW1iZXIgb2Yg
aXRlbXMgaXMgYWx3YXlzIHJvdW5kZWQgdXAgYnkgNAorCQkJCQljbnQyID0gaW50KChjbnQg
KyAzKSAvIDQpICogNDsKKwkJCQkJaWYgKGNudDIgIT0gbnVtKSB7CisJCQkJCQlleGl0IDE7
CisJCQkJCX0KKwkJCQkJYnJlYWs7CisJCQkJfQorCQkJfQorCQl9CisJLy8geyBpZiAoTlIg
PiAzMCkgeyBleGl0IDA7IH0gfSAnIHRyYWNlX3BpcGU7Cit9CisKKworZ2V0X2J1ZmZlcl9k
YXRhX3NpemUoKSB7CisJc2VkIC1uZSAncy9eLipkYXRhLipzaXplOlwoWzAtOV1bMC05XSpc
KS4qL1wxL3AnIGV2ZW50cy9oZWFkZXJfcGFnZQorfQorCit0ZXN0X2J1ZmZlcigpIHsKKwor
CSMgVGhlIGlkIG11c3QgYmUgZm91ciBieXRlcywgdGVzdCB0aGF0IDMgYnl0ZXMgZmFpbHMg
YSB3cml0ZQorCWlmIGVjaG8gLW4gYWJjID4gLi90cmFjZV9tYXJrZXJfcmF3IDsgdGhlbgor
CQllY2hvICJUb28gc21hbGwgb2Ygd3JpdGUgZXhwZWN0ZWQgdG8gZmFpbCBidXQgZGlkIG5v
dCIKKwkJZXhpdF9mYWlsCisJZmkKKworCXNpemU9YGdldF9idWZmZXJfZGF0YV9zaXplYAor
CWVjaG8gc2l6ZSA9ICRzaXplCisKKwkjIE5vdyBhZGQgYSBsaXR0bGUgbW9yZSB0aGFuIHdo
YXQgaXQgY2FuIGhhbmRsZQorCisJaWYgd3JpdGVfYnVmZmVyIDB4ZGVhZGJlZWYgJHNpemUg
OyB0aGVuCisJCWVjaG8gIlRvbyBiaWcgb2Ygd3JpdGUgZXhwZWN0ZWQgdG8gZmFpbCBidXQg
ZGlkIG5vdCIKKwkJZXhpdF9mYWlsCisJZmkKK30KKwordGVzdF9idWZmZXIKK3Rlc3RfbXVs
dGlwbGVfd3JpdGVzCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJh
Y2UvdGVzdC5kL2R5bmV2ZW50L2FkZF9yZW1vdmVfZnByb2JlLnRjIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVudC9hZGRfcmVtb3ZlX2Zwcm9iZS50
YwppbmRleCAyNTA2ZjQ2NDgxMWIuLjQ3MDY3YTVlM2NiMCAxMDA2NDQKLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVudC9hZGRfcmVtb3ZlX2Zw
cm9iZS50YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2R5
bmV2ZW50L2FkZF9yZW1vdmVfZnByb2JlLnRjCkBAIC0yOCwyNSArMjgsMjEgQEAgdGVzdCAt
ZCBldmVudHMvZnByb2Jlcy9teWV2ZW50MQogdGVzdCAtZCBldmVudHMvZnByb2Jlcy9teWV2
ZW50MgogCiBlY2hvIDEgPiBldmVudHMvZnByb2Jlcy9teWV2ZW50MS9lbmFibGUKLSMgTWFr
ZSBzdXJlIHRoZSBldmVudCBpcyBhdHRhY2hlZCBhbmQgaXMgdGhlIG9ubHkgb25lCisjIE1h
a2Ugc3VyZSB0aGUgZXZlbnQgaXMgYXR0YWNoZWQuCiBncmVwIC1xICRQTEFDRSBlbmFibGVk
X2Z1bmN0aW9ucwogY250PWBjYXQgZW5hYmxlZF9mdW5jdGlvbnMgfCB3YyAtbGAKLWlmIFsg
JGNudCAtbmUgJCgob2NudCArIDEpKSBdOyB0aGVuCitpZiBbICRjbnQgLWVxICRvY250IF07
IHRoZW4KIAlleGl0X2ZhaWwKIGZpCiAKIGVjaG8gMSA+IGV2ZW50cy9mcHJvYmVzL215ZXZl
bnQyL2VuYWJsZQotIyBJdCBzaG91bGQgdGlsbCBiZSB0aGUgb25seSBhdHRhY2hlZCBmdW5j
dGlvbgotY250PWBjYXQgZW5hYmxlZF9mdW5jdGlvbnMgfCB3YyAtbGAKLWlmIFsgJGNudCAt
bmUgJCgob2NudCArIDEpKSBdOyB0aGVuCi0JZXhpdF9mYWlsCi1maQorY250Mj1gY2F0IGVu
YWJsZWRfZnVuY3Rpb25zIHwgd2MgLWxgCiAKIGVjaG8gMSA+IGV2ZW50cy9mcHJvYmVzL215
ZXZlbnQzL2VuYWJsZQogIyBJZiB0aGUgZnVuY3Rpb24gaXMgZGlmZmVyZW50LCB0aGUgYXR0
YWNoZWQgZnVuY3Rpb24gc2hvdWxkIGJlIGluY3JlYXNlZAogZ3JlcCAtcSAkUExBQ0UyIGVu
YWJsZWRfZnVuY3Rpb25zCiBjbnQ9YGNhdCBlbmFibGVkX2Z1bmN0aW9ucyB8IHdjIC1sYAot
aWYgWyAkY250IC1uZSAkKChvY250ICsgMikpIF07IHRoZW4KK2lmIFsgJGNudCAtZXEgJGNu
dDIgXTsgdGhlbgogCWV4aXRfZmFpbAogZmkKIApAQCAtNTYsMTIgKzUyLDYgQEAgZWNobyAi
LTpteWV2ZW50MiIgPj4gZHluYW1pY19ldmVudHMKIGdyZXAgLXEgbXlldmVudDEgZHluYW1p
Y19ldmVudHMKICEgZ3JlcCAtcSBteWV2ZW50MiBkeW5hbWljX2V2ZW50cwogCi0jIHNob3Vs
ZCBzdGlsbCBoYXZlIDIgbGVmdAotY250PWBjYXQgZW5hYmxlZF9mdW5jdGlvbnMgfCB3YyAt
bGAKLWlmIFsgJGNudCAtbmUgJCgob2NudCArIDIpKSBdOyB0aGVuCi0JZXhpdF9mYWlsCi1m
aQotCiBlY2hvIDAgPiBldmVudHMvZnByb2Jlcy9lbmFibGUKIGVjaG8gPiBkeW5hbWljX2V2
ZW50cwogCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVz
dC5kL2R5bmV2ZW50L2VuYWJsZV9kaXNhYmxlX3Rwcm9iZS50YyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZHluZXZlbnQvZW5hYmxlX2Rpc2FibGVfdHByb2Jl
LnRjCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYzFmMWNhZmEz
MGYzCi0tLSAvZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L3Rlc3QuZC9keW5ldmVudC9lbmFibGVfZGlzYWJsZV90cHJvYmUudGMKQEAgLTAsMCArMSw0
MCBAQAorIyEvYmluL3NoCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCisj
IGRlc2NyaXB0aW9uOiBHZW5lcmljIGR5bmFtaWMgZXZlbnQgLSBlbmFibGUvZGlzYWJsZSB0
cmFjZXBvaW50IHByb2JlIGV2ZW50cworIyByZXF1aXJlczogZHluYW1pY19ldmVudHMgInRb
Ols8Z3JvdXA+L11bPGV2ZW50Pl1dIDx0cmFjZXBvaW50PiBbPGFyZ3M+XSI6UkVBRE1FCisK
K2VjaG8gMCA+IGV2ZW50cy9lbmFibGUKK2VjaG8gPiBkeW5hbWljX2V2ZW50cworCitUUkFD
RVBPSU5UPXNjaGVkX3N3aXRjaAorRU5BQkxFRklMRT1ldmVudHMvdHJhY2Vwb2ludHMvbXlw
cm9iZS9lbmFibGUKKworOjs6ICJBZGQgdHJhY2Vwb2ludCBldmVudCBvbiAkVFJBQ0VQT0lO
VCIgOzoKKworZWNobyAidDpteXByb2JlICR7VFJBQ0VQT0lOVH0iID4+IGR5bmFtaWNfZXZl
bnRzCisKKzo7OiAiQ2hlY2sgZW5hYmxlL2Rpc2FibGUgdG8gZW5zdXJlIGl0IHdvcmtzIiA7
OgorCitlY2hvIDEgPiAkRU5BQkxFRklMRQorCitncmVwIC1xICRUUkFDRVBPSU5UIHRyYWNl
CisKK2VjaG8gMCA+ICRFTkFCTEVGSUxFCisKK2VjaG8gPiB0cmFjZQorCishIGdyZXAgLXEg
JFRSQUNFUE9JTlQgdHJhY2UKKworOjs6ICJSZXBlYXQgZW5hYmxlL2Rpc2FibGUgdG8gZW5z
dXJlIGl0IHdvcmtzIiA7OgorCitlY2hvIDEgPiAkRU5BQkxFRklMRQorCitncmVwIC1xICRU
UkFDRVBPSU5UIHRyYWNlCisKK2VjaG8gMCA+ICRFTkFCTEVGSUxFCisKK2VjaG8gPiB0cmFj
ZQorCishIGdyZXAgLXEgJFRSQUNFUE9JTlQgdHJhY2UKKworZXhpdCAwCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3QvcnVubmVyLnNoIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0L3J1bm5lci5zaAppbmRleCAyYzNjNThlNjVh
NDEuLjNhNjIwMzlmYTYyMSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
a3NlbGZ0ZXN0L3J1bm5lci5zaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2Vs
ZnRlc3QvcnVubmVyLnNoCkBAIC00NCw2ICs0NCwxMiBAQCB0YXBfdGltZW91dCgpCiAJZmkK
IH0KIAorcmVwb3J0X2ZhaWx1cmUoKQoreworCWVjaG8gIm5vdCBvayAkKiIKKwllY2hvICIk
KiIgPj4gIiRrc2VsZnRlc3RfZmFpbHVyZXNfZmlsZSIKK30KKwogcnVuX29uZSgpCiB7CiAJ
RElSPSIkMSIKQEAgLTEwNSw3ICsxMTEsNyBAQCBydW5fb25lKCkKIAllY2hvICIjICRURVNU
X0hEUl9NU0ciCiAJaWYgWyAhIC1lICIkVEVTVCIgXTsgdGhlbgogCQllY2hvICIjIFdhcm5p
bmc6IGZpbGUgJFRFU1QgaXMgbWlzc2luZyEiCi0JCWVjaG8gIm5vdCBvayAkdGVzdF9udW0g
JFRFU1RfSERSX01TRyIKKwkJcmVwb3J0X2ZhaWx1cmUgIiR0ZXN0X251bSAkVEVTVF9IRFJf
TVNHIgogCWVsc2UKIAkJaWYgWyAteCAvdXNyL2Jpbi9zdGRidWYgXTsgdGhlbgogCQkJc3Rk
YnVmPSIvdXNyL2Jpbi9zdGRidWYgLS1vdXRwdXQ9TCAiCkBAIC0xMjMsNyArMTI5LDcgQEAg
cnVuX29uZSgpCiAJCQkJaW50ZXJwcmV0ZXI9JChoZWFkIC1uIDEgIiRURVNUIiB8IGN1dCAt
YyAzLSkKIAkJCQljbWQ9IiRzdGRidWYgJGludGVycHJldGVyIC4vJEJBU0VOQU1FX1RFU1Qi
CiAJCQllbHNlCi0JCQkJZWNobyAibm90IG9rICR0ZXN0X251bSAkVEVTVF9IRFJfTVNHIgor
CQkJCXJlcG9ydF9mYWlsdXJlICIkdGVzdF9udW0gJFRFU1RfSERSX01TRyIKIAkJCQlyZXR1
cm4KIAkJCWZpCiAJCWZpCkBAIC0xMzcsOSArMTQzLDkgQEAgcnVuX29uZSgpCiAJCQllY2hv
ICJvayAkdGVzdF9udW0gJFRFU1RfSERSX01TRyAjIFNLSVAiCiAJCWVsaWYgWyAkcmMgLWVx
ICR0aW1lb3V0X3JjIF07IHRoZW4gXAogCQkJZWNobyAiIyIKLQkJCWVjaG8gIm5vdCBvayAk
dGVzdF9udW0gJFRFU1RfSERSX01TRyAjIFRJTUVPVVQgJGtzZWxmdGVzdF90aW1lb3V0IHNl
Y29uZHMiCisJCQlyZXBvcnRfZmFpbHVyZSAiJHRlc3RfbnVtICRURVNUX0hEUl9NU0cgIyBU
SU1FT1VUICRrc2VsZnRlc3RfdGltZW91dCBzZWNvbmRzIgogCQllbHNlCi0JCQllY2hvICJu
b3Qgb2sgJHRlc3RfbnVtICRURVNUX0hEUl9NU0cgIyBleGl0PSRyYyIKKwkJCXJlcG9ydF9m
YWlsdXJlICIkdGVzdF9udW0gJFRFU1RfSERSX01TRyAjIGV4aXQ9JHJjIgogCQlmaSkKIAkJ
Y2QgLSA+L2Rldi9udWxsCiAJZmkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3J1bl9rc2VsZnRlc3Quc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydW5fa3Nl
bGZ0ZXN0LnNoCmluZGV4IDA0NDNiZWFjZjM2Mi4uZDRiZTk3NDk4YjMyIDEwMDc1NQotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydW5fa3NlbGZ0ZXN0LnNoCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3J1bl9rc2VsZnRlc3Quc2gKQEAgLTMzLDYgKzMzLDcgQEAg
VXNhZ2U6ICQwIFtPUFRJT05TXQogICAtYyB8IC0tY29sbGVjdGlvbiBDT0xMRUNUSU9OCVJ1
biBhbGwgdGVzdHMgZnJvbSBDT0xMRUNUSU9OCiAgIC1sIHwgLS1saXN0CQkJTGlzdCB0aGUg
YXZhaWxhYmxlIGNvbGxlY3Rpb246dGVzdCBlbnRyaWVzCiAgIC1kIHwgLS1kcnktcnVuCQlE
b24ndCBhY3R1YWxseSBydW4gYW55IHRlc3RzCisgIC1mIHwgLS1uby1lcnJvci1vbi1mYWls
CURvbid0IGV4aXQgd2l0aCBhbiBlcnJvciBqdXN0IGJlY2F1c2UgdGVzdHMgZmFpbGVkCiAg
IC1uIHwgLS1uZXRucwkJCVJ1biBlYWNoIHRlc3QgaW4gbmFtZXNwYWNlCiAgIC1oIHwgLS1o
ZWxwCQkJU2hvdyB0aGlzIHVzYWdlIGluZm8KICAgLW8gfCAtLW92ZXJyaWRlLXRpbWVvdXQJ
TnVtYmVyIG9mIHNlY29uZHMgYWZ0ZXIgd2hpY2ggd2UgdGltZW91dApAQCAtNDQsNiArNDUs
NyBAQCBDT0xMRUNUSU9OUz0iIgogVEVTVFM9IiIKIGRyeXJ1bj0iIgoga3NlbGZ0ZXN0X292
ZXJyaWRlX3RpbWVvdXQ9IiIKK0VSUk9SX09OX0ZBSUw9dHJ1ZQogd2hpbGUgdHJ1ZTsgZG8K
IAljYXNlICIkMSIgaW4KIAkJLXMgfCAtLXN1bW1hcnkpCkBAIC02NSw2ICs2Nyw5IEBAIHdo
aWxlIHRydWU7IGRvCiAJCS1kIHwgLS1kcnktcnVuKQogCQkJZHJ5cnVuPSJlY2hvIgogCQkJ
c2hpZnQgOzsKKwkJLWYgfCAtLW5vLWVycm9yLW9uLWZhaWwpCisJCQlFUlJPUl9PTl9GQUlM
PWZhbHNlCisJCQlzaGlmdCA7OwogCQktbiB8IC0tbmV0bnMpCiAJCQlSVU5fSU5fTkVUTlM9
MQogCQkJc2hpZnQgOzsKQEAgLTEwNSw5ICsxMTAsMTggQEAgaWYgWyAtbiAiJFRFU1RTIiBd
OyB0aGVuCiAJYXZhaWxhYmxlPSIkKGVjaG8gIiR2YWxpZCIgfCBzZWQgLWUgJ3MvIC9cbi9n
JykiCiBmaQogCitrc2VsZnRlc3RfZmFpbHVyZXNfZmlsZT0iJChta3RlbXAgLS10bXBkaXIg
a3NlbGZ0ZXN0LWZhaWx1cmVzLVhYWFhYWCkiCitleHBvcnQga3NlbGZ0ZXN0X2ZhaWx1cmVz
X2ZpbGUKKwogY29sbGVjdGlvbnM9JChlY2hvICIkYXZhaWxhYmxlIiB8IGN1dCAtZDogLWYx
IHwgc29ydCB8IHVuaXEpCiBmb3IgY29sbGVjdGlvbiBpbiAkY29sbGVjdGlvbnMgOyBkbwog
CVsgLXcgL2Rldi9rbXNnIF0gJiYgZWNobyAia3NlbGZ0ZXN0OiBSdW5uaW5nIHRlc3RzIGlu
ICRjb2xsZWN0aW9uIiA+PiAvZGV2L2ttc2cKIAl0ZXN0cz0kKGVjaG8gIiRhdmFpbGFibGUi
IHwgZ3JlcCAiXiRjb2xsZWN0aW9uOiIgfCBjdXQgLWQ6IC1mMikKIAkoJGRyeXJ1biBjZCAi
JGNvbGxlY3Rpb24iICYmICRkcnlydW4gcnVuX21hbnkgJHRlc3RzKQogZG9uZQorCitmYWls
dXJlcz0iJChjYXQgIiRrc2VsZnRlc3RfZmFpbHVyZXNfZmlsZSIpIgorcm0gIiRrc2VsZnRl
c3RfZmFpbHVyZXNfZmlsZSIKK2lmICIkRVJST1JfT05fRkFJTCIgJiYgWyAiJGZhaWx1cmVz
IiBdOyB0aGVuCisJZXhpdCAxCitmaQo=

--------------olGkcMsyyvQr12XTN0XojxjN--


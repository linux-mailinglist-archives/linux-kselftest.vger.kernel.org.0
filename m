Return-Path: <linux-kselftest+bounces-21328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728AA9B9AD0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 23:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE07BB219A5
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DD01E47B3;
	Fri,  1 Nov 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5qGOj6c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A11BDC3
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499965; cv=none; b=WBc7jqjuUn/36BAFuvqMpSbFc8wseVroZfMjClcJYufIcR2bZqzxhha1hqnRr6Dby2a0S0VlG/TUFdBUea7ijMd63jR7tghrLovxxmArkE7rcYRViMZilEaOlJDiUBPzqfm+evAt8JHSCs2bLxPFLZHoY4YWu+d4pPw1zfSFbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499965; c=relaxed/simple;
	bh=8WgB+62A7m8cWy56yXF5qm8X2qWqEnpgx23YDfgFxSQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=XtTOFZMleKu5MxHBefLbJYTXBgVjGyIt6yPMyHBBCWHX9p33nLMxKFxwt2ywVTha1FaaLpa7phy5vLy985SnXaiPTZpNHe8fgVleuMlDfahzyHeQA+cduFTBg45KX1FS/Pb9KV4ia2bvBRct1ElI7HWVLsuL96Nt9f8WK32yo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5qGOj6c; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a6af694220so6308915ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730499962; x=1731104762; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8ge729bSSFQAYpLNOdK0tpr7ndevPxzGAiO91GEVbAI=;
        b=Z5qGOj6cp1OojGsOY+MNhmmCsflofIh7dT843Msu4Dd1Vs4RI9dW1fxchTH1wDJlzj
         6M6lqBZ4v+D/IdmapvHPeKSFK38kGC6VmqlVm33meWxNE+4cqAWMNBZNBW+8d4/v95FR
         xXLdiG7pTajcnHsskUP9bRfkGOlk0v6zfn810=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499962; x=1731104762;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ge729bSSFQAYpLNOdK0tpr7ndevPxzGAiO91GEVbAI=;
        b=L2DhT9IiGJUOGm9YuEiIAtT+zcv1YUkb3TsnyzHL1YYP0V/9+iSxkLi+oBztQOq6xW
         m2ZsgJD4vnxlOltJ4H8v6jrqzG0VgCBd4HPiIzhCgZ2ZYOHQD01Co3UTyKIZbXm1pngH
         pjK/p0H5ZVFaUaMrSjsCaapBUWm9Dy/a2VEGL5sLvDVLP2YtBEZdGxskFcH2KIwJJ3WW
         xTJQ0Bi/uGJVp0KN+xsMEtdCVx2reHJS06Tu1oEyv2qvRlRdO58WaUpGhAlykg+hHx3j
         XKAPapwAfkSyQCoDyF4LAPOI3ue2xaMsWUEt32cik75PtkaUgAUDYAgL+8GoU35acB8x
         eAfA==
X-Forwarded-Encrypted: i=1; AJvYcCV4O2WCgtT/Po8240IxoWh5e3Ib67SvcN9LUR1UkNQ8j/6UJct3m3E9bJEoQcxLC7xl9tZdg9VmM7HrAlwU0Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3IAtIER7X4SP9HQhYQfTKrVEPrFKN/0+zJpJYwDr16bnpbimX
	nnbXxw1a+SaGZ/3OIaZquzAMHTnYfKLeJ8WBjnGn0j2VWuY/uchdTCUv8HUcbBU=
X-Google-Smtp-Source: AGHT+IEvYE5zUHozExbViAHlGqJiGaGQHg144qdlk8/veuvlKcr3K0IHDHd14kM6ALRohdTfbejSxA==
X-Received: by 2002:a05:6e02:152b:b0:3a6:af68:6679 with SMTP id e9e14a558f8ab-3a6b03cc437mr62099095ab.25.1730499961547;
        Fri, 01 Nov 2024 15:26:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6adbf2303sm8391095ab.47.2024.11.01.15.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 15:26:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------5MhXncmYMT4l0dO285lDHegg"
Message-ID: <3ae64072-4327-4e92-b0f0-ead3743d4d54@linuxfoundation.org>
Date: Fri, 1 Nov 2024 16:25:59 -0600
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
Subject: [GIT PULL] Kselftest fixes update for Linux 6.12-rc6

This is a multi-part message in MIME format.
--------------5MhXncmYMT4l0dO285lDHegg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.12-rc6.

Kselftest fixes for Linux 6.12-rc6

- fix syntax error in frequency calculation arithmetic expression in
   intel_pstate run.sh
- add missing cpupower dependency check intel_pstate run.sh
- fix idmap_mount_tree_invalid test failure due to incorrect argument
- fix watchdog-test run leaving the watchdog timer enabled causing
   system reboot. With this fix, the test disables the watchdog timer
   when it gets terminated with SIGTERM, SIGKILL, and SIGQUIT in addition
   to SIGINT

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit fe05c40ca9c18cfdb003f639a30fc78a7ab49519:

   selftest: hid: add the missing tests directory (2024-10-16 15:55:14 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc6

for you to fetch changes up to dc1308bee1ed03b4d698d77c8bd670d399dcd04d:

   selftests/watchdog-test: Fix system accidentally reset after watchdog-test (2024-10-28 21:34:43 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.12-rc6

Kselftest fixes for Linux 6.12-rc6

- fix syntax error in frequency calculation arithmetic expression in
   intel_pstate run.sh
- add missing cpupower dependency check intel_pstate run.sh
- fix idmap_mount_tree_invalid test failure due to incorrect argument
- fix watchdog-test run leaving the watchdog timer enabled causing
   system reboot. With this fix, the test disables the watchdog timer
   when it gets terminated with SIGTERM, SIGKILL, and SIGQUIT in addition
   to SIGINT

----------------------------------------------------------------
Alessandro Zanni (2):
       selftests/intel_pstate: fix operand expected error
       selftests/intel_pstate: check if cpupower is installed

Li Zhijian (1):
       selftests/watchdog-test: Fix system accidentally reset after watchdog-test

zhouyuhang (1):
       selftests/mount_setattr: fix idmap_mount_tree_invalid failed to run

  tools/testing/selftests/intel_pstate/run.sh                | 9 +++++++--
  tools/testing/selftests/mount_setattr/mount_setattr_test.c | 9 +++++++++
  tools/testing/selftests/watchdog/watchdog-test.c           | 6 ++++++
  3 files changed, 22 insertions(+), 2 deletions(-)
---------------------------------------------------------------
--------------5MhXncmYMT4l0dO285lDHegg
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.12-rc6.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.12-rc6.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ludGVsX3BzdGF0ZS9ydW4u
c2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9pbnRlbF9wc3RhdGUvcnVuLnNoCmluZGV4
IGU3MDA4ZjYxNGFkNy4uNmEzYjg1MDMyNjRlIDEwMDc1NQotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9pbnRlbF9wc3RhdGUvcnVuLnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2ludGVsX3BzdGF0ZS9ydW4uc2gKQEAgLTQ0LDYgKzQ0LDExIEBAIGlmIFsgJFVJ
RCAhPSAwIF0gJiYgWyAkRVZBTFVBVEVfT05MWSA9PSAwIF07IHRoZW4KICAgICBleGl0ICRr
c2Z0X3NraXAKIGZpCiAKK2lmICEgY29tbWFuZCAtdiBjcHVwb3dlciAmPiAvZGV2L251bGw7
IHRoZW4KKwllY2hvICRtc2cgY3B1cG93ZXIgY291bGQgbm90IGJlIGZvdW5kLCBwbGVhc2Ug
aW5zdGFsbCBpdCA+JjIKKwlleGl0ICRrc2Z0X3NraXAKK2ZpCisKIG1heF9jcHVzPSQoKCQo
bnByb2MpLTEpKQogCiBmdW5jdGlvbiBydW5fdGVzdCAoKSB7CkBAIC04Nyw5ICs5Miw5IEBA
IG1rdF9mcmVxPSR7X21rdF9mcmVxfTAKIAogIyBHZXQgdGhlIHJhbmdlcyBmcm9tIGNwdXBv
d2VyCiBfbWluX2ZyZXE9JChjcHVwb3dlciBmcmVxdWVuY3ktaW5mbyAtbCB8IHRhaWwgLTEg
fCBhd2sgJyB7IHByaW50ICQxIH0gJykKLW1pbl9mcmVxPSQoKCRfbWluX2ZyZXEgLyAxMDAw
KSkKK21pbl9mcmVxPSQoKF9taW5fZnJlcSAvIDEwMDApKQogX21heF9mcmVxPSQoY3B1cG93
ZXIgZnJlcXVlbmN5LWluZm8gLWwgfCB0YWlsIC0xIHwgYXdrICcgeyBwcmludCAkMiB9ICcp
Ci1tYXhfZnJlcT0kKCgkX21heF9mcmVxIC8gMTAwMCkpCittYXhfZnJlcT0kKChfbWF4X2Zy
ZXEgLyAxMDAwKSkKIAogCiBbICRFVkFMVUFURV9PTkxZIC1lcSAwIF0gJiYgZm9yIGZyZXEg
aW4gYHNlcSAkbWF4X2ZyZXEgLTEwMCAkbWluX2ZyZXFgCmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9tb3VudF9zZXRhdHRyL21vdW50X3NldGF0dHJfdGVzdC5jIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW91bnRfc2V0YXR0ci9tb3VudF9zZXRhdHRyX3Rl
c3QuYwppbmRleCBjNmE4YzczMmI4MDIuLjY4ODAxZTFhOWVjMiAxMDA2NDQKLS0tIGEvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvbW91bnRfc2V0YXR0ci9tb3VudF9zZXRhdHRyX3Rlc3Qu
YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9tb3VudF9zZXRhdHRyL21vdW50X3Nl
dGF0dHJfdGVzdC5jCkBAIC0xNDE0LDYgKzE0MTQsMTMgQEAgVEVTVF9GKG1vdW50X3NldGF0
dHJfaWRtYXBwZWQsIGlkbWFwX21vdW50X3RyZWVfaW52YWxpZCkKIAlBU1NFUlRfRVEoZXhw
ZWN0ZWRfdWlkX2dpZCgtRUJBREYsICIvdG1wL0IvYiIsIDAsIDAsIDApLCAwKTsKIAlBU1NF
UlRfRVEoZXhwZWN0ZWRfdWlkX2dpZCgtRUJBREYsICIvdG1wL0IvQkIvYiIsIDAsIDAsIDAp
LCAwKTsKIAorCUFTU0VSVF9FUShtb3VudCgidGVzdGluZyIsICIvbW50L0EiLCAicmFtZnMi
LCBNU19OT0FUSU1FIHwgTVNfTk9ERVYsCisJCQkic2l6ZT0xMDAwMDAsbW9kZT03MDAiKSwg
MCk7CisKKwlBU1NFUlRfRVEobWtkaXIoIi9tbnQvQS9BQSIsIDA3NzcpLCAwKTsKKworCUFT
U0VSVF9FUShtb3VudCgiL3RtcCIsICIvbW50L0EvQUEiLCBOVUxMLCBNU19CSU5EIHwgTVNf
UkVDLCBOVUxMKSwgMCk7CisKIAlvcGVuX3RyZWVfZmQgPSBzeXNfb3Blbl90cmVlKC1FQkFE
RiwgIi9tbnQvQSIsCiAJCQkJICAgICBBVF9SRUNVUlNJVkUgfAogCQkJCSAgICAgQVRfRU1Q
VFlfUEFUSCB8CkBAIC0xNDMzLDYgKzE0NDAsOCBAQCBURVNUX0YobW91bnRfc2V0YXR0cl9p
ZG1hcHBlZCwgaWRtYXBfbW91bnRfdHJlZV9pbnZhbGlkKQogCUFTU0VSVF9FUShleHBlY3Rl
ZF91aWRfZ2lkKC1FQkFERiwgIi90bXAvQi9CQi9iIiwgMCwgMCwgMCksIDApOwogCUFTU0VS
VF9FUShleHBlY3RlZF91aWRfZ2lkKG9wZW5fdHJlZV9mZCwgIkIvYiIsIDAsIDAsIDApLCAw
KTsKIAlBU1NFUlRfRVEoZXhwZWN0ZWRfdWlkX2dpZChvcGVuX3RyZWVfZmQsICJCL0JCL2Ii
LCAwLCAwLCAwKSwgMCk7CisKKwkodm9pZCl1bW91bnQyKCIvbW50L0EiLCBNTlRfREVUQUNI
KTsKIH0KIAogVEVTVF9GKG1vdW50X3NldGF0dHIsIG1vdW50X2F0dHJfbm9zeW1mb2xsb3cp
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy93YXRjaGRvZy93YXRjaGRv
Zy10ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy93YXRjaGRvZy93YXRjaGRvZy10
ZXN0LmMKaW5kZXggYmM3MWNiY2EwZGRlLi5hMWY1MDZiYTU1NzggMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3dhdGNoZG9nL3dhdGNoZG9nLXRlc3QuYworKysgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy93YXRjaGRvZy93YXRjaGRvZy10ZXN0LmMKQEAgLTMz
NCw3ICszMzQsMTMgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAogCXBy
aW50ZigiV2F0Y2hkb2cgVGlja2luZyBBd2F5IVxuIik7CiAKKwkvKgorCSAqIFJlZ2lzdGVy
IHRoZSBzaWduYWxzCisJICovCiAJc2lnbmFsKFNJR0lOVCwgdGVybSk7CisJc2lnbmFsKFNJ
R1RFUk0sIHRlcm0pOworCXNpZ25hbChTSUdLSUxMLCB0ZXJtKTsKKwlzaWduYWwoU0lHUVVJ
VCwgdGVybSk7CiAKIAl3aGlsZSAoMSkgewogCQlrZWVwX2FsaXZlKCk7Cg==

--------------5MhXncmYMT4l0dO285lDHegg--


Return-Path: <linux-kselftest+bounces-33678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF112AC2AB8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 22:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE8F7A730D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 20:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058351F03D6;
	Fri, 23 May 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M9QAKWG4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015221A76D4
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748031160; cv=none; b=rYHTENw3b53Q2q9AwABBOtbM/s9c0MikmIX+RCEm1w0Cm9/AY1yppBrBNiermad+KfL+C/Y7K5oPcugaycthJMHelbUesSvO4zj5h/GPr9B8Kp3TZMzuYtTNBk/GKFfeytNQWPtQz6T9/XTGnDvwTSWWVkDDXSpAtlyJMJ/UF/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748031160; c=relaxed/simple;
	bh=IsUqT2Nbyf3bYo3O7Bc9+g5SjYq0TRbsUwXysH7Yzbg=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=WAEq40uIp9ajQdM7LrKaumNk5hCs/3T54UAFgxZcE4AOSX8IJqzzltlJla2LjyBc44eX6Nnxg/8jzCZvB3pPWMS2Mu4/b0wP4PuGt9QkHup3/6ngMGMDn+euNDWehP+X+Vfe3dAFDs6u3N/nJp2vfYoR9H8SROlwwH5B0WM27Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M9QAKWG4; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b3f92c866so5338539f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748031157; x=1748635957; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DjOoqkojd+z53Bm3NFkUBelI0e+mwFoE4RhggrBwi34=;
        b=M9QAKWG4eTxWdNxHbusPtT8lLwt5zgc/1UCFHprm5hWezYOoBFpsQBZ0MqYxLfet6M
         n8GLViJ4XilYAxcclhgm0r1ccRgUJYN/z5qt6+T2adkRcXimIXvVEZ+J8+duE1t7PMR/
         Q7h89rYAchohFtZdtF1xKW3dxqqh1fDRipQWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748031157; x=1748635957;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjOoqkojd+z53Bm3NFkUBelI0e+mwFoE4RhggrBwi34=;
        b=w5a2DNLxgq1P4Aa8As+PazwRVMym5f1SA+Sy+G8TzRSL8U45QHa1KtBq//f9Y4dfvb
         CbW0vEcaZmXsLSQ9E9xGi9g20HeM3Ex4IRSAFKoGEXlVBENUrYB+PjiK1auc/WssKEfU
         GAyVLPYb4TqlfOtHS3dfIZ1Ys75EpoPthKGgpT4d1N9A7h069s93Azf2DVvEh0njLlEc
         X1MrkaMpidmMgHbed3kyn+WIj4V1dtp7JLisIdTTVUpNXRK+7Lpf5Ctk+SEloUMgnLr/
         qJVxSH6Oma+UKf+cGP6AVFi/CtlJXeiV40l6Q5tvPpWcJFfa5saukTZXGJASAGVc930f
         /iWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnBdpJgZUTCn+VsczFhd1N2iHH95JT/p2EAiy5JKL0c31lgasIosRDAh0SoJlIjaafu/fu9kOjfJ+SAFeJSS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqOd9yEsulSghSnkQ0h4HW79KJ55Xu90uWxxD7HVkMuz2kXrF
	sK/X7ID+j0tqaO6wR1vMZe9a4ZdT12mNl5caN5jwyzwhrtSTtUotOSycdXg40R0AUVE=
X-Gm-Gg: ASbGnctzm8a08oFnTjd46DmyuY795hTfN70bK4Iq/H26dl+3ZLoiHx2MnXpt/Zk2FPX
	VNWYmVBSN6HTP3TWWB0SnJotxiWmNkcSgChG3+VbqeRx0t5uMW2vWC1/vDlOxM5ZKQ+2yPmLFe3
	Lmxyox29oCshHWsHX6uNJIsn/wFbIY9IoK56CXabZiI++kUDj9xlUsuj3OjHI88yCa2/DTeh5VP
	04rTogXLeWeU6dJyyUzwjqKa7jED1gQNjv1wYxixLjlSuQLzhDujWb6Bg4HjLC83FbgXEngnKUa
	5BvmfIpiH8y2tINfVsaQ0U597aGuD+psss0MwuPeTF2vfB7Jzzf1k+40Kr2I7Q==
X-Google-Smtp-Source: AGHT+IGD5AvT0ZCOslvtg8fYuY6R0TPW+HU2UzirdDn3KmI9L5iQGYs3+z46jDeQu48pX+2E3RsHcA==
X-Received: by 2002:a05:6602:29a8:b0:867:3670:5d49 with SMTP id ca18e2360f4ac-86cbb813cf3mr93541339f.7.1748031156908;
        Fri, 23 May 2025 13:12:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc38a2a1sm3764060173.14.2025.05.23.13.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 13:12:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------hdoGusMM000G5LVg2MWm0rHk"
Message-ID: <f7b637e0-76d4-4891-a39e-085c7beed403@linuxfoundation.org>
Date: Fri, 23 May 2025 14:12:35 -0600
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
Subject: [GIT PULL] Kselftest next update for Linux 6.16-rc1

This is a multi-part message in MIME format.
--------------hdoGusMM000G5LVg2MWm0rHk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following kselftest next update for Linux 6.16-rc1.

-- Fixes
    - cpufreq test to not double suspend in rtcwake case.
    - compile error in pid_namespace test.
    - run_kselftest.sh to use readlink if realpath is not available.
    - cpufreq basic read and update testcases.
    - ftrace to add poll to a gen_file so test can find it at run-time.
    - spelling errors in perf_events test.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.16-rc1

for you to fetch changes up to 1107dc4c5b06188a3fb4897ceb197eb320a52e85:

   selftests/run_kselftest.sh: Use readlink if realpath is not available (2025-05-15 16:52:47 -0600)

----------------------------------------------------------------
linux_kselftest-next-6.16-rc1

-- Fixes
    - cpufreq test to not double suspend in rtcwake case.
    - compile error in pid_namespace test.
    - run_kselftest.sh to use readlink if realpath is not available.
    - cpufreq basic read and update testcases.
    - ftrace to add poll to a gen_file so test can find it at run-time.
    - spelling errors in perf_events test.

----------------------------------------------------------------
Ayush Jain (1):
       selftests/ftrace: Convert poll to a gen_file

Colin Ian King (1):
       selftests/perf_events: Fix spelling mistake "sycnhronize" -> "synchronize"

Nícolas F. R. A. Prado (1):
       kselftest: cpufreq: Get rid of double suspend in rtcwake case

Peter Seiderer (1):
       selftests: pid_namespace: add missing sys/mount.h include in pid_max.c

Swapnil Sapkal (1):
       selftests/cpufreq: Fix cpufreq basic read and update testcases

Thomas Weißschuh (3):
       selftests/timens: Print TAP headers
       selftests/timens: Make run_tests() functions static
       selftests/timens: timerfd: Use correct clockid type in tclock_gettime()

Yosry Ahmed (1):
       selftests/run_kselftest.sh: Use readlink if realpath is not available

  tools/testing/selftests/cpufreq/cpufreq.sh             | 18 +++++++++++++-----
  tools/testing/selftests/ftrace/Makefile                |  2 +-
  tools/testing/selftests/perf_events/watermark_signal.c |  2 +-
  tools/testing/selftests/pid_namespace/pid_max.c        |  1 +
  tools/testing/selftests/run_kselftest.sh               |  9 ++++++++-
  tools/testing/selftests/timens/clock_nanosleep.c       |  4 +++-
  tools/testing/selftests/timens/exec.c                  |  2 ++
  tools/testing/selftests/timens/futex.c                 |  2 ++
  tools/testing/selftests/timens/gettime_perf.c          |  2 ++
  tools/testing/selftests/timens/procfs.c                |  2 ++
  tools/testing/selftests/timens/timens.c                |  2 ++
  tools/testing/selftests/timens/timer.c                 |  4 +++-
  tools/testing/selftests/timens/timerfd.c               |  6 ++++--
  tools/testing/selftests/timens/vfork_exec.c            |  2 ++
  14 files changed, 46 insertions(+), 12 deletions(-)
----------------------------------------------------------------
--------------hdoGusMM000G5LVg2MWm0rHk
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.16-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.16-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvY3B1ZnJlcS5z
aCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2NwdWZyZXEvY3B1ZnJlcS5zaAppbmRleCBl
MzUwYzUyMWI0NjcuLjk5MjdiNjU0ZmI4ZiAxMDA3NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvY3B1ZnJlcS9jcHVmcmVxLnNoCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2NwdWZyZXEvY3B1ZnJlcS5zaApAQCAtNTIsNyArNTIsMTQgQEAgcmVhZF9jcHVmcmVx
X2ZpbGVzX2luX2RpcigpCiAJZm9yIGZpbGUgaW4gJGZpbGVzOyBkbwogCQlpZiBbIC1mICQx
LyRmaWxlIF07IHRoZW4KIAkJCXByaW50ZiAiJGZpbGU6IgotCQkJY2F0ICQxLyRmaWxlCisJ
CQkjZmlsZSBpcyByZWFkYWJsZSA/CisJCQlsb2NhbCByZmlsZT0kKGxzIC1sICQxLyRmaWxl
IHwgYXdrICckMSB+IC9eLipyLiovIHsgcHJpbnQgJE5GOyB9JykKKworCQkJaWYgWyAhIC16
ICRyZmlsZSBdOyB0aGVuCisJCQkJY2F0ICQxLyRmaWxlCisJCQllbHNlCisJCQkJcHJpbnRm
ICIkZmlsZSBpcyBub3QgcmVhZGFibGVcbiIKKwkJCWZpCiAJCWVsc2UKIAkJCXByaW50ZiAi
XG4iCiAJCQlyZWFkX2NwdWZyZXFfZmlsZXNfaW5fZGlyICIkMS8kZmlsZSIKQEAgLTgzLDEw
ICs5MCwxMCBAQCB1cGRhdGVfY3B1ZnJlcV9maWxlc19pbl9kaXIoKQogCiAJZm9yIGZpbGUg
aW4gJGZpbGVzOyBkbwogCQlpZiBbIC1mICQxLyRmaWxlIF07IHRoZW4KLQkJCSMgZmlsZSBp
cyB3cml0YWJsZSA/Ci0JCQlsb2NhbCB3ZmlsZT0kKGxzIC1sICQxLyRmaWxlIHwgYXdrICck
MSB+IC9eLip3LiovIHsgcHJpbnQgJE5GOyB9JykKKwkJCSMgZmlsZSBpcyByZWFkYWJsZSBh
bmQgd3JpdGFibGUgPworCQkJbG9jYWwgcndmaWxlPSQobHMgLWwgJDEvJGZpbGUgfCBhd2sg
JyQxIH4gL14uKnJ3LiovIHsgcHJpbnQgJE5GOyB9JykKIAotCQkJaWYgWyAhIC16ICR3Zmls
ZSBdOyB0aGVuCisJCQlpZiBbICEgLXogJHJ3ZmlsZSBdOyB0aGVuCiAJCQkJIyBzY2FsaW5n
X3NldHNwZWVkIGlzIGEgc3BlY2lhbCBmaWxlIGFuZCB3ZQogCQkJCSMgc2hvdWxkIHNraXAg
dXBkYXRpbmcgaXQKIAkJCQlpZiBbICRmaWxlICE9ICJzY2FsaW5nX3NldHNwZWVkIiBdOyB0
aGVuCkBAIC0yNDQsOSArMjUxLDEwIEBAIGRvX3N1c3BlbmQoKQogCQkJCQlwcmludGYgIkZh
aWxlZCB0byBzdXNwZW5kIHVzaW5nIFJUQyB3YWtlIGFsYXJtXG4iCiAJCQkJCXJldHVybiAx
CiAJCQkJZmkKKwkJCWVsc2UKKwkJCQllY2hvICRmaWxlbmFtZSA+ICRTWVNGUy9wb3dlci9z
dGF0ZQogCQkJZmkKIAotCQkJZWNobyAkZmlsZW5hbWUgPiAkU1lTRlMvcG93ZXIvc3RhdGUK
IAkJCXByaW50ZiAiQ2FtZSBvdXQgb2YgJDFcbiIKIAogCQkJcHJpbnRmICJEbyBiYXNpYyB0
ZXN0cyBhZnRlciBmaW5pc2hpbmcgJDEgdG8gdmVyaWZ5IGNwdWZyZXEgc3RhdGVcblxuIgpk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL01ha2VmaWxlIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL01ha2VmaWxlCmluZGV4IDQ5ZDk2YmIx
NjM1NS4uN2MxMjI2M2Y4MjYwIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvTWFrZWZpbGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L01ha2VmaWxlCkBAIC02LDYgKzYsNiBAQCBURVNUX1BST0dTIDo9IGZ0cmFjZXRlc3Qta3Rh
cAogVEVTVF9GSUxFUyA6PSB0ZXN0LmQgc2V0dGluZ3MKIEVYVFJBX0NMRUFOIDo9ICQoT1VU
UFVUKS9sb2dzLyoKIAotVEVTVF9HRU5fUFJPR1MgPSBwb2xsCitURVNUX0dFTl9GSUxFUyA6
PSBwb2xsCiAKIGluY2x1ZGUgLi4vbGliLm1rCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9wZXJmX2V2ZW50cy93YXRlcm1hcmtfc2lnbmFsLmMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9wZXJmX2V2ZW50cy93YXRlcm1hcmtfc2lnbmFsLmMKaW5kZXggNDlk
YzFlODMxMTc0Li5lMDNmZTFiOWJiYTIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3BlcmZfZXZlbnRzL3dhdGVybWFya19zaWduYWwuYworKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9wZXJmX2V2ZW50cy93YXRlcm1hcmtfc2lnbmFsLmMKQEAgLTc1LDcg
Kzc1LDcgQEAgVEVTVCh3YXRlcm1hcmtfc2lnbmFsKQogCWlmICh3YWl0cGlkKGNoaWxkLCAm
Y2hpbGRfc3RhdHVzLCBXU1RPUFBFRCkgIT0gY2hpbGQgfHwKIAkgICAgIShXSUZTVE9QUEVE
KGNoaWxkX3N0YXR1cykgJiYgV1NUT1BTSUcoY2hpbGRfc3RhdHVzKSA9PSBTSUdTVE9QKSkg
ewogCQlmcHJpbnRmKHN0ZGVyciwKLQkJCSJmYWlsZWQgdG8gc3ljbmhyb25pemUgd2l0aCBj
aGlsZCBlcnJubz0lZCBzdGF0dXM9JXhcbiIsCisJCQkiZmFpbGVkIHRvIHN5bmNocm9uaXpl
IHdpdGggY2hpbGQgZXJybm89JWQgc3RhdHVzPSV4XG4iLAogCQkJZXJybm8sCiAJCQljaGls
ZF9zdGF0dXMpOwogCQlnb3RvIGNsZWFudXA7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9waWRfbmFtZXNwYWNlL3BpZF9tYXguYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3BpZF9uYW1lc3BhY2UvcGlkX21heC5jCmluZGV4IDUxYzQxNGZhYWJiMC4uOTZm
Mjc0ZjA1ODJiIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRfbmFt
ZXNwYWNlL3BpZF9tYXguYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9waWRfbmFt
ZXNwYWNlL3BpZF9tYXguYwpAQCAtMTAsNiArMTAsNyBAQAogI2luY2x1ZGUgPHN0ZGxpYi5o
PgogI2luY2x1ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPHN5c2NhbGwuaD4KKyNpbmNsdWRl
IDxzeXMvbW91bnQuaD4KICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogCiAjaW5jbHVkZSAiLi4v
a3NlbGZ0ZXN0X2hhcm5lc3MuaCIKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3J1bl9rc2VsZnRlc3Quc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydW5fa3Nl
bGZ0ZXN0LnNoCmluZGV4IDUwZTAzZWVmZTdhYy4uMDQ0M2JlYWNmMzYyIDEwMDc1NQotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ydW5fa3NlbGZ0ZXN0LnNoCisrKyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3J1bl9rc2VsZnRlc3Quc2gKQEAgLTMsNyArMywxNCBAQAog
IwogIyBSdW4gaW5zdGFsbGVkIGtzZWxmdGVzdCB0ZXN0cy4KICMKLUJBU0VfRElSPSQocmVh
bHBhdGggJChkaXJuYW1lICQwKSkKKworIyBGYWxsYmFjayB0byByZWFkbGluayBpZiByZWFs
cGF0aCBpcyBub3QgYXZhaWxhYmxlCitpZiB3aGljaCByZWFscGF0aCA+IC9kZXYvbnVsbDsg
dGhlbgorICAgICAgICBCQVNFX0RJUj0kKHJlYWxwYXRoICQoZGlybmFtZSAkMCkpCitlbHNl
CisgICAgICAgIEJBU0VfRElSPSQocmVhZGxpbmsgLWYgJChkaXJuYW1lICQwKSkKK2ZpCisK
IGNkICRCQVNFX0RJUgogVEVTVFM9IiRCQVNFX0RJUiIva3NlbGZ0ZXN0LWxpc3QudHh0CiBp
ZiBbICEgLXIgIiRURVNUUyIgXSA7IHRoZW4KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3RpbWVucy9jbG9ja19uYW5vc2xlZXAuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3RpbWVucy9jbG9ja19uYW5vc2xlZXAuYwppbmRleCA3MmQ0MWI5NTVmYjIuLjVj
YzAwMTBlODVmZiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5z
L2Nsb2NrX25hbm9zbGVlcC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVu
cy9jbG9ja19uYW5vc2xlZXAuYwpAQCAtMzgsNyArMzgsNyBAQCB2b2lkICpjYWxsX25hbm9z
bGVlcCh2b2lkICpfYXJncykKIAlyZXR1cm4gTlVMTDsKIH0KIAotaW50IHJ1bl90ZXN0KGlu
dCBjbG9ja2lkLCBpbnQgYWJzKQorc3RhdGljIGludCBydW5fdGVzdChpbnQgY2xvY2tpZCwg
aW50IGFicykKIHsKIAlzdHJ1Y3QgdGltZXNwZWMgbm93ID0ge30sIHJlbTsKIAlzdHJ1Y3Qg
dGhyZWFkX2FyZ3MgYXJncyA9IHsgLm5vdyA9ICZub3csIC5yZW0gPSAmcmVtLCAuY2xvY2tp
ZCA9IGNsb2NraWR9OwpAQCAtMTE1LDYgKzExNSw4IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICphcmd2W10pCiB7CiAJaW50IHJldCwgbnNmZDsKIAorCWtzZnRfcHJpbnRfaGVhZGVy
KCk7CisKIAluc2NoZWNrKCk7CiAKIAlrc2Z0X3NldF9wbGFuKDQpOwpkaWZmIC0tZ2l0IGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL2V4ZWMuYyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3RpbWVucy9leGVjLmMKaW5kZXggZDEyZmY5NTVkZTBkLi5hNjQ0MTYyZDU2
ZmQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy9leGVjLmMK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL2V4ZWMuYwpAQCAtMzYsNiAr
MzYsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQlyZXR1cm4gMDsK
IAl9CiAKKwlrc2Z0X3ByaW50X2hlYWRlcigpOworCiAJbnNjaGVjaygpOwogCiAJa3NmdF9z
ZXRfcGxhbigxKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVu
cy9mdXRleC5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL2Z1dGV4LmMKaW5k
ZXggNmIyYjkyNjRlODUxLi4zMzk2MzNhZTAzN2EgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3RpbWVucy9mdXRleC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RpbWVucy9mdXRleC5jCkBAIC02Niw2ICs2Niw4IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICphcmd2W10pCiAJcGlkX3QgcGlkOwogCXN0cnVjdCB0aW1lc3BlYyBtdGltZV9u
b3c7CiAKKwlrc2Z0X3ByaW50X2hlYWRlcigpOworCiAJbnNjaGVjaygpOwogCiAJa3NmdF9z
ZXRfcGxhbigyKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVu
cy9nZXR0aW1lX3BlcmYuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy9nZXR0
aW1lX3BlcmYuYwppbmRleCA2YjEzZGMyNzc3MjQuLmQ2NjU4YjdiNzU0OCAxMDA2NDQKLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL2dldHRpbWVfcGVyZi5jCisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy9nZXR0aW1lX3BlcmYuYwpAQCAtNjcs
NiArNjcsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCXRpbWVfdCBv
ZmZzZXQgPSAxMDsKIAlpbnQgbnNmZDsKIAorCWtzZnRfcHJpbnRfaGVhZGVyKCk7CisKIAlr
c2Z0X3NldF9wbGFuKDgpOwogCiAJZmlsbF9mdW5jdGlvbl9wb2ludGVycygpOwpkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3Byb2Nmcy5jIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3Byb2Nmcy5jCmluZGV4IDE4MzNjYTk3ZWIyNC4u
MGE5ZmY5MGVlNjlhIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1l
bnMvcHJvY2ZzLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3Byb2Nm
cy5jCkBAIC0xODAsNiArMTgwLDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKIHsKIAlpbnQgcmV0ID0gMDsKIAorCWtzZnRfcHJpbnRfaGVhZGVyKCk7CisKIAluc2No
ZWNrKCk7CiAKIAlrc2Z0X3NldF9wbGFuKDIpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdGltZW5zL3RpbWVucy5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
dGltZW5zL3RpbWVucy5jCmluZGV4IDM4NzIyMDc5MWEwNS4uYTljMDUzNGVmOGY2IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lbnMvdGltZW5zLmMKKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3RpbWVucy5jCkBAIC0xNTEsNiArMTUx
LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAl0aW1lX3Qgb2Zmc2V0
OwogCWludCByZXQgPSAwOwogCisJa3NmdF9wcmludF9oZWFkZXIoKTsKKwogCW5zY2hlY2so
KTsKIAogCWNoZWNrX3N1cHBvcnRlZF90aW1lcnMoKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3RpbWVucy90aW1lci5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdGltZW5zL3RpbWVyLmMKaW5kZXggNWI5MzlmNTlkZmE0Li43OTU0M2NlYjJjMGYgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy90aW1lci5jCisrKyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy90aW1lci5jCkBAIC0xNSw3ICsxNSw3
IEBACiAjaW5jbHVkZSAibG9nLmgiCiAjaW5jbHVkZSAidGltZW5zLmgiCiAKLWludCBydW5f
dGVzdChpbnQgY2xvY2tpZCwgc3RydWN0IHRpbWVzcGVjIG5vdykKK3N0YXRpYyBpbnQgcnVu
X3Rlc3QoaW50IGNsb2NraWQsIHN0cnVjdCB0aW1lc3BlYyBub3cpCiB7CiAJc3RydWN0IGl0
aW1lcnNwZWMgbmV3X3ZhbHVlOwogCWxvbmcgbG9uZyBlbGFwc2VkOwpAQCAtNzUsNiArNzUs
OCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCXBpZF90IHBpZDsKIAlz
dHJ1Y3QgdGltZXNwZWMgYnRpbWVfbm93LCBtdGltZV9ub3c7CiAKKwlrc2Z0X3ByaW50X2hl
YWRlcigpOworCiAJbnNjaGVjaygpOwogCiAJY2hlY2tfc3VwcG9ydGVkX3RpbWVycygpOwpk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3RpbWVyZmQuYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy90aW1lcmZkLmMKaW5kZXggYTQxOTZi
YmQ2ZTMzLi40MDJlMmU0MTU1NDUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RpbWVucy90aW1lcmZkLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGlt
ZW5zL3RpbWVyZmQuYwpAQCAtMTUsMTQgKzE1LDE0IEBACiAjaW5jbHVkZSAibG9nLmgiCiAj
aW5jbHVkZSAidGltZW5zLmgiCiAKLXN0YXRpYyBpbnQgdGNsb2NrX2dldHRpbWUoY2xvY2tf
dCBjbG9ja2lkLCBzdHJ1Y3QgdGltZXNwZWMgKm5vdykKK3N0YXRpYyBpbnQgdGNsb2NrX2dl
dHRpbWUoY2xvY2tpZF90IGNsb2NraWQsIHN0cnVjdCB0aW1lc3BlYyAqbm93KQogewogCWlm
IChjbG9ja2lkID09IENMT0NLX0JPT1RUSU1FX0FMQVJNKQogCQljbG9ja2lkID0gQ0xPQ0tf
Qk9PVFRJTUU7CiAJcmV0dXJuIGNsb2NrX2dldHRpbWUoY2xvY2tpZCwgbm93KTsKIH0KIAot
aW50IHJ1bl90ZXN0KGludCBjbG9ja2lkLCBzdHJ1Y3QgdGltZXNwZWMgbm93KQorc3RhdGlj
IGludCBydW5fdGVzdChpbnQgY2xvY2tpZCwgc3RydWN0IHRpbWVzcGVjIG5vdykKIHsKIAlz
dHJ1Y3QgaXRpbWVyc3BlYyBuZXdfdmFsdWU7CiAJbG9uZyBsb25nIGVsYXBzZWQ7CkBAIC04
Miw2ICs4Miw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJcGlkX3Qg
cGlkOwogCXN0cnVjdCB0aW1lc3BlYyBidGltZV9ub3csIG10aW1lX25vdzsKIAorCWtzZnRf
cHJpbnRfaGVhZGVyKCk7CisKIAluc2NoZWNrKCk7CiAKIAljaGVja19zdXBwb3J0ZWRfdGlt
ZXJzKCk7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lbnMvdmZv
cmtfZXhlYy5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3Zmb3JrX2V4ZWMu
YwppbmRleCA1Yjg5MDdiZjQ1MWQuLmI5NTdlMWE2NTEyNCAxMDA2NDQKLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3Zmb3JrX2V4ZWMuYworKysgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy90aW1lbnMvdmZvcmtfZXhlYy5jCkBAIC05MSw2ICs5MSw4IEBAIGlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJCXJldHVybiBjaGVjaygiY2hpbGQg
YWZ0ZXIgZXhlYyIsICZub3cpOwogCX0KIAorCWtzZnRfcHJpbnRfaGVhZGVyKCk7CisKIAlu
c2NoZWNrKCk7CiAKIAlrc2Z0X3NldF9wbGFuKDQpOwo=

--------------hdoGusMM000G5LVg2MWm0rHk--


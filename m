Return-Path: <linux-kselftest+bounces-26471-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2241DA3286E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DC33A81C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEC0210186;
	Wed, 12 Feb 2025 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHli5STF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1958C20FAB6
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370568; cv=none; b=iCnPgNEST5BTWTED6q1s9Ars1+BMSMSk38XaND/6spEyZlytGy8MCnPgEV21Fm3U5vZKsERHe79RW2OUck60jaCyPZoZQB4ZmNClnMZwIArwLRCC3aoAbxTAqsDPZpkf17BlhHXucd1VWBTkYf/r/BU0QdnUtI98gl0NktvNpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370568; c=relaxed/simple;
	bh=OPY/ttXempJru6Ga1RV4xoldFBk00fifGauRa8nVjwg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DMHbFnAT+q9y6kpeJzAAJm0evgYWAT7oEHpUzhLj3GYuZ92/g8FB/9Qa6TwPBO+6U3PwDCVWCgLv+G+AT6yF7yo7WoglNJWmB6bmmSZszQrFkbxmAIxiQE9rPRT9NYOTAuAx1RKj2ksr3Vt8rE5IokNlGTcyTiS/Xe1STgO87nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHli5STF; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-866eb01bde9so4165627241.0
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Feb 2025 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739370566; x=1739975366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQXDe8fhhmSLuPbo2aVFP4x2A1nmLJfbRBStCyLpsCw=;
        b=CHli5STFJNzAG2/RW+n9/8Hl40lXOJjNfT5uv+uL/QGGOz4JZENKVifvFz0DVricqU
         avexO/hXOnQI8WO/zyP6qPVByJPlyUlR51dh3L4BUcg2at14QuWwswMnQCC8gjOb6mY/
         a198v1UxAcCHRQaRwusUcNDPOQyME8gHl+rPHTAsp6NvYDX8EaMkmkDLSdKYngyLcRXJ
         tl2Ncs8viO4F44JZCJ14HcugNKPhJLOVdHUYe4tejq2hTVxhXBrzNEJZfJdBR6HqQ13Q
         J0lhzrpJpX/tKWkwUsq+Cav8vnmQNEpQmk3KuR/cIiyk+GizodeUBRQjvO2FJvfAP2VF
         RJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370566; x=1739975366;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQXDe8fhhmSLuPbo2aVFP4x2A1nmLJfbRBStCyLpsCw=;
        b=Jadb0HSDzq3WzDgld7cluXTznV3VGWR0vyXfcljtNRFnvfha3hnv/87tNdHzRSneOi
         ypwt/2IH6Nxg3QqwYbozNK+ZEfBsVcCWIjAyOGf5UTSXkB+aG9/MRbw1XNsFmkyl8r3+
         elVw56IHStHaNmAcjTlgTy73nbuYmoy3RnchmgZCeN3Qi2Vuu2HHPHKuuy08jGqoi3pp
         6A/GRaPHpjherkBaI1TT6/P46FW28lB97ayRN5eVBbR6vtCnsgNdOaEWPeoUawFAXQBX
         uf9YHT+phZVhSqw9NnZ3JsK8MPGyTlTon27DuvsK9Q11wItkq8Q2n4Olc5sj84qG4YVI
         GnYg==
X-Forwarded-Encrypted: i=1; AJvYcCVmTPNL97J7cRHF8vVOQyTJiCQq7fMIJ9cmQCOA7p6ZzzVBxHNh+9z6WbNiGzVo1I9NP3Nbnjf7qbL4g4tVGd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXArtDHmzCZ5qs1/M6V5m7P49oQhjxD51OwEzgaFknDyEdDv+
	uKs3TAE31FMeVEQ2hlse7ZU9HjhuYUR6rW90YssWaNgl9ExH+qGasCk8zQ98+vSVjsMujx7Q7/w
	ly6ZLt5XTrI/yu8W8co5L2GcWdIPGuIot2/xkhA==
X-Gm-Gg: ASbGncvLUmBe58Jyn2L4JKKvFTldDfW0hv5/kQSCziECK4Kd5RMQLxYPhmQuhXRpIsM
	jwOboYRfQQGeBbfZUZfq1UMr/08WWD4EZQ69nBiITyyCYXovKm9HhxAJ3L++NUPKT7sYS9R7TvC
	A=
X-Google-Smtp-Source: AGHT+IG4n0xqcfXhx3NvshSoCQo+PEUb+p7MDHm4sjc30wvs2Pt/IPzEMlAVsG0PTmhHo4D+KJWvgxKySnM4I46+mqM=
X-Received: by 2002:a05:6122:16a2:b0:520:6773:e5ba with SMTP id
 71dfb90a1353d-52067b2abdemr3019034e0c.2.1739370565848; Wed, 12 Feb 2025
 06:29:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Feb 2025 19:59:14 +0530
X-Gm-Features: AWEUYZkKLpdZkyHVsSB2BWfSoOZsdInFc-eqp2yhtj3-lDliB8rWq5u4wrqEWBc
Message-ID: <CA+G9fYuw3XJ3NcYGHT=Jt9mQP_si49GQNEa6sSNLeqDm9A6+Cw@mail.gmail.com>
Subject: selftest/vDSO: vdso_test_abi tests with gcc-13 and pass with clang-19
To: clang-built-linux <llvm@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b60a9b062df2c4e6"

--000000000000b60a9b062df2c4e6
Content-Type: text/plain; charset="UTF-8"

The kselftest-vDSO/vdso_test_abi test encounters failures when built
and executed using GCC-13 on armv7 architecture.
The issue has been observed on both TI X15 devices and QEMU-armv7.

Interestingly, the same test passes without any issues when built using
Clang-19.This failure is specific to GCC-13. but test case should have
been failed on clang toolchain but it did not.

The Clang toolchain likely defaults to the traditional 32-bit time_t on
32-bit Debian Trixie (except x86), leading to an ABI issue similar to
older compilers. This is affecting compatibility.

This is not a new regression,
this report generated on Linux next but also seen on Linux stable tree.

Test name: kselftest-vDSO/vdso_test_abi
Fails: gcc-13
pass: clang-19

Arnd Bergmann investigated and proposed a patch which fixes the problem.

Test regression: selftest-vDSO/vdso_test_abi:

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

# selftests: vDSO: vdso_test_abi
# TAP version 13
# 1..16
# # [vDSO kselftest] VDSO_VERSION: LINUX_2.6
# # The time is 184285885525887.-5268386858514840748
# ok 1 __vdso_gettimeofday
# # clock_id: CLOCK_REALTIME
# # The time is 184287230099877759.-1225334784
# ok 2 __vdso_clock_gettime CLOCK_REALTIME
# # The vdso resolution is 4294967296 -1225335584
# # The syscall resolution is 4294967296 -1225334784
# not ok 3 __vdso_clock_getres CLOCK_REALTIME
# # clock_id: CLOCK_BOOTTIME
# # The time is 3253049749439251215.-1225334784
# ok 4 __vdso_clock_gettime CLOCK_BOOTTIME
# # The vdso resolution is 4294967296 -1225335584
# # The syscall resolution is 4294967296 -1225334784
# not ok 5 __vdso_clock_getres CLOCK_BOOTTIME
# # clock_id: CLOCK_TAI
# # The time is 184549377723756415.-1225334784
# ok 6 __vdso_clock_gettime CLOCK_TAI
# # The vdso resolution is 4294967296 -1225335584
# # The syscall resolution is 4294967296 -1225334784
# not ok 7 __vdso_clock_getres CLOCK_TAI
# # clock_id: CLOCK_REALTIME_COARSE
# # The time is 128974845965660031.-1225334784
# ok 8 __vdso_clock_gettime CLOCK_REALTIME_COARSE
# # The vdso resolution is 42949672960000000 -1225335584
# # The syscall resolution is 42949672960000000 -1225334784
# not ok 9 __vdso_clock_getres CLOCK_REALTIME_COARSE
# # clock_id: CLOCK_MONOTONIC
# # The time is 3253311892768162575.-1225334784
# ok 10 __vdso_clock_gettime CLOCK_MONOTONIC
# # The vdso resolution is 4294967296 -1225335584
# # The syscall resolution is 4294967296 -1225334784
# not ok 11 __vdso_clock_getres CLOCK_MONOTONIC
# # clock_id: CLOCK_MONOTONIC_RAW
# # The time is 3253442966580101903.-1225334784
# ok 12 __vdso_clock_gettime CLOCK_MONOTONIC_RAW
# # The vdso resolution is 4294967296 -1225335584
# # The syscall resolution is 4294967296 -1225334784
# not ok 13 __vdso_clock_getres CLOCK_MONOTONIC_RAW
# # clock_id: CLOCK_MONOTONIC_COARSE
# # The time is 3197606291493094159.-1225334784
# ok 14 __vdso_clock_gettime CLOCK_MONOTONIC_COARSE
# # The vdso resolution is 42949672960000000 -1225335584
# # The syscall resolution is 42949672960000000 -1225334784
# not ok 15 __vdso_clock_getres CLOCK_MONOTONIC_COARSE
# # Couldn't find __vdso_time
# ok 16 # SKIP __vdso_time
# # 1 skipped test(s) detected. Consider enabling relevant config
options to improve coverage.
# # Totals: pass:8 fail:7 xfail:0 xpass:0 skip:1 error:0
not ok 3 selftests: vDSO: vdso_test_abi # exit=1

## Build
* test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241126/testrun/26062838/suite/kselftest-vDSO/test/vDSO_vdso_test_abi/log
* TI x15 test log:
https://lkft.validation.linaro.org/scheduler/job/8117196#L7091
* build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2spp0E2mMNQq16RHsbzLSFAlxuM/

## Source
* git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
* git sha: df5d6180169ae06a2eac57e33b077ad6f6252440 (this not new issue)
* architectures: armv7
* toolchain: gcc-13 (13.3.0) - failed
* toolchain: clang ( version: 19.1.7) - pass
* devices: Armv7 TI beaglebone, qemu-armv7

--
Linaro LKFT
https://lkft.linaro.org

--000000000000b60a9b062df2c4e6
Content-Type: application/x-patch; 
	name="0001-selftests-vdso-debug-vdso_test_abi-__kernel_old_time.patch"
Content-Disposition: attachment; 
	filename="0001-selftests-vdso-debug-vdso_test_abi-__kernel_old_time.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m6z27dxf0>
X-Attachment-Id: f_m6z27dxf0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0X2FiaS5j
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3Rlc3RfYWJpLmMKaW5kZXggYTU0
NDI0ZTIzMzZmNC4uMjU3NzhhN2Y4NDljZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdkRTTy92ZHNvX3Rlc3RfYWJpLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
dkRTTy92ZHNvX3Rlc3RfYWJpLmMKQEAgLTE3LDYgKzE3LDcgQEAKICNkZWZpbmUgX0dOVV9TT1VS
Q0UKICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgorI2luY2x1
ZGUgPGxpbnV4L3RpbWVfdHlwZXMuaD4KIAogI2luY2x1ZGUgIi4uL2tzZWxmdGVzdC5oIgogI2lu
Y2x1ZGUgInZkc29fY29uZmlnLmgiCkBAIC0yNiw5ICsyNyw5IEBACiBzdGF0aWMgY29uc3QgY2hh
ciAqdmVyc2lvbjsKIHN0YXRpYyBjb25zdCBjaGFyICoqbmFtZTsKIAotdHlwZWRlZiBsb25nICgq
dmRzb19nZXR0aW1lb2ZkYXlfdCkoc3RydWN0IHRpbWV2YWwgKnR2LCBzdHJ1Y3QgdGltZXpvbmUg
KnR6KTsKLXR5cGVkZWYgbG9uZyAoKnZkc29fY2xvY2tfZ2V0dGltZV90KShjbG9ja2lkX3QgY2xr
X2lkLCBzdHJ1Y3QgdGltZXNwZWMgKnRzKTsKLXR5cGVkZWYgbG9uZyAoKnZkc29fY2xvY2tfZ2V0
cmVzX3QpKGNsb2NraWRfdCBjbGtfaWQsIHN0cnVjdCB0aW1lc3BlYyAqdHMpOwordHlwZWRlZiBs
b25nICgqdmRzb19nZXR0aW1lb2ZkYXlfdCkoc3RydWN0IF9fa2VybmVsX29sZF90aW1ldmFsICp0
diwgc3RydWN0IHRpbWV6b25lICp0eik7Cit0eXBlZGVmIGxvbmcgKCp2ZHNvX2Nsb2NrX2dldHRp
bWVfdCkoY2xvY2tpZF90IGNsa19pZCwgc3RydWN0IF9fa2VybmVsX29sZF90aW1lc3BlYyAqdHMp
OwordHlwZWRlZiBsb25nICgqdmRzb19jbG9ja19nZXRyZXNfdCkoY2xvY2tpZF90IGNsa19pZCwg
c3RydWN0IF9fa2VybmVsX29sZF90aW1lc3BlYyAqdHMpOwogdHlwZWRlZiB0aW1lX3QgKCp2ZHNv
X3RpbWVfdCkodGltZV90ICp0KTsKIAogY29uc3QgY2hhciAqdmRzb19jbG9ja19uYW1lWzEyXSA9
IHsKQEAgLTgzLDcgKzg0LDcgQEAgc3RhdGljIHZvaWQgdmRzb190ZXN0X2Nsb2NrX2dldHRpbWUo
Y2xvY2tpZF90IGNsa19pZCkKIAkJcmV0dXJuOwogCX0KIAotCXN0cnVjdCB0aW1lc3BlYyB0czsK
KwlzdHJ1Y3QgX19rZXJuZWxfb2xkX3RpbWVzcGVjIHRzOwogCWxvbmcgcmV0ID0gVkRTT19DQUxM
KHZkc29fY2xvY2tfZ2V0dGltZSwgMiwgY2xrX2lkLCAmdHMpOwogCiAJaWYgKHJldCA9PSAwKSB7
CkBAIC0xMzUsNyArMTM2LDcgQEAgc3RhdGljIHZvaWQgdmRzb190ZXN0X2Nsb2NrX2dldHJlcyhj
bG9ja2lkX3QgY2xrX2lkKQogCQlyZXR1cm47CiAJfQogCi0Jc3RydWN0IHRpbWVzcGVjIHRzLCBz
eXNfdHM7CisJc3RydWN0IF9fa2VybmVsX29sZF90aW1lc3BlYyB0cywgc3lzX3RzOwogCWxvbmcg
cmV0ID0gVkRTT19DQUxMKHZkc29fY2xvY2tfZ2V0cmVzLCAyLCBjbGtfaWQsICZ0cyk7CiAKIAlp
ZiAocmV0ID09IDApIHsKLS0gCjIuNDMuMAoK
--000000000000b60a9b062df2c4e6--


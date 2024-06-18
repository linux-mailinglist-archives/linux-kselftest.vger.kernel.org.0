Return-Path: <linux-kselftest+bounces-12166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4160D90DAD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8611F23302
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3D13F003;
	Tue, 18 Jun 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGA6nXUm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE813F00A
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732567; cv=none; b=UD5fjuH93b2o6RVVW1ys7wYlec1AO7sHitLWQouDkSZxr8WBUciUJdZ95l85maz9mIhgrBub+T5/bkZIpHl8bQbQVYPER1VvwLHU3OjlSOnrmaNc+YgyMPf295Dg858gQHuSUv2zCDcva+s2q6XAwfM+ndvLBCkcIyi0BoOxVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732567; c=relaxed/simple;
	bh=+KXHaWJRWeE9SvAOhI7bkcjwVi5BF70oFRcy1jR3idk=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=op6u5v8edm5fjo9lHLTnYz6p0aByKUHOwtu/xtt0ZHWAlWOOCLWual0AKmm3Z/0591gnN0PSpBjs52L1ZtsV67bTcY26haOPa7JmJZafxQeMsyzaQR1uzQmMOSnP7Sq0i1/Up7qVeRSxpyc5wj5XhmsNlpHagFisHkefywocSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGA6nXUm; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-375858224b8so3100065ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718732564; x=1719337364; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k4kuU5u9SGuQEygwCjUeiFjjBzMumH1fP75ahMq3wIQ=;
        b=cGA6nXUmooQoWHinl1fni5opQsfYufi2e8JaIIx6jb3GN3xHVTd7tboNLcPNJebX3V
         YAafZIyruR3Qa2VXX+anACJe7jLHufn+/BvmpLGroGhm30ZSiFHPhbVQ2oSpf1ZEOxGp
         ULxGJlfV2BoG7Q3IUiLbJnj0dukgS2dyxPVZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718732564; x=1719337364;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4kuU5u9SGuQEygwCjUeiFjjBzMumH1fP75ahMq3wIQ=;
        b=mhtzakK76Xmja4iuz6gykVwuUFNzo/hJ0DgJZFYnz52VI5UNAr/RnZ5DPtBqQpO9Iw
         2RWHGc7C1NWgBA0EGsRX4aP91v5I8PxI5XtUnGAE84UzqzxGn/vxsPhw7waurBlOysy+
         K+ICS+/eTmsmxGqjjFedsBQIjjv5Atl8mdTlYyX7EE6gWH0xko0ok+KLIyibNJwymS8T
         Qr5aW3z/v2onv4QvV+sTubsgwZ6gPVoAWMOxYOKAl48yAYbfuZvmNxnjoT14Dwo79AEv
         eGmtEDTO084u8moD4F44Jr7Ihf37dXWr81gSxj30rC7W+lRkABPdzAOlzcFdT8jj8d/L
         IXRg==
X-Forwarded-Encrypted: i=1; AJvYcCU5AAw8+YC363ow9+KUocd5D5jnp+mRGRAFedEU6jblBfRWmsQbS7Al+EZKEAYpwtGhKTxxjnbL/g17Ac5YqyIf3GhbOvUeVBm2FitsL6g/
X-Gm-Message-State: AOJu0YxFdxLYxutle/MO2kHQfSNxTRKnUj7C6moTDnoanOmckTDCCAkd
	6XIh5FotbXoirf2AMGGR/EqDr8Pd1Ra37rsB8N2N3QaG1yWTfSIFLl3h3SGBTo4biYqL7WcHk9g
	Z
X-Google-Smtp-Source: AGHT+IF7G4RmejRcO1xloqnVQ5ZeUGAmm9vPWOpgZXO47kbtYs4Jf3cx0KK1+808T1dcENznmujtAw==
X-Received: by 2002:a05:6602:1d57:b0:7eb:ea26:3471 with SMTP id ca18e2360f4ac-7f13ee6c867mr56834239f.2.1718732564389;
        Tue, 18 Jun 2024 10:42:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a20bc6sm3301638173.123.2024.06.18.10.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 10:42:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Fnxyrn8oxAwDvUk22LM0pFdd"
Message-ID: <772723d8-a7bb-4053-be40-b00680b518bf@linuxfoundation.org>
Date: Tue, 18 Jun 2024 11:42:42 -0600
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 6.10-rc5

This is a multi-part message in MIME format.
--------------Fnxyrn8oxAwDvUk22LM0pFdd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest fixes update for Linux 6.10-rc5.

This kselftest fixes update consists of 4 fixes to the following
build warnings:

- filesystems: warn_unused_result warnings
- seccomp: format-zero-length warnings
- fchmodat2: clang build warnings due to-static-libasan
- openat2: clang build warnings due to static-libasan, LOCAL_HDRS

diff for pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4bf15b1c657d22d1d70173e43264e4606dfe75ff:

   selftests/futex: don't pass a const char* to asprintf(3) (2024-05-31 14:37:10 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc5

for you to fetch changes up to ed3994ac847e0d6605f248e7f6776b1d4f445f4b:

   selftests/fchmodat2: fix clang build failure due to -static-libasan (2024-06-11 15:05:05 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.10-rc5

This kselftest fixes update consists of 4 fixes to the following
build warnings:

- filesystems: warn_unused_result warnings
- seccomp: format-zero-length warnings
- fchmodat2: clang build warnings due to-static-libasan
- openat2: clang build warnings due to static-libasan, LOCAL_HDRS

----------------------------------------------------------------
Amer Al Shanawany (2):
       selftests: filesystems: fix warn_unused_result build warnings
       selftests: seccomp: fix format-zero-length warnings

John Hubbard (2):
       selftests/openat2: fix clang build failures: -static-libasan, LOCAL_HDRS
       selftests/fchmodat2: fix clang build failure due to -static-libasan

  tools/testing/selftests/fchmodat2/Makefile                 | 11 ++++++++++-
  .../selftests/filesystems/statmount/statmount_test.c       | 12 ++++++++++--
  tools/testing/selftests/openat2/Makefile                   | 14 ++++++++++++--
  tools/testing/selftests/seccomp/seccomp_benchmark.c        |  6 +++---
  4 files changed, 35 insertions(+), 8 deletions(-)
----------------------------------------------------------------
--------------Fnxyrn8oxAwDvUk22LM0pFdd
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.10-rc5.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.10-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZjaG1vZGF0Mi9NYWtlZmls
ZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZjaG1vZGF0Mi9NYWtlZmlsZQppbmRleCA3
MWVjMzRiZjE1MDEuLjQzNzNjZWE3OWI3OSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvZmNobW9kYXQyL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2ZjaG1vZGF0Mi9NYWtlZmlsZQpAQCAtMSw2ICsxLDE1IEBACiAjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAKLUNGTEFHUyArPSAtV2FsbCAtTzIg
LWcgLWZzYW5pdGl6ZT1hZGRyZXNzIC1mc2FuaXRpemU9dW5kZWZpbmVkIC1zdGF0aWMtbGli
YXNhbiAkKEtIRFJfSU5DTFVERVMpCitDRkxBR1MgKz0gLVdhbGwgLU8yIC1nIC1mc2FuaXRp
emU9YWRkcmVzcyAtZnNhbml0aXplPXVuZGVmaW5lZCAkKEtIRFJfSU5DTFVERVMpCisKKyMg
Z2NjIHJlcXVpcmVzIC1zdGF0aWMtbGliYXNhbiBpbiBvcmRlciB0byBlbnN1cmUgdGhhdCBB
ZGRyZXNzIFNhbml0aXplcidzCisjIGxpYnJhcnkgaXMgdGhlIGZpcnN0IG9uZSBsb2FkZWQu
IEhvd2V2ZXIsIGNsYW5nIGFscmVhZHkgc3RhdGljYWxseSBsaW5rcyB0aGUKKyMgQWRkcmVz
cyBTYW5pdGl6ZXIgaWYgLWZzYW5pdGl6ZSBpcyBzcGVjaWZpZWQuIFRoZXJlZm9yZSwgc2lt
cGx5IG9taXQKKyMgLXN0YXRpYy1saWJhc2FuIGZvciBjbGFuZyBidWlsZHMuCitpZmVxICgk
KExMVk0pLCkKKyAgICBDRkxBR1MgKz0gLXN0YXRpYy1saWJhc2FuCitlbmRpZgorCiBURVNU
X0dFTl9QUk9HUyA6PSBmY2htb2RhdDJfdGVzdAogCiBpbmNsdWRlIC4uL2xpYi5tawpkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvc3RhdG1vdW50
L3N0YXRtb3VudF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9maWxlc3lzdGVt
cy9zdGF0bW91bnQvc3RhdG1vdW50X3Rlc3QuYwppbmRleCBlNmQ3YzRmMWM4NWIuLmU4YzAx
OWQ3MmNiZiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3Rl
bXMvc3RhdG1vdW50L3N0YXRtb3VudF90ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZmlsZXN5c3RlbXMvc3RhdG1vdW50L3N0YXRtb3VudF90ZXN0LmMKQEAgLTEyNSw4
ICsxMjUsMTYgQEAgc3RhdGljIHVpbnQzMl90IG9sZF9yb290X2lkLCBvbGRfcGFyZW50X2lk
OwogCiBzdGF0aWMgdm9pZCBjbGVhbnVwX25hbWVzcGFjZSh2b2lkKQogewotCWZjaGRpcihv
cmlnX3Jvb3QpOwotCWNocm9vdCgiLiIpOworCWludCByZXQ7CisKKwlyZXQgPSBmY2hkaXIo
b3JpZ19yb290KTsKKwlpZiAocmV0ID09IC0xKQorCQlrc2Z0X3BlcnJvcigiZmNoZGlyIHRv
IG9yaWdpbmFsIHJvb3QiKTsKKworCXJldCA9IGNocm9vdCgiLiIpOworCWlmIChyZXQgPT0g
LTEpCisJCWtzZnRfcGVycm9yKCJjaHJvb3QgdG8gb3JpZ2luYWwgcm9vdCIpOworCiAJdW1v
dW50Mihyb290X21udHBvaW50LCBNTlRfREVUQUNIKTsKIAlybWRpcihyb290X21udHBvaW50
KTsKIH0KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL29wZW5hdDIvTWFr
ZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9vcGVuYXQyL01ha2VmaWxlCmluZGV4
IDI1NGQ2NzZhMjY4OS4uMTg1ZGM3NmViYjVmIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9vcGVuYXQyL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL29wZW5hdDIvTWFrZWZpbGUKQEAgLTEsOCArMSwxOCBAQAogIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgogCi1DRkxBR1MgKz0gLVdhbGwgLU8yIC1n
IC1mc2FuaXRpemU9YWRkcmVzcyAtZnNhbml0aXplPXVuZGVmaW5lZCAtc3RhdGljLWxpYmFz
YW4KK0NGTEFHUyArPSAtV2FsbCAtTzIgLWcgLWZzYW5pdGl6ZT1hZGRyZXNzIC1mc2FuaXRp
emU9dW5kZWZpbmVkCiBURVNUX0dFTl9QUk9HUyA6PSBvcGVuYXQyX3Rlc3QgcmVzb2x2ZV90
ZXN0IHJlbmFtZV9hdHRhY2tfdGVzdAogCisjIGdjYyByZXF1aXJlcyAtc3RhdGljLWxpYmFz
YW4gaW4gb3JkZXIgdG8gZW5zdXJlIHRoYXQgQWRkcmVzcyBTYW5pdGl6ZXIncworIyBsaWJy
YXJ5IGlzIHRoZSBmaXJzdCBvbmUgbG9hZGVkLiBIb3dldmVyLCBjbGFuZyBhbHJlYWR5IHN0
YXRpY2FsbHkgbGlua3MgdGhlCisjIEFkZHJlc3MgU2FuaXRpemVyIGlmIC1mc2FuaXRpemUg
aXMgc3BlY2lmaWVkLiBUaGVyZWZvcmUsIHNpbXBseSBvbWl0CisjIC1zdGF0aWMtbGliYXNh
biBmb3IgY2xhbmcgYnVpbGRzLgoraWZlcSAoJChMTFZNKSwpCisgICAgQ0ZMQUdTICs9IC1z
dGF0aWMtbGliYXNhbgorZW5kaWYKKworTE9DQUxfSERSUyArPSBoZWxwZXJzLmgKKwogaW5j
bHVkZSAuLi9saWIubWsKIAotJChURVNUX0dFTl9QUk9HUyk6IGhlbHBlcnMuYyBoZWxwZXJz
LmgKKyQoVEVTVF9HRU5fUFJPR1MpOiBoZWxwZXJzLmMKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9iZW5jaG1hcmsuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9iZW5jaG1hcmsuYwppbmRleCBiODMw
OTkxNjBmYmMuLjk0ODg2YzgyYWU2MCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvc2VjY29tcC9zZWNjb21wX2JlbmNobWFyay5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL3NlY2NvbXAvc2VjY29tcF9iZW5jaG1hcmsuYwpAQCAtMTk0LDE0ICsxOTQs
MTQgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlrc2Z0X3NldF9wbGFu
KDcpOwogCiAJa3NmdF9wcmludF9tc2coIlJ1bm5pbmcgb246XG4iKTsKLQlrc2Z0X3ByaW50
X21zZygiIik7CisJa3NmdF9wcmludF9tc2coIiVzIiwgIiIpOwogCXN5c3RlbSgidW5hbWUg
LWEiKTsKIAogCWtzZnRfcHJpbnRfbXNnKCJDdXJyZW50IEJQRiBzeXNjdGwgc2V0dGluZ3M6
XG4iKTsKIAkvKiBBdm9pZCB1c2luZyAic3lzY3RsIiB3aGljaCBtYXkgbm90IGJlIGluc3Rh
bGxlZC4gKi8KLQlrc2Z0X3ByaW50X21zZygiIik7CisJa3NmdF9wcmludF9tc2coIiVzIiwg
IiIpOwogCXN5c3RlbSgiZ3JlcCAtSCAuIC9wcm9jL3N5cy9uZXQvY29yZS9icGZfaml0X2Vu
YWJsZSIpOwotCWtzZnRfcHJpbnRfbXNnKCIiKTsKKwlrc2Z0X3ByaW50X21zZygiJXMiLCAi
Iik7CiAJc3lzdGVtKCJncmVwIC1IIC4gL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfaGFy
ZGVuIik7CiAKIAlhZmZpbml0eSgpOwo=

--------------Fnxyrn8oxAwDvUk22LM0pFdd--


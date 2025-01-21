Return-Path: <linux-kselftest+bounces-24899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311FEA18737
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 22:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA283AD050
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31F01F5433;
	Tue, 21 Jan 2025 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gx/q5RgJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6761B2EFB
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494208; cv=none; b=sdNnUIASNO+0tjH40SEIMrUrKmfLpxLcMepV8Jv8UFQks5if32gyIkiUtvXpO/bjgOwRs4+WskXtCK7jy19okRdk9qoQw5FOOYYq4mkCVqEr9MF6BKUxmCeR8t7v50KK5gE6RX0F/pfuz7bnarthCqnRUd7l3rcwenTQgb+Og3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494208; c=relaxed/simple;
	bh=LiYyQjSn8/Ogrz53aGmr5g28X/Q2LgJPxWJUoYLkiqU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject:Cc; b=iRstmyRcNRGuRkFQuPqnP8EFaPN/hPr6Ezl1wweNWhPfIlHL/bSgiWrcVvoZaIIevitI7d9ss1tUmqNvWvAQmG9YEIWnCPSjnxUnYMVXSCIjqzGeScSzLtc7Tn9quRUWc7B2DkZtGf1mSlYCW6HhQP60XXL2q36W94hg8vcny/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gx/q5RgJ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ebb2d8dac4so3603107b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 13:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737494206; x=1738099006; darn=vger.kernel.org;
        h=cc:subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t0Y/E9LA5hslv08mHBG0j2fcfubf1KfMvovCy+4e7Pk=;
        b=Gx/q5RgJ7WRy2e554q7/WtJnBM0l/eUIKYPcsAud6p0iz1t90zI04qASrAmXg8KkVL
         s87pwlgkGbjbpMWg1YSw3ic/pxq6wfxn9t2ep0+5dVTLe74IqNvQOtBiEnpcHBHmFCOg
         Oo8EbnY9kdkvChcgNEn4hLvoVxCDYcp93Nswk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737494206; x=1738099006;
        h=cc:subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0Y/E9LA5hslv08mHBG0j2fcfubf1KfMvovCy+4e7Pk=;
        b=q7IyTDslHnwuF3XoUQlHjVXjOY0Cnj5hVmKmqbrKmwWRXdlAfec4mQmSrw8vmr0TMx
         TB2oisCZOP237DxiwkvRivbGfj4mfjqvrjQUYL+Rj7bJQyheqYWMmCUiwOJvA8xL6+sY
         5cLho68werZSnz6E0bwxrBbEMvM06rAW3qoa2jQtk0HGLAv8fKEHp6ioGJnyZmLmh9DL
         YcF8kBNZJZ4DLfCRIh5pNSw/Vek93v6p9MTyt3FnYqzv6JeYOAQhJZbv6sIL6bdXJSE1
         UoJD0Ey474w3aA7nMO9vuEvP9opgjqhg4eWgPy0EtSnVsdKBLzbiRlxUMwKew0t+Y0uL
         +D2g==
X-Forwarded-Encrypted: i=1; AJvYcCWnhS6a5Lq0r31EDrQcDjuae5bRirFOJrgGs0o+eH7hFL3dJOoOnC5oUTAg/T/RAnTf4zCbnRtd2DQ8IlM7aow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbZ45RIXrz3st8T5BE+NW2mvpzyZipvIEyXSm3a9OcqoITt53
	fLtaNCfAZSWhQJ+gO0kTAVZhda936Qsn/ULoqczhJnH5snAY6B0iiSGTtkDw/mY=
X-Gm-Gg: ASbGncsmjUQsI1HsbfCiK0AxNWbUN2elTykjOLHBauqn3FBKe0VhzznLarQXmLSt4z1
	vAGVNLHxw9ilfk0hZjNRs+05PaCBzOS9peG8JlMyneotl49ne+EWheQQpR8sJfmRP2OYTLdLMCO
	ZfpCFAu/VyzRAswkaY9XZFLVOomknLKssGz7kqeyFX8bhZzJJ9QzohSwYy0TO4bLqZG57OpxNXN
	NMpyxFOX+CZ3/j5f3JVz5fnlSEGq6kZnMiP5bVjDPHuZltFw6+RuTvAxbk5NVZHZqbY3KQnlXYf
	Qdso
X-Google-Smtp-Source: AGHT+IEgQJ7un/yhJfcl29kZW4Xd6ZOqxRbG5jgg7C2Hw1ZsSghAwf7b6lBHh7LNhj+FkjeXBai1Jw==
X-Received: by 2002:a05:6808:4494:b0:3e6:6097:847d with SMTP id 5614622812f47-3f19fc3b35amr13461858b6e.7.1737494205891;
        Tue, 21 Jan 2025 13:16:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f19db9e8bfsm3222504b6e.44.2025.01.21.13.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 13:16:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------S6ZVFAOyrbLHRDlIW0Gd8sQd"
Message-ID: <70eb3d1b-6f91-48da-8854-21f25bd3f289@linuxfoundation.org>
Date: Tue, 21 Jan 2025 14:16:44 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit next update for Linux 6.14-rc1
Cc: sfr@canb.auug.org.au, gregkh@linuxfoundation.org,
 skhan@linuxfoundation.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, brendan.higgins@linux.dev,
 davidgow@google.com

This is a multi-part message in MIME format.
--------------S6ZVFAOyrbLHRDlIW0Gd8sQd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kunit next update for Linux 6.14-rc1.

- fixes struct completion warning
- introduces autorun option
- adds fallback for os.sched_getaffinity
- enables hardware acceleration when available

Note:

Stephen reported duplicate patch in kunit and driver-core:

The following commit is also in the driver-core tree as a different commit
(but the same patch):

   875aec2357cd ("kunit: platform: Resolve 'struct completion' warning")

This is commit

   7687c66c18c6 ("kunit: platform: Resolve 'struct completion' warning")

in the driver-core tree.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.14-rc1

for you to fetch changes up to 31691914c392675bdc65d1e72dd8d129a1f0014f:

   kunit: Introduce autorun option (2025-01-15 09:04:06 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-6.14-rc1

- fixes struct completion warning
- introduces autorun option
- adds fallback for os.sched_getaffinity
- enables hardware acceleration when available

----------------------------------------------------------------
Brian Norris (1):
       kunit: platform: Resolve 'struct completion' warning

Stanislav Kinsburskii (1):
       kunit: Introduce autorun option

Tamir Duberstein (2):
       kunit: add fallback for os.sched_getaffinity
       kunit: enable hardware acceleration when available

  include/kunit/platform_device.h           |  1 +
  include/kunit/test.h                      |  4 +++-
  lib/kunit/Kconfig                         | 12 ++++++++++++
  lib/kunit/debugfs.c                       |  2 +-
  lib/kunit/executor.c                      | 21 +++++++++++++++++++--
  lib/kunit/test.c                          |  6 ++++--
  tools/testing/kunit/kunit.py              | 11 ++++++++++-
  tools/testing/kunit/kunit_kernel.py       |  3 +++
  tools/testing/kunit/qemu_configs/arm64.py |  2 +-
  9 files changed, 54 insertions(+), 8 deletions(-)
----------------------------------------------------------------
--------------S6ZVFAOyrbLHRDlIW0Gd8sQd
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.14-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.14-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvcGxhdGZvcm1fZGV2aWNlLmggYi9pbmNsdWRl
L2t1bml0L3BsYXRmb3JtX2RldmljZS5oCmluZGV4IDBmYzA5OTlkMjQyMC4uZjgyMzZhODUz
NmY3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2t1bml0L3BsYXRmb3JtX2RldmljZS5oCisrKyBi
L2luY2x1ZGUva3VuaXQvcGxhdGZvcm1fZGV2aWNlLmgKQEAgLTIsNiArMiw3IEBACiAjaWZu
ZGVmIF9LVU5JVF9QTEFURk9STV9EUklWRVJfSAogI2RlZmluZSBfS1VOSVRfUExBVEZPUk1f
RFJJVkVSX0gKIAorc3RydWN0IGNvbXBsZXRpb247CiBzdHJ1Y3Qga3VuaXQ7CiBzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlOwogc3RydWN0IHBsYXRmb3JtX2RyaXZlcjsKZGlmZiAtLWdpdCBh
L2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0LmgKaW5kZXggMzRi
NzFlNDJmYjEwLi41OGRiYWI2MGY4NTMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUva3VuaXQvdGVz
dC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC0zMTIsNiArMzEyLDcgQEAgc3Rh
dGljIGlubGluZSB2b2lkIGt1bml0X3NldF9mYWlsdXJlKHN0cnVjdCBrdW5pdCAqdGVzdCkK
IH0KIAogYm9vbCBrdW5pdF9lbmFibGVkKHZvaWQpOworYm9vbCBrdW5pdF9hdXRvcnVuKHZv
aWQpOwogY29uc3QgY2hhciAqa3VuaXRfYWN0aW9uKHZvaWQpOwogY29uc3QgY2hhciAqa3Vu
aXRfZmlsdGVyX2dsb2Iodm9pZCk7CiBjaGFyICprdW5pdF9maWx0ZXIodm9pZCk7CkBAIC0z
MzQsNyArMzM1LDggQEAga3VuaXRfZmlsdGVyX3N1aXRlcyhjb25zdCBzdHJ1Y3Qga3VuaXRf
c3VpdGVfc2V0ICpzdWl0ZV9zZXQsCiAJCSAgICBpbnQgKmVycik7CiB2b2lkIGt1bml0X2Zy
ZWVfc3VpdGVfc2V0KHN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgc3VpdGVfc2V0KTsKIAotaW50
IF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChzdHJ1Y3Qga3VuaXRfc3VpdGUgKiBjb25zdCAq
IGNvbnN0IHN1aXRlcywgaW50IG51bV9zdWl0ZXMpOworaW50IF9fa3VuaXRfdGVzdF9zdWl0
ZXNfaW5pdChzdHJ1Y3Qga3VuaXRfc3VpdGUgKiBjb25zdCAqIGNvbnN0IHN1aXRlcywgaW50
IG51bV9zdWl0ZXMsCisJCQkgICAgIGJvb2wgcnVuX3Rlc3RzKTsKIAogdm9pZCBfX2t1bml0
X3Rlc3Rfc3VpdGVzX2V4aXQoc3RydWN0IGt1bml0X3N1aXRlICoqc3VpdGVzLCBpbnQgbnVt
X3N1aXRlcyk7CiAKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9LY29uZmlnIGIvbGliL2t1bml0
L0tjb25maWcKaW5kZXggMzRkNzI0MmQ1MjZkLi5hOTc4OTdlZGQ5NjQgMTAwNjQ0Ci0tLSBh
L2xpYi9rdW5pdC9LY29uZmlnCisrKyBiL2xpYi9rdW5pdC9LY29uZmlnCkBAIC04MSw0ICs4
MSwxNiBAQCBjb25maWcgS1VOSVRfREVGQVVMVF9FTkFCTEVECiAJICBJbiBtb3N0IGNhc2Vz
IHRoaXMgc2hvdWxkIGJlIGxlZnQgYXMgWS4gT25seSBpZiBhZGRpdGlvbmFsIG9wdC1pbgog
CSAgYmVoYXZpb3IgaXMgbmVlZGVkIHNob3VsZCB0aGlzIGJlIHNldCB0byBOLgogCitjb25m
aWcgS1VOSVRfQVVUT1JVTl9FTkFCTEVECisJYm9vbCAiRGVmYXVsdCB2YWx1ZSBvZiBrdW5p
dC5hdXRvcnVuIgorCWRlZmF1bHQgeQorCWhlbHAKKwkgIFNldHMgdGhlIGRlZmF1bHQgdmFs
dWUgb2Yga3VuaXQuYXV0b3J1bi4gSWYgc2V0IHRvIE4gdGhlbiBLVW5pdAorCSAgdGVzdHMg
d2lsbCBub3QgcnVuIGFmdGVyIGluaXRpYWxpemF0aW9uIHVubGVzcyBrdW5pdC5hdXRvcnVu
PTEgaXMKKwkgIHBhc3NlZCB0byB0aGUga2VybmVsIGNvbW1hbmQgbGluZS4gVGhlIHRlc3Qg
Y2FuIHN0aWxsIGJlIHJ1biBtYW51YWxseQorCSAgdmlhIGRlYnVnZnMgaW50ZXJmYWNlLgor
CisJICBJbiBtb3N0IGNhc2VzIHRoaXMgc2hvdWxkIGJlIGxlZnQgYXMgWS4gT25seSBpZiBh
ZGRpdGlvbmFsIG9wdC1pbgorCSAgYmVoYXZpb3IgaXMgbmVlZGVkIHNob3VsZCB0aGlzIGJl
IHNldCB0byBOLgorCiBlbmRpZiAjIEtVTklUCmRpZmYgLS1naXQgYS9saWIva3VuaXQvZGVi
dWdmcy5jIGIvbGliL2t1bml0L2RlYnVnZnMuYwppbmRleCBhZjcxOTExZjRhMDcuLjljMzI2
ZjE4MzdiZCAxMDA2NDQKLS0tIGEvbGliL2t1bml0L2RlYnVnZnMuYworKysgYi9saWIva3Vu
aXQvZGVidWdmcy5jCkBAIC0xNDUsNyArMTQ1LDcgQEAgc3RhdGljIHNzaXplX3QgZGVidWdm
c19ydW4oc3RydWN0IGZpbGUgKmZpbGUsCiAJc3RydWN0IGlub2RlICpmX2lub2RlID0gZmls
ZS0+Zl9pbm9kZTsKIAlzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlID0gKHN0cnVjdCBrdW5p
dF9zdWl0ZSAqKSBmX2lub2RlLT5pX3ByaXZhdGU7CiAKLQlfX2t1bml0X3Rlc3Rfc3VpdGVz
X2luaXQoJnN1aXRlLCAxKTsKKwlfX2t1bml0X3Rlc3Rfc3VpdGVzX2luaXQoJnN1aXRlLCAx
LCB0cnVlKTsKIAogCXJldHVybiBjb3VudDsKIH0KZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9l
eGVjdXRvci5jIGIvbGliL2t1bml0L2V4ZWN1dG9yLmMKaW5kZXggMzRiN2I2ODMzZGYzLi4z
ZjM5OTU1Y2IwZjEgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9leGVjdXRvci5jCisrKyBiL2xp
Yi9rdW5pdC9leGVjdXRvci5jCkBAIC0yOSw2ICsyOSwyMiBAQCBjb25zdCBjaGFyICprdW5p
dF9hY3Rpb24odm9pZCkKIAlyZXR1cm4gYWN0aW9uX3BhcmFtOwogfQogCisvKgorICogUnVu
IEtVbml0IHRlc3RzIGFmdGVyIGluaXRpYWxpemF0aW9uCisgKi8KKyNpZmRlZiBDT05GSUdf
S1VOSVRfQVVUT1JVTl9FTkFCTEVECitzdGF0aWMgYm9vbCBhdXRvcnVuX3BhcmFtID0gdHJ1
ZTsKKyNlbHNlCitzdGF0aWMgYm9vbCBhdXRvcnVuX3BhcmFtOworI2VuZGlmCittb2R1bGVf
cGFyYW1fbmFtZWQoYXV0b3J1biwgYXV0b3J1bl9wYXJhbSwgYm9vbCwgMCk7CitNT0RVTEVf
UEFSTV9ERVNDKGF1dG9ydW4sICJSdW4gS1VuaXQgdGVzdHMgYWZ0ZXIgaW5pdGlhbGl6YXRp
b24iKTsKKworYm9vbCBrdW5pdF9hdXRvcnVuKHZvaWQpCit7CisJcmV0dXJuIGF1dG9ydW5f
cGFyYW07Cit9CisKIHN0YXRpYyBjaGFyICpmaWx0ZXJfZ2xvYl9wYXJhbTsKIHN0YXRpYyBj
aGFyICpmaWx0ZXJfcGFyYW07CiBzdGF0aWMgY2hhciAqZmlsdGVyX2FjdGlvbl9wYXJhbTsK
QEAgLTI2MCwxMyArMjc2LDE0IEBAIGt1bml0X2ZpbHRlcl9zdWl0ZXMoY29uc3Qgc3RydWN0
IGt1bml0X3N1aXRlX3NldCAqc3VpdGVfc2V0LAogdm9pZCBrdW5pdF9leGVjX3J1bl90ZXN0
cyhzdHJ1Y3Qga3VuaXRfc3VpdGVfc2V0ICpzdWl0ZV9zZXQsIGJvb2wgYnVpbHRpbikKIHsK
IAlzaXplX3QgbnVtX3N1aXRlcyA9IHN1aXRlX3NldC0+ZW5kIC0gc3VpdGVfc2V0LT5zdGFy
dDsKKwlib29sIGF1dG9ydW4gPSBrdW5pdF9hdXRvcnVuKCk7CiAKLQlpZiAoYnVpbHRpbiB8
fCBudW1fc3VpdGVzKSB7CisJaWYgKGF1dG9ydW4gJiYgKGJ1aWx0aW4gfHwgbnVtX3N1aXRl
cykpIHsKIAkJcHJfaW5mbygiS1RBUCB2ZXJzaW9uIDFcbiIpOwogCQlwcl9pbmZvKCIxLi4l
enVcbiIsIG51bV9zdWl0ZXMpOwogCX0KIAotCV9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChz
dWl0ZV9zZXQtPnN0YXJ0LCBudW1fc3VpdGVzKTsKKwlfX2t1bml0X3Rlc3Rfc3VpdGVzX2lu
aXQoc3VpdGVfc2V0LT5zdGFydCwgbnVtX3N1aXRlcywgYXV0b3J1bik7CiB9CiAKIHZvaWQg
a3VuaXRfZXhlY19saXN0X3Rlc3RzKHN0cnVjdCBrdW5pdF9zdWl0ZV9zZXQgKnN1aXRlX3Nl
dCwgYm9vbCBpbmNsdWRlX2F0dHIpCmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVzdC5jIGIv
bGliL2t1bml0L3Rlc3QuYwppbmRleCAwODljODMyZTNjZGIuLjE0NmQxYjQ4YTA5NiAxMDA2
NDQKLS0tIGEvbGliL2t1bml0L3Rlc3QuYworKysgYi9saWIva3VuaXQvdGVzdC5jCkBAIC03
MDgsNyArNzA4LDggQEAgYm9vbCBrdW5pdF9lbmFibGVkKHZvaWQpCiAJcmV0dXJuIGVuYWJs
ZV9wYXJhbTsKIH0KIAotaW50IF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChzdHJ1Y3Qga3Vu
aXRfc3VpdGUgKiBjb25zdCAqIGNvbnN0IHN1aXRlcywgaW50IG51bV9zdWl0ZXMpCitpbnQg
X19rdW5pdF90ZXN0X3N1aXRlc19pbml0KHN0cnVjdCBrdW5pdF9zdWl0ZSAqIGNvbnN0ICog
Y29uc3Qgc3VpdGVzLCBpbnQgbnVtX3N1aXRlcywKKwkJCSAgICAgYm9vbCBydW5fdGVzdHMp
CiB7CiAJdW5zaWduZWQgaW50IGk7CiAKQEAgLTczMSw3ICs3MzIsOCBAQCBpbnQgX19rdW5p
dF90ZXN0X3N1aXRlc19pbml0KHN0cnVjdCBrdW5pdF9zdWl0ZSAqIGNvbnN0ICogY29uc3Qg
c3VpdGVzLCBpbnQgbnVtXwogCiAJZm9yIChpID0gMDsgaSA8IG51bV9zdWl0ZXM7IGkrKykg
ewogCQlrdW5pdF9pbml0X3N1aXRlKHN1aXRlc1tpXSk7Ci0JCWt1bml0X3J1bl90ZXN0cyhz
dWl0ZXNbaV0pOworCQlpZiAocnVuX3Rlc3RzKQorCQkJa3VuaXRfcnVuX3Rlc3RzKHN1aXRl
c1tpXSk7CiAJfQogCiAJc3RhdGljX2JyYW5jaF9kZWMoJmt1bml0X3J1bm5pbmcpOwpkaWZm
IC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdC5weSBiL3Rvb2xzL3Rlc3Rpbmcv
a3VuaXQva3VuaXQucHkKaW5kZXggNjc2ZmE5OWE4YjE5Li43ZjlhZTU1ZmQ2ZDUgMTAwNzU1
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXQucHkKKysrIGIvdG9vbHMvdGVzdGlu
Zy9rdW5pdC9rdW5pdC5weQpAQCAtMzEyLDcgKzMxMiwxNiBAQCBkZWYgbWFzc2FnZV9hcmd2
KGFyZ3Y6IFNlcXVlbmNlW3N0cl0pIC0+IFNlcXVlbmNlW3N0cl06CiAJcmV0dXJuIGxpc3Qo
bWFwKG1hc3NhZ2VfYXJnLCBhcmd2KSkKIAogZGVmIGdldF9kZWZhdWx0X2pvYnMoKSAtPiBp
bnQ6Ci0JcmV0dXJuIGxlbihvcy5zY2hlZF9nZXRhZmZpbml0eSgwKSkKKwlpZiBzeXMudmVy
c2lvbl9pbmZvID49ICgzLCAxMyk6CisJCWlmIChuY3B1IDo9IG9zLnByb2Nlc3NfY3B1X2Nv
dW50KCkpIGlzIG5vdCBOb25lOgorCQkJcmV0dXJuIG5jcHUKKwkJcmFpc2UgUnVudGltZUVy
cm9yKCJvcy5wcm9jZXNzX2NwdV9jb3VudCgpIHJldHVybmVkIE5vbmUiKQorCSAjIFNlZSBo
dHRwczovL2dpdGh1Yi5jb20vcHl0aG9uL2NweXRob24vYmxvYi9iNjFmZWNlL0xpYi9vcy5w
eSNMMTE3NS1MMTE4Ni4KKwlpZiBzeXMucGxhdGZvcm0gIT0gImRhcndpbiI6CisJCXJldHVy
biBsZW4ob3Muc2NoZWRfZ2V0YWZmaW5pdHkoMCkpCisJaWYgKG5jcHUgOj0gb3MuY3B1X2Nv
dW50KCkpIGlzIG5vdCBOb25lOgorCQlyZXR1cm4gbmNwdQorCXJhaXNlIFJ1bnRpbWVFcnJv
cigib3MuY3B1X2NvdW50KCkgcmV0dXJuZWQgTm9uZSIpCiAKIGRlZiBhZGRfY29tbW9uX29w
dHMocGFyc2VyOiBhcmdwYXJzZS5Bcmd1bWVudFBhcnNlcikgLT4gTm9uZToKIAlwYXJzZXIu
YWRkX2FyZ3VtZW50KCctLWJ1aWxkX2RpcicsCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L2t1bml0L2t1bml0X2tlcm5lbC5weSBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfa2Vy
bmVsLnB5CmluZGV4IGU3NmQ3ODk0YjZjNS4uZDMwZjkwZWFlOWE0IDEwMDY0NAotLS0gYS90
b29scy90ZXN0aW5nL2t1bml0L2t1bml0X2tlcm5lbC5weQorKysgYi90b29scy90ZXN0aW5n
L2t1bml0L2t1bml0X2tlcm5lbC5weQpAQCAtMTI1LDYgKzEyNSw5IEBAIGNsYXNzIExpbnV4
U291cmNlVHJlZU9wZXJhdGlvbnNRZW11KExpbnV4U291cmNlVHJlZU9wZXJhdGlvbnMpOgog
CQkJCSctYXBwZW5kJywgJyAnLmpvaW4ocGFyYW1zICsgW3NlbGYuX2tlcm5lbF9jb21tYW5k
X2xpbmVdKSwKIAkJCQknLW5vLXJlYm9vdCcsCiAJCQkJJy1ub2dyYXBoaWMnLAorCQkJCSct
YWNjZWwnLCAna3ZtJywKKwkJCQknLWFjY2VsJywgJ2h2ZicsCisJCQkJJy1hY2NlbCcsICd0
Y2cnLAogCQkJCSctc2VyaWFsJywgc2VsZi5fc2VyaWFsXSArIHNlbGYuX2V4dHJhX3FlbXVf
cGFyYW1zCiAJCSMgTm90ZTogc2hsZXguam9pbigpIGRvZXMgd2hhdCB3ZSB3YW50LCBidXQg
cmVxdWlyZXMgcHl0aG9uIDMuOCsuCiAJCXByaW50KCdSdW5uaW5nIHRlc3RzIHdpdGg6XG4k
JywgJyAnLmpvaW4oc2hsZXgucXVvdGUoYXJnKSBmb3IgYXJnIGluIHFlbXVfY29tbWFuZCkp
CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2t1bml0L3FlbXVfY29uZmlncy9hcm02NC5w
eSBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL2FybTY0LnB5CmluZGV4IGQz
ZmYyNzAyNDc1NS4uNWM0NGQzYTg3ZTZkIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL2t1
bml0L3FlbXVfY29uZmlncy9hcm02NC5weQorKysgYi90b29scy90ZXN0aW5nL2t1bml0L3Fl
bXVfY29uZmlncy9hcm02NC5weQpAQCAtOSw0ICs5LDQgQEAgQ09ORklHX1NFUklBTF9BTUJB
X1BMMDExX0NPTlNPTEU9eScnJywKIAkJCSAgIHFlbXVfYXJjaD0nYWFyY2g2NCcsCiAJCQkg
ICBrZXJuZWxfcGF0aD0nYXJjaC9hcm02NC9ib290L0ltYWdlLmd6JywKIAkJCSAgIGtlcm5l
bF9jb21tYW5kX2xpbmU9J2NvbnNvbGU9dHR5QU1BMCcsCi0JCQkgICBleHRyYV9xZW11X3Bh
cmFtcz1bJy1tYWNoaW5lJywgJ3ZpcnQnLCAnLWNwdScsICdtYXgscGF1dGgtaW1wZGVmPW9u
J10pCisJCQkgICBleHRyYV9xZW11X3BhcmFtcz1bJy1tYWNoaW5lJywgJ3ZpcnQnLCAnLWNw
dScsICdtYXgnXSkK

--------------S6ZVFAOyrbLHRDlIW0Gd8sQd--


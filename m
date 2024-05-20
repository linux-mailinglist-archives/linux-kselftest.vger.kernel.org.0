Return-Path: <linux-kselftest+bounces-10442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71378CA170
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAEE281182
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA128137C38;
	Mon, 20 May 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDpN0vRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334113774C
	for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716226447; cv=none; b=hBcFTGUZpwBMIkX0kOFOJL+GHKcinlf0g6isdhMBFeBT99KvrB88FzL7d5CwyVVQDaBnR88AfePetbZOCj/GZ/v6a9NBQbBir5tDIQ+Yrc2eBuLXG7+0YoJkgZ5jGhuTe9VNppB25YJZatIbD9WU7QeS8kBYA2xxJJL/LJCucbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716226447; c=relaxed/simple;
	bh=NXPQ88bUsMStJ3GNQoRlRoNhxcTjfI+OoR7ZxZiF5nM=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=mNApn4YUJZe+H5pFF4+8WCsz8VHcrb0qHab7wXKQCpuaoYKvDH5zqO8rA8IeXnS2tWIkVhc43tqPWEHEhUG1IvFRAFMtiXqt6IO7r6CV+3yvgmClPlr8P6i6eohROqOzK2axhc1xJ4IO5H/4cuEyfq/juDLMOjiqBEPzTBV79G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDpN0vRM; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e250c4158fso3838739f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 May 2024 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716226445; x=1716831245; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=We463djKM5gnWQMeK0z6Ah5wGS2hu7RTpVVmyvWnYUs=;
        b=SDpN0vRMpm23TTgBUYjzLmNVWfsSEGDAKfAdsTfKGH0nmdus/d8acp6yJTuiOdPcS5
         4wk+fqILLoDOtsVWXh/GS82AsgO4guMSwywT50Jyko1SdxTIIJigEYVocURNN7pu2Fxf
         nef1m07eJnZDoKPcz4UB+2FljxdIYg+vAijQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716226445; x=1716831245;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=We463djKM5gnWQMeK0z6Ah5wGS2hu7RTpVVmyvWnYUs=;
        b=DMP9bOGH3OGhiuQWx9T6DKTssf+j4WM0VFiar0HBtwdkEV5THzWnKsiBQMti/T6LN3
         Lw6q1laTB82rTxJueVjh+nMamGmh+g8qpDmFPKpoyE21LWGPIKuIbYi1aiS/Ndj8nl1x
         GBdkNWqcyJRFpZX4NW7JTpTGM5AFbUTYZgCq2KYuH4ey5ggkFgDANKWB2JIojqY3tUde
         zVv9HDj9AOp5V4tMxy7dCp+q3skXBVQtrOzc0Lq+dRbspVvHkRSkw0HwY3AmiOykfa74
         Z1dXpRF27Ljzf9NiHnBeiB/nitDHgSePzM2qmmKE5whWQt6lZFtikp0I1LcxKKMl7Z7e
         7/FA==
X-Forwarded-Encrypted: i=1; AJvYcCUYZVsSc/ZsyppCKAvMFZzcEyiuHGrSTBEnGmURNNNMoqI6tisletU/j1tJQOCEyRXKFmt7lhtOZRZDt7LxvoswP1EEfxIDWhvyabrX+EHJ
X-Gm-Message-State: AOJu0YxwUqMIYUtuS3PNIAPpMEv9ALWfeLg6gy0K6OR0+SCxapX6Dob5
	1/oKKrYp932RRsLRfEMi7TlxI6ZD7OUgOem9VE9a7CiT0MvtZ+q6h+tZSprGBc0kzwvKLFXDhfb
	D5P0=
X-Google-Smtp-Source: AGHT+IHRerGd2Kn5X499MqlRWfZ5qBcq6NE0WiJXRgUFaOmfxaXfuBXsBnM7vw6NeyFIe0BEMH+vyw==
X-Received: by 2002:a5e:c748:0:b0:7e1:d865:e700 with SMTP id ca18e2360f4ac-7e1d865e82emr2693219839f.2.1716226445121;
        Mon, 20 May 2024 10:34:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-48960d727cesm5960273173.102.2024.05.20.10.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 10:34:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------a6FnaiFsNe7uxBNo5ImfozAe"
Message-ID: <1eee575f-91fe-4da8-bd8f-8a8e44fcd4c7@linuxfoundation.org>
Date: Mon, 20 May 2024 11:34:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>

This is a multi-part message in MIME format.
--------------a6FnaiFsNe7uxBNo5ImfozAe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this urgent kselftest fixes update for Linux 6.10-rc1.

This kselftest fixes update for Linux 6.10-rc1 consists of
reverts framework change to add D_GNU_SOURCE to KHDR_INCLUDES
to Makefile, lib.mk, and kselftest_harness.h and follow-on
changes to cgroup and sgx test as they are causing build
failures and warnings.

These three reverts have bee in next for a few days prior
to a rebase before generating the pull request.

diff for pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit ea5f6ad9ad9645733b72ab53a98e719b460d36a6:

   Merge tag 'platform-drivers-x86-v6.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-05-16 09:14:50 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.10-rc1-fixes

for you to fetch changes up to a97853f25b06f71c23b2d7a59fbd40f3f42d55ac:

   Revert "selftests/cgroup: Drop define _GNU_SOURCE" (2024-05-20 09:00:15 -0600)

----------------------------------------------------------------
linux_kselftest-next-6.10-rc1-fixes

This kselftest fixes update for Linux 6.10-rc1 consists of
reverts framework change to add D_GNU_SOURCE to KHDR_INCLUDES
to Makefile, lib.mk, and kselftest_harness.h and follow-on
changes to cgroup and sgx test as they are causing build
failures and warnings.

----------------------------------------------------------------
Shuah Khan (3):
       Revert "selftests: Compile kselftest headers with -D_GNU_SOURCE"
       Revert "selftests/sgx: Include KHDR_INCLUDES in Makefile"
       Revert "selftests/cgroup: Drop define _GNU_SOURCE"

  tools/testing/selftests/Makefile                    | 4 ++--
  tools/testing/selftests/cgroup/cgroup_util.c        | 3 +++
  tools/testing/selftests/cgroup/test_core.c          | 2 ++
  tools/testing/selftests/cgroup/test_cpu.c           | 2 ++
  tools/testing/selftests/cgroup/test_hugetlb_memcg.c | 2 ++
  tools/testing/selftests/cgroup/test_kmem.c          | 2 ++
  tools/testing/selftests/cgroup/test_memcontrol.c    | 2 ++
  tools/testing/selftests/cgroup/test_zswap.c         | 2 ++
  tools/testing/selftests/kselftest_harness.h         | 2 +-
  tools/testing/selftests/lib.mk                      | 2 +-
  tools/testing/selftests/sgx/Makefile                | 2 +-
  tools/testing/selftests/sgx/sigstruct.c             | 1 +
  12 files changed, 21 insertions(+), 5 deletions(-)
----------------------------------------------------------------
--------------a6FnaiFsNe7uxBNo5ImfozAe
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.10-rc1-fixes.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-next-6.10-rc1-fixes.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGUKaW5kZXggZjA0MzFlNmNiNjdlLi45MDM5ZjM3
MDlhZmYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCkBAIC0xNzAsMTEgKzE3MCwx
MSBAQCBpZm5lcSAoJChLQlVJTERfT1VUUFVUKSwpCiAgICMgJChyZWFscGF0aCAuLi4pIHJl
c29sdmVzIHN5bWxpbmtzCiAgIGFic19vYmp0cmVlIDo9ICQocmVhbHBhdGggJChhYnNfb2Jq
dHJlZSkpCiAgIEJVSUxEIDo9ICQoYWJzX29ianRyZWUpL2tzZWxmdGVzdAotICBLSERSX0lO
Q0xVREVTIDo9IC1EX0dOVV9TT1VSQ0UgLWlzeXN0ZW0gJHthYnNfb2JqdHJlZX0vdXNyL2lu
Y2x1ZGUKKyAgS0hEUl9JTkNMVURFUyA6PSAtaXN5c3RlbSAke2Fic19vYmp0cmVlfS91c3Iv
aW5jbHVkZQogZWxzZQogICBCVUlMRCA6PSAkKENVUkRJUikKICAgYWJzX3NyY3RyZWUgOj0g
JChzaGVsbCBjZCAkKHRvcF9zcmNkaXIpICYmIHB3ZCkKLSAgS0hEUl9JTkNMVURFUyA6PSAt
RF9HTlVfU09VUkNFIC1pc3lzdGVtICR7YWJzX3NyY3RyZWV9L3Vzci9pbmNsdWRlCisgIEtI
RFJfSU5DTFVERVMgOj0gLWlzeXN0ZW0gJHthYnNfc3JjdHJlZX0vdXNyL2luY2x1ZGUKICAg
REVGQVVMVF9JTlNUQUxMX0hEUl9QQVRIIDo9IDEKIGVuZGlmCiAKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91cC9jZ3JvdXBfdXRpbC5jIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvY2dyb3VwL2Nncm91cF91dGlsLmMKaW5kZXggY2UxNmE1MGVjZmY4
Li40MzJkYjkyM2JjZWQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nn
cm91cC9jZ3JvdXBfdXRpbC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91
cC9jZ3JvdXBfdXRpbC5jCkBAIC0xLDQgKzEsNyBAQAogLyogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAgKi8KKworI2RlZmluZSBfR05VX1NPVVJDRQorCiAjaW5jbHVkZSA8
ZXJybm8uaD4KICNpbmNsdWRlIDxmY250bC5oPgogI2luY2x1ZGUgPGxpbnV4L2xpbWl0cy5o
PgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwL3Rlc3RfY29y
ZS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwL3Rlc3RfY29yZS5jCmluZGV4
IGRlOGJhYWQ0NjAyMi4uYTU2NzJhOTFkMjczIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9jb3JlLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvY2dyb3VwL3Rlc3RfY29yZS5jCkBAIC0xLDQgKzEsNiBAQAogLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8KKworI2RlZmluZSBfR05VX1NPVVJDRQogI2lu
Y2x1ZGUgPGxpbnV4L2xpbWl0cy5oPgogI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+CiAjaW5j
bHVkZSA8c3lzL3R5cGVzLmg+CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9jZ3JvdXAvdGVzdF9jcHUuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91cC90
ZXN0X2NwdS5jCmluZGV4IDVhNGEzMTRmNmFmNy4uZGFkMmVkODJmM2VmIDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9jcHUuYworKysgYi90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9jcHUuYwpAQCAtMSw0ICsxLDYgQEAK
IC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCisKKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKICNpbmNsdWRlIDxsaW51eC9saW1pdHMuaD4KICNpbmNsdWRlIDxzeXMvc3lzaW5m
by5oPgogI2luY2x1ZGUgPHN5cy93YWl0Lmg+CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9odWdldGxiX21lbWNnLmMgYi90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9odWdldGxiX21lbWNnLmMKaW5kZXggODBkMDVkNTBh
NDJkLi44NTZmOTUwOGVhNTYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nncm91cC90ZXN0X2h1Z2V0bGJfbWVtY2cuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9jZ3JvdXAvdGVzdF9odWdldGxiX21lbWNnLmMKQEAgLTEsNCArMSw2IEBACiAvLyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAorI2RlZmluZSBfR05VX1NPVVJDRQor
CiAjaW5jbHVkZSA8bGludXgvbGltaXRzLmg+CiAjaW5jbHVkZSA8c3lzL21tYW4uaD4KICNp
bmNsdWRlIDxzdGRpby5oPgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
Y2dyb3VwL3Rlc3Rfa21lbS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwL3Rl
c3Rfa21lbS5jCmluZGV4IDJlNDUzYWM1MGMwZC4uOTY2OTNkODc3MmJlIDEwMDY0NAotLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9rbWVtLmMKKysrIGIvdG9v
bHMvdGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwL3Rlc3Rfa21lbS5jCkBAIC0xLDQgKzEsNiBA
QAogLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKKwogI2luY2x1ZGUgPGxpbnV4L2xpbWl0cy5oPgogI2luY2x1ZGUgPGZjbnRsLmg+
CiAjaW5jbHVkZSA8c3RkaW8uaD4KZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Nncm91cC90ZXN0X21lbWNvbnRyb2wuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Nncm91cC90ZXN0X21lbWNvbnRyb2wuYwppbmRleCBjODcxNjMwZDYyYTMuLjQxYWU4MDQ3
Yjg4OSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwL3Rlc3Rf
bWVtY29udHJvbC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91cC90ZXN0
X21lbWNvbnRyb2wuYwpAQCAtMSw0ICsxLDYgQEAKIC8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wICovCisjZGVmaW5lIF9HTlVfU09VUkNFCisKICNpbmNsdWRlIDxsaW51
eC9saW1pdHMuaD4KICNpbmNsdWRlIDxsaW51eC9vb20uaD4KICNpbmNsdWRlIDxmY250bC5o
PgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY2dyb3VwL3Rlc3RfenN3
YXAuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91cC90ZXN0X3pzd2FwLmMKaW5k
ZXggODQxOGE4ZDc0MzlmLi5mYTU3MWJmZDI0MzIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2Nncm91cC90ZXN0X3pzd2FwLmMKKysrIGIvdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvY2dyb3VwL3Rlc3RfenN3YXAuYwpAQCAtMSw0ICsxLDYgQEAKIC8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCisjZGVmaW5lIF9HTlVfU09VUkNFCisKICNp
bmNsdWRlIDxsaW51eC9saW1pdHMuaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRl
IDxzdGRpby5oPgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0
ZXN0X2hhcm5lc3MuaCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJu
ZXNzLmgKaW5kZXggMzdiMDNmMWI4NzQxLi4zYzhmMjk2NWMyODUgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdF9oYXJuZXNzLmgKKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0X2hhcm5lc3MuaApAQCAtNTEsNyArNTEsNyBA
QAogI2RlZmluZSBfX0tTRUxGVEVTVF9IQVJORVNTX0gKIAogI2lmbmRlZiBfR05VX1NPVVJD
RQotc3RhdGljX2Fzc2VydCgwLCAia3NlbGZ0ZXN0IGhhcm5lc3MgcmVxdWlyZXMgX0dOVV9T
T1VSQ0UgdG8gYmUgZGVmaW5lZCIpOworI2RlZmluZSBfR05VX1NPVVJDRQogI2VuZGlmCiAj
aW5jbHVkZSA8YXNtL3R5cGVzLmg+CiAjaW5jbHVkZSA8Y3R5cGUuaD4KZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpYi5tayBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2xpYi5tawppbmRleCAzM2MyNGNlZGRmYjcuLjA5ZThhODU0ZjBmYyAxMDA2NDQKLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1rCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xpYi5tawpAQCAtNjcsNyArNjcsNyBAQCBNQUtFRkxBR1MgKz0gLS1uby1w
cmludC1kaXJlY3RvcnkKIGVuZGlmCiAKIGlmZXEgKCQoS0hEUl9JTkNMVURFUyksKQotS0hE
Ul9JTkNMVURFUyA6PSAtRF9HTlVfU09VUkNFIC1pc3lzdGVtICQodG9wX3NyY2RpcikvdXNy
L2luY2x1ZGUKK0tIRFJfSU5DTFVERVMgOj0gLWlzeXN0ZW0gJCh0b3Bfc3JjZGlyKS91c3Iv
aW5jbHVkZQogZW5kaWYKIAogIyBUaGUgZm9sbG93aW5nIGFyZSBidWlsdCBieSBsaWIubWsg
Y29tbW9uIGNvbXBpbGUgcnVsZXMuCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZ3gvTWFrZWZpbGUgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZ3gvTWFrZWZp
bGUKaW5kZXggMjZlYTMwZmFlMjNjLi44NjdmODhjZTI1NzAgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9NYWtlZmlsZQorKysgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9zZ3gvTWFrZWZpbGUKQEAgLTEyLDcgKzEyLDcgQEAgT0JKQ09QWSA6PSAkKENS
T1NTX0NPTVBJTEUpb2JqY29weQogZW5kaWYKIAogSU5DTFVERVMgOj0gLUkkKHRvcF9zcmNk
aXIpL3Rvb2xzL2luY2x1ZGUKLUhPU1RfQ0ZMQUdTIDo9IC1XYWxsIC1XZXJyb3IgJChLSERS
X0lOQ0xVREVTKSAtZyAkKElOQ0xVREVTKSAtZlBJQworSE9TVF9DRkxBR1MgOj0gLVdhbGwg
LVdlcnJvciAtZyAkKElOQ0xVREVTKSAtZlBJQwogSE9TVF9MREZMQUdTIDo9IC16IG5vZXhl
Y3N0YWNrIC1sY3J5cHRvCiBFTkNMX0NGTEFHUyArPSAtV2FsbCAtV2Vycm9yIC1zdGF0aWMt
cGllIC1ub3N0ZGxpYiAtZmZyZWVzdGFuZGluZyAtZlBJRSBcCiAJICAgICAgIC1mbm8tc3Rh
Y2stcHJvdGVjdG9yIC1tcmRybmQgJChJTkNMVURFUykKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3NneC9zaWdzdHJ1Y3QuYwppbmRleCAyMDAwMzRhMGZlZTUuLmQ3M2IyOWJlY2Y1YiAx
MDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvc2d4L3NpZ3N0cnVjdC5jCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NneC9zaWdzdHJ1Y3QuYwpAQCAtMSw2ICsx
LDcgQEAKIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiAvKiAgQ29weXJp
Z2h0KGMpIDIwMTYtMjAgSW50ZWwgQ29ycG9yYXRpb24uICovCiAKKyNkZWZpbmUgX0dOVV9T
T1VSQ0UKICNpbmNsdWRlIDxhc3NlcnQuaD4KICNpbmNsdWRlIDxnZXRvcHQuaD4KICNpbmNs
dWRlIDxzdGRib29sLmg+Cg==

--------------a6FnaiFsNe7uxBNo5ImfozAe--


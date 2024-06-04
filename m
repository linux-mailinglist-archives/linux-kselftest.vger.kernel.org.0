Return-Path: <linux-kselftest+bounces-11207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF648FB7B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 17:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94186B2A4E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA4143C76;
	Tue,  4 Jun 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xgk0dV5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78113D501
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Jun 2024 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515480; cv=none; b=ljE60PcVny13mHqfmGhSQZ6C22gb1uC9lJx/VwPaigOcDF9WGJiiR5mPNRuEW/sYYn2QuGKTMECrDZKm8oaUPoAy+XnDaQ/rCCUUmE5HL7CnPU179dQj0dYnp+3D5VEQFl5BFFZZOQ/kVyj6gLme1yBRemrtKavviPZOOS0ZEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515480; c=relaxed/simple;
	bh=yufnEfjGW3HHBVtqyVbl8i0X8WGcbqJ5OlJiTm6LOAg=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=SH7ky+xCBGz67LBsNn5bA7Q7ZBAPLteuVjhdIh3fkwHWBw/ntgyw9CHc6zFOENNFaxbd3I1pFjul9qdeWrK/vc+Cj3IEEXDeQLlR4rAKHZlJBaXYRRcAZ8whJ4jUTHVfxslxSxtRAZQD2m14u1P/e5ga8Y9cSoFUESQw+wL5sL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xgk0dV5L; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36da9b73a54so2063035ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Jun 2024 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717515477; x=1718120277; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j8BS3K41v6vgBbioXVVAOSNpMUGdv3zQtA0n00+8Wuw=;
        b=Xgk0dV5Lh4zENT8dVh8W0gmNx1zrA/zQgAQtuwc8ZJycCPyNJJ+stBrPWMSNsa4F4A
         AScl/DUPA2V/dd5ND9jJqbVJdfM7vhk4i0RbaiJhMpE6DcH589PWA1e/h9L72kjNV09k
         PRhu/FZQpmPJ0V+fsXO4OVzdOT1NH1KVlbqlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717515477; x=1718120277;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8BS3K41v6vgBbioXVVAOSNpMUGdv3zQtA0n00+8Wuw=;
        b=hGGT7imIxgDpGDvE6XUCPEJOTLh0xpwb/XDCaRvwEQDWdmVvcAHYM8ih7RqtMxwJTh
         98RSb/15oPbTjRwUS31a2T2I95rSlPVlhUaOan7uggHrRPt5SepVRpG1w2AWHZZyTvvC
         T9TKanQ6gGqLdSwtlelWKpi0rm2BarFYHspXO/XGEUH/WXvhRDlQN7YIyn4E0oikN5/S
         dzMzy4ANbq4/m1/IuuKH24N+N/IW2lHh8d9IwY3NDUvGUKiIJlfXHG4+vX9GFtIB3Imf
         KUNop5GQul20MowhNFta+HO35JupKGDtduFhi2bpFg2QQyF/cxPB2cwifUroADW2Xube
         EOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXljm8ILJByP4DHB07By+EQrEz6vkLCx7Zt+ricA9fKrwlewiCNhYgWDDNhmu50bf0Jd7jOuGgKylYlfZF4SlW4wx5g0heq+1aoEYbAInXd
X-Gm-Message-State: AOJu0YwFoE6Ws86qksa9PXeLPn+OzOUXQu2EAByPg5IlpsHUIjzDFelm
	J6nQPrLsMr0BJykRioRKHIinNrARkPEq7vxUChN4alm4qxSFrLloSQzJDNL6HZc=
X-Google-Smtp-Source: AGHT+IHNEGfTxEHa76QD6xzIQ1Rm3YwNHHZnaTi0tPzC2d4j5y9r/vzRHiEKoKMe6zTKqrFX3vL09A==
X-Received: by 2002:a92:ca4d:0:b0:374:99fc:c83a with SMTP id e9e14a558f8ab-374a94fe190mr28608815ab.3.1717515477060;
        Tue, 04 Jun 2024 08:37:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3748a1dda21sm22215475ab.3.2024.06.04.08.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:37:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Idb85KJdyIJT2x3dxATbdFZe"
Message-ID: <f32f0c51-f11d-421f-95c2-1a9e94be1a32@linuxfoundation.org>
Date: Tue, 4 Jun 2024 09:37:55 -0600
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
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 6.10-rc3

This is a multi-part message in MIME format.
--------------Idb85KJdyIJT2x3dxATbdFZe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this urgent kselftest fixes update for Linux 6.10-rc3.

This kselftest fixes update consists of fixes to build warnings
in several tests and fixes to ftrace tests.

diff for pull request is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10-rc3

for you to fetch changes up to 4bf15b1c657d22d1d70173e43264e4606dfe75ff:

   selftests/futex: don't pass a const char* to asprintf(3) (2024-05-31 14:37:10 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.10-rc3

This kselftest fixes update consists of fixes to build warnings
in several tests and fixes to ftrace tests.

----------------------------------------------------------------
John Hubbard (3):
       selftests/futex: pass _GNU_SOURCE without a value to the compiler
       selftests/futex: don't redefine .PHONY targets (all, clean)
       selftests/futex: don't pass a const char* to asprintf(3)

Mark Brown (1):
       kselftest/alsa: Ensure _GNU_SOURCE is defined

Masami Hiramatsu (Google) (3):
       selftests/ftrace: Fix to check required event file
       selftests/ftrace: Update required config
       selftests/tracing: Fix event filter test to retry up to 10 times

Michael Ellerman (3):
       selftests: cachestat: Fix build warnings on ppc64
       selftests/openat2: Fix build warnings on ppc64
       selftests/overlayfs: Fix build error on ppc64

Steven Rostedt (Google) (1):
       tracing/selftests: Fix kprobe event name test for .isra. functions

  tools/testing/selftests/alsa/Makefile              |  2 +-
  tools/testing/selftests/cachestat/test_cachestat.c |  1 +
  .../selftests/filesystems/overlayfs/dev_in_maps.c  |  1 +
  tools/testing/selftests/ftrace/config              | 26 ++++++++++++++++------
  .../ftrace/test.d/dynevent/test_duplicates.tc      |  2 +-
  .../ftrace/test.d/filter/event-filter-function.tc  | 20 ++++++++++++++++-
  .../ftrace/test.d/kprobe/kprobe_eventname.tc       |  3 ++-
  tools/testing/selftests/futex/Makefile             |  2 --
  tools/testing/selftests/futex/functional/Makefile  |  2 +-
  .../selftests/futex/functional/futex_requeue_pi.c  |  2 +-
  tools/testing/selftests/openat2/openat2_test.c     |  1 +
  11 files changed, 47 insertions(+), 15 deletions(-)
----------------------------------------------------------------
--------------Idb85KJdyIJT2x3dxATbdFZe
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.10-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.10-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Fsc2EvTWFrZWZpbGUgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9hbHNhL01ha2VmaWxlCmluZGV4IDVhZjliYThhNDY0
NS4uYzFjZTM5ODc0ZTJiIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9h
bHNhL01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Fsc2EvTWFrZWZp
bGUKQEAgLTEsNyArMSw3IEBACiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
CiAjCiAKLUNGTEFHUyArPSAkKHNoZWxsIHBrZy1jb25maWcgLS1jZmxhZ3MgYWxzYSkKK0NG
TEFHUyArPSAkKHNoZWxsIHBrZy1jb25maWcgLS1jZmxhZ3MgYWxzYSkgJChLSERSX0lOQ0xV
REVTKQogTERMSUJTICs9ICQoc2hlbGwgcGtnLWNvbmZpZyAtLWxpYnMgYWxzYSkKIGlmZXEg
KCQoTERMSUJTKSwpCiBMRExJQlMgKz0gLWxhc291bmQKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2NhY2hlc3RhdC90ZXN0X2NhY2hlc3RhdC5jIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvY2FjaGVzdGF0L3Rlc3RfY2FjaGVzdGF0LmMKaW5kZXggYjE3MWZk
NTNiMDA0Li42MzJhYjQ0NzM3ZWMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2NhY2hlc3RhdC90ZXN0X2NhY2hlc3RhdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2NhY2hlc3RhdC90ZXN0X2NhY2hlc3RhdC5jCkBAIC0xLDUgKzEsNiBAQAogLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKICNkZWZpbmUgX0dOVV9TT1VSQ0UK
KyNkZWZpbmUgX19TQU5FX1VTRVJTUEFDRV9UWVBFU19fIC8vIFVzZSBsbDY0CiAKICNpbmNs
dWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHN0ZGJvb2wuaD4KZGlmZiAtLWdpdCBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL292ZXJsYXlmcy9kZXZfaW5fbWFwcy5j
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZmlsZXN5c3RlbXMvb3ZlcmxheWZzL2Rldl9p
bl9tYXBzLmMKaW5kZXggNzU5Zjg2ZTdkMjYzLi4yODYyYWFlNThiNzkgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL292ZXJsYXlmcy9kZXZfaW5f
bWFwcy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2ZpbGVzeXN0ZW1zL292ZXJs
YXlmcy9kZXZfaW5fbWFwcy5jCkBAIC0xLDUgKzEsNiBAQAogLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAKICNkZWZpbmUgX0dOVV9TT1VSQ0UKKyNkZWZpbmUgX19TQU5F
X1VTRVJTUEFDRV9UWVBFU19fIC8vIFVzZSBsbDY0CiAKICNpbmNsdWRlIDxpbnR0eXBlcy5o
PgogI2luY2x1ZGUgPHVuaXN0ZC5oPgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvZnRyYWNlL2NvbmZpZyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9j
b25maWcKaW5kZXggZTU5ZDk4NWVlZmYwLi4wNDhhMzEyYWJmNDAgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS9jb25maWcKKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvZnRyYWNlL2NvbmZpZwpAQCAtMSwxNiArMSwyOCBAQAotQ09ORklHX0tQ
Uk9CRVM9eQorQ09ORklHX0JQRl9TWVNDQUxMPXkKK0NPTkZJR19ERUJVR19JTkZPX0JURj15
CitDT05GSUdfREVCVUdfSU5GT19EV0FSRjQ9eQorQ09ORklHX0VQUk9CRV9FVkVOVFM9eQor
Q09ORklHX0ZQUk9CRT15CitDT05GSUdfRlBST0JFX0VWRU5UUz15CiBDT05GSUdfRlRSQUNF
PXkKK0NPTkZJR19GVFJBQ0VfU1lTQ0FMTFM9eQorQ09ORklHX0ZVTkNUSU9OX0dSQVBIX1JF
VFZBTD15CiBDT05GSUdfRlVOQ1RJT05fUFJPRklMRVI9eQotQ09ORklHX1RSQUNFUl9TTkFQ
U0hPVD15Ci1DT05GSUdfU1RBQ0tfVFJBQ0VSPXkKIENPTkZJR19ISVNUX1RSSUdHRVJTPXkK
LUNPTkZJR19TQ0hFRF9UUkFDRVI9eQotQ09ORklHX1BSRUVNUFRfVFJBQ0VSPXkKIENPTkZJ
R19JUlFTT0ZGX1RSQUNFUj15Ci1DT05GSUdfUFJFRU1QVElSUV9ERUxBWV9URVNUPW0KK0NP
TkZJR19LQUxMU1lNU19BTEw9eQorQ09ORklHX0tQUk9CRVM9eQorQ09ORklHX0tQUk9CRV9F
VkVOVFM9eQogQ09ORklHX01PRFVMRVM9eQogQ09ORklHX01PRFVMRV9VTkxPQUQ9eQorQ09O
RklHX1BSRUVNUFRJUlFfREVMQVlfVEVTVD1tCitDT05GSUdfUFJFRU1QVF9UUkFDRVI9eQor
Q09ORklHX1BST0JFX0VWRU5UU19CVEZfQVJHUz15CiBDT05GSUdfU0FNUExFUz15CiBDT05G
SUdfU0FNUExFX0ZUUkFDRV9ESVJFQ1Q9bQogQ09ORklHX1NBTVBMRV9UUkFDRV9QUklOVEs9
bQotQ09ORklHX0tBTExTWU1TX0FMTD15CitDT05GSUdfU0NIRURfVFJBQ0VSPXkKK0NPTkZJ
R19TVEFDS19UUkFDRVI9eQorQ09ORklHX1RSQUNFUl9TTkFQU0hPVD15CitDT05GSUdfVVBS
T0JFUz15CitDT05GSUdfVVBST0JFX0VWRU5UUz15CmRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2R5bmV2ZW50L3Rlc3RfZHVwbGljYXRlcy50
YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZHluZXZlbnQvdGVz
dF9kdXBsaWNhdGVzLnRjCmluZGV4IGQzYTc5ZGEyMTVjOC4uNWY3MmFiZTZmYTc5IDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2R5bmV2ZW50
L3Rlc3RfZHVwbGljYXRlcy50YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJh
Y2UvdGVzdC5kL2R5bmV2ZW50L3Rlc3RfZHVwbGljYXRlcy50YwpAQCAtMSw3ICsxLDcgQEAK
ICMhL2Jpbi9zaAogIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAogIyBkZXNj
cmlwdGlvbjogR2VuZXJpYyBkeW5hbWljIGV2ZW50IC0gY2hlY2sgaWYgZHVwbGljYXRlIGV2
ZW50cyBhcmUgY2F1Z2h0Ci0jIHJlcXVpcmVzOiBkeW5hbWljX2V2ZW50cyAiZVs6Wzxncm91
cD4vXVs8ZXZlbnQ+XV0gPGF0dGFjaGVkLWdyb3VwPi48YXR0YWNoZWQtZXZlbnQ+IFs8YXJn
cz5dIjpSRUFETUUKKyMgcmVxdWlyZXM6IGR5bmFtaWNfZXZlbnRzICJlWzpbPGdyb3VwPi9d
WzxldmVudD5dXSA8YXR0YWNoZWQtZ3JvdXA+LjxhdHRhY2hlZC1ldmVudD4gWzxhcmdzPl0i
OlJFQURNRSBldmVudHMvc3lzY2FsbHMvc3lzX2VudGVyX29wZW5hdAogCiBlY2hvIDAgPiBl
dmVudHMvZW5hYmxlCiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0
cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5jdGlvbi50YyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5j
dGlvbi50YwppbmRleCAzZjc0YzA5YzU2YjYuLjExODI0N2I4ZGQ4NCAxMDA2NDQKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9maWx0ZXIvZXZlbnQtZmls
dGVyLWZ1bmN0aW9uLnRjCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90
ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5jdGlvbi50YwpAQCAtMTAsNyArMTAsNiBA
QCBmYWlsKCkgeyAjbXNnCiB9CiAKIHNhbXBsZV9ldmVudHMoKSB7Ci0gICAgZWNobyA+IHRy
YWNlCiAgICAgZWNobyAxID4gZXZlbnRzL2ttZW0va21lbV9jYWNoZV9mcmVlL2VuYWJsZQog
ICAgIGVjaG8gMSA+IHRyYWNpbmdfb24KICAgICBscyA+IC9kZXYvbnVsbApAQCAtMjIsNiAr
MjEsNyBAQCBlY2hvIDAgPiB0cmFjaW5nX29uCiBlY2hvIDAgPiBldmVudHMvZW5hYmxlCiAK
IGVjaG8gIkdldCB0aGUgbW9zdCBmcmVxdWVudGx5IGNhbGxpbmcgZnVuY3Rpb24iCitlY2hv
ID4gdHJhY2UKIHNhbXBsZV9ldmVudHMKIAogdGFyZ2V0X2Z1bmM9YGNhdCB0cmFjZSB8IGdy
ZXAgLW8gJ2NhbGxfc2l0ZT1cKFteK10qXCknIHwgc2VkICdzL2NhbGxfc2l0ZT0vLycgfCBz
b3J0IHwgdW5pcSAtYyB8IHNvcnQgfCB0YWlsIC1uIDEgfCBzZWQgJ3MvXlsgMC05XSovLydg
CkBAIC0zMiw3ICszMiwxNiBAQCBlY2hvID4gdHJhY2UKIAogZWNobyAiVGVzdCBldmVudCBm
aWx0ZXIgZnVuY3Rpb24gbmFtZSIKIGVjaG8gImNhbGxfc2l0ZS5mdW5jdGlvbiA9PSAkdGFy
Z2V0X2Z1bmMiID4gZXZlbnRzL2ttZW0va21lbV9jYWNoZV9mcmVlL2ZpbHRlcgorCitzYW1w
bGVfZXZlbnRzCittYXhfcmV0cnk9MTAKK3doaWxlIFsgYGdyZXAga21lbV9jYWNoZV9mcmVl
IHRyYWNlfCB3YyAtbGAgLWVxIDAgXTsgZG8KIHNhbXBsZV9ldmVudHMKK21heF9yZXRyeT0k
KChtYXhfcmV0cnkgLSAxKSkKK2lmIFsgJG1heF9yZXRyeSAtZXEgMCBdOyB0aGVuCisJZXhp
dF9mYWlsCitmaQorZG9uZQogCiBoaXRjbnQ9YGdyZXAga21lbV9jYWNoZV9mcmVlIHRyYWNl
fCBncmVwICR0YXJnZXRfZnVuYyB8IHdjIC1sYAogbWlzc2NudD1gZ3JlcCBrbWVtX2NhY2hl
X2ZyZWUgdHJhY2V8IGdyZXAgLXYgJHRhcmdldF9mdW5jIHwgd2MgLWxgCkBAIC00OSw3ICs1
OCwxNiBAQCBhZGRyZXNzPWBncmVwICIgJHt0YXJnZXRfZnVuY31cJCIgL3Byb2Mva2FsbHN5
bXMgfCBjdXQgLWQnICcgLWYxYAogCiBlY2hvICJUZXN0IGV2ZW50IGZpbHRlciBmdW5jdGlv
biBhZGRyZXNzIgogZWNobyAiY2FsbF9zaXRlLmZ1bmN0aW9uID09IDB4JGFkZHJlc3MiID4g
ZXZlbnRzL2ttZW0va21lbV9jYWNoZV9mcmVlL2ZpbHRlcgorZWNobyA+IHRyYWNlCitzYW1w
bGVfZXZlbnRzCittYXhfcmV0cnk9MTAKK3doaWxlIFsgYGdyZXAga21lbV9jYWNoZV9mcmVl
IHRyYWNlfCB3YyAtbGAgLWVxIDAgXTsgZG8KIHNhbXBsZV9ldmVudHMKK21heF9yZXRyeT0k
KChtYXhfcmV0cnkgLSAxKSkKK2lmIFsgJG1heF9yZXRyeSAtZXEgMCBdOyB0aGVuCisJZXhp
dF9mYWlsCitmaQorZG9uZQogCiBoaXRjbnQ9YGdyZXAga21lbV9jYWNoZV9mcmVlIHRyYWNl
fCBncmVwICR0YXJnZXRfZnVuYyB8IHdjIC1sYAogbWlzc2NudD1gZ3JlcCBrbWVtX2NhY2hl
X2ZyZWUgdHJhY2V8IGdyZXAgLXYgJHRhcmdldF9mdW5jIHwgd2MgLWxgCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2twcm9iZS9rcHJvYmVf
ZXZlbnRuYW1lLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9r
cHJvYmUva3Byb2JlX2V2ZW50bmFtZS50YwppbmRleCAxZjY5ODFlZjdhZmEuLmJhMTliODFj
ZWYzOSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3Qu
ZC9rcHJvYmUva3Byb2JlX2V2ZW50bmFtZS50YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9mdHJhY2UvdGVzdC5kL2twcm9iZS9rcHJvYmVfZXZlbnRuYW1lLnRjCkBAIC0zMCw3
ICszMCw4IEBAIGZpbmRfZG90X2Z1bmMoKSB7CiAJZmkKIAogCWdyZXAgIiBbdFRdIC4qXC5p
c3JhXC4uKiIgL3Byb2Mva2FsbHN5bXMgfCBjdXQgLWYgMyAtZCAiICIgfCB3aGlsZSByZWFk
IGY7IGRvCi0JCWlmIGdyZXAgLXMgJGYgYXZhaWxhYmxlX2ZpbHRlcl9mdW5jdGlvbnM7IHRo
ZW4KKwkJY250PWBncmVwIC1zICRmIGF2YWlsYWJsZV9maWx0ZXJfZnVuY3Rpb25zIHwgd2Mg
LWxgOworCQlpZiBbICRjbnQgLWVxIDEgXTsgdGhlbgogCQkJZWNobyAkZgogCQkJYnJlYWsK
IAkJZmkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L01ha2Vm
aWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvTWFrZWZpbGUKaW5kZXggMTFl
MTU3ZDc1MzNiLi43OGFiMmNkMTExZjYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Z1dGV4L01ha2VmaWxlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1
dGV4L01ha2VmaWxlCkBAIC0zLDggKzMsNiBAQCBTVUJESVJTIDo9IGZ1bmN0aW9uYWwKIAog
VEVTVF9QUk9HUyA6PSBydW4uc2gKIAotLlBIT05ZOiBhbGwgY2xlYW4KLQogaW5jbHVkZSAu
Li9saWIubWsKIAogYWxsOgpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZnV0ZXgvZnVuY3Rpb25hbC9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1
dGV4L2Z1bmN0aW9uYWwvTWFrZWZpbGUKaW5kZXggYTM5MmQwOTE3YjRlLi45OTRmYTM0Njhm
MTcgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9u
YWwvTWFrZWZpbGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnV0ZXgvZnVuY3Rp
b25hbC9NYWtlZmlsZQpAQCAtMSw2ICsxLDYgQEAKICMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAKIElOQ0xVREVTIDo9IC1JLi4vaW5jbHVkZSAtSS4uLy4uLyAkKEtIRFJf
SU5DTFVERVMpCi1DRkxBR1MgOj0gJChDRkxBR1MpIC1nIC1PMiAtV2FsbCAtRF9HTlVfU09V
UkNFIC1wdGhyZWFkICQoSU5DTFVERVMpICQoS0hEUl9JTkNMVURFUykKK0NGTEFHUyA6PSAk
KENGTEFHUykgLWcgLU8yIC1XYWxsIC1EX0dOVV9TT1VSQ0U9IC1wdGhyZWFkICQoSU5DTFVE
RVMpICQoS0hEUl9JTkNMVURFUykKIExETElCUyA6PSAtbHB0aHJlYWQgLWxydAogCiBMT0NB
TF9IRFJTIDo9IFwKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z1dGV4
L2Z1bmN0aW9uYWwvZnV0ZXhfcmVxdWV1ZV9waS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvZnV0ZXgvZnVuY3Rpb25hbC9mdXRleF9yZXF1ZXVlX3BpLmMKaW5kZXggN2YzY2E1Yzc4
ZGYxLi4yMTVjNmNiNTM5YjQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z1dGV4L2Z1bmN0aW9uYWwvZnV0ZXhfcmVxdWV1ZV9waS5jCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2Z1dGV4L2Z1bmN0aW9uYWwvZnV0ZXhfcmVxdWV1ZV9waS5jCkBAIC0z
NjAsNyArMzYwLDcgQEAgaW50IHVuaXRfdGVzdChpbnQgYnJvYWRjYXN0LCBsb25nIGxvY2ss
IGludCB0aGlyZF9wYXJ0eV9vd25lciwgbG9uZyB0aW1lb3V0X25zKQogCiBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQogewotCWNvbnN0IGNoYXIgKnRlc3RfbmFtZTsKKwlj
aGFyICp0ZXN0X25hbWU7CiAJaW50IGMsIHJldDsKIAogCXdoaWxlICgoYyA9IGdldG9wdChh
cmdjLCBhcmd2LCAiYmNobG90OnY6IikpICE9IC0xKSB7CmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9vcGVuYXQyL29wZW5hdDJfdGVzdC5jIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvb3BlbmF0Mi9vcGVuYXQyX3Rlc3QuYwppbmRleCA5MDI0NzU0NTMwYjIu
LjU3OTBhYjQ0NjUyNyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvb3Bl
bmF0Mi9vcGVuYXQyX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9vcGVu
YXQyL29wZW5hdDJfdGVzdC5jCkBAIC01LDYgKzUsNyBAQAogICovCiAKICNkZWZpbmUgX0dO
VV9TT1VSQ0UKKyNkZWZpbmUgX19TQU5FX1VTRVJTUEFDRV9UWVBFU19fIC8vIFVzZSBsbDY0
CiAjaW5jbHVkZSA8ZmNudGwuaD4KICNpbmNsdWRlIDxzY2hlZC5oPgogI2luY2x1ZGUgPHN5
cy9zdGF0Lmg+Cg==

--------------Idb85KJdyIJT2x3dxATbdFZe--


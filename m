Return-Path: <linux-kselftest+bounces-29851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B8A728F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 04:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A22D7A64A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC8198E91;
	Thu, 27 Mar 2025 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TGjJlmSr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4F133987
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743044712; cv=none; b=axhA3tAMrXwzW9/qLUyQMANCchObqo68KbI/K4fO6mUtQkFRfQq9IrImse4o28t/okea3K3i7E3i0fsGT7N5Bx2wTnM3AmHGF9BJOO38FktMEvunp3aUvTIiKZxE/kTv8TJxuhPSbnEodzKrySdGTTgwjkhyghqWkBhM0xCUUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743044712; c=relaxed/simple;
	bh=xaiyb+43kpLQiTaQFl7k4Q9WcQ1x12uqBToBSPpceXQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=b9GVVOkc5DFD+vuKBgx94dxSmXnrvS6iZr3E8odJbev5rDp0glXap0nkRPQfvznXCPhdZQdgT21CZ5p62a+s3kpFPcz6kw8t5AXZHH596wOs9dZWNXSIssolnIgA4Kps0BCF4+3sV8Op313lJXYGbMtAPwI121YnGnKaRq0u9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TGjJlmSr; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso3676625ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743044709; x=1743649509; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vER9VzyQlD5GTKqM8LcyXr9AQyXPj9zGCWDvSyU8x44=;
        b=TGjJlmSr+hH3ttZwwd0sdSvd+ckS/KmIgxiuBq/TgXR//x64VdpwYP55L7wEltfcKF
         ST9KXStEaELaFFHfwAsh8fE8XSoipyFkU28FsdhvcOp3alDnm22RIMhjd4YdvBhFWxR2
         Ts7SsrwXE69bzrPiS3zCYtE9H2VV1udF9EMrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743044709; x=1743649509;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vER9VzyQlD5GTKqM8LcyXr9AQyXPj9zGCWDvSyU8x44=;
        b=mLHY9JZ0+JIhmR8DkhO0JcZM65KixWOqoQq3VMEnz1TTuS8ypNnkfqtxPcUnjGx7XY
         kX0wD2Tamc5IPk373XUJLzsVAsHv2H15INWytEH08ftjC8GbbSuLUUmtPsoW2WQ6ckHQ
         RgjvhVzRz0mWMrz2Z+qITLl9U11mtM/GW+n2FAFWf0fBg/UVHsghb0coASMZTLY2SoWx
         dJoai92SDESwYlSWw1VsR21WWsVCmnXlQ+MlxVByLqmBTSt+GHarabmsnoIrKmuKxn6l
         xsfcysZ5uHqQp21NtbEBvuYxebNCJY36LX563QxPuVvwywn0Wh9tuQXPiEbZbSLs/aUk
         ACLg==
X-Forwarded-Encrypted: i=1; AJvYcCUBzy4A5bOwmc73DD+IXbmoYQwhRqaaG60pXyApCcLBwY0cNmK1o6LkLoF/0+Ad/sinNWqMCf+dIwfFygH99K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziyN41FduC7nOMJsd2lze/zAfYDttq7lVaFlaxq+oi90zXPU8j
	UtOqB06ESCfaNj92tuzS/4g5nYekP9eCNPr41gkLg2KE8PKhfi9A3wVg39Ubajs=
X-Gm-Gg: ASbGnctV/FDxRQN7iIo8T9/IRmzWcivYpLMZkcdNqzNIAk24mweHkWdf5dLVHGm2ask
	N+zxbXhsZOYwM0QTe+SrOLoPCK/aSvZCw6u1r8JQXjLxSQEe8NzDRNWHCHf/blqFW5kqW1OB0bk
	y5mcTk30jqplHlXbM3hyE9oL2tPP4Tu+b941JcX+h8zlfd+65sxOZYg6Y24PJvLAeDtviXGa7vM
	fI6iaacKT8Q0f1ngo0NePo0iFTW9vti6gTJVx/J3Qwi4TbgXDHKCmgNDVflr7Ag9WX0vC9cxxY7
	Ir9PvZI/+51K9NMzzxmpeCFCG6e9kwC2fJ1XvzAjhbEwjWSiyvTqm0ldwlR3VYnZMpMr4SQUFRe
	WTjvn4MF59Byd7FR0+epgigt/TGE=
X-Google-Smtp-Source: AGHT+IFvYsmFPjIAvF6zdgV5MREAu/X7Lbn/j8zq0F/eLHT5LR/e210sE+aarUjqFQ9uyYHqnoakdw==
X-Received: by 2002:a05:6e02:3e03:b0:3a7:88f2:cfa9 with SMTP id e9e14a558f8ab-3d5ccdde20fmr24199955ab.11.1743044709211;
        Wed, 26 Mar 2025 20:05:09 -0700 (PDT)
Received: from ?IPV6:2607:fb90:350f:48e4:8567:efb1:9883:10ae? ([2607:fb90:350f:48e4:8567:efb1:9883:10ae])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb4728sm3134805173.19.2025.03.26.20.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 20:05:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1yMU2QgZ0q3U0KcWQDaBw4Qg"
Message-ID: <2bc29da1-5c77-45a4-ab75-7afc6f9210be@linuxfoundation.org>
Date: Wed, 26 Mar 2025 21:05:06 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kunit next update for Linux 6.15-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook
 <keescook@chromium.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>

This is a multi-part message in MIME format.
--------------1yMU2QgZ0q3U0KcWQDaBw4Qg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following kunit next update for Linux 6.15-rc1.

kunit tool:
- Changes to kunit tool to use qboot on QEMU x86_64, and build GDB scripts.
- Fixes kunit tool bug in parsing test plan.
- Adds test to kunit tool to check parsing late test plan.

kunit:
- Clarifies kunit_skip() argument name.
- Adds Kunit check for the longest symbol length.
- Changes qemu_configs for sparc to use Zilog console.

Conflicts in lib/Makefile

between commit:

   b341f6fd45ab ("blackhole_dev: convert self-test to KUnit")

from the net-next tree and commit:

   c104c16073b7 ("Kunit to check the longest symbol length")

The commit c104c16073b7 conflicts with the mainline now with
62f3802332ed ("vdso: add generic time data storage") from kspp
is now in the mainline.

Stephen has the fixes for these two conflicts in next.
(Thank you Stephen)

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

   Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.15-rc1

for you to fetch changes up to 2e0cf2b32f72b20b0db5cc665cd8465d0f257278:

   kunit: tool: add test to check parsing late test plan (2025-03-15 18:13:43 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-6.15-rc1

kunit tool:
- Changes to kunit tool to use qboot on QEMU x86_64, and build GDB scripts.
- Fixes kunit tool bug in parsing test plan.
- Adds test to kunit tool to check parsing late test plan.

kunit:
- Clarifies kunit_skip() argument name.
- Adds Kunit check for the longest symbol length.
- Changes qemu_configs for sparc to use Zilog console.

----------------------------------------------------------------
Brendan Jackman (2):
       kunit: tool: Use qboot on QEMU x86_64
       kunit: tool: Build GDB scripts

Kevin Brodsky (1):
       kunit: Clarify kunit_skip() argument name

Rae Moar (2):
       kunit: tool: Fix bug in parsing test plan
       kunit: tool: add test to check parsing late test plan

Sergio González Collado (1):
       Kunit to check the longest symbol length

Thomas Weißschuh (1):
       kunit: qemu_configs: sparc: use Zilog console

  arch/x86/tools/insn_decoder_test.c         |  3 +-
  include/kunit/test.h                       | 20 ++++----
  lib/Kconfig.debug                          |  9 ++++
  lib/Makefile                               |  2 +
  lib/longest_symbol_kunit.c                 | 82 ++++++++++++++++++++++++++++++
  tools/testing/kunit/kunit_kernel.py        |  4 +-
  tools/testing/kunit/kunit_parser.py        |  9 ++--
  tools/testing/kunit/kunit_tool_test.py     | 11 ++++
  tools/testing/kunit/qemu_configs/sparc.py  |  5 +-
  tools/testing/kunit/qemu_configs/x86_64.py |  4 +-
  10 files changed, 128 insertions(+), 21 deletions(-)
  create mode 100644 lib/longest_symbol_kunit.c
----------------------------------------------------------------


--------------1yMU2QgZ0q3U0KcWQDaBw4Qg
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.15-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-6.15-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3Rvb2xzL2luc25fZGVjb2Rlcl90ZXN0LmMgYi9hcmNo
L3g4Ni90b29scy9pbnNuX2RlY29kZXJfdGVzdC5jCmluZGV4IDQ3MjU0MGFlYWJjMi4uNmMy
OTg2ZDJhZDExIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni90b29scy9pbnNuX2RlY29kZXJfdGVz
dC5jCisrKyBiL2FyY2gveDg2L3Rvb2xzL2luc25fZGVjb2Rlcl90ZXN0LmMKQEAgLTEwLDYg
KzEwLDcgQEAKICNpbmNsdWRlIDxhc3NlcnQuaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KICNp
bmNsdWRlIDxzdGRhcmcuaD4KKyNpbmNsdWRlIDxsaW51eC9rYWxsc3ltcy5oPgogCiAjZGVm
aW5lIHVubGlrZWx5KGNvbmQpIChjb25kKQogCkBAIC0xMDYsNyArMTA3LDcgQEAgc3RhdGlj
IHZvaWQgcGFyc2VfYXJncyhpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJfQogfQogCi0jZGVm
aW5lIEJVRlNJWkUgMjU2CisjZGVmaW5lIEJVRlNJWkUgKDI1NiArIEtTWU1fTkFNRV9MRU4p
CiAKIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIHsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0LmgKaW5kZXggNThkYmFi
NjBmODUzLi4wZmZiOTdjNzg1NjYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUva3VuaXQvdGVzdC5o
CisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC01NTMsOSArNTUzLDkgQEAgdm9pZCBr
dW5pdF9jbGVhbnVwKHN0cnVjdCBrdW5pdCAqdGVzdCk7CiB2b2lkIF9fcHJpbnRmKDIsIDMp
IGt1bml0X2xvZ19hcHBlbmQoc3RydWN0IHN0cmluZ19zdHJlYW0gKmxvZywgY29uc3QgY2hh
ciAqZm10LCAuLi4pOwogCiAvKioKLSAqIGt1bml0X21hcmtfc2tpcHBlZCgpIC0gTWFya3Mg
QHRlc3Rfb3Jfc3VpdGUgYXMgc2tpcHBlZAorICoga3VuaXRfbWFya19za2lwcGVkKCkgLSBN
YXJrcyBAdGVzdCBhcyBza2lwcGVkCiAgKgotICogQHRlc3Rfb3Jfc3VpdGU6IFRoZSB0ZXN0
IGNvbnRleHQgb2JqZWN0LgorICogQHRlc3Q6IFRoZSB0ZXN0IGNvbnRleHQgb2JqZWN0Lgog
ICogQGZtdDogIEEgcHJpbnRrKCkgc3R5bGUgZm9ybWF0IHN0cmluZy4KICAqCiAgKiBNYXJr
cyB0aGUgdGVzdCBhcyBza2lwcGVkLiBAZm10IGlzIGdpdmVuIG91dHB1dCBhcyB0aGUgdGVz
dCBzdGF0dXMKQEAgLTU2MywxOCArNTYzLDE4IEBAIHZvaWQgX19wcmludGYoMiwgMykga3Vu
aXRfbG9nX2FwcGVuZChzdHJ1Y3Qgc3RyaW5nX3N0cmVhbSAqbG9nLCBjb25zdCBjaGFyICpm
bXQsCiAgKgogICogVGVzdCBleGVjdXRpb24gY29udGludWVzIGFmdGVyIGt1bml0X21hcmtf
c2tpcHBlZCgpIGlzIGNhbGxlZC4KICAqLwotI2RlZmluZSBrdW5pdF9tYXJrX3NraXBwZWQo
dGVzdF9vcl9zdWl0ZSwgZm10LCAuLi4pCQkJXAorI2RlZmluZSBrdW5pdF9tYXJrX3NraXBw
ZWQodGVzdCwgZm10LCAuLi4pCQkJCVwKIAlkbyB7CQkJCQkJCQlcCi0JCVdSSVRFX09OQ0Uo
KHRlc3Rfb3Jfc3VpdGUpLT5zdGF0dXMsIEtVTklUX1NLSVBQRUQpOwlcCi0JCXNjbnByaW50
ZigodGVzdF9vcl9zdWl0ZSktPnN0YXR1c19jb21tZW50LAkJXAorCQlXUklURV9PTkNFKCh0
ZXN0KS0+c3RhdHVzLCBLVU5JVF9TS0lQUEVEKTsJCVwKKwkJc2NucHJpbnRmKCh0ZXN0KS0+
c3RhdHVzX2NvbW1lbnQsCQkJXAogCQkJICBLVU5JVF9TVEFUVVNfQ09NTUVOVF9TSVpFLAkJ
CVwKIAkJCSAgZm10LCAjI19fVkFfQVJHU19fKTsJCQkJXAogCX0gd2hpbGUgKDApCiAKIC8q
KgotICoga3VuaXRfc2tpcCgpIC0gTWFya3MgQHRlc3Rfb3Jfc3VpdGUgYXMgc2tpcHBlZAor
ICoga3VuaXRfc2tpcCgpIC0gTWFya3MgQHRlc3QgYXMgc2tpcHBlZAogICoKLSAqIEB0ZXN0
X29yX3N1aXRlOiBUaGUgdGVzdCBjb250ZXh0IG9iamVjdC4KKyAqIEB0ZXN0OiBUaGUgdGVz
dCBjb250ZXh0IG9iamVjdC4KICAqIEBmbXQ6ICBBIHByaW50aygpIHN0eWxlIGZvcm1hdCBz
dHJpbmcuCiAgKgogICogU2tpcHMgdGhlIHRlc3QuIEBmbXQgaXMgZ2l2ZW4gb3V0cHV0IGFz
IHRoZSB0ZXN0IHN0YXR1cwpAQCAtNTgyLDEwICs1ODIsMTAgQEAgdm9pZCBfX3ByaW50Zigy
LCAzKSBrdW5pdF9sb2dfYXBwZW5kKHN0cnVjdCBzdHJpbmdfc3RyZWFtICpsb2csIGNvbnN0
IGNoYXIgKmZtdCwKICAqCiAgKiBUZXN0IGV4ZWN1dGlvbiBpcyBoYWx0ZWQgYWZ0ZXIga3Vu
aXRfc2tpcCgpIGlzIGNhbGxlZC4KICAqLwotI2RlZmluZSBrdW5pdF9za2lwKHRlc3Rfb3Jf
c3VpdGUsIGZtdCwgLi4uKQkJCQlcCisjZGVmaW5lIGt1bml0X3NraXAodGVzdCwgZm10LCAu
Li4pCQkJCQlcCiAJZG8gewkJCQkJCQkJXAotCQlrdW5pdF9tYXJrX3NraXBwZWQoKHRlc3Rf
b3Jfc3VpdGUpLCBmbXQsICMjX19WQV9BUkdTX18pO1wKLQkJa3VuaXRfdHJ5X2NhdGNoX3Ro
cm93KCYoKHRlc3Rfb3Jfc3VpdGUpLT50cnlfY2F0Y2gpKTsJXAorCQlrdW5pdF9tYXJrX3Nr
aXBwZWQoKHRlc3QpLCBmbXQsICMjX19WQV9BUkdTX18pOwkJXAorCQlrdW5pdF90cnlfY2F0
Y2hfdGhyb3coJigodGVzdCktPnRyeV9jYXRjaCkpOwkJXAogCX0gd2hpbGUgKDApCiAKIC8q
CmRpZmYgLS1naXQgYS9saWIvS2NvbmZpZy5kZWJ1ZyBiL2xpYi9LY29uZmlnLmRlYnVnCmlu
ZGV4IDFhZjk3MmE5MmQwNi4uNjJkNDNhYTllOGYwIDEwMDY0NAotLS0gYS9saWIvS2NvbmZp
Zy5kZWJ1ZworKysgYi9saWIvS2NvbmZpZy5kZWJ1ZwpAQCAtMjgzOCw2ICsyODM4LDE1IEBA
IGNvbmZpZyBGT1JUSUZZX0tVTklUX1RFU1QKIAkgIGJ5IHRoZSBzdHIqKCkgYW5kIG1lbSoo
KSBmYW1pbHkgb2YgZnVuY3Rpb25zLiBGb3IgdGVzdGluZyBydW50aW1lCiAJICB0cmFwcyBv
ZiBGT1JUSUZZX1NPVVJDRSwgc2VlIExLRFRNJ3MgIkZPUlRJRllfKiIgdGVzdHMuCiAKK2Nv
bmZpZyBMT05HRVNUX1NZTV9LVU5JVF9URVNUCisJdHJpc3RhdGUgIlRlc3QgdGhlIGxvbmdl
c3Qgc3ltYm9sIHBvc3NpYmxlIiBpZiAhS1VOSVRfQUxMX1RFU1RTCisJZGVwZW5kcyBvbiBL
VU5JVCAmJiBLUFJPQkVTCisJZGVmYXVsdCBLVU5JVF9BTExfVEVTVFMKKwloZWxwCisJICBU
ZXN0cyB0aGUgbG9uZ2VzdCBzeW1ib2wgcG9zc2libGUKKworCSAgSWYgdW5zdXJlLCBzYXkg
Ti4KKwogY29uZmlnIEhXX0JSRUFLUE9JTlRfS1VOSVRfVEVTVAogCWJvb2wgIlRlc3QgaHdf
YnJlYWtwb2ludCBjb25zdHJhaW50cyBhY2NvdW50aW5nIiBpZiAhS1VOSVRfQUxMX1RFU1RT
CiAJZGVwZW5kcyBvbiBIQVZFX0hXX0JSRUFLUE9JTlQKZGlmZiAtLWdpdCBhL2xpYi9NYWtl
ZmlsZSBiL2xpYi9NYWtlZmlsZQppbmRleCBkNWNmYzdhZmJiYjguLmU4ZmVjOWRlZmVjMiAx
MDA2NDQKLS0tIGEvbGliL01ha2VmaWxlCisrKyBiL2xpYi9NYWtlZmlsZQpAQCAtMzkzLDYg
KzM5Myw4IEBAIG9iai0kKENPTkZJR19GT1JUSUZZX0tVTklUX1RFU1QpICs9IGZvcnRpZnlf
a3VuaXQubwogb2JqLSQoQ09ORklHX0NSQ19LVU5JVF9URVNUKSArPSBjcmNfa3VuaXQubwog
b2JqLSQoQ09ORklHX1NJUEhBU0hfS1VOSVRfVEVTVCkgKz0gc2lwaGFzaF9rdW5pdC5vCiBv
YmotJChDT05GSUdfVVNFUkNPUFlfS1VOSVRfVEVTVCkgKz0gdXNlcmNvcHlfa3VuaXQubwor
b2JqLSQoQ09ORklHX0xPTkdFU1RfU1lNX0tVTklUX1RFU1QpICs9IGxvbmdlc3Rfc3ltYm9s
X2t1bml0Lm8KK0NGTEFHU19sb25nZXN0X3N5bWJvbF9rdW5pdC5vICs9ICQoY2FsbCBjYy1k
aXNhYmxlLXdhcm5pbmcsIG1pc3NpbmctcHJvdG90eXBlcykKIAogb2JqLSQoQ09ORklHX0dF
TkVSSUNfTElCX0RFVk1FTV9JU19BTExPV0VEKSArPSBkZXZtZW1faXNfYWxsb3dlZC5vCiAK
ZGlmZiAtLWdpdCBhL2xpYi9sb25nZXN0X3N5bWJvbF9rdW5pdC5jIGIvbGliL2xvbmdlc3Rf
c3ltYm9sX2t1bml0LmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAw
Li5lM2MyOGZmMTgwN2YKLS0tIC9kZXYvbnVsbAorKysgYi9saWIvbG9uZ2VzdF9zeW1ib2xf
a3VuaXQuYwpAQCAtMCwwICsxLDgyIEBACisvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMAorLyoKKyAqIFRlc3QgdGhlIGxvbmdlc3Qgc3ltYm9sIGxlbmd0aC4gRXhlY3V0
ZSB3aXRoOgorICogIC4vdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdC5weSBydW4gbG9uZ2Vz
dC1zeW1ib2wKKyAqICAtLWFyY2g9eDg2XzY0IC0ta2NvbmZpZ19hZGQgQ09ORklHX0tQUk9C
RVM9eSAtLWtjb25maWdfYWRkIENPTkZJR19NT0RVTEVTPXkKKyAqICAtLWtjb25maWdfYWRk
IENPTkZJR19SRVRQT0xJTkU9biAtLWtjb25maWdfYWRkIENPTkZJR19DRklfQ0xBTkc9bgor
ICogIC0ta2NvbmZpZ19hZGQgQ09ORklHX01JVElHQVRJT05fUkVUUE9MSU5FPW4KKyAqLwor
CisjZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9NT0ROQU1FICI6ICIgZm10CisKKyNpbmNs
dWRlIDxrdW5pdC90ZXN0Lmg+CisjaW5jbHVkZSA8bGludXgvc3RyaW5naWZ5Lmg+CisjaW5j
bHVkZSA8bGludXgva3Byb2Jlcy5oPgorI2luY2x1ZGUgPGxpbnV4L2thbGxzeW1zLmg+CisK
KyNkZWZpbmUgREkobmFtZSkgcyMjbmFtZSMjbmFtZQorI2RlZmluZSBEREkobmFtZSkgREko
biMjbmFtZSMjbmFtZSkKKyNkZWZpbmUgRERESShuYW1lKSBEREkobiMjbmFtZSMjbmFtZSkK
KyNkZWZpbmUgREREREkobmFtZSkgRERESShuIyNuYW1lIyNuYW1lKQorI2RlZmluZSBERERE
REkobmFtZSkgREREREkobiMjbmFtZSMjbmFtZSkKKworLypHZW5lcmF0ZSBhIHN5bWJvbCB3
aG9zZSBuYW1lIGxlbmd0aCBpcyA1MTEgKi8KKyNkZWZpbmUgTE9OR0VTVF9TWU1fTkFNRSAg
RERERERJKGcxaDJpM2o0azVsNm03bikKKworI2RlZmluZSBSRVRVUk5fTE9OR0VTVF9TWU0g
MHhBQUFBQQorCitub2lubGluZSBpbnQgTE9OR0VTVF9TWU1fTkFNRSh2b2lkKTsKK25vaW5s
aW5lIGludCBMT05HRVNUX1NZTV9OQU1FKHZvaWQpCit7CisJcmV0dXJuIFJFVFVSTl9MT05H
RVNUX1NZTTsKK30KKworX1N0YXRpY19hc3NlcnQoc2l6ZW9mKF9fc3RyaW5naWZ5KExPTkdF
U1RfU1lNX05BTUUpKSA9PSBLU1lNX05BTUVfTEVOLAorIkluY29ycmVjdCBzeW1ib2wgbGVu
Z3RoIGZvdW5kLiBFeHBlY3RlZCBLU1lNX05BTUVfTEVOOiAiCitfX3N0cmluZ2lmeShLU1lN
X05BTUVfTEVOKSAiLCBidXQgZm91bmQ6ICIKK19fc3RyaW5naWZ5KHNpemVvZihMT05HRVNU
X1NZTV9OQU1FKSkpOworCitzdGF0aWMgdm9pZCB0ZXN0X2xvbmdlc3Rfc3ltYm9sKHN0cnVj
dCBrdW5pdCAqdGVzdCkKK3sKKwlLVU5JVF9FWFBFQ1RfRVEodGVzdCwgUkVUVVJOX0xPTkdF
U1RfU1lNLCBMT05HRVNUX1NZTV9OQU1FKCkpOworfTsKKworc3RhdGljIHZvaWQgdGVzdF9s
b25nZXN0X3N5bWJvbF9rYWxsc3ltcyhzdHJ1Y3Qga3VuaXQgKnRlc3QpCit7CisJdW5zaWdu
ZWQgbG9uZyAoKmthbGxzeW1zX2xvb2t1cF9uYW1lKShjb25zdCBjaGFyICpuYW1lKTsKKwlz
dGF0aWMgaW50ICgqbG9uZ2VzdF9zeW0pKHZvaWQpOworCisJc3RydWN0IGtwcm9iZSBrcCA9
IHsKKwkJLnN5bWJvbF9uYW1lID0gImthbGxzeW1zX2xvb2t1cF9uYW1lIiwKKwl9OworCisJ
aWYgKHJlZ2lzdGVyX2twcm9iZSgma3ApIDwgMCkgeworCQlwcl9pbmZvKCIlczoga3Byb2Jl
IG5vdCByZWdpc3RlcmVkIiwgX19mdW5jX18pOworCQlLVU5JVF9GQUlMKHRlc3QsICJ0ZXN0
X2xvbmdlc3Rfc3ltYm9sIGthbGxzeW1zOiBrcHJvYmUgbm90IHJlZ2lzdGVyZWRcbiIpOwor
CQlyZXR1cm47CisJfQorCisJa3VuaXRfd2Fybih0ZXN0LCAidGVzdF9sb25nZXN0X3N5bWJv
bCBrYWxsc3ltczoga3Byb2JlIHJlZ2lzdGVyZWRcbiIpOworCWthbGxzeW1zX2xvb2t1cF9u
YW1lID0gKHVuc2lnbmVkIGxvbmcgKCopKGNvbnN0IGNoYXIgKm5hbWUpKWtwLmFkZHI7CisJ
dW5yZWdpc3Rlcl9rcHJvYmUoJmtwKTsKKworCWxvbmdlc3Rfc3ltID0KKwkJKHZvaWQgKikg
a2FsbHN5bXNfbG9va3VwX25hbWUoX19zdHJpbmdpZnkoTE9OR0VTVF9TWU1fTkFNRSkpOwor
CUtVTklUX0VYUEVDVF9FUSh0ZXN0LCBSRVRVUk5fTE9OR0VTVF9TWU0sIGxvbmdlc3Rfc3lt
KCkpOworfTsKKworc3RhdGljIHN0cnVjdCBrdW5pdF9jYXNlIGxvbmdlc3Rfc3ltYm9sX3Rl
c3RfY2FzZXNbXSA9IHsKKwlLVU5JVF9DQVNFKHRlc3RfbG9uZ2VzdF9zeW1ib2wpLAorCUtV
TklUX0NBU0UodGVzdF9sb25nZXN0X3N5bWJvbF9rYWxsc3ltcyksCisJe30KK307CisKK3N0
YXRpYyBzdHJ1Y3Qga3VuaXRfc3VpdGUgbG9uZ2VzdF9zeW1ib2xfdGVzdF9zdWl0ZSA9IHsK
KwkubmFtZSA9ICJsb25nZXN0LXN5bWJvbCIsCisJLnRlc3RfY2FzZXMgPSBsb25nZXN0X3N5
bWJvbF90ZXN0X2Nhc2VzLAorfTsKK2t1bml0X3Rlc3Rfc3VpdGUobG9uZ2VzdF9zeW1ib2xf
dGVzdF9zdWl0ZSk7CisKK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsKK01PRFVMRV9ERVNDUklQ
VElPTigiVGVzdCB0aGUgbG9uZ2VzdCBzeW1ib2wgbGVuZ3RoIik7CitNT0RVTEVfQVVUSE9S
KCJTZXJnaW8gR29uesOhbGV6IENvbGxhZG8iKTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcva3VuaXQva3VuaXRfa2VybmVsLnB5IGIvdG9vbHMvdGVzdGluZy9rdW5pdC9rdW5pdF9r
ZXJuZWwucHkKaW5kZXggZDMwZjkwZWFlOWE0Li5kM2YzOWJjMWNlZWMgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfa2VybmVsLnB5CisrKyBiL3Rvb2xzL3Rlc3Rp
bmcva3VuaXQva3VuaXRfa2VybmVsLnB5CkBAIC03Miw4ICs3Miw4IEBAIGNsYXNzIExpbnV4
U291cmNlVHJlZU9wZXJhdGlvbnM6CiAJCQlyYWlzZSBDb25maWdFcnJvcihlLm91dHB1dC5k
ZWNvZGUoKSkKIAogCWRlZiBtYWtlKHNlbGYsIGpvYnM6IGludCwgYnVpbGRfZGlyOiBzdHIs
IG1ha2Vfb3B0aW9uczogT3B0aW9uYWxbTGlzdFtzdHJdXSkgLT4gTm9uZToKLQkJY29tbWFu
ZCA9IFsnbWFrZScsICdhbGwnLCAnY29tcGlsZV9jb21tYW5kcy5qc29uJywgJ0FSQ0g9JyAr
IHNlbGYuX2xpbnV4X2FyY2gsCi0JCQkgICAnTz0nICsgYnVpbGRfZGlyLCAnLS1qb2JzPScg
KyBzdHIoam9icyldCisJCWNvbW1hbmQgPSBbJ21ha2UnLCAnYWxsJywgJ2NvbXBpbGVfY29t
bWFuZHMuanNvbicsICdzY3JpcHRzX2dkYicsCisJCQkgICAnQVJDSD0nICsgc2VsZi5fbGlu
dXhfYXJjaCwgJ089JyArIGJ1aWxkX2RpciwgJy0tam9icz0nICsgc3RyKGpvYnMpXQogCQlp
ZiBtYWtlX29wdGlvbnM6CiAJCQljb21tYW5kLmV4dGVuZChtYWtlX29wdGlvbnMpCiAJCWlm
IHNlbGYuX2Nyb3NzX2NvbXBpbGU6CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL2t1bml0
L2t1bml0X3BhcnNlci5weSBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfcGFyc2VyLnB5
CmluZGV4IDI5ZmMyN2U4OTQ5Yi4uZGE1M2E3MDk3NzNhIDEwMDY0NAotLS0gYS90b29scy90
ZXN0aW5nL2t1bml0L2t1bml0X3BhcnNlci5weQorKysgYi90b29scy90ZXN0aW5nL2t1bml0
L2t1bml0X3BhcnNlci5weQpAQCAtNzU5LDcgKzc1OSw3IEBAIGRlZiBwYXJzZV90ZXN0KGxp
bmVzOiBMaW5lU3RyZWFtLCBleHBlY3RlZF9udW06IGludCwgbG9nOiBMaXN0W3N0cl0sIGlz
X3N1YnRlc3Q6CiAJCSMgSWYgcGFyc2luZyB0aGUgbWFpbi90b3AtbGV2ZWwgdGVzdCwgcGFy
c2UgS1RBUCB2ZXJzaW9uIGxpbmUgYW5kCiAJCSMgdGVzdCBwbGFuCiAJCXRlc3QubmFtZSA9
ICJtYWluIgotCQlrdGFwX2xpbmUgPSBwYXJzZV9rdGFwX2hlYWRlcihsaW5lcywgdGVzdCwg
cHJpbnRlcikKKwkJcGFyc2Vfa3RhcF9oZWFkZXIobGluZXMsIHRlc3QsIHByaW50ZXIpCiAJ
CXRlc3QubG9nLmV4dGVuZChwYXJzZV9kaWFnbm9zdGljKGxpbmVzKSkKIAkJcGFyc2VfdGVz
dF9wbGFuKGxpbmVzLCB0ZXN0KQogCQlwYXJlbnRfdGVzdCA9IFRydWUKQEAgLTc2OCwxMyAr
NzY4LDEyIEBAIGRlZiBwYXJzZV90ZXN0KGxpbmVzOiBMaW5lU3RyZWFtLCBleHBlY3RlZF9u
dW06IGludCwgbG9nOiBMaXN0W3N0cl0sIGlzX3N1YnRlc3Q6CiAJCSMgdGhlIEtUQVAgdmVy
c2lvbiBsaW5lIGFuZC9vciBzdWJ0ZXN0IGhlYWRlciBsaW5lCiAJCWt0YXBfbGluZSA9IHBh
cnNlX2t0YXBfaGVhZGVyKGxpbmVzLCB0ZXN0LCBwcmludGVyKQogCQlzdWJ0ZXN0X2xpbmUg
PSBwYXJzZV90ZXN0X2hlYWRlcihsaW5lcywgdGVzdCkKKwkJdGVzdC5sb2cuZXh0ZW5kKHBh
cnNlX2RpYWdub3N0aWMobGluZXMpKQorCQlwYXJzZV90ZXN0X3BsYW4obGluZXMsIHRlc3Qp
CiAJCXBhcmVudF90ZXN0ID0gKGt0YXBfbGluZSBvciBzdWJ0ZXN0X2xpbmUpCiAJCWlmIHBh
cmVudF90ZXN0OgotCQkJIyBJZiBLVEFQIHZlcnNpb24gbGluZSBhbmQvb3Igc3VidGVzdCBo
ZWFkZXIgaXMgZm91bmQsIGF0dGVtcHQKLQkJCSMgdG8gcGFyc2UgdGVzdCBwbGFuIGFuZCBw
cmludCB0ZXN0IGhlYWRlcgotCQkJdGVzdC5sb2cuZXh0ZW5kKHBhcnNlX2RpYWdub3N0aWMo
bGluZXMpKQotCQkJcGFyc2VfdGVzdF9wbGFuKGxpbmVzLCB0ZXN0KQogCQkJcHJpbnRfdGVz
dF9oZWFkZXIodGVzdCwgcHJpbnRlcikKKwogCWV4cGVjdGVkX2NvdW50ID0gdGVzdC5leHBl
Y3RlZF9jb3VudAogCXN1YnRlc3RzID0gW10KIAl0ZXN0X251bSA9IDEKZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfdG9vbF90ZXN0LnB5IGIvdG9vbHMvdGVzdGlu
Zy9rdW5pdC9rdW5pdF90b29sX3Rlc3QucHkKaW5kZXggMGJjYjBjYzAwMmY4Li41ZmY0ZjZm
ZmQ4NzMgMTAwNzU1Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfdG9vbF90ZXN0
LnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfdG9vbF90ZXN0LnB5CkBAIC0z
NjMsNiArMzYzLDE3IEBAIGNsYXNzIEtVbml0UGFyc2VyVGVzdCh1bml0dGVzdC5UZXN0Q2Fz
ZSk6CiAJCXNlbGYucHJpbnRfbW9jay5hc3NlcnRfYW55X2NhbGwoU3RyQ29udGFpbnMoJyAg
SW5kZW50ZWQgbW9yZS4nKSkKIAkJc2VsZi5ub1ByaW50Q2FsbENvbnRhaW5zKCdub3Qgb2sg
MSB0ZXN0MScpCiAKKwlkZWYgdGVzdF9wYXJzZV9sYXRlX3Rlc3RfcGxhbihzZWxmKToKKwkJ
b3V0cHV0ID0gIiIiCisJCVRBUCB2ZXJzaW9uIDEzCisJCW9rIDQgdGVzdDQKKwkJMS4uNAor
CQkiIiIKKwkJcmVzdWx0ID0ga3VuaXRfcGFyc2VyLnBhcnNlX3J1bl90ZXN0cyhvdXRwdXQu
c3BsaXRsaW5lcygpLCBzdGRvdXQpCisJCSMgTWlzc2luZyB0ZXN0IHJlc3VsdHMgYWZ0ZXIg
dGVzdCBwbGFuIHNob3VsZCBhbGVydCBhIHN1c3BlY3RlZCB0ZXN0IGNyYXNoLgorCQlzZWxm
LmFzc2VydEVxdWFsKGt1bml0X3BhcnNlci5UZXN0U3RhdHVzLlRFU1RfQ1JBU0hFRCwgcmVz
dWx0LnN0YXR1cykKKwkJc2VsZi5hc3NlcnRFcXVhbChyZXN1bHQuY291bnRzLCBrdW5pdF9w
YXJzZXIuVGVzdENvdW50cyhwYXNzZWQ9MSwgY3Jhc2hlZD0xLCBlcnJvcnM9MSkpCisKIGRl
ZiBsaW5lX3N0cmVhbV9mcm9tX3N0cnMoc3RyczogSXRlcmFibGVbc3RyXSkgLT4ga3VuaXRf
cGFyc2VyLkxpbmVTdHJlYW06CiAJcmV0dXJuIGt1bml0X3BhcnNlci5MaW5lU3RyZWFtKGVu
dW1lcmF0ZShzdHJzLCBzdGFydD0xKSkKIApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9r
dW5pdC9xZW11X2NvbmZpZ3Mvc3BhcmMucHkgYi90b29scy90ZXN0aW5nL2t1bml0L3FlbXVf
Y29uZmlncy9zcGFyYy5weQppbmRleCBlOTc1YzQzMzFhN2MuLjI1NmQ5NTczYjQ0NiAxMDA2
NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9rdW5pdC9xZW11X2NvbmZpZ3Mvc3BhcmMucHkKKysr
IGIvdG9vbHMvdGVzdGluZy9rdW5pdC9xZW11X2NvbmZpZ3Mvc3BhcmMucHkKQEAgLTIsOCAr
Miw5IEBAIGZyb20gLi5xZW11X2NvbmZpZyBpbXBvcnQgUWVtdUFyY2hQYXJhbXMKIAogUUVN
VV9BUkNIID0gUWVtdUFyY2hQYXJhbXMobGludXhfYXJjaD0nc3BhcmMnLAogCQkJICAga2Nv
bmZpZz0nJycKLUNPTkZJR19TRVJJQUxfODI1MD15Ci1DT05GSUdfU0VSSUFMXzgyNTBfQ09O
U09MRT15JycnLAorQ09ORklHX1NFUklBTF9TVU5aSUxPRz15CitDT05GSUdfU0VSSUFMX1NV
TlpJTE9HX0NPTlNPTEU9eQorJycnLAogCQkJICAgcWVtdV9hcmNoPSdzcGFyYycsCiAJCQkg
ICBrZXJuZWxfcGF0aD0nYXJjaC9zcGFyYy9ib290L3pJbWFnZScsCiAJCQkgICBrZXJuZWxf
Y29tbWFuZF9saW5lPSdjb25zb2xlPXR0eVMwIG1lbT0yNTZNJywKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL3g4Nl82NC5weSBiL3Rvb2xzL3Rlc3Rp
bmcva3VuaXQvcWVtdV9jb25maWdzL3g4Nl82NC5weQppbmRleCBkYzc5NDkwNzY4NjMuLjRh
NmJmNGUwNDhmNSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9rdW5pdC9xZW11X2NvbmZp
Z3MveDg2XzY0LnB5CisrKyBiL3Rvb2xzL3Rlc3Rpbmcva3VuaXQvcWVtdV9jb25maWdzL3g4
Nl82NC5weQpAQCAtNyw0ICs3LDYgQEAgQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9eScn
JywKIAkJCSAgIHFlbXVfYXJjaD0neDg2XzY0JywKIAkJCSAgIGtlcm5lbF9wYXRoPSdhcmNo
L3g4Ni9ib290L2J6SW1hZ2UnLAogCQkJICAga2VybmVsX2NvbW1hbmRfbGluZT0nY29uc29s
ZT10dHlTMCcsCi0JCQkgICBleHRyYV9xZW11X3BhcmFtcz1bXSkKKwkJCSAgICMgcWJvb3Qg
aXMgZmFzdGVyIHRoYW4gU2VhQklPUyBhbmQgZG9lc24ndCBtZXNzIHVwCisJCQkgICAjIHRo
ZSB0ZXJtaW5hbC4KKwkJCSAgIGV4dHJhX3FlbXVfcGFyYW1zPVsnLWJpb3MnLCAncWJvb3Qu
cm9tJ10pCg==

--------------1yMU2QgZ0q3U0KcWQDaBw4Qg--


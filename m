Return-Path: <linux-kselftest+bounces-10139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC888C43DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1A2862DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2024 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D105CA1;
	Mon, 13 May 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ye0zy53A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90A25672
	for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613231; cv=none; b=MEd5VWIF20jfQAfDuRXQaFG2Q9obFGH+Y8XMvFgGfCchemOEh8cipXCe68b1Jo6ByTta8CbmW+HPUkA+uwEMe1TCXozPnZav8QGDHTCaZ0fyS4zlaa4nOFtGDTzUmgUmj44Grnv6eUyqYzVyCPl0w4r8WMaEtegegjxfOWz61zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613231; c=relaxed/simple;
	bh=bwxwLAiE81n3Z1yoB45RY2c8mTlYPK01k/Xno32pvA8=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=bi3Ie5D3CisFveDoLXpAtCAgUB/dNoEo2gCn4L7d0nFKbB8D03X5Q9KB47cXrwJbXIoOZAuk4Oie3DHTkpIM5JYq8YCKL2ilx5QoMobo293be+2fsMKJhmn1udtjs51UYfBqtq4OgMK+b2m/j4B84goPJxDp7a1CjUhPnTeyopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ye0zy53A; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e1d952ace4so8102839f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2024 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715613229; x=1716218029; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Y34rp11DhTo88f7ZZG+euMgHjyfBULc8fRUELw0yg=;
        b=Ye0zy53AexST0vE5fzyAuEvsIQ6EShzTVLz4mAK8Da7Fky+T+byEH5JsSD+PwqqVp/
         tnQSM/V4U6SytPIUx9eJ1d3gxHUu9pLEb1gV/z9hdfcppnhy9GREMOrN9bVpIYLmS0tG
         P/L+1DsIzolTSCBcERJajzX346teBVMl1iIyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715613229; x=1716218029;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2Y34rp11DhTo88f7ZZG+euMgHjyfBULc8fRUELw0yg=;
        b=IvgTT91XuToULjlgdvjeK6muxNdqICzRmGb2zWNNFt5VpygDi6PLDGxrWHix8AF+68
         mySVFdsD5XroOHCYq38M9Ol4bwRa/QPwZ8n7bm4NIZQseNnrid+RkRz7zdnwQ12AWWf4
         xD4tB1DopJP312iQQ+ob+XMYZo3Lxa7TzYIWmeOBNkgSNPYjhdkEzs6ARPlUbBGee8Nn
         h9V3gDEvOVNKxq6MwbR3gUNFInFwQ2BiTTRmam4L/l0cY8vao732JVv4dhFbAzM3c9cV
         +qDoxAbbr69QRFTjxvjzlqB4+mSMjMuvxxP1HB7yWEM596hibK/J6zKU1XK9xpCCxP62
         26QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmWxs1QFxCGk3tztrIcj5QWGhM22aT5/xRxJqxS8/ST2Ng/PeH0P0bywA9Wb6rANIeG7YscLeFh5dvQYB1AZGiN/qFpcqZV+b+QulcvO0g
X-Gm-Message-State: AOJu0YzP81iO5Ca+x+uQ5O8gVRiFhrfLnRc0211WYjzWIBqQrvV1R0s3
	2QlW+6InXloeunv8pKcZ49O3DwMIb3OSxLRtc3aOrjjCN55Y98oFgpRBZ6sHNkY=
X-Google-Smtp-Source: AGHT+IGnry8IAGVge2SIgEV/sy1Si+t9AN9FCzHpGStigudBNYjWS+ogphd25zvvQ3M/+YqO1rpmAw==
X-Received: by 2002:a6b:d203:0:b0:7e1:8bc8:8228 with SMTP id ca18e2360f4ac-7e1b501f23dmr1055809739f.0.1715613228793;
        Mon, 13 May 2024 08:13:48 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c0b23sm2508947173.96.2024.05.13.08.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:13:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------3h7oO02tp7Ub6Y8cOlsd370x"
Message-ID: <ddb23594-c519-4436-9219-e2f76f8c38b2@linuxfoundation.org>
Date: Mon, 13 May 2024 09:13:47 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] nolibc changes for Linux 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------3h7oO02tp7Ub6Y8cOlsd370x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the nolibc update for Linux 6.10-rc1.

This nolibc update for Linux 6.10-rc1

- adds support for uname(2)
- removes open-coded strnlen()
- exports strlen()
- adds tests for strlcat() and strlcpy()
- fixes memory error in realloc()
- fixes strlcat() return code and size usage
- fixes strlcpy() return code and size usage

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-nolibc-6.10-rc1

for you to fetch changes up to 0adab2b6b7336fb6ee3c6456a432dad3b1d25647:

   tools/nolibc: add support for uname(2) (2024-04-14 20:28:54 +0200)

----------------------------------------------------------------
linux_kselftest-nolibc-6.10-rc1

This nolibc update for Linux 6.10-rc1

- adds support for uname(2)
- removes open-coded strnlen()
- exports strlen()
- adds tests for strlcat() and strlcpy()
- fixes memory error in realloc()
- fixes strlcat() return code and size usage
- fixes strlcpy() return code and size usage

----------------------------------------------------------------
Brennan Xavier McManus (1):
       tools/nolibc/stdlib: fix memory error in realloc()

Rodrigo Campos (4):
       tools/nolibc/string: export strlen()
       tools/nolibc: Fix strlcat() return code and size usage
       tools/nolibc: Fix strlcpy() return code and size usage
       selftests/nolibc: Add tests for strlcat() and strlcpy()

Thomas Weißschuh (2):
       tools/nolibc/string: remove open-coded strnlen()
       tools/nolibc: add support for uname(2)

  tools/include/nolibc/stdlib.h                |  2 +-
  tools/include/nolibc/string.h                | 46 +++++++++-------
  tools/include/nolibc/sys.h                   | 27 +++++++++
  tools/testing/selftests/nolibc/nolibc-test.c | 82 ++++++++++++++++++++++++++++
  4 files changed, 136 insertions(+), 21 deletions(-)

----------------------------------------------------------------
--------------3h7oO02tp7Ub6Y8cOlsd370x
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-nolibc-6.10-rc1.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-nolibc-6.10-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N0ZGxpYi5oIGIvdG9vbHMvaW5j
bHVkZS9ub2xpYmMvc3RkbGliLmgKaW5kZXggYmFjZmQzNWM1MTU2Li41YmU5ZDNjNzQzNWEg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N0ZGxpYi5oCisrKyBiL3Rvb2xz
L2luY2x1ZGUvbm9saWJjL3N0ZGxpYi5oCkBAIC0xODUsNyArMTg1LDcgQEAgdm9pZCAqcmVh
bGxvYyh2b2lkICpvbGRfcHRyLCBzaXplX3QgbmV3X3NpemUpCiAJaWYgKF9fYnVpbHRpbl9l
eHBlY3QoIXJldCwgMCkpCiAJCXJldHVybiBOVUxMOwogCi0JbWVtY3B5KHJldCwgaGVhcC0+
dXNlcl9wLCBoZWFwLT5sZW4pOworCW1lbWNweShyZXQsIGhlYXAtPnVzZXJfcCwgdXNlcl9w
X2xlbik7CiAJbXVubWFwKGhlYXAsIGhlYXAtPmxlbik7CiAJcmV0dXJuIHJldDsKIH0KZGlm
ZiAtLWdpdCBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N0cmluZy5oIGIvdG9vbHMvaW5jbHVk
ZS9ub2xpYmMvc3RyaW5nLmgKaW5kZXggYTAxYzY5ZGQ0OTVmLi5mOWFiMjg0MjFlNmQgMTAw
NjQ0Ci0tLSBhL3Rvb2xzL2luY2x1ZGUvbm9saWJjL3N0cmluZy5oCisrKyBiL3Rvb2xzL2lu
Y2x1ZGUvbm9saWJjL3N0cmluZy5oCkBAIC0xMjMsNyArMTIzLDcgQEAgY2hhciAqc3RyY3B5
KGNoYXIgKmRzdCwgY29uc3QgY2hhciAqc3JjKQogICogdGh1cyBpdHNlbGYsIGhlbmNlIHRo
ZSBhc20oKSBzdGF0ZW1lbnQgYmVsb3cgdGhhdCdzIG1lYW50IHRvIGRpc2FibGUgdGhpcwog
ICogY29uZnVzaW5nIHByYWN0aWNlLgogICovCi1zdGF0aWMgX19hdHRyaWJ1dGVfXygodW51
c2VkKSkKK19fYXR0cmlidXRlX18oKHdlYWssdW51c2VkLHNlY3Rpb24oIi50ZXh0Lm5vbGli
Y19zdHJsZW4iKSkpCiBzaXplX3Qgc3RybGVuKGNvbnN0IGNoYXIgKnN0cikKIHsKIAlzaXpl
X3QgbGVuOwpAQCAtMTg3LDIyICsxODcsMjYgQEAgY2hhciAqc3RybmR1cChjb25zdCBjaGFy
ICpzdHIsIHNpemVfdCBtYXhsZW4pCiBzdGF0aWMgX19hdHRyaWJ1dGVfXygodW51c2VkKSkK
IHNpemVfdCBzdHJsY2F0KGNoYXIgKmRzdCwgY29uc3QgY2hhciAqc3JjLCBzaXplX3Qgc2l6
ZSkKIHsKLQlzaXplX3QgbGVuOwotCWNoYXIgYzsKLQotCWZvciAobGVuID0gMDsgZHN0W2xl
bl07CWxlbisrKQotCQk7Ci0KLQlmb3IgKDs7KSB7Ci0JCWMgPSAqc3JjOwotCQlpZiAobGVu
IDwgc2l6ZSkKLQkJCWRzdFtsZW5dID0gYzsKLQkJaWYgKCFjKQorCXNpemVfdCBsZW4gPSBz
dHJubGVuKGRzdCwgc2l6ZSk7CisKKwkvKgorCSAqIFdlIHdhbnQgbGVuIDwgc2l6ZS0xLiBC
dXQgYXMgc2l6ZSBpcyB1bnNpZ25lZCBhbmQgY2FuIHdyYXAKKwkgKiBhcm91bmQsIHdlIHVz
ZSBsZW4gKyAxIGluc3RlYWQuCisJICovCisJd2hpbGUgKGxlbiArIDEgPCBzaXplKSB7CisJ
CWRzdFtsZW5dID0gKnNyYzsKKwkJaWYgKCpzcmMgPT0gJ1wwJykKIAkJCWJyZWFrOwogCQls
ZW4rKzsKIAkJc3JjKys7CiAJfQogCisJaWYgKGxlbiA8IHNpemUpCisJCWRzdFtsZW5dID0g
J1wwJzsKKworCXdoaWxlICgqc3JjKyspCisJCWxlbisrOworCiAJcmV0dXJuIGxlbjsKIH0K
IApAQCAtMjEwLDE2ICsyMTQsMTggQEAgc3RhdGljIF9fYXR0cmlidXRlX18oKHVudXNlZCkp
CiBzaXplX3Qgc3RybGNweShjaGFyICpkc3QsIGNvbnN0IGNoYXIgKnNyYywgc2l6ZV90IHNp
emUpCiB7CiAJc2l6ZV90IGxlbjsKLQljaGFyIGM7CiAKLQlmb3IgKGxlbiA9IDA7Oykgewot
CQljID0gc3JjW2xlbl07Ci0JCWlmIChsZW4gPCBzaXplKQotCQkJZHN0W2xlbl0gPSBjOwot
CQlpZiAoIWMpCi0JCQlicmVhazsKLQkJbGVuKys7CisJZm9yIChsZW4gPSAwOyBsZW4gPCBz
aXplOyBsZW4rKykgeworCQlkc3RbbGVuXSA9IHNyY1tsZW5dOworCQlpZiAoIWRzdFtsZW5d
KQorCQkJcmV0dXJuIGxlbjsKIAl9CisJaWYgKHNpemUpCisJCWRzdFtzaXplLTFdID0gJ1ww
JzsKKworCXdoaWxlIChzcmNbbGVuXSkKKwkJbGVuKys7CisKIAlyZXR1cm4gbGVuOwogfQog
CmRpZmYgLS1naXQgYS90b29scy9pbmNsdWRlL25vbGliYy9zeXMuaCBiL3Rvb2xzL2luY2x1
ZGUvbm9saWJjL3N5cy5oCmluZGV4IGRkYTlkZmZkMWQ3NC4uN2I4MmJjM2NmMTA3IDEwMDY0
NAotLS0gYS90b29scy9pbmNsdWRlL25vbGliYy9zeXMuaAorKysgYi90b29scy9pbmNsdWRl
L25vbGliYy9zeXMuaApAQCAtMjIsNiArMjIsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3N0YXQu
aD4gIC8qIGZvciBzdGF0eCgpICovCiAjaW5jbHVkZSA8bGludXgvcHJjdGwuaD4KICNpbmNs
dWRlIDxsaW51eC9yZXNvdXJjZS5oPgorI2luY2x1ZGUgPGxpbnV4L3V0c25hbWUuaD4KIAog
I2luY2x1ZGUgImFyY2guaCIKICNpbmNsdWRlICJlcnJuby5oIgpAQCAtMTEzOSw2ICsxMTQw
LDMyIEBAIGludCB1bW91bnQyKGNvbnN0IGNoYXIgKnBhdGgsIGludCBmbGFncykKIH0KIAog
CisvKgorICogaW50IHVuYW1lKHN0cnVjdCB1dHNuYW1lICpidWYpOworICovCisKK3N0cnVj
dCB1dHNuYW1lIHsKKwljaGFyIHN5c25hbWVbNjVdOworCWNoYXIgbm9kZW5hbWVbNjVdOwor
CWNoYXIgcmVsZWFzZVs2NV07CisJY2hhciB2ZXJzaW9uWzY1XTsKKwljaGFyIG1hY2hpbmVb
NjVdOworCWNoYXIgZG9tYWlubmFtZVs2NV07Cit9OworCitzdGF0aWMgX19hdHRyaWJ1dGVf
XygodW51c2VkKSkKK2ludCBzeXNfdW5hbWUoc3RydWN0IHV0c25hbWUgKmJ1ZikKK3sKKwly
ZXR1cm4gbXlfc3lzY2FsbDEoX19OUl91bmFtZSwgYnVmKTsKK30KKworc3RhdGljIF9fYXR0
cmlidXRlX18oKHVudXNlZCkpCitpbnQgdW5hbWUoc3RydWN0IHV0c25hbWUgKmJ1ZikKK3sK
KwlyZXR1cm4gX19zeXNyZXQoc3lzX3VuYW1lKGJ1ZikpOworfQorCisKIC8qCiAgKiBpbnQg
dW5saW5rKGNvbnN0IGNoYXIgKnBhdGgpOwogICovCmRpZmYgLS1naXQgYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9ub2xpYmMvbm9saWJjLXRlc3QuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL25vbGliYy9ub2xpYmMtdGVzdC5jCmluZGV4IDZiYTRmODI3NWFjNC4uOTRiYjZl
MTFjMTZmIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ub2xpYmMvbm9s
aWJjLXRlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9ub2xpYmMvbm9saWJj
LXRlc3QuYwpAQCAtMjcsNiArMjcsNyBAQAogI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiAj
aW5jbHVkZSA8c3lzL3N5c21hY3Jvcy5oPgogI2luY2x1ZGUgPHN5cy90aW1lLmg+CisjaW5j
bHVkZSA8c3lzL3V0c25hbWUuaD4KICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1ZGUg
PGRpcmVudC5oPgogI2luY2x1ZGUgPGVycm5vLmg+CkBAIC02MDAsNiArNjAxLDI1IEBAIGlu
dCBleHBlY3Rfc3RybmUoY29uc3QgY2hhciAqZXhwciwgaW50IGxsZW4sIGNvbnN0IGNoYXIg
KmNtcCkKIAlyZXR1cm4gcmV0OwogfQogCisjZGVmaW5lIEVYUEVDVF9TVFJCVUZFUShjb25k
LCBleHByLCBidWYsIHZhbCwgY21wKQkJCQlcCisJZG8geyBpZiAoIShjb25kKSkgcmVzdWx0
KGxsZW4sIFNLSVBQRUQpOyBlbHNlIHJldCArPSBleHBlY3Rfc3RyX2J1Zl9lcShleHByLCBi
dWYsIHZhbCwgbGxlbiwgY21wKTsgfSB3aGlsZSAoMCkKKworc3RhdGljIF9fYXR0cmlidXRl
X18oKHVudXNlZCkpCitpbnQgZXhwZWN0X3N0cl9idWZfZXEoc2l6ZV90IGV4cHIsIGNvbnN0
IGNoYXIgKmJ1Ziwgc2l6ZV90IHZhbCwgaW50IGxsZW4sIGNvbnN0IGNoYXIgKmNtcCkKK3sK
KwlsbGVuICs9IHByaW50ZigiID0gJWx1IDwlcz4gIiwgZXhwciwgYnVmKTsKKwlpZiAoc3Ry
Y21wKGJ1ZiwgY21wKSAhPSAwKSB7CisJCXJlc3VsdChsbGVuLCBGQUlMKTsKKwkJcmV0dXJu
IDE7CisJfQorCWlmIChleHByICE9IHZhbCkgeworCQlyZXN1bHQobGxlbiwgRkFJTCk7CisJ
CXJldHVybiAxOworCX0KKworCXJlc3VsdChsbGVuLCBPSyk7CisJcmV0dXJuIDA7Cit9CiAK
IC8qIGRlY2xhcmUgdGVzdHMgYmFzZWQgb24gbGluZSBudW1iZXJzLiBUaGVyZSBtdXN0IGJl
IGV4YWN0bHkgb25lIHRlc3QgcGVyIGxpbmUuICovCiAjZGVmaW5lIENBU0VfVEVTVChuYW1l
KSBcCkBAIC03NjEsNiArNzgxLDQ1IEBAIGludCB0ZXN0X3N0YXRfdGltZXN0YW1wcyh2b2lk
KQogCXJldHVybiAwOwogfQogCitpbnQgdGVzdF91bmFtZSh2b2lkKQoreworCXN0cnVjdCB1
dHNuYW1lIGJ1ZjsKKwljaGFyIG9zcmVsZWFzZVtzaXplb2YoYnVmLnJlbGVhc2UpXTsKKwlz
c2l6ZV90IHI7CisJaW50IGZkOworCisJbWVtc2V0KCZidWYuZG9tYWlubmFtZSwgJ1AnLCBz
aXplb2YoYnVmLmRvbWFpbm5hbWUpKTsKKworCWlmICh1bmFtZSgmYnVmKSkKKwkJcmV0dXJu
IDE7CisKKwlpZiAoc3RybmNtcCgiTGludXgiLCBidWYuc3lzbmFtZSwgc2l6ZW9mKGJ1Zi5z
eXNuYW1lKSkpCisJCXJldHVybiAxOworCisJZmQgPSBvcGVuKCIvcHJvYy9zeXMva2VybmVs
L29zcmVsZWFzZSIsIE9fUkRPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXJldHVybiAxOwor
CisJciA9IHJlYWQoZmQsIG9zcmVsZWFzZSwgc2l6ZW9mKG9zcmVsZWFzZSkpOworCWlmIChy
ID09IC0xKQorCQlyZXR1cm4gMTsKKworCWNsb3NlKGZkKTsKKworCWlmIChvc3JlbGVhc2Vb
ciAtIDFdID09ICdcbicpCisJCXItLTsKKworCS8qIFZhbGlkYXRlIG9uZSBvZiB0aGUgbGF0
ZXIgZmllbGRzIHRvIGVuc3VyZSBmaWVsZCBzaXplcyBhcmUgY29ycmVjdCAqLworCWlmIChz
dHJuY21wKG9zcmVsZWFzZSwgYnVmLnJlbGVhc2UsIHIpKQorCQlyZXR1cm4gMTsKKworCS8q
IEVuc3VyZSB0aGUgZmllbGQgZG9tYWlubmFtZSBpcyBzZXQsIGl0IGlzIG1pc3NpbmcgZnJv
bSBzdHJ1Y3Qgb2xkX3V0c25hbWUgKi8KKwlpZiAoc3RybmxlbihidWYuZG9tYWlubmFtZSwg
c2l6ZW9mKGJ1Zi5kb21haW5uYW1lKSkgPT0gc2l6ZW9mKGJ1Zi5kb21haW5uYW1lKSkKKwkJ
cmV0dXJuIDE7CisKKwlyZXR1cm4gMDsKK30KKwogaW50IHRlc3RfbW1hcF9tdW5tYXAodm9p
ZCkKIHsKIAlpbnQgcmV0LCBmZCwgaSwgcGFnZV9zaXplOwpAQCAtOTY2LDYgKzEwMjUsOCBA
QCBpbnQgcnVuX3N5c2NhbGwoaW50IG1pbiwgaW50IG1heCkKIAkJQ0FTRV9URVNUKHN0YXRf
ZmF1bHQpOyAgICAgICAgRVhQRUNUX1NZU0VSKDEsIHN0YXQoTlVMTCwgJnN0YXRfYnVmKSwg
LTEsIEVGQVVMVCk7IGJyZWFrOwogCQlDQVNFX1RFU1Qoc3RhdF90aW1lc3RhbXBzKTsgICBF
WFBFQ1RfU1lTWlIoMSwgdGVzdF9zdGF0X3RpbWVzdGFtcHMoKSk7IGJyZWFrOwogCQlDQVNF
X1RFU1Qoc3ltbGlua19yb290KTsgICAgICBFWFBFQ1RfU1lTRVIoMSwgc3ltbGluaygiLyIs
ICIvIiksIC0xLCBFRVhJU1QpOyBicmVhazsKKwkJQ0FTRV9URVNUKHVuYW1lKTsgICAgICAg
ICAgICAgRVhQRUNUX1NZU1pSKHByb2MsIHRlc3RfdW5hbWUoKSk7IGJyZWFrOworCQlDQVNF
X1RFU1QodW5hbWVfZmF1bHQpOyAgICAgICBFWFBFQ1RfU1lTRVIoMSwgdW5hbWUoTlVMTCks
IC0xLCBFRkFVTFQpOyBicmVhazsKIAkJQ0FTRV9URVNUKHVubGlua19yb290KTsgICAgICAg
RVhQRUNUX1NZU0VSKDEsIHVubGluaygiLyIpLCAtMSwgRUlTRElSKTsgYnJlYWs7CiAJCUNB
U0VfVEVTVCh1bmxpbmtfYmxhaCk7ICAgICAgIEVYUEVDVF9TWVNFUigxLCB1bmxpbmsoIi9w
cm9jL3NlbGYvYmxhaCIpLCAtMSwgRU5PRU5UKTsgYnJlYWs7CiAJCUNBU0VfVEVTVCh3YWl0
X2NoaWxkKTsgICAgICAgIEVYUEVDVF9TWVNFUigxLCB3YWl0KCZ0bXApLCAtMSwgRUNISUxE
KTsgYnJlYWs7CkBAIC05OTEsNiArMTA1MiwxNCBAQCBpbnQgcnVuX3N0ZGxpYihpbnQgbWlu
LCBpbnQgbWF4KQogCWZvciAodGVzdCA9IG1pbjsgdGVzdCA+PSAwICYmIHRlc3QgPD0gbWF4
OyB0ZXN0KyspIHsKIAkJaW50IGxsZW4gPSAwOyAvKiBsaW5lIGxlbmd0aCAqLwogCisJCS8q
IEZvciBmdW5jdGlvbnMgdGhhdCB0YWtlIGEgbG9uZyBidWZmZXIsIGxpa2Ugc3RybGNhdCgp
CisJCSAqIEFkZCBzb21lIG1vcmUgY2hhcnMgYWZ0ZXIgdGhlIFwwLCB0byB0ZXN0IGZ1bmN0
aW9ucyB0aGF0IG92ZXJ3cml0ZSB0aGUgYnVmZmVyIHNldAorCQkgKiB0aGUgXDAgYXQgdGhl
IGV4YWN0IHJpZ2h0IHBvc2l0aW9uLgorCQkgKi8KKwkJY2hhciBidWZbMTBdID0gInRlc3Qx
MjM0NTYiOworCQlidWZbNF0gPSAnXDAnOworCisKIAkJLyogYXZvaWQgbGVhdmluZyBlbXB0
eSBsaW5lcyBiZWxvdywgdGhpcyB3aWxsIGluc2VydCBob2xlcyBpbnRvCiAJCSAqIHRlc3Qg
bnVtYmVycy4KIAkJICovCkBAIC0xMDA3LDYgKzEwNzYsMTkgQEAgaW50IHJ1bl9zdGRsaWIo
aW50IG1pbiwgaW50IG1heCkKIAkJQ0FTRV9URVNUKHN0cmNocl9mb29iYXJfeik7ICAgIEVY
UEVDVF9TVFJaUigxLCBzdHJjaHIoImZvb2JhciIsICd6JykpOyBicmVhazsKIAkJQ0FTRV9U
RVNUKHN0cnJjaHJfZm9vYmFyX28pOyAgIEVYUEVDVF9TVFJFUSgxLCBzdHJyY2hyKCJmb29i
YXIiLCAnbycpLCAib2JhciIpOyBicmVhazsKIAkJQ0FTRV9URVNUKHN0cnJjaHJfZm9vYmFy
X3opOyAgIEVYUEVDVF9TVFJaUigxLCBzdHJyY2hyKCJmb29iYXIiLCAneicpKTsgYnJlYWs7
CisjaWZkZWYgTk9MSUJDCisJCUNBU0VfVEVTVChzdHJsY2F0XzApOyAgICAgICAgICBFWFBF
Q1RfU1RSQlVGRVEoMSwgc3RybGNhdChidWYsICJiYXIiLCAwKSwgYnVmLCAzLCAidGVzdCIp
OyBicmVhazsKKwkJQ0FTRV9URVNUKHN0cmxjYXRfMSk7ICAgICAgICAgIEVYUEVDVF9TVFJC
VUZFUSgxLCBzdHJsY2F0KGJ1ZiwgImJhciIsIDEpLCBidWYsIDQsICJ0ZXN0Iik7IGJyZWFr
OworCQlDQVNFX1RFU1Qoc3RybGNhdF81KTsgICAgICAgICAgRVhQRUNUX1NUUkJVRkVRKDEs
IHN0cmxjYXQoYnVmLCAiYmFyIiwgNSksIGJ1ZiwgNywgInRlc3QiKTsgYnJlYWs7CisJCUNB
U0VfVEVTVChzdHJsY2F0XzYpOyAgICAgICAgICBFWFBFQ1RfU1RSQlVGRVEoMSwgc3RybGNh
dChidWYsICJiYXIiLCA2KSwgYnVmLCA3LCAidGVzdGIiKTsgYnJlYWs7CisJCUNBU0VfVEVT
VChzdHJsY2F0XzcpOyAgICAgICAgICBFWFBFQ1RfU1RSQlVGRVEoMSwgc3RybGNhdChidWYs
ICJiYXIiLCA3KSwgYnVmLCA3LCAidGVzdGJhIik7IGJyZWFrOworCQlDQVNFX1RFU1Qoc3Ry
bGNhdF84KTsgICAgICAgICAgRVhQRUNUX1NUUkJVRkVRKDEsIHN0cmxjYXQoYnVmLCAiYmFy
IiwgOCksIGJ1ZiwgNywgInRlc3RiYXIiKTsgYnJlYWs7CisJCUNBU0VfVEVTVChzdHJsY3B5
XzApOyAgICAgICAgICBFWFBFQ1RfU1RSQlVGRVEoMSwgc3RybGNweShidWYsICJiYXIiLCAw
KSwgYnVmLCAzLCAidGVzdCIpOyBicmVhazsKKwkJQ0FTRV9URVNUKHN0cmxjcHlfMSk7ICAg
ICAgICAgIEVYUEVDVF9TVFJCVUZFUSgxLCBzdHJsY3B5KGJ1ZiwgImJhciIsIDEpLCBidWYs
IDMsICIiKTsgYnJlYWs7CisJCUNBU0VfVEVTVChzdHJsY3B5XzIpOyAgICAgICAgICBFWFBF
Q1RfU1RSQlVGRVEoMSwgc3RybGNweShidWYsICJiYXIiLCAyKSwgYnVmLCAzLCAiYiIpOyBi
cmVhazsKKwkJQ0FTRV9URVNUKHN0cmxjcHlfMyk7ICAgICAgICAgIEVYUEVDVF9TVFJCVUZF
USgxLCBzdHJsY3B5KGJ1ZiwgImJhciIsIDMpLCBidWYsIDMsICJiYSIpOyBicmVhazsKKwkJ
Q0FTRV9URVNUKHN0cmxjcHlfNCk7ICAgICAgICAgIEVYUEVDVF9TVFJCVUZFUSgxLCBzdHJs
Y3B5KGJ1ZiwgImJhciIsIDQpLCBidWYsIDMsICJiYXIiKTsgYnJlYWs7CisjZW5kaWYKIAkJ
Q0FTRV9URVNUKG1lbWNtcF8yMF8yMCk7ICAgICAgIEVYUEVDVF9FUSgxLCBtZW1jbXAoImFh
YVx4MjAiLCAiYWFhXHgyMCIsIDQpLCAwKTsgYnJlYWs7CiAJCUNBU0VfVEVTVChtZW1jbXBf
MjBfNjApOyAgICAgICBFWFBFQ1RfTFQoMSwgbWVtY21wKCJhYWFceDIwIiwgImFhYVx4NjAi
LCA0KSwgMCk7IGJyZWFrOwogCQlDQVNFX1RFU1QobWVtY21wXzYwXzIwKTsgICAgICAgRVhQ
RUNUX0dUKDEsIG1lbWNtcCgiYWFhXHg2MCIsICJhYWFceDIwIiwgNCksIDApOyBicmVhazsK


--------------3h7oO02tp7Ub6Y8cOlsd370x--


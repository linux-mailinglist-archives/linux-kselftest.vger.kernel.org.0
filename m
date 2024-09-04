Return-Path: <linux-kselftest+bounces-17183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC8D96C99D
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E35AB23A89
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54A15531A;
	Wed,  4 Sep 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LfdQJv+U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB11514F8
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Sep 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485985; cv=none; b=uZSAIq8gc+S+ciMi7yPfXTO86oo23ugQnzkHGzKURvMfUsAcv4UeKJs7pjlrdU774OGm6d8rWY2cDcW+KvOvLiKvUZGxEfw9w2F4QwAZyzmLePympHngh2+P3LMtH213d5uFCQKTro4qJC6qD6xm+BBHFBlHcYIocinvGwVSrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485985; c=relaxed/simple;
	bh=Paag6BFcURhpeWfK5i4jM43Qb7+H9a1yCp9aenH53Dc=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=ry/YaChodzbLqpStThj82sptRmtlmAUsJhRI0hUNW9KnxM2KP6RYyqz6Gvwhpdba3hUtpyvuup8M+IvK/oSP7+7vwWP5ko2Hk4V6VTGW0tRivxMbM+dDUvnij6MziHr8TJCL31TmCgcPnyXy+yFqkCCf0OclLfZtdmQwA+j+LzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LfdQJv+U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20570b42f24so1552085ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2024 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725485983; x=1726090783; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cwfWMshAqNAR3bH5Ykm0ByElNf5VG1mmbiGlzTqRPs8=;
        b=LfdQJv+UXJA8Z+DSdub+7zmGuwie5n5AlOBr48FA02GAiLH1ZILl4aO9tl3XQww6Gy
         oZdkDm7RmpfzOqVNd9ez3N8sQq/YQCF8t4qobt3z6wR4DV0NS6o5vdbz+uWlCJZjhaaB
         nFBCY3DQK1ef6eCY0xj+E+JAjUsKEYU856hag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725485983; x=1726090783;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwfWMshAqNAR3bH5Ykm0ByElNf5VG1mmbiGlzTqRPs8=;
        b=WSnFIB6+rJNqbux6YEVan1cQz9dp5/UnpZa8XgML71FzyZ8Yx8iLeMN95oo6+Wr5he
         SwjMeRp2C00h9BYSA5uztU0do+Te4lJ3nAlokfPhFkUYU3VfHkVx5w/rsTDjK0SMh+p1
         b7dJ6b3jinXO4K64nK4zRUr8ZkV0wq03JYvwgNZVqo1OUaJ45BWNO6uzbebfMfUflU+p
         0XL1J4M0hiBXlxJkzngi3a/ATQgRdZz1E9AKA/Ud24dH0vfzXvs87ecb+cjek1OhUzPl
         G7alq7f7VIu/icpFpm7p4FkvkBXd3HUYxyAyOCFR/7UklQF9fy0XlsOk1zPAtunG8kYp
         i59w==
X-Forwarded-Encrypted: i=1; AJvYcCX+uFQ4wNmUNOWBYhtNWmI4lz0Xzd4DjCZyK9XtX59dZwTbjkR6Qmlhj1x1uHgbbXDAb+HwD1BtLW6xoSgmkF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGkO8g2Mkoq3auKUGX4WcxM75UGxqGbMtMw73WXi8+tHKE5iRS
	yIO9Rbf/M1qHFrz2PCK2coMN5Fj8S2B5qWzw3nZSiJNj3TT0pSqn/2JpBU6j8Lc=
X-Google-Smtp-Source: AGHT+IEAA/h6f7ZFoMxwlg93ax03CUs3H89eXgOqsXr1R5YPu/3D7usW9VI0KLRUK5HfFeHTqxrFNw==
X-Received: by 2002:a17:902:e5ce:b0:202:3a78:5d8a with SMTP id d9443c01a7336-20699acb74bmr79460275ad.8.1725485982330;
        Wed, 04 Sep 2024 14:39:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913b24sm17881555ad.12.2024.09.04.14.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:39:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------N7RuZE1AN07S4lT9ll8A81eC"
Message-ID: <4fa8a1d6-ac65-477a-aab4-814e02eea2b8@linuxfoundation.org>
Date: Wed, 4 Sep 2024 15:39:40 -0600
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
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendanhiggins@google.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.11-rc7

This is a multi-part message in MIME format.
--------------N7RuZE1AN07S4lT9ll8A81eC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.11-rc7.

This kunit update for Linux 6.11-rc7 consist of one single fix to
a use-after-free bug resulting from kunit_driver_create() failing
to copy the driver name leaving it on the stack or freeing it.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.11-rc7

for you to fetch changes up to f2c6dbd220170c2396fb019ead67fbada1e23ebd:

   kunit: Device wrappers should also manage driver name (2024-08-26 07:03:46 -0600)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.11-rc7

This kunit update for Linux 6.11-rc7 consist of one single fix to
a use-after-free bug resulting from kunit_driver_create() failing
to copy the driver name leaving it on the stack or freeing it.

----------------------------------------------------------------
David Gow (1):
       kunit: Device wrappers should also manage driver name

  include/kunit/test.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
  lib/kunit/device.c   |  7 +++++--
  lib/kunit/test.c     | 19 +++++++++++++++++++
  3 files changed, 72 insertions(+), 2 deletions(-)
----------------------------------------------------------------
--------------N7RuZE1AN07S4lT9ll8A81eC
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.11-rc7.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.11-rc7.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUva3VuaXQvdGVzdC5oIGIvaW5jbHVkZS9rdW5pdC90ZXN0
LmgKaW5kZXggZTJhMWYwOTI4ZThiLi41YWMyMzdjOTQ5YTAgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUva3VuaXQvdGVzdC5oCisrKyBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCkBAIC0yOCw2ICsy
OCw3IEBACiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KIAogI2luY2x1ZGUgPGFzbS9yd29u
Y2UuaD4KKyNpbmNsdWRlIDxhc20vc2VjdGlvbnMuaD4KIAogLyogU3RhdGljIGtleTogdHJ1
ZSBpZiBhbnkgS1VuaXQgdGVzdHMgYXJlIGN1cnJlbnRseSBydW5uaW5nICovCiBERUNMQVJF
X1NUQVRJQ19LRVlfRkFMU0Uoa3VuaXRfcnVubmluZyk7CkBAIC00ODAsNiArNDgxLDUzIEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCAqa3VuaXRfa2NhbGxvYyhzdHJ1Y3Qga3VuaXQgKnRlc3Qs
IHNpemVfdCBuLCBzaXplX3Qgc2l6ZSwgZ2ZwCiAJcmV0dXJuIGt1bml0X2ttYWxsb2NfYXJy
YXkodGVzdCwgbiwgc2l6ZSwgZ2ZwIHwgX19HRlBfWkVSTyk7CiB9CiAKKworLyoqCisgKiBr
dW5pdF9rZnJlZV9jb25zdCgpIC0gY29uZGl0aW9uYWxseSBmcmVlIHRlc3QgbWFuYWdlZCBt
ZW1vcnkKKyAqIEB4OiBwb2ludGVyIHRvIHRoZSBtZW1vcnkKKyAqCisgKiBDYWxscyBrdW5p
dF9rZnJlZSgpIG9ubHkgaWYgQHggaXMgbm90IGluIC5yb2RhdGEgc2VjdGlvbi4KKyAqIFNl
ZSBrdW5pdF9rc3RyZHVwX2NvbnN0KCkgZm9yIG1vcmUgaW5mb3JtYXRpb24uCisgKi8KK3Zv
aWQga3VuaXRfa2ZyZWVfY29uc3Qoc3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCB2b2lkICp4
KTsKKworLyoqCisgKiBrdW5pdF9rc3RyZHVwKCkgLSBEdXBsaWNhdGVzIGEgc3RyaW5nIGlu
dG8gYSB0ZXN0IG1hbmFnZWQgYWxsb2NhdGlvbi4KKyAqCisgKiBAdGVzdDogVGhlIHRlc3Qg
Y29udGV4dCBvYmplY3QuCisgKiBAc3RyOiBUaGUgTlVMTC10ZXJtaW5hdGVkIHN0cmluZyB0
byBkdXBsaWNhdGUuCisgKiBAZ2ZwOiBmbGFncyBwYXNzZWQgdG8gdW5kZXJseWluZyBrbWFs
bG9jKCkuCisgKgorICogU2VlIGtzdHJkdXAoKSBhbmQga3VuaXRfa21hbGxvY19hcnJheSgp
IGZvciBtb3JlIGluZm9ybWF0aW9uLgorICovCitzdGF0aWMgaW5saW5lIGNoYXIgKmt1bml0
X2tzdHJkdXAoc3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCBjaGFyICpzdHIsIGdmcF90IGdm
cCkKK3sKKwlzaXplX3QgbGVuOworCWNoYXIgKmJ1ZjsKKworCWlmICghc3RyKQorCQlyZXR1
cm4gTlVMTDsKKworCWxlbiA9IHN0cmxlbihzdHIpICsgMTsKKwlidWYgPSBrdW5pdF9rbWFs
bG9jKHRlc3QsIGxlbiwgZ2ZwKTsKKwlpZiAoYnVmKQorCQltZW1jcHkoYnVmLCBzdHIsIGxl
bik7CisJcmV0dXJuIGJ1ZjsKK30KKworLyoqCisgKiBrdW5pdF9rc3RyZHVwX2NvbnN0KCkg
LSBDb25kaXRpb25hbGx5IGR1cGxpY2F0ZXMgYSBzdHJpbmcgaW50byBhIHRlc3QgbWFuYWdl
ZCBhbGxvY2F0aW9uLgorICoKKyAqIEB0ZXN0OiBUaGUgdGVzdCBjb250ZXh0IG9iamVjdC4K
KyAqIEBzdHI6IFRoZSBOVUxMLXRlcm1pbmF0ZWQgc3RyaW5nIHRvIGR1cGxpY2F0ZS4KKyAq
IEBnZnA6IGZsYWdzIHBhc3NlZCB0byB1bmRlcmx5aW5nIGttYWxsb2MoKS4KKyAqCisgKiBD
YWxscyBrdW5pdF9rc3RyZHVwKCkgb25seSBpZiBAc3RyIGlzIG5vdCBpbiB0aGUgcm9kYXRh
IHNlY3Rpb24uIE11c3QgYmUgZnJlZWQgd2l0aAorICoga3VuaXRfa2ZyZWVfY29uc3QoKSAt
LSBub3Qga3VuaXRfa2ZyZWUoKS4KKyAqIFNlZSBrc3RyZHVwX2NvbnN0KCkgYW5kIGt1bml0
X2ttYWxsb2NfYXJyYXkoKSBmb3IgbW9yZSBpbmZvcm1hdGlvbi4KKyAqLworY29uc3QgY2hh
ciAqa3VuaXRfa3N0cmR1cF9jb25zdChzdHJ1Y3Qga3VuaXQgKnRlc3QsIGNvbnN0IGNoYXIg
KnN0ciwgZ2ZwX3QgZ2ZwKTsKKwogLyoqCiAgKiBrdW5pdF92bV9tbWFwKCkgLSBBbGxvY2F0
ZSBLVW5pdC10cmFja2VkIHZtX21tYXAoKSBhcmVhCiAgKiBAdGVzdDogVGhlIHRlc3QgY29u
dGV4dCBvYmplY3QuCmRpZmYgLS1naXQgYS9saWIva3VuaXQvZGV2aWNlLmMgYi9saWIva3Vu
aXQvZGV2aWNlLmMKaW5kZXggMjVjODFlZDQ2NWZiLi41MjBjMWZjY2VlOGEgMTAwNjQ0Ci0t
LSBhL2xpYi9rdW5pdC9kZXZpY2UuYworKysgYi9saWIva3VuaXQvZGV2aWNlLmMKQEAgLTg5
LDcgKzg5LDcgQEAgc3RydWN0IGRldmljZV9kcml2ZXIgKmt1bml0X2RyaXZlcl9jcmVhdGUo
c3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCBjaGFyICpuYW1lKQogCWlmICghZHJpdmVyKQog
CQlyZXR1cm4gRVJSX1BUUihlcnIpOwogCi0JZHJpdmVyLT5uYW1lID0gbmFtZTsKKwlkcml2
ZXItPm5hbWUgPSBrdW5pdF9rc3RyZHVwX2NvbnN0KHRlc3QsIG5hbWUsIEdGUF9LRVJORUwp
OwogCWRyaXZlci0+YnVzID0gJmt1bml0X2J1c190eXBlOwogCWRyaXZlci0+b3duZXIgPSBU
SElTX01PRFVMRTsKIApAQCAtMTkyLDggKzE5MiwxMSBAQCB2b2lkIGt1bml0X2RldmljZV91
bnJlZ2lzdGVyKHN0cnVjdCBrdW5pdCAqdGVzdCwgc3RydWN0IGRldmljZSAqZGV2KQogCWNv
bnN0IHN0cnVjdCBkZXZpY2VfZHJpdmVyICpkcml2ZXIgPSB0b19rdW5pdF9kZXZpY2UoZGV2
KS0+ZHJpdmVyOwogCiAJa3VuaXRfcmVsZWFzZV9hY3Rpb24odGVzdCwgZGV2aWNlX3VucmVn
aXN0ZXJfd3JhcHBlciwgZGV2KTsKLQlpZiAoZHJpdmVyKQorCWlmIChkcml2ZXIpIHsKKwkJ
Y29uc3QgY2hhciAqZHJpdmVyX25hbWUgPSBkcml2ZXItPm5hbWU7CiAJCWt1bml0X3JlbGVh
c2VfYWN0aW9uKHRlc3QsIGRyaXZlcl91bnJlZ2lzdGVyX3dyYXBwZXIsICh2b2lkICopZHJp
dmVyKTsKKwkJa3VuaXRfa2ZyZWVfY29uc3QodGVzdCwgZHJpdmVyX25hbWUpOworCX0KIH0K
IEVYUE9SVF9TWU1CT0xfR1BMKGt1bml0X2RldmljZV91bnJlZ2lzdGVyKTsKIApkaWZmIC0t
Z2l0IGEvbGliL2t1bml0L3Rlc3QuYyBiL2xpYi9rdW5pdC90ZXN0LmMKaW5kZXggZThiMWI1
MmExOWFiLi4wODljODMyZTNjZGIgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC90ZXN0LmMKKysr
IGIvbGliL2t1bml0L3Rlc3QuYwpAQCAtODc0LDYgKzg3NCwyNSBAQCB2b2lkIGt1bml0X2tm
cmVlKHN0cnVjdCBrdW5pdCAqdGVzdCwgY29uc3Qgdm9pZCAqcHRyKQogfQogRVhQT1JUX1NZ
TUJPTF9HUEwoa3VuaXRfa2ZyZWUpOwogCit2b2lkIGt1bml0X2tmcmVlX2NvbnN0KHN0cnVj
dCBrdW5pdCAqdGVzdCwgY29uc3Qgdm9pZCAqeCkKK3sKKyNpZiAhSVNfTU9EVUxFKENPTkZJ
R19LVU5JVCkKKwlpZiAoIWlzX2tlcm5lbF9yb2RhdGEoKHVuc2lnbmVkIGxvbmcpeCkpCisj
ZW5kaWYKKwkJa3VuaXRfa2ZyZWUodGVzdCwgeCk7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChr
dW5pdF9rZnJlZV9jb25zdCk7CisKK2NvbnN0IGNoYXIgKmt1bml0X2tzdHJkdXBfY29uc3Qo
c3RydWN0IGt1bml0ICp0ZXN0LCBjb25zdCBjaGFyICpzdHIsIGdmcF90IGdmcCkKK3sKKyNp
ZiAhSVNfTU9EVUxFKENPTkZJR19LVU5JVCkKKwlpZiAoaXNfa2VybmVsX3JvZGF0YSgodW5z
aWduZWQgbG9uZylzdHIpKQorCQlyZXR1cm4gc3RyOworI2VuZGlmCisJcmV0dXJuIGt1bml0
X2tzdHJkdXAodGVzdCwgc3RyLCBnZnApOworfQorRVhQT1JUX1NZTUJPTF9HUEwoa3VuaXRf
a3N0cmR1cF9jb25zdCk7CisKIHZvaWQga3VuaXRfY2xlYW51cChzdHJ1Y3Qga3VuaXQgKnRl
c3QpCiB7CiAJc3RydWN0IGt1bml0X3Jlc291cmNlICpyZXM7Cg==

--------------N7RuZE1AN07S4lT9ll8A81eC--


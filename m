Return-Path: <linux-kselftest+bounces-6032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC268745F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 03:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5190F281897
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C91A5C89;
	Thu,  7 Mar 2024 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwerY18e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4846AF
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Mar 2024 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777507; cv=none; b=QH6Tx8Dfg4ImnMemmZhCCmVHn/RN/W+OxCdXkzYcK2YchTw72bGOg+BaOucQR/Zc86F9lvJR0x2CGZpHLd2pQnBjacmRPXiY6mvPp73qwlJBJY6cjiD65tjDgdMvEPG+vHX5qtnnx1wdrQgd+NhRzlWHc2rTPKUTW8NqVTfEe6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777507; c=relaxed/simple;
	bh=0xzXFjWZ1m80S8gluLF6raYLj/LTINPRUXBQ9my8S2I=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=P0Ro0JB89kfL9lgVGCebPz4duM/wBneKwlbkxrcVsfKxfnsyGN9JyUP3aJR5xe18fsU4/2eQUGT87707Ooy9exzsClLD9FvTmxU5Tf8Upz0nXi2vG0akI4oOePK38ekQMKBeNKqndzsBb0AyJK9vMyJ6k5ETXVfhw1i6bpP4GSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwerY18e; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35d374bebe3so582205ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Mar 2024 18:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709777504; x=1710382304; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bU6ex/faxbEcoxve2/Lztk/HkuxBTPG2WMTvXEAw/AQ=;
        b=TwerY18e5h341M0bBPS4BH4hLHBHeMQ7o13g2KmYXVTfftkZte4i+lEb38ofh6rHd4
         stUmkKko4m4z6k63xGnd+aEkyno7ct/80w+57hg0yuV9AOZdJoIUi7cRtOVVG67YiT8s
         BfJsajkr1NIN1+zEOMiZKwV2MJl5zALlWj1d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709777504; x=1710382304;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bU6ex/faxbEcoxve2/Lztk/HkuxBTPG2WMTvXEAw/AQ=;
        b=E0/6j/fX2/SNBOxB2ijMMlIjmQOn5OgVyy0LxeHCqeSJPtY+mNByB2AORQcAXg7cLs
         vupclbv1fUIEcPhIkhkEfIL29b0GObafRNTvSQGrnqWNtZYVdnQg52sxTgD0PVvfRwRW
         LDeqdencKDrII9kZ6PmdUECjIk2LrWJHC3yXFKWDxa5VSr+BJdmYMtqEZEP4DjODJdL/
         NC2erZA2+CxFkgnX51sZWuChih65go69wXIOBvT7itWjustKv5b4wVzUmMOS8GyjTADf
         dQSpyvyoLtvhHpWC66fXt0upITw3MjyMh4jXiuFbXxALS2twocgqiNK4PgKIwn72i3N7
         B4eA==
X-Forwarded-Encrypted: i=1; AJvYcCVizEt/991sleWmwupqABm0BVJE41xY0zpVqSVzuF0baCabzq6rSz4iGmnTB9LAYyQ291DGtAeAA97h0nZycIrGchBidKO5icWYl9+jSZQt
X-Gm-Message-State: AOJu0YyNkIn+BTtGUTy4G6mjK7j+FKIrhpcGuhVwmhQKYg0/KF0CiiNd
	68NnS2o7cEN16o+VgMhn4L7oXFopNAHfAcfAPKLrBJ7lrqRcYAj69otGJqaApAk=
X-Google-Smtp-Source: AGHT+IGmP23jw2dxEpdO3hwcYbHLS8lWRXpfrAB17vbqxnJr7EwxNbSElhoDraMyL3NQxAeNbmNl8Q==
X-Received: by 2002:a6b:6712:0:b0:7c8:47d5:b86e with SMTP id b18-20020a6b6712000000b007c847d5b86emr869918ioc.0.1709777504594;
        Wed, 06 Mar 2024 18:11:44 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k15-20020a02c76f000000b004740d29b120sm3644410jao.111.2024.03.06.18.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 18:11:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------9ZDWGCPNPype8UplQxBtNQ0f"
Message-ID: <a47cb633-dc38-400f-a051-506b1b49fde7@linuxfoundation.org>
Date: Wed, 6 Mar 2024 19:11:42 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit next update for Linux 6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, david Gow <davidgow@google.com>,
 Brendan Higgins <brendanhiggins@google.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Dave Airlie <airlied@redhat.com>,
 shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------9ZDWGCPNPype8UplQxBtNQ0f
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following KUnit next update for Linux 6.8-rc1.

This KUnit next update for Linux 6.9-rc1 consists of:

-- fix to make kunit_bus_type const

-- kunit tool change to Print UML command

-- DRM device creation helpers are now using the new kunit device
    creation helpers. This change resulted in DRM helpers switching
    from using a platform_device, to a dedicated bus and device type
    used by kunit. kunit devices don't set DMA mask and this caused
    regression on some drm tests as they can't allocate DMA buffers.
    Fix this problem by setting DMA masks on the kunit device during
    initialization.

-- KUnit has several macros which accept a log message, which can
    contain printf format specifiers. Some of these (the explicit
    log macros) already use the __printf() gcc attribute to ensure
    the format specifiers are valid, but those which could fail the
    test, and hence used __kunit_do_failed_assertion() behind the scenes,
    did not.

    These include: KUNIT_EXPECT_*_MSG(), KUNIT_ASSERT_*_MSG(), and
    KUNIT_FAIL()

    A 9 patch series adds the __printf() attribute, and fixes all of
    the issues uncovered.

Note:
make allmodconfig x86 passed passed for me on March 4th linux-next
(This could be with Stephen's fix up for the following problem).

Stephen found a problem in drivers/gpu/drm/tests/drm_buddy_test.c

Caused by commit

   806cb2270237 ("kunit: Annotate _MSG assertion variants with gnu printf specifiers")

interacting with commit

   c70703320e55 ("drm/tests/drm_buddy: add alloc_range_bias test")

from the drm-misc-fixes tree.

Stephen found that the problem is not with the format string types,
but with a missing argument i.e. there is another argument required
by the format string.

It is easier to fix this problem in the drm-misc-fixes tree.

The hope is that the fix to the problem has been sent to you or will
be sent to you before the merge.

If not Stephen's fix up will be necessary.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

   Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.9-rc1

for you to fetch changes up to 806cb2270237ce2ec672a407d66cee17a07d3aa2:

   kunit: Annotate _MSG assertion variants with gnu printf specifiers (2024-02-28 13:07:49 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-6.9-rc1

This KUnit next update for Linux 6.9-rc1 consists of:

-- fix to make kunit_bus_type const

-- kunit tool change to Print UML command

-- DRM device creation helpers are now using the new kunit device
    creation helpers. This change resulted in DRM helpers switching
    from using a platform_device, to a dedicated bus and device type
    used by kunit. kunit devices don't set DMA mask and this caused
    regression on some drm tests as they can't allocate DMA buffers.
    Fix this problem by setting DMA masks on the kunit device during
    initialization.

-- KUnit has several macros which accept a log message, which can
    contain printf format specifiers. Some of these (the explicit
    log macros) already use the __printf() gcc attribute to ensure
    the format specifiers are valid, but those which could fail the
    test, and hence used __kunit_do_failed_assertion() behind the scenes,
    did not.

    These include: KUNIT_EXPECT_*_MSG(), KUNIT_ASSERT_*_MSG(), and
    KUNIT_FAIL()

    A 9 patch series adds the __printf() attribute, and fixes all of
    the issues uncovered.

----------------------------------------------------------------
David Gow (9):
       kunit: test: Log the correct filter string in executor_test
       lib/cmdline: Fix an invalid format specifier in an assertion msg
       lib: memcpy_kunit: Fix an invalid format specifier in an assertion msg
       time: test: Fix incorrect format specifier
       rtc: test: Fix invalid format specifier.
       net: test: Fix printf format specifier in skb_segment kunit test
       drm/xe/tests: Fix printf format specifiers in xe_migrate test
       drm: tests: Fix invalid printf format specifiers in KUnit tests
       kunit: Annotate _MSG assertion variants with gnu printf specifiers

Lucas De Marchi (1):
       kunit: Mark filter* params as rw

Maxime Ripard (1):
       kunit: Setup DMA masks on the kunit device

Mickaël Salaün (1):
       kunit: tool: Print UML command

Ricardo B. Marliere (1):
       kunit: make kunit_bus_type const

  drivers/gpu/drm/tests/drm_buddy_test.c | 14 +++++++-------
  drivers/gpu/drm/tests/drm_mm_test.c    |  6 +++---
  drivers/gpu/drm/xe/tests/xe_migrate.c  |  8 ++++----
  drivers/rtc/lib_test.c                 |  2 +-
  include/kunit/test.h                   | 12 ++++++------
  kernel/time/time_test.c                |  2 +-
  lib/cmdline_kunit.c                    |  2 +-
  lib/kunit/device.c                     |  6 +++++-
  lib/kunit/executor.c                   |  6 +++---
  lib/kunit/executor_test.c              |  2 +-
  lib/memcpy_kunit.c                     |  4 ++--
  net/core/gso_test.c                    |  2 +-
  tools/testing/kunit/kunit_kernel.py    |  1 +
  13 files changed, 36 insertions(+), 31 deletions(-)
----------------------------------------------------------------
--------------9ZDWGCPNPype8UplQxBtNQ0f
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-6.9-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-kunit-6.9-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90ZXN0cy9kcm1fYnVkZHlfdGVzdC5jIGIv
ZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9idWRkeV90ZXN0LmMKaW5kZXggMmYzMmZiMmYx
MmU3Li4zZGJmYTMwNzg0NDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90ZXN0cy9k
cm1fYnVkZHlfdGVzdC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90ZXN0cy9kcm1fYnVkZHlf
dGVzdC5jCkBAIC01NSwzMCArNTUsMzAgQEAgc3RhdGljIHZvaWQgZHJtX3Rlc3RfYnVkZHlf
YWxsb2NfY29udGlndW91cyhzdHJ1Y3Qga3VuaXQgKnRlc3QpCiAJCUtVTklUX0FTU0VSVF9G
QUxTRV9NU0codGVzdCwKIAkJCQkgICAgICAgZHJtX2J1ZGR5X2FsbG9jX2Jsb2NrcygmbW0s
IDAsIG1tX3NpemUsCiAJCQkJCQkJICAgICAgcHMsIHBzLCBsaXN0LCAwKSwKLQkJCQkgICAg
ICAgImJ1ZGR5X2FsbG9jIGhpdCBhbiBlcnJvciBzaXplPSV1XG4iLAorCQkJCSAgICAgICAi
YnVkZHlfYWxsb2MgaGl0IGFuIGVycm9yIHNpemU9JWx1XG4iLAogCQkJCSAgICAgICBwcyk7
CiAJfSB3aGlsZSAoKytpIDwgbl9wYWdlcyk7CiAKIAlLVU5JVF9BU1NFUlRfVFJVRV9NU0co
dGVzdCwgZHJtX2J1ZGR5X2FsbG9jX2Jsb2NrcygmbW0sIDAsIG1tX3NpemUsCiAJCQkJCQkJ
ICAgMyAqIHBzLCBwcywgJmFsbG9jYXRlZCwKIAkJCQkJCQkgICBEUk1fQlVERFlfQ09OVElH
VU9VU19BTExPQ0FUSU9OKSwKLQkJCSAgICAgICAiYnVkZHlfYWxsb2MgZGlkbid0IGVycm9y
IHNpemU9JXVcbiIsIDMgKiBwcyk7CisJCQkgICAgICAgImJ1ZGR5X2FsbG9jIGRpZG4ndCBl
cnJvciBzaXplPSVsdVxuIiwgMyAqIHBzKTsKIAogCWRybV9idWRkeV9mcmVlX2xpc3QoJm1t
LCAmbWlkZGxlKTsKIAlLVU5JVF9BU1NFUlRfVFJVRV9NU0codGVzdCwgZHJtX2J1ZGR5X2Fs
bG9jX2Jsb2NrcygmbW0sIDAsIG1tX3NpemUsCiAJCQkJCQkJICAgMyAqIHBzLCBwcywgJmFs
bG9jYXRlZCwKIAkJCQkJCQkgICBEUk1fQlVERFlfQ09OVElHVU9VU19BTExPQ0FUSU9OKSwK
LQkJCSAgICAgICAiYnVkZHlfYWxsb2MgZGlkbid0IGVycm9yIHNpemU9JXVcbiIsIDMgKiBw
cyk7CisJCQkgICAgICAgImJ1ZGR5X2FsbG9jIGRpZG4ndCBlcnJvciBzaXplPSVsdVxuIiwg
MyAqIHBzKTsKIAlLVU5JVF9BU1NFUlRfVFJVRV9NU0codGVzdCwgZHJtX2J1ZGR5X2FsbG9j
X2Jsb2NrcygmbW0sIDAsIG1tX3NpemUsCiAJCQkJCQkJICAgMiAqIHBzLCBwcywgJmFsbG9j
YXRlZCwKIAkJCQkJCQkgICBEUk1fQlVERFlfQ09OVElHVU9VU19BTExPQ0FUSU9OKSwKLQkJ
CSAgICAgICAiYnVkZHlfYWxsb2MgZGlkbid0IGVycm9yIHNpemU9JXVcbiIsIDIgKiBwcyk7
CisJCQkgICAgICAgImJ1ZGR5X2FsbG9jIGRpZG4ndCBlcnJvciBzaXplPSVsdVxuIiwgMiAq
IHBzKTsKIAogCWRybV9idWRkeV9mcmVlX2xpc3QoJm1tLCAmcmlnaHQpOwogCUtVTklUX0FT
U0VSVF9UUlVFX01TRyh0ZXN0LCBkcm1fYnVkZHlfYWxsb2NfYmxvY2tzKCZtbSwgMCwgbW1f
c2l6ZSwKIAkJCQkJCQkgICAzICogcHMsIHBzLCAmYWxsb2NhdGVkLAogCQkJCQkJCSAgIERS
TV9CVUREWV9DT05USUdVT1VTX0FMTE9DQVRJT04pLAotCQkJICAgICAgICJidWRkeV9hbGxv
YyBkaWRuJ3QgZXJyb3Igc2l6ZT0ldVxuIiwgMyAqIHBzKTsKKwkJCSAgICAgICAiYnVkZHlf
YWxsb2MgZGlkbid0IGVycm9yIHNpemU9JWx1XG4iLCAzICogcHMpOwogCS8qCiAJICogQXQg
dGhpcyBwb2ludCB3ZSBzaG91bGQgaGF2ZSBlbm91Z2ggY29udGlndW91cyBzcGFjZSBmb3Ig
MiBibG9ja3MsCiAJICogaG93ZXZlciB0aGV5IGFyZSBuZXZlciBidWRkaWVzIChzaW5jZSB3
ZSBmcmVlZCBtaWRkbGUgYW5kIHJpZ2h0KSBzbwpAQCAtODcsMTMgKzg3LDEzIEBAIHN0YXRp
YyB2b2lkIGRybV90ZXN0X2J1ZGR5X2FsbG9jX2NvbnRpZ3VvdXMoc3RydWN0IGt1bml0ICp0
ZXN0KQogCUtVTklUX0FTU0VSVF9GQUxTRV9NU0codGVzdCwgZHJtX2J1ZGR5X2FsbG9jX2Js
b2NrcygmbW0sIDAsIG1tX3NpemUsCiAJCQkJCQkJICAgIDIgKiBwcywgcHMsICZhbGxvY2F0
ZWQsCiAJCQkJCQkJICAgIERSTV9CVUREWV9DT05USUdVT1VTX0FMTE9DQVRJT04pLAotCQkJ
ICAgICAgICJidWRkeV9hbGxvYyBoaXQgYW4gZXJyb3Igc2l6ZT0ldVxuIiwgMiAqIHBzKTsK
KwkJCSAgICAgICAiYnVkZHlfYWxsb2MgaGl0IGFuIGVycm9yIHNpemU9JWx1XG4iLCAyICog
cHMpOwogCiAJZHJtX2J1ZGR5X2ZyZWVfbGlzdCgmbW0sICZsZWZ0KTsKIAlLVU5JVF9BU1NF
UlRfRkFMU0VfTVNHKHRlc3QsIGRybV9idWRkeV9hbGxvY19ibG9ja3MoJm1tLCAwLCBtbV9z
aXplLAogCQkJCQkJCSAgICAzICogcHMsIHBzLCAmYWxsb2NhdGVkLAogCQkJCQkJCSAgICBE
Uk1fQlVERFlfQ09OVElHVU9VU19BTExPQ0FUSU9OKSwKLQkJCSAgICAgICAiYnVkZHlfYWxs
b2MgaGl0IGFuIGVycm9yIHNpemU9JXVcbiIsIDMgKiBwcyk7CisJCQkgICAgICAgImJ1ZGR5
X2FsbG9jIGhpdCBhbiBlcnJvciBzaXplPSVsdVxuIiwgMyAqIHBzKTsKIAogCXRvdGFsID0g
MDsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJsb2NrLCAmYWxsb2NhdGVkLCBsaW5rKQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9tbV90ZXN0LmMgYi9kcml2ZXJz
L2dwdS9kcm0vdGVzdHMvZHJtX21tX3Rlc3QuYwppbmRleCAxZWIwYzMwNGY5NjAuLmYzN2Mw
ZDc2NTg2NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9tbV90ZXN0
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3Rlc3RzL2RybV9tbV90ZXN0LmMKQEAgLTE1Nyw3
ICsxNTcsNyBAQCBzdGF0aWMgdm9pZCBkcm1fdGVzdF9tbV9pbml0KHN0cnVjdCBrdW5pdCAq
dGVzdCkKIAogCS8qIEFmdGVyIGNyZWF0aW9uLCBpdCBzaG91bGQgYWxsIGJlIG9uZSBtYXNz
aXZlIGhvbGUgKi8KIAlpZiAoIWFzc2VydF9vbmVfaG9sZSh0ZXN0LCAmbW0sIDAsIHNpemUp
KSB7Ci0JCUtVTklUX0ZBSUwodGVzdCwgIiIpOworCQlLVU5JVF9GQUlMKHRlc3QsICJtbSBu
b3Qgb25lIGhvbGUgb24gY3JlYXRpb24iKTsKIAkJZ290byBvdXQ7CiAJfQogCkBAIC0xNzEs
MTQgKzE3MSwxNCBAQCBzdGF0aWMgdm9pZCBkcm1fdGVzdF9tbV9pbml0KHN0cnVjdCBrdW5p
dCAqdGVzdCkKIAogCS8qIEFmdGVyIGZpbGxpbmcgdGhlIHJhbmdlIGVudGlyZWx5LCB0aGVy
ZSBzaG91bGQgYmUgbm8gaG9sZXMgKi8KIAlpZiAoIWFzc2VydF9ub19ob2xlcyh0ZXN0LCAm
bW0pKSB7Ci0JCUtVTklUX0ZBSUwodGVzdCwgIiIpOworCQlLVU5JVF9GQUlMKHRlc3QsICJt
bSBoYXMgaG9sZXMgd2hlbiBmaWxsZWQiKTsKIAkJZ290byBvdXQ7CiAJfQogCiAJLyogQW5k
IHRoZW4gYWZ0ZXIgZW1wdHlpbmcgaXQgYWdhaW4sIHRoZSBtYXNzaXZlIGhvbGUgc2hvdWxk
IGJlIGJhY2sgKi8KIAlkcm1fbW1fcmVtb3ZlX25vZGUoJnRtcCk7CiAJaWYgKCFhc3NlcnRf
b25lX2hvbGUodGVzdCwgJm1tLCAwLCBzaXplKSkgewotCQlLVU5JVF9GQUlMKHRlc3QsICIi
KTsKKwkJS1VOSVRfRkFJTCh0ZXN0LCAibW0gZG9lcyBub3QgaGF2ZSBzaW5nbGUgaG9sZSBh
ZnRlciBlbXB0eWluZyIpOwogCQlnb3RvIG91dDsKIAl9CiAKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS94ZS90ZXN0cy94ZV9taWdyYXRlLmMgYi9kcml2ZXJzL2dwdS9kcm0veGUv
dGVzdHMveGVfbWlncmF0ZS5jCmluZGV4IGE2NTIzZGYwZjFkMy4uYzM0N2UyYzI5ZjgxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0veGUvdGVzdHMveGVfbWlncmF0ZS5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS94ZS90ZXN0cy94ZV9taWdyYXRlLmMKQEAgLTExNCwyMSArMTE0
LDIxIEBAIHN0YXRpYyB2b2lkIHRlc3RfY29weShzdHJ1Y3QgeGVfbWlncmF0ZSAqbSwgc3Ry
dWN0IHhlX2JvICpibywKIAkJCQkJCSAgIHJlZ2lvbiB8CiAJCQkJCQkgICBYRV9CT19ORUVE
U19DUFVfQUNDRVNTKTsKIAlpZiAoSVNfRVJSKHJlbW90ZSkpIHsKLQkJS1VOSVRfRkFJTCh0
ZXN0LCAiRmFpbGVkIHRvIGFsbG9jYXRlIHJlbW90ZSBibyBmb3IgJXM6ICVsaVxuIiwKLQkJ
CSAgIHN0ciwgUFRSX0VSUihyZW1vdGUpKTsKKwkJS1VOSVRfRkFJTCh0ZXN0LCAiRmFpbGVk
IHRvIGFsbG9jYXRlIHJlbW90ZSBibyBmb3IgJXM6ICVwZVxuIiwKKwkJCSAgIHN0ciwgcmVt
b3RlKTsKIAkJcmV0dXJuOwogCX0KIAogCWVyciA9IHhlX2JvX3ZhbGlkYXRlKHJlbW90ZSwg
TlVMTCwgZmFsc2UpOwogCWlmIChlcnIpIHsKLQkJS1VOSVRfRkFJTCh0ZXN0LCAiRmFpbGVk
IHRvIHZhbGlkYXRlIHN5c3RlbSBibyBmb3IgJXM6ICVsaVxuIiwKKwkJS1VOSVRfRkFJTCh0
ZXN0LCAiRmFpbGVkIHRvIHZhbGlkYXRlIHN5c3RlbSBibyBmb3IgJXM6ICVpXG4iLAogCQkJ
ICAgc3RyLCBlcnIpOwogCQlnb3RvIG91dF91bmxvY2s7CiAJfQogCiAJZXJyID0geGVfYm9f
dm1hcChyZW1vdGUpOwogCWlmIChlcnIpIHsKLQkJS1VOSVRfRkFJTCh0ZXN0LCAiRmFpbGVk
IHRvIHZtYXAgc3lzdGVtIGJvIGZvciAlczogJWxpXG4iLAorCQlLVU5JVF9GQUlMKHRlc3Qs
ICJGYWlsZWQgdG8gdm1hcCBzeXN0ZW0gYm8gZm9yICVzOiAlaVxuIiwKIAkJCSAgIHN0ciwg
ZXJyKTsKIAkJZ290byBvdXRfdW5sb2NrOwogCX0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRj
L2xpYl90ZXN0LmMgYi9kcml2ZXJzL3J0Yy9saWJfdGVzdC5jCmluZGV4IGQ1Y2FmMzZjNTZj
ZC4uMjI1Yzg1OWQ2ZGE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3J0Yy9saWJfdGVzdC5jCisr
KyBiL2RyaXZlcnMvcnRjL2xpYl90ZXN0LmMKQEAgLTU0LDcgKzU0LDcgQEAgc3RhdGljIHZv
aWQgcnRjX3RpbWU2NF90b190bV90ZXN0X2RhdGVfcmFuZ2Uoc3RydWN0IGt1bml0ICp0ZXN0
KQogCiAJCWRheXMgPSBkaXZfczY0KHNlY3MsIDg2NDAwKTsKIAotCQkjZGVmaW5lIEZBSUxf
TVNHICIlZC8lMDJkLyUwMmQgKCUyZCkgOiAlbGQiLCBcCisJCSNkZWZpbmUgRkFJTF9NU0cg
IiVkLyUwMmQvJTAyZCAoJTJkKSA6ICVsbGQiLCBcCiAJCQl5ZWFyLCBtb250aCwgbWRheSwg
eWRheSwgZGF5cwogCiAJCUtVTklUX0FTU0VSVF9FUV9NU0codGVzdCwgeWVhciAtIDE5MDAs
IHJlc3VsdC50bV95ZWFyLCBGQUlMX01TRyk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2t1bml0
L3Rlc3QuaCBiL2luY2x1ZGUva3VuaXQvdGVzdC5oCmluZGV4IGZjYjRhNDk0MGFjZS4uNjE2
MzdlZjMyMzAyIDEwMDY0NAotLS0gYS9pbmNsdWRlL2t1bml0L3Rlc3QuaAorKysgYi9pbmNs
dWRlL2t1bml0L3Rlc3QuaApAQCAtNTc5LDEyICs1NzksMTIgQEAgdm9pZCBfX3ByaW50Zigy
LCAzKSBrdW5pdF9sb2dfYXBwZW5kKHN0cnVjdCBzdHJpbmdfc3RyZWFtICpsb2csIGNvbnN0
IGNoYXIgKmZtdCwKIAogdm9pZCBfX25vcmV0dXJuIF9fa3VuaXRfYWJvcnQoc3RydWN0IGt1
bml0ICp0ZXN0KTsKIAotdm9pZCBfX2t1bml0X2RvX2ZhaWxlZF9hc3NlcnRpb24oc3RydWN0
IGt1bml0ICp0ZXN0LAotCQkJICAgICAgIGNvbnN0IHN0cnVjdCBrdW5pdF9sb2MgKmxvYywK
LQkJCSAgICAgICBlbnVtIGt1bml0X2Fzc2VydF90eXBlIHR5cGUsCi0JCQkgICAgICAgY29u
c3Qgc3RydWN0IGt1bml0X2Fzc2VydCAqYXNzZXJ0LAotCQkJICAgICAgIGFzc2VydF9mb3Jt
YXRfdCBhc3NlcnRfZm9ybWF0LAotCQkJICAgICAgIGNvbnN0IGNoYXIgKmZtdCwgLi4uKTsK
K3ZvaWQgX19wcmludGYoNiwgNykgX19rdW5pdF9kb19mYWlsZWRfYXNzZXJ0aW9uKHN0cnVj
dCBrdW5pdCAqdGVzdCwKKwkJCQkJCWNvbnN0IHN0cnVjdCBrdW5pdF9sb2MgKmxvYywKKwkJ
CQkJCWVudW0ga3VuaXRfYXNzZXJ0X3R5cGUgdHlwZSwKKwkJCQkJCWNvbnN0IHN0cnVjdCBr
dW5pdF9hc3NlcnQgKmFzc2VydCwKKwkJCQkJCWFzc2VydF9mb3JtYXRfdCBhc3NlcnRfZm9y
bWF0LAorCQkJCQkJY29uc3QgY2hhciAqZm10LCAuLi4pOwogCiAjZGVmaW5lIF9LVU5JVF9G
QUlMRUQodGVzdCwgYXNzZXJ0X3R5cGUsIGFzc2VydF9jbGFzcywgYXNzZXJ0X2Zvcm1hdCwg
SU5JVElBTElaRVIsIGZtdCwgLi4uKSBkbyB7IFwKIAlzdGF0aWMgY29uc3Qgc3RydWN0IGt1
bml0X2xvYyBfX2xvYyA9IEtVTklUX0NVUlJFTlRfTE9DOwkgICAgICAgXApkaWZmIC0tZ2l0
IGEva2VybmVsL3RpbWUvdGltZV90ZXN0LmMgYi9rZXJuZWwvdGltZS90aW1lX3Rlc3QuYwpp
bmRleCBjYTA1OGM4YWY2YmEuLjNlNWQ0MjJkZDE1YyAxMDA2NDQKLS0tIGEva2VybmVsL3Rp
bWUvdGltZV90ZXN0LmMKKysrIGIva2VybmVsL3RpbWUvdGltZV90ZXN0LmMKQEAgLTczLDcg
KzczLDcgQEAgc3RhdGljIHZvaWQgdGltZTY0X3RvX3RtX3Rlc3RfZGF0ZV9yYW5nZShzdHJ1
Y3Qga3VuaXQgKnRlc3QpCiAKIAkJZGF5cyA9IGRpdl9zNjQoc2VjcywgODY0MDApOwogCi0J
CSNkZWZpbmUgRkFJTF9NU0cgIiUwNWxkLyUwMmQvJTAyZCAoJTJkKSA6ICVsZCIsIFwKKwkJ
I2RlZmluZSBGQUlMX01TRyAiJTA1bGQvJTAyZC8lMDJkICglMmQpIDogJWxsZCIsIFwKIAkJ
CXllYXIsIG1vbnRoLCBtZGRheSwgeWRheSwgZGF5cwogCiAJCUtVTklUX0FTU0VSVF9FUV9N
U0codGVzdCwgeWVhciAtIDE5MDAsIHJlc3VsdC50bV95ZWFyLCBGQUlMX01TRyk7CmRpZmYg
LS1naXQgYS9saWIvY21kbGluZV9rdW5pdC5jIGIvbGliL2NtZGxpbmVfa3VuaXQuYwppbmRl
eCBkNDU3MmRiYzkxNDUuLjcwNWI4MjczNmJlMCAxMDA2NDQKLS0tIGEvbGliL2NtZGxpbmVf
a3VuaXQuYworKysgYi9saWIvY21kbGluZV9rdW5pdC5jCkBAIC0xMjQsNyArMTI0LDcgQEAg
c3RhdGljIHZvaWQgY21kbGluZV9kb19vbmVfcmFuZ2VfdGVzdChzdHJ1Y3Qga3VuaXQgKnRl
c3QsIGNvbnN0IGNoYXIgKmluLAogCQkJICAgIG4sIGVbMF0sIHJbMF0pOwogCiAJcCA9IG1l
bWNocl9pbnYoJnJbMV0sIDAsIHNpemVvZihyKSAtIHNpemVvZihyWzBdKSk7Ci0JS1VOSVRf
RVhQRUNUX1BUUl9FUV9NU0codGVzdCwgcCwgTlVMTCwgImluIHRlc3QgJXUgYXQgJXUgb3V0
IG9mIGJvdW5kIiwgbiwgcCAtIHIpOworCUtVTklUX0VYUEVDVF9QVFJfRVFfTVNHKHRlc3Qs
IHAsIE5VTEwsICJpbiB0ZXN0ICV1IGF0ICV0ZCBvdXQgb2YgYm91bmQiLCBuLCBwIC0gcik7
CiB9CiAKIHN0YXRpYyB2b2lkIGNtZGxpbmVfdGVzdF9yYW5nZShzdHJ1Y3Qga3VuaXQgKnRl
c3QpCmRpZmYgLS1naXQgYS9saWIva3VuaXQvZGV2aWNlLmMgYi9saWIva3VuaXQvZGV2aWNl
LmMKaW5kZXggNjQ0YTM4YTFmNWIxLi5hYmM2MDM3MzBiOGUgMTAwNjQ0Ci0tLSBhL2xpYi9r
dW5pdC9kZXZpY2UuYworKysgYi9saWIva3VuaXQvZGV2aWNlLmMKQEAgLTEwLDYgKzEwLDcg
QEAKICAqLwogCiAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisjaW5jbHVkZSA8bGludXgv
ZG1hLW1hcHBpbmcuaD4KIAogI2luY2x1ZGUgPGt1bml0L3Rlc3QuaD4KICNpbmNsdWRlIDxr
dW5pdC9kZXZpY2UuaD4KQEAgLTM1LDcgKzM2LDcgQEAgc3RydWN0IGt1bml0X2RldmljZSB7
CiAKICNkZWZpbmUgdG9fa3VuaXRfZGV2aWNlKGQpIGNvbnRhaW5lcl9vZl9jb25zdChkLCBz
dHJ1Y3Qga3VuaXRfZGV2aWNlLCBkZXYpCiAKLXN0YXRpYyBzdHJ1Y3QgYnVzX3R5cGUga3Vu
aXRfYnVzX3R5cGUgPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IGJ1c190eXBlIGt1bml0X2J1
c190eXBlID0gewogCS5uYW1lCQk9ICJrdW5pdCIsCiB9OwogCkBAIC0xMzMsNiArMTM0LDkg
QEAgc3RhdGljIHN0cnVjdCBrdW5pdF9kZXZpY2UgKmt1bml0X2RldmljZV9yZWdpc3Rlcl9p
bnRlcm5hbChzdHJ1Y3Qga3VuaXQgKnRlc3QsCiAJCXJldHVybiBFUlJfUFRSKGVycik7CiAJ
fQogCisJa3VuaXRfZGV2LT5kZXYuZG1hX21hc2sgPSAma3VuaXRfZGV2LT5kZXYuY29oZXJl
bnRfZG1hX21hc2s7CisJa3VuaXRfZGV2LT5kZXYuY29oZXJlbnRfZG1hX21hc2sgPSBETUFf
QklUX01BU0soMzIpOworCiAJa3VuaXRfYWRkX2FjdGlvbih0ZXN0LCBkZXZpY2VfdW5yZWdp
c3Rlcl93cmFwcGVyLCAma3VuaXRfZGV2LT5kZXYpOwogCiAJcmV0dXJuIGt1bml0X2RldjsK
ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9leGVjdXRvci5jIGIvbGliL2t1bml0L2V4ZWN1dG9y
LmMKaW5kZXggNjg5ZmZmMmIyYjEwLi43MGI5YTQzY2QyNTcgMTAwNjQ0Ci0tLSBhL2xpYi9r
dW5pdC9leGVjdXRvci5jCisrKyBiL2xpYi9rdW5pdC9leGVjdXRvci5jCkBAIC0zMywxMyAr
MzMsMTMgQEAgc3RhdGljIGNoYXIgKmZpbHRlcl9nbG9iX3BhcmFtOwogc3RhdGljIGNoYXIg
KmZpbHRlcl9wYXJhbTsKIHN0YXRpYyBjaGFyICpmaWx0ZXJfYWN0aW9uX3BhcmFtOwogCi1t
b2R1bGVfcGFyYW1fbmFtZWQoZmlsdGVyX2dsb2IsIGZpbHRlcl9nbG9iX3BhcmFtLCBjaGFy
cCwgMDQwMCk7Cittb2R1bGVfcGFyYW1fbmFtZWQoZmlsdGVyX2dsb2IsIGZpbHRlcl9nbG9i
X3BhcmFtLCBjaGFycCwgMDYwMCk7CiBNT0RVTEVfUEFSTV9ERVNDKGZpbHRlcl9nbG9iLAog
CQkiRmlsdGVyIHdoaWNoIEtVbml0IHRlc3Qgc3VpdGVzL3Rlc3RzIHJ1biBhdCBib290LXRp
bWUsIGUuZy4gbGlzdCogb3IgbGlzdCouKmRlbF90ZXN0Iik7Ci1tb2R1bGVfcGFyYW1fbmFt
ZWQoZmlsdGVyLCBmaWx0ZXJfcGFyYW0sIGNoYXJwLCAwNDAwKTsKK21vZHVsZV9wYXJhbV9u
YW1lZChmaWx0ZXIsIGZpbHRlcl9wYXJhbSwgY2hhcnAsIDA2MDApOwogTU9EVUxFX1BBUk1f
REVTQyhmaWx0ZXIsCiAJCSJGaWx0ZXIgd2hpY2ggS1VuaXQgdGVzdCBzdWl0ZXMvdGVzdHMg
cnVuIGF0IGJvb3QtdGltZSB1c2luZyBhdHRyaWJ1dGVzLCBlLmcuIHNwZWVkPnNsb3ciKTsK
LW1vZHVsZV9wYXJhbV9uYW1lZChmaWx0ZXJfYWN0aW9uLCBmaWx0ZXJfYWN0aW9uX3BhcmFt
LCBjaGFycCwgMDQwMCk7Cittb2R1bGVfcGFyYW1fbmFtZWQoZmlsdGVyX2FjdGlvbiwgZmls
dGVyX2FjdGlvbl9wYXJhbSwgY2hhcnAsIDA2MDApOwogTU9EVUxFX1BBUk1fREVTQyhmaWx0
ZXJfYWN0aW9uLAogCQkiQ2hhbmdlcyBiZWhhdmlvciBvZiBmaWx0ZXJlZCB0ZXN0cyB1c2lu
ZyBhdHRyaWJ1dGVzLCB2YWxpZCB2YWx1ZXMgYXJlOlxuIgogCQkiPG5vbmU+OiBkbyBub3Qg
cnVuIGZpbHRlcmVkIHRlc3RzIGFzIG5vcm1hbFxuIgpkaWZmIC0tZ2l0IGEvbGliL2t1bml0
L2V4ZWN1dG9yX3Rlc3QuYyBiL2xpYi9rdW5pdC9leGVjdXRvcl90ZXN0LmMKaW5kZXggMjJk
NGVlODZkYmVkLi4zZjdmOTY3ZTM2ODggMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9leGVjdXRv
cl90ZXN0LmMKKysrIGIvbGliL2t1bml0L2V4ZWN1dG9yX3Rlc3QuYwpAQCAtMTI5LDcgKzEy
OSw3IEBAIHN0YXRpYyB2b2lkIHBhcnNlX2ZpbHRlcl9hdHRyX3Rlc3Qoc3RydWN0IGt1bml0
ICp0ZXN0KQogCQkJR0ZQX0tFUk5FTCk7CiAJZm9yIChqID0gMDsgaiA8IGZpbHRlcl9jb3Vu
dDsgaisrKSB7CiAJCXBhcnNlZF9maWx0ZXJzW2pdID0ga3VuaXRfbmV4dF9hdHRyX2ZpbHRl
cigmZmlsdGVyLCAmZXJyKTsKLQkJS1VOSVRfQVNTRVJUX0VRX01TRyh0ZXN0LCBlcnIsIDAs
ICJmYWlsZWQgdG8gcGFyc2UgZmlsdGVyICclcyciLCBmaWx0ZXJzW2pdKTsKKwkJS1VOSVRf
QVNTRVJUX0VRX01TRyh0ZXN0LCBlcnIsIDAsICJmYWlsZWQgdG8gcGFyc2UgZmlsdGVyIGZy
b20gJyVzJyIsIGZpbHRlcnMpOwogCX0KIAogCUtVTklUX0VYUEVDVF9TVFJFUSh0ZXN0LCBr
dW5pdF9hdHRyX2ZpbHRlcl9uYW1lKHBhcnNlZF9maWx0ZXJzWzBdKSwgInNwZWVkIik7CmRp
ZmYgLS1naXQgYS9saWIvbWVtY3B5X2t1bml0LmMgYi9saWIvbWVtY3B5X2t1bml0LmMKaW5k
ZXggNDQwYWVlNzA1Y2NjLi4zMGUwMGVmMGJmMmUgMTAwNjQ0Ci0tLSBhL2xpYi9tZW1jcHlf
a3VuaXQuYworKysgYi9saWIvbWVtY3B5X2t1bml0LmMKQEAgLTMyLDcgKzMyLDcgQEAgc3Ry
dWN0IHNvbWVfYnl0ZXMgewogCUJVSUxEX0JVR19PTihzaXplb2YoaW5zdGFuY2UuZGF0YSkg
IT0gMzIpOwlcCiAJZm9yIChzaXplX3QgaSA9IDA7IGkgPCBzaXplb2YoaW5zdGFuY2UuZGF0
YSk7IGkrKykgewlcCiAJCUtVTklUX0FTU0VSVF9FUV9NU0codGVzdCwgaW5zdGFuY2UuZGF0
YVtpXSwgdiwgXAotCQkJImxpbmUgJWQ6ICclcycgbm90IGluaXRpYWxpemVkIHRvIDB4JTAy
eCBAICVkIChzYXcgMHglMDJ4KVxuIiwgXAorCQkJImxpbmUgJWQ6ICclcycgbm90IGluaXRp
YWxpemVkIHRvIDB4JTAyeCBAICV6dSAoc2F3IDB4JTAyeClcbiIsIFwKIAkJCV9fTElORV9f
LCAjaW5zdGFuY2UsIHYsIGksIGluc3RhbmNlLmRhdGFbaV0pOwlcCiAJfQlcCiB9IHdoaWxl
ICgwKQpAQCAtNDEsNyArNDEsNyBAQCBzdHJ1Y3Qgc29tZV9ieXRlcyB7CiAJQlVJTERfQlVH
X09OKHNpemVvZihvbmUpICE9IHNpemVvZih0d28pKTsgXAogCWZvciAoc2l6ZV90IGkgPSAw
OyBpIDwgc2l6ZW9mKG9uZSk7IGkrKykgewlcCiAJCUtVTklUX0VYUEVDVF9FUV9NU0codGVz
dCwgb25lLmRhdGFbaV0sIHR3by5kYXRhW2ldLCBcCi0JCQkibGluZSAlZDogJXMuZGF0YVsl
ZF0gKDB4JTAyeCkgIT0gJXMuZGF0YVslZF0gKDB4JTAyeClcbiIsIFwKKwkJCSJsaW5lICVk
OiAlcy5kYXRhWyV6dV0gKDB4JTAyeCkgIT0gJXMuZGF0YVslenVdICgweCUwMngpXG4iLCBc
CiAJCQlfX0xJTkVfXywgI29uZSwgaSwgb25lLmRhdGFbaV0sICN0d28sIGksIHR3by5kYXRh
W2ldKTsgXAogCX0JXAogCWt1bml0X2luZm8odGVzdCwgIm9rOiAiIFRFU1RfT1AgIigpICIg
bmFtZSAiXG4iKTsJXApkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZ3NvX3Rlc3QuYyBiL25ldC9j
b3JlL2dzb190ZXN0LmMKaW5kZXggNGMyZTc3YmQxMmY0Li4zNThjNDQ2ODBkOTEgMTAwNjQ0
Ci0tLSBhL25ldC9jb3JlL2dzb190ZXN0LmMKKysrIGIvbmV0L2NvcmUvZ3NvX3Rlc3QuYwpA
QCAtMjI1LDcgKzIyNSw3IEBAIHN0YXRpYyB2b2lkIGdzb190ZXN0X2Z1bmMoc3RydWN0IGt1
bml0ICp0ZXN0KQogCiAJc2VncyA9IHNrYl9zZWdtZW50KHNrYiwgZmVhdHVyZXMpOwogCWlm
IChJU19FUlIoc2VncykpIHsKLQkJS1VOSVRfRkFJTCh0ZXN0LCAic2VncyBlcnJvciAlbGxk
IiwgUFRSX0VSUihzZWdzKSk7CisJCUtVTklUX0ZBSUwodGVzdCwgInNlZ3MgZXJyb3IgJXBl
Iiwgc2Vncyk7CiAJCWdvdG8gZnJlZV9nc29fc2tiOwogCX0gZWxzZSBpZiAoIXNlZ3MpIHsK
IAkJS1VOSVRfRkFJTCh0ZXN0LCAibm8gc2VnbWVudHMiKTsKZGlmZiAtLWdpdCBhL3Rvb2xz
L3Rlc3Rpbmcva3VuaXQva3VuaXRfa2VybmVsLnB5IGIvdG9vbHMvdGVzdGluZy9rdW5pdC9r
dW5pdF9rZXJuZWwucHkKaW5kZXggMGI2NDg4ZWZlZDQ3Li43MjU0YzExMGZmMjMgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXRfa2VybmVsLnB5CisrKyBiL3Rvb2xz
L3Rlc3Rpbmcva3VuaXQva3VuaXRfa2VybmVsLnB5CkBAIC0xNDYsNiArMTQ2LDcgQEAgY2xh
c3MgTGludXhTb3VyY2VUcmVlT3BlcmF0aW9uc1VtbChMaW51eFNvdXJjZVRyZWVPcGVyYXRp
b25zKToKIAkJIiIiUnVucyB0aGUgTGludXggVU1MIGJpbmFyeS4gTXVzdCBiZSBuYW1lZCAn
bGludXgnLiIiIgogCQlsaW51eF9iaW4gPSBvcy5wYXRoLmpvaW4oYnVpbGRfZGlyLCAnbGlu
dXgnKQogCQlwYXJhbXMuZXh0ZW5kKFsnbWVtPTFHJywgJ2NvbnNvbGU9dHR5JywgJ2t1bml0
X3NodXRkb3duPWhhbHQnXSkKKwkJcHJpbnQoJ1J1bm5pbmcgdGVzdHMgd2l0aDpcbiQnLCBs
aW51eF9iaW4sICcgJy5qb2luKHNobGV4LnF1b3RlKGFyZykgZm9yIGFyZyBpbiBwYXJhbXMp
KQogCQlyZXR1cm4gc3VicHJvY2Vzcy5Qb3BlbihbbGludXhfYmluXSArIHBhcmFtcywKIAkJ
CQkJICAgc3RkaW49c3VicHJvY2Vzcy5QSVBFLAogCQkJCQkgICBzdGRvdXQ9c3VicHJvY2Vz
cy5QSVBFLAo=

--------------9ZDWGCPNPype8UplQxBtNQ0f--


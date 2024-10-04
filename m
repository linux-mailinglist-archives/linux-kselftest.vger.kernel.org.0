Return-Path: <linux-kselftest+bounces-19043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC599099D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EF91C20E36
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216384CDEC;
	Fri,  4 Oct 2024 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GYil2C5B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326A1E3795
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060302; cv=none; b=gW7k2B9e/POT/FNH5BXbHHo8CrlpyuYJ9/bCCPZUyDlQnYdyxlD3/8Mcoegerui/RIUGTmMNs3Ro09BX+PK+u3sWYTLIVak4fxEikeuRA6pINFfPpAahvfohR2q0RmRSK92fCbGCoeUO7cUn8ZH0C1Nk7Ix3C8/QPQoXI2dB6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060302; c=relaxed/simple;
	bh=Hq80wbTCVLtZ21mLi7c3CaTFZ5LjUehB/a3vjSHHbCI=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc; b=cSlALR60R9ThR03yBffPKr0czxZChnUnzEnH+jHdgOSHya05MFpmAr6Xg/54IuoCz4MhmY0qP2khs5T4emncuGqWv3kpYxOc2WGzPA0BHa4UQPz3snE7WmyDQaRJeixeDbR4f9FqHyXSvNCBo3PuW/yg5fVC04il4YjpqFeeIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GYil2C5B; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a2761f1227so7710785ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2024 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728060299; x=1728665099; darn=vger.kernel.org;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fdxfDM/YObFCf1TC5a8kva0Yj7FTK3ndHvZQFOO6mGM=;
        b=GYil2C5Bn540ppINVmcJB4oK9A8wFXHZpDtx94Eh3EyYCwpRrfs3jGwOwsupmJ2+hO
         hA2em+cevKu7Vdu+GIk2/BFvHa9Y332bQxDvGFZZm30FcDQmIVdvkg1BISTYNs68gUz6
         wATu5IgFjT5LDDCCSVRpTLIkuVRsVdtMt8YZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060299; x=1728665099;
        h=cc:to:subject:from:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdxfDM/YObFCf1TC5a8kva0Yj7FTK3ndHvZQFOO6mGM=;
        b=pd0F76ANv5yxsSBf4QG9IQeRW+Po6k/6uOTAfuifFutog34lIf66PMmLsIzYuhiXl4
         Y3xUn9rJStGdN7PZc6JvaQmqcchHE7bBQOpmxVSwHfwzR/gR+8Kglyl1uXMUInGCC7x8
         +hr0EiYsHYHULADQztWiSxoXcaZXpceQ7t67XPjU7rQPsGHhIjPdC9ewQyHNKoHQcvgw
         aUbMEMpxtd0Tcr1TDWusa279W0gXeaof9m9qFw7crM4rwjVr6hLecaQHqYugOn9SsQqf
         PO7XyabBPHlh75CS6gB4K4lZE2TKwvSYX7wNMbRoPztZCqCLSB/1SMKVfI/Dq8VI58qo
         eXEg==
X-Forwarded-Encrypted: i=1; AJvYcCUBXAhKlfJZLxcVDA3/GZOX+V3PZAG20XB8Ps8bPkgwO0gWfrNsdk0iDVx+SnUYuuXNOXPDsEyCOUw5NIZgJJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVti+O/rObU3P/uGm6KzPR/SAHYJ5VBfPGeBsUXi5XUCeqALJ6
	BqPRgR7FtFEJjo2amh5/B4Gszu47AptFdTTnNIgXui/n7kghyoR/Vhzd6Y3L/eKGl6SENyJ5ZYO
	u
X-Google-Smtp-Source: AGHT+IHEi2v56POM6xL7GHZvZjM6YypaFAN5/G2CvNlipESRFhxdVYzbtcgaVWdCvTUt3untKDlrGQ==
X-Received: by 2002:a05:6e02:2142:b0:3a3:5fad:77b4 with SMTP id e9e14a558f8ab-3a37597788emr36334775ab.3.1728060299009;
        Fri, 04 Oct 2024 09:44:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7e790bsm451965ab.10.2024.10.04.09.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:44:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------JAiHeT6I3XGhUdM916rbj7VZ"
Message-ID: <2d95ac4d-e239-49ba-ad72-368284a3ae25@linuxfoundation.org>
Date: Fri, 4 Oct 2024 10:44:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.12-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------JAiHeT6I3XGhUdM916rbj7VZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest fixes update for Linux 6.12-rc2.

This kselftest fixes update for Linux 6.12-rc2 consists of fixes
to build warnings, install scripts, run-time error path, and
git status cleanups to tests:

-- devices/probe: fix for Python3 regex string syntax warnings
-- clone3: removing unused macro from clone3_cap_checkpoint_restore()
-- vDSO: fix to align getrandom states to cache line
-- core and exec: add missing executables to .gitignore files
-- rtc: change to skip test if /dev/rtc0 can't be accessed
-- timers/posix: fix warn_unused_result result in __fatal_error()
-- breakpoints: fix to detect suspend successful condition correctly
-- hid: fix to install required dependencies to run the test

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.12-rc2

for you to fetch changes up to c66be905cda24fb782b91053b196bd2e966f95b7:

   selftests: breakpoints: use remaining time to check if suspend succeed (2024-10-02 14:37:30 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.12-rc2

This kselftest fixes update for Linux 6.12-rc2 consists of fixes
to build warnings, install scripts, run-time error path, and
git status cleanups to tests:

-- devices/probe: fix for Python3 regex string syntax warnings
-- clone3: removing unused macro from clone3_cap_checkpoint_restore()
-- vDSO: fix to align getrandom states to cache line
-- core and exec: add missing executables to .gitignore files
-- rtc: change to skip test if /dev/rtc0 can't be accessed
-- timers/posix: fix warn_unused_result result in __fatal_error()
-- breakpoints: fix to detect suspend successful condition correctly
-- hid: fix to install required dependencies to run the test

----------------------------------------------------------------
Alessandro Zanni (1):
       kselftest/devices/probe: Fix SyntaxWarning in regex strings for Python3

Ba Jing (1):
       clone3: clone3_cap_checkpoint_restore: remove unused MAX_PID_NS_LEVEL macro

Jason A. Donenfeld (1):
       selftests: vDSO: align getrandom states to cache line

Javier Carrasco (2):
       selftests: core: add unshare_test to gitignore
       selftests: exec: update gitignore for load_address

Joseph Jang (1):
       selftest: rtc: Check if could access /dev/rtc0 before testing

Shuah Khan (1):
       selftests:timers: posix_timers: Fix warn_unused_result in __fatal_error()

Yifei Liu (1):
       selftests: breakpoints: use remaining time to check if suspend succeed

Yun Lu (1):
       selftest: hid: add missing run-hid-tools-tests.sh

  .../testing/selftests/breakpoints/step_after_suspend_test.c  |  5 ++++-
  .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c |  2 --
  tools/testing/selftests/core/.gitignore                      |  1 +
  .../selftests/devices/probe/test_discoverable_devices.py     |  4 ++--
  tools/testing/selftests/exec/.gitignore                      |  3 ++-
  tools/testing/selftests/hid/Makefile                         |  2 ++
  tools/testing/selftests/rtc/rtctest.c                        | 11 ++++++++++-
  tools/testing/selftests/timers/posix_timers.c                | 12 ++++++++----
  tools/testing/selftests/vDSO/vdso_test_getrandom.c           |  8 +++++---
  9 files changed, 34 insertions(+), 14 deletions(-)
----------------------------------------------------------------
--------------JAiHeT6I3XGhUdM916rbj7VZ
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.12-rc2.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.12-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JyZWFrcG9pbnRzL3N0ZXBf
YWZ0ZXJfc3VzcGVuZF90ZXN0LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3Bv
aW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jCmluZGV4IGRmZWMzMWZiOWIzMC4uOGQy
NzVmMDNlOTc3IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icmVha3Bv
aW50cy9zdGVwX2FmdGVyX3N1c3BlbmRfdGVzdC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JyZWFrcG9pbnRzL3N0ZXBfYWZ0ZXJfc3VzcGVuZF90ZXN0LmMKQEAgLTE1Miw3
ICsxNTIsMTAgQEAgdm9pZCBzdXNwZW5kKHZvaWQpCiAJaWYgKGVyciA8IDApCiAJCWtzZnRf
ZXhpdF9mYWlsX21zZygidGltZXJmZF9zZXR0aW1lKCkgZmFpbGVkXG4iKTsKIAotCWlmICh3
cml0ZShwb3dlcl9zdGF0ZV9mZCwgIm1lbSIsIHN0cmxlbigibWVtIikpICE9IHN0cmxlbigi
bWVtIikpCisJc3lzdGVtKCIoZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlKSAyPiAvZGV2
L251bGwiKTsKKworCXRpbWVyZmRfZ2V0dGltZSh0aW1lcmZkLCAmc3BlYyk7CisJaWYgKHNw
ZWMuaXRfdmFsdWUudHZfc2VjICE9IDAgfHwgc3BlYy5pdF92YWx1ZS50dl9uc2VjICE9IDAp
CiAJCWtzZnRfZXhpdF9mYWlsX21zZygiRmFpbGVkIHRvIGVudGVyIFN1c3BlbmQgc3RhdGVc
biIpOwogCiAJY2xvc2UodGltZXJmZCk7CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9jbG9uZTMvY2xvbmUzX2NhcF9jaGVja3BvaW50X3Jlc3RvcmUuYyBiL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Nsb25lMy9jbG9uZTNfY2FwX2NoZWNrcG9pbnRfcmVzdG9y
ZS5jCmluZGV4IDMxYjU2ZDYyNTY1NS4uM2MxOTZmYTg2Yzk5IDEwMDY0NAotLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xvbmUzX2NhcF9jaGVja3BvaW50X3Jlc3Rv
cmUuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jbG9uZTMvY2xvbmUzX2NhcF9j
aGVja3BvaW50X3Jlc3RvcmUuYwpAQCAtMjcsOCArMjcsNiBAQAogI2luY2x1ZGUgIi4uL2tz
ZWxmdGVzdF9oYXJuZXNzLmgiCiAjaW5jbHVkZSAiY2xvbmUzX3NlbGZ0ZXN0cy5oIgogCi0j
ZGVmaW5lIE1BWF9QSURfTlNfTEVWRUwgMzIKLQogc3RhdGljIHZvaWQgY2hpbGRfZXhpdChp
bnQgcmV0KQogewogCWZmbHVzaChzdGRvdXQpOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvY29yZS8uZ2l0aWdub3JlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
Y29yZS8uZ2l0aWdub3JlCmluZGV4IDZlNjcxMmNlNTgxNy4uNzk5OTM2MTk5MmFhIDEwMDY0
NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jb3JlLy5naXRpZ25vcmUKKysrIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvY29yZS8uZ2l0aWdub3JlCkBAIC0xICsxLDIgQEAK
IGNsb3NlX3JhbmdlX3Rlc3QKK3Vuc2hhcmVfdGVzdApkaWZmIC0tZ2l0IGEvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZGV2aWNlcy9wcm9iZS90ZXN0X2Rpc2NvdmVyYWJsZV9kZXZpY2Vz
LnB5IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZGV2aWNlcy9wcm9iZS90ZXN0X2Rpc2Nv
dmVyYWJsZV9kZXZpY2VzLnB5CmluZGV4IGQ5NGE3NGI4YTA1NC4uZDdhMmJiOTFjODA3IDEw
MDc1NQotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kZXZpY2VzL3Byb2JlL3Rlc3Rf
ZGlzY292ZXJhYmxlX2RldmljZXMucHkKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZGV2aWNlcy9wcm9iZS90ZXN0X2Rpc2NvdmVyYWJsZV9kZXZpY2VzLnB5CkBAIC00NSw3ICs0
NSw3IEBAIGRlZiBmaW5kX3BjaV9jb250cm9sbGVyX2RpcnMoKToKIAogCiBkZWYgZmluZF91
c2JfY29udHJvbGxlcl9kaXJzKCk6Ci0gICAgdXNiX2NvbnRyb2xsZXJfc3lzZnNfZGlyID0g
InVzYltcZF0rIgorICAgIHVzYl9jb250cm9sbGVyX3N5c2ZzX2RpciA9IHIidXNiW1xkXSsi
CiAKICAgICBkaXJfcmVnZXggPSByZS5jb21waWxlKHVzYl9jb250cm9sbGVyX3N5c2ZzX2Rp
cikKICAgICBmb3IgZCBpbiBvcy5zY2FuZGlyKHN5c2ZzX3VzYl9kZXZpY2VzKToKQEAgLTkx
LDcgKzkxLDcgQEAgZGVmIGdldF9hY3BpX3VpZChzeXNmc19kZXZfZGlyKToKIAogCiBkZWYg
Z2V0X3VzYl92ZXJzaW9uKHN5c2ZzX2Rldl9kaXIpOgotICAgIHJlX3VzYl92ZXJzaW9uID0g
cmUuY29tcGlsZSgiUFJPRFVDVD0uKi8oXGQpLy4qIikKKyAgICByZV91c2JfdmVyc2lvbiA9
IHJlLmNvbXBpbGUociJQUk9EVUNUPS4qLyhcZCkvLioiKQogICAgIHdpdGggb3Blbihvcy5w
YXRoLmpvaW4oc3lzZnNfZGV2X2RpciwgInVldmVudCIpKSBhcyBmOgogICAgICAgICByZXR1
cm4gaW50KHJlX3VzYl92ZXJzaW9uLnNlYXJjaChmLnJlYWQoKSkuZ3JvdXAoMSkpCiAKZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2V4ZWMvLmdpdGlnbm9yZSBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2V4ZWMvLmdpdGlnbm9yZQppbmRleCA5MGMyMzhiYTZh
NGIuLmEwZGM1ZDRiZjczMyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
ZXhlYy8uZ2l0aWdub3JlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2V4ZWMvLmdp
dGlnbm9yZQpAQCAtOSw3ICs5LDggQEAgZXhlY3ZlYXQuZXBoZW1lcmFsCiBleGVjdmVhdC5k
ZW5hdHVyZWQKIG5vbi1yZWd1bGFyCiBudWxsLWFyZ3YKLS9sb2FkX2FkZHJlc3NfKgorL2xv
YWRfYWRkcmVzcy4qCishbG9hZF9hZGRyZXNzLmMKIC9yZWN1cnNpb24tZGVwdGgKIHh4eHh4
eHh4KgogcGlwZQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlkL01h
a2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlkL01ha2VmaWxlCmluZGV4IDcy
YmU1NWFjNGJkZi4uMzhhZTMxYmIwN2I1IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9oaWQvTWFrZWZpbGUKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvaGlk
L01ha2VmaWxlCkBAIC0xNyw2ICsxNyw4IEBAIFRFU1RfUFJPR1MgKz0gaGlkLXRhYmxldC5z
aAogVEVTVF9QUk9HUyArPSBoaWQtdXNiX2NyYXNoLnNoCiBURVNUX1BST0dTICs9IGhpZC13
YWNvbS5zaAogCitURVNUX0ZJTEVTIDo9IHJ1bi1oaWQtdG9vbHMtdGVzdHMuc2gKKwogQ1hY
ID89ICQoQ1JPU1NfQ09NUElMRSlnKysKIAogSE9TVFBLR19DT05GSUcgOj0gcGtnLWNvbmZp
ZwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnRjL3J0Y3Rlc3QuYyBi
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3J0Yy9ydGN0ZXN0LmMKaW5kZXggOTY0N2IxNGI0
N2M1Li4zOGE4ZTY3ZGU3N2QgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3J0Yy9ydGN0ZXN0LmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcnRjL3J0Y3Rl
c3QuYwpAQCAtNDEyLDYgKzQxMiw4IEBAIFRFU1RfRl9USU1FT1VUKHJ0YywgYWxhcm1fd2th
bG1fc2V0X21pbnV0ZSwgNjUpIHsKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2
KQogeworCWludCByZXQgPSAtMTsKKwogCXN3aXRjaCAoYXJnYykgewogCWNhc2UgMjoKIAkJ
cnRjX2ZpbGUgPSBhcmd2WzFdOwpAQCAtNDIzLDUgKzQyNSwxMiBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqKmFyZ3YpCiAJCXJldHVybiAxOwogCX0KIAotCXJldHVybiB0ZXN0X2hh
cm5lc3NfcnVuKGFyZ2MsIGFyZ3YpOworCS8qIFJ1biB0aGUgdGVzdCBpZiBydGNfZmlsZSBp
cyBhY2Nlc3NpYmxlICovCisJaWYgKGFjY2VzcyhydGNfZmlsZSwgUl9PSykgPT0gMCkKKwkJ
cmV0ID0gdGVzdF9oYXJuZXNzX3J1bihhcmdjLCBhcmd2KTsKKwllbHNlCisJCWtzZnRfZXhp
dF9za2lwKCJbU0tJUF06IENhbm5vdCBhY2Nlc3MgcnRjIGZpbGUgJXMgLSBFeGl0aW5nXG4i
LAorCQkJCQkJcnRjX2ZpbGUpOworCisJcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9wb3NpeF90aW1lcnMuYyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL3RpbWVycy9wb3NpeF90aW1lcnMuYwppbmRleCAxNmJkNDk0OTJl
ZmEuLmRkYjFjZWJjODQ0ZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
dGltZXJzL3Bvc2l4X3RpbWVycy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Rp
bWVycy9wb3NpeF90aW1lcnMuYwpAQCAtMjYsMTMgKzI2LDE3IEBACiBzdGF0aWMgdm9pZCBf
X2ZhdGFsX2Vycm9yKGNvbnN0IGNoYXIgKnRlc3QsIGNvbnN0IGNoYXIgKm5hbWUsIGNvbnN0
IGNoYXIgKndoYXQpCiB7CiAJY2hhciBidWZbNjRdOworCWNoYXIgKnJldF9zdHIgPSBOVUxM
OwogCi0Jc3RyZXJyb3JfcihlcnJubywgYnVmLCBzaXplb2YoYnVmKSk7CisJcmV0X3N0ciA9
IHN0cmVycm9yX3IoZXJybm8sIGJ1Ziwgc2l6ZW9mKGJ1ZikpOwogCi0JaWYgKG5hbWUgJiYg
c3RybGVuKG5hbWUpKQotCQlrc2Z0X2V4aXRfZmFpbF9tc2coIiVzICVzICVzICVzXG4iLCB0
ZXN0LCBuYW1lLCB3aGF0LCBidWYpOworCWlmIChuYW1lICYmIHN0cmxlbihuYW1lKSAmJiBy
ZXRfc3RyKQorCQlrc2Z0X2V4aXRfZmFpbF9tc2coIiVzICVzICVzICVzXG4iLCB0ZXN0LCBu
YW1lLCB3aGF0LCByZXRfc3RyKTsKKwllbHNlIGlmIChyZXRfc3RyKQorCQlrc2Z0X2V4aXRf
ZmFpbF9tc2coIiVzICVzICVzXG4iLCB0ZXN0LCB3aGF0LCByZXRfc3RyKTsKIAllbHNlCi0J
CWtzZnRfZXhpdF9mYWlsX21zZygiJXMgJXMgJXNcbiIsIHRlc3QsIHdoYXQsIGJ1Zik7CisJ
CWtzZnRfZXhpdF9mYWlsX21zZygiJXMgJXNcbiIsIHRlc3QsIHdoYXQpOworCiB9CiAKICNk
ZWZpbmUgZmF0YWxfZXJyb3IobmFtZSwgd2hhdCkJX19mYXRhbF9lcnJvcihfX2Z1bmNfXywg
bmFtZSwgd2hhdCkKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08v
dmRzb190ZXN0X2dldHJhbmRvbS5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92
ZHNvX3Rlc3RfZ2V0cmFuZG9tLmMKaW5kZXggNzJhMWQ5YjQzYTg0Li5lNWU4M2RiZWM1ODkg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0X2dl
dHJhbmRvbS5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vdmRzb190ZXN0
X2dldHJhbmRvbS5jCkBAIC01OSwxMCArNTksMTIgQEAgc3RhdGljIHZvaWQgKnZnZXRyYW5k
b21fZ2V0X3N0YXRlKHZvaWQpCiAJCXNpemVfdCBwYWdlX3NpemUgPSBnZXRwYWdlc2l6ZSgp
OwogCQlzaXplX3QgbmV3X2NhcDsKIAkJc2l6ZV90IGFsbG9jX3NpemUsIG51bSA9IHN5c2Nv
bmYoX1NDX05QUk9DRVNTT1JTX09OTE4pOyAvKiBKdXN0IGEgZGVjZW50IGhldXJpc3RpYy4g
Ki8KKwkJc2l6ZV90IHN0YXRlX3NpemVfYWxpZ25lZCwgY2FjaGVfbGluZV9zaXplID0gc3lz
Y29uZihfU0NfTEVWRUwxX0RDQUNIRV9MSU5FU0laRSkgPzogMTsKIAkJdm9pZCAqbmV3X2Js
b2NrLCAqbmV3X3N0YXRlczsKIAotCQlhbGxvY19zaXplID0gKG51bSAqIHZncm5kLnBhcmFt
cy5zaXplX29mX29wYXF1ZV9zdGF0ZSArIHBhZ2Vfc2l6ZSAtIDEpICYgKH4ocGFnZV9zaXpl
IC0gMSkpOwotCQludW0gPSAocGFnZV9zaXplIC8gdmdybmQucGFyYW1zLnNpemVfb2Zfb3Bh
cXVlX3N0YXRlKSAqIChhbGxvY19zaXplIC8gcGFnZV9zaXplKTsKKwkJc3RhdGVfc2l6ZV9h
bGlnbmVkID0gKHZncm5kLnBhcmFtcy5zaXplX29mX29wYXF1ZV9zdGF0ZSArIGNhY2hlX2xp
bmVfc2l6ZSAtIDEpICYgKH4oY2FjaGVfbGluZV9zaXplIC0gMSkpOworCQlhbGxvY19zaXpl
ID0gKG51bSAqIHN0YXRlX3NpemVfYWxpZ25lZCArIHBhZ2Vfc2l6ZSAtIDEpICYgKH4ocGFn
ZV9zaXplIC0gMSkpOworCQludW0gPSAocGFnZV9zaXplIC8gc3RhdGVfc2l6ZV9hbGlnbmVk
KSAqIChhbGxvY19zaXplIC8gcGFnZV9zaXplKTsKIAkJbmV3X2Jsb2NrID0gbW1hcCgwLCBh
bGxvY19zaXplLCB2Z3JuZC5wYXJhbXMubW1hcF9wcm90LCB2Z3JuZC5wYXJhbXMubW1hcF9m
bGFncywgLTEsIDApOwogCQlpZiAobmV3X2Jsb2NrID09IE1BUF9GQUlMRUQpCiAJCQlnb3Rv
IG91dDsKQEAgLTc4LDcgKzgwLDcgQEAgc3RhdGljIHZvaWQgKnZnZXRyYW5kb21fZ2V0X3N0
YXRlKHZvaWQpCiAJCQlpZiAoKCh1aW50cHRyX3QpbmV3X2Jsb2NrICYgKHBhZ2Vfc2l6ZSAt
IDEpKSArIHZncm5kLnBhcmFtcy5zaXplX29mX29wYXF1ZV9zdGF0ZSA+IHBhZ2Vfc2l6ZSkK
IAkJCQluZXdfYmxvY2sgPSAodm9pZCAqKSgoKHVpbnRwdHJfdCluZXdfYmxvY2sgKyBwYWdl
X3NpemUgLSAxKSAmICh+KHBhZ2Vfc2l6ZSAtIDEpKSk7CiAJCQl2Z3JuZC5zdGF0ZXNbaV0g
PSBuZXdfYmxvY2s7Ci0JCQluZXdfYmxvY2sgKz0gdmdybmQucGFyYW1zLnNpemVfb2Zfb3Bh
cXVlX3N0YXRlOworCQkJbmV3X2Jsb2NrICs9IHN0YXRlX3NpemVfYWxpZ25lZDsKIAkJfQog
CQl2Z3JuZC5sZW4gPSBudW07CiAJCWdvdG8gc3VjY2VzczsK

--------------JAiHeT6I3XGhUdM916rbj7VZ--


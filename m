Return-Path: <linux-kselftest+bounces-48079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83556CEF12A
	for <lists+linux-kselftest@lfdr.de>; Fri, 02 Jan 2026 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C93F53001196
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jan 2026 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C932EBBB0;
	Fri,  2 Jan 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpSyP9x9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF542E282B
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Jan 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767375337; cv=none; b=f/wrcVfBNHhwZ2Hi4nE+HyY4A/ZiF+24syEEmjCsZiokgxIlU/CKWrA3o47fxBJr8hGl8BQ/SVpUCaEtzU5jx/CO71He6H5qdN4KTN3SPoTLMvvxObGOl5ZQ6C8nhnQhKmtYxAvXqgslfVaJ6yx+GIPKOca8IMfYIgbHCnh4Q9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767375337; c=relaxed/simple;
	bh=q4aktyMssiBwKUXmDSu9jKhxKX63UngFygnSvUPXdMs=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=HUklYxoEWnO0/3SVrik7e8GlUXsUlMUvsO2oqGA/h3ih/iQ1gMw1WRSGRMpDFgRnkz+lqgpvCel6VdVxgMz7pQqYKafb0kX2bT9UjyhRJsu+FuM+VfCxWaZL2wi4EJ4uwjQsYfvSG9VCITGzfdeguv5IJbiaCd1S8k0DQO7lum0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpSyP9x9; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88fe44cce7eso64354456d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 09:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767375333; x=1767980133; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nTnOjlrtubTuKx+7EKBDgdBxaF8pW9FEcmd37x8rvx4=;
        b=UpSyP9x9YzNnEBvcLFSlN1AIkc0rSGNokwio2TXD3VNtpQI7S3KO6AgszKFb4l4WKu
         0MNvx7Kn1hK2qVJVGC5FXhOfFMKXnbUf0QvIpo52879B16ny0Ysm2/CdA/adJj3/cXDP
         ITYRH2WW+ObDt/HVW9aTxSdseozWu4Apw7KBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767375333; x=1767980133;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTnOjlrtubTuKx+7EKBDgdBxaF8pW9FEcmd37x8rvx4=;
        b=SYx4wkKhSkG8BRQB6pr3vTJf5mqmyPxaA5EH9z4cN2q4v89M4a6IEk+ac66k+8flnz
         SZtPMg85KEg8PkF63jN/cUyh16J+KeqDlsOTKE6AzkZGXLuGTqe+zqDcObWqPYUWIuDY
         lTg/HXdzGApA3u8PG9lXHcWTh+KaXNS4qBgBXraagCGgIyMcTw5j3OIceiphkPvZYEWY
         VPgVpPPHIkyHLuEZ0vdlQdwy3Ixnt3cqbexqelLqxp1gsJ+0lpZJxlFCFGWWUseK520c
         PNeZgZfUgg6UAnI9gL11+VbmdBZ/bTjc2JhRqil2kBeJiZUBtWite8wJOtSsyFhp585R
         MOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOrOpdSLA8fn93jcH8HBFGZQJrvBFpCrYYGAmNbc4ZnrCk7eZ4hf5hSXEcLOuqqV2Z9T8XqasJhYKKTVnxO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkALW/2hu3S61wpH0JsDP55qqaNFhlOt7CzHsHwCdorTn8y0J1
	tAW2lxXsJ46NQTtRit0wFjSW4IMddzxj8/qQkh/kUiYFro0Z1gsPu1t3Fdw3haMNfwk=
X-Gm-Gg: AY/fxX6wqF+/b+9VcosvAh6d85BWluChifqv+CJ3XtSi97uLXWKeojyeWmTigGNg0L0
	bCcSemBs8cHnZUsDZb8m2K7zPRMwIeWgX0PJ/q/ipUUdG4yI5dzRGGa0BbiCP8utWq8/RH7h8ZA
	pp3Mf1+qlmBb7XlO8PhwhAvCNQv/AY4m5Y2zdyitvtO2iRXzjab35qvnx191wgNpPqGfhgex157
	LRBuKQkeBGggpfgKM6YJUK7lC8fmgDPXgscGJX8m34pE8rcJCWYPmMKfDlM/KjGmEn03Vkj1+Q4
	Vi2SBHO/8PX8v1p+PpSBqfhWuxkNIwM6xnLFLsXtHibZnEZ36qu7nyrDo/J3bAl4EDm1wIQ7Zm6
	SmPcF19i3eAZ9QYJlCSlWqmg7E9UWtJ/HqR85we5GTnyCynKd5Pccwibl4RW4mvMwlsSHuKh8J/
	5WR+o7C2s6G6u26QTSWjChLS4ugOCiBXwajYwELPxtQWid17Sx1Qtf1kbJWtrQQz5znaXSI0CGB
	+Zl2h/HaR/gJI3SZLeKRKM1Q527XY6NCg==
X-Google-Smtp-Source: AGHT+IGbmscp8Ioyt7Bxsb+ayrc/4uKwQGZnsZBU//BjVR/3g8G6GvY+VHGcG2FgaWQ+1omu2URCzg==
X-Received: by 2002:a05:6214:2482:b0:88f:da24:37c4 with SMTP id 6a1803df08f44-88fda2438d5mr471545696d6.71.1767375332805;
        Fri, 02 Jan 2026 09:35:32 -0800 (PST)
Received: from [192.168.1.239] (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com. [207.181.222.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623feb0sm310181436d6.2.2026.01.02.09.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 09:35:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------RmXRq9DXiHGK00hLZy8ytzgQ"
Message-ID: <592f1743-ef62-4bfd-b91c-cb5e48201184@linuxfoundation.org>
Date: Fri, 2 Jan 2026 10:35:31 -0700
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
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] kselftest fixes update for Linux 6.19-rc4

This is a multi-part message in MIME format.
--------------RmXRq9DXiHGK00hLZy8ytzgQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the kselftest fixes update for Linux 6.19-rc4.

linux_kselftest-fixes-6.19-rc4

-- Fix for build failures in tests that use an empty FIXTURE() seen in
    Android's build environment, which uses -D_FORTIFY_SOURCE=3), a build
    failure occurs in tests that use an empty FIXTURE().

-- Fix func_traceonoff_triggers.tc sometimes failures on Kunpeng-920 board
    resulting from including transient trace file name in checksum compare.

-- Fix to remove available_events requirement from toplevel-enable for
    instance as it isn't a valid requirement for this test.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.19-rc4

for you to fetch changes up to 19b8a76cd99bde6d299e60490f3e62b8d3df3997:

   kselftest/harness: Use helper to avoid zero-size memset warning (2025-12-31 13:27:36 -0700)

----------------------------------------------------------------
linux_kselftest-fixes-6.19-rc4

-- Fix for build failures in tests that use an empty FIXTURE() seen in
    Android's build environment, which uses -D_FORTIFY_SOURCE=3), a build
    failure occurs in tests that use an empty FIXTURE().

-- Fix func_traceonoff_triggers.tc sometimes failures on Kunpeng-920 board
    resulting from including transient trace file name in checksum compare.

-- Fix to remove available_events requirement from toplevel-enable for
    instance as it isn't a valid requirement for this test.

----------------------------------------------------------------
Wake Liu (1):
       kselftest/harness: Use helper to avoid zero-size memset warning

Yipeng Zou (1):
       selftests/ftrace: traceonoff_triggers: strip off names

Zheng Yejian (1):
       selftests/ftrace: Test toplevel-enable for instance

  tools/testing/selftests/ftrace/test.d/event/toplevel-enable.tc    | 3 ++-
  .../selftests/ftrace/test.d/ftrace/func_traceonoff_triggers.tc    | 5 +++--
  tools/testing/selftests/kselftest_harness.h                       | 8 +++++++-
  3 files changed, 12 insertions(+), 4 deletions(-)
----------------------------------------------------------------
--------------RmXRq9DXiHGK00hLZy8ytzgQ
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.19-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-fixes-6.19-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZXZl
bnQvdG9wbGV2ZWwtZW5hYmxlLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L3Rlc3QuZC9ldmVudC90b3BsZXZlbC1lbmFibGUudGMKaW5kZXggOTNjMTBlYTQyYTY4Li44
YjhlMWFlYTk4NWIgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFj
ZS90ZXN0LmQvZXZlbnQvdG9wbGV2ZWwtZW5hYmxlLnRjCisrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZXZlbnQvdG9wbGV2ZWwtZW5hYmxlLnRjCkBAIC0x
LDcgKzEsOCBAQAogIyEvYmluL3NoCiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wCiAjIGRlc2NyaXB0aW9uOiBldmVudCB0cmFjaW5nIC0gZW5hYmxlL2Rpc2FibGUgd2l0
aCB0b3AgbGV2ZWwgZmlsZXMKLSMgcmVxdWlyZXM6IGF2YWlsYWJsZV9ldmVudHMgc2V0X2V2
ZW50IGV2ZW50cy9lbmFibGUKKyMgcmVxdWlyZXM6IHNldF9ldmVudCBldmVudHMvZW5hYmxl
CisjIGZsYWdzOiBpbnN0YW5jZQogCiBkb19yZXNldCgpIHsKICAgICBlY2hvID4gc2V0X2V2
ZW50CmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5k
L2Z0cmFjZS9mdW5jX3RyYWNlb25vZmZfdHJpZ2dlcnMudGMgYi90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2Z0cmFjZS9mdW5jX3RyYWNlb25vZmZfdHJpZ2dlcnMu
dGMKaW5kZXggYWVlMjIyODk1MzZiLi4xYjU3NzcxZGJmZGYgMTAwNjQ0Ci0tLSBhL3Rvb2xz
L3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnRyYWNlL2Z1bmNfdHJhY2Vvbm9m
Zl90cmlnZ2Vycy50YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVz
dC5kL2Z0cmFjZS9mdW5jX3RyYWNlb25vZmZfdHJpZ2dlcnMudGMKQEAgLTkwLDkgKzkwLDEw
IEBAIGlmIFsgJG9uICE9ICIwIiBdOyB0aGVuCiAgICAgZmFpbCAiVHJhY2luZyBpcyBub3Qg
b2ZmIgogZmkKIAotY3N1bTE9YG1kNXN1bSB0cmFjZWAKKyMgQ2Fubm90IHJlbHkgb24gbmFt
ZXMgYmVpbmcgYXJvdW5kIGFzIHRoZXkgYXJlIG9ubHkgY2FjaGVkLCBzdHJpcCB0aGVtCitj
c3VtMT1gY2F0IHRyYWNlIHwgc2VkIC1lICdzL14gKlteIF0qXCgtWzAtOV1bMC05XSpcKS9c
MS8nIHwgbWQ1c3VtYAogc2xlZXAgJFNMRUVQX1RJTUUKLWNzdW0yPWBtZDVzdW0gdHJhY2Vg
Citjc3VtMj1gY2F0IHRyYWNlIHwgc2VkIC1lICdzL14gKlteIF0qXCgtWzAtOV1bMC05XSpc
KS9cMS8nIHwgbWQ1c3VtYAogCiBpZiBbICIkY3N1bTEiICE9ICIkY3N1bTIiIF07IHRoZW4K
ICAgICBmYWlsICJUcmFjaW5nIGZpbGUgaXMgc3RpbGwgY2hhbmdpbmciCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3RfaGFybmVzcy5oIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0X2hhcm5lc3MuaAppbmRleCBiYWFlNmI3ZGVk
NDEuLjE2YTExOWE0NjU2YyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
a3NlbGZ0ZXN0X2hhcm5lc3MuaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2Vs
ZnRlc3RfaGFybmVzcy5oCkBAIC03MCw2ICs3MCwxMiBAQAogCiAjaW5jbHVkZSAia3NlbGZ0
ZXN0LmgiCiAKK3N0YXRpYyBpbmxpbmUgdm9pZCBfX2tzZWxmdGVzdF9tZW1zZXRfc2FmZSh2
b2lkICpzLCBpbnQgYywgc2l6ZV90IG4pCit7CisJaWYgKG4gPiAwKQorCQltZW1zZXQocywg
Yywgbik7Cit9CisKICNkZWZpbmUgVEVTVF9USU1FT1VUX0RFRkFVTFQgMzAKIAogLyogVXRp
bGl0aWVzIGV4cG9zZWQgdG8gdGhlIHRlc3QgZGVmaW5pdGlvbnMgKi8KQEAgLTQxNiw3ICs0
MjIsNyBAQAogCQkJCXNlbGYgPSBtbWFwKE5VTEwsIHNpemVvZigqc2VsZiksIFBST1RfUkVB
RCB8IFBST1RfV1JJVEUsIFwKIAkJCQkJTUFQX1NIQVJFRCB8IE1BUF9BTk9OWU1PVVMsIC0x
LCAwKTsgXAogCQkJfSBlbHNlIHsgXAotCQkJCW1lbXNldCgmc2VsZl9wcml2YXRlLCAwLCBz
aXplb2Yoc2VsZl9wcml2YXRlKSk7IFwKKwkJCQlfX2tzZWxmdGVzdF9tZW1zZXRfc2FmZSgm
c2VsZl9wcml2YXRlLCAwLCBzaXplb2Yoc2VsZl9wcml2YXRlKSk7IFwKIAkJCQlzZWxmID0g
JnNlbGZfcHJpdmF0ZTsgXAogCQkJfSBcCiAJCX0gXAo=

--------------RmXRq9DXiHGK00hLZy8ytzgQ--


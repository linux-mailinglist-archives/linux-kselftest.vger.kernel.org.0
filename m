Return-Path: <linux-kselftest+bounces-8002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227D8A57A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB1D6B23449
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3027F7D3;
	Mon, 15 Apr 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vzpt0IrT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27F29414
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198196; cv=none; b=LZOODXyw0zoiu9w835G45zBrt/mlEafnR1MM3VXa/dE5jOybHuQOZsfJprp08EEoJad6iXEBOopkSKIrIMezu1UOEb16xC+bxMk4tanI/pH0G5BgxoMVoYqhhDc0kbLVl9DH4BwDmQumOrTWE4Be0YwjCwRqQr36jdrwcq4ziJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198196; c=relaxed/simple;
	bh=IztYwKZ/VaVkKmnd9d5+3jv+XxvhkFJkenC+M8BvwQU=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=X6EVpxqrAHMEwMGi9RJ7n64ZP3VV3PmEOUi/e6fHHUkxXAh/SpE4ToAY2HfA3cWM39Z9CZFE5Vp8PGlNtnulEFmC0DeGd8QqJQHLEPCfcEP5iICjGB9ri4BI6naZvTm2kSZ/uGQubDO+8jpdbpdnB79IXuZuMdKJT2eiRngLUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vzpt0IrT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5f760eebd79so70125a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713198194; x=1713802994; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Z51JDqeCMIYAogMv4e7mjxOubQ/EaWsQPKXTj8RQ4=;
        b=Vzpt0IrT4UmI/8l2V4DdwEdp8olYOeS0Ax+R9NARoHlKti3i30gfSyDvqaZbDySlj4
         I2J52A41IUNsNq8PT4HZzyX4XI1iQEvIDX+XclN/NipNIbS/btZnTbTj6nTSc5u8d8V2
         efrCFrdGCiDK2H7s1/1sTtESSZUxLyWdn/kdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198194; x=1713802994;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/Z51JDqeCMIYAogMv4e7mjxOubQ/EaWsQPKXTj8RQ4=;
        b=INjdeclJRdCdSAoYwyNLJLOKlYCXuErFnxjjfCH7F08+RSgKAcfoHu6yqTswPSRtjZ
         SoRfP0WxZ8OYg0kctKbGrOSCTduFpWxBQUdOeYGWfv2JW+JUgTPKRdnjNsaE36/fZsPw
         04UWLlP2RCfeQlODb0MrB5jzaEVa8DjtlvUPBNlLTGQK99RLDH0tzMaK3sw+cyCDmuqm
         L510FlOs+L6HrlVl2V4J4XVkR4CmqpxBLPZT2H+aaQ8m08OcTzEAucwwNcmKoF7+jaz1
         V0P0K29I5MV0izTzkIQsGD/vXyEhd/hP3smtJetuvAvNaOh85UEmJ8omnOqN3TJ58ya4
         N0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYd0YQNYzKwSOtVDMdKGWsmTnVQaAOntougtTzP4RpS1C82Bq59efAI1s11azg14tePvI9hchrZijcain8x6HvHLXK4fBsIJqAsX9sqZC6
X-Gm-Message-State: AOJu0Yx9g7xYwLaM74B4HUw5IcVYY66d5ZQhyX4BTA5XV/ZL+GUKtP6S
	RKhBD/WHgVZ+liIyJUPtV31MHWvTYL9EwRtAYzuEBtVXgcnSX64R8Mih26edsRQ=
X-Google-Smtp-Source: AGHT+IGGW7en+6bXWtgxTwQRzlAn+FGmigqcoxLVLENAYPJ4AFSUjBaYrm1Wyp93UhbyFXXF7OuKDg==
X-Received: by 2002:a17:902:da8c:b0:1e2:c544:9bb0 with SMTP id j12-20020a170902da8c00b001e2c5449bb0mr12201217plx.0.1713198193865;
        Mon, 15 Apr 2024 09:23:13 -0700 (PDT)
Received: from [172.20.9.236] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902650b00b001e509d4d6ddsm8293062plk.1.2024.04.15.09.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:23:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------9zKQTgrVK4VJRn8QITeFZYlg"
Message-ID: <c03e09c7-e9a5-4e64-b146-40c14c68bfd5@linuxfoundation.org>
Date: Mon, 15 Apr 2024 10:23:12 -0600
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
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.9-rc5

This is a multi-part message in MIME format.
--------------9zKQTgrVK4VJRn8QITeFZYlg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.9-rc5.

This kselftest fixes update for Linux 6.9-rc5 consists of a fix to
kselftest harness to prevent infinite loop triggered in an assert
in FIXTURE_TEARDOWN and a fix to a problem seen in being able to stop
subsystem-enable tests when sched events are being traced.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit 224fe424c356cb5c8f451eca4127f32099a6f764:

   selftests: dmabuf-heap: add config file for the test (2024-03-29 13:57:14 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc5

for you to fetch changes up to 72d7cb5c190befbb095bae7737e71560ec0fcaa6:

   selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN (2024-04-04 10:50:53 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.9-rc5

This kselftest fixes update for Linux 6.9-rc5 consists of a fix to
kselftest harness to prevent infinite loop triggered in an assert
in FIXTURE_TEARDOWN and a fix to a problem seen in being able to stop
subsystem-enable tests when sched events are being traced.

----------------------------------------------------------------
Shengyu Li (1):
       selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN

Yuanhe Shu (1):
       selftests/ftrace: Limit length in subsystem-enable tests

  tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc | 6 +++---
  tools/testing/selftests/kselftest_harness.h                     | 5 ++++-
  2 files changed, 7 insertions(+), 4 deletions(-)

----------------------------------------------------------------



--------------9zKQTgrVK4VJRn8QITeFZYlg
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.9-rc5.diff"
Content-Disposition: attachment; filename="linux_kselftest-fixes-6.9-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZXZl
bnQvc3Vic3lzdGVtLWVuYWJsZS50YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFj
ZS90ZXN0LmQvZXZlbnQvc3Vic3lzdGVtLWVuYWJsZS50YwppbmRleCBiMWVkZTYyNDk4NjYu
LmI3YzhmMjljMDlhOSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRy
YWNlL3Rlc3QuZC9ldmVudC9zdWJzeXN0ZW0tZW5hYmxlLnRjCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZXZlbnQvc3Vic3lzdGVtLWVuYWJsZS50YwpA
QCAtMTgsNyArMTgsNyBAQCBlY2hvICdzY2hlZDoqJyA+IHNldF9ldmVudAogCiB5aWVsZAog
Ci1jb3VudD1gY2F0IHRyYWNlIHwgZ3JlcCAtdiBeIyB8IGF3ayAneyBwcmludCAkNSB9JyB8
IHNvcnQgLXUgfCB3YyAtbGAKK2NvdW50PWBoZWFkIC1uIDEwMCB0cmFjZSB8IGdyZXAgLXYg
XiMgfCBhd2sgJ3sgcHJpbnQgJDUgfScgfCBzb3J0IC11IHwgd2MgLWxgCiBpZiBbICRjb3Vu
dCAtbHQgMyBdOyB0aGVuCiAgICAgZmFpbCAiYXQgbGVhc3QgZm9yaywgZXhlYyBhbmQgZXhp
dCBldmVudHMgc2hvdWxkIGJlIHJlY29yZGVkIgogZmkKQEAgLTI5LDcgKzI5LDcgQEAgZWNo
byAxID4gZXZlbnRzL3NjaGVkL2VuYWJsZQogCiB5aWVsZAogCi1jb3VudD1gY2F0IHRyYWNl
IHwgZ3JlcCAtdiBeIyB8IGF3ayAneyBwcmludCAkNSB9JyB8IHNvcnQgLXUgfCB3YyAtbGAK
K2NvdW50PWBoZWFkIC1uIDEwMCB0cmFjZSB8IGdyZXAgLXYgXiMgfCBhd2sgJ3sgcHJpbnQg
JDUgfScgfCBzb3J0IC11IHwgd2MgLWxgCiBpZiBbICRjb3VudCAtbHQgMyBdOyB0aGVuCiAg
ICAgZmFpbCAiYXQgbGVhc3QgZm9yaywgZXhlYyBhbmQgZXhpdCBldmVudHMgc2hvdWxkIGJl
IHJlY29yZGVkIgogZmkKQEAgLTQwLDcgKzQwLDcgQEAgZWNobyAwID4gZXZlbnRzL3NjaGVk
L2VuYWJsZQogCiB5aWVsZAogCi1jb3VudD1gY2F0IHRyYWNlIHwgZ3JlcCAtdiBeIyB8IGF3
ayAneyBwcmludCAkNSB9JyB8IHNvcnQgLXUgfCB3YyAtbGAKK2NvdW50PWBoZWFkIC1uIDEw
MCB0cmFjZSB8IGdyZXAgLXYgXiMgfCBhd2sgJ3sgcHJpbnQgJDUgfScgfCBzb3J0IC11IHwg
d2MgLWxgCiBpZiBbICRjb3VudCAtbmUgMCBdOyB0aGVuCiAgICAgZmFpbCAiYW55IG9mIHNj
aGVkdWxlciBldmVudHMgc2hvdWxkIG5vdCBiZSByZWNvcmRlZCIKIGZpCmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2VsZnRlc3RfaGFybmVzcy5oIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMva3NlbGZ0ZXN0X2hhcm5lc3MuaAppbmRleCA0ZmQ3MzVlNDhl
ZTcuLjIzMGQ2Mjg4NDg4NSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
a3NlbGZ0ZXN0X2hhcm5lc3MuaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9rc2Vs
ZnRlc3RfaGFybmVzcy5oCkBAIC0zODMsNiArMzgzLDcgQEAKIAkJRklYVFVSRV9EQVRBKGZp
eHR1cmVfbmFtZSkgc2VsZjsgXAogCQlwaWRfdCBjaGlsZCA9IDE7IFwKIAkJaW50IHN0YXR1
cyA9IDA7IFwKKwkJYm9vbCBqbXAgPSBmYWxzZTsgXAogCQltZW1zZXQoJnNlbGYsIDAsIHNp
emVvZihGSVhUVVJFX0RBVEEoZml4dHVyZV9uYW1lKSkpOyBcCiAJCWlmIChzZXRqbXAoX21l
dGFkYXRhLT5lbnYpID09IDApIHsgXAogCQkJLyogVXNlIHRoZSBzYW1lIF9tZXRhZGF0YS4g
Ki8gXApAQCAtMzk5LDggKzQwMCwxMCBAQAogCQkJCV9tZXRhZGF0YS0+ZXhpdF9jb2RlID0g
S1NGVF9GQUlMOyBcCiAJCQl9IFwKIAkJfSBcCisJCWVsc2UgXAorCQkJam1wID0gdHJ1ZTsg
XAogCQlpZiAoY2hpbGQgPT0gMCkgeyBcCi0JCQlpZiAoX21ldGFkYXRhLT5zZXR1cF9jb21w
bGV0ZWQgJiYgIV9tZXRhZGF0YS0+dGVhcmRvd25fcGFyZW50KSBcCisJCQlpZiAoX21ldGFk
YXRhLT5zZXR1cF9jb21wbGV0ZWQgJiYgIV9tZXRhZGF0YS0+dGVhcmRvd25fcGFyZW50ICYm
ICFqbXApIFwKIAkJCQlmaXh0dXJlX25hbWUjI190ZWFyZG93bihfbWV0YWRhdGEsICZzZWxm
LCB2YXJpYW50LT5kYXRhKTsgXAogCQkJX2V4aXQoMCk7IFwKIAkJfSBcCg==

--------------9zKQTgrVK4VJRn8QITeFZYlg--


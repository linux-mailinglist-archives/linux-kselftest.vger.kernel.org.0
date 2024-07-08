Return-Path: <linux-kselftest+bounces-13339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174992AC34
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 00:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4897D28319D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 22:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432CB1514CC;
	Mon,  8 Jul 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wb+6dTgb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B514F9EB
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478538; cv=none; b=uv4bFF0oqKcx1mvEa9OiigXz+3fsrJ0w9qUrlbyp82S7p38dbKpRpigPx4JJjpxHsl773QgVdRN869Y2YJZSKrm+CF6x2LUYh1/jVDi+0FMFax1tEV6PKmrh/NVUeCjMvFoPnpbpgrxSDRfzqjt/SbxR6jWz2dQ2a6fuK1DvPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478538; c=relaxed/simple;
	bh=/Csvsngo9An8lKU/uqQ4PwREsIrRpApsjXkFtThY7r8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=RCQpfbtwwaXPmMtXkmir+ha0TnLdmij/ch1SuBWYW6cEyhJ+X8lFxAagFBoeIr2adKNqQczy3kuFMr0v/YmnlrO6mb1a7LDww/X+H3C0kgrgfg5Iq9nw54qShPaHBv5ssCCYruWLzS89wqzyM5R1Z9PFUeb2xg1uZrtuXISUvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wb+6dTgb; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f906800b4cso6712139f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2024 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720478535; x=1721083335; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zovC7QVd34p3m3CAUQtKD0SY4AbJLTNsaDdpwwBJTts=;
        b=Wb+6dTgbdGvPtSRwmyyhj0vR1ykqLi7imYM2vRbuYaVP+b6N2D/h1/1kXOfhKh42AB
         mCxjAfU/1V3lyD1E8aksj8eLveOcdx9UeTGMdJhaxpKDkosp36IQgSbO9vkz8/ZEbQKK
         jrPWF234xMwNe2rTAtpNpkl90qLU8NrOTkSVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720478535; x=1721083335;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zovC7QVd34p3m3CAUQtKD0SY4AbJLTNsaDdpwwBJTts=;
        b=vizNBo/0W9+q7/PshijL4XSkhg2UT3BOvFRsHV94Vy050P4nyEY1HthhFt4HHcxo9U
         6tT8t8vaxYYymNNoLdrpu5Cw3v5hvuAr7daUOvgDyQzzveHPWAEJBEdsV8sUJKT50fxS
         YvLr32Wx7craeeUwZj5F8OG5ZXnfZZqYVxwnJ2AfSDedca2NtKQQm/o4y6JMXeXJKSiX
         RkG4TUIRZT0i9g9rGn9BfIiO0HulxkekZ0uyMPKrwywU/NMs4OwgZnny3j8P+nnZOUND
         YE3+cL8hUyM3q/ZPgkA89Gl3HXxiK91rcFqYbWKxeIEt3SL0GiOnKu9Hpu2uQm45+khp
         /jqA==
X-Forwarded-Encrypted: i=1; AJvYcCWwuZ43VGTuHhedsuY4FT//w6fgS/Quhyt/zXIY0ifFL+eqiTYie3xv3FEFsb6iRjb3U7lLVTinrihig1lg2SCYFx9uI+pYJOqk09x4APFj
X-Gm-Message-State: AOJu0YyDK9tYRFsmAXAiJ1FDc0GUqHKM8XGS1ijJyzPqn61yohCkFI61
	Y/haCX3f7/V34QPjxrw4NZxKLnVB0FcSbQ3txOQwoS+u0r/vdOucc/BUojWXFAU=
X-Google-Smtp-Source: AGHT+IHTLYyh+Jcy22XXxAXWdWcQhiGYB2223bdTg2DFGSeQOJUGmgTMYU8u4DP+IJaVFlGDvso5HA==
X-Received: by 2002:a05:6602:6199:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-80001930275mr119437339f.1.1720478534710;
        Mon, 08 Jul 2024 15:42:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf65f0sm182528173.93.2024.07.08.15.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 15:42:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------zvEHuaPS38NLDGr1NkzGpYeN"
Message-ID: <7007e67e-0af4-4b01-a708-ba108208b217@linuxfoundation.org>
Date: Mon, 8 Jul 2024 16:42:13 -0600
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
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 6.10

This is a multi-part message in MIME format.
--------------zvEHuaPS38NLDGr1NkzGpYeN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this kselftest fixes update for Linux 6.10.

This kselftest fixes update for Linux 6.10 consists of fixes to clang
build failures to timerns, vDSO tests and fixes to vDSO makefile.

Note: makefile fixes are included to avoid conflicts during 6.11 merge
window.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 48236960c06d32370bfa6f2cc408e786873262c8:

   selftests/resctrl: Fix non-contiguous CBM for AMD (2024-06-26 13:22:34 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.10

for you to fetch changes up to 66cde337fa1b7c6cf31f856fa015bd91a4d383e7:

   selftests/vDSO: remove duplicate compiler invocations from Makefile (2024-07-05 14:12:34 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.10

This kselftest fixes update for Linux 6.10 consists of fixes to clang
build failures to timerns, vDSO tests and fixes to vDSO makefile.

----------------------------------------------------------------
John Hubbard (4):
       selftest/timerns: fix clang build failures for abs() calls
       selftests/vDSO: fix clang build errors and warnings
       selftests/vDSO: remove partially duplicated "all:" target in Makefile
       selftests/vDSO: remove duplicate compiler invocations from Makefile

  tools/testing/selftests/timens/exec.c              |  6 ++---
  tools/testing/selftests/timens/timer.c             |  2 +-
  tools/testing/selftests/timens/timerfd.c           |  2 +-
  tools/testing/selftests/timens/vfork_exec.c        |  4 +--
  tools/testing/selftests/vDSO/Makefile              | 29 +++++++++-------------
  tools/testing/selftests/vDSO/parse_vdso.c          | 16 ++++++++----
  .../selftests/vDSO/vdso_standalone_test_x86.c      | 18 ++++++++++++--
  7 files changed, 46 insertions(+), 31 deletions(-)
----------------------------------------------------------------
--------------zvEHuaPS38NLDGr1NkzGpYeN
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.10.diff"
Content-Disposition: attachment; filename="linux_kselftest-fixes-6.10.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy9leGVjLmMgYi90
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lbnMvZXhlYy5jCmluZGV4IGU0MGRjNWJlMmY2
Ni4uZDEyZmY5NTVkZTBkIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90
aW1lbnMvZXhlYy5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy9leGVj
LmMKQEAgLTMwLDcgKzMwLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkK
IAogCQlmb3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7CiAJCQlfZ2V0dGltZShDTE9DS19NT05P
VE9OSUMsICZ0c3QsIGkpOwotCQkJaWYgKGFicyh0c3QudHZfc2VjIC0gbm93LnR2X3NlYykg
PiA1KQorCQkJaWYgKGxhYnModHN0LnR2X3NlYyAtIG5vdy50dl9zZWMpID4gNSkKIAkJCQly
ZXR1cm4gcHJfZmFpbCgiJWxkICVsZFxuIiwgbm93LnR2X3NlYywgdHN0LnR2X3NlYyk7CiAJ
CX0KIAkJcmV0dXJuIDA7CkBAIC01MCw3ICs1MCw3IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICphcmd2W10pCiAKIAlmb3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7CiAJCV9nZXR0aW1l
KENMT0NLX01PTk9UT05JQywgJnRzdCwgaSk7Ci0JCWlmIChhYnModHN0LnR2X3NlYyAtIG5v
dy50dl9zZWMpID4gNSkKKwkJaWYgKGxhYnModHN0LnR2X3NlYyAtIG5vdy50dl9zZWMpID4g
NSkKIAkJCXJldHVybiBwcl9mYWlsKCIlbGQgJWxkXG4iLAogCQkJCQlub3cudHZfc2VjLCB0
c3QudHZfc2VjKTsKIAl9CkBAIC03MCw3ICs3MCw3IEBAIGludCBtYWluKGludCBhcmdjLCBj
aGFyICphcmd2W10pCiAJCS8qIENoZWNrIHRoYXQgYSBjaGlsZCBwcm9jZXNzIGlzIGluIHRo
ZSBuZXcgdGltZW5zLiAqLwogCQlmb3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7CiAJCQlfZ2V0
dGltZShDTE9DS19NT05PVE9OSUMsICZ0c3QsIGkpOwotCQkJaWYgKGFicyh0c3QudHZfc2Vj
IC0gbm93LnR2X3NlYyAtIE9GRlNFVCkgPiA1KQorCQkJaWYgKGxhYnModHN0LnR2X3NlYyAt
IG5vdy50dl9zZWMgLSBPRkZTRVQpID4gNSkKIAkJCQlyZXR1cm4gcHJfZmFpbCgiJWxkICVs
ZFxuIiwKIAkJCQkJCW5vdy50dl9zZWMgKyBPRkZTRVQsIHRzdC50dl9zZWMpOwogCQl9CmRp
ZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lbnMvdGltZXIuYyBiL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy90aW1lci5jCmluZGV4IDVlN2YwMDUxYmQ3
Yi4uNWI5MzlmNTlkZmE0IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90
aW1lbnMvdGltZXIuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lbnMvdGlt
ZXIuYwpAQCAtNTYsNyArNTYsNyBAQCBpbnQgcnVuX3Rlc3QoaW50IGNsb2NraWQsIHN0cnVj
dCB0aW1lc3BlYyBub3cpCiAJCQlyZXR1cm4gcHJfcGVycm9yKCJ0aW1lcmZkX2dldHRpbWUi
KTsKIAogCQllbGFwc2VkID0gbmV3X3ZhbHVlLml0X3ZhbHVlLnR2X3NlYzsKLQkJaWYgKGFi
cyhlbGFwc2VkIC0gMzYwMCkgPiA2MCkgeworCQlpZiAobGxhYnMoZWxhcHNlZCAtIDM2MDAp
ID4gNjApIHsKIAkJCWtzZnRfdGVzdF9yZXN1bHRfZmFpbCgiY2xvY2tpZDogJWQgZWxhcHNl
ZDogJWxsZFxuIiwKIAkJCQkJICAgICAgY2xvY2tpZCwgZWxhcHNlZCk7CiAJCQlyZXR1cm4g
MTsKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy90aW1lcmZk
LmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy90aW1lbnMvdGltZXJmZC5jCmluZGV4IDll
ZGQ0M2Q2YjJjMS4uYTQxOTZiYmQ2ZTMzIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3Nl
bGZ0ZXN0cy90aW1lbnMvdGltZXJmZC5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L3RpbWVucy90aW1lcmZkLmMKQEAgLTYxLDcgKzYxLDcgQEAgaW50IHJ1bl90ZXN0KGludCBj
bG9ja2lkLCBzdHJ1Y3QgdGltZXNwZWMgbm93KQogCQkJcmV0dXJuIHByX3BlcnJvcigidGlt
ZXJmZF9nZXR0aW1lKCVkKSIsIGNsb2NraWQpOwogCiAJCWVsYXBzZWQgPSBuZXdfdmFsdWUu
aXRfdmFsdWUudHZfc2VjOwotCQlpZiAoYWJzKGVsYXBzZWQgLSAzNjAwKSA+IDYwKSB7CisJ
CWlmIChsbGFicyhlbGFwc2VkIC0gMzYwMCkgPiA2MCkgewogCQkJa3NmdF90ZXN0X3Jlc3Vs
dF9mYWlsKCJjbG9ja2lkOiAlZCBlbGFwc2VkOiAlbGxkXG4iLAogCQkJCQkgICAgICBjbG9j
a2lkLCBlbGFwc2VkKTsKIAkJCXJldHVybiAxOwpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdGltZW5zL3Zmb3JrX2V4ZWMuYyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL3RpbWVucy92Zm9ya19leGVjLmMKaW5kZXggYmViNzYxNDk0MWZiLi41Yjg5MDdiZjQ1
MWQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3RpbWVucy92Zm9ya19l
eGVjLmMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdGltZW5zL3Zmb3JrX2V4ZWMu
YwpAQCAtMzIsNyArMzIsNyBAQCBzdGF0aWMgdm9pZCAqdGNoZWNrKHZvaWQgKl9hcmdzKQog
CiAJZm9yIChpID0gMDsgaSA8IDI7IGkrKykgewogCQlfZ2V0dGltZShDTE9DS19NT05PVE9O
SUMsICZ0c3QsIGkpOwotCQlpZiAoYWJzKHRzdC50dl9zZWMgLSBub3ctPnR2X3NlYykgPiA1
KSB7CisJCWlmIChsYWJzKHRzdC50dl9zZWMgLSBub3ctPnR2X3NlYykgPiA1KSB7CiAJCQlw
cl9mYWlsKCIlczogaW4tdGhyZWFkOiB1bmV4cGVjdGVkIHZhbHVlOiAlbGQgKCVsZClcbiIs
CiAJCQkJYXJncy0+dHN0X25hbWUsIHRzdC50dl9zZWMsIG5vdy0+dHZfc2VjKTsKIAkJCXJl
dHVybiAodm9pZCAqKTFVTDsKQEAgLTY0LDcgKzY0LDcgQEAgc3RhdGljIGludCBjaGVjayhj
aGFyICp0c3RfbmFtZSwgc3RydWN0IHRpbWVzcGVjICpub3cpCiAKIAlmb3IgKGkgPSAwOyBp
IDwgMjsgaSsrKSB7CiAJCV9nZXR0aW1lKENMT0NLX01PTk9UT05JQywgJnRzdCwgaSk7Ci0J
CWlmIChhYnModHN0LnR2X3NlYyAtIG5vdy0+dHZfc2VjKSA+IDUpCisJCWlmIChsYWJzKHRz
dC50dl9zZWMgLSBub3ctPnR2X3NlYykgPiA1KQogCQkJcmV0dXJuIHByX2ZhaWwoIiVzOiB1
bmV4cGVjdGVkIHZhbHVlOiAlbGQgKCVsZClcbiIsCiAJCQkJCXRzdF9uYW1lLCB0c3QudHZf
c2VjLCBub3ctPnR2X3NlYyk7CiAJfQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdkRTTy9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vTWFr
ZWZpbGUKaW5kZXggZDUzYTRkODAwOGY5Li45OGQ4YmEyYWZhMDAgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vTWFrZWZpbGUKKysrIGIvdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvdkRTTy9NYWtlZmlsZQpAQCAtMSwzNSArMSwzMCBAQAogIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAotaW5jbHVkZSAuLi9saWIubWsKLQogdW5hbWVf
TSA6PSAkKHNoZWxsIHVuYW1lIC1tIDI+L2Rldi9udWxsIHx8IGVjaG8gbm90KQogQVJDSCA/
PSAkKHNoZWxsIGVjaG8gJCh1bmFtZV9NKSB8IHNlZCAtZSBzL2kuODYveDg2LyAtZSBzL3g4
Nl82NC94ODYvKQogCi1URVNUX0dFTl9QUk9HUyA6PSAkKE9VVFBVVCkvdmRzb190ZXN0X2dl
dHRpbWVvZmRheSAkKE9VVFBVVCkvdmRzb190ZXN0X2dldGNwdQotVEVTVF9HRU5fUFJPR1Mg
Kz0gJChPVVRQVVQpL3Zkc29fdGVzdF9hYmkKLVRFU1RfR0VOX1BST0dTICs9ICQoT1VUUFVU
KS92ZHNvX3Rlc3RfY2xvY2tfZ2V0cmVzCitURVNUX0dFTl9QUk9HUyA6PSB2ZHNvX3Rlc3Rf
Z2V0dGltZW9mZGF5CitURVNUX0dFTl9QUk9HUyArPSB2ZHNvX3Rlc3RfZ2V0Y3B1CitURVNU
X0dFTl9QUk9HUyArPSB2ZHNvX3Rlc3RfYWJpCitURVNUX0dFTl9QUk9HUyArPSB2ZHNvX3Rl
c3RfY2xvY2tfZ2V0cmVzCiBpZmVxICgkKEFSQ0gpLCQoZmlsdGVyICQoQVJDSCkseDg2IHg4
Nl82NCkpCi1URVNUX0dFTl9QUk9HUyArPSAkKE9VVFBVVCkvdmRzb19zdGFuZGFsb25lX3Rl
c3RfeDg2CitURVNUX0dFTl9QUk9HUyArPSB2ZHNvX3N0YW5kYWxvbmVfdGVzdF94ODYKIGVu
ZGlmCi1URVNUX0dFTl9QUk9HUyArPSAkKE9VVFBVVCkvdmRzb190ZXN0X2NvcnJlY3RuZXNz
CitURVNUX0dFTl9QUk9HUyArPSB2ZHNvX3Rlc3RfY29ycmVjdG5lc3MKIAogQ0ZMQUdTIDo9
IC1zdGQ9Z251OTkKLUNGTEFHU192ZHNvX3N0YW5kYWxvbmVfdGVzdF94ODYgOj0gLW5vc3Rk
bGliIC1mbm8tYXN5bmNocm9ub3VzLXVud2luZC10YWJsZXMgLWZuby1zdGFjay1wcm90ZWN0
b3IKLUxERkxBR1NfdmRzb190ZXN0X2NvcnJlY3RuZXNzIDo9IC1sZGwKKwogaWZlcSAoJChD
T05GSUdfWDg2XzMyKSx5KQogTERMSUJTICs9IC1sZ2NjX3MKIGVuZGlmCiAKLWFsbDogJChU
RVNUX0dFTl9QUk9HUykKK2luY2x1ZGUgLi4vbGliLm1rCiAkKE9VVFBVVCkvdmRzb190ZXN0
X2dldHRpbWVvZmRheTogcGFyc2VfdmRzby5jIHZkc29fdGVzdF9nZXR0aW1lb2ZkYXkuYwog
JChPVVRQVVQpL3Zkc29fdGVzdF9nZXRjcHU6IHBhcnNlX3Zkc28uYyB2ZHNvX3Rlc3RfZ2V0
Y3B1LmMKICQoT1VUUFVUKS92ZHNvX3Rlc3RfYWJpOiBwYXJzZV92ZHNvLmMgdmRzb190ZXN0
X2FiaS5jCiAkKE9VVFBVVCkvdmRzb190ZXN0X2Nsb2NrX2dldHJlczogdmRzb190ZXN0X2Ns
b2NrX2dldHJlcy5jCisKICQoT1VUUFVUKS92ZHNvX3N0YW5kYWxvbmVfdGVzdF94ODY6IHZk
c29fc3RhbmRhbG9uZV90ZXN0X3g4Ni5jIHBhcnNlX3Zkc28uYwotCSQoQ0MpICQoQ0ZMQUdT
KSAkKENGTEFHU192ZHNvX3N0YW5kYWxvbmVfdGVzdF94ODYpIFwKLQkJdmRzb19zdGFuZGFs
b25lX3Rlc3RfeDg2LmMgcGFyc2VfdmRzby5jIFwKLQkJLW8gJEAKKyQoT1VUUFVUKS92ZHNv
X3N0YW5kYWxvbmVfdGVzdF94ODY6IENGTEFHUyArPS1ub3N0ZGxpYiAtZm5vLWFzeW5jaHJv
bm91cy11bndpbmQtdGFibGVzIC1mbm8tc3RhY2stcHJvdGVjdG9yCisKICQoT1VUUFVUKS92
ZHNvX3Rlc3RfY29ycmVjdG5lc3M6IHZkc29fdGVzdF9jb3JyZWN0bmVzcy5jCi0JJChDQykg
JChDRkxBR1MpIFwKLQkJdmRzb190ZXN0X2NvcnJlY3RuZXNzLmMgXAotCQktbyAkQCBcCi0J
CSQoTERGTEFHU192ZHNvX3Rlc3RfY29ycmVjdG5lc3MpCiskKE9VVFBVVCkvdmRzb190ZXN0
X2NvcnJlY3RuZXNzOiBMREZMQUdTICs9IC1sZGwKZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3ZEU08vcGFyc2VfdmRzby5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvdkRTTy9wYXJzZV92ZHNvLmMKaW5kZXggNDEzZjc1NjIwYTM1Li40YWU0MTczNzJlOWUg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vcGFyc2VfdmRzby5j
CisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3ZEU08vcGFyc2VfdmRzby5jCkBAIC01
NSwxNCArNTUsMjAgQEAgc3RhdGljIHN0cnVjdCB2ZHNvX2luZm8KIAlFTEYoVmVyZGVmKSAq
dmVyZGVmOwogfSB2ZHNvX2luZm87CiAKLS8qIFN0cmFpZ2h0IGZyb20gdGhlIEVMRiBzcGVj
aWZpY2F0aW9uLiAqLwotc3RhdGljIHVuc2lnbmVkIGxvbmcgZWxmX2hhc2goY29uc3QgdW5z
aWduZWQgY2hhciAqbmFtZSkKKy8qCisgKiBTdHJhaWdodCBmcm9tIHRoZSBFTEYgc3BlY2lm
aWNhdGlvbi4uLmFuZCB0aGVuIHR3ZWFrZWQgc2xpZ2h0bHksIGluIG9yZGVyIHRvCisgKiBh
dm9pZCBhIGZldyBjbGFuZyB3YXJuaW5ncy4KKyAqLworc3RhdGljIHVuc2lnbmVkIGxvbmcg
ZWxmX2hhc2goY29uc3QgY2hhciAqbmFtZSkKIHsKIAl1bnNpZ25lZCBsb25nIGggPSAwLCBn
OwotCXdoaWxlICgqbmFtZSkKKwljb25zdCB1bnNpZ25lZCBjaGFyICp1Y2hfbmFtZSA9IChj
b25zdCB1bnNpZ25lZCBjaGFyICopbmFtZTsKKworCXdoaWxlICgqdWNoX25hbWUpCiAJewot
CQloID0gKGggPDwgNCkgKyAqbmFtZSsrOwotCQlpZiAoZyA9IGggJiAweGYwMDAwMDAwKQor
CQloID0gKGggPDwgNCkgKyAqdWNoX25hbWUrKzsKKwkJZyA9IGggJiAweGYwMDAwMDAwOwor
CQlpZiAoZykKIAkJCWggXj0gZyA+PiAyNDsKIAkJaCAmPSB+ZzsKIAl9CmRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fc3RhbmRhbG9uZV90ZXN0X3g4
Ni5jIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3N0YW5kYWxvbmVfdGVz
dF94ODYuYwppbmRleCA4YTQ0ZmY5NzNlZTEuLjI3ZjZmZGYxMTk2OSAxMDA2NDQKLS0tIGEv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdkRTTy92ZHNvX3N0YW5kYWxvbmVfdGVzdF94ODYu
YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92RFNPL3Zkc29fc3RhbmRhbG9uZV90
ZXN0X3g4Ni5jCkBAIC0xOCw3ICsxOCw3IEBACiAKICNpbmNsdWRlICJwYXJzZV92ZHNvLmgi
CiAKLS8qIFdlIG5lZWQgYSBsaWJjIGZ1bmN0aW9ucy4uLiAqLworLyogV2UgbmVlZCBzb21l
IGxpYmMgZnVuY3Rpb25zLi4uICovCiBpbnQgc3RyY21wKGNvbnN0IGNoYXIgKmEsIGNvbnN0
IGNoYXIgKmIpCiB7CiAJLyogVGhpcyBpbXBsZW1lbnRhdGlvbiBpcyBidWdneTogaXQgbmV2
ZXIgcmV0dXJucyAtMS4gKi8KQEAgLTM0LDYgKzM0LDIwIEBAIGludCBzdHJjbXAoY29uc3Qg
Y2hhciAqYSwgY29uc3QgY2hhciAqYikKIAlyZXR1cm4gMDsKIH0KIAorLyoKKyAqIFRoZSBj
bGFuZyBidWlsZCBuZWVkcyB0aGlzLCBhbHRob3VnaCBnY2MgZG9lcyBub3QuCisgKiBTdG9s
ZW4gZnJvbSBsaWIvc3RyaW5nLmMuCisgKi8KK3ZvaWQgKm1lbWNweSh2b2lkICpkZXN0LCBj
b25zdCB2b2lkICpzcmMsIHNpemVfdCBjb3VudCkKK3sKKwljaGFyICp0bXAgPSBkZXN0Owor
CWNvbnN0IGNoYXIgKnMgPSBzcmM7CisKKwl3aGlsZSAoY291bnQtLSkKKwkJKnRtcCsrID0g
KnMrKzsKKwlyZXR1cm4gZGVzdDsKK30KKwogLyogLi4uYW5kIHR3byBzeXNjYWxscy4gIFRo
aXMgaXMgeDg2LXNwZWNpZmljLiAqLwogc3RhdGljIGlubGluZSBsb25nIHg4Nl9zeXNjYWxs
Myhsb25nIG5yLCBsb25nIGEwLCBsb25nIGExLCBsb25nIGEyKQogewpAQCAtNzAsNyArODQs
NyBAQCB2b2lkIHRvX2Jhc2UxMChjaGFyICpsYXN0ZGlnLCB0aW1lX3QgbikKIAl9CiB9CiAK
LV9fYXR0cmlidXRlX18oKGV4dGVybmFsbHlfdmlzaWJsZSkpIHZvaWQgY19tYWluKHZvaWQg
KipzdGFjaykKK3ZvaWQgY19tYWluKHZvaWQgKipzdGFjaykKIHsKIAkvKiBQYXJzZSB0aGUg
c3RhY2sgKi8KIAlsb25nIGFyZ2MgPSAobG9uZykqc3RhY2s7Cg==

--------------zvEHuaPS38NLDGr1NkzGpYeN--


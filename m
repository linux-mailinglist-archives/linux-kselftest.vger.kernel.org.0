Return-Path: <linux-kselftest+bounces-29848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCEA72892
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 02:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC763B9539
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 01:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C4555E69;
	Thu, 27 Mar 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Td912i5f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663C4A07
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743040598; cv=none; b=EysYyps1l6IjLq07+OL7hHLcVZSIgHr8/I6BqZ0mqP78LSejX+Jp2hG293JAuP9+U/F5+iuWHJEYCmYFX3aGMMajoeSaRU8P8wCEgvcqAUeBwhgbGTsSMeDlh5jUq8HEPTUN+ac5AME9cBzQ94thu3XrjGGL/lwp2X8Vt1vxoxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743040598; c=relaxed/simple;
	bh=WKJ7mWmFPBRxnpOR+VELzor0tgJoOHyTl8l3Kv+8PXE=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=CFONXFh4NB8JNtXmf1wwe+jKe40cZP/NbHR//T0jHoh21r1LeBgtqiqEUlf9zVH9J9F3hS1KOT1cSmSfedozowfa7VtQDa3vWgidAGOK6YjTeOFGjJhfn4+ugTyHik6uB4fy08yY3SLiolPq0DZdGQfiCOKoZaO9Qc82NIeDAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Td912i5f; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ce868498d3so1332065ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Mar 2025 18:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1743040595; x=1743645395; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZBduPTfPN2uX9BOGMKyaZKiJagAob/jle2PtKYLtCo=;
        b=Td912i5fB7u53D5+ekTl5vo2/phHXSzMxShg+pCkLhmmITUpzlO8Wu9DbvvCzo5Yc5
         u7rLvl0qkgIpdD1CLfO4gApl/TKnZhQEGTz+yySnJB8YsQD6JJO08R0T1GbuWjgwK/qZ
         0wYuHIxpKr61lIEJ5J2sX6IzGN+3iI9OBlITk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743040595; x=1743645395;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZBduPTfPN2uX9BOGMKyaZKiJagAob/jle2PtKYLtCo=;
        b=Qu7MHt2+xJs5BlXrpMIdZ2N3TuIZH1YueBAV4Y9rRP1JcW57VmJU6+7T1uoUljZlQD
         ttkjGLJ2PFBTSDY0T7ZUfhftA/GxUYqdrUSG/Ba+sS8dczjBget8Hd6N47kHTYuI4ADK
         GtUlVM0IJB/SO00lhp2KppnPPFFe8h+6gWmbCnBExj36U/V8hNPaf+fxKbQsSm/9X0ax
         qZTjencY5Np5F0O51xQE+vyMbuFZ6N5Mxj/GOm3ESgy8zsHvVgflLFCKSLnBbbskEm79
         zPoB4K2iOqH6XnFuomJMjA2HTbm6TrB6f5t5YoulDdNiGru2iQooekGBgOq1rxZRjb8E
         Toww==
X-Forwarded-Encrypted: i=1; AJvYcCXVBv5WAAdD02BdCIlGm4FWzmO6JdJCaWxbxIFEdMMGJwgnRPurGzPq+prqo6rMZjdie5UflVhtl78wtpD2xIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRwnG/BmumLYSf16zQiF5xQnQlV2vpfmSejLC/A+qrryc9p9xO
	4jFToO04xMYbpEW/XuJjfeGb9yOaJ9J2OATi4CbHPgxwASgSI6Y/dTCaGqi9Nuw=
X-Gm-Gg: ASbGncti/0Fxim968CkvfMzdN8/3nSkiMjlBa1OnRFSEggvrLLM7lbo0IRR818Mk0Kz
	5Tvl3E3rc5ryVP9eaFUqDPRZAomHZGyTNywbgcHoQoeOBzhRsM8Byr32kQBTnETWUclkXTGPyQh
	1yuYi6PmYjIEUvSarsAablL6QGvA0CXh6jIngBou4jS2kQ0JsDRxxhQShkz2HaochKgFYbJGtLn
	iA4Ud4MJFaSyolWOHiFnESx2WxcgDfPd/K7NdCNT30Ax2OLyyIhYjZyjHSo5I5IOZP7a8PO0Nfg
	msY2Wp1aiY5XDZsyS9yTlAWXVEFqrnRogy5i5zlVW8w9tucSiOBjGBrXCGU/gOAw1J60nNDkeEG
	9u8ho/OslvwItzSSzfLQqH+Dk2AY=
X-Google-Smtp-Source: AGHT+IFHH5FCZeAU3GsafVf2mIwuSdTM1q+8MhrR4QLDXzNQa7OTITQUnueUudOIgDgDhtrJrFvpNQ==
X-Received: by 2002:a05:6e02:1f05:b0:3d3:fdb8:1799 with SMTP id e9e14a558f8ab-3d5cce2c7bdmr26412595ab.22.1743040594829;
        Wed, 26 Mar 2025 18:56:34 -0700 (PDT)
Received: from ?IPV6:2607:fb90:350f:48e4:8567:efb1:9883:10ae? ([2607:fb90:350f:48e4:8567:efb1:9883:10ae])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd0871sm3100635173.42.2025.03.26.18.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 18:56:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------5LOUJqtrUIGQC6X9Tf5kUI86"
Message-ID: <cf07ff28-f329-42a6-abb7-aff61845cbca@linuxfoundation.org>
Date: Wed, 26 Mar 2025 19:56:31 -0600
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
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest next update for Linux 6.15-rc1

This is a multi-part message in MIME format.
--------------5LOUJqtrUIGQC6X9Tf5kUI86
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest next update for Linux 6.15-rc1.

Fixes bugs and cleans up code in tracing, ftrace, and user_events tests.
Adds missing executables to ftrace gitignore.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

   Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-next-6.15-rc1

for you to fetch changes up to 82ef781f24ac26f4aa71f02d7624c439ab8389a7:

   selftests/ftrace: add 'poll' binary to gitignore (2025-03-04 08:51:17 -0700)

----------------------------------------------------------------
linux_kselftest-next-6.15-rc1

Fixes bugs and cleans up code in tracing, ftrace, and user_events tests.
Adds missing executables to ftrace gitignore.

----------------------------------------------------------------
Bharadwaj Raju (1):
       selftests/ftrace: add 'poll' binary to gitignore

Heiko Carstens (1):
       selftests/ftrace: Use readelf to find entry point in uprobe test

Steven Rostedt (3):
       selftests/tracing: Test only toplevel README file not the instances
       selftests/ftrace: Clean up triggers after setting them
       selftests/tracing: Allow some more tests to run in instances

Yiqian Xun (1):
       selftests/user_events: Fix failures caused by test code

  tools/testing/selftests/ftrace/.gitignore                      |  1 +
  .../selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc      | 10 +++++++---
  tools/testing/selftests/ftrace/test.d/functions                |  8 +++++++-
  .../test.d/trigger/inter-event/trigger-action-hist-xfail.tc    |  1 +
  .../test.d/trigger/inter-event/trigger-onchange-action-hist.tc |  3 +++
  .../test.d/trigger/inter-event/trigger-snapshot-action-hist.tc |  3 +++
  .../ftrace/test.d/trigger/trigger-hist-expressions.tc          |  1 +
  tools/testing/selftests/user_events/dyn_test.c                 |  2 ++
  8 files changed, 25 insertions(+), 4 deletions(-)
----------------------------------------------------------------
--------------5LOUJqtrUIGQC6X9Tf5kUI86
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-next-6.15-rc1.diff"
Content-Disposition: attachment; filename="linux_kselftest-next-6.15-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS8uZ2l0aWdub3Jl
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlLy5naXRpZ25vcmUKaW5kZXggMjY1
OTQxN2NiMmM3Li40ZDdmY2I4Mjg4NTAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2Z0cmFjZS8uZ2l0aWdub3JlCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2Z0cmFjZS8uZ2l0aWdub3JlCkBAIC0xLDIgKzEsMyBAQAogIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vbmx5CiBsb2dzCitwb2xsCmRpZmYgLS1naXQgYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2R5bmV2ZW50L2FkZF9yZW1vdmVfdXBy
b2JlLnRjIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9keW5ldmVu
dC9hZGRfcmVtb3ZlX3Vwcm9iZS50YwppbmRleCA4NmM3NjY3OWM1NmUuLmYyMDQ4YzI0NDUy
NiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC9k
eW5ldmVudC9hZGRfcmVtb3ZlX3Vwcm9iZS50YworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9mdHJhY2UvdGVzdC5kL2R5bmV2ZW50L2FkZF9yZW1vdmVfdXByb2JlLnRjCkBAIC0z
LDE0ICszLDE4IEBACiAjIGRlc2NyaXB0aW9uOiBHZW5lcmljIGR5bmFtaWMgZXZlbnQgLSBh
ZGQvcmVtb3ZlL3Rlc3QgdXByb2JlIGV2ZW50cwogIyByZXF1aXJlczogdXByb2JlX2V2ZW50
cwogCitpZiAhIHdoaWNoIHJlYWRlbGYgPiAvZGV2L251bGwgMj4mMSA7IHRoZW4KKyAgZWNo
byAiTm8gcmVhZGVsZiBmb3VuZC4gc2tpcHBlZC4iCisgIGV4aXRfdW5yZXNvbHZlZAorZmkK
KwogZWNobyAwID4gZXZlbnRzL2VuYWJsZQogZWNobyA+IGR5bmFtaWNfZXZlbnRzCiAKIFJF
QUxCSU49YHJlYWRsaW5rIC1mIC9iaW4vc2hgCitFTlRSWVBPSU5UPWByZWFkZWxmIC1oICR7
UkVBTEJJTn0gfCBncmVwIEVudHJ5IHwgc2VkIC1lICdzL1teMF0qLy8nYAogCi1lY2hvICdj
YXQgL3Byb2MvJCQvbWFwcycgfCAvYmluL3NoIHwgXAotCWdyZXAgInIteHAgLioke1JFQUxC
SU59JCIgfCBcCi0JYXdrICd7cHJpbnRmICJwOm15ZXZlbnQgJXM6MHglc1xuIiwgJDYsJDMg
fScgPj4gdXByb2JlX2V2ZW50cworZWNobyAicDpteWV2ZW50ICR7UkVBTEJJTn06JHtFTlRS
WVBPSU5UfSIgPj4gdXByb2JlX2V2ZW50cwogCiBncmVwIC1xIG15ZXZlbnQgdXByb2JlX2V2
ZW50cwogdGVzdCAtZCBldmVudHMvdXByb2Jlcy9teWV2ZW50CmRpZmYgLS1naXQgYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL2Z1bmN0aW9ucyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZnVuY3Rpb25zCmluZGV4IDg0ZDZhOWM3
YWQ2Ny4uYTEwNTJiZjQ2MGZjIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvdGVzdC5kL2Z1bmN0aW9ucworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9mdHJhY2UvdGVzdC5kL2Z1bmN0aW9ucwpAQCAtMTU2LDcgKzE1NiwxMyBAQCBjaGVja19y
ZXF1aXJlcygpIHsgIyBDaGVjayByZXF1aXJlZCBmaWxlcyBhbmQgdHJhY2VycwogICAgICAg
ICAgICAgICAgIGV4aXRfdW5zdXBwb3J0ZWQKICAgICAgICAgICAgIGZpCiAgICAgICAgIGVs
aWYgWyAiJHIiICE9ICIkaSIgXTsgdGhlbgotICAgICAgICAgICAgaWYgISBncmVwIC1GcSAi
JHIiIFJFQURNRSA7IHRoZW4KKwkgICAgIyBJZiB0aGlzIGlzIGFuIGluc3RhbmNlLCBjaGVj
ayB0aGUgdG9wIGRpcmVjdG9yeQorCSAgICBpZiBlY2hvICRUUkFDSU5HX0RJUiB8IGdyZXAg
LXEgIi9pbnN0YW5jZXMvIjsgdGhlbgorCQl0ZXN0PSIkVFJBQ0lOR19ESVIvLi4vLi4iCisJ
ICAgIGVsc2UKKwkJdGVzdD0kVFJBQ0lOR19ESVIKKwkgICAgZmkKKyAgICAgICAgICAgIGlm
ICEgZ3JlcCAtRnEgIiRyIiAkdGVzdC9SRUFETUUgOyB0aGVuCiAgICAgICAgICAgICAgICAg
ZWNobyAiUmVxdWlyZWQgZmVhdHVyZSBwYXR0ZXJuIFwiJHJcIiBpcyBub3QgaW4gUkVBRE1F
LiIKICAgICAgICAgICAgICAgICBleGl0X3Vuc3VwcG9ydGVkCiAgICAgICAgICAgICBmaQpk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmln
Z2VyL2ludGVyLWV2ZW50L3RyaWdnZXItYWN0aW9uLWhpc3QteGZhaWwudGMgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL3RyaWdnZXIvaW50ZXItZXZlbnQvdHJp
Z2dlci1hY3Rpb24taGlzdC14ZmFpbC50YwppbmRleCAxNTkwZDZiZmI4NTcuLjIwYTM1ZmVh
MTNmOCAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3Qu
ZC90cmlnZ2VyL2ludGVyLWV2ZW50L3RyaWdnZXItYWN0aW9uLWhpc3QteGZhaWwudGMKKysr
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmlnZ2VyL2ludGVy
LWV2ZW50L3RyaWdnZXItYWN0aW9uLWhpc3QteGZhaWwudGMKQEAgLTIsNiArMiw3IEBACiAj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiAjIGRlc2NyaXB0aW9uOiBldmVu
dCB0cmlnZ2VyIC0gdGVzdCBpbnRlci1ldmVudCBoaXN0b2dyYW0gdHJpZ2dlciBleHBlY3Rl
ZCBmYWlsIGFjdGlvbnMKICMgcmVxdWlyZXM6IHNldF9ldmVudCBzbmFwc2hvdCAic25hcHNo
b3QoKSI6UkVBRE1FCisjIGZsYWdzOiBpbnN0YW5jZQogCiBmYWlsKCkgeyAjbXNnCiAgICAg
ZWNobyAkMQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rl
c3QuZC90cmlnZ2VyL2ludGVyLWV2ZW50L3RyaWdnZXItb25jaGFuZ2UtYWN0aW9uLWhpc3Qu
dGMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL3RyaWdnZXIvaW50
ZXItZXZlbnQvdHJpZ2dlci1vbmNoYW5nZS1hY3Rpb24taGlzdC50YwppbmRleCA5MTMzOWMx
MzA4MzIuLjU1YWIwMjcwZTVmNyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvZnRyYWNlL3Rlc3QuZC90cmlnZ2VyL2ludGVyLWV2ZW50L3RyaWdnZXItb25jaGFuZ2Ut
YWN0aW9uLWhpc3QudGMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rl
c3QuZC90cmlnZ2VyL2ludGVyLWV2ZW50L3RyaWdnZXItb25jaGFuZ2UtYWN0aW9uLWhpc3Qu
dGMKQEAgLTIsNiArMiw3IEBACiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
CiAjIGRlc2NyaXB0aW9uOiBldmVudCB0cmlnZ2VyIC0gdGVzdCBpbnRlci1ldmVudCBoaXN0
b2dyYW0gdHJpZ2dlciBvbmNoYW5nZSBhY3Rpb24KICMgcmVxdWlyZXM6IHNldF9ldmVudCAi
b25jaGFuZ2UodmFyKSI6UkVBRE1FIHBpbmc6cHJvZ3JhbQorIyBmbGFnczogaW5zdGFuY2UK
IAogZmFpbCgpIHsgI21zZwogICAgIGVjaG8gJDEKQEAgLTE5LDQgKzIwLDYgQEAgaWYgISBn
cmVwIC1xICJjaGFuZ2VkOiIgZXZlbnRzL3NjaGVkL3NjaGVkX3dha2luZy9oaXN0OyB0aGVu
CiAgICAgZmFpbCAiRmFpbGVkIHRvIGNyZWF0ZSBvbmNoYW5nZSBhY3Rpb24gaW50ZXItZXZl
bnQgaGlzdG9ncmFtIgogZmkKIAorZWNobyAnIWhpc3Q6a2V5cz1jb21tOm5ld3ByaW89cHJp
bzpvbmNoYW5nZSgkbmV3cHJpbykuc2F2ZShjb21tLHByaW8pIGlmIGNvbW09PSJwaW5nIicg
Pj4gZXZlbnRzL3NjaGVkL3NjaGVkX3dha2luZy90cmlnZ2VyCisKIGV4aXQgMApkaWZmIC0t
Z2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmlnZ2VyL2lu
dGVyLWV2ZW50L3RyaWdnZXItc25hcHNob3QtYWN0aW9uLWhpc3QudGMgYi90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9mdHJhY2UvdGVzdC5kL3RyaWdnZXIvaW50ZXItZXZlbnQvdHJpZ2dl
ci1zbmFwc2hvdC1hY3Rpb24taGlzdC50YwppbmRleCAxNDc5NjdlODY1ODQuLjllYjM3YzJm
YTQxNyAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3Qu
ZC90cmlnZ2VyL2ludGVyLWV2ZW50L3RyaWdnZXItc25hcHNob3QtYWN0aW9uLWhpc3QudGMK
KysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmlnZ2VyL2lu
dGVyLWV2ZW50L3RyaWdnZXItc25hcHNob3QtYWN0aW9uLWhpc3QudGMKQEAgLTIsNiArMiw3
IEBACiAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wCiAjIGRlc2NyaXB0aW9u
OiBldmVudCB0cmlnZ2VyIC0gdGVzdCBpbnRlci1ldmVudCBoaXN0b2dyYW0gdHJpZ2dlciBz
bmFwc2hvdCBhY3Rpb24KICMgcmVxdWlyZXM6IHNldF9ldmVudCBzbmFwc2hvdCBldmVudHMv
c2NoZWQvc2NoZWRfcHJvY2Vzc19mb3JrL2hpc3QgIm9uY2hhbmdlKHZhcikiOlJFQURNRSAi
c25hcHNob3QoKSI6UkVBRE1FIHBpbmc6cHJvZ3JhbQorIyBmbGFnczogaW5zdGFuY2UKIAog
ZmFpbCgpIHsgI21zZwogICAgIGVjaG8gJDEKQEAgLTI3LDQgKzI4LDYgQEAgaWYgISBncmVw
IC1xICJjb21tPXBpbmciIHNuYXBzaG90OyB0aGVuCiAgICAgZmFpbCAiRmFpbGVkIHRvIGNy
ZWF0ZSBzbmFwc2hvdCBhY3Rpb24gaW50ZXItZXZlbnQgaGlzdG9ncmFtIgogZmkKIAorZWNo
byAnIWhpc3Q6a2V5cz1jb21tOm5ld3ByaW89cHJpbzpvbmNoYW5nZSgkbmV3cHJpbykuc2F2
ZShjb21tLHByaW8pOm9uY2hhbmdlKCRuZXdwcmlvKS5zbmFwc2hvdCgpIGlmIGNvbW09PSJw
aW5nIicgPj4gZXZlbnRzL3NjaGVkL3NjaGVkX3dha2luZy90cmlnZ2VyCisKIGV4aXQgMApk
aWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3QuZC90cmln
Z2VyL3RyaWdnZXItaGlzdC1leHByZXNzaW9ucy50YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2Z0cmFjZS90ZXN0LmQvdHJpZ2dlci90cmlnZ2VyLWhpc3QtZXhwcmVzc2lvbnMudGMK
aW5kZXggMDVmZmJhMjk5ZGJmLi4wZWJkYTIwNjhhMDAgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvdHJpZ2dlci90cmlnZ2VyLWhpc3QtZXhw
cmVzc2lvbnMudGMKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNlL3Rlc3Qu
ZC90cmlnZ2VyL3RyaWdnZXItaGlzdC1leHByZXNzaW9ucy50YwpAQCAtMiw2ICsyLDcgQEAK
ICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKICMgZGVzY3JpcHRpb246IGV2
ZW50IHRyaWdnZXIgLSB0ZXN0IGhpc3RvZ3JhbSBleHByZXNzaW9uIHBhcnNpbmcKICMgcmVx
dWlyZXM6IHNldF9ldmVudCBldmVudHMvc2NoZWQvc2NoZWRfcHJvY2Vzc19mb3JrL3RyaWdn
ZXIgZXZlbnRzL3NjaGVkL3NjaGVkX3Byb2Nlc3NfZm9yay9oaXN0IGVycm9yX2xvZyAiPHZh
cjE+PTxmaWVsZHx2YXJfcmVmfG51bWVyaWNfbGl0ZXJhbD4iOlJFQURNRQorIyBmbGFnczog
aW5zdGFuY2UKIAogCiBmYWlsKCkgeyAjbXNnCmRpZmYgLS1naXQgYS90b29scy90ZXN0aW5n
L3NlbGZ0ZXN0cy91c2VyX2V2ZW50cy9keW5fdGVzdC5jIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvdXNlcl9ldmVudHMvZHluX3Rlc3QuYwppbmRleCBiZGY5YWIxMjc0ODguLjU0Yzk0
MTJmOGRlZSAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvdXNlcl9ldmVu
dHMvZHluX3Rlc3QuYworKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy91c2VyX2V2ZW50
cy9keW5fdGVzdC5jCkBAIC0xMjcsNiArMTI3LDggQEAgc3RhdGljIGludCBwYXJzZV9hYmko
aW50ICpjaGVjaywgY29uc3QgY2hhciAqdmFsdWUpCiAKIAljbG9zZShmZCk7CiAKKwl3YWl0
X2Zvcl9kZWxldGUoKTsKKwogCXJldHVybiByZXQ7CiB9CiAK

--------------5LOUJqtrUIGQC6X9Tf5kUI86--


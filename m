Return-Path: <linux-kselftest+bounces-6903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F31C892526
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 21:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26BD1C20CCE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951313BAC4;
	Fri, 29 Mar 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPh41XLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A613B58D
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743596; cv=none; b=ZhbA8i1R4pv7hm7ir4NaMxo66tMHL575OXGT4QmsVA1Hi0Kfc8MXYuWCDxo9FZvbgzHvd33QJLilkzj1jnSX01A8hhZVI6G9SZpFvWGZFO5LKgWTeXHUh1XN6DfdBUi0cTWDGwphBMntkBmTEHzx560m0k/rjjO2UzM4ick1w8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743596; c=relaxed/simple;
	bh=vl+i70ZMCodkAigSW5hho0Ztj2SmfeRNq80IcW3/8ZA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=b2DdYvZp/vBGDvimbrTo+NvLtPhtNdfytPSQEHcmseHx7meAtEFTwCbEgujUjhK4etRTqosNN1eBQSFF83BbeGOo1SkWrS9OO8R+momHo3is44f7z/D2lSqC6gt8bI6FII4vn4S7ZdsmCPBUsyDXbCWaiAnks3wa381CzYbqrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPh41XLi; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-368539ef3dfso1934015ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711743593; x=1712348393; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=An2c+m0EBVjUyZtfRNWkkg/EmLKM6ADwwn2qcGZufac=;
        b=ZPh41XLino/bd3mlpbAEOsdQJv+egyl50n0re4XEsscXA7SPDK2mFuWIv3BG2IxFnd
         56B7cYDnc4yNaBG48usAjUOzjB0YXpz8OZ1QrnGbkS1BL2G491HFspO5RAwYzJDhp0NY
         fRqNOdFVHYpInmIE8kJpcfXQIEHWwkM/YQIEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711743593; x=1712348393;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An2c+m0EBVjUyZtfRNWkkg/EmLKM6ADwwn2qcGZufac=;
        b=himP3RenBIvkAo23f6irO60Tl4WRG3PILzJqCa10w11pY5ACX/EgPBVySG9HKfVGI6
         JDirb22aKFt8tYaZhespI7UADGvBink4WU3xs5NBKJZ8AHaOeZ/wzrd5jwk2Qf8svUpz
         lE2Tx+RktVIms8fevwox2aqYATXu0xxxST+GcvGNYIp8buTb8LrF9Q0fnCR8GOOsMMwI
         NaeGmFScwnffO+3Oa1iOqKVeYvgy4vJOR8zv4lrhLHFftUmgJFeaF0ThOZMc4hXRB1Z1
         ZB4bevb4/mI34V+E9HwCgYuRUxXaQ7KammtcpNor6/JmZD2/unWCZvQoEZa3m9x5BLY4
         jMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEhWY5RWJ9C/+JX8kC9JeqTExNNL6HtYX7mpoL8JDD14ErElMLnXZj9CiyjU2UYWw6gkuVjQWWOgj+i0S81BHP7XIQatwC8rlj7W71earp
X-Gm-Message-State: AOJu0YxcthTDvHivjfMiYiNzgFs7EJ1WBdbFmI4/nMq0pg5IoTadrFEI
	XzhBtS6UefuP6gBBgiHOJ4aOhf+MZOpJNrh7x00Jus0Rx81XgxqjzaO6wcLW9Jw=
X-Google-Smtp-Source: AGHT+IFUE0Sf7NoL7vX8ci6ITd6PYpGYErdQvzC4eTqLCCaNA/qbYj/Mkoud1o2JaL29+504kfmRNg==
X-Received: by 2002:a5e:da04:0:b0:7d0:32b0:5764 with SMTP id x4-20020a5eda04000000b007d032b05764mr3331372ioj.0.1711743593467;
        Fri, 29 Mar 2024 13:19:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p23-20020a6bfa17000000b007cbf94d8698sm1223132ioh.4.2024.03.29.13.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 13:19:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------OWEC03me0GRkyfQ0OjAfR75D"
Message-ID: <c9b1f203-a8b6-479f-86c2-49d6aac378bf@linuxfoundation.org>
Date: Fri, 29 Mar 2024 14:19:52 -0600
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
Subject: [GIT PULL] Kselftest fixes update for Linux 6.9-rc2

This is a multi-part message in MIME format.
--------------OWEC03me0GRkyfQ0OjAfR75D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.9rc2.

This kselftest fixes update for Linux 6.9-rc2 consists of fixes
to seccomp and ftrace tests and a change to add config file for
dmabuf-heap test to increase coverage.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc2

for you to fetch changes up to 224fe424c356cb5c8f451eca4127f32099a6f764:

   selftests: dmabuf-heap: add config file for the test (2024-03-29 13:57:14 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.9-rc2

This kselftest fixes update for Linux 6.9-rc2 consists of fixes
to seccomp and ftrace tests and a change to add config file for
dmabuf-heap test to increase coverage.

----------------------------------------------------------------
Mark Brown (1):
       selftests/seccomp: Try to fit runtime of benchmark into timeout

Mark Rutland (1):
       selftests/ftrace: Fix event filter target_func selection

Muhammad Usama Anjum (1):
       selftests: dmabuf-heap: add config file for the test

  tools/testing/selftests/dmabuf-heaps/config                           | 3 +++
  tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc | 2 +-
  tools/testing/selftests/seccomp/settings                              | 2 +-
  3 files changed, 5 insertions(+), 2 deletions(-)
  create mode 100644 tools/testing/selftests/dmabuf-heaps/config
----------------------------------------------------------------
--------------OWEC03me0GRkyfQ0OjAfR75D
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.9-rc2.diff"
Content-Disposition: attachment; filename="linux_kselftest-fixes-6.9-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYWJ1Zi1oZWFwcy9jb25m
aWcgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWFidWYtaGVhcHMvY29uZmlnCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYmUwOTFmMWNkZmEwCi0tLSAv
ZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZG1hYnVmLWhlYXBzL2Nv
bmZpZwpAQCAtMCwwICsxLDMgQEAKK0NPTkZJR19ETUFCVUZfSEVBUFM9eQorQ09ORklHX0RN
QUJVRl9IRUFQU19TWVNURU09eQorQ09ORklHX0RSTV9WR0VNPXkKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRl
ci1mdW5jdGlvbi50YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQv
ZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5jdGlvbi50YwppbmRleCAyZGU3YzYxZDFhZTMuLjNm
NzRjMDljNTZiNiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L3Rlc3QuZC9maWx0ZXIvZXZlbnQtZmlsdGVyLWZ1bmN0aW9uLnRjCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5j
dGlvbi50YwpAQCAtMjQsNyArMjQsNyBAQCBlY2hvIDAgPiBldmVudHMvZW5hYmxlCiBlY2hv
ICJHZXQgdGhlIG1vc3QgZnJlcXVlbnRseSBjYWxsaW5nIGZ1bmN0aW9uIgogc2FtcGxlX2V2
ZW50cwogCi10YXJnZXRfZnVuYz1gY3V0IC1kOiAtZjMgdHJhY2UgfCBzZWQgJ3MvY2FsbF9z
aXRlPVwoW14rXSpcKSsweC4qL1wxLycgfCBzb3J0IHwgdW5pcSAtYyB8IHNvcnQgfCB0YWls
IC1uIDEgfCBzZWQgJ3MvXlsgMC05XSovLydgCit0YXJnZXRfZnVuYz1gY2F0IHRyYWNlIHwg
Z3JlcCAtbyAnY2FsbF9zaXRlPVwoW14rXSpcKScgfCBzZWQgJ3MvY2FsbF9zaXRlPS8vJyB8
IHNvcnQgfCB1bmlxIC1jIHwgc29ydCB8IHRhaWwgLW4gMSB8IHNlZCAncy9eWyAwLTldKi8v
J2AKIGlmIFsgLXogIiR0YXJnZXRfZnVuYyIgXTsgdGhlbgogICAgIGV4aXRfZmFpbAogZmkK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2V0dGluZ3Mg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZWNjb21wL3NldHRpbmdzCmluZGV4IDYwOTFi
NDVkMjI2Yi4uYTk1M2M5NmFhMTZlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZWNjb21wL3NldHRpbmdzCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Nl
Y2NvbXAvc2V0dGluZ3MKQEAgLTEgKzEgQEAKLXRpbWVvdXQ9MTIwCit0aW1lb3V0PTE4MAo=


--------------OWEC03me0GRkyfQ0OjAfR75D--


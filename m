Return-Path: <linux-kselftest+bounces-14358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2D93EFC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8201C21161
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4A13C681;
	Mon, 29 Jul 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NS3YyOZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8E13B293;
	Mon, 29 Jul 2024 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241250; cv=none; b=mWN1ibFpl+WQaciZyzgYQB7brWoPTPyXiO0pbBE2csbdEWTid+EVgbAe5fDiWJbU6N9CvwEOJGpjwiJMwG6rn8OqbvWtP1/anykmgosyOUBq+Hud8joSX3B3EiT5VjwKnfSvKdtoRuWmoA7wUAutKOHPuFmiPxz8OHDWq3EgCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241250; c=relaxed/simple;
	bh=gWoeHDWBYkw/Cf56KlItPlCKBTInWP9tVziNZNVhVCU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oDgPhU146vVq9/4vxz8RWrVlPkjQwvjhjESDQ8rVigg4xJm2fGUoln35Vi5jJD2WcXuxPaVkrgtEznSvSng5KcM7fqCAIkhhJQubipiX9Ir5prq335xwahCgeUU3/6tOXrk8lnYib9C9pBEYTtpVh3CqEkY5jBlgcxGQQzCjPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NS3YyOZC; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 780B36000D;
	Mon, 29 Jul 2024 08:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722241239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4fFVFGlNlnhAQFPV1Z/aOZg6AK32ftL61u05vs63M2Q=;
	b=NS3YyOZCFEM4bt1F94deQta+9coiy50AP9gFL20P+aGsCP5EI4TJZrRfJN8FL+QyBEvNam
	gMmPySqvhhZNQQgs7p3PtrZ9I5rX9YDaBQfmSZsPdWJHX8ha6T7eMZdTjWLZlTSx8GZ8SC
	jInwIguj0sx8hdLk3LmBuBYHVotKbuf1PiBhLQ76qSnud63ymAxw++Y0hC99X/wA/dfHHd
	4dbF8hVRMdjaWRGVzGlP4KTMtThOXe2orfbLr3o3LxiZqKmP3CUELxnz4tnVCtkqITOCYj
	ZyCKO7Z+dg3Q6PLrdOm4HCAWsnQ5RqtQfcPgI33rsnanaWE72mEjoXOAtlNUUA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
Date: Mon, 29 Jul 2024 10:20:28 +0200
Message-Id: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMxQp2YC/22NwQqDMBAFf0X23JQYU5We/I8iYjarBtpEkjRYx
 H9vkB57HIY3b4dA3lCAe7GDp2SCcTaDuBSAy2hnYkZnBsGF5I2oGDqbyMdBUxpw9u69slrWUnF
 dNVM5Qh6uniazndEHqHVilrYIfTaLCdH5z/mWytP/wrd/4VQyzgS2qLRsG5SyU87Fp7FXdC/oj
 +P4AsPyG8jAAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this small series aims to integrate test_dev_cgroup in test_progs so it
could be run automatically in CI. The new version brings a few differences
with the current one:
- test now uses directly syscalls instead of wrapping commandline tools
  into system() calls
- test_progs manipulates /dev/null (eg: redirecting test logs into it), so
  disabling access to it in the bpf program confuses the tests. To fix this,
  the first commit modifies the bpf program to allow access to char devices
  1:3 (/dev/null), and disable access to char devices 1:5 (/dev/zero)
- once test is converted, add a small subtest to also check for device type
  interpretation (char or block)
- paths used in mknod tests are now in /dev instead of /tmp: due to the CI
  runner organisation and mountpoints manipulations, trying to create nodes
  in /tmp leads to errors unrelated to the test (ie, mknod calls refused by
  kernel, not the bpf program). I don't understand exactly the root cause
  at the deepest point (all I see in CI is an -ENXIO error on mknod when trying to
  create the node in tmp, and I can not make sense out of it neither
  replicate it locally), so I would gladly take inputs from anyone more
  educated than me about this.

The new test_progs part has been tested in a local qemu environment as well
as in upstream CI:

 ./test_progs -a cgroup_dev
 47/1    cgroup_dev/deny-mknod:OK
 47/2    cgroup_dev/allow-mknod:OK
 47/3    cgroup_dev/deny-mknod-wrong-type:OK
 47/4    cgroup_dev/allow-read:OK
 47/5    cgroup_dev/allow-write:OK
 47/6    cgroup_dev/deny-read:OK
 47/7    cgroup_dev/deny-write:OK
 47      cgroup_dev:OK
 Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED

---
Changes in v2:
- directly pass expected ret code to subtests instead of boolean pass/not
  pass
- fix faulty fd check in subtest expected to fail on open
- fix wrong subtest name
- pass test buffer and corresponding size to read/write subtests
- use correct series prefix
- Link to v1: https://lore.kernel.org/r/20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (3):
      selftests/bpf: do not disable /dev/null device access in cgroup dev test
      selftests/bpf: convert test_dev_cgroup to test_progs
      selftests/bpf: add wrong type test to cgroup dev

 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   2 -
 .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 113 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dev_cgroup.c     |   4 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 ----------------
 5 files changed, 115 insertions(+), 90 deletions(-)
---
base-commit: 3e9fef7751a84a7d02bbe14a67d3a5d301cbd156
change-id: 20240723-convert_dev_cgroup-6464b0d37f1a

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



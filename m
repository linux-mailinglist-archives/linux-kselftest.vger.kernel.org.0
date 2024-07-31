Return-Path: <linux-kselftest+bounces-14509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF4942704
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 08:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F581F22829
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 06:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2516E864;
	Wed, 31 Jul 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SWcbSkj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18A16D307;
	Wed, 31 Jul 2024 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407864; cv=none; b=CBgiOiRn/tef9VfxvurZkDEWNFSXUys3RSzwlNxKiAGVE+cZETah2fOrsoFwak/ZT1szizINIglDR40PZ+K+HK+DZo4HA0ozZUmgYgn3253Tq/aXrwHiUWj28mJHWRYRLzp2oHCYx+AAMS9um8FSxGcIxFMvpIhWx4SR7OpKJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407864; c=relaxed/simple;
	bh=sg9VIN4M0CV6No6xmqYwiqff2sOLqKouf64Z31BvVGU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b3fcae6fTbgv41dJ2ZmXsY2P3pLvXSMiY0bj1+6p8iUPtzV1b7Vxxe56mzBvOUJTzHjLg89ez0DKWxMfIgLbmCSk1Vj8uwxQ2ovp1zy4ud4YZjX6r+CxWLp7uykNrwVq2BamysaF2rBMG5kYHU8rmFpiZJ64R4etvusv8PS/Ex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SWcbSkj8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEADFC0005;
	Wed, 31 Jul 2024 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722407854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aPdAOxZAN3hVP9G2R+391hBaqbIq2iVttLSKrdaO+k0=;
	b=SWcbSkj8/K+h3ixBbyPAfVCv1+04zdpJlKHtpdJdPjosh7hlynlIvzSTxJ/f/38DKnhM4D
	1XRiWeNCjtj/U7oWK60FDLrXUTxWKnICSpza8wJ7/q535ij1TJrnFdIovR8aD6BCw+1yw2
	Nyci7M62rSGvSBIW9O3tXLeq1U0YsRumXTXcOX7xaJCJYDWj5AVysJ1cclbnOhxd1RnZk0
	5vD6kpZJu5Meu7b+oR+U1IVrmdCEvNCuNOcBhGyEGBAKbz0G39QTF9vWnpb28ElbUjOp0r
	GikubpG/3eq1QbH7NhFUKSWsrY/jZ2g6YdRrXs5JSbtISt0JqGKV/b2zbhwJCQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v4 0/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
Date: Wed, 31 Jul 2024 08:37:24 +0200
Message-Id: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKTbqWYC/23NQQrCMBQE0KuUrI2kyY+xrryHiJjfXw1oUpIaK
 tK7G4oLxS6HYd68WKLoKLFd9WKRsksu+BJgVTG8nv2FuGtLZlJIEEYqjsFnisOppXzCSwyPnm9
 gA1a0ynT1mZVhH6lz44wemO077mkc2LE0V5eGEJ/zW67n/gPrJTjXXHCJW7QtbA0C7G0Iw835N
 Yb7DGb5jTSLiCwIYN2h0FJo0P+I+kKUWERUQRpF2ihrQGnzi0zT9AayDsR3SgEAAA==
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
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
  47/1    cgroup_dev/allow-mknod:OK
  47/2    cgroup_dev/allow-read:OK
  47/3    cgroup_dev/allow-write:OK
  47/4    cgroup_dev/deny-mknod:OK
  47/5    cgroup_dev/deny-read:OK
  47/6    cgroup_dev/deny-write:OK
  47/7    cgroup_dev/deny-mknod-wrong-type:OK
  47      cgroup_dev:OK
  Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED

---
Changes in v4:
- Fix mixup between ret and errno by testing both
- Properly apply ack tag from Stanislas
- Link to v3: https://lore.kernel.org/r/20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com

Changes in v3:
- delete mknod file only if it has been created
- use bpf_program__attach_cgroup() instead of bpf_prog_attach
- reorganize subtests order
- collect review/ack tags from Alan and Stanislas
- Link to v2: https://lore.kernel.org/r/20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com

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
 .../testing/selftests/bpf/prog_tests/cgroup_dev.c  | 125 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dev_cgroup.c     |   4 +-
 tools/testing/selftests/bpf/test_dev_cgroup.c      |  85 --------------
 5 files changed, 127 insertions(+), 90 deletions(-)
---
base-commit: 2107cb4bff1c21110ebf7a17458a918282c1a8c9
change-id: 20240723-convert_dev_cgroup-6464b0d37f1a

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



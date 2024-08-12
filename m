Return-Path: <linux-kselftest+bounces-15150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F72094E907
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 10:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6E31F231E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A916BE34;
	Mon, 12 Aug 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZf/tQZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729774C14;
	Mon, 12 Aug 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453096; cv=none; b=V3gVofxO5dIj2M+w2Mz7Kh/vBeIi0IEk+Z55HsAFDe46NntqmXv9nFg7A52Qs+gK9Iwuicy18OY4JhfguGuhQK3B7FIkbjaPpfdPvq8vJC8g8QGd4WWdMvoXYQ7RjQOw9R5MxJcoeaii/11jXTWPKyeA2SqkJTMpc19RmdVf8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453096; c=relaxed/simple;
	bh=mLvu6gXo4g+8ophTXB9CzQ7WD8ZJWObTL3UEQFdYQj0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tKbHwPqA8D68GWV8loO1g5WJAuX4GGJRqyWjHLNeoT5lRhU9Eix4IGkCYKVdFOElAnvNb1fA5QPr7NG7bBIEdpZK01FzsTiVF9+Pm+Y/vZbBcOs49OEQ26xlfQzMA8z92SCVwppFDVNc/oLFgG+Cf/y4AvQAGx6HIp/YA+gMkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZf/tQZD; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2B71FF804;
	Mon, 12 Aug 2024 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723453092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z0BJB69DHJWDk/JjMhZu94LWX5S4er1GRmUXEl+wW9U=;
	b=KZf/tQZD2uC9aWGUy/RQJ6rRl6FkUxXgKvrlDK9icNrcG7kLmxvJ5A1MfaPsWtdNqJvnn2
	EuFf5dHEHev7oAOF8awkT8zA6q60votDAd+nw1+/HMFsyDhpFqx8y026c4FtIo2utThtaU
	h1oHQLOcdGOgXBMoVvXX/zvY/gcpFa+/51xUb7ZpREWEvWQKFrzz8vvBctXXzAMKjnJ8kA
	8KE2o/QhEMkBtZt9XoO0+QGiTFL0dCT9zFwsSn2WeN1Bd4H84u1sEyGFgBQOEWYBopOzkZ
	23Sn0vkZN2in68mB2TaenzFZ6jScWrEidtW47jatxSwRbuexksYWxavtYOnIkw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v3 0/4] selftests/bpf: convert three other cgroup
 tests to test_progs
Date: Mon, 12 Aug 2024 10:58:02 +0200
Message-Id: <20240812-convert_cgroup_tests-v3-0-47ac6ce4e88b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJrOuWYC/3XN0QrCIBgF4FcJrzPUTV1d9R4RI92/TSgdarIYe
 /fMLiKoy8PhfGdBAbyBgA6bBXlIJhhnc6i2G6THix0Amy5nxAiriWQca2cT+Njqwbv71EYIMeC
 OSC0E4RVjHOXp5KE3c2FPSE09tjBHdM7NaEJ0/lH+Ei39m67obzpRTDCttdKcKrGv5VE5F6/G7
 rS7FTKxD9MQ8YdhL6YhmkvgSlLyzazr+gR60dX0CwEAAA==
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
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this series brings a new set of test converted to the test_progs framework.
Since the tests are quite small, I chose to group three tests conversion in
the same series, but feel free to let me know if I should keep one series
per test. The series focuses on cgroup testing and converts the following
tests:
- get_cgroup_id_user
- cgroup_storage
- test_skb_cgroup_id_user

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- Fixed multiple leaks on cgroup file descriptors and sockets
- Used dedicated network namespaces for tests involving network
- Link to v2: https://lore.kernel.org/r/20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com

Changes in v2:
- Use global variables instead of maps when possible
- Collect review tags from Alan
- Link to v1: https://lore.kernel.org/r/20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com

---
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: convert get_current_cgroup_id_user to test_progs
      selftests/bpf: convert test_cgroup_storage to test_progs
      selftests/bpf: add proper section name to bpf prog and rename it
      selftests/bpf: convert test_skb_cgroup_id_user to test_progs

 tools/testing/selftests/bpf/.gitignore             |   3 -
 tools/testing/selftests/bpf/Makefile               |   8 +-
 tools/testing/selftests/bpf/get_cgroup_id_user.c   | 151 -----------------
 .../selftests/bpf/prog_tests/cgroup_ancestor.c     | 169 +++++++++++++++++++
 .../bpf/prog_tests/cgroup_get_current_cgroup_id.c  |  46 ++++++
 .../selftests/bpf/prog_tests/cgroup_storage.c      |  94 +++++++++++
 ...test_skb_cgroup_id_kern.c => cgroup_ancestor.c} |  14 +-
 tools/testing/selftests/bpf/progs/cgroup_storage.c |  24 +++
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |  26 +--
 tools/testing/selftests/bpf/test_cgroup_storage.c  | 174 --------------------
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |  63 -------
 .../selftests/bpf/test_skb_cgroup_id_user.c        | 183 ---------------------
 12 files changed, 342 insertions(+), 613 deletions(-)
---
base-commit: ab2c4aa104050a184c3411a973b165285549f732
change-id: 20240725-convert_cgroup_tests-d07c66053225

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



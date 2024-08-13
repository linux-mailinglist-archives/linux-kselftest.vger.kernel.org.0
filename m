Return-Path: <linux-kselftest+bounces-15217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83495056C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40CE1F207CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A819CCEA;
	Tue, 13 Aug 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jLWMo3UC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69019ADA6;
	Tue, 13 Aug 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553122; cv=none; b=taS6XbYYLJHhX0jvtSoZPycewfnMCvT4ASsW1VPmqFNhSW4ClUItovx+/SfjM4WOmDg3OITldX73d5r0b8M/cgk48N43By5t20fyfCnt4z5BWjdERUMLotxGgbKZMe/Hjo9HI61Z2ykBs71/Zy3zCFxPiu+rnXJ/IDNxp/Z6uQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553122; c=relaxed/simple;
	bh=tbSsJTrf7kJiZPZr3tqCkdiqPHsPTr0ryig5NQ5JWkU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gpEDk/TTETTnzyrO/KHfJEHwDqF5pJn/gQkBzT+j66JORM7hUAnyy0XDKKQ4jxlA1grkkkOzMVN+opjAnYGHejrJ0HXJDuQ0vUj5SEgLgkgDvIB1H/ZzXMRRrRAPFaCxwo5Y3EXmgaFlWRj9uUqInDY8Q8eZWDpFvTSIz+cp1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jLWMo3UC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFF6AC0006;
	Tue, 13 Aug 2024 12:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723553110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zRtblZQA4MLwBUeEOQcnO09wele2w9TnuvZ013OnKHg=;
	b=jLWMo3UCAtGqsOWIwiKW1qGTN1KPO0o4DMVRnBrBFha0fnRCTER/SoQStsJcrExSVc5d33
	Ft11QM64+5K9b0I8/gqbgrGwlfjOS1fEUg1NBe32DD0CMhEXRMziW6sdJwwO+NM19s7uN2
	PhXLHGhZKQK95g3/z3e6imKs3+BHU5yiQyFIIUQmr4y9jr7sYI/CbQNHQRdjK3GFJb9iiU
	8MoFLLh8BbqfRj3894XemhfVqWhbwwatTNc1u1GLROTkSkCzZJ/Rhdu0VnF9Ym0v+ZmiGK
	6yJgFI+iIcBNPECEugKmjtZVB+GfKUBFOH21+3E3dfLXRudv0ru2/8LnOAq7Kg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v4 0/4] selftests/bpf: convert three other cgroup
 tests to test_progs
Date: Tue, 13 Aug 2024 14:45:04 +0200
Message-Id: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFBVu2YC/3XNzQoCIRQF4FcJ1xnq+DO16j0iIm+3EkoHNZmIe
 fdsWlRUy8PhfOdGEkaHiSwmNxKxuOSCr0FOJwSOW39A6nY1E8GEZEYoCsEXjHkDhxgu3SZjyon
 umAGtmWqEUKROu4h714/sithuTz32maxrc3Qph3gd/wof+yfd8N904ZRRLsGC4lbPpVnaEPLJ+
 RmE80gW8WJapv8w4sG0DJRBZQ1n30zzxnDxh2kqI80WNKDEtrWfzDAMdzvikxZSAQAA
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
Changes in v4:
- Fix test after netns addition by making sure loopack interface is up
- Link to v3: https://lore.kernel.org/r/20240812-convert_cgroup_tests-v3-0-47ac6ce4e88b@bootlin.com

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
 .../selftests/bpf/prog_tests/cgroup_storage.c      |  96 +++++++++++
 ...test_skb_cgroup_id_kern.c => cgroup_ancestor.c} |  14 +-
 tools/testing/selftests/bpf/progs/cgroup_storage.c |  24 +++
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |  26 +--
 tools/testing/selftests/bpf/test_cgroup_storage.c  | 174 --------------------
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |  63 -------
 .../selftests/bpf/test_skb_cgroup_id_user.c        | 183 ---------------------
 12 files changed, 344 insertions(+), 613 deletions(-)
---
base-commit: ab2c4aa104050a184c3411a973b165285549f732
change-id: 20240725-convert_cgroup_tests-d07c66053225

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



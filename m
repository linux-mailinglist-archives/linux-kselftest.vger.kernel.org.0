Return-Path: <linux-kselftest+bounces-14525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A17942C1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74035285769
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD21AC43C;
	Wed, 31 Jul 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TakMBs4k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4541AC421;
	Wed, 31 Jul 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422421; cv=none; b=LC8jt6HrrDhsDesj3YDsVGgIeOhYGy7z/VkrN2D+1wHuzixskPS9ALDz73zgtR28hRDz7PVARHl4NdLDHcVGb9b3tWLCUp3Ngj+MBv+XYSqJJzAMeGo6klp1Na09jyNXrWbe2NIhv5pmvHvtSvw3kXci2tDdGh8q2l2tiO5LY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422421; c=relaxed/simple;
	bh=mYLRWXlM+n3SOa6OwEFgUUjWlUaZ3RC92QdfCCeBRCg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jEQuKyQ0UjqUTEfJZtQKxBjXPpyLk9njF5mVExpmUrTz3MZxzx6G7va9U08lJH/SNiTfArbFkvJtjaHRj65AU7F6/7EKUZTlikczEPlZj8m1wzBIdJUnsO2eSYUeoHEE1aiO0/6Z7+4kM+WoE9j0CRs3hUuH24eDFWranARoyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TakMBs4k; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8C02E0007;
	Wed, 31 Jul 2024 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722422417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DcFzzz40MophD/afQvyh9AnsviWCYZt1Cq/CmLhvP5A=;
	b=TakMBs4kSG1jHgfPV/XfHTpUUi8YfQk8aggukm7NNC9xLFNWRfvBGpeE4oY9wXIesj0WcP
	9AY+z/0CtPfeXnU3lhLy4WlxI9nMcHzTeO1fcyCTKkSPYA01dCEUaVNze7D+qVYFkpcaYR
	aTy2FFq69QEmo3zfaBwLxtSVQTfK0G3qa5r2BkLjOud8fZOg1L8yrupk+/vkzs8IyJFcPQ
	O+hIFS4ij/HO1xHvy7kRTYXtOgiYesJnKi27wlNQOlkYQhY1BYtMg9qmzByI0wZGYWefFR
	IE3Fvdg47/AbyKmpXHlgn9QeokGi6ycJAIsqQXVOhERkgGRVqTHbRIMrbloBGQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: convert three other cgroup
 tests to test_progs
Date: Wed, 31 Jul 2024 12:38:23 +0200
Message-Id: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB8UqmYC/x3MQQqEMAxA0atI1lOocargVWQQrVGzaUtSRRDvb
 pnlW/x/g5IwKfTVDUInK8dQUH8q8PsUNjK8FANa/NoOnfExnCR59JvEI42ZNKtZbOfb1roG0UF
 Jk9DK1387wJxWE+jK8HueF/ffbtJwAAAA
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
 linux-kselftest@vger.kernel.org, 
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
Alexis Lothoré (eBPF Foundation) (4):
      selftests/bpf: convert get_current_cgroup_id_user to test_progs
      selftests/bpf: convert test_cgroup_storage to test_progs
      selftests/bpf: add proper section name to bpf prog and rename it
      selftests/bpf: convert test_skb_cgroup_id_user to test_progs

 tools/testing/selftests/bpf/.gitignore             |   3 -
 tools/testing/selftests/bpf/Makefile               |   8 +-
 tools/testing/selftests/bpf/get_cgroup_id_user.c   | 151 -----------------
 .../selftests/bpf/prog_tests/cgroup_ancestor.c     | 159 ++++++++++++++++++
 .../bpf/prog_tests/cgroup_get_current_cgroup_id.c  |  58 +++++++
 .../selftests/bpf/prog_tests/cgroup_storage.c      |  65 ++++++++
 ...test_skb_cgroup_id_kern.c => cgroup_ancestor.c} |   2 +-
 tools/testing/selftests/bpf/progs/cgroup_storage.c |  24 +++
 tools/testing/selftests/bpf/test_cgroup_storage.c  | 174 --------------------
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |  63 -------
 .../selftests/bpf/test_skb_cgroup_id_user.c        | 183 ---------------------
 11 files changed, 309 insertions(+), 581 deletions(-)
---
base-commit: 0e2eaf4b33f65e904b69bae6b956f3f610dbba9a
change-id: 20240725-convert_cgroup_tests-d07c66053225

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



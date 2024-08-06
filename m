Return-Path: <linux-kselftest+bounces-14834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84BE948AA9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 09:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAFCB2368F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB0816A95F;
	Tue,  6 Aug 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kDKt/cnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ED942AA0;
	Tue,  6 Aug 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930923; cv=none; b=HeR7/okAFEifmRzdP4bHqgghLPlaA7rlAKJdywB1/RuMZk7zs/nkn4uhd7NPBnxwzPvqoKOxue5l1BPF3r2en1CzOUtcQ23JrscOXxCRykrK1HE4/ahTWthXidvWZj6NjCwBoW9pnMak/XPCoAMHgYa8LQUl6sSunjbQRoBeRI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930923; c=relaxed/simple;
	bh=Hho3Bqf/9kFmx7wGamGh/nWS2t9BQwLo9vANHGGJfPo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nWmXWd3xx1eF+mw/+wVq1/jREEaPseWnCg6jWjoyO0js9DXouuj3eNKBIFBrVNzOBx8fAW7XlgOO1Mqk8cRDl57YgOOPMHB8wD6MGkZ6wn8zGa08zxRo+YMp3z1IEGwKYtn7y6I3NgBeV2GMKB+e1Mj8matCfgSgluD/YyKM6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kDKt/cnz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3014240002;
	Tue,  6 Aug 2024 07:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722930918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GYpTAA8edk4pyb6Ap5JSaKP/F2u9sV+LUTwUsnkc8iw=;
	b=kDKt/cnztYn7m4T7BSxC6ziv6Lr8JjWHH2Vyzoq3G0i5HW63e8/XYmUqgwq8DZgI67V8DM
	4xfCtrF4udWVwJbK/ypTJvZVBtyYnR+SOcXE23Fj1DsxgHaCznK8g+aW/NgizXgUe+R3uK
	VUunv83h1qDNJRcCH775n/sqUgW3gNVIItXxIwoz1pjT0GUfUp5Jcy3DN5kI60sxCNrXZt
	d/GsBHY819rQAQKJC1xgax3Y+AfoGPtY+LGzQaSRyH5uxeVoYVKMr8+3BtCaahPC6CmrHG
	M6BpieduK3r0awi2KV3OWCPVdvPzxmb4iqrf9uko8IHYVB2fs2vxOpxO3rHnDA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Subject: [PATCH bpf-next v2 0/4] selftests/bpf: convert three other cgroup
 tests to test_progs
Date: Tue, 06 Aug 2024 09:55:11 +0200
Message-Id: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN/WsWYC/22NwQqDMBAFf0X23JQkGqU99T+KSBNXXWiTkKTBI
 v57g732OAxv3gYRA2GEa7VBwEyRnC0gTxWY5WFnZDQWBsllwzupmHE2Y0iDmYN7+yFhTJGNvDN
 ty1UtpYIy9QEnWo/sHbSfmMU1QV/MQjG58Dn+sjj8L12L/+ksGGeiMdooodtL0920c+lJ9mzcC
 /p937/mYaj4xAAAAA==
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
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>
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
 .../selftests/bpf/prog_tests/cgroup_ancestor.c     | 154 +++++++++++++++++
 .../bpf/prog_tests/cgroup_get_current_cgroup_id.c  |  45 +++++
 .../selftests/bpf/prog_tests/cgroup_storage.c      |  65 ++++++++
 ...test_skb_cgroup_id_kern.c => cgroup_ancestor.c} |  14 +-
 tools/testing/selftests/bpf/progs/cgroup_storage.c |  24 +++
 .../selftests/bpf/progs/get_cgroup_id_kern.c       |  26 +--
 tools/testing/selftests/bpf/test_cgroup_storage.c  | 174 --------------------
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |  63 -------
 .../selftests/bpf/test_skb_cgroup_id_user.c        | 183 ---------------------
 12 files changed, 297 insertions(+), 613 deletions(-)
---
base-commit: 34dbece299dfc462db4504268a697f29750d2932
change-id: 20240725-convert_cgroup_tests-d07c66053225

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



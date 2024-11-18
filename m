Return-Path: <linux-kselftest+bounces-22163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE99D0816
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 04:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A481F21CAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B845013A869;
	Mon, 18 Nov 2024 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hICkSiS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A729CF4;
	Mon, 18 Nov 2024 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731899447; cv=none; b=WdqTUFb5ZX4cu9ltFeexMZi8tTOJpgiWj8dizO6VPJf+eR1IPt/QWtJpboS/+rOeOXHZfqShbVgedaMXWJvPt+dGO1iT4FckgbkR+A7Sz4lvDIQ8CUY6fSaV8l3HzFyL05ZgbKS4tTBFNSggK0Touh7VXGXiPnIHSHRVLM/psVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731899447; c=relaxed/simple;
	bh=B/+10sqbKSupSATuAe447F4+PEOQapad9igdJjmyZfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+u+R2gHOMB7roTPrCgvckBN3Fl06mHQ7/8hdEPRrCljiG7OyODWBVdcl25i+x5MimIV3Co3HDvsYc0FPrX2KGByZ6l8hCBuaOtc0mkxyuZ3nXFY0NQbcuSLoBeC0R1SQHlNh8+hiXlqNHXzItVj3lDb3QxB1Kvh8Mibp+ZaaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hICkSiS3; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=sUror
	PIhK+TqCTUr2mfTT198WUfxzfyaZdwozHF9NK0=; b=hICkSiS39dcHt3DiJ9IjV
	F8tN8DGHHbkehV044Txi2wEzFIbqfpaUIUBrP9w1JTbwzibez2Fi2BWT9EcpdSza
	zKv3HDqJOrAGFa0B/8/4HuCLgGIKJ2FezE8HrFJKkCNsEMWhrIRIb/qfX/l/y0/A
	u2l/UjLp/vNSX6tv/BC9t4=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnTyXirzpnA_TwCQ--.780S2;
	Mon, 18 Nov 2024 11:09:31 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	daniel@iogearbox.net
Cc: mykolal@fb.com,
	ast@kernel.org,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	haoluo@google.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	mhal@rbox.co,
	yonghong.song@linux.dev,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH bpf v4 0/2] bpf: fix recursive lock and add test
Date: Mon, 18 Nov 2024 11:09:08 +0800
Message-ID: <20241118030910.36230-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTyXirzpnA_TwCQ--.780S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4rWF1fZFyfCw4ktryrWFg_yoWfKrX_ur
	Wjy34kJ3srJF45tFWjqanY9Fy093y0y348AFy3tr129w47Zrs8ZF4kur9Yy34UZa1fA34a
	q3W5urZaywsxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRXXo2UUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxqbp2c6rMNmmAAAsl

1. fix recursive lock when ebpf prog return SK_PASS.
2. add selftest to reproduce recursive lock.

Note that the test code can reproduce the 'dead-lock' and if just
the selftest merged without first patch, the test case will
definitely fail, because the issue of deadlock is inevitable.

---
v2->v4: fix line length reported by patchwork and remove unused code.
        (max_line_length is set to 80 in patchwork but default is 100 in kernel tree)
v1->v2: 1.inspired by martin.lau to add selftest to reproduce the issue.
        2. follow the community rules for patch.
        v1: https://lore.kernel.org/bpf/55fc6114-7e64-4b65-86d2-92cfd1e9e92f@linux.dev/T/#u
---

Jiayuan Chen (2):
  bpf: fix recursive lock when verdict program return SK_PASS
  selftests/bpf: Add some tests with sockmap SK_PASS

 net/core/skmsg.c                              |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 54 +++++++++++++++++++
 2 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.43.5



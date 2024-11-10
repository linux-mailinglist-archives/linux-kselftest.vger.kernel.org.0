Return-Path: <linux-kselftest+bounces-21743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39AF9C3139
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 09:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C891C20B25
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Nov 2024 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1E014D6EB;
	Sun, 10 Nov 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dj8h395J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF114B96E;
	Sun, 10 Nov 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731227302; cv=none; b=AroEu+kVgqG9oqjDXtDT1qd0JYEsNqCXJEeHprCOxZYpTu7+CUb1EREw/eBJwCLaZaB1v2f7bn2PMIvXxShVeK32imt4zFU+2VkccoSwXgYUK7GjWHwKWez9ObIHwLKhAWZCjohRZmCnFFzt0cTWgGSgofnH3h1a/6fEmuKb2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731227302; c=relaxed/simple;
	bh=npwNU/+kTkMYOInPRZ5Taty5zOdr26g5+W8368VaIWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3ixGlkGhUXIF3qgm5F7fOMOA7zgEkXlQGj0BbR4BYo006zm0kDKPtAenSOstY4vu21NNOHabCkzIjOH86t6IphF/9v63ULM124C94nybxqNSFUY2YEswqMh2rUCHESWBB02ZwB0S79OTqE7SPs4XkzYIdadAOsv452JekBwhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dj8h395J; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Pvdr3
	PrZmxeneufgxTf3r/s5KDkayI7dD4sj9/OZOUY=; b=dj8h395JuZ0wnssstEkaX
	DwMVlVXbTFJZNk8Ou8T6lXKQS54pxHWvqbAaiMh15dNUW/8oLKO25CFdYzQsOGSe
	XH0R0d6WUSCIVecQW8Dym0wxnvnOfkyGscWeOnhlVq6JGSNCEdJLTxjkSiuSD4If
	FHa2A17jb6IcUZKTu5fvAU=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3_zwRbjBnO5BvEQ--.51752S2;
	Sun, 10 Nov 2024 16:26:02 +0800 (CST)
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
Subject: [PATCH bpf v3 0/2] bpf: fix recursive lock and add test
Date: Sun, 10 Nov 2024 16:24:50 +0800
Message-ID: <20241110082452.40415-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_zwRbjBnO5BvEQ--.51752S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw4rWF1fKFyDXr4xZr4DCFg_yoWfuFg_ur
	Wjq34kJ347JF4YyFyUXan5CFy093y8t348AFyUtr129w47ZrW5XF4kWr9Yy34UXa1xA3y2
	qF15urZ2vwsrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRXXo2UUUUUU==
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDw6Tp2cwXFTwuwAAsh

1. fix recursive lock when ebpf prog return SK_PASS.
2. add selftest to reproduce recursive lock.

Note that if just the selftest merged without first
patch, the test case will definitely fail, because the
issue of deadlock is inevitable.

---
v2->v3: fix line length reported by patchwork.
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
 .../bpf/progs/test_sockmap_pass_prog.c        |  2 +-
 3 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.43.5



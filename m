Return-Path: <linux-kselftest+bounces-31750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068FA9E693
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 05:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0DE1774B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862E2149C7B;
	Mon, 28 Apr 2025 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D1gnxgpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CF24431;
	Mon, 28 Apr 2025 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811348; cv=none; b=oyyWI34K0cS1rA0lOHUG1IEOxQvRptRZ2HqQi7W7I8zT+oftTYg46en4hu/vdo1uj3Bjn4emXW6QcgxmyeCeAE8vsXS2DCkPCjZn5L9gYCXQ6JJeAM+YUPYQ/9sTzXA2P4TjdZVOISJ84KrWW0kfPipAEoBoURKI84zqB+RMAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811348; c=relaxed/simple;
	bh=Vl74lbaPxao4i+PKCKAVwlqXBb7lIiZC8DAbfSaqGA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQJhVGFIR+6L5BiaeRzfkK4LE4oboBGof35unVSNrN3heLkCgwuWJxeEtxCGyusKjJXXhiGdNLI6ObXy8wkEzZMsMNAJyDFRwuKT+svJ5ph1b5GYh6QZH7zQo8+75M8upkp3laCX63uKGh+oYQUPvBtYwiAG5Kdb6bYUctpmpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D1gnxgpq; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xC0ns
	2DS1YSWPkq7hRW07GpUN9EJ9rep06tDSrSrHRQ=; b=D1gnxgpq5LIoNHemUJeAd
	bM6TKh9m2vCtmObDVHmkZ0rsmizvA88rnx7ZcWWq9SrKJW3Zq+rS61GcjMk5e+P3
	WWB/r/T3HebG9ZnVuZ+aFoC+aLZDTe5kvuRIjhgj77RE3xzMEib21a3VmnGYD5fU
	hcj0RhVIRFXjkmS7I8ViE4=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDX5pZV9w5oNYEeAQ--.47989S2;
	Mon, 28 Apr 2025 11:34:48 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	toke@redhat.com,
	amery.hung@bytedance.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix compilation errors
Date: Mon, 28 Apr 2025 11:34:45 +0800
Message-Id: <20250428033445.58113-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDX5pZV9w5oNYEeAQ--.47989S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWxJFyrtr18Zr1xWw13XFb_yoW8Aw1fpa
	4DZw1DCr1Fgr4UWry7trW5u3WI9ws5Wry7Ca1UJ34Ikrn8XaykXr1IgayxWa4agrWY9wsx
	ZasF9a43Zr1kCFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jerWrUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTQY8eGgN0ZzHBgABsn

From: Feng Yang <yangfeng@kylinos.cn>

If the CONFIG_NET_SCH_BPF configuration is not enabled,
the BPF test compilation will report the following error:
In file included from progs/bpf_qdisc_fq.c:39:
progs/bpf_qdisc_common.h:17:51: error: declaration of 'struct bpf_sk_buff_ptr' will not be visible outside of this function [-Werror,-Wvisibility]
   17 | void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
      |                                                   ^
progs/bpf_qdisc_fq.c:309:14: error: declaration of 'struct bpf_sk_buff_ptr' will not be visible outside of this function [-Werror,-Wvisibility]
  309 |              struct bpf_sk_buff_ptr *to_free)
      |                     ^
progs/bpf_qdisc_fq.c:309:14: error: declaration of 'struct bpf_sk_buff_ptr' will not be visible outside of this function [-Werror,-Wvisibility]
progs/bpf_qdisc_fq.c:308:5: error: conflicting types for '____bpf_fq_enqueue'

Fixes: 11c701639ba9 ("selftests/bpf: Add a basic fifo qdisc test")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 65a2c561c0bb..7e7f2fe04f22 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -12,6 +12,8 @@
 
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 
+struct bpf_sk_buff_ptr;
+
 u32 bpf_skb_get_hash(struct sk_buff *p) __ksym;
 void bpf_kfree_skb(struct sk_buff *p) __ksym;
 void bpf_qdisc_skb_drop(struct sk_buff *p, struct bpf_sk_buff_ptr *to_free) __ksym;
-- 
2.43.0



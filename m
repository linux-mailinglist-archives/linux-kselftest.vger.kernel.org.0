Return-Path: <linux-kselftest+bounces-38168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED7CB17B54
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F878166121
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 02:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2ED157E99;
	Fri,  1 Aug 2025 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KlzIIBCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10087487BE;
	Fri,  1 Aug 2025 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754016796; cv=none; b=HYcmfTuIEDghnOjxwV/aaNN5DM2oqopkxlRZEzyIqTtp+tjBQkw7Bp5ozsmsHKZ+K7ZJaH+LBTSKOtth19zIDci/dCy/yjPTAT1CoCpg/g5OmFsK0SFJcFlZ5JVzfbXYaZrIASe0mK6Km1aupZRCJiWk/J9El2eenZDzbfdetDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754016796; c=relaxed/simple;
	bh=pNHaJvulCYKuG0b8Yy+lCdkASXqglWLT26rDzH0QsBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8nplY4ka/qiPpKohgMhm+Xtlhjt4SCHDJ9vI7hZIKLs8sYv+E9WPloZRaqEW1NuezMFbGASCQcipzR7HrkAi9WZfa2i3qdBwySarE/aO62X0BwfkRTsu5WKfnJ/EvohPqysjZPd0QiJxCzLC4yKOKVLHv6W/63OdbncGErIHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KlzIIBCF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P/
	aO2bVwhm3KlTRb28FtC23xjh/JMrV2KR9zx14DyfM=; b=KlzIIBCFAjZ+wVgx2i
	7Pl9RIPGbCkvFl7ye//rIV+g9hXh2TH9cYBxXDiwhKUlj4Ov/Fm0iTEPZAyjEZTm
	KR9Iqy1nMgv6yhUbwfa6zvn8S0CMEKRfTMzoA4Kkm0NV3MufNBRBTySRTjufOUqL
	BqE1bWRPRAtlgGP2bmxaNd9vM=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3nxj4K4xouksQJA--.18629S2;
	Fri, 01 Aug 2025 10:52:41 +0800 (CST)
From: chenyuan_fl@163.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH] selftests: bpf: Add missing symbol declarations to common header
Date: Fri,  1 Aug 2025 10:52:39 +0800
Message-ID: <20250801025239.80595-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nxj4K4xouksQJA--.18629S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWfAF47ZrWrKr1rtryUtrb_yoW8WFWUpa
	y5Zw13CF18Wr4UWr1Dtr4Uua1Fkanagw45uw47GryfCrn8tFykX3WIq3WSvw15KrW5Z3sx
	Zr17Ka43Za18GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIOJ5UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxecvWiMKDpeVwAAs+

From: Yuan Chen <chenyuan@kylinos.cn>

Fix implicit function declaration errors in bpf_qdisc_xxx.c by adding
the required kernel symbol declarations to the shared header file
bpf_qdisc_common.h. This ensures all qdisc BPF programs can properly
resolve these kernel functions.

The added declarations include:
- bpf_qdisc_skb_drop
- bpf_qdisc_bstats_update
- bpf_kfree_skb
- bpf_skb_get_hash
- bpf_qdisc_watchdog_schedule

Using a common header prevents duplication and ensures consistency
across different qdisc implementations.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/bpf_qdisc_common.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
index 3754f581b328..4c896b3e0f65 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
@@ -14,6 +14,15 @@
 
 struct bpf_sk_buff_ptr;
 
+extern void bpf_qdisc_skb_drop(struct sk_buff *skb,
+			       struct bpf_sk_buff_ptr *to_free_list) __ksym;
+extern void bpf_qdisc_bstats_update(struct Qdisc *sch,
+				    const struct sk_buff *skb) __ksym;
+extern void bpf_kfree_skb(struct sk_buff *skb) __ksym;
+extern u32 bpf_skb_get_hash(struct sk_buff *skb) __ksym;
+extern void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire,
+					u64 delta_ns) __ksym;
+
 static struct qdisc_skb_cb *qdisc_skb_cb(const struct sk_buff *skb)
 {
 	return (struct qdisc_skb_cb *)skb->cb;
-- 
2.47.3



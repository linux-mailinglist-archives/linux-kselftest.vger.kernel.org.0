Return-Path: <linux-kselftest+bounces-14837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61979948AB1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9965A1C23644
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6DA1BD027;
	Tue,  6 Aug 2024 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a/Eg2fqZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EA165F00;
	Tue,  6 Aug 2024 07:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930925; cv=none; b=XGKbb6SMi5aCgsBV5jSTu48TwZZsZ7q1LbEJwRsU76QR6YPj8PWbLKsGcISIjRfKA9Rv+aGBSYOrMjZIg4QnS5ukYI1UbggRGxmO3Duk9x66F8M8SH/qU10vh1cBu37LKJdy1m92bYKA2ww+ww0aoMFzAayu5XpKGUu+iKAHWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930925; c=relaxed/simple;
	bh=9oNt0WaYPSg4JGMsU247xlPjVAMF26JMUmIJNrtt0TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNAbaMxALyxhzYnF7aVdPzG8qtJVGLwxVTVRt99zcCU4VuZsZT2oNCtL0cVjGBlxoAop8aCfOd806FJx2cbNevn/FKchT2sVzZSEEp9DTzHasy/AwwKWAYYDbo4WF9bRgs8hvFXGhE2fLRpr+1gd8r45CBVNe+d3wnE6ND49DWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a/Eg2fqZ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63272240006;
	Tue,  6 Aug 2024 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722930921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU4BPWAnN7c1WNFwEKIwFGr49YxXIk59zsUN8zRWA+I=;
	b=a/Eg2fqZMdrXSN5QI719XJQn9u41VmcIBz2GiqM5P0B/DeooYX4plYpheMDiJKJ8N9H4WA
	M5feOpX+fwJ9D7DQLKeN48u57GigZ1gUI/zhHUuwGVRxrWxnmfqWn/nq97KCFj8DBcPnsj
	arfMUHRR0HK7C3KVzqexE1cvJYGVu6PCgTR8M5yGUH2MHKSnHuLDL6892fFhylDO/xse9E
	h4qpsuF2Be76rYACqqY3uyacpQ4SgiKZT/wv91uCorLJ4aUS7t//yMDBEBHgP/a54yT7DM
	7X2Eq33NdFi0gv5eQrMk7+GjCbQCWCPHzB9ZC8QzhoUkJ+sRo7zFz4CTRq9cmw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 06 Aug 2024 09:55:14 +0200
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: add proper section name to
 bpf prog and rename it
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-convert_cgroup_tests-v2-3-180c57e5b710@bootlin.com>
References: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
In-Reply-To: <20240806-convert_cgroup_tests-v2-0-180c57e5b710@bootlin.com>
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

test_skb_cgroup_id_kern.c is currently involved in a manual test. In its
current form, it can not be used with the auto-generated skeleton APIs,
because the section name is not valid to allow libbpf to deduce the program
type.

Update section name to allow skeleton APIs usage. Also rename the program
name to make it shorter and more straighforward regarding the API it is
testing. While doing so, make sure that test_skb_cgroup_id.sh passes to get
a working reference before converting it to test_progs
- update the obj name
- fix loading issue (verifier rejecting the program when loaded through tc,
  because of map not found), by preloading the whole obj with bpftool

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../progs/{test_skb_cgroup_id_kern.c => cgroup_ancestor.c}   |  2 +-
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh            | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c b/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
similarity index 97%
rename from tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
rename to tools/testing/selftests/bpf/progs/cgroup_ancestor.c
index 37aacc66cd68..4879645f5827 100644
--- a/tools/testing/selftests/bpf/progs/test_skb_cgroup_id_kern.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
@@ -28,7 +28,7 @@ static __always_inline void log_nth_level(struct __sk_buff *skb, __u32 level)
 	bpf_map_update_elem(&cgroup_ids, &level, &id, 0);
 }
 
-SEC("cgroup_id_logger")
+SEC("tc")
 int log_cgroup_id(struct __sk_buff *skb)
 {
 	/* Loop unroll can't be used here due to [1]. Unrolling manually.
diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
index 515c2eafc97f..d7dad49175c2 100755
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
@@ -30,8 +30,10 @@ setup()
 	wait_for_ip
 
 	tc qdisc add dev ${TEST_IF} clsact
-	tc filter add dev ${TEST_IF} egress bpf obj ${BPF_PROG_OBJ} \
-		sec ${BPF_PROG_SECTION} da
+	mkdir -p /sys/fs/bpf/${BPF_PROG_PIN}
+	bpftool prog loadall ${BPF_PROG_OBJ} /sys/fs/bpf/${BPF_PROG_PIN} type tc
+	tc filter add dev ${TEST_IF} egress bpf da object-pinned \
+		/sys/fs/bpf/${BPF_PROG_PIN}/${BPF_PROG_NAME}
 
 	BPF_PROG_ID=$(tc filter show dev ${TEST_IF} egress | \
 			awk '/ id / {sub(/.* id /, "", $0); print($1)}')
@@ -41,6 +43,7 @@ cleanup()
 {
 	ip link del ${TEST_IF} 2>/dev/null || :
 	ip link del ${TEST_IF_PEER} 2>/dev/null || :
+	rm -rf /sys/fs/bpf/${BPF_PROG_PIN}
 }
 
 main()
@@ -54,8 +57,9 @@ DIR=$(dirname $0)
 TEST_IF="test_cgid_1"
 TEST_IF_PEER="test_cgid_2"
 MAX_PING_TRIES=5
-BPF_PROG_OBJ="${DIR}/test_skb_cgroup_id_kern.bpf.o"
-BPF_PROG_SECTION="cgroup_id_logger"
+BPF_PROG_PIN="cgroup_ancestor"
+BPF_PROG_OBJ="${DIR}/${BPF_PROG_PIN}.bpf.o"
+BPF_PROG_NAME="log_cgroup_id"
 BPF_PROG_ID=0
 PROG="${DIR}/test_skb_cgroup_id_user"
 type ping6 >/dev/null 2>&1 && PING6="ping6" || PING6="ping -6"

-- 
2.46.0



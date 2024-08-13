Return-Path: <linux-kselftest+bounces-15219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A7950571
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3721C212C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1A19D069;
	Tue, 13 Aug 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BKZug/Xw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99A1993AC;
	Tue, 13 Aug 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553124; cv=none; b=lfCjgvSjnr7xgISUdk7V+K5LU5rN8fiymMqDkq57OCvE3VtS9pGSCwh4frMwACJBa+jpSy6nmnKM/jAFSVCrctTWp0QrLFJ57L7evx8F3KYDiYJ+WFZnyFYaO7yXUdt4F5ZEyeDRh2nBaW4NiSEpPJp4fIoKJlvYqgekybuTNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553124; c=relaxed/simple;
	bh=9oNt0WaYPSg4JGMsU247xlPjVAMF26JMUmIJNrtt0TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZvQpwZlPyHoEmoCgJgSZLjmDGu8xUDEwacT4wFxDfyM2J9QNb31KfGp0VJ3QUf+xrfpyJYkVFs66wPCXpx0RzLoSQ0o0argOebxiWWF+Ck50rrZrT180btfNB4enUov2JRY9lXCvBd/VJkseSZBeNSK3/WKfj1tAH9wJNhriKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BKZug/Xw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AB75C000A;
	Tue, 13 Aug 2024 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723553114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU4BPWAnN7c1WNFwEKIwFGr49YxXIk59zsUN8zRWA+I=;
	b=BKZug/XwBjnnoYHdEtDeyCPVLH4gG8YGKhyzLrAyLKrJlFvXNsIyIYFyJkrf7oDiZbaTIh
	d2jYSBzaQl4LziZs0a/q5ddFjEumlAVCePA0u66CgtsfBA3o/IudEamn6byutlJISTRa4t
	2Uqhnw9oNOcYOnvp3/YtcLIPCCBZCrREAoFe18UtSLACCODV0R6/OtQjfyWRkT7qE0tzpw
	1LXcKC+bgjYVyYJU3x2q+nNGTjMxBXhzlwN/IBNyuKhbVTLyVa9oqNm9jLiviu/IwrToSo
	fO1lvI68/NSfGBa1BySo8NFEC3orNgQyEvgQqO+GnXrZr57uniBT5mVUc8nyCA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 13 Aug 2024 14:45:07 +0200
Subject: [PATCH bpf-next v4 3/4] selftests/bpf: add proper section name to
 bpf prog and rename it
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240813-convert_cgroup_tests-v4-3-a33c03458cf6@bootlin.com>
References: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
In-Reply-To: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
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



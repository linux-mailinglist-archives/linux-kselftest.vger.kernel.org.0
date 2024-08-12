Return-Path: <linux-kselftest+bounces-15153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027094E90F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04411F225E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F516D9AF;
	Mon, 12 Aug 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n0rctEuq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FBC16C84C;
	Mon, 12 Aug 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723453099; cv=none; b=KOaA7AaWF4nyMnIVBYMJAc4+NpXGpLz+RNK9UJLKnIx2wtVL7mEWWlek3Nnx3CezdE2AHHUrpSGAUV0QofYOB4aa+tQlOIbkGNtEmmZuP45M1nazMzxzdk8QWENArN5LO7vnj378QxoxBQAlnb2/0WIJJU8FXlzQhftPRcwKrs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723453099; c=relaxed/simple;
	bh=9oNt0WaYPSg4JGMsU247xlPjVAMF26JMUmIJNrtt0TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pg/jZHh4mtfuo34UtSCpr+Bg69VUgskoHpkTRjoyjNzk5kz8Fds3LPiQQSu+UljiHwP6x4U1W+tp6s12M0qJp4QnZcbRm89+jVveIDbQIZs1+icqAr8spdGI8+grJ0m7OT794oWDAjXm+mVofPODvRFFfA8RDNV4MbMdibeNaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n0rctEuq; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27818FF80C;
	Mon, 12 Aug 2024 08:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723453095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jU4BPWAnN7c1WNFwEKIwFGr49YxXIk59zsUN8zRWA+I=;
	b=n0rctEuqpWvSKxLW1eD5CgSaemVjpdaNohIqTgZ1WAbEQjaw+QtUR5o56T3ydYVbSkFw8r
	nqb/zr7cb28Efl0Q6ibYqAIoLo/lADeWWQpXQDRn4OY8dG8gmsEZAq+CguGnauOt6Sdedl
	Cnu2w5ZuNvJ3tu81oKvViTWWsSQa6e/eaOK00Y/6JT9zujsrxNQ7YfZD9Es1Qo0B+BZWpy
	0Y2Ud3FR41TbOcwy5JQcYsZbWis6P9KbNpkHnHs6a22K2DweYKWvwaQT5kNdlJWTyaLHBm
	7Pbf1UFFUV0S3JXR0mJibQSuTXwL+YDW9YIuE85JDDtyuEFMAck7XNBOl1Dk1w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 12 Aug 2024 10:58:05 +0200
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: add proper section name to
 bpf prog and rename it
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240812-convert_cgroup_tests-v3-3-47ac6ce4e88b@bootlin.com>
References: <20240812-convert_cgroup_tests-v3-0-47ac6ce4e88b@bootlin.com>
In-Reply-To: <20240812-convert_cgroup_tests-v3-0-47ac6ce4e88b@bootlin.com>
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



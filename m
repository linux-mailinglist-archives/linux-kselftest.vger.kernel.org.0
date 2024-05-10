Return-Path: <linux-kselftest+bounces-10039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9758C2A45
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5284F1C22A4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF4482C1;
	Fri, 10 May 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ul7kZa15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092845023
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367790; cv=none; b=gpcxujQprORfkuGvV0oWZO7lQXaosKMUBsJGjxGE3fEUAO1PScZfI/d/UI920ihJpKZSy7h8xvrDHxUGTbOMa6/ZWnwV1fuf10/JTz13HynxWgSyivTS8U2SrhlLUwHmQFS842le0OIvWrpjjdaFZYT+oZPdrXwGhb6ktEnkkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367790; c=relaxed/simple;
	bh=BUKmtnNs2wklMJIvxINe04xe6pmF+mh+kjGQW30j49k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A/E6rdzHQyEup5gC+V97pamnagt6/a/DNFTLZz71y1CGXr8so6vxiVLuOk4pefTWSZEmPmKcqfiSq1zbfr0vJbztrqWbtcOOLSvTILGAy1dK0szAVdViqc+z/WqjXNLG1YlAmO18+yA90Pfr/32/BhgWz1+2vKp+txrgs7if5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ul7kZa15; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7e1b80d4004so117882939f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367788; x=1715972588; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgof1JdDIiQsHO2U8t6nMcAU4LuwP+16QwPtEtzPHeM=;
        b=ul7kZa15LmCw4XcqyGIIZfkccnWZ9SpQ9COoCCA545A595pmKnqnTBk/FSnPIfS5H/
         Be9o1hgZU54k53VyMRwMwazpv44/RmCaBhyQ+rdds0brn74wRbAdqY8v46x9e9ONUxdj
         D5vjynuePhPs5opz8qHLCLGi2mdRadVt/0We3rWl0Fv2ue88wVB1LgDFauHhN3EgWGUz
         z5hZxXIpPNDgqhSYaDNVzFy+cf8BdYP1oS7GYsshY0CVziZyci8klV8mIZnGGiEGWnw1
         MWzxxJdAU4u93qgBltiCwZMkQxDPvZ1Gq8+sn942miayZWIXKXXSudFlhKuh/9j1UMHl
         Zt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367788; x=1715972588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgof1JdDIiQsHO2U8t6nMcAU4LuwP+16QwPtEtzPHeM=;
        b=Zu7E5j/Kpm2gJgiwllHzCpgAc9QerY1mSzrSOBrU8YMuostOIU8fht3nhrHbUAIrV1
         X/lvsf7+RFr2uwuvkA3YsJ/bQQB6siG09NPg/qXlfJEuQ6nkIwAGgYPf/NS1YbuYZsmW
         OOpnnchR5Xh10yv1uV76PYFOuzOFRjzSWOURn4zk1Jsj283YAc/cSuuaEZiRZtjj3FBA
         4XDYQQJmZEoTesceukAu2UGcgj/3pwbhGW5rinHVhImP7tRBm3nbdekziN0yK27OY3od
         HeGCgkzdM7nceaJLitMGgAQqvHQqvbDNTuAimdfEl1zTze6vRHtvd1icAHc9uzOMFV5D
         CMEg==
X-Forwarded-Encrypted: i=1; AJvYcCVVVN5uTUvjjUYplKV4tsjf+aYpAK3QKMdHDLPEErBx9uATJKjjjD0z/Xq1KQ+xb5O0GDYcEg6a91noVm7ls6yQJY6wyVyhC3NBJOcxcCAn
X-Gm-Message-State: AOJu0YzjtmIYLQK+1Tz2ScH3rF4Xsivo3/QzZF2HgptQfHbh7fpLkC9C
	nHTGpix9XpPeKvQcDvJ055cgdb1DsxoFxInkAWAiOUHm97f6pmZbhrcybKDtwl71rcw1+H9b0Q=
	=
X-Google-Smtp-Source: AGHT+IEu5Ha/9G6xoyaIJnCe7JbzsANU7IpamibLvfl0JQcsi0n2IXqcNHJI1T7nlje2/yBgL6EAPCRAUg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:210d:b0:488:e34a:5f72 with SMTP id
 8926c6da1cb9f-4895857588dmr232481173.2.1715367788325; Fri, 10 May 2024
 12:03:08 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:29 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-13-jrife@google.com>
Subject: [PATCH v1 bpf-next 12/17] selftests/bpf: Remove redundant sendmsg
 test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove these test cases completely, as the same behavior is already
covered by other sendmsg* test cases in prog_tests/sock_addr.c. This
just rewrites the destination address similar to sendmsg_v4_prog and
sendmsg_v6_prog.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 161 -------------------
 1 file changed, 161 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index 311eda4f48645..a2b587273331c 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -88,170 +88,9 @@ struct sock_addr_test {
 	} expected_result;
 };
 
-static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
-static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
-
 static struct sock_addr_test tests[] = {
-	/* sendmsg */
-	{
-		"sendmsg4: rewrite IP & port (asm)",
-		sendmsg4_rw_asm_prog_load,
-		BPF_CGROUP_UDP4_SENDMSG,
-		BPF_CGROUP_UDP4_SENDMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SRC4_REWRITE_IP,
-		SUCCESS,
-	},
-	{
-		"sendmsg6: rewrite IP & port (asm)",
-		sendmsg6_rw_asm_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SUCCESS,
-	},
 };
 
-static int load_insns(const struct sock_addr_test *test,
-		      const struct bpf_insn *insns, size_t insns_cnt)
-{
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
-	int ret;
-
-	opts.expected_attach_type = test->expected_attach_type;
-	opts.log_buf = bpf_log_buf;
-	opts.log_size = BPF_LOG_BUF_SIZE;
-
-	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, NULL, "GPL", insns, insns_cnt, &opts);
-	if (ret < 0 && test->expected_result != LOAD_REJECT) {
-		log_err(">>> Loading program error.\n"
-			">>> Verifier output:\n%s\n-------\n", bpf_log_buf);
-	}
-
-	return ret;
-}
-
-static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
-{
-	struct sockaddr_in dst4_rw_addr;
-	struct in_addr src4_rw_ip;
-
-	if (inet_pton(AF_INET, SRC4_REWRITE_IP, (void *)&src4_rw_ip) != 1) {
-		log_err("Invalid IPv4: %s", SRC4_REWRITE_IP);
-		return -1;
-	}
-
-	if (make_sockaddr(AF_INET, SERV4_REWRITE_IP, SERV4_REWRITE_PORT,
-			  (struct sockaddr_storage *)&dst4_rw_addr,
-			  NULL) == -1)
-		return -1;
-
-	struct bpf_insn insns[] = {
-		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-		/* if (sk.family == AF_INET && */
-		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-			    offsetof(struct bpf_sock_addr, family)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, AF_INET, 8),
-
-		/*     sk.type == SOCK_DGRAM)  { */
-		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-			    offsetof(struct bpf_sock_addr, type)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, SOCK_DGRAM, 6),
-
-		/*      msg_src_ip4 = src4_rw_ip */
-		BPF_MOV32_IMM(BPF_REG_7, src4_rw_ip.s_addr),
-		BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7,
-			    offsetof(struct bpf_sock_addr, msg_src_ip4)),
-
-		/*      user_ip4 = dst4_rw_addr.sin_addr */
-		BPF_MOV32_IMM(BPF_REG_7, dst4_rw_addr.sin_addr.s_addr),
-		BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7,
-			    offsetof(struct bpf_sock_addr, user_ip4)),
-
-		/*      user_port = dst4_rw_addr.sin_port */
-		BPF_MOV32_IMM(BPF_REG_7, dst4_rw_addr.sin_port),
-		BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7,
-			    offsetof(struct bpf_sock_addr, user_port)),
-		/* } */
-
-		/* return 1 */
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_EXIT_INSN(),
-	};
-
-	return load_insns(test, insns, ARRAY_SIZE(insns));
-}
-
-static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
-					 const char *rw_dst_ip)
-{
-	struct sockaddr_in6 dst6_rw_addr;
-	struct in6_addr src6_rw_ip;
-
-	if (inet_pton(AF_INET6, SRC6_REWRITE_IP, (void *)&src6_rw_ip) != 1) {
-		log_err("Invalid IPv6: %s", SRC6_REWRITE_IP);
-		return -1;
-	}
-
-	if (make_sockaddr(AF_INET6, rw_dst_ip, SERV6_REWRITE_PORT,
-			  (struct sockaddr_storage *)&dst6_rw_addr,
-			  NULL) == -1)
-		return -1;
-
-	struct bpf_insn insns[] = {
-		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-
-		/* if (sk.family == AF_INET6) { */
-		BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_6,
-			    offsetof(struct bpf_sock_addr, family)),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_7, AF_INET6, 18),
-
-#define STORE_IPV6_WORD_N(DST, SRC, N)					       \
-		BPF_MOV32_IMM(BPF_REG_7, SRC[N]),			       \
-		BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7,		       \
-			    offsetof(struct bpf_sock_addr, DST[N]))
-
-#define STORE_IPV6(DST, SRC)						       \
-		STORE_IPV6_WORD_N(DST, SRC, 0),				       \
-		STORE_IPV6_WORD_N(DST, SRC, 1),				       \
-		STORE_IPV6_WORD_N(DST, SRC, 2),				       \
-		STORE_IPV6_WORD_N(DST, SRC, 3)
-
-		STORE_IPV6(msg_src_ip6, src6_rw_ip.s6_addr32),
-		STORE_IPV6(user_ip6, dst6_rw_addr.sin6_addr.s6_addr32),
-
-		/*      user_port = dst6_rw_addr.sin6_port */
-		BPF_MOV32_IMM(BPF_REG_7, dst6_rw_addr.sin6_port),
-		BPF_STX_MEM(BPF_W, BPF_REG_6, BPF_REG_7,
-			    offsetof(struct bpf_sock_addr, user_port)),
-
-		/* } */
-
-		/* return 1 */
-		BPF_MOV64_IMM(BPF_REG_0, 1),
-		BPF_EXIT_INSN(),
-	};
-
-	return load_insns(test, insns, ARRAY_SIZE(insns));
-}
-
-static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test)
-{
-	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_REWRITE_IP);
-}
-
 static int cmp_addr(const struct sockaddr_storage *addr1,
 		    const struct sockaddr_storage *addr2, int cmp_port)
 {
-- 
2.45.0.118.g7fe29c98d7-goog



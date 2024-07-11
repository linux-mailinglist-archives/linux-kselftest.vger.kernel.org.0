Return-Path: <linux-kselftest+bounces-13577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAEF92E6FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB133281247
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F63169AE3;
	Thu, 11 Jul 2024 11:33:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C21607A1;
	Thu, 11 Jul 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697597; cv=none; b=vEKodCAOOUWlFS5tx6m9JaiU0SHYbQ9ATruZ0HJzrRT4TrWQ4KuDewpUOwovVKQIDthnsnBL+JsH901j657hs3PMkWznZmgTTMvgvq5knqScLsnNs1Zi49HV0kxNG1q0ZtIgP2PuM2g2FskN1CsqbGu2Qt8zxkFxDzeuNlNtpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697597; c=relaxed/simple;
	bh=USl+GS8SjbfAG9TdaFkQ19+FupY8gk0c9UWuJ1wPhLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g0/RIoc3uAPcZd8z67HaI7I+V4eRlEkd8Ve4Y1+yrikqxxuQpxQY77Q+Iv40+iz+DWGmheqA8hvCEyk6gxFvn9NC3D2jimBurMd5c+GyHM8bcQHlej1MqsszViSRVWBxBAVVcRpx8ubvUslFggzrSjwoSBRKnSbzn1L7fC2hzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WKXf51cd7z4f3js4;
	Thu, 11 Jul 2024 19:33:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DB39C1A0181;
	Thu, 11 Jul 2024 19:33:12 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgDXKvT0wo9mzI8hBw--.25380S6;
	Thu, 11 Jul 2024 19:33:12 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Brendan Jackman <jackmanb@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	John Johansen <john.johansen@canonical.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH bpf-next v4 17/20] selftests/bpf: Avoid load failure for token_lsm.c
Date: Thu, 11 Jul 2024 19:38:25 +0800
Message-Id: <20240711113828.3818398-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
References: <20240711113828.3818398-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXKvT0wo9mzI8hBw--.25380S6
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1rJr4DJry7XFy7Jr1UJrb_yoW5CF48pF
	95W3429rWkJFy2kr1xXF13KryYqFs2va17JF1UCry0q3y7Kw4UXry7GFWakF95Grsayrsa
	vF95XFZ0qr12kaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The compiler optimized the two bpf progs in token_lsm.c to make return
value from the bool variable in the "return -1" path, causing an
unexpected rejection:

0: R1=ctx() R10=fp0
; int BPF_PROG(bpf_token_capable, struct bpf_token *token, int cap) @ bpf_lsm.c:17
0: (b7) r6 = 0                        ; R6_w=0
; if (my_pid == 0 || my_pid != (bpf_get_current_pid_tgid() >> 32)) @ bpf_lsm.c:19
1: (18) r1 = 0xffffc9000102a000       ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5)
3: (61) r7 = *(u32 *)(r1 +0)          ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5) R7_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
4: (15) if r7 == 0x0 goto pc+11       ; R7_w=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
5: (67) r7 <<= 32                     ; R7_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
6: (c7) r7 s>>= 32                    ; R7_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
7: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
8: (77) r0 >>= 32                     ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
9: (5d) if r0 != r7 goto pc+6         ; R0_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R7=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff))
; if (reject_capable) @ bpf_lsm.c:21
10: (18) r1 = 0xffffc9000102a004      ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5,off=4)
12: (71) r6 = *(u8 *)(r1 +0)          ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5,off=4) R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
;  @ bpf_lsm.c:0
13: (87) r6 = -r6                     ; R6_w=scalar()
14: (67) r6 <<= 56                    ; R6_w=scalar(smax=0x7f00000000000000,umax=0xff00000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xff00000000000000))
15: (c7) r6 s>>= 56                   ; R6_w=scalar(smin=smin32=-128,smax=smax32=127)
; int BPF_PROG(bpf_token_capable, struct bpf_token *token, int cap) @ bpf_lsm.c:17
16: (bf) r0 = r6                      ; R0_w=scalar(id=1,smin=smin32=-128,smax=smax32=127) R6_w=scalar(id=1,smin=smin32=-128,smax=smax32=127)
17: (95) exit
At program exit the register R0 has smin=-128 smax=127 should have been in [-4095, 0]

To avoid this failure, change the variable type from bool to int.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/progs/token_lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/token_lsm.c b/tools/testing/selftests/bpf/progs/token_lsm.c
index e4d59b6ba743..a6002d073b1b 100644
--- a/tools/testing/selftests/bpf/progs/token_lsm.c
+++ b/tools/testing/selftests/bpf/progs/token_lsm.c
@@ -8,8 +8,8 @@
 char _license[] SEC("license") = "GPL";
 
 int my_pid;
-bool reject_capable;
-bool reject_cmd;
+int reject_capable;
+int reject_cmd;
 
 SEC("lsm/bpf_token_capable")
 int BPF_PROG(token_capable, struct bpf_token *token, int cap)
-- 
2.30.2



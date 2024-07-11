Return-Path: <linux-kselftest+bounces-13574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D802A92E6F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E825280CC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560015ECE6;
	Thu, 11 Jul 2024 11:33:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B415ECFD;
	Thu, 11 Jul 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697597; cv=none; b=qDaUpkKswsg50CrG/VSHQ5YHJoXL/VMMdTuN8DW5XUR/x6f4qqXZmysfmQL3OVLD2MPo9VJpWdZnNOeioJGYpKVZ3hbHkKgClqGkJFskgftaaolvmYrOVLa/JgacP+99qWCIZeYSAVs/SJ/74qp0ovhNa8CH3cBUxCzFlMw3JSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697597; c=relaxed/simple;
	bh=Nka+bODEYP2N+MN4laCszVqVFo8qBRk8+LNJimzPa2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmzCmx1zISFDQ9zcJcKEE0QQ06uPq8yQQZM7ewrkdbbyYLHzfohEvkP3x4zHF4xFh7gez1xZFq9qa/Mw/bT6Yj2neg7ZNZixSlQW6mGIu533LojJ9HN7Q3f1cLGdoRBgk/SVJ0Ei4unNXzixde8Pt08NLuU6SE2Jj2O9vVg1Sr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKXf205f3z4f3mHV;
	Thu, 11 Jul 2024 19:32:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E0D301A0189;
	Thu, 11 Jul 2024 19:33:10 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgDXKvT0wo9mzI8hBw--.25380S3;
	Thu, 11 Jul 2024 19:33:10 +0800 (CST)
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
Subject: [PATCH bpf-next v4 14/20] bpf: Prevent tail call between progs attached to different hooks
Date: Thu, 11 Jul 2024 19:38:22 +0800
Message-Id: <20240711113828.3818398-2-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXKvT0wo9mzI8hBw--.25380S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1Dtw45tFWUJF1ktryxXwb_yoWrGrWxpF
	ZrZry8Cr48ur4xXrWxGw1fZry5Aw48Kw47K348X34YvF4qqrn5KF4jgFWavry5Gry5JrWS
	g3W2qFZ8CF95Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UAHUDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

bpf progs can be attached to kernel functions, and the attached functions
can take different parameters or return different return values. If
prog attached to one kernel function tail calls prog attached to another
kernel function, the ctx access or return value verification could be
bypassed.

For example, if prog1 is attached to func1 which takes only 1 parameter
and prog2 is attached to func2 which takes two parameters. Since verifier
assumes the bpf ctx passed to prog2 is constructed based on func2's
prototype, verifier allows prog2 to access the second parameter from
the bpf ctx passed to it. The problem is that verifier does not prevent
prog1 from passing its bpf ctx to prog2 via tail call. In this case,
the bpf ctx passed to prog2 is constructed from func1 instead of func2,
that is, the assumption for ctx access verification is bypassed.

Another example, if BPF LSM prog1 is attached to hook file_alloc_security,
and BPF LSM prog2 is attached to hook bpf_lsm_audit_rule_known. Verifier
knows the return value rules for these two hooks, e.g. it is legal for
bpf_lsm_audit_rule_known to return positive number 1, and it is illegal
for file_alloc_security to return positive number. So verifier allows
prog2 to return positive number 1, but does not allow prog1 to return
positive number. The problem is that verifier does not prevent prog1
from calling prog2 via tail call. In this case, prog2's return value 1
will be used as the return value for prog1's hook file_alloc_security.
That is, the return value rule is bypassed.

This patch adds restriction for tail call to prevent such bypasses.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d255201035c4..bf71edb260cd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -294,6 +294,7 @@ struct bpf_map {
 	 * same prog type, JITed flag and xdp_has_frags flag.
 	 */
 	struct {
+		const struct btf_type *attach_func_proto;
 		spinlock_t lock;
 		enum bpf_prog_type type;
 		bool jited;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ee62e38faf0..4e07cc057d6f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2302,6 +2302,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
+	struct bpf_prog_aux *aux = fp->aux;
 
 	if (fp->kprobe_override)
 		return false;
@@ -2311,7 +2312,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	 * in the case of devmap and cpumap). Until device checks
 	 * are implemented, prohibit adding dev-bound programs to program maps.
 	 */
-	if (bpf_prog_is_dev_bound(fp->aux))
+	if (bpf_prog_is_dev_bound(aux))
 		return false;
 
 	spin_lock(&map->owner.lock);
@@ -2321,12 +2322,26 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 		 */
 		map->owner.type  = prog_type;
 		map->owner.jited = fp->jited;
-		map->owner.xdp_has_frags = fp->aux->xdp_has_frags;
+		map->owner.xdp_has_frags = aux->xdp_has_frags;
+		map->owner.attach_func_proto = aux->attach_func_proto;
 		ret = true;
 	} else {
 		ret = map->owner.type  == prog_type &&
 		      map->owner.jited == fp->jited &&
-		      map->owner.xdp_has_frags == fp->aux->xdp_has_frags;
+		      map->owner.xdp_has_frags == aux->xdp_has_frags;
+		if (ret &&
+		    map->owner.attach_func_proto != aux->attach_func_proto) {
+			switch (prog_type) {
+			case BPF_PROG_TYPE_TRACING:
+			case BPF_PROG_TYPE_LSM:
+			case BPF_PROG_TYPE_EXT:
+			case BPF_PROG_TYPE_STRUCT_OPS:
+				ret = false;
+				break;
+			default:
+				break;
+			}
+		}
 	}
 	spin_unlock(&map->owner.lock);
 
-- 
2.30.2



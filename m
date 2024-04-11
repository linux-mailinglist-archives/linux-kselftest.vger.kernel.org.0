Return-Path: <linux-kselftest+bounces-7696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454138A1475
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 14:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014D8286CDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EC914E2C4;
	Thu, 11 Apr 2024 12:24:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A7D14BF8D;
	Thu, 11 Apr 2024 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838293; cv=none; b=IokiAOj4tcQHlMS/jLg8r1Cjwki+LgepEu2ApLuTNpOPRaQAOiLKuH4Iy8IFXhIVSuZJG8PTLAOPIK5pK/3Y8RVL5h4DyuXf9f1kFyook8G4YWuziOE0NLkmgELg1vU6YkXx9BvOh6+JqXwm8vigyN+FN8JgsM1IIjBepFnjvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838293; c=relaxed/simple;
	bh=ZQyaL0WiOmapKU1DLJG24/f7k4kwX7jk601/QooCOVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TM/Adt/ffnhcBdckxntWOWcbhqGaqpcqLY3s4S1LQA4MVn/AoLxGlEYtnyl31AgY2VQnL5Pdh46y5Gc0LvfKNlQrL7IjExGr/IVELvswfwGacR+6yo2MxEmraRUbjNYoaSgpl3PWRB+F60cLsuBCTGN126qDLhdgxiQm/5d4yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VFf5d5zgjz4f3n6D;
	Thu, 11 Apr 2024 20:24:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7EB501A0572;
	Thu, 11 Apr 2024 20:24:46 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP4 (Coremail) with SMTP id gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S9;
	Thu, 11 Apr 2024 20:24:46 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
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
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 07/11] bpf: Fix a false rejection caused by AND operation
Date: Thu, 11 Apr 2024 20:27:48 +0800
Message-Id: <20240411122752.2873562-8-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3h2mJ1hdmZ5R_Jw--.23051S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXr48KF48ZFy3JFy3Cr13XFb_yoWrZFWkpr
	W5Wrn09r4kZrWxuwnFvan8Ar95tF48Za18JasrA340vry3KF45tr1UKryUJ3sxJrs5Jw4S
	qFnrX3y7Kw4UGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

With lsm return value check, the no-alu32 version test_libbpf_get_fd_by_id_opts
is rejected by the verifier, and the log says:

  0: R1=ctx() R10=fp0
  ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
  0: (b7) r0 = 0                        ; R0_w=0
  1: (79) r2 = *(u64 *)(r1 +0)
  func 'bpf_lsm_bpf_map' arg0 has btf_id 916 type STRUCT 'bpf_map'
  2: R1=ctx() R2_w=trusted_ptr_bpf_map()
  ; if (map != (struct bpf_map *)&data_input) @ test_libbpf_get_fd_by_id_opts.c:29
  2: (18) r3 = 0xffff9742c0951a00       ; R3_w=map_ptr(map=data_input,ks=4,vs=4)
  4: (5d) if r2 != r3 goto pc+4         ; R2_w=trusted_ptr_bpf_map() R3_w=map_ptr(map=data_input,ks=4,vs=4)
  ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
  5: (79) r0 = *(u64 *)(r1 +8)          ; R0_w=scalar() R1=ctx()
  ; if (fmode & FMODE_WRITE) @ test_libbpf_get_fd_by_id_opts.c:32
  6: (67) r0 <<= 62                     ; R0_w=scalar(smax=0x4000000000000000,umax=0xc000000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xc000000000000000))
  7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
  ;  @ test_libbpf_get_fd_by_id_opts.c:0
  8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
  ; int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode) @ test_libbpf_get_fd_by_id_opts.c:27
  9: (95) exit

And here is the C code of the prog.

SEC("lsm/bpf_map")
int BPF_PROG(check_access, struct bpf_map *map, fmode_t fmode)
{
	if (map != (struct bpf_map *)&data_input)
		return 0;

	if (fmode & FMODE_WRITE)
		return -EACCES;

	return 0;
}

It is clear that the prog can only return either 0 or -EACCESS, and both
values are legal.

So why is it rejected by the verifier?

The verifier log shows that the second if and return value setting
statements in the prog is optimized to bitwise operations "r0 s>>= 63"
and "r0 &= -13". The verifier correctly deduces that the the value of
r0 is in the range [-1, 0] after verifing instruction "r0 s>>= 63".
But when the verifier proceeds to verify instruction "r0 &= -13", it
fails to deduce the correct value range of r0.

7: (c7) r0 s>>= 63                    ; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
8: (57) r0 &= -13                     ; R0_w=scalar(smax=0x7ffffffffffffff3,umax=0xfffffffffffffff3,smax32=0x7ffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))

So why the verifier fails to deduce the result of 'r0 &= -13'?

The verifier uses tnum to track values, and the two ranges "[-1, 0]" and
"[0, -1ULL]" are encoded to the same tnum. When verifing instruction
"r0 &= -13", the verifier erroneously deduces the result from
"[0, -1ULL] AND -13", which is out of the expected return range
[-4095, 0].

To fix it, this patch simply adds a special SCALAR32 case for the
verifier. That is, when the source operand of the AND instruction is
a constant and the destination operand changes from negative to
non-negative and falls in range [-256, 256], deduce the result range
by enumerating all possible AND results.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 kernel/bpf/verifier.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5393d576c76f..62e259f18f35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13369,6 +13369,29 @@ static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
 		return;
 	}
 
+	if (src_known &&
+		dst_reg->s32_min_value < 0 && dst_reg->s32_min_value >= -256 &&
+		dst_reg->s32_max_value >= 0 && dst_reg->s32_max_value <= 256 &&
+		dst_reg->s32_min_value == dst_reg->smin_value &&
+		dst_reg->s32_max_value == dst_reg->smax_value) {
+		s32 s32_min = S32_MAX;
+		s32 s32_max = S32_MIN;
+		s32 v = dst_reg->s32_min_value;
+		while (v <= dst_reg->s32_max_value) {
+			s32 w = (v & src_reg->s32_min_value);
+			if (w < s32_min)
+				s32_min = w;
+			if (w > s32_max)
+				s32_max = w;
+			v++;
+		}
+		dst_reg->s32_min_value = s32_min;
+		dst_reg->s32_max_value = s32_max;
+		dst_reg->u32_min_value = var32_off.value;
+		dst_reg->u32_max_value = min(dst_reg->u32_max_value, umax_val);
+		return;
+	}
+
 	/* We get our minimum from the var_off, since that's inherently
 	 * bitwise.  Our maximum is the minimum of the operands' maxima.
 	 */
-- 
2.30.2



Return-Path: <linux-kselftest+bounces-34874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A3CAD84B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3E7163FA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC39291C14;
	Fri, 13 Jun 2025 07:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kvD2hrpD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB9F3DABE3;
	Fri, 13 Jun 2025 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800266; cv=none; b=hpP+yohiqQSjoTmC8o1AvfwsOLxIw+L9NwwjkCjKbW2NayJXsBAaYJADGTbxLyyTkRDrN0B3CIqFw1T3uPVBL83TMmZ7LRdmjA7O8FE2vGUB10t4R4gt31u6ZYdFmud3XdQRIg9VqbBrJV22EUxQ+LQOzNUVctZu/n+TnCpe384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800266; c=relaxed/simple;
	bh=vtKxNMQ6gJ2JlF1RXe+Fzar4sjRw68Vcwy6y8vb5qGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xo7GZTNnTqLRZxs3Oq9SsU6CkIQ9CIY0oThvy9RqCax0fOVSK8ZgmZVcRfNQ1fZN1Wd77Zf8DHidbEyR5jnh4Xcy1hSmJwgEvvwuyTnIfn3EBqI42YbC/DkNgC6Vcf27nJlq/cux5tdqoDuq6enkz95WEoTe5pZNuYR1TTcb5Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kvD2hrpD; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88A9C44516;
	Fri, 13 Jun 2025 07:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749800260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AE8ksX7Iai+R1M5VXIrdzL2o9dpfxU46gR1hgNGIp3g=;
	b=kvD2hrpD62fIseyftMWMe0jHM9CAcsYLN8R7Xc6MonWGBLp7j1sio+s3HcvX7iPfzC/8h8
	getABYjlm0kibtX6MId+UBJ9HmyRY30O6f5FyYUYWuUd8PDdov6JURNzzP4S+uSdsJSv4q
	XEb+KK+3h6voonmJL7D85NyAtp25lNiRQMRalDJ3kPboHbjNLpH55lSoe5q2znNNkOnL81
	8DtdUSstHOPVtwdZHqSvS3c5RAY9y45B+vRcTVgadBsa9GwE1sAcrWV87jhqCt7RWiB26X
	LiMUIN4BZaGLJ52spVpVwWII1yY7zWXf+/2MwJYIcUGxuNPNiZ1HJdUWRRohqg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 13 Jun 2025 09:37:13 +0200
Subject: [PATCH bpf 4/7] bpf/s390: prevent trampoline attachment when args
 location on stack is uncertain
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250613-deny_trampoline_structs_on_stack-v1-4-5be9211768c3@bootlin.com>
References: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
In-Reply-To: <20250613-deny_trampoline_structs_on_stack-v1-0-5be9211768c3@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Menglong Dong <imagedong@tencent.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehkedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigq
 dhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghplhihrdgtohhmpdhrtghpthhtoheprghlvgigrghnughrvgdrthhorhhguhgvsehfohhsshdrshhtrdgtohhmpdhrtghpthhtohepmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtohepshhvvghnsheslhhinhhugidrihgsmhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

When the target function receives more arguments than available
registers, the additional arguments are passed on stack, and so the
generated trampoline needs to read those to prepare the bpf context, but
also to prepare the target function stack when it is in charge of
calling it. This works well for scalar types, but if the value is a
struct, we can not know for sure the exact struct location, as it may
have been packed or manually aligned to a greater value.

Prevent wrong readings by refusing trampoline attachment if the target
function receives a struct on stack. While doing so, move the existing
check (ensuring that the number of args passed on stack is not higher
than MAX_NR_STACK_ARGS) into the newly created check function.

Fixes: 528eb2cb87bc ("s390/bpf: Implement arch_prepare_bpf_trampoline()")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 arch/s390/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c7f8313ba449716a8f18eafdeb6c77ed3b23f52e..b441feb20e993f54cc0e9a39c67a726f4b61d9f2 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2566,6 +2566,27 @@ static int alloc_stack(struct bpf_tramp_jit *tjit, size_t size)
 /* -mfentry generates a 6-byte nop on s390x. */
 #define S390X_PATCH_SIZE 6
 
+static int validate_args(const struct btf_func_model *m)
+{
+	int i = 0, nr_reg_args, nr_stack_args;
+
+	nr_reg_args = min_t(int, m->nr_args, MAX_NR_REG_ARGS);
+	nr_stack_args = m->nr_args - nr_reg_args;
+
+	if (nr_stack_args == 0)
+		return 0;
+
+	/* Support as many stack arguments as "mvc" instruction can handle. */
+	if (nr_stack_args > MAX_NR_STACK_ARGS)
+		return -ENOTSUPP;
+
+	for (i = nr_reg_args; i < m->nr_args; i++)
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			return -ENOTSUPP;
+
+	return 0;
+}
+
 static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 					 struct bpf_tramp_jit *tjit,
 					 const struct btf_func_model *m,
@@ -2579,13 +2600,17 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int nr_bpf_args, nr_reg_args, nr_stack_args;
 	struct bpf_jit *jit = &tjit->common;
 	int arg, bpf_arg_off;
-	int i, j;
+	int i, j, ret;
+
+	/* make sure that any argument can be located and processed by the
+	 * trampoline
+	 */
+	ret = validate_args(m);
+	if (ret)
+		return ret;
 
-	/* Support as many stack arguments as "mvc" instruction can handle. */
 	nr_reg_args = min_t(int, m->nr_args, MAX_NR_REG_ARGS);
 	nr_stack_args = m->nr_args - nr_reg_args;
-	if (nr_stack_args > MAX_NR_STACK_ARGS)
-		return -ENOTSUPP;
 
 	/* Return to %r14 in the struct_ops case. */
 	if (flags & BPF_TRAMP_F_INDIRECT)

-- 
2.49.0



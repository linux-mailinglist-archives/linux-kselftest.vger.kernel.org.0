Return-Path: <linux-kselftest+bounces-30621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59782A86732
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9005A1B63ED9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05E28CF57;
	Fri, 11 Apr 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VpzGMXts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C764280CCD;
	Fri, 11 Apr 2025 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403550; cv=none; b=APW/qGeicDZ7fdYMDjj/oI2RpM9Un2TDbXHX6ohpvSwca4K9mCnnBAiyDt7Cc/uA/+QCLRVTb06lVCteRuuYRsruMyUbWzj8ejbyuvdgo0lNTYqa5nj27ETS7DIjRLEjLuytd+9q01Ws66yPZMgp0tcL1RFKiSEFhP8AIwAavuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403550; c=relaxed/simple;
	bh=ejORcpvGfrfykxujY30gBt0iabsPSkXI6NglRqseVT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osZbZVRnerPABwwaVe1LqAWCZ5Fn8uCvtiD/hP79OvfTEerBXSl7Sc+zyn9qPa8KgruV2bVi1e0SN+QOiZC+pR2HVOohDwEkMfSv2TG0TjNC1EIdg046ofJys2yLUX81cXSMILu8RP2CtqoQFEgCSAbT/cBpH/U4hc/hlubH8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VpzGMXts; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 285C4439D4;
	Fri, 11 Apr 2025 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744403540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0Lf7W9bQWXXAkTM40dnJ+uKraq0dPHGV+hXAWhTfnE=;
	b=VpzGMXts8vgeVU0Ddi28PFbkrr/1n86d1hEvDDcle5wS5M0lcVaWSGqTxCtPLuPev9r/Tx
	E2ORWC9W6nXSL8Y18Wo/dJEmtwBjAQT0DAPcPgEC6ihScWncCoiKeKZ1H+y7Jr9SiVrTAY
	LhaDvIx9k7Fku99th6Vtjs4eoHgyeZleFXOszZbgeSoDGiHw52wkOusp3dz5Oo3lR+OpEC
	RUvZgfKfzXSwDwmgolZgjTWZtlIOvpsBZv8yzn9ma4AxcVQaiLEsbgi2imv8inV7yEU55Q
	HQX9Pzt0vzhuue/BtlfvqOoZumlBd3DBNUQfA4S7DnePLIztKZtYJrTopLvZHQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 11 Apr 2025 22:32:10 +0200
Subject: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
In-Reply-To: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Florent Revest <revest@chromium.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhorucdlvgeurffhucfhohhunhgurghtihhonhdmuceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeljeektefffeevleegkeelhfethffgieegudevffejheelieeffeejtddujeegueenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplgduledvrdduieekrddurdduleejngdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedtpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphhtthhopeiguhhkuhhohhgriheshhhurgifvghitghlohhuugdrtghomhdprhgtphhtthhopehjohhlshgrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmhihkohhlrghlsehfsgdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgtohhquhgvlhhinhdrshhtmhefvdesghhmrghilhdrtghomh
X-GND-Sasl: alexis.lothore@bootlin.com

In order to properly JIT the trampolines needed to attach BPF programs
to functions, some architectures like ARM64 need to know about the
alignment needed for the function arguments. Such alignment can
generally be deduced from the argument size, but that's not completely
true for composite types. In the specific case of ARM64, the AAPCS64 ABI
defines that a composite type which needs to be passed through stack
must be aligned on the maximum between 8 and the largest alignment
constraint of its first-level members. So the JIT compiler needs more
information about the arguments to make sure to generate code that
respects those alignment constraints.

For struct arguments, add information about the size of the largest
first-level member in the struct btf_func_model to allow the JIT
compiler to guess the needed alignment. The information is quite
specific, but it allows to keep arch-specific concerns (ie: guessing the
final needed alignment for an argument) isolated in each JIT compiler.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/btf.c    | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622cb1a097999afb78c17102593b6bb..8b34dcf60a0ce09228ff761b962ab67b6a3e2263 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1106,6 +1106,7 @@ struct btf_func_model {
 	u8 nr_args;
 	u8 arg_size[MAX_BPF_FUNC_ARGS];
 	u8 arg_flags[MAX_BPF_FUNC_ARGS];
+	u8 arg_largest_member_size[MAX_BPF_FUNC_ARGS];
 };
 
 /* Restore arguments before returning from trampoline to let original function
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfab7531babf5753cab9f368cddefa3..5d40911ec90210086a6175d569abb6e52d75ad17 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7318,6 +7318,29 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
 	return -EINVAL;
 }
 
+static u8 __get_largest_member_size(struct btf *btf, const struct btf_type *t)
+{
+	const struct btf_member *member;
+	const struct btf_type *mtype;
+	u8 largest_member_size = 0;
+	int i;
+
+	if (!__btf_type_is_struct(t))
+		return largest_member_size;
+
+	for_each_member(i, t, member) {
+		mtype = btf_type_by_id(btf, member->type);
+		while (mtype && btf_type_is_modifier(mtype))
+			mtype = btf_type_by_id(btf, mtype->type);
+		if (!mtype)
+			return -EINVAL;
+		if (mtype->size > largest_member_size)
+			largest_member_size = mtype->size;
+	}
+
+	return largest_member_size;
+}
+
 static u8 __get_type_fmodel_flags(const struct btf_type *t)
 {
 	u8 flags = 0;
@@ -7396,6 +7419,8 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 		}
 		m->arg_size[i] = ret;
 		m->arg_flags[i] = __get_type_fmodel_flags(t);
+		m->arg_largest_member_size[i] =
+			__get_largest_member_size(btf, t);
 	}
 	m->nr_args = nargs;
 	return 0;

-- 
2.49.0



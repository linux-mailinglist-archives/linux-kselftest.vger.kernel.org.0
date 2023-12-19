Return-Path: <linux-kselftest+bounces-2204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D038188ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 14:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A092CB229EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC019BCF;
	Tue, 19 Dec 2023 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioGokt/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D871A58F;
	Tue, 19 Dec 2023 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-593d9b1139fso811752eaf.1;
        Tue, 19 Dec 2023 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702993843; x=1703598643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIG7gX50kKtmhzIyeXshzVLZolIi3kTx5IiKTBxlLu0=;
        b=ioGokt/z7J9mHNSSlfnrNpmaKq6ggDsV2EvsOMhhnH2kulZcbIPnsixNNwOt7VKBtS
         6VNgVkRNPrhBiMquVeRkt298IJJFpCtjWj9qmPRsnH+6PIEXzdEJh25DfXB9zwQA8Ru8
         uhbsa9mBGCB93E4dhKNReE6k7ykx+9RIvN3N3DLzsf0DqplqQAvlMuURIVnkHdtIJ00c
         TIOplV+/fnG/fK0MBMIsRyr5+E3n9uGO0AyYx49nDV3S+DeT484jemClgYr2ynNJcmMN
         zWMm9jpfNlBQB1Xaqw6HPCCyCh+ofOwn7YxpGEM9vimrw8ZLFuFw2QFCoyOKDWgPFySf
         Fgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993843; x=1703598643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIG7gX50kKtmhzIyeXshzVLZolIi3kTx5IiKTBxlLu0=;
        b=EVmr7XrIFAmA+X0m1Bw9MVAwnEtYhhV1KF8MRTDYwrI0IQq3yiVoBAJUP1wXRJhlYF
         F/s5xLY+0y2AbbYXMawxZ2D1RWD+n2DV8FWOAksP4CJ14zUvib1VPUoKjz70/3grvKik
         t5g0QT/p2GDKC26FCDE/wQEtpJ/vv4jn3rj31OD6FVxx4Y6XCqD/1LyMM1FhCrPiAaKG
         IjmwlAxO4QY00W3qjY838h9Ojtoz9MCfkBXl3m+h+G+htINmq3xoJ2en7mWK37P1O9Ix
         9zpY06TJ/4mTqVyF7Ph4yY9+NhfQi4iBt7l9ppjVXL0rboqZdVzt8OnxD4/djPECE+NP
         dCnw==
X-Gm-Message-State: AOJu0YzFWdFcsR7we6t7W7zJcQWh0UQt0aE7KMSUasuQD3sJ6uVnO/gQ
	qUfyA7D+Xtdw2HXtkosp4ic33NXVI/xihEFx
X-Google-Smtp-Source: AGHT+IEUwCFelS+UDCF6zIJzpNrzXI5jANkHv2yAjuwZIR0y0E6j5IOFn16FRHcI6Z86VT3MRtmB8w==
X-Received: by 2002:a05:6358:5e15:b0:170:b07b:8352 with SMTP id q21-20020a0563585e1500b00170b07b8352mr17482631rwn.4.1702993842987;
        Tue, 19 Dec 2023 05:50:42 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b006cddecbf432sm20695264pfj.96.2023.12.19.05.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:50:42 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	menglong8.dong@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v5 1/4] bpf: make the verifier tracks the "not equal" for regs
Date: Tue, 19 Dec 2023 21:47:57 +0800
Message-Id: <20231219134800.1550388-2-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219134800.1550388-1-menglong8.dong@gmail.com>
References: <20231219134800.1550388-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u32 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
v2:
- fix a typo in the subject
- add some comments, as Eduard advised
---
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..29c41d66ea6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14343,7 +14343,43 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		}
 		break;
 	case BPF_JNE:
-		/* we don't derive any new information for inequality yet */
+		if (!is_reg_const(reg2, is_jmp32))
+			swap(reg1, reg2);
+		if (!is_reg_const(reg2, is_jmp32))
+			break;
+
+		/* try to recompute the bound of reg1 if reg2 is a const and
+		 * is exactly the edge of reg1.
+		 */
+		val = reg_const_value(reg2, is_jmp32);
+		if (is_jmp32) {
+			/* u32_min_value is not equal to 0xffffffff at this point,
+			 * because otherwise u32_max_value is 0xffffffff as well,
+			 * in such a case both reg1 and reg2 would be constants,
+			 * jump would be predicted and reg_set_min_max() won't
+			 * be called.
+			 *
+			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
+			 * below.
+			 */
+			if (reg1->u32_min_value == (u32)val)
+				reg1->u32_min_value++;
+			if (reg1->u32_max_value == (u32)val)
+				reg1->u32_max_value--;
+			if (reg1->s32_min_value == (s32)val)
+				reg1->s32_min_value++;
+			if (reg1->s32_max_value == (s32)val)
+				reg1->s32_max_value--;
+		} else {
+			if (reg1->umin_value == (u64)val)
+				reg1->umin_value++;
+			if (reg1->umax_value == (u64)val)
+				reg1->umax_value--;
+			if (reg1->smin_value == (s64)val)
+				reg1->smin_value++;
+			if (reg1->smax_value == (s64)val)
+				reg1->smax_value--;
+		}
 		break;
 	case BPF_JSET:
 		if (!is_reg_const(reg2, is_jmp32))
-- 
2.39.2



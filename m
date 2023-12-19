Return-Path: <linux-kselftest+bounces-2203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B667B8188E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 14:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BACA1F25577
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA227199D3;
	Tue, 19 Dec 2023 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ekt+mOwx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AD1C691;
	Tue, 19 Dec 2023 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-58d06bfadf8so3204351eaf.1;
        Tue, 19 Dec 2023 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702993838; x=1703598638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usqe+Dnt7wqkTAv1w+i37oHGNIidymGi/ajhqi81wDs=;
        b=Ekt+mOwx2YIqaeWMS2o7ss36Plg0HnvJFm16ItNRcKQzi2vkhchUAiUFe4cgxVygUU
         mQYG0hbEtbroMnLT3/GoZTcMg60sOMrgTEY2IdSWe/9/PMmz+3GpCcrWRZP06Nhhb6aK
         923scnfFW6i3NVli22ghU4xFRmVuUCcdaf4eko+ZI16BwYsCeXv0A/pCscuvOuNLSKWt
         NnXYL+J71BIOXLCUU7C0TImw62Inpwi5NHtggVN0GGvj/lptrr8h+DhS9bdBgLJUxmyW
         OfzbGJbfJ1PYQgPVXKM4WLqgK3HBbuCpPY35FAoOslA9rXVOLR86awGoGpDUwYmnUSpX
         uCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993838; x=1703598638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usqe+Dnt7wqkTAv1w+i37oHGNIidymGi/ajhqi81wDs=;
        b=qocvekmc1RsAacnwvFEhNBuukCz8xloHVA/PuD9h/dD1Cbt2Acowy1Pr9rU11rqDk6
         cCb8L7X9uUxycG/aXHvwZ1Sb7GWuf8Q3sCMGEbx2lLKkfMOOriV7s72DOSSKmoLZaV3G
         yhUf0107z6aBPK8d16ATZ0CLyDuL2wOj4N9zgIvigR2xuymTxXT9HKHh/SBRHUFu6Oau
         H5l+nmhyhEqb4ELNvgZ2l//ICgic+WV05GvMYsSPWIlaKPmh+zzwutOianLesnyt2tFx
         TuiAZML/Ajv4uXRJfNXjBV6fipUszAK+PCldSjKCSJIELtLyQeG3OGjY2XfA8zyNRztT
         b6yA==
X-Gm-Message-State: AOJu0YzJgGwpv6zJlJOIMUfSWE1Taz56hTDkR6RnoDIrswEI8VaqyHnd
	/JOjSf6yFIRojMl9yVKnGjcch6rbq7cuD3lx
X-Google-Smtp-Source: AGHT+IGKkUBS62W9CM+0RV4DUXjCcVH4YsHKzbLwJ6JiH9n0fTQ4izm7M1oO0YCSdNG/TmHOED5WqA==
X-Received: by 2002:a05:6358:2c93:b0:170:c991:d419 with SMTP id l19-20020a0563582c9300b00170c991d419mr20387683rwm.48.1702993838444;
        Tue, 19 Dec 2023 05:50:38 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d17-20020a056a00245100b006cddecbf432sm20695264pfj.96.2023.12.19.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 05:50:37 -0800 (PST)
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 0/4] bpf: support to track BPF_JNE
Date: Tue, 19 Dec 2023 21:47:56 +0800
Message-Id: <20231219134800.1550388-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the reg bounds is not handled for BPF_JNE case, which can cause
the failure of following case:

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

In the code above, "a > 0" will be compiled to "if a == 0 goto xxx". In
the TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

In the 1st patch, we reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg For BPF_JNE.

In the 2nd patch, we remove reduplicated s32 casting in "crafted_cases".

In the 3rd patch, we just activate the test case for this logic in
range_cond(), which is committed by Andrii in the
commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").

In the 4th patch, we convert the case above to a testcase and add it to
verifier_bounds.c.

Changes since v4:
- add the 2nd patch
- add "{U32, U32, {0, U32_MAX}, {U32_MAX, U32_MAX}}" that we missed in the
  3rd patch
- add some comments to the function that we add in the 4th patch
- add reg_not_equal_const() in the 4th patch

Changes since v3:
- do some adjustment to the crafted cases that we added in the 2nd patch
- add the 3rd patch

Changes since v2:
- fix a typo in the subject of the 1st patch
- add some comments to the 1st patch, as Eduard advised
- add some cases to the "crafted_cases"

Changes since v1:
- simplify the code in the 1st patch
- introduce the 2nd patch for the testing

Menglong Dong (4):
  bpf: make the verifier tracks the "not equal" for regs
  selftests/bpf: remove reduplicated s32 casting in "crafted_cases"
  selftests/bpf: activate the OP_NE logic in range_cond()
  selftests/bpf: add testcase to verifier_bounds.c for BPF_JNE

 kernel/bpf/verifier.c                         | 38 +++++++++++-
 .../selftests/bpf/prog_tests/reg_bounds.c     | 27 +++++---
 .../selftests/bpf/progs/verifier_bounds.c     | 62 +++++++++++++++++++
 3 files changed, 116 insertions(+), 11 deletions(-)

-- 
2.39.2



Return-Path: <linux-kselftest+bounces-37022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC7B00896
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A460B1CA0C17
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2832EFD9E;
	Thu, 10 Jul 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIUccdb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6492EFD96;
	Thu, 10 Jul 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164864; cv=none; b=d+Bms6AL6H/dnE8F9VdW6Pz5JDBDR2Uqksa7g3zL99MzCNm3pELhmu1r7U8IPQ0VllioA7lsro6PHJycXvikx8rvcJVHTSc/l656hie3iZrjfcBpza5IIrggVwDXAeRAOjloUDKUs5iAaQXdHRcHrkLAZcu4mxqWbIqkATPJPfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164864; c=relaxed/simple;
	bh=ZrIAEoctm9gHdT/HIzJ2Q0JmBR8njFd4t9SDxBMDRaE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnhp9EoRDUJ4GKzFe2SalMBl7fG2Ls2scrvigpKvUzleSvSczaRbx2LQoHWlE/6QcOI/HxulkizH7/gsVak0COdncWFHvc/BvANnO3CeM9zrsJgh1I+Z9bJW2njdo/RMQy5ysR4Vio4Le2X4xNaY3bzq8AaiQGvn/yjYyrAj4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIUccdb5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e81d37a7so827971b3a.1;
        Thu, 10 Jul 2025 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164863; x=1752769663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsT1QWK0CSRlLDCFnlQrt7zidjO2WK2kzsjSc6wbQJs=;
        b=HIUccdb5PyPR8WHgoJ4YD5aK2ab9wbDZHshboNQRcsop1vpZlVzRjIwb7OSIJEuxWA
         fb2WasaJLgBl+Sx2vt5pcB0q34UdwQg+qiYrM90p4R9FdBR/OkLsP7jtIxi1E2vmbPSy
         cYuaKPzcx7OYCvyWOn7g/4FJ6EXQd1woEdGpwCa1XdMPMYuobQQYMZl5LR/F6bCuvZ6v
         VnVTRsKEcJuBz0Dd0mYFmMeNMUYvXfi++rWEEnJos0/kkP/hew7IvgDsFBaaSfiH2yGT
         o5CrX9z1z1GVzTkeXs0MX85b2N79OWIVSoR4fd6Bb4fY77Nk0lwUb6SCfruhykbt1wSX
         uVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164863; x=1752769663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsT1QWK0CSRlLDCFnlQrt7zidjO2WK2kzsjSc6wbQJs=;
        b=tE6gX7PtEe/2K6+k0Fkw5RtxU5aBEMH0miINVMChGhYMjGOoBbfIdRdrwREHnG/Z6F
         OoJVKF5cLeYgSYbCfGMbjQcVLAT9cy/Ks07ufROB99LNztnCk4SyXun76bFCYsRLi0fD
         GY+CU0C5HN/nvpQM/ghPEU3r+teJXAVWIQQlYAj992akqVBJZt200xvvKKDG759vVORc
         5w9RDgnsDpXxTWWh8DeNIgSsakmH7/aA8Pz2f38EwmltYWx1TC+kNpVZN0VnXZnzOmtC
         wbFi5AamZ8974esL684uoJMih68Vsr13GUBHXnnrfFVNHn1ck2jM50YlPZUzeT6fIXg2
         EtSw==
X-Forwarded-Encrypted: i=1; AJvYcCWF9wwrgjBvIqOhv/A8VmT4u4LVcV6cuXHWZeFauUHhOGFDBsIyl4WVqUDyjbIIfqV2cTukGRgUjnTTfgvR@vger.kernel.org, AJvYcCWeTnRPf6hslexverE+or5uNMuZq0c585EZeKq37k2aOdP1NnA7rqCrTsL/6peSPn6zkJc=@vger.kernel.org, AJvYcCWkwEz9Wm5nHh3t+mALNeRS1kqHlKqPoBT/Y28m8nn3eXhv16aitD4baSM+5TmKpeWVWB09woEaWS4tOoCZH5RX@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzOBF3MwbPvUG0lCWgDDutBfw71xbF7vk8xFfGTk/B8veYD2g
	zJ2QMINwndAq8uk5Qci1YMpiWXp0C3D+7wLWobMcw9LKTKUOkZBAi6mR
X-Gm-Gg: ASbGncs0Qegl3ViSVsNn8C1YKu87TDruidf6as5jMIAO9L7T6F0cDFVcTwBOmm7H+lh
	hZbXGi1ovCCsqToHgLXIX2DgMzcH+69xnOGRzmaUjvCowoLTlMy6bbBqyl6uBkUtWsOPogivosh
	JAWzvvHbZ0XgIqObZ2KucxdEZ6ZjL5M4Q9N7FpONNa/odkq3yvXsxhmxFIqV1NA+Pik9SMLxe/s
	Q9h5s9MGUYrG0QYcfRqwoJKeIqFy0ABE1/5FzzEto+o1wW+GcQyGdIYF8McbhmdHDDTw77GHjJR
	ByxJtQ6dnmZA2mY6eWl5PzLqkuUIjbeHu3JDBbzpWvGeSk7rkwC/uFymlcfFGfI=
X-Google-Smtp-Source: AGHT+IGVSzmRnX4u8tRfnJEfDsYJujf1tU+AGw1Gw03GdPuHUSs4obV/uyGPejGQPPC721YcHcSJLQ==
X-Received: by 2002:a05:6a00:3982:b0:747:ab61:e4fa with SMTP id d2e1a72fcca58-74eb55b92cbmr6071913b3a.14.1752164862519;
        Thu, 10 Jul 2025 09:27:42 -0700 (PDT)
Received: from ubuntu2404.. ([60.176.129.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f25269sm2690418b3a.107.2025.07.10.09.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:42 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mannkafai@gmail.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/3] bpf: Show precise rejected function when attaching to __btf_id functions
Date: Fri, 11 Jul 2025 00:27:16 +0800
Message-ID: <20250710162717.3808020-3-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710162717.3808020-1-mannkafai@gmail.com>
References: <20250710162717.3808020-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Show the precise rejected function name when attaching tracing to
__btf_id functions.

$ ./fentry
libbpf: prog 'migrate_disable': BPF program load failed: -EINVAL
libbpf: prog 'migrate_disable': -- BEGIN PROG LOAD LOG --
Attaching tracing to __btf_id function 'migrate_disable' is rejected.

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 275d82fb1a1a..2779d63e1f8b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23938,6 +23938,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			return ret;
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
+		verbose(env, "Attaching tracing to __btf_id function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
-- 
2.43.0



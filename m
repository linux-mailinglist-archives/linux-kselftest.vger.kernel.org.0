Return-Path: <linux-kselftest+bounces-37630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EBCB0AFF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 14:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BF9E7AF6B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61228750B;
	Sat, 19 Jul 2025 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu2jgn2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37B28727C;
	Sat, 19 Jul 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928893; cv=none; b=GoPHeNloVngI8N9qPcxJ36y7KJiZMTEXDY/nKSqSND/VKibEgcTSFgY0GFI93BC6UYCG8X4buiLvI2weUwhUu3EQtQeLI/UsLDTqjXT3XqbhDXxMxoUi+69cL3W7ubyoR88mdougU+EDrKsPvPq8a0JfKRxe3WmY+BvbdeNgnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928893; c=relaxed/simple;
	bh=c2iSIbfl72/PE02qKxd2sEEW21TnRnWXjbbFM17kfms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ot/btKyy+1j8P57Z4X7+9Vl8IMDgNiV3tyga0IPSzdSe2oqaFGjTtOo4TU/voPOpVulwGx80kmHdu8Smhuz1rH2VlULnxiqmJQrrBEmTV8Y3e9WH43t0wUM9Hf9YqhFgPIT44z2XarfYe2fv49LtALdpOsGDmph3fy3aHGCUaKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu2jgn2o; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23dea2e01e4so33464695ad.1;
        Sat, 19 Jul 2025 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928890; x=1753533690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIHT2GA2kDyoylsiQ8nvqXzmOHbU+XNDhQ170RsJnPQ=;
        b=Uu2jgn2oHsfaBt0M4bsQpwhjWiTMUGekGt184AlOmuqwk1xtbSfEPtG7Mc+zKxUuS1
         jD6KfaqZsSan05qOKwtRtop6xk9v5T+Kr3MlnDf2A8D4423SsCsbduLmhAM3N0elRaVz
         KSt5RoXtNsEdMM7pIxdR3wkpi68NwdrDEoSXCxn3GYQNqTvkkLuBEKxCur5Hu3195SkS
         3F7xNQnXgjAYwX08Y9y4yfTIhDEem5yI+BJf2umR+qcFnN3LQ3lJ37Vh/g+RttHw2PHq
         rhebuTQa0O25Fyltixx8vtVdFNB8zFaY8qz5qabHT6kkySbWaHzAcpZnH66X4viJLPVs
         V4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928890; x=1753533690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIHT2GA2kDyoylsiQ8nvqXzmOHbU+XNDhQ170RsJnPQ=;
        b=bvUNU+dbhZpExqtftDUpevZb3z9c/Z2JpV7coWEnw0fvVicTR4Kgb70LYODWrcStlL
         JnKFT8OLSI0uv4rig3wpdYUTR6esB8cx43auDtSh/Ty0hgGym9n8iRc5iJh4cgEG7PSB
         ff5rCT46Vhti/sUlosGbCGqpBoJGlxjvD3F0LHWBAz7CAW3cuQekPTXQXyXLvCUh+sC4
         AwNhgG2+Om4tQZL1dxtTQQ52/wA0FJxiT6H9Xgl8uwlWhB1Yd5wchKxJ4q2wkir0BiD+
         L+X1czKkzawTIFJOtQPkR5trOs68FHu6bPsABh81Wlxca2lxv2LOSTiuFsD4/gPGyF8o
         zY4A==
X-Forwarded-Encrypted: i=1; AJvYcCWBsPXfRGSyVHKEReTWsu//V0uqw6HBmhdYz8aEOvcYfaNf+X9eGHYf+o89JP95sa+fe0MX5L7e1YSHJfnyyoY8@vger.kernel.org, AJvYcCXoy+EcEAqt2gCwtGhm+7SA5iidAxPfKpT9YSE3rSoOpKI+WiqSWCZgFaK1v43ZCtAmoSFA67yfX/J4u+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhW4Mt6qB+WZn86roB8yJMOFUItydPSUANGMP528vsca8LbXfL
	rYlWOzC4mcBCLWOLqT/VHNOCnUGs3f7YfvO9RYypJiIJKMA4KkMJ3L3ttn1c+zf99y4=
X-Gm-Gg: ASbGncsKuhjW1LhK5IofQXEId4P6BHRMDnLfYmMeqvcbE0utwpKRxroTtTxox3F/xq8
	FhRNwcizl/6+ojA3qi64PVy7eHcRJa9KaL4O4QF7GmAz/4CNFR7gn48ap+T3x3t1WuY6dNAlYBf
	AveUpiEJYJGnAoBbcoa90fvktiNw3tJOgVYfbC+UJD5iWT1cg+oB2CtPN0PFU+GYGgpha14Qs9F
	hkVDjSFaNb1erFhpkLvhMtJJGeEQlGP7K8JgEp+ah4K6lv/QuadpiHZnp4/aZBuTC+yrNaRbkgc
	n7QiJxnCBF1ATZymYPsz3DdXnkQoSodhqmmd4t96GIFkGsu/BapcZRfDawSb//ms0Ar5nE+nDyV
	p9G/lMqH7gyvDhDQTm6ld
X-Google-Smtp-Source: AGHT+IHmWzP4qHL8HHeUF5zabvd4mp7Mre9Z4c1DKtQc7Vq9EXdklqQyWOXFedxOML7UbBYwG5j3iA==
X-Received: by 2002:a17:903:944:b0:235:eb8b:9968 with SMTP id d9443c01a7336-23e257437ecmr163886875ad.36.1752928890001;
        Sat, 19 Jul 2025 05:41:30 -0700 (PDT)
Received: from [0.0.5.57] ([136.159.213.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4b36sm28630285ad.92.2025.07.19.05.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:41:29 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
Date: Sat, 19 Jul 2025 06:41:25 -0600
Subject: [PATCH RFC 2/3] selftests/landlock: add cross-domain variants
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-landlock_abstractions-v1-2-2c4fd61f8973@gmail.com>
References: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
In-Reply-To: <20250719-landlock_abstractions-v1-0-2c4fd61f8973@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abhinav Saxena <xandfury@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752928886; l=3000;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=c2iSIbfl72/PE02qKxd2sEEW21TnRnWXjbbFM17kfms=;
 b=AG1PkSmxesoDAXXR54orzBnHfJrxDfASpS3LQ+PFVWCcUWnpup/4+AddHt0UO1Gn4lcUXj4dj
 wd8t5Ina6bjAQt28O+BxACTRKI30wLf9pOO6oF4pltwfKOvn2yz+5al
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=

Add scoped_cross_domain_variants.h providing shared test variants for
interactions between two independent Landlock domains. Current tests
only cover hierarchical (parent-child) relationships but miss the
case where unrelated processes establish peer domains.

The header defines four canonical variants:
  - none_to_none: both processes unrestricted
  - none_to_scoped: only accessor process scoped
  - scoped_to_none: only resource process scoped
  - scoped_to_scoped: both processes scoped (peer domains)

This abstraction will be shared across signal, abstract UNIX socket,
and future scope types (like memfd execution) to ensure comprehensive
cross-domain test coverage.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../landlock/scoped_cross_domain_variants.h        | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_cross_domain_variants.h b/tools/testing/selftests/landlock/scoped_cross_domain_variants.h
new file mode 100644
index 000000000000..6068987a52c8
--- /dev/null
+++ b/tools/testing/selftests/landlock/scoped_cross_domain_variants.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock self-tests - cross-domain scope variants
+ *
+ * Provides one FIXTURE_VARIANT and the four canonical combinations
+ * (none->none, none->scoped, scoped->none, scoped->scoped). Every test that
+ * checks interactions between two independently created domains
+ * includes this header and iterates over the variants.
+ *
+ * Variant structure: which domain each side of the interaction lives in.
+ *   resource_domain  - process that creates/owns the resource
+ *   accessor_domain  - process that uses the resource
+ *
+ * Copyright © 2025 Abhinav Saxena <xandfury@gmail.com>
+ *
+ */
+
+FIXTURE_VARIANT(cross_domain_scope)
+{
+	enum sandbox_type resource_domain;
+	enum sandbox_type accessor_domain;
+};
+
+/* Four concrete combinations */
+FIXTURE_VARIANT_ADD(cross_domain_scope, none_to_none) {
+	.resource_domain = NO_SANDBOX,
+	.accessor_domain = NO_SANDBOX,
+};
+
+FIXTURE_VARIANT_ADD(cross_domain_scope, none_to_scoped) {
+	.resource_domain = NO_SANDBOX,
+	.accessor_domain = SCOPE_SANDBOX,
+};
+
+FIXTURE_VARIANT_ADD(cross_domain_scope, scoped_to_none) {
+	.resource_domain = SCOPE_SANDBOX,
+	.accessor_domain = NO_SANDBOX,
+};
+
+FIXTURE_VARIANT_ADD(cross_domain_scope, scoped_to_scoped) {
+	.resource_domain = SCOPE_SANDBOX,
+	.accessor_domain = SCOPE_SANDBOX,
+};
+
+/*
+ * Mapping reminder:
+ *   SIGNAL               resource = receiver    accessor = sender
+ *   ABSTRACT UNIX        resource = server      accessor = client
+ *   future scopes        resource = creator     accessor = user
+ *
+ * Only the accessor domain is enforced; tests therefore expect:
+ *   accessor NO_SANDBOX      -> ALLOW operation
+ *   accessor SCOPE_SANDBOX   -> DENY if resource is outside its domain
+ */

-- 
2.43.0



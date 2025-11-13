Return-Path: <linux-kselftest+bounces-45540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A813C57775
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 13:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 866CB4E6C44
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED5334FF55;
	Thu, 13 Nov 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM28zDVD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4EC34F24A
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037630; cv=none; b=nvijvJuzbyZ0mkJI9Xw0peloYzN6mhTe2rjrEJ/f3X6ZXMdpp8dP//A+gJOfDSTOkCbq4OcmLPOehhQMUt2VkvldqMiJrom2Fh/rF4xKqO4hfeGnnwGNSuMUPxooMIZnd8XIf4r+2qYYl5fETTAEGz579krhlFe6h8dyrr8N8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037630; c=relaxed/simple;
	bh=ZDIjKrxNRsNKjDHyHEBYoPmLkLVi1miMphnKseqdm2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRemEy9qbq8xXTilWwCv99Ojm9G7x/Dzi5IDYSu5kFtS3RftLqsXjmMWFCwO8mBsMuzGED41eymd3lAHdhOn9or+TwSSSsIMu0ErKUSIFkOLUPwvgCWYFf80licmiwLcliQIvDGkqdNRcliWI/JCdj4Bt4UmrXP8mWwzKCPu89k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM28zDVD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c4c65485so680643f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037627; x=1763642427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=PM28zDVDce/GS0oF5Z085lkACZLsnDDdLwESuUTD4Pl3O2qB4z06jXIZd8aT0OVH5t
         7pl06Je3UXw6k7hqGunUJvNBMKrLWjZThhX7Y/1wVDp2AbOKMr+SLFYd4y2jvfatkmVk
         bOJgo2p+S+LEwhNkclVUmAAk5LrCeYeqvL1GpQTVcBKsBiW3+af/KjsUZpKYhc1U7ARE
         DjQ8I/6lt8tXTJT0u9INEEEvl7wwbpQBefvfhD5i541ytYq6nLVPt7HW2ScbweCrLwBy
         R4PTlDTYWgJ1y7RalE5S6UkwsJ4GvrTkIvCDwtE3J9PBELEf7DmSc95Kr65d3iqFn2XM
         qlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037627; x=1763642427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=Hgqs0XS4KxRcYXhaku3pgcYl0tGqRkSXkUwD6w2L6BgKIZ2dY+v00M53TIThkZgQU9
         h0/oY2vnIRPh3mGktVfyeLCDeaSWKXGlQAIlQc593303U887AyTu+3EUpzlsb2UVEPyV
         YFhF6j9uH6x89fwgSnz+rSCtdtLTJmT78vWG47le5EtL891JQUcEwib3BZScqsmg6b0q
         m46jEVAaUOvtP8WuQNia2rdeTbRsfHQsTZCk9Vv0y3zEo4YD1IxVXRWfsx0tkQKGVHkr
         +EZWaeB97qBkqbE8vOrffF549KI/55BkJzCFw9U3EuW1+ORJDT5QtaogjoebZMKqxhvk
         QTKw==
X-Forwarded-Encrypted: i=1; AJvYcCV19AQL1iav0BxQHwLoUxau2VdtHYrCivcSLo/3QVfKt4LVbLtnjmwbpVyPZM6hkYLHku0qO8+fQmRKZ302BUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZY+DoY8jNB62lECWvar0Pl13v8N0MW60i/dNAdmln/wDvxedb
	+JOZN3pQJKsXLB0a8VQGptxhpWYfXbA5Y7J4k5mi+wHy/WxxwMhmun2I
X-Gm-Gg: ASbGncv2QgS03bZ4Fp3upx35LFFh6KLi+BQrvugGZIrUrYKvN3VTmhket6epzI0CAmV
	J6cKHYP4BKITIyib/uIOYl9t5W5thraTyAwMkcBu1wdP4hi/DBPIP1WXfgRAw4Em6RBwhkj9Vx9
	Wf0/oTDiUxJy9jHczJI9g5AgwnlW14Krq3GqOMbHZ2/qvOreLOdoS2WIS07oI7y2UCl7nP5VHyZ
	2h7Mlntu8PpSUmTB6DI0aydhXn9dqkQCIq/Mu1HIZ2j0IaroBx8hO5XzFpunHC+RP1pxj3lgVfq
	c/RS+911z7wBEV1aD+2K2Lv2XXRBZ26Dv4qZr8UJKnPru5wMH2B70Qf/LZVQUZJ/ywSJcluIprh
	la93HDkRRYCG4VKLd8NibKQlWFIih93Ybf7/xC1uD3wZ39bBvzTW/OKUvH8/mzPrPLaLZaLB/FY
	Y6wUcI9hJ4k9mdq0mb7XvWV3Y=
X-Google-Smtp-Source: AGHT+IFMEpMMezmvxEMs766MRgjBKcLvtdSkSskQxUa3/4U12S0a20TELgCjrLTK7nBypapkTU9dgQ==
X-Received: by 2002:a05:6000:2f86:b0:42b:43b4:2870 with SMTP id ffacd0b85a97d-42b4bb91d32mr6647570f8f.26.1763037627088;
        Thu, 13 Nov 2025 04:40:27 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b62dsm3697140f8f.24.2025.11.13.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:40:26 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v4 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Thu, 13 Nov 2025 13:39:51 +0100
Message-ID: <9fac2f744089f6090257d4c881914b79f6cd6c6a.1763037045.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several ./test_progs tests:
    1.  btf/dedup:recursive typedef ensures that deduplication no
	longer fails on recursive typedefs.
    2.  btf/dedup:typedef ensures that typedefs are deduplicated correctly
	just as they were before this patch.

Signed-off-by: Paul Houssel <paul.houssel@orange.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..054ecb6b1e9f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7495,6 +7495,71 @@ static struct btf_dedup_test dedup_tests[] = {
 		BTF_STR_SEC("\0t\0m1\0m2\0tag1\0tag2\0tag3"),
 	},
 },
+{
+	.descr = "dedup: recursive typedef",
+	/*
+	 * This test simulates a recursive typedef, which in GO is defined as such:
+	 *
+	 *   type Foo func() Foo
+	 *
+	 * In BTF terms, this is represented as a TYPEDEF referencing
+	 * a FUNC_PROTO that returns the same TYPEDEF.
+	 */
+	.input = {
+		.raw_types = {
+			/*
+			 * [1] typedef Foo -> func() Foo
+			 * [2] func_proto() -> Foo
+			 * [3] typedef Foo -> func() Foo
+			 * [4] func_proto() -> Foo
+			 */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 4),	/* [3] */
+			BTF_FUNC_PROTO_ENC(3, 0),		/* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0Foo"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0Foo"),
+	},
+},
+{
+	.descr = "dedup: typedef",
+    /*
+     * // CU 1:
+     * typedef int foo;
+     *
+     * // CU 2:
+     * typedef int foo;
+     */
+	.input = {
+		.raw_types = {
+			/* CU 1 */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			/* CU 2 */
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [3] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 3),		/* [4] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo"),
+	},
+	.expect = {
+		.raw_types = {
+			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 1),		/* [2] */
+			BTF_END_RAW,
+		},
+		BTF_STR_SEC("\0foo"),
+	},
+},
 {
 	.descr = "dedup: typedef tags",
 	.input = {
-- 
2.51.0



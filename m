Return-Path: <linux-kselftest+bounces-45531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B2C57230
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FC13BA6EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FCE33BBB5;
	Thu, 13 Nov 2025 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekL7KdFa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA633BBAB
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032518; cv=none; b=SRktUGRhBBccIaStUiDwLNzRe8jDkXaik7iowDtU3x6fVc6m8LmlVml9C4Aqf3QIaeHcI71bAxxY1ogqNXm9KPjb8+q6fwUUqnNlGEXqbSiAmKr2Ohf4CbiRVQm6pR/oW5ouWsdygH9Yc1NIdkppDOcTltQj8T5cAx2WIhnYtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032518; c=relaxed/simple;
	bh=ZDIjKrxNRsNKjDHyHEBYoPmLkLVi1miMphnKseqdm2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFQn66r2l+0NuNvaC6cLFd8nyn6txhTMJkRkY3UTznEM1ih+Rwq6oP1ANxzWYE/ykw28dpcbIuz3j2Qbm99vsBR8se7LTwcXtlFXAupnYWpC4KFtbzms84RgizaooOcmrkINPC3Mhq20xUlnOdNtF16xc1x6DUMh4ac9fP47yoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekL7KdFa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4774f41628bso9530785e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032515; x=1763637315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=ekL7KdFacIWNCU+Z7idSzNL5LXSB0isrLFrrCBfQoBIp9HIr6hcNxzf4TM29pfhvei
         IAB4tfNEYTqtYmURIMYZ2HmYFiGVzhaIp6owckjsGs/RRPkdGDYXwdOgC29BDDBqql7X
         Csft1dSvkN3q7siWtYZ7ZrSco2mtoS0knTnMLlvBCu5HUu849q9PzLWKGRdLtJUB00n/
         PKD/NGskl3JaPeBqVH5ROVBFEgy/xIB/4wrvP8YaguHq2Ag2qmggEYFEo1q3ETsxQxdU
         ViyPNDHlqJRUz7PasJ0uPaiR3o8tWeN2FkTCJ98GQEsAyyM3FXmceop/ZFXk6Q2ei/dm
         TWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032515; x=1763637315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MO9XnnVHj/rspITKiAGHVAzlJx09tqhwIOhjHMpSEAU=;
        b=G9i4Dc4pLUz/Rb8X8TXLFOpiiFgMnaMreRMp4k9M10fKVOhjAyuVnxJRAJ1Qba8Xgm
         MU+DWt7MMn9hQ8tF9a4qNDRzKk0R4WmSmkl2IKg/bakgSiMeOBqvY417V5IDo1tfVVl4
         XTUmN9HnfrcueE69w1iEH4oEuVeVD1lJC6z0p/qCrn6zuoBU6zGtW6yh8xbkoUVmnIJA
         qc8RSTEpX4XjM+h/rGvIDbl2PosK/AvHRTttBh0BlJ+yqSQZbCXlqwU6uMeSjUkmpJKV
         8gBOBYelaRZq0EcV3YhDlYifMXp+vDVVbgcty9bdRZ5DE3t+ITe9/Q4sTFhmndST+fD4
         PFdA==
X-Forwarded-Encrypted: i=1; AJvYcCW8y1c3va7ed9XGtGwo0rHxRZB/Q9DHl91YTOjxvIyk2/i3hwtO8CxDtSeh4WIiYDYvleLV0nO0wnXtP5UTeUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAk5Nlr/iZxJoo1GLsaykjP46/+EWPMq3cjG3jOv2D1LT9kdY3
	jsJRddfDv88s4frC5i5yiIMVi6f4UdeQpM6pSAyZcwSDnstzXGC/3N3x
X-Gm-Gg: ASbGnctYFpnmnzJA+U2JnK5PtiWUhGhtUMmZDkYlgpPYYVJcQagg6efS/JF4VDJfb+A
	Jm/DpWg2Q4uMeL6gwUxqbHDHRw4n74122zcAi5mcS+WF0wWYQPa3dnaaXG4wi8rwvI9bI9Pja8/
	KzGqCNuccB+bCG9c5x63NV6ILI9nGbT/XtRdZM8CbdtrlYoRVB9JFM2FlJ5AzAAiIkAT6Av8elg
	x6SaiMnwUZ2zN4JkQJxp83gVwhsP032yzK8rt4heujL52VCWH8F8Vo11ZYZUQ0+R+8oxbUfZEiF
	J/RsaOkuF0kfUeAvHz9+YhT7xdGe3w0ZpbPCnDl7CQ17n3xFovYCklcZrci1SPw5eXHRFv23mCc
	3ENj5iZGCC/UXBarR3jAH+HdxmEydRKdLG3ZkBX56q4a/J3PdjEd8/ecIFxkpKGHtEAcMxAgcey
	K4yPhlczmGW+zi
X-Google-Smtp-Source: AGHT+IEXbGLWZEjRrYrXvD5qQyxHy/qVaSW5hVRb4W7YjSQHnlUr1eV81RIDEqWn4jjaLy1xF5bxNA==
X-Received: by 2002:a05:600c:285:b0:477:3fcf:368c with SMTP id 5b1f17b1804b1-4778bcdb884mr18553865e9.9.1763032515217;
        Thu, 13 Nov 2025 03:15:15 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bcfa2e9sm17739825e9.12.2025.11.13.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:15:14 -0800 (PST)
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
Subject: [PATCH v3 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Thu, 13 Nov 2025 12:14:06 +0100
Message-ID: <6aa4391604ee79ee7c9805906a7340ce60ff8a0c.1763024337.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763024337.git.paul.houssel@orange.com>
References: <cover.1763024337.git.paul.houssel@orange.com>
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



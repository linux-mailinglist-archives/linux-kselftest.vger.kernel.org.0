Return-Path: <linux-kselftest+bounces-45411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B624C52BC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A598E424085
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25D5279324;
	Wed, 12 Nov 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5w+yE4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D126B2D3
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956780; cv=none; b=rdEmzppQ4F2hQXCemQ/lbhbjLfTDBWl5ppMoIFfmL9wus5SLdiTIYjqVugHGR3I1sysTbx8Vq8yXM+kw34mbqVN1PT8CuzoO0mrMGyM5L5HkkHr5kh2SoF/HCZ+gvCIcqYyYybDEFvAg5QrIEUZw89Jh8hW/hsoS6LHL/aq6Pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956780; c=relaxed/simple;
	bh=pVP2OILUU+1rzWIBbsAl/6YtKwi9rPRCel6NowAfs78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuPG5hYh5W3lBAPyD9ZjClv7m7RRybukunWkFl/I5YPmrGcck2aDef2z+C85W/1QFn2KKHQGa2STL80ZteyUxqs6BxqJaaprG2A+kGQwpY9NXqGSuqGEdmG/8Ws9m4jrTnv13Dpov4vxqRHx/GVHuFjlrkFiko7sizF/uHtfXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5w+yE4d; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so528332f8f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956777; x=1763561577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/iGYxZtLORX3ELbLt9jFe4ep67d1sKTixtTlZRLqY0=;
        b=T5w+yE4dv6WzPr49oYvFbx6sySmsxGSB3B0Qbk4nQ2iXQcTVwvIyzXUoisE+/TLziq
         TJVaIpGg2MbmfBQe30SmDez0fy42VSR8vs0HewNTfCLOh5eigM301YfCkS2UeG204nu2
         06weNRsHhJ7lOHlcdEWPg/rF7BbGfX7y8t3UxipFzhB4UsvlYcQwLfP8ZRpyNaJ1GLVZ
         I7NgmN0W9ZyzMfChyFfVqFdgvcdHYNj0KBhKw1xXfFAOMDeOqGmBQQW/6PQChHxtgVEp
         wC51XPZ7P9xdRJ321g9P8g/VhRB6EcfCs+OuWSO+HZU8newRbhtALUAxQuCVR+DAYWK6
         T4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956777; x=1763561577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/iGYxZtLORX3ELbLt9jFe4ep67d1sKTixtTlZRLqY0=;
        b=uVyKbTgOmjrGLDJnNLBAyxBGwuT8KEhFH27Ps47yzlfnFbDoDQR1Vstxe7qbebQ0X8
         7F7sIs0wSpfmL60RC/cY5VN9vaJWoVd3wNLRPrxlzl7FZI/rM2qEwYhSO/6glkEfQ/dW
         k54c9Fdd1P93SQcQstgIfZCrOMhm54GkVChaBZF8B6PHzcMGmkNSc7kEflncSb/nj3MH
         KtXodERAq2dVOsaa3acCDfrKKJqyQrSplhghsZttyXOE456EpOq5Q13euqMnByBnd2+l
         vrZumShs18Dq1C6kKTEXoixA/J2hGvWwIjgQEZls7NuGbsRFFGo+FLIcuktiySmgxKhg
         AvFw==
X-Forwarded-Encrypted: i=1; AJvYcCU37XQ5DIgTBKLBbaBuGsyx92hkbEdTBrUMFAQSzdRn9ms/41SfkxDAKNGZjptmRKmlTOcP4J+zaMi5/u6PGXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmUy7boCkpeEJ6pQo/j7Ri1+6zCCm1vkmjHwFEbIQzpoCASmT
	UYOe9libJrlgaNWFORQByvNTzeED8On0KDTGaY0Tqzyo1WJn5QBDoa2T
X-Gm-Gg: ASbGncvnwFxSh+Z3haX0xiOPKxPbj269l8eWWkxNM9uM6btIEEpaHV82S6v4pU4v1xX
	6Drob8pFmEd01yp8gkKd7f0j7P4MU1QwPFcxGGRj80ePK8xydwBJvur132NAeVhThp0wq37G867
	UWQdTsp0iN7yBnnr5NcYoNliPot6jDJJLslbrdZAoJunonMG/YKr6rRqwVWNmPd47R3jEWsMFPL
	SkkSZb1V7LWjWpwQFmysvZLf2X5vV/NyEOa8+tspdjlDGgaDgo7toeqQIyDNM6oTBTgW+uMNzX1
	w+ciBJr4t+SsMhLmW+dHRz4tKHZ3Y+1kWKla3g8K3vZPyJCQTVTJlQP4LXtau7tDt0QQZabg+LO
	algkkxZroH/AAiqlLJabYrS/7KkhldHKZWZzQi4Jn4B5cLwHwxGrO+wXEQgIP6YS/kGtbrLNIjp
	jd0UmbyOov/ZLV
X-Google-Smtp-Source: AGHT+IGYNoOTXnre/4ceRR7yKQ/OoOBBVZ7Ao+Bo2jO9uF7B6Yz0Tq6gekxjquRjIP2nqgGKT+RdVQ==
X-Received: by 2002:a05:6000:4210:b0:429:d66b:508f with SMTP id ffacd0b85a97d-42b4bdb03a9mr2990959f8f.30.1762956777196;
        Wed, 12 Nov 2025 06:12:57 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm28303603f8f.2.2025.11.12.06.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:12:56 -0800 (PST)
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
Subject: [PATCH v2 2/2] selftests/bpf: add BTF dedup tests for recursive typedef definitions
Date: Wed, 12 Nov 2025 15:11:34 +0100
Message-ID: <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762956564.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
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
 tools/testing/selftests/bpf/prog_tests/btf.c | 61 ++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 8a9ba4292109..a19db159475a 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7495,6 +7495,67 @@ static struct btf_dedup_test dedup_tests[] = {
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
+			 */
+			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
+			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
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



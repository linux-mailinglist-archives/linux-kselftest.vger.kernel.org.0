Return-Path: <linux-kselftest+bounces-16889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A47966F7B
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 07:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53A8B2210A
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 05:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9928413B58B;
	Sat, 31 Aug 2024 05:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRNzVlSr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBA2E405;
	Sat, 31 Aug 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083271; cv=none; b=p5kkgDgnipu/DRtjkBdvj8tSgKEir476aXheJR2bAYG143z1hTEFiBeakahqEg7TMUF9JgdC0DsjAvfAl8vA0iddm4opkzxgdP2qcfcIj0drCDc0y7X9+sWnCTxn53IIMMds9x4ekO+1GWpIqRVow7hv1j12oAgWHirFz/gr9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083271; c=relaxed/simple;
	bh=cV8GigBqJzTIQ/oFjGK4Y5hHeBbGDREvYmt5NzuQCEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8c7DBqX+3a7KbXJ5P3u/9x110464tV0hbVrfU9/3XOoQtxAXzNYl0eP0SnQMM8C43Y66G6TQ0FJcvpZCzgSG814YmUU0skt4YScPRK54Y/nPO4ez2F+cUSXJ/xt3m1knbSP5qNNdksZmdyQCXT6Yt04f90yaUgIaHjHDdiidjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRNzVlSr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71744362c22so43981b3a.2;
        Fri, 30 Aug 2024 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083269; x=1725688069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ckgtpxhKEUT5nAj96jMRuGhhWodTxLNrAvXaIKOqCk=;
        b=XRNzVlSrqWc2RoP0C0WlpBt7P/lAxyJXnrsBR3zWy3eVXAuQWqon0vlj6OlBWVzVUg
         23beQa4ADGOrOZ9fn36mxXY0tQssXaO7yCDqoDFrUjp6WaRNsIF3xrHlCAdbgtgC+QGx
         0MEyi8VLStzuYIoSZzSN4aUOKkjNlzcaO4S+F0AuRDcAb0NoaVFhQHV2CNNG5XqZ0wZw
         DH2ycOejZdwQtHt36kJn9TcWJcvUxM3KMoXVXQ3PyW0FhguHrHxEpTuxXni9ngr2lYM+
         5eeeqQtPxB2RhI4bjZLIAZs+Gkd/3t8RjdP1kF25821fySreVNm4aPHwKrlcacUsXFja
         sEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083269; x=1725688069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ckgtpxhKEUT5nAj96jMRuGhhWodTxLNrAvXaIKOqCk=;
        b=jer/iUCoGlu7KzRwnYAIq3ttmwRgMHHzZIlpbI+xR82i+M8qNDF8XvcBVlYKXbnUqz
         WjqRNMZKpYnCQtN1cUrz2MiQkAC2wc+4m7oRY8ChDILf/joW6D7lljTs2WmVluO9yAEt
         zCowaoAKnCciwzQRGU75VeBPV9ZhewcUIejMzRMftoRdEAJU+9P34DFNLdHj4Nbq8ET/
         gwQI6o6j6VcQfAh6eSeM9lLTMyvEoikztrt1fFDHuV6NnMifY5XQQhEkqwgM2R7ztNwg
         781XVSdP8C2cNdVMd4eB6z3egN2zyiyNzXJ7M5uXXZDZQWV/dUQtNeTY//aIn5DDpZK4
         EyTg==
X-Forwarded-Encrypted: i=1; AJvYcCV0BCTqxaJf6YP2ojUTyvwh9TLzNwbPGpFbg37r+NbEpEf09GOv4KxAS/sV3XyAFs3cmB2s9XE7cHnyhgXCvdj4@vger.kernel.org, AJvYcCWImEreNJgtmG0OVtLYdTI0Z90GwjN/hBrNgA3QdZkiJOFURS58EfcHv7WZJuFMOZRt/hYe2yytu6dbaXbJ@vger.kernel.org, AJvYcCWK+oVMifu0+5FivpPQzLWfmk8/chYn0r4621IO5wnD4hqOpOe0PArztGvwwvflStcHGZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQWX+gs1XVw+oAceW0eo7JVAWO1NNqZcltC+5hvXrJfv9EjmZ
	L12SrWzdBgVxBYwOMh42oh2amYl8E2eK6VgUMM5uogZdnLVWPzPM
X-Google-Smtp-Source: AGHT+IG/WCbMFojSxC3xOhkFsA9bL6w0IdupUHCplkiRyaZ3b3v1SNYwCg4ej3GSmj239JffaDPiYw==
X-Received: by 2002:a05:6a21:9101:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1cce10979f6mr7242647637.38.1725083269352;
        Fri, 30 Aug 2024 22:47:49 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051553442esm34843105ad.135.2024.08.30.22.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:47:49 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	aha310510@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf,v2,2/2] selftest/bpf : Add a selftest test case to check for incorrect names
Date: Sat, 31 Aug 2024 14:47:42 +0900
Message-Id: <20240831054742.364585-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831054525.364353-1-aha310510@gmail.com>
References: <20240831054525.364353-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftest for cases where btf_name_valid_section() does not properly 
check for certain types of names.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 00965a6e83bb..61de88cf4ad0 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -3550,6 +3550,40 @@ static struct btf_raw_test raw_tests[] = {
 	},
 	BTF_STR_SEC("\0x\0?.foo bar:buz"),
 },
+{
+	.descr = "datasec: name with non-printable first char not is ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC ?.data */                            /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0\7foo"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
+{
+	.descr = "datasec: name '\\0' is not ok",
+	.raw_types = {
+		/* int */
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),  /* [1] */
+		/* VAR x */                                     /* [2] */
+		BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
+		BTF_VAR_STATIC,
+		/* DATASEC \0 */                                /* [3] */
+		BTF_TYPE_ENC(3, BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1), 4),
+		BTF_VAR_SECINFO_ENC(2, 0, 4),
+		BTF_END_RAW,
+	},
+	BTF_STR_SEC("\0x\0"),
+	.err_str = "Invalid name",
+	.btf_load_err = true,
+},
 {
 	.descr = "type name '?foo' is not ok",
 	.raw_types = {
--


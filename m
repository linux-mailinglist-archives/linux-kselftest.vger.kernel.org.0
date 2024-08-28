Return-Path: <linux-kselftest+bounces-16526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00182962590
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3301D1C21A05
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926A16C874;
	Wed, 28 Aug 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhPraint"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38913D53D;
	Wed, 28 Aug 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843544; cv=none; b=K5G9bzh/aoKiV0VhCbrQOuTFyLI80xrOTvyPXuDMY/0pZHYYx6eTdTXi6t+g5YlQn4apg28KLS7bfoolun+AotyhE+GnoNQ/HDOB4Alon/fiTXGlE1yBuotGnss2BtVxmLPCUG2YX6Sz0wp81/pZZofR2fJIM01AoH1YwwXADkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843544; c=relaxed/simple;
	bh=UJoIZbAwd0dcyPldGPlUH3SNsQcKTlS8LGIL6P+fhDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+6sYHIDrurNNdei0lJxnGyyA5Xr9n6MOQzi3DV10MK6Pu2LXnjWRgpee1t8DmCgseqJ6oJXYa7PQ2nzzcjsMa7uFsKHI/mik0YCRxu8s0qvqrLa6f4PzJGD3dvex+iTPk0zMPsz4SZaSQ87Iiqxgoxfsr6GGEglfzodcVQgYYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhPraint; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202089e57d8so3323795ad.0;
        Wed, 28 Aug 2024 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843542; x=1725448342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=AhPraintUZlmgQoYKncsG0/yWLtft5BgJH6IpCJbyGRBY1YRV4991J8eBTz295j4iK
         7nKUsxbZkhwi21hQkeLAzkw7LqByf3BpNqEGVpozKrh4ab5kZRkDVAyyrMNKdzIysXGY
         pfD0DJPQw8HUPBrYQN1+puSu+2k/7hSskW+7WLla9i6UKlc5kLWctyMDZg3nkLU60C8D
         K6NOyflLoSsZZxj9c4TFt17m42tZB2bB0xAooZ/m00OgzREQBt64XrV0DMpIL/I4Tt2+
         men/YXTn1v2v1SlIBSzXyuRX8fE2KtItKW4umiQUfbJTOFR3sD3L3jdPXL9Dj4t/kqKa
         yksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843542; x=1725448342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=aBfwRmvrSK1xNWH4lcJCEumVcMq5zcX9wKtcPwIpp/Vz1zooP5WaYqdxTAiApmJcOf
         kEE/m/OPg793oDZZB7OFps8s5b3WhKqK9TWmPZuKXbCrby6ToATjmbx+K3aZoGPc8MYK
         anp7f3MI5OU1dcUkpcr63/o/jlRXpITQM5KYYlk4pq6f/XmcgxmpssrQBVyGJWeZRV5B
         SnRli9ZcHu7xvyLGzfW0Ushap6Vqyqiqnf98G87ySVA4TiQFlQg2mhmxwq9e6PkM7A8I
         zAJHWoLTVjVFz6X7TntTU0SLtgVRb4MjY9bVLj5WjrjPsZ+SJMBNeGjg1GkRUi2LRzSY
         EcZA==
X-Forwarded-Encrypted: i=1; AJvYcCXqK8jGiPzbvzDR+qD5DLDvuKZ9Z+888GQFa+n63rofW5jMJaTpMMRlfPVz98cRhDtXSizP+Yhh5clMmjcxmqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlSrSeQhGtAxC+XrOZJ7gMdfECDkd128df0/wrruUlY7xznMx
	KmUFn3GwgHcz+B6U5G817nrZRB/TH+vlGv1wwUfcOsif3EDl4PZhPdhUPB9l
X-Google-Smtp-Source: AGHT+IEPIc8xe+SGGPTh5+Wb+z07lGclv1e7VW4Pscx+ktaHVaAW5DwfVGeqIV6JYcKM9RV2qfDITA==
X-Received: by 2002:a17:902:ea12:b0:202:21:eb2a with SMTP id d9443c01a7336-204f9bdf0ddmr30608845ad.19.1724843542111;
        Wed, 28 Aug 2024 04:12:22 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:21 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next v3 2/8] libbpf: Fix header comment typos for BTF.ext
Date: Wed, 28 Aug 2024 04:11:52 -0700
Message-Id: <299dcd6119c4a69649c0331db55c7d23bcdc7465.1724843049.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724843049.git.tony.ambardar@gmail.com>
References: <cover.1724843049.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mention struct btf_ext_info_sec rather than non-existent btf_sec_func_info
in BTF.ext struct documentation.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/libbpf_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 408df59e0771..8cda511a1982 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -448,11 +448,11 @@ struct btf_ext_info {
  *
  * The func_info subsection layout:
  *   record size for struct bpf_func_info in the func_info subsection
- *   struct btf_sec_func_info for section #1
+ *   struct btf_ext_info_sec for section #1
  *   a list of bpf_func_info records for section #1
  *     where struct bpf_func_info mimics one in include/uapi/linux/bpf.h
  *     but may not be identical
- *   struct btf_sec_func_info for section #2
+ *   struct btf_ext_info_sec for section #2
  *   a list of bpf_func_info records for section #2
  *   ......
  *
-- 
2.34.1



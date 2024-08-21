Return-Path: <linux-kselftest+bounces-15836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B580B95986F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E979281E02
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3216F1CBEA3;
	Wed, 21 Aug 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7DIE1N7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76471CBE9C;
	Wed, 21 Aug 2024 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231397; cv=none; b=odqAItvZ9fnPhOy8awwABgxHVWRgEH5v/0v8/n7OIJs3p3c6VhRE2EO7yPUHlSzPANNxpm9DhnkpIGEB49P1LgDMeETerxcCbIyCqxoAPt/nEhMGsxdf9LKr0ENLFsdSQqR9002jnLkcBvWHDwykMF0ObYhyorgVYeUDpAiBDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231397; c=relaxed/simple;
	bh=UJoIZbAwd0dcyPldGPlUH3SNsQcKTlS8LGIL6P+fhDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haylikR3XNpmCzxGe75DZbOlISWYB3EGpwldpnaGUS64IonbbviL4Vl752wLeWhgoDuqPB6yITq4/z0+yl4K8+6lWSUIv+3FxMJDqCMrPKM5BxgPYCHpYcSCQSZywRuUGC7q0AfJb/wNRvdf6/4BSMF4TOUwFRJ/TP58GlajPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7DIE1N7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20219a0fe4dso35631385ad.2;
        Wed, 21 Aug 2024 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724231395; x=1724836195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=j7DIE1N7PlT9s+b0c+OfkUubiMaXEEgIHjgROoNgISsYCz+PexGjKeycaEzFXZjeXn
         JB4j0OCP+6ptsipuD3lMmtvxOuYC6UjUvFCVPEUz+/oG92fY0jQMH2UMf2f3oVR62vL5
         3heS5Pj9YhQizcUX3y97Jf4z3UeyiTC+94bCZDq3dd2CHjo17ko3+A20zoC3y/i6XOjB
         rBMlRiXC1kg02AG7bdyBO5Cus1fYAaDGxSTCZHk+vK2R3GVViVatf8mKbzKxnuy0D8Fj
         R45JcL4nmIH0G7fVsRfuK8tL7oYsg6urcfUNJoG+qw1OggQuDArVn1XCFDtFvktdP8MI
         xtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724231395; x=1724836195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=YOKhv57oI+NSDkkAsqpog3CbIceiscTIMZ4GmlctAEsh9OQK4sX2aNHuxL8EIaCJbl
         +zB3h7DaX/mqM708J+/Rmp47I00tApqabA7jhg5y0RVU46yE0QqGPSSSyohVtz/O8sn9
         F0zcjlSArGZV+opauVfAKLOswOFhht9MsCwzqBZg/ZF2ZmJ9kx6MsMm1tpiHn6IYKQpf
         2lAZtUadCrJxUgCSQIrrXobWNOh6rs7DIxsNnM31KPiOXyxEf3NMngtogghYw0Xp189U
         QVt/A33A06Nq4LCMR+hKWe6pkSPFHHBD8AobP2TMdw+cPHMRF50TIx/M3rc1/AKC4h5g
         zHWA==
X-Forwarded-Encrypted: i=1; AJvYcCVAiEvqoVnUnnGMf+io0hCs/GnHyDKR4X9EZJUpHeJrpUJ7qDkyTGnFyDmK4pftnDuTgXslVR+0G7gDoSoz//A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXzjOsHn4VpM31+ddHgqf4lfu1UWyChbNpna1iMmIwTG2l9Sew
	YRxVAuqw+QOiIIYKrBnswhJPcbAyNuQCu3LHXC0wdyfjayi7srxsXpEOE40l
X-Google-Smtp-Source: AGHT+IHUddUyzwSvkPvBUsbeRbwCgyG1H46fnbK7AmlrU7O2Fi2RBuY2PGTjz7Td3RVHQkoHfaBXIA==
X-Received: by 2002:a17:902:db03:b0:1fb:93e6:94a3 with SMTP id d9443c01a7336-20367c08e9bmr15979605ad.18.1724231394465;
        Wed, 21 Aug 2024 02:09:54 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm90191405ad.94.2024.08.21.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 02:09:54 -0700 (PDT)
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
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v1 2/8] libbpf: Fix header comment typos for BTF.ext
Date: Wed, 21 Aug 2024 02:09:20 -0700
Message-Id: <f97b1541d4216d782ba6ac2a08e80b5454e23b8f.1724216108.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724216108.git.tony.ambardar@gmail.com>
References: <cover.1724216108.git.tony.ambardar@gmail.com>
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



Return-Path: <linux-kselftest+bounces-17023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C872296959E
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554C91F24B30
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28401DAC6C;
	Tue,  3 Sep 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJKqyRYa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A01D6C7B;
	Tue,  3 Sep 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348819; cv=none; b=BzNEflJ1pM6DqDe9ApAyCFYjyX1Hbprj+kVcYozhx6m0Q24Echpm/TetIVYbGqVr5etwVow5V6XJUhxx7gXfWtqOXCv85f2XHVH0oQgsKLlw14lvnZmVpRSa33S2wWBh4B+gVa5ClOnVsXUWjQ9/na5cfhRp0dpyet2n4TFVAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348819; c=relaxed/simple;
	bh=UJoIZbAwd0dcyPldGPlUH3SNsQcKTlS8LGIL6P+fhDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDMNBTA4qyP7ycmQwhhmXn5Ce2N+8AxbZgMLy2VXlN3x/uid5gxdPgClSj3v7Ji+Hw1VQNr2biwzdgnrGi/em/t6DSPEJd3gY21gQS0bRfEeEL699AEj/SYiSsjtarDCm/za9+ynpMTyaINPyjiMPw0gxbgEvKUTmsOjr88LgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJKqyRYa; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7176645e501so848304b3a.1;
        Tue, 03 Sep 2024 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348817; x=1725953617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=FJKqyRYaBv57p3O+THguPeC7iC+HMriNPrVBnxigNf2Lf92CmN4THIf8nMGVPYZp6n
         e4m6wl2Z5IcnK4w15qtLk7UJ3SVJynrWh5z1//PakPikgD9Mxx54li8vaffwZazNCw1b
         nia8lTNP95t4C6CHw68QDQ0clDe75bijpgpe/g7Plj9GohBDrtpKDxBcZWy+SrBGev+o
         dTQ4tmPdAuCfKNLlK/zu4jqHthBCCUxDukUxi/OmuPDc9YAsXBpqrJ6CJOr5syiMVEsG
         yNeIIghEDg1HDMH6ybhx+JFIOQFYFQTAR7YHofcSYMTDwG9eKGyO7o/5JC6sCySB4Ap+
         1kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348817; x=1725953617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7S9DLK/xi9tXkFIx+X5J9oUvgA+SnKs7nCanjbxcE8=;
        b=DoJ2X9TsTBGkOdioMBClmBYE3JhdbldwsdtVE9eUk57YcpFnbOvGP4kg2auWTGlLaV
         cARNrySAnIcTbukdI8rOOr4uvS7zLm5rs1Inkedlf1LbWkLAMwEZLwKe1wOk6wPXlbGJ
         3YUiw/h0PxQ7SpQIaTuon84E6aYG3i9xoB7t6W7kfzrwkqCGQ11F7pAxGo2IcFtkFU+k
         F1/hi37XWJ9GM18nIZJCreWVkIkWUaU/CgvplBOV/EHYadrLQqJsjCPtjBLNTj3mLo9b
         lufTL6bv4ZYxSA+lt7mIP7KI8GPbNy3TTxXcq1+7LlI2/boZZMytLqENi3ofpBfdK3xZ
         Oj+w==
X-Forwarded-Encrypted: i=1; AJvYcCX/8zJjXk4Ah2NKdThyVgyM1Tx9CKUobokX20o6QHpiffpDsBh9cjiNM+0YLTGAs/ysGu8c64A31em9WOp0uFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWkzF0cTNTYLaRfHTbNpctPlRDpwaBrJezDZhGiSwjzFlhCsd
	588JRwtVZOs+Bf/lqEw1t/XkxckHQVzOqJY4vjWSlsL64Gj7IHVGhXGngZGB
X-Google-Smtp-Source: AGHT+IFaHlD1YHIlj7MEHsFnqDJ9obg3hSvzIUZiirD3VdA2AeRzy5Yas7xMd0VbOkOPwgef8Cp7YQ==
X-Received: by 2002:a05:6a00:3c89:b0:714:1c0e:1336 with SMTP id d2e1a72fcca58-71744333c89mr7492581b3a.4.1725348817082;
        Tue, 03 Sep 2024 00:33:37 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:33:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/8] libbpf: Fix header comment typos for BTF.ext
Date: Tue,  3 Sep 2024 00:32:59 -0700
Message-Id: <0dfc9c06410e8bca3e774ea67215681e6d3e5c37.1725347944.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725347944.git.tony.ambardar@gmail.com>
References: <cover.1725347944.git.tony.ambardar@gmail.com>
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



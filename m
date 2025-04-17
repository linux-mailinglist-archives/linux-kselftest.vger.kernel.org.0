Return-Path: <linux-kselftest+bounces-31067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A66A92121
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA33B9FCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 15:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EE2253938;
	Thu, 17 Apr 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2dajMOr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4562522A1;
	Thu, 17 Apr 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902998; cv=none; b=QgywTL1djHQMV4QRaWjuKedr4jIvyI1qkO81Iiuv4+Tx7PgLu4wYHYN3ecD6QAKbkVKr8g9t3gqgHrAaw4iwANwulB4ZyzubM1thQFcnrN6F03gsftoqW9Shb4DWPz/Za1mV13/OUGHNKKkEFfMRCFLUMbCZqvHEK2eeX5T7ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902998; c=relaxed/simple;
	bh=M0ps3LCBKc62FNAWPHwB1zPZkFhqRXORCQuoBC88wcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpYAObaiO2Fk3Rqf8Lm1Jvg6dOwGS3BZrC5JRYSucQySKXYhASRg7grAW/id7s+8GSYdsJbgxx0g/bpUYqNVmCvMqUy3Q6vYX7rIex5kl0G2DiB9HZBse5OzBsdUXvqjVpiJa9/Ocv8fpG8L7Yi5w7u1ngikIMxZ1uJzOvvskg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2dajMOr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-227d6b530d8so10837255ad.3;
        Thu, 17 Apr 2025 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744902996; x=1745507796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euLZUslJNu0pFdN7EJCQ7RkSALSAl6XKyINO0kuIYTs=;
        b=E2dajMOrTdOr/Jx1UrCzpySxQFE001XakA1NihBiobKum2GMsvT4rJKjE3WD+aXyA/
         3p21IOu+n8Mdh+X8Kw1TR8sffvKe3F6COpG2ufSAEJKLkd85y+QbrzjOWXalWWf/zn9L
         GCcQGlyzgACUXVbKP6wac0kXfp6BDatdD28tZUvCbpIM44lXk7bYPnuPqnhmiOrM4ZQ1
         y3O0qW1uZ7NBZsumt6FoA+rdTMOFNevtGEILhPhRVVi7V2gGv4y3UaC0MJ5BTdOkb9Aa
         gOqeUUxwNOpuXen+6hJhoVuKXaTqTJEw/Z4Db8mBVwwFJwKKq1Nz7V2+l+uIkL+1AWGL
         SCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902996; x=1745507796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euLZUslJNu0pFdN7EJCQ7RkSALSAl6XKyINO0kuIYTs=;
        b=dUOj/RPwz+3vbw6fOBfDn/Uxs68vmY2ttHUfN1rFFmgkfGTrrnp0t/3+dmzxmv9Tar
         Z8qywiPKVwud3no7GbReyT+Yua5sou/NAXNSHjzaMzHNUFUkzH8drIQt6KX0yGaXBAnh
         ixYtNmHamiaknDA70t/3yyRXS3RJvjkQZvkuJ6OkPOGmbXtTT1D+S+bzOydhg7pFM8I0
         FxYJkjxHpzuTyf59tn9QOVHWK+G3ebwIAVfNAU10R+KABm3urIWAIubnrz+mJzrYcMBM
         Q75wE5phykSZHp/oPklY0PZYMaj8fWLW1zllJkLUWikheoCLizSniVF/c392tGrZKpJX
         Uvjg==
X-Forwarded-Encrypted: i=1; AJvYcCVrmy1Ftf0sZO6zRIwhkEc7nl9p1svKZTL6i8jNs3QDMnuyAcrjE6N83LHOCOj3WkxAfNKIRs8L+H3hFzY=@vger.kernel.org, AJvYcCXZZR/g8gsQF7LYsEcuuyGDO8rIF40GFykrTrAzX5DFq0hC81f/o6em7OvQX3i3bdaDP+juweGGs697ohDyuHA8@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJz7XaskQhTmWs39gmn63MYN+M9nd1I9u6xwV0RuXPJA9kCWZ
	tjqcAjcW0tE+rKQ0fIWxnlvuy1EEmpkYoUP5USkQ/+gEu2JGaXMp
X-Gm-Gg: ASbGncutx33uKFhk6t95FmJ84jSKxI/vDzdHYvuZR0zGVHiW5lW7ejo7Ol2mmIFj3Av
	Bh0YQ21cpZJAeYfzFSG3cF87/mQK04kxxwOfd0iUOLK97FvYp5WzmjHnwnLKQDEly5G61BrB6rd
	LD7OCpz0Bv9/hTYnGxuN4FNZkQNb6YFerir6ICLHnhZ/ZhrqZgPdAs0AXuoAj0OpMV4SNe6JFgQ
	urlIn4mxVnP2r5IHA6AGd+ehwbUygtg/URvzDZBvVXhiGqWansZBfXBcD5J0Kapje4eYF38Y+uI
	/tyiFD/qqswMRP6dU7q0M+r0lkbBFLJpDV1A5xdYkKLB
X-Google-Smtp-Source: AGHT+IHdPEu5kbBaAs5vfqhKwIrxObiM0Xt+eP4UF3dnlnAkulaDLzvj5C3+dLSU1yVNOeewy/DbxQ==
X-Received: by 2002:a17:903:1b26:b0:224:13a4:d62e with SMTP id d9443c01a7336-22c3597ec4bmr120492105ad.35.1744902995986;
        Thu, 17 Apr 2025 08:16:35 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdb97esm773125ad.219.2025.04.17.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:16:35 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
X-Google-Original-From: KaFai Wan <kafai.wan@hotmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add test to access const void pointer argument in tracing program
Date: Thu, 17 Apr 2025 23:15:48 +0800
Message-ID: <20250417151548.1276279-3-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417151548.1276279-1-kafai.wan@hotmail.com>
References: <20250417151548.1276279-1-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding verifier test for accessing const void pointer argument in
tracing programs.

The test program loads 1st argument of bpf_fentry_test10 function
which is const void pointer and checks that verifier allows that.

Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
---
 net/bpf/test_run.c                                   |  8 +++++++-
 .../selftests/bpf/progs/verifier_btf_ctx_access.c    | 12 ++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7cb192cbd65f..aaf13a7d58ed 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -569,6 +569,11 @@ __bpf_kfunc u32 bpf_fentry_test9(u32 *a)
 	return *a;
 }
 
+int noinline bpf_fentry_test10(const void *a)
+{
+	return (long)a;
+}
+
 void noinline bpf_fentry_test_sinfo(struct skb_shared_info *sinfo)
 {
 }
@@ -699,7 +704,8 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
 		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
 		    bpf_fentry_test8(&arg) != 0 ||
-		    bpf_fentry_test9(&retval) != 0)
+		    bpf_fentry_test9(&retval) != 0 ||
+		    bpf_fentry_test10((void *)0) != 0)
 			goto out;
 		break;
 	case BPF_MODIFY_RETURN:
diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
index 28b939572cda..03942cec07e5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_ctx_access.c
@@ -65,4 +65,16 @@ __naked void ctx_access_u32_pointer_reject_8(void)
 "	::: __clobber_all);
 }
 
+SEC("fentry/bpf_fentry_test10")
+__description("btf_ctx_access const void pointer accept")
+__success __retval(0)
+__naked void ctx_access_const_void_pointer_accept(void)
+{
+	asm volatile ("					\
+	r2 = *(u64 *)(r1 + 0);		/* load 1st argument value (const void pointer) */\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0



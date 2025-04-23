Return-Path: <linux-kselftest+bounces-31398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A066A98970
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0D95A550D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DC62741D4;
	Wed, 23 Apr 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+msE829"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDF2741C8;
	Wed, 23 Apr 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410478; cv=none; b=bTouzpJwukleO1D5qT/tVEYac+YQkzKTbAFgkwCC/wK7dE1sqUFhbbTdwsAhEhD6qkN8N55kBgM4UtQZX3lMtwphF+FNaw2p1Ud7SwIp3NVPyZlRKBNJoWtRNtU4HFve4fVL4wnHspWw5MtEgzLuxvwrLM+ClZ+ZuFI51nRsJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410478; c=relaxed/simple;
	bh=iI+zOFiPdKwPbL1x/XV2O6KQJB7HnqFPdwL8xUTkTGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKcoBWIXw9KKBb8vPQ20J6EgPdz9DtB+puccoPBrtNdUIdpNeQROTUYvJyw+y305ALW8jKdxMvOio7mHF5xZfSJDGPnUir3DuhJL0/kGTsLSVnU03lmVnTTcpKhqCeVm/7YKGeL+6SywiIRX9SfpZF79r3n/omeeSDAe76NP6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+msE829; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2295d78b433so74063275ad.2;
        Wed, 23 Apr 2025 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745410476; x=1746015276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6G/y3HQErml1NMZQNrayd+/BsrgNwWrmomSiPVW0Nsc=;
        b=K+msE829fzeroKjiXRKf9NS3zVzUUkKOoMMAF9p20Rq7zI3UpFWs/wjPbA1RNLVrOQ
         vVfAdLWwA9vuVb6mCOospRpxAjWd/UZuJcED8twGKhxdCBd0yVg/D+VMs/TS14NDIvMO
         lLRsgO6f6j7rOltvdgwFQ2a3ndNnP2+wUebwEjRiSUOMxkGc71ZPSLkhcx+26ivKpVbB
         cv6CoJPRA8kaZI/fueIeiHRDBavWrKshCJ18Jfc0jQBpfx+RQo+iQtTraMX/MVPJupHf
         +yJTCc4Ffcu6f1Ke19e/hxFVhMvYphTXdrrKZ+jtnNxc5cjjEd+oanDRajP0fLbMd+Dl
         gDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745410476; x=1746015276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6G/y3HQErml1NMZQNrayd+/BsrgNwWrmomSiPVW0Nsc=;
        b=nqMkNQeFPvYpqYfzKzqQSX5pRPRjcbZtNJLP1R+/NjAhORUT3jaiaJUsiX5xD1Jb0e
         nztEZ6YqmMassfoAdfWaf7ki4TB7hAc5V42umgQbNZjoOdNCLry5geHpwmehqVY4GMhV
         61lucRpRB5LdaNJZ5W4nYOl3TxXAVMTUKya7KUu0aQjcioWOQm+kRLDAxHo4QGbScOmY
         29tU5X6aQHKzYlk3XkIuCukHAJOxSnhiFBxBs0NjONZJBCQCjl4QFNzGU5wH9KKEwo0z
         Olu5Quyv0+SiGnVTRriQNHxf03P8I8esLIyI/kKqMR7PG2otKr3spLZVvb14Jj2BbdH7
         yXaw==
X-Forwarded-Encrypted: i=1; AJvYcCWBpbA0viVYCT5tmO/CL1M+aTLtyCOr5RepQQ0VvVFOgjYt/5CA/oK+sB9sYmIqUjOlHhMkq/+Tdds8kyw=@vger.kernel.org, AJvYcCWZvOQRiwMOvsXx9CMbAgBwAWx77WlIarNAgdSQTRx0G6RRgTax7fAD9HBGRy0wsVKojI+07+Bz@vger.kernel.org, AJvYcCX7OJgNXnk9u4GHlOkNgwPBuAwgNtGQvGzmie/HY3+LMip/bNEGdcaJWL8mFR04JTJ8FjOhes7JhLasnzzgAYdM@vger.kernel.org
X-Gm-Message-State: AOJu0YylA7FJTMB22WvdqsUWjt+R9CIY/AVqLbnH2R9Hvo9M0X7nsWYf
	7IoeRFgiFkGhYpwh0fArEZltD9C2wKRJc6ODmIq70kTWPAAuRkga
X-Gm-Gg: ASbGnctFG7JQpjWXfL6Vha7WxW5jNi/G0GCz0+LQNWp5xTyF+oblHBXiDStYiBq8sqr
	1BCCFTB2vM0k4Zsk8cq0ZAYLxvCnmej49bTgg/fHKJFH8ocmZDQR07yLzk0S5wyoJahegY+7vnO
	UUBaQ/TjlMyXYhnn0KCS30rJ7N8rBh/+4HCOGyaIvnauPSdq1WvRt4CLvbuPgsEpHeLrarVImpg
	9yXDS5jm//kJgaQORPBEInyLNz3DLOzOXVO+hlz0ZZ5mDVzzJ6Ekw/ouQ7p9sRIt1zWR+GOVyTb
	9cn+QMNO/GD8dtDIae27jVd1PEsUSymkBXkZ2a4l/lI=
X-Google-Smtp-Source: AGHT+IF+oB26vPds+B4kBrr2c9xPwwreiL7sTMFTRFvzhefCWoyDXGQln9OtTCMvRnNeQwmY27e4aw==
X-Received: by 2002:a17:903:234e:b0:215:8d49:e2a7 with SMTP id d9443c01a7336-22c53620bb5mr256277845ad.50.1745410475779;
        Wed, 23 Apr 2025 05:14:35 -0700 (PDT)
Received: from ubuntu2404.. ([122.231.145.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5528sm102647295ad.100.2025.04.23.05.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:14:34 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: alexei.starovoitov@gmail.com,
	martin.lau@linux.dev,
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
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev,
	KaFai Wan <mannkafai@gmail.com>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add test to access const void pointer argument in tracing program
Date: Wed, 23 Apr 2025 20:13:29 +0800
Message-ID: <20250423121329.3163461-3-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423121329.3163461-1-mannkafai@gmail.com>
References: <20250423121329.3163461-1-mannkafai@gmail.com>
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

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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



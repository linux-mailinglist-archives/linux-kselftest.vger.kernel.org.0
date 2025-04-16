Return-Path: <linux-kselftest+bounces-30959-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA2A9088C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2277B445F0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC16A211A3D;
	Wed, 16 Apr 2025 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTJBdIrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006321129D;
	Wed, 16 Apr 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820303; cv=none; b=p1cq14ceVNJXRDe09DYD9FwnzkQ18GMEa/plTmnSSPzg6WP/WNhta5Ebz565BoY6BsZQslB0VnwFLXPHW/JZIKJ8YqAywoYTPnptXNLsqABCEsNJwhLQW1nHjdeUj2yw4b6ko3au+gAC9HcVt1ZOFf6f5f4CFkCuzn0t2xZ1s6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820303; c=relaxed/simple;
	bh=M0ps3LCBKc62FNAWPHwB1zPZkFhqRXORCQuoBC88wcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRw7+aHsgyDJPMrcFlRbqvUjWImI4w2euZBFC3TOx/Xfna4O8PI11P2gJME1Tfd2Yoqm8zBljKpF97rIw1kEke4p28S06TKunjVlej3FI8G/rZE/YY08VfTosyOr/HRgQJPnP7b/Vz7Hha22FwRC5qjkoKGfJOcT8x9Z9jES8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTJBdIrw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736a72220edso7264273b3a.3;
        Wed, 16 Apr 2025 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744820301; x=1745425101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euLZUslJNu0pFdN7EJCQ7RkSALSAl6XKyINO0kuIYTs=;
        b=jTJBdIrwm7e4Qf6x3LoZcGmxu+LR/jXXZ/I6Koxdkr9XUdTFNtqnnzCzhr0SHmmwFD
         ldvcZ6jzT/ZNCX9A8Ibdl/3BTvhoI4wjfD9MZnYnbbTRB2GO+cx2gLrgW+eiKvYxHQmU
         5yz8j0TyC2CiB9rf8zb7Yntxn+7TjNcdOwO4EPQrFaQoeBdoX+LoVrxUGl+Zjvg5DCVg
         3SmcBRGYX6/elMA+HDq0V5HpGH4lr42kvmS/mzHPpEoGvrMs+PH8zTDvVcrXgQeoS8hW
         M09OAWBp4mUj8Tst1A2wZl+tE43a5wBThEcaK1MFCw4wsXEhvQFNK7pt778MlPFNcw+7
         rD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744820301; x=1745425101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euLZUslJNu0pFdN7EJCQ7RkSALSAl6XKyINO0kuIYTs=;
        b=qKiDwHozXRZNsNT9KqTglQ+9vSU/0wHxKiCakGeXZYkcf19N+EzNaKxFYPQ0W+cmOE
         BAwZ3f9a17oFODrxKjlwmsfOWbg37BEsX53Mr7RHXaclMsJclDQVHttK1cbGpRsURs9u
         GE9CBoBig98p0nP8lwu0+yrFkHmu+2f9fJcKdjDX0VnvKZRBBsr/ek0ckJabJkRiHW9N
         Q1PCvRrg0SZd+TxHmBCJWjHtqjGPXMMXYblogtaMsoCAPYDSbE/mGNHCya1jgQvLLiyS
         nhGZYdhYlkhlRIpPI+RMzmwIAGVG2iDog3w9ISbvV4SuN5jvmtSm5/NDWiROeZUKsJ/y
         9Ofw==
X-Forwarded-Encrypted: i=1; AJvYcCVfubpPJ3EmzF9N9F+PRShcqaCdHdbhdwgz4sQuWZnIaFxLEtmXDl9Q2PIVwJWExeCX3W5jp/gC89gz7yA=@vger.kernel.org, AJvYcCWf4LrPYkO+FWm4jzw+waBQ3fwHSRL2IPdTJuEekPo5CfDpZsANgIW+zrb+2aML2GGPwMrkeCjmqiQnIfPp7efQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+x+aQXmNdsC2mg5FRRil8tzP17XzX6AruMnYFeCrMfKGQtGoQ
	0ggLJjH5dTTyy3DesnAKOf5xr9jMuKZbXdUN144R3mlVYQ3BVeMk
X-Gm-Gg: ASbGnctDnnqtIa9drru0e2cwQ5CNLL/NjQZpwu29NWu8A/ogHf7LvDixQ9mI7YGS3zC
	2GKi4Ud9J0m4u8a+x2P7YDz+Ji3zWBYm7aLQTetc/cf1h5XTL/TJSMjZOrn+rxZ/BKDz01aTJI/
	ljerZqnVmn3Ms7f+NXF5Z8zzgdDGdi4V6UOkBWbGFYWbHztrtIwrrwTxslwZ7vkprcxqREEpICH
	sOKoRNlxUUKtzEGPIwCHd7UPtBIzZ7bCV9kOJiDG0ZcKIYeomcqlKvIHJ+K5XUQaGq8rH8JdLg5
	SEp6VUIS3Y+mjYc+0HTjH+Awv1S7nsOt6h+O+isLJdcJ
X-Google-Smtp-Source: AGHT+IHs592UNmX2eMXvrjWKKjCvePFkTODmijTI4ak5bzNFR2Ppl7jv5WdIIaO/qjfAor066vIqSg==
X-Received: by 2002:a05:6a00:1da6:b0:736:eb7e:df39 with SMTP id d2e1a72fcca58-73c267fe3f8mr4090663b3a.24.1744820301334;
        Wed, 16 Apr 2025 09:18:21 -0700 (PDT)
Received: from ubuntu2404.. ([125.121.98.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230e355sm10921939b3a.139.2025.04.16.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:18:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test to access const void pointer argument in tracing program
Date: Thu, 17 Apr 2025 00:17:56 +0800
Message-ID: <20250416161756.1079178-3-kafai.wan@hotmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416161756.1079178-1-kafai.wan@hotmail.com>
References: <20250416161756.1079178-1-kafai.wan@hotmail.com>
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



Return-Path: <linux-kselftest+bounces-37240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57909B03E39
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C81A64AFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B3F24DD0B;
	Mon, 14 Jul 2025 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5aba3tw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6505C24DD00;
	Mon, 14 Jul 2025 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494670; cv=none; b=MalReDul4imcmCUrMt644OeNXX4ACLkC7h8D9H0j3/KlGRoaiBHV8VHccgPnFkWWCquucGIVc+5kyzCivO+WHgpYf7/IqXhVdNr8CIcWH90340eR1zQ43ACFVCttZ979QNLs2ziAA/zloJda19R3QRFLRTvGbj7h5IQ1EIauvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494670; c=relaxed/simple;
	bh=4wyLT3YlJDVpRKUKlGyJSa/8UE8XVEowxxN9nIdM1mM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC11VgnnDMHNkvKsgyGNhL7hNN7dRtrh5/3eCMLrVl9zrMzThRZQO5OggqYxce1lXYKo6v7ZIGnsYM7nQQbuVazpcmB+O+vA48Jf0Gr9rODe9oqX0/KosADtZM5Tseuqs3s3MqghN9rO6BIrPYDHVGiHVmJv35mwjPubd6Bi4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5aba3tw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2353a2bc210so41152975ad.2;
        Mon, 14 Jul 2025 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494669; x=1753099469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMSOLP/R0PZ61NzAHx28NftsReSlNDrRQHUOySUfniM=;
        b=C5aba3twhB7BYYND1YQFFSHHDGFqyqMMNSy5z3nBafgP8OKmNpkWgMPibranqI4qki
         Wp2BStck5zKWV/qMfbbomuxfgGujECDwSHnGb3JDTgiKbsjH/kbaBPML/5s6yfxrI3v9
         4CXq5asabV+Uxd52B0xP6/VGX/aOZcKPNF4Wjsddh6nfkwpTwT9lvW7S+iqTPJRgfnYa
         PZskJGwyXkb1SsB8hII620jyUKwJigFB4oDEod3GwvCJvboYzBdBeUM+cvW6XIBHhw21
         Ikm0XyDSU9IvlRbXt1GgFZuhXYGTFMwIlDzshoWnL3K+Bc4ur70XlhuTaPp/iOCECPgn
         nlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494669; x=1753099469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMSOLP/R0PZ61NzAHx28NftsReSlNDrRQHUOySUfniM=;
        b=tHHD7BEjZtWYZhn4ySyl8U1LTTkPAxcfilkmMRqsJtkuWiLAg4EubJAKjd0ouhmuD+
         xJmRQFkOugYHpW0nfJSLIoN8CNBi/hMGmh2tqF0ell1jCkM4Dmfh6N0OmTgvuq07LknX
         x4rDy/tWl7YkS8x8FgBoGi1vKSGGPFt439bx++elBqM5GBFA/HD5rne/iqxuV8ESfu6d
         EDHECSbQXzixVorfhtXIOEfXMK5xoM3Xm8nqMMnH56Em/Cvw/tKUc6JRtW7PgQwaP2c4
         wiHZu2ztU8byU3iVpWOoabnCsMRQKgjmeKJLcNeaAwoF0G3T17mduphTda4GC8N9FjHB
         7+wA==
X-Forwarded-Encrypted: i=1; AJvYcCUZBWb8MpQ+vdE1sQSH+znO5a+UNRf+aYW1uybQTXlY7ja1WAPen0MngmGEVDJ+APlmNETJchZUwbvTpqJuuDaN@vger.kernel.org, AJvYcCV5jtZOtVI4Ijc1fjHkII+GfmeulD2IrXZu1WfgUghVrWK8RMc6Kc7yl8H+f5T/KfJxDl0bUBhdlFtC0Ry4@vger.kernel.org, AJvYcCVD6VBvsdJnCmhmaT8aavv3xPCGiKaCIK3f3LRSdAzF1inw9Gl5HZGIEQWl9NuB9Y0WnyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEl3nQJA3svboc+Ij43PE7W9iAnfRclRb/VBZkcS5bhGN99uHO
	Q4ga8YSqHd1TSYlPazzqEvqqRv4V/bi0TRzeqJyj6TQQRI7NRC7CO9Mf
X-Gm-Gg: ASbGncv39UMFw8Rq0de/Pi0Per080GDCKseBtGV073Vm2AszsuKhOoTt3GM+t1qnIcz
	1hrCy/v24/jLZz40gciBG8znNEVK58/DXSjxLnQ73QpMzusVZ3P8vvh5iHos4/iVz18l4iy2A1c
	ErP5WMISm2E+OmcBXJM3y/Hta0pJALWmKF5i4vog/B0U/j5czQ9HcWMKqT8UIOmoEJ4BkVJsXWo
	r2akxh11utejJO1C2pb9ZQOcjAEcNNZtNw4ED/K1NzDYt20/jm0+ZKA9/udotv5tfhR4T8ouXzE
	IzeS2ewT9B72pRBLvgnz6hFxbmVwFJDBn9Ul3dT/on2w9ndejUmuU03I1Ijdy0kHH3dsvIMJMIr
	c5maf3df91ydu1TJU/mCRLr4T/klWnjx9rA==
X-Google-Smtp-Source: AGHT+IHwd6GXW/7RS2OqOFMK6Dvkk+BNLJKgKuYuFV440Xmvr8vbFm/9owzH3kmAm4PSGj3b+WWdCA==
X-Received: by 2002:a17:903:4b0d:b0:234:8f5d:e3a4 with SMTP id d9443c01a7336-23dede2f256mr198713005ad.2.1752494668401;
        Mon, 14 Jul 2025 05:04:28 -0700 (PDT)
Received: from ubuntu2404.. ([125.120.99.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359e4bsm89612895ad.215.2025.07.14.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:04:27 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mannkafai@gmail.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v2 1/3] bpf: Show precise rejected function when attaching fexit/fmod_ret to __noreturn functions
Date: Mon, 14 Jul 2025 20:04:06 +0800
Message-ID: <20250714120408.1627128-2-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714120408.1627128-1-mannkafai@gmail.com>
References: <20250714120408.1627128-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this change, we know the precise rejected function name when
attaching fexit/fmod_ret to __noreturn functions from log.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.

Suggested-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 kernel/bpf/verifier.c                               | 3 ++-
 tools/testing/selftests/bpf/progs/fexit_noreturns.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2fcea860755..00d287814f12 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23946,7 +23946,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn functions is rejected.\n");
+		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+			tgt_info.tgt_name);
 		return -EINVAL;
 	}
 
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
index 54654539f550..b1c33d958ae2 100644
--- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -8,7 +8,7 @@
 char _license[] SEC("license") = "GPL";
 
 SEC("fexit/do_exit")
-__failure __msg("Attaching fexit/fmod_ret to __noreturn functions is rejected.")
+__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.")
 int BPF_PROG(noreturns)
 {
 	return 0;
-- 
2.43.0



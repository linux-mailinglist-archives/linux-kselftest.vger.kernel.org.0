Return-Path: <linux-kselftest+bounces-23476-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF69F5D69
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 04:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCC5188259E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44403597A;
	Wed, 18 Dec 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaQAKisi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62D15250F;
	Wed, 18 Dec 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492262; cv=none; b=ZEn0OZCKENEpWaqUbL5bV6COK6eiws+5zstTrP2XC1kUnNp259m3bz4O1DpYlgNjA1RlvUH+nVfvz1Fh42jPuC47xT9g9BF/KfCKgIYnzn6pxV+ex/WSGNiU2oeBoZq+40zxJRgu84oNd6z9UTdB3tYUNDOMlPDXFRgP4Cqx2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492262; c=relaxed/simple;
	bh=EpIiynsjnozVqw/0x3LVUCzOWJ6olzjgv5hUvkC7X1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYF5zJJ99lgzkwrNuKVGBGoWY6VVSbkrRi4LROFH84nrC3FA9uKuriuLrPngnOCjpOVEnIv6eVG8TdxQ25uCbzMS6T7miLoi60rqR6zvytAS4LLA5P6/v7UbPlHNR+PM+9DW7S7y+VWRR3BK4gmlxzKBJefPMPmSUdGIw1pDFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaQAKisi; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6ff72ba5aso356417685a.1;
        Tue, 17 Dec 2024 19:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734492260; x=1735097060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU1DPjWTLJX1jYc4OU+MA5rIh9EYQGoOHy6NRrQN9LI=;
        b=TaQAKisiyxhxs+d2lAuXWXqV3OOrIgrfaGIh08Dl6A756JLAvDx64+/41hJaoWlagU
         XbFdCuqxSrBDnVHlW5EkMNMwAytnKQTkc0Z2eIw5zUIHA3NcV66rEVIcFzvil2Mc1WuO
         FKR55cJ/gzXOqZ0rzS3IJWaf7gtbKWhrbmxjlYBBocVErNLVfvF4aX2vJmJ1YbY6L0/y
         ctugGRmTjuEBMkJHHCT6s8Zup7PEZHBHEIKwthk37xek0wh9oovW16MriTVZb/KeM3YB
         1m3gxi4arK0eJRVDAkgyE76Z4GTxUMp7R5BSVFSCH8P7efbeq3T6MfsTcFQu4X4Er3k6
         8ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492260; x=1735097060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU1DPjWTLJX1jYc4OU+MA5rIh9EYQGoOHy6NRrQN9LI=;
        b=w3f7LZj4xyIpZrfJFDL4fn1BV+0Sos+i0MTLEPxJmpCCnH1YFd7hTamfBJG1j6FuQQ
         K1OAiDJUZZpxuD/vlh+1LoX9g/6akh2H4RfoO2Ktxzn8WMQGLMXvGSrcGnGh5XF46EWW
         slpit7lrpq169EUdj7yOhaivzJt5Q0+TPhEYZxDwhcm+LLzUgwYxpe05WX+9G/ASfSs3
         qvHMTUP8MssbynAfZ4HgphzeqHL0SfROgD94OFE7EK0MJU5QMaLDZBXKFMlySQ4KObSp
         Tu3H4IOQwHtNcSkuhxvOgkGiMf5v/Z8QIet8FeWROsqG6yOWwMwPLCd2oOhp86hZ8eeU
         /krg==
X-Forwarded-Encrypted: i=1; AJvYcCUmDp2ac3U6vfRentna9ldBvQC3drsqUCIDzLUjfmeG6CganI5nTAVzAvCGz76Mj0+Tptqj39pHcA5VFR5j@vger.kernel.org, AJvYcCXbsPS/KJbNa6hfuJ10/MKJ6xIRFByBln+DMMGITFYEQZbnUfPavgGfxfJozwahmYvFjcA=@vger.kernel.org, AJvYcCXgbbKuVzBTGoXu6Na/XQFuqYpJvcKx9betqQf+dsurzKsc/wRItfBjbQtW9byqdpnUS/ZDJC0GpcJvimTXPErC@vger.kernel.org
X-Gm-Message-State: AOJu0YwJE2tCrj5S/fDFVxF+vPzWEFAfqkwBYkpFTNRq6ABYn++0a+Kv
	AQ1YvH0Gnu1H++clENHenhGZ2doo9CRq5aZPplIsOSrVlxDChL56
X-Gm-Gg: ASbGnctvEkp09sTGaGmkZggMR2W1FhA3nFs9bEuOuccTA4cKlv8kne8geqNYAfZJGrV
	pC3MQdguLDLYTrB28t9QaH1jPskHet9GBEf99ZkR6cNFLn+K6nxwrdv+VwtCTbAsMLPybhVRHvT
	qcbtACiZgelY04gszbBm4OkFMpEdE+hc1bY6MAVGd2G5HcFu27zsgufFubRX954r2AYbKV2oiKT
	ZC6CplqSedkwInVYmrxCEMIGn6NgFjC7mDXogqGng49zyf/4yaEcUh92Ld5p9GzbRkTJI481K2/
	K2BA6UooL8A8PDgKgRYMd5bFKVIeqJ4=
X-Google-Smtp-Source: AGHT+IG5vxfsDUp+PMTN1rdUWhcZAKT9Ky2wjbLSfXxt0fmilRdnxS2teb8kS6i6n4M0BkjCuiICDA==
X-Received: by 2002:a05:620a:4714:b0:7a9:c333:c559 with SMTP id af79cd13be357-7b8637b167amr237291685a.48.1734492259898;
        Tue, 17 Dec 2024 19:24:19 -0800 (PST)
Received: from Matan-Desktop.localdomain (ool-457a37de.dyn.optonline.net. [69.122.55.222])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-7b7047aa6bbsm381977985a.3.2024.12.17.19.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:24:18 -0800 (PST)
From: Matan Shachnai <m.shachnai@gmail.com>
To: ast@kernel.org
Cc: harishankar.vishwanathan@gmail.com,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	m.shachnai@rutgers.edu,
	Matan Shachnai <m.shachnai@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add testcases for BPF_MUL
Date: Tue, 17 Dec 2024 22:23:35 -0500
Message-Id: <20241218032337.12214-3-m.shachnai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218032337.12214-1-m.shachnai@gmail.com>
References: <20241218032337.12214-1-m.shachnai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit improves precision of BPF_MUL.
Add tests to exercise updated BPF_MUL.

Signed-off-by: Matan Shachnai <m.shachnai@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a0bb7fb40ea5..0eb33bb801b5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1200,4 +1200,138 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("multiply mixed sign bounds. test 1")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=umin=0x1bc16d5cd4927ee1,smax=umax=0x1bc16d674ec80000,smax32=0x7ffffeff,umax32=0xfffffeff,var_off=(0x1bc16d4000000000; 0x3ffffffeff))")
+__naked void mult_mixed0_sign(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xf;"
+	"r6 -= 1000000000;"
+	"r7 &= 0xf;"
+	"r7 -= 2000000000;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiply mixed sign bounds. test 2")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=smin32=-100,smax=smax32=200)")
+__naked void mult_mixed1_sign(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xf;"
+	"r6 -= 0xa;"
+	"r7 &= 0xf;"
+	"r7 -= 0x14;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiply negative bounds")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar(smin=umin=smin32=umin32=0x3ff280b0,smax=umax=smax32=umax32=0x3fff0001,var_off=(0x3ff00000; 0xf81ff))")
+__naked void mult_sign_bounds(void)
+{
+	asm volatile (
+	"r8 = 0x7fff;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xa;"
+	"r6 -= r8;"
+	"r7 &= 0xf;"
+	"r7 -= r8;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiply bounds that don't cross signed boundary")
+__success __log_level(2)
+__msg("r8 *= r6 {{.*}}; R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=11,var_off=(0x0; 0xb)) R8_w=scalar(smin=0,smax=umax=0x7b96bb0a94a3a7cd,var_off=(0x0; 0x7fffffffffffffff))")
+__naked void mult_no_sign_crossing(void)
+{
+	asm volatile (
+	"r6 = 0xb;"
+	"r8 = 0xb3c3f8c99262687 ll;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= r7;"
+	"r8 *= r6;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiplication overflow, result in unbounded reg. test 1")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar()")
+__naked void mult_unsign_ovf(void)
+{
+	asm volatile (
+	"r8 = 0x7ffffffffff ll;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0x7fffffff;"
+	"r7 &= r8;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("multiplication overflow, result in unbounded reg. test 2")
+__success __log_level(2)
+__msg("r6 *= r7 {{.*}}; R6_w=scalar()")
+__naked void mult_sign_ovf(void)
+{
+	asm volatile (
+	"r8 = 0x7ffffffff ll;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r7 = r0;"
+	"r6 &= 0xa;"
+	"r6 -= r8;"
+	"r7 &= 0x7fffffff;"
+	"r6 *= r7;"
+	"exit"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
 char _license[] SEC("license") = "GPL";
-- 
2.25.1



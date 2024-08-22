Return-Path: <linux-kselftest+bounces-16030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDC95B18D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A303A1F23568
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02217E009;
	Thu, 22 Aug 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH5eplnu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7513C9CB;
	Thu, 22 Aug 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318692; cv=none; b=jR+7sivkuorjMDfVehIwbdBTCgZJRpboCcgk59//Aim9rgZeCe46DOamnjk48gKywlwE4vTrI94w9QwRTvznodFqm8u76cGWhV5TAW3PZapNdutmjcO0cgK92TNSoXYnhCuFVSEPm3dnlQuUt7Je0P4Bvm/3E8wdHxfNXITKnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318692; c=relaxed/simple;
	bh=VBNLRm/K6S9P+VrNfuUGLUml+N9DcK1q+aeGBKmB8I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzadIdcqpcpCTzYOblCN74I981xFkM4hkt6hLQv7yqp02pb0bQmpogXZQbKHVCBrajAoOos8Zxz31hipPElf09xYzNhxalZoH2iv5OQmjw0zuBUX+kE3/HRKJWOXyFfUEKn/5iL/3Ey2NrMStsnTVLKIi2eDOCmCi1z+aLszY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH5eplnu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714226888dfso522342b3a.1;
        Thu, 22 Aug 2024 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318690; x=1724923490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSnIlYklgq3so9gt2lwPJQSnXdrAywKGiJfE+S1Ka1Q=;
        b=RH5eplnu9TaSOrrbJmUQsgOzuv/lFA79tVJI5RVYdCz1mvqGKTv+gOOTTbsaymaAdB
         9syW3j+tn/VwAEGDXcqBmsHvzJ0JZZx4kstXll6Gn+HEVAW/r3LHV3Uc2602J7o+eqCX
         OUt8ouhmIxLgyngBQILq30zRGaEpWvaR08roZK/d1uKKk0kjPikvYydhaLRe+QQqTlSb
         KwcH9a1HZzTyKhOXQF4U5jeJndLE3a5Y+HI3Tjd7OSbki3iYh+X8SUezJYA8hibBuDt4
         ZX9qNmbM0d8eCiGvyadMX8c6JlB1jlnLv20Mh8tpM0N7RUr44Cqh/hpv2qoa9prD3shV
         Bkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318690; x=1724923490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSnIlYklgq3so9gt2lwPJQSnXdrAywKGiJfE+S1Ka1Q=;
        b=YoUjEhvxbBaJmnwgyhNRe6PVI5Og4vrqfPC/wdXLwwrRP1VxQ4NKCCxh0PJdTrM++Z
         PPuLZ0YlyEgh5ktMyscC0p4kn/evFQirSvpo/9v0vHGlqXtB6XPfYobe3v8hyfqNkvaf
         dNKrHq0QsdpX+ZBfEYBIUBD/aG/DRjEA79ORmM034fURwtFffOPcPIfHb4yd7hmjv6Er
         LeDGunhLA3t5mIXZPJF0+YseXj4xm34Bel6/Jy2kF94pQGLI6j8mLaSVYiRKA4QJleS4
         zl0dZX/sGbHBNM3DQsloD5CiAzyEliy/iZBNOq4H+Wq3lLk/BqKKu3NfO73S6OoObOzH
         GGbg==
X-Forwarded-Encrypted: i=1; AJvYcCXc7ZYv51+Ur8oxo2K5n7XZRP2N1LQDlKQI3DQaYU4/HKuEroIvFdXVVEOmAEX+nZWaEZJWH5wJTYGGBtZt5yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ07ZZQG5nSH52Q5W6Q3LWvt8PWMbIALfPyNp5CD0YdiKTHPwa
	UyqJzwlpoLqT0IKKC9tJgXnVNwZgum4SFwLRYsS1DfvVbmf1QJPTP+fqHGfp
X-Google-Smtp-Source: AGHT+IFX4lIZ5kUnWhuWkmyJ5Dy3yqobDegARzbZFbTUzpTUHNcI/yzIpG9ZwxU8jxjrr1PzyA8B2A==
X-Received: by 2002:a05:6a20:2d23:b0:1c0:e629:3926 with SMTP id adf61e73a8af0-1cad7f89740mr6692997637.16.1724318690142;
        Thu, 22 Aug 2024 02:24:50 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90decasm3548820a91.23.2024.08.22.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:24:49 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
Subject: [PATCH bpf-next v2 2/8] libbpf: Fix header comment typos for BTF.ext
Date: Thu, 22 Aug 2024 02:24:25 -0700
Message-Id: <acece98fd4a4f06a13dd946918d9624ad98b4072.1724313164.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724313164.git.tony.ambardar@gmail.com>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

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



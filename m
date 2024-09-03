Return-Path: <linux-kselftest+bounces-17029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C386D9695AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3541F21E35
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D51D6C7E;
	Tue,  3 Sep 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWS04Bb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45F1C62B1;
	Tue,  3 Sep 2024 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348875; cv=none; b=hD35NJMEw5E47XEwl5N5tZNcEu6UwUwmX6c5fPIJwY0jdgirWuGDw/hreDuXw+GYGsEhbnS8dutACLXb6zIRRhmTlTwW7Pf9H3GxLMSdh8Tm8qmzyM/lOCX7iFrOJvPXX6X6nZabvnVrsP7UBGj0qTF0lsYhspzhiJ0WENg+moA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348875; c=relaxed/simple;
	bh=w40eLrSBtS6klKdh9gX6KL19qx6emdBSygq3BzSs4hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riF2HnUm3ss3hOFNBpjRqfZSZ4xOyEabXwx0DfPUgcVEMYh9nW7l0NulgfEDj4+491IZE030dpuR75J10IBPzC4bd+0FeQ9StcgTr/36elBPZ7Al9uYSy/JIxY9C5TVAFp3hDtWKoJ2SPYdtwhYiFDOIV+OUE7fqC/3Ca4bnnfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWS04Bb5; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70f6732a16dso3011743a34.3;
        Tue, 03 Sep 2024 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725348873; x=1725953673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+dH+RZcHjqpxSRHc4esw3Xc63l/7rMXelYdHD7/OEg=;
        b=OWS04Bb5TZBYsBMwNFdny3WJ8pmFDrWSO3KsOQdHrlA1ffrI9gd1RbnXF9g1CV+AGt
         Nkry7wJ+97GzXvRUur4gK5qS5NPYoEaXW5R4lscVzep+dxsjbVRFNgNH0Xm3qNaGLbtG
         ZSbYPRVeGCXiOi5l+Nc0ZFZK2g22XK/QDnaHx2S7CACTXhQIAt5w6BuPzdTO/M2RRUKK
         j9g/e+SaCra2GGt7Am2krBzRNaujN4FspC1ZQLMgY6n3k+F4+hKgxSgqwA3dg9MzX+eg
         nHtGWZKIWpxy4FylVcs9NQO3nmYEnYYU1sUwKPH5UuhTAor7O8m2rHorMBLbELiKgrKm
         f6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725348873; x=1725953673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+dH+RZcHjqpxSRHc4esw3Xc63l/7rMXelYdHD7/OEg=;
        b=lFaYHGJ07vDFSx5GWuC/lS5XHU/R30g01TQFDwTr4Wh7pE8a+dMgb+IcXzYubVG8Oz
         WPHIW9kXz5QGssKA/gAP/KqjTWmxd3f9FTeglzTiFwFk12Mq5Rn4Diqx/GKmRnvjZNF5
         3RnAtR+jOBNq7WEmsx7LRWJj9/qdZLID9l5TtLaBMkWjSiAcDuoQlxdHVLUzS1SUo9JD
         hzvD04qrxD63GJIbO7jLs0SCDKbrRFCOU4oP7la5m5/SGltL2IN9fpBSeBGwlJzRtuAq
         4o0nlMoOZNSwFhlqtVqAsWt/uttTW0T4lI8Dmli4LRQArCEAnACAGGOOp5BDki3FGx9f
         jlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUmar8gTXp7HiVg+SDeZ7dreomur2EWIxf2JLfHwj+fc2I6ESnwMitYxrdn6jTX5DrX6cUntlth+5ORZXNMvuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8fU8WJJoVAAmC64rBSC04cxq3h9ITfaMGjUih2v1tKOEvpUr
	BMoTatR+XG0YeGCslB3cMbfM6vL/VyCLcICtm8Krp0F4JbmTvKXy1bDFLA==
X-Google-Smtp-Source: AGHT+IGJzk2s833FOAhv3iQ+NXrcUphB8UFBJbqARLNqBkNgWxZmJHzascz2RqQ5HEAgCCg2DhlkGA==
X-Received: by 2002:a05:6358:6f82:b0:1b5:fcc8:49d0 with SMTP id e5c5f4694b2df-1b7e37a4fafmr1740214355d.2.1725348872849;
        Tue, 03 Sep 2024 00:34:32 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7176882e523sm1172980b3a.164.2024.09.03.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 00:34:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 8/8] selftests/bpf: Support cross-endian building
Date: Tue,  3 Sep 2024 00:33:05 -0700
Message-Id: <419d9f3b772a09f1db62b9bc484cb1e69336a444.1725347944.git.tony.ambardar@gmail.com>
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

Update Makefile build rules to compile BPF programs with target endianness
rather than host byte-order. With recent changes, this allows building the
full selftests/bpf suite hosted on x86_64 and targeting s390x or mips64eb
for example.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 7660d19b66c2..1f21d3a0c20f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -442,6 +442,7 @@ endef
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -469,17 +470,17 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $4 - binary name
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 --target=bpf -c $1 -mcpu=v4 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
-- 
2.34.1



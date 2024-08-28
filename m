Return-Path: <linux-kselftest+bounces-16532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831629625A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56CA1C228ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257E16D322;
	Wed, 28 Aug 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISSdS8Dz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B71714AE;
	Wed, 28 Aug 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843563; cv=none; b=abWPKkI6q8Jq7O1Axoh97W2hCxli67UvBbcexnrK4Ygk7V8QPrKL1x1vb7/GuX1s8J7zVgfB/Lb0/x1QRxTS+UgcAtOfGUArtYD1nok4XqoiwE+lLk4PD4KhjipIHAuEfXeGz2SdiK3y/dv3b4YNQiarLsQ2fl/qWbUuFn551Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843563; c=relaxed/simple;
	bh=Sf7g9q6kzZ2QDVZ42l9TEK1MrgR/netlPt93lP7g9x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEwQWP92pHyIu0qSMAQpvBAIwEiwyqtkMIScHYbr3RIqyf3+znUNGXDTglFiueKs+rcAmzFfamqFlyoEFLyYj8LIiTkoDExXlzfqt/gZvIJGCW2UmfsxxbzjXm+pzoxrwwDBAsugkPbjITbmJmriWsSJnGasP6Zdj77u8M4jIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISSdS8Dz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202089e57d8so3325455ad.0;
        Wed, 28 Aug 2024 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843561; x=1725448361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRgUXWe8dZjfzs16xzJQ+DDVhbgl0JeJ2Y/m+gXLXrs=;
        b=ISSdS8DzI8110ozIu8QxgiWxgd0mTOEPnauxbOHT+4gRte8p5Yt6RIkuL7DJAyJhp4
         SuR58+B+6rpeSM2EG22WtHrJ08JjNa9Mjae0oTmNtW/4y8Fzbal66ECUzunjrg2lZdS5
         k8E9avWgAwWPObYU+38aSx28OmL4sM/M7KCTD9N/NL7ncO6IdcFC1vHMWRzOngvo9OTR
         LNTlT4JeH2IV+/KgnR98DqXMFc2teJsGvgO0+U8xPnWhhMupXT1db9MH+Z9CIpc03PjN
         gUwW/LfXSyRKJuwp4BK5j8+ZpILTbFVsp/cacRmv75bx4dyVYrKHSOmf83QQXTgvv9e5
         34CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843561; x=1725448361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRgUXWe8dZjfzs16xzJQ+DDVhbgl0JeJ2Y/m+gXLXrs=;
        b=iADBLC4nEnCLUBkDq/tImqQ9gT/kylD2Np4bT0ocLbqeT+C9+Sf8LmOQIuPAC3XoJT
         HRPnt5kDuIOLLlc5zmr78GJJFs6uPDuOeOKF2FQAjlEboXOAGLzSs4k5JNYNcDZh62nO
         InBQGoFPfN6CbL+MGBRQ8Ltk+z4Ubykyv89JoFTTtuFPwHg4/5PnRJYG/k3Ie1l+mpni
         /D3ATWst5qRI0+zQly69chdOV0PLmE07asWq1hP+cco1IGtEpCPAAnPGgpyz2yS+3uVz
         gSY2M6ch8P9Y5NWd7CxdH+u7BD6WeHc0yi3s5PuBk2xUwS15D0+GU7KqL9wljUQuKkny
         7P3w==
X-Forwarded-Encrypted: i=1; AJvYcCWqbU7cC0GPNeoUtiG4Dtgy/EhNUcA6VzrNYBsgDRgXKzUiXF9PdkAUgvUdbt3pQBQPwMIJaN5KjxY0QxLVpgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJd9yasQeryRRLdOP7VMpcIsRFidb1l9HFL4+cAnd1+gC7yMu
	icHbznWWgoGvEIMUzrA0aWEYNrREgJy1ft2+NlVCe4oYwHZfMkw01CoKTrC2
X-Google-Smtp-Source: AGHT+IF17LvQdX0nlvFZv3KKEyPcd6PlsJDl18GzJgHep9e1plVKgnsJdA6JoC+HEGZBVhHkx/ONuw==
X-Received: by 2002:a17:902:c94c:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-204f9bcea59mr31930845ad.15.1724843561136;
        Wed, 28 Aug 2024 04:12:41 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855678f9sm97369395ad.1.2024.08.28.04.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:12:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: Support cross-endian building
Date: Wed, 28 Aug 2024 04:11:58 -0700
Message-Id: <524c7472b9c5b0a5f4f6f415975807a23b9679b9.1724843049.git.tony.ambardar@gmail.com>
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

Update Makefile build rules to compile BPF programs with target endianness
rather than host byte-order. With recent changes, this allows building the
full selftests/bpf suite hosted on x86_64 and targeting s390x or mips64eb
for example.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c120617b64ad..27afbfa9e831 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -438,6 +438,7 @@ endef
 IS_LITTLE_ENDIAN = $(shell $(CC) -dM -E - </dev/null | \
 			grep 'define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__')
 MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
+BPF_TARGET_ENDIAN=$(if $(IS_LITTLE_ENDIAN),--target=bpfel,--target=bpfeb)
 
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET_ARCH = --target=$(notdir $(CROSS_COMPILE:%-=%))
@@ -465,17 +466,17 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
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



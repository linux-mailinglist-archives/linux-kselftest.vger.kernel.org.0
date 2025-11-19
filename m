Return-Path: <linux-kselftest+bounces-45948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF9C6CC1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 05:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BCB222CE61
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 04:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6028307491;
	Wed, 19 Nov 2025 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J5WDVEAR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3E3064A5
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527094; cv=none; b=i3G6BQ+e1NVh68CTkN0DzGQqDPitfXskK5oZyL0Zne7+eGrbyMpsVay/GhzT8JmwSzHfPYOSJO1WzH9Pkoa6ZHfZSXua5xMRpkruf/URPXwpraGzf8bCy6JkPX965IQMDmSw+QOITZBO279CYBsYkwH8plFkg2Kl494CUmuhEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527094; c=relaxed/simple;
	bh=C5jSsTgvkALL9ejzqmPQgB6rWH7GZHKRGrQ29813rEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/4P8XtG+d+7UxnSZDkjH8UHDYq1IOkR41MwH07cYp25uY4+GuZUmELGuqRqUe7UWXh2Hhgtge564gS1kgAsKA65EJah7VMCR9bvTd6qBJL1PVQry+4tth0btASaukU4aQhP2EmEjW4XMGmbJeWoMWN9bsi2jnDOvhk9wwvr5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J5WDVEAR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3720e58eso5707731f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 20:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763527091; x=1764131891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=013VvflcLvdlThJ17BkVnV7aFyDVxc9/Iz9Z2M21yQ4=;
        b=J5WDVEARPirjQxfx718S3tk+baK5IC76Yit7U174BzHHy5wQB0t00/E5Kvw0fZiM3e
         I8/fqP6/kdTbOpIbZ9C82GZMExP7cTGrqMpVk8P3oPrWANtbQmQlr2xcDn4Pzy+NiLq2
         phPDjrDJrPXrJPrrHa7A+Kv5wykA1GSMbS33dUTKytl4SUDjQ+iXPENDa1Y4G7nhNwob
         7yJ1hScCwhu3CGNgpEK/wOOFlM5f8Cn1/rS8QY9xIAGEf9iFCtFRefsVaoT8NJZFBJ/y
         ede2nitFyB7yqTbaYMKI2mygFfSftegFrSdL4ILiizPzcAag+I+n5rrr+nTr3RTlp3ii
         arAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763527091; x=1764131891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=013VvflcLvdlThJ17BkVnV7aFyDVxc9/Iz9Z2M21yQ4=;
        b=fu6PolTARa30cMrnFCAfjSRnYqOwgGSjEYWHAe1x1lTH9U4noa61D74UHmax14DNtM
         GqFfpuqVb9FIbrcknv4K7SI1kbpZTrYwOCo7ZTj+krA12qsDc0CjRyXMk+MEPTyf+j8H
         TSfcnrhH/NInFr50XBKqIPPIn1RfyOcUM+Z86G4kpRoYTFcGfOhkUXjn36TKt/AZnFyq
         dbRSBhqYOxCn0c0RE+dBcY7ZQi2Kler6qgsakgPgmQOSJZWZ9FsBQFqlN/TduJ3sdAnf
         SRJcArQ7NlG8bXbp18LlmkUYDxka0E7RH9nvYyz050B5mIxGzUpn5wjewKwXmOWugvvM
         TYew==
X-Forwarded-Encrypted: i=1; AJvYcCWtWMeSieH/mqaPtkytSUTiAW1F7bjbbbLdnRQGsBQ681kylCIbtISqktqsJTq2BD1CM+80MZVMr0fCe3SR1K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhan1XUKf4GPS5GnnDxCbQlkiKmzdviP9mgGU5V7ZUctm33aDG
	Cc9/5PTCssB0S0PtHCM/Ea1+M6Df/sDkJFY7Io8M5gCemvKlWilK9J0ur6WCEFae73w=
X-Gm-Gg: ASbGncvuaYcz68+pq8+z6jm9wgDFUDknrTEp5mppZmy/Z8BZ16Zx/Mv+D8z0+XpqkfG
	OBZL0MZM/epozc/32kSVdZy7q36zvRU046LwrwTp7EW6ZNFZ7ocp+k2vcZfozN1m7f+78iXKdUx
	0ruSV8lmJbRYjFlz69uDmyMrifWnqG3RCcdojHJ0ML03ZVtbM8uGHPkVszxgyConiyDESvjzu5v
	5uWblVYK+2Ih4PLQzETUP5fMCBvg8bTyzN796QuLIO/Y24StQSSWjN3JuIz5VvfzsKuf/9X6lKC
	Nsb2gqIWafKlvKZ4mJC90UJxkKpqEfJUw0EYveBVCGvtil6MugcYgNl33vnra37SB6r3oTedUp/
	QKAIWghAz2GwLX6ew2mkqLzh/bDxC+DM6uSSKD0hlxv+nSjDMmbZvv7SFbYif6a1yJSPhJN1M6u
	K3VWD581Y6EaQPZCHdvzSfIJxyQ+dRnH2yF/BjbnmNBH7GMSJe4nwsgVS5JJvZ
X-Google-Smtp-Source: AGHT+IFgiHdEgYchAFUbIZ5BWc3G8XCUjTmDiMfuGUz/BhBLX64rehASsPYNXoMihhYrAXRp+ZdMsg==
X-Received: by 2002:a05:6000:230d:b0:42b:2dfd:5350 with SMTP id ffacd0b85a97d-42b5939e2afmr16870012f8f.56.1763527090754;
        Tue, 18 Nov 2025 20:38:10 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf1ddsm192241165ad.92.2025.11.18.20.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 20:38:10 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [bpf-next] selftests/bpf: propagate LLVM toolchain into runqslower sub-make
Date: Wed, 19 Nov 2025 13:37:39 +0900
Message-ID: <20251119043739.1860428-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The runqslower build invokes a nested make, but the selected LLVM
toolchain (via LLVM=-<version>) is not propagated. This causes the
sub-make to call the system-default 'clang' and 'llvm-strip' even when
a specific LLVM version is intended.

    # LLVM=-20 V=1 make -C tools/testing/selftests/bpf
    ...
    make -C tools/bpf/runqslower ...
    clang -g -O2 --target=bpfel -I... -c runqslower.bpf.c -o runqslower.bpf.o && \
          llvm-strip -g runqslower.bpf.o
    /bin/sh: 1: clang: not found

    (expected: clang-20 and llvm-strip-20)

Propagate CLANG and LLVM_STRIP to the sub-make to ensure LLVM version
consistency across all builds.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 tools/testing/selftests/lib.mk       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 34ea23c63bd5..79ab69920dca 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -306,6 +306,7 @@ endif
 
 $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
+		    CLANG=$(CLANG) LLVM_STRIP=$(LLVM_STRIP)		       \
 		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a448fae57831..f14255b2afbd 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -8,6 +8,7 @@ LLVM_SUFFIX := $(LLVM)
 endif
 
 CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+LLVM_STRIP := $(LLVM_PREFIX)llvm-strip$(LLVM_SUFFIX)
 
 CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
 CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
-- 
2.51.1



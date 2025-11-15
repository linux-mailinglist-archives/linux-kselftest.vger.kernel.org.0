Return-Path: <linux-kselftest+bounces-45697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C9C60C5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 23:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF135A78F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B026A1BB;
	Sat, 15 Nov 2025 22:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xamextw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535125C809
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247420; cv=none; b=ThDmZqOICDxJqaU7kZDkGYsQCybgITLGV4JGvLTY1kNBgjAm9HFVpOX1t9sgZN6m8OFI8AZOezvnYVptrkZ2T71/aYfpVTUNdsQnJmfiATdB7SgPoPrNsUhFqOzJhWl6ni4saBpwoL9OjBIb1MylR9TU5iuLTIEYcTtveSA90Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247420; c=relaxed/simple;
	bh=r6WDjhpIq3Wd/J0Y+qOKRxylI1swOi5e1ZWkbyl+O9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge1HGNGghq1PKuMF399r1lwAaUaketrFNo16olIKjrqliD63DNJzPpPF0FcYWGJTg4FVo/l9zWXbjs54EQEyqRn/kIooFT8uiyXaT3o4r8KID5YuMKxlXnI0blS1V1l8sMXGV4HJR8jEE1jEJhIlbqXbURQWt/foInqPL4ymmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xamextw8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710022571cso28963295e9.3
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 14:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247416; x=1763852216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoQmqXz6sGsQU+5pMM6WGkJhNb0pQ0+RIfWOvYniKT8=;
        b=Xamextw82DwYWSqntdG9MeMF44K+zJGdTXjxlixvbMixa1LhzCfuGxJEsWK8y2wffB
         p8mjHPGSVyfllguJ3rxr8mWceC0E7Y1YohNhq/clTwaucKbqJHsvENTxExIKfvj4twiS
         06a8yRjDgdL3jdN/NisfjIq5LJZPrpyo12Tl3olydU+1ONl17WnU+kkpsM0zZRtMFexl
         WP6k7gwJOy5wo765vt48hGQxR2E5NEV6fXWzsMVnsemlDYk7uAsQa3GWXyvoDzv21L23
         /QdVzggCCMbclhpTBCK+HNCv5CJLshKWHfeXwQE4ApvmetMo3rWkaEC+RI8++StGcoG/
         m1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247416; x=1763852216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VoQmqXz6sGsQU+5pMM6WGkJhNb0pQ0+RIfWOvYniKT8=;
        b=nSxLi6KcQYa0o43VyKoZssk+1Yp8Y7bNMX7tJj5qd6eIuhmGDTs0Uh0X9FB96+faMa
         lgRxihRHlr4ik800lFyjGbBCTA3x/DfsSFLDjdPvsw4s7N9IxN03JY57LGSxSfj7Xpnt
         RGRRtQytKizntLvQdpodKPpgM/j13y7gDqvKuEtYV+eq0D/qer4YsL7B8wqmeMlGeXyl
         qzcw7ZTbn2DkN27RI6cu+lDnT88lXxWM5ySSRqeNQHfxGGJDlRKFuM42d8lxdMzUCGWG
         UNdl3gWoJOov7LyztehvL3KAIDu3WvzWcK7a9d00ezB/Wn62H4y7JNooUENK7dU5zt15
         j90w==
X-Forwarded-Encrypted: i=1; AJvYcCUVH+FJ+z6TYGYMCUiXUjg1v75W/jW4BGbHWfFtAiMumPKLjClDpZNBB3eE9iHnN7VuN7ZsjId1hZHEHFa1+7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDifeyGMZ5CnGcujR5RqUM8mOf6vSamp/y5wYrp2xAzvmbTDV
	eGCk8c390nFlhGIF8e2EHaVHcifw4bdbCoe7QD3d0Jg9ZgBxl34TYiXooiS2qV8u6+I=
X-Gm-Gg: ASbGncu5XOuw+9dP/b1Dax9s5Z+RVnP9CXHD3ooIuuO9RqWjL388hfepdv4O62Ieed8
	1OOYWlDN5Y4BUCOjtW+eSyz828SEHK8U/tHf2jxSBFUhuDyqCM+IaxJ7Qo6dwzRVJ7W3igPcai3
	rBjqHuMEHCAKU7VS2HpIdCQPgXN7Nci6Fc7N6oeWJv7lr/cFoP1V/PEX9CuClcDj4tgHgT2O2/U
	GrzF4eTXmBrHRCZsB0JXb5SaQX2YE3NinI86tSiZY1UoYTXfMZgA+9nNYtH2HtKfA4mbSiIZLMD
	TFAbRha6X9FtVcNWl9rFj5GDFkDJqMsi79uuhvxIv86vfn9fQkOdXcUMvXt/cyuCFj8UQ8u6nkG
	VcxLWhKGYzeQgas6kBOuyYuq1Q+CZ5nO19WL4k9oIhr3FrTgNilKbHXPSgUjWkIEXsVVuUkmJKf
	T+8HgcPgGC9rW6Zf5+tzEWpkayJQWAlv5qz7xD7tbf1cDkAhK56w==
X-Google-Smtp-Source: AGHT+IHzTCVjlD7bxRYPCcVQyJMUetvvQL/GhvoPlqWuHIenUBMbxrAsm/jIQ3IT68GtJnvxF1gisQ==
X-Received: by 2002:a05:600c:3b19:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-4778fe95fe2mr74546895e9.21.1763247416137;
        Sat, 15 Nov 2025 14:56:56 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:55 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
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
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [bpf-next v1 5/5] selftests/bpf: propagate LLVM toolchain to runqslower build
Date: Sun, 16 Nov 2025 07:55:40 +0900
Message-ID: <20251115225550.1086693-6-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selftests/bpf invokes a nested make when building runqslower, but
LLVM toolchain version (clang/llvm-strip) is not propagated. As a
result, runqslower is built with system default clang, not respecting
specified LLVM version.

    # LLVM=-21 make -C tools/testing/selftests/bpf
    ...
    make feature_display=0 -C /bpf/tools/bpf/runqslower                        \
        OUTPUT=/bpf/tools/testing/selftests/bpf/tools/build/runqslower/        \
        BPFOBJ_OUTPUT=/bpf/tools/testing/selftests/bpf/tools/build/libbpf/     \
        BPFOBJ=/bpf/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a    \
        BPF_INCLUDE=/bpf/tools/testing/selftests/bpf/tools/include             \
        BPFTOOL_OUTPUT=/bpf/tools/testing/selftests/bpf/tools/build/bpftool/   \
        VMLINUX_BTF=/sys/kernel/btf/vmlinux BPF_TARGET_ENDIAN=--target=bpfel   \
        EXTRA_CFLAGS='-g -O0  ' EXTRA_LDFLAGS=' ' &&                           \
        cp  /bpf/tools/testing/selftests/bpf/tools/build/runqslower/runqslower \
            /bpf/tools/testing/selftests/bpf/runqslower
    clang -g -O2 --target=bpfel -I/bpf/tools/testing/selftests/bpf/tools/build/runqslower/ \
          -I/bpf/tools/testing/selftests/bpf/tools/include -I/bpf/tools/include/uapi       \
          -c runqslower.bpf.c -o /bpf/tools/testing/selftests/bpf/tools/build/runqslower/runqslower.bpf.o && \
          llvm-strip -g /bpf/tools/testing/selftests/bpf/tools/build/runqslower//runqslower.bpf.o
    /bin/sh: 1: clang: not found

Explicitly propagate CLANG and LLVM_STRIP to the runqslower sub-make so
that the LLVM toolchain selection from lib.mk is preserved.

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



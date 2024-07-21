Return-Path: <linux-kselftest+bounces-13971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA359383D7
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 09:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B1B20F1A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 07:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BD8BE8;
	Sun, 21 Jul 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boi1Dw1e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFFC79E1;
	Sun, 21 Jul 2024 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548290; cv=none; b=R3aRAxCoWve+LQbaSPa8gNL+7qAbwujUSCtZT8nxfk1FREudMEgR1tJRfERGZ7pTL1FMmiDa0EzSDTZzArF5wiZ3au1wzFUxa8/S2Bp94psiBup7GeYG9mKB7qFeaklDm6uSCbmD+SKGkP/q2titPZGaeYXh1JnY2d8kTizyK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548290; c=relaxed/simple;
	bh=gaYxMpVWcmx+rOqEfDteNR28R+GSm6Eq2rwKKxUzbOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evcon6LJSVKEq4lBVqEdBjwSFhzfxTsiQiwcVnqk93P118/S9uH2qa7LA/sB6HHDZU1u7Ff0VdYMK6j9Ov0y2VAMQtPW7DGixGKn1dPAQeZrq7kVGAplz0FvHZ9GKHitTeox1PouLYTC/0yWGii/qgqrFQq5R7NZoAAGk585CnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boi1Dw1e; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7039e4a4a03so1872927a34.3;
        Sun, 21 Jul 2024 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721548287; x=1722153087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJQywKsVLTGkJj96t5HPgqXogiWsXBHjQ4pVqiolOiA=;
        b=boi1Dw1eXBIwAAnaNqOVNlu6RvFIADHUN7QzTHp3XuLLCvNRNuY3nNOiFg0lVG8flY
         bWlOy5YLgZp8te/lgihkVeyfF1RG2JByOJqmkjAaD9wrUb8FIMdNg1gQnFoBTYSNCrCU
         E6HUm0IfnRtFbU51o2WC97hECDjonPALXEarpgk9G8sguJFK3tEcxUxRNWbH4Ynjt5IA
         O2bP4zXcKXtoeMlXMCI0iZyvpME3xa9eaewCRHTePtTMNzRzqd887H5676zYQ3WtoWYk
         DBleK/sif2/uIHtuBhOGYeb/72A3iSaW86le8tT+kXNQBrAmV1p3e82GXhLnMWylvgHq
         GJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721548287; x=1722153087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJQywKsVLTGkJj96t5HPgqXogiWsXBHjQ4pVqiolOiA=;
        b=ojBcuPoNVdYth4ZNq/qPrme6YkpGCQ9zft89ll1II08s7YF/9VlEQUMyg8lc8qzcJJ
         vgeNLwWdleLMOHMhATWaq2viLgIEBSKSVHErH40VhPIaSfW62LaUM9uUNMvnMQjiapmv
         3Z+MACYL7MjSy1ostMO97mhrCP80x/kdVmr0kvwPn914DxwHioxcCGaC9UVsoM0aoj89
         75M86qsL1C7HBvjEocsymu/yqdz5afEFIP/VIvwvVqg0v8X5Wf42ko4vs7XRhs9Nrc4A
         WLGZwq+Yro3iRZfg2fPB62EDMOO6q6KPMXRb5qtnihHxZIu3Asrq+Ey0lwJ2Gyz9XRjN
         vXVw==
X-Forwarded-Encrypted: i=1; AJvYcCWqHoN8PRBa2tzS5nsUVnt9d19ABLmzr+EtLCfizi2P26uyUhRtNeU/45a4dG20JbCaHJXrY3ETLKnO2RLpcyN4i1dPYx4uxzoBc9Bg8Q8B
X-Gm-Message-State: AOJu0Ywd/oIgp0Rb1ccFPpOrnprvRevpTm0REzKJD7lESruGKEqPOVoI
	+Mi7hENQgOYONSBIaRojLG7PdwsCkkuTCfH4ItgayLpMBGgv9CXps4e+yjbr
X-Google-Smtp-Source: AGHT+IHyZknbTH8JzZ0DBAXddWaqGTScHsdQoQIRzXgZQjrRSXuaJtlcKFugRdnjwp+6o195YTiYYg==
X-Received: by 2002:a05:6358:7e53:b0:1aa:bde7:5731 with SMTP id e5c5f4694b2df-1acc5c3f6f2mr522463755d.24.1721548287256;
        Sun, 21 Jul 2024 00:51:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77504952sm5760591a91.40.2024.07.21.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:51:26 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Fix error linking uprobe_multi on mips
Date: Sun, 21 Jul 2024 00:50:56 -0700
Message-Id: <7eeb1a1a9910b30782adba9eb5cc47c6ce075223.1721541467.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721541467.git.tony.ambardar@gmail.com>
References: <cover.1721541467.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linking uprobe_multi.c on mips64el fails due to relocation overflows, when
the GOT entries required exceeds the default maximum. Add a specific CFLAGS
(-mxgot) for uprobe_multi.c on MIPS that allows using a larger GOT and
avoids errors such as:

  /tmp/ccBTNQzv.o: in function `bench':
  uprobe_multi.c:49:(.text+0x1d7720): relocation truncated to fit: R_MIPS_GOT_DISP against `uprobe_multi_func_08188'
  uprobe_multi.c:49:(.text+0x1d7730): relocation truncated to fit: R_MIPS_GOT_DISP against `uprobe_multi_func_08189'
  ...
  collect2: error: ld returned 1 exit status

Fixes: 519dfeaf5119 ("selftests/bpf: Add uprobe_multi test program")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a9c447c63fee..0b4bfbc0ef68 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -784,9 +784,12 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+# Linking uprobe_multi can fail due to relocation overflows on mips.
+uprobe_multi.c-CFLAGS := $(if $(filter mips, $(ARCH)),-mxgot)
+
 $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
+	$(Q)$(CC) $(CFLAGS) $($<-CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
 
 EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
-- 
2.34.1



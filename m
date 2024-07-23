Return-Path: <linux-kselftest+bounces-14031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD06939756
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1350B21CCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 00:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C4CED9;
	Tue, 23 Jul 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaJQswgR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6D367;
	Tue, 23 Jul 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693652; cv=none; b=TzB8BCTo2Av1vioGu8lyhZAFj+vGmvQHL8/ZHPZIATCuX89sblvNKzL76F30TBL0avz6mxcU7Hegkj/whWWZwDVnCVnWVvImWOcc28QAYv5f0r57sA6uuOFzKRVqtr4NAbIA9Qlcv4cr0bQg8jJkvoa7r3mNNfgmuS1Wb5YtYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693652; c=relaxed/simple;
	bh=yNqvLkLdmItRNrlqWRMJ9OQAo/hWme8VonLmIuj9wck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSKCCff/Y6+utmIAw5SFvD/i5nmM04n2aQsIwc+FVr7+Tz9+3hKwXB8+7w/e+zm5pyGZ6Ye9f+V3Qo84wqpbo44cM3EPorPlJV70TTXv3n20ThACyc8AC+GTzSBa/cr+RZC2Tx2cb+k4ff5vzYC0gSpg3+e58IuxoeEB6UZUpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaJQswgR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc5239faebso802675ad.1;
        Mon, 22 Jul 2024 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721693651; x=1722298451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZ5wt8LPl1ED8SmV39RI+AxdKFeRoDjRtT2DxDCCHdI=;
        b=OaJQswgRuQCgPFdBnaNSYwjzasuFbHw1K2iyUoCzAlkUcaiZ4geinVpSrsva3bckSh
         7kmK8CwPOcK0Osli6RXhWeaQqpw53cGhmA4NDFxARlMB5dmCDF7GO/NKW5gmCe7sIudA
         pOE79xUj58FegJIU6OsNDH95GAMF6+xlh0TyhcO9QEljEJySrHQmR9kbK1Zi8L+yg0b/
         85npTIFApiFBSJsnR57ghAAEHZ7+md3wm2KEfAFv8t64c5d9mP7VLb29vSjDZG+VWXUd
         wQOW6h4z2xnwIl/XWp9lrsWow8rwqnlushmQ9FhmO9ggRwlQLl3nYbvocsy9N9emUALu
         4eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693651; x=1722298451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZ5wt8LPl1ED8SmV39RI+AxdKFeRoDjRtT2DxDCCHdI=;
        b=Fo5PhoVAw0gl/22la9ZX9Mp8aL2bAONspQIaQV3vjTo8r+c06Ba36LU0fBV7/LYdHe
         WobZScLdXF2WvexkMFVGrBVXc9W5mId43lMewwAgeFQwWzsDYKayqZv0Te081473Xx0S
         3Oo6tchnYvt3Yprwv7+HtQmHOOO61LTixbIkd3zTBr8zCsXtM8upH/X0x6eNn4noAEQT
         7U5Ztv9R+8Kq2H7NsZ7uRx50+XfleZZg74XYuQe0zgKQKgfQmSvq42/163ON2BG9+9F3
         QRHrAZtvdXMesZV2cVPuPnMt3UUBc3DQAopFDZANRsYLdtBPvCtRRCRNoL1yZdUizSa+
         LISw==
X-Forwarded-Encrypted: i=1; AJvYcCW0jtnXfpf5tTNdyw50zi1AyYJMhP9Vpv2Uwov37MKfk8NjuROZ74+0XpZKT/HPX3YeoSfRPkIgiV4ENJZB/EkzTv5/dHKDcn7ahSp1NvN1
X-Gm-Message-State: AOJu0YzPUaNscIMM6OrKltm3DZgu+t22B78FgUaGWOHhCjLzradzrdO4
	4CATDvpUYSZPJIy/XXck2oLXqbXM1iFHmpwn2OUL+0VlxEK6IsNzYudEZ/G2
X-Google-Smtp-Source: AGHT+IHrOJFzXzmwYP6gm0u+D7NVm/ke4XvWTtjIvETGp7oJlN/edpQaCQuA5A1x/OKNnrnGGjzq7g==
X-Received: by 2002:a17:902:ea0b:b0:1fb:82f5:6641 with SMTP id d9443c01a7336-1fd7455cae3mr75992595ad.23.1721693650636;
        Mon, 22 Jul 2024 17:14:10 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48e7c4sm61395485ad.307.2024.07.22.17.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:14:10 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Fix error linking uprobe_multi on mips
Date: Mon, 22 Jul 2024 17:13:29 -0700
Message-Id: <14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721692479.git.tony.ambardar@gmail.com>
References: <cover.1721541467.git.tony.ambardar@gmail.com> <cover.1721692479.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

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
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 11fdf126cb7c..60a07605a162 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -785,6 +785,8 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+# Linking uprobe_multi can fail due to relocation overflows on mips.
+$(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
 $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
-- 
2.34.1



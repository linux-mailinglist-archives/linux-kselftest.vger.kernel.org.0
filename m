Return-Path: <linux-kselftest+bounces-19316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD6B995E6E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 06:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0720B1C21CF6
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032B414BF86;
	Wed,  9 Oct 2024 04:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY3GGTYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F3262A3;
	Wed,  9 Oct 2024 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728446853; cv=none; b=umvoxq+9W8Uy1EwHACwPdv0pRrIwYQtgJUaP2AGWUdsTYRu2QqZGi3MESm6EtfveAGTUXo7CwKAt4Yqx0d79FYZwZ+OOSCIxSVovFbioeQYpoau1EXqhRw7H8QhTAHk2n5OOOE4IQSP9uvfg2dSCaJPmTbvby3VbuUztqYGz4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728446853; c=relaxed/simple;
	bh=QcIT83wLA5rHMyAJXvwx5mgH/80wUM8fVFxLEhr3Wss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oPwapG/tyUh82267ukmDRSFumWJIVimSdft98x4uq5hzhrUL0PWzJ2sAInZmcJnrqULAiCqpPkxxpe8OLfPdIrcse5IOduiIRUCp941NWzw+RB5PAfr9R8PtpM+Q/7qwlGd+OEseIsgDmMREP3/sJcrJ+ZDifMU/Lbd1c4Z1hvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY3GGTYJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b78ee6298so40812465ad.2;
        Tue, 08 Oct 2024 21:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728446851; x=1729051651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSop8G86JoZFrUEYqIxsfvFqwFa4cDV0yEZA3jyJekg=;
        b=OY3GGTYJ9oLTWimr1Zt6BhFKhbVBS4HsI8IzZexobojoM5q0OFCn+9mEn4jDyWIaDq
         tFxCE9BFq2hMHMmAzJTI3LlrRM1sUbFv4QIF/cOo7AZnAbVKrPzRVbzx5xLUYDAhAWgU
         /LvFIgV+1fKwp+D6FgycZn3zgOnvbqmQrTldPRY3PEBZjFD4bTKVgJiRxOIvP309qror
         Di5xxxFwejchk0i+vD8d8FvO0QwHA/4Yc8zrSAytpPbd/gJAab0MxxO0JbSmiGwfEJcR
         LckRHsmzHsjv4cqkqrREzHTyD59ZV695yPigawI60bOQMythwgNYUkqytl2xUcnGMfok
         eBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728446851; x=1729051651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSop8G86JoZFrUEYqIxsfvFqwFa4cDV0yEZA3jyJekg=;
        b=aZDMXYxNBxFyBwl6pmnQnTX/aHq5xyBwt9PJLB3bz7OXa4IQUIGJdfzAY1yP+/1w7n
         fwrfftA81tSxbknC5noTHpeB7oPl+/7fGG3IYfePCFIeOWLDV0R+dcYojyN/lxNWqmut
         WRF/BoWPCtcSRkOa8h8h6wTCRwvfHih0ebKhlWfNpJvqGDTPjH0VdyvDjvqU1xdn80vj
         H+tkPnJBywSfPFqGRbGo0DafN7SJuu+FUCdbwiTrUGMo6y4LHtZqyHo/InZiZj/Yvoxi
         yjQl27cCSDnDo0i0Kyozyrcb4Y01MUG4b6j/v3m+8Fcp5gLofjDCS1DMW2ihuqJ56xEy
         XrpA==
X-Forwarded-Encrypted: i=1; AJvYcCUz0ZdWQIITr+vDXADKXrL9ZSFiSz7IY06IcWQoSGWt6vrxsr2Y28ZZMyoF9WCp7ypknNHkl1MMMTWDErD5RuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCOHL3MeYucrm0KMxo3JdbOBKvhv2idcBDencHm1V5zJoD8Obg
	pwyr60D+6tLzerJGD7b8Efb3bH8LfQeHlV/VwlQ56Mdi3Ey1Q1dB6Lpd0Q==
X-Google-Smtp-Source: AGHT+IE4nzLu5Tb0Ubptm/o6ysbFE7cIEce/3b1O8vGzeT7vxuN+KqKzAkP4C7SZW+DWWITz3tHGUQ==
X-Received: by 2002:a17:902:d4ce:b0:20b:7ed8:3986 with SMTP id d9443c01a7336-20c637351c6mr14928155ad.24.1728446851399;
        Tue, 08 Oct 2024 21:07:31 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c5b31d130sm14177315ad.303.2024.10.08.21.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:07:31 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
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
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v1] selftests/bpf: Fix cross-compiling urandom_read
Date: Tue,  8 Oct 2024 21:07:20 -0700
Message-Id: <20241009040720.635260-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linking of urandom_read and liburandom_read.so prefers LLVM's 'ld.lld' but
falls back to using 'ld' if unsupported. However, this fallback discards
any existing makefile macro for LD and can break cross-compilation.

Fix by changing the fallback to use the target linker $(LD), passed via
'-fuse-ld=' using an absolute path rather than a linker "flavour".

Fixes: 08c79c9cd67f ("selftests/bpf: Don't force lld on non-x86 architectures")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5e366f2fc02a..f2a0f912e038 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -263,7 +263,7 @@ $(OUTPUT)/%:%.c
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
 LLD := lld
 else
-LLD := ld
+LLD := $(shell command -v $(LD))
 endif
 
 # Filter out -static for liburandom_read.so and its dependent targets so that static builds
-- 
2.34.1



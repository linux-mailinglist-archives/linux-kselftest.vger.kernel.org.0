Return-Path: <linux-kselftest+bounces-13970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9749383D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DC21F213BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Jul 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F58F58;
	Sun, 21 Jul 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/bFoAWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA858BE8;
	Sun, 21 Jul 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548289; cv=none; b=mx89KsKK1wQbJBebXIHXnZ/4KhZFFbqumj+LOiJrC+H0rxBXrmOjuYt196OGSRFlG+FWBCXepMdlAYBRJsi6r3HTm7Sh14iB+p0/dC3kZcQ9S6lNn5N8ToOyPMJ9Qj5BRwtp9mV7bX4Pb+GFLFQ/KiluUPPoDfoXcU+9oVwVESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548289; c=relaxed/simple;
	bh=B6lUOt+PP/bDbLGKNJb3ArjgmotFRT99qQSyBdII5Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SoAKuEdnAnvoSKCxdgPyWNQ3/ObNXCfH1l8S3smcBF/NWONL6txuWA94ZUgoqbZgVumZ1Y4Zkb4dm+pq8PF2k9TPVDf1RkgroTKfIYiZWwJxWU4+obzwJUtXrCyUMXGn0n12CcKMFiVXn6bU3X9364oW6/Bz0SAzBiodZzKkrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/bFoAWf; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d94293f12fso1976968b6e.3;
        Sun, 21 Jul 2024 00:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721548286; x=1722153086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6LzMCmGbeJ/HEkNuZ799gqzE3W9WkErKluYrr3obHs=;
        b=X/bFoAWfbFveuEY14WEljCTyvfqkLiHzeTiY/fWSotfcgS9PNqQXLBw7XC/HY/CbDZ
         bOiWBiVPHKYATCTnSZjw98O/r4hGl+XZuS0a+U7NvVBZauExOQ/5+4/bpQL5cY2yBsQE
         5J57eUOfCIKDylDvGFLaVtaqABwU8gJkyKKcrMdGCxTfQvlf4O9WiWOczZLRa02Z/Nf8
         I7dPMbKn5McjaPQwQTMhiaS9WDaDteqOtrPgf/+HZTmM9EAfYi8Ehhz5H6w6OoO5kjM+
         ZJOyJQQ1wNAwzGtud8R3dY1LuKHof3JibTQVOe6Peoko/uKCidEFS9xV27SDgOhmGNH1
         F6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721548286; x=1722153086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6LzMCmGbeJ/HEkNuZ799gqzE3W9WkErKluYrr3obHs=;
        b=Y15+e7agGO2QBzchyidF4tbnfMHquhcVP3sucYTlXYiQVS2bZR/hVaotQNKs74OnDc
         r2y5JzLK8yqq9A4aeUn/KK1AUPj4h8/J1S0ql0YsCGpRdgf2V/DFcvU1HOb4q8OXLOnm
         ibQ9B+DR8RqfJKnEyQUWdBfKLJq0xWUU7r5ufSAI6DGH0b+zok6lCF114oBGHykmCxwV
         S3yVqEeQcQOsq8yWD7KX6Ss6Mh7ILLyC3HknL9IonPLJK9xAZez2L2cUkq9QyfZSmaED
         QChYbSHD96E/1D1FbX7CfsmGTo1wSNd5J6iClB/SVReipNVLVNvSZZKAMOPnnE+AWkw+
         JRRw==
X-Forwarded-Encrypted: i=1; AJvYcCXtpe5X6FmzYsOBucKdpN6J4MeVTogw6+f6XBcs9vSmxGIu5+/cXVof1x5fRueP3GqiYwoGFzK+HWnEo30kxaM8//UJvEES621G3XQoT84w
X-Gm-Message-State: AOJu0YxlHtxyysIWJJvRU7tznge7dHKDibYZP0rsOYtdnlRdv1J2ghCi
	KMMjbkdE1wq3m4K2LBLX0k+MK8pJEpzvRn7+/Px7qJrWCXENFbNA16Oo2OyW
X-Google-Smtp-Source: AGHT+IETkihDjHFX5igPpFYFPJoT+9cQlgf7H3jKl5eX6fnQ6U7sQl5eTDEIRrr85bt7KYptpKG74Q==
X-Received: by 2002:a05:6358:6f02:b0:1aa:c71e:2b2c with SMTP id e5c5f4694b2df-1acc5ad5a58mr516096655d.11.1721548286333;
        Sun, 21 Jul 2024 00:51:26 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77504952sm5760591a91.40.2024.07.21.00.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:51:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Add missing system defines for mips
Date: Sun, 21 Jul 2024 00:50:55 -0700
Message-Id: <2451c21ef2a582de94e7fcdc32aadc02ff874c51.1721541467.git.tony.ambardar@gmail.com>
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

Update get_sys_includes in Makefile with missing MIPS-related definitions
to fix many, many compilation errors building selftests/bpf. The following
added defines drive conditional logic in system headers for word-size and
endianness selection:

  MIPSEL, MIPSEB
  _MIPS_SZPTR
  _MIPS_SZLONG
  _MIPS_SIM, _ABIO32, _ABIN32, _ABI64

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 05b234248b38..a9c447c63fee 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -396,7 +396,8 @@ define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
 	| sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
 $(shell $(1) $(2) -dM -E - </dev/null | grep '__riscv_xlen ' | awk '{printf("-D__riscv_xlen=%d -D__BITS_PER_LONG=%d", $$3, $$3)}') \
-$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}')
+$(shell $(1) $(2) -dM -E - </dev/null | grep '__loongarch_grlen ' | awk '{printf("-D__BITS_PER_LONG=%d", $$3)}') \
+$(shell $(1) $(2) -dM -E - </dev/null | grep -E 'MIPS(EL|EB)|_MIPS_SZ(PTR|LONG) |_MIPS_SIM |_ABI(O32|N32|64) ' | awk '{printf("-D%s=%s ", $$2, $$3)}')
 endef
 
 # Determine target endianness.
-- 
2.34.1



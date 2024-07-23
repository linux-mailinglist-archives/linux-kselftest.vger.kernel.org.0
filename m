Return-Path: <linux-kselftest+bounces-14054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B4939979
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81461C21A71
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488D13D60F;
	Tue, 23 Jul 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvtKGHrA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31113DDA7;
	Tue, 23 Jul 2024 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714169; cv=none; b=f0Wt4ZnSnD+5zyQc5TsNPROdZETqq+YAzANE0Y/g7Wtqjd1bpGXe5bOdt/AcWMgY6oe/kUHMWnNfPmPsiXaZtFhd6ASuHqWR17HhyM3mhjbnpaHryR0FUaBE/KTKdxqRaymZb1e2s/0IWw/7GWJBuO/m9ZbstW81AzkVujmXXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714169; c=relaxed/simple;
	bh=C0twfGdyjqX+3sEKcMBFDTvhBmdMfU8+ZG5M4jF0S6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNnxgYMdo/C6C82LirsJHlt4kyxRtm2R9i+aGugYGXiaZYBe1R7yAFNOV+5Yb/tfYctUtySNbPHsfCejMW3c8WOYzdBZmDLX5UaldQfJYK7akGvsXPfbRQDGvm8M415Lx5m9XWcmeYMzjSX+1utdIQ9prO+yo1D314e+5k5Lw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvtKGHrA; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so200756a12.1;
        Mon, 22 Jul 2024 22:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714167; x=1722318967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BohHnOX/Z4iOxB/wHzdyab75r3qCJZwCLvXmoeSZNA=;
        b=NvtKGHrA9RbrLIWIM4F7xGBGvlUVyDKkmGyr0UHIcMtXACmGfbi0xhEdQyHMj2k7cl
         zalscKtcZi+NrVx4HCF8QwkYg1YUODWugjrXvIERACHrs8+3P7n9BiMjJuq5/acZL3I4
         N1PGfuu0n8Qfy42uqei3z/IioRqdHCuTfThXBixkydN/QgC5A8oMpAbQ3Y9JWL3Z7iwj
         B160s0Oc4ZXa1UQ+nqVHTn+Ryw8SvRD6awvNXzpPoPatX27WbgYNe52BtHw84Owdca75
         aPzjaBRfK3SNEp8GdjO0LNiIGY+nlImN8Tw1lKAnqVGfCqzTVz4GH8RU1yQoSG44nZSj
         1jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714167; x=1722318967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BohHnOX/Z4iOxB/wHzdyab75r3qCJZwCLvXmoeSZNA=;
        b=LFZ/tYrPzEN3c12hBS0xCrLk8gktxmR69PwlVRaoiYJoKIM6ydFE1sYj3mMu0mm/CY
         yDLAazl06KSJENO1LS9ybhNpOZVVlei/1sXEnwIVM7adWrZpZ6TB47DJJ4685BWIJxb0
         wOZcDG26OkKtcEudjWyI9wdawL5JFP2jKBzpAzjGCx9quA75qr39+GU1zwvYiGqh/siE
         cdSJ332YQ96flPl1X/SFZ+TzCWKuspGzCls/Y9f4H0x49ae5o8X7WTdpN4g7ZAztqJvT
         8wzyXMl7IoW6KPpFEC4XB0FBQtwYm/oeDqOo5PAeFHvny1ro9W+VITYuF+uF9wcqTrkf
         56rA==
X-Forwarded-Encrypted: i=1; AJvYcCVcdoxQV6VpHKs0OHsZDBp52IDwfBROqhZLLK/XjLGKUDkcAHXaOWAsDewecxTxFhwSq0YJ+UInCG8c54ytTX0Dcmat2EMY3uODufXMCKB+
X-Gm-Message-State: AOJu0YxsRS6vAQV5NnSjNsGiHk+aGeehzpwWSX1lhyyxcVWfHUhqc/Qc
	1Iu8+LzxE5v4AD4CO6TcnLAx+dxZYphf0Ym+2+Fxp41lobQXgw0z8qnGAFUD
X-Google-Smtp-Source: AGHT+IEqo8YfSVOJTpDNsKy7OYxeevmwG+LbdoA0/rJc2X2efK5tqDzjFZ9YL7WUniC21IW74OkHgA==
X-Received: by 2002:a05:6a20:72aa:b0:1c1:61a9:de5a with SMTP id adf61e73a8af0-1c422914c69mr9633907637.32.1721714167028;
        Mon, 22 Jul 2024 22:56:07 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:56:06 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
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
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 17/19] selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
Date: Mon, 22 Jul 2024 22:54:44 -0700
Message-Id: <e986ba2d7edccd254b54f7cd049b98f10bafa8c3.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a redundant include of '<linux/in6.h>', whose needed definitions are
already provided by 'test_progs.h'. This avoids errors seen compiling for
mips64el/musl-libc:

  In file included from .../arpa/inet.h:9,
                   from ./test_progs.h:17,
                   from prog_tests/decap_sanity.c:9:
  .../netinet/in.h:23:8: error: redefinition of 'struct in6_addr'
     23 | struct in6_addr {
        |        ^~~~~~~~
  In file included from decap_sanity.c:7:
  .../linux/in6.h:33:8: note: originally defined here
     33 | struct in6_addr {
        |        ^~~~~~~~
  .../netinet/in.h:34:8: error: redefinition of 'struct sockaddr_in6'
     34 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../linux/in6.h:50:8: note: originally defined here
     50 | struct sockaddr_in6 {
        |        ^~~~~~~~~~~~
  .../netinet/in.h:42:8: error: redefinition of 'struct ipv6_mreq'
     42 | struct ipv6_mreq {
        |        ^~~~~~~~~
  .../linux/in6.h:60:8: note: originally defined here
     60 | struct ipv6_mreq {
        |        ^~~~~~~~~

Fixes: 70a00e2f1dba ("selftests/bpf: Test bpf_skb_adjust_room on CHECKSUM_PARTIAL")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/decap_sanity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
index dcb9e5070cc3..d79f398ec6b7 100644
--- a/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/decap_sanity.c
@@ -4,7 +4,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <net/if.h>
-#include <linux/in6.h>
 
 #include "test_progs.h"
 #include "network_helpers.h"
-- 
2.34.1



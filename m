Return-Path: <linux-kselftest+bounces-14047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1AD93996B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703291C21A0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D113D896;
	Tue, 23 Jul 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL4kaT/3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAF013D62A;
	Tue, 23 Jul 2024 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714154; cv=none; b=SdOKXB1K79fBduutLIDXT1KEDLjgXMP2egikJRw1Cos/1dml0vmpF0TAzZsWteLLrW2zIPwIxaWdTAo9TpVSWTJERX8qa0eJOTU3txXWSE0LIfKkPm7DprRsYMkCgx0UpBpvn6ydJravlFuHzro4MOEI8MrQ/vy6DXG22ceYoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714154; c=relaxed/simple;
	bh=eRuII98XViD/0dSwBICuaSw1bvM26bbH0s8DROk7gjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK/QqGFHqUiZ8s4jgvv96gro5bFt3jmmYhiKIeejVpvcIRPDRgyKT0upmm9mxa+gz9ZUPlz6Rpk71gS3Ijt60GHWsJQetyM6VRo3lVBwy1x+H8pQJj7HfiUTLzVfgDZg44x7dkoquUBq/znKYVMOb3dDh9V7tq/3b/PtmImhYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IL4kaT/3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa9ecfb321so2814675ad.0;
        Mon, 22 Jul 2024 22:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714152; x=1722318952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AL4DPYZgYlDk/NnjGykoigyFpJLr7PWYohg34iZoO9Y=;
        b=IL4kaT/3klHGnH7sveMkli7wqLvV0WuDjL4eCrPzROtphlSe+izAYDERHOVLn/0djf
         Mdn6PFlVHCHFq0rCMjWqtN52Z+AY9TK9VVdBipONZKvo1R1zctZWNJjleLU6Hv0XtqU/
         XOOTd/nimYsoRsx93H3DGeXlhjj+j4ugD/jUj2DeClJIBxKxsveSv5YdvEQ41VJtlkun
         HJjAB5j9WO2e2ZvjcGpdmBhMlL3Uu+NukH1F9KKqdojoAV2FW5w8XCWGGWv4s5yDbmAK
         4nmJ2rVfdCx1ioK2tCz/RL4PeNqkja/3dIImNafTNCGkM+BdBSf77Kk6SC4347V+R1pd
         AJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714152; x=1722318952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AL4DPYZgYlDk/NnjGykoigyFpJLr7PWYohg34iZoO9Y=;
        b=cvx99fgR5uYXJQMbmmuGCD9yoU6b5BrdrL1fm4RkFG7YE+KGclOb86EXJSoq6HtOzX
         wxEDKHp9HuNHr+UKuPaouEZrq4fbILLM/QA3O3Oc339L1sH1toDrIbiA5R+tbmFeisyd
         X0sPV1vFAUAtBN6MvyteHO6IWILeEyvcOCq4yDvlwlIeb+XsApXCgF9nOCkZB/D920nG
         GKPNKvLojBrkVhruya5p1KCRpyrl8Kq0ozQ/OaKzR9arLt/oO8wB1MaH3hyxzGc6liuh
         Awu8hW/fsxbXdC5ivOpWA/wMwU5dvLdUnP0vf2K2HOzveavYz398xBREyRSuKmGgOluS
         FQnw==
X-Forwarded-Encrypted: i=1; AJvYcCX9xlWbcP6k4Sgfthhh9AtZSqL+00/jrW9u00Y9lBDHMI+1eI3knvDEWSb0mTlSYJ4+RMGjjJHqKNWiA0Qk/Kpp7sS2Thi1Lfu7/++szOza
X-Gm-Message-State: AOJu0Yyx1J53K/uNMTullRd1eCiBtiTHJmQVK+QxOnZAOXRl/LAFxPNC
	/tKjDmdoUpez1MEtaU+SJuljDZ+oo9I7KOI/Ks9Etdo2Mqp8KDHovXH5hk+m
X-Google-Smtp-Source: AGHT+IFJXgCrXg14DOLfGGc9zK9VKdvI9JTGxiNO2X/ubUh2bDZA5w+vUJgLgjDVFvWSqyGmTMUkZA==
X-Received: by 2002:a17:902:c1c4:b0:1fb:58b8:2fbb with SMTP id d9443c01a7336-1fdb5ed65f8mr14409625ad.31.1721714151931;
        Mon, 22 Jul 2024 22:55:51 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 10/19] selftests/bpf: Fix include of <sys/fcntl.h>
Date: Mon, 22 Jul 2024 22:54:37 -0700
Message-Id: <8bdc869749177b575025bf69600a4ce591822609.1721713597.git.tony.ambardar@gmail.com>
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

Update ns_current_pid_tgid.c to use '#include <fcntl.h>' and avoid compile
error against mips64el/musl libc:

  In file included from .../prog_tests/ns_current_pid_tgid.c:14:
  .../include/sys/fcntl.h:1:2: error: #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h> [-Werror=cpp]
      1 | #warning redirecting incorrect #include <sys/fcntl.h> to <fcntl.h>
        |  ^~~~~~~
  cc1: all warnings being treated as errors

Fixes: 09c02d553c49 ("bpf, selftests: Fold test_current_pid_tgid_new_ns into test_progs.")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
index e72d75d6baa7..c29787e092d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
+++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
@@ -11,7 +11,7 @@
 #include <sched.h>
 #include <sys/wait.h>
 #include <sys/mount.h>
-#include <sys/fcntl.h>
+#include <fcntl.h>
 #include "network_helpers.h"
 
 #define STACK_SIZE (1024 * 1024)
-- 
2.34.1



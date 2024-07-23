Return-Path: <linux-kselftest+bounces-14051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F33A939973
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93DF1F22878
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82313D62A;
	Tue, 23 Jul 2024 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqqaTRbl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9E13D538;
	Tue, 23 Jul 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714162; cv=none; b=X50wb65i3p+YNA3qL/jDe7Qt/JeKJIbw/VylJcygbZ5G3f5ulqMwlJ6OqzJvMnG4jdQPpb7CwqSy3yYQn4GDkPHcCF1V/awzvvGNRJqn9vX0BGpXPEefWLOZWsYYlbqvIKd3KR14/kqdt5x3qalK50ep2ErvG9f5OnX0W3UC/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714162; c=relaxed/simple;
	bh=DCYr8+TNLq880CaFvxJA3qBBgZNRmV5ZkEVnxPOYp0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1iWul1HRRYFc4OywSKkCdtSymu5t5WraxFOy4RgEalzLaiyl6IJnHlHSEYX04kI2NYCsRDnOWkPZxFeszY4mD/zsVZTJiB/ecVPGRbXp8BzQp3LFZry5Z8uSIiqBG/YfE/4WeTqeFW55+ajGbG0tbNueidblQEPJWsR5Xr3fCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqqaTRbl; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7b121be30so197956a12.1;
        Mon, 22 Jul 2024 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714160; x=1722318960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG0y/r8wSyWzN+dbWbXqoKJWdEZ0lVRyZSwfEfFYx+U=;
        b=gqqaTRblCfRx8SXaphPiu3jn8dylghFXlAxL3Iv/H01T9Opayf6bLjC+6o1nQ+nEFI
         FQpaxh2qachQg9oDFdckJuXlacdgN8aIN0JQcmqVkkexERi/e2nwIORsBh4PJZ0sx1Dl
         hmHRqDbYv1E18drIzpOjv/BMyU17nxUZXCH7M9u/3BN04JKvkWjQDjXGe46zo0AdsyD2
         2sCOF9UiWm6/KE65+T4GW/+x5YZ1XLiVKBl4SfVoO2mnOF2kO8t2ToSOdPTAhu+9sS9A
         xKBTgZhMMoMKdqMIUuSgI3oPunadP6Hd0PJVdKqOek04w1toom3ZO4+8w1eCs1yfa+hX
         MT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714160; x=1722318960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG0y/r8wSyWzN+dbWbXqoKJWdEZ0lVRyZSwfEfFYx+U=;
        b=VngQpo+Qfmoyp38qqOWj9Xgq+KOhA8OcTte+QL10+n7d+oJhciI9aN0/3s43vH55Ss
         0eD0cP7KNlOQeb0/OUHO67R+hTbGoeKKdpLBYo8x4aAL1pnbxJfVKz48gO/LWyEAtRAF
         P9lFmz4mh5UviE5q+dRULlQDR85a40TqbO3LBT41Yfq2jY7Z+DCOvxcBSVX4ShwhOJLU
         B4yzFRbY4vHr8M8qCpRP29XSW2t+AVEou3B61tPKQlJ8QWst5Fc7tfoVzxVF+TNCzCCL
         byWu/C0hfr3PJ+1biIcbteMdzL7vL/QL2M17leXpUUBy4jURmaRGggWfQiMEHqecMZ3N
         7u6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0HluJ8JX5QwK63AjFDCglbASCZ7X3PAwx5tIzRMFUkdTpTY1UwVKHof2OdHEvePj4Y1eugKJ21XpGA2MVcCMTVudP+XOrfDRhxw746SMH
X-Gm-Message-State: AOJu0Yxr28uvd8VnD4t0YIT/RBEfrzJ4lx2sFz8ev5Bh7/2VD++lLbnw
	r6j7FzPDrBVwibuKIshfqRxTniZL5wK3FEgQ04nJ8TFlXqMK/0OTdZsZTXf6
X-Google-Smtp-Source: AGHT+IECsm7+ewOr3xHp/9+mJUR810Oo7BHaMqWkkiTHb9+LItqvKhSRLUm1vOqr2ZngWAy2Yf06VQ==
X-Received: by 2002:a05:6a21:710a:b0:1c2:8d30:accf with SMTP id adf61e73a8af0-1c42858ec27mr6559712637.19.1721714160109;
        Mon, 22 Jul 2024 22:56:00 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 14/19] selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
Date: Mon, 22 Jul 2024 22:54:41 -0700
Message-Id: <f2329767b15df206f08a5776d35a47c37da855ae.1721713597.git.tony.ambardar@gmail.com>
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

The GNU version of 'struct tcp_info' in 'netinet/tcp.h' is not exposed by
musl headers unless _GNU_SOURCE is defined.

Add this definition to fix errors seen compiling for mips64el/musl-libc:

  tcp_rtt.c: In function 'wait_for_ack':
  tcp_rtt.c:24:25: error: storage size of 'info' isn't known
     24 |         struct tcp_info info;
        |                         ^~~~
  tcp_rtt.c:24:25: error: unused variable 'info' [-Werror=unused-variable]
  cc1: all warnings being treated as errors

Fixes: 1f4f80fed217 ("selftests/bpf: test_progs: convert test_tcp_rtt")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/tcp_rtt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
index f2b99d95d916..c38784c1c066 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_rtt.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
-- 
2.34.1



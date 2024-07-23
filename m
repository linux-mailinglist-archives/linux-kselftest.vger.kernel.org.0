Return-Path: <linux-kselftest+bounces-14049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FD93996F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211B61C21A2E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430113D89C;
	Tue, 23 Jul 2024 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+dY1tq0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE713C8F6;
	Tue, 23 Jul 2024 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714159; cv=none; b=jFfz8qDVRzjs/4FNUAtsARFCG1WTUg2V8HCBP8bKPcPmnh6jSVQ4FUTJRjUQ7GJ3PMPlmAjsb7sgONHG/uqo2E6epuxYnToT3u2FHWfb5O0NSdeBwx6kfJ+snhiZsHYT+ykeQYtgLL9R5Pvwz3JFtSDWhkirhcZa/msQ6L0BwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714159; c=relaxed/simple;
	bh=EW2DH4rw9P1hXyVvvpPlJUkXeYjfh/hVonUvD+qOedc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDRDsWqmR7dC2vJE1YmyY8f+ODxXPPUWrEOx78wKfWG+1DOa3Voprst5x8Y1vMSqZLGhCaeyB2KPdTw+p59+8GqdL8RrrXVwWFxxoLr7osgelcr31QKk0cO2GfJWO7eq2nz2s2b+gPjAwscF/bmDpM4/9H8IHPnN3e77rHWKspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+dY1tq0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd78c165eeso22262105ad.2;
        Mon, 22 Jul 2024 22:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714156; x=1722318956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YirOn/8mFg8+FfZ2hOYhsi5cWrkxZXezo6GXBJXTZ74=;
        b=m+dY1tq09ZXNbFAOWt6ErtqyHuzvoA2guvRQVvJ66/U3qJc2uxumXeIek6LPLqBs1I
         BxniZzgQt4+zjfibgMK5nbBoNFWh6INymRWvx+gs9NYMSLL3P73d6lFVQ0i1vDvlvECN
         KuYWeaQY+cyheYgSqqJvTYhKF/eonqY41hCVwyP/hXmdLmReH80QjWLFNtBcFatwHmZ4
         8tm/yEwYgliEeT1u1U5Sj0vSwxNWhlJZK/uACu/oiRVgVi9FykrkO9MuuUEYRAWuMA3c
         fNfMWNbfjPkchLbnBNEsr2qVv1F4XcDFjbV7m9Qi6uhzcPB6BYqy5PoZszxbvk0nxZ8x
         Ot4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714156; x=1722318956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YirOn/8mFg8+FfZ2hOYhsi5cWrkxZXezo6GXBJXTZ74=;
        b=j01RoLkG8I9nzVdEEZyGhTuSsKTLjLRbuXWrL717EbcMwxL/ZHrocZEEcQzw52qiWH
         bSGqdG+LUnTIVBMTwT0TxiM73FW11LPvIQCBbVmMBtrZN1yqe+C+YYCGCXxZouCXiH/t
         MF6U6TYPF25mQVld1494UIaYfXqI2mv6QPClzcLMVf73zmw/gdkvIR38wEAHxP2m62Oj
         kUzW/sRR/Tgo+on7r4QV8FBpUr76N/0DDQ2pGWuDLRNY2jytS6cmJRzail7zKe3ILM+n
         ABCeRjdYQtj+9orodUHbntJWdIrFc0lcao6/UDTxCye1OiqTpTiDwjCJCQ3w9eCnfgjF
         RR0g==
X-Forwarded-Encrypted: i=1; AJvYcCXjftLHJs49bP+Rf4zYkU5bnx7NVVNZ/LywCSUKCV6o2HvWvglBLvvnzQ53j7XjbwpyxOXRZpMJJCTnSbJaRxFiQWQwTL4uq8G64nmYYZIq
X-Gm-Message-State: AOJu0YwAY1jLEt6gTL9VxE+Ex5pO4MocmDYeLdu6nDsPTmi99WqGK3Qb
	vscZZi+oFFXdNERDyx4BvjiSb9xOs2DLcdmwOjWis6DvsO68igwZ8IcuQMUM
X-Google-Smtp-Source: AGHT+IF/wOchNpLDLP7DZxvjifw6FX4fgfsE+7tuSFDwBofr+9g2xk0Zi0ykAaKXdiAJ+uaQq74zwA==
X-Received: by 2002:a17:903:2444:b0:1fc:a869:7fb7 with SMTP id d9443c01a7336-1fd746230d6mr82224645ad.54.1721714155963;
        Mon, 22 Jul 2024 22:55:55 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 12/19] selftests/bpf: Fix compiling kfree_skb.c with musl-libc
Date: Mon, 22 Jul 2024 22:54:39 -0700
Message-Id: <e2d8cedc790959c10d6822a51f01a7a3616bea1b.1721713597.git.tony.ambardar@gmail.com>
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

The GNU version of 'struct tcphdr' with member 'doff' is not exposed by
musl headers unless _GNU_SOURCE is defined. Add this definition to fix
errors seen compiling for mips64el/musl-libc:

  In file included from kfree_skb.c:2:
  kfree_skb.c: In function 'on_sample':
  kfree_skb.c:45:30: error: 'struct tcphdr' has no member named 'doff'
     45 |         if (CHECK(pkt_v6->tcp.doff != 5, "check_tcp",
        |                              ^

Fixes: 580d656d80cf ("selftests/bpf: Add kfree_skb raw_tp test")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/kfree_skb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
index c07991544a78..34f8822fd221 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfree_skb.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <test_progs.h>
 #include <network_helpers.h>
 #include "kfree_skb.skel.h"
-- 
2.34.1



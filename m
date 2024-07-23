Return-Path: <linux-kselftest+bounces-14056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D004F93997D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD54281E8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199DC13D626;
	Tue, 23 Jul 2024 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byj7ezQg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A213DDA6;
	Tue, 23 Jul 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714174; cv=none; b=b2fAnL3h4OBd38sz+54kYabJs2DyjTUg/TYwQTYzmhZmkk/ph+T6xX0URmVos32ZT9s1U86Fy3Yf9XtBOcB52q49AcZOsWHumAtK3Gcjc4Ny1DRePWlHDJ1CzDpzbJsCcf+5dmxbojOST9FfeKhA+rgkJz4ojP4uqbtzHKCEwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714174; c=relaxed/simple;
	bh=9ZRAfiKnZMFQ4sO6YZ4qmeyXMEAhqJzO0oV12nYn19E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KW974XPnFdaZ9Aqeab+YWJSb7EvSBU+rDAEd71Mq5800PYSTxhIONkFO8UOqKF0Xyh8lPM5O/is5iwEpLB+Fx8vlhFJ4cbdsipsjjpau7RKBLMwF1ogSjYTbESenMz/9otb7rArZdB8CPXYoCm0NjDvfnB50tUvajaMAS6xpZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byj7ezQg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc569440e1so3180455ad.3;
        Mon, 22 Jul 2024 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714172; x=1722318972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MG2PeOMOolb1htrH87ixqT0wk/31rclRCNXCUAAWHM=;
        b=byj7ezQgAndCc1UAnay04w+CvZc8UBTxByWdZrIvZAknG5EX7MAXRbgKJXr+ahbN9p
         D9fOscu3FZX9F86mVaezop4B+cgpNjIGZhalYOgQPccfcKcs/2iTodgqHuKUDFaBRoKY
         isGYRDnSVOZzwph28UEyE7ZSEJQ3cdbRGVV3y5el5wDznCXwk5QGVAyIvetFNO96r4lu
         H2o6sukKkKo5OJqepjVPhgR16XK6S9YZH4JCQrwrsU8T1dVvLeJZUP+sV3P6MO9Y3A/O
         +wdWlzis3nNqPou0eT99+UhRFgRlZ9VMv0DgH9Gd7EYWxEPPHhdVV7lb/7uRdLxthCM1
         vrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714172; x=1722318972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MG2PeOMOolb1htrH87ixqT0wk/31rclRCNXCUAAWHM=;
        b=OiHMaSlhY0MWEThNg04x9jvvWPMUViTuqLBP7l+wIdmbux1IDSNXlRzf09IkIwkFem
         GPISfcZ1SSZ8OYc7u8AQAuuGgo1hK2pi1lYK8hF6VJ+iAlnHmDXM7fBKHvfmByg05fBu
         9YDYcmuqnMyyoL0i4PFd2zDnNhcFy54JpoWGr4GJMsuaRVSBLvBE5dSNYpXFuafZmVfd
         NNDkMLk6ENrZ2de3ISYbRMN2jltimNHZyK7aCdlYB7mntNjw4GWDe5sqgAWw8m91CnXC
         d77gnrxhlQ6CGxtW18XWCMzRz/6TEXmxYVxy/z7Eiv3CS8dQEpFcNhWu1UCHuGKbmpoZ
         jjqA==
X-Forwarded-Encrypted: i=1; AJvYcCWsFRjAMUtRLoWQ5ioLXUsSOG18MGVMwRqs3n4l3lz1h/rhmNqby4PyxxXZcSy2PmFuHz2XzSkOjqJMpbwxQvfVGnXrRExcLy5Ce2hv1u2e
X-Gm-Message-State: AOJu0Ywq7Wp6+bci2CMXn/NV23DeAEh4Oqync04qE2axPxGmH7jnOYVo
	MHRACYedS+YQb61+8aaeUs9571MIZc2ewbSHHUpWXhQ4uqKon+62AexZl8zj
X-Google-Smtp-Source: AGHT+IFytpCUFA8IA0s61NeqnjNIQ1INiPTY0AICLu2DCZMD5AwVcMPePdfCAp75F1DMtGicppXWnA==
X-Received: by 2002:a17:902:d511:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1fdb5f50c4dmr18992655ad.12.1721714171896;
        Mon, 22 Jul 2024 22:56:11 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:56:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 19/19] selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
Date: Mon, 22 Jul 2024 22:54:46 -0700
Message-Id: <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
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

Remove a redundant include of '<asm/types.h>', whose needed definitions are
already included (via '<linux/types.h>') in cg_storage_multi_egress_only.c,
cg_storage_multi_isolated.c, and cg_storage_multi_shared.c. This avoids
redefinition errors seen compiling for mips64el/musl-libc like:

  In file included from progs/cg_storage_multi_egress_only.c:13:
  In file included from progs/cg_storage_multi.h:6:
  In file included from /usr/mips64el-linux-gnuabi64/include/asm/types.h:23:
  /usr/include/asm-generic/int-l64.h:29:25: error: typedef redefinition with different types ('long' vs 'long long')
     29 | typedef __signed__ long __s64;
        |                         ^
  /usr/include/asm-generic/int-ll64.h:30:44: note: previous definition is here
     30 | __extension__ typedef __signed__ long long __s64;
        |                                            ^

Fixes: 9e5bd1f7633b ("selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/progs/cg_storage_multi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
index a0778fe7857a..41d59f0ee606 100644
--- a/tools/testing/selftests/bpf/progs/cg_storage_multi.h
+++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
@@ -3,8 +3,6 @@
 #ifndef __PROGS_CG_STORAGE_MULTI_H
 #define __PROGS_CG_STORAGE_MULTI_H
 
-#include <asm/types.h>
-
 struct cgroup_value {
 	__u32 egress_pkts;
 	__u32 ingress_pkts;
-- 
2.34.1



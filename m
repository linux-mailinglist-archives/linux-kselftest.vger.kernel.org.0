Return-Path: <linux-kselftest+bounces-10533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058548CB7E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 03:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5316287605
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B4154434;
	Wed, 22 May 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRl3zY1b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7ED153BD2
	for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339712; cv=none; b=tptjCCz31TB7tzyd3j/p1oReQs+Y2IXeRd/8qxIbJ78Ogpi5CWLYLyfz/c115ApPXqkJggyzBXAik1Vn21Zmkxc49KgeNu4gYIC+fb6EL05vYTog1B1mVSl9LSIDKhmJY/58PB2CkCGmlsew6bcay2iozQvrnDdgO8KNPjeWPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339712; c=relaxed/simple;
	bh=SmrocNUJvB/ITWCaF4rKnfFmHCtlMS6QocJOOBtpHOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HgIQu5eJ9OsGuu+0vMnPpIH0e47tA2XlmFGRvRHsJaK0j2Nli2X2rGOkYVBYZSVPO0b53d7DfWp/VqBxL29WmrRiQImxx3OfYg9yH1hfnTndkRKJkOM1vRTdJQJAvn8/LMm8rlETflDU2gjDtVBxWrihSYeSLu3wl1l3ii3f8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRl3zY1b; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-658b03ebe58so5654049a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 May 2024 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339710; x=1716944510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddm347wncUXhvBA0WIqVxztes14b3U0yNoWhmDeDFY=;
        b=SRl3zY1bK8gwbkMgvl5YJOz9kp31ainmDDVq+xV30n8nNnDIfKiJ+3QM8zKosf888o
         mKbYXdGqXRic2kTxHEJPt9sRzHit2eLcjaqVtqRs1agaPVLOB5wz+tLm81dPqnFcugRv
         19k0SY3xbFB601gl2tqkQc48m3zRcsKDRobn5d26s+Y2p0nbZ7v2QgEyaszyAOoyRqk9
         GIs0rww0cdzOJTIb/xZL4kUYgcCiez/9SqSnhUEVkvUTgz6VoUy5fC/PJIPvsAXuwZnT
         0+QlBaReqtfr28VUCBkjgxR1q4oxCeb+Zg9CbwZ8yEH1SpoI/bat7Tye7Ra4m9u7R8lT
         kqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339710; x=1716944510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddm347wncUXhvBA0WIqVxztes14b3U0yNoWhmDeDFY=;
        b=bgtbEc68uXFtTi+uutOQn7frsnF37OKXRlwWIPCArswffyOsTSUXbj9bC/P9YPPedI
         LNOBywmGQy54aywGy5TjptDq2oFKQrqjymUxwz6E9MhR6BMu8OQBseoV+Wdp5cDq620r
         1O5iwSB2SRp1TjNuij9ClRj89vAuaO4ERFRD+PtzS9cuuLO+W0mNAIjjcuUgfCkmww2F
         nIcWFZ0BjCA98rpSELEjv8CJqgsKpBJl1CjTR4HEzqlKP3QhF2I1PavaS3c5yRvc2JlB
         CLR40LbEAVxdQwP6n36JHF8WXBLmQjZ+F57wukFVtLpcvtX+uvrZ/V4jqdiYW1Kk6QD7
         DFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP1iqaeVt4oQwgrxhMKWW13NfjTQCIKmvf/9VLB7pNgvz0DVRR1o0m89MhFmgYR7hBWsziCFQunRhsxRf6YsCMfxnU9wGCba2rV7+5pKYk
X-Gm-Message-State: AOJu0YxvNohUwpCEkq8QGsBWEXosvIzpWSfRpkHcz7UFdEdigVwyaCXw
	dvWcdp7TTVPEiYINV3hEPHNlaDg46FmqmhYzELPVdymMxwqtbMJDOPGyUaaefGP799xMtXXedIk
	RFA==
X-Google-Smtp-Source: AGHT+IHViMDRF07gYGA4O1kZVdy742miSAJ5o6zH/GL3MaXuWgF70gUFd0Ml+qHdUScPYudMioDDIIFR1uM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:371c:0:b0:630:dcf6:f224 with SMTP id
 41be03b00d2f7-6763f99bfffmr1357a12.0.1716339709684; Tue, 21 May 2024 18:01:49
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:32 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-47-edliaw@google.com>
Subject: [PATCH v5 46/68] selftests/proc: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.1.288.g0e0cd299f1-goog



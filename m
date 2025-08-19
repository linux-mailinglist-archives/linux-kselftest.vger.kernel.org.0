Return-Path: <linux-kselftest+bounces-39278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECAB2B7D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 05:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E0368339B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDF2EA74F;
	Tue, 19 Aug 2025 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHNjwAI5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4292E337E;
	Tue, 19 Aug 2025 03:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574819; cv=none; b=EM+c69mNUvRlRVgnLE4iU2H5dYlRYF3ikMmVSJyic3tIS4xXGKciuMGULmNMMgBhOXPxBBDVDcn1qml7GOILgc1H6qKWomnC91bT7uS3JO/X9A5p4kvoNXAi/Fx12vXnfCIrImaR8L/yJF7eJnYWz/b8lVf9apKIPm2fNRHvLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574819; c=relaxed/simple;
	bh=TGw2ul2ZAldEcVHaU0fnT+T9Zm5AaMY7QcEq1fLdVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOWOKc4sO9s/R9RpL+k5dKNzYjK85c/n5bDo8OI24A8Sj0vXVjxCFG7s60cnq9DKTb9/iMlhCfr9d2ypMeyFrAowVOZ1m826lsZ2iFdjrp8WvfLNfqz1WCrq4MfVtSSk4ITOuY0RiE9XxCSwNaL1TpZh7hgl5opntP3Qo0cpbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHNjwAI5; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so3598020b3a.2;
        Mon, 18 Aug 2025 20:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755574818; x=1756179618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=EHNjwAI5wRmQh+oylJOYmvTeyiMfTJVu5xW1ETHE8EohMrntKJjCe9MF1w2UI1DTDJ
         yv0C8h1UOyiauronFQh1n9zuQrBUTpVIyb44B7vRMkP2hSynQBC7uoxtni5xy6B8GUFk
         TDgTo/9O8c8WsYd53Qvo+GHcq+gd6eQsI++gbuJeKEA9/o6QulERoszh0uZ3O3SfAuEh
         W0a9tl0itsei1zfBxhLNnbGMVVVUHBs/2x+b4VqP5roLFC7rtsbDN1OD6TuwnJO134Ex
         qTcB3V/zVAFl2VTTcoXoi5ApAbQ+KJF94nj7/ps1doKhkm76jkaV8jEAZNRk3GEqhvZ6
         vrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574818; x=1756179618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGBbLIiLGqrmFvSwaYDbAojdCre78exL+6ZjHnBuXvE=;
        b=UwgGhRjLdWFnKd3+BO2UFY0wyOM5tIudP+ZudmaxQNAUx3GQeAbBWogVLnovybr5Wd
         DPAQAdAg8RQ/2rZ3O34IweWSy8qQMYZf14bYPQsLwNSbDhGxjirXoOc/4PkFLUQwop27
         k4wjAHx9QB5SGJ8FP9XAXRoO5hoRAlJwcY5hdf1zZDKVgyGORssF4MaAo4s0hYphHtJy
         IgaPUHr74USwZ386W7wAHfiTRz1y0VSZg1GUj5vmoyABrkxq9CEhtAcgPgKl6oibVwrE
         vWCYgAw0oIaCugfxBtU/nyiyqWwley+ziT8fTV1rd2lKgr6gJs36gig+pZYHijsdRY87
         ePkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaDb21aWn/VYLXwjd400kwoBTFEn/uPdlTT53N0NuVqHw4HwFomTZgc7wd4o39h+AaG/g=@vger.kernel.org, AJvYcCVeig5ZKbNUp9+6alz+pyLf5XQYlkJfYGjrVuM0BVwVJAy5yGw2tau5qmHisYZo9MzqOlxCBH3g@vger.kernel.org, AJvYcCWSHG4apsLvqSkQTA+edIodlUvP0guFqOj0GnLbt+a7lQPJbALvF0RPUCQdWhr5UurJsi6tL3AtRRkc1put@vger.kernel.org, AJvYcCX6KhVlv37akCDK8Y+MtQ5IsI1gmy4DopiQjZj2CJ7ry/iHGrbHQZsjHd+wssecNtG7NleTLEz3txiFQz+y0gzh@vger.kernel.org
X-Gm-Message-State: AOJu0YywkvLjdk5Q+gonbq6QwEhCC8AChLXPvGca5/nV6CSRq0Cm10mV
	gh1cMKz5Gg/51xWzo1HDyfWx42iVne9tUHkj2ifG7WTyfm1ZampX9hkY
X-Gm-Gg: ASbGncv1F77R8NRztEycxPoJMhhE0MdhAujYGn5nGNypzLdaWwDlM3JIudCUlxCWKol
	rgEMwlYjo9LhuxO38I3MuKKYFE4GBTjxkgaWbO8A4XoAdgyq9xC9teyGo8hM9bnoLHcOm2XyBTK
	bBwD0ie1vX5eggAqM3uN8Z43ufIlVGOMr8QdvXIvMdmhsaJfAvSa/3Rv1g3mJ/UTrzJ0A35rimu
	CEGPk852Io6a6x8s5D3nXy0QmJLrmcHbealm3akyzi0DGvMtLtK/HcmMdWKmlLeCq13cDR98ezt
	5YTcFM9i7pxUKvxIYO03c5mAWEjXG0gHyNE5NwUdmb51UaLuyym3g5KrG8UiLWzGmRkXTTDS9XA
	W3uhO2Urrni5Ysp6sIv4=
X-Google-Smtp-Source: AGHT+IF4R9bdzNb3/9hrsjsrr0p8U2Js2+EVLDDxYI98NMhZmCYvt0+xwcxGQlfFKVcOuwBibBiaiA==
X-Received: by 2002:a05:6a20:1596:b0:218:96ad:720d with SMTP id adf61e73a8af0-2430d2c353dmr1422612637.1.1755574817578;
        Mon, 18 Aug 2025 20:40:17 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d22b8sm1109804b3a.4.2025.08.18.20.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:40:16 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next 2/3] selftests/bpf: skip recursive functions for kprobe_multi
Date: Tue, 19 Aug 2025 11:39:55 +0800
Message-ID: <20250819033956.59164-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819033956.59164-1-dongml2@chinatelecom.cn>
References: <20250819033956.59164-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions is recursive for the kprobe_multi and impact the benchmark
results. So just skip them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index d24baf244d1f..9da9da51b132 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -559,6 +559,22 @@ static bool skip_entry(char *name)
 	if (!strncmp(name, "__ftrace_invalid_address__",
 		     sizeof("__ftrace_invalid_address__") - 1))
 		return true;
+
+	if (!strcmp(name, "migrate_disable"))
+		return true;
+	if (!strcmp(name, "migrate_enable"))
+		return true;
+	if (!strcmp(name, "rcu_read_unlock_strict"))
+		return true;
+	if (!strcmp(name, "preempt_count_add"))
+		return true;
+	if (!strcmp(name, "preempt_count_sub"))
+		return true;
+	if (!strcmp(name, "__rcu_read_lock"))
+		return true;
+	if (!strcmp(name, "__rcu_read_unlock"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1



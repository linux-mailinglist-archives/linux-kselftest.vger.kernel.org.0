Return-Path: <linux-kselftest+bounces-27077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E4A3DDBE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CCB19C243D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB4920D4E2;
	Thu, 20 Feb 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KovFf0YR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1520C010
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063833; cv=none; b=nhvaEwa6ev80H53M3K2w+IYoFu79GP+a8OdFkDMJowUQQNqso684TeI8qk1IexVTBSaeOO+q4Pt1I5Gb68AlRO8w9FrJMNJH5pCbMwdVb1qgWfUDLHk/oWwYvJoezQjt6lJEXBnykLaiqF87Xzkwub2rzwK/O/UezUbGWXc+CY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063833; c=relaxed/simple;
	bh=W4mj1z3uEq947HIkExuSIBSOsvPwRxwjgNUnGwTjvA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qq8vaTJDjZVlm1cJNo/GG+g3t9U1KIgAnHP3UeS4QvTMTYwwbz2jd/JN6NYxwBjKiNWeYkqyWcfBATGqZpPyinQAWkeZDJ++LyQBBeA0NdbqMRXhRlD80pUX7BhtuaqNz8pdQG5XuHvRms0ta89e998/80eFBwd51ofCMCo3cXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KovFf0YR; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4388eee7073so9933665e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063831; x=1740668631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbBII2vXo7U0fvcYEVnofRQGig0kHut1fyAo0nfwDbE=;
        b=KovFf0YRRr+aSy7IFePApN2u1PY8usv/WOA7D13UUU4bpr3YH34guHZzP27VltJJ7f
         yfsxCyu5KZfu2gSWsTqyFkOAjrQjngVmkr64SwfWUze/Z02eabKZovhgD/5+9KKe1xeM
         y4tmGAJQ9T02CWWw1LerY4Lp8Gr7MksvV/fBT6IN0Zw2rAsKlyXkaAkOQeE3pWL7nHRy
         qMCBRDaEARV/wq96m8yKcTcI/XW3UotTA0ioSqFS1yE88wH0szgukNiE2IqFEwEXD8ni
         WGW2Bjqdm7I01kMFFzBiIXRs+LmJY0xgrNiDahSSA83yQgybN8wwJ+qaw/EpgnC/ZoEn
         pNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063831; x=1740668631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbBII2vXo7U0fvcYEVnofRQGig0kHut1fyAo0nfwDbE=;
        b=Iz3kOj9deA8qeTb9ol/gLcuwKAYQH9vEikKO3f9z2zZc+mFvMVjVFH5MoQMr11RC5v
         jCfcv1wFxDid6BTIdMj37H/4LqKFoQnY0/p8zBp5Cp/ofTepNgbz4i7vC7M20f94zPIK
         I4tDy4mUj3jg71EQJFOKG5KgK2dZSMIvB15bknX28zZ6yIC/85oc0g286TM+Jiu43q6P
         cNRPCxctvPCRkKFrDPaKlUdYTw5D3yYl55AGaqnVNPG974UIyPpm/Bb1pAH7+vNSEiPd
         GzJb3WzRHXxusbdr51o1KNVkKJLJJq5LH937N0lrbHcQ1gB6NXpmJ6XuOg9PVlxccmXr
         TNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyLgdxOLo4of+cXDfjsI6cwTTabn3+7bdwArc25trvNDZjsg2WeVxOjb8SHUjDEL6oWY4TDnsbv7kWU8Xspeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxawksYQYhOiEJ+ekAGc+tk7c1O6TuMEXR4HmRJJVjFPJn1bL1s
	5rXaP6+kOXS4DDgUq2UzeDVjxRZykZT9M2aWQxVYiyUTfI89IfgYrAoMDEeVkkgoJzGtj1x2Aye
	W57vNtl6BjA==
X-Google-Smtp-Source: AGHT+IE7Haql4kRMGhVIrFouZcnUmxPrPTorpBWL1U181AADTVynYOoCOjR/I6BHdrXJEH2hvn+bGdgYYdY0eQ==
X-Received: from wmbay10.prod.google.com ([2002:a05:600c:1e0a:b0:439:8715:690e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1f8f:b0:38d:b8fd:591f with SMTP id ffacd0b85a97d-38f614991e7mr3002810f8f.5.1740063830609;
 Thu, 20 Feb 2025 07:03:50 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:18 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-6-9bbf57d64463@google.com>
Subject: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This calculation divides a fixed parameter by an environment-dependent
parameter i.e. the number of CPUs.

The simple way to avoid machine-specific failures here is to just put a
cap on the max value of the latter.

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 1facfb79e09aa4113e344d7d90dec06a37264058..f306accbef255c79bc3eeba8b9e42161a88fc10e 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -453,6 +453,10 @@ int main(int argc, char **argv)
 	}
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	if (nr_cpus > 32) {
+		/* Don't let calculation below go to zero. */
+		nr_cpus = 32;
+	}
 
 	nr_pages_per_cpu = bytes / page_size / nr_cpus;
 	if (!nr_pages_per_cpu) {

-- 
2.48.1.601.g30ceb7b040-goog



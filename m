Return-Path: <linux-kselftest+bounces-28745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A156A5C254
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9454F7A8FC6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45227256C99;
	Tue, 11 Mar 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPIargED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E4255E37
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699119; cv=none; b=HmDIlmPj9KOoN/c8p0opsjgvsDlKxc0KFHrjvnLfd2i08569/62FhOjVFoMCIQXBVZlqKauqioP+6RWxa0JkhFMfwDVGJqt9N4LnKbk18KBv0Dk8JRSbC6qrY6LQ5zjOCJ3/uFRr7vpnD9d+xE7/WmrAMoND/T5WjI9RLLnIo/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699119; c=relaxed/simple;
	bh=TZCEoOVscJhi1eVQtBkTLxAR5uWerpL1QhTHsmZs710=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HVnqYuSM6volUkMRmzGgDAOgdHqA9LbNwICLwU8UyhCNwDRfBhwitZEfLmbxGFQPIqCVk/e2BmiPQHEMbvjZoclrwDx0iGxEawq22mO/TESHi+pO5XLwIiSiVzrojuyApKbHnyq+h0Y15AeDyusqm7YuS0YTxLDNzFVYVDnwzc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPIargED; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf64f1dc5so12735565e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699116; x=1742303916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ezfRKweWcsi8VDsOy21QFyFbC65YGuaZroNiYeoxlPc=;
        b=gPIargED1npa5FTeBubhvT9SAcepTZ61BqJzmsJ7P3EGcVoCvbdkmQqKt5UtgCZMbB
         yc3yrxi33zkJH/OhaugWuqtxrs4VLF9cj8UNB8Pu2xWgpmPOPGvyGgwAE9rcVIw39hBH
         yw1Gi/rHxoq6c9ajpxKuS61ZFgKu6PH8pWBGo5rXFdteiCx6O32eKUPyz44xVXB2YsNC
         r0OxccIIXrQijIFVSuJxr1PY1XbexowNrwCWG8izUr4Wn+rmqp5vxRb+qgohgBEPUQc8
         Kh02e+nax9M/bJBOCjRmbnNu6MYAJc3e7DTmQYMzjz1WOyqsJsxcSLlJ0NbOvbwhZK4p
         tW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699116; x=1742303916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezfRKweWcsi8VDsOy21QFyFbC65YGuaZroNiYeoxlPc=;
        b=HHeZN0W+tF6S1pAZ+EQt/EJ9pNoqCK33ffRcaWHzOQ7dLWq1BXN1WScDl8c0yPYNoK
         +WjlACOyrW7wlFAY8j2NMLGU87hR3v8a9uEnscsfEl6EI0n7QzO1+6v0TCkkfcc/SXoC
         Mj4oK3mGo0IV6DkP9UIY3QRG1UQbM3MLo32vW3lCeaG58Y/BoaO1ZqB2NNqQ68PHbvHm
         t14+EseLc6PO7pTCm6aXL9e9NsB9LDpcXr5Yhnfwo6gdIuyFFRd9Ut84++bEc5VAhPo6
         EF56nDteF8LQ6WqICBjPUGFjO1B707X7QBLkA4xWJ6i6VWEXJXPb5w8LB0dMfzewz2es
         2fJA==
X-Forwarded-Encrypted: i=1; AJvYcCXN8G5tFbJh8wgvtW02ybW6boJvV5xpj3OuCA2eYrziim4VErE24gCu4dK27h/MelIlqSeGwyI3TnNamGhC6no=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHsGYZKgO3wVbNVQu8ZBZy5X5dwWsTQZa3y4duWY0/M/XG676
	c45nFAYhITkzRUebwQfwL8BVugHCuG+dRk7CutRmE9RwOS71g/43g+LUJGYLGQr0cGV9iQfwiKz
	WXiXPfMNyKA==
X-Google-Smtp-Source: AGHT+IGM8dDbafePeprrNK04mscqi9s1n3LRsj1p3n0Stvsl5Ct+lcHP80x8iiWL53VzzL0Jri/DkBOybzhFEg==
X-Received: from wmbet7.prod.google.com ([2002:a05:600c:8187:b0:43c:fad4:7595])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d1:b0:43d:53c:1ad6 with SMTP id 5b1f17b1804b1-43d053c1decmr18085815e9.26.1741699116150;
 Tue, 11 Mar 2025 06:18:36 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:20 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-9-dec210a658f5@google.com>
Subject: [PATCH v4 09/12] selftests/mm: Drop unnecessary sudo usage
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This script must be run as root anyway (see all the writing to
privileged files in /proc etc).

Remove the unnecessary use of sudo to avoid breaking on single-user
systems that don't have sudo. This also avoids confusing readers.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index da7e266681031d2772fb0c4139648904a18e0bf9..0f9fe757c3320a6551e39b6d4552fd4874b0bf43 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -386,7 +386,7 @@ CATEGORY="madv_populate" run_test ./madv_populate
 
 if [ -x ./memfd_secret ]
 then
-(echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
+(echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
 CATEGORY="memfd_secret" run_test ./memfd_secret
 fi
 

-- 
2.49.0.rc0.332.g42c0ae87b1-goog



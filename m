Return-Path: <linux-kselftest+bounces-27933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7204A49F86
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382BC1898ECD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199722862A4;
	Fri, 28 Feb 2025 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ck08eJuJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F2286293
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761719; cv=none; b=mHw3o7pw9rk1wBxxVTmm6FpUy/4WW6aWfCv1yZW81WHFiFoFSP1H+TSWCxYvzKy0Z7NYPCnfSnGnJCjoAOeSivap6XxieuSQ0KYhAbCTWhvBg0TjX8Hjdc9i5eoEu0RbYm0QMkZ+PRAj1/eLCwuK6l5Eh5zqmRXBbJf6wNHutbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761719; c=relaxed/simple;
	bh=kw4u2ebla+coKdKT/zjWKswK5RGlmRG7yc4jJXGzJoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pE4oCngZjy4U+pnzANi4WFgsMA0/H870UCdy5LFZ/yZpVd4XbHzfwcct3byA6br/ibnKGnBN0RwhLRshikm+MyMUn/phj804P55EVQInB5tBjYExX2MmdLpdxhFncbDMq1Y7sq46sOOhU8NhTphY35ackUJLOsVFBbb5CZZV0qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ck08eJuJ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so1532048f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761714; x=1741366514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1J0iA3fwqq4X8OYjBfR+jqU6ued6Ezuk5An36D2os=;
        b=ck08eJuJgvTTmqU/vvEsyKF2NXsn0XkMuz7mH2MfgmCME5WDL/0aR5ExBei4ZZ1Gvv
         n0JTeEwGklH3+Eav+Ou1tAj+9RSv4BUh1PkABdKoBMsjWs5ktePwgy74Eb+MS4D/S3u0
         4Zc8WrW1IvoWAndeh42WfbbaMBYLflIb++eSuKRl359YTBkzOYu1wXQYMzalS/X12piY
         phP0W5FysjNIEBc8O13zXQyenXgQXtYx/WqWjlj32O1uq0pOjoMGdUXmXyQLLJRafcTQ
         Zx3QSih1YY6JJogOSyUhyiyCnIuwRlOZ91EFbDgf2r+mCylZuFq2lBLbUAIHPxWdwdD6
         GoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761714; x=1741366514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG1J0iA3fwqq4X8OYjBfR+jqU6ued6Ezuk5An36D2os=;
        b=QQhfu6k5A8hGjHY3AuXjQgwN78+qXTt9btuKnDhKD5a70+8bogFAU+1p7lNIbt5Kkk
         oq2t+oUagJ7AZZTAaKqb7I6aJfzxaP9uy/RBdmXc3wZWCVUKMcyZ01YfsKkD2GG7HKFq
         ONwXBRWjbzsCxY8EOz3F13QsqIQn7MgVTJJgrQkHp+eGiuAdg3ADfANHQuFt1v5su/CH
         P49QdAtywtqBjbCbAA1wUGZWtouAcHwdDwdWs+fIwusm2FNLSng//1gc05h6AsQJALdh
         TZFy0nr9+cq4Nl0y4vI95cJVljTxVQMn/HpJyAhucxsOvOfRytZoj07YW3i+N8TC3tF9
         pJrw==
X-Forwarded-Encrypted: i=1; AJvYcCWAPevj+LBod+qkBeVbNVD2KR/+p3/1p1724pvwKIAz/+yxYthamkas76nzCi9hzB0UQT5yuxzfMOurSxjTa54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzG8GwPIbfETDTkfhGv7RtKXoBfvv+brj0RC/OI5qPxnFNf5Tf
	7NijJ+YKB7zkixkLJJGM4NUlYSOCtw+QOvULqYR0tNCzN80r1rTyMCEmlXbsjh3Oi0oZT2rA6fw
	vh4nWdCpUcw==
X-Google-Smtp-Source: AGHT+IFhLHMyiWVhCEV+u6n15NyZd6uFVbQzk9eeDskhG0wjSB0nxk6Q1iAAywBZ/+yofpbEhpMwmSUf+cMMTQ==
X-Received: from wmbg22.prod.google.com ([2002:a05:600c:a416:b0:439:82a0:5431])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5885:0:b0:390:ec1d:7e4e with SMTP id ffacd0b85a97d-390eca63baemr3464099f8f.49.1740761714665;
 Fri, 28 Feb 2025 08:55:14 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:57 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-9-958e3b6f0203@google.com>
Subject: [PATCH v3 09/10] selftests/mm: Drop unnecessary sudo usage
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
2.48.1.711.g2feabab25a-goog



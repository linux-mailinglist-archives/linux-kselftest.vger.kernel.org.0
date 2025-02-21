Return-Path: <linux-kselftest+bounces-27211-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7465A3FEBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E365919C7A2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0A925291E;
	Fri, 21 Feb 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yyYUTpKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA622528E5
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162354; cv=none; b=t/U2rbf1fPK2PS/fizj5NRSXvrgGQB0za4hnohUDrgWho3IULzmojPbMjX1cCLMzMJoXKPiPqieeku3tlpfI0KpkoFpicXfg/2N0iyxMG3FY59HH/tqJP3MJB8fQl6MJHf8tGqIv2mHnJWCp2UfUnJMoqGX2MkdxFLA4fVn9XXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162354; c=relaxed/simple;
	bh=Ilk6+5tZclI1F7dj4D5Y8eYPtM9YM7Dc/fjaV8j1+O8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7ZmkHGKiF9UnF4LDrc1SIw4MaVMQqg2ri42Df2YOYe3QkAdCy5nrWg6K9Lc/x07KqVtUuShss7NzhSYhdmO6JsWZI7oU3aXyD/vXubEv1vjn/FEWaRMG14C5rHllmK2xVSZWkmW58huHZLf34ayseVybKCth4pdZe5tEDZ8Q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yyYUTpKs; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f20b530dfso3135289f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162351; x=1740767151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wiDbMltjmyaz+TufXV5xdn+s6ZmLgnlpLnjEPTqGgXg=;
        b=yyYUTpKsjxOY+MVJ8O3WFXSlDtTPveuHDryCmeATQPIoCGBR/HN/9V44eyHwpaefAF
         nWkZepywzRYVnJIt1QsE641HtREin+poBtewlOG09c4CwVSUEoxJHD2o8TfYQ7PJOmiH
         alKAuIa1ufKFIAJnsxCQAWErqbnCkY0mHlxdrXLwHV58NfNOTpF4AZPz++yErDjXSde2
         SDA0Achw/k7PNGqVeDHbtPoyAgzvDA4dOnliFxohd336D5ZkBy4ibwbvR4rkv3ZfEpnu
         kw8uDLQLTfA1SJHtCfbfkLINV3WTUUfZMz0MnA2OKJTJi87u4dXRS6Bs8gVPd3RTVs1B
         yfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162351; x=1740767151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiDbMltjmyaz+TufXV5xdn+s6ZmLgnlpLnjEPTqGgXg=;
        b=Ux70+DG8t1iRA1++Wpzf0UmyM45fWB89J/A74t9mMMPYvTDeMQFXTNPalHRRtyrRTe
         xOfIUwBUMAaGx69vfRlUdNo25dJuXDbYa2DJwI2+VvrOvwA/We3KeTE39eBpDwpYp+59
         vtTxzoruHN81k+MJUDxByf3pHk6rk/0FJAV2R4NHecVBol1mA/LLT6wTpafQBlG+iR/0
         hRn6R3Poe+rwFBlzBiolvTJQX/NvhDc9GyqclsukPEzVgXKMz1b0GFEl7CxYRJPVMGd1
         R9IdfwJtTphH3lAX/fK1bTTqowvAOL0RRc4RvsgMqe7xBuwt/Zj840VdXYxAaO18lsK6
         krRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj68xQ7afS47ESGsPhqf+0MISOLJfBxsMF5Bu67KDHHPQfUv6MZ4YOmOC0rD2XVDGzvzvFutpXxUKIgbuCyHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHQrLEuoV3q4wkCHc7uzYx4rO9jQKUaxW7VZMqMqY8681AjFN
	q8u+PHh1bVYGyAVsy9zCP8W9H+K6lWhJBEAXjxVD/5pnlQuJJ1tEGvUVfQA+gMY1J+3LnwWYPgh
	NFRToS4aWUQ==
X-Google-Smtp-Source: AGHT+IHvtIB+srUjpk6uvB7EZGmO0/DSJFR+7wDmYyQaFCKzvAqVW3z1wzUI9oGP+GeG2cFpYZzpIvgbccRs1A==
X-Received: from wrbcc7.prod.google.com ([2002:a5d:5c07:0:b0:38f:476c:40ec])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id ffacd0b85a97d-38f70783f03mr2572158f8f.7.1740162351365;
 Fri, 21 Feb 2025 10:25:51 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:41 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-2-28c4d66383c5@google.com>
Subject: [PATCH v2 2/9] selftests/mm: Fix assumption that sudo is present
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

If we are root, sudo isn't needed. If we are not root, we need sudo, so
skip the test if it isn't present.

We already do this for on-fault-limit, but this uses separate
infrastructure since that is specifically for sudo-ing to the nobody
user.

Note this ptrace_skip configuration still fails if that file doesn't
exist, but in that case the test is still fine, so this just prints an
error but doesn't break anything. I suspect that's probably deliberate.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index da7e266681031d2772fb0c4139648904a18e0bf9..9c963f50927ab2b10c3f942cedd087087d4d0def 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -89,6 +89,17 @@ RUN_ALL=false
 RUN_DESTRUCTIVE=false
 TAP_PREFIX="# "
 
+# We can do stuff as root either if we are already root, or if sudo exists.
+if [ "$(id -u)" == 0 ]; then
+	HAVE_SUDO_ROOT=true
+	SUDO_ROOT=
+elif command -v sudo >/dev/null 2>&1; then
+	HAVE_SUDO_ROOT=true
+	SUDO_ROOT=sudo
+else
+	HAVE_SUDO_ROOT=false
+fi
+
 while getopts "aht:n" OPT; do
 	case ${OPT} in
 		"a") RUN_ALL=true ;;
@@ -384,10 +395,13 @@ CATEGORY="madv_guard" run_test ./guard-pages
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
-if [ -x ./memfd_secret ]
-then
-(echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
-CATEGORY="memfd_secret" run_test ./memfd_secret
+if [ -x ./memfd_secret ]; then
+	if $HAVE_SUDO_ROOT; then
+		(echo 0 | $SUDO_ROOT tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
+		CATEGORY="memfd_secret" run_test ./memfd_secret
+	else
+		echo "# SKIP ./memfd_secret"
+	fi
 fi
 
 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100

-- 
2.48.1.601.g30ceb7b040-goog



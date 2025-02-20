Return-Path: <linux-kselftest+bounces-27073-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524FDA3DDCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A03422150
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8F1FF7D3;
	Thu, 20 Feb 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCjwY5vX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6849F1FF5F4
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063826; cv=none; b=WQMUs0Wv4EOc7KhXurlDPUio/y9sBhUjHlXX8o93/qILWxfCfaXCoF5Y5z8x5TXBlxubtqt9WVz/tuZEzJsY/Ntqal7PRGa+mtv6TfI80f4OJzkkouoGFYXg6Om3chf+0hIbN3i2b+P7/ihGxhy8K5I7F3xAj0BLJVC1k3kobz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063826; c=relaxed/simple;
	bh=Ilk6+5tZclI1F7dj4D5Y8eYPtM9YM7Dc/fjaV8j1+O8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iw5VAnY02addK4f1rOVwR10iC/A3WQmWjn/XAPaaJDIIahheH8CWiwCh08j9GLmrBA7GJOGhmA05vUfufDfoR909ipTaZnpHVElNICkroxiPM1mnn/+lMj1UMwECaN02obPY39Hy2Bnr15SQoi0rcwxtHP+Bnba3rYMlFOrcExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCjwY5vX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-439858c5911so5461095e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063823; x=1740668623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wiDbMltjmyaz+TufXV5xdn+s6ZmLgnlpLnjEPTqGgXg=;
        b=OCjwY5vXJ5IiNskY7194N8VukxN38ZP9SQkZ0aCCPWWOjjrFjDBZq2N6NeX/rV+Fyz
         4HjM7oJD/nLmAJDGMGNVD+A4sCa0LN6Z3ConMghkgNHAhKe59DD1tiz9N1kR/bXl6pAT
         yxexElii3MaMJSFk2pBnPqijIRnwxDC0+eJ2gJeq9yuuI2gSwknv3L+0zejI4uKlHoNO
         VMEXAwcJ+QhwE01G9RcBgwHT5qelrTDSfS1ku9OVqqwoxZIIFn0Cg+MCJgPP6TFaDSR1
         Q/M97tSm6VOJt2KXibC5MSosSuhkGCBRPiCdQdT5XJu1/aUyrSM5dgWD7fQ8bd0qN3HA
         ++uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063823; x=1740668623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiDbMltjmyaz+TufXV5xdn+s6ZmLgnlpLnjEPTqGgXg=;
        b=D1/XACdaMQ6YaBCCU/pmkosLSDCQuZ37XyvUbaFZchcuhM3FPzyDee/psCTwkrhLLP
         C1XBv7aJjgQfvkpYwMW13vgVJziluH4bJKFHPANP9bdoxitCb1bbER4bxMPJ53QqAZYt
         2pJX0iDEddBOfzJZdNiaZA2SMdtHdTHIuqjWl/j/cxF6iNrMLpkAB9emM6QQgy9Jls2F
         LDg4/008NaIDfyKxUYknBPHgRnL32dCdnbfODnjWN+d6qwnMArs7qd2r72h9AXPBgr8R
         hYJ+WXp2e7KRBcj73EJVxwYMnZA7OpbavbugnVH1/gxZHEyh/s/CCS5/F5PRb1WjNSq0
         bjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8a49CLSJJIfytqpUH6zFHivRgDlY9HYHBn583ycOtCadLfcXTL4jwPux8lso0le3b/pjAlxyBG3v1O/3UUzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXipaTXGqta0ODmOk3uIXmECFjj/bpDwL42oNDzpexiQnPfNxk
	tU1NxpAGj2HCYf0hiGa8ysCGuyBV9DLPQLJokw+HazmREl61m0pracuV1lNqEOiGwH0n5MVI+VB
	GrGiVWsJGEQ==
X-Google-Smtp-Source: AGHT+IGMX6sUMZFB6kcF1FLDPNy7JKgv9mVpVnHmQkgAM/qSvu5gFbpVA6vpmtah98EUgiAhA5SqxJEjJc185A==
X-Received: from wmbg23.prod.google.com ([2002:a05:600c:a417:b0:439:95b9:9200])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450b:b0:439:9225:2f50 with SMTP id 5b1f17b1804b1-43999db0139mr80231185e9.16.1740063822867;
 Thu, 20 Feb 2025 07:03:42 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:14 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-2-9bbf57d64463@google.com>
Subject: [PATCH 2/6] selftests/mm: Fix assumption that sudo is present
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
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



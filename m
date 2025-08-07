Return-Path: <linux-kselftest+bounces-38446-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B36B1D47C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A4418C2E74
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63623373B;
	Thu,  7 Aug 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6/ZhOnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180FB1D514B
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754556649; cv=none; b=uMhIW25ZeVZdX+PY+DXHZhCnPP2mWmdmNWAwsjYYYAxdjrcWiZNyGLeWKAoJ66kFn0uqce/C5qg1QX4kv5hg4ptMlCVpHo1v7yA/sGBsT7gHQxXcDC7Gdf5jTw3fcpshpqKl8rdauF7v0PTIl/TC0/XKph1TdHXAwRTo4VtbZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754556649; c=relaxed/simple;
	bh=FwhFes50Tn7NJQfQMP0GASIlWrGFxqp9/xLR3m4889I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YpG6leVTEL4GTDHFgMah1EWCw9Cla6Ng0Tdh8jEQKqwWiSmbSzuV13PdouTLiBpRBEmUPXsUUGAd9sr7W3KEsfBcXZYDxf5Z7i/F4JSBCCmDj/i+vXhAXR/ztVg2yVSZYKJCSZ9wWeF+TK+cNCkURKq8QovaA8X73mC1ERO6XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6/ZhOnm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wakel.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-242a1390e9eso16098235ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754556647; x=1755161447; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FF2oTQU3oNxnUp2FsWYDhFwL8LdokYGJ1eqoMrwki98=;
        b=V6/ZhOnmbN8lBeNpKuPWODrNNnxff2RM6RYxKWs/w9TfdEitdMunI9ThePQChNUpuM
         iV+Tmllq6KzD/nlCKSFdzTpNwg+4dDITUJc7L9l60lb/nwjSZr99Io0k9I9tT8lVuFe5
         aWADZRYu/VcLKuXioVuuZjmA7k+eZZvg551UFy0GiOqmM8cgmzeSUR70jtd5bXhSOe69
         2caf9SrB55vLYt4dVKN3DUXPX3YJFn1Mlwg9V9U3zE1andtNSI4IPdm+BQL8yPqaSjWQ
         bzwwgBll2e9p2CFi6mr2yz6tuRC4BBaVFjlnPPvgnHbwVzt437RHwnZ7JE70V0OHsVy2
         Poaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754556647; x=1755161447;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FF2oTQU3oNxnUp2FsWYDhFwL8LdokYGJ1eqoMrwki98=;
        b=kbjl3eVRCrLTH9IRTvJ1vXj0cTl2fJG1SA7X10XPklEiX/fo6NlRhiElYGcptTXruY
         NJOWcDCs19PDdpO+7CNPj1y4YPNFwNX18j3sVQSh2H1BtbNg15mWFFS+U60Eu1K+M/Bl
         RaWbWQkIfR4tck9ztXwR+OZgQ24EM9Oi/SsZGoqyhZSglnRRx+8/aKOPGb9IivurR5sr
         QFKe7hHYzFeXAf9bWubDvL6CiHkabuHf9WlIPKNi97Yo3tJ3tNu1A6PsMYnwftGQq/Kx
         ro9+fdWs3wFnGa4+scIGnUYuzBG5sSFQK/LG4BBkBclt4/BCqPkpCNnUQG6Bq3IB38oU
         i50A==
X-Forwarded-Encrypted: i=1; AJvYcCWsvmSHFyNceqzMGSGQYeoSupz4oKRmtDkRvDrdBUjsfMjoA48IWfLrNub+sFF04BR9iQMTHwvzfRQpgu5sU3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5Sm1pY8Sl/whnfqgwkZeXQbbXuVFUexS9f1yKDuTvYumKxl6
	47C6Me0t5bmEgKkNAzCf5gP3ymLam+M841Zm/PHsGfGG4IMVJLi3UYOeZvj8g2SoJGr9gZnJIUI
	kRQ==
X-Google-Smtp-Source: AGHT+IEh7maDHFXzzlyyjSh7c3D+bITMOC+qTmrEhkL//B6F/4b8wbqj0IR/qlWosbupwoAnhrwyx9TcBQ==
X-Received: from plha17.prod.google.com ([2002:a17:902:ecd1:b0:23f:d0e0:7e93])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32ca:b0:237:f76f:ce34
 with SMTP id d9443c01a7336-2429f329b07mr85540905ad.15.1754556647417; Thu, 07
 Aug 2025 01:50:47 -0700 (PDT)
Date: Thu,  7 Aug 2025 16:50:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250807085042.1690931-1-wakel@google.com>
Subject: [PATCH] selftests/timers: Skip some posix_timers tests on kernels < 6.13
From: Wake Liu <wakel@google.com>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wakel@google.com
Content-Type: text/plain; charset="UTF-8"

Several tests in the posix_timers selftest fail on kernels older
than 6.13. These tests check for timer behavior related to SIG_IGN,
which was refactored in the 6.13 kernel cycle, notably by
commit caf77435dd8a ("signal: Handle ignored signals in
do_sigaction(action != SIG_IGN)").

To ensure the selftests pass on older, stable kernels, gate the
affected tests with a ksft_min_kernel_version(6, 13) check.

Signed-off-by: Wake Liu <wakel@google.com>
---
 tools/testing/selftests/timers/posix_timers.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index f0eceb0faf34..f228e51f8b58 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -256,6 +256,11 @@ static void *ignore_thread(void *arg)
 
 static void check_sig_ign(int thread)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		// see caf77435dd8a
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct tmrsig tsig = { };
 	struct itimerspec its;
 	unsigned int tid = 0;
@@ -342,6 +347,10 @@ static void check_sig_ign(int thread)
 
 static void check_rearm(void)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct tmrsig tsig = { };
 	struct itimerspec its;
 	struct sigaction sa;
@@ -398,6 +407,10 @@ static void check_rearm(void)
 
 static void check_delete(void)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct tmrsig tsig = { };
 	struct itimerspec its;
 	struct sigaction sa;
@@ -455,6 +468,10 @@ static inline int64_t calcdiff_ns(struct timespec t1, struct timespec t2)
 
 static void check_sigev_none(int which, const char *name)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct timespec start, now;
 	struct itimerspec its;
 	struct sigevent sev;
@@ -493,6 +510,10 @@ static void check_sigev_none(int which, const char *name)
 
 static void check_gettime(int which, const char *name)
 {
+	if (!ksft_min_kernel_version(6, 13)) {
+		ksft_test_result_skip("Depends on refactor of posix timers in 6.13\n");
+		return;
+	}
 	struct itimerspec its, prev;
 	struct timespec start, now;
 	struct sigevent sev;
-- 
2.50.1.703.g449372360f-goog



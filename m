Return-Path: <linux-kselftest+bounces-47729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40DCCF1E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 10:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8964C301A1E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 09:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9C2EFDBA;
	Fri, 19 Dec 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTbGSqIn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D921578D
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136353; cv=none; b=HMCRoOIdGH/LFN8Ae3l0ELwDelo3mLPILU9k9EepxvaSiShyNWq0ifkGv19Tfkktv8t/m+oQU9PnPYXhI0yvM7C7OyHvrH51ouFB0xI4EiKD6LWHUJS1+EwZj/xsHJexiJkRStoE5v2icjx97DfMxUxOpuvL2vwTCXbzhb919ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136353; c=relaxed/simple;
	bh=eAL3LC+2dHh9zMBn+hXpoAz7Jvm8uTTfKLQguRTeU5c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Tl6KilCzgcMH0wA89wxoF/aHcPA2EG4QS0VqfMI/ViR+odLkNZ8dEjrQpF4L56H9uQaVCaiYz6FJRd9/lmOaX1PjW0By0BZLYKvvh5LAJz6ub48bR9YQl80wL7bphe+a4ceJXwH4MbI4FAhF4dWN6UT+RHGOuDOVsP44uDB1wHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTbGSqIn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29e6b269686so31008155ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766136352; x=1766741152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FDiA9++PSC1lAnu943IjFuSz/gL1rZEi0ur8htsl9Kk=;
        b=PTbGSqInE0e+O9rKa6U8v1gh+FYYaKgeE1N8wmN77PpVzeqQ1NyVNLL4QnGRuOgoHq
         cPy6HG/w63N69+VpkbhrfzpR+4o2w774obOJ6A/z/q+EGtij67+ocs6YI9VfJyFqC6Xy
         QBkRLkQ6JVdgjQ2fjnKg+Inr8Kh1oWlHgPg2Fj4WHJrmKZMYariHHBBwsNCK1zzF4iLC
         Xetunopi/P3F2KLisosEwlhN5L3cH1tmai4wWQQtItSsFBRx2/SqLIqSJVlD44/vkWEO
         VzDkG9LRNvPJz+ISbOq7B2yxhg11HBJJaI5YQoDbLPBCwy85xk6bmy0CfCJbvBx5xHkJ
         /Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136352; x=1766741152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDiA9++PSC1lAnu943IjFuSz/gL1rZEi0ur8htsl9Kk=;
        b=bJrfbkwDPGJuX4f/rsCVrNz/mvyh6kYatjGcUSZZgnAtU3oBOT9RQ70IvbGcnTgd5r
         acQweO58Bnf7WAR93zbgdExgmDG0Pu4WA5ArlWPthdPbfc0W/SV8KfzIZyk9gMIivc6s
         wPafOiQqPCLtq+jiZR5dW2StsmrXQXa17FJ29E7O2VcSeXzqv2iIIHeS2EGwHOrucDBT
         pqYHtAO9P/JAceu2/MrBoi3AmXq/iw1eB2+H+ce8SOtdoDy+T9lLIgSj9YpgjCw/AdlA
         Cul97eA+4QTdJ0ZuCgEufvG7XmmO3nyKTEzsyEk4vTzYnX9hogwjAzwEJ2aZzAObiPWU
         HwFw==
X-Forwarded-Encrypted: i=1; AJvYcCVACYC4m/cDnVFSjFebHueHJw5Sk3ERz7Pp46qBMZ3ik+Zrb4kTRjvGZqlxwKTgOGg6tfQnnhtLXvnfF6b3/I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytyDGsqlKhrLwqvsuZZOs9q50IwaOI5jW5GeyiNX1N7j0OvIbs
	Un0Ajdb4eCKXL122Jvm/Csp2QFqve9gRLYr6vmALpaOyrYe89o3wK4vaUjhLf3JVoAjcm+lPCM4
	cBTBOQJTXmyRxGA==
X-Google-Smtp-Source: AGHT+IFESw50RYH9ypgSn2SiV5z0LY9j1QZK87YYocisEWy4PFUqcOeZorDnuMip9BneY5uX4han6LJmRN+G/A==
X-Received: from pjboh15.prod.google.com ([2002:a17:90b:3a4f:b0:34c:d212:cb7f])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce11:b0:2a0:c5b6:67de with SMTP id d9443c01a7336-2a2f2a3d5b0mr23777415ad.52.1766136351586;
 Fri, 19 Dec 2025 01:25:51 -0800 (PST)
Date: Fri, 19 Dec 2025 17:25:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219092537.1227513-1-davidgow@google.com>
Subject: [RFC PATCH] rust: doctests: Number tests by line numerically, not lexicographically.
From: David Gow <davidgow@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rust doctests are numbered -- instead of named with the line number
-- in order to keep them moderately consistent even as the source file
changes.

However, the test numbers are generated by sorting the file/line
strings, and so the line numbers were sorted as strings, not integers.
So, for instance, a test on line 7 would sort in-between one on line 65
and one on line 75.

Instead, parse the numbers as an integer, and sort based on that. This
is a bit slower, uglier, and will break things once, but I suspect is
worth it (at least until we have a better solution).

Signed-off-by: David Gow <davidgow@google.com>
---

This is a pretty unpolished, likely-unidiomatic patch to work around the
test numbering being horrible.

I have three questions before I decide if this is worth continuing with:

1. Is it worth renumbering all of the tests (hopefully just once), or
would that break too many people's test histories?

2. Is there a better way of doing this in Rust? I can think of ways
which might be nicer if the whole thing is refactored somewhat
seriously, but if there's an easy numeric sort on strings, that'd be
much easier.

3. Should we wait until after all or some of the changes to the test
generation? Does the new --output-format=doctest option make this
easier/harder/different?

Does anyone have opinions/advice on those (or, indeed, on anything
else)?

Cheers,
-- David

---
 scripts/rustdoc_test_gen.rs | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index be0561049660..60b0bbfb1896 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -116,7 +116,19 @@ fn main() {
         .collect::<Vec<_>>();
 
     // Sort paths.
-    paths.sort();
+    paths.sort_by(|a, b|{
+        let a_name = a.file_name().unwrap().to_str().unwrap().to_string();
+        let (a_file, a_line) = a_name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
+        let a_line_no = a_line.parse::<u64>().unwrap();
+        let b_name = b.file_name().unwrap().to_str().unwrap().to_string();
+        let (b_file, b_line) = b_name.rsplit_once('_').unwrap().0.rsplit_once('_').unwrap();
+        let b_line_no = b_line.parse::<u64>().unwrap();
+
+        match a_file.cmp(b_file) {
+            std::cmp::Ordering::Equal => a_line_no.cmp(&b_line_no),
+            order => order,
+        }
+    });
 
     let mut rust_tests = String::new();
     let mut c_test_declarations = String::new();
-- 
2.52.0.322.g1dd061c0dc-goog



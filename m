Return-Path: <linux-kselftest+bounces-33878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61C1AC52A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 18:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB4017BF32
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C527E1AC;
	Tue, 27 May 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GizWuES3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22227B519;
	Tue, 27 May 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362180; cv=none; b=A40pZbxQMFamh7ChMaDbPjadpyYvAPdLQArna5hJS6DDIuzZYZSpwJxWEga480u2SQVAwt7mSJSQkP9MkEa43M4HGkqQkhnVKiSeC2Y/c9WdjamlNz2W5K1xH1JOOu0B1QiF3pVwcIfUqesF9mkR1ci/+RtT2WYekI7e/1rW5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362180; c=relaxed/simple;
	bh=wmkhpzXDnZ0g8qX/wKkzt/uak/bBbTXP0RSHnvXCzog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BpTEJS+WGgEeOx7AYIdUblWJmdcbHyBDH6BbiaPSJpZmDLVGd9VqOizDl5DtbUD4ERWtbndq52MTz6GP0eVkLyzHNvmPxj3XOdQzk32pmF+vZn+vvbatg8BOl0r0CQj6PxioMgjhODeeeX7zfwiy/OIiollw4CkVvo7aq+bbDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GizWuES3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5e39d1e0eso363324685a.1;
        Tue, 27 May 2025 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748362178; x=1748966978; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdafvH3qKchv40RUQ4A8gsyR+VlDxzAi3WsekEuYUJc=;
        b=GizWuES3VLRYzDyrEn7L3mFopPxMl9AkO6GClft1jeux1yIH+3rSh3YeWQlvmTU8Mz
         LWX4yA5zbOzV0iZAWltpKW07+ZT3Fla+t7X/vwMiR+HNkoU8MLWrwxwx6so54qBSK7OG
         qmpJQgKe/GBZ6xIK3sELQKMzTpUAqSX/gfECpkBYmr09qCzSh0/EXFrGq/jV+Oj9hRb4
         Dj2mUEXrbDLq+sTBsYe5iOazVFkBuMwLMODTzY0jMU7G0M5tgBQ77JoGf33O3ENVAokv
         VKkX6lXh+URh5t1a1Jb8VZzVO8J3F5PqKORWyRIzNbn7j2yz6L9P4uQGn2WIPbRNik8p
         sF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748362178; x=1748966978;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdafvH3qKchv40RUQ4A8gsyR+VlDxzAi3WsekEuYUJc=;
        b=a4pmsgPHzLZvQ/C6ht3te8rdSjbj+7pL5DxF6H+RzyGecQK/F7yv2+JjdAasYPaurI
         uV6/Jx/d5tqXiU7QCFAmjsvlkprnS/syzeCu0CjaM/MYtHVbIdiegYZZLQsib3CVLqFc
         5xpl93z36sFy9i7hkuwFj/yaI6PbE1CYYYkpo4Eb5Pf5GlnFfq7EWIdZxESZdPxZ5qFu
         a5FJYX8eNrKqWCBkQCV600TQeUVKsDQBfWxMveH7T+jTs6zl3lAormbZOkDsGDbvDDqY
         /0ug+pQhvUJzKNuTDPi7ucQGbb5wzRz8ze3yvl8W+jH95d4r8t42tGwugg9q2/5LYGqg
         nwHw==
X-Forwarded-Encrypted: i=1; AJvYcCVMxUZJIiJtBwfmxE+Sy5aTviZzG55oFFy9fABWrEo+aQpchIzZ/B0yd5U26gI1r3oM+9NNRz8FiO75Sjun1/E=@vger.kernel.org, AJvYcCVwzSvqQVjSenaFi9ijMEtS3Zw2J0nBiEytMH/XzNmsesFi1a75TCfetMUQWleFc0v0yz67W5b2nULeksA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOaexmKd6Yp+dP+zYAtJNGROCsHNdG1hMZ2C0+ew+zk7hcqSe
	sK6WQCXSNEdDkZcygLr36GB25HqHXh7gugD0j4clljMK95V/hDtvCDh/
X-Gm-Gg: ASbGnctIBZJ/DRY6Ys72779t5DqGn9GXr1FJRMwCstSDlrdiHKumiE8DA1arrddnnyU
	eXzdDuBC49gSH3PNHVkoviPBFtr47de++278BiMGT7S6jLamuOk2EWFA/FEb4PPADIX8CQuWeO1
	EAzb+7Eu2MJOCstQ8iAAQFrW70hqkI00IQxNxyWab92kCM2L8LD4GYxV5exHA7AlJ+vayjzE1/K
	D95c5YuAS2sy0A/gEZPG5O4BhLrFD3sVw0GpnoYx96wJ1Sr7/B+0Sos5aQ7r7+3v4JysxZ/7OfP
	hHQmpKmPBKGZdqJJoJ1r94W9MGjzCe+TGtHsj32qFsvw/wyFRBMcZ+unzfCeg3kLZ6xnt/nB9LQ
	v0z76oql/8iDsjSrFg5G7dT2KjjZyaPrIPVmUcue2/6y/I2CubCmfMBbhZKhw
X-Google-Smtp-Source: AGHT+IEhK8uYBSCXQVul2cqMuX9Zf1oRVVgkEUahL8gAo2qNPFQorLHLod0m8oVd9q4mVM934Q/vZQ==
X-Received: by 2002:a05:620a:4448:b0:7c9:2425:a7ae with SMTP id af79cd13be357-7ceecbe0efcmr1789366485a.29.1748362178151;
        Tue, 27 May 2025 09:09:38 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:24d7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cedf7930b5sm763460685a.89.2025.05.27.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 09:09:37 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 27 May 2025 12:09:36 -0400
Subject: [PATCH] rust: replace length checks with match
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL/jNWgC/x3MQQqAIBCF4avErBNUKqmrRAvRKQdKQyMC6e4Nb
 R58i/dXKJgJC0xNhYw3FUqRodoGXLBxQ0GeDVrqXvbaMCkd9iIneF0QZSeHQg/WjF5JiZ0H/p4
 ZV3r+7ry87wfXkpzSZwAAAA==
X-Change-ID: 20250527-idiomatic-match-slice-26a79d100e4d
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use a match expression with slice patterns instead of length checks and
indexing. The result is more idiomatic, which is a better example for
future Rust code authors.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/rustdoc_test_gen.rs | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 1ca253594d38..a3dc251221e0 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -85,24 +85,25 @@ fn find_candidates(
         }
     }
 
-    assert!(
-        valid_paths.len() > 0,
-        "No path candidates found for `{file}`. This is likely a bug in the build system, or some \
-        files went away while compiling."
-    );
-
-    if valid_paths.len() > 1 {
-        eprintln!("Several path candidates found:");
-        for path in valid_paths {
-            eprintln!("    {path:?}");
+    match valid_paths.as_slice() {
+        [] => panic!(
+            "No path candidates found for `{file}`. This is likely a bug in the build system, or \
+            some files went away while compiling."
+        ),
+        [valid_path] => {
+            valid_path.to_str().unwrap()
+        }
+        valid_paths => {
+            eprintln!("Several path candidates found:");
+            for path in valid_paths {
+                eprintln!("    {path:?}");
+            }
+            panic!(
+                "Several path candidates found for `{file}`, please resolve the ambiguity by \
+                renaming a file or folder."
+            );
         }
-        panic!(
-            "Several path candidates found for `{file}`, please resolve the ambiguity by renaming \
-            a file or folder."
-        );
     }
-
-    valid_paths[0].to_str().unwrap()
 }
 
 fn main() {

---
base-commit: bfc3cd87559bc593bb32bb1482f9cae3308b6398
change-id: 20250527-idiomatic-match-slice-26a79d100e4d

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



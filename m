Return-Path: <linux-kselftest+bounces-33997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF8AC7E73
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3821C01E7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCB225A35;
	Thu, 29 May 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPAegats"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525C2253F7;
	Thu, 29 May 2025 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524504; cv=none; b=PpOofkRDVFkjKCnCLlJPyT3RZ/8BuOAvqouum5RnZMfN1uUSaVMgKNBudPFdM2fZcF00wfxQ3f4SKw6wHA2MbPKDJ00TNUixJA6NUqajwLx3kFFXxWaFSd1rKcrNZUw9mBO04wa9DA4PRcx/rtU+oDHxyhmkaExI8z7MRMOeHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524504; c=relaxed/simple;
	bh=0UGHp7jfAc0Ku2jl5ePFDVyN+3ieU31F+io2vpu3t8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSBsqkYE3yNRS+uEoJagcFHykeaLHwUjVVeavovJHcPGOz7ctz5bcdjznJGFfyvC3/N2Cw0GNh6qHiMH9qX4hpLEtYotZqPzaqZeuiCJrh8489YV354ajMhypeuTApNRkRFrlGXVc3wjAmvRFDmcEObBSOXXF/88/NxDhhvENiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPAegats; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8b2682d61so20013456d6.0;
        Thu, 29 May 2025 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524501; x=1749129301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=falrcJggJ2+8U8zphNs4lD118xsCQzXc3zARnKFg7Do=;
        b=DPAegatsFzXU4j09hxGNLGcIfRgRCzQGuA55B92YMMv2zJbtuGYHM1bdogjeUa7IQ8
         oc7pK/ekZFULqCpLgkKHT7NynXoBeLWmwJD3TKOzRaMPHH33XD2MZbRFnHLmZ9BW3Xk8
         036jbAkPJ4VZWnijCJjEJClIOZ+YuWQsJ+3Vil92Sh+KenVw0Ir80syAwLB7wwJc5TAW
         bavWBg/JcoTJA5pS1R1vPUjPulw7AD5BcoK/BdUhEVSrjsl7B2wzuEu3/jlra9eGdyV+
         YgXpGM9i8/ivnLyrNBk81RSpdci+lqpgrUv4xaDDAefsfsgpI/rII0iDSp5mT+gR+83x
         ZkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524501; x=1749129301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=falrcJggJ2+8U8zphNs4lD118xsCQzXc3zARnKFg7Do=;
        b=ajCa/3jP4oamhC14IyFErNE2Kq3rkn2qchN5eCQ0gsocFP+2xm2mAezqWdkOGNUXDT
         jxAObwplgIQSWeZSIjiJ4SLzuQaVR9LUPi80QHu+SD3yg33eqg/zkx/Aw2pp0YjGv4x3
         q6zxndhPOlHGkRM/gZwIaudpFc9ugUw5ntq93aD9to2v8feGqqDVkck3BcOirl8A0HVn
         BQyjWNJSp9Z1ZpNoVt/ioCyl/qR9yttUZ+QOFrSF276+9DQN4HN2VbPIMqzOvI3MUg7w
         +QI9gSswn4szITbFjMGGeYODTjcCvSLGQoSv5KdKgQdUxW9IIAY7bstdtYqBaHddKpW9
         EhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/P1xAtKazmJAQNpsUKkJApKeWuOmyEsJ97qg1ZLaom7QmI3CWGB+qYvHs6mxJr499DWcVwuTxKupUZe6r/Jg=@vger.kernel.org, AJvYcCVOEwve/zqP3ihlX0vQOfLNiNXrErHty9KSrd4Ne5LUjXXLEsc+BKWj6Ld7GaWuSoc1nLiiHZGT3XJg8iI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+D2+2g4ucRh2ngkpd4tJpZoJ8cgvOhuHU8H4v9zDcRrcDlPLZ
	Q07eoDf192rktrTs6G8WmzZWFb/6jIoZ/rO5iO6lhok41w4eVLQwZijp
X-Gm-Gg: ASbGncsQQXtUhJD1gJk75ln0HF7bQmiiZ38sIRzO3c9vUE+J/N8rcYGerst1IaRRuZt
	QYSP7behpEd2uTP96hFV/avNuHHxaYUf5slIL/E2kQN+WwDzSD2MrCCmR3tILgYTz3j0kVkC4Xi
	xz21qvxJRxb/PjMFm67PSUa3RN+OZdlYVeTVGa6Fk1rfNAftvtx/yY/hkMwKj2KouynrmMjjQHt
	Z/ELAGLUmiEkGPS+2dOP6k6/CmVUFUl5I6sowVcuwwo4HbkvK6e3jZ0ciau0kWAXzkrIciTdzBo
	lvFA3PH6V8A+Nv/URoU1y5BiUk11QQdZvnumH6uTconxjI8oWdyWd/9U9Ekd6JV8ejyTCPM7zSi
	Evz0=
X-Google-Smtp-Source: AGHT+IFidKN7BhBHdfTtVQh3V/cGxBjfsgeVT0N78UQrKLFG1VdlQw07H8YFDtFPz5RLtsN3nyBGKQ==
X-Received: by 2002:a05:6214:500f:b0:6f5:4dfa:6944 with SMTP id 6a1803df08f44-6fac5d12b7emr58898776d6.3.1748524501531;
        Thu, 29 May 2025 06:15:01 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:da0:d9ee:5c71:a02a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f7d96sm91528285a.30.2025.05.29.06.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:15:01 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 29 May 2025 09:14:58 -0400
Subject: [PATCH v2 1/2] rust: replace length checks with match
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-idiomatic-match-slice-v2-1-4925ca2f1550@gmail.com>
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
In-Reply-To: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
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

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/rustdoc_test_gen.rs | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 1ca253594d38..d796481f4359 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -85,24 +85,23 @@ fn find_candidates(
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
+        [valid_path] => valid_path.to_str().unwrap(),
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

-- 
2.49.0



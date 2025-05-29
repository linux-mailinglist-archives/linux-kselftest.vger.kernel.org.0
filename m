Return-Path: <linux-kselftest+bounces-33998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E36AC7E76
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E9D1C01DEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CC22539C;
	Thu, 29 May 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTOFfuSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7519ABB6;
	Thu, 29 May 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524515; cv=none; b=gCU1/wS8VURYiucZ0+ppxUHbMCHexXYy80HlR1STbwusnjTUjwLz14nuH5cKRrizNRXQaKEM/PaZWfMlpzlPyLNRWr1QBS5rJFewnCtX59zIYKq0inaJ+CKQZWs2OPrevl/DV15shIoSYozzVWXYpTwvpN60AfdStNSBavcXgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524515; c=relaxed/simple;
	bh=izTBMmwweAGuAnXHJtubgKrUDiBkjD0FY51OCVbyMBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDdwOpbguNMQUwygZcbxk0J8juANZObXdZfgHczgNhEYCc2FnDS9unU+HECy4z/XCFIwjRvpmu8AGWygNDwaC5KA1uUh47XCVl+FJdGT2vrIIBLTZUX7xdraNggU4fMvHfpro+uu3AUCNRQXmEdfxksgWiDRc5vHi6y3u+7tVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTOFfuSB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso1000876b3a.2;
        Thu, 29 May 2025 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524513; x=1749129313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDjprSXjpWj7IN/c9BrZgUvfGIdrnvmdvSk6h2l12/E=;
        b=HTOFfuSBFocmpqb3FmcErkXaD9FaN0+X2HtlYB9TLwgEfuFnv6wIo3SnVru9208Rg7
         LvS369+mX8kZQfIritMPDjZ0tLRo+U/DGtNPCqOM+Qy5O1GRwhMdAWZlVI7n7dJSmV8L
         Qmg3YcG9gEsmdIGEflGwaTP/Jvb6rgiF9tGetxOb2E15v0iRIbWFind5m0NvLsoQUFAe
         wXjevlqhvb2VPw7byGpaCKZ3hOeA/WAP5E9Lg/SEp4/2ds17oMSt5s/Ik+K5DMLhuPWl
         01JcmZqrc/J9VDA83mXm+rw6bcEKIHnzPW7lv0fpvGRmQlrl6dskumrTV6yQSbtVz9/M
         ntGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524513; x=1749129313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDjprSXjpWj7IN/c9BrZgUvfGIdrnvmdvSk6h2l12/E=;
        b=w3X4wXpRKF1267XH8BlvjK5Bdm5EGcVMyzRtraS+qjl9JEEINqcX3XDVIWjIIslkz5
         8CpIeWwa3e9eq08vKTbzV/ai8FVwofL0BJPQFktKOkd7OwhdSOHhrFvbZ5td4isw3GKB
         w30/pkvTQvzIqt3LE6WCEcNNdIVVvJB6NX8UPsPClsdzS8ROL9jn1vYQj5AngMA7M9n+
         UzhvMU6KX1ATb5yb1hBrqcgo6RPDUlBVFADaPkT5FikQn9UB7OXLj/1FsgkEQXxTL3na
         2EVkQAwMWX4J5Z92LrdDEIJFnSU4yCTUefg9wZ+qL1gKhzJuDgv8nALD4hEIlPQPRNj0
         QdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1qA8M+7jtKtgItw3t9nHV1EeaW8SfzY9zMEFEru31DmQMGkl0KWE2+iZswlvXytdioXeMH6k6UyL0D08=@vger.kernel.org, AJvYcCX2ar1PYiiuWPEtX1THb1mTh/qXX58uF2nIrTzupxt7Iy8r7zHBvtNry1k16YlQhuGlN2Z8+uBjKiwlZEncG6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYe3BNaY4nuKJUi788/GXkYVK1mJVvqJVp+ywfbRCt6e1w07Q0
	Z26cyZHDmKuOmqjPFvznbSbMCNr5jEwpjl7HLzuVrsQHWlUAYJDhC2ywYf+69/B/TZI=
X-Gm-Gg: ASbGnctC3rBMvbdVEPunTIpUzZtrgBd5ebMlpVzVuwXJwT/M1sBFhT/2VjBGZ9b8fiw
	TMd2cwPwCoOb7Pqtm1vuEgYRFO4Zgfgh0rJLt54D0Jhx6dbUvDI4HPLjFxNcqi0bUG0rVHGjDE7
	I0tOqQmAtnZGWzzpc5qOCB7J7P1ZAlm4IehP0/5KzZGwd3+dfoIB7LrRlzP9dE0jhHSXr2XZmYx
	wuwqsuzBKmeAJnTXGYNayFdfthRCtBiYQT3uO1HLUNbim3HbJOHOcXTP00K/iM/37plSumEO40c
	VUrEqZOboNbKHy+nm78/dnBl87aVmwswQLHS0MxmwwSguOq14rwmnXygsT92UZ5pcTRAhMJ3NIX
	oq1fKbsUfzNhD9Q==
X-Google-Smtp-Source: AGHT+IFZS4//fV7KzceypZuAS7jRaNoJwp5bqwCgeHwzNmiDtrX7cm9iZXd/41HxrzX2+eLp4Tw1Yg==
X-Received: by 2002:a05:620a:4550:b0:7ca:ef12:966d with SMTP id af79cd13be357-7d09aba561dmr374330585a.56.1748524502690;
        Thu, 29 May 2025 06:15:02 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:da0:d9ee:5c71:a02a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f7d96sm91528285a.30.2025.05.29.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:15:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 29 May 2025 09:14:59 -0400
Subject: [PATCH v2 2/2] rust: emit path candidates in panic message
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com>
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

Include all information in the panic message rather than emit fragments
to stderr.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/rustdoc_test_gen.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index d796481f4359..f95129b03cd8 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -92,13 +92,15 @@ fn find_candidates(
         ),
         [valid_path] => valid_path.to_str().unwrap(),
         valid_paths => {
-            eprintln!("Several path candidates found:");
+            use std::fmt::Write;
+
+            let mut candidates = String::new();
             for path in valid_paths {
-                eprintln!("    {path:?}");
+                write!(&mut candidates, "    {path:?}").unwrap();
             }
             panic!(
                 "Several path candidates found for `{file}`, please resolve the ambiguity by \
-                renaming a file or folder."
+                renaming a file or folder. Candidates:\n{candidates}",
             );
         }
     }

-- 
2.49.0



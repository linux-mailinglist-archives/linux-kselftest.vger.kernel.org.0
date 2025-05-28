Return-Path: <linux-kselftest+bounces-33957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50531AC702A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 19:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3DA4E35A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED6628DF1C;
	Wed, 28 May 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9nx6qrv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412A1B6D06;
	Wed, 28 May 2025 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748454694; cv=none; b=jXf8pCoc5Et8CFMNg7adJlowl6ypEGU5nBhWApYE7xkeSg8PuaguyO5irUsKKHCuuxzp7vh+D68/8Upj0x7k1yWHB3iRfLEhUNtBQEtOpqb9NiNf4izsGXXDvheCkDH+uVSx80g9qZKrpExFkGp8gktKKycVknQRfF3y3L0ob4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748454694; c=relaxed/simple;
	bh=pKrP+SJ4LaJNwfbkiX7iV0LUuK6iL+pWws8KTlHLUeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brgbEGL91gLTlHslKtAm879I2aGBxbStRvDKVJM2Yc5qvTkQH8ITUICsM1YOOSM9ygKGCcvrNK9L8SI5iJEZIyizN8El8ixE4XMSGhoQTmL+tULZJ6YZKwsjnHvpfmtgsVbVLtE5WmdkUVCID8kiiIxdmeIbd3Bf5pPZ1Iharrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9nx6qrv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c9907967so4057b3a.1;
        Wed, 28 May 2025 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748454691; x=1749059491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1+IwopJU0lv/yXFu4CFGB0kRxCi/XJPpkkbxvoT8Jg=;
        b=U9nx6qrvwTBTE0E9FH9Ud+sUx4t7XjL3vqdo+kYeAFs9xHExMxImYHPCGQj5sTxFAY
         rbKOnNFDmzjAORPD3IXxmnebNuA6g2r4Lt44DEihGeuva3NFqm8yE98GhMBYrFYHXiIb
         Yt4NalcYlOVskTY6axOz4fOtmLLTlEitfTvYZ3VrhUXZmrovyoJjmHB6tW4U+xk1kOt0
         DMvnOU5pB4CcBkwaTyAPPYXVYYk7giI55dlxa8b+2uhBq2rFgnnQeNGRU9R+is0SaZ+L
         ZzCam0HWRRju5jqSAt3A0M07RV+IkxDUM4hNAYVDOXbFMdOf7iEJ7O9+xeRYALLHQTcq
         ZyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748454691; x=1749059491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1+IwopJU0lv/yXFu4CFGB0kRxCi/XJPpkkbxvoT8Jg=;
        b=K0wo3IIszrGeWtE3j2UGHOrN3XyXA/gjIQXcXdgKCGqskn5rmo0DdE0OldO9Ws2HbX
         ThahkK9x5iN9ZJNj7Sr0MIwFqLPmYpJKGgozT8xWgZKvdJeSZ+hP/pUUTdivb6kciKEr
         rjz+SuDBn17RjTXaADOF2CnM3FLCk9wTcNrbb9YpH4RHHWF6q3N/X8zK1uX4g8YEp0CT
         TFQGlX7ln0f24oEnzM4XA+rj/JwHqG4TB2aUMxrjZO4i6iYFhiLB9XBZUiOV+u1I7ICE
         rsFks7V108W13E7XnmZr5jWM9t6Vr4+VzGZF3E8D5eMdPDMF6wTgEk0U2jFrn64UHbE0
         YdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6TNbAPMHcHBFKCgZ3JjUDm+779i6VT+YQm/tmepKh7d0z3t48XhpRI2Kldb5OsVpKzilre4BCT0gxzTaRwxU=@vger.kernel.org, AJvYcCXZJXhS2bpeov8hzU//nf5FBmQvvDzI3+mRFpy7dYaIvzHaSQ3+lg6ESFJM55NVd1w0NlSlNGVXRCvnuXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7l45LYRNzKuOuIt8wPPMfKNY7GtI2apg7eBIfmt2F6jfSPYrj
	AnZqnfGO09eE5kRyQgsvcn43W/kI7BeNqEoZwBH+KeQkmg8QUTNl+oWO
X-Gm-Gg: ASbGncu65p8PtlEN/reOOFyvDi9FOrbGWuy64HRc3xXaWxhRF6xJIFEe8+Pcw45cjUr
	vKoe8RWiNmHMGAOHQNejj9lKjbnHnTjjo9T+dPxcVAADtSD418tlADBedpoz1/9blqXFi357Hs+
	B9UQNqbVEH6XLqNsEptpVlnqQlc22D2vmP0kY+OMgtdaigRdXFkelccSb8x+nYHGXlgWy4B4NyV
	1cPkCoWzrlDk6KF2c7FrFBcVQ1ChQlAN/ANDSYY8RBGX5PQcUxZxtvczkRZMJG4djSiKXsOUH5n
	1Rifi/VJv6lYkjpgdF0j91VDlJNP8WbdBhzXP9fLzAwwpVRSW+IbNOKqqNB/k+MumiInhbT7CB7
	E7BIMyHHlOv0mM51OFA==
X-Google-Smtp-Source: AGHT+IFVO7KOkICyQIQM0olRxVieRE+++FIRGraoGJUL+14X0dln5wxY/fKxuitqFepnzJOlCJVoBQ==
X-Received: by 2002:aa7:888d:0:b0:742:a82c:d832 with SMTP id d2e1a72fcca58-745fe05d238mr29975839b3a.24.1748454691493;
        Wed, 28 May 2025 10:51:31 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e343c015sm1544696b3a.138.2025.05.28.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:51:31 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: [PATCH v3] rust: kunit: use crate-level mapping for `c_void`
Date: Wed, 28 May 2025 17:49:55 +0000
Message-Id: <20250528174953.2948570-1-y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `use core::ffi::c_void`, which shadows `kernel::ffi::c_void`
brought in via `use crate::prelude::*`, to maintain consistency and
centralize the abstraction.

Since `kernel::ffi::c_void` is a straightforward re-export of
`core::ffi::c_void`, both are functionally equivalent. However, using
`kernel::ffi::c_void` improves consistency across the kernel's Rust code
and provides a unified reference point in case the definition ever needs
to change, even if such a change is unlikely.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/520452733
---
Changes in v3:
- Rebase on a3b2347343e0
- Remove the explicit import of `kernel::ffi::c_void`
- Reword the commit message accordingly
- Link to v2: https://lore.kernel.org/rust-for-linux/20250528155147.2793921-1-y.j3ms.n@gmail.com/

Changes in v2:
- Add "Link" tag to the related discussion on Zulip
- Reword the commit message to clarify `kernel::ffi::c_void` is a re-export
- Link to v1: https://lore.kernel.org/rust-for-linux/20250526162429.1114862-1-y.j3ms.n@gmail.com/
---
 rust/kernel/kunit.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4b8cdcb21e77..603330f247c7 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -7,7 +7,7 @@
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
 use crate::prelude::*;
-use core::{ffi::c_void, fmt};
+use core::fmt;
 
 /// Prints a KUnit error-level message.
 ///

base-commit: a3b2347343e077e81d3c169f32c9b2cb1364f4cc
-- 
2.39.5



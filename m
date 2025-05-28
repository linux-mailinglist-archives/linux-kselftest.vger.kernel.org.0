Return-Path: <linux-kselftest+bounces-33943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7E7AC6D41
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC557172EA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BBB28C862;
	Wed, 28 May 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FArEaPVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17D28C855;
	Wed, 28 May 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447731; cv=none; b=ELVIbzxIXAI+XVDC/fH2PuxWynvqxEtx+zy/nGESLjxi7UWaiOVyeqUXK/QCBER1LhcpHtukGZw2zx2AUwahaInqIPX/VRP9p5BelxX7opVt5KTuXqA88mD8GRbdAOvQs/uDv5J56TUXoty/l83k4eViVy5jwpsAixI87fVi+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447731; c=relaxed/simple;
	bh=8JXxfcJjoGbvpn9MgUUsyU3cv+zoDwRCtAsunztYnAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qoBNs8utzySIpd7fhRhNleRpZvyLVyu4BUdPbtbcyu5LPjz9QG5YDhgkd2pTzAOJpyQPMi8Gj43L5AEv/Z7eynWGl1vBiYwCd1znrgpC83UaUMJQ33/qULi1r0UZnzbeNIGBcVvlCclk8dKVJ98/jVNX8VwZiGqdTIWabQJtRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FArEaPVp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af548cb1f83so13773a12.3;
        Wed, 28 May 2025 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748447729; x=1749052529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TdWUtiBXIpdQ6dngRJ0xyGfp5ROuWsfYLJvZy2BONrs=;
        b=FArEaPVptH9fjYu43o54yy0BxrH5zu3xRFqk9plxS5KFV+moMvGr6kl4X7YfTWIA69
         e84dsIlvflrmqIkuYJl1ybU1rWRwfGfQzKdkHrx3EQcfzD3p3yHFKNC4d+7hxQPv/0Ig
         A4uH6i02tiAOQBklHYMEgK3BC5/NXWoNUSxqE01/hFkOvN0VoUszfTUH6d3WuES4xW18
         1oMMezAUskW4lrVhUUkFpPhS0tslNoCTdQHIaqk5Q+prAcTdHzZIFjgBo0k96DatHy9u
         BdQ0D7jO1Et6526C8k90KiaOCcoqiS4Kf47fbKm/9/GNyQlO0fB+6ItWsfFmE3ksCtJ1
         9JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447729; x=1749052529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdWUtiBXIpdQ6dngRJ0xyGfp5ROuWsfYLJvZy2BONrs=;
        b=be5v3Thh+HY4JPK9ivBziPJOn0fOBIyZ4o/wpHJLlKyQgnJUJj0jSvLTd7mDdt7cmk
         usFd6r4devq/uLWYecNFUnwTTqYhY4cWXJnFPdR6UotoRkmfe85bUFxsTRd5Vx1XUsD3
         4Tp8yp7MFulLI4Vb9DvNtaOlIXOJFq3QfgU41lr8oYJbBOlQlAdAY8kDyJbJaN6PgQU8
         GPT12ErEVpHdzixDtGkoqpsKGSsyabBlKpXTLvrzU0+NTRaAiQQtLANNG72h8lMEDzlz
         I5UmnLtQ7wEn5USZ3CNZLGwLYGUrMx8QYHrxn/PRwpf3aA8fEZAcKYmXrrwJMtiRajeq
         Z3FA==
X-Forwarded-Encrypted: i=1; AJvYcCU8QzYNYGinwanP0Wr2GaK5vSfYNbsh6qNPPhqXxY1LjficNBylPbnotUsSymQ5SFP/eQYqjWCyvHoLUts=@vger.kernel.org, AJvYcCUCRQ0LtoeOiZOg2R0utvQXn8+b8IT/5AN6m/kJKPE6An7Ls7Zn9pUQ+X1UEnMoJD1yQjneuPz+QvsjdVsq/sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygSWLO++tpLV+2/A2Bu7wSh2IsPLJTtUDgrvyJFPahVz7CoRxT
	/XaQISMlkDFk2dSlc0rtMmK4byLe4fncGSjoaId6CKJVRwFibSpCDp02
X-Gm-Gg: ASbGncuxjmoktB7f+34C6sSAj/cUXES/a1C9DQuhAf0zSgP1KdX9PiBuwdAGo8WCtZF
	7+Ma6hTndIsraA62Q4lD2aLMsjgZNDarJytMiDgBwj5S5EE2th4Yr1G2I7EZDqbxLdQHvFkW8sq
	iyWcsqQbxXRpd5tea7QZJFQK4EVb2f3ZIC571y3lE3f6+mJ5IjyOJVcS6jirJQUeVT2EAcnOB+3
	HFAaldehPOyJiWHeNe5XlzmGKhhAEt96TOPrmVc+4eFra8G8rt6sPg5jtKtn3mSn4keH7XXDaIV
	C0hqH44oKdYEOpRdLPoAhobpPuJxGETRD9pHEJhFE1zUaq6trX9NrQKnHtzko3x6cD3vfpPz
X-Google-Smtp-Source: AGHT+IFANBqiDmGcHFrSu/ihjwM81fRnfat123aATS9Fi9jALatSGZQFvIRcNwOkXvOpaOAjW8Lmpw==
X-Received: by 2002:a05:6a20:d04d:b0:1f5:9d5d:bcdd with SMTP id adf61e73a8af0-2188c1e811dmr28470637637.1.1748447729374;
        Wed, 28 May 2025 08:55:29 -0700 (PDT)
Received: from localhost.localdomain ([112.149.32.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2d9872c835sm1311815a12.14.2025.05.28.08.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 08:55:28 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: [PATCH v2] rust: kunit: use crate-level mapping for `c_void`
Date: Wed, 28 May 2025 15:51:47 +0000
Message-Id: <20250528155147.2793921-1-y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `kernel::ffi::c_void` instead of `core::ffi::c_void` for consistency
and to centralize abstraction.

Since `kernel::ffi::c_void` is a straightforward re-export of
`core::ffi::c_void`, both are functionally equivalent. However, using
`kernel::ffi::c_void` improves consistency across the kernel's Rust code
and provides a unified reference point in case the definition ever needs
to change, even if such a change is unlikely.

Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/520452733
---
So in sum, I believe it's reasonable to keep the diff unchanged... but
I'm happy to adjust if you'd prefer a different approach.
---
Changes in v2:
- Add "Link" tag to the related discussion on Zulip
- Reword the commit message to clarify `kernel::ffi::c_void` is a re-export
- Link to v1: https://lore.kernel.org/rust-for-linux/20250526162429.1114862-1-y.j3ms.n@gmail.com/
---
 rust/kernel/kunit.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 81833a687b75..bd6fc712dd79 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -6,7 +6,8 @@
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
-use core::{ffi::c_void, fmt};
+use core::fmt;
+use kernel::ffi::c_void;
 
 /// Prints a KUnit error-level message.
 ///

base-commit: f4daa80d6be7d3c55ca72a8e560afc4e21f886aa
-- 
2.39.5



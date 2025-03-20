Return-Path: <linux-kselftest+bounces-29478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4C8A69E1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 03:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4951E42399C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A58C1E0B9C;
	Thu, 20 Mar 2025 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="YJ/miXVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33D1DE3DB
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436524; cv=none; b=i5qn6ZnGc7DNsgJn1sCGI66CFFmsJKuUPAW7YFXl89/WJwHhF5Sw7AlT1M7gaKmlpXmrUrA/7gL87KBkxiqUj2d3+2VdL8j5HehyDrupfyLhT5VrYHBLp3fDW2EQEyVvg9pWgYdU7aJh6Rp9KpAhnJeVaGm1VXQH6z9Boc1F+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436524; c=relaxed/simple;
	bh=l4ssaSufUBK09dZq8G177UU7r+oY0bTFzW+fGBCFPiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXcAeU5axnKRHnx/eio7H1Ip9JQJYCsXg5XFstwLM6/tK1W9vigBpH7+4hJ6GQpOseqGNeU49O/Trf8J3laeqGi8tvXp6QgpcTbHHg6ADor7UU/KivSUFonfwX+wlikDJ4XnvSxwmqhp2p6WidKN632AIwBKMv/K596PKHBPnyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=YJ/miXVt; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f47ed1f40dso2076947b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 19:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436522; x=1743041322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbcxZM28E8h0jIzorHcyOns09Bm2rCHzwWFkZIFRSh0=;
        b=YJ/miXVtEFUEjbF9R+DE/DjFInnn2K+9eTMCqRgLSWJitu5MWbqMXGbWIxGgl0DhZb
         x/Vlgnye1P66A2m78+yx+S+C0Y+zU5bdJNFbmWljFoZo/YXq/Qp3KnJUxH/4rzHFmi0l
         2rQCKswSPA4YPZFEjkQcHMhfn0PYbDQCt53e+9O7McfPeSo2WnPV6Pk5rfEgqeyAiu/z
         +6k8sJh3/jKEeUWBacZCHe1UfCu5gAhd1COBAX0z4EVmZ5RcEcqdNWrX9UrIHrYCsHk0
         ro5A5XZoWbLaQnV0uh7RyVQNmIkFiKNFTJWF4+412WVML8EmnRNpWp4RmlMc7rP+mLyl
         fzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436522; x=1743041322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbcxZM28E8h0jIzorHcyOns09Bm2rCHzwWFkZIFRSh0=;
        b=j5W9VQn2QFpqI9YTszWGrFBQryUKuSHWn7WUNZNuGr1zW6IQ/fn2d9GtDRqLQp0aT2
         3ePLy6QzmheZLfxjcZSTef+E3Rl1b3Dd1pvsWaUfPgi6gGrGN/xpDMSTANNMjurDTx/+
         5Jl7Gc27ZHZHGEWEo1RgtHTkbGO3J99BxS/MKlPnvND07GapkUwVWrg+/cOl3Bo9AZCt
         3HztKHNL7BJv0ow5lQj+LhUSU5Occt3tz2ojAv9fXctirXj3ch9CsQoTYT7yjgs0pNM5
         cxJNIvM/t7tHubUo0/g3ciuBOetzLLiomT+Iq2+tg6WHF1Wb6LgupEIDfjOLdx1ClHOA
         LCrA==
X-Forwarded-Encrypted: i=1; AJvYcCVK9XkUTka4ySM5/XWNARzPNE1HSmQHhlDtMuev8YyHevLekL1EbJo2q1k/SsyXZeYQEBtjhRAOVZZNDdhJr3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJ07h6cm2jDGIwmoeK95tTxYfDL9K4St2RE6YnLLMrIV48J4I
	Mu4rDZIk4wK8j8sNhAJ+2LsqY7KBSWTb5W/H3pBse6KiOzKw8WS2w9wqhr5rdFA=
X-Gm-Gg: ASbGncv91G/hd2jfxBxRxrW0oyHkHOlWGsWPc9RYGMCghXPRExgKuODKAwcU3oxtKy5
	m7l5D2YYhW3bUe0fQoWO5RqQfelCedawPWZJxZEzhCnapRzvfeIF6SbcSCOIXNzkPDCiTthcZF1
	EP17CidD6X3vvlTFOAEzGvscAs3ndHDxMnqdOA0R9sEq/bTdoYYi6yvLBieurIeciBgPbzSBqbu
	j1vrQNvARfYV9CYSxQeW6CAt7aed+c3nqs5rar5GpDmn0DwuiqOJPzrUD3Qg0tyiIKK4D3EimYb
	i9dYtaLHD71y9PIZc6gVfaiQ1EAM8S7eOhHs8DNOKVLPFP0Zt5VnO8x700Z0u5suMFSHYKv+t4W
	fziSvLdmm38vG3D/VW/M2JXteFK+DMg==
X-Google-Smtp-Source: AGHT+IGHMAEjMdl+ZerkRf+axmhEvgKYAVqsiOnVu1D9v0O0rWKtPV1XHVLoGkf89pshff/xYAgPCg==
X-Received: by 2002:a05:690c:c96:b0:6fe:b7ed:9715 with SMTP id 00721157ae682-7009bf7ef66mr85241607b3.11.1742436521683;
        Wed, 19 Mar 2025 19:08:41 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:41 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/17] rust: kunit: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:27 -0400
Message-ID: <20250320020740.1631171-9-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` with
`&raw const place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const` is similar to `&` making
it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/kunit.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..a17ef3b2e860 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -128,9 +128,9 @@ unsafe impl Sync for UnaryAssert {}
             unsafe {
                 $crate::bindings::__kunit_do_failed_assertion(
                     kunit_test,
-                    core::ptr::addr_of!(LOCATION.0),
+                    &raw const LOCATION.0,
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
-                    core::ptr::addr_of!(ASSERTION.0.assert),
+                    &raw const ASSERTION.0.assert,
                     Some($crate::bindings::kunit_unary_assert_format),
                     core::ptr::null(),
                 );



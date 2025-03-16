Return-Path: <linux-kselftest+bounces-29153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B02A6343F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 07:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985757A8C22
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D951922FA;
	Sun, 16 Mar 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="Idlh1j9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9C18FC8F
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Mar 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106042; cv=none; b=nkVeLx4mdKoW4Uw9jEUJrwmxTzIgWZLXG1jCYqw00eK6E241EYK0S+vutAytjUZbxIDfHr8WppUs8wIIfozULT3m8fhOILwkaCTnllru05gcCK3/RTXp8F/adaUiKKEYGQhddk5xPO1jCuukpQ4s7oIyJEdrPUs62P2rW8ZYNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106042; c=relaxed/simple;
	bh=YC0aFKOl5srVCaDj9HbucZ/4B5f/InwUtG32FScc5k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihjjSRc2KbgBxpp7jjZ3KgFQrLBKTkR+FmmhFuVjaBK3OUuuFmUQU8ZV+6gpgjck6moCdbBRvpq0EiXtEfPqY92INxiNM/D8tLFFfCw/cFx+EK4/vJg8JYog2VqXXMWqM9wzryut66RF9in0x/XmaGgFfpol8xuh6sW145CjEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=Idlh1j9U; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso2595754276.3
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Mar 2025 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106040; x=1742710840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI9KVcwdadVIoPwUOMUiJkuxM0R26yz4AdH6Inso0Ms=;
        b=Idlh1j9UM2XFdknrrX9CJyCGNPmZDFjHoEvystlHzOJiE9N8vVqu9y1RQ+bgyWtYDE
         h4O4KDp7ltAPDxN6GIzatSOppsK7q9SuURvzfrY8MOhjh3D8XCmRT5dBWlgkvHiYy1gm
         4pjlyZMRfpvDZ08yNgZlIsqlNKboiOvEgFFG4UqLqK61AADtFQj7slzqCNWJWCVxO+ad
         ko7sntgy5yjIKmWbusoGzC6eI8NfhOne3GBTp8oCsKaPAs6DrbQ8fVXahj0wCyrj7keB
         WCC8KzAi7EkxH1VFhOsiAUvn7Ujm75w+2AwlQLOKnMUaOnjj6RxyYtj8MGinfvlWFjsy
         2mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106040; x=1742710840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MI9KVcwdadVIoPwUOMUiJkuxM0R26yz4AdH6Inso0Ms=;
        b=WRPK90FrqyVih3EAETK32Yu4EdqtF3E7pdoHoP/+fP0IXExLeKKFts3I0kOnw9VMDs
         /KwR/0QCU6Yhl7H+hshtpCXqiwCNnKCl7dGBXuT17ZFcf7lq19aj6p49lBE+2ylB+BKh
         F0HUtMxYWXmqPngqUFhlnLlDc+MZOqX+DjS7ANhVgUQl1FmkYYyqrNUJ/PZCOlI1PLs6
         89pmDRHzrzYY9FVcNScZAruwwE+3cYCpI2XvsPUNAoXseeSktpmDldKHE6fTWhiYa5sL
         YXXy8ANrQf53CN2LDooTNpWh6o69JflVSoCVWFGaaCUwmy9fXeQgl0jlglgr3rBfmFQe
         eCzA==
X-Forwarded-Encrypted: i=1; AJvYcCXzAzPMM19gV5vld4qbSej9WSeJ9ZD4ezdUs+0WK5ziJzzXvcY7uuh4waePWEM0COXtwOxRDHoL1kQf47wYdDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh18TeSmQJvCsdBRCLkypSkRvDUgQ/b4+upccrl6FDdRMADqjh
	toE1NviRh9se1LyHmolKW7O150DiXh5hir2NnSdqROM/nTu8s+2Qj8FxWc472Gs9iRRW0iyB82/
	gFMQKUA==
X-Gm-Gg: ASbGncvasM7A0nCejt6j2tT6eBd9LXF+DyNFyQhrK2Lje8dnM8f+43qfNtBCcj/3Qy+
	UUP9UO0So2A0ZIpI0t2wOzvARDovFVCCeCmAU55z+juwD8KgB3/YZ4n+20YpSx9vvSBuI7rCUND
	xVMOKXBwADxUoLAaZu19RisX6p9O+z8AfZjffPmYjdj8HlXD+YERGnC2yBw32YSjMLLbpoeMfEp
	s4mmj78ymisc/3jVbO3s1uhVeG71qI4pFAzMzR7GoXH6S8oi+qoyWkKLsDLCuxkCE9AspD8fbK7
	U9jcIQXlRU7/pjDj8Gc0lkfB22ToRXB+Jv5wGcYsw+axe5/QS5mBZYEm4MY3Zs2V1Jc+a6Z7Vnp
	tLNZ5q+vnDUGOfHaddbBdlU3xSZ9x0O16zpWk9M3h
X-Google-Smtp-Source: AGHT+IFAFL4Jrh9Si4Gax3r4dtRoG0FBSmnCiBh0EFTCVqOTSuBu2GcZmIpzrGnEwTgp1XUPTU94PQ==
X-Received: by 2002:a05:6902:2186:b0:e60:9b80:1f82 with SMTP id 3f1490d57ef6-e63f64d1799mr10862158276.8.1742106039894;
        Sat, 15 Mar 2025 23:20:39 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:39 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:17 -0400
Message-ID: <20250316061429.817126-9-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

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
-- 
2.48.1



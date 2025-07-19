Return-Path: <linux-kselftest+bounces-37659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8156B0B268
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6501AA02C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767028A408;
	Sat, 19 Jul 2025 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXq9Cboq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91928A1D7;
	Sat, 19 Jul 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964940; cv=none; b=KV6DuUi31dAys1W4mJtzdmNVM7tYMRtZ48mOq6Es07o4tfgMjYS5D3x8hxfeRRsNXKDFb81oMZcDmk1nvHtGDO1Ux18+zPedn8koHC8TMLqmAoq5XUr8z2S2P83PnAepEQezgyih2x+0EeGcighrcusdBeBKOvhCSu3jTEStUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964940; c=relaxed/simple;
	bh=jyqFD6nM8ro9Ks9YCIIHVd34qdVyENgV6xpP2iUg/jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qnL+uoCEkraGGf6atRbKo0RfQjRF7cpxUH12PAI0hTkxHaNkhePjx2h1+3d0RB6Tfrj4JHtxMMP1wbna0ZzmB3pACs79wJFS60uk/puQez/qvIbStWqcHMXYyG1nPr6AJj6BPAqKx88mSimI8w9d5ocmdmG5y6/cAPnFdFOWUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXq9Cboq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e34399cdb2so344326585a.3;
        Sat, 19 Jul 2025 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964938; x=1753569738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rs1DGyghn6m5F7YPyJpVWwpTqkEtp8qoCALsZqeRz8=;
        b=FXq9Cboq+oT/fzSrphlsy+HQsi82AdP+VMsfeS+1Xdh7vez+U2IBHswHd7TIG4XUll
         XTBQ16r52tFYTrEBeyUxlcap8NhHJdHhFuW/f/jotelM1w9dHdICQv8SQyYHEh4geX3a
         oqf9UJYIovAXzGyVzvHvFqOaLX7J5zi82D7RacxFcrGzvUnHnEqBTwcDOvHe4Bq5AnN2
         I5X586tlC15ztx4buiAcFnlVcOcp5jLNds9Ra3wQllRcPQHxVlAR8qH8SyBgvO/uiKZ9
         Q2/3tNemw66nHeyw7K1hH3E/sJjzOzb0elXeVK6oW/ZHq6Rng2mehkiZFHsytvkk3bfH
         H3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964938; x=1753569738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rs1DGyghn6m5F7YPyJpVWwpTqkEtp8qoCALsZqeRz8=;
        b=wEIIq4/pwSWc//fW1alJZKjFy7aYO8SLmMPEKN6/Innr9VgUYDX3/ZljXtClBUxQxb
         NvCcxyVA9azoQcQ5VTtK0tTCU3nB4VaILp0Lg0waEd2J94xIDhyNccPQRyvH+E0Xbr7v
         AYCCy13UPB5yWVWBO/cAOxPOnpTXJXns8xbLlxrcei6m9sxJHO1NNEBDSXOfxyBWsfsy
         Y/Kh7LQLVdxdTm93VXMc7GxlpOFsjUop/Hr16sKwLm+IEqk6Mudbdww3z9HYnNviRfZO
         Y1rLsSJPzNeXKXlZ3Gr7OTBtGXvCBiV4QekEpabTRCBWE3EVDjTakJFaqGvzP3irf7dt
         A12g==
X-Forwarded-Encrypted: i=1; AJvYcCUWxqxGR72YfqlozO8OdN+kxQiUPcVVHuFAJoIY9j4HM3ZC0mh1lKRkSynHjRqICJqjSIvwinrppPbbwRZSvXv+@vger.kernel.org, AJvYcCVGtoWWXkta9hZeGyCYBIqt3SVY3QytDr1IDS+/cGWrPscX3H2ZIo8srL8XegONOpUV4FKmEQxBrCqmtw==@vger.kernel.org, AJvYcCVVNovyfeRr511OANIuhXl1w8Miqe0J8ErGTV5tz0QvElAU+Er1AvWhQvc6vPWOLydTY9nMSURXfRQujpVU0iM=@vger.kernel.org, AJvYcCXIrQ/S8imTZjElLJIv897ybakr+45VKkC3IM6EuclKgBLm0/0jzvxZ/x0Fh0Enyvoa93OBO+SRxguQCJ0z@vger.kernel.org
X-Gm-Message-State: AOJu0YyfXZtL7i8OfGEyqRgC91frT235XmgTcAoiyRJfwGDK5pDGGndX
	s9ws5NmvIeNf6Y/MXRRkYD3FPCYn/oZ7wyNzJzEeVy7XpzE4X4CfUTtb
X-Gm-Gg: ASbGncvcn2Tke/X31V2z7eOjZRhrE0a2/NPzeHvANd7Qy0kYEsAv0it6//SiSoFgQwQ
	wJJmitX+00EadkQp1dxREd55BY4hcIrJpD8cr4emdaqqZR63pV9SWGW14z9FEgh6bYV0t7jLhRM
	DzpmfUktI/sXpko9ahJ+gBDStkjxyeprzyunXKwK1c94oWbQpIsr+68mGuYqnORb7PHXpSHXBd8
	D6R4OHo7KvwLaF9a0qyhEn42RdbzdBsMOXAhi2m63Q0I1S4CXaLvlfde2LErFJkazyDQ+GR4lId
	9tY/JdcagPodYjdnnxwp+lb4ttd+Yl2wXr8gCq427Fr2GKgcX7wM6wbk2ECwxq8AW3ezlHRlomQ
	7pXZU3vTCsfNmpHZ5AIxz6QNs0snrERNEhDep0yk5t2SGCUkbZ2UVW80m4OXvxOUriUO1q/Of1Y
	Ii/PrMy7+MsoiKRm7AXff/Td+13DUg6mDb9GZxObE=
X-Google-Smtp-Source: AGHT+IFtOTZ/PrQwepu0hwdAQftEUkuWxYVHS9B8D5JpfvXd++3lzu/pWaap3iuGs4DIwGCQ04QMyQ==
X-Received: by 2002:a05:620a:7203:b0:7e3:4601:9721 with SMTP id af79cd13be357-7e34601a170mr1752546885a.44.1752964937883;
        Sat, 19 Jul 2025 15:42:17 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:55 -0400
Subject: [PATCH v2 6/8] rust: kunit: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-6-1ab5ba189c6e@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=2517;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jyqFD6nM8ro9Ks9YCIIHVd34qdVyENgV6xpP2iUg/jQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNOn8Tovv2dHgoqC1i0lAp321l6XEurS5uFMegrG079Th4U9L3wXbn9B8imJH6UktgvZZeU5c9O
 yz00xKgktJQE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/kunit.rs        | 8 ++++----
 scripts/rustdoc_test_gen.rs | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 099a61bbb8f4..42498cb93f33 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -6,8 +6,8 @@
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
+use crate::fmt;
 use crate::prelude::*;
-use core::fmt;
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -74,14 +74,14 @@ macro_rules! kunit_assert {
                 // mistake (it is hidden to prevent that).
                 //
                 // This mimics KUnit's failed assertion format.
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
                     $name
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Expected {CONDITION} to be true, but is false\n"
                 ));
-                $crate::kunit::err(format_args!(
+                $crate::kunit::err($crate::prelude::fmt!(
                     "    Failure not reported to KUnit since this is a non-KUnit task\n"
                 ));
                 break 'out;
diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 1ca253594d38..507d36875196 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -201,7 +201,7 @@ macro_rules! assert_eq {{
     // This follows the syntax for declaring test metadata in the proposed KTAP v2 spec, which may
     // be used for the proposed KUnit test attributes API. Thus hopefully this will make migration
     // easier later on.
-    ::kernel::kunit::info(format_args!("    # {kunit_name}.location: {real_path}:{line}\n"));
+    ::kernel::kunit::info(fmt!("    # {kunit_name}.location: {real_path}:{line}\n"));
 
     /// The anchor where the test code body starts.
     #[allow(unused)]

-- 
2.50.1



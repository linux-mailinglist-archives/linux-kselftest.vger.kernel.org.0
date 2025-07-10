Return-Path: <linux-kselftest+bounces-37004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35264B00746
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E50D483461
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707272EAB61;
	Thu, 10 Jul 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2tHOLqW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA32EA73C;
	Thu, 10 Jul 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161532; cv=none; b=hg/CxVwN8CgRCoaqv7ZzdhrDyWoOls7UMbBvy/8sT2pI87Rypes2KGruDfU4YC38chCbCk8r6WzaJn4iRbq/bChrjz07/odyT4qroSGnq4Dz1LZNdGG3D8rM1hqCGNCC/0TurE8HUTYcKnq/uH7knO28Lv+tNFoYlehqLQpTMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161532; c=relaxed/simple;
	bh=lLdnM+NUEuXkQdsCZ2Zc/ZWA5W8wgiORDQ2a6677Zzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQhSe7SYC7glGeEpmnVeCfn4FWCWUqx3Yv2sJxYkJOSdkobLMzJhe+NEoIkXgM2Rba59OIdEr4gyFBYhDmQLOspEDkRVWwiEDKew0U9DkPwKeZYWnZ7Zz0AQ54KVn6Iv7racMZvONi73/dpA0Sjq/TT6yJKsgEwhkcFnT+azL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2tHOLqW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6face367320so10040656d6.3;
        Thu, 10 Jul 2025 08:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161529; x=1752766329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg9MyoLzW2O/wZTFQuwcCSu9JeslcLq4bzCQcPCtBGw=;
        b=H2tHOLqWsA/F9mJv+GKxy7Wvb1tP/3gMKiJipylhtMWB3Xqq8PxJ4hL5ey7LIOn2rS
         LwLlqcKTBLprwN9jkhBH2yKlB3yxII02DuVw6bibBBrMHDB3OnmLFOBtEhiEBmpRXne0
         wxOMxtlA9KZBz2ScGpgBOpZClHFw2sYPkdt+Eu5e1DXflitGMLbD6jl+BEIZNGiJB1IS
         7u1vRqNs8czVBj7iapBCuicCpf8dg5BpUlDYAMV86ywh4Ity2rWt+YuqAufOdbXr4iJL
         E7SgBUgnPuGxbB1EVvGN4e75lcQQjUknD1IgDZI7jTmiWl71YHKEBkxmuOeFkS96xpQt
         5Lnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161529; x=1752766329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qg9MyoLzW2O/wZTFQuwcCSu9JeslcLq4bzCQcPCtBGw=;
        b=fr8BAfjZfC823xSNDi8T+Njkm375b2w4Yva6zyHJchOZsVud82oJRP9qwx2iOODXWF
         W+dFPW3mtIZudYfM4STNk9Vw+ovh7mJQyi76LapSSfahSHbpfC6kqpQjOH8xxiTVQHO0
         lLMIGDjdCu0h1PYkLAywIppikmhES5s7fHhs9FRKQxxeeBwKMVTYmsyQ4XCMS259iIym
         GQjjHEhvGC1g17lBw4bUaW4OYgJhL5OhIlcyJZ1O/E28WxmMyOkqFtEuVdDieVsEkTFm
         Wf8nRaYKRULjwtBhpDjHYgzCHIDgyx2Kz0DUrvd0PW5e4b31JC2vyNrja2wh11SDzx09
         2wcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNPo8ztHMvstNB5uOIJ5Ht95+ugQDreiZ0q4H5eW4SeDo85yE6ahJHIdxEr/jRPtW3GED2eUAs1Iq3G4Hv8IA=@vger.kernel.org, AJvYcCUVIJKbeldAT1iOs81ce2UO6ZA4QtIYUxe2SA/GJvtjltHH/sX4uFqJgAQqyhXSOh4MS4QarbDD/YABFQ==@vger.kernel.org, AJvYcCUYqb8yhy2JVggzvJ8BG7N39Cn8tpazPGeMrTJZ50sBsMo/doKUYrGthYZyiK1CrAyqiwfdgykq@vger.kernel.org, AJvYcCVJcOXJ0VvfepV6A1ASFgVpRWY4pSdghv5LpNkezmRBrb17undJhUhY+ZkuDTQnnlnNUMlCK4rioB6S@vger.kernel.org, AJvYcCVo5m1rlrV8/2s3ssP1sSYQq+z83Ee9JfQt1VXwsshzH287y/g//SUvJEeRD1S1MZxEooGtTjYRqOV+Dm26DV2U@vger.kernel.org, AJvYcCXJtWOrpYSwS+qHacLTnykXyQHwaFH847PmVyCd6qSOfpdmFtgAV8vPWdXRaFkY0/HUibYssOjlrx+M@vger.kernel.org, AJvYcCXkQup6nqO+6OKlAxo9aFjSDMeE8dK15n0QIZ9eisOrd8NrGoQ63mcjiX65YFH7osOzS8CqyqB5HfFM3GpJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBP0y17bK2oCxc570hYMuD8Ho55sJBGysQ/UGoGn5RkfNXSuB
	uDUJBi3ReOnuGl3QOt4HgohW8+xeDA507WW2SrxtLY/IQDnxLxYkAgG2
X-Gm-Gg: ASbGncu2qj5CiaSAdaRxvftywAFpJPu0kIHttrFdZDNHVETnhHaMcnU9ywtvZYDdcrr
	XyuAxZoYQOXgTP/3gKIBts/HmA2WvyX8WXmUGpIXqCU6UbYI9e7tCflxz77AydFevm0LjWwZO4R
	xOiOVgppdXsKCwR22yJXOjLEyXRLnWxnKMoaLAi5u2TPDmIy/X92Z12DUWlaONFQNbk9JQD2jZL
	L+XiVZbEipp7Wl/bZTmjfW33mdl944IA4dKC36B/oRmQNcmwc1MtHHKCfe786SZIXrFaICKpvRr
	cIiHeBXWsKgapkJHivQGNYmi43w2fHTaDU94D3ReKU0O6uvmCJsYVJ0sjGZqr/0rmzrBTFdJcvW
	LSFdvhc1T1n5rgkK/RbW/4YzNYR4dKlq5o7qTPs6pTk8cxFgOW5cD3aDjjw==
X-Google-Smtp-Source: AGHT+IGR2RRZQW2bcini0bMXKS9fKRmwAOf5eVXkkfrEVuuKui6PaVOKJy0ulnbPEP69BzEKMolKgw==
X-Received: by 2002:a05:6214:328e:b0:6fa:bb26:1459 with SMTP id 6a1803df08f44-70494eeb96cmr79324366d6.7.1752161529395;
        Thu, 10 Jul 2025 08:32:09 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:32:08 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:20 -0400
Subject: [PATCH 17/17] rust: sync: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-17-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161491; l=3792;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=lLdnM+NUEuXkQdsCZ2Zc/ZWA5W8wgiORDQ2a6677Zzo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEQCLdocV7E4OivASyLh0mReapGH3HAqrlKw6p+xfkfcFh+9TajU5mVNbgdK6iJLvlwtkJLY9Sp
 YR4gNbcIrDgs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/block/rnull.rs         | 2 +-
 rust/kernel/sync.rs            | 5 ++---
 rust/kernel/sync/completion.rs | 2 +-
 rust/kernel/workqueue.rs       | 8 ++++----
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 6366da12c5a5..9aa79b862b63 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -55,7 +55,7 @@ fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
         })();
 
         try_pin_init!(Self {
-            _disk <- new_mutex!(disk?, "nullb:disk"),
+            _disk <- new_mutex!(disk?, c"nullb:disk"),
         })
     }
 }
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 63c99e015ad6..9a6d2753937d 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -43,7 +43,6 @@ impl LockClassKey {
     ///
     /// # Examples
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::alloc::KBox;
     /// # use kernel::types::ForeignOwnable;
     /// # use kernel::sync::{LockClassKey, SpinLock};
@@ -55,7 +54,7 @@ impl LockClassKey {
     /// {
     ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
     ///         0,
-    ///         c_str!("my_spinlock"),
+    ///         c"my_spinlock",
     ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
     ///         // `from_foreign()` has not yet been called.
     ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
@@ -111,6 +110,6 @@ macro_rules! optional_name {
         $crate::c_str!(::core::concat!(::core::file!(), ":", ::core::line!()))
     };
     ($name:literal) => {
-        $crate::c_str!($name)
+        $name
     };
 }
diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3..97d39c248793 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -34,7 +34,7 @@
 /// impl MyTask {
 ///     fn new() -> Result<Arc<Self>> {
 ///         let this = Arc::pin_init(pin_init!(MyTask {
-///             work <- new_work!("MyTask::work"),
+///             work <- new_work!(c"MyTask::work"),
 ///             done <- Completion::new(),
 ///         }), GFP_KERNEL)?;
 ///
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index cce23684af24..432624c69c72 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -51,7 +51,7 @@
 //!     fn new(value: i32) -> Result<Arc<Self>> {
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value,
-//!             work <- new_work!("MyStruct::work"),
+//!             work <- new_work!(c"MyStruct::work"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -98,8 +98,8 @@
 //!         Arc::pin_init(pin_init!(MyStruct {
 //!             value_1,
 //!             value_2,
-//!             work_1 <- new_work!("MyStruct::work_1"),
-//!             work_2 <- new_work!("MyStruct::work_2"),
+//!             work_1 <- new_work!(c"MyStruct::work_1"),
+//!             work_2 <- new_work!(c"MyStruct::work_2"),
 //!         }), GFP_KERNEL)
 //!     }
 //! }
@@ -215,7 +215,7 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
         func: T,
     ) -> Result<(), AllocError> {
         let init = pin_init!(ClosureWork {
-            work <- new_work!("Queue::try_spawn"),
+            work <- new_work!(c"Queue::try_spawn"),
             func: Some(func),
         });
 

-- 
2.50.0



Return-Path: <linux-kselftest+bounces-29712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356DA6E61B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120F77A1AB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D11F03D1;
	Mon, 24 Mar 2025 22:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ac5C/BK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB671A83F8;
	Mon, 24 Mar 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853708; cv=none; b=V+m0Y7aE2WzlqC7UaYWOxLE3+nnm4swec80mhIxkV8dIAMznDsVxpPGpSkyDCsc7ybzBabWODzVA0xmqd0jFASYk3vY5PIlAsWShj7/4r2pNv/K2Po6fLx8h3p7040gDkm5tRi+hs0reC/21e64FVG0+WGDl4qxdbY7D3uNNdVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853708; c=relaxed/simple;
	bh=jXBOpo5UWtwyrzWvahiJ2pLNqcTsAoQ2rJCCE9+N488=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slJO5rD3MoadNeR75vNe4ZTNhytdw5tbgTpMKBAPwd2V7+GNOajxctO7dE79TwFleHmbaNNbTcxCFZ3ZC2KEca8oqJC8Gtbo5rb7BIxR0VIhB2veCZgG2vUQEQb7T9/maPJOHkDB5vJigrHhvFqa716mvcUc14rCuO78VGxMy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ac5C/BK+; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-474f0c1e1c6so75604391cf.1;
        Mon, 24 Mar 2025 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853705; x=1743458505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLYdB8oz2i/GfcI4zN53mys18Ki2XN46F1DPNODr+Tk=;
        b=ac5C/BK+lIVre3hExgxqeJbkMUWOQvXcwgQROQDkqqIB9dKRl/wWUAtEbIWsTjxgbG
         IHaaOovBCkrHQEiRxkn/82LyeIOFg8S5v6szFc2mHIv2jjXT9Z4gtFV63zSRZtfH466S
         n/BY9gytp+PrHv4MHxc/pvjik6315rsTpi7HndyxC/KSLuXdLvjHquq9kPLdCtz6gg1/
         bDACxnGLtD92L8SKpBGGU2iN7NOZVOL3VnJW1Ugdrg2bum3gasQIDv/8LJsx43ectCAc
         4iF/KnaU7jVfbkEbhrnpdDwZ1bNhd3a+L9QmxD+Wo6iRpH12025+xgHLlwqut65xBnWS
         1EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853705; x=1743458505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLYdB8oz2i/GfcI4zN53mys18Ki2XN46F1DPNODr+Tk=;
        b=n+B++mf1p4SI698CgKjn2yTdBY9ymhfWCWAvESUD7j08tlKHyEr4hrLj+dYfZdNwvt
         ATZmepU6nuuCjovLbZTaPqHUD93EaYgJ8jfrzmTk/6CFPEKAlBQAksczMyiYddbXAErq
         6VFTXZmJLJyT9KP/oYCLsg9tB050XEL2HMkaRVX6b5VP0GL6+a6JEwRFgeRhbkBDT1Iv
         tNCFAEWCqdZ1uos3rDlKhFJUIWsfWczj9G/+Rzq4/65dBptQm736xzTcDAQmrLiBqRZT
         9PRTQigA9Yl1wejkNV3NqjLXSYntz2eaDdXaG3lqManVEJXcxdhfN3eUfE5VN3KqkX6y
         CKrQ==
X-Forwarded-Encrypted: i=1; AJvYcCULFhBpyYtztMZ3bA6fiP+FJ4+T5ttDAhtRKGImXLqfjXxnsVH4IMRI2lm94iQh+wDwJ8MDJjUMQhPX@vger.kernel.org, AJvYcCUh1PlhQqd8aUdZK2JWf2bDKQJgmHyFocSG9j+dD26v7g0JkSmh/oONgXoFjYUKWEaW9pzPN8SoDI9AgaVzcAw=@vger.kernel.org, AJvYcCWhq/YWJvSX7Ew1uXCttWmLnfbXBBeQMADpl8AHRBRIuYWX4NyvnunZvoX4FZsimTepwEX4FZxQ@vger.kernel.org, AJvYcCWoKH35vVesDjkS07LbF7Oiwg3b2dPBKJuyaOgw/9NE6wzUH7Q5fRAMKbf6wxgB3gyWDxi7S04gw8WPDH0=@vger.kernel.org, AJvYcCXgMw64Bh+MbdyoWHWcQkNRcYBSusfqF8eKxrpnsH1TIGB3fvCYXWr1vvVjL+9x7sYRcV7o/1xtzcRk@vger.kernel.org, AJvYcCXsrbC2451oV+9hIqOhaEjvynJIe30HsIdTkUaeaYZI4gMbrpRE1FAWZvy7DOkQWvLepp/Bep6CQA0Mo7JgJmBz@vger.kernel.org, AJvYcCXuyLtcH54cof2cvy7QBvLjE+ZK4Y74Y/wRrS9OlD9t1Aj8+AhVQOssJzPrIjtHhbDb2KKyyN2XvoHIa0tj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyg4vD8T6G0HngbpqiMf6ZhN6xpjA90TSYIvNm4BDOTWqt7BMO
	yjxAGGcs4807E0SkJKsdPnMXMA8EOaPTx8Lbbai3pUWP0tnOnhNi
X-Gm-Gg: ASbGnctFsJSkOngo5Ym09GRV9peJLYcTx5QzBVZi5pI9Fhhtcgnww/XYHWoxvSFsI38
	E2IbijVKoQpqiLTIpc9ddAYzIDidH5Riu6GsHIsQRRlI6mzgxdsMsO+XicYXZRGhGOXxYi5CvLs
	4WR3zee0H61zDB2bbUGSryz6aHzEGK2gCFORhz3iC2od6LF+QDsm6iKgvhKmdN3LiFkPynX410l
	y0uXBtlBdGFth6sMbGjo02hvwSBLuYfnEbNWcTmMcjt+BhsHKp51cMyIZ8kmpYriT7jQgXMzXpD
	3RxsR1y5pn/JakZ97Rll70POsPsiNBMDFxX+JoW5T4BZtXj6kKKteLs+pi/Pi0m7I346mmBciII
	ENZwKrr0rhQ6wuORRYS1UYiBJCjx9Lb7GtgL8h1DOcq1clOXSpO2a6fjSbS9HCY/8
X-Google-Smtp-Source: AGHT+IETbkIsiMSS3aJnwxSeNF2HAjbJX2SYSBhI/Fk+fnGg2Vjy1M9GacySt+Gyh5yE9AnyKA+qog==
X-Received: by 2002:a05:622a:4d03:b0:476:77a5:3106 with SMTP id d75a77b69052e-4771dd615e2mr239659571cf.5.1742853705391;
        Mon, 24 Mar 2025 15:01:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d0ad87esm52129541cf.0.2025.03.24.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:01:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 18:01:30 -0400
Subject: [PATCH v6 1/6] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-ptr-as-ptr-v6-1-49d1b7fd4290@gmail.com>
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
In-Reply-To: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Avoid casting the input pointer to `*const _`, allowing the output
pointer to be `*mut` if the input is `*mut`. This allows a number of
`*const` to `*mut` conversions to be removed at the cost of slightly
worse ergonomics when the macro is used with a reference rather than a
pointer; the only example of this was in the macro's own doctest.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/lib.rs      |  5 ++---
 rust/kernel/pci.rs      |  2 +-
 rust/kernel/platform.rs |  2 +-
 rust/kernel/rbtree.rs   | 23 ++++++++++-------------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ba0f3b0297b2..cffa0d837f06 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -190,7 +190,7 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 /// }
 ///
 /// let test = Test { a: 10, b: 20 };
-/// let b_ptr = &test.b;
+/// let b_ptr: *const _ = &test.b;
 /// // SAFETY: The pointer points at the `b` field of a `Test`, so the resulting pointer will be
 /// // in-bounds of the same allocation as `b_ptr`.
 /// let test_alias = unsafe { container_of!(b_ptr, Test, b) };
@@ -199,9 +199,8 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 #[macro_export]
 macro_rules! container_of {
     ($ptr:expr, $type:ty, $($f:tt)*) => {{
-        let ptr = $ptr as *const _ as *const u8;
         let offset: usize = ::core::mem::offset_of!($type, $($f)*);
-        ptr.sub(offset) as *const $type
+        $ptr.byte_sub(offset).cast::<$type>()
     }}
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..271a7690a9a0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -364,7 +364,7 @@ pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
     fn as_raw(&self) -> *mut bindings::pci_dev {
         // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
         // embedded in `struct pci_dev`.
-        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) }
     }
 
     /// Returns the PCI vendor ID.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..84a4ecc642a1 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -189,7 +189,7 @@ unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
     fn as_raw(&self) -> *mut bindings::platform_device {
         // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
         // embedded in `struct platform_device`.
-        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
+        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }
     }
 }
 
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 5246b2c8a4ff..8d978c896747 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -424,7 +424,7 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
         while !node.is_null() {
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
-            let this = unsafe { container_of!(node, Node<K, V>, links) }.cast_mut();
+            let this = unsafe { container_of!(node, Node<K, V>, links) };
             // SAFETY: `this` is a non-null node so it is valid by the type invariants.
             let this_key = unsafe { &(*this).key };
             // SAFETY: `node` is a non-null node so it is valid by the type invariants.
@@ -496,7 +496,7 @@ fn drop(&mut self) {
             // but it is not observable. The loop invariant is still maintained.
 
             // SAFETY: `this` is valid per the loop invariant.
-            unsafe { drop(KBox::from_raw(this.cast_mut())) };
+            unsafe { drop(KBox::from_raw(this)) };
         }
     }
 }
@@ -761,7 +761,7 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         let next = self.get_neighbor_raw(Direction::Next);
         // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
         // point to the links field of `Node<K, V>` objects.
-        let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) }.cast_mut();
+        let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) };
         // SAFETY: `this` is valid by the type invariants as described above.
         let node = unsafe { KBox::from_raw(this) };
         let node = RBTreeNode { node };
@@ -806,7 +806,7 @@ fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>>
             unsafe { bindings::rb_erase(neighbor, addr_of_mut!(self.tree.root)) };
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
-            let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
+            let this = unsafe { container_of!(neighbor, Node<K, V>, links) };
             // SAFETY: `this` is valid by the type invariants as described above.
             let node = unsafe { KBox::from_raw(this) };
             return Some(RBTreeNode { node });
@@ -912,7 +912,7 @@ unsafe fn to_key_value_mut<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b
     unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut V) {
         // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
         // point to the links field of `Node<K, V>` objects.
-        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) }.cast_mut();
+        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) };
         // SAFETY: The passed `node` is the current node or a non-null neighbor,
         // thus `this` is valid by the type invariants.
         let k = unsafe { &(*this).key };
@@ -1021,7 +1021,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // SAFETY: By the type invariant of `IterRaw`, `self.next` is a valid node in an `RBTree`,
         // and by the type invariant of `RBTree`, all nodes point to the links field of `Node<K, V>` objects.
-        let cur = unsafe { container_of!(self.next, Node<K, V>, links) }.cast_mut();
+        let cur = unsafe { container_of!(self.next, Node<K, V>, links) };
 
         // SAFETY: `self.next` is a valid tree node by the type invariants.
         self.next = unsafe { bindings::rb_next(self.next) };
@@ -1216,7 +1216,7 @@ pub fn get_mut(&mut self) -> &mut V {
         // SAFETY:
         // - `self.node_links` is a valid pointer to a node in the tree.
         // - We have exclusive access to the underlying tree, and can thus give out a mutable reference.
-        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links).cast_mut())).value }
+        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links))).value }
     }
 
     /// Converts the entry into a mutable reference to its value.
@@ -1226,7 +1226,7 @@ pub fn into_mut(self) -> &'a mut V {
         // SAFETY:
         // - `self.node_links` is a valid pointer to a node in the tree.
         // - This consumes the `&'a mut RBTree<K, V>`, therefore it can give out a mutable reference that lives for `'a`.
-        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links).cast_mut())).value }
+        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links))).value }
     }
 
     /// Remove this entry from the [`RBTree`].
@@ -1239,9 +1239,7 @@ pub fn remove_node(self) -> RBTreeNode<K, V> {
         RBTreeNode {
             // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
             // back into a box.
-            node: unsafe {
-                KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
-            },
+            node: unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links)) },
         }
     }
 
@@ -1272,8 +1270,7 @@ fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
         // SAFETY:
         // - `self.node_ptr` produces a valid pointer to a node in the tree.
         // - Now that we removed this entry from the tree, we can convert the node to a box.
-        let old_node =
-            unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
+        let old_node = unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links)) };
 
         RBTreeNode { node: old_node }
     }

-- 
2.48.1



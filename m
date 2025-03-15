Return-Path: <linux-kselftest+bounces-29128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6F5A62C6A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B495A189B7B5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162A1FBC99;
	Sat, 15 Mar 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDCjajY+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A64D1FAC25;
	Sat, 15 Mar 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041056; cv=none; b=aIOtxA6N5Awwz/JoSmPiw5+J6PXcOwLli0slB4yB23lhcYC5RQc8P93ZHSaBRcJUZ+9vRjtHQYflD3saq34Sd1fAbNDPji+TJr5VRIE/Vl8IUcuNrsVyduqQiS8UVe47SBZxz5zbB+65xU3Sha1xO3HkymZiBjlODcmWf2mmPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041056; c=relaxed/simple;
	bh=dDQupNav3SXw5VhrEjMVEy17ST8KxvEPfS1MsDl/Bvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ExXOhsqDWINEX2Twyu9RA1r4A7lk9X6yJ+z1W0geCe9wiKHxatXrMq8g/FzSYaywBUt/RpwuCqB0yI3UobU5VdI87QUgA3LgNXYTZgPZ+MXOtknJpMfLNbvl8yW6bInEoaTkTh9NibqgResbktvnlferVkukbEueE/iuMG/n8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDCjajY+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c54a9d3fcaso306209985a.2;
        Sat, 15 Mar 2025 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742041053; x=1742645853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRSqdfwSx/UEQwa1Uc/BINHa6oMwpSmypgRT8Rx991M=;
        b=lDCjajY+OFRthBtomcZxvVTr/wmj8YidFraczG6vnRdH7bkVecDVZlKiBeDALNjGgW
         8f/4XfryBrvqSb5qbJ1OsROBY0Ku+Lrm60AOdgJ6Wf9BIE9J2Yxl/r4Sjn9ek7NRQSke
         PudXg1t5KVosrwVZwHWkbw2SGM1k/tZiuO82JdkxJMkBxPCt6kz8zBUcisjSNKdVui4v
         ayFOJcYAm406mk6JWVctbsNormFNVNbq6ghsRSsYe7G2XMTKH6E78KJIkDQqxlgefmyt
         oN9w+sKcjWo3+xGvXzI8OdiDhtv7Hd1twC6TEZhn0zIdCFZdVTOyVFkJvuhhvQVZOFqC
         RmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742041053; x=1742645853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRSqdfwSx/UEQwa1Uc/BINHa6oMwpSmypgRT8Rx991M=;
        b=Qqu9T3OrnoTAK3Nta0LlwjKwfuyHDeWWH4U8q/xNENKnoVFIU7WSGcJmVYWUWoZQzx
         QT23TfA+GSrxqNhQPlistxeiu8f0XIU9+I6HNbC3UzHuwnGz79mUrZDoT9bwmCsMWcrY
         PjCbQ8v1ujOLwnh0j0X8960CtPo2SZ3WKDAB17ZCNAEKwKdRpeMCI2Gz6Wliuo3yWYi6
         5GwExpgBtGk4oFLSMqXv2hdmBNcXXY69f2GkSs/3tIVBdrA/ST8to1ekVD5M23YjJuQ9
         zrxUKnkCdug8ExxJ1GkpB0vi/UKuduLB9xOiY2u8QBhbveMTyHdP98ZMiki06hX5CtmF
         QYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGrmKD1pFna82ZwvZrOHtyXAA0wNNBLgk5hwcSiK58uPXXUU7ADjR/UJuwhSh6n2+onz6GQyNGrcC6@vger.kernel.org, AJvYcCUk9AwhPe529m0kGiQfZRh7iu5qPXJB1P7lcq7GphnPb1YmT3AA6pN6ymWJt0lREXhCo5GsARiMjN37N3h0qUcj@vger.kernel.org, AJvYcCVo3bPSoZZivzpfOQSiClSIpOqOODGaSNHsepbZZZvoSR6ukTWYjeYyIAvWuibJw/2V2DDPFnvukdfCRmYa@vger.kernel.org, AJvYcCVzUd2hvk1P5L5vuEstnPtbrTHlQm+gIicCQEGDraXCkOlrixy8ameEV3GiHyFBOAwyXyz5CaBIBgE0SpI=@vger.kernel.org, AJvYcCWKKKM/EVFQQJd7bJM+N1SdnKM/HQ0G5mdRVjF0LYk+jxg+3qL/xv46lr0HpmtQC4NhiIVgLsXuFHYu@vger.kernel.org, AJvYcCXsqTEvfmCAyoFQfiXxV27OnHrLYqhGXZWbRRQ0uKJvRQLGi0SX+/1zOjq4T6/b3Urs9EevuSPGTYeYHCeHEAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBxYNK/6pl8/nRQoLBwBWTHNRcEZ4sR6muygfJKe9xEZREjsI
	Z+tK4M1e0M1FT3kZmqeMDJfA2Znr0fQYJ14xmySnyHcO7h5XY75z
X-Gm-Gg: ASbGncvFOIPFP/5bCH74fU24JsaJ7pDPOu+FmySgBzpzeXrJ8PInFm2Jru9dymsvu4F
	QpkpvsjSJC4fPSdmtf4iekWC61i8L5tcSy8yFt+MDAxBYCWCFZSla+jtR03RPHC3lY2n71gDBs6
	n3L0yBO0xlaUqfvbWuZRomDdNxAqHo5+B7+D5f1GFqcBztqS29aWP2nDP7oynKq++LF4zEja8ih
	A0Qq5uyjhpCkDiFvB+YgrUWA5Nz5ZNbLOBtaQ8p/ymJ5O10BsgA4dhwhPoYhtfAjDS1KtLcRU9i
	zZIoWLylqagbwCowDjS1z5HONHYiwScPWrrYcH4Ca7rBvCzWbuFz25Dnbz0q+51l6wbO
X-Google-Smtp-Source: AGHT+IG1vnCieJ3RWkOOw8/wbjPXdpDTmdmbwTkVwCHDxheeJxvF/ub82RKoP5sQ2V2Uv4kVSZ+SGg==
X-Received: by 2002:a05:620a:1a22:b0:7c5:5229:2f1f with SMTP id af79cd13be357-7c57c79b7edmr740854585a.5.1742041052894;
        Sat, 15 Mar 2025 05:17:32 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9be48sm371885185a.60.2025.03.15.05.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:17:31 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 08:17:25 -0400
Subject: [PATCH v4 1/6] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250315-ptr-as-ptr-v4-1-b2d72c14dc26@gmail.com>
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
In-Reply-To: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
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
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Avoid casting the input pointer to `*const _`, allowing the output
pointer to be `*mut` if the input is `*mut`. This allows a number of
`*const` to `*mut` conversions to be removed at the cost of slightly
worse ergonomics when the macro is used with a reference rather than a
pointer; the only example of this was in the macro's own doctest.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/lib.rs      |  5 ++---
 rust/kernel/pci.rs      |  2 +-
 rust/kernel/platform.rs |  2 +-
 rust/kernel/rbtree.rs   | 23 ++++++++++-------------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..486715528587 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -187,7 +187,7 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 /// }
 ///
 /// let test = Test { a: 10, b: 20 };
-/// let b_ptr = &test.b;
+/// let b_ptr: *const _ = &test.b;
 /// // SAFETY: The pointer points at the `b` field of a `Test`, so the resulting pointer will be
 /// // in-bounds of the same allocation as `b_ptr`.
 /// let test_alias = unsafe { container_of!(b_ptr, Test, b) };
@@ -196,9 +196,8 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
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
index 1ea25c7092fb..27de954a0889 100644
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



Return-Path: <linux-kselftest+bounces-29225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA0A65339
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789A91887000
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2524292B;
	Mon, 17 Mar 2025 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2rmOgqG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D69157E99;
	Mon, 17 Mar 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221439; cv=none; b=Ws+oj+/wx6rX6lNp0FwJPLvdVJkeSCP1JOuo1gB4w6UMOzMkdBA8qOX+1+zbngosy7hAMUil3zGpcGqMrFz0KsDcxhpyXNCohZ28Oqiup+IhKSqaX/GMOvLhJz/XD3ofVyOcqDTGDqYp83Kcf/JZa8Z/xUrx+wmBYOBz5AWXXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221439; c=relaxed/simple;
	bh=hUqDrxpSwpP9E50itXENwmGSsydhbnNR1/5lsGr8dMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqOqE339gQRlISQPCEj/aXFpEFLpBlA35EuzRXS2bKYA4bRnSgpajlNuZFyQWXdmNGz2htTOZeQ+CMwc1s/ScfvaulRNPD71HzNo4yAnuZBkwM7DW2bwYnaUr8gCXQNqD+XHs8p1PGBE2+UnBmD0Exsu3W7oTxMmfyM6MzyDjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2rmOgqG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c542ffec37so448289485a.2;
        Mon, 17 Mar 2025 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221436; x=1742826236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0rwCqLo0r32XXWfSsHXFhEq1/YRdQfuRGfOXmpf1Ag=;
        b=X2rmOgqGL0Qphp1qq9sM+jxRFfOHMlwwRO3I7dxRVOm7JAX8noLr/1iJ4M4H/nuIEP
         qNCszrRBbELZsOJJEtOITFuRApujoIqepuRHwnsJzXPgZxs2Vkbu0QlVJhpriYbMv78o
         mufhcI1BrkcKkVKf65lkDZFc98eWcgXKADFEnuLtvRQ438JvpR9iLyDp6O0FxhNI8Bde
         qwcx9+xMoomI0AyvAEObNV7LEcSYjLSvw9bKwwyHA0OYQhPtrik31ZQ8NzSqIxtVbRpx
         NXenoJzqWjOXOcQtj8u/HhETqKb7cm18VxxKnXxjdFqYsVpTQSg5wzTiqUwMD/lB6iKY
         UB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221436; x=1742826236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0rwCqLo0r32XXWfSsHXFhEq1/YRdQfuRGfOXmpf1Ag=;
        b=gijjrGJXTWDc35xF29x0eilETFZPBYUhK2rUOYYT58Fy5lVGkadgnuJnXo+vjfKeBz
         KHOPMce+rjeaqbiOr1KyNsMqRO7/f0yhqiw/IQLAkqSBPPj/QylKJvy6O6A9l5c44tV0
         SCVE+9tf18l9cVwZ2Dr9goK43BPyNQ04e7jIwBr3m+k1vmvjFnjySJOuigJAZiHUvLiW
         qtVfT2HItZUuXlDCQZ+MjzMuuChZCUWoXZZ4VHK7g0/UuAPGxCx3gAN407+4Ln/4vkt1
         NcgOuhUgMaDBh2DrryVHuAsnHzmEU2bQ8nSd0OycGzy44D4cbS1DPS+aAt+OzcRu4n+Q
         dm8g==
X-Forwarded-Encrypted: i=1; AJvYcCUpM50zNDMh0jmHTeKr7SIDKUG4geELjTmhPECCvuCHfUk2/Cyf8OWrzpBS3mGzgjZ4HHpyGyfFI1SL@vger.kernel.org, AJvYcCUptc8eezgmMRN3D2qbs+T2NfRIx/0M82s34nGFZAL4v9QbchFYJem6wWRLTrdyMIuH8LhrRa+BD8MtN52OKGoY@vger.kernel.org, AJvYcCVtVrCpfycw2O54H2FpDv6GJ3jclxa8MSyqAga4tQ2xwG6VJ1gNzZ7dBmQqAbw6IuDbOLdAlDqKmkDe@vger.kernel.org, AJvYcCX9JcjSHE7fQsK4216fuuewMYzQ7xlzBbsaCvXefBXHjQEp9UzCuWwvBj/ydymsO3TgqTu4NBB2b2/M+bpm@vger.kernel.org, AJvYcCXOBlwMKkm+natgZ7D7t4QMJb1Srn8GI7aSGCJl7oPkXZIdWJz7IE0Cz2fqeKoSq+dylpdQCjrQgQ4HejfjVe8=@vger.kernel.org, AJvYcCXqtz70nvLuGSBVEOf6CIGa528UVOteZLIR18QjNM9W/9DM9EzIeGqvnCjhS6h08MId+bsltfP1/9YwPSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUrf9N9F7ivCng0T+Iyd79+/wWMxuf6rRXE+KajjeVLiml6pu
	7Wx3FQIvxhQK1hOzlfCr1sF3y0MGZJRaRCNr578+Y3NF2j4atqL3
X-Gm-Gg: ASbGncv3dZGypXVchC/fqNeMqyGBBCZ9EOXUPT03rIB/EaGSHoLc94++d8KQX44OC4O
	OoNyOZgwJrCAdAjZ/9P6BeMbQQv/HsmzglQWkIJRVx4HAlZlzrn2qKXpQR6McL55YqX4BPZsK1l
	KBTdhGT441TnywSJ+GaVOwr2Kh/LHuxsf+U/HQZjcor1ov2eN8XbI9VZqKHUw7XCkF05xDBvEIq
	p2GJwktdFsz1aap9+L0aGGMG6z3i88P12t+guFkzicFRAphgomvIu66LgTEnhvWr9fo4ox8HWrN
	3DPmpmFENFrdv4q5m2FVwcGuH9AXdjsdvb4d71t6OVXCo6iKLO6vbbQ6mp5zmbUTqU6Jpl2oUg=
	=
X-Google-Smtp-Source: AGHT+IFbwRJE3tF5G5WYrzWKq9JvMgDWQhfQ91Zvfz64Hy339PZNTzQeIy5WWTHghR6VT2wL2+ZrZA==
X-Received: by 2002:a05:620a:24c9:b0:7c5:431f:f5e6 with SMTP id af79cd13be357-7c57c81205amr1542683985a.33.1742221435870;
        Mon, 17 Mar 2025 07:23:55 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb60b13esm54601011cf.6.2025.03.17.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:23:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:23:51 -0400
Subject: [PATCH v5 1/6] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-ptr-as-ptr-v5-1-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
In-Reply-To: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/lib.rs      |  5 ++---
 rust/kernel/pci.rs      |  2 +-
 rust/kernel/platform.rs |  2 +-
 rust/kernel/rbtree.rs   | 23 ++++++++++-------------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c92497c7c655..fc6835cc36a3 100644
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



Return-Path: <linux-kselftest+bounces-29036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B06A6111F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E4F1881F2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79851FF1C6;
	Fri, 14 Mar 2025 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOGwBJ5C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B151D5CDE;
	Fri, 14 Mar 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955301; cv=none; b=T8TqG12/pGa1PJKjZozB3RoZwcwCWtdC67tDHVthGHGK2IT2MVrV2gz1SjyBikAzWwJufhkBK4xsMQlUG+yL3x1yqR7Xue0Xf3SuOJJh0DApd7CAviJK6Lro2V9cKB+ahCq+nzWbkiCdyY72I/B+pSuYE+sGZ3WZSw8W9o61Ymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955301; c=relaxed/simple;
	bh=xoKfeHqGE8xbIYKZujtrHw9A4U3Id+Jnvx+k2aJp1W0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQYJjYGQ7u576Pfqx4FBQxpe2xvZKaq2htOxUrKgv6UhOyxNEbzdVnSxlUXbywLgEcaUeP6vjJPblT8cO7r8ooFt93zLO370+OkAxC7Ja8arGHssX99eGiS+aTf0dw13bjyO7KUfjXrcvTP9KwgDBPAULQpCB0lh/AapN7OLysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOGwBJ5C; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c081915cf3so254872485a.1;
        Fri, 14 Mar 2025 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741955298; x=1742560098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTpsijprHY7gtTYiGCqVhbcBGniYrVSsNB5A3xer/Jc=;
        b=YOGwBJ5Cofc0/5x9+bM8BmLnJ92FKspe1S48+v6QcESuhFvYTB71dfBj3c/J9PyTOK
         VvxFEQyf3ZFc527MoR8sb9uFTOI+5A2wfizQtz00ZLR5+QUR5hVrV6rWVlBJ5qt3+wQ0
         JAKd0jMQMe1Hi4T6CGfnYwKbLz6zae2Cw+ToTLWGJqKpbzXnRGSl7c00bqe6xT2kTqhy
         V0vtnUiU6YX4xBWE5Cqy3u8nyZTEb9APNYxJrDog4iZntg5k0xlQq7bsVg3E90iaWGVh
         mc7eP3zRmQq3eYJ+ycecEIpuyi1cBNbGpirHgaN1SkXkzno/ddcFOPPUqHS+NZMvduc+
         2P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741955298; x=1742560098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTpsijprHY7gtTYiGCqVhbcBGniYrVSsNB5A3xer/Jc=;
        b=E4VG4LNHgq8j4w2NmUJReZdvqywgRU1QW0AQvtfLB+4cf4taDl9KrBpN4RemD+QaAZ
         z6i1qSof6ecF6z5Ickm0TssKJsvp8x6s+qFfuJosj07kmzCEYIqtyefkCuumwDAZU7Tk
         BxLpU3hTK6tpswsmn+94cVsOsgK5wSblDZdOkKOXZ1GCyqPzbqivshhD/ukKOZyW8AKE
         uDXfimhbxV64Li4wx33MrekjNCWLVSOrKJzWBgLvvaB07GQxwjDV5vzMyaQqpE8F/wSW
         fIzT6EQ2ssPfSjVbI5H2mLePJ+WE2OJ1MwIUepoyvp6z7OhurUJPA/orwLpAyRWLrDyh
         JqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPZXQ7ZdIZL7nEPtyEUMKBJ9aDOgXv6H+cD7krxcxxZGySiirWjtCOEV02lAIpDE4OF5yseofA3UY2h2O5qRTs@vger.kernel.org, AJvYcCW/aNqZ/MS8Lb777ffnR9BMZEjrR1ks+8KbgKdl4SA4donQOhsuVNFVH+2FATBRnzyNnBe2eg+Ug5HB@vger.kernel.org, AJvYcCX9cKxj3BUpp8qVCDPLi+MGrA4MZBDAgqFMm/cQpDrDNezjGRyWxnUFFG9ICbOGDzZOWQfC2JbXSEcugIk=@vger.kernel.org, AJvYcCXCPw5GU7eDpZnjE0UsVvNyh83AnTQYnyFhv2qHs/MUKnZpya6HxS+hOtY5hrbs2KK6Vsf7nrS4Z5l0Q3h1hCc=@vger.kernel.org, AJvYcCXQcVvj5yDh7z36G+PksrgzlMZtvMg4kQlBMJhLhPGCI13vzhWNqyJbE2FC99mSM6db29FCuFZBCaWA@vger.kernel.org, AJvYcCXp6JfZvlOhoq9uaVlKL5DvEqVk8q47faVK7WQEpyi2oMu6oEtGpjz72fj02DitF3k+5GyEWwKzSiOZJmFj@vger.kernel.org
X-Gm-Message-State: AOJu0YwMYW0ANzP0s7Xbsx9LVZrOMZ4ADYMnN8Ep8rOK1PmA/hQhqtjv
	3ipTlUBFWgzoAVGbXAKEo5HJ73JcRO9VPUUf+V8xcPNzhKSDjXhG
X-Gm-Gg: ASbGncvAG9KPZ8lnWPvOcOTegDr2lCN0AZV1GMRBWdNkg8fE47VKxSgImAZWAssaZ2u
	YbATiqyBIt36bmfE6sRq71xANbDENVmJBPaEon1TeuFuDCLWNRkHhWbVut0YET8FhZiKluvPNqM
	uzPPqvXMGoBSBFFWzDDAb7SdIVP+pwZ0TFrUIt+aPWiUG6t4gZCqH8pINSR0Ujyj69b4jZ9od0J
	Ovit1T3m2+zLgFpn4p2CoU0NQgYs43r9i0sigYU7EUOQj/qYUM98vbuwoMLVoIYVuIBKefeutoW
	KVyLzNiGHoIaRPbKaJYHy/EvN+8bXtGO14ZdXo/iB553WF7hJ9b/jAkQShROANPITAey
X-Google-Smtp-Source: AGHT+IE1KvD1ifCeVsUboXcAARHOcC8+Q5SgS74dwW6JAJ45kUUdh1/tYiQlghiuWn0gWm6lDEb++w==
X-Received: by 2002:a05:620a:688c:b0:7c5:4949:23f2 with SMTP id af79cd13be357-7c57c8fcd6bmr303287185a.44.1741955298333;
        Fri, 14 Mar 2025 05:28:18 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:cd19:6a0f:e1a6:e800])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63f3a4sm21905821cf.30.2025.03.14.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:28:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 08:28:05 -0400
Subject: [PATCH v3 1/6] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-ptr-as-ptr-v3-1-e7ba61048f4a@gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
In-Reply-To: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
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
index 7697c60b2d1a..9cd6b6864739 100644
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
index 4c98b5b9aa1e..c37476576f02 100644
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
index 50e6b0421813..c51617569c01 100644
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
index 0d1e75810664..1fdea2806cfa 100644
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



Return-Path: <linux-kselftest+bounces-37661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89304B0B26E
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D0A16595F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3328B4F0;
	Sat, 19 Jul 2025 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1sZbMIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10F28AAE6;
	Sat, 19 Jul 2025 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964943; cv=none; b=OkoOmyxs+twst6uNegRvypdl8XnK04xKP1vhYrOM0icGQWcQ5fSDsQUIkgLOpY7+I+HY06MzNGsWaz88VxKX4YNZmi5neGJ+KqMoH/HYohxgLHfxmc118igNKPZPnbGspjNE+DhoODWQApf+ed8S5i3VGOUrtQb9PDsxfgT0k18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964943; c=relaxed/simple;
	bh=JT4wt4ZGHRcX28Gp51Np/HdVIFSoSzvSxV6NKAkiYZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfxoCTTqNhHRj7sXAa1iXQeWrjn8jhwkaVGO5iwRYRJvFnD48bF3ZSyAanbQEQJ63l2uEJmrlzwCug7Ov5CvSBhS2b4MIhUy6tTRAQBpcpaF4vxmZLeuHP6W0Oh1DrITKVZAKTRkj5bCTmQVQ/AqgQVQ8bn1UourPt9NP7Oc2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1sZbMIe; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d45f5fde50so289197685a.2;
        Sat, 19 Jul 2025 15:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964941; x=1753569741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdbbYgm/iXkAkxwQMWH0ycz2sZVChnbra180vU+zHz0=;
        b=g1sZbMIeEXbvKaUyQ8zDJF+7Gq+GDF58AgjGvX6vsiz2IxK0+Je9KyXjvWrzjhmZ3k
         2R7jR3tnFWXzxlNWMXIQ7iv+xtfQT2AkRvSHIQQGZqRWZx+7UHSncZlyz6SSlo6bfYPe
         uResAh1DtdBZnq48EA1TPifoiElI4m0Gb6Wi6Uk0GCOTv6zGAxfAQ0ZidXkHPgaYWtbg
         BUzaoynCAwxbuFvmoSnoDda0W17ED4xMhdJ0GTz+TVBHH3ZpCVaCNo6oAe8kbQG7ndde
         WuETqZiKDc5fY3MLCI0ULfpZ0XGjSws1nVsxNafeHbFDnmPyXHMuJ2/o1ZcWwQe/aFTF
         /t3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964941; x=1753569741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdbbYgm/iXkAkxwQMWH0ycz2sZVChnbra180vU+zHz0=;
        b=ZsVrj+03q1tIsPJpuQWe9w9d1sD78AY67nLYKsQpL9YHrMU3aeA5FvOTb9/L8yg1cw
         1NJcQjKCcLNjlGUrHGTtg9PjWWL1cjRezayCL5BnOJcsx3bclxh696HogQoCPOctiXgU
         bPxy8OXo5Ib2LyDLASxhBvh5XKP1cfl9Oz6xboGSS0jjs21z6TKEI+Ywe7ZhP6s1W6Td
         0JWIHY0AlmcQd7w6V/gYQgZ6kH9L81yVuaIIv2Apde/hD+4EvCrKdyrACwQ2yB7qUZTx
         RokS3f0kkPh0QAmC5LHR4lvNaEoXxCAe6tOv492hXpdJ5JN7DuYPn2jArb0UH98KWanC
         FqEw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Gb1rNJ+aoT8J+hzNL5DkQ05HuzMBM3hIm5475FZC+txzjGilcY2yLu517buz5py32y0yxFGewytH9DHT@vger.kernel.org, AJvYcCVTgTtJVsgd2nNR9k6nAL988BGSLv4GdD7uauxUBu2mkiIFv1CIwHguOVbaLhWQFNoxqa20d3EodY5x73STEJ59@vger.kernel.org, AJvYcCXCcoUq+neXJYmq6ejutaOxKAapjoPrgPQy3wiivGtIV+WKpPHqW2alxAQ2iDDYJ0N5fPT8VQlZuOp6MRCaDVw=@vger.kernel.org, AJvYcCXaxemWeeCtaXmTe+QiUbXfSmHU2Cwvzm1MHsIPwH8LJ/IHaKQ8XLrPKQK8adRMCFQoYPllIybWV8ATOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ9h/mJTQ88zsmQKgwgds7V2uBsnc11vyxoRfPFJTdTvIBuJE
	hpoH5TZQeSaSA0+GV/zoI+focv3hp3i8RCVUJ6EVOdQsa8o5aHbkTyH3
X-Gm-Gg: ASbGncsTC11YtVzYFaC7xigXioHNfk2XpA674VrG3NAN64HsnZRpgo1VFL3BhJRxmsX
	sSCfvC+9kPg+0bbbsOEJoLZLOcewF4Kjr3R5bN3GrWG1poUp2KoUbknePk0yKqtNV/cB54JQvNT
	fuXhI3U5B+XKG7yWzpD8QcwvvRjjROT81XvAN3snnI/fV9JpmgKBFvjsM731B6tOttX9BdY3VAK
	KoOhjQo0emsdYIKcWpEEwXLbKjHeQ0q/0ymjdy8MbTcKrqcA9MgfRGH2vkLVTqF1KsTjryU6D6F
	/R0n3XqW5++sO6+6iWPcNiKast7AUgCpG1IVZz3AGAAqti3wtYyAvWoqddNUSVTo5VpkrtDoGLN
	R0Z84MlXriIr+JGQLPg+X3qn6yzEr9TcoNeH5376WHo6il8d3fMxufkVE4V0T9FdszL6BfnMW0Q
	mJscajDZE3NH2xryZMdb/yfhMo0X0E
X-Google-Smtp-Source: AGHT+IExJ0S3QQDaiGbPTBsZmpSjuOQIlR5bLS/MkE3qOes24LnmbTk8ROv7AcJo9jNAjk73PAhZ2Q==
X-Received: by 2002:a05:620a:2603:b0:7d6:f963:8764 with SMTP id af79cd13be357-7e342b37069mr1693903085a.34.1752964941355;
        Sat, 19 Jul 2025 15:42:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:57 -0400
Subject: [PATCH v2 8/8] rust: sync: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-8-1ab5ba189c6e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=1044;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=JT4wt4ZGHRcX28Gp51Np/HdVIFSoSzvSxV6NKAkiYZQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLEQxox4uw29M7Ga/wSxO4/q3iC5xttqA8XggKW3e209GRzKxBr13fwKRE/61UufHZ5HECtWBet
 gOEf03vWiSw8=
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
 rust/kernel/sync/arc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a66761d0c7..4f3c1c2ff05e 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -20,6 +20,7 @@
     alloc::{AllocError, Flags, KBox},
     bindings,
     ffi::c_void,
+    fmt,
     init::InPlaceInit,
     try_init,
     types::{ForeignOwnable, Opaque},
@@ -27,7 +28,6 @@
 use core::{
     alloc::Layout,
     borrow::{Borrow, BorrowMut},
-    fmt,
     marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},

-- 
2.50.1



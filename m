Return-Path: <linux-kselftest+bounces-36876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F55AFF28E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6606D3B03E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18282EAB7B;
	Wed,  9 Jul 2025 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awkeAFBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42451258CD8;
	Wed,  9 Jul 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091230; cv=none; b=k8rvboB3+9UNZIp+GmUUsfwBKvhC6tEAh6vLoxhyHRh0sScizBbvpZUve9nQ3nOU/NCGj70FdofUtXf2assqFQMnyIIJ62oLJ75hmjvROUPbXXwwmJa+C+lYS/8exldNB2SMx31XTt5h8RyJ8/i+iv2+cXayDVMeSMntiXXqplQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091230; c=relaxed/simple;
	bh=6Oa3cXehoAzpEzhSDCacIqKa9qd81pBdJbPezrggmQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tyIHrPsAvcDh4q0GG+975IYt3TXGWXCgIymoCvOQNo4lkvl9XluLG8tVsrjA1+oBf74RkCyRHbyLNZW/ZoHQRv5RfT3tAmRoLuENFbg6QAHJzArJwuIbrqLblZbAieJXC0qjv30Ca5ZEl57hw3YUmYb3z+nemaZL1fOZFu6yPy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awkeAFBe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b9b2af8so2020221cf.3;
        Wed, 09 Jul 2025 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091228; x=1752696028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/DcNjK+ad89tRBvsQX+S6zpol8aKve5l6g7f8vctP0=;
        b=awkeAFBeeVjPXLUSyUR+Y4NDH6W79R4NNAM631nQHdtFUyV9UglaT60Mlb1WYp0Xje
         xNwX0y6Ne/z0PuehcyRPMOyqInp5TjXUHncuqDg4jYNjiE+CPq30GT3MzHhcYjtEkUn7
         xkNlSnl+K9x/Og9VXsd6qzYqmh8ZAYbIh4PSCQeekwnBM9cGv+/TelxtJwRhrinQh4MC
         XNktPRma4ty6EAuvb1Rk4CIqPEABACfhweE72P3X9ItwtWOABvD+Byd8cBCkGmL74XZs
         PtGCUAhcXOkP6LV0a6bl7LHR/HMB/esPd+8ehnCR7HjaKlCT5nBsqY4kQ+yZPvLa3KFe
         T1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091228; x=1752696028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/DcNjK+ad89tRBvsQX+S6zpol8aKve5l6g7f8vctP0=;
        b=qiiqX2cjjXsVWWmWtzw2Mr3Qg83NzVmyHsk8IFKA3JBgwrAhIuSRJ+2xBm2sSKGoEV
         SCzJxCcXCVl/wkxlLHZ5FsOQ9jN7qL+ds888SDdT4NOIVu6KWWfOUoBZd5gmdlF2aaLT
         2tyPMV7iY1MIslzPib1iagV1A6mwLYJG24/LidedKQL7QRHLIK3cCiDbSgoZkQDS4SfA
         o/VhNKWl9wngrlFe33XNZ81njg95YMHO/4oflAUPEHV/rahLhTAC8HgXNLD58gl9MDbv
         HPPQteXfN3MFCagT85iAwefEwiAmt+IR8ulOMbH6NlQyt745GQm9tWefUmvz764cWk34
         ZjEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi00aKeq/EiCPQU0fX8ZLNCGVZDBiJ4GTD1+/C2nR+E8XYlhTQFci48RV/C+yELoCcETUut/+/k5C+4OZB@vger.kernel.org, AJvYcCWieZaSjYp9avUJ8NXsGxBsRX/EIFaFUnjrE+t9EI1uWnqdMmkLtK1xQDi7p7Hbrv2XsXPYsCSPY68GIZh+VAMc@vger.kernel.org, AJvYcCXPqSPa/Uw1GH1mIc8EW3XeLpSwdQOSZl046ARdUwql6DB8w9umoZfMEwcbtjk6wxmyZYJq5Dsy44+yhw==@vger.kernel.org, AJvYcCXbkWuJXWvDo8jIQ+gtNWcoT4Ogbc63EWIjNaYNJX98WNH6czMMROCZsmwNnER0tfP04S02TfKvXHLJSDm00KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynH2MRFthrHnGOyq16dxES9VCkwQD6ZQt2bbd7Sl6S72gSK2/8
	h/bRJXgtAB/QJxxUh5E/eKh735gmE0SYqiDnTY0hKMSC4GReAWGDDoqI
X-Gm-Gg: ASbGncuRVCmQ1FRdLZLM6ukBnepYbESbBPddWU/9dcW8fXiSUkNj17qtGS5Ph+9ejN6
	4xt74NQkWsnuFYtJNGvlv6ju973iLsOK6BjcHLSIeKQh0FSgr517khBRwa+LX1Ha0ggY6SmJmQb
	vC26lYDND5Ec0zf3r2X6SAevjsNq/GaO/QowL1RKcDsfib/UfljDofvEZaUPwKV/tEb2BJ3RIMx
	cTOBlOjh2axxZQPYq80rQkzR2jZYBELYSbLeF3e5AG3exbrJ+VdylXnC2O+zHIU9tHcHiB/olzd
	9AKJVMYrysp00rKctCpk8IwBO1uo2wP3LI7NUljYFWKD3qvsBwnoaazHOKgSlJNjWfIuvGlnh3G
	EfYQpj6+t2fRIzld4iyyhBBM9OQTg8O6nEUB9HFQKKlM0VICmjihPc4Hu9A==
X-Google-Smtp-Source: AGHT+IGDPYWz+E3dnMDl2IGcpOC6d+1Nh292sF9LOImxi5N/DxYBIIqZq2RWfnk0uSSfN7WXQL9XKg==
X-Received: by 2002:ac8:5713:0:b0:4a5:a96d:606d with SMTP id d75a77b69052e-4a9ded52558mr52943921cf.46.1752091225141;
        Wed, 09 Jul 2025 13:00:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:08 -0400
Subject: [PATCH 9/9] rust: sync: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-9-64308e7203fc@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
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
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=915;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=6Oa3cXehoAzpEzhSDCacIqKa9qd81pBdJbPezrggmQs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKYLyzXzfoucuo4J/QNdzaRaKqUYTTxwz+z6ySMVetanHNnBRutB6OmGm/FR1SsxfYNVnaPWV3g
 F0cQtdEM7Tgs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index c7af0aa48a0a..b366260f56b3 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -18,14 +18,13 @@
 
 use crate::{
     alloc::{AllocError, Flags, KBox},
-    bindings,
+    bindings, fmt,
     init::InPlaceInit,
     try_init,
     types::{ForeignOwnable, Opaque},
 };
 use core::{
     alloc::Layout,
-    fmt,
     marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},

-- 
2.50.0



Return-Path: <linux-kselftest+bounces-36868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E1AFF271
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938231766E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19924728C;
	Wed,  9 Jul 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k46qgyCW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9A2459F8;
	Wed,  9 Jul 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091211; cv=none; b=XcI2f3Eq9gGzH22QUs06QnYwU3MUEZAYg51BR5K0R9UEzTwlafWfnKRD7HgEoqBpzaMMc6KOqmoLZCzOKkWej8miJbzZNZcoSopa3pSf2rZavnZkGYkH8uOYw3Z0pQAklvskkPeq5UjzeYTtlBvDiaMh1MuyVx+T5d/A/NYz2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091211; c=relaxed/simple;
	bh=pCigoXsp4LXT/GFOU7Jz2F9f5TrzOun3SN3jz9HmrL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5eU/x2kY6lHYjgL85g9f+OOiJLOzT5JfiQiCoJcaKlndrc2sX6U019yVr2XkL5IuKnW5WKfm8sMas7UsJlR1hZo5R8wkQ7pGJdkEDnYnwKHIa1vfWybP2ff+Lgqj10XuxVm+RI4JR0Gutw9LvvmhyOahDTFKqbzCkdzHMLLyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k46qgyCW; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44e94f0b0so3817901cf.1;
        Wed, 09 Jul 2025 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091208; x=1752696008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8SYbkq24HYI/QL2FTeNupi8GxAZULeQ0HmG/pWS2Zk=;
        b=k46qgyCWVm+6KvsSQJU+cldIK9wSZYnzQPvIVpYhsrxXvp7mzuxD9+ttyeb9ANwjZJ
         wIjWNztrgYlbkKFLj+rhT/IyJsAIxwmFnkdHXFwos9d7+fXeyorESVKZWJ5YzxRTdj6d
         ZwUzCIboCJ85uEaYpQSDKtCwBV3hTFvNovnLOOGuQt5Co3sX+RpzbUyP++n+NUYDW25O
         phtZy334N0UMDZKQxjhQpkKi+8iKG9ByYkcLWoGawfFWogJmJp9VU0rEkQRrp+Mx/mdt
         9/WayTdLb9GtrOGmtu/CnurUQh50MKQG0PnD7fGilQJVb1tbZ4UKa8omnRJzbYl9iiSm
         tyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091208; x=1752696008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8SYbkq24HYI/QL2FTeNupi8GxAZULeQ0HmG/pWS2Zk=;
        b=MsDjEc4ncpz5vtSshSeOjn9QLB3w18o0sK9cPqAkky6wcBuNac/qSJZ92Ouvwjt9Tx
         y2d9cneRy9h3J5BJJiOm4AUd9SP3I/qcjJ0xq3g6raqkG4YOVjok5CgqdXdhgN7zoj8g
         KXcIUBgZDWdnUSCfI6+iph8ZhK3aHI1LPBTh1r0yEwUxeAZNfKI7J2ZwC/BmHZDmCy65
         J/D434nI5N1QsjBo4Q3cRUxfX/qcHmEe4n1mkcQHXrSnnyITP7XN+9cVJtuhZ3Enhqrw
         VpFsht3yuKnwwFbst4T40U1+AWGj++7scEOPShjD8E7IvtzpCDJcqAXvhqvt/qbs0tOp
         mqSw==
X-Forwarded-Encrypted: i=1; AJvYcCV0sm9XebzrYFCbV3CZJ3BMsrRh5TIT7AQ/wvZ97j3ibHcXdhclwktnehgx9ph1Lvf+C24fhX1Tc0V/Ig/NjpM=@vger.kernel.org, AJvYcCVFNQOaqiGWTyDIFX4UEMiKQHRKOtFvvLjAi6khp/+7LOKivXl5SeZdz2vo1t/lkEtkD+E67PeNIDPFuQ==@vger.kernel.org, AJvYcCWWAesb4UrwYK3dBqpO5M5M8eF5OclmLL+a5jJJn6i+k7fRxS7n9wMPiyaZLRBHXZ3LJxS/EdDyOixJ+HuNBW/m@vger.kernel.org, AJvYcCXHid1YNQvphJ/F569FdfgQ7EUamsnBRcE8RQ1pKPdF2+8O6k7TdCyG98A21IaGmkzBDMxviOh0EigmNUrE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkax7UBlv7ikKD101HXftjooGkqZ5nobTKxf9DHj+EdId5aNUn
	o7eIGpCqbCehbWfesuNtwTxwaJCUEADO93DHEA/Eu5D9TwtI/Ub0RUHK
X-Gm-Gg: ASbGncu5Kk07ESYc/7cDv358JfpFE7wFAeUbmEJu2arWwmSzbZbg5ihLQCIPlWqhSlQ
	F4mZICeq0Dqbvggf9QJ1HeCC2uZ9xqcR39bElEojS8cDRnv37s9zgOkh8/QCHGl+8WEQZOttas9
	y/5ZQnzIyTfXX+y/Wne1rwKfHEHt40VO6MTlpX3V70aDjxldfWNnMjdgBkSIxfdhaz7ZUjkz2uv
	Kc6YA0ih055SCMP+PJxVzJF2QMGgb+r+2f5JD/sy5BEsdXfqI9UrGy9lVna+/FMAlE2skloCtAB
	V5ohx0otnfFHHNJsDoxSKoKDlh4MoITuKUhCij68L+pnC2rgg+V+huJkXScV7xoE6YWRvqgQvZN
	GJh4fIn8Bkf9eCCpVmXJJEM4tZp3osc5BnaXXuVbZRwyZYWxgdLQxi9WsQg==
X-Google-Smtp-Source: AGHT+IGI+gwm5eTKWmm2g8ouSxtbF/xVdr+iB9m75yl89bzxojUSPP7D5dFXau22sPklx8oqNt6QXQ==
X-Received: by 2002:ac8:578c:0:b0:4a9:c2e1:8844 with SMTP id d75a77b69052e-4a9dec1f0bfmr46868371cf.10.1752091208084;
        Wed, 09 Jul 2025 13:00:08 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:00 -0400
Subject: [PATCH 1/9] gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-1-64308e7203fc@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091203; l=2067;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pCigoXsp4LXT/GFOU7Jz2F9f5TrzOun3SN3jz9HmrL4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK0DbMWw/E+Jo/SQJTsgBaDiYcF6u/cfsfhszo37V9mpjmfvwJr1oAexhnOQHh9LyACg7euGN+w
 Ilt9fZxU3zgs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/gpu/nova-core/gpu.rs         | 3 +--
 drivers/gpu/nova-core/regs/macros.rs | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 60b86f370284..f1d72da7fddd 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{device, devres::Devres, error::code::*, pci, prelude::*};
+use kernel::{device, devres::Devres, error::code::*, fmt, pci, prelude::*};
 
 use crate::driver::Bar0;
 use crate::firmware::{Firmware, FIRMWARE_VERSION};
 use crate::regs;
 use crate::util;
-use core::fmt;
 
 macro_rules! define_chipset {
     ({ $($variant:ident = $value:expr),* $(,)* }) =>
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
index 6851af8b5885..759773a19480 100644
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ b/drivers/gpu/nova-core/regs/macros.rs
@@ -106,10 +106,10 @@ macro_rules! register {
 
         // TODO: display the raw hex value, then the value of all the fields. This requires
         // matching the fields, which will complexify the syntax considerably...
-        impl ::core::fmt::Debug for $name {
-            fn fmt(&self, f: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
+        impl ::kernel::fmt::Debug for $name {
+            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
                 f.debug_tuple(stringify!($name))
-                    .field(&format_args!("0x{0:x}", &self.0))
+                    .field(&::kernel::prelude::fmt!("0x{0:x}", &self.0))
                     .finish()
             }
         }

-- 
2.50.0



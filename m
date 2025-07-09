Return-Path: <linux-kselftest+bounces-36871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE7DAFF27B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7695C016B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177F52E9ECD;
	Wed,  9 Jul 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elgQqzKk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7505D2E9EC2;
	Wed,  9 Jul 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091220; cv=none; b=aJlT5dWWi0YRdLmXCWaX077OUWpcVF4rItTgvsdXAmRouXELQVjiVfYz6feTOy32gPdUn3FGxXE1/s3K4u5Bpgj/fr4aUrPpFoxsLYVPCoi9hTy9wd4onZ6OiLSgEZMlyuv/6QPEEhKydCPbwJwPhehzHWki4AAg6Oyw6X2+iTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091220; c=relaxed/simple;
	bh=ulVPEZq9Jbltpj5m+ZKcCOATlnirfkaWcJbMC12CGGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+r6ki7Kt8vrqsB/QJfnqJcR+xAq7XpofCIH/PrcYikMzxYyOBJ3XtOA8GlGhLglN1WqoHvKMeLeWhd5J3LsFCMT1iYz5XK3pa4UAwvUbSdnGRh6IBk6UBZNqryjtm3kEI0EhFN4Azjyyq4BXWGqucRHea0syxH7FUpLmVgfQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elgQqzKk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4a58f79d6e9so3807411cf.2;
        Wed, 09 Jul 2025 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091217; x=1752696017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtAb0bRzj6kkU1aoRo4HWiBiB02s3rvT49BZnRuUOhI=;
        b=elgQqzKk5B+LSBYTSWrO7ei7pJzpgOOa0/LppSirg37MSh45M3pzJMdU9DrPehFXA8
         +2N5BRiCtryhk3d0E4+zvN8tNe2uBvhVxh3l3tnryXufJjzf5+iHcArQvu7Ul2lZFbAr
         PYs5NQ5cgavN4jACB22NBbT4xSYVGYuNnZGON9HxmXOZbtLoRbe6cIBCotlloDee2/9T
         r9BFO27amqT96XPIDcl67tWaRGsffgfyW+3Es03vXKm9UZL4TMnTtOru6/Iig3UGMmHO
         QwtSwhAbLq95jQHEu7r6yRglFAI3rywqocCVR6qCh2DqP4j7VVUi6a5XpqJeTjuviX4z
         skCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091217; x=1752696017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtAb0bRzj6kkU1aoRo4HWiBiB02s3rvT49BZnRuUOhI=;
        b=Gy+cdmNe22/oXFpDozHKIozmtwkM95o1AapoqV8ybbITQd3y3pya0cCU/+r1qxIYds
         2aibB7jJb1CZyP3VZM1cRqCinrMvY23aO7BWJtZRPLl1hxUUgOvynsFcSY2CKTpQoyRD
         MrIZrAiR9CBEH2bC8Rw2o/wkmjDq9uGLozwWLLL48MtTXsdJ/Vk7vDdu7WD5sGc4vn7A
         efeRuvVIagBZ4ekl2hknIH5uXqNHk+RinEQWUmuhPbQubJObG2NkgOwBQsX9lAIbUMPg
         FCqZZQuGzzBlJ3V/6qu3X/tYxT+tELvRhp5SB3zCQwOSD7kM8K/Xv4PsbYHZYR1U7Gjw
         YwEw==
X-Forwarded-Encrypted: i=1; AJvYcCVCtNFk1Yv8iXTvOHbJ3akoZ3Cxv8Ik1o3yN9CEcICGmtKrK/eoYUgjBYupz00R2VoD9zkQpfsuIrDMzaqeofU=@vger.kernel.org, AJvYcCVExLvQL3jcdcZhWS4hx9Ttw/QZ/jDA15UhgmrlKTuP75ElQh0uZTfGBhhjDqKHYDxECotHmNijuWiO6tqH@vger.kernel.org, AJvYcCXHjnAb5pBoJmzCMDFCcmZ6XIX0/6Z0KQDyTJMbaJhfIXTSEEtUzRvEoHLbrLFQEvxIQj1USOAqOmuHbBlJhFkV@vger.kernel.org, AJvYcCXSO/jC8b3TPx0+Zu3C9f8MTXxDGe4tfTCO+np3DkdW2X1wuCjEftmYfC5YkUy7PvsuszhtCGwbbUiaYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yysp9p1cjNWg7raPgmZtMLPvCBZVYYQl/4X3fgf2RisjNAs1QUh
	S/3FUzd/lqQ83DPcMh1RHQ7h4S7vqYMowRqI7ojd3nWeYAKBOQozeNU4
X-Gm-Gg: ASbGncukrf1ebRLHufBllr/GQG1OYvtxF/hADwQWyayHo/1jnSBNFjJrxp7pxeIwS9X
	7Wiv3X4x5Qjtf5qIKNAF/WNOK0Oi2OyYCtBgjV90NPVWTJRz+ryEpp4IlvbAUUFqTEZe6wBNfP+
	1XpmLJlO25GzVg2bhLwkqtJJJAB4u9q/xN/twBFWymosZlBm/V6iOX9+858KQlKLaXlgxYBSD9H
	gtAp0dVwm3lb0Ghy5eNwPvD7W+xza3e0idG+fglIUBcmhPPIXD8b05jMJevDGGo5XC5ldUWU014
	RR3dXJKbCDTUikcOyguDz/5dnFchNVAdkevt0HZgniYu7/aPHCQtTKJygbVK0a0Z/nUDcP/pKaj
	55hhu9o4EnEkIRdr3qCbuUz6GtOxPeOkvGn4BeAWE4NkEhE0ZmNFyIASPnY48H1CLScdo
X-Google-Smtp-Source: AGHT+IHINhIqlUa7DCpDjHN+II+KrfU91sr0X+Nh9ajVLFRJzCxP8B8BUPyzTg89wGo0r7WtCvZq4Q==
X-Received: by 2002:ac8:5ed3:0:b0:4a6:c5ee:6ced with SMTP id d75a77b69052e-4a9dfe6c7eamr50950701cf.4.1752091216860;
        Wed, 09 Jul 2025 13:00:16 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:11 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:03 -0400
Subject: [PATCH 4/9] rust: device: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-4-64308e7203fc@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=1197;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=ulVPEZq9Jbltpj5m+ZKcCOATlnirfkaWcJbMC12CGGQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKa+9W1qEMCIC5nwDM5pzqB0yrk8C6OiT/Eck8hVU2yYFOH0UcdQB5HSqXCLqIEzznx1uAPJMxt
 Yys2X7knfKQU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/device.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5c946af3a4d5..9e9ecdb1beec 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -5,11 +5,11 @@
 //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
 
 use crate::{
-    bindings,
+    bindings, fmt,
     str::CStr,
     types::{ARef, Opaque},
 };
-use core::{fmt, marker::PhantomData, ptr};
+use core::{marker::PhantomData, ptr};
 
 #[cfg(CONFIG_PRINTK)]
 use crate::c_str;
@@ -345,7 +345,7 @@ macro_rules! impl_device_context_into_aref {
 macro_rules! dev_printk {
     ($method:ident, $dev:expr, $($f:tt)*) => {
         {
-            ($dev).$method(::core::format_args!($($f)*));
+            ($dev).$method($crate::prelude::fmt!($($f)*));
         }
     }
 }

-- 
2.50.0



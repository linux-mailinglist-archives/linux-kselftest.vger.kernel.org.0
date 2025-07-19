Return-Path: <linux-kselftest+bounces-37658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096ADB0B264
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B923BEDD0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA828A1C0;
	Sat, 19 Jul 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx8vUb0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC6289838;
	Sat, 19 Jul 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964938; cv=none; b=MnSRF+8REkpqiZp5h/ullpj0/KYM2riPByfDoM4RQUT6d8DJFUCGvy92Prmh9IuOtR4RUq8PRtxbmAZZn2Bo3or1VKHtrj2lQ5huKJqI6Ft94DLUrS/KIGxrbD/4B1G+nvuNqmhiUpq7NPuv7e7urvgQEpQBN5F4sI4G8VTZEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964938; c=relaxed/simple;
	bh=pXR+pneQEkVan1ORZtdC4QLLw1pF+V8ExOh8drAAHsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkFbBtRcQsmemAQUtGKW9GaU2zV7BJI5lc0qYqECVcCSera4qxe3DN+fj7YyIdcnTpOtxqOdHKub9Q5Q4JZvY+sEWIwN9Bcc++/vV77sHIzw0rpx1ZxrKmyklQtCIHypJyAwYPaj5YBuNaCO4Ci/+4SksFCGSjUAYmrRf0VeUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx8vUb0O; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7df981428abso516425885a.1;
        Sat, 19 Jul 2025 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964936; x=1753569736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMiFmax83DBHXL/VqrofbEg17y34QjNQwBZrlkLA1Pc=;
        b=Hx8vUb0OYyMNOqy1dbmXDGxbec/RnuYnJzcp8tkoTvn1FlJAXyJ7IVHWJbfbI4NAZQ
         ZVCOL2Wuehrd4TXu86GFPLluvG8O9u+sTvyPlHu8/D8ZS/Y2UuvoIprjCV6lr+EqoI7w
         AeavHqKXwB12Uwc3UXdXrvWLSbENPqePXcbdmXfWV1Gab5CTXQEGKMDMS/QfiAoBXb02
         mQTK0c2sHGY66JwfS31xjXC27Nyqjy8wdc2/H4YSyj61NxmovFIgdTJP2VcOWYR5IHH4
         4YLHoawbdw9DalO/outZU7eZ0mTRy++R5oikplWlbjDM3gqwSkuFgUhtEBBNmJaDRUhK
         7EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964936; x=1753569736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMiFmax83DBHXL/VqrofbEg17y34QjNQwBZrlkLA1Pc=;
        b=lDHoVl8Os/rhdvCVPrGQh8FtFxXYtL1amf/g8KfCdLSlA8wCzcSkATCD/k+pFvyHfu
         IiCI8TY6cY1NqwS09h12xihghHeu2PfGwc4QApLtI5owhWnOfjYsHr2L5CVIgyw2l5ja
         Ios7Ee7YuG7HXWuhGMJf0prcRaN3vXa4LtVufw5mJ1oQ7cG61hjhB1RXCIjGySW+484g
         rwuP6prgkxTTD2Tc9B2sq6VyPAmr20Osu+ViUlfTdOGSAkNpZlOBVfAPserLqPsidVap
         6sJ5+eDHKbGyfVrG4bzSRkexc80Ywe8tg8H8xHJHN0cjeJrp8546Xm+WEXmBh97sUOox
         c/RA==
X-Forwarded-Encrypted: i=1; AJvYcCUZOcOy98OtY6AeThZrV82RYpT4jG11B68o4N9dbIfxnrqW9mI7Fu5bm1VfzT58gOY33LwaSSIlHnZFOFctRhw=@vger.kernel.org, AJvYcCVB5bOFkd6TNVWz5/A7x9zLMLdGH+tig9pibpDtXLxDQOg8BLAo78NG5G2/xWaVgqw3DcQodCBSECwWdYng@vger.kernel.org, AJvYcCWRg18kwFKGErjpjlZx7mbEnbABlDh9rULR7bEidvIGemQASfZvOvciH0GHpBqGuOUPEOxWck7Crona7Ygiv0Uj@vger.kernel.org, AJvYcCXN7agd8tQHOmGCRymdvzEF1fXQ1dBA2awueOUBqhFUtlMnyVproGinaE5xA2QfUbMi8jaBOMLN4i2Bmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03BPHrXdmnULW7bQerqrGVSVbfGUluxaeUj8bmTLJZ+2Qd/Di
	Oqi2IrTjg25XIO8ZPf0zDXYrhcuKcikK/7Z6JIE7IIl9rnrueFkmz6q9
X-Gm-Gg: ASbGncsa0FcoYAOZd+ncBEUzK2PHZTYnyaOj5Cd5B3N5hEH4OKzqbdYvRR9bcTlACrd
	sO2m18VaV2HnCVn3vyJVZ6+tTa6ju2y91Br6/qoQvhEEEsgp4oESNEN7hUzRjZeLmtEyczRG757
	mGc5VfgrdPbQDAW4XF2CLrfH9EP2i85fVy4tC9VIwEbqdoZwJyiZUSiwWBeumJU1xHXiBkH84Hi
	+pfPK8lAGZT9Eg8vxx2j7TEczHeO13fRl62UjUDDB3aP8/LQOcwqlzqH950Ku8aD6WqP5VY+E1W
	ECVDftppQbQimMaGAS71T/kTblvbq53iwTllyh1LuB9Do1VbIh8Jwx0BQYs7fyV+s8CBYQ3JkMW
	HHxPEmnu+tBPitzI+y3i4CHq2j0KgsTTtzGPJHlAiKLh/H5Sid3oJF0xlovyc/pGYScSI0PeaGv
	jRwkOsdSOj58ifweXL3Cq32J1J6z88
X-Google-Smtp-Source: AGHT+IGVo1i2TaQIfqAE4SlKOOW0XT2MULeIOXkGaUKBOzQ48pQ7CM6UfPlu3A7MsQxB2vk/ikPF8g==
X-Received: by 2002:a05:620a:4095:b0:7e3:3da8:1d06 with SMTP id af79cd13be357-7e356b282efmr1102367685a.54.1752964936028;
        Sat, 19 Jul 2025 15:42:16 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:15 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:41:54 -0400
Subject: [PATCH v2 5/8] rust: file: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-5-1ab5ba189c6e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964924; l=1180;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=pXR+pneQEkVan1ORZtdC4QLLw1pF+V8ExOh8drAAHsM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDn9tcAkIdM1tWcaE/g1fRFUadSDfcLW0qfYjUzPTHiL3CXZbnVUx7cxTfPOCZum2i3seyeZdwF
 2Wk7ChT8O9A8=
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
 rust/kernel/fs/file.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 35fd5db35c46..67a3654f0fd3 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -11,6 +11,7 @@
     bindings,
     cred::Credential,
     error::{code::*, Error, Result},
+    fmt,
     types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
 };
 use core::ptr;
@@ -460,8 +461,8 @@ fn from(_: BadFdError) -> Error {
     }
 }
 
-impl core::fmt::Debug for BadFdError {
-    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+impl fmt::Debug for BadFdError {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         f.pad("EBADF")
     }
 }

-- 
2.50.1



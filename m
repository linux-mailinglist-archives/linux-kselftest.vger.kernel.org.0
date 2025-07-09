Return-Path: <linux-kselftest+bounces-36873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09472AFF284
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68063BDB80
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63602EA462;
	Wed,  9 Jul 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ0oa/WA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A32580DE;
	Wed,  9 Jul 2025 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091223; cv=none; b=t6g7pFgO64xFdwDL9DgA3W7nn1zWsuist3ArRkAxZAWKIC+zWOTZYA7YlqRLawgO/PTEVJBIU2bf0jwu+algGZyRbnHI16uF8CdT5dSTFF+K+3xfzmJdX9yrR9ctLhT7zogPOChRcrAjI4ci4GSV96YFY3ydV+gO/WO6XSQOoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091223; c=relaxed/simple;
	bh=5dTiOejZJe8RnjUwx1Mx5Diy0vJJ7o1JB54aVyaQ3/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZauiR3NsmkgJCh0MmRhlTZRY7P9C+gLKjZsXWiEditYwOo2RMaacC8Ia10xPffviYZJDdtQ5zn1h81ZeW7AGgOKmQDhu0DLn420V3++gJAkC1i8TuqmHf6xfcRnj50JxvOxJWONkZps3tWrzI7Q1xgdMSK0PJSAHseExzI3SYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ0oa/WA; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a9bff7fc6dso3049601cf.1;
        Wed, 09 Jul 2025 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091219; x=1752696019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYbYV/jbSYlUlYZK529EkBoBy94/ve5uHCT0jgrrsEc=;
        b=hQ0oa/WAp8JTLnxTw6P7CjcMNKvAlTQoyXPTgiJwigmwNky1CxfxNMB6bHxbN1MlPx
         uuP5Q/bPC90Oc/TSVADaZCw/qNZrzXM08537JZoLTa4f/uoCGZ5RBwSlfcY2pGROZqcx
         izp6d3e1H46jixbEhp6BNiPU1oEORYebsJB7O+/0+WLQ2KAoElgsr+E9yEkAfyRjX886
         DoeNsnWBqT3uxANDXvwn7wTk10EmqfVC1LcXh3jhH4x6AGqyEqqNiWQdYZ/+4KpPsXoE
         MJITsKTlDblW4wBCN5/cIgd1UaeiEhYBQv2mbOgC7n1A1gKUb29ES+Ew71ldg+6S7Mzx
         vhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091219; x=1752696019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYbYV/jbSYlUlYZK529EkBoBy94/ve5uHCT0jgrrsEc=;
        b=fg/vxGS3khdYcHEN2YF/SwOn8WX2l8D8qLbwictk4H4R3TWI/aKaqjcIm728PFJNTL
         UrkE/5ODKlWPkNtb9T58QIKQNd7/kFQXTfnfpDSDcdtJwbkG54QuZXOlpi9mIXNiIv0z
         T8naKV94xGfDZMcKOfmCt9za2SemA3U6TLfZjKoLD/3O6HHaby6CAQHftfx5Kd1NLLFo
         zFmHwGX6ub2yXaWfHgm6lYb5LpaeMvgQkzpPBj1klphYPU8dpSfAwxJ71UOi2gPr7vox
         nQbLTN9pfGPlFdImFU1Gr+QzHU63lU+Hf5egFtvR49TongzHdl5cLeRs6q+2h0yzRj4A
         XBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTQwxnrbmsgVjTrx9nMLxUwofHuh4IyoaqDP2z/i5DeX/WZhoM7u+/rgILG4GF++pv5bnp+4XNW/pa0A==@vger.kernel.org, AJvYcCUeAgUVdP4p0d8OxS2rPeZGCZevoWdqK8+7w6EzRAKNlXTEeDgK6lFrOvyB+4gLDLTpugQwmvVYqUhY0YE7@vger.kernel.org, AJvYcCV1lWor6Z0NpMzK3iBr9CkJadwHTGQBuWkBsf6FD4eJGKJR1K4l8E0s0gveyIP9M747XUTtm0Mx9KkhtU1xETnE@vger.kernel.org, AJvYcCWEubugKoYNh/qpFM9lfheYAI1tsNUNSFQ8q+UtnoxCaHqTCUD84mgNiwsmeXD+fLNV2v2H24Di8s7XZC1DneI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOOfJuqqXj1u3HRcpH0zlVNw3P7VXOvxYXNpZeoU9+NHAzP/1
	8mHSHrCPbbANRIsgDl8dzdoPItKaKhCUZBpm+y+ihNVMRcNSjILE8arU
X-Gm-Gg: ASbGncvpZNP/oW7ScFRWY6op+5PeoNWl0qlRe1qtavs33L7atmiZsZdazOGV7M02lVD
	3mCyjNp/eYRhhmaY247sQxtldz+IJ1YXwtXZkbV/xKVIFGa6a4XQ7YOnw03ocFq+e0zjwiC/XXo
	x/9Q4qCP4L4sHCGfKvxjMSAJ2l2e1Qc4DyY9T5qRRG9VFEVkmARmQaxKEQhaA+jqNhR2UBwtvA+
	Zz34M9c2NH/UMVLfE694kkHdfqCKpFqAt4GY/OrQl28KDE+xRcAE3ODk9LVqg4ZxaWi2xHwrQTK
	7EzdCcYhq5eJXYyXRfR9fnShU7ktvF+FnRVOiMSnaa8VIdyy4k5lzP9u5SXHPotHzYAyX/Q1xWt
	OL20H/FjWQX100W4uzLVSYK5w4dWQ+ya3VxiKZZqudOceZOODJ8I1kq2waQ==
X-Google-Smtp-Source: AGHT+IEWZGAjchfamIdPYEH1FsR0qpTsGWn1OKlq64cGF3DAghxLjgjw20fv5qWhtdp+gL7T1gCPWg==
X-Received: by 2002:a05:622a:1b0a:b0:494:731c:8746 with SMTP id d75a77b69052e-4a9e9d39db3mr12683541cf.23.1752091218452;
        Wed, 09 Jul 2025 13:00:18 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 16:00:04 -0400
Subject: [PATCH 5/9] rust: file: use `kernel::{fmt,prelude::fmt!}`
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-5-64308e7203fc@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091204; l=1087;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5dTiOejZJe8RnjUwx1Mx5Diy0vJJ7o1JB54aVyaQ3/I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNJZvlrOcKPbSKef6UpG5KCpY0ZVZYeAhWghFLoYOxqZ6pyW3Fg24FvRlC8yX2hCr7ezE9aSuv5
 EjP1ebs7IRQY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
2.50.0



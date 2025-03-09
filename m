Return-Path: <linux-kselftest+bounces-28569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851FEA585A5
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 17:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79C6188D19D
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE971F099C;
	Sun,  9 Mar 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlNPHDuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DF41DF259;
	Sun,  9 Mar 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536079; cv=none; b=fWc8ZfULjNJmS52QPwchyxFUDaDMtbv3+CSTMapvBbbwp+H9vCO9jvdAxRDJSKPKwje68pey4n6a8a8+l7734CIUBORi/jO5FZujhwYFU3lB7qQTKXmzWa8xvQMKQa+lFsRsU5CXjqChHTrF/rCpmGEHi3CYG2LBFCd2Ju3yPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536079; c=relaxed/simple;
	bh=oNRbNb4r/1V2VqyfgzcuLuSel9lESwEeMabx/50bX9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OnwzLqD1tpSZqXsQUTYSH1zprhWUe7swXvOxj97IPMg6glz1zQby4NbrJDLM5h5vn2Qy3A+fR7wsZYLgwKg8I4YbWSiBQ4wrJpm3jdNAhDzP+PL2dg7rHvMoa3GoHpX7wb3M0NUW890WEh8vCLBQixg1hbuTB1SMy/qMwW/bTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlNPHDuU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8f28172dso222790585a.3;
        Sun, 09 Mar 2025 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741536074; x=1742140874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAWd0B4we2Lx/jsJEWSFzRia6Y42P0AOIVa7mxyDLPQ=;
        b=QlNPHDuUPEE6QOWWb2goxnvYrarp+oxT201cXwLrxY2cGTBSJ2H5ZOtYs3SzzHhEvC
         r2C9ATkxtweXfujm+wrUefLGLtF8g7nyXgwJMRPW9Aajub+PxCK/QBQYYO0u2/uYonmu
         2NiZg+EvL9aDT4ZxUVjBlyJy/rZe+60LhiqEPSolZ5f5w/a0Fm2/zPXqW9K14YdCupoQ
         w2pjcjFNmooCQBS46ittxb/PbZctuSJUq+2gxSjSsu3MUN2wFsf5bzj04H4R/rAo3JD4
         dqt8mBJtfMYe3oq2zdsVMFd2qCp/kEYmBlUWgsM2iuMmpAsCzU7op+HAZ/qvW82aaW73
         c6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741536074; x=1742140874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAWd0B4we2Lx/jsJEWSFzRia6Y42P0AOIVa7mxyDLPQ=;
        b=f5V2/biVsbclaxZY/CNRIU09wyCdDxCBkWwuL/4SRxB4GAJmI9yCJOohSQd1pEquGA
         xSgWNxaD+X3GtFK3Rk1wG+tkxIZAVB7gl66jQk2T1EM7ahR10uzTPU33IjLcUZjNXgZM
         YaSbKdLZcqJTClkhRyfFvYKK5nt3W+MXhvl5HUwX9yhlUD01UTDGe6wKn4R12sqxzwW+
         walEqmPAvocItFpBjfVVGLpQ+3l5z4Lih6RlJQtEyDmcWqqPWMJhFEo0ONXjPO2nFDD+
         vMEeKDV2lMrwXhPnhHSRRHNRaQfsbprIE7L9rmdbtKlDwSsGJKqb0LupVxBFRRkQGb8e
         TZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCUv5fDwza6lyKB+v9T02kmWizaC4RguP5Htg1BIIeJKjyFiqPmT+rvGYT8O3pY5T7IFNB/yk/56hGaDC7M=@vger.kernel.org, AJvYcCV42xnTMTn/YZP9lG19YDoVVBwXVvfZwTNThyScx1iTmHJBKwigdH0Gb6dxxf6RYVLp9E4DZlxfUPXs@vger.kernel.org, AJvYcCWE6PFmU6g41f3lybPYjYrh7CNYtOMW+IzGlK+6bsEFEEm2fCzwI2cD996mUpOb73MGqJLfWNlOzKxPsxRxeSdv@vger.kernel.org, AJvYcCWfuigSycblgw7q0Yt06aMwBrAsorjpStZkf/UC5/eC3NYymGZPEOZIl1vEttfz64UizASZmqgCO30G17hQa0Q=@vger.kernel.org, AJvYcCXm21I5i1NyaZPIAZvdR7AW2yT2su0RMuUJYgBLjRoBec9W78x4KkBai32lV5yVgJZzHVyEau2h0puJS0Y7@vger.kernel.org, AJvYcCXyXLrgNEwmuTzB+AdYgtLqPcWJtYK2akMOa7Af4nHtuMObkNkk8PNZNAceK4jzVuozXHcvjIvZ8E6N@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS1B73ErMVY+4UKEsjJlGoHwycr36H9dWtvC9cTF8RWv+N2lQ
	zU6uKgKPv6vrysx4Yl844uM4dg7zel23IJqxBY7eGLCes2Hergb3
X-Gm-Gg: ASbGncsndRLAOAoFIoBAJ+2JbClKeU2yWkWf+nqAnj2RrQPrZevGHowW8KSzjSYH1G0
	VzIo8NRJwQZvTHBWS3aNG0dljGqJYjgwX7s9qeshEl06maAN27A9/yYL51+uFd2Euc2LeLmXn1W
	xs1K2ZVX43X+Wj7dIf8k8zl3TmRCVKHZGb0V9cBZVfrbZWbFw/aUeSqB7txnURMJmDBmN6Gm+AZ
	xbrcOHuW7ygR/jyZYj/GG4CFwioX3k+u1/+j2jI/lvthUZ9DozbTxI3+lyiPL1r3+0pK13t60XQ
	yPBjaaJLZxjLLLbXaMpAn4dffSY+xQmuJ6uC391zK3p5ieKd/maIO0MjCWOX5amucSo=
X-Google-Smtp-Source: AGHT+IGi9XWEOmbXwJHyecHe6thZh1KgqXu7hMzrKof4MiursoZ/E4M5j6+CcIFUc+LvzdjhS0N5YA==
X-Received: by 2002:a05:620a:640d:b0:7c5:4be5:b0b1 with SMTP id af79cd13be357-7c54be5b2a0mr325321685a.35.1741536074608;
        Sun, 09 Mar 2025 09:01:14 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534d38dsm512531485a.44.2025.03.09.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:01:13 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 09 Mar 2025 12:00:43 -0400
Subject: [PATCH v2 4/5] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250309-ptr-as-ptr-v2-4-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
In-Reply-To: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
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

In Rust 1.66.0, Clippy introduced the `as_ptr_cast_mut` lint [1]:

> Since `as_ptr` takes a `&self`, the pointer won’t have write
> permissions unless interior mutability is used, making it unlikely
> that having it as a mutable pointer is correct.

There is only one affected callsite, and the change amounts to replacing
`as _` with `.cast_mut().cast()`. This doesn't change the semantics, but
is more descriptive of what's going on.

Apply this change and enable the lint -- no functional change intended.

Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_ptr_cast_mut [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile              | 1 +
 rust/kernel/devres.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c62bae2b107b..bb15b86182a3 100644
--- a/Makefile
+++ b/Makefile
@@ -477,6 +477,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3a9d998ec371..598001157293 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -143,7 +143,7 @@ fn remove_action(this: &Arc<Self>) {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
-                this.as_ptr() as _,
+                this.as_ptr().cast_mut().cast(),
             )
         };
 

-- 
2.48.1



Return-Path: <linux-kselftest+bounces-33857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7CAC504F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E8517BE54
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FE827602C;
	Tue, 27 May 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCUiOMhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337B134CB;
	Tue, 27 May 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354183; cv=none; b=KW+MSicXPJKVHn4QZL/GCx4F63nJywRU13sS1Hc8Yc1VvpStV9CyQf26Ju0Uv4pbAH9C/RCH9Zr42UZIGoutgQDDv4XrvjMHnzjuIoNjCvPyBtKgvYN7QCLnmS0Z1T4NgjS1icDI6y85kkEYasJT6bOm6lQ46Hz4AZ69gT2edWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354183; c=relaxed/simple;
	bh=wMlcAUTr2JWpW/Jw3FrSvD4HubPhNV5PvBq4p8YRk00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReEu3iL0NL76zjnGqMDGnsFm3KU1VifpxBNHIGqAbk3xXt+t+UFxGSlGm+LONiJ9CfedBzdHmA7qiTtd8DLupS0B7kWrRWt8BAsW4yHQoXJaGluBpJAq95ol3HqgAFR5C2iJpFlZUhL85aegFTA6dNrDcmNT+gtuo6owdbf8wFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCUiOMhd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2346765d5b0so19345465ad.2;
        Tue, 27 May 2025 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748354177; x=1748958977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnktFiXJXJodN0pB61aJG59CK1E9b68p2VWpKi9y8vw=;
        b=CCUiOMhddQUodpu/cXeo/oyESSX+rawGMqih2vlfV9uFyENsCdq0hQS28+nm1VLoYY
         /z5WKuzaU+KQWjt8i1ULG5ZXtt3ao42iz8/p6K9rqCv9WFkWfYHRaZpTzlxldxJgqgp9
         GbsB+d2x5w/GV1aqgTc22c8Mk6QIPv6GmMn+glQMYtFSyLfgeb6MPWereggmtK95cNvO
         a03+HMvKiHB3w/ltOUKH4fLX4BxvbeJTvogsBqlCXR9oCbeGNPB7U6YRQiQp0ivepV8X
         1LSKFQ7vjtVZccWcBMkW9gOeSSu8X/DIef67ybN8U8B+VeivBHwvA6o+bHjdGexkKwC/
         Rzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748354177; x=1748958977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnktFiXJXJodN0pB61aJG59CK1E9b68p2VWpKi9y8vw=;
        b=tUdanh0ViSWPONtK6KSZ0ij3U8wx7TW0ZRXgLWRXvhvDhDdbuRnH7eGqSo2z8bMDGD
         tsmmaHd9IzzFF1Nuf9uOcoV8dcKmGkhV++4P2fRqw1/qMDSx1QJv1/pNEUX6Fabo61fw
         atAypINBzG1uGwXCk7wFExiZuN2ttAi8XvO1/g3Ou8tcUZasvUV2kyKFMtVZvaXuiXBQ
         oFiqIsFRWIjlQqmvCMuNhlBTutDxqW1Qr9b7fUB48ynuV0jvd6QJ/hdDTmlTYhDCUsa2
         QpxKfCKaXIMICaUYwvF1VCDZ2asKl8x9pqQZKTolAWz5AISj6nRW/T5wtvV0KzGIUkDo
         wyNA==
X-Forwarded-Encrypted: i=1; AJvYcCWAlOTXZRThKu5jjMyYpdCnC3x8XFSz1HwmEdjr3U7rjx2PSd9V0mTapNoHFiHIwHpK2/vnwzoag+lkKoE=@vger.kernel.org, AJvYcCWeEG4wkXa0Ah9DgjqjhhL6q+fKO8888B9cCQp4RpOn6NJb7IxeXpDmjkbG4qEzWXOsVv+GPGwwSLnadYfq7vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuDaV30UuZgBccmG6+lePjxOD2HKWXnmyM6+gI9QeMNpNo3UW
	jhHHS5fiIbMyI+7Kx9KSo1QbsawOKbx7WCYnwmq2QC3J/p6kbg8Ga/cp
X-Gm-Gg: ASbGnctgtUIqxVjiIfoL/TRbWjQgjznJAL8APQzU7zNUTXgTgDwC1OXsSQTBlspbylg
	yv7DnmDNQwVBVNILmvIParjuHXvLUl0k13OglS2Y7RaBGMh9er2Q9ur7+IYOWja4lZ8uvXjPt55
	XR+V+LUy78dlqo7GlGoYHGWBx3v9rqum1diDAoWzsrSqFSOWtSLMSCVcbEX2YUPqYtQoU9fQxTB
	mLYZUtgbV0pv173vZbeB+htBaWoDy+rdiFxMO9MYp74vS2QCTIJ+lyM+ZuZwlmhyobe5aOHogNI
	isjTz9Pj/oLcwKueUcqQ98jexKDBQ0m6fUurj7eSP2znAQSiR55K8zLTxDcRqyI=
X-Google-Smtp-Source: AGHT+IFNNoxF29EfkZcUJGXn/ohVeLl/OG6M5rRHNblzkgPj16tTYH/KioWbWzao9437hQv8KtCczg==
X-Received: by 2002:a17:902:f54c:b0:22c:35c5:e30a with SMTP id d9443c01a7336-23414f4a6b9mr166280325ad.16.1748354176742;
        Tue, 27 May 2025 06:56:16 -0700 (PDT)
Received: from localhost.localdomain ([104.28.249.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234018ac5desm67801475ad.158.2025.05.27.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:56:16 -0700 (PDT)
From: Jesung Yang <y.j3ms.n@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesung Yang <y.j3ms.n@gmail.com>
Subject: Re: [PATCH] rust: kunit: use crate-level mapping for `c_void`
Date: Tue, 27 May 2025 13:55:49 +0000
Message-Id: <20250527135549.1982244-1-y.j3ms.n@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <DA6XI37GNRHE.1FN5893KE2OIG@kernel.org>
References: <DA6XI37GNRHE.1FN5893KE2OIG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Tue, May 27, 2025 at 9:06 PM Benno Lossin <lossin@kernel.org> wrote:
>
> We don't need to explicitly import it, as `c_void` is present in the
> prelude since 3d5bef5d47c3 ("rust: add C FFI types to the prelude").

The base commit of my patch is f4daa80d6be7 ("rust: compile libcore with
edition 2024 for 1.87+"), which unfortunately predates the addition of
`use crate::prelude::*`. As a result, removing `use kernel::ffi::c_void`
causes the build to fail with the following error:

```
error[E0412]: cannot find type `c_void` in this scope
  --> rust/kernel/kunit.rs:22:41
   |
22 |             &args as *const _ as *const c_void,
   |                                         ^^^^^^ not found in this scope
   |
help: consider importing one of these enums
   |
9  + use crate::prelude::c_void;
   |
9  + use core::ffi::c_void;
   |
9  + use ffi::c_void;
   |

error[E0412]: cannot find type `c_void` in this scope
  --> rust/kernel/kunit.rs:38:41
   |
38 |             &args as *const _ as *const c_void,
   |                                         ^^^^^^ not found in this scope
   |
help: consider importing one of these enums
   |
9  + use crate::prelude::c_void;
   |
9  + use core::ffi::c_void;
   |
9  + use ffi::c_void;
   |

error: aborting due to 2 previous errors
```

Starting from commit c4c0574ee33b ("rust: add `kunit_tests` to the
prelude"), we do have `use crate::prelude::*;`, so the explicit import
is no longer necessary in that context.

Thanks for pointing this out!

Best regards,
Jesung


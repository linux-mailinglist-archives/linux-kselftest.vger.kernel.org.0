Return-Path: <linux-kselftest+bounces-34674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04304AD51A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A0F3A8444
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808EE2686AC;
	Wed, 11 Jun 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WecFJdaz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A9266B5C;
	Wed, 11 Jun 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637425; cv=none; b=fB1UxxBAuncuTvAF8HW2lJgNuDdf4LlgV+SowiSSGfvNuQSxlLXmSOKG4MjcNsOP5SojX5oDe1eWlJNvYmBtAoEJciiMrpbODPco4WxOhfTr+jE+gyyWlv39zxN37xxJb5yoABI+cXQSXrn0Uazgk2i2yQ3JY23HsAr8w5F0wcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637425; c=relaxed/simple;
	bh=yF5Gv8tK9X1wroVzoAbelwVn5+WfGFCL8D9RidNzyJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLvg1475Zi+cjU6ZMNIvSWwVwXwsafnEFMIboZuFusFfSldC0UnNU1uTZlWz2IFrfZFuw3QUgYMvbJYk9OuD2fwyp1LM/8lvEsqR4pXKQONsOfF3A9U5ZtuNuRdGkP9rpu5pqdYkvVRfdoFu4SJK1mp9dQIVXh2jS1AZFfOTBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WecFJdaz; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44b0ed780so84900551cf.3;
        Wed, 11 Jun 2025 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637423; x=1750242223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwuzOkwr2WXLbNIqZ4PjxHxYIhjL5EaV2fkU8tqfaYg=;
        b=WecFJdazz8I5JCI5jpmhrJE/576FIGiu5LgZ1R5fU7Us/NS/FYQ5O++E66mMKmQq5u
         4c40u6H6zqNzCnTCi+q415T9SkcIYto4CKL9BbaRo+nVmOgdkA+6k1tCE/wUTp4ZMEMR
         59UwMOMtBjeVjaQqBkzvvSStK5KpbYZVCJbklaZ+JozODTT2M1VVNIGm0dsXnAOsTIrB
         j2JUOJBghYcGL+n5UUayrZ630mCKHFfVNMHaxZ4MuCHNlP+Fd7h5f99TKvTiSfJB724d
         6jpKWw1UY8tmEStGs7vrsXFCttA23+MWrHG6kJehNZ0/J1D2Q3rgrVB8DHY8ENeA4Q2p
         ZjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637423; x=1750242223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwuzOkwr2WXLbNIqZ4PjxHxYIhjL5EaV2fkU8tqfaYg=;
        b=vRFXZWrjYDql0Y81Su41t5gvuJeBSUUdSrrxrKh6C7XUgWignRj8P4aOQlKeQAp/J3
         uhxFpSLkJc9aG/xIVA6Z9bihmPuzldF2XhsZBf4nP5c1yhr3fvERu19S32Yx4bfk5xlk
         suLewZ+5+dA2PyZGAjhDfJfkmiru8DS3Poigfe3KWXCtlpG+bcYz3GjA1fC4R9K7VwHy
         XJZXFyy76WdTJ0J2E4PYsAHyjioeMPQTmGFn7fAdfaCX0wrkvRJhwpA7ogFMJYcXJSnq
         xW+z8Ec1HilqaFco4NhTE5WEW96u3xYBYnmAB7FL9Dim9wFzlgrwQjRTBHaqG5MrVq+M
         JXcA==
X-Forwarded-Encrypted: i=1; AJvYcCUTL7NhC6RwqMi8q7PJlO+iMDaLyoGS9qddBDQd1DxLD9tJHZOB0aSwvtsPufVdRxuS1zyV7Nt+AGo/Nvw=@vger.kernel.org, AJvYcCUueEdVZazwFe5uYrSnhgcI4OrOB4aBxHIQ3dwV8W7rVDKaKti+mSV/JrXyY+sHPj7mO4VBoV9jNSfH@vger.kernel.org, AJvYcCVKJJFffpyfzuwg+V3Vg8rkJLvLrxqFwhuDefb8gmtobdOLhG/YDU/ZqzzOtS2J+vPyCEelaDKf@vger.kernel.org, AJvYcCW3lj6XMTr3EimY0jbuLUMVaCPPPE5GLs6DZvkCz5dcgWHWgbvkG8IG2sPIAYZ0qtwy20K6Tm+I5oMEzykanWBu@vger.kernel.org, AJvYcCWJ0mNd1xSAIU7As//NybCXLhTRINBnmGN24f4Zjy2vFgVMIPG+XetjlfWvxOkhDnuAhRQhHk2nizqPCNp6@vger.kernel.org, AJvYcCWokf7esMH1dPSAL8IbI0Qb+gQae/0Ur2hsE7I0Wf09Mb19kmQ1UO7YtlkEGysi8Nw8rEG3xuiqV2KlUCK3Il4=@vger.kernel.org, AJvYcCXo+bSvBx4cOVwfWKOR0u0DZPGGTkZW6N1AIIHkYnD1S/JgqLVG6DS7UvbhI93S15Gh494gk18dOKf2@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZH5y7RKhyCv9evzyO2nLZY3ppnJMZamF8zUYQwaywr1OWQZK
	k1OU47DJi5g3bcf/mv1uUxfZHCZz0GwZj5xYNiO5AoqPj5V3Wt84nrQ4
X-Gm-Gg: ASbGncuY2rYATUzVEAnHfdyGLcmgSpHfPeMfPPWaDcN3owHUiE//aIlWOL17ekp+9RS
	FgsHnVj7SQw8f3FRKkKZBHPvd+nMyPIFky2JIEFkCQPvu+FMqJuyHzQIbGxu7MmNEHRtDRt1dhc
	MiI0n4Mb5/GNhkWUs39shWd3YcgoYtbB/7ifb4tzyk9OvcHbx7s0RagO7rycM565H2B211ejl5e
	Ox2bxxoJKmqOKpTUsZwepL4FWlizjIkfD68sOpM1v54sRhMNCuamCqrSIKos9FgBwQDkuOOitCO
	0pB84yn7VH4Fvyd7fgpznJ8/UBuHhQhn+DY/dCrMRmNcm4dOFhavjzfST3PNQ+rxkoifLikJMtm
	3xg==
X-Google-Smtp-Source: AGHT+IHtIidebIfTt2jkkrOO6cFXeDxcrBR6iqFW0QLdbmEyB32yNlITHUCKNzRDp0DfY2l6KJd6Hg==
X-Received: by 2002:a05:622a:1b29:b0:4a6:f774:dec5 with SMTP id d75a77b69052e-4a714bd9ceemr41400951cf.31.1749637422582;
        Wed, 11 Jun 2025 03:23:42 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61114ff18sm85664341cf.6.2025.06.11.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:23:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:23:27 -0400
Subject: [PATCH v11 3/6] rust: enable `clippy::as_ptr_cast_mut` lint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250611-ptr-as-ptr-v11-3-ce5b41c6e9c6@gmail.com>
References: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
In-Reply-To: <20250611-ptr-as-ptr-v11-0-ce5b41c6e9c6@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Benno Lossin <lossin@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
 Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Makefile              | 1 +
 rust/kernel/devres.rs | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5eeddfbf5900..bb33023f87c3 100644
--- a/Makefile
+++ b/Makefile
@@ -479,6 +479,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wrust_2018_idioms \
 			    -Wunreachable_pub \
 			    -Wclippy::all \
+			    -Wclippy::as_ptr_cast_mut \
 			    -Wclippy::ignored_unit_patterns \
 			    -Wclippy::mut_mut \
 			    -Wclippy::needless_bitwise_bool \
diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index e5475ff62da3..237182446db3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -140,7 +140,7 @@ fn remove_action(this: &Arc<Self>) {
             bindings::devm_remove_action_nowarn(
                 this.dev.as_raw(),
                 Some(this.callback),
-                this.as_ptr() as _,
+                this.as_ptr().cast_mut().cast(),
             )
         };
 

-- 
2.49.0



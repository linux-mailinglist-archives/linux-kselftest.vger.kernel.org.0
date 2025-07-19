Return-Path: <linux-kselftest+bounces-37672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13698B0B2A0
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DE717E7D6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B508A28FFCB;
	Sat, 19 Jul 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETOSH2Mg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED628F955;
	Sat, 19 Jul 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964982; cv=none; b=KyxKTBDKmaPMQWfOexAfgs38q+QnLShozIIBwpZhQ7RkGJ9HO6tl5w6AsvFV9Fk2+PYtFSTkC/NH2GT+o0cvkuK0SY2SsPCY79j+MQpmkioTjW8w57Ay2MKJHhdrvPMPfiXBQY3bbu+36d2IbQSPk7qvV1E7y3/QrHi0GPtq5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964982; c=relaxed/simple;
	bh=SD3G4jqyuzcSVOOImxvxCQKawvUyi73ZCoxehYBa7Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gjh3KBf9/CKch+CZRHcp+tgsU/vkbyrJ3qJyVgdmnZJDeGytwRAktbS/WNE1LiUh0AlLW1F26pGRzs+Ki0ynzR2gBUAJFgbja7cf/l8TXvqmpJM+I6QuIZSZnWKSg+3UYOrJj5fan5BpclgIyrBtilJINss9RAmdolcezeyEjwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETOSH2Mg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4aba1bc7f44so24286581cf.0;
        Sat, 19 Jul 2025 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964980; x=1753569780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3NY47tJRGk+8ZCP8/kt7QLiEFpyYgbdtZryIR8Da5M=;
        b=ETOSH2MghW9JrVlQNT3jgHh9A+y45K3f3OQxZ30JtlQtPS5HVRsRBDrJrabCWKSDpG
         3AW+sPvPJf1J29M8SPMfkarheJhbC/mS1yE/hoIx5SUyNYOhTx+8boj9XYmhRh1FoLjh
         1bpS252BOsfLm9ocbmXb5RUa1uusM5LsU3oxjBvfV+NhWknFf4A7hdXKwarHTxNh0Qmt
         JQ/NqpXrfT0AVKgJm2TMgQVUIi5OJjp18MHreRmDXyfSNF6xiNKVp280OnBYoGnUcVuO
         KXHZgQhDxGn0Fz8DqZ+MfQqixvJSIPgliTDmcvU91J6S6lZn/zErm2m/qkZHhfbDsd8K
         hNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964980; x=1753569780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3NY47tJRGk+8ZCP8/kt7QLiEFpyYgbdtZryIR8Da5M=;
        b=l17hbzNp+q5oMClc5IHMXiW6rnSawKip3nC36WVRa5xNz+hpqANnQ5RDUYn+fvJey+
         5NBwGIOrTMcs42skGfJEXNGCEil9YTqng+mDrfMXRTT0dL36tPFMa133ax1yLPyBbXUV
         TwiS1f1ghI5o5hN5mI5mYOfQeC2jNJwlRICLf0izq4qLtsKKHNWo8kbUGcfocANH9u2/
         WUk4oT0rbRdb4ylTDdrNXqRe1/V5erPJwvz8aEO0/VqDkyRt8ALxEZfJx6fydYYGWuvx
         nokBBg2zy/cDs1HPzo4fVoSOCjOE3aWD8iktMM7gnFkM1fKUQi+5alZ55gPC4Paw20kF
         3jSg==
X-Forwarded-Encrypted: i=1; AJvYcCUA18IfxeHOdowvh7TI5bpAmvaqKaG8EjnzPFJa875iyiJ+p17HpKN6BALAwFCJ/o+Whd0oDY3tkV5qs5q7@vger.kernel.org, AJvYcCUK80H6Q/9dqAk3R9rN1NTIFTqqxwuft30/TBJ46CyrG9UhW1iwArLHL4OJrQCjbt9my8K5cDrK@vger.kernel.org, AJvYcCVNmRZ32jyMeEB3eu4Gq5RM1/eU9Dc8/l1xd8Hz6a/bhjnKhB9wfFEyeB3mn4iemfOMA1le+Nm9vqFOZkYxDq9R@vger.kernel.org, AJvYcCXLhRbDNNaVGiUHv/ubAYq7vd+DVfaahig/eH/DN0d9HQLH7l1klzUEfXKcovlOiIvbCGvC593EwYQ=@vger.kernel.org, AJvYcCXfyrzWXwJzKDQNlASUtUGng7SMoIG919Jt52dyEq4Ng8r9s4dJCWhp497qxPtozWfMxeAMcMiHqpabla25cyc=@vger.kernel.org, AJvYcCXz9WSIBzGxliGwkR3+0G/hhyNl228nFg+CM37i8ZPT2b2Ei9D4angYdUEnwdfjfVcn8vJb792d7D98@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvTpWVeifu3chXI9k1KOTjEi5U5H4R+YH1wOZjy/3dHRl+tok
	GJ/Ui8X6+1oBpbOuuKmQgpUWCz7dfGQbsOy+yuIgsEELGHx/OVwKbO9F
X-Gm-Gg: ASbGncszqXlO3e153APRAVH2JzmY5Ls4+O6PCkPgNF44jhDxDlzoPv0Z2ejNHiZb9dq
	n4OX7tv6mSrVbvpfW19ENlz5YM6sqmfj4z5e7FtiP0MDqhxzMUL99a8F3o7njCMzyzNTnYzbCWI
	WVK7GzjIK7qzubJCYz6sPA7OkLwEoRjArtvDW0KWDrAIygvMMBlzM65O3+WIe1ar6E2m8KWIN1G
	Ib9hci/f5Is1G1qdwyXFc9DBpfPFA/hpoDo7HDv02yEIw7O/2h7EdVcEyD0BuazuuIXxl7NqzxP
	F1ghi/Ikmle5s6ePeBHUNep1TQqG0yB2a05QRs/cOomhgIL8rNB78dxO+c1bbmLEzh51HEaErFs
	j4R6/H/J3uKjlwuNedUwXKodRQtnaQMFo4gQ4LH4T77oUtaeWBz+j3+23tg5dPSjXjCOmFXjs3p
	h57Fc0hfwahHn/e3y3jM7FbhYgF5VI
X-Google-Smtp-Source: AGHT+IE+VLj1eoQJlkntq9FCqSiBVAWaZ6ejE3+GS7GuKBpgeIfpkdAoy8KZVTX3zCCXeHxJrsI52A==
X-Received: by 2002:ac8:7d89:0:b0:4ab:70df:fa20 with SMTP id d75a77b69052e-4aba25f73cdmr190367941cf.16.1752964979879;
        Sat, 19 Jul 2025 15:42:59 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:39 -0400
Subject: [PATCH v2 10/10] rust: of: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-10-e1cb53f6d233@gmail.com>
References: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
In-Reply-To: <20250719-core-cstr-fanout-1-v2-0-e1cb53f6d233@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964956; l=1199;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=SD3G4jqyuzcSVOOImxvxCQKawvUyi73ZCoxehYBa7Fo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDbHtLruIIxp9ZSU/n/rHXJnJySJp0GBObTIQohb5XiIw2SrNPfLKfjjQVWotSa6tEAbOEg5G0M
 tsoqBodzCsg4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/of.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 40d1bd13682c..5cf50979c1e8 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -29,7 +29,7 @@ fn index(&self) -> usize {
 impl DeviceId {
     /// Create a new device id from an OF 'compatible' string.
     pub const fn new(compatible: &'static CStr) -> Self {
-        let src = compatible.as_bytes_with_nul();
+        let src = compatible.to_bytes_with_nul();
         // Replace with `bindings::of_device_id::default()` once stabilized for `const`.
         // SAFETY: FFI type is valid to be zero-initialized.
         let mut of: bindings::of_device_id = unsafe { core::mem::zeroed() };

-- 
2.50.1



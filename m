Return-Path: <linux-kselftest+bounces-38878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1879B24E30
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87B11BC0ED6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C628AB1E;
	Wed, 13 Aug 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0w5YDe8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D2289350;
	Wed, 13 Aug 2025 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099731; cv=none; b=o7yFvMGO9cdbr21/wfHy+yW2eJHLgc3VTB4wi6+653jGYKlkdjJuq952C2vsPpGNz574pVf39qhohBENkIP90bQFxfbHElkyNh/mhHUYSeGhYIYcTKRyHxCKqZXfT6zQgs96txjtlgA1eEmK2Ml3kGIgVLJVSUSHhAVnG5D9hFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099731; c=relaxed/simple;
	bh=VlYiw/A0T4sL7LlhqFZhg9UDlnS8zpc+y74HsiIttIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlyS/ZIpt3KLSU3Ys4nSJ8c9WwlRhqQ5ozTws4As7us9sZDDnkVJFikcwRd7C7A4tDKAto9LCBmsKaBnlLwiS2QLE7Fci8L+DsVM6T8Vnm66iVMGemkyO9bf1Pk4QWIgnqh1IVtzfRJY2/DvMTddeBM+/nZvL46lmfJiC7XbeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0w5YDe8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e86f90d162so4025485a.0;
        Wed, 13 Aug 2025 08:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099728; x=1755704528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAVIGNcXAikIPjcz0+9QwautG+MBQN34qHjISmCjRuM=;
        b=P0w5YDe8rnafXt9RXZvuRjm3Ytqwo0HPE7B5ZZGUnjUjjxohuFNB4k9B3/kmDTvkPr
         0A84U8V3P35hi8KLXlhc640f58koroQ5DCfNa7XMLQFserc4N7l28LyrQN+W9nrgr9Ss
         dwiLs4rMANxfF0wrHeBofwz2NJWuaIz9aizolbnbhWRShOh38z7H0PO28B2+civcY27f
         3AGE1QA4pqv4KizvJFoyV/HFgd4Z4JpAzNWAq3I69F8RNSr7o+cb1Ck2Iy0qH6hr/XfL
         6umO/eNSciCAfRNEiyKXoxiwnRGwQtkRcsaCV8VdxiN/JOFXc0znfOoyaWG442wFSGot
         A7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099728; x=1755704528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAVIGNcXAikIPjcz0+9QwautG+MBQN34qHjISmCjRuM=;
        b=qNsuQE7xVwyTJoMF3DtC7KpwK0nbIh0H0nYqglBYhgUcu8GhVNNXgaWefrMtAimLsc
         LYyLEYvUOFsfI40xT2DDGw8lxlqSnx+AeCQ1yJOhcPBOtLfEuQoy9O0JrUo/X68pGlkl
         xwEyb2k5O1BL3WS4pGN2AQRj+JuWpj8MH75+UEFoELP1JmMFwKGddcFNwCKsjeHq2v/g
         qypF0VZdDFXUD+p1LWMHbW6yX07Kd22CyzGF1e+XjvjtceXAAndzu+587s5+On7mt5l7
         aO2U77G/mBDuq/3Qsc20te0YbvH+JN4aSELnXeZuBep2+hL3beKHoqgYXPW6ScDU78b1
         +y5A==
X-Forwarded-Encrypted: i=1; AJvYcCUGazpSDV0YAOrofhqpy00+snXtJ63w3eafy1Yn36SJAGo8QtG7NOnHe8HsbXKVU/Hdlg6tBrUh7xs=@vger.kernel.org, AJvYcCVbGQSSSJKGC8C5Myyacqryw5u4X1St4doSHj9c6Z5JWTV4ytkT5xgGyQOEQHNNz2IbhuMEefZwJM775aR7ZTs+@vger.kernel.org, AJvYcCWIPU7HbN01sCyqz+bVVkGO4591Lq4RuUYU5kbDlqVvCXexWYFkv0d8VAe37bYEhYfORqLlfltd9buq+2GF@vger.kernel.org, AJvYcCWfXnyOt+ep22iPUnTO6lkP6mIv1rL7jmHml7aEuwzvH6mkyBK+tEOdFQOcEa9caWD9WJwNBGX3XDAc@vger.kernel.org, AJvYcCWrAvYF9wPy1lFQl457RSUWv2ugbM0GURD9C/DNoK5HF47nMzJnaYlcxA9iG0UbSaV/87tc5aVfNfCZmbAVlS4=@vger.kernel.org, AJvYcCXGNCQQ7Y9hTNwkPZjr506MxN7EjM17xiUblHHQvoyYajB9V5pZgrfa4FLpZHtA/EoFyTQKKCJt@vger.kernel.org, AJvYcCXSyzN/RP0ckidpXIR9vKYoOTrc0zAYDWsdzaNgDg6Niq8iV5WgC9VyJnDi4dttVtyO+pr53J0aAHgOXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7k5GS1otcXkSExmO94i8teIcTJCgDAYyDho81juKfjmr8DPyj
	MtWgNRL8kpdMOdMCLVSwRR/pMcdwXAzS3u8Kb6ZGXHAvIBDHGDE/d7F2
X-Gm-Gg: ASbGnctNJIV6uR6ry5WfGsqEysJ0YArGE6tJPl1814XRrlvMxFV2ZW3z+qPmXVZAp5y
	cpcGWofJksSxe75Zyr0YoOJ2F/lXOd1QVoqkWteTqx0xA1cKuF7Zmq9q3iv4GQ0UsskUT8dK8Yw
	AmsnZhyJEkJgDNcgx42x6LWH8aMF83/b0E8+PJeLot3/ZdsnnJhUBfbijxKidw3A79rQWWo9WpE
	39suzpArr7ISBjS1fn2DDwzwLUBobtSsj6J8heRpkM3fYOk1qBSkYcEArbsktZRxRXozK0hFWpk
	UpQEMQ4FAoasdwgnBFehYqxMdSE9hUC4mSf5OX32rLUpLxRYnBf2nnc+iCJReA8lMGtg//hMF5O
	Gy66yZ5EQY1gkTjUR8O7ylggt+6yl4q372Eudg0RNqWeb1KS4A0g5xndhQ3lrinSDGRQNRPHV9F
	EKYFJsgNTew7CKjdJLhpTwukxNtxoh91Yl1kyTCgP32D4+
X-Google-Smtp-Source: AGHT+IHWWRr4WlqqCu+JbpSqKh1qg6xKr81k4ITVTkgW2vt8hj987C3AcQSVI0HeFPlkaF6YX7H/mg==
X-Received: by 2002:a05:620a:390c:b0:7e6:38a8:bbd1 with SMTP id af79cd13be357-7e86fbc03dfmr9802585a.2.1755099728387;
        Wed, 13 Aug 2025 08:42:08 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:55 -0400
Subject: [PATCH v3 04/11] rust: cpufreq: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-4-545c14bc44ff@gmail.com>
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
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
 Saravana Kannan <saravanak@google.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=1047;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=VlYiw/A0T4sL7LlhqFZhg9UDlnS8zpc+y74HsiIttIg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKRzT95JfYfHTEBnhcIw0am5SW6Ke1PVB8xmVGYw6QGfVJxXJSHX4LF0AI5UNzsF0D3C7KbWjbG
 vvqT1dVQqpQo=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index afc15e72a7c3..2bdf9ae00ffe 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1018,7 +1018,7 @@ impl<T: Driver> Registration<T> {
     };
 
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
-        let src = name.as_bytes_with_nul();
+        let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];
 
         build_assert!(src.len() <= CPUFREQ_NAME_LEN);

-- 
2.50.1



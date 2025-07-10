Return-Path: <linux-kselftest+bounces-36992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E8B00705
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97704643BD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3BA27A918;
	Thu, 10 Jul 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbClBLye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEF27A131;
	Thu, 10 Jul 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161509; cv=none; b=mvoD1oWP7MllaugxjsSXoEaBDTzas/uR5DHxgE3NoiuLRrdTCGUt+2jw1m/KWanNHDkLc+TXDTaVwPDjDK+1A1B4VszFHBjiTjOlkK/9+98IhNY7gqDWGamisTkTnsW2M0XdCtuumonPW3l9EuQGliNDR/WLVb1g96fTg3kxHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161509; c=relaxed/simple;
	bh=VNZQXHbrPNQTjnCfNmCZZ01KeKVkMs9GB6vXbtVxjro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cgFpm1IQ5VHQUjLf+iuV9G8kEDEpkSv84ditB98uH5hPmW7WAdFNNNXd1yHBRquLGFhdp968iCi+StFipDdzXYJZ6kgTo6KO4HWRGiCenUgRWnRY/SqE1EJgGYnUbODhly2g29u9e3kT04MARRxhFDUEXND2jh7Wwc2MXmLYFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbClBLye; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so10567246d6.1;
        Thu, 10 Jul 2025 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161507; x=1752766307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0zIVbcphTDjCV/BRYSz6swPeiPXn1qULo40NKxP67Q=;
        b=JbClBLyeIgTxf+QMF720uIYCGAIMCzgYBo1twWIQMgeRyseXADqq6OMW9njiQKJ5fS
         eoDFxfizlsW+AOr7LQQ5OhUxrbOZExd5KfMTMzJnwFeISgX2Z1jB82N+clTrNnqolsQe
         xE6b5PuPssCadHZcZsmSO0kdSyOx5XlGfesdcaXRaSNMAYf3BUNCe0YQxO/IRi0Bh4BW
         df9/vMfcFmmmFJDeNyNS2rE0h6hfI8WK3kghVqDyyzTZjUrdZZMg43/POst4I81g/6Oe
         AG3Th1Ee2fkx5Fw1ZQDTCNb3cvf67P5/aIZH7lY3fpG4UWuGD5OMVep3+XqMs/9+IIGW
         H59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161507; x=1752766307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0zIVbcphTDjCV/BRYSz6swPeiPXn1qULo40NKxP67Q=;
        b=FxjUgxCebjGuS5Yl2GjlX6gbqqaWK/Uf/blquT5tEzZYo9/Nmnxe8uWxtnQwQQU3kf
         e2XRHt7tEj0YMlnBP4gCBH9M7UmhH1COISYSStEgcfX9FmNcHGmNeTMd6QLHzWGBnMIB
         ux15jpXELs1W07HUF/QUNRuTzAE9ouK8ERFbFxHXyMrDyfWrmWeocJgAUuNL3kHSYfrb
         VGeiuNwKpMOYR/NAfgUzN7Fi2Hx0pjSaBFk2Ivlk3b28WZ0QHFqGw14hsZheHUjv3uwW
         MVB/Xg3OvJ9zKcGW12cqcdkpwrNdWV+PKX7vQCiaOpNqvHZNoLiLwGH7/VQTANhjL0T7
         YTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwymS87Eni9VdQfu3XjcdjdZz1N2eGQNmmkYnd+7sLW6cwM6uDGN3h+sZL4j9FFSz4Y4cuwhv@vger.kernel.org, AJvYcCUeI+PVQcr3wG0kkAwEpM2W3sNAt070wXlNVwbuYYDZFPzf/qs2NejkQHRH4wkSB0VjnSdDJrm61Vhs@vger.kernel.org, AJvYcCUtIpJpjK4IlynqdmCPa4bwnn3Xmi2LhdekH438vSOY2FFahl2pxoow2BWIJVI3IC4vlbIJX+6NWnGXlAtetmu1@vger.kernel.org, AJvYcCVjBy9wGYIkERFbSNxxyYEojs9eolY4h8gv/rICTlErdGtPj/O3jDCKJ7yPLoDrJyzoyn6KpzUaINde@vger.kernel.org, AJvYcCWpoMCUclXvVwSTp85FYzyIWAb1DT9HvmCXEkWd2qePuL0jpLJqerU+AK/4nBmhrRHNtrJoToigyxArLIuA@vger.kernel.org, AJvYcCWvjjEsoiUl45R6Iy2j9SydXje0HK708VnXau1iOmBcgT5otGlgVl36boMKY5t0ygW0ndnNZCgSdOhNeWvOqs8=@vger.kernel.org, AJvYcCX90NUllWP2iuZ2QkTMUwsTwwubyCuook2J+KJRHGEWzL4ZHD4iN1ljJJeLIOWYYGDK33XM3+/jR9wtrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztednSOVsGkHbx7dinEflNGiLMk38cvSh5ZsRTc9Xm0ykGR9n5
	RsfoWUNLJtmGygcsTHJYWorvTjSLZQsfwvtiakusTDrqHbbxGiC5QMZr
X-Gm-Gg: ASbGncvu7fD5tbPdJ3hgYjw7lHUYQeWlbitgw6QzyasjYVBRI/0s9UBODNXUVtCjed9
	P/qFjwRplRXQ21xMarvqlG8Syx0jc+B8cX/2icfYXgzkiNeZT8Ru2fgK3KgQ1rxz42BOnPuZMjs
	F7YTS4H+TIvWGvq9wrVv6RSWyosvBvdx0ap89mJEB7oGWhaijWv1ktgHO1ikFuaJvHNLmfh5AVX
	SY0evjBn6EfLy/usnr6Nq1I7cT7B0bTv54wv7WH+7fa7TkCi2HqrdhcMbRizo/cZY6CSl21RiY3
	A7gjI5lSri5KZ+XqSVqvOLQx+5yHXiQN4HOw4F1l9jfwSfKoMWWqz0OfwQ8lgYArsHAPat5oQ3V
	7hh6rANu1kGT95fy9WbpxeghUqXrLf5c8JEh0cTlH+NwbfdIt0R46r9U0ag==
X-Google-Smtp-Source: AGHT+IGcu2AWwgL23R/GZcRg4GNhqiTRg3tVkCGWznIBgtE8Kyf5DTvce0/bAy+ygow+T8DZUkNSVg==
X-Received: by 2002:ad4:5aa9:0:b0:6fb:6114:1034 with SMTP id 6a1803df08f44-70495068decmr72119166d6.39.1752161506061;
        Thu, 10 Jul 2025 08:31:46 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:09 -0400
Subject: [PATCH 06/17] rust: cpufreq: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-6-027420ea799e@gmail.com>
References: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
In-Reply-To: <20250710-core-cstr-cstrings-v1-0-027420ea799e@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=2282;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=VNZQXHbrPNQTjnCfNmCZZ01KeKVkMs9GB6vXbtVxjro=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJt8ypGIS+ehjdJ0134iQriRSNjL+xYEiSlM8eZgFuoZS1V3HRYbC3s63Q2FJIma29BKt9XxA5D
 3g7BKjvyMGgk=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 drivers/cpufreq/rcpufreq_dt.rs | 5 ++---
 rust/kernel/cpufreq.rs         | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 4608d2286fa1..0b4feb27b4f4 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -3,7 +3,6 @@
 //! Rust based implementation of the cpufreq-dt driver.
 
 use kernel::{
-    c_str,
     clk::Clk,
     cpu, cpufreq,
     cpumask::CpumaskVar,
@@ -55,7 +54,7 @@ impl opp::ConfigOps for CPUFreqDTDriver {}
 
 #[vtable]
 impl cpufreq::Driver for CPUFreqDTDriver {
-    const NAME: &'static CStr = c_str!("cpufreq-dt");
+    const NAME: &'static CStr = c"cpufreq-dt";
     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
     const BOOST_ENABLED: bool = true;
 
@@ -200,7 +199,7 @@ fn register_em(policy: &mut cpufreq::Policy) {
     OF_TABLE,
     MODULE_OF_TABLE,
     <CPUFreqDTDriver as platform::Driver>::IdInfo,
-    [(of::DeviceId::new(c_str!("operating-points-v2")), ())]
+    [(of::DeviceId::new(c"operating-points-v2"), ())]
 );
 
 impl platform::Driver for CPUFreqDTDriver {
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 71d601f7c261..0f316dfeb5dd 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -841,7 +841,6 @@ fn register_em(_policy: &mut Policy) {
 /// ```
 /// use kernel::{
 ///     cpufreq,
-///     c_str,
 ///     device::{Core, Device},
 ///     macros::vtable,
 ///     of, platform,
@@ -854,7 +853,7 @@ fn register_em(_policy: &mut Policy) {
 ///
 /// #[vtable]
 /// impl cpufreq::Driver for SampleDriver {
-///     const NAME: &'static CStr = c_str!("cpufreq-sample");
+///     const NAME: &'static CStr = c"cpufreq-sample";
 ///     const FLAGS: u16 = cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV;
 ///     const BOOST_ENABLED: bool = true;
 ///

-- 
2.50.0



Return-Path: <linux-kselftest+bounces-38876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 536A1B24E07
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D7F585DAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Aug 2025 15:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A578285C90;
	Wed, 13 Aug 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYglH0jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75372853F2;
	Wed, 13 Aug 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099726; cv=none; b=oFkpyTxP5dbZ0P7Kk9csH5DQXgQUjZp8WBIDTnuw9XrvPt+m4xAb5Km1Cm76MTF9GDZMgc/OsPdSBU2K6s8rVP3q5NzSuBEAazdoHGKxpeqvC7fifosEoAbICp45Xh2+JlYm4+RDxkcOL+u4AxKActXjLKXf6ASm8xzMPzKBfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099726; c=relaxed/simple;
	bh=fm0qgPhMLwhXVUuwviW+AbdgNwUfh/gp/dzymaCtTqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ll8Z38q8r5DGuhqb3qo9Lq8kZU35Q5pXMt8UYVv9MLpVk6HVhrfooDcPRcqi2v80p4asmKnddAJMHOmo9QR0FYr6j4InyANYUujyRVUY8W/cMzWmqnpW2oMOzc042VvF9t+K12vAis1bJhBCjYl+xDitL/CecI47ksQV4sroNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYglH0jy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e841c71aa6so423902485a.1;
        Wed, 13 Aug 2025 08:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755099724; x=1755704524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp+fCas9Zrtl4wezHGHT/3mKuibllRBTEu6ZN90ulnU=;
        b=ZYglH0jyLNguhVMGcRKNVkKgKUuvRIRDG+AMN7NXPyTeVPpGYJX4fe0JtdTkSICADp
         8JFytQmefSfgGhMQHZELllde2+xFyZHvDvqK07klfWhnIas9luDk0PUU8BwbBrxrSMZj
         3zdf/qztI9mZToWmrgR+j9h01aAFjbUWTnSHGKUy0wWmBkU3uinshqUOJLobpd+czhif
         GhQbH9EE6i+6BVA/23NNIL/sROqlZV72wmUTFzHMP+6kdz41XDEGXSCmeSrKl1Zw2/MQ
         UDAqmJGHRXDvx1iT+vzISmPX3I2h40t8m9x37G+CUoRxxm8lBGB6bhAXd1EsQqrNtSrC
         m77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099724; x=1755704524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp+fCas9Zrtl4wezHGHT/3mKuibllRBTEu6ZN90ulnU=;
        b=K8j5Sy4xPd9n9FnkY1JddqvQ2kiLIJhDhojmB4jN3R2KzGTT5whGcD207oF14Wpyk5
         L7/FX7P8TiB4qu2+ft1wNvgKjKx+JV4k1ghimjtjvk67pBIfA3zoA65pHxSl4wtAtkyX
         4ensaf0jNbEs/XV+Ed3IRptE88G/quT4Bom7zT2dkuWCQTGfEbHKrX6QizOpyk0ypDeo
         rghawZHp0q6C/OttNEZ5Z04DvPX38AVTnXSziotqMkfgZKyBQ1OzVppPfNC+TE8VTUJ+
         G6WHkco7Xtl/TxG3jsGM6gpz0t5gwqYrtX+jJgi2GkVmn6H2liV4Gcb9SQJF3iUuHsp1
         dejA==
X-Forwarded-Encrypted: i=1; AJvYcCV1z4Fc/0y6beIEt/Vrs1L9agWOTnZjO+M4TGiI2odpueefvZ1N3CozFXaoRNiuxykcGQIUD3apNiG7gATrdNCN@vger.kernel.org, AJvYcCVPO4TEf7PXNEzYVszDZypi/avzF94ezMDOB2zrvOnL8mUD3zJZmlDhGz1u5XLlNvMmtQlTvlBZMotO6ywd@vger.kernel.org, AJvYcCVSfSR4okU8S+2wJu1OsW6vR0vBS8vTF8cOWtkt9yvz8H3RDQ+G7BE7XIzDHx6avExqou5zPEMCSbiksA==@vger.kernel.org, AJvYcCWEP+RJNmXunvsG/4qGF5ny1kdcMiVeWFqGMBqtBf5oSKfuiq1Z1sC4j1w/SleQJKauVbrzvivw@vger.kernel.org, AJvYcCWi9i5j+qHE14Sl4CjzyQw41SWHLpTBCSMATKe31WfLqfJyKEqzac1IhhuTymodnO9GdtB7BPDYpfg=@vger.kernel.org, AJvYcCWlKX9Kp6CQKsoQGiCDHvZ1HyRg1NbqEMVXQdP8qcP92hFd64nKI5l8MsU9Eu5lAaD0jDtFLAbRoCF7yaKSWzc=@vger.kernel.org, AJvYcCXG/2F7GaYBnAUSf3yvDbljtjqGRs2FqSS6rUFuZ56n2SxTwEFPNS83PYtEb5OvT0cpPKwd/XdwZaQA@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMLZ8MnGealpRVFfTtcTesnSHk4TP21bZpkpyM0lBj/sq9FE4
	SnxxJ66RsGYVn1UXbE3Gt+2buSKleiu5XCAkwsbphuk9GbVKFRGzgtw7
X-Gm-Gg: ASbGncuYmFQDWxniGtvCMnSJaRA4ezKILajWXqGRE4xNe6gixg3WQRCQCXZPs0cSOFC
	vmB+YrvAKkskQYA3BuG/bDp5lbwIgnREaD06Ish29Pzja1Kr9KoX12uNr9hkupiOW6WNBny6Jx1
	T3Pj8Alaxov/Ily/UiueOjlsVZBvJXD2fsmayb8m7PqV7/UwqLvE9/E6qFyVOLzyhDbl2KGQHU4
	fKuh5WU6Roznfu1pAyTtoJ1O+oEVqgCHXnikT/YLj8nkrID7HT2WevfNJcQQsB26VCKFoKXHllo
	QN13yc03TKp89UeLYVsohiwBeLaj0cjd9Pvr/Piqhu7QDgVREnTL6MFPCZ4CIVfKGnHfvSomSf4
	WbfQ4REgq+b7LlzwA9h4Loymt8ZXRGfnCee0xVskguA3BaLH8KdPF5vrL5rBS/JsUgnjGaAtXiD
	DVi8MehF/yme3CmkHOlayCSD1ptIVjC1aAcg==
X-Google-Smtp-Source: AGHT+IH3Gyl1PAf9LZipxoIqItiIsX5gN76gMdGUlBsOjA++2YXjpKyARkzqrf4A5usSLWq1CNBAvw==
X-Received: by 2002:a05:620a:484e:b0:7e6:9c12:f0ce with SMTP id af79cd13be357-7e86537b611mr412290785a.66.1755099723511;
        Wed, 13 Aug 2025 08:42:03 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:d445:7694:2051:518c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81bc7a1e3sm1180019685a.74.2025.08.13.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:42:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 11:41:53 -0400
Subject: [PATCH v3 02/11] rust: auxiliary: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-core-cstr-fanout-1-v3-2-545c14bc44ff@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1755099715; l=1235;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=fm0qgPhMLwhXVUuwviW+AbdgNwUfh/gp/dzymaCtTqo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNI3dWTWVNva1ClYJUkm/ax4LvCecBNot1IU85Wq7cotQ2nzszw6MVgFO7DYjRRwPjXruczaFwK
 yVy6EkaASMgM=
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
 rust/kernel/auxiliary.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 4749fb6bffef..58be09871397 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -105,8 +105,8 @@ macro_rules! module_auxiliary_driver {
 impl DeviceId {
     /// Create a new [`DeviceId`] from name.
     pub const fn new(modname: &'static CStr, name: &'static CStr) -> Self {
-        let name = name.as_bytes_with_nul();
-        let modname = modname.as_bytes_with_nul();
+        let name = name.to_bytes_with_nul();
+        let modname = modname.to_bytes_with_nul();
 
         // TODO: Replace with `bindings::auxiliary_device_id::default()` once stabilized for
         // `const`.

-- 
2.50.1



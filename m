Return-Path: <linux-kselftest+bounces-42342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF71B9FCC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403B81884A58
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A52ECD01;
	Thu, 25 Sep 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ1QBzQQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE62DE6F7
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808558; cv=none; b=csrYJJ928eejq9xMiNVJeAgWyVH6IbapSS6ixL3yF2z2p/0y7m9ttrGnyox0QzXLttopYQIToZVFvlEPDxRdPyrd5L8/8qSUFpv20TnM9stmw7YrmPphSPu/c2v7ZAN1AqJZ2QX03+NbxPeCO7t58KMZzrAKDagW47ICOlycCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808558; c=relaxed/simple;
	bh=TE76Xl7EtGwiL3k522JoFNelrGIHYPV5uXDUZx193fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oR85MHjdFLJskWVJR5oP7n9F4RpFqt882cxnYxwpF54dFsV8R5Rigc8+tPHZ8f3f2eg/OK16pjPvP8xFnuGzNFfeCFiPcVvz4zwrqw2tr81OdHxaILoFzWZiy/K75KpishVzN00pk46xmMfkXsK+rGYN/OuPPTo+y/dac294e28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJ1QBzQQ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8582a34639aso63245185a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Sep 2025 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758808555; x=1759413355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbRi9B/DaIaW8U9NAWZIVdIpXCsTnUCErxxV4ovxvuk=;
        b=kJ1QBzQQnod8ikaYW54XssR+CBE3xeOc5hPHb9VMVkm40EXVbG2yI0I4JTy9k7v1V2
         xPJPBZLVEqpXdWn+b+d+yi/VR3bTT3A8qRWqvvbLrlZC0zK4EMU6eQB6ocCdJL+STxG8
         rGtjFKtaxLVHEkxVjFk3hqKNTf53DOdJ/cPB31CF3iu9Bo4Jx7+FJJRXun5NuVDK5R0T
         XEE+P7wWItGg7cidouV0rTIv1sdBr/NZ8eT/ErtQPMdbjvPQ7EMvq41rnAmJkvHTqQpM
         jsXPHNd26pnlqGcpVzITl7z1hZ4Jm5dKwib+hGhygoPE13itEfZhletKi6i6fRZtxWbx
         sGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758808555; x=1759413355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbRi9B/DaIaW8U9NAWZIVdIpXCsTnUCErxxV4ovxvuk=;
        b=I+fvHrep6+oOSbf6jjUDi5W6A7ufBKXKGDJ7y4v2XDEaRHM5dK1s6SoF7xrbRAsKOM
         WadCFl1QKCsrMDHX3TsTlVTiogjamdL7esFktyO+ELUABQjQzc70Xs076kzFioj5hrMU
         K+LvQqfN+u8rMAOijSr70Wl65XJRyfnjFDLoiNZk6sioIl9EWIq/wD8i7iJRXjhyQQDN
         0jf5Z4VRYWOyF+9XngZOjHbxMMq+VchYoM4jDYm2kNICnuVyak7wFnGBcz5OqbLWJz2Y
         ZrHpb9XlJny0MeEOett3Yjrregf9fmZhyA4yiO/hEIzZzYqSEVcDxS0JUunQRI8Cw/U0
         NrAA==
X-Forwarded-Encrypted: i=1; AJvYcCU4amsRHYr0O5cm2TfGnwzU5HtU17hrUvWaYQTeCXJggDSn5QllbfsLKK5HPIdC5UL5oliEU7KbTm4SIHqBtyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCiPj8q9XLuwtIoljTBRw+nylurq1UFId2rPZUSUDz8uHm5oL
	oIadP2qu1qGBTey5SkdKlrdXv/CQxdp4jHgZgXhXAo3yU+zbuVNjYJRr
X-Gm-Gg: ASbGncuYGq8/P1BU4rMiVn6tUJCIU61GVTQNPnzc3Svbe48sVAtSxXdfMGYJB6GSqLn
	24OYgRwFD8okEV/jQ1t5rW2njh3Vq+7O5WINFVXGzl98zgV7H7yceqCNZIIIJ+XfG/Kd6EHJsUu
	DLLjbdItudNGSHLLcFNEyuwHdsrxX5gtrUe/PX4a8JqVHLRgePLb1WmkOVN9LOIBiYAM418dtNs
	++QzhYWgVJe9WnD3bx8uVjvtlbiy/Py/g/sBJ/1XwdBG4pvTrKAukHol0zsDSMJThTBq4pW3NCd
	LIhn4TuCWo9HU5LZDuAoEDyQXVTzG4wwm1zWVojAG3FxaMN0A6/xhqrT6gegPWc/VLnyj3Ec6oj
	NqeufsF5Qetl+tvObLl93y3WaLcGt2KXNSqzr+rTXMo23c1X+XwlDsfN2JGQ9c5unS4Sha+Ol+i
	emIJCQXD6N2pv3EBbgk7rC9ZcWzN0wTBvEA/qry9mF5BDrab/EqCRUlK+tALTGThql77XF
X-Google-Smtp-Source: AGHT+IG7SCiSfqv22MjkqMAx69OdDcsv0d2XWfzHnQ58HqF/5wRLVKKYuW5rQhqneJzNL2eu5F8jIg==
X-Received: by 2002:a05:6214:5198:b0:77f:4415:6d8b with SMTP id 6a1803df08f44-7fc28076ae1mr36287846d6.8.1758808554316;
        Thu, 25 Sep 2025 06:55:54 -0700 (PDT)
Received: from 137.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:7c:b286:dba3:5ba8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135968d5esm11536916d6.12.2025.09.25.06.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:55:53 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 25 Sep 2025 09:54:04 -0400
Subject: [PATCH v2 16/19] rust: str: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250925-core-cstr-cstrings-v2-16-78e0aaace1cd@gmail.com>
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
In-Reply-To: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com>
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
 Jens Axboe <axboe@kernel.dk>, Alexandre Courbot <acourbot@nvidia.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1758808438; l=1351;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=TE76Xl7EtGwiL3k522JoFNelrGIHYPV5uXDUZx193fk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNEkH2K217WCJVB+0mC1S+mvJu9BnNI6eCwPt0AKaTiMW7gojiLm71MaiB58vh7llyUCTN8zCSP
 N0RCtgv8pDgg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/str.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 624386cb07be..4203ce34ce98 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -272,15 +272,14 @@ impl fmt::Display for CStr {
     /// Formats printable ASCII characters, escaping the rest.
     ///
     /// ```
-    /// # use kernel::c_str;
     /// # use kernel::prelude::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
-    /// let penguin = c_str!("🐧");
+    /// let penguin = c"🐧";
     /// let s = CString::try_from_fmt(fmt!("{penguin}"))?;
     /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_bytes());
     ///
-    /// let ascii = c_str!("so \"cool\"");
+    /// let ascii = c"so \"cool\"";
     /// let s = CString::try_from_fmt(fmt!("{ascii}"))?;
     /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
     /// # Ok::<(), kernel::error::Error>(())

-- 
2.51.0



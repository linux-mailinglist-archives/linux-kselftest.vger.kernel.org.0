Return-Path: <linux-kselftest+bounces-37001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6C4B00743
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679AE1CA508F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFB2EA174;
	Thu, 10 Jul 2025 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLkodWil"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE96275AED;
	Thu, 10 Jul 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161527; cv=none; b=mU/UWRnivDqwydVTpgHvk1j0O/aArjcNUmErFCRWaX8wg/ycNsQigmL6fgkMrDPGNg1v8e6fm/o4x0PVI/ioyN116GjE9le5vWmhkXi9Dwa/9CQw71z+iFI3o4fVTsHSLbKHos1IKDykOyZHjI8r5G7L9nCVQRCPR+bmRCeJOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161527; c=relaxed/simple;
	bh=oWfPD9SZ2WRxhFsnid53HSH+eaDtp4ct8AP6223uNWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnDnNHcnmF9FNwJnKa5/6rYOpRBBYTi1ZMbHUNc5iXtFWP5IbmtT8exNz8ehGEf1yeeX5a7T+pKpO4wXsLvuRHaGSQVnP/wVRtdZAEk7lrISgoKp+DHa89rJLoUxghN9FvHcrHS93X1vgFo3K5DhS2Okd3Y9uEwpXe3n/iyZdnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLkodWil; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7dd8773f9d9so39746185a.2;
        Thu, 10 Jul 2025 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161525; x=1752766325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAjg0ZV0+LQF8h7dWz/4RhRbIfQ28PSCjaiFK3RId/4=;
        b=NLkodWilQepBBmMlEG5wvKO8+gAweW0Hc5VTuFdsL5BSP77lPoaDZ4lzpSwRlNQ8eg
         rvmZV3PsIpBjMzJQabEinOUQo1W9n16qhNf3a4DSj4wWtWtj3Ku3TvLc1iO6x5Vcj8eJ
         rXbWRnPivkWCYTSkBWN5CbwIFKu7Zu+e34k7ayue6eC1EvtyNHK+7nR5udVPhBvfHugv
         BSHmotqzsyXl0RUH0mt3v7Wc1fsH0J8DbbVhmDQ55dZCkQtGBeRJFXBojVbVHWa0dA0C
         o7ntZAYHfCoUKcwa4JVT9AKCNAsv+z9/KEQUiDxA6Y0V4IPuJPJuZT4RQrxjaCAVxfTm
         P1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161525; x=1752766325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAjg0ZV0+LQF8h7dWz/4RhRbIfQ28PSCjaiFK3RId/4=;
        b=QcXdtQ6ANZYDfA/UGUc8P7srBkrkzeouNU8F2fkgMdaF/H051sHcKqBDh0MuF9NM/8
         wJ/AEVr30A74A5Q6kKgmjQ8hXMo1agX2XTMEUJ6vhGDL7ciWzNErSBheU54V9dD7Y4Po
         IHrpdrH1gBi9oJO7RoiMz+lQI8yRdBZlM0YTt6zIqgMNJuHI74rjU7l3h0iCarPdngki
         k9uOHZHbAKO6ot/eZVNQpih9catHxC3RTNVMFLJlc67uzhkUqb5Nopq+nX/M40mGg+AT
         0pZQkTlWD0yXKopJevw8qMeWSDocvcL4x7b5RicWct12Zlfn+joB0IdP9H3kpIJ22zRm
         5zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYBFMCRInOWPk3BkrHcBsnNovYH3JgwzcA/GiNFO4n9g/2un69OjDkjSuNHKYButoJi64jrgv13N+kZQ==@vger.kernel.org, AJvYcCV+ej7dYuTlw8TNqnM+7tt7/xtjTosbqQq5XgnL1ng90ZqIXgXsdOLbfm08Vw1IXJPHjcCLo2P/q2a9@vger.kernel.org, AJvYcCVLbpqGDBkfbURVv/XeEqU+ENa5u8tLlxHmhr7+Jn2dYJu3SM8Y6G/38/xhLiNqKuZhW7oUkWHV@vger.kernel.org, AJvYcCX8zKpDg0ewcLVUq2iNroKe9ta/xBBgbfZku0yyHo9HYvnz8mUzH4SKbyWANbAhDrekdteX5l29Bx5EPMRQ@vger.kernel.org, AJvYcCXX4DZ6QnOocOoqx+0J5jAhgQhHj0DACl2yhVRqwv5bWoLUX7pceCIT5SfUFCMucFZIiCVC1RKyh/vjilKTyV8p@vger.kernel.org, AJvYcCXi3kh+FJUu2OS8hgmrqvhBirSnDHl7ybeQDPiBm07+cGZ2pbIQvcjTiK7939H3wYE/VYxtHvQMs4Zo@vger.kernel.org, AJvYcCXsTgyP4x0ihh5RZpfH34MZrzdX2hg2vgxSj7DYmi7LXnMNP1keMUDwHvc9y6PQ5//12UjoCqOFbmfqrwN9V/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkjMNFhGcrySouVsO78uGgC67wedb/4/El+xOkJChHrvcyL2S
	rtkVtK5jA6frGJgemFJm/9gEE9kMdws92NMZxTpxPmvyyjF3UlASTt2+
X-Gm-Gg: ASbGncuprBu6MlL7AbcRXVZU+XoxCxGODew3FZk0zQwg+eavMls8ZPRc8nVibjT/V75
	nljf6J9/HBRwyfIjdxtfNFVy3T2RIIQF0PRkf1/Y0R1rI1w43TduhVi77EvUuTpUNuatENH141w
	021lcqLCefzpBqUqFkXWgl0a+c66P0k3Q9T2Zr5ubcnACO8zy9Z5tLskjdY8CDL2YB3eQOwP/e4
	2HaWsbAVEdmpdBwP7IqyirGJMkLFvkRCFdEofbhWYudzR0UNsqyNM2BVu/tK4e+lMOKJ/cQK5RT
	IN6f/K7PHtkBK/Gw3RRfsedUSa5QhHVID9Y6+LFFbTZK2oRTvUBPDOAOXWm9248fHh+qNgISY6Q
	VBV8DPjerFsrxR+5RHWTElPCTnam5LL35TwWFAxUK+9uU/mDPcMj9G2CnAg==
X-Google-Smtp-Source: AGHT+IHa6QfTTxtysiSDzhEZvT6ceVeIez49OGRLLuuePcNYfbMj3bkmBsvuO2geaZw6Uk2BToW7lA==
X-Received: by 2002:ad4:5608:0:b0:704:9275:a7c7 with SMTP id 6a1803df08f44-7049275a7d7mr44810926d6.2.1752161524949;
        Thu, 10 Jul 2025 08:32:04 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:32:04 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:18 -0400
Subject: [PATCH 15/17] rust: seq_file: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-15-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=1281;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=oWfPD9SZ2WRxhFsnid53HSH+eaDtp4ct8AP6223uNWU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFNv2Kh23FtytsmiZFEP5IAXsVFrrWde3HmnmKMIPax0OI3s+QHLlwEHNMx8/NtqTIKC1Y9eoLt
 QxveS62SAaQY=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/seq_file.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
index 855e533813a6..518265558d66 100644
--- a/rust/kernel/seq_file.rs
+++ b/rust/kernel/seq_file.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_file.h)
 
-use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
+use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, types::Opaque};
 
 /// A utility for generating the contents of a seq file.
 #[repr(transparent)]
@@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
         unsafe {
             bindings::seq_printf(
                 self.inner.get(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
             );
         }

-- 
2.50.0



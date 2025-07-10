Return-Path: <linux-kselftest+bounces-36993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40095B00700
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D021D5A12AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96727C15A;
	Thu, 10 Jul 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeZugnrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE9279DCD;
	Thu, 10 Jul 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161510; cv=none; b=qjs3g/ySO8N0MXiRZhMebTIX10vSEXGXt+xoQCvhwGu3jeEVOJCeJpysBOx2dDbroxegLtHpRgwgvWOY2XwKhiLUR/AIl7GI9BuXBttSAleV96+OmyVK18SBM4Q5KiUe78C4WxwC0ljA0Ahuitdo3x9QFAeKRLEZrcPPwlRBkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161510; c=relaxed/simple;
	bh=lKArFG3jk79KbI1Ip2d9VIpBoj3sVr8YWgzpzTTR72M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8BJh7kcRG2FGTJVgBhW1TRc6UoLrXcgqFM9H73Hy4Mb5kPCWjZbZO2weHBCLdOSCHwCDJcaJvykoHl8eHsBBydio0EZ+tjBI5CE8orWy7SXi3lQeogRWqpstBEDk3gj7Jin1pqCiS114K8WGfhMmarbfcNNuHbEu55hAgINd+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeZugnrR; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df2e7cdc69so3134025ab.2;
        Thu, 10 Jul 2025 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161508; x=1752766308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVFjfPNTbi6R66/7pUgl3ALTHRI4zFg3YUCk14hLoUg=;
        b=EeZugnrRXU5e4qMz7AAoIYaqHEBnSAtpygoa/I+p3L9f2WMnWzBOSshncuXMC3RuIw
         JOQCMujro44fJtBM+jGmK74GJE1HY/kBG3DEaOrFRzhD8nG44XppjHEVVZ8oWcDsrnZM
         YlBEi12sKKoBj/6iRkVLpWipL9XP+AaA5WrwL73oY97cUocXhimW48W3AuyvzN9yIjin
         V3n8jtoqBZMcpSr39MY77kNHhzX7YTseHhoQbVtLza2yJiE/hR+GG+5Z6yfswTdBV/d6
         6sV2dBfhVFT1ue7jZkcp+hJyyuy4RhesHees+N2ii3rKzJJAvQbKhRZ4fbRqooNA56su
         dN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161508; x=1752766308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVFjfPNTbi6R66/7pUgl3ALTHRI4zFg3YUCk14hLoUg=;
        b=JdNymk8lK76D7r6/rhCDcK93hTuA2FW4wqeIZmQ6tuLBukf/tmNvqsuDHU8/ivzBip
         xcrUIvdbGqc0dlujLg7CLvr/oBkm9r6i8l4FLc95cEIPoadoZfWQroqDdIiBklc+lpju
         rukzTF61mb+Eu4prr4Iburng0n/zxNiUKa8oWdwqWq7S0KHxyWuAMWJ0pywtX73WanP/
         7TAc3psVLUsDyCxYpGNW8H3LTk/Urgxqr1Ts4PUXHYksFMCJ6c2iiAlhpglomVJslHYr
         /cIvA6NZc8JbS9YD/BzD6l4gZsFo27DnbMjVxZ+WrP4sCWzwQ7qJFrUheADLvxDLjZa3
         8O6w==
X-Forwarded-Encrypted: i=1; AJvYcCUnzWFo/TqLxlClKjCYrSpc+Yd5wOsKDRUe/WWcuOegFE+LCQsObZNpPG6o37Oje0AierSLxo72dSDUMRGk6K/e@vger.kernel.org, AJvYcCV/XQ9AtiXfT0ZLMCXRkGeZcSTsXDc3ZP+7k276BOG2mEoV3Pb7Dt+vFUE4dLQ63ljaMjmI1dKEzjzP@vger.kernel.org, AJvYcCW/6fm2KQOgOKgZbiLnfNdQ2JmzC/M4EkYtDr4SovBHqfY3N8gncsjhAq7TvymsgYcAJ36eRNzsUBiu8w==@vger.kernel.org, AJvYcCWCDb6Rg8ER/ic/IDggvWyxyU8tvuzaNh6Cdnpt7c+B3zAVg/F1EUsX322ub9/PAvVXDEpxc/qnZJ4DyZ3+Uq8=@vger.kernel.org, AJvYcCWv9BD4B6OsA9GQEDk4uGSG2gN1d52sgMKoJIJ9emVajKYp0IGSAFpGXQjSYjuFj/YASlaG1Fq3IXsHvGxR@vger.kernel.org, AJvYcCXBBj3TVFC3Z0iuDv48gqFOLDYlJtxwlBA9TvTHfglIu93uVNcAB0Xwk4asD5eQUWlnUP6pzmE4LyIi@vger.kernel.org, AJvYcCXvao82+JIvZUrXVTXbTaSSAx6jWb88dRueXqQg7QarbzepiFciJkHexZwvXrofMHA29W7OYIAN@vger.kernel.org
X-Gm-Message-State: AOJu0YymZhH9uJH5jpNyTbwyapR/jV0jjlN15SjL0b0H0qtmNx6x0OV9
	hOiUk6IWcf3JYnJjiZn8ZlBosXw2QcVe8Z++HrHMdZriJiznneOYm2md
X-Gm-Gg: ASbGncu6ADcN3GGZaqpZOURKFUXqns1s3MFRdVUysJjkwL10fViYvf2Fzizw0e+iEWF
	xKkCpWcI9FqtZJHfE08Y30LmpGSwSx19aGW4Ei2ops1Tc6cHG5CHOaFoUTviVipcl9e44rCXfTy
	mb091ccXN/LPIw91fVb0izInTlTlcQz1rF6ZBnfhoaZMHwHnqSGJvzD7FY65o2Z5+JJm+jm/Uxp
	pgE0OVgRnEkf4kl+KKMfJG/lAbGB71nuFgDS53fFvCqXZVvCsNI5mCR/4k1ombb1zqrrUei91e/
	KvCWg13rCALRid++sJu7OLO/+HjQ1prXttfDDTBQ1A2IQrV90rBw6N5/BsTYR64Iv0You4SkUfU
	rogxpcC5wGdX29E3IVE7Q5WAOnFtaewWJNBApYPkDYG9N8T8eZ6llOxtbIA==
X-Google-Smtp-Source: AGHT+IFCym+xBGoaFaMTBAc6u039EKWRGAB/Yd6+c7XI6q8JLxZTaP4UxwS5DlA2tuk9iufaO/epKQ==
X-Received: by 2002:a05:6e02:b42:b0:3de:2102:f1d8 with SMTP id e9e14a558f8ab-3e244019ab8mr53662575ab.18.1752161508131;
        Thu, 10 Jul 2025 08:31:48 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:47 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:10 -0400
Subject: [PATCH 07/17] rust: device: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-7-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=1137;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=lKArFG3jk79KbI1Ip2d9VIpBoj3sVr8YWgzpzTTR72M=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAzd5arAmJGDCeVxbMUwisyHuguGLVYd1t94JvFxCxzK/cekAHr5Rtjw+6FA4xzDvfKhCkirXSB
 JiQdbWuO4ygU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/device.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index b34173536230..ff300e1d014b 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -11,8 +11,6 @@
 };
 use core::{marker::PhantomData, ptr};
 
-#[cfg(CONFIG_PRINTK)]
-use crate::c_str;
 use crate::str::CStrExt as _;
 
 /// A reference-counted device.
@@ -198,7 +196,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             bindings::_dev_printk(
                 klevel.as_ptr().cast::<crate::ffi::c_char>(),
                 self.as_raw(),
-                c_str!("%pA").as_char_ptr(),
+                c"%pA".as_char_ptr(),
                 core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
             )
         };

-- 
2.50.0



Return-Path: <linux-kselftest+bounces-36990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E883B006E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F49916A486
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C96279791;
	Thu, 10 Jul 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNn17M+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C556278761;
	Thu, 10 Jul 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161504; cv=none; b=k7CCcRBG+jXUuDEa4/cwaos5bsdYursfI5JD8FwzxssLPfV5J9q6D9nxWKrFfb2sYls7AyPsyzi9drEy7QOuBk2U8MfQPJ0k68Qzkp0HTUHYTAIegg5IPs5mX8jPMhAdfalLGaKa8UuU3pcjxT67RX948Wq3dBztQb1pCya2bGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161504; c=relaxed/simple;
	bh=hq6DDcaya80h1WPZeZ2fcDK/88nl92ydlSKTms9sp+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D/wIAf3bEoF4KABRqIX8u2DRSqmssVu5Z3zDqiYV35G+jRtkXHaajeuQgrYglrnDUy8+Mbmn9XSbMcRmw3LepXMDNZz9MQuSHDBp0D6zaISXuRVu3DPGEfqmd6cTML343se3Nx/m9mASTaSP+mEjpQ6wPmnRSrxtuMIgo35mnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNn17M+q; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6face367320so10035596d6.3;
        Thu, 10 Jul 2025 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161502; x=1752766302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jwny/YDMsp6Uti9L9noK3c3durn05YOXlAE+7kmbbsk=;
        b=MNn17M+qWQSR/jcuCIr7El2zAxAsmoUtFtEJ63ZWnvs8TYEbyYGfp+jkR7zHKE1JSV
         X+KaikLSgJM9UNC+/KUv6m0foELRGSpNhYabFMKvEvoc81l4toKQz+UI72t/uPFkHKJl
         gJn9zOd9emHEo6ZL/ZWNtmy2wXLi5ce6NdrEIZLX3Nk3zTGbEFOJjK8K8i4MNY1XJNvQ
         oikj4lv23JAzJUV0uUFQRJhwvVMpBNCTv6FGP5GBVV1GIjo/CKrzCU0xfxyZXcjYHNWs
         51zKU/PtzL28urV2Xwumzo85c9fTWmSM2hU2tl1FvkR5uZPxclUyJ1bbSbMWpj23nBWf
         HIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161502; x=1752766302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwny/YDMsp6Uti9L9noK3c3durn05YOXlAE+7kmbbsk=;
        b=fNrE0fhBIeYgywH/M9LI+zI3xzIyvtf25DBvFwaT+8b7+9EJEuRmudRQCnhdGl1jf1
         15eioyBAIrIdBA2zCzfNSzg5eRI0JqO4ktikPAg2c8+voIH6R9x1tXtl++9FH/P8nzOu
         GzpWjvDfKRWKrcDwIhurLhothsvgiNk5Bu/RJcNWLNZJEVtMqWq1SjNF+q+S97GSh6ZR
         qRCU087rJNhTGak2VhxXwecXl8WIo3bHtY2NlPy/QZO6DbbWegS1N/VAUZYmlXf4/0or
         WjlpG11ob0KIU1+sIKbX/CIgRo5/Olahax82nWa0Wt1pquWNyL2P4Jqn5TEqT+H2/MQQ
         gRzw==
X-Forwarded-Encrypted: i=1; AJvYcCU1VTwWB8TOW99gwYXh28NyxHTqMP4tGgkhm0t/lWGfXDJf1W0GnZIpRI6q9i+0TScH5f5nYi0l5Hmn@vger.kernel.org, AJvYcCUUUtzmWjPhZxvaAkF4Kv48+ew/ZI41SgZWxv2NdFkTDa4sQYvN/3CnG3KvG2jXcFwJ7vL+237Fc5QnLAj1@vger.kernel.org, AJvYcCUhOGSAxbj5pMj6RoQU0rG3o1rW2rD0hsxAjpiezxa+j0Ji9W5qrJarlDulx8sLWC7gm0PuyVnJRAcvX09Bnks=@vger.kernel.org, AJvYcCVBYFxXvitbhCtP29ebKjG2zaAz4LqGVE4JIbFVTkvi1YML2ZK0s1cROEFnL7/Esw6Pfa76tdoE@vger.kernel.org, AJvYcCVatYH8XJujtblFedPd3OzmyBpDegion8rqTJvwdzGohZZfd9NoxPui3acI2L3Ikl6MwJVzjJhl62w0@vger.kernel.org, AJvYcCX7ko+3a/n+5gpRfDrY5wXXboKzv0aee2UvjglMIJsTaXPtdh5u5IQSfLO74acbQaZWZBYs2aqFXb4CKQ==@vger.kernel.org, AJvYcCXUqs9LTfaHIy4cgFTQlZte02sX/yVJrrulESVvwpgQ4ZHOG6H9k/jp11qD4ZhUt+uEi4Mts+98pAxski5qVMCs@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSEGwfbl06kRLf0HP3qz49gpgrQpq5NPe5DZSkILeVAxYr47E
	E2o8tR67E1Uqt2E60u475qszH8inqpPnz49PqKHAA+qqeh3Abi0Dt8KcPkerZfQ3ONdtFQ==
X-Gm-Gg: ASbGnctnGpTnt4XLOWjiFFz9693QSOGNbn9bBp0uQbpYobg/qL7QTqkjbY+8yGJcDEK
	epK5zSPQV0ud3m9oT5YbKrK8WcyYyEgZsZGrqvkE2CCZ5MqpvjGR1Tf5RY2QEZpwrbFxlhMWKj4
	scQPbFZIpQtpPLLexgP+oA4rDSn4/CBzMIq74zFUHrUqBgI9CbnfL/aMtjJLMGfMyVVGWLAztBs
	4b/CzgmpO1lXTBOrtM8ne3d9xMSfyMvA1YbwMfE5SPTPM87u/GCiBEz+kznnxVCkWnHMnO5qfQS
	87eoDX/vfo9EwaPtHoBd5z/3HgeFookjGW/B1azIt1Hwxwr81WG43rYFAKefga7gW6TdJeJQVtx
	EhwPD/QOWCsD8PGd8TnrA3hypWvPYE0y82lJ3atlON+5dx2OsoCUw7EzX8A==
X-Google-Smtp-Source: AGHT+IH7OAFO4MBtcOae4A7Ufmd/gVO0MGsqsoI+qUvq0KaZNdtURjl40SFBRWgfYeNbvdb036U2Lw==
X-Received: by 2002:a05:6214:3382:b0:704:7dfc:f56e with SMTP id 6a1803df08f44-70494f4b3fbmr68970736d6.18.1752161501839;
        Thu, 10 Jul 2025 08:31:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:31:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:07 -0400
Subject: [PATCH 04/17] rust: clk: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-core-cstr-cstrings-v1-4-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161489; l=1647;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=hq6DDcaya80h1WPZeZ2fcDK/88nl92ydlSKTms9sp+U=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJ9/Zze0YHCWW3FvdYU/EkNUZX2HriURvSzn4pTjOzAXH73w74+FqJhMSmpj2ynoVkrRw20pPDF
 ulFzacsKb2A8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/clk.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index 34a19bc99990..fb0f259cf231 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -100,13 +100,12 @@ mod common_clk {
     /// The following example demonstrates how to obtain and configure a clock for a device.
     ///
     /// ```
-    /// use kernel::c_str;
     /// use kernel::clk::{Clk, Hertz};
     /// use kernel::device::Device;
     /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = Clk::get(dev, Some(c_str!("apb_clk")))?;
+    ///     let clk = Clk::get(dev, Some(c"apb_clk"))?;
     ///
     ///     clk.prepare_enable()?;
     ///
@@ -272,13 +271,12 @@ fn drop(&mut self) {
     /// device. The code functions correctly whether or not the clock is available.
     ///
     /// ```
-    /// use kernel::c_str;
     /// use kernel::clk::{OptionalClk, Hertz};
     /// use kernel::device::Device;
     /// use kernel::error::Result;
     ///
     /// fn configure_clk(dev: &Device) -> Result {
-    ///     let clk = OptionalClk::get(dev, Some(c_str!("apb_clk")))?;
+    ///     let clk = OptionalClk::get(dev, Some(c"apb_clk"))?;
     ///
     ///     clk.prepare_enable()?;
     ///

-- 
2.50.0



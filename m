Return-Path: <linux-kselftest+bounces-36862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D9DAFF25A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA9E54498B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FB0264FB3;
	Wed,  9 Jul 2025 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERLLVgX2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1240262D27;
	Wed,  9 Jul 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091149; cv=none; b=pWb99suvsdaJFQd0p35Y2EcWaaX4OW4XxPyMhdMtOWCeTx7e4CcRFxFi2xQotugHmHwzWk6wt8ORMPhSVMTZLMrT08JjhVbhWUU6UuaSGG9TIChnIL8W1HJYTIsq3uKcwUfivCQkZ7AGm9VzxpyWAxyrLqbvft6iB+yq/ufFBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091149; c=relaxed/simple;
	bh=/htbXMuPqM3udNl22VLfwXmvEucPDAQBS9Vh2/hL3Ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KA8ym3/Y5qTETMWrDssa59hffDaWUjJ8Tc7zyWHuCJ4g+Oj6cTedtpZ9jrIAIOeu/HrYtrd+44/UEYtG5sHkMWOUcAzofSkPUYtkVZzqiNhePmT0gdChn+AF0Z1pFAbfTEm0VswwUwm1MZ6qIhGjAAGKx63iwO3hdMCfvSSsh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERLLVgX2; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a43afb04a7so2634881cf.0;
        Wed, 09 Jul 2025 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091147; x=1752695947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iar6CZEb07Sg4moByjCthjTFBa1u8uyvo2c3wz4q2/A=;
        b=ERLLVgX255Ck8zY0cnFY8iKGp/xDqgu29GDTownoyo0LPXEY3Q3sy665qXHkUuvrBi
         uUIevVOCsj09KzaAwlWLOxDqsPAfp7xezCrdoz30Yit1VTG92Yqt2Hi4t9H55cDQfWhx
         iWHgfiJOMcdJZHzttTXslIjmkVQCwRiyGIRfqtWIJKc6CJVmPKykrR1S9pl85pa5i2xy
         /bFa+OKdt0P4301MVUQIVxC3LOftQOiCM6tdzlOgA3qDmYEnbvWtorn3qOfL6cRWLMlo
         x2GgpO5OYmO+Aj+9HvDMvwriTEUFSp7UKtvLXI+/VDqYlw/6VZ88b/IMo3o4t9c578z4
         BWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091147; x=1752695947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iar6CZEb07Sg4moByjCthjTFBa1u8uyvo2c3wz4q2/A=;
        b=PXmph2sgr6CsL4YZyDs4J7sxUHscugG7r/2VgNHbKdWciDxxm9wY2yJii6pVRGyWV+
         c4ZejiO2vuwUPWrLhe8mJ88FWYjwCPEU+VoXHLLDkM7osA3Mw98AWTGAa1kvgA7IDHnD
         Ld3Djp+K53QErzt6/2jvjNXbPL/Ip/wZ8dsUK7QzZqWXNTknoVzLvNr4m/FOvAsg8h43
         vrM6iQau+GPAKSFL8EM1Zf8OSZwgdXP7B69gi07obDjnG+VbseyJUvSKM6G7J3D92/ec
         5WD/nr7VmM69RY5dGB+CRZ3yWWaEPH47BCdOCA/m+2PSpSgus06iZLEPEVbl81lgGYoQ
         qpVw==
X-Forwarded-Encrypted: i=1; AJvYcCURlvut9PV+nRO6XpdsuDfc5RsNAvSuTejbRc5tN0Y7jj79YJpa5pQcX9M54ZIo74iGGajUZDSO9VDNqWw2@vger.kernel.org, AJvYcCUdZeDQGFc/jUrFowOoXMRPCQDX68xjGgSgqkFsGQ3s5rgBwe507eXN92bJyc3Y2vrqNynJdUBo@vger.kernel.org, AJvYcCVm1z8JLzoRfKufCoa3/Xl2mGmNy1dTzGvq9nbdicT+c5FB51rUgqDjCQ7yN85ULuBahU/4EaZPMdAx7cS8zjA=@vger.kernel.org, AJvYcCW6a8omZ4ARHXlEnnxQPUCR+C4PJ/tYTejpJ8fKLSgtNc1kCXyhv87OuLKaWLNwK5R5rou+SEVLmz0=@vger.kernel.org, AJvYcCW8rIFsEuMqXLs0U3+bEE9NQKWZWfDRq4sx9o/riJN/4IavqeOc+eYerS3a03Pweja3RoNp5+/pe12z@vger.kernel.org, AJvYcCWCxX4TFDK9YZNqXRSGwNcnRJ+q48Q74R2sKvsyRbkIWwNDlCz0DbQoijdQLJOpEFMw+W37R3oxpWTFUMYX19Xw@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKFJMmZ1/c3FFTmdusaY/cJo+mrE9tO3gEY+GtiF7dKa2WMW+
	T+GPtxk81QgRutD4HLew8/BN0401qOH/YeeDIOXqqHJZe5QO2SkK+MFa
X-Gm-Gg: ASbGncva+RvTNJI/njrOtnsEi3LnrELNP5zMYZUuMWsyAGe0g119bzrBBA3sPemMVRZ
	w8kK/nhgY6px0UKo2LluNLwYzpm2I8OUcPkhWrMCO3w7SfM3gPsx4LfOUZAQJVBz4Ydgsi/NGpn
	REdPGKw4lDZRooXZSTomLAiTgniiJ3+9sBwtB/A/pp2Qifa/xYug6zd6imYY2IhA18ZC3yMoKQt
	k0uawnD63Hx+NIH84def6f7OGoy9nXNdvFvp/FXCeZ66+gMx9B3bwsb+5+bD14/5UDPe5yJGYee
	n94OTbGI9GVtbRalsXpM5/AF0tLaa1/VFVI27qJXwvqFbei3XGypqmoYb4JpHqduaR8d6k9nzfG
	uJJRhOrHnWj9mFuy2PQf9iVC6Ap+yIE8RfrOm88diFXv3wCAr3JWdhPHSvA==
X-Google-Smtp-Source: AGHT+IHhr7S62p3GeKqSfvS1C/Frohg226ZNlEil0nItGfMOTEFEoSiMlBSg6VeylA85PxOXjmoL9w==
X-Received: by 2002:ac8:7fcd:0:b0:4a9:ae5a:e8a6 with SMTP id d75a77b69052e-4a9ded59946mr60608561cf.47.1752091146662;
        Wed, 09 Jul 2025 12:59:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:56 -0400
Subject: [PATCH 06/10] rust: firmware: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-6-fd793b3e58a2@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=1046;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=/htbXMuPqM3udNl22VLfwXmvEucPDAQBS9Vh2/hL3Ns=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDb3TIbXnNLqkMJ0gYRyWSVF1X274n1waPRoERpZzJNKDLlYkuxge9P2g93d6SplCz6NiTFiObC
 St+mKIg7fLgU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/firmware.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index be684e860ed2..ca00aa2b4d85 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -291,7 +291,7 @@ const fn push_module_name(self) -> Self {
         let module_name = this.module_name;
 
         if !this.module_name.is_empty() {
-            this = this.push_internal(module_name.as_bytes_with_nul());
+            this = this.push_internal(module_name.to_bytes_with_nul());
 
             if N != 0 {
                 // Re-use the space taken by the NULL terminator and swap it with the '.' separator.

-- 
2.50.0



Return-Path: <linux-kselftest+bounces-37664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B3B0B27B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4173BEA13
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79EA28C02D;
	Sat, 19 Jul 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4pDGIYg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CC28BA83;
	Sat, 19 Jul 2025 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964964; cv=none; b=RTuL+uxhRrmPUwEmZFf6QnY2MNjaZHRUUi4JomtR+78KtwJaglvABSSLMcShHcp30YWOwBHRbtX6uJs6sR42Zppssx3+/1Elewbb8ScBsCVvuWJd+CNi3B94eT4XKZRDj6gFnN3jkCec2zzBFpaaiIRa3so77CsVvqaGuJwMkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964964; c=relaxed/simple;
	bh=C2RoA1DYRtxUsK+7WCxXFFASB83Bj0hUEk4zZrYldtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDaI9eDgQlDzimMdahnpaWeVUGI4KBvv1izxWbi4laP0k30qEAmMlvUzRV+S3QskWQXlnFC1ZHeKTt5H5+7MT75L28xhApSoWxG8G5Eq/vLGaoLC45xLStJCdRtClZvuSow/LTXaFeYwcxyMc+r1GbgkOLwuqzeqljFBBeIqk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4pDGIYg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab53fce526so47605181cf.2;
        Sat, 19 Jul 2025 15:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964961; x=1753569761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeEHIXOtH2ncLF22HE0YpS44+Upp0FbsPcW0YSpVKLs=;
        b=I4pDGIYgE0BrFJ6KHp5ONrF7tana0w6CEeHlfANo04yhB1cfKbZW9KRub6D1D15O6B
         fjnaK7hngGOTU4YhpYwFVoyA+2MywsiDl/LLUyUyhR8DbjL0q8liSIHb7KXZds5VhBpt
         ua+p7jHULavbTia6g9sgeTmW+ANNG0yuBKVPcl+JUhA0m5Uk1UMbMLQkQmKSNKEOm+zW
         ZW83PcEb2/GwDtiVE5AITMVhxk6v6SOeAczYcb8zTX+TmcctwpYj8wlVWJ8Po6TMyOsG
         07ub30VYJzLCWfvei8qNkfrmgTQOP2akriD3gbmPkB4HwM3fWkM/yyx1yZ6C7nRvYlAN
         fwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964961; x=1753569761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeEHIXOtH2ncLF22HE0YpS44+Upp0FbsPcW0YSpVKLs=;
        b=iYKvr1/B2hk1zB+WmVfF5Y2HhdlhE821jJNBl/1DeV4XWmKiNVxdFIuBHqMTOufyH9
         yF2qAroTCcAewm35zloTnQGNzvSDaHM+ENjr7A90m7kHnTJcC+BWxK6GoesJGBrvdaxY
         rYn77CH2cg+hTj1ZNhBNzlol+5c+grzMsuo3sZ2jRoxPAYv9vjK7mwN6Roxyzz5BvTt6
         5fX7nho0yblQy6l4/xjzFgk85Eyli4ROrUf59VMHzpNc4ZkKzF6ZolCAmFvyKuoB7GjS
         ihdEvWTb7Oke+Wl8K9Tl44CKODQGj+TETt/DhsnYf8rAPTya5gwfOYGe+AGEDzI0jQHl
         sVsA==
X-Forwarded-Encrypted: i=1; AJvYcCUWu8C+r1ILOrOXk0LI9ZqnlSJ+aYadRb0dGoat4rwCx2LQY789b8E6NZ+YDj5dckze4zTKVr0ywmizuLProEc=@vger.kernel.org, AJvYcCUzoUJF+yI4nM9/plbxbJFrUi/tmfx/EhcaU+AZzUxgp01KXAsqZwqyJEMxJ/E492jTMRuERlkW@vger.kernel.org, AJvYcCVGURfCqNaFUOctfELHNKjYbXLfpUr8UTAh9gy1HRsENmu0mQCqJKHUrnKEsEcbreNq5R3enJBAY/c=@vger.kernel.org, AJvYcCWpDE4ayaOGeSuCs/HlgBS+qqsj1bTNhPZj8DrImBYclpPMOHsNfFKnl2NcmpbMT2z9VChomjNhGb4hvLyv@vger.kernel.org, AJvYcCXUnQpsCzpf5lqs1zMOlWj6+HU+ZpLf8jb7Mb1JkiOP/pN3+TEIKiXa18qLI7Psph693KIc7ePUDK24YEsfKCub@vger.kernel.org, AJvYcCXxtDFeRhgzRg6ExlDlVgc/TNvrswszn/DEwf8QNePHpXJrhMt0YTXBgwr9IItqnU7QEeTgbLMFIC8T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Zr9rzdYPe2MuFaGSZfULEGjiHuQHACTJnhoANNJSK6XhcZVy
	EgRC4I0Ww3IXWA/HyDBia8cBQr2DIRIxVIyLd2+lKBItWV9gYXihBy91
X-Gm-Gg: ASbGnctAjAdEw+sGYhfP3Zt00QXQJipfEtj5QKHoHWnb1CqbylnChn4K3NME42Z29R0
	MnIz9qHDbjKfuZC/nAXj62vRnzUqfO+sf9OS2Qf0g4S4ZKp6cv5Y54fJa7C7e+FoO10aRrci7ly
	3AsViikALDGvvNT+RYBZMB3NHGWSQUx3t+cOqN7FLRdtidyyu/dKxSkBH7jZvT8RPRQ9pmP4hc1
	oUxkI+cAzeJnr5QJ8utbGUX/wdmc1P4vToBH9J6cToRvfv7epFDfkBO6vdWfsc8SDfQhB414K+2
	XqwIUvkqplhsBUu8QfgnXzFEDstSjBlNyjCwv2PEgnobSCLxU6TN0oUbeYc6ggOL3F8lKuRaqge
	ldOmkLD21LLaT/FGx1BwWPUThKACu8MYwddMzuhyd0rdO8gwHKiRzxUFsetAkfkZy37nxGNRDgK
	kCawdMLOBcjgVHGMtMEKzt1DlePjt4
X-Google-Smtp-Source: AGHT+IF2PYh8zx8Jfn+WqSRkgzvcMsRj/r02AxZBLfN/d2WuVA0PvKOvK3qRe/MPq3QXtlxLasEHCw==
X-Received: by 2002:ac8:7dc8:0:b0:4ab:a8d0:a244 with SMTP id d75a77b69052e-4aba8d0af42mr148999311cf.6.1752964961499;
        Sat, 19 Jul 2025 15:42:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:40 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:31 -0400
Subject: [PATCH v2 02/10] rust: auxiliary: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-2-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=1235;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=C2RoA1DYRtxUsK+7WCxXFFASB83Bj0hUEk4zZrYldtY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCLcLgD4dL6x0zBz6Jg+8AmnF0edNVa7Kb18ObpM0PwVmNfeWR0fPny8j2hSdBW2trJMt4LD7tj
 4wnszhfhnwgw=
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
index d2cfe1eeefb6..89d961407adb 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -111,8 +111,8 @@ macro_rules! module_auxiliary_driver {
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



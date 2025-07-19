Return-Path: <linux-kselftest+bounces-37668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF76B0B28C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E650717F54C
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68F28D8E8;
	Sat, 19 Jul 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+0eRbnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB804288C22;
	Sat, 19 Jul 2025 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964972; cv=none; b=gx45QxtrHZGR5s4EoRlhrGdCyI2pgXKYCXAuJ256EvEclDP8IuAAaWyVSePaSSLkZ8QaBn9RsjyWza/OSetMhLZdxIO30GOyxB1SFy727wu/AvlVPKoP9rQtdOVhKf2zH5m15fXSYpPKaTk8hHHOW4tKGORoWOVUNotPlGw1kNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964972; c=relaxed/simple;
	bh=eJzxwo6+dOxZLnVsYJ7KLApzPh+yuXrFuqz7GoEm5V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9XzP+hRUUqOxgUzRDgE3mVWz+x1tk2IIZHNkbnTQDAJgmGgQf/39Dhh0QPM8m30AepflTpSmEjwKYIU4+M4hm2gKNm1inh8+fXMalK3uUhfbI/6xsoVHWZIcDruL0DRJFZGMMmPgpdoWwibnGGRYjvTO2D0osk6XmSGlMIcbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+0eRbnO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab92d06ddeso47472151cf.3;
        Sat, 19 Jul 2025 15:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964969; x=1753569769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shIOPZHNE3YOj8YEFGq9npDcc3SRxzlV4M7LnlpOpn8=;
        b=b+0eRbnODBBcaPEpQa2vI+VGbKOusTtgtzzvV43T2j2nHlZcg27eyh66/kCdSt8+8x
         j2JpEWNJZUe4E7+zHjUfgFyKYRKFblKPKbr9me1g6iSShLyvV3CKGfacimZmogrP6MpN
         NK6A7GdAvCBLuG/RMwjFJrNR6BTjZLWM3HKNY5xyRDVpu2g2PBb5Nw4XZO+0ro0hI+3b
         XE81Vg9bA5pouojcbj61qiCfe52v3bYHEGAI+XVvbGU9aEBipldmuPzvFdaRqc6hK5WT
         1U9UtOftnhv8SmESvWnORl3MOjjE51sZfmpzJmEqPjb7fCof9RLqXOgY11fqVAPzKItg
         i4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964969; x=1753569769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shIOPZHNE3YOj8YEFGq9npDcc3SRxzlV4M7LnlpOpn8=;
        b=WCjhnaFdnCxrU5M7qhEAEKsk2x+Kb9l10O+hvRXtw8dFlpVzheYvwyFdGfCWeLUyII
         aBSNsMRybU3Xuv+FzEbWqJDw0pvWJUBlYDVj6BfF05jyJDEAdmOMWpIV5LWKTJbyRYm2
         gGD7TGFAoIQ6V8WDhdhwpkHXWXw88CCqijv7PpSm+GZJRLEWj1d37GvAnmvAnM63cPfd
         E6BGVVGmMW8CdMdskKccKQSp5o1r0bfirbZXNLL6GdisZN/UkeYNZozxkyCimuJoATJ4
         Zku0SxXR5WZUVTI3c5BIIlwn7YZ81Dm6Huq/sIunxNaXHCYKGyZsrwxWoHnhy0fhIKDQ
         SYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf0dXa5PDJQdqftJzXQxNb4aI8aqq9KYtR9gkYzDp6xuCasKDiI9mrJxyoKlm+X2CGurhlFIenkqhT@vger.kernel.org, AJvYcCVphcWczGxxLp0ZbIXdzOIysPmdmCsTZX/oDmyhXpqs7wX9OR5H2b9R26FuauWEPcwMsXdzowGf@vger.kernel.org, AJvYcCWTDCDZfG1G59JE0mpGXKQBSoYd34iDJJ7+H+8BWj/gR8dJQafCPgC80AragX+0bF0PRvPniXHfQrU=@vger.kernel.org, AJvYcCWijw8OYljYHp/VWREvU5UnEOdP2tYuKvN4DuX+fjsqSdmTRU2drLFqFDEan2Mp68c7fKSazRr1W3gmccUQ@vger.kernel.org, AJvYcCXl9VcVPOsoP7nogB6wsgk5V/xrh9hamPBb2dNLUsLM5z9XSYzcfh5lodxtu8DgmK2EJew62zf/nsd9XrCBYDE=@vger.kernel.org, AJvYcCXrwRub0mGbLSqY2qlCItsY7sIbwXh0Gpz19KSNpEzf737kTKsXp/4WeqfdfdmpdEAAO3GY4jq0erT6aqNx/5XL@vger.kernel.org
X-Gm-Message-State: AOJu0YweuYzp4FENECM/IdSVh+i7ETlpzL0+M7uETb9bMSg/LbN4qv70
	Iac1WByvNhx8m5psyuTGZyn1ZqyReglif5+pwkGGgcI0EDLETx32Q5hs
X-Gm-Gg: ASbGncviaopNqeJ0157B0pZtSjff9fJGq1b4Pc+aOhM/xorkit8ArwiLYkHPUbEXDcr
	zEK360iCn2fW5O+u/GcKkkVB6dbrgVaXOL/evrkcCs+2+6IaghtvP/R/XBPJD1VOw6heqI2//5V
	87kMa7z3dU+1k3XayLgFRKxCJKaBECRTXfItXR1vbtWydi4T7v/n2pDTQKEOgZB/yjjBAbkv+wl
	MNU6M9wx+ragmrtNJL68/FRsEhL4JRH+q9TGjFsDmgNNOIxMHxbqAgWRkEQVpzWWmzFhxAHN6Mt
	9YHetKRDv6R6WkJ+sHp0/1STG57skaOSqHyTbWGOaZQ88RCz/fT5vsBpG9R2qtiN0oHiTzoOen9
	XC+zsXW1lx0p8EtiZXySuDA0uFaqiwZM1bS+ECodh7/3zFWf0fYAw6uaBqACv38ZyyRXTmzlZlZ
	yFmv4drRLBAHM3ga26aqdViofOOE1K
X-Google-Smtp-Source: AGHT+IEGo/MTvkIry259WaVh/tw9rDFQDiRK5HBiJnLYSAsembv5QYNewH86zQneZbtR/Kc+tN9uQQ==
X-Received: by 2002:ac8:5888:0:b0:4ab:8692:408e with SMTP id d75a77b69052e-4ab93d8db2cmr238698361cf.25.1752964969436;
        Sat, 19 Jul 2025 15:42:49 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b1f1d5sm23671841cf.50.2025.07.19.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:48 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 19 Jul 2025 18:42:35 -0400
Subject: [PATCH v2 06/10] rust: firmware: use `core::ffi::CStr` method
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250719-core-cstr-fanout-1-v2-6-e1cb53f6d233@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964955; l=1139;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=eJzxwo6+dOxZLnVsYJ7KLApzPh+yuXrFuqz7GoEm5V8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP1e6JGRPX2Yn2Vgs8WZJjmjU+81WfzK4lKb2id8EqsgtG1MZLLxYbdgmtODlw4OTWKcgMCQa+x
 S01m6sOBO/Aw=
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
2.50.1



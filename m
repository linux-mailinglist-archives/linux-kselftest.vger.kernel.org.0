Return-Path: <linux-kselftest+bounces-36861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31AAFF251
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395305A7CD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10B25F986;
	Wed,  9 Jul 2025 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbx2pJ83"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3725BF18;
	Wed,  9 Jul 2025 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091147; cv=none; b=XrjoADHAyjEAueWv5utg/7fYEFa7ToI+4sjHzRBCkttdSi4Pr0N7uyxqIGDNZh7swCkEF+1KdaZUEHyoTgfIYX6+GNGJJBhCjBygQZLJAb9IzuJArBvHPM3rwFaAuE+oudZ65LIhzdnxgYaMaD7WSgTldcNsxbFeghLugHGNmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091147; c=relaxed/simple;
	bh=aLYXykvEFDAvQVjjQ9rlBaXRy7vjxZdWC+vGw2wqK9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6lHpS9b3dbrVwEovimh69Pm8M3ekfjHSg1tz5dFPfwVR1GA5kH/xoeefTPLLIMOYpRNfLpPOfpPntIN8Fievl7o14oY3IGOAfg7xVf1E7ioKdAhj4dPr+PyCyzV6ZX3BYaTlLJUFW0sOvWTWU82jLNJiMPk7/gSCB3Mcipt5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbx2pJ83; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a43972dcd7so3120631cf.3;
        Wed, 09 Jul 2025 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091145; x=1752695945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6zoAU+3+NRGYowRJHpIYpTMUTkd2sUwwkSZRyZYqF4=;
        b=Dbx2pJ832N0eczeMWY7g5Qr8+YWJ4fak1P21OEe+v7n78BDLRw3AtHv7IJk34rX/I7
         /Sjk5GXf9r51c0H0slQU3XYr8dJboVUBfULj2x/DEN7SbWgqLFx/qukxGQ9zK7bOJ0jd
         eTCBGV9xpIEckf0L0N4hcb2MuR+EKorta/Ob++tjr3f+b/neyXEJd5louSnJtzHK7Gn0
         J9Qe/LsNPxwNbuBUjth+2AlF9AN7gYNTc+xDe0UjZsS57KFq0cbpMxwgADyUNAfWkSJY
         Edz9NPr4A9Q4XVKry0Rsu7xjsPbfmpBtrNltlLujDV8zb5L79UZmrwpJgPOT4CDc74Cc
         pSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091145; x=1752695945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6zoAU+3+NRGYowRJHpIYpTMUTkd2sUwwkSZRyZYqF4=;
        b=m46A66s0H7il1BlfpeL1litIRaq+iLbh9l/iWdhi+ChHzqFNj6nH+c75j09Zt08NR3
         OwOIBPJ16sqyOIM/86IYDgit+EoGuA+CD4+E8mcOGxOu4W6Pk9o3+MRsMX13QlZGXfOo
         9YlO/JhhtdiXVU57o5uNO07mRCrJWmL+cKU6SXwX0a142PeWHu98vDTFW5vhrGTMtYWW
         Lviqlnxgo68HWUmRkQoV74M6mOZRXPnjvVr1NuH2Mx0MzatnbE1qtEbAnPMHs+y+IVy0
         CSDu1Uvlzh8xOtnUZXvJGHd5Mgt0xc56R0eIUhH+uFkeHHcLgOs14GUgXwaUHe+5Cq1f
         eMaA==
X-Forwarded-Encrypted: i=1; AJvYcCUF1T+EVH6WxhMOGET8JfFM3gqchL3amTuFOCzBbA/ceXA1qONUSYqP1r/lpxPK0DvPtyKHtAiqkZc9@vger.kernel.org, AJvYcCUREk5GFKqII1KQQfSiNnYOqDp2wC5wDi43Y1WRA76foJKHuQkv7eKYmMfbbMSMDHOZvFxOZwWNN7E=@vger.kernel.org, AJvYcCUxLas+Ku4M/hwwhApzUdFURLVDiE6JGc98o3Wwxio9cQBYF4LbOMEeisSPAQsEkdTK3uIaM0kiYWLfXBpOxuk=@vger.kernel.org, AJvYcCWfKOjwKcoChfAhfMXd3Z/gUfJ83wXheooICDMcy8OVdKYyXCpFS1kGk1ejSlSVZJipmx+5DruHSvOjf5v+@vger.kernel.org, AJvYcCX+PdFMCUugCrqo8CqWV/M3BpAiUibFjSwSUJ6zrRvbPe9AdTeHEldt4XAZcBvUy/MSL8DirOYJQKN3KPG+KxZA@vger.kernel.org, AJvYcCXigeLTUAT7qsgqfswF2tPVekfn6RQcHXP+lUpFMoAv1HGgZNy60JgWzFBI2CcmfwTLx0/VHf/T@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjO/ppUU73dRUDMRnGA/YRTWwLLsHLlZLR3YXr4W4/LulD7e8
	7O1Q4qdPTdME4WSTtkQNvycl0Vv0o4ACIoWUQgtME1xfbecbHa05w/1F
X-Gm-Gg: ASbGnctU1I7Jqww46HTfNezpNMXIt3yKdZqaX8mJgqcBxnxJdyXDaT+gwj2wjLTFqxd
	GtqoOVPpOy8RbZnBohqr8qydgFjfOWsQxRoIMhVg5Ban2+gz3JkWIcY1+u5p0l0CEdrouyyQjEq
	BFaNnM6BTPBZWmdeNPGey0xb3xhzHaq07t61bG9cleAp08n5W6tT3bbFA3biZwsHLOz/9Xkd5JH
	dfnoTO5knwLf5vI7Rjzb2iXOzGhOtkfQZodKfPxeOhtty68tKKYlgkQxcVersGWk2MsPAsOjXjq
	H2FgO3A6zwjKQ0U6ueuniQG7yXpstJ/s/zI54lFSRBcEaMVGJivAg9I+uwpGKjclhPgOSyAH1fI
	z71BE8Z907Psb6RcTgYkU+vKJS95Sch5DYbto0rtEVzLeF4iI+iHn4pKL2NjfGcb+E2jn
X-Google-Smtp-Source: AGHT+IEHE092R70aLUuoMy8vYdq3O+lo5/x/JcZq5QkQKedPEYTGiVV/m7e75sMnKuTUMIqYUQHzag==
X-Received: by 2002:a05:622a:8c02:b0:4a9:e20f:c6c with SMTP id d75a77b69052e-4a9e20f1147mr42124791cf.18.1752091144903;
        Wed, 09 Jul 2025 12:59:04 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949faf39sm103584281cf.28.2025.07.09.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:59:04 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:58:55 -0400
Subject: [PATCH 05/10] rust: drm: use `core::ffi::CStr` method names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-core-cstr-fanout-1-v1-5-fd793b3e58a2@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091133; l=1149;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=aLYXykvEFDAvQVjjQ9rlBaXRy7vjxZdWC+vGw2wqK9g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNfUtJS4YM0EruZr6Q6jVt9BNzTkLZfHyZm3PHVUgP0rzTsZpXY4LTRXSY8JwfktuFLf5vyneCg
 OmkAUz4yhFQ0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
avoid methods that only exist on the latter.

Link: https://github.com/Rust-for-Linux/linux/issues/1075
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/drm/device.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index b7ee3c464a12..998b942b6dd8 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -83,8 +83,8 @@ impl<T: drm::Driver> Device<T> {
         major: T::INFO.major,
         minor: T::INFO.minor,
         patchlevel: T::INFO.patchlevel,
-        name: T::INFO.name.as_char_ptr().cast_mut(),
-        desc: T::INFO.desc.as_char_ptr().cast_mut(),
+        name: crate::str::as_char_ptr_in_const_context(T::INFO.name).cast_mut(),
+        desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc).cast_mut(),
 
         driver_features: drm::driver::FEAT_GEM,
         ioctls: T::IOCTLS.as_ptr(),

-- 
2.50.0



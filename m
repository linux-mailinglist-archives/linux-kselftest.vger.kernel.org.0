Return-Path: <linux-kselftest+bounces-37003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580C1B00748
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 17:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F2F483765
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ED22EAB65;
	Thu, 10 Jul 2025 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQdkpDO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33442EA490;
	Thu, 10 Jul 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161532; cv=none; b=jawckSZGJfW+bz0w7li0FQ4O15negEcWxCbNJn7CgEEdhQiYyKHIIS28H4549LTBQoIZ8rXfG/1cpCgSLWmC3StU8F6PxTyzHuIoSc9DJ19ogn+ynlFZc9nRihGNwtSEbvAor+DNUG/bpyjkt+P8EibDcW+JDyURF2PySjm7OIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161532; c=relaxed/simple;
	bh=Y04H46Vkhl20b1wCTfgyVZYYKhXv1+IODFSBq3p+QNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFLda7Syxlikg0ChsBawlz2PVMXydnwn+8/b7WoQl3hggIMZlyVGuEGSePUqIJ+tw+q73rUTvitJZFIj7RLKg319q12G/566nv9vzuYn0KWXv2+fnop4pAEe1jT33NdPqGI8TJTOYHsKYGaha5rIDCx6Mi3HLcGfjsQcOFmF4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQdkpDO7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d9e2f85b77so171073985a.2;
        Thu, 10 Jul 2025 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752161527; x=1752766327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTPDeQ3MzYVsL9l7pIRQLeK6xoOi/0dqJ+7kw94Xeno=;
        b=FQdkpDO7tL/ohueIW+kWqMuI/8hA1SNArlFh+ibvAhocpOBRDm1KMKf1+YV2uhJI0b
         fnikBj5nmCmje9Y/fs/6zy4N5io9s/qwPnA9Qgy8lH6upxJIFB/ZitNRHIf8bq/5qAoI
         31eU+MvdhgZ8nMvH5wB0yGd+4EXoq9pviZXpkGI83xnByaNfL4JtRdkiN6dqLhC+eVzf
         EJig4PXUneSuY1z6Zp+Pr07XHoP72lUjp83TdtgoURvZxtVOwrIknxp+djxzTBqsRrdS
         CtUh+govDJ8VUfKfvGEdRHlF+NIOG5dWY7APDwFStriAZo4DgQl2MI9FzcYJGHXtDjG4
         KYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752161527; x=1752766327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTPDeQ3MzYVsL9l7pIRQLeK6xoOi/0dqJ+7kw94Xeno=;
        b=SkpCD0wXaHEZmp1XoUPL+ttBM1+wkZ/fk+s4ueBEgmlGyIFdHSOthOxDRbgzWSlwp0
         mNjeGuJgG78DLU5/I3GTPgH8mESBESV8EVo/H5QW7yMA8Z4eNxyR004E5WYdp35RGCwV
         tCXNMaH44tLE5MuUJPWbYM3gf1plG2MpecULfpwXLYyK4EvTbkjOykizbDwNsKdC6uWl
         tZ9ef4d18u/WDmwBgJnzTOywfIq4yfFc9x5RBRXrKFgQni8sJkJAeA+MgDPi+zo5ZR1s
         I8nK3x7RENnPOHwS+0P6iSUcawTY87gd6f7pZ20pSvj/daEF57mvlddlIhDJBndEHHW0
         cnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg2BTGvkdjXCifRa911yugkcZYxxS7V0KBXTYS5B50f4kngaqAVIe/SBR8MFZW3murKKXZOUz5PchRQA==@vger.kernel.org, AJvYcCV9j/rso8NLm0HYIBOzPBQAAw0ThoztGfLfem5F0EqBMUcLP1Aq+rbmZFYi7frDMkYTTBoNWR7JbURm@vger.kernel.org, AJvYcCVBtvlDvMM+McXHKocOyncIB7bmLRKLl9iDtQLSXYrchFCGZg3Ojlr/0N1texXo3v9kyPkT+WFlN3tvUzLH@vger.kernel.org, AJvYcCW8k76O5QV/pb/ZE57ngRXMHTSH8/c1vEu97EpJIaqRYw08I1t89LkU2+XGetrqdtTKOEZIa+4P4e62@vger.kernel.org, AJvYcCXbndWgD/GxAvZ4HHVcpZs/h5xl3TwKLsLkeCq9fBqaHPb+TsMwfWR33CKUhJBMICDK2ZjWcPixUakHANWQILA=@vger.kernel.org, AJvYcCXkOYhHeYXb+8tcAm9BcG0ZhrkN2xG1cwZHtqqek0MtRH7E1hnHFqS5dGsUbBbfjf39+SrKfqs/0D1GAHYNkbVK@vger.kernel.org, AJvYcCXsLXKCJT5KVq928rkwgJXcm9Gwk9HVwF3R0CDRMsKKX4cQl/CzdU7/2ZiQ6dxOdjfkj/pEwlMx@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJ9YefCSD38m1DYq7VvFs7jYUMCzPTIZmCxRqvlWUnpJJ8wVx
	8K69v1zqSVcTyRpuq/nQX8w+SKhyMLrVeHhoMZ2gn5f12U7D0csPR4tu
X-Gm-Gg: ASbGncuh7CgmUClg8C8ZDvkbxJTPvhjWi8HVWU89mws/RB04jI4HMWohcxn0+fUA6Zu
	BcS/42IkzXLwI9F39V5NOq3Iw4iqVz6auTiuJUTeVyMz9tvIDE9YZpezr85Lsl5FiuZ2h0hHAc4
	Q+SBlspUvjFmhGNWy2P4LeVqtmBqSSiIAYx9/Ery7IfvTnEkC2sGtLGB3G8Hd+wGvko9CWaHjvn
	UKZff+WSed/evwoFEV+xEPMQR/MbYH9k3eIio1YuStmRgKcVhE8z4aLhEcTJkDQvLtPiU47NOJm
	RwZYo8iUxSOQservY6g57maewIYSh/Tfu0e1HSEkIfm/JuDpvqo9gz9xNazA97uS/wCQSZAAbOp
	rKyCwd0JrL22TNXJO2H0x9dtKbMiMmxaWc0IqjAhZrr0jQv4W1CaHyRQVOA==
X-Google-Smtp-Source: AGHT+IFwb1eDl83RWRgNOPiI2xnO3+DJqfkH5CNG1RfiaGeJvrTkceoGSYcx57ApRt9niHfqfPdvrw==
X-Received: by 2002:a05:620a:1726:b0:7d9:7096:4910 with SMTP id af79cd13be357-7dc999b341bmr564287385a.1.1752161527419;
        Thu, 10 Jul 2025 08:32:07 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979dbc3asm9449496d6.38.2025.07.10.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:32:07 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Jul 2025 11:31:19 -0400
Subject: [PATCH 16/17] rust: str: replace `kernel::c_str!` with C-Strings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-core-cstr-cstrings-v1-16-027420ea799e@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752161490; l=1304;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=Y04H46Vkhl20b1wCTfgyVZYYKhXv1+IODFSBq3p+QNY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN/x43LOGtGcE5XoKlHGuC7ORRj2DN1CIT42OvTRD/0MaEaE8FrNbcFi6fQDB5xIRVLz4YRHP6h
 Lk3wiyMArwww=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/str.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 61ebaacddc23..26bb3d916ba6 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -266,15 +266,14 @@ impl fmt::Display for CStr {
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
2.50.0



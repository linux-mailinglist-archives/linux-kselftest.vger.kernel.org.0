Return-Path: <linux-kselftest+bounces-33996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A60AC7E72
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 15:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2C94E7A2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963D225404;
	Thu, 29 May 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDnpq+HO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AF2253E1;
	Thu, 29 May 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524504; cv=none; b=prLl5TnWwSo4xNPZi2Dz4O/XBKtte6uKXJHAvWTL0bT8+IFPVtlKWUiczO0bFNDMx3GK+dNmLYNtqJlEXRW2Rn+qoO0FzAHNIdRAkuKhBzGYj1uEfsKBB5t+Y+LFqWWBZvBqdrJEcMmKarszfvbJfLjqPYdoFy8unmjDA63Me7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524504; c=relaxed/simple;
	bh=EfOde0Abdz8QadKeG6lhYJottsYoKJ2gdDrQmMJ3r94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZRbGYidlTmOh2eqviJ4+wnOiTm3GStKyoL8UqiFiXoWg4d1QRpcfm1woJehIseRwP7wBdKEogKv1Ys0F8mt2qnJ37Ms8IgJ5C6xBwjSR4CvaxrLTIuui/1zVL4u+VYHT9JsBHJrK8+Brk4Be+GQnqHBJPg5WNbZNG7yRZ0+uTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDnpq+HO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c59e7039eeso127474885a.2;
        Thu, 29 May 2025 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524500; x=1749129300; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ecBufqYnupmizlM2kLCzvsMQZD5WnzR2vq8To2Zhczc=;
        b=FDnpq+HO2vGcBXlBKLsr0suvowHkcmzgebU0PlpQxEDbSLSCQwFOuK/XYhateMi04b
         8Ji2+qBBdDLocb5+9GhH+RBRMyPIrPUy/SXqM6F36zN1NXHqEEGGz9fbgV2m/tpMfgyy
         v3etnqgLK1AR4wUGoxsBVTWZnh2mJnsD/nR0w4C/40+eK8++r4CEvSGDU3CNBCRHWlOc
         NrOSsuyjSNlFx7s++RygRuKlU3UCsVm4vtK/TF+6PDShiNYnWuNne3gjsmQhGRcDJcQf
         hH+snO0HOBq1GSHNT4SOU6cxqDDzsPU7m3E+6rGFXv1JuY/1IeBfPSWRmK1PHno+tTtY
         HZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524500; x=1749129300;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecBufqYnupmizlM2kLCzvsMQZD5WnzR2vq8To2Zhczc=;
        b=u4MIZqVuk9+8pf/gEEZOEnZjETNtvaFKxQND46v9O0tWNAZ3tQJmc/HPYgC/Q0bROy
         QBaMbHSnYuf+VXC74NXQd6bE+BqWyiKeA7zxpzVi88D01d81VEe+cpYLy+TXj3BTDW1n
         LA6rp1Sd9tLIkeVetnbbH2errVBab4x7q36baMTyW0KpCV8MGipQMeA14esYY80YNy3u
         F6jFFjcnuT4HI8xF2Jd0vVdlUdtktIIxDvU3Ed1bQFGC8osojQMufkrUtcSewu2JmQaW
         RUpzJYYsAYfHRu06QFCWzcNiXAif25stZwlmzEgYlkGskJo5udJQPjUgEGJt/lhcvrvM
         M4qw==
X-Forwarded-Encrypted: i=1; AJvYcCUA1omqjcpmapYdnjRifYhNeUzXe1dDnfLoqEWJJ6zKNQq99ZMUb4qyrOhRAc1QgpqJdVbNt2geu8RMhxk=@vger.kernel.org, AJvYcCX6xUKpRFqtcmdwRoaMwxFUwIF79PkY2rBm3mBet4+2TvNCJiTyubnlGtKueK4a9l4a86JHJZqnlYgU30xoGS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0qSKpbLgCgZvySFaddljsxl1cXP2I0F9LubiQbzQycc5TFEG
	bEnRNO69jcXSqfl2q2bupGp8njlYjLMEZtviTNpEl6XIuYaTFW1XBA6+
X-Gm-Gg: ASbGncvp9ON+JaQmbzEKmRKfKEI4C9/S489SUYNwrIUlnipOf8zsTerkmvsndVm7BUo
	aRJ7yjseKDaDKrVzOmI0CImvceGtaEZbwpvbnO4S80oAi56rQ45ecslL5Z1WYDwvAwtKSivc/j2
	jbwlikObN2MFQahYZWnH2Wh7nnxJ+Ppk18ruYkPlMvrO3hepXf3qPfE2FHNno9Rh6aqv/SLSRuP
	myHt5YiMngGsgt1sYunkXqlnFTMQ64k7Q3sE7ydisuHQ+K2kNlZK82xpxZb8im7j889kdaOpzH7
	aeHC6fdZDw2zxPp3Lb5gZWxPDsIda2IsCctkvxfF3LRaoM1UdjARjid8ZCOQj8pLunqx6fnUIDI
	sEZM=
X-Google-Smtp-Source: AGHT+IGB4SvHr65HATlmmpSzq0LQi85yrPN4dPLTQCKfwHgl/pK0E8snG33PCprELDwrNd4pktlQfQ==
X-Received: by 2002:a05:620a:2991:b0:7ce:d356:b8ab with SMTP id af79cd13be357-7ceecbc0cf9mr2808231285a.12.1748524500375;
        Thu, 29 May 2025 06:15:00 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:da0:d9ee:5c71:a02a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f7d96sm91528285a.30.2025.05.29.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:14:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] rust: minor idiomatic fixes to doctest generator
Date: Thu, 29 May 2025 09:14:57 -0400
Message-Id: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFdOGgC/4WNQQrCMBBFr1JmbSQTG6uuvId0kSZjM9A2kpSgl
 Nzd2Au4+fA+/Pc3SBSZEtyaDSJlThyWCurQgPVmGUmwqwxKKi216ipymM3KVtS0XqSJLQl1Nt3
 VoZTUOqjbV6Qnv3fvo6/sOa0hfvabjL/2nzGjQHFqBzmgQ6cv9j7OhqejDTP0pZQvjz/J0boAA
 AA=
X-Change-ID: 20250527-idiomatic-match-slice-26a79d100e4d
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Please see individual commit messages.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- rustfmt.
- Alice's RB.
- Add second patch to emit information in panic rather than separately
  to stderr.
- Link to v1: https://lore.kernel.org/r/20250527-idiomatic-match-slice-v1-1-34b0b1d1d58c@gmail.com

---
Tamir Duberstein (2):
      rust: replace length checks with match
      rust: emit path candidates in panic message

 scripts/rustdoc_test_gen.rs | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)
---
base-commit: 1ce98bb2bb30713ec4374ef11ead0d7d3e856766
change-id: 20250527-idiomatic-match-slice-26a79d100e4d

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



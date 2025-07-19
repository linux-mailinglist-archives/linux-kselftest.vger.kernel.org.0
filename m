Return-Path: <linux-kselftest+bounces-37653-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E88B0B243
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 00:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75203AE558
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA2221721;
	Sat, 19 Jul 2025 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3cvJ/5L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D277F477;
	Sat, 19 Jul 2025 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752964930; cv=none; b=DIFZR3tLyYR2cB72F1bPoeyAe9lytuuRZjS++qw6tg0s3CUbCrj2dkL5HRU6pPzGWgUwkQRnPZVo1ym+D4uluXLB8ruyW3MjHx4pKCwzMuJ7/Qv936w3CUaSFPhJsO5u6l/N4NR8pd9KBFgKjAHvePbYWhmGfB1LC3FOnrwGyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752964930; c=relaxed/simple;
	bh=vbgrYCnB5GbWpCXhaPw8I4u9NCR+1Fim6HSx76fv2mQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SiE/LtpssGqOi33PVsOwfw98LeL5u9mAAPliL46YYiiocGAJ3nh8dl+0ARr3ez+CIoLAUIblrWD4esb7C1vnaPmllO1Ky4lZrnNKlV3Tvve0l/zKT8U8yf7C/ENFy0vdr+gVlPb7K/GLpEW3WdDQHuiOBE3xbcEmD8Brw2gvJD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3cvJ/5L; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7dfc604107eso310397485a.2;
        Sat, 19 Jul 2025 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752964927; x=1753569727; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYtqZBE28LZ0UGLaX8MEv+0dHfoGt4V/IBm1NTd57go=;
        b=b3cvJ/5LGILbIVJWtOJn99Yd1PX+65jh6cL8rz5blkRLH+ta/Iw7tvVMNxdbrULnxr
         135sjc2+BYCsY/MIsPTnS03f+popAeuHyDo+zjcFl4B6+UtniaQOtTbr7fpIs++zvZQI
         kQIxvkeeCpuwlYn6VMZB9e4nHwrS5qmeN0yTIx2uixBK0V4GGFaZXQVoY778k5Y2pr87
         y2h5rNUs2iowYRJrG0HF0lw5x7NwdXnwl+5WVvNQdrerA6fQZwSlHLyqLbLSH8Pc2H0e
         FV0UQYUseuhnyyb/H8pqBMFUZglUlD1XaJ0xpgtp238i2bhdmsRiN9LdyuzPIVlK/R2m
         B81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752964927; x=1753569727;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYtqZBE28LZ0UGLaX8MEv+0dHfoGt4V/IBm1NTd57go=;
        b=CHyc8IvceddheY1jd3iUVVNy4etWg6pUZscMYevwGSTfaKvcfvPt+O6+bcvEu3IokU
         wLXn8BrFlnAAVOf1aLvaPXSCvzzUMlvShKTP4MRgM63PvzBdkHe0LwPZZAeswGFKssiF
         kivtoysZkm4bKSjlwodPofw8/TUYotDeaepO4uMcEGHYcUzjcZzXnh2K1p0wiw/2XxhJ
         iGuixF6GAKhm4HqdvtxkwWacKOhuL+y4JJ08+66G78c6IBXBugHOAOxN3MVb8z/wADI0
         CWQr3vSWp5zBGx+Z7Wi7YGx68wqigT6zFlArJ5e6egFMtI7O6bYcrTwe5jqYsb0gXeNn
         1m/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHmPVnB/dbcYTavuasGL5+qTK7nQ7TEtmyE4LBsvSRsjRamiXiu61TkLHxtCAItICetyExwdDK0FA/WPyJ@vger.kernel.org, AJvYcCWgpPBoJfWPLjNiO989pytNnXFkjkA4gj5LIuVMp9zna+V5fRdYswvxzZUfD/iYZtpPvZ9UdYM4NtaHXOP3XB8=@vger.kernel.org, AJvYcCXiVm78ZsdvSzbHBCayvZJY2QMJm+NKFA8xT1I0NZ5scva4/CsXou5yA4X16XVDMWAsQGdSh9CwopIRjKTWJY/K@vger.kernel.org, AJvYcCXkdeCG0mFACc7e+KR+zaxrs0WreUNk7waz3SotC2Q+GmY+k+gx0rWN6/Z4OLWCOdosnrEt8hDtizbHyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GTB3wns42UJwdGtceKqWUKiAmjkm/dLDwVBbQJyuIq//vwVd
	BabA18fmPdi5FQYCWR6cIszuZZq/GxvdknbHHvjig8a5F/9FSWXlcALC
X-Gm-Gg: ASbGncvM08i5URVeLvh6CpIZVpz5y9rWgMyAEaqHvqOSMLMWKGANUARzJlyadP2ErOs
	Q+RUOvlNbTU3mxf7GdwHB1gt23xD9JnKCXge1omhMcH7DDmFIrYdNOzwM84DZ2OK6OO1REll9Xw
	il/zQx7kMmvT3ObR21KU0R91Ot4FvAmCQfDqzQhksNPMSEYa1ngGpgNLpIyWTUyMDz0OnKPWp/x
	Ieay4GUV6Dgu8E3U0ZXryZWMxqMAvQkiIZ/d1EAC//Dhi9nNxb0VtMMsPYX0NhIWjrofwo1WFYm
	chavq78NIBgixJ2NnEGFOtw4WYXj2HRnamcagYBPC4RCxjr+nOINyVwMj6eDq0dUnX8p8SHnZy3
	GLCmOQlkIUYRqdJpZhnmzVXU88YEt1fKOdn5HS8MimMxW5pzCFYp5e6Zr/u6OMs1NaN2CZfCvba
	ebzrqHRH7NvBV4KvcCrJ4/aAJ9+jmk
X-Google-Smtp-Source: AGHT+IEiARXQyHTIyMuT3fUQxXz/kzFJUN0F5TuE4Y+GyJF6HI6/8bptvftq/fAC42E6NKFRIuKCzQ==
X-Received: by 2002:a05:620a:40d4:b0:7e3:3417:a5e3 with SMTP id af79cd13be357-7e3435709c5mr2426367585a.19.1752964926749;
        Sat, 19 Jul 2025 15:42:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5c29:e400:78d6:5625:d350:50d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm251550785a.84.2025.07.19.15.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:42:06 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/8] rust: use `kernel::{fmt,prelude::fmt!}`
Date: Sat, 19 Jul 2025 18:41:49 -0400
Message-Id: <20250719-core-cstr-fanout-1-v2-0-1ab5ba189c6e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC4ffGgC/32Py27DIBBFf8WadakAm4e96n9UWQAeEqTapECsV
 pH/vZN4k1WX90pz5tw7VCwJK0zdHQpuqaa8UpBvHYSLW8/I0kwZJJeKGz6ykAuyUFth0a351ph
 gUXIthO2lNBLo8Fowpp8n9PN05ILfN2K3owTvKkHysqQ2dSHYAWPvrY0DN2j9rJyKxuuR61mgH
 q0SwSoNr06keBgNL0b06OoojH5E7QyBDE6bgIfEJdWWy+9zKFUPi/82bYJxpoeeWzSS9zF8nBe
 Xvt5JGk77vv8BSAOG5TkBAAA=
X-Change-ID: 20250709-core-cstr-fanout-1-f20611832272
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Jens Axboe <axboe@kernel.dk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752964923; l=2632;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=vbgrYCnB5GbWpCXhaPw8I4u9NCR+1Fim6HSx76fv2mQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCu0Eab3XaeXjLZDUQ3ddLY//J9C+sC+ywoIlzS121Jh4xTPdsG4c76spmKHrnjg4eQIbIkKIcu
 2gdLHhR8aSA0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

This is series 2a/5 of the migration to `core::ffi::CStr`[0].
20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.

This series depends on the prior series[0] and is intended to go through
the rust tree to reduce the number of release cycles required to
complete the work.

Subsystem maintainers: I would appreciate your `Acked-by`s so that this
can be taken through Miguel's tree (where the other series must go).

[0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com/

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Rebase on rust-next.
- Drop pin-init patch, which is no longer needed.
- Link to v1: https://lore.kernel.org/r/20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com

---
Tamir Duberstein (8):
      gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
      rust: alloc: use `kernel::{fmt,prelude::fmt!}`
      rust: block: use `kernel::{fmt,prelude::fmt!}`
      rust: device: use `kernel::{fmt,prelude::fmt!}`
      rust: file: use `kernel::{fmt,prelude::fmt!}`
      rust: kunit: use `kernel::{fmt,prelude::fmt!}`
      rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
      rust: sync: use `kernel::{fmt,prelude::fmt!}`

 drivers/block/rnull.rs               | 2 +-
 drivers/gpu/nova-core/gpu.rs         | 3 +--
 drivers/gpu/nova-core/regs/macros.rs | 6 +++---
 rust/kernel/alloc/kbox.rs            | 2 +-
 rust/kernel/alloc/kvec.rs            | 2 +-
 rust/kernel/alloc/kvec/errors.rs     | 2 +-
 rust/kernel/block/mq.rs              | 2 +-
 rust/kernel/block/mq/gen_disk.rs     | 2 +-
 rust/kernel/block/mq/raw_writer.rs   | 3 +--
 rust/kernel/device.rs                | 6 +++---
 rust/kernel/fs/file.rs               | 5 +++--
 rust/kernel/kunit.rs                 | 8 ++++----
 rust/kernel/seq_file.rs              | 6 +++---
 rust/kernel/sync/arc.rs              | 2 +-
 scripts/rustdoc_test_gen.rs          | 2 +-
 15 files changed, 26 insertions(+), 27 deletions(-)
---
base-commit: cc84ef3b88f407e8bd5a5f7b6906d1e69851c856
change-id: 20250709-core-cstr-fanout-1-f20611832272
prerequisite-change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e:v1
prerequisite-patch-id: 83b1239d1805f206711a5a936bbb61c83227d573
prerequisite-patch-id: a0355dd0efcc945b0565dc4e5a0f42b5a3d29c7e
prerequisite-patch-id: 8585bf441cfab705181f5606c63483c2e88d25aa
prerequisite-patch-id: 04ec344c0bc23f90dbeac10afe26df1a86ce53ec
prerequisite-patch-id: a2fc6cd05fce6d6da8d401e9f8a905bb5c0b2f27
prerequisite-patch-id: f14c099c87562069f25fb7aea6d9aae4086c49a8

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>



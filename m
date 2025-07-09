Return-Path: <linux-kselftest+bounces-36867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF6AAFF273
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ACE3AED15
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EDE2459E0;
	Wed,  9 Jul 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxYA5y3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D242925;
	Wed,  9 Jul 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091209; cv=none; b=Q+fwuauOc7pKJay75tW127qNQbNMaqlkaVf1NlAPfJAsEdlmWvUYCVk0U3lRqGvalXi+cVm0iuCg1M2w2A45Dt0VGBX1IW14tUbsLwt1/HkloHkW+7iglvni51dG18GHBK9sSLaO7bgBasPRF1qgfVzq7v3jS7R2ZCsPa+mRTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091209; c=relaxed/simple;
	bh=3uVzBwpZOZRwh4aQxcecwTnih0t2Su/HW/bH4b6okHs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CwafkeQoLvCiqi6qqxe5bup/RfEaTApkYa2x7oJRIw2DTbprgf1MFQnIdaI2zmCuI1pi1/MG7sDiQ+t4CxMqgKKLwO2VfrAtQfz2rse4CbiwFp3VsPlnZTRCMQ1kmEsw1eKYrkiImD5qtIoudosQPII8JVFHKsDdqC0Ci3OHggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxYA5y3U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58d95ea53so4621121cf.0;
        Wed, 09 Jul 2025 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752091206; x=1752696006; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBPH7FnIuiVsSiPlIYMq7bGgWWPkIuqhlOH0NbxWPbw=;
        b=fxYA5y3UDUVFv6Pv8RlqOzUHQ/OmovWiTmdc7NW0VmR5gEKuZ2JpNrEQ00/vMos7gj
         8Cza2Gwf0PovjOkfVV338D4MMvdFA0b/iWiv9qo3JSkGhL1b+mqYtieEWvI/48UVkI5f
         96uCMe09OmLzz1GmoPqvCh32Ymx7vjzWRfdUqS6nSXnydLl9WCZbET+jdJ0HDPAgOoOL
         Kk9iMXZXE7/ByFWh/mlfvKcr8LfDSHEE0QVKcZRdeXtq3wyK+Lw8OoFMN0JuZXFGer6B
         l83IyEAWNqjTScwR/z+9vLYaNZHwZgsOUEL08YIHty0cy2bNh1HSG35Ch08vElWTOMGI
         uUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091206; x=1752696006;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBPH7FnIuiVsSiPlIYMq7bGgWWPkIuqhlOH0NbxWPbw=;
        b=mWRzqCU4jBtLGF/Bmm450xHktZiImyZZff13AtqXH8ysAOJyFSGcVxNYfFjDlCXgtm
         xsFCet06tl5/kVOjAoEmh6WHgE2+ILt7toGGxZIfeomCV2QWYBZG2iEKKIRt2FdCsLdX
         0H157k245wOE2cuXLW2LXyf6zw33wvQt/4D3ehRk0kACM50NAGWDaacvc3eh3jifpfAS
         112dK9KMONz0WlkyVmeoPlsqOmuiBqOKNnJ7vQ5H3llgq6WWfbhel20SptfCZ1X3+gOO
         jAFk8oRhJjq9LizXglsNz0z3r4pHlnfQk4O2venfQvz6GKTeaEBrWjYCX0IPo/hmzBYH
         mCVw==
X-Forwarded-Encrypted: i=1; AJvYcCVRGksgJSdaaabxZAkofWZ5wuTLYS30JAkOo/MrOJlevaBQGCepGNEJSG3dvSBxHR95RDTyDUKp0Do4YlyPITQ=@vger.kernel.org, AJvYcCW3PvsGxDi88jMsNRPpRYI+LvMZA174snp4fJZPsdmuquLAvqf3kBYNlFxZPGueyws+4vhAxUAG35sH0A==@vger.kernel.org, AJvYcCWO57qZbBwZ7+/YBGUb+oVo0sNPTAXgP4EkgHUwvnRwdDRpMkxyg4RJqutU8WjHRgtfdHAiOmvYETliXW7VLl8k@vger.kernel.org, AJvYcCWhq1AgCm6hjjAQ/Skrgwp+HZ/zzALqzWKN8upjInUIAV3chY84pMITx2EFC9YSgqQ1ThC1a8rbZtSWS6/l@vger.kernel.org
X-Gm-Message-State: AOJu0YyePcmtkN4xJCUO6QKcQ7dH4NsCLiD1jKfSV/9Mw2DdEnWwr2Xm
	myuUPwj4UPu0ZM6VvNuxzXjbds/ak0IbBm/+AONAEol2R2avJFUBzcdd
X-Gm-Gg: ASbGncu+XlJJvZpmpmOaqCINq4/hxg6FvvdF818DKbt4VDu/4V6G+5TMlxTsaFnzWjp
	Do21N/x7T10pEVnZ+L9oEA0eeeKEBbmcUXaFmVcPwUMqJQvnbN0EIN4foJ0juVu8/AA11UY/HrO
	cCP8tUn4Qn5ujEegfFqkcr8f7d4PvVg1ExKY8FMVlemyr3s7BQIFgWrceq+rHmR+tIkcyrF8m2P
	0thbnAJamavYXfuEX5N+JmNOowxdP6GI8g2hgsL3BrxdieaVAX0svcWeCA8soEK3Yb1TfW84ISo
	YWLOE+GynoFIBaWHVvWchwGljGfSPbYj+owdzP7FA90HTOGbxOPNfsn1/kRyj/E/JXa4/fjwbac
	MEkx628cls/Oi8YGmXVh3ckllHk3UqbDsLshTQQ+okvnal4Vul/Q7uhz7dA==
X-Google-Smtp-Source: AGHT+IEjvhAx4Fexn1s+7YjFkkN49k26NgQzpiKzVdxw5gpNGSXQ/darWIe+uClarfZ+hMNJzu4LEQ==
X-Received: by 2002:a05:622a:53c4:b0:4a7:6408:b449 with SMTP id d75a77b69052e-4a9e9bf79afmr13743511cf.2.1752091206317;
        Wed, 09 Jul 2025 13:00:06 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4aaasm100432891cf.3.2025.07.09.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:00:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/9] rust: use `kernel::{fmt,prelude::fmt!}`
Date: Wed, 09 Jul 2025 15:59:59 -0400
Message-Id: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD/KbmgC/02OzQ7CIBAGX6XZsySwpaz0VYwHfhblYKvQGpOm7
 y5RDx5nk51vNqhcMlcYuw0KP3PN89RAHToIVzddWOTYGFDiIElaEebCItSliOSmeV2EEgmlUer
 YIxJCe7wXTvn1kZ7OXy78WJt7+R7Bu9ok8+2Wl7EjY7lH7Y3xMlqMUqdeDVEGPTiZCKmnQNpq+
 G8au1+R/itqQ3fXwHrLxpGPA/H4VHDe9zfyzQPq6QAAAA==
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
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752091203; l=2543;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=3uVzBwpZOZRwh4aQxcecwTnih0t2Su/HW/bH4b6okHs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOFx1gBF76r4ZDYB2EZOTwsUwSVSVp3sKW88+0lIx1FnbguWzfge/GtyFqlJhS0kWl0FJEONZDI
 dw5ZmS5n/ygg=
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
Tamir Duberstein (9):
      gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
      rust: alloc: use `kernel::{fmt,prelude::fmt!}`
      rust: block: use `kernel::{fmt,prelude::fmt!}`
      rust: device: use `kernel::{fmt,prelude::fmt!}`
      rust: file: use `kernel::{fmt,prelude::fmt!}`
      rust: kunit: use `kernel::{fmt,prelude::fmt!}`
      rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
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
 rust/kernel/init.rs                  | 4 ++--
 rust/kernel/kunit.rs                 | 8 ++++----
 rust/kernel/seq_file.rs              | 6 +++---
 rust/kernel/sync/arc.rs              | 3 +--
 scripts/rustdoc_test_gen.rs          | 2 +-
 16 files changed, 28 insertions(+), 30 deletions(-)
---
base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
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



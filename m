Return-Path: <linux-kselftest+bounces-28565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B12A5858E
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 17:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0E616AD3B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680461C1ADB;
	Sun,  9 Mar 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqj31l1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2C186A;
	Sun,  9 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536064; cv=none; b=rXsZOITz0NM/J9etvOKgGNltL/0DdlS17RHJMatFbIQVZjyb1pyKjxe2ljQFWER/blkLy7ugGwMF/F+ntjVYp4cQThMukgqH+WppFxih/y8tyhjW72L7C7KrpABiP8nlS40X3ofHBuP25Cj8046NugvwPi2D784NXUIH5ZYgOd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536064; c=relaxed/simple;
	bh=+6HLtN55+ZUAhpYm27irQaUN2b2chdOxzMn8Ekhuj5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NW55OZ3w05QBUxvknwni16rykR0LS8vcWR5xkbmwyDLxE2FjvumPTOGA5HipOXJcOcGewWlLLhiG832LpnFB/WcWRlE6lRNAlea+h3RyaHEoaUym1sUfgezo7p2bkJfkqc/C70u8bYiXcqJqaFOkDTVqspygnPodS/gCsbjFcuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqj31l1/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c54f67db99so22103185a.1;
        Sun, 09 Mar 2025 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741536061; x=1742140861; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIUSfNrkhAc/xH30MPlnOFxI+AR8qQFueAZfxbScCvc=;
        b=iqj31l1/MYLgu6cX3bv2x2+fsYie1RRhVgAG4UjQM+g5Wl1XqECG44bFwBeRc83lki
         qFUqELWqvWDaElMVAg5sf5iyJTjDyLwaBlWkXr3X7cyv5j7tvBaSP8SYUSbS4rT0DnWs
         5tYc4gSsVUvKZ1RSN7AkFRiH/1Bpv1c9Ow1DJWxCyYLcL2QcOUZHaYySjD90hr2c0h46
         0gFkK2ozqxjwsbfyN2FKHKxdI5mD8Z56I0dg74vSUx/nscZTlVbMyEpufC/QU1JFJX85
         j8/wQXBQMJFxoWDtQ2IthWdOIegaYOrg8uh+SGPIBncI0Z9egGaqfhl0DTaggz40QyDx
         rdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741536061; x=1742140861;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIUSfNrkhAc/xH30MPlnOFxI+AR8qQFueAZfxbScCvc=;
        b=WvOwaJdhQMDLfNHxkLRTO5n4mocwCnf6WpSjzyon46EXPeTgA27OXWpUEdBcbcZLnO
         jtZyNaj7G9mot7Y2iFyOILiwwJ4msVmHpBvDE17k5NFigqjblE2FhPvVVHkthUECq49v
         wzTboncPPxws+ncqOcKc0s25Nftw6zWBMopBVt5xp4UEG3qPp7vmCNQoOu1FhT0PVzue
         6VR/YuV+PPxnZfnGFAXplahZLWZ6Lj688X/J2nkxO6UrefzwuMCUnTUY9XZ73qLGNaBn
         slv1q1LKe7mSTsCyC9omINlPNWcBZvUZ9tWxrvstTSoe8Vu6IZ2/gF+EFCmxLZA2k6To
         M3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUzzxePVxoH7OlFvyh5mbQWRu8qqc1zHxp9QppBGLPfRpeo0MDgQKs1iFtcklU+D0BgQv7lR8U/FAo@vger.kernel.org, AJvYcCUemhU1oKJZDCjnks0ORlAUZHP9xZYV63Y6QlVAzH209u+4ZI58HNOb2rUne24Csz/fnVs+Cvs2wDnnIa9SmDM=@vger.kernel.org, AJvYcCVnFfCkoAB5aikjQ4iANxlkYOwog5ZDBROxfmYVdqCn5janq8GHCXo5TmqquvzdID2Dl+8jRl5ZpTBD+6YH@vger.kernel.org, AJvYcCVtno/w+Wr5g/48ZnQMc0q/TR4uLq0/3Hlee4N1DY4SSaUhAe/THTaw9YP9lDhBEZGi1C+DTQw9nLuxFSqRZkox@vger.kernel.org, AJvYcCWzbz6+EidxIjHje8cDiipIPpM/McHdJQpijmCXYePVSQYcKbZf1k/CmkOzokBdyS9VsdoilFnEZs5ZYtA=@vger.kernel.org, AJvYcCXJ9/wm7doC7EMAeTltadkSGzj03yCBAJUPTz2TMkUZTxUdjNU9exWDRR6cTeT6F0mYCb2U1vc5ySsq@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoM3k/0Q1GvWFr6qKwPHnBM5RI+jiIqd/wx7TWRjFiFo4KC9n
	JZ6tMzM+HASOv/8q0qdh/Xw3/1lxw/QYQih4ilsOfWY5NdjBlRf2
X-Gm-Gg: ASbGncuhYmjHE2et0YS21UMAWzvxskD9Sq5/7bbyirPSNJyhDe8ruPK9dGaKtrQaKZf
	lnUea8Iqs8LufoiqMP+Eu+WadSSVa0fN6kYJbStiIguUH+2H9wt+nmdWPzUDp1VnVTzB2mkS1nk
	LzBTPH/JVVyw6zn2tXhVSJkunfzfgQ20qMY9PWi5HGoikN1zCWnatrviExyfTy85GvE9M54RcbR
	i7Z15H6NCY/Wclci+NLCvCgPGv4qdN706Wqf3o4hxVL1HpSON5uK901G/SyaQubEQFcC0/CvRwc
	ztuXPN0MOZ/tAUS9cvWlm/I3uokytZnlvjhm4qPew8/NV9ig/9nB8wMSeuw/5DBrHJs=
X-Google-Smtp-Source: AGHT+IGSBUnrtTxluwTmVU0Jrsl2Un4V6qUpUqr8ZkQ6WpueiHDhn2vUp9FBAB0SnSQlRBi4o2md1A==
X-Received: by 2002:a05:620a:2693:b0:7c0:add8:1759 with SMTP id af79cd13be357-7c53c8bf4e2mr1121022285a.18.1741536060862;
        Sun, 09 Mar 2025 09:01:00 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534d38dsm512531485a.44.2025.03.09.09.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:00:59 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/5] rust: reduce pointer casts, enable related lints
Date: Sun, 09 Mar 2025 12:00:39 -0400
Message-Id: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACe7zWcC/22MwQ7CIBAFf6XZsxgWoUVP/ofpASltN7GlgYZoG
 v5d5OzpZV4yc0B0gVyEW3NAcIki+bWAODVgZ7NOjtFQGAQXil94x7Y9MBPrCHyibrvRykFCEbb
 gRnrX2KMvPFPcffjUdsLf+zeTkCFTWgy8VSjtVd+nxdDrbP0Cfc75CwPAD6ukAAAA
X-Change-ID: 20250307-ptr-as-ptr-21b1867fc4d4
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This started with a patch that enabled `clippy::ptr_as_ptr`. Benno
Lossin suggested I also look into `clippy::ptr_cast_constness` and I
discovered `clippy::as_ptr_cast_mut`. This series now enables all 3
lints. It also enables `clippy::as_underscore` which ensures other
pointer casts weren't missed. The first commit reduces the need for
pointer casts and is shared with another series[1].

Link: https://lore.kernel.org/all/20250307-no-offset-v1-0-0c728f63b69c@gmail.com/ [1]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Fixed typo in first commit message.
- Added additional patches, converted to series.
- Link to v1: https://lore.kernel.org/r/20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com

---
Tamir Duberstein (5):
      rust: retain pointer mut-ness in `container_of!`
      rust: enable `clippy::ptr_as_ptr` lint
      rust: enable `clippy::ptr_cast_constness` lint
      rust: enable `clippy::as_ptr_cast_mut` lint
      rust: enable `clippy::as_underscore` lint

 Makefile                               |  4 ++++
 rust/bindings/lib.rs                   |  1 +
 rust/kernel/alloc/allocator_test.rs    |  2 +-
 rust/kernel/alloc/kvec.rs              |  4 ++--
 rust/kernel/block/mq/operations.rs     |  2 +-
 rust/kernel/block/mq/request.rs        |  7 ++++---
 rust/kernel/device.rs                  |  5 +++--
 rust/kernel/device_id.rs               |  2 +-
 rust/kernel/devres.rs                  | 19 ++++++++++---------
 rust/kernel/error.rs                   |  2 +-
 rust/kernel/firmware.rs                |  2 +-
 rust/kernel/fs/file.rs                 |  2 +-
 rust/kernel/io.rs                      | 18 +++++++++---------
 rust/kernel/kunit.rs                   | 15 +++++++--------
 rust/kernel/lib.rs                     |  5 ++---
 rust/kernel/list/impl_list_item_mod.rs |  2 +-
 rust/kernel/miscdevice.rs              |  2 +-
 rust/kernel/of.rs                      |  6 +++---
 rust/kernel/pci.rs                     | 13 ++++++++-----
 rust/kernel/platform.rs                |  6 ++++--
 rust/kernel/print.rs                   | 11 +++++------
 rust/kernel/rbtree.rs                  | 23 ++++++++++-------------
 rust/kernel/seq_file.rs                |  3 ++-
 rust/kernel/str.rs                     | 10 +++++-----
 rust/kernel/sync/poll.rs               |  2 +-
 rust/kernel/workqueue.rs               | 12 ++++++------
 rust/uapi/lib.rs                       |  1 +
 27 files changed, 95 insertions(+), 86 deletions(-)
---
base-commit: ff64846bee0e7e3e7bc9363ebad3bab42dd27e24
change-id: 20250307-ptr-as-ptr-21b1867fc4d4

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>



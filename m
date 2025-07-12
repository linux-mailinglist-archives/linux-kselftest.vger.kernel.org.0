Return-Path: <linux-kselftest+bounces-37183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2DB02A13
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D531BC2E76
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175F726B774;
	Sat, 12 Jul 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHKpRx3X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCDF51C5A;
	Sat, 12 Jul 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308829; cv=none; b=OCLG/D+PjDikN6IPRTpccRcgBIRgJbPiIvC1gIvKZTLh41YY6NVfFWthlg7h89BtnOpZMoZ9DdmykvZIm25h9jz8bzY9CuZiLkm2TyQowyQ8sYPWQcES5WLaTmUva2bwtt6nuwp4WtqtiBWM7OCmYmV0EFvuKjEzbEL5DI1qyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308829; c=relaxed/simple;
	bh=sAt6M/6dVGn+429g9VocZGFb50raWZLPION4ReTbBao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uvzvMjHEb2q0eNigRKGh6rxnbHy0x9lnzDSVYGQdveSa2om0WFJ5x3ABlRMW2OynFAc026RFUc1K93frbVMYf+Ks2X/cyAIjoqcKh+KsEorFZqBvk6y0l9wBxfvbDoU2t5l5JYAVv0k7B9RlPFvhUl7BzKjR3vn6nb+qUjjFX7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHKpRx3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1293C4CEEF;
	Sat, 12 Jul 2025 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752308828;
	bh=sAt6M/6dVGn+429g9VocZGFb50raWZLPION4ReTbBao=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RHKpRx3XEbhUDq7hq1Yk8ORjJPPCCwPE2SbwiU7gs28q9YLhlUzZA6c6zd6ZbCyia
	 sx+3JwHM75ViVOcGejPt2C+0owpMCEWMIfqScxQQsRlphT5dNWUYD/+A38GVpQZrSu
	 PN6fnBkBhnxwU+gKtph+hOhourhad+6LuHrFqIClfTha4UQLii9VSmzbDIS3iNJp5T
	 stU79tCWpSBwwvJeb99n0arV+6ywZn2NS1iXZQEAvK8usEQJUOwQARrPi3R/Z+AmOk
	 GnAevKKsk7kwDUpp5JGOPeUSgeCKTF6AHTDLl0rD9OdR/rDsawbUNP8whC8ZWNzc1i
	 54kW8pDVSyorQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Jul 2025 10:27:00 +0200
Message-Id: <DB9XMV1NE9F5.20SGV690NJ9DY@kernel.org>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>
Subject: Re: [PATCH 0/9] rust: use `kernel::{fmt,prelude::fmt!}`
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Jens Axboe" <axboe@kernel.dk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow"
 <davidgow@google.com>, "Rae Moar" <rmoar@google.com>
X-Mailer: aerc 0.20.1
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>

On Wed Jul 9, 2025 at 9:59 PM CEST, Tamir Duberstein wrote:
> This is series 2a/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.
>
> This series depends on the prior series[0] and is intended to go through
> the rust tree to reduce the number of release cycles required to
> complete the work.
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).
>
> [0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (9):
>       gpu: nova-core: use `kernel::{fmt,prelude::fmt!}`
>       rust: alloc: use `kernel::{fmt,prelude::fmt!}`
>       rust: block: use `kernel::{fmt,prelude::fmt!}`
>       rust: device: use `kernel::{fmt,prelude::fmt!}`
>       rust: file: use `kernel::{fmt,prelude::fmt!}`
>       rust: kunit: use `kernel::{fmt,prelude::fmt!}`
>       rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
>       rust: seq_file: use `kernel::{fmt,prelude::fmt!}`
>       rust: sync: use `kernel::{fmt,prelude::fmt!}`
>
>  drivers/block/rnull.rs               | 2 +-
>  drivers/gpu/nova-core/gpu.rs         | 3 +--
>  drivers/gpu/nova-core/regs/macros.rs | 6 +++---
>  rust/kernel/alloc/kbox.rs            | 2 +-
>  rust/kernel/alloc/kvec.rs            | 2 +-
>  rust/kernel/alloc/kvec/errors.rs     | 2 +-
>  rust/kernel/block/mq.rs              | 2 +-
>  rust/kernel/block/mq/gen_disk.rs     | 2 +-
>  rust/kernel/block/mq/raw_writer.rs   | 3 +--
>  rust/kernel/device.rs                | 6 +++---
>  rust/kernel/fs/file.rs               | 5 +++--
>  rust/kernel/init.rs                  | 4 ++--
>  rust/kernel/kunit.rs                 | 8 ++++----
>  rust/kernel/seq_file.rs              | 6 +++---
>  rust/kernel/sync/arc.rs              | 3 +--
>  scripts/rustdoc_test_gen.rs          | 2 +-
>  16 files changed, 28 insertions(+), 30 deletions(-)

For the entire series:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno


Return-Path: <linux-kselftest+bounces-33889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C4FAC5B6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 22:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201104A1F67
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 20:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A620F20B7E1;
	Tue, 27 May 2025 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgJOVINO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1D2F5E;
	Tue, 27 May 2025 20:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748378326; cv=none; b=CaadZdQg2oMt7hBruXcNfrhAjqZ7XWFChxm13E/+Y6djfY8aWcyn8ksMNw9lBwmt7ssbfcsxt8Yqfc0b+MU5lTdKgISzRDmCq2xLTCPmW7J6soJGcq59rcNAjBWrqcQUUdRZELWmuALo5RWw1rm/hwOa0KCN02cLtVnl2q1WUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748378326; c=relaxed/simple;
	bh=BapnUP1IoIf8nYjTuVXWEkLsnc2IMqI9Qe2u8wk5ZAw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hs4LiLG9uqBUO1tJWTfbzy18i/P50ZRqrreP5yO7dTOf5JLoaamTnhoyI4R7vJDaLxM6E8CfqiqHaSIU8M31W9fTds0A677uQ8Dai3LulfRGt/ytuDlCIf65oC3v+TU/nm9dgtkE1iXYhS9ZCG3Lx+ZNTqDSQ2RfGkGRpGQeb+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgJOVINO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B1DC4CEEB;
	Tue, 27 May 2025 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748378325;
	bh=BapnUP1IoIf8nYjTuVXWEkLsnc2IMqI9Qe2u8wk5ZAw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tgJOVINOaOVk17qThB05ojD2VR+ETal4D8BIgtU2LUXr3qWUDjjIEJ42/YUAkDRyN
	 4lUbEGJJThXPhZfXZybqpOSXLyvnDE+4EiT/YGTOe3i5/KTj3NaFPv3pJWMGqunpf9
	 H+wBvhVnWZs2Im6MM5MvqUthvUTZOq0b8rpyfx+0Nvi4c/HdtVa9LqELEhwFQt0pml
	 5j1pHWluTKwERuOrBU7L125oGRSHDL/sb1O3UhEwzMn8s0URe6xUudzDQR7Uw4t8bA
	 vDk9fikhr4pSOCIGnEn40FSMYABtu8EZsYKkpJpQM+5EwAhixvV1523j/T6X3LmZii
	 f7rMZikNHpbOQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 22:38:40 +0200
Message-Id: <DA78E05ZANKN.1U1GZRIBC163K@kernel.org>
Cc: "Jesung Yang" <y.j3ms.n@gmail.com>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: kunit: use crate-level mapping for `c_void`
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250526162429.1114862-1-y.j3ms.n@gmail.com>
 <DA6XI37GNRHE.1FN5893KE2OIG@kernel.org>
 <CANiq72=ue5Fw+7TPPpRcK+0Zk4KTRhH+5YnAY8BQQVX_4YUWqA@mail.gmail.com>
In-Reply-To: <CANiq72=ue5Fw+7TPPpRcK+0Zk4KTRhH+5YnAY8BQQVX_4YUWqA@mail.gmail.com>

On Tue May 27, 2025 at 3:51 PM CEST, Miguel Ojeda wrote:
> On Tue, May 27, 2025 at 2:06=E2=80=AFPM Benno Lossin <lossin@kernel.org> =
wrote:
>>
>> We don't need to explicitly import it, as `c_void` is present in the
>> prelude since 3d5bef5d47c3 ("rust: add C FFI types to the prelude").
>
> Hmm... But the prelude isn't there yet in this patch, no? i.e. our
> prelude is (so far) not a "real prelude" that gets injected
> automatically. So I guess you mean importing the prelude instead.

Ah right it's only auto-imported in the doctests. Forgot that, would be
nice if it could be :)

> (It is imported in the KUnit series anyway, so it will llikely be
> there either way)

Oh yeah, it's in rust-next already :)

---
Cheers,
Benno


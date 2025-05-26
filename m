Return-Path: <linux-kselftest+bounces-33825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60509AC456A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 01:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F503A3AAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 23:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA9E241668;
	Mon, 26 May 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPWMfoiG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EFF4ED;
	Mon, 26 May 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748300619; cv=none; b=doBHtwuFqjT8iDGwCXn7dNR07/pe9Cv/iz17MST2VEReBHziOu818eTUd89BpFPbEyISvB9iAg9+sQycPmp2O4fLkE6zXJj1AKZeEPQtzfoWnWRFMoHiIVY9hS4hQ/lzHN8s6/zJqZwMLaJZPTjxKYNA4G8+3roVEbvCxcpLWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748300619; c=relaxed/simple;
	bh=c+cHcD34wYL9XAQPF1/cyDefYw1UeT25S/M5bM3zJ/Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GIRcIoJRhGR/3QJf9utc9z1byxF2/UlN1Xpz3rIKbxHkep29YEiRdRttK29O1Pj9kp3vCklE2TMT7J0VNXsJmxdXSJTybY6GnfgKCOvsfSQlllPhWB2b/s4yfUeTtcVa2nEzZKFMz1dgT98RieqUeN6OvLTjX1rewvNfmVdqqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPWMfoiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B53CC4CEE7;
	Mon, 26 May 2025 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748300618;
	bh=c+cHcD34wYL9XAQPF1/cyDefYw1UeT25S/M5bM3zJ/Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pPWMfoiGJjLe/cIYGf1GNzU1GxS0/pkuCp0JMZ8O3bxfIjjeO222jyPC7YrNnoLHx
	 a2iRgH+0xP+7orMHfxWe5PufIhx0K78RjL2kmPy0bVKrmk/PBpMqzx6czruy6b6a/7
	 kZtCHO2/Zhl96Z68B5n+sQfcJ7nFjzppDcbTDik+JpP0US10Mposu1kNoR3unHbRFJ
	 0xKFxrT0kcX8tF3GoikkT31qOIc4Uw9/CYD4gf5oDZJRgUyKX6qoTbgVoDcxfc7OX2
	 SpPpB/XjYIHo7Yxg/SEeCp9Nl0hzu4l9wnK2y7yLh45v3WEUfugdqj+nB/judjsC8a
	 gVttzEPhkf3fA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 01:03:26 +0200
Message-Id: <DA6GUB3YOVBD.RWGBCC8CTE7K@kernel.org>
Cc: "Michal Rostecki" <vadorovsky@protonmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Rob Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@google.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <nick.desaulniers+lkml@gmail.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Jens Axboe" <axboe@kernel.dk>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <llvm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <linux-block@vger.kernel.org>
Subject: Re: [PATCH v10 3/5] rust: replace `CStr` with `core::ffi::CStr`
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-3-6412a94d9d75@gmail.com>
 <DA66HHUA8ANF.BI2FH7POFSRJ@kernel.org>
 <CAJ-ks9kmDiOV_qH_s-r4Z4iQf2k6H7ZnqOf5okaQxWWxrj5Deg@mail.gmail.com>
In-Reply-To: <CAJ-ks9kmDiOV_qH_s-r4Z4iQf2k6H7ZnqOf5okaQxWWxrj5Deg@mail.gmail.com>

On Tue May 27, 2025 at 12:24 AM CEST, Tamir Duberstein wrote:
> On Mon, May 26, 2025 at 10:56=E2=80=AFAM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
>> > `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64. Replace
>> > `kernel::str::CStr` with `core::ffi::CStr` now that we can.
>>
>> What's this supposed to mean?
>
> It means that kernel::str::CStr was introduced before core::ffi:CStr
> was available. I didn't check this before, but it is indeed true - see
> https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e43f1d8=
d5c0860d98a23f.

I see, then just write that and mention the commit.

>> > C-String literals were added in Rust 1.77. Opportunistically replace
>> > instances of `kernel::c_str!` with C-String literals where other code
>> > changes were already necessary; the rest will be done in a later commi=
t.
>>
>> Similarly this, the message should explain the motivation for the
>> change, the change itself and can include additional information.
>
> The motivation is implied (that using standard types is preferable to
> having custom ones; this is also implicit rather than explicit in
> https://github.com/Rust-for-Linux/linux/issues/1075), but I can
> sharpen it.

Please add this information to the commit message.

>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  drivers/gpu/drm/drm_panic_qr.rs |   2 +-
>> >  rust/kernel/device.rs           |   4 +-
>> >  rust/kernel/error.rs            |   4 +-
>> >  rust/kernel/firmware.rs         |  11 +-
>> >  rust/kernel/kunit.rs            |   6 +-
>> >  rust/kernel/miscdevice.rs       |   2 +-
>> >  rust/kernel/net/phy.rs          |   2 +-
>> >  rust/kernel/of.rs               |   2 +-
>> >  rust/kernel/prelude.rs          |   5 +-
>> >  rust/kernel/seq_file.rs         |   4 +-
>> >  rust/kernel/str.rs              | 358 +++++++++----------------------=
---------
>> >  rust/kernel/sync/condvar.rs     |   2 +-
>> >  rust/kernel/sync/lock.rs        |   2 +-
>> >  rust/kernel/sync/lock/global.rs |   2 +-
>> >  14 files changed, 112 insertions(+), 294 deletions(-)
>>
>> I'm a bit confused by some of the diffs here, they seem pretty messy,
>> any chance that they can be improved?
>
> I'm open to suggestions. I think the confusion arises from git trying
> to keep code from moving; fundamentally much of the change is moving
> methods to an extension trait, which means git has to choose between
> keeping the documentation where it is, or keeping the implementation
> where it is. If I use `--patience` then everything moves together, but
> then the diffstat swells. Thoughts?

I haven't viewed this patch with color-moved (since I haven't applied it
locally), I can try that first and see if it helps.

---
Cheers,
Benno


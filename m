Return-Path: <linux-kselftest+bounces-29431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6632AA68F0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE9C3BC552
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 14:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8428F1B2182;
	Wed, 19 Mar 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iJnRTbTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95D1B2194;
	Wed, 19 Mar 2025 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394347; cv=none; b=g9nkVKxQPr8vgV5XJG1NtmDlAJNqsOZd5yOMJ3CJNZKg0g6AvLh4XEckC38fDA/3SRUVb5JZM5oL9cET3RHxtSXET7uMS0/GRPdXA9iBO8RzOhZMF5nO6DKoXh+WOJKMptAM3Ihb2sqPO5vx4OCUj2rUraRtLmKDw1FKJW9ItC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394347; c=relaxed/simple;
	bh=QjvonDKsUZ4V2iHv4/1U+AOqOqV/gfEXuo3Gcj7IC+0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nh60dKIChPtPRRLdPc47VuFk8VqOjHWNbhvVsDa95hvslreCU2mMSdpEjIUHQLUohCuATF2Bo7pT7JYnbDIvHYML7uYA5lw1LQTzBrvkpElTrMgv6oXZywCKhNaZFoC2FcENWCOQIMQKBRpG2ZO0vr5i4Mlk/Veg/XzaaRssTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iJnRTbTc; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vrle5chyzvelni2thueqk7aiii.protonmail; t=1742394341; x=1742653541;
	bh=QzhvFGzMYNRsuB/5rn3tyDmEPC9S1uTQvs7bilK0myo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iJnRTbTck6nxRS/SxHCsvttxYgnywoVmmrKnn/tl56xuKAnWWDFK+fKXFAT3OeShj
	 TQ5mMAlWWjL0Pq+Dcfme0Apn8FsLJl8yQNl/p49IY7sdoi0nFvNsyjy/lxs28n20ec
	 v7Xfb+Q6dqA2w7s+iK8fyanWa4aS18OwabFgWrm5SKN4dQd32mC2Oj2x29IViyuh14
	 Q8QKrnlrkNQB70Q9pXtRifybiraRdeEdlkMuF+liSYg2Ch+s5/AT6ZCFTpqoy1sQxc
	 Sij/gGAsvpMZ1bSJQfJeJ+NDpsr5tVb+9I+oMrMT5EfcO3dR0QrHV9MV7V65XRkj85
	 IKO6P4YFCk/ZA==
Date: Wed, 19 Mar 2025 14:25:35 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8KB8OW0SDQJ.B0BDYQPT3NAH@proton.me>
In-Reply-To: <Z9q2xpwsNMDzZ2Gp@google.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com> <D8JTC30W0NF6.17SR73Y9I99ZT@proton.me> <Z9q2xpwsNMDzZ2Gp@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b823c4633caec0aa5f392421097f913030dfea86
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 1:21 PM CET, Alice Ryhl wrote:
> On Wed, Mar 19, 2025 at 12:23:44AM +0000, Benno Lossin wrote:
>> On Tue Mar 18, 2025 at 1:29 PM CET, Alice Ryhl wrote:
>> > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
>> >> Throughout the tree, use the strict provenance APIs stabilized in Rus=
t
>> >> 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
>> >> functions at the `kernel` crate root along with polyfills for rustc <
>> >> 1.84.0.
>> >>=20
>> >> Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc =
<
>> >> 1.84.0 as our MSRV is 1.78.0.
>> >>=20
>> >> In the `kernel` crate, enable the strict provenance lints on rustc >=
=3D
>> >> 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introduci=
ng
>> >> compiler flags that are dependent on the rustc version in use.
>> >>=20
>> >> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-p=
rovenance-apis [1]
>> >> Suggested-by: Benno Lossin <benno.lossin@proton.me>
>> >> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.m=
e/
>> >> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> >
>> > I'm not convinced that the pros of this change outweigh the cons. I
>> > think this is going to be too confusing for the C developers who look =
at
>> > this code.
>>=20
>> 1) I think we should eliminate all possible `as` conversions. They are
>>    non-descriptive (since they can do may *very* different things) and
>>    ptr2int conversions are part of that.
>> 2) At some point we will have to move to the provenance API, since
>>    that's what Rust chose to do. I don't think that doing it at a later
>>    point is doing anyone a favor.
>
> We don't *have* to do anything. Sure, most `as` conversions can be
> removed now that we have fixed the integer type mappings, but I'm still
> not convinced by this case.
>
> Like, sure, use it for that one case in `kernel::str` where it uses
> integers for pointers for some reason. But most other cases, provenance
> isn't useful.

I disagree, it's only going to get more painful in the long run to
change this.

>> 3) I don't understand the argument that this is confusing to C devs.
>>    They are just normal functions that are well-documented (and if
>>    that's not the case, we can just improve them upstream). And
>>    functions are much easier to learn about than `as` casts (those are
>>    IMO much more difficult to figure out than then strict provenance
>>    functions).
>
> I really don't think that's true, no matter how good the docs are. If
> you see `addr as *mut c_void` as a C dev, you are going to immediately
> understand what that means. If you see with_exposed_provenance(addr),
> you're not going to understand what that means from the name - you have
> to interrupt your reading and look up the function with the weird name.

I see this as a double edged sword, yes `addr as *mut c_void` might seem
more easily digestible on the first encounter, but that might also lead
them to never look up what it exactly does.

And I don't think that we should optimize these functions for C readers.
They aren't used commonly (or supposed to IMO) and there are several
other functions that are similarly confusing if not more already in our
codebase.

> And those docs probably spend a long time talking about stuff that
> doesn't matter for your pointer, since it's probably a userspace pointer
> or similar.

For userspace pointers, see below.

>> Thus I think we should keep this patch (with Boqun's improvement).
>>=20
>> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
>> >> index 719b0a48ff55..96393bcf6bd7 100644
>> >> --- a/rust/kernel/uaccess.rs
>> >> +++ b/rust/kernel/uaccess.rs
>> >> @@ -226,7 +226,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit=
<u8>]) -> Result {
>> >>          }
>> >>          // SAFETY: `out_ptr` points into a mutable slice of length `=
len`, so we may write
>> >>          // that many bytes to it.
>> >> -        let res =3D unsafe { bindings::copy_from_user(out_ptr, self.=
ptr as *const c_void, len) };
>> >> +        let res =3D unsafe {
>> >> +            bindings::copy_from_user(out_ptr, crate::with_exposed_pr=
ovenance(self.ptr), len)
>> >> +        };
>> >>          if res !=3D 0 {
>> >>              return Err(EFAULT);
>> >>          }
>> >> @@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T>=
 {
>> >>          let res =3D unsafe {
>> >>              bindings::_copy_from_user(
>> >>                  out.as_mut_ptr().cast::<c_void>(),
>> >> -                self.ptr as *const c_void,
>> >> +                crate::with_exposed_provenance(self.ptr),
>> >>                  len,
>> >>              )
>> >>          };
>> >
>> > That's especially true for cases like this. These are userspace pointe=
rs
>> > that are never dereferenced. It's not useful to care about provenance
>> > here.
>>=20
>> I agree for this case, but I think we shouldn't be using raw pointers
>> for this to begin with. I'd think that a newtype wrapping `usize` is a
>> much better fit. It can then also back the `IoRaw` type. AFAIU user
>> space pointers don't have provenance, right? (if they do, then we should
>> use this API :)
>
> We're doing that to the fullest extent possible already. We only convert
> them to pointers when calling C FFI functions that take user pointers as
> a raw pointer.

We should make bindgen use that type in those interfaces already.

---
Cheers,
Benno



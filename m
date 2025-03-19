Return-Path: <linux-kselftest+bounces-29458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC4A699EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CE83A1158
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148A220FA90;
	Wed, 19 Mar 2025 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KHKntT7u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D24819;
	Wed, 19 Mar 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414547; cv=none; b=Qr5/zP3RPyKSDxD4VvUrdcmul8xqhKcQDY5fP0UzMxtqQW5m3ryW1bINHxidFzT7YeYSjkE1EA2UDeQVFsK6tiiQ2sRMURqRtDUFDraOTr3DoNLHaqD/0W8A3Bf1/6AdM0ElieGmUpuyZYiqNgDDTZ7SCdT1maZ7m3T8DLu0dxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414547; c=relaxed/simple;
	bh=lmBL7zejKvnUDqOWdxUwfNo/k5rPUmaeIm9R+fKvhCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+ZYkjIvRMg+E6rLQloFsVPKqyZ4z5pVOhqaLFaVI2pc6XpU/N1IZPX0P9JIpqKeC9EhlUUqKknDludn4VOa2TiTyNvVJ0mD4nFokYrKr8Yg8KDPHcBdUDSDnAIyOEngPInWYgRsLhkoCyUHXUbPa6njyuAOb3cUNbePWdOtFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KHKntT7u; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rzien2anczd5pltdexn7zrjcni.protonmail; t=1742414541; x=1742673741;
	bh=AZ0CyElZ+X6TSDauNtt6GcIL1oWwt7laTyNsmPTHFuc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KHKntT7uXn0VxwAicITA/daL5jI3pMXg8QnDlyUUeSPXJH03KqsQZJgJya7S4VEgY
	 6f4EsueCVQzOEIPKWMfkYL1uE9a0qyFxYwySsR/4EfpW9kZhTESmCUWRfDpv8aisqC
	 IZfml1PJyXoDScAG57T+qlM7orApxfF58G4CE9Na4SnugYU3IbbjvbUH6JDzm1xgU1
	 FdM4lt/19rykYeA1nXurYlGl9JFPmAPoVsEXq1IVEC+8fbU7adph/JaFYKgMN7/O14
	 2Wvsna7ZLGpinVuY0yPqJDpoZWghokos2c8BKxY+l3Y57nrPOJBEZ3AEwiqIJsHNlN
	 d4pbl+AhnAUNA==
Date: Wed, 19 Mar 2025 20:02:10 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8KIECKPCJN5.3MR59IHCSZMUJ@proton.me>
In-Reply-To: <Z9q2xpwsNMDzZ2Gp@google.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com> <D8JTC30W0NF6.17SR73Y9I99ZT@proton.me> <Z9q2xpwsNMDzZ2Gp@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ca7cc9420e0e1361b7fbb21fd83254119179e3ac
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
>
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
>
> And those docs probably spend a long time talking about stuff that
> doesn't matter for your pointer, since it's probably a userspace pointer
> or similar.
>
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

In our meeting, we discussed all of this in more detail. I now
understand Alice's concern better: it's about userspace pointers, they
don't have provenance and thus shouldn't use the strict provenance API.

There are two possible solutions to this:
* introduce a transparent `UserPtr` type that bindgen uses instead of a
  raw pointer when it encounters a userspace pointer (annotated on the C
  side).
* use a `to_user_pointer` function instead of `without_provenance` to
  better convey the meaning.

I prefer the first one, but it probably needs special bindgen support,
so we should go with the second one until we can change it.


Miguel also said that he wants to have a piece of documentation in the
patch. I can write that, if he specifies a bit more what exactly it
should contain :)

---
Cheers,
Benno



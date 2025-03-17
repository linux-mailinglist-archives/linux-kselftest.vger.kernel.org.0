Return-Path: <linux-kselftest+bounces-29282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2566A660B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 22:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BCD3B41F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35718EFD1;
	Mon, 17 Mar 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd6ULlpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF3200BB3;
	Mon, 17 Mar 2025 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247375; cv=none; b=oiqy2QfAurosWmDU1KrMu8/TDFhx+w9LxBmiztAkoBGg3V2PeVWhC1qpE7cbfPFhxktO2of+VkE356/3xiKznO4D1+8xiqV8DVDcBFXeCueJuK8IEmSL9qZalr8rmnXNYp8tsi8C02EaBKUoxkUxRTIMRoNUfZLMEJ2NskyQb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247375; c=relaxed/simple;
	bh=NDRo1NDyk0UjBObq9g44k3C9noQuO7EtswHNQ9SKiec=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0PKDBvfTRZHhcPR9da5uoxQ/fBFoolkKWsczDRtlqHzh/yviX+5l2ltYbKJsBHO3NWEo28BpBb0U6pTYPrtl7AJdkbgekMcxjnxXzndhkqt872ShN+Ud6XtsRR9Sn1BxkvHpkfW+98ZxybOW6g1cQnrzC1sLIgTXFIcSpvlz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd6ULlpE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso41538676d6.1;
        Mon, 17 Mar 2025 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742247372; x=1742852172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8gbb/i5BgK8BB2vPDb7y+lygRuwfeWxT2URX0MKFH64=;
        b=Wd6ULlpE/9aitSilvzrPJUogeV+afAS6Q9DCfD8Z8OmQoZabhmsg6fjX7mfkYZDSYs
         f0Hr6IZHNvia/nETXeB0DX3Eps/o+Su4eKsFo0ON7uebLWl40u7V4MYP12gW13Xu9Whw
         8GDMCfMcf/MUwRar/gGrD0PsX67ceYRYvNvagQNAs6kj02vn7vA2CrINj2fpqUtO3UaT
         UMdRHFuwNxBVkuIkdk4FtVC4AGIxZQhGNh7jXb//1hAVry5650+Oy/lXoHMP8eNP0Dj7
         kNlK6XnZZZ0gwVvYVUzWcW+zN/+AjlQ+nvxcZKFJWHXdOFd5yaJh2ZEH97Sf6+kUnUA2
         M7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247372; x=1742852172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gbb/i5BgK8BB2vPDb7y+lygRuwfeWxT2URX0MKFH64=;
        b=eFtz78hCAbxsE3Xt1/Hmqh3bqlrPUVKU4FP+ny0nQHv/Ye59QvAAhKlGJHuKPLf9aD
         4nv2T7zBNrYv5nSmuH+erLoeyysdotXqT343d3C8YIrgjQ2N6hqM77CMwUcOaeq4n+PN
         DWmSr9uZz8XOAiMFf5IgRxB9ezKrAulti2CXgA9a2e5rMJIcsKhAHuy7wgC28wrkrZnt
         x7jITvJ5ZyHn6i2sZv5UfsNBD1n/y8nL4JPvF0F9mnam/s25vqAWLd1KEDUYyFpA9/gc
         JJQ684eidmEoLzgBqPH+hr9og0T7PVHLkubAu6DcmfUeyEynfDnEIMdc2Cl9I7klzwjO
         pUFA==
X-Forwarded-Encrypted: i=1; AJvYcCUIIuw+KJyN1G7G98ofllND30CQIjn3Yx8nVvYn1y8bybOkb+d1n0it2Legi0xHe0dpoTdv9THW6UBx@vger.kernel.org, AJvYcCUsyHSyyP/nuHyq4WRa1SJR7rXyGMGGSS/crLJjBByXDEf11r20Wz8SX+tbK5ZYJfDL9XCU/h9fui5i/qeN@vger.kernel.org, AJvYcCUyanpg2vg+Lzt7cPljobq8A+TZASZV8Mk3t5ETbe4DMSvafZU+e99ZWMU4TggpDr+A2gJ4/Al6sdBvAneiNanj@vger.kernel.org, AJvYcCVhlb6JvWosBEATNn7tuZjRtsxt6xxOr727nPnfx/WBKnmA92ADOb1n0ig635Zy85j7TIqVVykEtc/uyKIg@vger.kernel.org, AJvYcCW4+J7Ir8T4dQySjquChgbrneMqIbgFGmewzcdZ0x2uO/iapZXWMy7sT8//SpBA9QgUF5MhUQRJDtBg@vger.kernel.org, AJvYcCWzN9CjQa/Kunm1Wh/XBL0NfdPG3B+xEvtc5H5TkSPkfHVNMrHnWIhvSzqlt6LLw3SmfTC5jwODEmbIiAA=@vger.kernel.org, AJvYcCXr2YU5FWSTQHC0YCAl05oByRaPUyKvSCxZOwj8HT26uSR7tFOGz93EArSPekaYo33Oh5QBgF3n1XcDD/BD40s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ighyk1YwwDB0iXP3Sz0raJVrxRTdYQ4CbUzxqRgYZyYrGatW
	rY5XjlwVJGJQIO6jgffHWvtdPcsgbdU7MVRhjFTeEqiHdbybi2Qm
X-Gm-Gg: ASbGncuY2xGlEgGj2QLrIfwZwkxBO/w071DL0G5yBpT0/6OjlZt1Ni75me/r//ft6sD
	YHXdqujqgMYeQcZX6lOWFUQa4qQBJ9unCk7QSK8hJcLnWWvhT81qj5tF7Ns4ywTs6+1foS1TmHV
	DUuJahYa2bv310zVmv0cQxU+LZpU4N7sxCDX9Ii55ToWpDfzmEUDZd9D4ubVSkNDya8v6c8zC27
	9vywXPtKiswUA97flxumG1y1hgNuGwbTp1794KNn7G7aMjH00hdYSdj0QlGt3Kj7Vnl8CTaFXN/
	iC+y/TNBSoUXVDQdYVfpz1jponxgJb4JG5daL59T4o6MtHOCrsib/ODvmHXz8sUGxdSiriNZLQC
	Dk1PHpwn3SytwP3FgAg3zv0ihFwN0FFQd7mKUzMII3F8Ppw==
X-Google-Smtp-Source: AGHT+IH7Cg+zRnk0RKChbvzsCRrFHm3/BGwV9VJShTZo0drsjzRIjm781oK9RmO+lw2g3ZlpO0mzrA==
X-Received: by 2002:a05:6214:d49:b0:6e6:602f:ef68 with SMTP id 6a1803df08f44-6eaea9e0a17mr215245556d6.10.1742247372550;
        Mon, 17 Mar 2025 14:36:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24b8c2sm59151996d6.50.2025.03.17.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:36:12 -0700 (PDT)
Message-ID: <67d895cc.050a0220.99d33.5adc@mx.google.com>
X-Google-Original-Message-ID: <Z9iVyI7hTo0imPzs@winterfell.>
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 18F611200073;
	Mon, 17 Mar 2025 17:36:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 17 Mar 2025 17:36:11 -0400
X-ME-Sender: <xms:ypXYZ4YXhTbqXacc55vyK0DzU36dWKEoqldGMH5M6YKAOcHDbJQ2nA>
    <xme:ypXYZzaES_UoXJhNr1-Tpfcy9v_PPeCLlIF_G-JB2IOtJKMJxXpIr-C9w4HJkEoIe
    PdXMRJsXTe-JBGXIA>
X-ME-Received: <xmr:ypXYZy8nGPeqzJOzL8NTluopRnAXycXq7Fx6bEGwXYEm5IbLg5trBkpcf1iOKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhephedthfeukeefuefhteehgedvvdfhleff
    jeefleevkeeklefhffdvkeefleeuvedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehg
    mhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfhhj
    rghslhgvrdgvuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhho
    thhonhdrmhgv
X-ME-Proxy: <xmx:y5XYZypVtA76PPl-m-9kbwVPrIJgH5gajSBF3WTO0nKBx_5qXn6pdg>
    <xmx:y5XYZzrDR3LvRcQhC_YjdvlvHCExbhH_kDpbnyWb0oU0v1YByxCBcA>
    <xmx:y5XYZwTYUuiPTy3RWllPn1PCnorfOu_ULD6QLLg3X52FEOnzp6HIdw>
    <xmx:y5XYZzojp2cg3CDIWX-EdUsXDkf_6fF-SbZDicqSt6QlHWCr-wgjug>
    <xmx:y5XYZ47o-BkwHDGbRJ7JuT-GW1O6nTYgbSm5Ebi6pRye0rPkZg8zfL6G>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 17:36:10 -0400 (EDT)
Date: Mon, 17 Mar 2025 14:36:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,	linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	kunit-dev@googlegroups.com,
 linux-pci@vger.kernel.org,	linux-block@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
References: <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
 <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com>
 <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com>
 <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
 <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>

On Mon, Mar 17, 2025 at 04:53:18PM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 4:46 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Mar 17, 2025 at 04:35:42PM -0400, Tamir Duberstein wrote:
> > > On Mon, Mar 17, 2025 at 4:28 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 17, 2025 at 03:05:45PM -0400, Tamir Duberstein wrote:
> > > > > On Mon, Mar 17, 2025 at 2:50 PM Tamir Duberstein <tamird@gmail.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 17, 2025 at 2:17 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > > > > >
> > > > > > > Then we should fix clippy or how we set msrv rather adding the stub.
> > > > > > > @Miguel?
> > > > > >
> > > > > > I filed https://github.com/rust-lang/rust-clippy/issues/14425.
> > > > >
> > > > > I don't think we can wait for that to be fixed, though. Usually clippy
> > > > > is distributed with rustc via rustup, so even if this is eventually
> > > > > fixed, all versions between 1.84.0 and the fix will need this
> > > > > workaround until MSRV is >= 1.84.0.
> > > >
> > > > We need to take one step back to evalute this "workaround".
> > > >
> > > > First, expose_provenance() and with_exposed_provenance{,_mut}() API are
> > > > clearly defined as equavilent to `as` operation [1]. Therefore, the
> > > > changes in this patch doing the conversion with expose_provenance() and
> > > > with_exposed_provenance{,_mut}() don't change anything related to
> > > > provenance in practice.
> > > >
> > > > I do agree we want to use the explicit provenance API, but I don't think
> > > > we want to introduce some API that we know we will change them latter
> > > > when we bump the rustc minimal version. So the question is: are these
> > > > stubs what we want even though in the future our minimal rustc version
> > > > stablizes provenance API? If not, then the cost of this patch cannot
> > > > justify its benefits IMO.
> > > >
> > > > Now let's also look into why we choose a msrv for clippy, I would guess
> > > > it's because we need to support all the versions of rustc starting at
> > > > 1.78 and we want clippy to report a problem based on 1.78 even though
> > > > we're using a higher version of rustc. But for this particular case, we
> > > > use a feature that has already been stablized in a higher version of
> > > > rustc, which means the problem reported by clippy doesn't help us, nor
> > > > does it provide better code. Frankly speaking, I think we have other
> > > > ways to ensure the support of all rustc versions without a msrv for
> > > > clippy. If I was to choose, I would simply drop the msrv. But maybe I'm
> > > > missing something.
> > > >
> > > > The point is tools should help us to write good and maintainable code,
> > > > we shouldn't introduce complicated structure of code just because some
> > > > tools fail to do its job.
> > > >
> > > > [1]: https://doc.rust-lang.org/std/ptr/fn.with_exposed_provenance_mut.html
> > >
> > > Even if we globally disable this clippy lint, we still need stubs
> > > because exposed_provenance was added in 1.79.0. Did your suggestion
> > > address this? Perhaps I missed it.
> >
> > No, I didn't.
> >
> > That's a separate topic though, because I can see the argument that:
> > because with_exposed_provenance() is a function rather than a method, it
> > won't be very benefical to use ptr::with_exposed_provenance() instead of
> > kernel::with_exposed_provenance(), therefor these stubs of
> > exposed_provenance make sense to exist. But I don't think the same
> > argument works for ptr::{with_,map_,}addr().
> 
> What about `pointer::expose_provenance`? It's a method that was added in 1.79.0.
> 

We have a few options:

1) we can decide to use funtion-version of expose_provenance() (i.e. the
   stub), if we feel the symmetry with with_exposed_provenance() is
   a strong rationale. This also means we won't likely use
   pointer::expose_provenance() in the future. That is, although kernel
   doesn't have stable internal API, but in the foreseeable future, we
   decide to use funtion-version of expose_provenance().

2) we can introduce a PtrExt trait for <1.79

   pub trait PtrExt<T> {
       fn expose_provenance(self) -> usize;
   }

   and

   impl<T> PtrExt<T> for *const T {
   	...
   }

   and `PtrExt` in kernel::prelude.

   (we need to #[allow(unstable_name_collisions)] to make that work)

   We can also make with_exposed_provenance() use the same *Ext trick,
   and remove it when we bump the minimal rustc version.

Regards,
Boqun

> We can certainly disable the clippy lint rather than add stubs for
> `pointer::{with_,map_,}addr`, but it doesn't bring us to a solution
> where only free functions require stubs.


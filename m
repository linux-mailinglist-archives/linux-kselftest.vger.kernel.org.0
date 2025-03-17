Return-Path: <linux-kselftest+bounces-29278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F098EA65F1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 21:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91446189DA8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9571F4725;
	Mon, 17 Mar 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgNKsBsu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987117BBF;
	Mon, 17 Mar 2025 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243330; cv=none; b=N445ATkHEmR9LBUEMlIsYyy22xJlIwnqNulsw0Eck+tfR02gvy37G9Sc+XWOqVJL2A0+D0MBa5Ba7zXMpaerIQsKz3ypUziPcGT8F6NdqmSnf/ccN5t6YFdkcNnNLLLZ/sqljBkssEeZfYO+dxSrXV4Ye1bnxr8821WxPCJMHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243330; c=relaxed/simple;
	bh=lchsoJgRQfVQ7pnAJv0mq2YPdxtDq/QgWfmec9w36mw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2fXUnVuHvPdm8E8D7yveArTMVR/zwxphaEQGbU1GJNyHqhrKJwSq1hHkOuCrmb2Y7flP4Lx62Mdy0J1Kx43hleYORpKTWTGw2SUt8cwI698EIZdBkzn/WfDkWIutvVluZyi8pK9SSLiBhHNrvTJnKgb0D6bTlVTcwSNjyRMiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgNKsBsu; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so50988946d6.3;
        Mon, 17 Mar 2025 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742243328; x=1742848128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OgTnoCMML7NG1ectzvNO/tL6qoh3imfTVjxu3to55Yo=;
        b=NgNKsBsuC9bN19avFypi6zTddaXoAHfkObNLQf/UsymTkS0x5cGhHW3PxImBEAGo1t
         qfT0vrJM41Ca7gv8InRVIYoUrYQrXuj+hUBTBXkbYxODYDeandKNRzw6XOPysfj6rE1U
         aHmG9Fs0cw/kFrWjM8pHL3UgWD6IddvhvlDv/TJx4/Nm+xSX3Ml9ZhqZhKPqLnKfsTJF
         iYT7/uNhd5GjfWoz//b3shOP0RZj3eIY195Q9u7UwlLuXHFHlTNMdfCxujxFiqeufAaK
         ajptxGxX/pUYC4Ip0AQMNYL1758kjL/fCV7gEmwr29KusUjUxOVHGvhP7V+qNWj1ddD3
         CxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243328; x=1742848128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgTnoCMML7NG1ectzvNO/tL6qoh3imfTVjxu3to55Yo=;
        b=KDl4hwN0UyzKsxXa50oND8AjLmsEAUFnpO8ENBRgmn4CH6SNk7Vd6lTfTCDvarZmdy
         fFU2sTZ05JEs19+mukLS5FEIn3DMi5UXbC1GWxUgTgHH6R2N+Zg7PyuGlt/Hbvi0J7UA
         GQvdYJh6jIwQh4mNDEXXVGxj571Z2LDaDOC7muouFFkhI5fxyyGnmJ584znVFo1uupwM
         bTccOliyNR4P90zVXZdYisvfePYfXhWd0ni8gxgpE7rsAuxfOYK/u4fuWCQjcvQPzlfx
         sUpMSNXyLcxwC4yYK/VAjsOLdcm7CFNTOJNmX87XNo/RPiONrZyYRz3UZR+d7esfWn9K
         jeYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBUyVYQK/9PTX/KR9SP/CiN6uJkf0LNRDychvDYoye09CzYon9ExOe7zGIvSuoLDNOueawH5ztAxadpMD0OfRq@vger.kernel.org, AJvYcCUtN1XZM4GngE3lBnKJHuNukFZssYPZ+mcN1JR6FN8EgqN05frZlGNMGst8uN7ZD5aM5qpVnpRXE+myJmmk3SQ=@vger.kernel.org, AJvYcCVAKgaqaxo1VMQMHucq3+J8D3Rf3vfyPRAmK7o/uGVVsAE2DBn375dbckR9kPQ8N5FxtHR7RwXDmZdi@vger.kernel.org, AJvYcCVaUTEcexAuFExQPR10bNVpBNbGFOObWPTiyXB/lfCnjTMA4zrmj8uL4zby8qaBvkLTLf9uodQePKY4LDU=@vger.kernel.org, AJvYcCVmkYpAJXcH/l0ORN039Or0TaYkRiQgeFxTPrD0dJJL94KuzdhM4So43ZXhhiObwpa7NA+xpcydNY3QsdfN@vger.kernel.org, AJvYcCX9zONEVU8j3dT4Y+dhnOqnwHwSBDODai2+NtkfFdwcllAoMsxu74mDmwRj0GBkDZKZnN9x3dUCk7RF@vger.kernel.org, AJvYcCXYacWgFEUkzj98TQyHNPEnTPVe/pLzFIpVDynzgYSE6uAugiD84lbK831YXxXAwFNJBgnNJdKxoygONpGZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzILBFDRS/VwIbY0kCHQNNHFWVwDPT6txiPqAD/hwHC9936d+mn
	3YJFgIyMIIf8tRDCyGSn+k8uSn74xiMT233lYwIsgLw/HjL2MttC
X-Gm-Gg: ASbGncuOX+VBw7Wb8SXkyb5NTgprOXZCDL6j2cE+l2QB+QLuAXj+DvsTDo8j5oGRDtE
	JBNee+8GzWrm5YBYqaJnHH1ZG2XQ9xBDX3MPke+Wjftt75gNQG/tM1GOTKjG1WQSMj1bFR91cLf
	eq6OsTENAGUodf4aoD1wR+D2cuPDQJFtzGYOFKaSxm7L3MYn9mmbscvoKB5ZN9nF2R58G+0bz3/
	t6Jp5NLwjUVxPI7jLmTDhOHoA/IP4jq+0gqMt0euKYjBppi3GspA3NLWfMf0sro5/bK9gtNYy7y
	q+3r9LtONqVaT31hTKVLBxXG1KPVIOMEsb0Bx7ZXUxXxIQ7ukcMESKYwmVnjfAuIkNKs+VSI5mW
	rTxsVGkp23Peh+Pn03B4mL3BZ+BlKSbRyW9XeQLRKZkG4NQ==
X-Google-Smtp-Source: AGHT+IG22UCk1wWtKHGuahOdB4N/jHDhl7GdUIABQTTRSKMwZTYkEJZboCMsj9BGDIQnMwF3xDaLwg==
X-Received: by 2002:ad4:5748:0:b0:6e8:fee2:aadf with SMTP id 6a1803df08f44-6eaeaa9cf9fmr224274316d6.31.1742243327531;
        Mon, 17 Mar 2025 13:28:47 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade231bcbsm58221036d6.36.2025.03.17.13.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:28:47 -0700 (PDT)
Message-ID: <67d885ff.0c0a0220.111215.5644@mx.google.com>
X-Google-Original-Message-ID: <Z9iF-xR9a61rDiAz@winterfell.>
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3232E12000B0;
	Mon, 17 Mar 2025 16:28:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 17 Mar 2025 16:28:46 -0400
X-ME-Sender: <xms:_oXYZxmT28nRC8TZWRlWL-X2AWmpGeFR9Wz9pQdpNH8idwsV9nu35w>
    <xme:_oXYZ80zqMnm85svzwSWNHpxhYUiKD730qds8ApFH6vVqhmqLOWoaW0QIBG1JSeld
    iDJJeBx_3Ypw7tbUw>
X-ME-Received: <xmr:_oXYZ3qUhHnSjvL9DkVflSS5nvIWaFB5P-y_Rb4UJowWVUogiFm1Mxu5To8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtgeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_oXYZxlANMwuNKP6DOD5TBOFjLmRE1W6xYhzD3Dwd8ZbIRuy6xOyig>
    <xmx:_oXYZ_2EJeXAh6_9vMOF-ARGYLwnMitB_JEetjjhgNPJFhIF1mI2ow>
    <xmx:_oXYZwuKl8baxiJ2x7FkMMhwnsWQuRwOBnd512TF6iqJsV9YEUFz2Q>
    <xmx:_oXYZzU6TfNKWU5vvN8twnm0mC3c8x-aG3ih_6qLFdnJXj39vX6sNg>
    <xmx:_oXYZ20zuqGxVVrfsulmKHmPb990VxojM_28zgMlZR-HuSsn3xd7RkpD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 16:28:45 -0400 (EDT)
Date: Mon, 17 Mar 2025 13:28:43 -0700
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
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
 <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
 <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com>
 <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>

On Mon, Mar 17, 2025 at 03:05:45PM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 2:50 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Mon, Mar 17, 2025 at 2:17 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > Then we should fix clippy or how we set msrv rather adding the stub.
> > > @Miguel?
> >
> > I filed https://github.com/rust-lang/rust-clippy/issues/14425.
> 
> I don't think we can wait for that to be fixed, though. Usually clippy
> is distributed with rustc via rustup, so even if this is eventually
> fixed, all versions between 1.84.0 and the fix will need this
> workaround until MSRV is >= 1.84.0.

We need to take one step back to evalute this "workaround".

First, expose_provenance() and with_exposed_provenance{,_mut}() API are
clearly defined as equavilent to `as` operation [1]. Therefore, the
changes in this patch doing the conversion with expose_provenance() and
with_exposed_provenance{,_mut}() don't change anything related to
provenance in practice.

I do agree we want to use the explicit provenance API, but I don't think
we want to introduce some API that we know we will change them latter
when we bump the rustc minimal version. So the question is: are these
stubs what we want even though in the future our minimal rustc version
stablizes provenance API? If not, then the cost of this patch cannot
justify its benefits IMO.

Now let's also look into why we choose a msrv for clippy, I would guess
it's because we need to support all the versions of rustc starting at
1.78 and we want clippy to report a problem based on 1.78 even though
we're using a higher version of rustc. But for this particular case, we
use a feature that has already been stablized in a higher version of
rustc, which means the problem reported by clippy doesn't help us, nor
does it provide better code. Frankly speaking, I think we have other
ways to ensure the support of all rustc versions without a msrv for
clippy. If I was to choose, I would simply drop the msrv. But maybe I'm
missing something.

The point is tools should help us to write good and maintainable code,
we shouldn't introduce complicated structure of code just because some
tools fail to do its job.

[1]: https://doc.rust-lang.org/std/ptr/fn.with_exposed_provenance_mut.html

Regards,
Boqun


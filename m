Return-Path: <linux-kselftest+bounces-35309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E4ADF3B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6DE16BD3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097F2F002B;
	Wed, 18 Jun 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0GMLe5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEA2FEE0F;
	Wed, 18 Jun 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750267670; cv=none; b=kZY8RTy9iFGxFB0lW2Fv/hEn84+XAbtjSz/pgPZGg8WjA1Sqlz5lpcC9DBv4hTq3U+cboV1mZ79UpMIEW3j1w3SapR3T4yxTVWxDtFoR9TTAerJjzgxG/wW5MD9ZWN7Z7JFGlFYnns6mI2P3Ei0B1ZMxwL9J7b+MrnOwGlEiShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750267670; c=relaxed/simple;
	bh=i6qGqcOLeZ+C33Fl0SoQO/hHSNceE95rDLEGVJmh26g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8b+k0folKRPYdH3gsYtJYixHDcyzII5BzJqjLG7iPDU51HP72MRN0aS4vW8YfEMPbVJshYfcBWuckHTHQYq7cdD9sGCK/xEe9FqaS6C4oCyDLgdrCA7NLEzrHXNGfAkgWLlkgnJ4CF/M3Yj5pakLv6otVllPLHq+2AH5tl6+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0GMLe5i; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313336f8438so1414779a91.0;
        Wed, 18 Jun 2025 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750267664; x=1750872464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+q5GpQ2p91YPUwXGOT+L4Iu/3q5RIn50B6DUy0Q7so=;
        b=J0GMLe5ibmi6acJy4t+xOstgKNyU4Ls6us72KXQ/ONM5Z1FEQgrzcGvQHbksMtFs/l
         kecjHxqdi1zygRrJckNCsdGZDv5uTEYQo4oCDoSSki8vtVVYcfylbGkpJ5Y6r05WQEhO
         Si9nO+/MyTcMKO4oP/4XmMCnNkeoTcal2m60Wq9PWl/hK2BO4P3ZvxcWUp26el0hCXks
         EYIdakmgblUw3V5UqkRXaWCz5ukwyBJGfibzG/wyCjFVOSRuZ/6pDid+Z0C6KGmPOVyw
         fla95oFxGmaXgEzkLVyp+RQB9agXe5jXSnqZzy1trF9EBAypwnGWoNu1Um3WQPHFDZjt
         WbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750267664; x=1750872464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+q5GpQ2p91YPUwXGOT+L4Iu/3q5RIn50B6DUy0Q7so=;
        b=sYg7F97dikc/oI2gxa2BZ3BduzdcKR0uDWK4RpuNCCiFTpRPDUaw3Rzcms5CufSDVn
         CSbFjjLl7AtSUBFgf+yMEnkCmrm7wScCHMikdZDqsldOpP4RvDt/v7ezXCtsgR7j1Oev
         /b1Jls9sIAgkuk6os7DQxweEY58VXlGZqKLSznU9PMvidfoZZKGv/z4oIEQSUL7zT324
         4D+et2hgp4rrz0bfflDcqSgCORrDdEsOYagQ8Mp1/Sp/l2bmdRgKp5WlUTTRqx76ZDsS
         5atM4MoyCdGR84s72ZGKshCoOqNI8j6XTHT8rlFTwsg5JjY+j9tDFRHTYI3oozFfHLV0
         RRIA==
X-Forwarded-Encrypted: i=1; AJvYcCUSkrLgRQhhCPfzi2KOapUzOwlZs3ptDbYc2g3rzJYoKm4xZDk+bmYkR4cv3IGKbI2xC+muSS2CklRD470/@vger.kernel.org, AJvYcCV70Fe/5OQXRj4NOKBDa3u/EZj2pjCLPP3F3P5Dnv6Y4Sa8wRldoiDJ+JWDrmu6z5ZPAhBB6JdH@vger.kernel.org, AJvYcCVZjfBKj4ZRVgEVhO6lwSqeF+H4F4dldTBGWrHkAd+tongmAuLIa+qZGM7+BShimplFIGc4KNy4zWyTcGh8u5w=@vger.kernel.org, AJvYcCViwPS3fxjYgoSlB+fWixMJSTXIkZw9zyl1gmkpwPGgIUEPmhPcprkU8/J1Qvk31vNtAXUE/iF8rzIWwdX8jkwi@vger.kernel.org, AJvYcCWEZ3gwZm9n2G+yPkZkq6KELxYzYv8DX7QUliNtlUbIebYXt66+AmVHXNOiDZaAW/Vdu2ergFQMYSs=@vger.kernel.org, AJvYcCWtnU7mPMIfHJaYYpWluXCIPO7Ok3zcpjRZRnCIOiVc+eBz3HSNwhFvv1ei/TpeAA/oUXLDqH6D0LSZ@vger.kernel.org, AJvYcCX83+XdGwZNRoGoa34UrUd7s8zoE4lnji8B1LvVyxTfVjbb+H8O6pnN7R1BNvJUwUkR/ws6bOitZ8bZq7Xc@vger.kernel.org, AJvYcCX9uariTuA4YFF35kFD9fohASw22CU+dwSr657npxYyWzi56b/z2eY12EWoRG2C8JO/15i9fFFOcEJfTNw=@vger.kernel.org, AJvYcCXMuKdOSk8RTrOIquyA9BaN6w4Na6hKzPT+9jx5h0A/1AIATGlC4vM+0NABKq77xod97AGUoJJEHkEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCUTYA8MoG0WWyRm3wEsFaWG5muvWq4PcQdBwJED/i7pMdqZ6
	VTh4tNKP1r7eFcNy0fjT1NDu3NlEJlB2r8oK+Zt551KgaQ9/ycmh7lSMIue1zCeC04EN5bYw0ov
	VbAe9f6OMYO1hT01yJh9YPU5sWY83f2E=
X-Gm-Gg: ASbGncsw8GCC5Gk0+8PGYz7Za69uyjTZi2SK9KICaByvy8vdpXZZ2W+iJDIc1VGTqkX
	WokitcMFEVaO+yijF0ftOA+UPEnsGyOMbVV0KXZ/872tAoCXOcuyo0Z83DIQ0bD7+EaAvbhW0ww
	vBwq00cl4ZFUXTulEar//+Q5S/mgnA5Y0IhlH5Gspd73g=
X-Google-Smtp-Source: AGHT+IHgojIF7ZtAWL01BJX9X9RDL/KOffVgqU2TBitLwLXw3+WIYaOCUYiiv/uPX3E3RPRNcpmmIUzrPPvpRfNOxow=
X-Received: by 2002:a17:90b:53ce:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-3158bfee2a1mr70211a91.6.1750267664414; Wed, 18 Jun 2025
 10:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com> <20250615-ptr-as-ptr-v12-6-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-6-f43b024581e8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:27:32 +0200
X-Gm-Features: Ac12FXyjLr8F_PeGOXgNiD3lzcYVOjPw7Oy7KTgQZIrIWl7ZUXuM1dkxLpsBDQ8
Message-ID: <CANiq72nji33-=cLnEkpsXyovctshNZ5-pheBBxQdNscWdReO_A@mail.gmail.com>
Subject: Re: [PATCH v12 6/6] rust: enable `clippy::ref_as_ptr` lint
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 10:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
>  rust/kernel/configfs.rs  | 20 ++++++--------------
>  rust/kernel/device_id.rs |  2 +-
>  rust/kernel/fs/file.rs   |  2 +-

Andreas, Christian, Danilo, Greg: it would be nice to get Acked-by's
for your bits.

(This particular one can be tricky in other cases due to lifetime extension=
.)

Thanks!

Cheers,
Miguel


Return-Path: <linux-kselftest+bounces-29798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E834A70DA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Mar 2025 00:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AF117A5423
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423201EA7FD;
	Tue, 25 Mar 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C36IW42v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC451624DD;
	Tue, 25 Mar 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742945532; cv=none; b=pn2Q3+8kgqZUh5SezTkDPu9UBrBY3hYiR6WTnPjCRz24JP/FkccpNYBKrpbGDt6MD3mv1flRNINCurzpc9O3/gA8aCMNKBrbfmSbWOKiG5hPan6f2fukurDQ/ffpIW8AgfMd4zORoQiqp6vq7oJfkZIrLVhoEHrZgniTxTphrWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742945532; c=relaxed/simple;
	bh=eefr6HbRlYtDKXKjCQxLxiNjejMQgJVFupcX7Ph1gcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GNErjIcuch4bDZTh85MZI31r8G/3/9/O/45lx3+c5ivEvTzKRwBebe6t0Eg1hYh3RsAJTXVp1W9ZgdDrjQeMPHMkyOLNmgzrWAfjc+zbC3jbjF3RQakKW/l0BveEFb5PSpYCXFwofscmQWWGb3WnWSJzNJdEoQoEOEH9JoxWumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C36IW42v; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a6bso64335101fa.1;
        Tue, 25 Mar 2025 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742945528; x=1743550328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eefr6HbRlYtDKXKjCQxLxiNjejMQgJVFupcX7Ph1gcM=;
        b=C36IW42vSDX8AsfdN9ifM3U4YtkmuaYPPaQpdjFyT+zEpNKJFlO3NSMRMUoeo27+YJ
         Ikf//JM+d/mpMqVbXuqyDdZ/yAjqGPWlaBikVhMANovhXviej+nCJqlH+vqnGLNK8NyX
         ko9kVj09MQovDSGULzPkJmCMx7ywVBUaJ4HUpuUtVPHetpLr6+eWg81Q7jc3IpeE449t
         DjeMTH8DKx3RWZv/ky+oA39RpktJ7sTgW5oEXGvgQ7rjj6yxxOR3XW6/GDFJVROMryIf
         HHix0K/kAfWdvj6gjqcVOneCa4mT3URApTtcpc8DDepFyx89IhsQ0gwQ9E7XAKOyj9jL
         6NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742945528; x=1743550328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eefr6HbRlYtDKXKjCQxLxiNjejMQgJVFupcX7Ph1gcM=;
        b=RvfA+9HP/7lBjf1goX/JrDR75gn642jTkOl6HOsPvIxGwP5R8ivtoEZ/x9GKgX8Iqh
         JpOFhJK01mn+exee4syb/GXuQkywvIdjdFJH+kV5A5sbLyypFt1p9K7+3fwghGtRlI5i
         c4AS1CYjlP4MNOeaQ5fnD9M/taluK/Zt5JAudDfnizEcy+iCHYbRQ8BEKFwazXs4k/9e
         TPinBKWgC6MeaeeNOPE2iE5qiJgxq82o5kMEJg4CF5awxyDNOeP4HXTyis2/KfYFcFrg
         ZZi4WB5bQpF5+5msKILR6zRS5YhRGt1THyTHVW8OozowEFr5wWhlx7Go/DYom+gak21S
         ignQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2Zkmkwsz4K+Pf9Jfp9tunpIBAnRFRiBSX0Gxr5WXyZ+Y87F1q3u9ALJT2DcztjzHT/n/U1XvQ+EhCqAs=@vger.kernel.org, AJvYcCUItrrFj7aqsGua/D7qmedLOKXeqykvMINUP3z7Rt68B0QH9DL0A0eK+vncwb5sBxUtRb3YYiPO@vger.kernel.org, AJvYcCUKTXz+tJJHbe0BtIy5LOTkE38/sV4ydf8bEdoIs2SSUgqpSHPUbOypENZfm7svqauZmRHHmlg4yb+r@vger.kernel.org, AJvYcCUUQCucInV3MyysM5xIxXrItWXcLOlQMYafQYlwQ5TBNlBTx+3Uifn1L9lVUSW2LOM4yUxJdwHD+Q/K2Ps4@vger.kernel.org, AJvYcCVj2Z0irQ6dTQc77IbeVSIqBjbcidIcrJsZgaVldCkj2reRzd5iULllxwK7hbI6bJtutANNQFDkyPkef1dU@vger.kernel.org, AJvYcCVq3uoRUKRXOra7ilvFfY79SSSUG5JxPq+CjPJDNQq0BbPUsmNP7enCxoD8tdmMC9lOTjimwS+xHQWFTTJ1spk=@vger.kernel.org, AJvYcCW4/1Ln6s2vkAnQZ+/R8wzrmlJN3H+/5B+Ajlowb9owh+70vkUYnybvJaS+38mDOCIlzNPDJb4byErG@vger.kernel.org, AJvYcCWPr0j3nVRh3zqJDUPpP5rbcH4ZOyvR2W5aA5leZ0IhdaT8iM18Wu9JK0ecUHG/GYvhAPPWJx1JXNPsIKkoi0Bp@vger.kernel.org
X-Gm-Message-State: AOJu0YxGy8QSgrQfbauiTH8lWmOHKEd9W+6RQNXnHTt1frIKTakFxyZI
	sbSuLZcAxREy/szvwBH+k85ShR3i81Fuj+895CHZAwrc0Jz9SgYgkraKrBjKomjfx3pU33ph3Bo
	UFlKJYGq6vp5kUM5AgIPIxELViHY=
X-Gm-Gg: ASbGncsVI2Amp7e1bgffpm2CZROuDYDD0S68NfyW1hSy4aMkNE1vzleehXtoMOv+O7j
	0v1MNMellL20JIBfD3lhH9IHTxHlb5cY8CFzYWh2E3umnks7iYmvv362mQYbOYEdoQ2DzbpFTkE
	8OCiL2v2ZxxeSGfapcsJkgjvIJMU9K4uoRHauLBFUQbExgTZTbuPxhVKkIuvg=
X-Google-Smtp-Source: AGHT+IFxHYJ+0IsL/dVIF9u+EAWIllGZhFdwDLi1uT8DJOuKNoI5GnEZcD+Vh9CnqpoEAhYqpPdcD4a8c0fhXk8RIyI=
X-Received: by 2002:a2e:bc1b:0:b0:30b:a9b7:7dfa with SMTP id
 38308e7fff4ca-30d7e214c8dmr68301441fa.3.1742945528268; Tue, 25 Mar 2025
 16:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com> <CANiq72kYt2mYG8FA=U6C4CPUGfAwDFZ8Jji5SH2Yt2NnOHua0w@mail.gmail.com>
In-Reply-To: <CANiq72kYt2mYG8FA=U6C4CPUGfAwDFZ8Jji5SH2Yt2NnOHua0w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 19:31:32 -0400
X-Gm-Features: AQ5f1Jr6QN6jniT-TQODJ_8YxxFjZq1wvjuil1EsgVPT_xGsnF65ZNPxsL_Gs5g
Message-ID: <CAJ-ks9kjY0i4ZHe6WJ=6Peo+6nN-5cPkuWQu1iYva_mH=356cw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] rust: reduce `as` casts, enable related lints
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:23=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 25, 2025 at 9:07=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Changes in v7:
> > - Add patch to enable `clippy::ref_as_ptr`.
> > - Link to v6: https://lore.kernel.org/r/20250324-ptr-as-ptr-v6-0-49d1b7=
fd4290@gmail.com
>
> Please slow down -- at least wait a few days between revisions (unless
> there is a particular reason that requires it, of course).

Thanks, certainly no urgency here. In this particular case this isn't
a true revision: the difference between v7 and v6 is the presence of
an additional patch.

> We are in the merge window anyway, so there is no urgency to resend
> since these cannot go in, and you may want to rebase on top of -rc1
> when it gets released so that you can cover most/all cases added by
> then.

While it's true that this won't be picked up for some time (and that's
ok), I wanted to get Benno's eyes on it sooner than later. Is there a
workflow (within the mailing list) for such a case, or do folks go out
of band in this situation?

Thanks!
Tamir


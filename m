Return-Path: <linux-kselftest+bounces-29742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAA1A6EFD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 12:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F27189CA7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE2255254;
	Tue, 25 Mar 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDk63Gtu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA0618E351;
	Tue, 25 Mar 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901037; cv=none; b=sXp4vwkv4fzN9ApR1wM+3TENfbXhdpDsffczrCM9WVnlgKWg4S/utXdSldXE4KqjyASct3BZ848SJ20mVgJ8VmZL5uJ/PC+v05m/FwD07Td+j2iTzy4TxGhTmBf2qGEHaBXtFu9Dv10OTQfV8yhNiFcCP5bUOy0g/tTJ+3GOPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901037; c=relaxed/simple;
	bh=52KHnFLo2jgwjIz3u/2IvJMxndBoJ9B+hywEvn+IgVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdO3ZgqEOHCtzY5cpdsExJ/+fd+EOESgyN1S/kwzAB0mnkn4JkQsFiSjSj9uu8sXKiy/kwvvQYRwgw4Ze+urcLes+wIxfXZh6jM++FfntrpyK+DX3ZaaTYD3OgohZ8/ezRkD1vMIE2YFkn0s0HYD4KqjcNCxtkvdNgdSe29f42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDk63Gtu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227e29b6c55so1956155ad.1;
        Tue, 25 Mar 2025 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742901036; x=1743505836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpjqO8YLYhKVActbTnIJgvSrcw7QxNRRzPXj8z9Z3+o=;
        b=VDk63GtulAOYXD/vJpLEKwnngE4o2u6huPP9p1TSIrI2qFRdbMDn7UjuvMNZ/J5IbL
         74mGff6qeKPRUh7R2STMqBnT9NmUeUYvd8QRIVUWeadoRXdWo9mPvrDHdZpVz+P/L//S
         qhRuW7MLt5uM4xY8npmdtfw70THQOYYC7uV6dy/Yp5pn5rUFGB68vaF/9TE1TtvnHD+y
         q2NxzeVdSZlB+Gb6ANY5TyFQvMSSztBsMhqPiqZoxvx9mGHuagwChV3p9H5ZJ/iH6QvS
         UyX6XVLUswyGCR129O+EVnkmsLfOY2cFPXbB5uPuirnQ2AwVTUAD1M67k5d21cvXGS0G
         Gprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742901036; x=1743505836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpjqO8YLYhKVActbTnIJgvSrcw7QxNRRzPXj8z9Z3+o=;
        b=n0EktrYkzfBxHZqykwoxx4REXjQIxFayFRr0BaMYygU8vw3a2+BiC+AFKao62h3otE
         J+PHMJ6RSMdAYMJ1Kv5fNzmhKHgicGUl8AFOrnfVlj0TB2hehAv4Qhpfd6JZuy171YZf
         +Q3+MoEUVjP5NPeQxhTuwC+e0nTAX2usJq79RekJI1AdthPf5eYsNP1queX6IpmJIOt9
         lroKh4KvS4jfNiYw5OPY15R2q+m7iizCiJzguNnQ4Ar6rGXiyooykCwutpXPynS5gMiW
         U2LYCowmvBrOiAu/7svp8P9SBdjm0EU9v8Yov8Qqta+NpZYQgA+z71MmmfzdclGKNF2B
         oyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVKESd2Sz0hkrVthGqV43qXPiv4QhIQcZpRG3/tRbUHkRlbZb8+keINoHOvD0tb30gmSMR0sdYVTtaWMQ4TEPN@vger.kernel.org, AJvYcCUYj5lsDhLXpzOCgnxs2hWL6PhcooQMP7JX71jwgIOQuauZr2YWlV5NSu10fnp27mgEtLo3wJbWz6gsgei1@vger.kernel.org, AJvYcCVQk9HZpem8jH4eyoZH0+NlAcCLDxoBUichI+dj4oXVwCFUHntR7SGhpCnhT3/nNS9E2Wj1QB6aIrTpZBhdhXw=@vger.kernel.org, AJvYcCVtRB+nOBsn3YFOtMvkiQ0lFW2qdYQ4fF/iSKNlT24bE9dQVFfv/2ixHzmTY6NkLBfDtq0I8W6rg1VaFFYh@vger.kernel.org, AJvYcCWL398ioetrQb49o+1dEiG/Eg+otblSaHf+hSc7F3/520V+kT3zjgKPGbnS1g/wtkh7wPZf8yeJUYJytVI=@vger.kernel.org, AJvYcCWwq9v+N1+GThNOWiqdDXK3AT83FMp6YLi8XXoBxNXgH8qvuJdgCy9f+NznbV09t7rdGMVBPgzBFg+h@vger.kernel.org, AJvYcCXvOmlYJJQMYJfG7FcfJVtlUwBAfv1PeYE+RE/0vBhGdUHtmbMhkohVGKX5Egn2H4W4PO+xSerFyCpe@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvyl88/5rnnaXv56Cd6E36l5OekKi3TkV5ymrokHgAOVK4Z3p
	vXel+OBBhjP+lp2/Q0OnFHuv2cJv5XEmkKBjOeWNe2j81X2K+e7Jx3utq4jz9cZuv/pDG1/Ud4d
	7e+gNcP2mJA7drNbQZDlcvavdDIc=
X-Gm-Gg: ASbGncu18vKs7vaXx+XspUVg5LSwnua6+rh3mWZRKWQUTO6rwrU04C6wYPxT/dBFPti
	2H1UwxAt/eKv1G35I+ralxA/2FsId997VrQzGskoqBBjYuSemTL9OZSu9z0TZYBeRrUAjRFD36P
	GgfXMKvf/4BhbeqOlMrgOQRTsvbfQ+ZjjPUbES
X-Google-Smtp-Source: AGHT+IHpJwxSmBo6BH0zzung/n6kxmjGM1u7xLnYxyUt7cmgQfavPYj2SsoHyvHVfv9gpydH4oInfkZrmJ+HN6tGAhY=
X-Received: by 2002:a17:902:d2c4:b0:224:1785:8044 with SMTP id
 d9443c01a7336-22780c6b0c8mr90475055ad.4.1742901035512; Tue, 25 Mar 2025
 04:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
 <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
 <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me>
In-Reply-To: <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 12:10:23 +0100
X-Gm-Features: AQ5f1JqwX_NBrpr_QjwlspVeAWrNOtqXvG7Oj-9W1A9VEei-Tzd_1wGZRvEA414
Message-ID: <CANiq72kLNYj7HELq4ieSPh7Lnqud63RoAitn-HWfcNUQW-yrrA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:05=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> Done: https://github.com/rust-lang/rust-clippy/issues/14469

Linked in our list:

    https://github.com/Rust-for-Linux/linux/issues/349

Cheers,
Miguel


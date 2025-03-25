Return-Path: <linux-kselftest+bounces-29785-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADFA70B65
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 21:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF131898E77
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB21FFC4F;
	Tue, 25 Mar 2025 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyxaq6PW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C21E1E05;
	Tue, 25 Mar 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742934174; cv=none; b=E23KPMZgQng3N6rHpaoPAPd4KBiSvAh8fFY9EkVg4/LXcckTiItJFWq9vGfdmEk56weh2085vUFHj++S2bJhVNVPBdoIRPL5vn5vqN2wbRER5ty/s+Uz4rKjlJv0zs+FSjxUrJWRoqOYhN0kP+jZgfzB7C+amdAjlc11Ew69N0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742934174; c=relaxed/simple;
	bh=ga4/7+5AsKmXN7KaZ/v2lpo/okFMBuYIQMZ6+9qNp8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/nTx5y2LsdW66S4i5HEdZlL0IG6J5F11QWY/DcDyvkejMMkUHYzEebG7D467v85jjNxgO4+gJ1Whxtml+emQkGhKwiaeGRmyal4seEOT+IvRiwtcJafDsfsR22x3h0E4q14Id+d0665Uy7FhBqLGi3FsXNaW2mJMcLoj03RHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyxaq6PW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c0517142bso63125661fa.1;
        Tue, 25 Mar 2025 13:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742934171; x=1743538971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ga4/7+5AsKmXN7KaZ/v2lpo/okFMBuYIQMZ6+9qNp8o=;
        b=kyxaq6PWN4ZabhOlV0xAyQbaq2jrxKfA1DxT2jYoqFjHS4HNbXLjvQlWBquhFjf9Mt
         SUhhXVl+zUIausAmTqNU/4P5Vub1KXUp+uuhQNrR+YyTgZpD1fve8I7Igd6VNBvnDQds
         meYSTz5zCKhH+HjQUM8RkNMvB2+Xw299diD4K94yU4/epEwKGroua/x14BfmMB0YONlS
         vFczjSmHeYk5m6rLTdxO4D1E4iq4SbK7PjPyrquc4aTL3ewjtIvKOgU29r0RcDfbVd+M
         IdQR9Y7psfRibKlgdqoj7Of+aVt/B0hyKXq6MMfqgWXPim9jpc+8ElxGlBNxyb0JMbkf
         GSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742934171; x=1743538971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ga4/7+5AsKmXN7KaZ/v2lpo/okFMBuYIQMZ6+9qNp8o=;
        b=xORMCs0aJRDS+ufj+mjKnQdncRwi+qyEkPN0T60uV+o2YWK+WO8Y9hIhM0ocoTKx+9
         nB8Cpp4ExBz3A0u9k4VOxuzCFYeiSzf69RkS7EwSJZyR/WYWCj+1VvnharbpXYYSW2eB
         6PQkvpsMvaoDcdT0XMBYwculMTqoF4mr2MVuQtcdBjV9UtJ6bMvNlkVYtYIIkUO8Yr/U
         lOP3zMXoKMnJkrcSmvFlYPDAPJhpmSEkYEOsLrilAdL1TQcJjWJXRDQ/4fq/v7g22ZCG
         a61uZUmpZIY/JltjGLOqyQBPgH0yM61wfbvAPOZRnccphMHlOjLNS4yZbHmlbjcDgs3d
         Lolw==
X-Forwarded-Encrypted: i=1; AJvYcCV+JELKLxgFT6RMaCW71uJhT+b36LIDlUzdG5iKG67bJmB13xRefYqaWTny+dq7mVC+M9jp8fjzbhfX@vger.kernel.org, AJvYcCVahLjLFOIwNPhBIoOWzYjwRVWbCuiB68iBTaVa0I55TeYWpBl9/Z4nSRMBp+9SuQK5fRfck0g4u1llPOjG@vger.kernel.org, AJvYcCWWt2xf9OXVAX+zvDJq4hN5EoC7sg+jnXMa2SQibc//P+KvABzNArmsoSyuZxDkD8kdDUQhqKow/1NJPNk=@vger.kernel.org, AJvYcCWc3Wdo+Z7etFrifn8KkKSiMBbLZ5SeyjAGQT1z01UQ66QD2bjJb/2zS7Q+BE3EOyjzCa3qU1OdpPrKEfWmSU2P@vger.kernel.org, AJvYcCWyeTdxlrQ6av9s5ONBW74NwvQGFjtXlfcdsMpTOvPGrc9DnHWIohRSJImpm3DpqBjjSeDVAHfHBLGwDMaIjMg=@vger.kernel.org, AJvYcCX+v4xcheUoYERhHXb8949bu46EjHh67jaFQMMitXyVW+bJlMIO8KHHHichMiX4RktSwQEHrLcX52g4@vger.kernel.org, AJvYcCXxU8hPFoUgWrWTdXoI6u5Wq4bO6H3lrl9cjRhD+OMSVVdX6LAHtSDYyNK1Rn7Tpu+Jzqv8+qVTJeQsIA/t@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKUscBiHvOMSSTd/AwGsDLTJcxv0ZfZkLgonatnWbEBpDiVlI
	QUdgsQCUNd5UTKnmaNQqaGYd3lUo18fLOM8VlBBV9tpFfbdkM1ZunUW1v4AsUTAe3S1Jxgko6yv
	f+T0iukhQlZ85xL1gk2ixPi+hqlE=
X-Gm-Gg: ASbGncuB+cq3vkl15ZQlwU05cj8bqDPiuZdlGh97po/ZQwV7ZWFnC/2Cw2OIRlvkpcn
	qoH0NL5SFVQX9DODWIllvGMJNwppVSjoi6UtvsPE/Ra7xsOzj/vAMUpSDSYhbFSursA1uJRa5p1
	dur6lj2M1ADYrruK2kQZHVFxxLI4Ng3qm87f9bKpIpHA==
X-Google-Smtp-Source: AGHT+IEbs64VWSllHMzvmDD4F/4QQ4b4rhzTGU/qs026hg44Lw7sNBxdnnrHZ2WPK0a1TsBMTDyOztiagJjwXvH/+xM=
X-Received: by 2002:a2e:90d6:0:b0:30b:c980:c589 with SMTP id
 38308e7fff4ca-30d7e222ab1mr60061921fa.14.1742934170481; Tue, 25 Mar 2025
 13:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
 <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
 <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me> <CAJ-ks9kuG8SyybioKQ0+bYwjnCQFMhip+4A1WnMhsdgnNZGiZQ@mail.gmail.com>
 <D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me> <CAJ-ks9mMVzm4m20AxiZ53DyAmSEaEh9veMoVB5XRxmTQP_H_ZQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9mMVzm4m20AxiZ53DyAmSEaEh9veMoVB5XRxmTQP_H_ZQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:22:13 -0400
X-Gm-Features: AQ5f1JpdENwrBAN9qVC5H8oo9JgDi7PU89LvpVV2fPAutff2t5To5Wue3t58KJk
Message-ID: <CAJ-ks9me_Ossv0KqNr8y133GuiMcF6t5jXdOY3EvLXFkez=MXQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
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

On Tue, Mar 25, 2025 at 1:17=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Tue, Mar 25, 2025 at 11:33=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>
> > Here is another lint that we probably want to enable (after the `&raw
> > {const,mut}` series lands): `clippy::borrow_as_ptr`.
>
> This sounds like a good one to file.

Actually I just enabled this and it has no incremental effect relative
to the lints already enabled in the series. We can enable it now, but
it seems to only trigger on patterns already caught by `ref_as_ptr`.


Return-Path: <linux-kselftest+bounces-29136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8CA62CDB
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73B8189B636
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55A1FA165;
	Sat, 15 Mar 2025 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUPRI+DT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20D1F790C;
	Sat, 15 Mar 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742042549; cv=none; b=cJmt5N8tHurwYCb+h3t1n/UjzZ1153pc5AP8LR/I/ekJsAsd+2d3u63CeAm81CcmJ6N71tkW6Xb3aS0ODC4k5GpNWzHrARcqmiRlfyo02OCSkF6ste0wbTHopH+c8HB74tIbEPPbReIcccs4XmaCjXx9xA64Lz8ZevMuUeu74dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742042549; c=relaxed/simple;
	bh=+BUlJQ5BJW3AH1pRYx70iXox+NZApYPAuZ4sAEorWjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0LI8oCXbv94lPDyLjhrMF5J6YLTN6I8P/I8Ay8IPQc/l3h6gTtrZJkMQNWAL3w/Oo+IgcdEYobqr5Tyl0mD6gaPZnFkmyyy5pu1XeXdV/PmE0bxRH0C+kdpUYqfRFM1l2HXbnaQz1adbGPGsVfyyRrmp6F6LPuyXLt0n/zsUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUPRI+DT; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so26684671fa.2;
        Sat, 15 Mar 2025 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742042546; x=1742647346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BUlJQ5BJW3AH1pRYx70iXox+NZApYPAuZ4sAEorWjg=;
        b=mUPRI+DT2sx8gQQc2RrQCitP1goq7Se/JyCXyrohUeAbsvQ5xBSAjO3Riqdx/V2HxV
         2geW75tdKib22KBOC/oqCtCmpO7K2qOgnMjdGpTU9Duttofpet1CZIOrTW3FJwwpOGnv
         UmrU6kdR3F9PDGhSgSIb+KGxk4LP4Re9Z5w5T+iFEGTxgSNNTNJJA9nVvp5yWPdD1Rto
         zalqQ7S6IdQG5aXwW5/hC74PwvdZ25OTyqKzwyvGqx/gdgpEjTG6QpNbC0q1r5XCH9xb
         l+yx+vYcxK0M6d0PWBsPNqpVqs1IsCNJJzIEo/Dy2eHLE8LEy39eL1nxaOG+q33nlLnn
         wMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742042546; x=1742647346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BUlJQ5BJW3AH1pRYx70iXox+NZApYPAuZ4sAEorWjg=;
        b=ZNDb6DQB4WJnthDz6WBKu15YPSMhj89l6hDEJvgvsNhkW/E1jOWzIlN9QySQBXVhlI
         6V65+ZZw83XWA1GJLXdLrSZ8t5G8comV8XKse6NDXO8gn4Z7rAk7R/7SSwFQMARmddsg
         +7qWhT4W5x/lZ8cA2X95d1/TuKqr7MV1R8JdCGirY2IgrydA6h3hUMkE3xU5xPy7f/db
         MRerhbFvfbKLP5DULoCFKv0twOytNwT/2sKSqSU3MKWn5QHbMntCg1G4RnMIMhdR/H0M
         4HgR/RIZMzFpzE93AiRn97Wo5zoggSzjJjA2j7V40GW4g3Er2EMUKFf8srAFC7+ZWRmp
         ojyA==
X-Forwarded-Encrypted: i=1; AJvYcCU0cylP5VrBW5eLG03H2x+kDEwVJb5BVkCtFiuCA4QCWxFpKQ4OYAFQkmGtuXuMyUuF9pJiTJpWraoy@vger.kernel.org, AJvYcCUDxFn/PHVJu0ba1UgaLdcgEywFlnKVPFaXB6q91DRiq9Oribco+U/nvlBiX9W7JNk0lYWL2DuUw0QHMHpB@vger.kernel.org, AJvYcCUGHlzkCdmJezy0wlwRkjieASUqagWD4RVo7S3noggplbnzWunQgX7svpmvEBxmOWueJR5ELYkR5dd/hCw7hZI=@vger.kernel.org, AJvYcCUlsDcV+DmCjhc2+CT4lRNvswcLWi0CUZdlpKmtW8OtZbYvXfFP1l7gcfXJhhsWRU74SfHq76RZmMxT@vger.kernel.org, AJvYcCV+8IOOaB45WWUp7hgq1c8Rl9f0EhlmbOqEHEV2sr8U1Q2hwW7dBwnhp3aSHqNB+0ta7CV8iYMmvHR6lxGx@vger.kernel.org, AJvYcCVPb4qk1njKb5dnXShskshQIlbx3ls0XzJ+lxUzdryef5+KVPHiEdn4Do7UMU5lCjgoRCn+b+7Htzrbbbg=@vger.kernel.org, AJvYcCXi/rRRjT6i8x7XI9CE5t8hA1lCvvQUIeiOleRPUawFfPOiUlJGJ0HAXF9JMrve9c4GuEBDEDT+gjN9b/gf/nsM@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnMDYThm2b3xplKN4da5OSGOinJiM2Ib9GFXcNdi4SGJ64uv3
	SzzLtr4cGSTNDhB+GBhLgCyhemLwR74iM/TSDgUO/tgp8q6L5dOPFFF0NFZxQ13GtHcxLzV3D6y
	G7XeLhVrBlwA5U4SGETMg5yOxi3k=
X-Gm-Gg: ASbGncvrVT6RtfFozImwv8o98mzclrgxd86ZKqwWaZPUfPfu6ljJ94YSSmbzt/5Jt+k
	0TIy9sImzOlNNsaxSaeQIjhu2B29eTBzA7HdDXkce0idKFEhQ8YkmKHhElyVhPPlYTBCuRfFIIz
	A3JZeqo0+uv0kb4pBQKy6yQyuK5/kvIfQ0RTQb55hbkMV1fGBiUKtXTEGLvlOT
X-Google-Smtp-Source: AGHT+IE3AzRzqPlJWkzh4mknsPU/LseF7MyLIEILpyDXIuEEitmhzOybgKjnOLbYtDJdMD1ymq06ArIS/rk3CZFSfqQ=
X-Received: by 2002:a05:651c:1549:b0:309:23ea:5919 with SMTP id
 38308e7fff4ca-30c4a8f4a03mr24532121fa.31.1742042545627; Sat, 15 Mar 2025
 05:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
 <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me> <Z9V0jSfuhqWi_t52@Mac.home>
In-Reply-To: <Z9V0jSfuhqWi_t52@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 08:41:49 -0400
X-Gm-Features: AQ5f1Jr1mnyPJv4J-y1kug05UbgUbmuNGOwI_7Bv4f8YhvYtu1k3t5NU-uSbWe8
Message-ID: <CAJ-ks9k+5c-MYNaxv412Ri1LDAxvkdSQQfKEgQtTu6aEsS-XFA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Sat, Mar 15, 2025 at 8:37=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Sat, Mar 15, 2025 at 09:34:42AM +0000, Benno Lossin wrote:
> [...]
> > > The rest Rust code changes look good to me. Although I would suggest =
you
> > > to split this patch into several patches: you can do the conversion f=
rom
> > > "as" pattern to provenance API one file by one file, and this make it
> > > easier for people to review. And after the conversions are done, you =
can
> > > introduce the Makefile changes.
> >
> > I think it's fine to do several of the `as` conversions in a single
>
> Well, "fine" !=3D "recommended", right? ;-) If the patch was split,
> reviewers would be able to give Reviewed-by to individual patches that
> looks fine trivially. Then it's easier to make progress every iteration,
> and also allows partially applying the changes. Of course it doesn't
> have to be file-by-file.

I sent v4 a little while ago, hopefully the resulting complexity is
manageable now that the build system is untouched.

Cheers.

Tamir


Return-Path: <linux-kselftest+bounces-29105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327EA61FB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5984C420FDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E41C8631;
	Fri, 14 Mar 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adP6xDqC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121021A317D;
	Fri, 14 Mar 2025 22:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989635; cv=none; b=S9hVMM67H1oFHswGhkLy9RoVhCdvTd4EjTrm0KRfeZTBS+Yp921HRyidosRJoGnhr6TLjRlLnAkd2qF6BwruHviVrsOSgKtX0BbVIRqDhW7gOP4vIBEZtRCAmcpfk8QKHdoRHckkR9IgV3/eDx0Txhcc3hpWZqzogkR7nSQ6l+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989635; c=relaxed/simple;
	bh=C0kd9aKABRj1QAtLOroFspun/9OddRjZbQKvrKafBuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5mpvQ03u513eqjPoAejueIlIN1gUkI3fszizLYcPrjvfjfv4yL6x8KsJBOi/ud2r0jeZd28rEIr6oJHY6CoWaYemlNkOscMUEX/2m2EFirR36lzLPFwTSCeWNE2CMIPZM3eyp38spqtAqaJ5nPIMb1R17TeSB9pOI7Y640g0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adP6xDqC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403c99457so6142405ad.3;
        Fri, 14 Mar 2025 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741989632; x=1742594432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0kd9aKABRj1QAtLOroFspun/9OddRjZbQKvrKafBuY=;
        b=adP6xDqCZUW7MI0v01FOX/i0qU/lWjv2duJT/Nfhh1Z0jdMmAWXejFYfMlth2U8V/I
         OrYSlwAL2wKRsT/wVZoqoCfwZdehhSgMP2uB/ZePyx5VXYfMHkNxkYfoL7XRoIUxAyho
         W/wlgWqq5LISSXJJBX/3Xl6W8kqg0RGg+7aQ6jHRAM+1Eq2mMxofVL04vbDwf7vrx/sW
         1zCDnMWyOole63nlTa30ieg8RF4lK5OkOmlggbUi/GyAUezIwCfp+vBr30OYyiXU8kSu
         hf0IuEdBPULrHT+VtvInBS0uOUVz6969QWaZEZOxc8GhQ4ZzXk2pSuW7kQCWVH++t1nO
         1jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741989632; x=1742594432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0kd9aKABRj1QAtLOroFspun/9OddRjZbQKvrKafBuY=;
        b=URoi9kT6497PsP7dlh3bi6V0fRZ0PbwRjWujMGeNwXe7RbPY5Xi2o1bayVoCr0EcnQ
         mxk28UQ2X/JLqdKLQBxpGC3WcWAtCLj3RwNzOpmwsowMo+kdLkJ8J0oW/XsY493z17Lx
         fEmDCeqE4iIdSnkS/Cz8ynsIg1FUnH4rlcRCM26P2onKss+v0h680X/s9Pn8xi/qADb/
         WFOPJFdGgLYWP1yQfEKBvrnhy4NtKYCcvUC8eAAHA8eOWeIPqFIVKRwPrQJc+tfZgkMR
         xoA4ObSJ1SAWvFDVFRvQguwalvAD0ObgGNncOYAGHQ+c/YoViYQGTjP/wZbjNYpP2bfo
         MVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9lLgI08nJFM8+A8eShJLPZOrJ8nWAJeOCj0nnfpUEsVBILr85cA0j05KVE1zIEj4mcr7K+A2lpbpI3J8=@vger.kernel.org, AJvYcCUb9NkHXwmEgMytp5I/mW/M+vz8Yl5/xdQIBxXDbHfbgdqvpNP+L/DzpX8SypjUTTR+2m5MjlqxenNf5VCt@vger.kernel.org, AJvYcCVXvNa39NiFcWf1yBjC8v8Lkqv1dkKn92szPOvuuTiy6/I0Y0nvhwGu7M8csQYlHRtp3jBH9UeDnSAN1Rm41ZoG@vger.kernel.org, AJvYcCVjCpnTmdS5H3MiC1BDR7+FiCdeWS3fy2qZGkfEGjYLA+rSgRwfecW9lKPxO0dD08rg5uxhhC6PovQq@vger.kernel.org, AJvYcCWIln/36lfXItxGnLbxMUnm7JPUAFDH0GtFPDRnSb5OhpZBCoGrrFBFRZLjAnjxgX2nROWpEL4DqL+62C1d@vger.kernel.org, AJvYcCX8y5gPsG0UIgDDISsX2mdpNtecKC9MTaNI/7t6HCoQBCO1YQfwCffX41/nqWmyMDZW2uEu7dnDkMWZmyQcK/g=@vger.kernel.org, AJvYcCXVwbdK3JN0gUPdDb3fTWGusiBN/iNuLaCnEYnuaVZj961NI9ug+8xMQIr+f5qyVAUPlzHtWcMMEORN@vger.kernel.org
X-Gm-Message-State: AOJu0YySgq1Omh/qb2o8OjQ0ehlyCdlJdD/mJAfHSa//AzDEi82U+phg
	Mq55DOqWfkJv/OjObNunpsTzpBulkwAIEJCcJD/YPHAd88qG+aLpUd4wE6f+rN+PcJmGlhOzu3f
	276JKkucT22Pq4Zuzr3WwqukDQ1o7KVK204IU2Q==
X-Gm-Gg: ASbGncvBJstUcwzGGJCZ2Y6qCjgcNiQX7bojcBxr6m+xK0WsHUhpK/ou987eD7hrWQ2
	pSN624js3Dz6Sb1co3jHE0gLw5x7kEi6JQggDnw7kmqZayIAD2yYabu9UcaCbrYD5qR9ytUuWRJ
	BHj9zAlIujM5PzJGdmfKOhc/vqcg==
X-Google-Smtp-Source: AGHT+IGIUg/02s/2JHqPXRDH7/TVhuII4i8lcqJu/RWFW/EJed7lRFJjAAKliqw8+h54oGAl7/TlDjGvEyNR+aIcAyI=
X-Received: by 2002:a17:903:24f:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-225e0acca8cmr22208805ad.10.1741989632152; Fri, 14 Mar 2025
 15:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com> <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me>
In-Reply-To: <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Mar 2025 23:00:20 +0100
X-Gm-Features: AQ5f1JpGXNTQUt_9OGK-niix7_yVJl6KGktSOGjR233jaFdbDnqZxcfMo88tqPc
Message-ID: <CANiq72=JCgdmd+h4_2VguOO9kxdx3OuTqUmpLix3mTLLHLKbZw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
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

On Fri, Mar 14, 2025 at 9:18=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> I don't know when we'll be bumping the minimum version. IIRC 1.85.0 is
> going to be in debian trixie, so eventually we could bump it to that,
> but I'm not sure what the time frame will be for that.
>
> Maybe we can salvage this effort by gating both the lint and the
> unstable features on the versions where it works? @Miguel, what's your
> opinion?
>
> We could even make it simple, requiring 1.84 and not bothering with the
> older versions.

Regarding Debian Trixie: unknown, since my understanding is that it
does not have a release date yet, but apparently mid May is the Hard
Freeze and then it may take e.g. a month or two to the release.

And when it releases, we may want to wait a while before bumping it,
depending on how much time has passed since Rust 1.85.0 and depending
on whether we managed to get e.g. Ubuntu LTSs to provide a versioned
package etc.

If something simple works, then let's just go for that -- we do not
care too much about older versions for linting purposes, since people
should be testing with the latest stable too anyway.

Thanks!

Cheers,
Miguel


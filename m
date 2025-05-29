Return-Path: <linux-kselftest+bounces-34002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4BAC7FCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 16:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675AF4E11BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B022A813;
	Thu, 29 May 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCVI6GiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EE5219E93;
	Thu, 29 May 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529524; cv=none; b=Z3NnekdedT9XKEqigifS30IXIWKSNBBjMuOT0FpdJOWWLk6VN+A7OGCgvLlVPk4PzT0EGQqXBX+rViujusi3vZiDgmQhlcQdExHQwYCsl+k30Y/jfXhe5iGSafomuoiAie9YbpV/z+ceU2El66EBCsvs2Q1daMxe7ZxPf4w610I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529524; c=relaxed/simple;
	bh=YZ2ULh4POJvTHlw2c5YkPq84cjuhmnHK/Reg7POWUrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmYk5UjHBz7wPQDYqkRpoFEmsASCOAyXMbR7h1fNkRZEPjQ9lHKaUN/mr4IrCL50jpbhqNj6Nwddhbi51wNnxWSAN3hIwEGGrrT1jDBRtOnkOjXpWerE0cKZRzs4+01Xi+vfYxVexMjmhc/H08Hq87l3K2EREdI1c3B7AHrUxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCVI6GiS; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3105ef2a071so11233031fa.1;
        Thu, 29 May 2025 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748529520; x=1749134320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZ2ULh4POJvTHlw2c5YkPq84cjuhmnHK/Reg7POWUrU=;
        b=eCVI6GiSko77vpHcQLv+cuGduzMezuMvgzr4IsA+Z2YavYacAe9neePgYKr6ziAUpi
         dO4IBDK6ur+7OUnYsivbLAE0ZV9ZSx8yd+jVHEgZRmm/+6/gWU/Xcmot7IJ/hdE9AMaQ
         SF8BmJnvSxViix7XwcThh2uMsssDFKxA7bZSXqkN94u4BIpfXYdW7/UezRTrnFvq3azq
         suSf0FA7rNxFvv60MVf9hDLQBBhsXQrCq+gXnm2z1G0XIV22zh277OMzegLfmjBE/DV6
         ZN280Pho9C2hM5BpvSbE09QDguhfKv/26ULHP7Czw1srS4SWyouBy629wKVDmHWowHve
         UESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748529520; x=1749134320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZ2ULh4POJvTHlw2c5YkPq84cjuhmnHK/Reg7POWUrU=;
        b=xJ3fdLGkDwq0vRIA4ASjNHoMwJZWyqZVYduC3O72ExuNEOd/7R0HMfyTYlGAkv7DwP
         Rl1JYN5cdMNJs7qnkGGCjnYLHfvAB/CyVnEPmQ5NPmYUVXzBr5RIwElEBVAY2kxqGdol
         OqgvmdpsFs1RrmzxvGTfc4JNkEkabWyn2OVOSfuQJYxa2wJnIV2OF++4EeTlrLWt/gkn
         kfUr7Cwn636dRQnP2Dk91vZJ3SK+zncVGKJcNhR0Ytd80oGfu8e8EUYjDQqeJJ2QpJ5x
         8Y7HEljFCvx5Wgg7MoCV9nNqi4q+EPHQLEojiGTsiSCHOLij3T6Lt80sZF8MGGLCJcrv
         4ehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiOHQciY9096ouFx2IIcP5HD80xJ24sPUcq8Dy5QTtBENEBFGGWwqXyBNnOTh/cr0GJoAw7tou0vMpXOM=@vger.kernel.org, AJvYcCV2POxpngKz1aks67opoF2akid3HBWeDDDC/QjQqRCgH8TqDEQKMyeMwGc96BPZIK1W09Bn/GGIAwJSGyDT73mn@vger.kernel.org, AJvYcCWCq60QfENMAeky7jr0RY5ebnctyr918MjJsj2QJkb9a2r13HFd3F0P5x7tBsacL+0JlAoYHEnZdcEJJQzFIcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZJa/1XI63TS6NZMqbomZsXituqjG1BjCQ3uPSV+PF46ZAYAD
	/mRNw5X4KwKdmNEt2dXQTZmW3Px56bV85kMGhHhmXofkY/i1bz8FAUg1VwvormV78l4kJK7Xj6F
	PtV99fStiAQt2xasxnJRGuyAaE1uLUsw=
X-Gm-Gg: ASbGnctwpYfUaRdFNwi6ijVBHE/S/ZLxs4rh/Lcb6eeuCeP0fgFs7PzHdiXGo2wDaYX
	bFkv7SYAAsTnEhGPcgzf/zyk41jIIDyKYfHn7Jpd71JP/Fb5gGfLJ62SovCM/Xh0293xm+xPXTY
	Vo7QWOFXxSyQfz5Y1Fw6XzQGI3Z1m58A8QxEQgXg5E2eYhDayMJS+oxMtxU1vjCB6/Vw==
X-Google-Smtp-Source: AGHT+IFgc9Ey4Ja+wDZHeNoqalCFZgnSE4lIbqqpKV1yZEaSEei3l3RkP3A9Ep96GrxjJbNi2t8J2gX3c20hntvjveU=
X-Received: by 2002:a05:651c:2123:b0:32a:7386:ca13 with SMTP id
 38308e7fff4ca-32a7386cb65mr32295081fa.22.1748529519497; Thu, 29 May 2025
 07:38:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
 <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com> <CANiq72nigDV2R_9PNOv98nGBxDZ=46WcRM7V05nQWni5VQRw6w@mail.gmail.com>
In-Reply-To: <CANiq72nigDV2R_9PNOv98nGBxDZ=46WcRM7V05nQWni5VQRw6w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 29 May 2025 10:38:03 -0400
X-Gm-Features: AX0GCFukv9hhDvnJcuBGM42QN0bNrWuKmF5v2cpyoDAv-NCmmvXZAFSSoe86oas
Message-ID: <CAJ-ks9=L6zYyr=jsGBbMvL+rwtnPN0MsgZg-Uvz1WeMDyeZXEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: emit path candidates in panic message
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 9:21=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, May 29, 2025 at 3:15=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Include all information in the panic message rather than emit fragments
> > to stderr.
>
> Could we explain the "why" as well in the message? (i.e. not just the "wh=
at")

Sure, that would be:

Include all information in the panic message rather than emit fragments
to stderr to avoid possible interleaving with other output.

Let me know if I should send another spin for this, or if this is ok
to do on apply.


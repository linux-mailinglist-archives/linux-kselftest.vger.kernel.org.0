Return-Path: <linux-kselftest+bounces-36895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0B8AFF4FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 00:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366FC16B319
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED0C21D018;
	Wed,  9 Jul 2025 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr5HDwF8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B978801;
	Wed,  9 Jul 2025 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101496; cv=none; b=K3S1Pa+g2d5Gmvehxivv16vBh6sWsXCcOAayyJdG0tDUoBOjQ9vynApZNDmxrIXOpfk61itUNNG0JW5kBz11P5Q2OyYjwulIeHuuewZUQzrJ/h8zI36XAAenMVoAF9ehSVmwGsOL6iTqY4f2kv5qKsoLXtOsMtJtNJ1Y2jpCh14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101496; c=relaxed/simple;
	bh=AT7zdgEz0XpzQD4/Kb0V7s5h4j2xaoLGpeNlxuiDd50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpV2MY0T8OBOOYM78rz+yA9X0qmML5zoxoM5C5FIq68c7f9xhEC3RRBqComcunKXAGjrNV4MnOmJid5vw/Sfn9M9zufPL8IW+I9NM82hd03ZLKZf3ydbk5PLFoVJ7ARRsbJGirAjRr3q7lxk/8ZNPaOwlkMXezUej97lBpwuwaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr5HDwF8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32f1df5703aso2514151fa.3;
        Wed, 09 Jul 2025 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752101493; x=1752706293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT7zdgEz0XpzQD4/Kb0V7s5h4j2xaoLGpeNlxuiDd50=;
        b=Hr5HDwF8CY+CWdmx0FV8RuoB9auBYi8mv1lKnmLKtSjAjMEtEu26jUvkONYpgKInWm
         VRCSjrSfoi7bbWy1qTtASppkGaq8SxbJdNJZhRhsnljlEm0iySD1AqOrjR4QyCSENLyF
         VR6Nj/cEEBKGx5xRWauR4/WuVhKAn/bV9qOSjNDhDpicqYgaW6AsDPFNAKbLoJ59I98E
         dWg2ufMuccrOZGciN+v99R84ql4G1vLO5ndNg1mf01UDPG+W57I29fRrjCio137p/hWW
         2wmpK3bUfntLAj7BPBU2ced/Hd0thAWqrbmwg+HkqY/GFRTPMF76l45x0uPRQdC8wo6F
         EwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101493; x=1752706293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT7zdgEz0XpzQD4/Kb0V7s5h4j2xaoLGpeNlxuiDd50=;
        b=UqTiwvPq0OAV4A4oxjlNzZ8lfhKOEmrQfZ8ctDjT1ih36WGBvb5v7OzIlX5l0hXu5m
         ZWJk0+57+hRTxDaAX4JVkeZl5r4IYoOXYKOORprq4rdhNM6ckNkRGs0wIMuwXAFIJVkl
         VOUpwh9oE5gthIqWFYrhRRt/ByRUPQhwo+Yo3pmNdCMiIsfbjstNvUUslnGHUoL23r/V
         zj2NpFg1md9bkLEG/yLdjIccBEkDR/g9E9/BlyeDDsZ39HV+W9pLSqNg1pnpBzHDPJ+q
         3p6rAt7fffFjXXYNkAxakAqHIeDtdarlZ7MnR2BIzqqdUV2EvLm1NH+qGshefPL2u4Sj
         vasA==
X-Forwarded-Encrypted: i=1; AJvYcCW+0qe8I3/GZifxXyh3jTmRp01GpOYi43PXP2a4UYjaPTZJAUrpEqAkXzKEG/mYWbIst29nDz/FLboSTz7s4GOl@vger.kernel.org, AJvYcCW30P0Dl+j19PHv2bvG9kIYY4+zkLeEdUj6V+jqj4QBXpQhOlC12yqi98SVroJ2rbizFoqo6nscs/9/kl3T@vger.kernel.org, AJvYcCW3zF6EEXALZXvCC76FaMFZrzeyMPdMtIW9nHN5K0YyGjRbZvwAgjI6/JwCgL8/2uZtHFCIpLicKk3Gkg==@vger.kernel.org, AJvYcCX5zs1QLzVTxjYsWLCoFp7HPMTPgZdm/ceBH+7rKDCRYTMZ/ZbUDujESsRLyQ16ikRzURbjrmB/L7sq2MRdQnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynKva+nqN4nEEMQP6riOKYkIO9U9yXWo+3qXNin0R7pC1j770F
	17cQy0iCtQXbJWIfukD0n0fOzwp7wV7CCcAeVo4repjHtVCSUzXnwoDBDoVPMDRRCHGNfK3ERoy
	/E9GHlMPlclZbQw4msUlF4A+NF4g7iWw=
X-Gm-Gg: ASbGncu6g7cLXFwgFXIzSAASkf1J5p4vHTgCIcyXis4cWkNpz0HqxbZbUVeSEYQHrBH
	JT8ivKkI6nw9/WSDTbujoCHRvWJtmkROOMu0OGdXgNEXbiwTa9Go/axsFwj3wiB2NEvAOVN4yQ6
	eyVkih8fWEGoDtw9SKYshiDKcyvXfXASSHzqGQBiCNaMLpTjTRLVHBbjkmYUo7sfCLEG9VUfKsM
	d+qZgb/uFeNnerk
X-Google-Smtp-Source: AGHT+IF27+KrVs2nw7zMxm/lAjmI7ad0idRyIl1c4CvKZ8/UEyE7oxDB/OUDydZblbt7SfQMSlfdwda0M1ohVpNso+I=
X-Received: by 2002:a05:651c:220d:b0:32f:41a4:5584 with SMTP id
 38308e7fff4ca-32f48584db9mr13809651fa.27.1752101492829; Wed, 09 Jul 2025
 15:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-64308e7203fc@gmail.com>
 <20250709-core-cstr-fanout-1-v1-7-64308e7203fc@gmail.com> <DB7SVTBZ46QB.31WTHFLWDHPZY@kernel.org>
 <CAJ-ks9nNc_pThtb+gHUcjEnvR6V0RAEG0tkv+_DHYYjXs1N7=A@mail.gmail.com>
 <DB7V0GL2HVMV.BR1JSWQPDMC3@kernel.org> <CAJ-ks9n9Z0PtBmqNupS2390B+gq7UJuV0npD+3Ri0tJrQZVB9g@mail.gmail.com>
In-Reply-To: <CAJ-ks9n9Z0PtBmqNupS2390B+gq7UJuV0npD+3Ri0tJrQZVB9g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 9 Jul 2025 18:50:56 -0400
X-Gm-Features: Ac12FXy4ZkLQdVyOcORlDTRU2dOMP13FGi20G8_0yikxCOUmMBlYgA2CbZFOSII
Message-ID: <CAJ-ks9=hdDghvG5d2sK6SWz3OME6BFxZEmrDmfkrAV7Dse8wXQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] rust: pin-init: use `kernel::{fmt,prelude::fmt!}`
To: Benno Lossin <lossin@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:36=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
>
> Ack, sent https://lore.kernel.org/all/20250709-init-remove-old-workaround=
-v1-1-a922d32338d2@gmail.com/.

Messed it up, sent v2:
https://lore.kernel.org/all/20250709-init-remove-old-workaround-v2-0-a3b1be=
8fd490@gmail.com/.


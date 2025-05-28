Return-Path: <linux-kselftest+bounces-33950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA83AC6E36
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BED0165EC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2B28D8DC;
	Wed, 28 May 2025 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4+wvNe+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EA28BA8E;
	Wed, 28 May 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450559; cv=none; b=Y9rh/KWzSo239FMKSSTPOENBru8gXciPxlkxwQ6LPKBoBu77oVhgSjRhC6Lk8COINkIG8+prN+se/Sdx+2/Mf0H0GAO5SZKKH+WKTsAdKnmaHMwxuFA3pCts4krrVYL0qXqAuqZJmQ8CNEMnDLVO3J1bfYfI/7Domi+/AXme5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450559; c=relaxed/simple;
	bh=CL4fdIyFZSXeMM+ZGv0Bz4ORS2ADdJgyt9Wpq8s2V/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knTW6zL2mnn1lRTOjFH0l2iznq0dIaVqtOvksr31e/4JjoXYixf5Fhdf6wRTv5gQdclMtNRXju1TIvowjPoFT6yOpVWE+CxHkYlfkvAX84KpbJdu7WesJ+pnmGZUr7XgchV2iBACfSsc8EwV3q8/8CmKTlZcpLb1gWfVqUVIoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4+wvNe+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3dca2473129so119415ab.2;
        Wed, 28 May 2025 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748450557; x=1749055357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL4fdIyFZSXeMM+ZGv0Bz4ORS2ADdJgyt9Wpq8s2V/M=;
        b=E4+wvNe+TerObiEnW+2WoSaU52r9EJ8YOBUPFzrNr3DHfcTb8VOhoHpVou00o0ftf5
         IMm/aE813nJ/FkiqAmBPZCzhFRdEQrkjKAOU0H6kzEyFfbdqLtfN/Q89VUFbGdS1HIBT
         EhdoaI6CncOHI9BTXRfOdH5RCz7jke0N8kgqjLE3DZEtIZ/f0uniYrPUDhI/53tEwRZo
         eb0Fy+OuzogaubJlb4cbvGj3ByOVj3yg0MRMuf7gVf//6CF33h1eY0kCwKgss/FnDLho
         GQNi1MpZr1cBTVL1eOGS+irLJmV5pSrQD/y3XpQgjE9ktDIw4CeF3chj8WdCXd7eOA6M
         oo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748450557; x=1749055357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL4fdIyFZSXeMM+ZGv0Bz4ORS2ADdJgyt9Wpq8s2V/M=;
        b=CcrLeRvBITNNvL3Q5iqejCvUPSa2ZG4YsCwgxLAVpPP7w/tr3uZvhF1nEMexn63QKK
         n4g/A0gsBOe1jruNrpm60Lat0DjgyRNq58Elcs6yru/CU4JjHHHGz9brHKlC2DZKlLxl
         tZazgROrL425g5r1UUOpAzoBMPGD96Cr3bNhSVbsZYBd42gHOAcpHhyHsLOlMTnaeJQ1
         Wa70yhpcCQjb01U6DV8XtfAY/Z2SOqYahgk37k39BujnLcAmfARqL+nNBao9P14nAQqo
         BvsazWXJYpPqjOpWVLzaeJwbrIBEhqDZipA+Q+AYTEsj1K0SW7NuCxLwI6pnt6KdXzPZ
         ZQSw==
X-Forwarded-Encrypted: i=1; AJvYcCVn9yGy9NQvLHU4tsKQ9Pk4XKpYRLWgx6QqG1wjd6NpGXNZLShI945OHidmhkXaTR728NMbWhu5HwNQFvQ=@vger.kernel.org, AJvYcCWI1v/UrRREeQ5pOA9Y1HsBW6ojkvcmbfvsz59H2+KQfunWDIkJK5Xe5/BAsPWIyJR0KpXnkk2r6ETR+cRuvpU=@vger.kernel.org, AJvYcCWtOYtFemF9O1TIvGkk8IcQYMzY+IcJ8r2f5zDCkTWX09tQX8R28b0dgR6g0CQQ6jMTXWGe31kQSV25PHmVMeTT@vger.kernel.org
X-Gm-Message-State: AOJu0YwrymmnwNLLpS6dYdFCW24b/mbG/5GYCBWkwvOXIhJy70JeHkLm
	Drxa1HWY8JUgEGERHAM91G8984GqrO7ji3tvZp3tHIb36iKelhOPfb+UFCwrLsKGPVi6JkI7nk5
	gyo/yt52DFuieHfTrwjxxQ9dXnuYw8KM=
X-Gm-Gg: ASbGncuZWjIuUJ3i5iWWp/u/D9/BlDiefuPpo4+mLvflAsOJEE6BozASr1w25HXcbNB
	er6gOsN/s7hBCRF2RU444iA2G8cUnxUm4o8DKlykUrLiGhsOVOLeKPenN/Z4clrmdDrpvHbojv5
	OkP4O28tLWq8ezxP3+5kEJLcHaPN9cZM8Frp4O32snzSY=
X-Google-Smtp-Source: AGHT+IG8CoEoXwbyCTS6/cob1FWwDC2rYze5HbDUoZubz0J/3OyoxsvLb+KnOL6AWmmS/KoRCLrClA89L8jvbfvLGA4=
X-Received: by 2002:a05:6e02:b43:b0:3dc:76c6:436f with SMTP id
 e9e14a558f8ab-3dc9b7656abmr189693575ab.21.1748450556856; Wed, 28 May 2025
 09:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528155147.2793921-1-y.j3ms.n@gmail.com> <CANiq72==P-Sp=d6N7B=f-_aHak3Gr596Bs-3MmMBs+tw9J_K9Q@mail.gmail.com>
In-Reply-To: <CANiq72==P-Sp=d6N7B=f-_aHak3Gr596Bs-3MmMBs+tw9J_K9Q@mail.gmail.com>
From: JS Y <y.j3ms.n@gmail.com>
Date: Thu, 29 May 2025 01:42:25 +0900
X-Gm-Features: AX0GCFssabpDLq5oViRLdDvNbOrwHvkIlD3DNI5Pjr-KshHdlvaTWBADm0sTz54
Message-ID: <CA+tqQ4+Y_zYowu3ig0CPHc6VTWi1wj6rdZkdq9FBOagC+tfNAA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kunit: use crate-level mapping for `c_void`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 1:31=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I see this is based on rust-next -- if you rebase the patch on top of
> the latest one, you will see the prelude there :)

Thanks for the heads up! I'll rebase and send out v3 accordingly.

Best regards,
Jesung


Return-Path: <linux-kselftest+bounces-6522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E415887F6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 23:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132BD281579
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Mar 2024 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310C2574F;
	Sun, 24 Mar 2024 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfzAX4Ug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7EDDBC;
	Sun, 24 Mar 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711318403; cv=none; b=YX5z8xJFlc1JE0cdwBu5xoInxXmZNus73hUOG14xFqT1ZW/DRJeOJatKvnMcIeakuotpbPyOt9tDHmzoPUljkzojBiD6gDOCbMAjKAF03M1UA+WI6v74l96atwne6SEl98RXC6GV+HGXD6z/cuGOsJRiT6fiGZCsV6ssJJVBPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711318403; c=relaxed/simple;
	bh=hywmCcBW0orQmN+UCYCOuHWcheXYsAC7Tj6t+LOGyjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4LAhhBfZgtc2RFSXPyfVDj+9t6FWmDxOb/KE/TxCQcJyXTLdZwhQo3somkHWCrWF7Ra4uGkM4j9e6+81K1bzU2MUCJ+hYIlTLRJ2x71NFypyx7B8s16OBmrK8iYhbVm/0i3cDvLcUsLLqHnvL5gek+kkYuNw80LNoup1hxIxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfzAX4Ug; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so24042065e9.1;
        Sun, 24 Mar 2024 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711318400; x=1711923200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hywmCcBW0orQmN+UCYCOuHWcheXYsAC7Tj6t+LOGyjU=;
        b=DfzAX4UgpvVeAWmgrptkHAbWz4TTKj7YwPWXdW9uRQ0a6TyZfAOGhp8hm2ANQUCdwH
         ZsS3J4Ueb4dulVhcz98FovMrOpPWTMsWEEsy+UZebGCIZfWRV110MkJdRW0Yo/agXNTr
         Z+tXwrJgg6yGhyZ+5zQCO8orxNNieSX35edWMonZ8k7jdUR37ZxcIyJJ0sXLQeXHDgyX
         H0GFUSQQeMU8z457mBmWBHS67O73wzhE0SQkk63QXV8tuMewuLXxbSu7wDJuZ0xVZA2q
         Qt2snfgUW+8y0Jjd3vEjGciuDceFexooDxMPVzPt3WCeaK//C993GAB3nD/lkJxYXQye
         Ud+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711318400; x=1711923200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hywmCcBW0orQmN+UCYCOuHWcheXYsAC7Tj6t+LOGyjU=;
        b=g17z4HiXhHexpfcoZ4VcXRiZkP7Zw5N8fRqIFzFqOWdHwd2QTwTxn/8SQw9sQ7328W
         DQ++mX1+bZ2FYf8huzWyBSzYAfvxP25F9TkU2J4wK0Aw+K4R549Q61fQkoFd2AVeotrG
         EA+8D8JrysNyqUXBjJDQcrD+vfqXRmr+bWRQnnI7i1FqE3hcz8U+uHfC8A6dtwcjahYO
         6Dh8HkEPzEk4DjHwesDGlOjBZgVJPkl0w2zWz5jRFpX9vurKCdy4wWtNiJ4k+cxbr/2c
         iNJJ2pt0DZ/VLidNsXDt8PyFjbPachXL19O7wO4+zHgYPx/asIm3ll4PE23Ytzud5qbC
         OC4g==
X-Forwarded-Encrypted: i=1; AJvYcCXuAH4eV5QvpjKiekqOyCgsm2ktdUjR+jBZuefwh7uL/AjZZQVIWZGftWQGSkIaUxkdF6oLZZDko/g10hWhbp20K1CrGVaSiOv2D3RrUc4hX9K8a+HPQloNHoDFYalbtS3aOZRJR7IX+wZnrtG1PWfmuWanB8KQN2MIID2qEhIhLQx2
X-Gm-Message-State: AOJu0Yy+QpiEf2KTOxmm71MHvFFP6J160Xmvplp3DRxv8qvd+rnXJMn+
	Ttk/tH0TxZIhBydVKdIJwoisvhQnF8uBaGsvlTu1D2WWz8slRUR2b+6C4hWA5MLEhAMklNQ4bpe
	/SyBElnzRRAG10MKzkye7ZNNqltg=
X-Google-Smtp-Source: AGHT+IG34qAnMqbaSfcff2cfsm3hhOYWc0eUO7q3sIj/I0742jLBohIFfqPT1Wyx4f6WIl9dZ1Wzkq01fSARWrHUnHk=
X-Received: by 2002:adf:e90d:0:b0:33e:c5fd:6636 with SMTP id
 f13-20020adfe90d000000b0033ec5fd6636mr3606269wrm.3.1711318400124; Sun, 24 Mar
 2024 15:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-hid-bpf-sleepable-v5-0-179c7b59eaaa@kernel.org>
 <20240322-hid-bpf-sleepable-v5-2-179c7b59eaaa@kernel.org> <CAP01T76oYpkNdgxXo+6v53afjObvYU4LWRLfkg2S7pNivzaEvg@mail.gmail.com>
 <CAADnVQL_mQgN8uKsNFR0FBtWoaweCkzXw03EvbnQ-iFVWvXxuw@mail.gmail.com>
 <CAP01T753_FjFdj1CbCX5Bh1itYUWf8DUh41F7R_7Fdb=2SEL8g@mail.gmail.com>
 <CAADnVQ+5mSEW-LJwS30hED1cJeHOhqfCTKdBzYCcRd8EiVNvtA@mail.gmail.com> <CAP01T757ddmmFR+Cnj70DrTLFcEu+9uAcbscrO-uOmSVGB8eJA@mail.gmail.com>
In-Reply-To: <CAP01T757ddmmFR+Cnj70DrTLFcEu+9uAcbscrO-uOmSVGB8eJA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 15:13:08 -0700
Message-ID: <CAADnVQK=aAcNt-8BBJNnp3QGkxVWLYhZ9=9dizo-7eQosjNtow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/6] bpf/verifier: add bpf_timer as a kfunc
 capable type
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 9:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:

> > > >
> > > > Observation is correct. The patch is buggy,
> > > > but the suggestion to follow process_dynptr_func() will lead
> > > > to unnecessary complexity.
> > > > dynptr-s are on stack with plenty of extra checks.
> > >
> > > The suggestion was to call process_timer_func, not process_dynptr_fun=
c.
> > >
> > > > In this case bpf_timer is in map_value.
> > > > Much simpler is to follow KF_ARG_PTR_TO_MAP approach.
> > >
> > > What I meant by the example was that dynptr handling does the same
> > > thing for kfuncs and helpers (using the same function), so timer
> > > arguments should do the same (i.e. use process_timer_func), which wil=
l
> > > do all checks for constant offset (ensuring var_off is tnum_is_const)
> > > and match it against btf_record->timer_off.
> >
> > I don't follow. Please elaborate with a patch.
> > The var_off and off is a part of the bug, but it's not the biggest part=
 of it.
>
> Not compile tested.

I see. All makes sense to me.

Benjamin,
pls incorporate it in your set.


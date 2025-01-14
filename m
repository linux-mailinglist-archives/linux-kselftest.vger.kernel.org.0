Return-Path: <linux-kselftest+bounces-24537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00DA115B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 00:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C123A0495
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676EC217705;
	Tue, 14 Jan 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9kedv+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C748520F97C
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899016; cv=none; b=uJbKJAXlswrA6JgwivybUQIr5Yohlf8lv6oXHR7YvPp9HINKOiGpgJJxYOGfGx3duVVF+HqeN5RB3aITRWEU0tD4pHucMeRdJR2YxoiS7yLK7vv5zWaccHXNOMdKiAp0nvA5XpjaP+0DtPAhVQSVlLD8/xeXuiD+hBLn83nXIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899016; c=relaxed/simple;
	bh=hsDXwmzK+MEbUTf1nmH+fU3nSl1k+Il7rWMBGEuCIjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClBiGuS1zibJxuGFBZf8XXcfXQpy0mKzLTnDOV5LWO0yzG2+LzCy05GPxfSt3tpooAvE1oHRmyLl0LKDGpSESfs50G5npXRi8w1ggpCfKLezmqOTJ8tqZ0HYTfY30RaJA/FeoiT8DD8wNn1sT7Qu0i7jX3DwCyzGf67Ezcwqazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9kedv+E; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e15abd163so326236a34.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736899014; x=1737503814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsDXwmzK+MEbUTf1nmH+fU3nSl1k+Il7rWMBGEuCIjY=;
        b=M9kedv+EmytPQRJS5vDO2QW54eG8n18qMKR5X577V5SdNMdY3AmkHkp6/xynmK68rD
         stT+dWvypE+JJzRT/9t3pQ2wrGZPJ9xVzawrqEEWazhuz2HAEs3ukKb81m44kVNku0z9
         dvQfqhHGMMfAgCdbyVu8wUtfn5dt8xutg4TME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736899014; x=1737503814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsDXwmzK+MEbUTf1nmH+fU3nSl1k+Il7rWMBGEuCIjY=;
        b=VOQ8LD+NNkOpOeLzW2gpxVSl+aehObFZCrEQPv5aUSzEWcF5xXjn8tQHw+g8WZpSz6
         dI92NUQn/DOo7g7NeedHKFxqwLiAbmQXLraCgRvHmZvLSDRKlrxpdErVW2EzhvpR9VLj
         q6l1GKxDaw5N0bcC/DufkhyTn8YsLIThFSpsCuE3RelcfjU/kuB2luoY01I8Kjpz6ASW
         prQt1Qk/ZFq/F9xvXB5RyVBP6UARGJy/RRvA1lsrTUxT2L5znyy9gxnjDVUyFZbw8tg5
         HY302Jhs2byFRwR7J2ld5mzVYFsrbriSSm4RNqcPrIzHnkhZVbMpHHsxrj9qCtvByle9
         RLug==
X-Forwarded-Encrypted: i=1; AJvYcCWzHv6DCg1RfW6kcuexIQxJStp2eO8RO35tXNZUiu8KwN91HTWcbc1moqjjcfvPo193RgQBczP/6QJcYI/p9+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87p8NfY6C+EyG9zoh/CRk2r4jDYtEfMH1aCub1h4ENkcO8YEN
	rgFrjkby0sSEz5BPFe/UPoajyF9zB/5fxlbedew6CAxKmpyorC/o0XyKVgeVJtl9vX1ndNhAD1v
	SYqh60vER40BPcC/VAua3DlTyCQ1o2+788IhN
X-Gm-Gg: ASbGnctIn9OUyyetxMiuk4mUMtXZbbWKP4laMyaE57W9ZUvv6ybbC/gSJLLb0CeRf8S
	05/NVVvR95RPwoUq7YqARUwJqDKB+gldBic7usgNzzT2RjizoFGrTf5cTVpfVoAMGrkY=
X-Google-Smtp-Source: AGHT+IEAw2B5tCNJDwUL7Y6+KMPrK0hY5kh46XqIOUz3BH2q9OUUWw7ikrIg6V0VzXoo+NOVvkfJ1O15Pgg2qtc+B/I=
X-Received: by 2002:a05:6870:718d:b0:29e:57b1:b20c with SMTP id
 586e51a60fabf-2aa069758f3mr6115602fac.10.1736899014008; Tue, 14 Jan 2025
 15:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook> <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
 <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
 <Z4bC1I1GTlXiJhvS@google.com> <202501141326.E81023D@keescook>
 <Z4boRqW9Gv57GDzu@google.com> <CABi2SkVqa7o7E82m7c8KTsHO4MjwCsdtp21UO+wb_A=r-+aqmw@mail.gmail.com>
In-Reply-To: <CABi2SkVqa7o7E82m7c8KTsHO4MjwCsdtp21UO+wb_A=r-+aqmw@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 14 Jan 2025 15:56:42 -0800
X-Gm-Features: AbW1kvYVUAP5xVIsnmRsQIsr2TbfB3Xp5ZrZuZOEIpJoQq_ZV6Ao_Nj-QrGDqBs
Message-ID: <CABi2SkWE6dguS24oSoycB1z0dCNS1iqW=ftv56Vpm4EtaMTX9A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 3:41=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Tue, Jan 14, 2025 at 2:42=E2=80=AFPM Isaac Manjarres
> <isaacmanjarres@google.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 01:29:44PM -0800, Kees Cook wrote:
> > > On Tue, Jan 14, 2025 at 12:02:28PM -0800, Isaac Manjarres wrote:
>
> > Alternatively, MFD_NOEXEC_SEAL could be extended
> > to prevent executable mappings, and MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> > could be enabled, but that type of system would prevent memfd buffers
> > from being used for execution for legitimate usecases (e.g. JIT), which
> > may not be desirable.
> >
> The JIT case doesn't use execve(memfd), right ?
>
That might not be important.

I also think selinux policy will be a better option for this, There is
a pending work item to restrict/enforce MFD_NOEXEC_SEAL on
memfd_create().


>
>
> > --Isaac


Return-Path: <linux-kselftest+bounces-1580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D86780D1BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA71FB20ECD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A374CDF0;
	Mon, 11 Dec 2023 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zu8UDPwJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2E10C
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 08:29:20 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5d7346442d4so44183407b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702312159; x=1702916959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSPGyUrN4GjfYDkEDWQ9RuHGcmWJXoW4tq+uyOT9lYQ=;
        b=Zu8UDPwJSapGPadQZucWc+ffyxSWsa7h/ZguD9XwSptExTOO/YDXdU7OEbIt2Vac67
         PyFvf7xWWa3zO6tQ5kZd3p1VP3J6SrV2MVSWmqh/LwQl3UmqGGj6JmxT0eub3tA/ERsu
         3kDQZ+6JH7po4/Wpy7WelgP/ds/a2Khy+NDRy2SDD2l3N/cZcvncPjpdyE0KAFVK4og2
         Wt+sYg1+cp0d5d7egzjzC54QbGyTOySMSlAuG9b99gBG4LLAtRUgvfimQfHdKbmuGKDI
         M3TH8fg9Ktzm9NEyKvfNq13gFzRqceUl/bPsAgrIflzc9FPFlPYPaqvK5whIIOmBBzr2
         ayCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312159; x=1702916959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSPGyUrN4GjfYDkEDWQ9RuHGcmWJXoW4tq+uyOT9lYQ=;
        b=ITsWaD2/bI2+7tVSYnq9mvHmF5ZgT+g94Z3teviKGVRsNXIZScsPOAbncX7GVchg+r
         ZC5QX/Q0hnF+MnF/B1gRbNK9q1Sz2oeBQBUETLLJhRWHWWsEM+WtxXgT6EyJgADmMsBa
         iTh/+boN/pWY+BOttBgeEeD4WR8ml3y13KEUFKZEnPHatAhJjqHmA9ZK0znYNPlEw48S
         Ywf50+qfq4mpqz8+vt8G0tCKHQpVtQZcacmX3RQoqzkBEI0pi+pZTnXtxE8/k/Nly07V
         jQYII0eGHkA20rkrW5kH496q+8ieS3/NdaFXO306yrpquLgjnFyYhUALCOHfXdp/CpRR
         LKtA==
X-Gm-Message-State: AOJu0YzRYqGnB9F0JjMM+wNJJVGfAHVOp/FVwCNoiKKjCNaGPODiq0tz
	k0O77Z3783/FjuIOVM2qF04b6037KNMm7DIu3QZSJA==
X-Google-Smtp-Source: AGHT+IEhILWoGMDAtGuNT9NWDVh05Lsk8AMNK0XY+S8xdfil2h/twfsZPK3dQs15HVmmLEysTUS2RYXmliuqhFPsf1k=
X-Received: by 2002:a81:4a84:0:b0:5d7:cfe5:a476 with SMTP id
 x126-20020a814a84000000b005d7cfe5a476mr3477164ywa.74.1702312159491; Mon, 11
 Dec 2023 08:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk> <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk> <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk> <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
In-Reply-To: <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Dec 2023 08:29:06 -0800
Message-ID: <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Mark Brown <broonie@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com, 
	lokeshgidra@google.com, peterx@redhat.com, ryan.roberts@arm.com, 
	hughd@google.com, mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 8:25=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Dec 11, 2023 at 08:15:11AM -0800, Suren Baghdasaryan wrote:
> > On Mon, Dec 11, 2023 at 4:24=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > Oh, it's obviously the new headers not being installed.  The builds
> > > where I'm seeing the problem (my own and KernelCI's) are all fresh
> > > containers so there shouldn't be any stale headers lying around.
>
> > Ok, I was updating my headers and that's why I could not reproduce it.
> > David, should the test be modified to handle old linux headers
> > (disable the new tests #ifndef _UFFDIO_MOVE or some other way)?
>
> Are you sure we're not just missing an updated to the list of headers to
> copy (under include/uapi IIRC)?

Let me double check.

Just to rule out this possibility, linux-next was broken on Friday
(see https://lore.kernel.org/all/CAJuCfpFiEqRO4qkFZbUCmGZy-n_ucqgR5NeyvnwXq=
Yh+RU4C6w@mail.gmail.com/).
I just checked and it's fixed now. Could you confirm that with the
latest linux-next you still see the issue?


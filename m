Return-Path: <linux-kselftest+bounces-4161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD8084A918
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5C01C27C09
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE81DDDA;
	Mon,  5 Feb 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGdW1sy9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77ED1DA3F
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Feb 2024 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171202; cv=none; b=lIXvh9ivmpKwTVcOXQllidITiZ4U/JCmXO4HWrhlQhwO9Sc9Zinr/g7i0ABP72d0avybSIsicfjG1vrbvG92AfGUzl9NjFLdu5VWkxaOcZV6iOsezavIBNJEfofg2sWKJCeItOfj65vbZMNXPTFGRBzNjqVt8xYksu1DAZkF8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171202; c=relaxed/simple;
	bh=jdd1RTnsCbK9CBh+Tor3vhucPu9sttBLgqAG8qJCD9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AoJbpjDuZCZyQgV7YHEUdDvlGGj+oMKdDhX8e/LUt1wxBCoc6/1yX65ZbZvRAFZZdMY9LeaLxzx1ZSp9GNzb0U44/Fob6+m1wzOO7LbrRJ/6Gg3s9LbH4sV3QfkN0kyGnioaon65mXRwzBIPU4qXRY9OFvDQ3rN7vGfvexU/K3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGdW1sy9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60406f4e1d0so42996127b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Feb 2024 14:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707171200; x=1707776000; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+wc7Sgfr0FX1NUK9lSF8NbngE4sfyd8aYAoXi3MmuY=;
        b=HGdW1sy94car4fYnXdy3DYt9kTJQqZkFGoDoomMrHTRezfSkMgDOHSIdZZ8+swYV/X
         uIKTZbzQ9fmiIZykn1fqK2RG5RSRizuNd+vtq5UHWE9GPo7WtWERAWu9qMHputgvVvaF
         5Ea3pUJYbH0/QrQ8CUF9eB/CWfihWBEsfeQsMomvPrExQ3XqKAqqdauEjmzA3b9HsBFa
         WerCYgEMTK6smljgIS4dZ4racsB2Past1PVXeWunWwIpyAxdqPxD83A06MXGkH3HHb47
         CinGTW4xKU93oOkmRUM+R0uX0WYeYW2PbYE86ILcP9IITl3DwH/BuAANWbhjccSF4spN
         InBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171200; x=1707776000;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+wc7Sgfr0FX1NUK9lSF8NbngE4sfyd8aYAoXi3MmuY=;
        b=LYQ2p1h1W/bA0LCDmn6OlAyqfWL6Rw+Hntfa0QtwNqTmcu2p7kTdU3m64u96ZKVhpM
         75aPAKF33YnZKJ1bEQE8ra1aDqBkzx/aNpM4kRJXobxmntXADWbmsXBYTQnQBx1C/2oq
         vfmSUHNZ5jVmJTMe/P2D/+S8xEtPFbcLN7/xNTAN29sWFoao+dqQHGp4kI7xLAlig+5B
         d+vOumhGBH8n8TcWXpOQj1EUwPqbKutZHVXvN5VVpSyqrWV+bwXXaqywpChBQAbEG9sn
         OUqCRxRAJEhxX+vZjm7vN5MP76dvTnkdxxDCJt2OnOS5U10nIU0WTopHhrmhK95mVJ+W
         IyyA==
X-Gm-Message-State: AOJu0Yzvs0baHqB4VF4xphZQtyxa3AqTDQQ/cIotdXjsk60aDzLHVBtC
	AOns0GOX/bA30wLQ+lHbSuS1Og9HrIJHh8DaPF1F45jy88t0dqHGEyxuwUxEV07IP1h0VIcO2Pu
	gwsPYFTLu/43GoAPcPx5j4HjKGGwbOltnhp9i
X-Google-Smtp-Source: AGHT+IE3Q8rQ7p44qPRhpPecrcgKN57uf9gFqW1Q2sgeAXqYfYu/n/QNxOLHPNun1c2+nnvHUGp3OOQurFj1SVrbBZ0=
X-Received: by 2002:a81:b715:0:b0:604:ea3:6525 with SMTP id
 v21-20020a81b715000000b006040ea36525mr1064920ywh.0.1707171199364; Mon, 05 Feb
 2024 14:13:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver> <85714.1706902336@cvs.openbsd.org>
 <CAHk-=wjNXcqDVxDBJW8hEVpHHAE0odJEf63+oigabtpU6GoCBg@mail.gmail.com>
 <20240202211807.6sca4ppezma7cyev@revolver> <CAHk-=whhmasHcmaS0MZkBe2NohjF7Wb3F3pdW4vqyaSbSzQ75g@mail.gmail.com>
 <20240203044534.wkyfkxdlnskxctsq@revolver>
In-Reply-To: <20240203044534.wkyfkxdlnskxctsq@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 5 Feb 2024 14:13:08 -0800
Message-ID: <CAJuCfpHPk282ttjwEn0A39cHuUgsVTCDsSGzvG3hnFVV+G7edg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:46=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> [240202 18:36]:
> > On Fri, 2 Feb 2024 at 13:18, Liam R. Howlett <Liam.Howlett@oracle.com> =
wrote:
> > >
> > > There will be a larger performance cost to checking up front without
> > > allowing the partial completion.
> >
> > I suspect that for mseal(), the only half-way common case will be
> > sealing an area that is entirely contained within one vma.
>
> Agreed.
>
> >
> > So the cost will be the vma splitting (if it's not the whole vma), and
> > very unlikely to be any kind of "walk the vma's to check that they can
> > all be sealed" loop up-front.
>
> That's the cost of calling mseal(), and I think that will be totally
> reasonable.
>
> I'm more concerned with the other calls that do affect more than one vma
> that will now have to ensure there is not an mseal'ed vma among the
> affected area.
>
> As you pointed out, we don't do atomic updates and so we have to add a
> loop at the beginning to check this new special case, which is what this
> patch set does today.  That means we're going to be looping through
> twice for any call that could fail if one is mseal'ed. This includes
> munmap() and mprotect().
>
> The impact will vary based on how many vma's are handled. I'd like some
> numbers on this so we can see if it is a concern, which Jeff has agreed
> to provide in the future - Thank you, Jeff.

Yes please. The additional walk Liam points to seems to be happening
even if we don't use mseal at all. Android apps often create thousands
of VMAs, so a small regression to a syscall like mprotect might cause
a very visible regression to app launch times (one of the key metrics
for Android). Having performance impact numbers here would be very
helpful.

>
> It also means we're modifying the behaviour of those calls so they could
> fail before anything changes (regardless of where the failure would
> occur), and we could still fail later when another aspect of a vma would
> cause a failure as we do today.  We are paying the price for a more
> atomic update, but we aren't trying very hard to be atomic with our
> updates - we don't have many (virtually no) vma checks before
> modifications start.
>
> For instance, we could move the mprotect check for map_deny_write_exec()
> to the pre-update loop to make it more atomic in nature.  This one seems
> somewhat related to mseal, so it would be better if they were both
> checked atomic(ish) together.  Although, I wonder if the user visible
> changes would be acceptable and worth the risk.
>
> We will have two classes of updates to vma's: the more atomic view and
> the legacy view.  The question of what happens when the two mix, or
> where a specific check should go will get (more) confusing.
>
> Thanks,
> Liam
>


Return-Path: <linux-kselftest+bounces-1328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE6F807A35
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C891F218FB
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB39E6F62E;
	Wed,  6 Dec 2023 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLsQjd6i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C80D5F
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 13:14:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso282461a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Dec 2023 13:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701897251; x=1702502051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmJEDBzKxyQU9MCwcJin0j3ArzElELYr7Bhn9rZHDMc=;
        b=HLsQjd6is8o1mLTgKgynRGGnavRhRCjDYmyDeS5fOmPhbbkV9ieLR5oyJDZ4JH1Bhy
         /tdnLN41SfG+6hv1kSIQtl2/t8Lt0/lGUjlFdZCO0K8CH5gAMqEkYpDn4doFV7eGr3/w
         5Iq9imXpSmWj5cVoPhnxliChrNdI3fySwk5P/ql2pEWIfhDapvUiIG/N9Ru0uCocL2rh
         31v7cCkSPZkmolPrPZcJBnxCPe5IhGJsWg8UhTwTW3L1VeKPUV9y0/U8e14fufjLFYc2
         WuoCQ+yldbFB+Y+CLSR4rnLG55r+4sOrbcDDimqxZk+WW34JOZ9lcWmPw5/W6AtZrz54
         v8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701897251; x=1702502051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmJEDBzKxyQU9MCwcJin0j3ArzElELYr7Bhn9rZHDMc=;
        b=qTGlX3DU1eU3+HB8Jx3QJvrHrS0bI2jrXGlpvuod32GPQFZrdLkhDPCrCsVihdo17t
         sowH+jGZsczLB/+sHYpnQwrmTjbfQdxBqgvTxsuok6xG268i2WWE0OSkmGwh1AvZfvNu
         tA7NPVtmZ9aWAgiaVLM2HGPEEoIBzXDZrvUmyjiwL9tkUj96g7TigybvWLxOBJCnpBlc
         NyVgYh1bp5nKfnBOhrHwSYvF4nhqQwTcdGkVvnlP3GQll76X74fD6HomT2MVtnFfgFdL
         GdUe2ydCRpXt616TVwebQyoL06O5dndt0YEgVtLwFYVfcgF0mmrAGvwXAVtcSF+5i4r2
         K1Fw==
X-Gm-Message-State: AOJu0Yz/uPtoOiAEvNwidU2zHTm2cukmkf+4Mo9YqOZhPfGTjwliPnjr
	f2q02dGtRW0S2bnzfZgSPs5zvcmBpXjEeDjf5sXPlQ==
X-Google-Smtp-Source: AGHT+IGdUJ0U7LGEKJjGqt5itynfcSrlXa/hzW69+tBQz3ZKJeFsQ9wcSARFzKG7Hzt4JesxN71jS11/3dhzFfPH9sA=
X-Received: by 2002:a17:906:3518:b0:a19:a19b:78b1 with SMTP id
 r24-20020a170906351800b00a19a19b78b1mr730768eja.116.1701897251403; Wed, 06
 Dec 2023 13:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-7-nphamcs@gmail.com>
 <ed2792de-24cc-4037-9ee1-966cc07df57a@linux.dev> <CAJD7tkbiWqXs1PEZjMHO0gj5uSaaB-KNUNCiUz25MuPvzeb=wg@mail.gmail.com>
 <CAKEwX=M8YThH8qOdHt5TV1E4PCiw2FSv7815O3fhqXNVMt5ezg@mail.gmail.com> <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
In-Reply-To: <CAKEwX=OkZsPiv-A3Rg7Wh2TKcf0aKd-1Yi9wRyEzJK6o9=zXQA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 6 Dec 2023 13:13:35 -0800
Message-ID: <CAJD7tkZb71Tr=se96hrtEWc5oXXwdYOLMayNkkiP1ymcKBjNig@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] zswap: shrinks zswap pool based on memory pressure
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	cerasuolodomenico@gmail.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, chrisl@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 11:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> [...]
> >
> > Hmm so how should we proceed from here? How about this:
> >
> > a) I can send a fixlet to move the enablement check above the stats
> > flushing + use mem_cgroup_flush_stats
> > b) Then maybe, you can send a fixlet to update this new callsite?
> >
> > Does that sound reasonable?
>
> I just sent out the fixlet. Yosry and Chengming, let me know if that
> looks good. Thank you both for detecting this issue and proposing the
> fix!

The fixlet looks good, and Andrew already took care of (b) before I
could send a followup fixlet out :)


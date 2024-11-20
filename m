Return-Path: <linux-kselftest+bounces-22375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD039D4135
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 18:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE421F2277C
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642041AFB31;
	Wed, 20 Nov 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obHVI5SC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699B749C
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124039; cv=none; b=LSBvFsza/KeiYqlR5jNVPs1KPKPqwAM6wYzeK87T3lSfx5f6EWMSua/ugxQoCZXka6pMZllF7ouG6D7wl7q4aFhGmfOPEeg6eqNErTo6Tg/VkIwTtg5L3sbaSvjckkXtbVIaebFioNLL3aPp+SW6oWUNbF5T4r2on/QGUAlII/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124039; c=relaxed/simple;
	bh=Qpu/AFEa2uG9HdS1pBVJ6cUxEzFgxChSm6OIAK9vj0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnmgltBpLqUqMRqGbJPaF76sXuomrUmIx5LJyy4eGXP5fZn1Xo+gMBb8LQR0m7rNjaLz6apQ6AvSYdpa9Hd7fbT6CuxVhESaKw+gnEdbnwjmzuO5bB+3r85bRDckIvVGFRJPRkc/ky0IuPt7tVkpk4jDSOjmi/cVFfKX1TLesFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obHVI5SC; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eebae6f013so17008667b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732124036; x=1732728836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYCCxRwoo4/e9pvHHukibz0lUEYL/K5Rpqldo2LsKi0=;
        b=obHVI5SC7ryDI3ZPz/Lt1cMnmqG1LNQ1B39f1RAePE4ygf1p8k76SIv2MQe3G5bY77
         vwZTERRU592Rt/qpSDFw0+GD/nvAc5TWGbN9Vwv6KQmyB70SYqhxGyRjJ3uqihyhsCX4
         /e69eLbgEGx2FBIX8D4uDBWuFrBQ1Sdwu/IwBydDNV1C0nRoMlcO8OTnBmrcUPvtEKS+
         a/Acmeh7QV3orGYhTO1ySwVo47Pchsc7+T/7McZD5JW//ry0YfMpiqraa1QyRk476SFe
         Avbzkk0VN3wxBsYSgEikCHlUED/MUyncXLk6OIRB/HOAb4inj8qsWpU6wlkIw62ZihF4
         h12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732124036; x=1732728836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYCCxRwoo4/e9pvHHukibz0lUEYL/K5Rpqldo2LsKi0=;
        b=HgoXViUrY8Eh1Mp8Oaz63hFnx4Kr2F+zEsS2hFXi3sYOC8mVvKALBZeZUjmqW2Tz8M
         Gwa73N/sJHFb/Rk80XYGqBYMGCTC7vNN8uFK6acqmj/vN4YTSCgVelmbOqskhqRCJi/M
         0ke5K1V3XUCkaPsaeHKu3CVz8mESrzuVOLhdv8l6JoTJLt4vkvwMoiC/kDTFi99lCF8N
         NOxRJZf4aWKQ3y/T76q1pOBQxKkbK+OusWbwe5eapdEDDDuUU9F3/lrlyVubzVgCF4yS
         DuLYpq1O38U72123xcyJONdldrEIwSGUHBMAB7RUinhstJ1Uj/BnIZvFFrpIRwEY9cUL
         8lyw==
X-Forwarded-Encrypted: i=1; AJvYcCVwAlAJtimtu9HFjszf7krRIpUEixnzlKvzYG4u4yGI8zOjEG9t/nstVObuwjPrbtYg1Cq1nZDRNEe3+ur12I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIk222JNxGbeC4ydtDF70CneEAGuzp+D9OnvjqpIJyv1lFIHpM
	sajS9uQ9kLqqknupW/EWmrtfx5Wo333xrNOVUMq89xnZAFa9dI+xgoQPt1OmX5uIlXUaI4tqnz+
	NUaANXioE8Cwx/LgHmfD/JHQ2pLMz1NtlrtBE
X-Google-Smtp-Source: AGHT+IHXzlZzV1HDFKFSLMAjhmGRty1hJSXHMpkrUSLDMTXo54lPb8SEMTegLCJ8chntFke9JfMyqGqm2lxUKSFEZ3Y=
X-Received: by 2002:a05:690c:4911:b0:6ea:5da9:34cc with SMTP id
 00721157ae682-6eebd141ed6mr33197707b3.7.1732124034964; Wed, 20 Nov 2024
 09:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com> <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
 <CAJD7tkZDSZ4QjLhkWQ3RV_vEwzTfCMtFcWX_Fx8mj-q0Zg2cOw@mail.gmail.com> <CA+CK2bC-jNxUgp9JB=H9GsMu1FrxyqXxCe_v1G-43A1-eed0VA@mail.gmail.com>
In-Reply-To: <CA+CK2bC-jNxUgp9JB=H9GsMu1FrxyqXxCe_v1G-43A1-eed0VA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 20 Nov 2024 09:33:18 -0800
Message-ID: <CAJD7tkaYuJpxijOp6se+mWHO6djaz_7KaoXjf=Rdo6nJubwB2w@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:14=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, Nov 19, 2024 at 2:36=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Nov 19, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 1:23=E2=80=AFPM Roman Gushchin <roman.gushchi=
n@linux.dev> wrote:
> > > >
> > > > On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > > > > On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > > > > Additionally, using crash/drgn is not feasible for us at this=
 time, it
> > > > > > > requires keeping external tools on our hosts, also it require=
s
> > > > > > > approval and a security review for each script before deploym=
ent in
> > > > > > > our fleet.
> > > > > >
> > > > > > So it's ok to add a totally insecure kernel feature to your fle=
et
> > > > > > instead?  You might want to reconsider that policy decision :)
> > > > >
> > > > > Hi Greg,
> > > > >
> > > > > While some risk is inherent, we believe the potential for abuse h=
ere
> > > > > is limited, especially given the existing  CAP_SYS_ADMIN requirem=
ent.
> > > > > But, even with root access compromised, this tool presents a smal=
ler
> > > > > attack surface than alternatives like crash/drgn. It exposes less
> > > > > sensitive information, unlike crash/drgn, which could potentially
> > > > > allow reading all of kernel memory.
> > > >
> > > > The problem here is with using dmesg for output. No security-sensit=
ive
> > > > information should go there. Even exposing raw kernel pointers is n=
ot
> > > > considered safe.
> > >
> > > I am OK in writing the output to a debugfs file in the next version,
> > > the only concern I have is that implies that dump_page() would need t=
o
> > > be basically duplicated, as it now outputs everything via printk's.
> >
> > Perhaps you can refactor the code in dump_page() to use a seq_buf,
> > then have dump_page() printk that seq_buf using seq_buf_do_printk(),
> > and have page detective output that seq_buf to the debugfs file?
>
> Good idea, I will look into modifying it this way.
>
> > We do something very similar with memory_stat_format(). We use the
>
> void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> {
>         /* Use static buffer, for the caller is holding oom_lock. */
>         static char buf[PAGE_SIZE];
>         ....
>         seq_buf_init(&s, buf, sizeof(buf));
>         memory_stat_format(memcg, &s);
>         seq_buf_do_printk(&s, KERN_INFO);
> }
>
> This is a callosal stack allocation, given that our fleet only has 8K
> stacks. :-)

That's a static allocation though :)


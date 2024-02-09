Return-Path: <linux-kselftest+bounces-4456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9F984F993
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDF928CC53
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B00768FA;
	Fri,  9 Feb 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLp5nqEp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53267317B
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496006; cv=none; b=W9cVbixZ0C6a3fkrjPnU851G2Lur8MlEcuKc5kaX5PPeY8kZI7HQPGdUXBu++LzC7rh8cXj6jHxX2D5RC2uw83SuMdXy5Fejacs7CSU83YNlop8rC+2sck1go8m9gROE2c2Pafg0gsme9xfuOWUUPHY6c//nkKj6YMn0TTGxblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496006; c=relaxed/simple;
	bh=xSVANJ9Sul+6tG8IyWGYziNKbkjPAgWV/TLqpKmQNq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lW1YbcFbTaCDkU3M9QiDnHBjXrJXQuPEwlTUkkOBglE81FSUBvIq8b++jpYZJlPPHifKDnepBCoFrngKRhxsiQNy11tXdn69etpUK7iyV2VZrSf9sLsl711Zl/3PC59kdBaRYcS7IWxw9CRtc34eUtHFX6+1kFKOv9p/lI4MNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLp5nqEp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707496003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSVANJ9Sul+6tG8IyWGYziNKbkjPAgWV/TLqpKmQNq8=;
	b=TLp5nqEp+eqt4QTglDU5D1SgbzM/0lVlTydRQyBzjgsFE098vjFv/wf97iKHVjkKu6lrH/
	hq6wW+hZjbaVRF2jXul0VOWog4UONqR89ADfKG8A5v66RiyZrsf0U7vrpizhLKMPDiunLu
	AvvuIKJ5DdKqX23soB3MHPxDYr+N7B8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Ps6gBrysNNOMSs9uXSghGA-1; Fri, 09 Feb 2024 11:26:41 -0500
X-MC-Unique: Ps6gBrysNNOMSs9uXSghGA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3c027b6987so32358166b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 08:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496000; x=1708100800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSVANJ9Sul+6tG8IyWGYziNKbkjPAgWV/TLqpKmQNq8=;
        b=hh0+JXsidJlSriElgpGM6oZm3tJl0Spr9Pytr8mWVTrgxFrXw3uu3HOgjSsQS7lOMh
         uA3FKX/Dag+2hdmsvKo7rCcFD0H9+4WbjLiiqG233inNplR9LggfOL+tJsQtIbPlGqm3
         HXGGsVcxpeIsK+t0dxql2jYJdHlBmrEWnj+PJ6dcWua6yQhXa7ktwcaR8mpzYZehfadW
         oJtcwq9isUDQ1UNpH/1V9IToCdIlF4un0EiZR/F3hG05ReRIXa8FoCFRukQySIVb/RS+
         eu9VkSGelhU02v//xVV/9YF3TUiRayXHceCwGQiLO8fkQsJfXVsqWa7J+oIaLXWEgTTo
         WV6Q==
X-Gm-Message-State: AOJu0Ywk2sv1dnhWtOZXfDykbwI4ouJSCHwCJfiCQTxGSW7VBDXhapmY
	TBYJAc+/Soc835vxGJjqoKyDx+c8S5x1S1IKQ06Eyvk7kFyPU88ozL1x33L+U9zWJwK659yncAj
	lo09zMGZpvMXLkMfCx/IGOD9Ae2E8lvJohL807gyAyxursmkUJ0yNSetf/qURGbBaojltcbFhug
	/H/OwDKqLs406sEUYyHEklQn+nc95MsKHx1qBoDApk
X-Received: by 2002:a17:906:a3d6:b0:a37:e35b:9a3e with SMTP id ca22-20020a170906a3d600b00a37e35b9a3emr1642631ejb.40.1707496000243;
        Fri, 09 Feb 2024 08:26:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy61pDxReOPip14CkIUEYp+eoqOxBTFmJqAoTo/34APibzrj1ifuHurTTUgT36YYc88gUAGfXaSJOT9jT1nF8=
X-Received: by 2002:a17:906:a3d6:b0:a37:e35b:9a3e with SMTP id
 ca22-20020a170906a3d600b00a37e35b9a3emr1642604ejb.40.1707495999966; Fri, 09
 Feb 2024 08:26:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org> <87bk8pve2z.fsf@toke.dk>
In-Reply-To: <87bk8pve2z.fsf@toke.dk>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 9 Feb 2024 17:26:27 +0100
Message-ID: <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 4:42=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Benjamin Tissoires <bentiss@kernel.org> writes:
>
> > [Putting this as a RFC because I'm pretty sure I'm not doing the things
> > correctly at the BPF level.]
> > [Also using bpf-next as the base tree as there will be conflicting
> > changes otherwise]
> >
> > Ideally I'd like to have something similar to bpf_timers, but not
> > in soft IRQ context. So I'm emulating this with a sleepable
> > bpf_tail_call() (see "HID: bpf: allow to defer work in a delayed
> > workqueue").
>
> Why implement a new mechanism? Sounds like what you need is essentially
> the bpf_timer functionality, just running in a different context, right?

Heh, that's exactly why I put in a RFC :)

So yes, the bpf_timer approach is cleaner, but I need it in a
workqueue, as a hrtimer in a softIRQ would prevent me to kzalloc and
wait for the device.

> So why not just add a flag to the timer setup that controls the callback
> context? I've been toying with something similar for restarting XDP TX
> for my queueing patch series (though I'm not sure if this will actually
> end up being needed in the end):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?h=
=3Dxdp-queueing-08&id=3D54bc201a358d1ac6ebfe900099315bbd0a76e862
>

Oh, nice. Good idea. But would it be OK to have a "timer-like" where
it actually defers the job in a workqueue instead of using an hrtimer?

I thought I would have to rewrite the entire bpf_timer approach
without the softIRQ, but if I can just add a new flag, that will make
things way simpler for me.

This however raises another issue if I were to use the bpf_timers: now
the HID-BPF kfuncs will not be available as they are only available to
tracing prog types. And when I tried to call them from a bpf_timer (in
softIRQ) they were not available.

Cheers,
Benjamin



Return-Path: <linux-kselftest+bounces-4522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B538851C9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 19:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86BC82835B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 18:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429F3FB3E;
	Mon, 12 Feb 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQiKOKhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945543FB1E
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762071; cv=none; b=QZT43i5wHgVogZvM/6X4L8pHulfb9iPfP9dv1G57dUU9JizQiuJGtsbZVbOADV5QF+LZWoWEhKhdOC0kcsCr9iCpSedZB+ElBlSdHsNnD+e83bwtE58Jt7+lEve6+apNB8zsgwoYMDbepXJcTjHiYdNTgyJcskOAc3aWRVgFee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762071; c=relaxed/simple;
	bh=Quv90+T3dAOOagaLIeJ9QrwDVUG7gl85SK8F/SFSmzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4dgo7A8a1sgQWhSpRC4m3aSGMb8WniEiKu5urdbNDgE+v6aBK19wB4AsoWybZ2K+HnUs/tH+XZdplikI4fUxcTFgPNQkfUfzh+xqo6dOj3GHO+Z+5Po44Feg86oo7HVWrF9zLuEkijK403QFw3eIcSrzl8R9zopfJXuNP8b8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQiKOKhv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707762068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Quv90+T3dAOOagaLIeJ9QrwDVUG7gl85SK8F/SFSmzs=;
	b=KQiKOKhvLEjKM/85IY1noRxaFvvrK/LhrGmf+tlsqAB7bfRWsexvi7ogTiQS0pLOVz20wy
	0M9wvJYGeEjfkRYi/8CeY6t59CD0u1nT268sDCmnPtC3nN121hREFJEjpR90zeBHXoM2ER
	f0fDf0xT0IZtyyAnjw/MryJPaKYWjG4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-YXesRXuvMt2N_9iViPLLLw-1; Mon, 12 Feb 2024 13:21:07 -0500
X-MC-Unique: YXesRXuvMt2N_9iViPLLLw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d0cbf577e4so36271251fa.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 10:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707762065; x=1708366865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Quv90+T3dAOOagaLIeJ9QrwDVUG7gl85SK8F/SFSmzs=;
        b=UAoZgZ4DPA+yXvVhCpJDrRTpnTJ8JJqdeCfz8K4xKWg0A9C4OLExvWldEZhlyUROi+
         mcLM29hjbq8D3KC3t88mKVUTA9aGQ9wNHWc6YlZceujdU/HBGLfyjS4wer/khhRoF8BG
         MLcYb1fauRKnZ/oFeS8YrHPeY0HZGsawgqmLROCnANA0uvuFfxbxkxaRLLqqTieiiNZz
         GKjDiqkmkdE9x9DxYyatMgMGKpblEZ8cSnn4ziYsYkd+qMrlGWeJIARIjrwdYUNilPPQ
         +vIfmDdFBLMPb2EIA2Xf0DupoaMy+lT9sC2C0GdofA20uRiyDpqgP7OI1ivgLhJ2FqYF
         gfXg==
X-Forwarded-Encrypted: i=1; AJvYcCUwAJ9UGoWx8Js9rnJv3wrnh223AjtP5qwsCu0k3TjjbKvf3e6XRfJA5JxZp5EzVi/QcCLQ35XX8voKm7RYyl9RqeJ0I3akHAeG0Kb7hkrE
X-Gm-Message-State: AOJu0YzRJkz39odLDF1zcc/wvoIPlw7G2N/xM09ULF/1A4NzuuqgmsaM
	Un3AxJtriZ6z8x87HxNdFpveFVGKuQyBQnx0px1/DOR0KM7tam1+cgVCW/QCEJZWnKqXz6J5GXq
	KOiaZmECHHv8lMkvdHQ0gNpwLVSRduTasc1CgdIk8VL8z6XBo8G82/QRvJkVKzm5B7fhXuR0JRh
	EMkukGIOb9WAQ9YqKgiK4hp9AlO7ptR687J0avm+sP
X-Received: by 2002:a2e:9d02:0:b0:2d0:cc80:dcad with SMTP id t2-20020a2e9d02000000b002d0cc80dcadmr5146921lji.7.1707762065698;
        Mon, 12 Feb 2024 10:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVDBBNbKf4ImXQwE8JyZ3fQX074ArrUpqN5YepxpJCPLGSsPy5C7PupjtXSTP89q24mqDNrC0ALqCwbaA+eQQ=
X-Received: by 2002:a2e:9d02:0:b0:2d0:cc80:dcad with SMTP id
 t2-20020a2e9d02000000b002d0cc80dcadmr5146906lji.7.1707762065378; Mon, 12 Feb
 2024 10:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
 <87bk8pve2z.fsf@toke.dk> <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk> <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk>
In-Reply-To: <87r0hhfudh.fsf@toke.dk>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 12 Feb 2024 19:20:53 +0100
Message-ID: <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 6:46=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
>
> [...]
> >> IIUC, the bpf_timer callback is just a function (subprog) from the
> >> verifier PoV, so it is verified as whatever program type is creating t=
he
> >> timer. So in other words, as long as you setup the timer from inside a
> >> tracing prog type, you should have access to all the same kfuncs, I
> >> think?
> >
> > Yep, you are correct. But as mentioned above, I am now in trouble with
> > the sleepable state:
> > - I need to call timer_start() from a non sleepable tracing function
> > (I'm in hard IRQ when dealing with a physical device)
> > - but then, ideally, the callback function needs to be tagged as a
> > sleepable one, so I can export my kfuncs which are doing kzalloc and
> > device IO as such.
> >
> > However, I can not really teach the BPF verifier to do so:
> > - it seems to check for the callback first when it is loaded, and
> > there is no SEC() equivalent for static functions
> > - libbpf doesn't have access to the callback as a prog as it has to be
> > a static function, and thus isn't exported as a full-blown prog.
> > - the verifier only checks for the callback when dealing with
> > BPF_FUNC_timer_set_callback, which doesn't have a "flag" argument
> > (though the validation of the callback has already been done while
> > checking it first, so we are already too late to change the sleppable
> > state of the callback)
> >
> > Right now, the only OK-ish version I have is declaring the kfunc as
> > non-sleepable, but checking that we are in a different context than
> > the IRQ of the initial event. This way, I am not crashing if this
> > function is called from the initial IRQ, but will still crash if used
> > outside of the hid context.
> >
> > This is not satisfactory, but I feel like it's going to be hard to
> > teach the verifier that the callback function is sleepable in that
> > case (maybe we could suffix the callback name, like we do for
> > arguments, but this is not very clean either).
>
> The callback is only set once when the timer is first setup; I *think*
> it works to do the setup (bpf_timer_init() and bpf_timer_set_callback())
> in the context you need (from a sleepable prog), but do the arming
> (bpf_timer_start()) from a different program that is not itself sleepable=
?
>

Genius! It works, and I can just keep having them declared as a
syscall kfunc, not as a tracing kfunc.

But isn't this an issue outside of my use case? I mean, if the
callback is assuming the environment for when it is set up but can be
called from any context there seems to be a problem when 2 contexts
are not equivalent, no?



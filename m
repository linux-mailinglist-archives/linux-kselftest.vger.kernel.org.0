Return-Path: <linux-kselftest+bounces-4540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F797851F83
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 22:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBBC1F22245
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF904CB3D;
	Mon, 12 Feb 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGcHWXeS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F2481AD;
	Mon, 12 Feb 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773065; cv=none; b=d2LPdsQRkf7/M3OhaSySblsWUzFmshTV2GkK+KRAH/EkoYu/TE3XL/eH0Fdmc6X+fQVB28jiKo1D3JZrnIKxhjcJTXXvmqBSnhJ8IJp6led80tQfq0SZ4JHmxFCcs9POul0qMI0OZ7TrG98bDSlbVM3Ld/7Tl1hLeUkPz0ZDe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773065; c=relaxed/simple;
	bh=bxE29yGll33bT1hVGkhkpU2SSMDQ/72L2rqcmd5FkqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atLfTrauXL/V/yUprSgpr0obyKo8JRPLNOudTG1Va2f9xStq4rQ4q2iz0AFbamJ1C95IXopR5EIEu06j6WdcMNHMAg6xQqvCkWA/Dn49ToLd6JA7ZZN+jnsSRyuojx5RXyz59NV5TOhaz5LfdK8NHhBjMFsWvxoWlLYSJXtr6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGcHWXeS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b66883de9so2594926f8f.0;
        Mon, 12 Feb 2024 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707773062; x=1708377862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxE29yGll33bT1hVGkhkpU2SSMDQ/72L2rqcmd5FkqI=;
        b=NGcHWXeS4iFkAbyCmXmhwCNxDHcnvpI7Ty7W2/qXLcd2G7JUvaruPJ4siVDDBR+wAA
         TTiGB6ki1xKHlvqaa0VvVIwYU/QhTSABRBpxgmdQpRdPJkqauBUnyh4MaIjPucsmXcae
         Ki56aX6n92Al5ogmEVuNQAmm2G6Om8N7WkR4Tw7DPkLxzqiowrK1Zg8gFI60DnPu3+dA
         rjjVXgBcICKguHPRSZ1JV68OVFd3L5t/LspBUQ6EzpQ/HW+c7pMw3zNNM4VuWvI9L8Er
         ISFcGjoeZR9MAfraU6350kKKSS7mHmbqBtIZrsXsBUrx+jLFBfngBc8SRA0lwql4erri
         HTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773062; x=1708377862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxE29yGll33bT1hVGkhkpU2SSMDQ/72L2rqcmd5FkqI=;
        b=itSjiM0Xd0YhbWTD/WdZT8/Z2JygdYjwb9YVPU3dlRd+lAUowgFZND3l1sGOVr1dpp
         NfOalQnuW7smERzdnQzZZ3yx/wVlH2FaGqN5/zOvJIU80+5BagBLNd1SKCgQeqtDv9Sz
         UcVkiYceKHK69D3ZDwtSJvdwfcv3i3g0blIf9EjTuIO1KS1Dw4/PmrWbamCYC31GoI8/
         IUFdb66v5Io7cOqGJ8lqB8lCxT78wrsLbOmLhr0RDB5+Yaq+OtPfb/l229Q4t2MCM/YS
         fm+CTwSz/7Gkq8ScAZNvhG2U41yu3+BtizaQuXvg/yaKK71SSpKOfBqU5/ynlsBH6kn6
         tQew==
X-Forwarded-Encrypted: i=1; AJvYcCUOef7VnbKhReZZXtw3GMjld0QsvXvQjkuyuuT2XombRWRfVp5N9OpPSIY1WzIhpsJ5E1cSSGt55Q92NMssXA/gvd5HywVQed6SaaqsE9NaTV6cPaGcTYMELvQR00PwaKQEHYxEjKFxPW3MVDMgkIV+6eM7uDKe+ztFl/7XpzJkY9RaQlUvWCGJ5+IWyRk9x235jp5ogfaNvWp9e7BUkuZJvYcAEeJ/F/Axifo/SzhMsWYyjqcY1MWiHFA=
X-Gm-Message-State: AOJu0YyWL2COuTSVzzMBhEv/ke4ztxMpgPV0OlFskYMVGBJqsYcpE0HA
	ZYClnIZkBk7oZ4fz4DoeMJESPQDLi/jA9QKzjLXc6dIE0Ug95r93LqZTBwjXa8LKgHc7mVA75op
	rgCRtE1ZZ6WQcEljxGO5TYlA0pmU=
X-Google-Smtp-Source: AGHT+IGQJsk4wTT+E8TFIHtU+/AM8HkdWJmfCDLAlARodYmBzIu5z3aknMyj7upwGILqyPN3v8jpKhnatN3rHCwCR5Q=
X-Received: by 2002:a05:6000:148:b0:33b:8782:985a with SMTP id
 r8-20020a056000014800b0033b8782985amr1875411wrx.21.1707773061559; Mon, 12 Feb
 2024 13:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-hid-bpf-sleepable-v1-0-4cc895b5adbd@kernel.org>
 <87bk8pve2z.fsf@toke.dk> <CAO-hwJ+UeaBydN9deA8KBbgBiC_UCt6oXX-wGnNuSr8fhUrkXw@mail.gmail.com>
 <875xyxva9u.fsf@toke.dk> <CAO-hwJLvEGNRXc8G2PR+AQ6kJg+k5YqSt3F7LCSc0zWnmFfe5g@mail.gmail.com>
 <87r0hhfudh.fsf@toke.dk> <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
In-Reply-To: <CAO-hwJLxkt=THKBjxDA6KZsC5h52rCXZ-2RNKPCiYMHNjhQJNg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 13:24:09 -0800
Message-ID: <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:21=E2=80=AFAM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Mon, Feb 12, 2024 at 6:46=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
> >
> > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
> >
> > [...]
> > >> IIUC, the bpf_timer callback is just a function (subprog) from the
> > >> verifier PoV, so it is verified as whatever program type is creating=
 the
> > >> timer. So in other words, as long as you setup the timer from inside=
 a
> > >> tracing prog type, you should have access to all the same kfuncs, I
> > >> think?
> > >
> > > Yep, you are correct. But as mentioned above, I am now in trouble wit=
h
> > > the sleepable state:
> > > - I need to call timer_start() from a non sleepable tracing function
> > > (I'm in hard IRQ when dealing with a physical device)
> > > - but then, ideally, the callback function needs to be tagged as a
> > > sleepable one, so I can export my kfuncs which are doing kzalloc and
> > > device IO as such.
> > >
> > > However, I can not really teach the BPF verifier to do so:
> > > - it seems to check for the callback first when it is loaded, and
> > > there is no SEC() equivalent for static functions
> > > - libbpf doesn't have access to the callback as a prog as it has to b=
e
> > > a static function, and thus isn't exported as a full-blown prog.
> > > - the verifier only checks for the callback when dealing with
> > > BPF_FUNC_timer_set_callback, which doesn't have a "flag" argument
> > > (though the validation of the callback has already been done while
> > > checking it first, so we are already too late to change the sleppable
> > > state of the callback)
> > >
> > > Right now, the only OK-ish version I have is declaring the kfunc as
> > > non-sleepable, but checking that we are in a different context than
> > > the IRQ of the initial event. This way, I am not crashing if this
> > > function is called from the initial IRQ, but will still crash if used
> > > outside of the hid context.
> > >
> > > This is not satisfactory, but I feel like it's going to be hard to
> > > teach the verifier that the callback function is sleepable in that
> > > case (maybe we could suffix the callback name, like we do for
> > > arguments, but this is not very clean either).
> >
> > The callback is only set once when the timer is first setup; I *think*
> > it works to do the setup (bpf_timer_init() and bpf_timer_set_callback()=
)
> > in the context you need (from a sleepable prog), but do the arming
> > (bpf_timer_start()) from a different program that is not itself sleepab=
le?
> >
>
> Genius! It works, and I can just keep having them declared as a
> syscall kfunc, not as a tracing kfunc.
>
> But isn't this an issue outside of my use case? I mean, if the
> callback is assuming the environment for when it is set up but can be
> called from any context there seems to be a problem when 2 contexts
> are not equivalent, no?

I agree that workqueue delegation fits into the bpf_timer concept and
a lot of code can and should be shared.
All the lessons(bugs) learned with bpf_timer don't need to be re-discovered=
 :)
Too bad, bpf_timer_set_callback() doesn't have a flag argument,
so we need a new kfunc to set a sleepable callback.
Maybe
bpf_timer_set_sleepable_cb() ?
The verifier will set is_async_cb =3D true for it (like it does for regular=
 cb-s).
And since prog->aux->sleepable is kinda "global" we need another
per subprog flag:
bool is_sleepable: 1;

We can factor out a check "if (prog->aux->sleepable)" into a helper
that will check that "global" flag and another env->cur_state->in_sleepable
flag that will work similar to active_rcu_lock.
Once the verifier starts processing subprog->is_sleepable
it will set cur_state->in_sleepable =3D true;
to make all subprogs called from that cb to be recognized as sleepable too.

A bit of a challenge is what to do with global subprogs,
since they're verified lazily. They can be called from
sleepable and non-sleepable contex. Should be solvable.

Overall I think this feature is needed urgently,
so if you don't have cycles to work on this soon,
I can prioritize it right after bpf_arena work.


Return-Path: <linux-kselftest+bounces-4578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64AD853AD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183F21F227BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4333E5FDD8;
	Tue, 13 Feb 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtrd7/o0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7C6086A;
	Tue, 13 Feb 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852238; cv=none; b=UqtTi6N+xsMaonvTnk/+INDSXreRLQoSbaYxRJVQw+NVd+O8c1hW4evHCqSehRLA9+CHglPN4n1WKFdNk5YHWuOR0HOw/dfLYPPhD2rQoh2rsKr3YRNJqmiDseNtMY1W1roaoMrD+YGdvxHVMMA7q7SmjslDBqUd74KJMRZ69z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852238; c=relaxed/simple;
	bh=0B3uRJhmyT1XuLMISGiYjXxLVeAFL5LNdwOdq4xlDX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2pc8JAiT8bSpfTcWWuUVlwQtmNNdUCuPa02JLCiEPBcwiH+C7XgTA/9yPPYIB2y03K940WWvhNp0To8CqJP7y8EBmX2ARahN97RiHRDDHrSFKVwOaGESKwZwV4U5eqagmFn1FN6kIt5sqbRYa0cMWbRomGdv9yC7gEvjrBxerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vtrd7/o0; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so6256457a12.1;
        Tue, 13 Feb 2024 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707852234; x=1708457034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B3uRJhmyT1XuLMISGiYjXxLVeAFL5LNdwOdq4xlDX4=;
        b=Vtrd7/o0MHexn+sVI9y4b7W1DOy41qDcgXz8TtOEU8F/zSjkBQ0WdS827M+l6tt5iz
         /yh3fBBDHWpAJJr6polkJJmDOlE0pprPg9GDx0RrsU6gpWoF0tRmALOkWSCjTAb/rmPq
         HEf61L1TQhbKjFnXdUkFEkuWyBEdhDMXLvoyPoKVxxRljQOrmHl9z0TjxEeWmCC3EYfR
         jrhgB+mt6Cjj4vzIaXUSrWiiSeBXr8rYo5WfBWhbCsS9v8c5QzVBUZEl8H9U4OWwhow4
         YbxwJVBqDIMezyBdMCP6Q/8uwZ7tYInc0x9RX3JzCmNltU4/IFvzZnvf0j4P22l/X9aV
         WA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852234; x=1708457034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B3uRJhmyT1XuLMISGiYjXxLVeAFL5LNdwOdq4xlDX4=;
        b=O7SHAgAl5wgOKH18AYNvGnREaz1q4Gaw4eSX9OZpqZb5JcZmfx7sQRG6SF8m5hCVbQ
         YtmAOrYanPyUAR6+073Hff+wXFQ7JeQEjCDUjZVb4O+tQprPwo8sVCpRIwQHhxLMYQju
         4pKxX0zpOUoGc0MPIv/T9f6TcZzQHC5sogs3fVhPEDd8zOYU2plpbeRKW0MCgED6GMDi
         i+Txhuqv7Xj9cNqPRJfY94dSSC7VnWNLhHEiu1JdgNcmdhfvZQU6vVKfRAvmP3ystVuN
         r8J8SnMnIWXhzwqaCNR+KR3NSF5H6sg6rXQ5UbIZ4pT0Iek8FbwjzlZ5Yplxc+TVJE/z
         Se5g==
X-Forwarded-Encrypted: i=1; AJvYcCVUIUzBe3f9e6VMcrM3u09GS8YnhWCcxWCtbx/S7f+PvNqYQsPPFH57LHGdIXHxxGuoVRmzQ3Ve0qrnK6G3+RYcEv7YD31AU1ydesBEUT2JsDvxan9nER0gJNvV2f2b9I09VZzW5VxGLarFPcvxOVinSKLQmttlUXBVLNHUywoFFC+Yy3Y2zUdEXyzAftoPdYV7FADlPWADo+4KMLD/MDn5SFJkQMAD4X+CQr9dgJM6d0ECMn3hTKFhWOw=
X-Gm-Message-State: AOJu0YzwNQCQUSPHzfAIO5Sr3ZcKFEf+uXNvNgzu8tJ2WwIgzJoZbXBl
	iPPfcGFM44bHpU6xkqniKQI0AnU+MJLLjCCyK50l4hg8r9Q2LzOhAdexIm4hh8SzXsJzowFioFN
	RymorSENgnirFuzWHsYYjVfwHXqY=
X-Google-Smtp-Source: AGHT+IHNWC5dzy02TygLZzR+lN/Pi5k41JXMUom8PqU9BAxHkbw6tqD9WrKBNP04934vbG+r6JwgS+Mw7fhMEQnLQxg=
X-Received: by 2002:a17:906:aad6:b0:a3c:a655:3a3c with SMTP id
 kt22-20020a170906aad600b00a3ca6553a3cmr210638ejb.16.1707852234355; Tue, 13
 Feb 2024 11:23:54 -0800 (PST)
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
 <CAADnVQKt7zu2OY0xHCkTb=KSXO33Xj8H4vVYMqP51ZJ_Kj1sZA@mail.gmail.com> <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
In-Reply-To: <zybv26nmqtmyghakbebwxanzgzsfm6brvi7qw3ljoh4dijbjki@ub7atnumzuhy>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Feb 2024 20:23:17 +0100
Message-ID: <CAP01T75Giw_5j0RXaaxX0rDzCcXXZgmHrw7QZ_Ayib8rHgunBQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/9] allow HID-BPF to do device IOs
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 18:46, Benjamin Tissoires <bentiss@kernel.org> wrote=
:
>
> On Feb 12 2024, Alexei Starovoitov wrote:
> > On Mon, Feb 12, 2024 at 10:21=E2=80=AFAM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 6:46=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgen=
sen <toke@redhat.com> wrote:
> > > >
> > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> writes:
> > > >
> [...]
> > I agree that workqueue delegation fits into the bpf_timer concept and
> > a lot of code can and should be shared.
>
> Thanks Alexei for the detailed answer. I've given it an attempt but still=
 can not
> figure it out entirely.
>
> > All the lessons(bugs) learned with bpf_timer don't need to be re-discov=
ered :)
> > Too bad, bpf_timer_set_callback() doesn't have a flag argument,
> > so we need a new kfunc to set a sleepable callback.
> > Maybe
> > bpf_timer_set_sleepable_cb() ?
>
> OK. So I guess I should drop Toke's suggestion with the bpf_timer_ini() f=
lag?
>
> > The verifier will set is_async_cb =3D true for it (like it does for reg=
ular cb-s).
> > And since prog->aux->sleepable is kinda "global" we need another
> > per subprog flag:
> > bool is_sleepable: 1;
>
> done (in push_callback_call())
>
> >
> > We can factor out a check "if (prog->aux->sleepable)" into a helper
> > that will check that "global" flag and another env->cur_state->in_sleep=
able
> > flag that will work similar to active_rcu_lock.
>
> done (I think), cf patch 2 below
>
> > Once the verifier starts processing subprog->is_sleepable
> > it will set cur_state->in_sleepable =3D true;
> > to make all subprogs called from that cb to be recognized as sleepable =
too.
>
> That's the point I don't know where to put the new code.
>

I think that would go in the already existing special case for
push_async_cb where you get the verifier state of the async callback.
You can make setting the boolean in that verifier state conditional on
whether it's your kfunc/helper you're processing taking a sleepable
callback.

> It seems the best place would be in do_check(), but I am under the impres=
sion
> that the code of the callback is added at the end of the instruction list=
, meaning
> that I do not know where it starts, and which subprog index it correspond=
s to.
>
> >
> > A bit of a challenge is what to do with global subprogs,
> > since they're verified lazily. They can be called from
> > sleepable and non-sleepable contex. Should be solvable.
>
> I must confess this is way over me (and given that I didn't even managed =
to make
> the "easy" case working, that might explain things a little :-P )
>

I think it will be solvable but made somewhat difficult by the fact
that even if we mark subprog_info of some global_func A as
in_sleepable, so that we explore it as sleepable during its
verification, we might encounter later another global_func that calls
a global func, already explored as non-sleepable, in sleepable
context. In this case I think we need to redo the verification of that
global func as sleepable once again. It could be that it is called
from both non-sleepable and sleepable contexts, so both paths
(in_sleepable =3D true, and in_sleepable =3D false) need to be explored,
or we could reject such cases, but it might be a little restrictive.

Some common helper global func unrelated to caller context doing some
auxiliary work, called from sleepable timer callback and normal main
subprog might be an example where rejection will be prohibitive.

An approach might be to explore main and global subprogs once as we do
now, and then keep a list of global subprogs that need to be revisited
as in_sleepable (due to being called from a sleepable context) and
trigger do_check_common for them again, this might have to be repeated
as the list grows on each iteration, but eventually we will have
explored all of them as in_sleepable if need be, and the loop will
end. Surely, this trades off logical simplicity of verifier code with
redoing verification of global subprogs again.

To add items to such a list, for each global subprog we encounter that
needs to be analyzed as in_sleepable, we will also collect all its
callee global subprogs by walking its instructions (a bit like
check_max_stack_depth does).

> >
> > Overall I think this feature is needed urgently,
> > so if you don't have cycles to work on this soon,
> > I can prioritize it right after bpf_arena work.
>
> I can try to spare a few cycles on it. Even if your instructions were on
> spot, I still can't make the subprogs recognized as sleepable.
>
> For reference, this is where I am (probably bogus, but seems to be
> working when timer_set_sleepable_cb() is called from a sleepable context
> as mentioned by Toke):
>

I just skimmed the patch but I think it's already 90% there. The only
other change I would suggest is switching from helper to kfunc, as
originally proposed by Alexei.

> [...]


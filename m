Return-Path: <linux-kselftest+bounces-33293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A68ABB1B7
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 23:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41433AEB97
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3921FDA61;
	Sun, 18 May 2025 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aX5vUadI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA301EB18A
	for <linux-kselftest@vger.kernel.org>; Sun, 18 May 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747604059; cv=none; b=ZQLGFGpiaLPX1/NHBgpXav0987gI1GPAyNE7cpmO82owJ8EURVmV751KVGbGC9hYmNyNXWLvQwWVlHJ3G0EX8SIgrYj4AX74X1Ocl8pa25iPtoPQlb5qzYiT94po01tllXXjy4lHfyQJJ2avT09zcrvjY4S5nwJ7HOOmJbmgE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747604059; c=relaxed/simple;
	bh=MVyWvTH9jezrYGixpYmB8VcITaczqnk77BRhuiSVPIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGj9zUubSYoGjK2hgjP+EQSgANw//HRZMx4oagc/YOXd9OrBSsllbPFpc7f1mZuBskvbdhi5SOvcRLiiTkNcKJmL0U+SvY+EHLvNufZ6gSOF6LA9m6tlYa5lT89jNzDGOjaBak4+v7GEDTAgBVQ01hGVelLA2eRaNpbeVw/I6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aX5vUadI; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so3311533276.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 May 2025 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747604056; x=1748208856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQP7kiEFeXieUYHTQOWlMajO9SS2h9UcfNmGDRaBXeQ=;
        b=aX5vUadIzIV8ASEorrYerOBh7+o83iuc5x/ndhc0fQmonqniSuI9umaiKZxSIryMcj
         pCZN2rcwbp58rU7iUbuKcLsLE70NyHEBJXI62t9OTeuKcJqyA/6Zi8v+8ost8toBFBX+
         nvLqwnDHcJCjlKa6AN5EPV+hf2r7AykRaEfH9nFdMubumAaFS8RpPgPtp8FUdQQlI7cu
         Kz89u9LK/j4BwPFHWn6Mhdq9YGo9bxcTQa59HwgZyj+zVFh3ZhCgChFySWBSwgk6U0FV
         SvKV91Y/kecm+kxvZDX+9CtxV1YQaHOJRsWQwOWsOvm4gBtQt7KspTl5g4b3T5r30Oel
         ygyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747604056; x=1748208856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQP7kiEFeXieUYHTQOWlMajO9SS2h9UcfNmGDRaBXeQ=;
        b=uQbdQw5aRAGz+hqkdjEkpfx47x61Cd9FETawuSpFo6Df8r5m0tis7RRnb5tBY81wLT
         s4kaQkpIUUsRyiFOh2FhwltJ2Qyu0iWVzDRc3xKIFm1FKs4aSoQFgIhgI44j7jOj+w7o
         7kGxN2s9PzIIMwRgQBc7lIUWFUsnMvp0CzhXaXQ1REzm+4JU3nldYE0VQuy3yGH+XEp2
         eIrX87v0NepGQHKF9kHOjod/pd3UAJwIji36lBtVZyHhIfMancXi0U1rG2Mz+a1puGFN
         vucuMzgMmOi6S8IGc7T9IJRoZGxhtcZ7pFhcEON++Y/B2FkJK/Udn3QfWEZtSKnfTS47
         JIRw==
X-Forwarded-Encrypted: i=1; AJvYcCVfGZw/wdueXqguyRh3QEe9j6rv+f1VlUAi2IIfEn/eklI73U5u8auO9Re0n2iKu7qVUuACkfeA+hjS1de5f2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJUnTZlHOAZRq1x7LW3LnzVmdSumjhvoBrFwaQpj5jNVMn8yqm
	dNUBVCLGNR60qm1p5mJKz5y0+96UoyRo/5Z/lJkj4l4GRqACablSukxUpN7H5Oxx2zza3+l2GIc
	S6+8OJcXoSq8VC9roXEb2gujf0oU5HdOmD+IuNcX9
X-Gm-Gg: ASbGncuzq0WIexQnDdctWFtnx8RW4xWJERq8zvLysY2PBYgqs56KIdn7Ji9WOFvermy
	ZLITHwe50Y61hQVzZHM4kpR3eQ+0CDr0HkuWT8QfwqKMnqaDEr9cRt2C7XZli0zTFP5iizrHBDV
	5zCv3qQnCQyDsyc76jAGoIYuyLznRHbV98dEVKsodiwME=
X-Google-Smtp-Source: AGHT+IE4xhc4enZwnp333lRGkDvOTlvAzIVwQODufuLGxxB3SU2BQ2IFplj8HM2L9kwEdXZjW5DSrE/jizotZyc82E8=
X-Received: by 2002:a05:6902:1201:b0:e78:f901:6074 with SMTP id
 3f1490d57ef6-e7b6d39c8e6mr13141403276.5.1747604055898; Sun, 18 May 2025
 14:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
 <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
 <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
 <CAADnVQJ4GDKvLSWuAMdwajA0V2DEw5m-O228QknW8Eo9jxhyig@mail.gmail.com>
 <CAHC9VhTJcV1mqBpxVUtpLhrN4Y9W_BGgB_La5QCqObGheK28Ug@mail.gmail.com>
 <CAADnVQ+wE5cGhy6tgmWgUwkNutueEsrhh6UR8N2fzrZjt-vb4g@mail.gmail.com>
 <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com> <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
In-Reply-To: <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 18 May 2025 17:34:04 -0400
X-Gm-Features: AX0GCFtLeZnisw8iWe1mhoQFds0HugDTz8gkrQRoSC4fm6wSRan9ZFZmtDGOv3w
Message-ID: <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	code@tyhicks.com, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 11:52=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Sat, May 17, 2025 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On May 17, 2025 12:13:50 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sat, May 17, 2025 at 8:03=E2=80=AFAM Paul Moore <paul@paul-moore.c=
om> wrote:
> > >> On Fri, May 16, 2025 at 7:49=E2=80=AFPM Alexei Starovoitov
> > >> <alexei.starovoitov@gmail.com> wrote:
> > >>> On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > >>>>
> > >>>> I think we need some clarification on a few of these details, it w=
ould
> > >>>> be good if you could answer the questions below about the
> > >>>> authorization aspects of your design?
> > >>>>
> > >>>> * Is the signature validation code in the BPF verifier *always* go=
ing
> > >>>> to be enforced when a signature is passed in from userspace?  In o=
ther
> > >>>> words, in your design is there going to be either a kernel build t=
ime
> > >>>> or runtime configuration knob that could selectively enable (or
> > >>>> disable) signature verification in the BPF verifier?
> > >>>
> > >>> If there is a signature in union bpf_attr and it's incorrect
> > >>> the prog_load command will be rejected.
> > >>> No point in adding a knob to control that.
> > >>
> > >> I agree that when a signature is provided and that signature check
> > >> fails, the BPF load should be rejected.  I'm simply trying to
> > >> understand how you envision your design handling all of the cases, n=
ot
> > >> just this one, as well as what build and runtime options you expect
> > >> for controlling various aspects of this behavior.
> > >>
> > >>>> * In the case where the signature validation code in the BPF verif=
ier
> > >>>> is active, what happens when a signature is *not* passed in from
> > >>>> userspace?  Will the BPF verifier allow the program load to take
> > >>>> place?  Will the load operation be blocked?  Will the load operati=
on
> > >>>> be subject to a more granular policy, and if so, how do you plan t=
o
> > >>>> incorporate that policy decision into the BPF program load path?
> > >>>
> > >>> If there is no signature the existing loading semantics will remain=
 intact.
> > >>> We can discuss whether to add a sysctl or cgroup knob to disallow
> > >>> loading when signature is not present ...
> > >>
> > >> As mentioned earlier this week, if the BPF verifier is performing th=
e
> > >> signature verification as KP described, we will need a LSM hook afte=
r
> > >> the verifier to serve as an access control point.  Of course that
> > >> doesn't preclude the addition of some type of sysctl/cgroup/whatever
> > >> based access control, but the LSM hook would be needed regardless.
> > >
> > > No. New hook is not needed.
> >
> > It would be good for you to explain how the existing LSM hook is suffic=
ient
> > to authorize the loading of a BPF program using the signature validatio=
n
> > state determined in the BPF verifier.
>
> I already explained:
> .. a job of trivial LSM:
> if (prog_attr doesn't have signature &&
>    (task =3D=3D .. || task is under certain cgroup || whatever))
>   disallow.

I read that earlier reply as an example that covers a sample use case,
I didn't realize you were asserting that was the only approach you
were considering.  Perhaps that was the source of confusion earlier,
we may disagree, but I don't intentionally "twist" words; not only is
that rude, it's just stupid in public, archived discussions.

As I mentioned previously, we really need to see an explicit yes/no
flag from the BPF verifier to indicate that the signature on the BPF
program has been validated.  It really should be as simple as adding a
bool to bpf_prog_aux which the BPF verifier sets to true upon
successful signature validation, and then an LSM can use this flag as
input to an access control decision in a hook placed after the
verifier.  Are you objecting to the addition of a flag in the
bpf_prog_aux struct (or some other struct tightly coupled to the BPF
program), the LSM hook after the verifier, or both?  It would also be
helpful if you can elaborate on the technical reasons behind these
objections.

--=20
paul-moore.com


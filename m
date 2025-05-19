Return-Path: <linux-kselftest+bounces-33350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC4ABCAC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 00:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF6E1B61324
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 22:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA6821CA0A;
	Mon, 19 May 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNvPmYB/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91521C9E3
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693225; cv=none; b=tAMOMJUqjLZZwZCR28e/NK+f5UZnXwTXg0d8eTuXprblVrJ4brr//cgFt7JNnP75rB6LgtK71akG/Ubsu1FQKh3+m/+gsvSv+A9mhsHLEBmbNMHa/xLutnw2nd5gcTCAwomdlAC+YP9+hyR0b4NZFSUUUKu6gAgPA695kmYjDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693225; c=relaxed/simple;
	bh=uZ8XlymW+4rF1CnsOePthFc1cGC0345sXJLUZ4Dhuzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4XCLJYjQkm1I1JmQsdD6JZSTVi4r75Kx9EOWWeIalHvNPaelpEuOkJuBmySaAXJSjQC+vDI00p7v0tW1yEK0BPNCFOhAYtb8684r3vpT4dn8awKjceCuQ4bb6hiscDmVBLQsOXqWxfmIeV1ik48WZy0iTxNksLzFNm49f+f2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNvPmYB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD96C4CEFE
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747693225;
	bh=uZ8XlymW+4rF1CnsOePthFc1cGC0345sXJLUZ4Dhuzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FNvPmYB/BWE9H4pFifR9X4JmFNEKfwcxgDeIguIj5zAZKVk7BKI0J+2xg1E9KOLg5
	 7rXzPwj/YIhKUjsjgTPMxVgO1+LfTr/uJeV48TOWrOtDgjUnHT473ZgihBJIyUalqd
	 LQrpmeF10pD6ZFTGdg86YK6y4WgAFc74hg1wKhocZyIANc0AnGJGagJgpmJozYK2jN
	 +ELzpKsjWQJyxv/z5cGc+7xoul9LFqVo4np6BVa2cITCASyfIJvLDowtHPLcCcZJFW
	 Fl+TVqlb6VZiIxO4iCIbUx3qFFJiL0b4PORwjEduJnZQ3SpI4KFXCfsXXQ6l1kYpCc
	 Y5U59y7sAH+VA==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso46552156d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 15:20:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJMH83Hz1epL3rrrSbvbgbyqSO8lz4gMgD9IPA8naEimWW+66vahCet9TUkqog0dUKp2cXFk1I2dUk1IS1lVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyidnge47NPnlKvtvj8VivIKCRLNUZoAsWJV9zvOIVHLUHZvtUC
	X8SQRapcZSKFeXWOvS1gxt7ijqv2cdNaKHC/qAKafHeyPtmMpmDuoi1QkYjVRi4s3pu1gO0SfMA
	NzefY407Uf+K4NUBUpjoRLapmNzpKffsMOsZY/QkH
X-Google-Smtp-Source: AGHT+IHFHdg5xMZ80kod/4sph2VycUtK9qNlkm2FnJGRZxVkUq3RbTcJ3jP0aO1H2L1OVI6jAzpln5vFVLpAvKyKmlI=
X-Received: by 2002:a05:6214:d4a:b0:6e8:9086:261 with SMTP id
 6a1803df08f44-6f8b084b144mr244282176d6.3.1747693224025; Mon, 19 May 2025
 15:20:24 -0700 (PDT)
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
 <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com> <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com>
In-Reply-To: <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 20 May 2025 00:20:12 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com>
X-Gm-Features: AX0GCFtuAbaLmBw9yy0173D8s7LpAOVbxR9TeXNkvABXPMZF511wGOkzeZtojxE
Message-ID: <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
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

On Sun, May 18, 2025 at 11:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Sun, May 18, 2025 at 11:52=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sat, May 17, 2025 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On May 17, 2025 12:13:50 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Sat, May 17, 2025 at 8:03=E2=80=AFAM Paul Moore <paul@paul-moore=
.com> wrote:
> > > >> On Fri, May 16, 2025 at 7:49=E2=80=AFPM Alexei Starovoitov
> > > >> <alexei.starovoitov@gmail.com> wrote:
> > > >>> On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-mo=
ore.com> wrote:
> > > >>>>
> > > >>>> I think we need some clarification on a few of these details, it=
 would
> > > >>>> be good if you could answer the questions below about the
> > > >>>> authorization aspects of your design?
> > > >>>>
> > > >>>> * Is the signature validation code in the BPF verifier *always* =
going
> > > >>>> to be enforced when a signature is passed in from userspace?  In=
 other
> > > >>>> words, in your design is there going to be either a kernel build=
 time
> > > >>>> or runtime configuration knob that could selectively enable (or
> > > >>>> disable) signature verification in the BPF verifier?
> > > >>>
> > > >>> If there is a signature in union bpf_attr and it's incorrect
> > > >>> the prog_load command will be rejected.
> > > >>> No point in adding a knob to control that.
> > > >>
> > > >> I agree that when a signature is provided and that signature check
> > > >> fails, the BPF load should be rejected.  I'm simply trying to
> > > >> understand how you envision your design handling all of the cases,=
 not
> > > >> just this one, as well as what build and runtime options you expec=
t
> > > >> for controlling various aspects of this behavior.
> > > >>
> > > >>>> * In the case where the signature validation code in the BPF ver=
ifier
> > > >>>> is active, what happens when a signature is *not* passed in from
> > > >>>> userspace?  Will the BPF verifier allow the program load to take
> > > >>>> place?  Will the load operation be blocked?  Will the load opera=
tion
> > > >>>> be subject to a more granular policy, and if so, how do you plan=
 to
> > > >>>> incorporate that policy decision into the BPF program load path?
> > > >>>
> > > >>> If there is no signature the existing loading semantics will rema=
in intact.
> > > >>> We can discuss whether to add a sysctl or cgroup knob to disallow
> > > >>> loading when signature is not present ...
> > > >>
> > > >> As mentioned earlier this week, if the BPF verifier is performing =
the
> > > >> signature verification as KP described, we will need a LSM hook af=
ter
> > > >> the verifier to serve as an access control point.  Of course that
> > > >> doesn't preclude the addition of some type of sysctl/cgroup/whatev=
er
> > > >> based access control, but the LSM hook would be needed regardless.
> > > >
> > > > No. New hook is not needed.
> > >
> > > It would be good for you to explain how the existing LSM hook is suff=
icient
> > > to authorize the loading of a BPF program using the signature validat=
ion
> > > state determined in the BPF verifier.
> >
> > I already explained:
> > .. a job of trivial LSM:
> > if (prog_attr doesn't have signature &&
> >    (task =3D=3D .. || task is under certain cgroup || whatever))
> >   disallow.
>
> I read that earlier reply as an example that covers a sample use case,
> I didn't realize you were asserting that was the only approach you
> were considering.  Perhaps that was the source of confusion earlier,
> we may disagree, but I don't intentionally "twist" words; not only is
> that rude, it's just stupid in public, archived discussions.
>
> As I mentioned previously, we really need to see an explicit yes/no
> flag from the BPF verifier to indicate that the signature on the BPF
> program has been validated.  It really should be as simple as adding a
> bool to bpf_prog_aux which the BPF verifier sets to true upon
> successful signature validation, and then an LSM can use this flag as
> input to an access control decision in a hook placed after the
> verifier.  Are you objecting to the addition of a flag in the
> bpf_prog_aux struct (or some other struct tightly coupled to the BPF
> program), the LSM hook after the verifier, or both?  It would also be
> helpful if you can elaborate on the technical reasons behind these
> objections.

Neither the aux field, nor the hook are required because:

* If the signature is passed, it will be enforced, there are no
"runtime aspects" that need to be configurable here.
* What the LSM can specify a policy for is when a signature is not
passed, for this, it does not need an aux field or a signature or the
new hook, existing hooks are sufficient.

- KP

>
> --
> paul-moore.com


Return-Path: <linux-kselftest+bounces-33351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8488ABCB2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 00:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B8E3A99A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4EB21FF20;
	Mon, 19 May 2025 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fkFXWMWP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC561C9DC6
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695547; cv=none; b=FDip1MGCn4ld3EUEPXaMZ8Tr2vS3M7HOQFHj9lHFkZ3epQJ4xyJZuGldH4H9/ybnR+9qulYHCSIwAQwgFHUGJFVjG5Ddd1xNurITq7t5JtZVa930Wp2Pln/kRc6ajMZBhfvXj+lYLgQktg/AExPX3jIncq9IWCRxWCiWeaMolXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695547; c=relaxed/simple;
	bh=kjwn2ds7cCMY6u8Wc4J5VzC7zaszlbkpn9nqAdYGxDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLi6Ui4Dubtz3FfIicQJicTdB2wdrNWWLamDYrDV1oAotUGuh5QI3bTTzQr0vLUnseJFniwfwitzxhIAvr4NcFGlfp068HGdVqV1DTQjDeQiMjqlG/mRvSH0O1h47BQxoIxBtZ35vkzN+cDET1yw3a7E5MLDjSjFTyUEMIOfFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fkFXWMWP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70ca772985fso27882677b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747695544; x=1748300344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/RrrGUvS6xBKIaPYnBpsLPZNCZLvh9OPRpykB0Ulvk=;
        b=fkFXWMWP+yIpMcz3/yLRTMSF7KTizTvEe/1IMUwI59Galoy+CCGn3uSpuTHianl9pO
         I/qgZV5I35wpxgHkphUEYeObqMQnvBP++kkzVnYZOe9+lpgr1nrLt9TmqX/BT6EU8CfL
         NbrHe5U3+tJdb6yV4rmXX1YO4FBeHYpS+2NuiUZxyHKcOgC1ZrzkkeRrFmvVDmSy7Hkw
         OTgq8l49gun3sDfiqu0wWmwQtP9N+hDnFf+F9fyFgdKZQhtfUVMFUzrd2TeJHpECNber
         1eVc8FF6HZZADKUTU5AbB9rhzvskwxDGXDgoDqz9QSepKUJEXP9WDkU8M5BBBHvHcGxh
         tFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747695544; x=1748300344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/RrrGUvS6xBKIaPYnBpsLPZNCZLvh9OPRpykB0Ulvk=;
        b=JpS1ECEF6klGipXViPshnuB9HYHslSsdcVn6C/YbwVcDNTb7/9ksfp7OnDPb4Ck8Ab
         1lBWSf1Oub3lv8Edd2Gbnwr0BnowWjGIQftKPiGYZFaN9estZM0jtNUZU4zpv/1AjXdy
         N68sKQNrL0YpLFwx7NXbOJtmxy0MkDevuJycOwmOhkKHDkpkStyGhXnHO/d3B54MOfNu
         Afr3VNmwByOCOT1wM7nlFC3g0Ch6VP+ELF8G8A6iDEiVZVywEvVi/4sOk8jEbodX0w10
         nnAhjZLOEo+awXmdYEi62ub6ohJqNMLKvllS2fhnjGJViLcT5JFu+yBTgxxe1ogsCpo5
         Yn8w==
X-Forwarded-Encrypted: i=1; AJvYcCWOabpe+0My2O9Tt4DkMHgX4lCCK5ONFPQUe6WifY8VIjkMMt/FL0fAW/YcxNViwEc7O39SvIP1Ri0P8RgVVro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBrcf4IB+YVOSRl+BnAOq9dHggfogUilzOq1puIXO9qbTu12H
	jcmT05b9oJVueolJ0WEQKoHC1DVIbuJufOUktil7764UadKS9DW1+zCrxykB0z72NO9Y5EYHScD
	E6EBseelWYJV5b8OkKjwS9WyCHO1HDAv91eZOOLTl
X-Gm-Gg: ASbGnct2hC3d6b2eUpR1iVyQfdUJ0WThQkprC2eVKmh61qKVL7aRvFTfMinvzpi4g6z
	r+8uFxtEWznf7ULiBq69cRlVnZOz3gJGtvJ2FXUhAzD+GWyUb+OAuF/LThJNEScOAD4+Q7s7BOG
	E9OFwInlX71P9IcN0z4NjjoqF+VjRzRgOB
X-Google-Smtp-Source: AGHT+IFgdXMx0++rCnS34CKw8hZgyEs80zXpEEvuAIv/c65tdIdqmkcl1gyVl8f56p6dX5jzkRw5EVPCF2N2N1x3l0g=
X-Received: by 2002:a05:690c:4910:b0:70c:cbef:df27 with SMTP id
 00721157ae682-70ccbefe1f2mr105461797b3.14.1747695544492; Mon, 19 May 2025
 15:59:04 -0700 (PDT)
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
 <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
 <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com> <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 May 2025 18:58:53 -0400
X-Gm-Features: AX0GCFuNK2GlgjCzp9NuXPlW8VAedGQJmwklDdgcpEoZxd4pfb2_T3t5Jc58lno
Message-ID: <CAHC9VhQ7Rr1jJm=HY2ixUWpsRuwCxjOq5OTMfn5k5hRzxTCz-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
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

On Mon, May 19, 2025 at 6:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
> On Sun, May 18, 2025 at 11:34=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Sun, May 18, 2025 at 11:52=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sat, May 17, 2025 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On May 17, 2025 12:13:50 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Sat, May 17, 2025 at 8:03=E2=80=AFAM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > >> On Fri, May 16, 2025 at 7:49=E2=80=AFPM Alexei Starovoitov
> > > > >> <alexei.starovoitov@gmail.com> wrote:
> > > > >>> On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > >>>>
> > > > >>>> I think we need some clarification on a few of these details, =
it would
> > > > >>>> be good if you could answer the questions below about the
> > > > >>>> authorization aspects of your design?
> > > > >>>>
> > > > >>>> * Is the signature validation code in the BPF verifier *always=
* going
> > > > >>>> to be enforced when a signature is passed in from userspace?  =
In other
> > > > >>>> words, in your design is there going to be either a kernel bui=
ld time
> > > > >>>> or runtime configuration knob that could selectively enable (o=
r
> > > > >>>> disable) signature verification in the BPF verifier?
> > > > >>>
> > > > >>> If there is a signature in union bpf_attr and it's incorrect
> > > > >>> the prog_load command will be rejected.
> > > > >>> No point in adding a knob to control that.
> > > > >>
> > > > >> I agree that when a signature is provided and that signature che=
ck
> > > > >> fails, the BPF load should be rejected.  I'm simply trying to
> > > > >> understand how you envision your design handling all of the case=
s, not
> > > > >> just this one, as well as what build and runtime options you exp=
ect
> > > > >> for controlling various aspects of this behavior.
> > > > >>
> > > > >>>> * In the case where the signature validation code in the BPF v=
erifier
> > > > >>>> is active, what happens when a signature is *not* passed in fr=
om
> > > > >>>> userspace?  Will the BPF verifier allow the program load to ta=
ke
> > > > >>>> place?  Will the load operation be blocked?  Will the load ope=
ration
> > > > >>>> be subject to a more granular policy, and if so, how do you pl=
an to
> > > > >>>> incorporate that policy decision into the BPF program load pat=
h?
> > > > >>>
> > > > >>> If there is no signature the existing loading semantics will re=
main intact.
> > > > >>> We can discuss whether to add a sysctl or cgroup knob to disall=
ow
> > > > >>> loading when signature is not present ...
> > > > >>
> > > > >> As mentioned earlier this week, if the BPF verifier is performin=
g the
> > > > >> signature verification as KP described, we will need a LSM hook =
after
> > > > >> the verifier to serve as an access control point.  Of course tha=
t
> > > > >> doesn't preclude the addition of some type of sysctl/cgroup/what=
ever
> > > > >> based access control, but the LSM hook would be needed regardles=
s.
> > > > >
> > > > > No. New hook is not needed.
> > > >
> > > > It would be good for you to explain how the existing LSM hook is su=
fficient
> > > > to authorize the loading of a BPF program using the signature valid=
ation
> > > > state determined in the BPF verifier.
> > >
> > > I already explained:
> > > .. a job of trivial LSM:
> > > if (prog_attr doesn't have signature &&
> > >    (task =3D=3D .. || task is under certain cgroup || whatever))
> > >   disallow.
> >
> > I read that earlier reply as an example that covers a sample use case,
> > I didn't realize you were asserting that was the only approach you
> > were considering.  Perhaps that was the source of confusion earlier,
> > we may disagree, but I don't intentionally "twist" words; not only is
> > that rude, it's just stupid in public, archived discussions.
> >
> > As I mentioned previously, we really need to see an explicit yes/no
> > flag from the BPF verifier to indicate that the signature on the BPF
> > program has been validated.  It really should be as simple as adding a
> > bool to bpf_prog_aux which the BPF verifier sets to true upon
> > successful signature validation, and then an LSM can use this flag as
> > input to an access control decision in a hook placed after the
> > verifier.  Are you objecting to the addition of a flag in the
> > bpf_prog_aux struct (or some other struct tightly coupled to the BPF
> > program), the LSM hook after the verifier, or both?  It would also be
> > helpful if you can elaborate on the technical reasons behind these
> > objections.
>
> Neither the aux field, nor the hook are required because:
>
> * If the signature is passed, it will be enforced, there are no
> "runtime aspects" that need to be configurable here.
> * What the LSM can specify a policy for is when a signature is not
> passed, for this, it does not need an aux field or a signature or the
> new hook, existing hooks are sufficient.

When the kernel performs a security relevant operation, such as
verifying the signature on a BPF program, where the result of the
operation serves as input to a policy decision, system measurement,
audit event, etc. the LSM hook needs to be located after the security
relevant operation takes place so that the hook is able to properly
take into account the state of the event/system and record the actual
result as opposed to an implied result (this is critical for auditing,
measurement, attestation, etc.).

You explained why you believe the field/hook is not required, but I'm
asking for your *technical*objections*.  I understand that you believe
these changes are not required, but as described above, I happen to
disagree and therefore it would be helpful to understand the technical
reasons why you can't accept the field/hook changes.  Is there a
technical reason which would prevent such changes, or is it simply a
rejection of the use case and requirements above?

--=20
paul-moore.com


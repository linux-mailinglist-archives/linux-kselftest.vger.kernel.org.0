Return-Path: <linux-kselftest+bounces-33292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9ADABB0B8
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 17:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D76171878
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9CD21C17D;
	Sun, 18 May 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAkoIeKe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7912AC17;
	Sun, 18 May 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747583539; cv=none; b=Ppqkp9ymgm+4f0fjF89cwaIfX6TqMJk/bBUXG33j69xUNoBINcneWA5Q6olEEKR2JH7VwaiqgstPT7K8uFWksOUkowGIFYkKtMQy3w4WV7RmCT8X53yCA5uS7LAXh5BydewxeHJ2izB732ruBOY7+Xn7jnEcaZ9E44P+rFZFJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747583539; c=relaxed/simple;
	bh=+3sfbNrs775Nuch7lp3CXdZrxEkkKx2XOLmSr98QaCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bJR8M9bsM1ulZZfPyevaLemMfSkJqBHmWCxP6TAln+KDREqcH9GGVA9uqxC0PUIzGqpvS5NLhcocg2S/FiZc95qDzSOhEY3VsT2DOX4YjbMOTzpGyFP5iebDtRunUE23J2D5rjmt1Arj4bt6437ALOGyfxRH75xFT7aLEr4K9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAkoIeKe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso2341159f8f.0;
        Sun, 18 May 2025 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747583535; x=1748188335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3as2gF+IatO8dg1hmkBSNBs2pFXaXsGSX1ZIQFwJQ4=;
        b=cAkoIeKeBkAgaZf0+4psRdyr4cApTCvy7rXpKQN9mB3Nq88tIoO8H6GGZu+AwJ1VOP
         +cA22pAgYrMTAxCSnHR5PmhUZF6NFg2UcHHcCqfbbPijYq7aXC8V+4Xklh2oaxOrA9DH
         mjwwx6l5odZ3W1CiRthhY5/xqqoynth9VMljC0H6qNfJTeaULle3Y8J5QDsFH6kCEwG2
         rhFBYDgihM7clcDR98obPAcmUT2FqZjuAuPU1mj6dLN74U95up3ORvoa/fsEvYYG2hTx
         8kNwqlmkiVkzI53hxDxv/M6cQiJgYSgepM9JQU2novlnSRSmNSfLW3ODjl86u4J5PFHd
         4P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747583535; x=1748188335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3as2gF+IatO8dg1hmkBSNBs2pFXaXsGSX1ZIQFwJQ4=;
        b=LwOOvdN84iV9uvyy6diaSAzim/3vXZNHpmI62uEPZ+S1XK2Uo4zM8SXSgW3Okgh6rJ
         jC6087knAy5AjL0Ivi0beMJXWtXmb7gFaRiunaKXZX5LukRp9cR2mW8BWV6NG6UjvuvV
         lEDzN35ske42VZsHaVBYJBlC31YWnV+6P4+wx1qL7zWoh6p7q/GDurEX00LnV8m0H8TQ
         vt7y/M9WHUO24622dTkGGvViLhlhD05W9N4dhISFzaFqS0U+N2qec391yZHiUrTMsa6d
         ZW2beoex2WfRT3I+aMcrR8sqd/QUsTshjbe0zSFwD16BMnBooqTl5eqsMa5vIA6+aq8I
         i4lA==
X-Forwarded-Encrypted: i=1; AJvYcCUF+4T59LTzyGa2XoE1k6EL11QdqLyAy4vvLqJiwo3NRTq0c1drBSD+gQkFAXXBAUiYww7kWAwqnFm4J5YX@vger.kernel.org, AJvYcCUJOqnyR1DP6TnRUZB4Vp3TF2z8waPRIuXWhMmdf/NyN98v0NcejJqPLyaNYO5wVHTSfuruiQL5AU8X@vger.kernel.org, AJvYcCUw++A5pdmRhhD1tRgRioZ4yKN84CH3096HZCLeUoxsBDd+biKDmE3I/91rMSWcC/rnPjuqwvm12xDHT6Rd@vger.kernel.org, AJvYcCVaQunn7hsm08ITjOIuzXSZq10bmKoddP/P3AXgZOGyk1Zj0nXrDv4V9OCbGnuGkK+shNfHsW8v3xU=@vger.kernel.org, AJvYcCWUMvqzKPo18qzbtAOOTEEZblAKhwNnekV7GPLOZE3Xlh+4g397dOfo5dHiT4bFTYtg1QJMlXM5VrxtOPD5a0AGxN62RWwD@vger.kernel.org, AJvYcCXMpZ6V7r/XhV2WUVmy3WHS1AZnJsjywLwU5ENFAMGMk9QGlAv9+z8BTpPuP/v6OVarsaU=@vger.kernel.org, AJvYcCXZsWmWOI+9XqJxhhuBxaY4PX+VwowccTEv5r9v2MiAcPoTRk6pQpC+RTgxx/0yaoMRUwhuxC9MZsDAbwHS4VwB@vger.kernel.org, AJvYcCXzYZdGI2ljZGQj2ccBIQ4wpJMD3+P4tTQqWen+8B+x2I28t5EUH6AWQuyKbTVOjQXgvr+orOOzjBIFLlja@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTn7pohfqVD/vLV1S0FZ0FOWfaUs6megSqWcP4Ss+/3s6MIH1
	n1ei/yo6S6ZZnaDa6J3YIW0Y7KHMrJQYhc935KEPTMcd8zp42ZWv/pGQyqJrEVtvG77a2vV6qap
	bQpBCL/BZX6J+gYth63RZ2rRtFhurB8I=
X-Gm-Gg: ASbGncuY24LoAXvs1m70+NwUk3Ny5ylM/hpd8Ygwzj4beFxgquI/DQK/9vwVM6tQdv9
	Cs4ZERDpv8i5z/6lpi5f4KzPTnQFboMUvMwC6VKZxSPFNjKnk/IjB+wheip8EO+owYkt276IHum
	Mepw8N47lEC9+amrHWivBYN3AfZOfrn8Buj9YOYiAd/UxFqwkjlQ1VnIveyYhLxw==
X-Google-Smtp-Source: AGHT+IEiZa7/kL1vl+lHgpPDDtfRZ6UOCk/sObQ0RqGRPFYYBykx/zOKPS3oTQuTUrCCrc8E+OeC4fTdKLrwex1Vzss=
X-Received: by 2002:a05:6000:188e:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-3a35c8457cbmr8695268f8f.49.1747583534541; Sun, 18 May 2025
 08:52:14 -0700 (PDT)
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
 <CAADnVQ+wE5cGhy6tgmWgUwkNutueEsrhh6UR8N2fzrZjt-vb4g@mail.gmail.com> <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 18 May 2025 08:52:03 -0700
X-Gm-Features: AX0GCFt9M3_dCkyMrm7XCxwJyjC1dFUOiX7_cT3eZ9_H0MvAbu0YgA5uhMOcM8E
Message-ID: <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>
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

On Sat, May 17, 2025 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On May 17, 2025 12:13:50 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sat, May 17, 2025 at 8:03=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Fri, May 16, 2025 at 7:49=E2=80=AFPM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >>> On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> >>>>
> >>>> I think we need some clarification on a few of these details, it wou=
ld
> >>>> be good if you could answer the questions below about the
> >>>> authorization aspects of your design?
> >>>>
> >>>> * Is the signature validation code in the BPF verifier *always* goin=
g
> >>>> to be enforced when a signature is passed in from userspace?  In oth=
er
> >>>> words, in your design is there going to be either a kernel build tim=
e
> >>>> or runtime configuration knob that could selectively enable (or
> >>>> disable) signature verification in the BPF verifier?
> >>>
> >>> If there is a signature in union bpf_attr and it's incorrect
> >>> the prog_load command will be rejected.
> >>> No point in adding a knob to control that.
> >>
> >> I agree that when a signature is provided and that signature check
> >> fails, the BPF load should be rejected.  I'm simply trying to
> >> understand how you envision your design handling all of the cases, not
> >> just this one, as well as what build and runtime options you expect
> >> for controlling various aspects of this behavior.
> >>
> >>>> * In the case where the signature validation code in the BPF verifie=
r
> >>>> is active, what happens when a signature is *not* passed in from
> >>>> userspace?  Will the BPF verifier allow the program load to take
> >>>> place?  Will the load operation be blocked?  Will the load operation
> >>>> be subject to a more granular policy, and if so, how do you plan to
> >>>> incorporate that policy decision into the BPF program load path?
> >>>
> >>> If there is no signature the existing loading semantics will remain i=
ntact.
> >>> We can discuss whether to add a sysctl or cgroup knob to disallow
> >>> loading when signature is not present ...
> >>
> >> As mentioned earlier this week, if the BPF verifier is performing the
> >> signature verification as KP described, we will need a LSM hook after
> >> the verifier to serve as an access control point.  Of course that
> >> doesn't preclude the addition of some type of sysctl/cgroup/whatever
> >> based access control, but the LSM hook would be needed regardless.
> >
> > No. New hook is not needed.
>
> It would be good for you to explain how the existing LSM hook is sufficie=
nt
> to authorize the loading of a BPF program using the signature validation
> state determined in the BPF verifier.

I already explained:
.. a job of trivial LSM:
if (prog_attr doesn't have signature &&
   (task =3D=3D .. || task is under certain cgroup || whatever))
  disallow.

If that's not obvious you have to wait for patches.


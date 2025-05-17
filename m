Return-Path: <linux-kselftest+bounces-33251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D43DABAAF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825CD189C148
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC956207A2A;
	Sat, 17 May 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTBGT/01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0F2557C;
	Sat, 17 May 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747498433; cv=none; b=oIcMiQen/iv5ly5U72jh7tLjU2uzAqqGn8qKcUOg4Gv8dKuAKzfB6Sr9z3TgQuXRSk1aqvk6+clm4YQgeBi/z2QoDHFtvH3xOMHS/z0LFObEA/I/n2bGWP6IFGljIG9vTdKA8vheewzLYUsFBoWe3riCCuIK+RqiDnk2NmBPzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747498433; c=relaxed/simple;
	bh=LbvYxJ3Tcd/Fw7lY2lX1yyeiA5XRGFWTyq4VYLwKSqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+T/5vdXqGIMt0+L3LGArbk9+IhRhD0y414IBeg5bAuDeuCI50g7JwhaeCjiA8XYc7xD6VFVCsv9BXy9fmTndmPujbou+tZm0zDaKoMJ4du2dVolXsv7F6CekJvq1HrRJwVx6EwExgYw3qdJITP4NVwg8S6+RQj4obEDfyvauCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTBGT/01; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0b9c371d8so2671458f8f.0;
        Sat, 17 May 2025 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747498430; x=1748103230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82OhuhlHOez3jDmdlmzfxsmkDtQ4s4LOyl3j3kN+AnA=;
        b=nTBGT/01H+eq9KdQi+bR9DU46UHjLQBaOIpcjC7JoATNP2q0mhNpf7xb+tKz3sQZHy
         BB+LvyPA67atSfC341FvcKF7w82PZBFE9EuBUTaTunkblL1B/aE0PJwDhxgctPuXQzbF
         NdZkni1rpAN+3Q+eitA49TmSfCMOMdAEBuGqe3GWPnTR4QB0t/Ce8cY93cPYAUv42nIM
         PTxgvH9hnplgR5AsFjI3g8dHLQr4skS3w1tCzwYwhEqWwgZCLoAUlOIrEsggAIxUEIqG
         4o2BojEvB6PYxcK+05NV2ihUOG0mG8LJorfVP9tJX+JVLqqyVJvRqvCV2fhlpZst2m4V
         4nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747498430; x=1748103230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82OhuhlHOez3jDmdlmzfxsmkDtQ4s4LOyl3j3kN+AnA=;
        b=NoCB5GUkByRNheL0ITp+tIV6chRPxkfuKYayR9jSYYGH99gu9rbQUUBVvip2wyoM/T
         3/CBzd8prEbnwFYMHV+uLULcNITAfrDlIZQM2Zah4hMrt3flVQMpl6MHnfIqYauQDkHp
         CyTd96GPzTWCZDGULEIEB6JWrmzWknnA2iy1f1LjlNj/MG4O6n61KYYcTyBvvZjeSHAS
         nGIAy7/22DEGWXDR0rrI+lsUv+JamwZvba3KcEiaYVL/sZhF/O1A6FCaNo0mel/URQMz
         EeuwVgHx4sF2Izd9JCpRSCGD7Oq9kwiaZonAub+tRBWez48tTOig/52qiQ1zlWxnYa0K
         rZvA==
X-Forwarded-Encrypted: i=1; AJvYcCU6wdXtC500QXVAeRifnV5iwbqfp/z+bk2PPDeX1ECRoFR/eGgJS2j3F1NGeRZgfmPCG/VLO6j2Khu8rA81qOP97Aj6bv7Z@vger.kernel.org, AJvYcCUedfdAQbgITPoRYwNhvgf56D77sbkVJjilGE7+NrwJO8YBJ3NdWLAvcmVEpPf6irsCxjeAuyu4TMusBbh+@vger.kernel.org, AJvYcCUf/a++0Px5nUoZqEJUFH6hb9RFzzRGnEez28qArtKcJMO29RwUKsQ6mI6Y3Q4Zvgkoh5NF6j+ccLU=@vger.kernel.org, AJvYcCVZE2R9fjX6nuhL8xhHDbrfwHIgyUe86gVPXSQY5GfOuHufizD6jB9Tpd35xMqzqlggr0AvPk3sNFI0hctd7hW4@vger.kernel.org, AJvYcCWZIcIVTIGrLad0rP1Tccrlm/IMWOBYH7eTKofRAtZeSq2tNEpdbebw9vk2woN2jb0EJmugyQrYYkLaeexr@vger.kernel.org, AJvYcCX5efwZkQPs8GhTO+iPimW6qVp9bsnnikmn1D5uWXEH59wvaie8PvnjfpeMn9RbALEce6tKLLPTlNBZ@vger.kernel.org, AJvYcCXnPPhkGyRjS7tHmyTghAq1q085zolJKSSxVRqQW02HJEXBSE64OoQyAZxYvCG7SQmyxaI=@vger.kernel.org, AJvYcCXwiGTDHV/Dri7JBzq7V1hMDf231cAY2Rjku6KZAVQQJQ5c1UBHXyviyud3i4mOU7Y8oor/5fwaJZagaq+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AYOfeC9Wm1qgzjo+vC6YAALu3BbmJVhHUs/hSALcICdV0Ey+
	Aqe8rsn8sn3yJ61GenoD2ZgHikOt1wESFd2O5rqNcOH8lT0BPyVoWr6DnAeMnOudax7YdwmvpYZ
	4zPwUDCbOlwQiNkwvEOMQ6PBGRhDlfhA=
X-Gm-Gg: ASbGncvuXOhrslUcVYjG+0jaz/6fvAkti4VUdZgzg2itMb1HS8pdYloLT1Ph458OslB
	PkBQSIPl9LrBVYGZUqhwA4y9Una6Tw8JHCaV3nUpoofiVbgBlb/dPfi1ww+aZzi158JFEivpCv+
	G2QS+0hoB7CuwM/cgYoNOCASXXJ3smMdSPZ8SpdF5v5Bn6UeQBavMosOg3JxnTOQ==
X-Google-Smtp-Source: AGHT+IGarazK394xibyYuLT0mYueQg8j7j5ZYb5Tjx68VPA3RvUUD+et9GfgP4lQjmkZi97eSRT8BdRUfJNPJzdkQVg=
X-Received: by 2002:a05:6000:2a5:b0:3a3:6a77:3387 with SMTP id
 ffacd0b85a97d-3a36a7736b3mr770880f8f.6.1747498429897; Sat, 17 May 2025
 09:13:49 -0700 (PDT)
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
 <CAADnVQJ4GDKvLSWuAMdwajA0V2DEw5m-O228QknW8Eo9jxhyig@mail.gmail.com> <CAHC9VhTJcV1mqBpxVUtpLhrN4Y9W_BGgB_La5QCqObGheK28Ug@mail.gmail.com>
In-Reply-To: <CAHC9VhTJcV1mqBpxVUtpLhrN4Y9W_BGgB_La5QCqObGheK28Ug@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 May 2025 09:13:38 -0700
X-Gm-Features: AX0GCFvp20fiHibEhTzOmtoJ3hSYUBnQTUWsP4BmGr2mNOIhP3brqkNqnicpeoo
Message-ID: <CAADnVQ+wE5cGhy6tgmWgUwkNutueEsrhh6UR8N2fzrZjt-vb4g@mail.gmail.com>
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

On Sat, May 17, 2025 at 8:03=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, May 16, 2025 at 7:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > I think we need some clarification on a few of these details, it woul=
d
> > > be good if you could answer the questions below about the
> > > authorization aspects of your design?
> > >
> > > * Is the signature validation code in the BPF verifier *always* going
> > > to be enforced when a signature is passed in from userspace?  In othe=
r
> > > words, in your design is there going to be either a kernel build time
> > > or runtime configuration knob that could selectively enable (or
> > > disable) signature verification in the BPF verifier?
> >
> > If there is a signature in union bpf_attr and it's incorrect
> > the prog_load command will be rejected.
> > No point in adding a knob to control that.
>
> I agree that when a signature is provided and that signature check
> fails, the BPF load should be rejected.  I'm simply trying to
> understand how you envision your design handling all of the cases, not
> just this one, as well as what build and runtime options you expect
> for controlling various aspects of this behavior.
>
> > > * In the case where the signature validation code in the BPF verifier
> > > is active, what happens when a signature is *not* passed in from
> > > userspace?  Will the BPF verifier allow the program load to take
> > > place?  Will the load operation be blocked?  Will the load operation
> > > be subject to a more granular policy, and if so, how do you plan to
> > > incorporate that policy decision into the BPF program load path?
> >
> > If there is no signature the existing loading semantics will remain int=
act.
> > We can discuss whether to add a sysctl or cgroup knob to disallow
> > loading when signature is not present ...
>
> As mentioned earlier this week, if the BPF verifier is performing the
> signature verification as KP described, we will need a LSM hook after
> the verifier to serve as an access control point.  Of course that
> doesn't preclude the addition of some type of sysctl/cgroup/whatever
> based access control, but the LSM hook would be needed regardless.

No. New hook is not needed.

> > but it probably should be a job of trivial LSM ...
>
> Exactly.  If the LSM is simply verifying the signature validation
> state of the BPF program being loaded it seems like an addition to IPE
> would be the best option from an upstream, in-tree perspective.
> However, with the post verifier LSM hook in place, one could also
> supply a BPF LSM to do something similar.
>
> It sounds like we are in agreement on the desirability and need for a
> post verifier LSM hook; we'll keep moving forward with this idea
> despite KP's earlier objections to the hook.

Don't twist my words please.
We're absolutely _not_ in agreement.
What I described above can be done with the existing hook and
its current set of arguments.
We're not going to move or change the existing hook.


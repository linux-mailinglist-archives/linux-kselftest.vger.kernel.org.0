Return-Path: <linux-kselftest+bounces-11063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448558D6B34
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B332B1F2266E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5778286;
	Fri, 31 May 2024 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dzysLtzu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3768005B
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189619; cv=none; b=WwJcpXY/AzJJpzxIT+NVzTLreHp/j0nT0lEPfDNN5Xz4RQH5UlbEBAI5e+lMmkCc22vy2zx85HS0KFqXN058C1+rwm6+OTnh2H0MTw7kgA1NE9IzpTyeAU+QekHX0vw9pSr3gg0XFIjQ4EsS/BOAlxJCvzck9ezBRM2grrzDhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189619; c=relaxed/simple;
	bh=bwCukm/Yfw6lwZqmTFY8N+2pL/22FYmG87P4IZ8Kg6M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpBWwutg67T/dcTAZo5XEj80mPMdhcmRbvBrfZj53avtER+73h8T4Z2rcqU2l9OcN7+1X0J2CrTeFEB1Vc6+zC6TUjlgTM00ddfDgJD0UL5Cph/4//aglY07HPrLVH7d5lgsoumSBP4xaNAQuf99Ze1l29oo6PLFZ50ynOzxt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dzysLtzu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a63036f2daaso282973966b.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717189614; x=1717794414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1n0VoVMhStMuRZZjqgXJlMWW/IMmC2AmLspEwJJwpMY=;
        b=dzysLtzufeQGlRxU7JnVygR+PsRpjA1ux3Cp8mpSduV3DT+B/4Q0A6+tbBt+E2++qC
         MpZ1LBzTZifDxelbM21681Tz/7NoqII8Szbtg/DihiU+OYLMqJg6BhbyNjv0z8kY3a1L
         VBIOlLDw6xrIt4wOlpYJdVqik0phYKJ90Xhepe0ijNE6PwiFVz/DQfKJtdOMY3q6HTM3
         PRruZbO/Tit/fYDU48VzcsyDqsF5fuFh01IBxYPT/7aeJn2xSlCPYC8rA9bhHqF+2Bxm
         EP96FzGeoK5fS0jBxjyKaj89mhtpD/xq4yUZaAtOBYc0ZOh9Iaj3LfeGYM7ldlMX+YJ1
         5HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717189614; x=1717794414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1n0VoVMhStMuRZZjqgXJlMWW/IMmC2AmLspEwJJwpMY=;
        b=k+7RHd/XHlM33oWnB5rkOt7PiCPhmZtXrHOUUy6zKame4KkkFPcDdmSM52uQIfXQeV
         XtaPX0RA2kR1W6+t0JIIqefPgRQupwxz8lwkG5djbjyHZ1m8imoAh09Zg+aeZ+Thfgo6
         efcoYT4RSjKVusqzuzepmGCFKwg9z2X7Iwm/dkNwY4iA+s7uEYwSnT58kzjNN70nLm5k
         UPGYvWlPhAena46EjW3+dxgUNMt/no4ceYRZc+tPitekLpchSV5tcAIE4f1vjkEarZZR
         8lyxDNDnKmCG81HL6yk4n7qD4oPqTWtZgAwYEuvo6Cu6QWNe9zxSnPp/EgNph0OTW23O
         sw2g==
X-Forwarded-Encrypted: i=1; AJvYcCV18JohBXuoQ3v1g3jdd8c64KkB7wsEOrYiOUC+OeeIKqVLN8rXE/0Ib98IxoA/mO+uEWgweM9n7TSyIEUDRn6W0XgUqLB8azGqGIzv83eK
X-Gm-Message-State: AOJu0YwvgzG5nCzHwjUn5EivVSReFGkZKbYVtsx7X7a4Ud5Fj6o2gky1
	X3221Huhh+9rsQ/tJJMuiliJaP9/NlMgn0TsZFwrz3RZyDU+xmslgk2F0MraQ5A=
X-Google-Smtp-Source: AGHT+IGzjwkRbK7JN2qov60rIIZ6FETvbPiNqcZq5L48jeuG3cKt0CBJaeq9KbIc5yAj/nstHzIqug==
X-Received: by 2002:a17:906:2746:b0:a68:ac15:cd3c with SMTP id a640c23a62f3a-a68ac15d8c6mr8287966b.17.1717189614508;
        Fri, 31 May 2024 14:06:54 -0700 (PDT)
Received: from ?IPv6:2804:5078:851:4000:58f2:fc97:371f:2? ([2804:5078:851:4000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a253881asm23809966b.211.2024.05.31.14.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:06:54 -0700 (PDT)
Message-ID: <92d683bd138a76e6c7100f4984be202dd06c9424.camel@suse.com>
Subject: Re: [PATCH v2] selftests: livepatch: Test atomic replace against
 multiple modules
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Shuah Khan
 <shuah@kernel.org>,  live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 18:06:48 -0300
In-Reply-To: <ZloormpDnnc4SDub@redhat.com>
References: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
	 <ZloormpDnnc4SDub@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-31 at 15:44 -0400, Joe Lawrence wrote:
> On Sat, May 25, 2024 at 11:34:08AM -0300, Marcos Paulo de Souza
> wrote:
> > Adapt the current test-livepatch.sh script to account the number of
> > applied livepatches and ensure that an atomic replace livepatch
> > disables
> > all previously applied livepatches.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > Changes since v1:
> > * Added checks in the existing test-livepatch.sh instead of
> > creating a
> > =C2=A0 new test file. (Joe)
> > * Fixed issues reported by ShellCheck (Joe)
> > ---
> > =C2=A0.../testing/selftests/livepatch/test-livepatch.sh=C2=A0 | 46
> > ++++++++++++++++++++--
> > =C2=A01 file changed, 42 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh
> > b/tools/testing/selftests/livepatch/test-livepatch.sh
> > index e3455a6b1158..d85405d18e54 100755
> > --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> > +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> > @@ -107,9 +107,12 @@ livepatch: '$MOD_LIVEPATCH': unpatching
> > complete
> > =C2=A0
> > =C2=A0# - load a livepatch that modifies the output from /proc/cmdline
> > and
> > =C2=A0#=C2=A0=C2=A0 verify correct behavior
> > -# - load an atomic replace livepatch and verify that only the
> > second is active
> > -# - remove the first livepatch and verify that the atomic replace
> > livepatch
> > -#=C2=A0=C2=A0 is still active
> > +# - load two addtional livepatches and check the number of
> > livepatch modules
> > +#=C2=A0=C2=A0 applied
> > +# - load an atomic replace livepatch and check that the other
> > three modules were
> > +#=C2=A0=C2=A0 disabled
> > +# - remove all livepatches besides the atomic replace one and
> > verify that the
> > +#=C2=A0=C2=A0 atomic replace livepatch is still active
> > =C2=A0# - remove the atomic replace livepatch and verify that none are
> > active
> > =C2=A0
> > =C2=A0start_test "atomic replace livepatch"
> > @@ -119,12 +122,31 @@ load_lp $MOD_LIVEPATCH
> > =C2=A0grep 'live patched' /proc/cmdline > /dev/kmsg
> > =C2=A0grep 'live patched' /proc/meminfo > /dev/kmsg
> > =C2=A0
> > +for mod in test_klp_syscall test_klp_callbacks_demo; do
>=20
> Slightly nitpicky here, but the tests were originally written with
> the
> livepatch module names via variables like $MOD_LIVEPATCH.=C2=A0 Would
> using
> $MOD_LIVEPATCH{1,2,3} help indicate that their specifics aren't
> really
> interesting, that we just need 3 of them?

Makes sense. I thought about it when I was changing the code, but I
didn't want to change it too much, so it was the result. But that makes
sense to have the modules better named.

>=20
> > +	load_lp $mod
> > +done
> > +
> > +mods=3D(/sys/kernel/livepatch/*)
> > +nmods=3D${#mods[@]}
> > +if [ "$nmods" -ne 3 ]; then
> > +	die "Expecting three modules listed, found $nmods"
> > +fi
> > +
>=20
> I was going to suggest that we might protect against a situation
> where
> other livepatch modules were active, that a simple count wouldn't be
> sufficient.=C2=A0 But then I thought about this test, atomic replace!
> Anything previously loaded is going to be pushed aside anyway.
>=20
> So maybe (in another patch or set) it would be worth enhancing
> functions.sh :: start_test() do a quick sanity check to see that the
> initial conditions are safe?=C2=A0 That might also prevent some collatera=
l
> damage when test A fails and leaves the world a strange place for
> tests
> B, C, etc.

We have been discussing about start/end functions that would check for
leftover modules... maybe should be a good think to implement soon as
we land more tests.

>=20
> > =C2=A0load_lp $MOD_REPLACE replace=3D1
> > =C2=A0
> > =C2=A0grep 'live patched' /proc/cmdline > /dev/kmsg
> > =C2=A0grep 'live patched' /proc/meminfo > /dev/kmsg
> > =C2=A0
> > -unload_lp $MOD_LIVEPATCH
> > +mods=3D(/sys/kernel/livepatch/*)
> > +nmods=3D${#mods[@]}
> > +if [ "$nmods" -ne 1 ]; then
> > +	die "Expecting only one moduled listed, found $nmods"
> > +fi
> > +
> > +# These modules were disabled by the atomic replace
> > +for mod in test_klp_callbacks_demo test_klp_syscall
> > $MOD_LIVEPATCH; do
> > +	unload_lp "$mod"
> > +done
> > =C2=A0
> > =C2=A0grep 'live patched' /proc/cmdline > /dev/kmsg
> > =C2=A0grep 'live patched' /proc/meminfo > /dev/kmsg
> > @@ -142,6 +164,20 @@ livepatch: '$MOD_LIVEPATCH': starting patching
> > transition
> > =C2=A0livepatch: '$MOD_LIVEPATCH': completing patching transition
> > =C2=A0livepatch: '$MOD_LIVEPATCH': patching complete
> > =C2=A0$MOD_LIVEPATCH: this has been live patched
> > +% insmod test_modules/test_klp_syscall.ko
>=20
> Similar minor nit here, too.=C2=A0 If we think copy/pasting all the
> $MOD_FOO
> is annoying, I am fine with leaving this as is.=C2=A0 I don't have a
> strong
> opinion other than following some convention.
>=20
> With that, I'm happy to ack as-is or with variable names.

Thanks Joe! I think that is Petr's call, either way I can rework this
patch, or send additional ones to adjust the tests.

>=20
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
>=20
> --
> Joe
>=20



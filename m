Return-Path: <linux-kselftest+bounces-12384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A09117D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 03:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BFF1C20DC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 01:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A110FA;
	Fri, 21 Jun 2024 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM0R3jb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07325625;
	Fri, 21 Jun 2024 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718931915; cv=none; b=rT2N5rn/9M3bymZMrz+9wPca6/tqbvAq91fcIHuTmyb0l2wfgrBlUpCgi8m4WMOQ4DApGHL0IHjLfZhxC/UzdXIybzieE8JeXsZBCObQdV3aDIVERZ482iAHIftKyuYIvwrVqkmYhHXf80LB3/JxGgBrHuXwAZueOoR3mkW0hTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718931915; c=relaxed/simple;
	bh=quFMaldFa9X38ZMJn06ygjjx4LlG1mhbgRP0FSjft/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr4VSCv6B9Ml33yP6i3UT6P6aJV+6AdiyKTUwlS5zFID0Eo12SL/cdA+HP3witVuV8uVx9+nhLP1LeCHVIRAbR8CcvhYWShiQW345wIH2tUURknuiJz0MJGCuH5l4iDekxuHixNxV1jeSyyFmW4+iqa4VBVXgMVqiQaFD4eXW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM0R3jb4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c7c61f7ee3so1279918a91.1;
        Thu, 20 Jun 2024 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718931913; x=1719536713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUIiselN6aNygKYqR/gG69pZatewEjIOFlDm5aKgKok=;
        b=QM0R3jb4UdQyWiEa3nGTCzgz9r5rEkclIxCA6y4Vpy6l13pf+YlWy7OLL9LlvfunuE
         GHYMAI8xtOOX4gCv7DjBhefR1tBvFVk5wStXl2Fb1mXfcdJnY+0qmp48vQg0RB2iaAD3
         oKD8lPSWADxKw//aAniDG+hV3WqVKCMeMFsuKiXmkhcBjHi6dKpAUNM1E41a0oGmcQim
         BGi9UDED07yDG2h0i+XWmpnnIhsfOxnyrg+Jb8sOKzQoLxtLyCtKqAP7bWHjL5QqxlNF
         AIdWrz9zieksDBSj2JvPMJUV2feNQN70Oldk8S824a9HpL6CaiXgDYG/oCJXglrzZ4NG
         PbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718931913; x=1719536713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUIiselN6aNygKYqR/gG69pZatewEjIOFlDm5aKgKok=;
        b=p7qWJB7m60K9uYbAXK6+ps047UZTfPgsA0ySbLQord9IAdItIycmBWrrCCtr7diKN6
         r+z8mtKZaJGBP4zuQ5uT7PLtxcBNMm0PX0HGuDmU0vTbW/nMKSSKQKa6cK9fuFeO0O/F
         iQlidSZiqq6Cyndu/QB8633f/1l9tKETnEd71c2wpdu4M1YpbLUBqKe6nG0TkT4A3w2+
         CS19bG0jlWWpanjBezNGdUWtChEya2T6ggVg7sM73Wf5DNw1DbTXNaJ1vB7SIadZUe8M
         fHzNSGviUvCmM6K9CG8jQWueLroAX8VSLHXUIFND7LuYcILGeeTozNOjBZDjFGBh888D
         I0eA==
X-Forwarded-Encrypted: i=1; AJvYcCWjb4E/hJzhVuLtq1ovtNSsvHiNRkv94Fm8FCaxMJ/nHYpeCUdC+kjUKCevTlN7ilmj9JW5h4XzXwxWlVDTAZ442mrWXj64LUlbpGVM9qmba5MpcUgV8na/DvtubZ9zG4GCtoCO
X-Gm-Message-State: AOJu0YzNzh93PKKtTAtQuT0VeUPcFcpzbOnytWypiWWgrwd540A2xpNv
	ThiRvva9OC21napSXFM6keZIDZ37YxqxlwTXtNzh9aTURV3bd4d/1mZpewljWwU0FDEbqo5ktgy
	Mx3+DfHhsPM/7ZdrrUSir/6N3DTg=
X-Google-Smtp-Source: AGHT+IHy/dmus3ScgDMFm90pxEkbbLcbvEhZYkXi09/AjVzNDXnip5kENJ4RpNA0OSe6QmVmNHjjlM68sILOy7nGiB4=
X-Received: by 2002:a17:90a:6047:b0:2c2:d813:bffa with SMTP id
 98e67ed59e1d1-2c7b5dc805cmr6615824a91.43.1718931913186; Thu, 20 Jun 2024
 18:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619230658.805185-1-zhouzhouyi@gmail.com> <673d737a-cf17-4480-a9e2-7ff1668f4b44@paulmck-laptop>
In-Reply-To: <673d737a-cf17-4480-a9e2-7ff1668f4b44@paulmck-laptop>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Fri, 21 Jun 2024 09:05:02 +0800
Message-ID: <CAABZP2xa4T_E1KHLFFSF=1SURdg6fQJmj_rnGjvKoK0gnmDSeA@mail.gmail.com>
Subject: Re: [PATCH V4] rcutorture: Add CFcommon.arch for the various arch's need
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, lance@osuosl.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:57=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Jun 19, 2024 at 11:06:58PM +0000, Zhouyi Zhou wrote:
> > Add CFcommon.arch for the various arch's need for rcutorture.
> >
> > In accordance with [1], [2] and [3], move x86 specific kernel option
> > CONFIG_HYPERVISOR_GUEST to CFcommon.arch, also move kernel option
> > CONFIG_KVM_GUEST which only exists on x86 & PowerPC to CFcommon.arch.
> >
> > [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gma=
il.com/
> > [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@pa=
ulmck-laptop/
> > [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
> >
> > Tested in x86_64 and PPC VM of Open Source Lab of Oregon State Universi=
ty.
> >
> > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Thank you!  I have reverted the earlier version to queue this one.
> Please check below to make sure that my usual wordsmithing did not mess
> things up.
I have studied the edition thoroughly, it is wonderful, and I learn a
lot through this
process!
>
> Mark, any suggestions for any needed ARM CFcommon.arch files?  Or does
> moving out the x86/PowerPC-specific Kconfig options take care of things
> for you guys?  (Hey, I can dream, can't I?)
Thank you both for your guidance!

Regards
Zhouyi
>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 9d6767c47ce4de2ef817e47a5882748d8008ebe9
> Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Date:   Wed Jun 19 23:06:58 2024 +0000
>
>     rcutorture: Add CFcommon.arch for arch-specific Kconfig options
>
>     Add CFcommon.arch for arch-specific Kconfig options.
>
>     In accordance with [1], [2] and [3], move the x86-specific kernel opt=
ion
>     CONFIG_HYPERVISOR_GUEST to CFcommon.i686 and CFcommon.x86_64, and als=
o
>     move the x86/PowerPC CONFIG_KVM_GUEST Kconfig option to CFcommon.i686=
,
>     CFcommon.x86_64, and CFcommon.ppc64le.
>
>     The "arch" in CFcommon.arch is taken from the "uname -m" command.
>
>     [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@g=
mail.com/
>     [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@=
paulmck-laptop/
>     [3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/
>
>     Tested in x86_64 and PPC VM of Open Source Lab of Oregon State Univer=
sity.
>
>     Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
>     Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>     Suggested-by: Mark Rutland <mark.rutland@arm.com>
>     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/t=
ools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index b33cd87536899..ad79784e552d2 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_=
KCONFIG_GDB_ARG"
>  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_A=
RG"
>  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_A=
RG"
>  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
> +config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
> +                     "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null=
`"
>  cp $T/KcList $resdir/ConfigFragment
>
>  base_resdir=3D`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/to=
ols/testing/selftests/rcutorture/configs/rcu/CFcommon
> index 0e92d85313aa7..217597e849052 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> @@ -1,7 +1,5 @@
>  CONFIG_RCU_TORTURE_TEST=3Dy
>  CONFIG_PRINTK_TIME=3Dy
> -CONFIG_HYPERVISOR_GUEST=3Dy
>  CONFIG_PARAVIRT=3Dy
> -CONFIG_KVM_GUEST=3Dy
>  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=3Dn
>  CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dn
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686=
 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> new file mode 100644
> index 0000000000000..d8b2f555686fb
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> @@ -0,0 +1,2 @@
> +CONFIG_HYPERVISOR_GUEST=3Dy
> +CONFIG_KVM_GUEST=3Dy
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc6=
4le b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
> new file mode 100644
> index 0000000000000..133da04247ee0
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
> @@ -0,0 +1 @@
> +CONFIG_KVM_GUEST=3Dy
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_=
64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> new file mode 100644
> index 0000000000000..d8b2f555686fb
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> @@ -0,0 +1,2 @@
> +CONFIG_HYPERVISOR_GUEST=3Dy
> +CONFIG_KVM_GUEST=3Dy


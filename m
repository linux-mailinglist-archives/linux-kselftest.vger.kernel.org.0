Return-Path: <linux-kselftest+bounces-12104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9759F90BDB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 00:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424B7282C02
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 22:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704E1991DC;
	Mon, 17 Jun 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvURCjwb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C81D953B;
	Mon, 17 Jun 2024 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664096; cv=none; b=LP9sMyFgb6b8yeSN/lo6YSkiptuv4VrPIkqO3QfoYZ/Pjj7qw4LLLphi4vECGULMONB1Kc8jiJOYykF4AzZsFDjjnhskwpyVc/ImMrHVy/XgzcSTKto36vJ4pC59zgLTyagng9T2n2OzFKqi/EQ43ThFjxjgC6V9LHU6DYfswLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664096; c=relaxed/simple;
	bh=QtGV/R4adHLMd1k17SRurpscLI7Ufo8DBbF7CILGQCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLID23EkW9uCRcQmUGCQoqpFba9WDeR2/7HzDpjecUZ+bHVZkbgUDZOvAgL59MQDGJiDxWjgZGz8G/eSTfCZJOQZfP0iS6QGAv56ekGgTCJNLhb2/Th97oPKmqf5ALaF823vLePLAJDrQe94saNg7bnFp2xO4IEx3k4m/Q/WE1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvURCjwb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so3568842a12.3;
        Mon, 17 Jun 2024 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718664094; x=1719268894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9R71IhZlLlWSDzgVp7mTHB+mnPcb3UWEQe+UrX+TEQ=;
        b=QvURCjwbAMc/RZxiXlJwIlYA/frtPwVE4VzLxgXdxy9P2cVyzIT9jVeQRkXftRhlLL
         MWUeEPaszjUwdAa8VQCNmaudtkZNI5pkx6DiievZ7xaW8jeTOEXnza2/vr8GhFyzz01U
         CrqBaRiLP2fMNuJ1DInKYz+M/gXrnM5vKq+wCp6yVH9g8XnJOQrPLu7yB7YZAiMM/N8j
         u+XFQn9sHGNFBKl0Psi2bOHWQ10lbByc9OTncDLI0Ng+q+sZjj81jXtyIcv/3Q2zVAyP
         ipp5uPnJOK3v/TfAUK0TIHEAlwsrBaNqlHidvnFoifpdKgbLOvd0Ok3MS2wXszJxKddH
         eQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664094; x=1719268894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9R71IhZlLlWSDzgVp7mTHB+mnPcb3UWEQe+UrX+TEQ=;
        b=tsgjWc7CJERws3Sph2ex1NJ7WtIDWIenFZTsryLn7kzuKmYBp2Tctpj9GOGiMHSwZv
         hL/K71XmPM8a25c3C2gxz0t6wauvRouvHnnTByZ4PRB4OAG/vaDcT0fepcKHHBshx3Sm
         M7N6tUjDCu3maV9w3uPJqZnXlOaakpYtafGgTEwMqcNd6O5of6VaDU2bwkT0Tx9frDds
         drXE8A8b7s7nDXeY6IQrMmVAn58/izodtHQERS53/5cICFJjqyo49/gu50jvGdCeusmc
         3TXlk1hgyVMIJePeBtvKb0qbihhf4i6By3T0Y2thd8nam3CyOEgitOHN7e2Y57kl9Gop
         8SyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLafdH6MtXcv2Y1thiCMtkOnTz8tk5/21H0VR03S6qp9VX3nUSMiR9wcL/TNkqbZ4Bgc8JTsO/QYl2KGNFigbhQ9ZqnxfzKnDNlhJdsW6QrPslbflNe9p6hJGKvwhcj3fXJZOaJ+QQg5PVzysEa/Vf3UCpbMhp8CGr5jGDj5NqHLWu
X-Gm-Message-State: AOJu0Yy7vPWdfcR7zBXgbqQ2oP+XuUo67dKU/lRyHkxCI/MonkUyyjYf
	pGdnZrImQYQ+joaYlEqylimqphSlRmjPNEhzEIPuqvBO89wkmlzbn/ssnsugJP/5xtveHhtVf11
	2J8g+V7Wz+n4oTa1fOjtF+o3Vspg=
X-Google-Smtp-Source: AGHT+IFsVVHidNeYyK9JJtQowF1AOqQP+lrEGQoui7QGo2YyXJa1GfP9ueU48L6g2ogGiUGhLZzYY9QeJGgKrkuyfr8=
X-Received: by 2002:a17:90a:c903:b0:2c3:3d22:b304 with SMTP id
 98e67ed59e1d1-2c4db13220dmr9894853a91.3.1718664094126; Mon, 17 Jun 2024
 15:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612013527.1325751-1-zhouzhouyi@gmail.com>
 <def32dd4-b205-45b8-a5ed-e6e28a0ac4f4@paulmck-laptop> <ZnBkHosMDhsh4H8g@J2N7QTR9R3>
 <76deed7a-9852-4d21-bbcc-8b14e267fe89@paulmck-laptop>
In-Reply-To: <76deed7a-9852-4d21-bbcc-8b14e267fe89@paulmck-laptop>
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Date: Tue, 18 Jun 2024 06:41:22 +0800
Message-ID: <CAABZP2z0-zHTADL5REThay5CYcfSBaHA4mUXO6NYu-JJA7=Xvg@mail.gmail.com>
Subject: Re: [PATCH V3] rcutorture: Add CFcommon.arch for the various arch's need
To: paulmck@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 12:47=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> On Mon, Jun 17, 2024 at 05:28:14PM +0100, Mark Rutland wrote:
> > On Tue, Jun 11, 2024 at 07:57:29PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 12, 2024 at 01:35:27AM +0000, Zhouyi Zhou wrote:
> > > > Add CFcommon.arch for the various arch's need for rcutorture.
> > > >
> > > > According to [1] and [2], this patch
> > > > Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options") by moving
> > > > x86 specific kernel option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
> > > >
> > > > The patch has been revised and improved under
> > > > Paul E. McKenney's guidance [3].
> > > >
> > > > [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi=
@gmail.com/
> > > > [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d59=
0@paulmck-laptop/
> > > > [3] https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb66195=
e3@paulmck-laptop/T/
> > > >
> > > > Tested in x86_64 and PPC VM of Open Source Lab of Oregon State Univ=
ersity.
> > > >
> > > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >
> > > Much better, thank you!
> > >
> > > I queued and pushed for review and testing with the usual editing,
> > > so please let me know if I messed anything up.
> > >
> > > I added Mark on CC in case he has thoughts from an ARM perspective.
> >
> > Ah, thanks!
> >
> > >From a quick scan, the only thing I spot is that CONFIG_KVM_GUEST is
> > also not an arm64 thing, and only exists on x86 & powerpc, so pulling
> > that out too would be nice.
yes, CONFIG_KVM_GUEST exists in powerpc & x86, which makes me think it
is global.
>
> Thank you for looking this over!
>
> Zhouyi, would you be willing to add this change, either as a new version
> of this patch or as a new patch on top of it?  (Your choice.)
Thanks to Paul and Mark's guidance, I achieved a lot during this process ;-=
)

I am going to create a new version of the patch, and test is both on
X86 and PowerPC

Cheers
Zhouyi
>
> > That aside, this looks good to me; having the infrastructure to do this
> > per-arch is nice!
>
> Glad you like it!  May we have your ack?
Very happy that Mark likes it ;-)
>
>                                                         Thanx, Paul
>
> > Mark.
> >
> > >
> > >                                                     Thanx, Paul
> > >
> > > ---------------------------------------------------------------------=
---
> > >
> > > commit 29cf4c63d04b9752a32e33d46a57717121353ef7
> > > Author: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > Date:   Wed Jun 12 01:35:27 2024 +0000
> > >
> > >     rcutorture: Add CFcommon.arch for the various arch's need
> > >
> > >     Add CFcommon.arch for the various arch's need for rcutorture.
> > >
> > >     In accordance with [1] and [2], this patch moves x86 specific ker=
nel
> > >     option CONFIG_HYPERVISOR_GUEST to CFcommon.arch
> > >
> > >     [1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhou=
yi@gmail.com/
> > >     [2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d=
590@paulmck-laptop/
> > >
> > >     Tested in x86_64 and PPC VM of Open Source Lab of Oregon State Un=
iversity.
> > >
> > >     Link: https://lore.kernel.org/lkml/cd3709dc-2c08-4ac2-a19b-d8edb6=
6195e3@paulmck-laptop/T/
> > >
> > >     Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
> > >     Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > >     Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > >     Cc: Mark Rutland <mark.rutland@arm.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh=
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > > index b33cd87536899..ad79784e552d2 100755
> > > --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > > +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> > > @@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORT=
URE_KCONFIG_GDB_ARG"
> > >  config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KAS=
AN_ARG"
> > >  config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCS=
AN_ARG"
> > >  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_=
ARG"
> > > +config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
> > > +                 "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null=
`"
> > >  cp $T/KcList $resdir/ConfigFragment
> > >
> > >  base_resdir=3D`echo $resdir | sed -e 's/\.[0-9]\+$//'`
> > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon =
b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > > index 0e92d85313aa7..cf0387ae53584 100644
> > > --- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
> > > @@ -1,6 +1,5 @@
> > >  CONFIG_RCU_TORTURE_TEST=3Dy
> > >  CONFIG_PRINTK_TIME=3Dy
> > > -CONFIG_HYPERVISOR_GUEST=3Dy
> > >  CONFIG_PARAVIRT=3Dy
> > >  CONFIG_KVM_GUEST=3Dy
> > >  CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=3Dn
> > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.=
i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> > > new file mode 100644
> > > index 0000000000000..2770560d56a0c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
> > > @@ -0,0 +1 @@
> > > +CONFIG_HYPERVISOR_GUEST=3Dy
> > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.=
x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> > > new file mode 100644
> > > index 0000000000000..2770560d56a0c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
> > > @@ -0,0 +1 @@
> > > +CONFIG_HYPERVISOR_GUEST=3Dy


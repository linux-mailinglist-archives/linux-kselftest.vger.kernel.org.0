Return-Path: <linux-kselftest+bounces-25424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDFA22DBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 14:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E377A18AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 13:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945351E3DFA;
	Thu, 30 Jan 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByHuLa8H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA80819;
	Thu, 30 Jan 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243660; cv=none; b=PoSaI4+ctVpCSL80UkwA5fOL6i/+ze0D0TcvhIlv5GkZgkJNzqCsqNmxtlLP7l6hXKh1XXCGGXLbER6d49icVsYrZZtHikLwbLzZHb0iTsazmX4x/TMsmCtXDCgQgr76gKWnsC00jp2/HV1rSeXufcsQt29GMyMptrZIZKbBP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243660; c=relaxed/simple;
	bh=nCvbnjCsBbJ5FsxX4YRrfQaHw0Tx+zG6GrSTdxNaiQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEQIL58eWx3Tprb+49EqnSRxnEVPSh/MK0JTJQV3gKAE0AlMuynnf/AJauWyO3IIMSomJOw5/O4OhqeT4zhAwTKYyl7asG/iXIBvyCWgXFusDAj0vRGEFHZ55SpBzxeabxXhkyUc18eeLr0Pn3VPEJ3rJI4HXX0pvGwHU3yEVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByHuLa8H; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-854a68f5afcso6423039f.0;
        Thu, 30 Jan 2025 05:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738243658; x=1738848458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq1XFa9etbTxIeq8MzY5AubOpQwzI5sUCBw+tZsW4jk=;
        b=ByHuLa8HyUqYCsB2Qmn4qx7OL+eC/42NIfkUySGfnL+yJRWPKMizGozoGuJlCAb6w4
         11HEFYr7VFQzdKwGsoafzlKidKsQkfan86ImO2Do9IZwlVzMwcyW4OJs5aCIoXP39KNc
         d9fTf++9YJFzHpvfIc1V8jbJVr/dkVpW57k5OwiIvklAxmpWsH3RTVipLJkfgDvnyC3l
         ayL5h37vhaA90QoEJUoFC8F4rw7oCY278E91CkJ61/vxX+vLikkF5eyss9A7eYr+bJyr
         rHs9lZccxSarN8Hic0pKgNrAXWjxPn4YjEc3PUTzvouMQjX2uYKlk18XpuSMf9GGkIvb
         PfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738243658; x=1738848458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq1XFa9etbTxIeq8MzY5AubOpQwzI5sUCBw+tZsW4jk=;
        b=gVzcabKguyHPcLVvuIaz2yQ5chuubLRoCGkuqYNoRAzFwJSMWP+kIPDKeNl5KNJJAt
         HwUcHUg+bKi+rpJHJtp5YDmxBx8DUJNlL6q1Jb9WFxNmrnyBFYeGWLRNkN85vjj60rUP
         C3LZ/1v5nq6BpGlNBfIssjRX7hj4+udPIYkjJ5nM26lAmrdywHsobjg+BtbVTbBaKctR
         PlaTY2PN3zSwBscThMN/Wtyz25dnBVw9abNcukkqND+G3buceFFQZ9LCckwk7PQulQ1I
         b2/S6FRJS+g+YSD9SAJ3lMc1m745gCtitAWafqD5XdF6hxDGb1tnyzll0Eq+CMPDduYM
         yADg==
X-Forwarded-Encrypted: i=1; AJvYcCVPwgj2WgsgqttWe1I1bGCdDFh4tpy1IHTmt3KmKo4DNASFhpsp7NeUq6J9TSne/Dp4qQcVS6oSubq6wfQ8+fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwESL40nXrVV9cNJw39fmtOjUqz5IzgE7zv7vrNS0MafKgWkx6I
	6L9lV4I0kG6hWEJsSrgg+h3e2TOdv/pS6BF5L6rAJ4hUy/M+OtYkkjZv6I/ynEg7lNAV6RbjPB9
	JppMgihGi7f3gwLiiX2wuu5TDBwr1S25pcRU=
X-Gm-Gg: ASbGncuVZUg/tUgk9JXEkw9D7ElLcM33ZliDpsd3QwqaDgO58a6UkmsHdk1Y4I1HTwN
	57GIgxecCyw6jDKZM63mFZp2fc/pjxqXutBgWVIKBT2FvXit1CQI8YJYVgrXyatCI3jhsq+pWVv
	fjID7E21iqnQ3yM/AJTIyZDR20lCc9Aqo=
X-Google-Smtp-Source: AGHT+IFtKCmoV6sMWqKrVvA4GF5oxUKXvP72zYNd2p82qdKpGXowwtCWgdSJvQNxoJt2/FhjEZqlzRUgPC5kKws6Ueg=
X-Received: by 2002:a05:6602:7505:b0:83d:ff89:218c with SMTP id
 ca18e2360f4ac-85427e24f96mr716842039f.7.1738243658005; Thu, 30 Jan 2025
 05:27:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129143601.16035-1-annaemesenyiri@gmail.com>
 <20250129143601.16035-2-annaemesenyiri@gmail.com> <20250129120526.7ba0958b@kernel.org>
In-Reply-To: <20250129120526.7ba0958b@kernel.org>
From: Anna Nyiri <annaemesenyiri@gmail.com>
Date: Thu, 30 Jan 2025 14:27:27 +0100
X-Gm-Features: AWEUYZmgRNw3ve5dDOJt5tNThmBvK8l20BuTSdvPp9iayb-Gv6grYrkeZ3f5EnQ
Message-ID: <CAKm6_Rvp+KotAyYrr6w0GCQT1ji5J+R5qX6X8B8ZZQoOBwveDQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com, 
	pabeni@redhat.com, willemb@google.com, idosch@idosch.org, davem@davemloft.net, 
	horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> ezt =C3=ADrta (id=C5=91pont: 2025. jan. 29=
., Sze, 21:05):
>
> On Wed, 29 Jan 2025 15:36:01 +0100 Anna Emese Nyiri wrote:
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index 73ee88d6b043..98f05473e672 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -33,6 +33,7 @@ TEST_PROGS +=3D gro.sh
> >  TEST_PROGS +=3D gre_gso.sh
> >  TEST_PROGS +=3D cmsg_so_mark.sh
> >  TEST_PROGS +=3D cmsg_so_priority.sh
> > +TEST_PROGS +=3D test_so_rcv.sh
>
> You need to add the C part to the TEST_GEN_PROGS, otherwise it won't
> get built. We're seeing:
>
> ./test_so_rcv.sh: line 25: ./so_rcv_listener: No such file or directory
>
> in the CI.
>
> > +     memset(&recv_addr, 0, sizeof(recv_addr));
> > +     recv_addr.sin_family =3D AF_INET;
> > +     recv_addr.sin_port =3D htons(atoi(opt.service));
> > +
> > +     if (inet_pton(AF_INET, opt.host, &recv_addr.sin_addr) <=3D 0) {
> > +             perror("Invalid address");
> > +             ret_value =3D -errno;
> > +             goto cleanup;
> > +     }
>
> Any reason not to use getaddrinfo() ?

I chose inet_pton() over getaddrinfo() because getaddrinfo() depends
on libnss, which can cause warnings and linking issues in static
builds. In contrast, inet_pton() is fully part of libc, so it seemed
like a safer choice.

> Otherwise LGTM, thanks for following up!
> --
> pw-bot: cr


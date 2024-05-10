Return-Path: <linux-kselftest+bounces-9986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7178C1D8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 07:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AB6283658
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 05:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BA161920;
	Fri, 10 May 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym710eLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F231315E819;
	Fri, 10 May 2024 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317535; cv=none; b=Ct4Uh91OMDclwFmQm+CIkXkEcRxDQHsThIpHY7dy9MPfBbGxX/gEuwG6qXK5b1MXBe9sp1VmlYxeN80C7R8nJupxNuejhxwJbVg8D8XJFrqiuKCUi/O1xjtWKTosl0ltHcbki9wF/3Nck+bsnR32kLnEY3VBO3PPoZ6dCVIPSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317535; c=relaxed/simple;
	bh=jDGgcoUKKrxphsvaVnf/uMQ3t2976hJCRm3+2wGPq2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmVschlRqw7h+wsnYa2AaM0+iUeRdXOG6G1E7LfqgWaK86H3tyX74FWrKcEN1eQDepTb59RJXGD6Yvz/bzy9UjcRS76ZyvmBtCAIMsfgF7z0mYxizAIF1wso9YsUUzAVqvV/m/OP+JLSS05ImddETIA8KdP+UAVvpLlhGO2sY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ym710eLx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a2c05006aso83500966b.0;
        Thu, 09 May 2024 22:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715317523; x=1715922323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDGgcoUKKrxphsvaVnf/uMQ3t2976hJCRm3+2wGPq2Y=;
        b=Ym710eLxvwSWAwOtpWMD8zoYbYe0xgqTfzsGrhqS6pgGLlcvY7+qsEcEQVJfPewcYg
         sXZhfZPNuHXwcgKyjAL8e7c8isSPM2nJE9uBmDP5qoiqVMhOy4s5XXB3GdfdT6bo8Om0
         16LALo0WEvHBJgS9rrKJFWkZI3JZajxe+JRKivjAekzrpajnkWz3Qq0cmJHGsvl8hXwd
         ucTghuGGEBWYKEucX+0u8xBxPm/5AIJ+hE6NhNSIZ7e/ZcIkY0cGIuP6+wldxtZoav/Y
         D8rhJmoav8w1MBx16W7lKq0qPSkGSvj1hqxeFOj1CViTWMDPBeU9ix3JR1lhll//2Ujh
         msSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715317523; x=1715922323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDGgcoUKKrxphsvaVnf/uMQ3t2976hJCRm3+2wGPq2Y=;
        b=jpgwpjDNDsqpdOrNR6oYgNWRXGbq+8ogbdDG+5NS/W+tw8sXUfAottGOfNt+sVlgDu
         GAedC+O5PbQniYYfutXH9SRKBX4ar8lzTLy5bIJ2sUEsSSeso/bEooUZTvhA4uxwmKIK
         TYgGSeIRZ2pZg7UZbuTMV9ZIH+U1MEhh3Iad3a+TFnZ4lckn/LRYKU4CpY8MfD82h1bd
         VIyhhyyPtiH/r0lU2LJWHqxm2cipW2Zk8PohRhc67EFLlFZhueRbeBHwc+WbOv1vd2s2
         TicBuUk2iICc04N2vHVpqralC9SWBjfRvxRuw+/O9T/z+zsn5TSKsaoD7kPpkdPPVoik
         Tl9w==
X-Forwarded-Encrypted: i=1; AJvYcCXn47adRN0LPbGfaX1+decQSH1mDyRYheQYTlmVKtpmjDJLz9Rg9gaVQLEJIwJNDQduIjsK4MexJeCBHIxDHAhU0AhEfYz/6JWG180Mp5T5DaFXgJfPoLmBe/iU7dir5r0N6hdbBHTU
X-Gm-Message-State: AOJu0YxdXt2Sj7mTZZlMGHuL+Lor3jM52+i1hHL/Y1LM7N4IAkRCI4yp
	EZkbDxaZcLYEGr1cPzFAESZ1HvCRcM/cZaZXk5Tfj8jpkrVxhSygHu6Tm0ZJalLBGMxt0apmj3+
	mLeCL6CQ85Asm1FyKdU+iycT4nR6zAOTWB2Q=
X-Google-Smtp-Source: AGHT+IFvfQWhu1T/qdm9a3KREXg/Ypu6OnM4R/WZl1q3DCXxu8A88T/TExiiBn6JYOThs25R6H1YaM9IAB9viKA/cXc=
X-Received: by 2002:a50:bb4b:0:b0:571:bb79:51aa with SMTP id
 4fb4d7f45d1cf-5734d6e0021mr1172138a12.39.1715317523098; Thu, 09 May 2024
 22:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508040643.229383-1-ap420073@gmail.com> <d5016925e415c422c37f7ac1c5374a06bbdc2126.camel@redhat.com>
In-Reply-To: <d5016925e415c422c37f7ac1c5374a06bbdc2126.camel@redhat.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 10 May 2024 14:05:11 +0900
Message-ID: <CAMArcTUaeVTDxSMy4u70RiKghAtezea4HBoQcqbRsoaYPa7d9w@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: avoid waiting for server in amt.sh
 forever when it fails.
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:36=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>

Hi Paolo,
Thank you for the review!

> On Wed, 2024-05-08 at 04:06 +0000, Taehee Yoo wrote:
>
> > @@ -210,40 +217,52 @@ check_features()
> >
> > test_ipv4_forward()
> > {
> > - RESULT4=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
> > + echo "" > $RESULT
> > + bash -c "$(ip netns exec "${LISTENER}" \
> > + timeout 10s > $RESULT)"
> > + RESULT4=3D$(< $RESULT)
>
> if you instead do:
>
> RESULT4=3D$(timeout 10s ip netns exec \
> "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
>
> You can avoid the additional tmp file (RESULT)
>

Thanks,
In the recent patch from Jakub, a variable is used instead of a file.

> > if [ "$RESULT4" =3D=3D "172.17.0.2" ]; then
> > printf "TEST: %-60s [ OK ]\n" "IPv4 amt multicast forwarding"
> > - exit 0
> > else
> > printf "TEST: %-60s [FAIL]\n" "IPv4 amt multicast forwarding"
> > - exit 1
> > fi
> > +
> > }
>
> [...]
>
> > @@ -259,19 +278,17 @@ setup_iptables
> > setup_mcast_routing
> > test_remote_ip
> > test_ipv4_forward &
> > -pid=3D$!
> > -send_mcast4
> > -wait $pid || err=3D$?
> > -if [ $err -eq 1 ]; then
> > - ERR=3D1
> > -fi
> > +spid=3D$!
> > +send_mcast4 &
> > +cpid=3D$!
> > +wait $spid
>
> It looks like you don't capture anymore the return code from
> test_ipv4_forward, why?
>
> That will foul the test runner infra to think that this test is always
> successful.
>

You're right,
Sorry, I didn't consider it.
It should not be changed.


> Paolo
>

Thanks a lot!
Taehee Yoo


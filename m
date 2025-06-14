Return-Path: <linux-kselftest+bounces-34975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3779CAD99EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 05:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A1F188417F
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68011ACEDF;
	Sat, 14 Jun 2025 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9YfK+Jl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589C38384
	for <linux-kselftest@vger.kernel.org>; Sat, 14 Jun 2025 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749871423; cv=none; b=Fteb74d1Css5LXrJBW6v7K4xSUrDsv9eH2dATFsAda7e/q4EitPpDkIrAdx6Lc8dEpK5CboBtAirl2ls1ZM5f49E6kEC67GIwuvcgxuRYpeP0j7h6k9e1CThrUBmA+h4+9w8RB5+ff4nvOLNCd6YvFkQjSu7UMnFNHSpydweQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749871423; c=relaxed/simple;
	bh=ks+qgcinxfP2t0Ff5arUdhpbKGhmd/HNmuw7bvh83zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkGlVg7CFlEtsOw9eUtfxtK/4stYMRfid+vCBkCcT6K34tVWroW9ee1f18kwgwZ5U0zBC4gpzB/X0V6Fm/+HOTJFBkEsczASZuUKmHMrfnfLvzR6xDruCau5xiopwhyuqSkGcUOfFg90f2NLEJ/W+my7/lYLiaIDMgLLT4SFEIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9YfK+Jl; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddc2aabcb4so15ab.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749871421; x=1750476221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMC1RgubSI8jxz91HSzJ6Iomy1CrrH+KUaf8/z5C7uM=;
        b=M9YfK+JluehVwcqaR7x5IvlFJiuEsbFNnux4limO89c4+tdeohTFk14wbPMMlS110w
         J3xhKPwFlpaIc0ppy1jgLv+hJK1lP9sgh6z0Cgfju7Wsrn41/MeyzERwLoWB1HhRwCCl
         g/KJnc7yr+Rq8HXDZ2EAYcuZBV5OcRGkMhqo4UBF5sw6APyiBmCMETFC0vGpWNgco0Wf
         B4814TIi8sAvf57Bl0cAx41wtsfokeh1lD7IvrxW0R9Hx85v+b26gw414I2REXLYEuon
         QNSs65LWghJEl8IeyaYyiDKoclGQJQ0jogPHDKAJz+vjv/Sz5WpaFKvvMC0WPGolFWpH
         Am+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749871421; x=1750476221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMC1RgubSI8jxz91HSzJ6Iomy1CrrH+KUaf8/z5C7uM=;
        b=ivwOeYWujq7RTd3lJbX3S+K78UlYobyVASnHhxSZ66xDJtvLMFoz/+v41yctTDxK8e
         P2jEaCYlf2trXljeYFW/xXPbyEojDuGKK8pjik2wDdB4kGJggaSBL677k/tPNlM4mRVZ
         tVn96ey5uQY775pGLpQ0fCByijPjiCYvISTp8KDKOpAkn3412DfFDIzxEujEr86leHHV
         doIdFU3NvhkbzFiOkiHTmW3wthTNQgmZPBxy6SEF5TnbGi3DyL0svYHdhJJkoIvTnHbq
         Us08SimzYJ1/0RpqFNhD5xmMjH/ooTvbkvbP6Nqx7Bikl04VQ/CQsPoVH1/ARW9XZuqM
         QRgg==
X-Forwarded-Encrypted: i=1; AJvYcCVvegKpkSOSUGhVEWLnwzUrwJz+vMHvRPniIKjX2BgkCGvgcrPMbBZVkBuMx6P872U6d7Ou0D4Z/ZjssX6q77M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMy8g07hxT+8m/kulo3LSXmhI/bl90fD8+tWWpc9WQ6+6nTc6
	vbTHUtvI58rM4IBBL3ttNxWYvUyX9Y9X5bnyCYSnA77iZuMNY5VenG58Brxx2LRdkKifAeNJwVI
	iB5IHzNhBdgrvniiZaGENOimVJJHCDIqgQpeYWhk9
X-Gm-Gg: ASbGncshdFJree5tPtNo27omvC+pREzCPWdWquOGouDHM/rzIlWEmCLO66Fu/Ntj85p
	zk5ldfvB1jcNAEgZnxnAefHmpiLD/wNH2UjKNKMiGrBx39vWfpF20vp7ZBj+UqLWbli2Rh26YZx
	SHxCvTt4hfLm7AA5HLdyexr9LXxC3/nEe+rmrEKeyjz2JRuzguvPL0t+umGGUWFSA26Z3N6bIb9
	HWp
X-Google-Smtp-Source: AGHT+IGlo6uYJF3Gn+pJN5jxgxVqy47hoLKB0YLDiznhdZSCh4GpZSc2oGthgnIZd8sYwsSUIl4f1nc2rSzZ3zzdsK4=
X-Received: by 2002:a05:6e02:2506:b0:3d9:3ee7:a75b with SMTP id
 e9e14a558f8ab-3de0817db53mr1219875ab.1.1749871420405; Fri, 13 Jun 2025
 20:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612020514.2542424-1-yuyanghuang@google.com> <20250613172941.6c454992@kernel.org>
In-Reply-To: <20250613172941.6c454992@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sat, 14 Jun 2025 12:23:03 +0900
X-Gm-Features: Ac12FXxi5jeP--oHy4Yft2q1FN2un7YHLfDbIUoTs8jLrWX9Uvhk2nC5jLxyXBc
Message-ID: <CADXeF1HJ7dyw5gp7sKZvRgf_WLuEJatqfKmfxzpWtLibB=e9rg@mail.gmail.com>
Subject: Re: [PATCH net-next, v3] selftest: Add selftest for multicast address notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the suggestion.

>Perhaps move these to lib.sh as a separate commit?
>They seem generic.

I am looking at the existing test cases, and it seems that each case
is doing its own way of handling the end_test()/run_cmd(). It's
non-trivial to unify everything into lib.sh, and it seems to be a huge
refactor if we want to do it this way. I can also imagine each test
case might want to customize the behavior a little bit differently.

On the other hand, it seems some of the helper functions I copied over
can be simplified. I will refactor the code a little bit to reduce the
duplication.

Thanks,
Yuyang


On Sat, Jun 14, 2025 at 9:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Jun 2025 11:05:14 +0900 Yuyang Huang wrote:
> > +VERBOSE=3D0
> > +PAUSE=3Dno
> > +PAUSE_ON_FAIL=3Dno
> > +
> > +source lib.sh
> > +
> > +# set global exit status, but never reset nonzero one.
> > +check_err()
> > +{
> > +     if [ $ret -eq 0 ]; then
> > +             ret=3D$1
> > +     fi
> > +     [ -n "$2" ] && echo "$2"
> > +}
> > +
> > +run_cmd_common()
> > +{
> > +     local cmd=3D"$*"
> > +     local out
> > +     if [ "$VERBOSE" =3D "1" ]; then
> > +             echo "COMMAND: ${cmd}"
> > +     fi
> > +     out=3D$($cmd 2>&1)
> > +     rc=3D$?
> > +     if [ "$VERBOSE" =3D "1" -a -n "$out" ]; then
> > +             echo "    $out"
> > +     fi
> > +     return $rc
> > +}
> > +
> > +run_cmd() {
> > +     run_cmd_common "$@"
> > +     rc=3D$?
> > +     check_err $rc
> > +     return $rc
> > +}
> > +
> > +end_test()
> > +{
> > +     echo "$*"
> > +     [ "${VERBOSE}" =3D "1" ] && echo
> > +
> > +     if [[ $ret -ne 0 ]] && [[ "${PAUSE_ON_FAIL}" =3D "yes" ]]; then
> > +             echo "Hit enter to continue"
> > +             read a
> > +     fi;
> > +
> > +     if [ "${PAUSE}" =3D "yes" ]; then
> > +             echo "Hit enter to continue"
> > +             read a
> > +     fi
> > +
> > +}
>
> Perhaps move these to lib.sh as a separate commit?
> They seem generic.
>
> Please fix the shellcheck warnings. The "info"-level messages
> are up you, SC2317 can be ignored.
> --
> pw-bot: cr


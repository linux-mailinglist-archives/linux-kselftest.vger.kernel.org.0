Return-Path: <linux-kselftest+bounces-30093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155BA7B70A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 07:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8623B78B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2171145B25;
	Fri,  4 Apr 2025 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+yPvcj2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018FE57D;
	Fri,  4 Apr 2025 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743743314; cv=none; b=KaIE4bqbop9KhJmf1QO8gWTVWhweCgqi55pP0hlydYIR1LjEbp+oUuS5fGFyrE6aTEn6JpQw5xUAwDgssT/hz8qZp4McI+RgZsd5DqApOtKEljnR5g4pvtkIGcR5BuUBU1lSzRAir+bkd+gVmy5ebnznQwlnP6/v7AROp94g+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743743314; c=relaxed/simple;
	bh=JoldXrkm+WuPDC2D+3ZXyfTf6gFSbkAdwf5bTVVPB/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpYOuttSjk77C5xie+EQxhA3lkJfvgvd3S2AVZ/WJN/xUiEYIu9ngTR8uXJp94aOt+vds1yCHAXkL41NKVgxeZSRbQOMyZF3q4MXpXi2+bvo/D64SP8QGS7m10IMfKUDgMvPiTmTkR4K3QTX9jQ1oOn6mqzX1C2AzdB5vdcseL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+yPvcj2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so2690339a12.3;
        Thu, 03 Apr 2025 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743743311; x=1744348111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxmqoiN7GgZYQQd4K4xM2K9htfgsC3Kosny6eqV4vRU=;
        b=Y+yPvcj2ieCQU84k5TTT0EJcvFXoeEA0CilL/Sils14tSn5qigQPGRgVAopeJbBay+
         SNM96vqrrOxWH8QEm/kMPQlW0FPX/5NisW2hERcXuau1TwXHNIncs8IWRzvNqgw3/6vh
         F1qRej6u6bLXHCLdBUU1nPjH/Tm1QbMdzrrS7S3IiHeaU6Sa6TOovWc692UwH3qdX2vq
         CoziC2AE1v6crQy42Lpi1DgBiJ4dRh0HcL6bdV3UX43II2aKfaFC3kzVY0ZqxOfkZcAr
         0/mEX05RVwJKOUrXXiZty7qQ39OosWMRS7bjvpObyfGXM5GIJ7q/H/hQL2LLbd7uyOjA
         VMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743743311; x=1744348111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxmqoiN7GgZYQQd4K4xM2K9htfgsC3Kosny6eqV4vRU=;
        b=NkTPO/5eZOvGl7Fq1zU6nchgEQ4h4boAqkFmDFkcVUIRjlBCKBWIKhVc72Otp7Iw+N
         lmDf2i4nmIJIR9x7lQ9rFuYs7JJQEIq92fEFJDcsgqHpVix+GJNKvVrkf6n+7AwnppHG
         aIhFl6u4xRcFt2mmUZLpeMynZS8+sbVXSsStshMaYycyKD+v1NAemLqhf8I7TGutEtrg
         P9jC3VkO/zSbgKggeZapb9Y0fqzjvbjz6DxYYJNkd6W1B2ZLSRoOzLykLBFbqefp2bWm
         FW731TTaTTvVrnILiKf8nl2Di1aNL9u8GoSsm+sXucJ2syGa38pxvJZiJyyobTwAKzfH
         AszQ==
X-Forwarded-Encrypted: i=1; AJvYcCUECbzCtogekbfVQwy+oqsJguvXGvahpDMWuWvObbiAcG7DVjKE+guRBSxdrqp9ClC5+9/OwNtJ@vger.kernel.org, AJvYcCXz1pVUs9mnn1B8420zjNnhzFhjd/jZh69Mng4+gLI0hWqKv3BOcoGe+zGfVKbrwqnbIxYANB79l0/7DUgnW8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCUcnX0ko1fQ4ovc+rSjdZoj4Lakv7tc9prAaQV05zwzwlFcP
	mwj8MUCzh4yzr7Mk/8mNzMn2IRfFOjEdCFYhN9E8LvRWWhkx4b1mVoZUWwT71+jzodg4/thLxRK
	FJywOny2761eF2ByuTeyOZDRbqz4=
X-Gm-Gg: ASbGncv+E/duZB36ONTLZnjUauxKyvfONu5DI9AZAkOiAQW0bRmEXlWHcWslwEqFmGW
	xJijgKLwA47FEMDHl2Dc2qYZgw4SHO53I2yCIzsMiHM5umI3fWy5HJcYNDwaZL/i/iorINsTHTH
	vA6obhnUVGaXvMwtcIpC/tDlFzCEon
X-Google-Smtp-Source: AGHT+IFeFzn9/+2gXc4a2Ug1a/lI3ESc7/s0uO654IwvUMD3t8HFyaP7kJW7ciMxg61XYdcx+9R986eq6cTrdMsDflM=
X-Received: by 2002:a05:6402:524b:b0:5eb:cc1c:bb9e with SMTP id
 4fb4d7f45d1cf-5f0b5d82c73mr994109a12.7.1743743310726; Thu, 03 Apr 2025
 22:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403145636.2891166-1-kuba@kernel.org>
In-Reply-To: <20250403145636.2891166-1-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Apr 2025 14:08:19 +0900
X-Gm-Features: ATxdqUFQyIMwV3KsoHGd_UjIvZwgQhhyJ10i-T6QuOgLJ4ne_2Fwp_Tx7MtQPWk
Message-ID: <CAMArcTWoxuPUJFN=mOzwTeSbnb6CiusnWusAocFEWgX-gx4B5A@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: amt: indicate progress in the stress test
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 11:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for this work!

> Our CI expects output from the test at least once every 10 minutes.
> The AMT test when running on debug kernel is just on the edge
> of that time for the stress test. Improve the output:
>  - print the name of the test first, before starting it,
>  - output a dot every 10% of the way.
>
> Output after:
>
>   TEST: amt discovery                                                 [ O=
K ]
>   TEST: IPv4 amt multicast forwarding                                 [ O=
K ]
>   TEST: IPv6 amt multicast forwarding                                 [ O=
K ]
>   TEST: IPv4 amt traffic forwarding torture               ..........  [ O=
K ]
>   TEST: IPv6 amt traffic forwarding torture               ..........  [ O=
K ]
>

Reviewed-by: Taehee Yoo <ap420073@gmail.com>

I tested it, and it works well.

TEST: amt discovery                                                 [ OK ]
TEST: IPv4 amt multicast forwarding                                 [ OK ]
TEST: IPv6 amt multicast forwarding                                 [ OK ]
TEST: IPv4 amt traffic forwarding torture               ..........  [ OK ]
TEST: IPv6 amt traffic forwarding torture               ..........  [ OK ]

Thanks a lot!
Taehee Yoo

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Since net-next is closed I'm sending this for net.
> We enabled DEBUG_PREEMPT in the debug flavor and the test now
> times out most of the time.
>
> CC: ap420073@gmail.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/amt.sh | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests=
/net/amt.sh
> index d458b45c775b..3ef209cacb8e 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -194,15 +194,21 @@ test_remote_ip()
>
>  send_mcast_torture4()
>  {
> -       ip netns exec "${SOURCE}" bash -c \
> -               'cat /dev/urandom | head -c 1G | nc -w 1 -u 239.0.0.1 400=
1'
> +       for i in `seq 10`; do
> +               ip netns exec "${SOURCE}" bash -c \
> +                  'cat /dev/urandom | head -c 100M | nc -w 1 -u 239.0.0.=
1 4001'
> +               echo -n "."
> +       done
>  }
>
>
>  send_mcast_torture6()
>  {
> -       ip netns exec "${SOURCE}" bash -c \
> -               'cat /dev/urandom | head -c 1G | nc -w 1 -u ff0e::5:6 600=
1'
> +       for i in `seq 10`; do
> +               ip netns exec "${SOURCE}" bash -c \
> +                  'cat /dev/urandom | head -c 100M | nc -w 1 -u ff0e::5:=
6 6001'
> +               echo -n "."
> +       done
>  }
>
>  check_features()
> @@ -278,10 +284,12 @@ wait $pid || err=3D$?
>  if [ $err -eq 1 ]; then
>         ERR=3D1
>  fi
> +printf "TEST: %-50s" "IPv4 amt traffic forwarding torture"
>  send_mcast_torture4
> -printf "TEST: %-60s  [ OK ]\n" "IPv4 amt traffic forwarding torture"
> +printf "  [ OK ]\n"
> +printf "TEST: %-50s" "IPv6 amt traffic forwarding torture"
>  send_mcast_torture6
> -printf "TEST: %-60s  [ OK ]\n" "IPv6 amt traffic forwarding torture"
> +printf "  [ OK ]\n"
>  sleep 5
>  if [ "${ERR}" -eq 1 ]; then
>          echo "Some tests failed." >&2
> --
> 2.49.0
>


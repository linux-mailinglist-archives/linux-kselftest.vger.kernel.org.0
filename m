Return-Path: <linux-kselftest+bounces-4021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 369D784746E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16B2295EFC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E5B1474A9;
	Fri,  2 Feb 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbS81ynG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332FE1468EF
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890462; cv=none; b=kr7QG1HS40j+mP/gA1IXOQVCik0xaMkX7fMPErruVrghO+wyGGd6MV9Mxe7kNol9lCOZW0bXVv0ScgpmhzOazbxxxKez2VjRxlzCjoAn2jvz24xB5Phet9HI6tFk6AFRsGQ1wxPefaSsrYQEnv7+un27wGo7GzxaNS7fAruQsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890462; c=relaxed/simple;
	bh=Ri3/hQOGxa7fvdX6zXfOFaMYOWypSsO0kQTSZQ0812I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyZ8WTWxGaUPDjSgKaGhbu1B166Q635L2M6xT4AAjfkuUqd76UuOEN6yXCG2fnVmefTNhVBUes53hPuKCIfNMT5qTuox+b8POMDwlFV1Q2RdNxsvsVi7qRl4PdiVoLQIh9KI1ASSr5nqSulGIBzJQR8+cQfFN5cCqH58sa8e5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbS81ynG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55fff7a874fso7981a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706890455; x=1707495255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6KbT4kBuivO+GxSvi+LQfZT8tk8UxIY20bJMtmOgR8=;
        b=tbS81ynGmyTwKLMxtAaHlvpfXYIHcMUPi/t2NTzYZOEn3Zm2ROibbJSAtOhB5RVPZz
         p1DiyYMy6WfSg8uAVZZC9r6I0g7Lq4qqbH7F0mGqAr1jQRxdjhPz9dnf6QkjbaL3nh+p
         tqFjpZ/WDrjFKXVlkGzCd6PToB0Y/hjm77sm0calBxt/b00dwOJ9SGnHKTil+Nk5Fbso
         2kyqltN0h2DhXhyAP/bkKPDyKpGJLCRdBPAf3pcm3LLVPf5UF1243NdzMnM8fB/T42yU
         jALuaZpaB1TbQbVUvzFC+TCA7OifEAMxMeZ473VO8w2e0nxFiePHN3Q9uyyi/m1v6Sb0
         cB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890455; x=1707495255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6KbT4kBuivO+GxSvi+LQfZT8tk8UxIY20bJMtmOgR8=;
        b=D4Y4ihk9+VvdKyIW8YqIzudkk6as5ylipM+V0VL2ZOgeOSQe4uzUZEP8294DvdNmEh
         QtdBU8sW+TUXl6dlvUQD6aFy8tQAueTL4EyWKpQVaXdZW2z120Wgx7rUYeVSv8cuBva4
         0n53tYLOKEvae6k5f4mXsS1WDS2yuSZ5uhed8sJ1M936JOJVhe1sQMLqzWtI3NNjlIvb
         CfkFG8OkNEmxqk5uaCQaqES488T5K5u/caY9evISPzSDElNgtBuYinFtne7cG/NJMSdn
         aesLBs0dwyNgGe3y/pcAMclwO5Dg3yzhqniMe5dRzNGKb+sYEzI1l6wHLskjJCc+4ZzG
         w9og==
X-Gm-Message-State: AOJu0YzYIBgWx7wR/a6lIiwjuBtmIH3IW5NEVeyeIo5/Wc5YtI2rD/95
	mF95qABzx26KXOGr5IeJPm2dsKkeBw1jjUo05bBAsIPco0sTF8dURyExLNpReGcDKjmkruhnSuf
	gQgxQyTSDwWsnI8bRV0LAE1PF8dpR4sxLY1Mq
X-Google-Smtp-Source: AGHT+IGoWJsfhic7qRq3Vkd/uQY7ncJaEl4oQRFpZ6VVQ+6xH8r5zNwrHxEHwrY4VVtCqnRYr0wWw05OQfRx3tGtzzg=
X-Received: by 2002:a50:ccda:0:b0:55f:98d7:877c with SMTP id
 b26-20020a50ccda000000b0055f98d7877cmr30140edj.5.1706890452766; Fri, 02 Feb
 2024 08:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
In-Reply-To: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 17:13:59 +0100
Message-ID: <CANn89iJ8b-vXhH0Rc5isVTaxgSQ871mud+ttQnLOLtuCu14UXg@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: let big_tcp test cope with slow env
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> In very slow environments, most big TCP cases including
> segmentation and reassembly of big TCP packets have a good
> chance to fail: by default the TCP client uses write size
> well below 64K. If the host is low enough autocorking is
> unable to build real big TCP packets.
>
> Address the issue using much larger write operations.
>
> Note that is hard to observe the issue without an extremely
> slow and/or overloaded environment; reduce the TCP transfer
> time to allow for much easier/faster reproducibility.
>
> Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/big_tcp.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selft=
ests/net/big_tcp.sh
> index cde9a91c4797..2db9d15cd45f 100755
> --- a/tools/testing/selftests/net/big_tcp.sh
> +++ b/tools/testing/selftests/net/big_tcp.sh
> @@ -122,7 +122,9 @@ do_netperf() {
>         local netns=3D$1
>
>         [ "$NF" =3D "6" ] && serip=3D$SERVER_IP6
> -       ip net exec $netns netperf -$NF -t TCP_STREAM -H $serip 2>&1 >/de=
v/null
> +
> +       # use large write to be sure to generate big tcp packets
> +       ip net exec $netns netperf -$NF -t TCP_STREAM -l 1 -H $serip -- -=
m 262144 2>&1 >/dev/null
>  }

Interesting.

I think we set tcp_wmem[1] to 262144 in our hosts. I think netperf
default depends on tcp_wmem[1]

Reviewed-by: Eric Dumazet <edumazet@google.com>


Return-Path: <linux-kselftest+bounces-38035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE08B14560
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 02:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A36A3A6461
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 00:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A99158DA3;
	Tue, 29 Jul 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPO4MZup"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A157E9
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753749255; cv=none; b=rT+IoMX7TT0/J3wKDSPoVVqb8SFr/8xbAxxsCO72EaIbWSrJEOtvRQKqnudDUzyntpOdHYvEOHlR9/xx5WufJp1yaIzowZ50HeRs7HyHkeLppUjWNKGfb0e0TfzHNx+RPorYK9gBupo5O98f+swPjVBTCXdkEHUgpLacA3HEbKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753749255; c=relaxed/simple;
	bh=We8NJtlyTWcxGuMNQojHZp8dx/FczpaYi0fnBJaQNsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK73eBglIMZ4wb0I2Bk6TqRuIlmiKsFjRzX7kjLB+UF0zL15CJI0P4kLe1CaQaHKnIZdZBGkGB8+4zpQhfGvjD6H0sXkvl0nraUZMmOp+0yj3zK3R7d2JjmkihWxLxkFpSdgGetH1zaPMxnRdVJ8+NG5KlejMfb7UZxJ+nyYpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPO4MZup; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso5238110e87.2
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jul 2025 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753749252; x=1754354052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Whj6JY75Fsg3BGdNR1zOYqR+ir+e7R/Ma+Im3UM2w=;
        b=yPO4MZupLkyHhyubVSIcXEAUVemsKDl2e78D3LD7DM4x/XMMUylPdLHy7scKGZtjlK
         PNrSK4HeiT7B4Hues+SXuj72usWlvewYDllu9pVhL/ATWMd09OxLqT0/idrMjX3QV2W4
         LOK3uJxRaASvm57rQZQoo6V0AQBAySrMLTQJv24cZKGD9e11FCnyPrHulEDmveN5R47K
         lU+s58b5u9kMdJ4yX+InP49kFen5nO8GvRNd3ypB7vO+xDw08z070e3+PBCpPvq5wuOo
         ZyFg1c78uS3dYD4GW4W84tQxiHwrM+RWyu0t9ZNmgft2axPt0kM3A2oLuLwAqojWdcly
         cXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753749252; x=1754354052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Whj6JY75Fsg3BGdNR1zOYqR+ir+e7R/Ma+Im3UM2w=;
        b=hlK5MXaO/eWNNu0k7AQnXKSf2115DAB92c9C8/Wn4ueYVlkE3DqRjCKWKXxYhxBHao
         d3dmvMeHmcDnN0lFpTSoISE56uYmX/8vnu1xoKRyptIDbokbFh9QT01g97/4ab0/kKjG
         0lepV3DV+4fQGX1YdImtix+SO1T60ZkHOjQPv9epG45JmV0PTKxE/uYVuwP1vFo+bLwc
         2sPr9NswoWffvTtXS5tAEHk5qCH1MnZGaB32EkcYiUEBgI/Yod+hVxWFGBwOaCLYDk0c
         U3ZJpZe/ne2dvAlKSJIsfI3HKen5A4J6r8AFu85eT5HS8UI/xiVY9cEIqUsxifdghcoa
         0yrw==
X-Forwarded-Encrypted: i=1; AJvYcCXmA75rS+96izgDY7CtVxIJ20QYqRbveLoX2OQFWTjwq1VuaKZ5YUQQKzDvCFR0LwAKzZihCzEY86sPonsJ0mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKhuYLoREpjkMgXu3HOmMoNoVFHjm4VPvHj3QQTJ/m9t+T9Ac
	ezYz3SIUkoeLVy/Nn6whB/N7Bid1skOdr5RFP5dAZyy5gK5ysdJB7xNE9dAVjFjdMqp9IHNlUyU
	5vpLvw4jm3qUFgzH98ZBSUNX8mI5Fw1GOGRfBywg=
X-Gm-Gg: ASbGncub0o6eCn/luGuhOytGotAN1SksoC6spZb8V+HSzw52y718hdh2SWE4WNZpmTB
	vXy8qxE1AeXI1dkQorqH2GANuRb/9RWnfA1oZfjERcqz+685ByUUsJDpUj1fXqMy8HuKJ9advbV
	42Y9paNIZWvBCD2Dfbvm94WsdjX0tl7nIz25pkAK3XM2UuG6DbOJNExQbU8vG4TsQpApX0WP56G
	wUmUtx/wUmpsWtX4Q2eIL2G7WJw3WTpDniMyDNeH30XiiE=
X-Google-Smtp-Source: AGHT+IE5Bd3w6Z2LNk6JRJ5jb6wy0zCYf9qbylShax6ErHFAM8WXw/mBfuBo7PfCsKUKTRRy7MxR3WI/hNN+ZBzHSpg=
X-Received: by 2002:a05:6512:39d2:b0:553:2e92:2c98 with SMTP id
 2adb3069b0e04-55b5f4aae0emr3881608e87.42.1753749251816; Mon, 28 Jul 2025
 17:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728160304.929942-1-vishistriker@gmail.com>
In-Reply-To: <20250728160304.929942-1-vishistriker@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 28 Jul 2025 17:33:59 -0700
X-Gm-Features: Ac12FXz-7iuhq18hkJw4umTW928d3CO9rlgWoiq82Ex2oaKStpEFt6sQvk9SfzY
Message-ID: <CANDhNCpp5DxzRufL9iVj8p0tpNSXG7WPEcTDpLbb2TzrY9HyOw@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: improve adjtick output readability
To: Vishal Parmar <vishistriker@gmail.com>
Cc: shuah@kernel.org, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 9:03=E2=80=AFAM Vishal Parmar <vishistriker@gmail.c=
om> wrote:
>
> Reformat the output of the `adjtick` test in tools/testing/selftests/time=
rs/
> to display results in a clean tabular format.
>
> Previously, the output was printed in a free-form manner like this:
>
>   Each iteration takes about 15 seconds
>   Estimating tick (act: 9000 usec, -100000 ppm): 9000 usec, -100000 ppm [=
OK]
>
> This format made it hard to visually compare values across iterations or =
parse
> results in scripts.
>
> The new output is aligned in a table with clearly labeled columns:
>
>   Each iteration takes about 15 seconds
>    ---------------------------------------------------------------
>    | Requested (usec) | Expected (ppm) | Measured (ppm) | Result  |
>    |------------------|----------------|----------------|---------|
>    | 9000             | -100000        | -100001        | [ OK ]  |
>    | 9250             | -75000         | -75000         | [ OK ]  |
>    ...
>    ---------------------------------------------------------------
>
> This improves readability, consistency, and log usability for automated t=
ooling.

No major objection from me, but also I've not followed too closely if
the kselftest output formatting has been formalized further (I know it
was moving towards TAP), but it seems this test hasn't been converted
yet, so it probably isn't negatively impacting things.

So it might be worth looking into getting the output to be happy with
TAP while you're tweaking things here.

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

thanks
-john


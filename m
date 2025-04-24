Return-Path: <linux-kselftest+bounces-31519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A55A9A48D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618CB7A4A0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BE11F4639;
	Thu, 24 Apr 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hKIKRJFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640F1F4281;
	Thu, 24 Apr 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480627; cv=none; b=B4y1/gtP/VBsnu+pZlLUYFLhtUU4RGrg2eZB1h/hh/hNXoTx3gL1rxswEprc+MaYQ4oUvjo3dvv62cLOdmJqMwFDa/QaYgK/bvFL2nqmoXTLXuQE8QHG1UZS2U8YTKGsvGtWsNrz+H3jgwEsYfDCLHJ+89OeVyaD1lzO9P0uTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480627; c=relaxed/simple;
	bh=O6yrGAzqaup7CwFSBUUclkCIDxpOHbcfAMztnYjjkfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4gsJLgEHI9xekU4uWX5RxrDmcC1RUTHvjgk8Yk+ii/Kd7lK8WAkC5IQXXEJPPZdbogjyyTqoq9ZhFB8cQuLpVQ5fnUtHDUvbhkxmTHzTVEu8dlahCSVcmNY8s9jw4c0wAzgyiNgQQkuGcEYib+ITIbt1kX6/jUx9Vcwek48o68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hKIKRJFx; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by smtp.orange.fr with ESMTPSA
	id 7rE2uyXOmRaJG7rE5uYbSH; Thu, 24 Apr 2025 09:42:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745480549;
	bh=P1axsTqElSQvWU//00NHvuNC2bG0mO4cI3nuzaLgbrA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=hKIKRJFx9JbI+zw1lpBvRFk8EfyWBrFXvBV8X3uthuOREVPRWNlpWO+aPv1H/3w8J
	 A2oAeyAsrfBGucs/nuxKRWFp0vpguGcinC6Hm1T8UiQ/pEnW0FfRBvw3Ejnd6+ReJT
	 8QaQwA94Z0Ui1jv5E9oNEInmw1kBLISUjvj3kreDfrIWE0IydJ2C8RzbrYhcNimjGx
	 DaEnAp6GYlZcOP0kTvQ34wrftgLbo+4x80mgMGSMlvj3SHWXQk+D+VM61AQefH7aSx
	 tSswD2idav4xqn2bxhZlghx3w7oo3+KC1dCazO+K6IiI3RxccAdjnqvDVnREwPIw7n
	 0GbSgUCDPs93w==
X-ME-Helo: mail-ed1-f43.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 09:42:29 +0200
X-ME-IP: 209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so1030311a12.3;
        Thu, 24 Apr 2025 00:42:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvyK6P08n+EvagWhToN3EzfyqJl6aR5USORbLJt80+Bp4lT6i37CxxSTTpUwUGJZkaqKymvrMTgkw=@vger.kernel.org, AJvYcCWciqa2R50wT/0KkGPUeGlDrMl+8UBUOZrKT7/enwyK3QQ9jWgdUXhvlkJS3e9TiUf0AQCqzhb44mn2OgXnBH2N@vger.kernel.org, AJvYcCWy2J4xytl4yR8d1Il6OwYhhkf8JOr+oFtYG1phBxeVgYPf1ShUeRWnDrBUUO3QLfoYA2H+gkjI@vger.kernel.org
X-Gm-Message-State: AOJu0YzLW7HOhIfD8qHxsZnzJpOj7e81tNYgy68gAeF98duvDjQ5XAgy
	Bc2DeWvPe34vfdKzNoqslXmJ9vJUZhsVNMjr4FFwNsoXgU3olGar/Fls4LiSwcIwwWW1otOfigK
	tVDl9F9mOmocY4Z1Rhp9WnHrTAKM=
X-Google-Smtp-Source: AGHT+IHZQb/HhPms49jRFsOdFIdNhHRS6tNNAnKO7HEKgdlO1Ec4NnmI/xA3SIe436TbwHIyhN0/XBMLsO0FM9+xQtY=
X-Received: by 2002:a17:907:3e0e:b0:acb:6472:c444 with SMTP id
 a640c23a62f3a-ace5737a688mr171411366b.32.1745480546375; Thu, 24 Apr 2025
 00:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745323279.git.fmaurer@redhat.com> <a4468403cc51ea6c0e8495d7d095befb37aa5aaf.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <a4468403cc51ea6c0e8495d7d095befb37aa5aaf.1745323279.git.fmaurer@redhat.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 16:42:14 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
X-Gm-Features: ATxdqUEevC2dGJ5oiLCxPIqUZQBSdUTkUF8Dy15XOtMX3G08Wv9ODH_Z4UFgHPQ
Message-ID: <CAMZ6RqKfdNRBKoH16=7JDC2QKB+XO68mahg2X7zKDcUAM+8bzw@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests: can: Import tst-filter from can-tests
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue. 22 Apr. 2025 at 21:08, Felix Maurer <fmaurer@redhat.com> wrote:
> diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
> new file mode 100755
> index 000000000000..e5f175c8b27b
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_raw_filter.sh
> @@ -0,0 +1,37 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#set -x

Leftover from the debug?
Can you remove this line?

> +ALL_TESTS="
> +       test_raw_filter
> +"
> +
> +net_dir=$(dirname $0)/..
> +source $net_dir/lib.sh
> +
> +VCANIF="vcan0"

Here, you are making the VCANIF variable configuration, but then, in
your test_raw_filter.c I see:

  #define VCANIF "vcan0"

This means that in order to modify the interface, one would have to
both modify the .sh script and the .c source. Wouldn't it be possible
to centralize this? For example by reading the environment variable in
the C file?

Or maybe there is a smarter way to pass values in the kernel selftests
framework which I am not aware of?

> +setup()
> +{
> +       ip link add name $VCANIF type vcan || exit $ksft_skip
> +       ip link set dev $VCANIF up
> +       pwd
> +}
> +
> +cleanup()
> +{
> +       ip link delete $VCANIF
> +}

I guess that this setup() and this cleanup() is something that you
will also need in the other can tests. Would it make sense to declare
these in a common.sh file and just do a

  source common.sh

here?

> +test_raw_filter()
> +{
> +       ./test_raw_filter
> +}
> +
> +trap cleanup EXIT
> +setup
> +
> +tests_run
> +
> +exit $EXIT_STATUS

Yours sincerely,
Vincent Mailhol


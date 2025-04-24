Return-Path: <linux-kselftest+bounces-31521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB8A9A4A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107E0442253
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500B1F2380;
	Thu, 24 Apr 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZDX3ay/v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDB1CDFD5;
	Thu, 24 Apr 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480692; cv=none; b=DR3OZnvw9gk7jB7xtfh8xCwAg4tP3LvI9Y///w9nL/HCpg0A5JacB0Jv2FVKVhlbRAEeOCOocWpJMrgiCAvQrRseYVLk7dK0MLwZ0lMb9rpgSSD43oyEtj09w8AYrcNHBYNVwuAVYWKNFcOWheND5gsDXoJr5t5uW4i6Bh+SGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480692; c=relaxed/simple;
	bh=WfVlC2CE0mhoeMmOOND8zbdoC10kmqgVlOqSOsgjkAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXkO709x3QdeGOunPEYyIKLpoEJaAbPwiI4OZRQgey+/Byz/Oj10OkYbg3GSgoAvITMahRLrk6CSlP/MhorU4jmoxooQHmNQGFUxDcIccfSqgEIBEnvwlL0dCrCZh3lE2w17LRuubDHEmHdmw3nK/Z/dGJ77248oqHr4ZjtyzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZDX3ay/v; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f43.google.com ([209.85.218.43])
	by smtp.orange.fr with ESMTPSA
	id 7rFAuQtYPaoZo7rFDuYqr4; Thu, 24 Apr 2025 09:43:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745480619;
	bh=zLfUsOVmwCeRnswWcWOa9E7kofesQSaSiABhPgK0EcE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=ZDX3ay/v1+9pkdNXO3wL9/zeLr2xdSbro9ZKt0Zec5Qo4jcvMGeSq1gejOyg7G8HK
	 lMUBWJUkMV0+VKEJ6+yefeTZ79jrPl4QZoKYj0bs7Mul4Ri3w+nF8p2hZZ89DCm9sP
	 9WoueU9iA4+OGuV/e31kr5De3kccOFWG7dVjoVeFWM/eo137CgEXaVVa0esGQsY06T
	 6VUSNc/AiLQfx2Soi9eYfjfbR/hHWRBky7dCGnY/svQbyLs8978FgGIdS9v/EK0Ai/
	 LOMGA0fKFVWc+UohGN03SBdj8dTIawd+pA8DUgmQh5h32Qf3ZtCfcqSMkPjPmIRn2B
	 t6Gv1AKUJDDSA==
X-ME-Helo: mail-ej1-f43.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 09:43:39 +0200
X-ME-IP: 209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so113377066b.1;
        Thu, 24 Apr 2025 00:43:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTj1wYVNdfYwhOGCtA0/YsSqOp7eaJaG/NxfMwaBDcwYJvkbnEMCY7bOdp5M4NAPgjl7FKW8oEuZ4=@vger.kernel.org, AJvYcCV1ot+xT2nqBSdb9MxwMc2QdPMv8Mq6xbAzEj3Szlea7pTb9u00FL0Al7RkRDDVaBKIlACSMEpL@vger.kernel.org, AJvYcCVGsqxoXID5f2z4mx0LrOTUnxiVZyklZ9B9xGeIX5XvQ2/Ct/cEHUFZhYDLsNNGVCxunHO6+Or889WEsnMOeGSC@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+6JvxhDIAFdvGHidjBzeK3Kz6bS51a6oxsyDHPZqW35Da+Ra
	HL7BFND/7+dj7GP3eBHKwKJMKpWKI0Z7uUt+PhsSwh9P6Pkd8ba4Eakydaqw1XbZERrZ3hAAjFb
	yk7/N49cVsX4UE8RJwttIVthRjiE=
X-Google-Smtp-Source: AGHT+IGjRdePXLP2s9z96dUL3Ys7/hsDE5MhsnO4hyCg7a4HajHQRk5VfYuSRjMBQvIO+1XA0xHKH1TDhNuwktmoggE=
X-Received: by 2002:a17:907:1c1b:b0:ac3:3f11:b49d with SMTP id
 a640c23a62f3a-ace56e3aa7bmr153482566b.0.1745480616336; Thu, 24 Apr 2025
 00:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745323279.git.fmaurer@redhat.com> <8b0e7642b63dfe9de85e3fe65f806843b42d3754.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <8b0e7642b63dfe9de85e3fe65f806843b42d3754.1745323279.git.fmaurer@redhat.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 16:43:25 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+BbLX-FCLUQ+TZuCMs-3FK5EnO_QKcAD+KeLcTEYmB3A@mail.gmail.com>
X-Gm-Features: ATxdqUG5sCLPRfRrVk7qaN-RNk_vmpQ44Moo6dzc3xLKzjU12bdlD8MoDx71EKo
Message-ID: <CAMZ6Rq+BbLX-FCLUQ+TZuCMs-3FK5EnO_QKcAD+KeLcTEYmB3A@mail.gmail.com>
Subject: Re: [PATCH 3/4] selftests: can: Use fixtures in test_raw_filter
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue. 22 Apr. 2025 at 21:04, Felix Maurer <fmaurer@redhat.com> wrote:
> Use fixtures in test_raw_filter instead of generating the test inputs
> during execution. This should make tests easier to follow and extend.
>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  .../selftests/net/can/test_raw_filter.c       | 311 ++++++++++++------
>  1 file changed, 211 insertions(+), 100 deletions(-)
>
> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
> index 7414b9aef823..7fe11e020a1c 100644
> --- a/tools/testing/selftests/net/can/test_raw_filter.c
> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
> @@ -18,43 +18,13 @@

(...)

> +TEST_F(can_filters, test_filter)
> +{
> +       fd_set rdfs;
> +       struct timeval tv;
> +       struct can_filter rfilter;
> +       struct can_frame frame;
> +       int have_rx;
> +       int rx;
> +       int rxbits, rxbitval;
> +       int ret;

Can you reduce the scope of the variables? More precisely, can you
move those declarations

  fd_set rdfs;
  struct timeval tv;

to the do {} while(); loop and move those declarations

  struct can_frame frame;
  int rxbitval;

to the if (FD_ISSET(self->sock, &rdfs)) block?

> -               TH_LOG("testcase %2d filters : can_id = 0x%08X can_mask = 0x%08X",
> -                      testcase, rfilter.can_id, rfilter.can_mask);
> +       rfilter.can_id = variant->id;
> +       rfilter.can_mask = variant->mask;
> +       setsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_FILTER,
> +                  &rfilter, sizeof(rfilter));
>
> -               TH_LOG("testcase %2d sending patterns...", testcase);
> +       TH_LOG("filters: can_id = 0x%08X can_mask = 0x%08X",
> +               rfilter.can_id, rfilter.can_mask);
>
> -               ret = send_can_frames(s, testcase);
> -               ASSERT_EQ(0, ret)
> -                       TH_LOG("failed to send CAN frames");
> +       ret = send_can_frames(self->sock, variant->testcase);
> +       ASSERT_EQ(0, ret)
> +               TH_LOG("failed to send CAN frames");
>
> -               have_rx = 1;
> -               rx = 0;
> -               rxbits = 0;
> +       rx = 0;
> +       rxbits = 0;
>
> -               while (have_rx) {
> +       do {
> +               have_rx = 0;
> +               FD_ZERO(&rdfs);
> +               FD_SET(self->sock, &rdfs);
> +               tv.tv_sec = 0;
> +               tv.tv_usec = 50000; /* 50ms timeout */
>
> -                       have_rx = 0;
> -                       FD_ZERO(&rdfs);
> -                       FD_SET(s, &rdfs);
> -                       tv.tv_sec = 0;
> -                       tv.tv_usec = 50000; /* 50ms timeout */
> +               ret = select(self->sock + 1, &rdfs, NULL, NULL, &tv);
> +               ASSERT_LE(0, ret)
> +                       TH_LOG("failed select for frame %d (%d)", rx, errno);
>
> -                       ret = select(s+1, &rdfs, NULL, NULL, &tv);
> +               if (FD_ISSET(self->sock, &rdfs)) {
> +                       have_rx = 1;
> +                       ret = read(self->sock, &frame, sizeof(struct can_frame));
>                         ASSERT_LE(0, ret)
> -                               TH_LOG("failed select for frame %d (%d)", rx, errno);
> -
> -                       if (FD_ISSET(s, &rdfs)) {
> -                               have_rx = 1;
> -                               ret = read(s, &frame, sizeof(struct can_frame));
                                                                ^^^^^^^^^^^^^^^^
sizeof(frame)

> -                               ASSERT_LE(0, ret)
> -                                       TH_LOG("failed to read frame %d (%d)", rx, errno);
> -
> -                               ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
> -                                       TH_LOG("received wrong can_id");
> -                               ASSERT_EQ(testcase, frame.data[0])
> -                                       TH_LOG("received wrong test case");
> -
> -                               /* test & calc rxbits */
> -                               rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
> -
> -                               /* only receive a rxbitval once */
> -                               ASSERT_NE(rxbitval, rxbits & rxbitval)
> -                                       TH_LOG("received rxbitval %d twice", rxbitval);
> -                               rxbits |= rxbitval;
> -                               rx++;
> -
> -                               TH_LOG("testcase %2d rx : can_id = 0x%08X rx = %d rxbits = %d",
> -                                      testcase, frame.can_id, rx, rxbits);
> -                       }
> +                               TH_LOG("failed to read frame %d (%d)", rx, errno);
> +
> +                       ASSERT_EQ(ID, frame.can_id & CAN_SFF_MASK)
> +                               TH_LOG("received wrong can_id");
> +                       ASSERT_EQ(variant->testcase, frame.data[0])
> +                               TH_LOG("received wrong test case");
> +
> +                       /* test & calc rxbits */
> +                       rxbitval = 1 << ((frame.can_id & (CAN_EFF_FLAG|CAN_RTR_FLAG|CAN_ERR_FLAG)) >> 28);
> +
> +                       /* only receive a rxbitval once */
> +                       ASSERT_NE(rxbitval, rxbits & rxbitval)
> +                               TH_LOG("received rxbitval %d twice", rxbitval);
> +                       rxbits |= rxbitval;
> +                       rx++;
> +
> +                       TH_LOG("rx: can_id = 0x%08X rx = %d rxbits = %d",
> +                              frame.can_id, rx, rxbits);
>                 }
> -               /* rx timed out -> check the received results */
> -               ASSERT_EQ(rx_res[testcase], rx)
> -                       TH_LOG("wrong number of received frames %d", testcase);
> -               ASSERT_EQ(rxbits_res[testcase], rxbits)
> -                       TH_LOG("wrong rxbits value in testcase %d", testcase);
> -
> -               TH_LOG("testcase %2d ok", testcase);
> -               TH_LOG("---");
> -       }
> +       } while (have_rx);
>
> -       close(s);
> -       return;
> +       /* rx timed out -> check the received results */
> +       ASSERT_EQ(variant->exp_num_rx, rx)
> +               TH_LOG("wrong number of received frames");
> +       ASSERT_EQ(variant->exp_rxbits, rxbits)
> +               TH_LOG("wrong rxbits value");
>  }

Yours sincerely,
Vincent Mailhol


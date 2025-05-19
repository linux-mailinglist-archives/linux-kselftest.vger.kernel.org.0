Return-Path: <linux-kselftest+bounces-33338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A808ABC5A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19F31B645C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C38288C86;
	Mon, 19 May 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2mtNDa2U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA1288C10
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675868; cv=none; b=bH5a31AZju6AS+V+3FrN1UK0u1SRGoZ+JEnPKMKYnvdDe0UlgCKyJG4oKj6+DYTEuEWjUhfr6YjmE5QvgOJGpr33y0rt6fsVZTdvWkbNBCPjgudeVskVMNHLLJuiyEH0cHCwWx1hks6nb6X4+s4sdHXxvaiIfszBIXA3TP2qgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675868; c=relaxed/simple;
	bh=9k3rSkCOUuBoGczbRjC9e6BrYoiZJsdyvLLsXOGHPTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOrBT56wX6XsRHHJYqEZ/IFVHbZlU0Rbd6v1yhyDcy+0PINIlLjaOh8cN4gjm3wcOCr6zZeKJzXeklYJcnQ17rb8sAVbXddCptapWjagzrdx188o+UGt8MGBujSmKLWpl+EVefOvk671YrPSa+mgeLKhNOjBJWCdLDowZModR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2mtNDa2U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231f37e114eso477145ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747675866; x=1748280666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3rSkCOUuBoGczbRjC9e6BrYoiZJsdyvLLsXOGHPTE=;
        b=2mtNDa2UCZjQd5G64gKNgvhl/EPIIqYesvKxSqxk/yd9DR4QkGrdBVqUGXgdXIBwrX
         panzXFMmFo222Py+QFlkwUJaYiHleOo0qEfJThS/zYAZptw6HFm7+As7OjcU0KIeiobC
         9ni2HzVPv1rSMkNomYUW9qHF2+76rgX8Oh6WByMEsqiwM9vrjgrdTZdW3+MnixVZGYhL
         uaSQl0Mdx5BSnBGI5onxvmYic/cyEWh4sUeDLcKoMzeWRcsg5Pmy2DsqK1ixq9oChnC8
         J2GZbQ3I6+ORpczhfawUkubTkqrees6WsYwIT3XwAL1hXne/QizzV9zd0hn2ZRsEMz+O
         QCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747675866; x=1748280666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3rSkCOUuBoGczbRjC9e6BrYoiZJsdyvLLsXOGHPTE=;
        b=PIFa6EiA0mzd+3ui2Jt2URrgBkXVZH6lC+dyQ1IJ8KcrKVFG6NxqM/f3TN4kTfHtVQ
         p9HMWcOFz37bsBHlo0Lyy54EJtFAd47msxw933PavSybpSyDhnAYUECuTjmek4cTkhD/
         O2FgIHvyR0M55cAGJ4POvdXvPXROkU78iYIZtjiyrRMQSTbp/xIsgWDi1aNpP9+AGR8q
         9Rv7fCTFJaMpyRZ7Rp1f3SNjjbLNV+lkUGC1o9Rc0X89yXuXZyL5PF9TIADBAbyah2LP
         dW/yLMKl3ZVodCKUEGgUv7MZXm80T3h3649TN48qOU3F2ZoApPXxGeZZQAefrutWsw4D
         Mw4A==
X-Forwarded-Encrypted: i=1; AJvYcCUL3tFym7GsLGnPol01NiRUm0t7fNpCnmypqqDsImjuu4kgef1l49t9HsjCrveTRSH+7nTkC62qRqKbAUzQCOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBERQpIhlMZwSBS5oQ4G8srcrt/ZXHsC8aZtKhdt/U5cWpTNvf
	Kw5ZLaIyrNgfju0Wby/itcB6zyxj92i144RZ1WgVxlQ2zhUjaTCUsECxmCs2Fp3HrfRo8plhc0q
	rlhlYpv6cVYfYHVMuejhRoxZMxFeV8TWR3oHBXBMnOzX+WMAhFkN3jTE1
X-Gm-Gg: ASbGncvZsLOXEHISmyixHBZNCSQykh6Hj9M17Z1sn7dl+ypNJGn/06ZR8gYbdb9S9JD
	fdcPed4eR4zVimx3gVGz1GdPvHzV6LYLBjiITpFqqvEEABA+nHjGF7yOXeKsP++G6TnYyRJZpTG
	pdmfkRt+SEyqIMpjezotVr9F1GK4WqcpAfJ8cbIADKm26r
X-Google-Smtp-Source: AGHT+IEEIZ5rIpCccmFXs6TxZYXiYRfp12vQO1P3n/ZqrkCa4SEVdMDrNAx9mJoPegE4qe9PiPx3y2eAjD4yYx4laKE=
X-Received: by 2002:a17:903:2350:b0:21d:dd8f:6e01 with SMTP id
 d9443c01a7336-23203ed3169mr4290135ad.5.1747675866236; Mon, 19 May 2025
 10:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-5-almasrymina@google.com> <aCtNYJo01UfMOLfr@mini-arch>
In-Reply-To: <aCtNYJo01UfMOLfr@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 19 May 2025 10:30:52 -0700
X-Gm-Features: AX0GCFufj5h-vFrrv9zQxEBaDXmM181og-1BYf2_XB1nm1053kjiQphd_FW10KQ
Message-ID: <CAHS8izOMLm5jLr+778nY0AdFoOWPSb+UV+1sZmOkFb5SSqTGqg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/9] net: devmem: ksft: remove ksft_disruptive
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 8:25=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 05/19, Mina Almasry wrote:
> > As far as I can tell the ksft_disruptive here is unnecessary. These
> > tests are largerly independent, and when one test fails, it's nice to
> > know the results from all the other test cases.
>
> We currently don't do anything special for disruptive tests. I'm assuming
> anything that changes nic configuration is disruptive and was thinking of
> an option to run all disruptive tests at the end of the run. But so far w=
e
> haven't had any problem with mixing disruptive and non-disruptive tests,
> so it's all moot. I'd prefer to keep everything as is for now (or remove
> this whole disruptive category).

I've noticed that if all the tests are marked disruptive, and one test
fails, the others don't run at all, which seems unnecessary. I'd like
to see if the rx test passed if the tx one failed and vice versa for
example. Removing the disruptive tag seems to resolve that.

dmabuf bind is automatically unbound when ncdevmem exits, so i don't
think these tests leave the nic in a bad state or anything that
warrants blocking running the other tests?

--=20
Thanks,
Mina


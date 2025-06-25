Return-Path: <linux-kselftest+bounces-35732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC90AE798D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18485A1B6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2693A20FA8B;
	Wed, 25 Jun 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDli5+K8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D020E011
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838915; cv=none; b=YhUgy+JaGDbtFYFiO9tuwhEF9wiP0RK24eC3zr5ZLRQX5BXKSAsg70nt4mDj3rjCfKH1/pfic0ZO+bAn0zVIVzbVMw9dU8krMK/o+e0SFOk9+x29wsivOl96fOqkm5RJLWmOqjCqERbtzAqUEQHUkmItTjTeQ32h6tS7HqTjM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838915; c=relaxed/simple;
	bh=zpwNDepzoTzzaxm0I9H9fOZHI8MES0vs8xLBUSVMd94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOJfTmNqQabRSqK1Vs9PT4Pk0FxQc3kxGiblhizUdQLS7LFubEZDxOJCva68GSts0TbXGa+PgAjawV4UrI3d8yqpsF45lThetC7SiVXKoQnR/hb/CywqajyXO/16H1mmSvWYKJyhP1S9Y9USiHloCX2IgJVGVmu6sOIwmQ5yv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDli5+K8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a752944794so14185081cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750838912; x=1751443712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJWUBaRn+NFbAiZsctR9Sk0rJwoQVmEaF8vNrJMha0=;
        b=cDli5+K8H0157CJRrliEULCG1ImmT23LgRW9zs5uWTXWtjR3MYfnR6xfWJFBUKFqa8
         yFuL75yfM5pBJoFxGGO9nwl0kX4KjyCwoQ53xO4uGltcKKPS9APMbI1mzCOx534VLYI2
         RkJUsUYykepxGLVgoyRrglOAao8bxwgILqL5Pwc2BpWyP4FRDXPAoqpOCoH0x/D/swOx
         ZtCgRXV7sRapZwB6/ExxromsmV+tv6EeO7xcw2sbVJ4+8WB1VHecDXDxj/GcZM9YRdi8
         uUa90ntT9APYjRQMWodVc/WSqy4YOF/baC3lEyoxm7GRkywTkVOrpofltvF/KU1Ox7eg
         tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750838912; x=1751443712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJWUBaRn+NFbAiZsctR9Sk0rJwoQVmEaF8vNrJMha0=;
        b=hGBHZV0cYmphjCENHCADjq0JX/1F5/sDVS1VL3UCBQ7Dqbn2i/Wn6LP5rWp96BT3jV
         XQ/FGGSoc9NbNm6XnfI0E66aO+hAlGH4aaAsU391bgpj/NmoHfZg1aqpmHeUKqtvMZV4
         lO5hPou3NSYxhFB07UVCl+uBYiv2cg14Y/XmP5ELXdSqNwgDuXInBHwSX3xCTrk4YjsK
         RWmw0O19RNkMTejPVItv4EDIdGRiMYQdnGVh+NoygGTXcskFgk0ViyGLtKTQJpSNrE8D
         uMeDlpdhAprGztgvhi5JkkZWqCnl5JuKEULDLXUriCw1xPw8cmSlG8FMHT/ZlsPLm+Yl
         VT0g==
X-Forwarded-Encrypted: i=1; AJvYcCUUBDMPM2ccpOh3xpzK1V2rt9iBpc01xsEl47JzNCcPHEPc0gYGSDbcabi5+v5fQMAxB2ftGaHxohlQNMVFMrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvrs2a1llvJt6n2T1/jtTWO4R6OQQ3rSIQYG5C/QNysbCGZmU
	UdTA3cJx1R/qyaT0LYvcvPlzgJRMO66CE9uEmUNzX/RJ+xjGWCPknciBXbJLkBK71ZmHwnYGYI4
	6hcXz3+/Ubj4PptBDMV6uIlZQiMVHRe/x2ytYiQOy
X-Gm-Gg: ASbGncvP9SAziV5iwVdk5L0+jeZnCucKHjdO/qHXtdWvRQ8sq6zL9lkKfS8Wp5plWEG
	6+syWv5Jd/769HSCRV2BB5VdUJH1lhvsD3F/nowTLagQs9V1KJR2llNkffJfB6X1XDm1vD8m/+Z
	W6Ph8hAeo3rM2r/OGtJ/ecZ9Z43sA/vnNumj2aUQOhRhpoBvpy9ggM
X-Google-Smtp-Source: AGHT+IH2l04goDte8C6MTfBkwicdcfLuBSPT0rwaeShXKmoGSohwlRGdRNtjkixcZ5WnAvB15y3GdC/wXCD1WKJl+GM=
X-Received: by 2002:ac8:5a55:0:b0:4a4:369c:7635 with SMTP id
 d75a77b69052e-4a7c0699e85mr36557401cf.19.1750838911907; Wed, 25 Jun 2025
 01:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 01:08:21 -0700
X-Gm-Features: AX0GCFtvmPCOCoMB53ZiS7lNiinqU-Ptn3ytwDVPBB0CYTmRz2Bl-m-tFudAibs
Message-ID: <CANn89iLmLeUxBh8kU-RgLZ764QsKUqb_4NiwpwhryPi=7RiZ8w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 08/15] tcp: sack option handling improvements
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:38=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> 1) Don't early return when sack doesn't fit. AccECN code will be
>    placed after this fragment so no early returns please.
>
> 2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
>    tcp_current_mss() does not memset its opts struct to zero.
>    AccECN code checks if SACK option is present and may even
>    alter it to make room for AccECN option when many SACK blocks
>    are present. Thus, num_sack_blocks needs to be always valid.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


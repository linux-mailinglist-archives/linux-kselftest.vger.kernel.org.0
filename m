Return-Path: <linux-kselftest+bounces-41224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B30BB52EB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856CD3B8ADA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23E3112CF;
	Thu, 11 Sep 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiCS0//c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475323506A
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586980; cv=none; b=V292eED3pglDibWGvv0pPBZZd/hIGYF9Ue2cp3jMvxSx/PG1Ega00+qLs5lvkPct1iSiO+PqOejPfFJSiqadlSTecUYcGDQ07q4fp1gEZcsK4mUrK8aPWJIiIw3RzNqBVQA1Bef2vd4KyV80FvaLuQcTmqo5LANcbLehCdzAeFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586980; c=relaxed/simple;
	bh=fzU09DMCAq3+s6xAcPw9iQSsM2DMfpbhX8B7RMRaHmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoESxSU+vDNGmtRpqwA9oG9R/cQeHCf8OpgamnTC+MdB8Kjh+qjuFIvwc/H0SgmEcTeUEm4AyJ1xz1y4FZjrKE520j8IR7zZVdIc0Hu5Zd8TpbLlRjpttmzM24zagK+2fv64hhF51UbSw1muUv/ioFurj1D3jBNcQB+ILE6unCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiCS0//c; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-810e642c0bbso56054285a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Sep 2025 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757586978; x=1758191778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIp65c74emW84B2YnB6/i2/DDD4Hn+llC22C9hRiCnk=;
        b=NiCS0//cSD0FrocGwKmaptnuhyVu+xdGCjs7S41OVTIIIVnZ0ISxW/VHKQ71EGMwpY
         0Q3RkgOaPwXrnh/ywwA8douNZwBVnTfp3zMH0pV/jIVwBGu/OzJTW2qQKXAvrz04ZV6H
         6HubEQF3Wpt5a2Sqh/+lKXYyavdvqYRUkJuQ8ZrqGlZAp/RmetqYfprBI1M0UKsn7FkR
         k6R3W7S2mVe7e185GenMupvOZmtUrZXG1LJCGujqHx0QMX1twaB3qE/06s39IhB6Yhc4
         ca25L/CY0OfcyP4JyoxOWSZTOTbCDu12yhFJoZ4wPQt/Fh9MlpQpLAnkiXXfK34r6B6t
         6Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586978; x=1758191778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIp65c74emW84B2YnB6/i2/DDD4Hn+llC22C9hRiCnk=;
        b=ARaO/vAVAOb0AsTaaPeBqpWbywgHMALSTSPvKfm2dGQFIyuLu+zpHUGz4SkoYrZlVa
         9YrsPD/Ov9ruEbrlOzGLDW0sn6jixxbULZt9Tuc+yngTxC6ctrkTbitu9BhgJwHSgMMD
         hrSDIYZ/KIChv3nlWV+MWGWMwoj8RPxeCOLXodOVNCKFSTmxieLHPzQNp0pROddP2Lhy
         eJPBBibt7E0UeDIfCwV2VE0FgOZF8ZOJxzNLXAVSjqq7iy+15YhPF8ZADac7fRiyneCc
         1BGfG9BBcCI0OUDkcC1J9WyCr+5HXX0gPzZFnAI/e5k+Pq7RvsF++qInLNszd41k/7Sz
         5ihQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNyrj19eYymovz3PgdEVHz018Y6/yhjQftHsVzfGXUaeEh1lB9ObY6AJBiMgC9cMX0gjLafl56nLCQ54eRySQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYSigp421FKBYZJhFQyYHIZClCVpB8hb8Co9aNLDnwRGnwz1C
	tV99efrb3SbNoE9TGcxCGcf3srnAbHDJ4YlLKMDpAqEfwpSp9XXwJIPLo8P5E5S+/8mi7NJ+jxH
	1+CSPZ7rn9nZuVMx7JLE2+bY2k20grdqyvIqvo6G2
X-Gm-Gg: ASbGncukW3z0HCyBZTp4vyu1JesFEpCzlv5kLWNb9eglb1Z6KZjMlBy/+W0zDSbsaMP
	pKJj5h1SeL/S/TSKGitJ0STIwD3zufEe9rXDIwqd2ai2Kj82n0ZYW7WT5LPYbYS+sU2aMmnMiEt
	8KtTWqvZAIUFig3DyoeRSF00Hy/O09xagSmKISz0HTdvyZVGyBTRqW0F3Na2J3zb70RWcHQ3AbL
	Vce4EXJpQ6z1Q==
X-Google-Smtp-Source: AGHT+IHkeK8FRTt1/uOZZvt19SPsFH61ba3vv8ohKTWkwH3zfvM5AA5iGlKW7xE0TOEjkPaubARP4koKOEFkohcuvOU=
X-Received: by 2002:a05:620a:2985:b0:7fd:6709:f08d with SMTP id
 af79cd13be357-813c70b42a3mr1975265785a.81.1757586977361; Thu, 11 Sep 2025
 03:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:36:05 -0700
X-Gm-Features: Ac12FXy6oEMGb8kpdEpmCoxkyIVYHYpg1RYuIGBFn_nQMm1knd9KsxNR4ndbi6g
Message-ID: <CANn89iJcyWE_SxM+sHWM_Es8KibOQpfs+HUTD0G+bnHr3WQn-A@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 12/14] tcp: accecn: AccECN option failure handling
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

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> AccECN option may fail in various way, handle these:
> - Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
>         - From the 2nd retransmitted SYN, stop AccECN negotiation
> - Remove option from SYN/ACK rexmits to handle blackholes
> - If no option arrives in SYN/ACK, assume Option is not usable
>         - If an option arrives later, re-enabled
> - If option is zeroed, disable AccECN option processing
>
> This patch use existing padding bits in tcp_request_sock and
> holes in tcp_sock without increasing the size.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>


...

> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 53e0e85b52be..00604b7f2f3f 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -316,6 +316,8 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> +       __u16   tcpi_accecn_fail_mode;
> +       __u16   tcpi_accecn_opt_seen;

We never add fields in the middle of tcp_info , even in a patch series.

Some people might miss this rule in the future, by looking at a patch
doing this,
and repeating the mistake...


>         __u32   tcpi_received_ce;    /* # of CE marks received */
>         __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
>         __u32   tcpi_delivered_e0_bytes;


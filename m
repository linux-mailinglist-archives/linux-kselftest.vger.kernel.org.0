Return-Path: <linux-kselftest+bounces-35631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA344AE4AB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 18:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8470441299
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E729CB2B;
	Mon, 23 Jun 2025 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvvWkioS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93642145B3E
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695253; cv=none; b=kfNqvnAPX3qcuU1jQIqYlI0dRmdsXtWaP2qyvzHF0+pJP1JdAMnG/v6O7XtTy05TIJlb4PtHgiricpsnjS+7/T92txCeCoipkgHu47ilb6aGwHzy09C2C86FcET+bXvb3HtMlTnH6hIt3ch2C09e8k9Xlv33ueIhvTOKrs3gjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695253; c=relaxed/simple;
	bh=Tz+moTFStFX1YX39jWCVWhxsp1nVbvbMEnciDuWFgg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBJyqBWQVwlBZd7h03vRND5kINEh2Dd7xNplaI4ItwQ9m7GvZuJLsQch6nVF89vPvwwl5ZjO+ds3R+E9SWHDClCr2KYSX78Dl/TDlbQUeYxdEEBIIY4+53jH6T5m2YOwvskBEOSL3BP/qakZC0RHLVBhOWCCYrS4Yvmbm8j627U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvvWkioS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a58ba6c945so74275881cf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750695250; x=1751300050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN+RSCnSaEyeOJOV22jB+Ns6YfYfbuKVTQFf93dpJN8=;
        b=gvvWkioSl67jjGr10PTQQbIlXYXFSOz+Z6BtomHgsf5xPkkU/kGiapFMoBfZUN+U+Z
         PmKLO+iCoRzYV+tRxsXYCbrKhyAa1hdTqOH09Hl4u0xClAtggzbulu0ZRR7kzldIpDvE
         IwUMIZ5OTZawrkly0Dh1AcIANi1TWz5FjW9vPINoUGfMEbsrcNdIS2XQQShLb/nxi2Mc
         uUtzKrWqqLBNt14ACAOTgcBlZW5vSthVqcUdQXYPKfoMR8iTGATIR9MJO6l+HG2j3KFK
         XadtpyQk6YSNilylWwOUrTJbFS10f/Icks5jOR77h3zDvY5TAiF+pkPNiPdYPAMCO+6I
         7U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695250; x=1751300050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN+RSCnSaEyeOJOV22jB+Ns6YfYfbuKVTQFf93dpJN8=;
        b=o8cafxqOgWIusElo7OIkcuiNnAewSj3CSqSACDLufUWSpjzzqkvry6mtHxPNXV8fum
         cp5v7B6dSO6RG4L0F04ktX47Mg7ZOBzswx+A7xmMSxiAyPTu/B6WtF2imvcSUhI26cCP
         oR5Kgkn9OGF+HR5gjcMlHzd4misOk910nQaCgJormQSD6aRD3eoc1eR27B1EQGwcIG4m
         kgNAwSnobz7PWQie2ZSu2UoYAtiCnZsDXg5c4X00EurtE90RfwRTqIak5EqhAsUQfTFz
         SDIZCNTcNSIDGELXoXi64EO1l06Rq/9qthZLHxU325kb+hlVbmCL1ETuayptDaFB6K3r
         kh4g==
X-Forwarded-Encrypted: i=1; AJvYcCVhXTekrziIZMl+yzKW4Mrai65OlEKODGsGDEsdffZn8t8mhD+jEcMdWB1LPx39TAALeOV+FZ91QfFT66oHgoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYg2hQO7pAbuzGqxYxHEu1T0SqmBr2SV5Khw0HIUB4sPDtvjFO
	Cn3obtyej9wBt2045BAojJZVAksD/ODCj65pIjIE5iGbbf1jybsViT73QkxLBIN8LvBm8OmAC5x
	e+6SsNmbDsamjWbDCE73WzDISyo1OD0k9BBMu8xYu
X-Gm-Gg: ASbGnctt8M5jYw6LV6QdBP/SO43IYOIdL6qJweNi28nU3u+0evJG5pehIaYPD4wo50d
	4ydmEVIfvF+XdzEB3wQArxUXL5g7lvb03+7uU56PMRRz9+zYbSiZSNSQX7U4cnRIy6MHFgMs1eB
	Tpq905HoFMlPsvqmfIRNX7QzAdl2L9xZ4s/TBmu8noZ2k=
X-Google-Smtp-Source: AGHT+IEobn0And7X+FnotCoZ870DRkq0dQIwi5clxpS4xb+1xJRmqq200eOqBXI6G1dwNYsWyv6mWhZ2d1yR0qDuYeA=
X-Received: by 2002:a05:622a:610e:b0:4a4:3a34:ee71 with SMTP id
 d75a77b69052e-4a77a2b6514mr178869141cf.29.1750695250190; Mon, 23 Jun 2025
 09:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 09:13:59 -0700
X-Gm-Features: AX0GCFsz5JzbRrh0-kqOwf2TSk7Ef6ZqFtN_ZPJc01ldHoBLtqqmmWiHN33x0qI
Message-ID: <CANn89iKLKzvkLkPY67286+dKC4fGS3VtP_YhL00BmS6-0yXKxQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 04/15] tcp: AccECN core
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
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> This change implements Accurate ECN without negotiation and
> AccECN Option (that will be added by later changes). Based on
> AccECN specifications:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Accurate ECN allows feeding back the number of CE (congestion
> experienced) marks accurately to the sender in contrast to
> RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
> Congestion control algorithms can take advantage of the accurate
> ECN information to fine-tune their congestion response to avoid
> drastic rate reduction when only mild congestion is encountered.
>
> With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
> track of how many segments have arrived with a CE mark. Accurate
> ECN uses ACE field (ECE, CWR, AE) to communicate the value back
> to the sender which updates tp->delivered_ce (s.cep) based on the
> feedback. This signalling channel is lossy when ACE field overflow
> occurs.
>
> Conservative strategy is selected here to deal with the ACE
> overflow, however, some strategies using the AccECN option later
> in the overall patchset mitigate against false overflows detected.
>
> The ACE field values on the wire are offset by
> TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
> real CE marks rather than forcing all downstream users to adapt
> to the wire offset.
>
> This patch uses the first 1-byte hole and the last 4-byte hole of
> the tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
> Also, the group size of tcp_sock_write_txrx is increased from
> 91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are
> the trimmed pahole outcomes before and after this patch.
>

> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v9:
> - Use tcp_data_ecn_check() to set TCP_ECN_SEE flag only for RFC3168 ECN
> - Add comments about setting TCP_ECN_SEEN flag for RFC3168 and Accruate E=
CN

Reviewed-by: Eric Dumazet <edumazet@google.com>


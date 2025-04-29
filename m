Return-Path: <linux-kselftest+bounces-31842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A274A9FFD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 04:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F15A6DC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D729CB35;
	Tue, 29 Apr 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sguunp6I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA8219EB
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894045; cv=none; b=WNnIAiVUVoECtpB7AM9OFiTr8g3GXuM5djZsDzHbkfyu85QtBYe0fS4VxsjimXHFyqlAbF4lg1q8wNuPtP2LrTIp8mp1XqpS4cfMBtOXau/M3r64niA8GSo6xEEIAm2zN9NqLkCUoHVHJAv0lDs5rd0uYAVnkJMOr5pvaI+IblU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894045; c=relaxed/simple;
	bh=GEwqfrDo18i9rwBcepiUpI3TMCd/Z1oRhiO8n/y7VOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ta1egSy2A7CMQcGMU84nOUPlgtXQPaZHknN/OauWzCRDaVjYB4FPU0ROF9zXip9YQOFlULKuRlmN+TMovzVdwRV811KJM5pEcPoBRbDrExkQnXY34FmTT5nBP0w+HizFq2lDu+6P5RuEf07/OL69CJBmYCSdEICb9kGsndR/zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sguunp6I; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47666573242so67031cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745894043; x=1746498843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h24UD2kqcRugcg46PL1Xt9ZtaHWSydfY0GpN06+3MH4=;
        b=sguunp6IRHxaJ6RlUuID1SUqny8jcR/JNW3gussqd0RssD8sYFfUaDxXzR3R8gaVqT
         0Bdl+i5pZL5+abyGzSRmwugVzhxiiSE7WK9NqOboLniEa8T+x0XeDAM9KyBso/pchP+5
         0hb8iX3lrCHQPsWcuHcifyIqeYRclKA67kRj64KkGB95ENBf3tpmXWB9TVbnvK/1VVoz
         bQ0CW29FS9wbPL5F5CcOp2BaQ/MpNrNTX4XngF/XuLf1ppG7HLs/iHqWTpP68XrdewKC
         CuJTpcKyRbpH16y6Eta13leE3muUnfYnlhZ6Xw1NQ9B4hi0D4D5VDQuYSPvk61NzHIzS
         rN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745894043; x=1746498843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h24UD2kqcRugcg46PL1Xt9ZtaHWSydfY0GpN06+3MH4=;
        b=au4fH3M6e5c3tKABvQXbVlR/ZwNaBziy0E7NMG5sOC/qPEPxKwfciyjo6Ky6lyYhS8
         1+SdhJVsbxpqFuEYTGnmVaMcNdf1jgdbcy7anh+vcvtXDvKYJynziLGsLzlE87Tm3zx4
         N9aFUaLgheZ7ZsLHy8J6H7ZRWxJCC06x7zkD+Rm7EUgGw+AVV8nPmalNwEeV0VXRPT2X
         7mG/R8S2YbjxHL6GR3GSqPfTObz5gE8iKwu4SZ9F13JYb0QeFkt83+LEXLcoywZqmosD
         44CAmYJSS1kUwVYB3cf0A8RoNkkmYFYjdmok8YjVYSAOhwrPkr+whSYFd2bU6/4DHfIn
         WH1w==
X-Forwarded-Encrypted: i=1; AJvYcCU8WovGljBegWjJU86hk37hHum30ijYvKpaMVbta3CZTLt/RdlijCSfbvxBw/USGQXcrmZ4PXVXil3AiiHUvQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAdh0K4i1czDrCEeMPwrsFMzu8PAlOkB6cUFSQD/W8vFNQnro
	Yb1XApEg2IiLh8DPP3ts9P4kPk+Em4rCLKXuUvbOKv9/Np2FMmHBBCSsMvR9b9M+OW/VBdy/WXJ
	Gilysi4obar0i0UjvV9gt3omLhW/WVKk1QotD
X-Gm-Gg: ASbGnctrQQ6tR59KMg2TXe4nBl68occ4JtLSHmcu5iBl9GktazpgCmeq2zfBvbE64da
	o92gzQpWQoE+bH6JbSfWwXiVOsOSDyUk9xMXoCC1YLcJm3MzlHD4dEnAoIVn79KtDo3aqGc06+d
	aBH2PRCSdc0SpAHua2oGM4SdE4GgjNbWks89xtr/hPiesxmL7Hj8bnvw==
X-Google-Smtp-Source: AGHT+IGd1Vq2PpS4C822WzDBZt+4H5h8+8S8bRL+Npul5YH8In/RrEiCACZS+8xBAJNO2kLVC1o+FuzEgGcP7VJmm0U=
X-Received: by 2002:ac8:5a8b:0:b0:477:2c12:9253 with SMTP id
 d75a77b69052e-4885b57a7e0mr2380541cf.16.1745894042800; Mon, 28 Apr 2025
 19:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com> <20250425173256.6880ece8@kernel.org>
In-Reply-To: <20250425173256.6880ece8@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 28 Apr 2025 22:33:46 -0400
X-Gm-Features: ATxdqUGBiLgIadxV07HhwjXLweK5cAAHzKgUIwtsUOazWECetvT0S1dyvA2bLxI
Message-ID: <CADVnQym9vWoDtL6T4kWAMaTiFeEPS3iyLYFYkjg0nAEMt9CjeA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 00/15] AccECN protocol patch series
To: Jakub Kicinski <kuba@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org, 
	kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dave.taht@gmail.com, pabeni@redhat.com, jhs@mojatatu.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Apr 2025 17:35:47 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Chia-Yu Chang (1):
> >   tcp: accecn: AccECN option failure handling
> >
> > Ilpo J=C3=A4rvinen (14):
> >   tcp: reorganize SYN ECN code
> >   tcp: fast path functions later
> >   tcp: AccECN core
> >   tcp: accecn: AccECN negotiation
> >   tcp: accecn: add AccECN rx byte counters
> >   tcp: accecn: AccECN needs to know delivered bytes
> >   tcp: allow embedding leftover into option padding
> >   tcp: sack option handling improvements
> >   tcp: accecn: AccECN option
> >   tcp: accecn: AccECN option send control
> >   tcp: accecn: AccECN option ceb/cep heuristic
> >   tcp: accecn: AccECN ACE field multi-wrap heuristic
> >   tcp: accecn: try to fit AccECN option with SACK
> >   tcp: try to avoid safer when ACKs are thinned
>
> Hi Neal! Could you pass your judgment on these?
> Given Eric is AFK / busy.

Hi Jakub,

I'm a bit overloaded at the moment, but will try to get to these reviews AS=
AP.

Thanks!
neal


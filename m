Return-Path: <linux-kselftest+bounces-40162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9291B398D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 11:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975A04E46A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294382EA498;
	Thu, 28 Aug 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Y9C5JNPy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5E2EDD62
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374791; cv=none; b=bVBzeKF6pos5wsc9Cy0HD4gAJkkR4IAqcJgVGWkgXBGGaW5+Rd+YZzGNBhP/8PX89U3Bu9TATyg2OnVfTad7dOpTQNAg/SQaCvIyOF7qKpZDxPwWQtB4IxshMktCMOEn+t6ySLprse2K1LDpnaqb2YN2rBNPQYL6Y8dcfczi09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374791; c=relaxed/simple;
	bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYcOfANZdbB1+fY/DxeLxbmDLI4RobpFzuN5OXUFXIAMsoIQwMO3f3d5KzLKm8ipHT0Ap74rXlQX1+HozIUEfrpt/Y2llrJUXGPJl0oNT2MCryIRqBFxva4j9KO4j5ZrJUFnDKN3YkePsBrlg7PuVsdhUrTACO106Zaxe7/mhuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Y9C5JNPy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3276f46c1caso729245a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Aug 2025 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1756374789; x=1756979589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
        b=Y9C5JNPysytbE40N6Vha+7S53QT2lmAH9vTLgJ4Jkw4kLBnHQ9nMDqVYVUDn5RiJJ4
         MIjWlFHo2Pe7oUsM29VOviL7wkh2GDidQZVJrxNHK+VdpTlqToySyvSTc4qqdtixfBGe
         6n2uI7gzvNc3gWauJTxnBSwYJixbm4ZmPpcTEYWeHj4FrBaSjqc3/gbNiiXA1Cgl5i3B
         LEPePhb9vZZg+6r0FoEz8cnRyi60Nny4quQrxUJaEBfP3syfYpbGk2lc0LEOGLHdFvpk
         psYSvgtjSBpn9gp0NjQvYw4X58stBs71O7O7gMsCv+zkfyFpPbk3zj5jrF2Tn0KTi9Ui
         gYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374789; x=1756979589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVa6GmAMluDPsP+Q998eJHpdv/J8OP2iwTb/vFH8cVg=;
        b=T1l/aqgjxGZ7Pt62ZwuZPlxHo34Ol3gmOjfkgc1PZnED1R/scveg+wK+QbppcAB5TG
         PAQxiTGhl2pgPeZgAgFnsK8WSq81pXsHQPuNmt1PIh3t+Wpw59g8sLgt/XE0O0n2jK7n
         5NoA1wTXqm+t0y9rqg/ZV6eNQ07R3AMY7Ok463zmEdtpl7IGGBU9zNPNp9NOoUQHUrdh
         pmsmpELBg7VVDVoraS73htVxCYn2fy+wPy7zlp4qULi6n1zaeNmvAglfLS0O+jQHVKbM
         BSpEYDAZlAiDzmXodJ33SUjzZvamQ/Z6HzYMmu/0rXnsx9wDtE2OtbP1REOxwYui3CDt
         YRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2FM/OPidZsyYYyGFm4WoWRdeD2p+tn2+fFXP3kVBsqLFepRICONfvD5vBpdJaRaIzCsg101Fty1F7OMg4HEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzE1dyjoHPOMxNWu7/WnRM7PrE5wVswYArCO1/VkEsIMXODWa
	5IuueCV6AkKoMRgskDyUYoUVngaiOlm1Z5Vgk2ZN7kesvWh4mg9LtTDDASKdoAf3smh1uOXuGLT
	v6wHR6WBbmaRm7XWtBI2KMzEnrqsBqJxpZDO2HX5Ttw==
X-Gm-Gg: ASbGncumq3RzoTCIwpjEhwaQdfLhiYbDNzGNL+07p2fo0/wjabab9STjejwoB8Aua6j
	d3pBvjCX79FmmAV3QKKdhDa6x7vexTeq5WV1nfaOsrl87hJcwJLIO/Rd5wlveFgwOSt+a0QGhsz
	f9BOxhHdjFaLVu5x0ZOA7bu3D4TRzFMFGhJKRMg28De92hqcnt9J3uMVUUCO9smYx1PNnIMt+Mp
	0cP/67Xns/Oqda0zrxKRYt8bwfj5Rr4jQ==
X-Google-Smtp-Source: AGHT+IFiPdVsknu0U0byAooRoHYi9Kg867zs/XmQado5OBM8B30B7VRf7vH1HN0s27q1gbRfKpCDHOffF2/n/I7g+k0=
X-Received: by 2002:a17:90b:380a:b0:321:335e:19cc with SMTP id
 98e67ed59e1d1-3275085e80dmr10678185a91.4.1756374788898; Thu, 28 Aug 2025
 02:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827140149.1001557-1-matt@readmodwrite.com> <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
In-Reply-To: <CAADnVQKs0=iM_QoP9+SN6kG3iZ8hMwqeLWrQ5S3TvBbW4dgk3g@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Thu, 28 Aug 2025 10:52:57 +0100
X-Gm-Features: Ac12FXwXov8EhZrXIVQ2GFdBqP51A06NQPbDibzT34Dfary9rb9a1p7gB-p2qOQ
Message-ID: <CAENh_SQJ4xt0rSimsHXTNDJaEqWV2P7wgh1g-bXB7iE3hHt99Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:30=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 27, 2025 at 7:02=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lpm_trie_map.c
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>
> I fixed the tag while applying, since it should be //
> also dropped or-later to match .h and the rest.
> I believe that's what you meant.

Yeah that's what I meant. Thanks for fixing this.


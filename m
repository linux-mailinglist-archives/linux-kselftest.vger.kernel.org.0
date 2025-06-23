Return-Path: <linux-kselftest+bounces-35627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A88AE473B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 16:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC17C3B2E62
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599A264623;
	Mon, 23 Jun 2025 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuO057es"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAB264A8E
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689512; cv=none; b=Fnh9DS5FYbaWxA+iXi1d53BN3Sj7laTJ8oeoceI0KUrnFoL/M1kDRbxb5OpkVfazUCFXtqldFGn1zuzQhFf8ECw0GePsXrI1RtyfeAQ7Zv5kF4rdET1UyVFBmoPSFm+GvVLbHuD1jrSrDbhagcA/kkfqvYN58B3pSjJkf1Rr18o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689512; c=relaxed/simple;
	bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OopWQt9JxVelFaqhSq3NgDowVseTxql5NoUIiGOQpmmauEXgM+86pprpBvmZoBj0JIq6bnBHPfUaZuv0MHT2bundKEUnAvzliOya7YodcOqFA9lGQTpOB2wSg82RLcqKYLzatwkV1TmsYczBcid8HY6hSu12l1ssiLbiFH4Fxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuO057es; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a77ea7ed49so29797181cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750689510; x=1751294310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
        b=GuO057esToEH/+8UyqtmtQdquMI7IDJq2ajv2GdMRB3aeZA6plScWwJPosTGF00ACJ
         VkgnLk9zCr556307/nHhhyiZjXWoIPjxsQMy/kKpL5ykgvRPYUNE2W5Q/DfvDRRP5Ooh
         nQt8KX48f47CH7XeNgewL8sNE7eUzQw1RccWRGrpphdAieTYBUFbUkyzvI4iYJLboOo8
         BzHp8mCWtxrOWcWrp93if4za5mSXSmP3ZFX55WJdnx+OHrgkwqKGc5b6TEuZtS16eFAG
         s3eQdvRbSkUxnX+k9Z6i4mEpm3wvbCb8r959zyNS3O+LLW3RDdVW7d7xNAQun1v139lp
         fgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689510; x=1751294310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
        b=kIfLd8bEpLaqWAGLfvfa3qAkRSqx2NzAnuMbdrbfR89HNjBsS4fAGITp4aTkei3i74
         KPbVZxWDfe+Q6EoVKdF3wHbR1tq36qqs76/7DBNFlzI6BCYALZ6sOo5pSJbRt7TDj9GX
         tQef9FOgGG3N0fiDyEdmxqIvPV4EUDOYdtEHwinCBh50jUJi+XKJn1k3XuMn0EQLewSK
         iJFq2Z0Q+GOTV2YXHRN45FpdDK6UblfXC7Hf21CqmDITApaYoraHThzeJJK3z4KIaqjg
         EBprfBtpvJlguy8ZVB26X6GgttNF2B/94TUPx7P3NobnZVFYmWLrz69EHZA0BhiJV8so
         ettQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHKdQ2pZKlHIPsppuwVoAFTzoNMgwIXBaBLDnEsyGZZqs12hylO2HPA4C6OvsZunAFukE0YmAD32vEK8A7BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1B3ixTmi8vDNb2DZWNGZoQ/O9Q8F3Zu4kDjjSOphlpA1cSWSX
	ihZV+zRKMpxRG4ovxvWRFTcIHDVdrEuJL3b+YbjQZRwZon50szA/RpeXcWv/5/NHQ+9RYrkaK8a
	EQ3/mTCDuNtPTlLjuqrTSvbkcu4iRpzq4vbvMRVen
X-Gm-Gg: ASbGncsiWX//zuLr+xWTovpV/+7mfpfYqlsq+PtInxVF8yihfZQg4RnfdkiZLwD6usH
	8vm5TgrcWK4ocQtl1DnhOa0BVZJX099jYnI0NsbBDgnyIFKNFYeW1L+XxU6ve0xGsbNaLlRS/Nu
	5/N3n4FXKI/cv/ARWlELomXshZBhoazKm3i0ib7P6QkKs=
X-Google-Smtp-Source: AGHT+IErEx0kDAOqp1ojFcDM9yYCZh+mVleoBFl1AEdwsO+17A/oIA84nB9tL4FUjJhJfRwxa3+3/8JyJJH7G1AK0u0=
X-Received: by 2002:a05:622a:750a:b0:4a7:7c8e:1d5 with SMTP id
 d75a77b69052e-4a77c8e083amr154660831cf.17.1750689450031; Mon, 23 Jun 2025
 07:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 07:37:19 -0700
X-Gm-Features: AX0GCFuRrhX0LBiCnxAPHQ5MTAVLkaa48kUt8r7GSQvKFHWuAgGT6_YRkQKc9Ek
Message-ID: <CANn89iKXWH8VLY5W+iM4d7MGYL2dMRep2xG-AGGV7BcbJyMY4g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 03/15] tcp: reorganize tcp_sock_write_txrx
 group for variables later
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

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
> group for 'noneagle'/'rate_app_limited' to fill in the existing hole
> in later patches. Therefore, the group size of tcp_sock_write_txrx is
> reduced from 92 + 4 to 91 + 4. In addition, the group size of
> tcp_sock_write_rx is changed to 96 to fit in the pahole outcome.
> Below are the trimmed pahole outcomes before and after this patch:

Reviewed-by: Eric Dumazet <edumazet@google.com>


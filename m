Return-Path: <linux-kselftest+bounces-48563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C3DD06787
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60EE330213E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57A3333451;
	Thu,  8 Jan 2026 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KP4G76vN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2B32C94A
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912490; cv=pass; b=mXr1OKnbckHMiGyV06BJrLpkf8cvAEKNc+og1KfxC8SAF0rtWZEeKnav8bDcROxF/XRNhL6BQtFjZWaRK9CAch57JKcgnvVbFhqj+Q751OQMKACL4M9R/X/S8h1NWm6SIBHQ63mhF6C4UUz+VQLKPS/xN7y/EKm5Uh6e1LUMkkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912490; c=relaxed/simple;
	bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoK4Esa9bU+n4XByPV0u506dW18KAXTuGPwevDP3uK9HSKnEAwY4LYxHYSYDQOLm1X7LT4j9DrTqD1BoQbczkOC/XVKlwkjfVKsYHH+xlj5A2ub5L3wVCgBZtIIbyG8hI0Fdi8EbutWRO2doT1ycRQYBgjvyuIfz6GrVLuF/i9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KP4G76vN; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4edb8d6e98aso180931cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912488; cv=none;
        d=google.com; s=arc-20240605;
        b=XKp5l3JqZV/CPuDKPOKSaAFvhoUDh7Z30CjiDSGX2IcOSNEVNELV4cW0guwtoSUSve
         q3TsuRabX7+3T/Koq9n4iJS+Yy2HJY6r4R1St1ElJnd/yJTzIMVmOIKtXdEyEHk+rB4K
         YwPpssdqeZhtsYuCJeksaBLTtBSzLcnX/wDxCFeQHM6ENY7chivYUTFONOPshTel40pL
         /gRbo69fG2LCaIGydVcs2i+IEO5S7IB+2SNWd9NoajCRUMtPDGeguWg58ZmVO8DEIW7g
         7SfMhbzydvcJEkS9Fc451rKYIhKk01fDyTmw+ScqpIcyWyLQ1LM22gunts0YegHsAj2f
         eeEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        fh=c7itryeyIPdvL56HPSmL7t6sp3MGHJtZg+d3IdRtv7o=;
        b=MS0809MGowQ4cCt7vVj7f7orH6691TvONcfyns3QGgkVyFvA/FE6daDJhaoH4uLDi+
         OHfUbHx3MNRgmCVDFqsBF8ldenqpV7u4g7ZJhlFYJGLMwz9X/6K94AVw0VJGSzSCjrjQ
         a3ngdz5JzAMC5pdRW4gyvDoT0SO0YkE+yGafMbp+fYFh9boiPsLw0OMRLowJuQotvVK3
         v7tUlUritBCbB8TBgrCzz4+6sMN2afIM6K63qagrPxifbufgJabyfBplW8W64uuG/So6
         fgxXzQ3goyPKEVxOLWzwI/gc83di+onl7tM7mIZQZ0pDWDkICnnH63aBvKulzwpwUsLv
         I5Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912488; x=1768517288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        b=KP4G76vNV8G2QJOzBZ3cs5ZC6bKRcr8+OPMKDkbNwQDkQxb+3lMTpACN3HVSNG9/Dv
         FLkKWfMtfH2Ic+yEEMP8peZE8gI3EGYV7ESz4VWTYr9Qd5/ANShPi8YR1NnIvlGecadL
         bSLz+SPPPu7zrn0o9Yg4WtX5DAxMce8uycGg32Vx6GMCx3ixgYBYzaZzYe2v1oRxVqZa
         9muz9upsFMIDXxg40v9qkD6BeUUGgYCwvvkvJcRi4iMsIB1AAdggE29ylmJVaiZ3/Khe
         87oC/F4AT3Qf4i4f6Pm945K4cbyH9cZo22WZNfrz8OMHRZ76yH+357zeIQHzuKABVaH4
         VK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912488; x=1768517288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WV9pPdU0/t3bo7zpdI6NRHH4RIbqWrXSjDNktz3inOI=;
        b=Nbpfzv6JTx9xoXTud3VoI3YucS8zYNYmWPI626Ydtmse4yz6SyVlQFPeBOkz9YZ9uF
         fm5AW6Rxd5dbh//C7TTXIdLVa6rPsHAgCr+JJZiHbZd4klHjmfWnSPnMZnfdWQIpNTtT
         o1h9A9r2Pq3K5jTWTBAtKS6UbgQxlPe8dHZpI64bCXt1UFutx4kFuW212KAEqHhG0FJ/
         HfUQgO1vMFKbXeGHktToH3rANQtsM6Rj2pjRg/idQGQQKN9cYm0CXYYOOWFvn/DVRnN4
         cHxP/ZG9C3ilywtOkbQYThdBQvmT4LtKLcOVUjCsRnlU+jX3K/GYpZzygXaGOih9anLk
         Ky+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/J5O/h8dQclHH6POeAp7iEKHkn7jvAk7yGalRUm7D84NzmTu/3JSnKXsaU2bgxewv0wawqt1CM0sMHO3DNMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVsapzG0/qsyfsawXhqyCovpTrtTDPelDLob4VdmSoOK1dh2f
	mE8Tip89vYC6PjW0+ogD00xkg5d8k5/zNdJulFPaTj2yT18m8K81n4ezTPAId17qGU5y0UiujV6
	R9DKix80fHNhqwJNFLOJVsdK5bwr1+XEP8EIhjsrY
X-Gm-Gg: AY/fxX5A41e/tH86aFP0r4gUYFeApUYYRbU+zf02XutfpQV6Z99Ybiqn2E8FMSus+JK
	0ZYwLZHPkYDTOacDJVdViQ04oo6H7Hc7Vfgm2/0mlr6RRt5pVW4OwjlTK+sh3fDMOHo+p4HS1g8
	r+nQbUAz5TDJuM+4dDo90rHTwLoG2D/p2bqVzJ6ik87ZjO0NxuAGXRMawFxob6045Eg81cVi8A0
	608B03hAmamGr7c9tbHzyczxC5ekmR/utxXGqi/+aPXiJW+m66yDGU8fcbPCiKyoXWkDJx1N9fC
	cP4OO8gCUn7gxAilUrPMPup2zmVcAUt8Cr85Dzwiuy542rjTWJXhNGUIj0o=
X-Received: by 2002:ac8:7dc8:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-4ffcb1703famr1912391cf.1.1767912487896; Thu, 08 Jan 2026
 14:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:47:51 -0500
X-Gm-Features: AQt7F2rHIoIx_fDko3yxcFPFIn-ukKfEKFlHAg0ugBLMmvSi3Dr6twPz-fvm6JM
Message-ID: <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---

A third note:

(3)


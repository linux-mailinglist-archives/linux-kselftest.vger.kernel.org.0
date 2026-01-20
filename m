Return-Path: <linux-kselftest+bounces-49480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A0D3C45C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 92F5F54421F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9193E959F;
	Tue, 20 Jan 2026 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ndOfVqv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B3341AC0
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901790; cv=pass; b=R1incgC//cNJsZsQcBHzkDzUc63JXX0+ud8CVsHYQREtxhXbRXNGxkvOZvjilRsI6geT0jfwkdpgWzy6wCmOAFE2vuoksd4LYukUIbfDa0MW6A1A0pRIcToNkTasgmIDfyTNpY1yczX1ccESgGqjyfegVVWqgsxJQigFZD+pX/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901790; c=relaxed/simple;
	bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzQk7DVgGU0NJRQb6rL73kPHhylZI25ldipUVBIkr9Jg8vtGo8KCkxeX/+drxZ+be0naxlR/mYMREKvzsBbRx/ORwDz9kMax13J/OpXxca9SNlgJlzVy7dOZMsp+ZDAYguWaYZSP0qyoJWOoP9XxYLZnvTPrK/etWEkCEnAisD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ndOfVqv; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50146483bf9so66897681cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:36:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901787; cv=none;
        d=google.com; s=arc-20240605;
        b=LYLNEFTrCavrV32kUFYXy9gcxZ7a9dxjaeYfbnEboXG+s8JGSi3m99+7pschePuDOa
         ZaiPNZ9+Xjy2dmL/fwaNlpCbPc0pcSQGQ2ANowmOG18zsuiGvB/WPyuIGAoiK79PzJk7
         HMCKv+oJ4LoUgaeFRMRvT2pxdlfhANq/ZruwvPFXrWLP3bqAqYoD36hljSEpucbpeiYJ
         JCHKcAFKnnqGS2Ra5Xo/J1c1TpjI684EmgS7OA0I/gH/mT58dS7lJPBmqpWUIZdf+321
         cBJl9Z4J+37FFBnoqmlf5p3DWk0CDHpgHX3+mRS9AQApqqEMt6wke31bt4z/xp9DY0Ib
         QVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        fh=eZB0DD0uKfhEINF6QMWi3i0oui5AzAZash8XljmnL8g=;
        b=JDEz1/ILVwYSXVkHACl3dFqNP9e3RtFEaskqZHFPk9HOc+G1X2GYoV0QYDqDp9l0qu
         CJK20UAATL4Qel4SDPdMXijgRCzBMNcjsqEqNSDpVoarx1DnaHGGPhxN97jXJhrc3FTd
         tnm3x0e0X3qisiOMPIOUsLqUY2w2D29DKRJezfCNbbwZDZ60+7UHCotqY9fS8R/ODyAR
         GzSb2bb5UW47C/OKxuta3daoJ59b2siRP8XAjQ5AJ8mN0x24xeNzPypnoj0IBNTr82Vf
         RE89Z4jOiNbwdjAcoLwk6Y3aybqlZ50Buxs9Ukv7+h6plAfiz8pSZGHcmuZ6+Km56ykW
         QcuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901787; x=1769506587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        b=2ndOfVqv4fK/TW+z5jKOb/UcajjFo/tOTQT6yvatC5jm5+XPDy7mU6DadDkJT1Mle1
         61ETuJ61zbQwfq5yIwsHyrqHPcjPe8+V3KODtHYyXJeK7QSQBEy0xv2mhXw6c1NqLoLW
         5ysj/VFaP4nI4f5jxQdVKI7EbPI9ly55bpH28cJimcm0czM8U5h/w7GwbwAfTNRtX1k1
         xv/awNwSLU3l5THmZBjVLlHXzwGbUbSN7Fep9X2lqtpPF8L9Y5eupsFQH5K5Ct0uVUnX
         2/xYuRl5usVIcOXiQp66YMwSvx3TDN5nQOV3s2d1QKBTwydj56smrEdi35z7YlEs13gm
         aG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901787; x=1769506587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3I124kDIFRAt475DmJvL319sDurBF9+70I4XBQkzu8=;
        b=ckTQPq6ZNP+vys9GSwuZbK0T9ZRirM7lb1shooOCHrehjKBixpWU7slE6NiQbQNFx8
         H9EfSCzQ3ewaCrLW5fOTNO8VXltC/dRr0Xqu5ZdQydXIefjMOJnCoXIu/8ns3qFqvzPJ
         BGrH9Ip9+k+uf7Mts1xPGmSNmbkaxtUBxnoC66kqzlpIyMmGu7FXdTMRQ/JfMdbgjo0o
         1s8Q/5w3fK4msxl9lxEY1TE46DlrpnPGfCriY2DBODnFltUGsE9tU1G8Spq9tZr0zRmj
         IX692l+heLTjr/o0JUWEVrYFf701n79rvjCOzqka2qMWSg6Mn3ShCPm2ZzP5IH2ocoxF
         7hsA==
X-Forwarded-Encrypted: i=1; AJvYcCUJemvbpp9cb8NbauxsWxuwv/iN8raosHoSqnRo9/sVsGOFvp76wn85hNKceHXh+G0fCBnBfsE8/8G3aY8hh9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnjhv5VjaEUfaOWalryllub+iCLhTR6oRs5u3OiYG0/H+T2YfV
	NlVT+FtU2eX75aPfXNK8POryAXpf67RzFzpmGdNXnSCDZaQIwWZ/sSUtybsWgVFKpEs4x258TZc
	cSH+FZ864AKyVyrEWaLJAYDnqfEKIjlmy5H+d4uax
X-Gm-Gg: AY/fxX7BpxYecBxw6vS3Sd8gOqKwtHhtOcjnIlIFWzuJEAyRgSdLLunFPC9DW9yTajA
	pLcuvwIMBxF4l1DQTono5jck8HTHEWvvv/gBmLYMCUspxEuIx1EcFDMYpHGp/DYDK7VfDB9uAXJ
	bpcGAunG28sed6oNUn2gKoX4RM/a+nzmJLqySBQrpeJfZTb3Fr3fsJSRyKjrb1zVivYTEvl2Fgh
	+wppILqooV/YzUThy26+p6Cn4zAioorHaTPEo8MuW6NOxZ3VskmC5+nKgSwX2SusLndZ/8=
X-Received: by 2002:a05:622a:180e:b0:501:4730:fbe1 with SMTP id
 d75a77b69052e-502a16073e7mr186116891cf.22.1768901786640; Tue, 20 Jan 2026
 01:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:36:15 +0100
X-Gm-Features: AZwV_QiBVALGf5mVTwkAOxxW_7LaEeT-CXPBAq0Ya9GQEa2O6BH9EXhsIb0Qnrc
Message-ID: <CANn89iKNgD9tUqck8xHphqc3iiERFjYcLBa+PTHCqXwT7cxY-w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 03/15] selftests/net: gro: add self-test for
 TCP CWR flag
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Currently, GRO does not flush packets when the CWR bit is set.
> A corresponding self-test is being added, in which the CWR flag
> is set for two consecutive packets, but the first packet with the
> CWR flag set will not be flushed immediately.

Reviewed-by: Eric Dumazet <edumazet@google.com>


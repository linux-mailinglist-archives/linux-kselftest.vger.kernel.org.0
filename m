Return-Path: <linux-kselftest+bounces-49486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF9D3C590
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E406A848A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932F3BC4D1;
	Tue, 20 Jan 2026 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sjtQ1x9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08FD3904FB
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903013; cv=pass; b=mqR99iwB1gwyw5/IAjsIcRum89ZwJq080E+Eg+AxRf/4mQfHoxvc8kdZKCyDTvWZMnp3tKoSgVR5BUHosFTg5NbtSdlGfCub6aBmgDLiJP5mtD0hfxe9z6X5suYxjLERA38kxj68FVa1GY4ASllLUTvGFnh3J3jhv5tBliwXxME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903013; c=relaxed/simple;
	bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDAPYI6sYR3mamL4Bu5E+y1M5o3eoIIdQsXY+PVdUuAJMg/dsrGkC5o+z+JrmoNE3aOxeGtPuaCUZBw4x5J14+LZAs6vYheOwZd/RYkaOtJz/h/iFX+CWa+W8Chn5tUcA65GIqNAMc+KwblxshOmq39CniEAXo8CuB4Q5IZHR9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3sjtQ1x9; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5028fb9d03bso41977751cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:56:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903011; cv=none;
        d=google.com; s=arc-20240605;
        b=kJ/bEN0NNxPUR5InG+eKZve4vmkKNhpkkyTTH3NjZ6++WPeIbU68Jet9BBw+pUbCUf
         JdhIamqMPRcI3kWicLRLf/Ud5uXMqRqjB3gR7gBDdpZNlhbj+TZiMPSd0iPc30NYH5ia
         n5mj9LnwkeYm46k0dBa5MK3THOQnP+efOLLuzaJiHOlVBZ5RxVPVHtUSufzJP526AY6r
         dI+Gt3J8LwP36M+CgxfpKIDtwGoG7sxebPaoMlwE9BVD7Re+KL0wDUuIslZuEz1Q2RO/
         QwIWTgVQi7Jy6bGMzWeFeruwDVkOrkQAlb72GsYu3Lpf51v6CxXS1YtZDBEDMse67gz0
         T5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        fh=cOXKf6vW709S8YPLbcti9haeXWliixskS4EivHRaHl0=;
        b=FRJu0Rp3IGVij+6QLh3mPRAMAj63boDp7x9YnRAWkgl602eOuZTCfUdZ+gXDIuHZ0a
         z9psa/iPh7ds01TTRDd6mCTbE5dBXlivWYBM+DcZ1FMa+mCepss2jGP5EOSBhLfwA/Vq
         bokXMc0ntm67vtuwv3/scYatkrUdH9PixohZgeuJoQvxarAdMSbWs7gLFuYmO0rLnBgz
         AdgmcsKxgrsktc0rOOjPPU4Y/mcGsWOnEp0qtx0HKEHqiihJx+/X5q4DirGD2BzUpuBh
         zkHStpfosGGrikUcMRnH8G3/5nx8/PDrxYYj8hLWkPIUjdr26y1Z4AqH17a52e4oe0lK
         gv0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768903011; x=1769507811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        b=3sjtQ1x9WmRvbdYB06aePiearuKrghc0l2W/2s0AEik+5hKq6QlTBKAsMVRl9/LRT0
         i2i+q7iKvKng2K621u7/hzupoRZquXkthX6XaBBR6N2yNmJU2VDfovpnJiPACbZSPyn0
         32bUBEZn3E5RqZYd5Olxu4G40D1/6zK+qnBo1XEBKsq+8flch6FDQ54uALk8dyBkrES/
         l3Z0xK1WGGesc4V2W78cUG9JKAWtmFfSTt0KXrEbRE2y1DJxfze2do4uujC7BrEShkpO
         fVBCYHHrIAmjPyV7HJm8Sf9j6AcYQqin+sgBrYW6y2RsnwW4aJh9GAeknshdsrFdqclp
         /z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903011; x=1769507811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DCIjvxqnB0B7Gd0SJ6C+JyGFfo1rtrAw0nwrgUxl/bU=;
        b=HUQtRVzJntkrHYq4PVItfPttb7B0tXlkgGHfRvr3G6LMlTepy9XNzGeKm1DFdDC+If
         GyHdKgKJPg7lvXNU78KvslaU4PO0n9civKQ6vLipz20G8L2LTNzD3GYNjJw9XrWUgRkl
         7EwtZHqnyoGd4mSx0gZjrzAbTNFW4gtRLniI83SB++RqPOR0gEyMc24x40vIAzFUpNy7
         kiNAeWKGvRezGVru+wt1ehbzcVXljmmUad9rxNmxo+R5hbhCEU37kOavzGw1Zx8JAQ04
         NiI1E4QtU5Mlbt519sxII4fATbcnNQb19iNXnNzR0WgmZfborJbH8/BtL/zIVcA9qF7C
         UQvA==
X-Forwarded-Encrypted: i=1; AJvYcCW0rpBZWDZc0mtwItU6KiCD6CTIRVarfghSXP0JrG7/vONt+qiXiLKscZEmnETbTKmBFTAQoloylmAwzmsvmFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Gt7veEPz3t4kzpH5dHaFt4OUzeo3GYcbg2P1mgPxIMCKP8F6
	9A1szL9hyHmazqFNSC7ORQl+6JI1i22FFq3Qr3IbPISGfJYx1tcYabxxP5fl1WZnvSgD1SuNAxv
	0Pgbv652WVoNIhMKvbd9yGHRQ1m0bHDjE2pCrus6z
X-Gm-Gg: AY/fxX6qrYKOyS6VO3sBVhO/HT0jFdqbjDqaSfFOD5bP6gzWNcNCokiShRD/6kce5b4
	2whlvAdobto9LljSdeMQfXlTkIl86wviQNYzLfcPncKILaeYpjWsFoXMxVUn+aAUCMXg/LGilhJ
	w49/xw0gfgOTDA855E/dM5fTN4zJSFOlz5DIcitSN0NNJiCWh6BRE10fnJHuDlmXmMwBHkp6RRV
	BvzQI++Rp2FisCtcNf4c4fZUGGz5ZLU2JnkQ04wRvRbtvTazjfwaI9k9T3F1qblHNyU3no=
X-Received: by 2002:a05:622a:1794:b0:4e8:b9fd:59f0 with SMTP id
 d75a77b69052e-502a179c31emr197588841cf.61.1768903010232; Tue, 20 Jan 2026
 01:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:56:39 +0100
X-Gm-Features: AZwV_Qi434Atr1gPGVfzbX7Cut4_5_Pnu1U9A-PDsd4oFP08xwfXslULTipllTc
Message-ID: <CANn89i+P_g8XB++mQ-MMXSSaTURLsohqnxHBcVpVrBBBoru91w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 05/15] tcp: disable RFC3168 fallback
 identifier for CC modules
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
> When AccECN is not successfully negociated for a TCP flow, it defaults
> fallback to classic ECN (RFC3168). However, L4S service will fallback
> to non-ECN.
>
> This patch enables congestion control module to control whether it
> should not fallback to classic ECN after unsuccessful AccECN negotiation.
> A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
> behavior expected by the CA.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


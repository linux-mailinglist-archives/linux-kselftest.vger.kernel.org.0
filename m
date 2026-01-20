Return-Path: <linux-kselftest+bounces-49477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4653CD3C423
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06B785262EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961053D3005;
	Tue, 20 Jan 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfLiBtRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3D3C1FD7
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901502; cv=pass; b=uVoxLgHqCh1Ngst8mYPzdQmKQMHK8OMIiWFM4TWRRpsix8fIISECWKdXmhlV+MGvwwMC8uw/jHPfL6IMABy3CqMqbO8RtobwbVldew6LZgWoR6Pu5HYinHWTNuvOBP2zSPCoDO8gmCNs+quz6Zh/zNPJk4cnLcyp3SVJMjMQcy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901502; c=relaxed/simple;
	bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux6Emj/13zVtxzEsbCTuLU6sObnUL3MtJ1EF5MjP+5619x68trPdR19Q+cb5wNYFAglCvyjSdHTAbs6hNamLrsibWfdU16QQZuzeRNYWJIKq5KOyY+VCWqwZPiAxgoevuHzcSb8RLX0+VjasFQsAReM2FIMM1GoIKYEkQ4hUsU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfLiBtRU; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5018ec2ae21so44314611cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 01:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901498; cv=none;
        d=google.com; s=arc-20240605;
        b=aspULl2Cye+N4RBuprD1BW1Y2xeuuK5ctB/M5RpLIG3fvZNRet6F+Dc+QE/256Vcne
         Da9iEB6rnjrx5zTrAxKGrutW6d0bEGcDd7i3CHmfmTt2X1ansGwYmx9AWFYuiw0PVNQ7
         hKCdfg85eWaXI3c6mRIx/MZm0vx3e5dKBOWr6IdcZMwCDV8DnrctzeyMnbwrxB5rDM8r
         hKYbrB4dAgkUP2+jK5BnvydYMIimMj39ud2nMoTCU/orE7bx72orYDUuKLvSfikAgUIe
         KuQ2rRaiCjeZQ9o8VdtMA2gI3mz2LGj2NBXtJLRFX1pyDMgEZxPldh3uXEYJA/PAulWM
         J2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        fh=kkcrCsAYicIEvEglD4Y7gGA5KcpYXsJ2p57G9otDLqs=;
        b=anzjSF8WuZnyi7oxsYeeaep46rISJ2W7fQPEi2y/Pb57mPxSuKqScVcxeFKXdCE2hc
         gcFG+G9yPuVBV5p4shPEtLi9EMCIe4Q6NahVoJQXP6QcQ1gliOrnfOJAIxQ31d2DqYJF
         uP0syASpv1VPNDkV0+MDahOPcrHc/AnH9ZnQDKRzYrJ2oPqqF1WiNQZc91qAXhOgxlOF
         SKtYo/wt3118tixdDZ2MBKj9eKfuWzNZ6+GATAGMaLnHFo87Ufw3i1ZoX5yAbnpFBKWf
         yTZM4bTkMUzPy/dhrBa38TbOXhMzmKsNP1BRC6c4ICJyduR6YZyzFpyKuWjVQCYWBk4H
         sTUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901498; x=1769506298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        b=cfLiBtRUY91o1o/2kdjpF6ig7LYi7EPEZBSDpd6sW+a+YUXfBhjr2fEpeJHr/015Cc
         y3f+JrmBg1mKHTe05WzmWcYGC03H178P2oJgzcw/O9Fm6NRXwFO8u2bWbUpEkHP9mLvp
         t+xAIGzN4zaDvXk1aK93G4QDnyRb3DLhJ73yFixua2wxE32One8eS93fCOLb+uiNxmAy
         BScqEPXqiiXneMfSKZwiWmSonyS3UrrWuGo6aNOAzDakMSUK85syqFqGfWFLiWPXPyVH
         Ze4Q3kxWmFwXuahQBxI7ix6gS2n5U+Jn5xmg1ALoVlYeiXEz5IVEQq/KSULpY1uXg2cQ
         u3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901498; x=1769506298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        b=JceHv6uT/5+2mE6GikimeyozHwaz4F4Rg545UxP7nC74zYwCnwbZh/rEAc+n6ntrk/
         3F+oy+H6QUgnhtOnkYulmYvM3LAfPUMx2ptHldhAPTMKXPQ6iQs8v3SdT5MM8Lpngyim
         I6//Q/fU0jxP8Vfd8y5Auf3/zbERvDg+Cu0KqTl1lGySQsznW+rprBQShkdvX68k7xTN
         SfjNQtGnYl2gU0ZpAvaLqMl4FNZ+0CdEqBEg1G0zJpznVuzQIVPgNcR3NSr4vk/rbTWC
         BOI8vzLLZ5cpSPAbKXsPMkTydF4S3M12K/QywXOhjLjSxNdElddxUsIEhISMar6tSDS5
         ieIw==
X-Forwarded-Encrypted: i=1; AJvYcCXyjOPNmYfZWhRU/J4yrvh6nupev6K/vFiovKIQOFUexAgMRSZazZQEuAmytZFL13nyw2dmXhIfPwA1yVtotyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxub/aSqkt4WhwAsgaZ8bZLg/5o0GUUATA0kuat0DLhah8fVZxB
	Jo/9c1C3qK/4G78+5lYVt59+8eKbtZndZNmtdsBkm380YqVJ4YpaTO2OR01qDHSDVLtRFHsknzB
	LeQ7zfnv1W8xaRq0QfKCPDv8B1YOaJyUTw/RNcnC9
X-Gm-Gg: AY/fxX7YimoHU+M7GlzCkEvUn+AFjbgOn8Sn0xi3vM3OaCOuL4XQorPERtziAx4P+d2
	1hzfNgBIUXy5Ip8/3mw6ODT6XGgC8X3e3ykdZgCLevV5dAqTr8KzJFShjlMlY703H9ZfEh3q8ZZ
	AUL4mDfQ63mkoUczmqvk9+GeYtocxqfi1i0rFVVKgY3WjofZrZP0P2m3Pi1KjdMXutjbWPBu3dQ
	fHjx5HsN1E6nz+u7J3pvBttHpg/xVJsHVx1eV35KB0bkyL7SSAju7dcw8xvWEEEuFQhHPk=
X-Received: by 2002:a05:622a:c8:b0:501:51b6:cd3e with SMTP id
 d75a77b69052e-502d84eabe5mr13635181cf.29.1768901497982; Tue, 20 Jan 2026
 01:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:31:26 +0100
X-Gm-Features: AZwV_Qj1Jnn01ns8cO1Mwqdo9iNbvBF-noKKnseassUVD5Rb4EGhtZz-4l3C_i8
Message-ID: <CANn89i++X8hRu5nc4ChyYxf=J1kT0QF0sMOW8BLkwpNWi+bkiw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 02/15] gro: flushing when CWR is set
 negatively affects AccECN
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
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
>
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.

Reviewed-by: Eric Dumazet <edumazet@google.com>


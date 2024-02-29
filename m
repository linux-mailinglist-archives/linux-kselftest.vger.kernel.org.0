Return-Path: <linux-kselftest+bounces-5677-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45F86D7B7
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 00:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD2D1F2255C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F38075810;
	Thu, 29 Feb 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ+4w4K9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CD74BF1;
	Thu, 29 Feb 2024 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249160; cv=none; b=jI8TQ7OPdg5TT4e9DxoagY9e5+JzKgzUdd3jTmwxcEODHqwOAXqDX8/8KNMsgyr7uOvBe2j3nS7bqcAMcgKDQVE0Kt2qQozCBwJHKi9Nms6hAnK8/FAwlRXZSJ1TbrXEfIln0iE10GAeYRt+lloifrYAkW/bMELza6uiFCqbeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249160; c=relaxed/simple;
	bh=QkWOLCXGjWdmYeUQ4QG/VDCFo+DPATObHhiMnUCbGgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuEwF7XrJJ+aM/0biFShJmunbJrcev5hVlzcYER8nM7a7qGajXD2ur5JiDSUMQ1edOjaAwyA7AASdxH+mFQDAn8p3+MCahC9nYMCQJ4UdmlfCcMHDBSMWeLojajYeUHA7EhRcv3SnMpqdioRoGjzcHGR8UACdc6es6rIgPGlOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ+4w4K9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c7770fd687so81757739f.3;
        Thu, 29 Feb 2024 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709249158; x=1709853958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jme5oUa53ygZP5xSuXYsOtdmv088OFcYmVS1nNJAVI=;
        b=LQ+4w4K9cZXwB69iLhCVBYKCia5S9L6dSKbi5c9UtFdSWyIt1bItWCcrtRH+eVlHUz
         nAoPyr/s/nuNW7UskUVip9wvd7hHnQNNYS34zedbV2dUfWnOWHCghBrweX7AflmhKjND
         RCrbRICPtpjdIgrabVrdPtF3s9Q97gxRhMsIhS1tgr8OcLtO9nXsI4YW8um8LnB3+T/x
         gDuxy+NN607WqdndHNs22MRHwJPyKO6L/cPe6wRmme2cyMtlV0QRT3eF5aNLK4zf5FF8
         P2wD6DoQle+4yAXtII+8L8Tf4LWP7DGxJTC8e7QTfVtTmV6BimJjAvRhiPTK6TiUjjTg
         YMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249158; x=1709853958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jme5oUa53ygZP5xSuXYsOtdmv088OFcYmVS1nNJAVI=;
        b=pY2kE9O3RWbyT3nDg6Z8Pz3n04UPPpD6xzKUswKaTEnHoKIWu9a7EktED4eI0JPhif
         bqssQf5k/l155PfkolDYLTGBazt+YSD6046W/UXLh/lBPVNzqClURY5EyCJsPkbTpSzO
         MGyjpwoTrMvBoa4D3oUh+SbDe1tk849kFuUPNwlTwEFvQ74C/eg54jknP1tC0IUSXQ3m
         3Kk5II40uvKrya6h/Uv7G8DrhDLAp8UU29irZ4Eimo+9CK7/cKFhvefk9jHJ4X3RiF78
         f8MkWCXo88R0BNTvyh0vXidVE/msF2e/yYWoMN6bxu6ekPNN0keIuDtbH/4BFu51f11J
         7hqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2HWnvPQxGIOkNY8Gj7aiYT0iG6m0fSGu3XioGIjyeOgiQLuu1BRiUClVScZpsJ8zEnDxrAciDsQpZmwwSTZvNWmnK2SymzysVRvFc074mwZupmVa9uzJd4d5Q2WaPbvwoaoeTlG5o5bkNy6KeqXDd/a1hgdIcW+WMNIGTAQGTjTV2AoryMWkesC7Fp0ff
X-Gm-Message-State: AOJu0Yx4KQwLziktZ3LRwU4yX8vOn6z26H5qyQSx8B1gyIw3Ay0yDA8k
	wrM3jaWfSUPUDkIPXo1O+NHxxdCPDn2tjAJGT9r8Yjpr1dVNSnFfjrvaUGI3MM5wCsBZWZG5vNj
	vZ9v6xHwo58rrepT+pLE4taLnrRk=
X-Google-Smtp-Source: AGHT+IGKCstCaSOwLBpvx+2RbrH2XMhIrO0Zi1WRF9+1w4gklfec/ZYCqtFdeNIGbe3s4ZAMkKVG/Tnlq7JT4L+zUss=
X-Received: by 2002:a92:c566:0:b0:365:1737:d74 with SMTP id
 b6-20020a92c566000000b0036517370d74mr233262ilj.0.1709249157897; Thu, 29 Feb
 2024 15:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229005920.2407409-1-kuba@kernel.org> <20240229005920.2407409-13-kuba@kernel.org>
 <871q8vm2wj.fsf@cloudflare.com>
In-Reply-To: <871q8vm2wj.fsf@cloudflare.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 29 Feb 2024 18:25:46 -0500
Message-ID: <CADvbK_e+JCeM9cn0Qd7JG5UdSO_-s8w5r0v40E485JevkbH4XQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] selftests: ip_local_port_range: use XFAIL
 instead of SKIP
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, mic@digikod.net, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 3:27=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Wed, Feb 28, 2024 at 04:59 PM -08, Jakub Kicinski wrote:
> > SCTP does not support IP_LOCAL_PORT_RANGE and we know it,
> > so use XFAIL instead of SKIP.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  tools/testing/selftests/net/ip_local_port_range.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/=
testing/selftests/net/ip_local_port_range.c
> > index 6ebd58869a63..193b82745fd8 100644
> > --- a/tools/testing/selftests/net/ip_local_port_range.c
> > +++ b/tools/testing/selftests/net/ip_local_port_range.c
> > @@ -365,9 +365,6 @@ TEST_F(ip_local_port_range, late_bind)
> >       __u32 range;
> >       __u16 port;
> >
> > -     if (variant->so_protocol =3D=3D IPPROTO_SCTP)
> > -             SKIP(return, "SCTP doesn't support IP_BIND_ADDRESS_NO_POR=
T");
> > -
> >       fd =3D socket(variant->so_domain, variant->so_type, 0);
> >       ASSERT_GE(fd, 0) TH_LOG("socket failed");
> >
> > @@ -414,6 +411,9 @@ TEST_F(ip_local_port_range, late_bind)
> >       ASSERT_TRUE(!err) TH_LOG("close failed");
> >  }
> >
> > +XFAIL_ADD(ip_local_port_range, ip4_stcp, late_bind);
> > +XFAIL_ADD(ip_local_port_range, ip6_stcp, late_bind);
> > +
> >  TEST_F(ip_local_port_range, get_port_range)
> >  {
> >       __u16 lo, hi;
>
> [wrt our earlier discussion off-list]
>
> You were right, this test succeeds if I delete SKIP for SCTP.
> Turns out IP_LOCAL_PORT_RANGE works for SCTP out of the box after all.
>
> What I didn't notice earlier is that sctp_setsockopt() delegates to
> ip_setsockopt() when level !=3D SOL_SCTP.
>
> CC'ing Marcelo & Xin, to confirm that this isn't a problem.
Yes, SCTP supports ip_local_port_range by calling
inet_sk_get_local_port_range() in sctp_get_port(), similar to TCP/UDP.


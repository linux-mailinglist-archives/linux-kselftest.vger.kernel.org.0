Return-Path: <linux-kselftest+bounces-42621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFFDBAC5C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 11:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFA3C78AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5632F549D;
	Tue, 30 Sep 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBXDFWtl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5623C4F3
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225640; cv=none; b=BEAi1HbfWw1EaZU1vXwGlJxxWATvYiREfAxbu3/4ezDx1aNGBQ4fs5N2mCsoQ99U4R+IPTCim+H32ljAHcOaScdEUkppErwYcysTb0NPVeaIkqK80jEvMlStSRZfNGM/ynEJqhsurf7F23ORcrJbYy4Dz84p7HWqNOjDjUyWkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225640; c=relaxed/simple;
	bh=R5eUE/k7fr9cPxgmyCPHZN28u/hmGz9eGDjEvMGrQ/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOA4Lrw/GpbzUMVsIS0it/g+nm6t8tjzMieFqP5W28a+Uxv0hUfiwpGqEpRUVB97A8d1zOuG+Gqm08JtSoKciTqS8aJ2kRlR0AOfOEHkuJz5LXj2dPV4pj1wSM8yRrVJELpOBRVInZBL5UrrM7aofQZxKp0d/VMeX9iFw/ft5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBXDFWtl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b457d93c155so64831166b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Sep 2025 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759225635; x=1759830435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PECcxxgPrslWjdZF9hdrPJ/fNitPu9//arKK4RLmCMk=;
        b=lBXDFWtl0SxDVRlNV0oUs5xYYDnrTRoxwGRi+j/gKn9CVI/GoOp4xyeX2HhlbFpXI/
         805LkdqYeGdZS03sl6pdUAfiOBaTznDQvjx10IrnB+MY0v/rMdMz7WFMngZJDwd5hrUP
         MIdbb6dtbvudk6sWUEEUIMBGAlsXuhR6tVophqRMd8NUKEPK7dS3/5yPflw6fKLo2Lhe
         DaDQFX9xhPvvMotCtmye/4jsG+5YecE3gDaIslKxLadWjuNk2OsyqiVnob+7J1ogyTTP
         GZXMGVJwWLa+QgWeLNkw+5oXN7iZxeWEud2pTMNWBkPQaH73v+E+gH/XGg8cGHyRSdfx
         sFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759225635; x=1759830435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PECcxxgPrslWjdZF9hdrPJ/fNitPu9//arKK4RLmCMk=;
        b=sPrA6HkqvO7ghDeEYNIGhFFUnG8F8SRXwKsHBAeZOD4VoiZIcwFBQB4svX2N/DUFEc
         I4le49Rtxd6QIH3qWKXUyzNjs/K4ZwdPq3AI0U6xulbZNRAaZj/Na85EoghXo1ZzRXCd
         XvXJB82WdpvXKgiTmX4ZSvQOpvq33N1SKiWSUXMLKpUVrOTyjecsfjSz4BoUdChXXUGd
         Q7ov6V+gTlTJwyKPX/B/wz1STtIw0WbhSVenOJTQWsSNlZZeFKidZ9dy3Vv8V81XvQiw
         kJ5Cts1SVZkYoQlN237cynwEsWrkwRLZo3qZsEFg1JeJZ7hGMd0xmHu9eXbDYgJNrQDr
         oQpw==
X-Forwarded-Encrypted: i=1; AJvYcCX7aW626FYOu1lk+AuIKCKxDcd1TAJnGeCuU4s//ocWrw9LdX5z4CCn3RKUHqOn3uoGq4oN8NFtmQR0WwH0xTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOu3dZVOEyYbEDAGTG2A7VznvRxJtjtxx5SV1ATneG0QysvpZ
	pCTs3Vwrgyur4ADWHbaO1cJCM/59p55EHBzBFI5c3UloJO0BNOPciVGPF51hNXDZOqlrKbYspY1
	7KwwdYziAjlGBq+Hc+3LjiuM1DWvSjz0=
X-Gm-Gg: ASbGnctj8APPqKMYanODLhK0YBXLUTz00PddhnjJ8vOboW8sw0w1hu40MyWdy1k15p1
	VsKt87SSjLkRqvDjC8G55UucnqkdMjFyzERxJxpHoGBkifPEe6SLLjORxdtCjbnRwD1z3ZRPAkS
	xsMeTKZgvlcUtYbikxkq1tdyqXUg0zrGSYf7M4ZI7tKDAPEcxaAVB1kQjFW2kEwKyaAXF+Jvmj7
	SEcAEdEdCiy5gDt37AQ+NEFU+BWNIgSgzLuH27H1Sn0aysFszm0Hd700RsTiB8=
X-Google-Smtp-Source: AGHT+IHgrTWmNMFFHnfd0lj5oNhgsomsQpL15DJSD0/eU20JCLwROv8mnCSGOX61iu8gWXio0owIt1z4w1bbdeC1XZM=
X-Received: by 2002:a17:906:730c:b0:b41:27ca:6701 with SMTP id
 a640c23a62f3a-b4127d9aeccmr487703866b.24.1759225635179; Tue, 30 Sep 2025
 02:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929211241.55701-2-sidharthseela@gmail.com> <aNueLn3Wy-2X_GeE@horms.kernel.org>
In-Reply-To: <aNueLn3Wy-2X_GeE@horms.kernel.org>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 15:17:02 +0530
X-Gm-Features: AS18NWCrQTE6adq-xMOBGkCFzYdqRGqDir_x8mhokUn4KGXncQ46nLQvKyPQ23k
Message-ID: <CAJE-K+AeEYkAN8wX3FbBCbQMGTDsueA-YiC4w_qi+TZgUzkS-w@mail.gmail.com>
Subject: Re: [PATCH net v3] selftest:net: Fix uninit return values
To: Simon Horman <horms@kernel.org>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	willemdebruijn.kernel@gmail.com, kernelxing@tencent.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:39=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Hi,
>
> I don't want to block progress.
> But there are some format problems with the commit message.
>
> Locally, git truncates the commit message at the line above ('--').
> Which, omits a lot of useful information.
> Most critically your Signed-off-by line.
>
> There is also another '--' below. Just above the fixes tag.
> Which would cause a similar problem.
>
> And the v2/v3 information should go below the scissors ('---'),
> below your signed-off by line.
>
> Maybe the maintainers can fix this when applying,
> given how close we are to the pull for v6.18-rc1.
> And that I believe there has already been some
> discussion of this patch with the maintainers.
>
> > ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenev=
er 'if' condition is true [-Wsometimes-uninitialized]
> >  1587 |         if (!sock) {
> >       |             ^~~~~
> > ovpn-cli.c:1635:9: note: uninitialized use occurs here
> >  1635 |         return ret;
> >       |                ^~~
> > ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always fal=
se
> >  1587 |         if (!sock) {
> >       |         ^~~~~~~~~~~~
> >  1588 |                 fprintf(stderr, "cannot allocate netlink socket=
\n");
> >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> >  1589 |                 goto err_free;
> >       |                 ~~~~~~~~~~~~~~
> >  1590 |         }
> >       |         ~
> > ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this=
 warning
> >  1584 |         int mcid, ret;
> >       |                      ^
> >       |                       =3D 0
> > ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenev=
er switch case is taken [-Wsometimes-uninitialized]
> >  2107 |         case CMD_INVALID:
> >       |              ^~~~~~~~~~~
> > ovpn-cli.c:2111:9: note: uninitialized use occurs here
> >  2111 |         return ret;
> >       |                ^~~
> > ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this=
 warning
> >  1939 |         int n, ret;
> >       |                   ^
> >       |
> > --
> > Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for =
ovpn module")
> > ovpn module")
> >
> > v3:
> >       - Use prefix net.
> >       - Remove so_txtime fix as default case calls error().
> >       - Changelog before sign-off.
> >       - Three dashes after sign-off
> >
> > v2:
> >       - Use subsystem name "net".
> >       - Add fixes tags.
> >       - Remove txtimestamp fix as default case calls error.
> >       - Assign constant error string instead of NULL.
> >
> > Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> > ---
> >
>
> This is where the v2/v3 information should go.
>
> ...

Thankyou Simon, I didn't know that double hyphen would cause
an issue. Although I need a logical separator between commit message
and warning log, may I ask what could be used instead?

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org


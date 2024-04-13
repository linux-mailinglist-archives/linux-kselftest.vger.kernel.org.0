Return-Path: <linux-kselftest+bounces-7903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058C08A3A3C
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3539F1C2124A
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F5EBE71;
	Sat, 13 Apr 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNrSaqOH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD546BA;
	Sat, 13 Apr 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712973017; cv=none; b=KXVrmwZL+RR4l5UbDUImOmMu9uhNdrxv6vCSjcC31MSHUs7fE+7BDq9sXy71+7rHFNMcsWtpU9otlKVfWWZW8aZT8O3uYLfQk/rWXqkLwrGGKlk4H7cZFWyFJPX1Zn8FGn5COO01Qq3hZnMtGtpNTjPsLEGWi88BDsd4VM3qtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712973017; c=relaxed/simple;
	bh=nK7S4AX7MvARgqM6BBHBiwuYAnJjjYfTAUaMHXm0s7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2xrzWrmLvbFu6S7YoamNJgG24hdzIuz8Uxv9pD54RlnmzlwGyu9NpcvFhnL9FxI30t31x0LLuStMhaQCNnSc2I/V0uB8/e2z7df8eTOzZMrljFk+tA+SKcWcGz6Kb9mi8hg/K/JMHrNabMmMGu/h07lAU1nSQrz+BE863OTn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNrSaqOH; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so986493a91.0;
        Fri, 12 Apr 2024 18:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712973015; x=1713577815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4GoxZ/DDCn693PM29RJyJPYwUobIu0pR6Xc9xkzx0qE=;
        b=fNrSaqOHzM3eH+01xq9bOJj41HrL/gZ+mehDlcXFXKa5e1VGoCAYLXjb/3PJGxwPtC
         Q54QYm90XtMzOQkwGS9+T8XOmnlDguCL4jFm8RmPAwv3EGPyzbh505QXTAivmI9slmdG
         vIcp5ZY6FydAMNksZ0O+N1cm6cnQsNg6u5f1j8+bzVlAGO/2usosmlxXMGRIpMe8MJob
         dvy9KOQemat+M+Ii3kyC7DDzKsY3kUNabCmsKYvp2nTjXdfnJlgPzrnvTNuxWw/abXqa
         2790AeMb/Vhgrt1bidNo29EuTRDuEKXyRJYXhRRmf+q0/9DdmEj1L1v6H1AiA1nDOpRJ
         SzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712973015; x=1713577815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GoxZ/DDCn693PM29RJyJPYwUobIu0pR6Xc9xkzx0qE=;
        b=fuD2pBeQVB+nQD6sgfPTnK0wbD150HtcMJ+iL1VG3s1h6Z+mrjdV9WanzuxVem19+I
         9H+UBASz5VVwgTwk7CFEusa7TYaYOyaTGnNDWH/VFs/cMdUI8IGVAKMigTVySDZwfEAp
         ZSxe2LDbhtMrkKaSTZwG5JGWea8SiRX83sSdYM33+0dumaW4R4g/2iPIM+06ePB7yntH
         MYN/2EtggHsPFMXXIWv0C/Nsrpp/YgKNX/uIfKeHQjYCLUZk1b8PJUgLWFNGPxMrgwpI
         6vYeZJrntMzrwdcJF0ffyPAy0VyqKYWVbROBW/71Xbfccy0BOkPOg+Gv+9GFUzsrP4Je
         0u0A==
X-Forwarded-Encrypted: i=1; AJvYcCUxNLpc1aY7giA4IA0O1sicXLYUnKBeNfzC9Pnk/bB5IXJOP/RpQCZDnWl2NDEocXc6J/uSH2fZY5yOoqHd7xvgUdLCJDH1tV2nW5dQoxaKkZntyN68CDYihaQDbgxnAbyLKS1a4KU5pyEL36UQDSU58bPw+X1Mod+8/ka/gi49NWzB/J2Y
X-Gm-Message-State: AOJu0Ywcs26gQ9iWqRuV9HrO7Vj0DxhWGMEAarPmUBJ9QnsPWi/FEpgp
	Ne/HjsqfhPlQmc7tsrkTJPwflZS5GmCZ4FK2XrfVsh4RyAJwN4dKdlaXmsv66MZQGD1XnnliRsJ
	gzrD+scO+3jT4pXdFMnsI/dSlD/0=
X-Google-Smtp-Source: AGHT+IH6BUPdU+NoMidFc6+jlwGqlMb9lQWMamK9mVH+ehSf6Wk5SSCtqrn3kznnpDURD5OV1Dq7BRw/BiLOHFJ83j8=
X-Received: by 2002:a17:90b:8cb:b0:2a5:3c66:25a8 with SMTP id
 ds11-20020a17090b08cb00b002a53c6625a8mr10160280pjb.15.1712973015100; Fri, 12
 Apr 2024 18:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com> <20240413-tcp-ao-selftests-fixes-v1-3-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-3-f9c41c96949d@gmail.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 13 Apr 2024 02:50:03 +0100
Message-ID: <CAJwJo6buDyTvL5Hh0Mhbrd-pzzom6m0D5==ujvKi3g5ejBURQg@mail.gmail.com>
Subject: Re: [PATCH net 3/4] selftests/tcp_ao: Fix fscanf() call for format-security
To: 0x7f454c46@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Apr 2024 at 02:43, Dmitry Safonov via B4 Relay
<devnull+0x7f454c46.gmail.com@kernel.org> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
>
> On my new laptop with packages from nixos-unstable, gcc 12.3.0 produces:
> > lib/proc.c: In function =E2=80=98netstat_read_type=E2=80=99:
> > lib/proc.c:89:9: error: format not a string literal and no format argum=
ents [-Werror=3Dformat-security]
> >    89 |         if (fscanf(fnetstat, type->header_name) =3D=3D EOF)
> >       |         ^~
> > cc1: some warnings being treated as errors
>
> Here the selftests lib parses header name, while expectes non-space word
> ending with a column.
>
> Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>

Actually, now I see that it was also reported, adding

Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/0c6d4f0d-2064-4444-986b-1d1ed782135f@coll=
abora.com/

--=20
             Dmitry


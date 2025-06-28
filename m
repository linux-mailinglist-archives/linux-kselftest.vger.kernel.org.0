Return-Path: <linux-kselftest+bounces-36032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EADFAEC611
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDD717F961
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 09:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE994224AF7;
	Sat, 28 Jun 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyYtXU0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB911EDA3C;
	Sat, 28 Jun 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751101812; cv=none; b=WOuFTKwx0YWZoDgUapIqXI4qNWlc9hIgiH6yZcCcSl1TKopJkrEpb0yvNQyj35m4kA0fHKXxf0e3AN4bT+jq+UDuh/IBDOQnBduUcimxHU/D4MDkuHGdF3azZ1U8PsDunP3/wMevgf0kAcGHB8qxsxHnGj1EZrqsBgbbecqat1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751101812; c=relaxed/simple;
	bh=LKhb5YM9QO3TGejJNvRHxeALdyLIxKEE/eOariXAOVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmS1svkKhKDPtFean5uG9JdfOa4bPNq2bE4658uEWPdzgIxjE+jEKrNxgh4tEGesuonmazXcsBj4ysoKXyfOhWWKb7/AXeNac0LHo5jhn0d7vjhj9FCRE+whDAWMwS4jys4YBl15YrbdmsQBQxklCD/iJrFKQxTKaPTMwhYcpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyYtXU0D; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae361e8ec32so211514666b.3;
        Sat, 28 Jun 2025 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751101809; x=1751706609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEHPoLzs6KMhxMJaJoJ20bFAcQbB2rDrdd+idOQqY/M=;
        b=iyYtXU0DO9X4bkU9a4YDoDB8d1Fp/FUzKu+syXdhMc/jbqBcLlsstot6SRS8kWBAwL
         VLQCNKnHtrPLxUhzzozjA7fGCkYhKtiWBeg7f2zu76q0ViP761hrISOPCEm6AiaTktC+
         sJbCZEpPwysHzl3S7klLrXAOCeE4W9PzMdJIfCei6cg7eH+VUw+2JlOle5yMw13UIvsH
         3UZUGBIX8i+FFcI37j5jr9NG82DSjJeL1+WBDbj6bee1QFDFK7/pELWEVMtkbvk6mPxK
         lSjeDkgg5hiE2zTT2awpmUvwoLOf7XFWoJlC5iPHX0Wikyc3PFaV7/tgwrVhKzA01P/5
         qalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751101809; x=1751706609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEHPoLzs6KMhxMJaJoJ20bFAcQbB2rDrdd+idOQqY/M=;
        b=cIayN/RWFx3r8ENY3daqqJcDscKj/5TKfytrk4NULUQCCbfOsh/xhM3mjYmobfPpxQ
         KXFEBZDXMjI/PJqVuAZ+S+1V5/ulUU2om6eJEM8gkpUQOX6MOsOJaGtGTRWhoAcRJjnM
         YNqHyY89+GjqJ2p4TpqQ5WJz6sTbnzyo4sjOKYCzcEuaCsF6EBRKF2ujyGoPSwTLf83j
         f4jU+rijWoYHGEwgpvWR0iAqJJnE+UMkCdYSnjEaG4nYtDEzfQlcpMNTug8qVbuOwq3J
         Y8YWSndyReUx7Vm0t3ZluaMfyxfJnioMCYfsvYtUlA7+heOAaKtP7l/8ot5aV5ei+fq6
         sxrg==
X-Forwarded-Encrypted: i=1; AJvYcCUu/zlGa+FCcVvyb/FoSLYCIt0qazIfUVLR8egVL2SRktLNAZZjao8MXqFPbdZQeMlEVjTnLIVvYFL6GWc=@vger.kernel.org, AJvYcCVKuOa7Gx/a+vbGfoHjcus5FQkuSNcWJY/NBwaQG86OHLUGNQuQiNtidE/XbWnMBEoz+Khoxf1xrHARPnDm1T/6@vger.kernel.org, AJvYcCWCqjZHj9pn5FgWi578NrCBktOFaKrLALoPMVX8CY+RN+F+PTFzAh3Cea4/qh/dWTjmJdI2VBmK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzon1NTEM535Kx2FCVhav8B7qi+jSBlO/gDf67Vs2nOOHWn9dJa
	k3Dz3LfSb8d125Yh6g+HSOti/1wAobOOp5ypDR/YdMTAJ6DxZUgS9MPpGSU4X0ZDxBb8aD0jTZy
	XrCu4Jnj9+KvI/7m4+1UaDHtLNAjh4RtMjG3Yqc8=
X-Gm-Gg: ASbGnctWkpgoimUGeT85BMU4nZRX2F31+OlaCWIndSuubi/WUwnvPBEch5XXCnEYYt6
	Xq1qmq07XGeJTTnjDJkEI7R4xffSRG3y9UBJ/VbkNtEU3MOEBQDuiEU24YhxjDHKasfaSgcG1pZ
	8a6Xf0NSuQhJpKmfSQD0wEJOkNX85+YOjfrfOObTWbrU7Cfw==
X-Google-Smtp-Source: AGHT+IEDK5Fe2UcoKbA9nlA8sV8V339+TMPazLs3l3+Ro56k1U+VATna31dBqLeNouv7HbHfgb8gugQJfcqr7VdMJP4=
X-Received: by 2002:a17:907:94c4:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-ae350192135mr551229966b.49.1751101809169; Sat, 28 Jun 2025
 02:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626083512.GT1562@horms.kernel.org> <20250628081918.523857-1-malayarout91@gmail.com>
 <CANn89iJUz2EXu_h-YbiNswixHo6z1EwcmQrfSk6o-MmBznWfWA@mail.gmail.com>
In-Reply-To: <CANn89iJUz2EXu_h-YbiNswixHo6z1EwcmQrfSk6o-MmBznWfWA@mail.gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Sat, 28 Jun 2025 14:39:57 +0530
X-Gm-Features: Ac12FXwXbpJLEZDHIn737zf3EnCP1LtBDwjYB6L9cIZwam4QZtP2xbJ1HElGugY
Message-ID: <CAE2+fR_eG=eY+N9nE=Eh6Lip4nwWir2dRQq8Z-adOme3JNe06Q@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: net: fix resource leak in napi_id_helper.c
To: Eric Dumazet <edumazet@google.com>
Cc: horms@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 2:15=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Jun 28, 2025 at 1:19=E2=80=AFAM Malaya Kumar Rout
> <malayarout91@gmail.com> wrote:
> >
> > Resolve minor resource leaks reported by cppcheck in napi_id_helper.c
> >
> > cppcheck output before this patch:
> > tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resou=
rce leak: server [resourceLeak]
> > tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resou=
rce leak: server [resourceLeak]
> > tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resou=
rce leak: server [resourceLeak]
> > tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resou=
rce leak: server [resourceLeak]
> > tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resou=
rce leak: server [resourceLeak]
> > tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resou=
rce leak: server [resourceLeak]
> >
> > cppcheck output after this patch:
> > No resource leaks found
> >
> > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > ---
> >  .../selftests/drivers/net/napi_id_helper.c    | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/too=
ls/testing/selftests/drivers/net/napi_id_helper.c
> > index eecd610c2109..47dd3291bd55 100644
> > --- a/tools/testing/selftests/drivers/net/napi_id_helper.c
> > +++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
> > @@ -34,7 +34,7 @@ int main(int argc, char *argv[])
> >
> >         if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(o=
pt))) {
> >                 perror("setsockopt");
> > -               return 1;
> > +               goto failure;
>
> client variable is uninitialized at this point.

I sincerely appreciate your prompt review and for identifying the
variable initialization issue. If you are agreeable to initializing
both the server and client to -1, I will proceed to share the updated
patch.


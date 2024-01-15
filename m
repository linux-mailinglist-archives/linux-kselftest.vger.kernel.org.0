Return-Path: <linux-kselftest+bounces-2995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB882DB3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9361D281D5C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jan 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC717599;
	Mon, 15 Jan 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Do1yxTR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29E17594
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a28f771661fso455300666b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jan 2024 06:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705328789; x=1705933589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ozom/lCh7bTZ+/UKfLuCBm+OREt52FaBrJgWzLh8wC8=;
        b=0Do1yxTRwgC7h280pJ8zhLj/yfD/6WH13dQWYRj2ztXHCfl0K2c7xAzZvEoJ6DoVqv
         mw6QNl8KldnuTDm1bTankOz7PZSmz9nW7Xb4Nvd1xSb8WKWW+M4JZR1xKTICA++qaKmb
         Qs8hFLuAnwnSinSay6UDX6ktpZhU/VUyToi6gZsM1XsUrWAbiM9Lrqua7HgmdqDAXF+i
         LaBWsQ/SJqMFtd0gSlX/8SQx7WrgWiJhx0uSzcoMefcd98yDhH5/yRHZvmtPHrVVYS3L
         DQlX85B9BJzJj18vXOYMUVzaKjEKb5PzLD8gJKaYGMmG78jIeUUPhXwhcnF8Mj4z4rI0
         xvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328789; x=1705933589;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ozom/lCh7bTZ+/UKfLuCBm+OREt52FaBrJgWzLh8wC8=;
        b=OX7THDND7ALn5GtrZann88oG1irJbjUB0j0084pWVarpqlLamcz/1SBKIuxA4XgQZn
         LAF3AnE+Y7PNBSHH9SlHsdwggCd9M1dqjPy0+svYbhZRSSgUJQByTX8Zh+d/ovoz7Sa9
         I+Xe7rBThzZG1kwbBo8nPTYjzHWbgaAmJ/KzHLYikPaAp+2n1tlvlkWx4tI7lxfucnep
         Dal3Mg+5NFuOLCjOKxfuvW6Hb+189uScEmHLS9M2IUA/IwQIAc1CQzIGQLsu821msygd
         569a30ZlaEWdlN7/PJutQj1yvPwp5HmDUbc9VZg2+NgGvtLPsQjP+JVUEb1rUUrO9woP
         mv1A==
X-Gm-Message-State: AOJu0YzMkrWqqBSwqqD98raXzhn+u5/gvO4iM66cwn2U8ARPBF+KLLNW
	qB0B3AT6cNEI+Wk0kUXp02bY5azECM7vQxgRWA==
X-Google-Smtp-Source: AGHT+IFPE1nx6Rr58qzIM5ZCiUHok3Ak5Gi1PZAX+14/hxuK9boaY1dYPKdC8HnlSs8HFgwRD9CSdDRExPU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3a10:62fd:72bf:27db])
 (user=gnoack job=sendgmr) by 2002:a17:906:39cf:b0:a23:5780:6300 with SMTP id
 i15-20020a17090639cf00b00a2357806300mr19031eje.10.1705328789306; Mon, 15 Jan
 2024 06:26:29 -0800 (PST)
Date: Mon, 15 Jan 2024 15:26:21 +0100
In-Reply-To: <20240112074059.29673-1-hu.yadi@h3c.com>
Message-Id: <ZaVAjQmio26WloSk@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112074059.29673-1-hu.yadi@h3c.com>
Subject: Re: [PATCH] selftests/filesystems:fix build error in overlayfs
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Hu Yadi <hu.yadi@h3c.com>
Cc: jmorris@namei.org, serge@hallyn.com, shuah@kernel.org, 
	mathieu.desnoyers@efficios.com, mic@digikod.net, amir73il@gmail.com, 
	brauner@kernel.org, avagin@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 514118380@qq.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, Jan 12, 2024 at 03:40:59PM +0800, Hu Yadi wrote:
> One build issue comes up due to both mount.h included dev_in_maps.c
>=20
> In file included from dev_in_maps.c:10:
> /usr/include/sys/mount.h:35:3: error: expected identifier before numeric =
constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from dev_in_maps.c:13:
>=20
> Remove one of them to solve conflict, another error comes up:
>=20
> dev_in_maps.c:170:6: error: implicit declaration of function =E2=80=98mou=
nt=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>   170 |  if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
>       |      ^~~~~
> cc1: all warnings being treated as errors
>=20
> and then , add sys_mount definition to solve it
> After both above, dev_in_maps.c can be built correctly on my mache(gcc 10=
.2,glibc-2.32,kernel-5.10)

This is apparently the same error as in
https://lore.kernel.org/all/11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com/

I'm getting the impression that we are fixing the issue at the wrong layer =
here?
After all, the mount() syscall is supposed to be used with <sys/mount.h>
according to the mount(2) man page?  It feels a bit like cheating to resort=
 to
sys_mount() instead...?

Do you have any deeper thoughts on what could be the underlying issue here?
With my newer GCC toolchains, I have been unable to reproduce this.

Thanks,
=E2=80=94G=C3=BCnther



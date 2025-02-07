Return-Path: <linux-kselftest+bounces-26019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA63A2CB80
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C147A6ABB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC7E1A5B80;
	Fri,  7 Feb 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEfx4YA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A871A3142
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Feb 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953185; cv=none; b=mPXZLSLJ4DC4vZum6JOL2ymWHJeP+lT0mp0s9y4eAfQ8lRXySTXjkHxaXwVKvJvF7f3/IkXQPhiW5Pz/hejncNArX/iTJcJA9yXvmSreZC9FB+kgH+Oqt7qf+8eHuLM0VP85l80K9zLa2a3qkzHYQVKGU6VcR3/U4Xll+XB5KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953185; c=relaxed/simple;
	bh=KFotgUxfmC7ai7PyzaxjdZAl1GAe29TnsnSw34Gvzmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug5UKRUQU/3IpxqMuFrbb4BPEoWGYhLOQZxCeJwNo36elEpR8ff3BYtuBCPFxnJWHN31wUoRcOJ7CtK4TCjA2kmyUTdcmPwz/FE6nsSJ+RyLFDpw3ViwBP+bKccpf+CxI1/NB8SKkcnCp0XFtIcy7/spdNXjujRmftPMq32pStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEfx4YA8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21625b4f978so12065ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Feb 2025 10:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738953183; x=1739557983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFotgUxfmC7ai7PyzaxjdZAl1GAe29TnsnSw34Gvzmo=;
        b=LEfx4YA8i2YlptRF6xEt3Md0UGpJIkbUXuyFbz0+GWr4wQd0vh1MoxDLJGkmCWLDzb
         2kwTDWZKy24Qsfrqyuq/3uRcEqThd5BNBkiQ7X0oi3kxebcpz6b4fRD27SqBPihf/d5r
         Rzj3jTBN3sST6vngOFmJmO5UP1OAlmNblwVEXhruQOSKOmrRp70k97NMXCPgJilUCAbd
         PNzIBFdJJGk9sGexNC+3Z3mwxVO+HW9VFkyYDdWlrQ2iNrWnkE/Ig/urHTjWRXYRSB2H
         j3cQhK8b0XGm7CVu+GIgSX/YFhWTeqNLiwWxOtPY/PElmFT9TsiKtyCa5n0zka+Gl+Yu
         7+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953183; x=1739557983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFotgUxfmC7ai7PyzaxjdZAl1GAe29TnsnSw34Gvzmo=;
        b=D4F5i5B4780/syaUzaEVb7v6oWuWwvYZapzIrSXKa7JombuyMyZNkOrQo0b3ljSf28
         dQQqk4sF6pY05exkr1AJUAF+mP8l4AE9kVVOV9KJeR3X+NuW1Jr4OcZVyfAIxriaQBzZ
         7x3y4sZA+kKlIhwVX+mNxvRegK5hTioy0EV0sjRrd9UsLY79b5aD5/4xz4iAv7fgdafv
         49QfajxC5gq2TwWria4fncDPvBMpijjKfyRisu+1Qgecyzm2kiUZkiaiqzBrtratVTiG
         8+6tfOKRKlsmI0lajExZ8ncP4ugKGEfupCZxe3o9MD7d9rPUW8OHiEGT+aIGBHq8EPfy
         czXw==
X-Forwarded-Encrypted: i=1; AJvYcCVvigmafx53nAOup8OJlrOqihehRVd0YlQxyv8zqCf95GFOylnVfahCLnsCEWA+4Pt+qxramJrn9IdMfLlydRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlOYWTCVA/Diw418pP94oCwzoyInSWiA1yVz/TnZ/nhttdoy6
	mv66TSawo7HwVAv2WvBMZMQ86yR/8gwHoQGrtmhnZfcIJx+XKxrLSXmZd28gnOlTKvUJHYnFLRW
	RlA7aqU7YNb9UPU6JJKrOjYUFeZ7Gd44p0XKc
X-Gm-Gg: ASbGncu1wyzvSd4u76vK3WDQ/LJmMaOW7ohSkOv6JO5bUa4O7QYYRvGnQNDIBVRnsVb
	3CJBZxcANuOatSoB/DT3dowb6JfZVI+eCQdEJ9ie4AoEoU482nedk+FgIqHOt8Fiyhv44plPt
X-Google-Smtp-Source: AGHT+IGdkOU+RI13xBQWaUOd/wbOo4jvt9gqCAHc80EjxhuB0ItJIVoLSEPn1GqroBqJsRXJB90ylZ6PxUDTgJP1w2I=
X-Received: by 2002:a17:903:1a27:b0:216:6dab:8042 with SMTP id
 d9443c01a7336-21f69deebc5mr34745ad.12.1738953183161; Fri, 07 Feb 2025
 10:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207183119.1721424-1-kuba@kernel.org>
In-Reply-To: <20250207183119.1721424-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 7 Feb 2025 10:32:50 -0800
X-Gm-Features: AWEUYZnZliuX8rWa3MXmPQtRIn0btUOZFS0F9oDOzflkwn3pR8toh5q8iLYN5Ck
Message-ID: <CAHS8izP8MtA=JKi+M9yEyXpNMhfVQB0_RF0kCJnwU+BAHpdeEw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: drv-net: remove an unnecessary libmnl include
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, jdamato@fastly.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> ncdevmem doesn't need libmnl, remove the unnecessary include.
>
> Since YNL doesn't depend on libmnl either, any more, it's actually
> possible to build selftests without having libmnl installed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Whoops, sorry about that.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina


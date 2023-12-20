Return-Path: <linux-kselftest+bounces-2258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F61819E23
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390851C25CE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D0220DF3;
	Wed, 20 Dec 2023 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jm2+T7Tw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3422303
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso8828995e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 03:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1703072032; x=1703676832; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+7iPHZO8utdOONNk8gsepNLSyHF62keDFSmQzSfEvPI=;
        b=Jm2+T7TwoBlgWlYHROVohJeiE9ZpCWfYvQo93Jitq40u4z7yKY8Ai0cbSUbxb15d+0
         a8lWFFEVOUviNN7njLF9ZGulOfwUN/P0edZUWEloaAbcGN9D77p7/Bc48ffUXdE/abre
         NTyF8ncuK/gwFpkX/5+Pi1lejZDBI61UEiXA3+f+ae/J5EcHwsFzot7lQeU+iG6ahBVe
         xIAc0Mdbmua2hTMmq3MRZu4wx4CsojGfbuIQiZR9xynyUtxiOuvqcF+zWLiK2gAdDN5x
         BILxygMhqFqhl6bBzqQvQkBtOxUSbsVF1wxuPhc7kWCXHNduuSAjOHXD4ZPaoUwQFh1Z
         tq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072032; x=1703676832;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+7iPHZO8utdOONNk8gsepNLSyHF62keDFSmQzSfEvPI=;
        b=G6+0zHHlP5lzwPlQMXyA4qP+IoX2KHF2vHAy2KqO1L/K89aNHETtBqF+xxUt9bkkRk
         k868rqh7zAKMQpN0CZvZuDX6adDfBOYxPSvYgosg9rt44h8YbvTkOwPn2ipGryHVET2M
         ZSBImTKIjFB8//KRt1Xt0XpLv8e+eJm0Ek/mcDgMnbZ8PeW4hgWvrBbPpDlBxA1sC2sa
         bcWrPZyafi4vmyUX0N1Et8dgX1prTk3rwxiiMBQAG/Y/v61QtygH+yHBiwQX8m01mtmT
         wMJgYFKer/HyHQwY6eE+Cyq/egs1UFe0CK3wFYbc1RddGhxDiNAqq3Py173gdmMoH91h
         j/lw==
X-Gm-Message-State: AOJu0YxzPA0y3UUtuAJQ3BsbmWTU5e5iP2x2tGmPmTw2/lppBVHhd4nX
	Vw7jobXfNTHLhjy/6jr2fklGuQ==
X-Google-Smtp-Source: AGHT+IGw13TjtuVjDpPTpYOKlsIVc3wODh81gNBr2XlzTKvZ3Uvxx0htJXcVGb5MR+89ggd2DRtKmA==
X-Received: by 2002:a05:600c:1ca7:b0:40c:3548:1ee9 with SMTP id k39-20020a05600c1ca700b0040c35481ee9mr9794787wms.164.1703072031651;
        Wed, 20 Dec 2023 03:33:51 -0800 (PST)
Received: from ?IPv6:2804:30c:1668:b300:8fcd:588d:fb77:ed04? ([2804:30c:1668:b300:8fcd:588d:fb77:ed04])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c1d0200b004063c9f68f2sm7160277wms.26.2023.12.20.03.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 03:33:51 -0800 (PST)
Message-ID: <5a7cdb47541e357629437e0b482a1ca506c3b9f7.camel@suse.com>
Subject: Re: [PATCH v3 3/3] selftests: livepatch: Test livepatching a
 heavily called syscall
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Joe Lawrence
	 <joe.lawrence@redhat.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.de>, Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet <corbet@lwn.net>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, Petr
 Mladek <pmladek@suse.com>, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org,  live-patching@vger.kernel.org, Miroslav Benes
 <mbenes@suse.cz>
Date: Wed, 20 Dec 2023 08:33:42 -0300
In-Reply-To: <3a6b1886-c133-4893-8113-73f290b97390@linuxfoundation.org>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
	 <20231031-send-lp-kselftests-v3-3-2b1655c2605f@suse.com>
	 <f9d82fa6-08d7-4ab6-badc-691987b37a82@linuxfoundation.org>
	 <unpg4z7eig6qbudgulnr6sog65fq7s2dy4u2vp2dgkdrq5csdw@dltnxuw6kw5b>
	 <8b95b96c-6aeb-4bf0-8ee9-2ba62330c672@linuxfoundation.org>
	 <12a9ec1bc84dc6d4b461e5c780ba7d3c3aa91740.camel@suse.com>
	 <76c4b967-1cb6-4f77-9402-f835b15adb10@linuxfoundation.org>
	 <alpine.LSU.2.21.2312061530470.13051@pobox.suse.cz>
	 <2498bf91-8057-43e8-98f2-4ed93c53ce9f@linuxfoundation.org>
	 <8a433f12-b930-6095-9a49-db5f1d2836b5@redhat.com>
	 <3a6b1886-c133-4893-8113-73f290b97390@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-18 at 13:47 -0700, Shuah Khan wrote:
> On 12/15/23 13:36, Joe Lawrence wrote:
> > On 12/11/23 16:53, Shuah Khan wrote:
> > > On 12/6/23 07:39, Miroslav Benes wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, 5 Dec 2023, Shuah Khan wrote:
> > > >=20
> > > > > On 12/5/23 05:52, mpdesouza@suse.com=C2=A0wrote:
> > > > > > On Fri, 2023-12-01 at 16:38 +0000, Shuah Khan wrote:
> > > > >=20
> > > > > > 0003-selftests-livepatch-Test-livepatching-a-heavily-
> > > > > > call.patch has
> > > > > > style problems, please review.
> > > > > >=20
> > > > > > NOTE: If any of the errors are false positives, please
> > > > > > report
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 them to the ma=
intainer, see CHECKPATCH in
> > > > > > MAINTAINERS.
> > > > > >=20
> > > > > > I couldn't find any mention about "missing module name". Is
> > > > > > your script
> > > > > > showing more warnings than these ones? Can you please share
> > > > > > your
> > > > > > output?
> > > > > >=20
> > > > > > I'll fix MAINTAINERS file but I'll wait until I understand
> > > > > > what's
> > > > > > missing in your checkpatch script to resend the patchset.
> > > > > >=20
> > > > >=20
> > > > > Looks like it is coming a script - still my question stands
> > > > > on
> > > > > whether or not you would need a module name for this module?
> > > >=20
> > > > I admit I am also clueless here. The module name is given in
> > > > Makefile. In
> > > > this case in test_modules/Makefile. I do not know of anything
> > > > else. There
> > > > is no MODULE_NAME macro. Could you elaborate, please?
> > > >=20
> > >=20
> > > I see that now.
> > >=20
> >=20
> > Hi Shuah,
> >=20
> > In the other replies to this thread, Marcos noted that he would add
> > some
> > text to the commit / documentation on running and building the
> > selftests
> > directly in the kernel tree (that would get my Ack) ... is there
> > anything else to be updated for a hopefully final v4 (for your
> > Ack)?
> >=20
>=20
>=20
> I am waiting for v4 with your comments are addressed. I can take
> this through kselftest tree.

Ok. I'm already preparing the v4. The plan is to send in the next few
days.

Thanks,
  Marcos

>=20
> thanks,
> -- Shuah
>=20



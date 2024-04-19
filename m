Return-Path: <linux-kselftest+bounces-8479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF78AB5E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 22:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AAB1F22046
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FAA13C9A9;
	Fri, 19 Apr 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWgTgCD2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF82206C;
	Fri, 19 Apr 2024 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557165; cv=none; b=R1zoB8+7Oe1pJxnw+IOOFiCaonafB0BpdZJYf6AZRzHOfuSf4MPSY6M5UxOrnDuyKhb9UO1smJwYzoNaq4KFW0Ug28WC7smf18Wnn1C1OSqynMxYMC60P6jTiw+DHb90/Xv/w3UUvFCyKW/8tL+SrBzTwPB8jlrxAl67S6vHq7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557165; c=relaxed/simple;
	bh=qiBYh7Q4vs/502OF3/ovuHA+agIZHizLsd++YZi/P5A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r2dBQZ5mFQc4NWLNqj+/y7p4iv6TClNxtafBnCZDu/7mvSPxotTOH9/HZFkLU61CJRR6skzugrvmAbnl3EMsKOO9xgVuMTcS0q1hj2O70zOSdejZ8uz14EJoRM1+D6ULfLwHC3ez6W6+xe9+mDke/9cvOt0S51u8h261QRt3IDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWgTgCD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5328C072AA;
	Fri, 19 Apr 2024 20:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713557164;
	bh=qiBYh7Q4vs/502OF3/ovuHA+agIZHizLsd++YZi/P5A=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EWgTgCD20cGXC2obnm+7DRzZMA2SWOgkh8x8neSq1xG/nL3Bp3eW7hGjTQM7iPzXA
	 ld6cgcD4nAUa4/RwewmqbTEISAXlnKagvG/bJ8uE4PPy1t9lVoo/wzAOn4MRJOQRsA
	 s4iDGy0T5VemW7vxJ0OaLUtuTQB94ADywih6ZgZafB2XuLokvxmSsOp/rwH7LCNdKD
	 IkxT83hQQsNf30+99I5rFrKEj1KDmTVATZz9JPacceATz1VvwesUGBuZ37LOQspUhN
	 Fymm8QpdJpJDcSmnxo/65A7umQY/1MgYimc6AZvALyr2SjAt29l8ZpJnWcbN41hgmM
	 Y4uMybalywT9g==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Apr 2024 23:05:55 +0300
Message-Id: <D0ODBDZDHQ6J.ZC4UU90AZPFL@kernel.org>
Cc: "linux-security-module" <linux-security-module@vger.kernel.org>,
 "linux-doc" <linux-doc@vger.kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-kselftest"
 <linux-kselftest@vger.kernel.org>, "bpf" <bpf@vger.kernel.org>, "zohar"
 <zohar@linux.ibm.com>, "dmitry.kasatkin" <dmitry.kasatkin@gmail.com>,
 "linux-integrity" <linux-integrity@vger.kernel.org>, "wufan"
 <wufan@linux.microsoft.com>, "pbrobinson" <pbrobinson@gmail.com>, "zbyszek"
 <zbyszek@in.waw.pl>, "hch" <hch@lst.de>, "mjg59" <mjg59@srcf.ucam.org>,
 "pmatilai" <pmatilai@redhat.com>, "jannh" <jannh@google.com>, "dhowells"
 <dhowells@redhat.com>, "jikos" <jikos@kernel.org>, "mkoutny"
 <mkoutny@suse.com>, "ppavlu" <ppavlu@suse.com>, "petr.vorel"
 <petr.vorel@gmail.com>, "mzerqung" <mzerqung@0pointer.de>, "kgold"
 <kgold@linux.ibm.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Bagas Sanjaya" <bagasdotme@gmail.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Roberto Sassu"
 <roberto.sassu@huaweicloud.com>, "corbet" <corbet@lwn.net>, "paul"
 <paul@paul-moore.com>, "jmorris" <jmorris@namei.org>, "serge"
 <serge@hallyn.com>, "akpm" <akpm@linux-foundation.org>, "shuah"
 <shuah@kernel.org>, "mcoquelin.stm32" <mcoquelin.stm32@gmail.com>,
 "alexandre.torgue" <alexandre.torgue@foss.st.com>, "mic" <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <Zh4DQ7RGxtWCam8K@archie.me>
 <66201cd2.df0a0220.a8ad5.6fbaSMTPIN_ADDED_BROKEN@mx.google.com>
 <fe361a16-1536-4c92-894a-0b24258384bf@gmail.com>
In-Reply-To: <fe361a16-1536-4c92-894a-0b24258384bf@gmail.com>

On Fri Apr 19, 2024 at 2:18 PM EEST, Bagas Sanjaya wrote:
> On 4/18/24 02:02, Roberto Sassu wrote:
> >=20
> > 72374d71c315
> >=20
> > Roberto
> >=20
>
> Still FTA (fail to apply), unfortunately.

Robert, quick suggestion.

Maybe pick recent rc for the patch set, rebase on top of that and
document that to the cover letter?

In git: "git rebase <version>" when on branch with the patches
applied.

BR, Jarkko


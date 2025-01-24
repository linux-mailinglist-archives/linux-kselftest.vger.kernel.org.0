Return-Path: <linux-kselftest+bounces-25122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F98A1BA93
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D65C7A16EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60081925AE;
	Fri, 24 Jan 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFwlYNS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2572189F5C;
	Fri, 24 Jan 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737736565; cv=none; b=QtkTP8qEeMLk5Mz8npwVR3I/h9dWLWqBEiGS45XPaCYmKo+3+Eo6cuLf4tZgIYpmx37paBTIGn/okeK/7p/VS5DMsZVdlqRmmN/LI/KmcsxHnu9EGCM7WB9QP7AUOot082dxMnzOTc2v2Q77FX9HZMC7JXr9pAcAzXUf9aGMkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737736565; c=relaxed/simple;
	bh=qw9sL4e2WHFO0R0bwxLwz5BJzMvwrz0O7pdsb4Warso=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=k5jUf8hqPqjuBfWitec2J1bFpPwQkb/wv38P7JaVr8xZ5VJ3VwGPl/o66OYlMK6XwWzZPnlFmwVg7s4a+Z/SB9nNID/lxaLZqHm6eiO9gYCsdIDz+RNoeRvBIqoX48beUiaTThIJL0jGmxIU8/uz6WOdrehjxuAPTEnqbOWl1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFwlYNS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCC5C4CED2;
	Fri, 24 Jan 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737736565;
	bh=qw9sL4e2WHFO0R0bwxLwz5BJzMvwrz0O7pdsb4Warso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFwlYNS7WTqSyyFtbpCZIYRS4wxfdkhkik45LEbaja2oWiiHOVSr3lLU5QUHdps/c
	 YMxmJksb+X1EJNVHdXthjkzKisj8OYFz5p0Z+3ky2onBSyb1ZxUuzjvCcaGmKhrpzz
	 5YGV+vbi3WNvxzAVeCOUqOOcV/pqw+alJ5YtglEKhI3YljsaolQcpHI2Km7o04lFYA
	 6N/uwwJ+nlehU77Ug0DAfqGHUCwN0MDEfOpIGh5wHxFPbkN+SoAK3lP8aIpU0jaqNG
	 7m3Sl0W69hRFPDyILQFu2mS63n/ZrKTyKx1dOnaWoqNKym1aOY2dBpxyPTwOunk1Os
	 12nC4dVCjtpRQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jan 2025 18:36:00 +0200
Message-Id: <D7AG776AI2EQ.KLG13BCOXBJL@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Nikolai Kondrashov" <Nikolai.Kondrashov@redhat.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, =?utf-8?q?Leonardo_Br=C3=A1s?=
 <leobras.c@gmail.com>
Cc: "Vignesh Raman" <vignesh.raman@collabora.com>,
 <kernelci@lists.linux.dev>, <linuxtv-ci@linuxtv.org>,
 <dave.pigott@collabora.com>, <mripard@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kselftest@vger.kernel.org>, <gustavo.padovan@collabora.com>,
 <pawiecz@collabora.com>, <spbnick@gmail.com>, <tales.aparecida@gmail.com>,
 <workflows@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <kunit-dev@googlegroups.com>, <nfraprado@collabora.com>,
 <davidgow@google.com>, <cocci@inria.fr>, <Julia.Lawall@inria.fr>,
 <laura.nao@collabora.com>, <kernel@collabora.com>,
 <torvalds@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
 <daniels@collabora.com>, <helen.koike@collabora.com>,
 <shreeya.patel@collabora.com>, <denys.f@collabora.com>,
 <nicolas.dufresne@collabora.com>, <louis.chauvet@bootlin.com>,
 <hamohammed.sa@gmail.com>, <melissa.srw@gmail.com>, <simona@ffwll.ch>,
 <airlied@gmail.com>, <Tim.Bird@sony.com>, <broonie@kernel.org>,
 <groeck@google.com>, <rdunlap@infradead.org>, <geert@linux-m68k.org>,
 <michel.daenzer@mailbox.org>, <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
X-Mailer: aerc 0.18.2
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
 <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
In-Reply-To: <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>

On Fri Jan 24, 2025 at 3:00 PM EET, Nikolai Kondrashov wrote:
> On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:
> > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
> >> Gitlab as an open-source software project (the community edition) is o=
ne
> >> thing, but can we please avoid advertising specific proprietary servic=
es
> >> in the kernel documentation ?
> >=20
> > I don't think we should have any of this in the mainline kernel.
> >=20
> > One angle is that "no regressions rule" applies also to the shenanigans=
.
> >=20
> > Do we really spend energy on this proprietary crap to the eternity?
>
> This is not getting included into the kernel itself, the contributed code=
 is,
> of course, open-source. And yes it would execute just fine on the fully
> open-source community-edition GitLab. I don't think "no regressions rule"
> should apply here. This is for developers only, and is a template for mak=
ing
> your own pipeline mostly, with pieces which can be reused.

Ah, OK then it is fine. It was a kernel list so I assumed it was for
kernel.=20

Then: I don't care about this ;-) I use a different testing tool
(BuildRoot) and a different CI (Woodpecker in my local server).

So go ahead and do what you like...

>
> Nick

BR, Jarkko


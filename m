Return-Path: <linux-kselftest+bounces-25114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE1A1B99B
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FD416BE63
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DB715C158;
	Fri, 24 Jan 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IMRZRySe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672F158DC6;
	Fri, 24 Jan 2025 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733567; cv=none; b=IGNVqrJgwypYKV6zIGdzpOMtcvVLtaHt7GHLTFoBExQJgSd5If6JxR9uy3p3D2Nfye2TlZuvFJXpqe39iEwEA88Es7ewxqzCiAEk+kjA6suZ/wJrP3O1cYkS0KqcYVRmU36waIzHtytnTm7Xvlj+hdxnt4daOWT4PW618cK+kiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733567; c=relaxed/simple;
	bh=cLZOIgnfgjGvNUIYx04zBqZGna/RfQWRwRglzMbRjPA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JAB2O5YNgnt6NTOAxPe+0SjcpG9YV5fSAbP0vR1TBlknJn/YAGK4d9tFCr40CXxsT6svg1UCq9Shg5qBA2drF9bUMPMKFYjbufoUa/CSKJ0LSsaUwpH285hm65X4ASdzUMN1JHtXYKqYRwxl2GH+wbgEBFmMR6HlvsJuTqBrIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IMRZRySe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737733563;
	bh=cLZOIgnfgjGvNUIYx04zBqZGna/RfQWRwRglzMbRjPA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IMRZRySe/CPCOi90T2I+F73BaBf5gi8JCS9AU4jiUx/4oKydpEeGcGUquzkgkZ8ku
	 s16m5Dy33q+SVtJtezCnGsQXyZbeouaJnwtmxrqpk+0B0v1RpQ3yw7+/4OY56EPnhU
	 ZY5+jHI2jtvJRNOkyARBF62bN7SU5lO81jitCgbRyDclT7GT4Sh8K4SWDfhepSlm8Y
	 K0XUUCWY9kDa3Nq2CPI04YIxYkU3TFDBpeJrgRTFmi8ApWPiWX/8bHfjlqpShdT7CC
	 STyrLmfiuSs2oBCbh1sqkPf9XJBqqmR/pJYmQ7/jmGfTn1n9gvwCZdS4grHLOrvaFg
	 rgDZogfAn08Uw==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4998417E0E6E;
	Fri, 24 Jan 2025 16:45:59 +0100 (CET)
Message-ID: <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>
Cc: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>, Vignesh Raman	
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, 	dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, 	pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, kernel@collabora.com, 
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, 	shreeya.patel@collabora.com, denys.f@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, 	geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, 	jarkko@kernel.org
Date: Fri, 24 Jan 2025 10:45:57 -0500
In-Reply-To: <20250124130021.GA6853@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	 <20250124081250.GA24731@pendragon.ideasonboard.com>
	 <20250124135203.040d0852@foz.lan>
	 <20250124130021.GA6853@pendragon.ideasonboard.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Le vendredi 24 janvier 2025 à 15:00 +0200, Laurent Pinchart a écrit :
> On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > 
> > > > It's been a few years since I first thought on finding a good way of helping
> > > > kernel developers testing their patches, while making use of the free runner
> > > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > > new to kernel development, or students trying to understand it better.
> > > > 
> > > > And this patchset allows that to happen :)
> > > > 
> > > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > 
> > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> > 
> > Sounds interesting!
> > 
> > > Gitlab as an open-source software project (the community edition) is one
> > > thing, but can we please avoid advertising specific proprietary services
> > > in the kernel documentation ?
> > 
> > Every time Gitlab is mentioned, the brand of the company that
> > developed it and has been providing proprietary services is also
> > advertised. If you're not happy with that, you should move to use
> > a git forge developed by some open source community.
> 
> I'm fine mentioning the gitlab community edition, I'm not fine
> advertising gitlab.com SaaS in the kernel source tree.

I've just looked attentively, the intention is just to explain you may need to
set gitlab variable in your project fork in order to select correctly sized
sized runners in your own instance. Its is not strictly about commercial
gitlab.com instance. The default only works with the original project used
instance (which is not gitlab.com as far as I know), but the comment refer to
companies that will choose gitlab.com internally to reduce their IT cost.

Its quite a stretch to call this "advertisement", that makes it looks very
dramatic. I personally believe its quite ahead of most other gitlab CI to take
into consideration running these pipelines on foreign (to the project)
instances.

Nicolas

> 
> > The way I see, the best would be if the CI integration could work
> > with more than one type of forge and being able to use any
> > free Git??b-CI runners that would be available for developers to
> > use, as this would allow testing more subsystems with CI, thus
> > increasing code quality.
> 



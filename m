Return-Path: <linux-kselftest+bounces-25098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BF7A1B7DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4940316D0B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29D612BF02;
	Fri, 24 Jan 2025 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BAL1UqWp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA8586339;
	Fri, 24 Jan 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728808; cv=none; b=kkxoetgLOZddMAR3Bsu5mENpwmRL1OWx1b/EsNBcr7e1CFH1XNEmzZ6n9YFiVFp51NVXPlD2WSDe5FOxeuguJzsKfi1Ni/uqUzgpo+eH4k1z1hFrXypPsu7TdDKVyJwzuVUwaSioyzcocqdhPh/jH596Q4eBpCKmaKVe43KAYBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728808; c=relaxed/simple;
	bh=Fn7sVn0NbYZhm7JxknrOZwVFg9G9cMFFUTYJo64GgPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NlcWASIMX45MMzBZp08zbp6YYY/reM8xLpgXEC++pTR6NNvqPHbSbl9vl7K3zBtnND8ohcdO+Bcep8V4LUiQMVjsXxK42xYae6PP71POtLqutQ8WSda64yUQSHYnJswXAdo0vEVMP3x1gID8mwBiEZU+aYZjMkCsvQ7nnPDXx80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BAL1UqWp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737728799;
	bh=Fn7sVn0NbYZhm7JxknrOZwVFg9G9cMFFUTYJo64GgPo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BAL1UqWppcSgPAdfimcgwSZtp5TQAmeChpEwqE7virszEImjVf3+eaAJHb82q4aZu
	 xPnOgU/Kc2jz/4PAHJk1xW00xAHe6N03twa6YyvqYa4ssu2h0c37PzgmrIPLQ6n4hG
	 AGSLRa8uBFWxMJ4D5SK8CdMz9K2fv6P1mvYUn0pfh8w0OJ1lgJq7RmVDqB9b0ZUVWG
	 SI2yQGg529UMho2hsuhi0bTYUOp6UE7Bkkn/QpIV82QtpFdO5sJiteVAwgQedKR05s
	 EbGGNnbOh/ttIf20CXV4BVoWHooMZw9NAsEGYzt1tOPz3BuETjqI4cFM3jTIYoqltG
	 wXfVJT9gi+khQ==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A97DB17E0E57;
	Fri, 24 Jan 2025 15:26:34 +0100 (CET)
Message-ID: <b3af62d3565d2d60218520d2ebace6f1a0368c17.camel@collabora.com>
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>, Jarkko Sakkinen	
 <jarkko@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Leonardo =?ISO-8859-1?Q?Br=E1s?=	 <leobras.c@gmail.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev, 
	linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com, 
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com, 
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, 	nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, 	Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, 	torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com, 
	helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, 	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
 melissa.srw@gmail.com, 	simona@ffwll.ch, airlied@gmail.com,
 Tim.Bird@sony.com, broonie@kernel.org, 	groeck@google.com,
 rdunlap@infradead.org, geert@linux-m68k.org, 	michel.daenzer@mailbox.org,
 sakari.ailus@iki.fi
Date: Fri, 24 Jan 2025 09:26:33 -0500
In-Reply-To: <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	 <20250124081250.GA24731@pendragon.ideasonboard.com>
	 <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
	 <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
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

Hi,

Le vendredi 24 janvier 2025 à 15:00 +0200, Nikolai Kondrashov a écrit :
> On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:
> > On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
> > > Gitlab as an open-source software project (the community edition) is one
> > > thing, but can we please avoid advertising specific proprietary services
> > > in the kernel documentation ?
> > 
> > I don't think we should have any of this in the mainline kernel.
> > 
> > One angle is that "no regressions rule" applies also to the shenanigans.
> > 
> > Do we really spend energy on this proprietary crap to the eternity?
> 
> This is not getting included into the kernel itself, the contributed code is,
> of course, open-source. And yes it would execute just fine on the fully
> open-source community-edition GitLab. I don't think "no regressions rule"
> should apply here. This is for developers only, and is a template for making
> your own pipeline mostly, with pieces which can be reused.

Perhpas worth clarifying that Media and DRM subsystem have opted for the
Freedesktop instance. This instance is running the Open Source version of
Gitlab, with hundreds of CI runners contributed and shared among many projects
(which includes Mesa, GStreamer, Wayland, Pipewire, libcamera, just to name
few).

Nicolas


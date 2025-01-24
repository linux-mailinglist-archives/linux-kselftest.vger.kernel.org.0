Return-Path: <linux-kselftest+bounces-25091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A029A1B654
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787C53AC690
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CDADDBB;
	Fri, 24 Jan 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RryHRov2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4002B665;
	Fri, 24 Jan 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723136; cv=none; b=lsGFxU9fojllj94csuwVfgV/oR0DgpTGM5Jqp8jWVoY4uU8EaxeHKJ2AA4KdCitGYcqy0FDFg2dlkpDsI1aYMHlsECVz3WMknzo5oGLPUa2IyBWx+5qaBkH9NkQ3zbhXoDXJQuP+FmDkCsKAxPL5Ts8OSToreN9BEhxZrb+cu2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723136; c=relaxed/simple;
	bh=CpbOkdw5ufLxu3POL0cSP+QQdt85eklh2emIk4kJQdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHdNHzl64ne6AkqDQrozy+wW04V/zzzPxpsPgSU5rKpo+/0VdfsDodkUOvsqzrRIft236frhz3Y9Vqi797E+bY09lf9ZeWIRtF2yFd+9RXM4AsDLlByxUOD3YpRw7bwt8KXu4Tv+EV+/OSmSq3j0f/NzpBAjkdxSfQ+Pvt4n1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RryHRov2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07688C4CED2;
	Fri, 24 Jan 2025 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737723135;
	bh=CpbOkdw5ufLxu3POL0cSP+QQdt85eklh2emIk4kJQdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RryHRov2KoNJszYH1AdqbYFOqxFE00KYUb2qQdcn6XWytVkTx8AEyIRrA8EtuEe3m
	 x8vOQs1rPLvRD/zh1iMl58Md6wWIDJbhUApNpjadFhn1BxXv0G7GIqvg+ecspRbQs2
	 ZCpSlLnCbT5a575vFoYr3+QA00DD7DW4Ve3Zv5NQMMAaFsJKDK1xvx93vwx8Npif91
	 jJy+xIR3jmm3NpoWLMGKBF9sYPpgYeGOrVEHs3J8bQujOR6Gzn8ONECASE2bgS9HOq
	 hGV85cTPUIdxBpXvxG71Bum3JQdo6yF7NIxseaPBLQKBZg2MLk0avz41j2iPcqIMuq
	 kLeBOgTG4fqvg==
Date: Fri, 24 Jan 2025 13:52:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Leonardo =?UTF-8?B?QnLDoXM=?= <leobras.c@gmail.com>, Vignesh Raman
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Subject: Re: [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <20250124135203.040d0852@foz.lan>
In-Reply-To: <20250124081250.GA24731@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	<f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	<20250124081250.GA24731@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 24 Jan 2025 10:12:50 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> > It's been a few years since I first thought on finding a good way of helping
> > kernel developers testing their patches, while making use of the free runner
> > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > new to kernel development, or students trying to understand it better.
> > 
> > And this patchset allows that to happen :)
> > 
> > Actually, I spoke to Helen last year, and to enable it to run on the free
> > Gitlab-CI runners, there is a small extra patch which is needed:
> > 
> > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  

Sounds interesting!

> Gitlab as an open-source software project (the community edition) is one
> thing, but can we please avoid advertising specific proprietary services
> in the kernel documentation ?

Every time Gitlab is mentioned, the brand of the company that
developed it and has been providing proprietary services is also
advertised. If you're not happy with that, you should move to use
a git forge developed by some open source community.

The way I see, the best would be if the CI integration could work
with more than one type of forge and being able to use any
free Git??b-CI runners that would be available for developers to
use, as this would allow testing more subsystems with CI, thus
increasing code quality.

Thanks,
Mauro


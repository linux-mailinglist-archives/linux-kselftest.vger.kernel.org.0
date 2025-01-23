Return-Path: <linux-kselftest+bounces-25027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A49A1A954
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 19:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD56188B17B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DB41552E4;
	Thu, 23 Jan 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dN6XkPpg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C170817;
	Thu, 23 Jan 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655460; cv=none; b=su7Ngjn4qRZMmwLmUMQBc6z1fR2iiNp8PQiPiyDSkX8f6fH5PFOn6uNVg0L5ZJPnRHB51vCk4n97JsrlWoQfT2o8uZBhdm+BxlrabxKi6FFpzMIu+hfzz68ovjmFm2P+/ZoOqkw0dsVUE9WvoxKKScQBfnoYZOJHc9RVVvTcfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655460; c=relaxed/simple;
	bh=eTuapbwK/KdvI8diNR5eurIEYnCZRL8MW3R/4gjq+6w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sq+VBDDnl8se8ZcYTMLh/+FEGnmSr3C83VgVLoaQ/BkF2ZUvH+ab+nSdHMd70qKWoyFlTP5KeNOuqXPBqn6617UtZiHcmhBw4qc2+Xmv8tbaSp6Hc4fJuKVeP7hrTloH8iVNioJSDud6NlW9EyQqxP637ZbiW1T/kcg5FZIC85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dN6XkPpg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737655456;
	bh=eTuapbwK/KdvI8diNR5eurIEYnCZRL8MW3R/4gjq+6w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dN6XkPpgjABscLcR3nYIXAz0bQMLNZxgbT67jyUfEivcJlWdPP2fqMzeJqdRFhXDA
	 FXaNasNNERyvl9jd3XW1t8+71Fl8VY/aeR33vSFgsEwpu6mqU180G5g+5ZkKWTeCgk
	 7Kq7Odd/pvaQzv52RtaphR1dxl6ib0q3x5fnXwG6xvOefakPg8ByZ7IUrAKDb0yPQd
	 zvjwg5lBe78jQX2NVh+K60iQSBLPW/bFnkWSyyf7PCzz2tTyEhg43478l7lUUF18/7
	 u9esbGiOIdgxqzhHPLljK3iNRG8S+j6P0H48nKAnX8efHquACXBRBMvVGCA1i32LvY
	 m2pigY9OxoHMA==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5892917E0E48;
	Thu, 23 Jan 2025 19:04:12 +0100 (CET)
Message-ID: <ae9d345c71e99ac56b935a18f02c2c01fc87b9e0.camel@collabora.com>
Subject: Re: [PATCH v2 5/5] kci-gitlab: docs: Add images
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>, Vignesh Raman
	 <vignesh.raman@collabora.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
 dave.pigott@collabora.com, 	mripard@kernel.org,
 linux-kernel@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, 	gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, 	tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com, 
	kernel@collabora.com, gregkh@linuxfoundation.org, daniels@collabora.com, 
	helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, 	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
 melissa.srw@gmail.com, 	simona@ffwll.ch, airlied@gmail.com,
 Tim.Bird@sony.com, 	laurent.pinchart@ideasonboard.com, broonie@kernel.org,
 leobras.c@gmail.com, 	groeck@google.com, rdunlap@infradead.org,
 geert@linux-m68k.org, 	michel.daenzer@mailbox.org, sakari.ailus@iki.fi,
 jarkko@kernel.org
Date: Thu, 23 Jan 2025 13:04:11 -0500
In-Reply-To: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <20250123135342.1468787-6-vignesh.raman@collabora.com>
	 <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
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

Le jeudi 23 janvier 2025 à 07:46 -0800, Linus Torvalds a écrit :
> On Thu, 23 Jan 2025 at 05:56, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> > 
> >  Documentation/ci/gitlab-ci/images/drm-vkms.png | Bin 0 -> 73810 bytes
> >  .../ci/gitlab-ci/images/job-matrix.png         | Bin 0 -> 20000 bytes
> >  .../ci/gitlab-ci/images/new-project-runner.png | Bin 0 -> 607737 bytes
> >  .../ci/gitlab-ci/images/pipelines-on-push.png  | Bin 0 -> 532143 bytes
> >  .../ci/gitlab-ci/images/the-pipeline.png       | Bin 0 -> 62464 bytes
> >  .../ci/gitlab-ci/images/variables.png          | Bin 0 -> 277518 bytes
> 
> 
> This seems excessive.
> 
> We have a few images in the tree, but they tend to be either the
> penguin logo or various source SVGs.
> 
> Not a set of random screenshots or whatever.

I can only agree.

Nicolas

> 
>          Linus



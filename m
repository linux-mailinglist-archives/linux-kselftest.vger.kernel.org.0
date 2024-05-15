Return-Path: <linux-kselftest+bounces-10208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7118C5E79
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 02:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0E93B21902
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 00:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9598D812;
	Wed, 15 May 2024 00:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b="lxaPLprY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A54A23;
	Wed, 15 May 2024 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.185.137.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734635; cv=none; b=f5vUrc4L69taWfK34tWNqfz2Mj2a3E+7a4QfyFDi8WavIiudvsUZsLn/wM/yUollD4hMNVd5oC3b4TdxyfwktyFafU+8Pj55ohgEn7ZB8bjd95DMh7D41z1r+NPl14N6FYxnl+35kEecSc5VYfPtfWIZUQ8XvDmN4wchJCSngkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734635; c=relaxed/simple;
	bh=Tp+H0K5QBoSVdZXwfKgYZIjpg1XuSAWBXwAx1DzF8sA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=VlBDmx7VEe8N9PHNwg0+o9Lwe4gxc4+YzCkmwSjCnsGuhStqcSXHtNV6SDRd+oWyW1RwKyv5FlXRmbML4DQ4rc3t+2GFA2P86KDvWoVNjL/TXHxhp20FwBHd9pMUIBcX+HKmm/9ow7om2a5+RBg8JWFWIXeTOpf+Oc9rSG5mWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org; spf=pass smtp.mailfrom=openbsd.org; dkim=pass (2048-bit key) header.d=openbsd.org header.i=@openbsd.org header.b=lxaPLprY; arc=none smtp.client-ip=199.185.137.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openbsd.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=Tp+H0K5QBo
	SVdZXwfKgYZIjpg1XuSAWBXwAx1DzF8sA=; h=date:references:in-reply-to:
	subject:cc:to:from; d=openbsd.org; b=lxaPLprYzJ00fSaQHk9PaY/XjyG/TOiry
	J4aaFgmXuVu9/f7WAP4UTqygXQYY60grub5GX6StNo9F20PFWuVvzlLNAFKEKNuObq0gH4
	gPVJaTyi/52KYiWEhrtOpmxprKp0rlqHFgbrvpP0A4PganEEqosTTvlIZYDN2GYsh0kQOh
	Kjz1mRunyAOmb9+lxOz2/YkF/7FGyUAcdwO+7ai1fU1MU3XRP4QWjUuYye9/BJ2qgCBQJm
	x5RiA8+29lUIceuRq9Gz3Uj8Dgke64xBlqTn5sNUFK/PibzPIjqM7HwzRYS8IRvCuvZtm7
	uWpIpZ52XSRNhrZreWzkAG/KtWo/g==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
	by cvs.openbsd.org (OpenSMTPD) with ESMTP id 4b91908f;
	Tue, 14 May 2024 18:57:12 -0600 (MDT)
From: "Theo de Raadt" <deraadt@openbsd.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Matthew Wilcox <willy@infradead.org>,
    Jonathan Corbet <corbet@lwn.net>,
    Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org,
    keescook@chromium.org, jannh@google.com, sroettger@google.com,
    gregkh@linuxfoundation.org, usama.anjum@collabora.com,
    Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
    rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
    groeck@chromium.org, linux-kernel@vger.kernel.org,
    linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
    pedro.falcato@gmail.com, dave.hansen@intel.com,
    linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
In-reply-to: <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org> <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org> <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Tue, 14 May 2024 17:43:47 -0700."
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28994.1715734632.1@cvs.openbsd.org>
Date: Tue, 14 May 2024 18:57:12 -0600
Message-ID: <16982.1715734632@cvs.openbsd.org>

> > I worry that the non-atomicity will one day be used by an attacker.
> 
> Blah blah blah. That's a made-up scare tactic if I ever heard one.
> It's unworthy of you.

Let's wait and see.

(Linus, don't be a jerk)




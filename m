Return-Path: <linux-kselftest+bounces-16917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1A2967D43
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93F32818FF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B3F9F8;
	Mon,  2 Sep 2024 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Uesik63H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511515E97;
	Mon,  2 Sep 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240036; cv=none; b=d0VLHqVkBDddnY/FIqWHsXz82NacER/sZdyWqgaZZ2z0ssXtD6bRzbhaRXclI8CHyAF1LhmZegbmQnUDoW8NTH2A7KgNxaEDJSlIeL/VMUuMIBgQsqZS+b+pGN38XpfR2F4ojTZgHRNT+qlHamPsHRBhLgfZZ0cfV9TGo5ZcVAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240036; c=relaxed/simple;
	bh=uG/xXCVOKjY0KM5DAbPkcSmJlXYAF9BrMu1xiOZ8kwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLgbam05gUOBlc7N1nladIZ9Qpcg6KsJC+8k7RGtJ8Yjh7Ldnu4/gO5BEuEFtlLhu25LA+DhxSML4WgWZPcyk/eJfZDGRSYj1dwdSRcSmEi8ybOwtsYP/ClrfLvb4qK5crwJ7c3kAzsQN+4CU+ndqlq4WQNiTRdc21PNWpO5b10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Uesik63H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D45C4CEC3;
	Mon,  2 Sep 2024 01:20:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Uesik63H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725240034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5l743c4I7GdnoeSRRi8sYZLmE7SZs2043vDOhLDuRU=;
	b=Uesik63HTiOhqO5Sn7oJWQ5z50ypFw7kd7XIqDXPU6rIv7aF77u4glqc1IOD1s78fiDEfC
	/Yo4ZxYDnSJfPMqvjREuL2xNJdfKnfhViUv+uWf5PUNc4S+ZGgrNJwVxR89/flQOMlY9JB
	BtH+eYmar7hq9EISCKoePXGjxLAf57s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eafaafb5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 01:20:32 +0000 (UTC)
Date: Mon, 2 Sep 2024 03:20:29 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>, broonie@kernel.org
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ZtUS3TecFTjE5A94@zx2c4.com>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>
 <ZtSsTkTUCGyxaN_d@zx2c4.com>
 <efca582d-20e9-4871-bcd8-5abcdb0c22f3@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efca582d-20e9-4871-bcd8-5abcdb0c22f3@csgroup.eu>

On Sun, Sep 01, 2024 at 08:43:10PM +0200, Christophe Leroy wrote:
> >> How would this fit in the logic where IIUC you just remove '_64' from
> >> 'x86_64' to get 'x86'
> > 
> > Huh? That's not what tools/scripts/Makefile.arch does.
> 
> Hum ... yes sorry I looked at it too quickly and mixed things up with 
> the other patch.
> 
> Nevertheless, if I understand well what tools/scripts/Makefile.arch does 
> on an x86_64 for instance:
> 
> uname -m returns x86_64
> HOSTARCH = x86 (sed -e s/x86_64/x86)
> ARCH = x86
> SRCARCH = x86
> 
> If you build with make ARCH=x86_64,
> SRCARCH = x86
> 
> So I still can't see how you can use that to know if it is a x86_64 or not.

By the use of CONFIG_X86_32, which is also used elsewhere in that
samme makefile for something else (so I assume it's wired up in the
context where it counts, and if not, that's a bug that affects both
spots and should be fixed)..


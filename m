Return-Path: <linux-kselftest+bounces-16911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440B6967BA0
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 20:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7531F218D8
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0E18306C;
	Sun,  1 Sep 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jB7W3KBN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E2183CA5;
	Sun,  1 Sep 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213782; cv=none; b=aQJoSEvT0p/UiDqL+8hCdlBI1ymiB7ejgjGpmPx3PelvHlamVnenSn+uf/96awYokbVm+loYuTScS18JXit61NUlYXTghuTSHg2p9wC1culCSa2DS4YNuw5eQA8sHereKoVDhvV3I9QrySM8mr5tFxr6Gneqzc0rCaW1ikQLNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213782; c=relaxed/simple;
	bh=hO1wExzhmBwqxqbuHDxVyMhMAXda+Y3e58KyFuDMheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T76h4nS/zx2AhJe12+AUle+gmAO+UOkiByMtkyrjCjcdZO6fd3tJbToWh1aSjCEExxdMqlSZhoJQAzOuq6flzAGKbqLT9fNNryl52nFfejeD3WfNRi4BkYGKR7rF1zANTZoRpQkAFvGwaX6nzm5Ha51tAbvKy9G5+leiPn5UIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jB7W3KBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D180C4CEC3;
	Sun,  1 Sep 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jB7W3KBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725213778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy7ET87sbWun3jDsXZxlhIDhdifK/ohyR5N1hUzew60=;
	b=jB7W3KBNxuLuGWJOIH1TfZW0u0d45F/N1GQXTpiO4ktT4bJQgYPiP3n2KKHORr9/t7+uAe
	C8iX4ACp9m6z1Q/VsGA+eUYG7suGn7maxbI8HBGDHVXrWec86ej9lvWkj4qZCm328cppOn
	sNbnoBZXrIyL3DVX9apx2Zh9o/Zd9p8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7ee1bc57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 1 Sep 2024 18:02:57 +0000 (UTC)
Date: Sun, 1 Sep 2024 20:02:54 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>, broonie@kernel.org
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
Message-ID: <ZtSsTkTUCGyxaN_d@zx2c4.com>
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
 <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <667622ae-dde5-410f-a9f8-4801788af278@csgroup.eu>

On Sun, Sep 01, 2024 at 08:00:30PM +0200, Christophe Leroy wrote:
> Hi Jason,
> 
> Le 01/09/2024 à 15:22, Jason A. Donenfeld a écrit :
> > Hi Christophe,
> > 
> > Hmm, I'm not so sure I like this very much. I think it's important for
> > these tests to fail when an arch tries to hook up the function to the
> > vDSO, but it's still not exported for some reason. This also regresses
> > the ARCH=x86_64 vs ARCH=x86 thing, which SRCARCH fixes.
> > 
> > What about, instead, something like below, replacing the other commit?
> 
> I need to look at it in more details and perfom a test, but after first 
> look I can't figure out how it would work.
> 
> When I build selftests,
> 
> to build 32 bits selftests I do:
> 
> 	make ARCH=powerpc CROSS_COMPILE=ppc-linux-
> 
> to build a 64 bits BE selftests I do:
> 
> 	make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-
> 
> to build a 64 bits LE selftests I do:
> 
> 	make ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-
> 
> 
> I addition, in case someone does the build on a native platform directly,
> 
> On 32 bits, uname -m returns 'ppc'
> On 64 bits, uname -m returns 'ppc64'
> On 64 bits little endian, uname -m returns 'ppc64le'
> 
> How would this fit in the logic where IIUC you just remove '_64' from 
> 'x86_64' to get 'x86'

Huh? That's not what tools/scripts/Makefile.arch does.


Return-Path: <linux-kselftest+bounces-16967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A77A968766
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8564CB22C41
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC213B58D;
	Mon,  2 Sep 2024 12:22:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946019E97D;
	Mon,  2 Sep 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279762; cv=none; b=kx3a4qFr0sTwcnd0AYm2mrUt5lx3KAr8/sz5ESP70zDEefZRhCzweiJWtqj1L3iLv/X/CJYixZlE4WfoRjrwF0pHDwpccNyIHjPDs+wD2bcFUeGtpuQuxjYDUyk/Irl/aLZzkgFLLQsS0cFBFpXp9kLBmauKQNXiwwx/7e04u3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279762; c=relaxed/simple;
	bh=YsAMVZFCaYtNn+OZ+erqnA/SlogGVqbiIM+xgOJ28kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu7k7ciuoClt6+dUQUsdaeUVBhJSbjWmaU6EXeisXUdJR2K/tHfkFGFal6RmRKxJew1ltduwERGduIs/t9LJj0BUhpuYUyqNGyV5Q4QGFW7Akg+SNJchNZfzL2M6UjkM40ed/1rr0gpbgb5alpilv1mlCpcWsmwx161UVvI7Ydw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy7Dv31Zjz9sSN;
	Mon,  2 Sep 2024 14:22:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c3MsuolDjQjZ; Mon,  2 Sep 2024 14:22:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy7Dv2D9Pz9sS7;
	Mon,  2 Sep 2024 14:22:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 358C58B76C;
	Mon,  2 Sep 2024 14:22:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id x0RjPMtErDM0; Mon,  2 Sep 2024 14:22:39 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D92528B763;
	Mon,  2 Sep 2024 14:22:38 +0200 (CEST)
Message-ID: <fe8ea6a6-71d7-4cfc-b20b-fa0a7f39a4be@csgroup.eu>
Date: Mon, 2 Sep 2024 14:22:38 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: vDSO: Do not rely on $ARCH for
 vdso_test_getrandom && vdso_test_chacha
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>, broonie@kernel.org
References: <ddf594c81787dba708fc392cb03027470dee64fb.1725124064.git.christophe.leroy@csgroup.eu>
 <ZtRqp-uZe5C07qOF@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtRqp-uZe5C07qOF@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

Le 01/09/2024 à 15:22, Jason A. Donenfeld a écrit :
> Hi Christophe,
> 
> Hmm, I'm not so sure I like this very much. I think it's important for
> these tests to fail when an arch tries to hook up the function to the
> vDSO, but it's still not exported for some reason. This also regresses
> the ARCH=x86_64 vs ARCH=x86 thing, which SRCARCH fixes.
> 
If we take the exemple of getcpu:

Only powerpc and s390 implement __kernel_getcpu.
Until recently, it was implemented on ppc64 but not on ppc32

Only loongarch, riscv and x86 implement __vdso_getcpu.

Nevertheless, vdso_test_getcpu is always builts, regardless of the 
architecture.

When vdso_test_getcpu doesn't find the vDSO entry point, it prints an 
error text and returns KSFT_SKIP


I thought it would be more correct to have the same behaviour on 
vdso_test_getrandom instead of trying to build it only when the 
underlying kernel supports it.

Christophe


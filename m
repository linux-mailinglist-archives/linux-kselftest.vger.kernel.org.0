Return-Path: <linux-kselftest+bounces-21594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162179C002D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 09:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474561C215E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBDE19F120;
	Thu,  7 Nov 2024 08:40:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9AC2ED;
	Thu,  7 Nov 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968850; cv=none; b=rc3wDV/1YmCbS3zIXcjXb+Q6IChZII4Vv0Yh4IokZ81vvcG+0ARKRpxAkvDuZx7QbRqU9DzbB7WNPBN+hihTHAyreRxoa83rcLrAJPdxINTUU4pwBHfAqYunCfmhqRIDL6TLxT4ZxDemKd++YrOOblOvNhO+FCPuxnRU/16OmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968850; c=relaxed/simple;
	bh=dfX6ZtwUHZN8F9lm+8DQLv5vlRp02eAi52yaIi5m5zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et37zySH4H5asS7qaljPVQyY1MFC0z7OPbwPfq08Y1KfYvSQjcPXSNECxXkMJrVEdewTge96Jq6u9HdVLdpQlNd6bXvAPgGPJjA771iQpoBRpSOfwNGuT2gcP7CeWNGzQx08TUmbRv/J4A3274yuW9uToQrB0vOg6vzeFyDBGoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XkbBQ54sGz9sSK;
	Thu,  7 Nov 2024 09:40:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JflxZQI1qNZ1; Thu,  7 Nov 2024 09:40:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XkbBM039Wz9sSL;
	Thu,  7 Nov 2024 09:40:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E5BA28B77B;
	Thu,  7 Nov 2024 09:40:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id v5yKCZ6xmeMy; Thu,  7 Nov 2024 09:40:42 +0100 (CET)
Received: from [192.168.232.148] (unknown [192.168.232.148])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AC908B77A;
	Thu,  7 Nov 2024 09:40:42 +0100 (CET)
Message-ID: <1a97751d-7e41-4b1b-84e8-3e1bd6aaef58@csgroup.eu>
Date: Thu, 7 Nov 2024 09:40:41 +0100
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


I was surprised today to discover that you finaly pushed something more 
or less similar. Did you change your mind ?

Christophe


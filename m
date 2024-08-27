Return-Path: <linux-kselftest+bounces-16411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD4960EB1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D41B25127
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C01C68A5;
	Tue, 27 Aug 2024 14:51:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A471C6888;
	Tue, 27 Aug 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770263; cv=none; b=qkazVSvAYtOCvNFgtAWHhb5i/kUEk7riG+Haba/wBMThbE7YOPiwFj6jGqqqKtPGQ/r0w7Uxd7f64F6RwouASGecW7T2ujBNqBUCi8Otr9/LiptY2lFKH5QBSOqfxPk8JQKK921wWNLz3EYmXd6NoR5uncgQwa1kcSfmC7/F1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770263; c=relaxed/simple;
	bh=LMnQZ09B2wmWN2tsj/qFaCW0lMgh4uzjXdseaNcIGJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oA///HUqswjii/cjNSladYdsVLCyEWZVj0h2n3hx8BEqL0ilmCgu7J9uCZXj+t35NmX3OYQXr9r4kHDXfQSEXnal7tVbO/Zb9tPQJ1TRDr0G8IeO6tQBXJp9k/S/9wqA6bF3DlnYJkWRZlM5dciYP+Ufxf/5DEPg59e9bcqsYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtVpr1YR6z9sPd;
	Tue, 27 Aug 2024 16:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hc4Dmp0-Z5yB; Tue, 27 Aug 2024 16:51:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtVpr0m1vz9rvV;
	Tue, 27 Aug 2024 16:51:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 091BD8B78B;
	Tue, 27 Aug 2024 16:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id viCXyMDG0jFf; Tue, 27 Aug 2024 16:50:59 +0200 (CEST)
Received: from [192.168.233.149] (unknown [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AD8E8B77C;
	Tue, 27 Aug 2024 16:50:59 +0200 (CEST)
Message-ID: <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
Date: Tue, 27 Aug 2024 16:50:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
To: Xi Ruoyao <xry111@xry111.site>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 Jinyang He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Arnd Bergmann <arnd@arndb.de>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site> <Zs3blfx1inX_FQLR@zx2c4.com>
 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
 <Zs3fhiSlXg2aCGa8@zx2c4.com>
 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/08/2024 à 16:41, Xi Ruoyao a écrit :
> On Tue, 2024-08-27 at 16:15 +0200, Jason A. Donenfeld wrote:
> 
> /* snip */
> 
>> gcc -std=gnu99 -D_GNU_SOURCE= -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../tools/include -isystem /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include    vdso_test_getrandom.c parse_vdso.c  -o /home/zx2c4/Projects/random-linux/tools/testing/selftests/vDSO/vdso_test_getrandom
>> vdso_test_getrandom.c:43:41: error: field ‘params’ has incomplete type
>>     43 |         struct vgetrandom_opaque_params params;
>>        |                                         ^~~~~~
>>
>> $ ls /home/zx2c4/Projects/random-linux/tools/testing/selftests/../../../usr/include
>> headers_check.pl  Makefile
>>
>> Since I don't build in there, this directory is empty.
> 
> In the toplevel Makefile:
> 
> kselftest-%: headers FORCE
>      $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> 
> So running "make kselftest-all" to build the self tests should have
> already caused make to build the "headers" target, which puts the
> headers into usr/include.
> 
> I don't think it's supported to build self tests w/o invoking the
> toplevel Makefile: many other self tests use KHDR_INCLUDES as well, so
> generally building with something like "make -C tools/testing/selftests"
> just won't work.
> 

My usr/include/ is also empty (only Makefile and headers_check.pl) and 
building directly in tools/testing/selftests/vDSO works for me.

The command is:

ppc-linux-gcc -std=gnu99 -D_GNU_SOURCE= -isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../tools/include 
-isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi 
    vdso_test_getrandom.c parse_vdso.c  -o 
/home/chleroy/linux-powerpc/tools/testing/selftests/vDSO/vdso_test_getrandom

I believe I get the needed headers through : -isystem 
/home/chleroy/linux-powerpc/tools/testing/selftests/../../../include/uapi

Christophe

PS: By the way, did you see the -DBULID_VDSO for the chacha test ? Don't 
know the impact though ....


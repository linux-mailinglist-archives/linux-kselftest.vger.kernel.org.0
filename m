Return-Path: <linux-kselftest+bounces-42176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17961B999BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 13:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1C64A084D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B82FD7C3;
	Wed, 24 Sep 2025 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QlOkXOk3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9aYLxaYQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE512FDC4B;
	Wed, 24 Sep 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713752; cv=none; b=k8vEDNqOo+dtn1ehHPqqZBbb+IlCkM57fSOeBfuYqudq1ov5+7fzQqUauTnlwRGTndua9g6pOanVQWFA37RZL7TdlH2O5WJSeF3NLb9Nnn7SnklwFutkG1NkRTx432XNSJZSp8IZQij56043Ab9n5lD1Kr8M6Qis76/E7kQNPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713752; c=relaxed/simple;
	bh=0JGoQ4hmCfZ/TkMkG/taAm55rt5AIxt1SS2NLziKhmk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BD6nIUOxE/1Bpo2FXc1RWtXvV9SnAdDc5tfnpGhAmzzBLTaAORJoouyXF9m5IKQ+K3tY669T3vLRDqxSthqmZd3zMLZOytVczCISiTrR3d1/13H8FIXUbD9CASPDpFXK8+Cq1EL86QUjsGUZMfiZrziTOscNI7LXXtYrtL9Kdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QlOkXOk3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9aYLxaYQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Sep 2025 13:35:22 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758713743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JGoQ4hmCfZ/TkMkG/taAm55rt5AIxt1SS2NLziKhmk=;
	b=QlOkXOk3wDqFbbFYZsEnlgMHERzf96yJYS0jGCAx8XL84tsLn5ka3PYxS3tS6fRiz4EdFp
	hMUyAsiUILtR8JSw3OgT3Fy0mtO9V6+vyErIQ7UEqbgWogA4ThP02dZ7nQf1bcNUN6oc1E
	qIS9/nd74dV5DEbbsNthzLIIe0mNg8fHArZw72OWjj0HJx2y/wJcXKWq9tADPKUcw2oCa1
	MNgG8SaKpMW/kXFfHB3IGyN4KRzzDdYS8yZwV4AN2CdSs8O+lduKmgKTYpZGvoSsWu5yzJ
	vn9hc+ve1LqLnCQYSUPrJ8WxAuF+cXnlxVYaeRwKdflbaBdk98XsHYzpLwzheQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758713743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JGoQ4hmCfZ/TkMkG/taAm55rt5AIxt1SS2NLziKhmk=;
	b=9aYLxaYQfRDX5WwG1TPEXNPpaVf2pDqro4TeNjcbtq5rkULq+SlNuIn8W8JezYqbHJuTiS
	grPgu4XhzSRIaIAw==
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Message-ID: <c5e28d44-3480-4e28-aff0-5c5cfd1b0632@linutronix.de>
In-Reply-To: <ec0894011cb4403f45ad8b30095cc333edc1e5e6.camel@physik.fu-berlin.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de> <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de> <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de> <60a0af09cc1a5de3b33b9606ed07ae91b42c5432.camel@physik.fu-berlin.de> <bea9cc5c-7fc6-4c87-ab78-8232b2bee4dc@linutronix.de> <ec0894011cb4403f45ad8b30095cc333edc1e5e6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 00/36] sparc64: vdso: Switch to the generic vDSO
 library
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c5e28d44-3480-4e28-aff0-5c5cfd1b0632@linutronix.de>

Sep 24, 2025 10:29:00 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.=
de>:

> Hi,
>
> On Wed, 2025-09-24 at 10:07 +0200, Thomas Wei=C3=9Fschuh wrote:
>> Sep 24, 2025 09:40:47 John Paul Adrian Glaubitz <glaubitz@physik.fu-berl=
in.de>:
>>
>>> Hi Thomas,
>>>
>>> On Sat, 2025-09-20 at 16:37 +0200, Thomas Wei=C3=9Fschuh wrote:
>>>>> Could you share a version of the series based on top of 6.17.0-rcN fo=
r
>>>>> testing purposes? I would like to test the series on a Sun Netra 240
>>>>> which is based on the UltraSPARC IIIi.
>>>>
>>>> Here is the git branch based on rc4:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linu=
x.git/log/?h=3Db4/vdso-sparc64-generic-2
>>>>
>>>> Does that work for you?
>>>
>>> I'm getting merge conflicts with "vdso/datastore: Allocate data pages d=
ynamically" and
>>> "vdso/datapage: Remove inclusion of gettimeofday.h".
>>>
>>> Can these be skipped?
>>
>> No, these are important.
>>
>> What are you trying to merge?
>> I can probably give you a merge.
>
> I'm using v6.17-rc7 plus all SPARC fixes in Andreas Larsson's linux-sparc=
 for-next branch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git/=
log/?h=3Dfor-next

This merged cleanly for me:
https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git=
/log/?h=3Dvdso-sparc64-merge


(Only compile-tested)


Thomas


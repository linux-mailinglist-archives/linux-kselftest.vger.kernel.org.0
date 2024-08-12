Return-Path: <linux-kselftest+bounces-15166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBA94F5CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 19:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F7E1C211C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3B4188CB2;
	Mon, 12 Aug 2024 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="G9zG2Ark"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84691804F;
	Mon, 12 Aug 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483676; cv=none; b=oPkQpu7W5+l/PWhZuAuhD0mtkgPPFJowtHyhHl/KUAXxn3OQ90wZps22SfM12FnYOBdbIalL986g1VNOF0r7ilhOXmfo3A44tNZap0LneXcPmTY8cOIsd5I2Wbf4g1hpFIDsK3OXpOsLy+RGMVBz+HBSoOAcHw+bZxNgNk8sL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483676; c=relaxed/simple;
	bh=IFMxJ0Br/sftBPuPaohb/P6aDtKUf9rUY46d2ecUm0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJyoOtlToqRAPZWuTvBNyps+tHzGRwJ9HijKVqNHXVK0wLOxDsCNatRJWYLfoFi3MQWDr4MjaWL9/gteIECKuNgR2G6hR3uL4xri79Cpw85xWyy+gHME3oZZwhWWloswZ1gpxy0r6eENfH5p6nPuoOPVYmmGJ2iwgYZnOIB+ZHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=G9zG2Ark; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=IFMxJ0Br/sftBPuPaohb/P6aDtKUf9rUY46d2ecUm0M=; b=G9zG2ArkCRinNETyPwuh+2xCOJ
	iDgDhrFoVtcvIrsQ5r6F28AViF6ENkdbgVlZS6crklmsR8Bmq8r7CbJ3JVrkQYU9TP1HCPWrdDQ1F
	yZ+5NLJr0OFq6Ja+pfu/X8WLHV/Pdx+4tT0EeyAm7dsjNwsHczh5SaTogf30Nm70iA7Lw8WEUtVHm
	a2ljf+HFcN/9LH139tpUE37YNiSPr8kSmW1UV+aRJEzT1Tt0qNQDC4LwrHs5oiQ0p+9QyVuU6Bgmw
	2yoO7J17rQT6ddUa3XxoCOt78JkFEWf8bEE6tvJlLRNL7YJlCj70d4AiGUxAQF8Br2DOU+aXmKuU0
	xlbRlNOw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1sdYYG-008ulR-0n;
	Mon, 12 Aug 2024 12:09:48 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>, wine-devel@winehq.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Elizabeth Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH v5 00/28] NT synchronization primitive driver
Date: Mon, 12 Aug 2024 12:09:48 -0500
Message-ID: <5805970.DvuYhMxLoT@camazotz>
In-Reply-To: <2325658.ElGaqSPkdT@uriel>
References:
 <20240519202454.1192826-1-zfigura@codeweavers.com> <2325658.ElGaqSPkdT@uriel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, 10 June 2024 11:58:48 CDT Elizabeth Figura wrote:
> On Sunday, May 19, 2024 3:24:26=E2=80=AFPM CDT Elizabeth Figura wrote:
> > This patch series implements a new char misc driver, /dev/ntsync, which=
 is
> > used to implement Windows NT synchronization primitives.
> >=20
> > NT synchronization primitives are unique in that the wait functions bot=
h are
> > vectored, operate on multiple types of object with different behaviour
> > (mutex, semaphore, event), and affect the state of the objects they wait
> > on. This model is not compatible with existing kernel synchronization
> > objects or interfaces, and therefore the ntsync driver implements its o=
wn
> > wait queues and locking.
> >=20
> > This patch series is rebased against the "char-misc-next" branch of
> > gregkh/char-misc.git.
>=20
> Hi Peter,
>=20
> Sorry to bother, but now that the Linux merge window is closed could I
> request a review of this revision of the ntsync patch set, please (or a
> review from another locking maintainer)?
>=20
> I believe I've addressed all of the comments from the last review,
> except those which would have changed the existing userspace API
> (although since the driver isn't really functional yet, maybe this
> would have been fine to do anyway?)

Hi,

Gentle ping on this=E2=80=94this series still needs another review.

If I should go ahead and make "breaking" API changes based on the last
review, please let me know.

Thanks,
Zeb




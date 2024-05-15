Return-Path: <linux-kselftest+bounces-10269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16888C6F35
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF61F21CDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 23:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EBD4F8BC;
	Wed, 15 May 2024 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="aZJnNRCo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A564D5A5;
	Wed, 15 May 2024 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815962; cv=none; b=f1NawSIY0TUBux0MGXBqY122a/RvGUS6u9XdFIoXx13JDqWGXxei5Zm/aW4FmCTLoxKkqPaalGYpogJZKRahmPeMQG7G71w6Z8AREgGUNKRpUTkovJHZoV2RYc6Uhddjtjnx2yV9TfG5drzy8Ls3NSztxvVxszxlepdi3DWTG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815962; c=relaxed/simple;
	bh=kNIfUSqmELR44cA1YYeUiPS/oNMg9kNiAuiUGNZMCbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c89AswlQlD3v7U6MRgRj5+dRJBUiz6ueEWH6B3eRi4VBHl6sfFe9csPvR76H59PvbxQ5buC14rkFcqbpYU2zSB28ypQPWyBb8MtHVAJ4IXE36478oDZa8VZp5nJi0L3fkO9z9P5WAsArtACU1oEdrgXubPMH5/apWCQxhBgVBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=aZJnNRCo; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=kNIfUSqmELR44cA1YYeUiPS/oNMg9kNiAuiUGNZMCbI=; b=aZJnNRCoU4VdBtKnFF2KaV3kkk
	H/MnU0t8TpOaClSFgLOcARfnRydTZRKZF4lEySoZF5MdxuK3dCAuZnhauaBUw/EgTy1cuxJTXWps9
	gTnZhGETkt32V4J+P9tOsZoRWrL7ui4X8jCrqFoAV2L/r4N/kJ0deokolHOw4Ly6aiE+jnW9QyFiW
	h39hO6ClKz8UCmoeAUwLyVfjNWdqx7kziiVEn+FBD2WmLVqcCYXDGuUChuaawgovf9fifN2qydGDx
	GudVNON6odyAwWU/UppZkPacdf3qJ6/9hqsaNoPPQnaRJYhqWZsNv96w13xRkLbIkfupCDCsZyC7o
	S9uZ6e9A==;
Received: from [10.69.139.9] (helo=watership.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s7O6n-005nPN-1T;
	Wed, 15 May 2024 18:32:29 -0500
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
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Wed, 15 May 2024 18:32:26 -0500
Message-ID: <2322852.ElGaqSPkdT@watership>
In-Reply-To: <1790266.VLH7GnMWUR@camazotz>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240417100132.GK30852@noisy.programming.kicks-ass.net>
 <1790266.VLH7GnMWUR@camazotz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, April 17, 2024 3:02:13=E2=80=AFPM CDT Elizabeth Figura wrote:
> > > Except for the "unowned" semantics of zero, the actual value of the
> > > owner identifier is not interpreted by the ntsync driver at all. The
> > > intended use is to store a thread identifier; however, the ntsync
> > > driver does not actually validate that a calling thread provides
> > > consistent or unique identifiers.
> >=20
> > Why not verify it? Seems simple enough to put in a TID check, esp. if NT
> > mandates the same.
>=20
> I mostly figured it'd be simplest to leave the driver completely
> agnostic, but I don't think there's any reason we can't use the real
> TID for most calls.

While trying to implement this I did realize a reason: if a Linux thread di=
es=20
and a new Wine thread is created which happens to have the same Linux TID=20
*before* Wine notices the thread death, that thread's TID will be conflated=
=20
with the thread that died. I don't think we can guarantee that we notice=20
thread death before we notice a request to create a new Wine thread.

Using Wine-managed TIDs avoids this by virtue of ensuring that a Wine TID i=
s=20
not reused until the associated Wine thread has been cleaned up.




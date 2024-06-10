Return-Path: <linux-kselftest+bounces-11583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB7902793
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EA91C21487
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9314532E;
	Mon, 10 Jun 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="DnX772Ec"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC477F2F;
	Mon, 10 Jun 2024 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039723; cv=none; b=YsXSXwMCxLfx2Y8zpyk36QUC6XDWx6WXY+dd2KnbeNV0vGvVNjzlEQOhinfgOTJpbas9V5u0I6HH2YJXXJi9ME9QNr4MXgVZIG3JYpQoFImWOgiiMzTe1T1t8ors7drKkGIEd+wDaIoHLV0hmejXtpq46j6ezHNfvATgyZo34Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039723; c=relaxed/simple;
	bh=tZhK0yK9PUCBDyPTcAJrUy48YWTdR49HUbCN3uazuz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKMkTotGI9/l59H10SOz1UZ94xrFdxIR3wSgDF4Pu+b2nELB1vyKdgKyy8KKdEZhkFjTu9KJNLae0gXQ5PeK7VImHpmeNF/M4OqVdk+ug0bPLXnfyPXnAV1E0sTwfiE18nHTCCvT6Ni+/5ENB44TKZ4Kcuyy4u3iF5QDdd2iG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=DnX772Ec; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=tZhK0yK9PUCBDyPTcAJrUy48YWTdR49HUbCN3uazuz0=; b=DnX772Ecy7Sytu4dDSC25WhQIM
	p5J1nPDMk23g5W9HIGqwfixQXSHf83CTiGTFcbIG2EtOfYpF1nbnMN4YIecI9884NVGDBMKen38lx
	H5A17OKO6ibWhAVY6DtoBGmmJe3P2sjGNsycECNyftwTeT74mFPKtsqkRDQ5H7m6GxIOHmcNDK8xB
	f/ZPLptOxLwz897jhfiz716tUV14MPVge41NhrFJYrM3savy+WZ+fBG1fn2KHLi2FDuyp7Ht2MrjI
	faduXUalJ6gir2AtcAqDE1HZu5VMSRtquUGHVqLX2x+lr7mZNrNiWJLrOzYvHJvZDHBgKyJ8MSvz5
	6BNpqxqA==;
Received: from [10.69.139.13] (helo=uriel.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1sGiM6-00H4i2-0f;
	Mon, 10 Jun 2024 11:58:50 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v5 00/28] NT synchronization primitive driver
Date: Mon, 10 Jun 2024 11:58:48 -0500
Message-ID: <2325658.ElGaqSPkdT@uriel>
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, May 19, 2024 3:24:26=E2=80=AFPM CDT Elizabeth Figura wrote:
> This patch series implements a new char misc driver, /dev/ntsync, which is
> used to implement Windows NT synchronization primitives.
>=20
> NT synchronization primitives are unique in that the wait functions both =
are
> vectored, operate on multiple types of object with different behaviour
> (mutex, semaphore, event), and affect the state of the objects they wait
> on. This model is not compatible with existing kernel synchronization
> objects or interfaces, and therefore the ntsync driver implements its own
> wait queues and locking.
>=20
> This patch series is rebased against the "char-misc-next" branch of
> gregkh/char-misc.git.

Hi Peter,

Sorry to bother, but now that the Linux merge window is closed could I
request a review of this revision of the ntsync patch set, please (or a
review from another locking maintainer)?

I believe I've addressed all of the comments from the last review,
except those which would have changed the existing userspace API
(although since the driver isn't really functional yet, maybe this
would have been fine to do anyway?)

Thanks,
Zeb




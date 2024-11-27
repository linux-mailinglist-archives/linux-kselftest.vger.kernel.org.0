Return-Path: <linux-kselftest+bounces-22564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F3B9DA707
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F172A165AFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FA1F9407;
	Wed, 27 Nov 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="D4yjdhy2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736761D9A41;
	Wed, 27 Nov 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707912; cv=none; b=FB/kMn+PoUQr4Eu5T+yWA64sC6SBuvBmZuLdSBJmw8Ahv7UAQFSppm8H4gZbXwWycbL/Z1bIOAscZBcpPwO+g5Qr0zwj609wNu+ypJbr2AcrI/4D0NhZ9FoJtMIz09WghUNru6LC2SymWo4KUc+FHHf4hrp2nUK0Eb2qoNnHUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707912; c=relaxed/simple;
	bh=mwUGhylsbgUqMhXih+Jds98x6S16t8YQHtQ6OIWiib0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ax0J373L7x0RKeKZBQoeuQoFetVkzDDx8XBsGph5p15rmPLJ4W0L0UfTDGQ4EYZrWdJu/MJI/B/hM4oa2h8k+0mIV8wgIeMTwuEOv+Iao1ukPd14UoXr6lDoTHVFUZb9ttxvxq/PdksEXaLn81440o7RiAlnIUwdWtRsP0xS21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=D4yjdhy2; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1732707903;
	bh=mwUGhylsbgUqMhXih+Jds98x6S16t8YQHtQ6OIWiib0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D4yjdhy29+8MtpalfJZuwK8SIvdX7rN+pn4eKp6zbRoehqJxSpRM680qj4Lz30Fs6
	 sp7/apFiKQhf+jDWy5IaE/Aih0rYmvgrFyxxHECxd11tnRWnFEyYYBWWOtSxZ23ikU
	 9fE7YE6uWa2hZW9Fj754prN+YHIkxCGvCBHVbp7M=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D45BC66AFC;
	Wed, 27 Nov 2024 06:45:01 -0500 (EST)
Message-ID: <c828b254fb93bd136b36d3a06ab1d9d29ce13d88.camel@xry111.site>
Subject: Re: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
From: Xi Ruoyao <xry111@xry111.site>
To: Shuah Khan <skhan@linuxfoundation.org>, Fangrui Song <i@maskray.me>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Wed, 27 Nov 2024 19:44:59 +0800
In-Reply-To: <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
References: <20240915064944.2044066-1-maskray@google.com>
	 <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-19 at 09:37 -0600, Shuah Khan wrote:
> On 9/15/24 00:49, Fangrui Song wrote:
> > glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
> > obsoleted for more than one decade in many Linux distributions.
> >=20
> > Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
> >=20
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Tested-by: Xi Ruoyao <xry111@xry111.site>
> > --
> > Changes from v1:
> > * fix style of a multi-line comment. ignore false positive suggestions =
from checkpath.pl: `ELF(Word) *`
> > ---
> > =C2=A0 tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++=
------
> > =C2=A0 1 file changed, 79 insertions(+), 26 deletions(-)
> >=20
>=20
> Quick note that this will be picked up after the merge window closes.

Hi Shuah,

The patch seems forgotten.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University


Return-Path: <linux-kselftest+bounces-37219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C803AB032D8
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C613B4A41
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 20:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2C1F16B;
	Sun, 13 Jul 2025 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pWk9cFuL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D71323D;
	Sun, 13 Jul 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752437533; cv=none; b=dT50U/3EYfExPIukVfv81zaOEILOs1e5K6TRFxZfYjfQLSQJ9kyZPhGowR2uzbNJ5xMR2pd1kvNU9udNkKnXHX9EFhnEwyoFPcxbc9uxsZb418ByfmwRYjGZWvqx5ehspEoTudEe1NohHuNyhBX4zJlLylKZhr+iTjHLMrrHZmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752437533; c=relaxed/simple;
	bh=UPEeRwp7HNBOhn9BFsaE/kSjzfY1EoisYzLppy2g/V8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k70jA1uSA+ykkcxUMFIVXTWvi9p87UivhxPevYOaNJpCoM0OXuTzVXlDoFW+r/fBctJVynhtTDquTOo9g2NKiZiKOx1ZKbXkt+VHW+loHkmaMi+d2GZXOCj9t8XRNg7NhTdKcuDOUH9bX5X3TsW+vOVSUNUMvsfX2UUPyKqGOB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pWk9cFuL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=77MbAHAFRMipMygK9QAjqjhQs/rRI1T3toWg9Mtt2TM=; t=1752437530; x=1753042330; 
	b=pWk9cFuLQVmS57/LdI6xh9EnB93Neb+cYtax5RhE+xiXOK3/8ehZPkyXS9n5lWg8mRrEVgyOlyq
	VrwETwos0a9gitfNHRih0Hye6PdDALIY8lYIDNhCtILRsrtEDr6fIBVRugRcyN6STjQFP9iMH4U0O
	PPOS1SvV6eZcocpO7KLA+qiUoN/z5DJGa8zr+eNFUE6EmwOnLebL9PDwO1kf77VnV67IxC6k1cwfH
	PCq3DZRDbnOGZEMnwxA1p/+bpTUf75/xKd516FzdLFTZWP7Ex5jBSYTCDxtEINoKUgFmAR21yWtn1
	qlRbR8iWJKNeiAm1DEBEyid5BYZCdr2RL6kA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ub33I-0000000148b-3WRd; Sun, 13 Jul 2025 22:12:00 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ub33I-00000000ysF-2WBU; Sun, 13 Jul 2025 22:12:00 +0200
Message-ID: <4d626bbabce733b14a463d5f35733edb9c896876.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] tools/nolibc: add support for Alpha
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Willy
 Tarreau	 <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date: Sun, 13 Jul 2025 22:11:59 +0200
In-Reply-To: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
References: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Sun, 2025-07-13 at 22:08 +0200, Thomas Wei=C3=9Fschuh wrote:
> A straightforward new architecture.

A straight-forward what? ;-) I assume you mean port.

> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Only tested on QEMU so far.
> Testing on real hardware would be very welcome.

I'll test on real hardware next week and report back.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


Return-Path: <linux-kselftest+bounces-41473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E30B574D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CB13A4A34
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3742F3C29;
	Mon, 15 Sep 2025 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mT+NeYvz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1387D2ECEB8;
	Mon, 15 Sep 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928237; cv=none; b=Hl5+9yyQeV0NqrQADH7irk+1OoHDfmAoFtOs3VMOtNcH7GZIJNdxkvO8Fu5BGaXT2xLVz/4wML0rs+IFrCIpd6TJg9McwP2irOp3aQ47GfYxCQh6i1fmPXiP5/uW84Py7bQu75gYgzw4eJitqvy+iWXG7BVjy3QmZQbC4d8bZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928237; c=relaxed/simple;
	bh=ibrtgmyavezo7/rV24wGdikXdfg56Q20YZWEB+mLWa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOq+u1UC9RxXat8VIIpGh1jfeR7MrGSeDnNZaWmdXt15KKP2N3mjldhOc1BZ5R9hhYBbSfbBJkuIa290aax0ecwjfOtK8ToBnz+EPiSTIrHi/svDJP9MEL5VKuIpBNnK9tZDEtdoyxiu/YGcstekZu/0/raqzhuQw2viLXAPpmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mT+NeYvz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757928233;
	bh=ibrtgmyavezo7/rV24wGdikXdfg56Q20YZWEB+mLWa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mT+NeYvznIc4tPG4UG5JHS3hYDS7hbLnIscEPoWCJjLxsLpq8eXISCLHN3iQr6nXq
	 Pmbzaou7G37f3CE3OrHyKvQjDsKQkNSE41iYJidnNRSU8IVII+WXzGW/NydWpEJX6p
	 5II/Cn2fq61/rRvig2tbY5I36tEKVS4FXokWyQHI=
Date: Mon, 15 Sep 2025 11:23:53 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error:
 use of undeclared identifier 'HWCAP_GCS'
Message-ID: <5fe12804-2538-42c5-b5c7-66d36ff947d9@t-8ch.de>
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
 <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
 <965c8d7e-c5f2-4bd8-ab7c-c3116632f015@sirena.org.uk>
 <5e4d9943-3a8d-4281-9007-f49bfc66dc6d@weissschuh.net>
 <b9b8b8cf-4920-4f9d-bcea-bea913058601@weissschuh.net>
 <a1dc9839-ab45-4dd6-9eeb-4bbc35bf8d90@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1dc9839-ab45-4dd6-9eeb-4bbc35bf8d90@sirena.org.uk>

On 2025-09-12 12:14:00+0100, Mark Brown wrote:
> On Fri, Sep 12, 2025 at 01:07:58PM +0200, Thomas Weißschuh wrote:
> 
> > The Makefile does *not* use -nostdinc, so the nolibc program probably finds the toolchain's glibc asm/hwcap.h.
> > There also doesn't seem to be a static arm64 hwcap header in tools/include in the first place.
> > I am still wondering how this works for the other tests.
> 
> make headers_install puts a copy in usr/include, probably we just need
> to include that in the include path.

Naresh, could you test the patch below?
The other custom $(CC) rules in the gcs directory are also not
respecting $(CFLAGS), but I'll leave these for now.

diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index d2f3497a9..1fbbf0ca1 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -14,11 +14,11 @@ LDLIBS+=-lpthread
 include ../../lib.mk

 $(OUTPUT)/basic-gcs: basic-gcs.c
-       $(CC) -g -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
-               -static -include ../../../../include/nolibc/nolibc.h \
+       $(CC) $(CFLAGS) -fno-asynchronous-unwind-tables -fno-ident -s -nostdlib -nostdinc \
+               -static -I../../../../include/nolibc -include ../../../../include/nolibc/nolibc.h \
                -I../../../../../usr/include \
                -std=gnu99 -I../.. -g \
-               -ffreestanding -Wall $^ -o $@ -lgcc
+               -ffreestanding $^ -o $@ -lgcc

 $(OUTPUT)/gcs-stress-thread: gcs-stress-thread.S
        $(CC) -nostdlib $^ -o $@



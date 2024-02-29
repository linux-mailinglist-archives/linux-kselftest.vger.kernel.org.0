Return-Path: <linux-kselftest+bounces-5675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36386D6BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 23:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3927B285555
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B486D52F;
	Thu, 29 Feb 2024 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TdZdV25G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8895025E
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Feb 2024 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245115; cv=none; b=kivRpoET01PJO2RGjD9YcDWs+CEu7wy+OpHsqyfhgEaUe0e69e2s83nQEJZmhn4xA9OCaQdPyTezGXpz/P0qWPh/8+8IC8FRFJcuciRiaRY70XBye1wTeoVDfTmm1DeEzEa+NjeyTAJSZ+VRvUy9rk1PAelcy/zaaDYyQejFJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245115; c=relaxed/simple;
	bh=Fm+QdvzGA9TDYfAFur5QEpo6vt/zoqdLcIjOtfw/IRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=onBP2ULawMWwlJuL49bSYX7ItaQLsoxcxbl500w2Dicz/LzoOt6rYQ4d1B7t2f297KpDzNIlLrXtP937BHDqtk4rX/x5/1MdUWKOQk2b+TWb+dEoWX6jSs7ZxRKafyXUa9k2T3b+m1uhhixexF64kWFOS0Yy6ib6nE7wAo0EX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TdZdV25G; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709245106;
	bh=ZyKv++aJiuu8o2meINckWe/fNHNwmW9QZnQAcfucrtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TdZdV25GOGIxNvmPRgEgVd1/hFZPHZTbM9fynaVKxpY15kAXgMlX25tiZ6g2rwlRm
	 9VZ8zYFiIxHc11oIvW2I0cJLN5RbOA7Zu5K3RCm/lnKtow2mWzX3TB+LwdeyVyjnSE
	 eF1/67guak1yDp2mEgbJcJyfW73iUW2leTkku5PNdv1O/IjXQ7MhM+190bnlvrrHzP
	 TA/cqJibOmeagz3kB/2cwZptOSLHbj6UZJWYDFjoLwPncPxHiarS4ksuxikyZup+ae
	 TjbZ6+0c8DgyYuZPdXsGEzwfV9LgL+EU4qLz9D0olJEknmRodIv0eZZKdcrkWAqedc
	 BDZcIt9zu+xOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tm5GB3z7kz4wc6;
	Fri,  1 Mar 2024 09:18:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sachin Sant <sachinp@linux.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kselftest@vger.kernel.org, tanzhasanwork@gmail.com,
 andy.shevchenko@gmail.com
Subject: Re: [kselftests/powerpc] Primitives test build failure with linux-next
In-Reply-To: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
References: <C11ED986-3959-4C4D-8780-ABD97D5FB0D1@linux.ibm.com>
Date: Fri, 01 Mar 2024 09:18:22 +1100
Message-ID: <87o7bygbip.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sachin Sant <sachinp@linux.ibm.com> writes:
> Powerpc specific selftests (specifically powerpc/primitives) included in linux-next
> tree fails to build with following error
>
> gcc -std=gnu99 -O2 -Wall -Werror -DGIT_VERSION='"next-20240229-0-gf303a3e2bcfb-dirty"' -I/home/sachin/linux-next/tools/testing/selftests/powerpc/include  -I/home/sachin/linux-next/tools/testing/selftests/powerpc/primitives    load_unaligned_zeropad.c ../harness.c  -o /home/sachin/linux-next/tools/testing/selftests/powerpc/primitives/load_unaligned_zeropad
> In file included from load_unaligned_zeropad.c:26:
> word-at-a-time.h:7:10: fatal error: linux/bitops.h: No such file or directory
>     7 | #include <linux/bitops.h>
>       |          ^~~~~~~~~~~~~~~~
> compilation terminated.
>
> The header file in question was last changed by following commit
>
> commit 66a5c40f60f5d88ad8d47ba6a4ba05892853fa1f
>     kernel.h: removed REPEAT_BYTE from kernel.h

Patch below should fix it, can you please confirm?

cheers


From f165de102de33704a54b892b689630bfa9a79132 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 1 Mar 2024 09:16:31 +1100
Subject: [PATCH] Fix word-at-a-time test failure

---
 tools/testing/selftests/powerpc/primitives/linux/bitops.h   | 0
 tools/testing/selftests/powerpc/primitives/linux/wordpart.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/powerpc/primitives/linux/bitops.h
 create mode 120000 tools/testing/selftests/powerpc/primitives/linux/wordpart.h

diff --git a/tools/testing/selftests/powerpc/primitives/linux/bitops.h b/tools/testing/selftests/powerpc/primitives/linux/bitops.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/powerpc/primitives/linux/wordpart.h b/tools/testing/selftests/powerpc/primitives/linux/wordpart.h
new file mode 120000
index 000000000000..4a74d2cbbc9b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/primitives/linux/wordpart.h
@@ -0,0 +1 @@
+../../../../../../include/linux/wordpart.h
\ No newline at end of file
-- 
2.43.0



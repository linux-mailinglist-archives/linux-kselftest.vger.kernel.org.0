Return-Path: <linux-kselftest+bounces-34555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBC0AD35FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 14:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C1A7A2DAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9035290094;
	Tue, 10 Jun 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MApbkGza";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uR929m69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DF28F507;
	Tue, 10 Jun 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558089; cv=none; b=RIrnmzTQP56y992UtEkwvECDWH7jPksZuUXNFxUG9yFKBI+yFSGxjbyLpjM5Xln7bluVulHa11yXZ6hi23nkR8zQi4g5qwuRYxCdO73cKQSd2/dvSHPmrGbnlyQBZFC0BUpA9L6t3SXFXuyU8eWaFpy8odzxbhAk+1xa+9YU/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558089; c=relaxed/simple;
	bh=fuAXOuUm6fFJtBIJC25rC27qpQWeJjXNesUbOsfwxYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1X1+0IGxdegI2z15nwsq2N/TgxQA+IiWpowpJ+yom6zGyTDAoY+3raDKmF/LtQ7SUYSFrQBoZPGP/eu3ZMMgS1qtVXrsZt+3huC2T/w5RJuIS2weDeY7oKnhr5CxfGMdZLfqvfmQ9/RIhSnl/lePdFbsRm4JEnTRdLN3jUg1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MApbkGza; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uR929m69; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Jun 2025 14:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749558085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7XHwyMIvux7mHDycUbcxmSE3NX5d97oyLdcmCQZNOo=;
	b=MApbkGzaNia4rcytfKGi496yLbsnZgNtl8TJ2QJQiZT2yhHV4ip9/Tdl6HM/XPI/i2xatF
	Lcp29FoGPeU3i9dx5NRx5VnhX6RsP/GtnOBpJJS4UsSX5FI7fNQjON9uoaFZFi9ZFD06YW
	h54AOg4i4jiZqYypJELtCpvQQuyygpezD350okq/rCDDZdkfXkphg9Cia9jh/AhXxagDJP
	Qs1x8kfefA27NspOe+NfatuyHhSJhTpue29s2SJE2QpM/IpNyArkKrm+SiWuMuPvh+yG+Z
	u4c09/rPPjPmsGcQJJu9lWlLboJd5GsJaLNwnMdlgPJRnKUzmt9HsKWdTyggVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749558085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7XHwyMIvux7mHDycUbcxmSE3NX5d97oyLdcmCQZNOo=;
	b=uR929m69LoihHTip8d1IsYJO9C90dAsayC2j74Q1/j4ThsmenxpqxfttAovYmqB8P40QB2
	GJ/15xc0lnKOibBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 12/14] selftests: harness: Stop using
 setjmp()/longjmp()
Message-ID: <20250610141252-1ee7ae72-dbad-4a80-931c-5b4b14fb07ce@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <20250505-nolibc-kselftest-harness-v4-12-ee4dd5257135@linutronix.de>
 <aEfTYkVdphiOhqPg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEfTYkVdphiOhqPg@nvidia.com>

Hi Nicolin,

On Mon, Jun 09, 2025 at 11:40:34PM -0700, Nicolin Chen wrote:
> Hi Thomas,
> 
> CC += Jason
> 
> On Mon, May 05, 2025 at 05:15:30PM +0200, Thomas Weißschuh wrote:
> > Usage of longjmp() was added to ensure that teardown is always run in
> > commit 63e6b2a42342 ("selftests/harness: Run TEARDOWN for ASSERT failures")
> > However instead of calling longjmp() to the teardown handler it is easier to
> > just call the teardown handler directly from __bail().
> > Any potential duplicate teardown invocations are harmless as the actual
> > handler will only ever be executed once since
> > commit fff37bd32c76 ("selftests/harness: Fix fixture teardown").
> > 
> > Additionally this removes a incompatibility with nolibc,
> > which does not support setjmp()/longjmp().
> > 
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> The iommufd selftest (CONFIG_IOMMUFD_TEST) starts to give warnings
> when building with v6.16-rc1, though the test code wasn't changed
> at these two functions:

Thanks for the report.

> ------------------------------------------------------------------
> make: Entering directory '/nicolinc/linux-stable/tools/testing/selftests/iommu'
>   CC       iommufd
> iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns’:
> iommufd.c:1806:17: warning: ‘mfd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  1806 |                 close(mfd);
>       |                 ^~~~~~~~~~
> iommufd.c:1766:13: note: ‘mfd’ was declared here
>  1766 |         int mfd;
>       |             ^~~
> iommufd.c: In function ‘wrapper_iommufd_mock_domain_all_aligns_copy’:
> iommufd.c:1869:17: warning: ‘mfd’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  1869 |                 close(mfd);
>       |                 ^~~~~~~~~~
> iommufd.c:1818:13: note: ‘mfd’ was declared here
>  1818 |         int mfd;
>       |             ^~~
>   CC       iommufd_fail_nth
> make: Leaving directory '/nicolinc/linux-stable/tools/testing/selftests/iommu'
> ------------------------------------------------------------------
> 
> Git bisect points to this patch, and reverting it fixes these.
> 
> Both mfds are under the same "if (variant->driver)" check, so the
> warnings don't seem legit to me.
> 
> Do you have any idea why this happens?

It does look very weird. I could understand if the compiler assumes that
variant->file changes during the runtime of the function.
But even if I work around this, by introducing a local variable "bool file =
variant->file" the issue persists.
However as soon as the value of of "bool file" is fixed to either "true" or
"false" it goes away.


The following diff *alone* also prevents the warning, but that doesn't
make any sense either:

--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -65,7 +65,7 @@ static inline void *memfd_mmap(size_t length, int prot, int flags, int *mfd_p)
                return MAP_FAILED;
        if (ftruncate(mfd, length))
                return MAP_FAILED;
-       *mfd_p = mfd;
+       *mfd_p = 0;
        return mmap(0, length, prot, flags, mfd, 0);
 }


Maybe the logic became too complex for GCC?
Case in point, when trying with an older GCC 13.2, the following warning appeared:

In file included from iommufd_utils.h:14,
                 from iommufd.c:12:
In function 'iommufd_viommu_vdevice_alloc',
    inlined from 'wrapper_iommufd_viommu_vdevice_alloc' at iommufd.c:2731:1:
../kselftest_harness.h:760:12: warning: 'ret' may be used uninitialized [-Wmaybe-uninitialized]
  760 |         if (!(__exp _t __seen)) { \
      |            ^
../kselftest_harness.h:513:9: note: in expansion of macro '__EXPECT'
  513 |         __EXPECT(expected, #expected, seen, #seen, ==, 1)
      |         ^~~~~~~~
iommufd_utils.h:1005:9: note: in expansion of macro 'ASSERT_EQ'
 1005 |         ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id, nvevents))
      |         ^~~~~~~~~
iommufd.c:2766:17: note: in expansion of macro 'test_cmd_trigger_vevents'
 2766 |                 test_cmd_trigger_vevents(dev_id, 3);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~
iommufd_utils.h: In function 'wrapper_iommufd_viommu_vdevice_alloc':
iommufd_utils.h:993:13: note: 'ret' was declared here
  993 |         int ret;
      |             ^~~

Which is also just a false-positive and fixed with newer GCCs.


Thomas


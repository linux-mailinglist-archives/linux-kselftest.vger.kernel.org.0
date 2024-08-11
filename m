Return-Path: <linux-kselftest+bounces-15123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5394E24B
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A3D1F219B4
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906511537C7;
	Sun, 11 Aug 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkVZGXG2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC81537A7;
	Sun, 11 Aug 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723394149; cv=none; b=htVp3NbKm5WAFaQStYehJCNnty6+tqEc6RMR8Ki3dDjOh5vvoyWb+PFiuqnE17qGG04tVsRQjblzlJ4hd++s1XI2BBpJyqqU6jdMMhRy2RKOBGLsr6bqAI/SslWcRFtuTcpPbhdehwsOcdDIm8JpTUG7RYm/datK5qmK9Ppk2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723394149; c=relaxed/simple;
	bh=JWC3mgdz2ktAtm0H6Q0A+PYoh4dsi333CkWUpefiwTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrAZiW7MoeMQXEx6Zgyk/oUeBTIq7IzxpOfbVDBeURr+6wXyzlT9t8VFhApahvQRx0wF0gBAwlF8uC7NXbwgT97ruB3t7J/ZaajLiWBBQ54eJUdJyLWC7dtKFXJy8u1Mk/8HBhYeQ1XMib01srPvzHeGffki4xsB2pv1385adnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkVZGXG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30118C4AF0D;
	Sun, 11 Aug 2024 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723394148;
	bh=JWC3mgdz2ktAtm0H6Q0A+PYoh4dsi333CkWUpefiwTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkVZGXG2B04KEwhASYe0vn0UbubvJskcdiZ48Fj381Pat/uHAGPW+1QGjUAXyGKai
	 9HdQ9PTWMNPaFKVmWhvRu5mWX0xT/qyz2f3hrWTdEiRcbsq9ETalzizQdCx7wiKmN3
	 7Tx3PCNS4p4pOvtlnF3Sp6ONa5s6t4wR4pfiTHNdXOn3hWjdxE90BArYS60SOJte7M
	 rTZI010lgwijCgyLuBu2w5tNZGjO5PUBlsW/a10DvWiRH7sCNzjF5kDVjOr5dFOcSq
	 DVbL3MTse1AwAUPExKhC8/As3AJ7PIsygcZ1Y7t1WJszPayTZYRDnTIdawBKhSvJow
	 goti7KOisr8Gw==
Date: Sun, 11 Aug 2024 19:33:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	kernel@collabora.com, stable@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] selftests: memfd_secret: don't build memfd_secret test
 on unsupported arches
Message-ID: <Zrjn2qIcGxPBuSP9@kernel.org>
References: <20240809075642.403247-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809075642.403247-1-usama.anjum@collabora.com>

On Fri, Aug 09, 2024 at 12:56:42PM +0500, Muhammad Usama Anjum wrote:
> [1] mentions that memfd_secret is only supported on arm64, riscv, x86
> and x86_64 for now. It doesn't support other architectures. I found the
> build error on arm and decided to send the fix as it was creating noise
> on KernelCI. Hence I'm adding condition that memfd_secret should only be
> compiled on supported architectures.
> 
> Also check in run_vmtests script if memfd_secret binary is present
> before executing it.
> 
> [1] https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/
> Cc: stable@vger.kernel.org
> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/Makefile       | 2 ++
>  tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 1a83b70e84535..4ea188be0588a 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -53,7 +53,9 @@ TEST_GEN_FILES += madv_populate
>  TEST_GEN_FILES += map_fixed_noreplace
>  TEST_GEN_FILES += map_hugetlb
>  TEST_GEN_FILES += map_populate
> +ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
>  TEST_GEN_FILES += memfd_secret
> +endif
>  TEST_GEN_FILES += migration
>  TEST_GEN_FILES += mkdirty
>  TEST_GEN_FILES += mlock-random-test
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 03ac4f2e1cce6..36045edb10dea 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -374,8 +374,11 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>  # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>  CATEGORY="madv_populate" run_test ./madv_populate
>  
> +if [ -x ./memfd_secret ]
> +then
>  (echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
>  CATEGORY="memfd_secret" run_test ./memfd_secret
> +fi
>  
>  # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
>  CATEGORY="ksm" run_test ./ksm_tests -H -s 100
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.


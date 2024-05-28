Return-Path: <linux-kselftest+bounces-10795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D78D25D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B5928FD22
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 20:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC815178CE8;
	Tue, 28 May 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSagSTgc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFF2FB2;
	Tue, 28 May 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928115; cv=none; b=arhpYxAFHLPlJy1WBExr0Ac5yPa31Yy4tyiAmakShxqb9ucNH0fjRVI5PH0rhiZry9Y8/aRfJOdMyU1kfyEx/klumi26THBLL7fWYCHGsTqltLAIPJndG3Qmd6k0/LK1BfaAXV/1a1EBl3NNdrmjNFlZ+IYerSKnH90sxNEFakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928115; c=relaxed/simple;
	bh=tvqtyxszXM8jDckKY+3E2CdFN/rc+uOT4+I2rD70XSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQAjcy33tHDTK9Gb8PIRqGsBD+zBhvwcX//bsZDb+E072ikkG3vIBgkmYl/Nk+0DqHrcExEtJ9EkeyrYPnXonqmMZ7hFjC5YOL8Chd3YI6P0atJFgHzLqCTa0M56Twbf+L3Cl6h7QMxzY7r4k4XdYMABf8FYGN9NUowoaq2fpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSagSTgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8327C3277B;
	Tue, 28 May 2024 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716928115;
	bh=tvqtyxszXM8jDckKY+3E2CdFN/rc+uOT4+I2rD70XSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSagSTgcCe2BF3D778iaB7O6jZupz2oWfXX6aVkdKYp9UtJAfx6AS7Taq1pRR+Cna
	 8+7JUyyCC7PxNSP5frvuVg+/t/TGdKo8qZMDhfRm6UurFPKoXufbH8CA1MIztVhPNj
	 d+nK0cQB6exOG37UGUijO7dekHrjsNBkjW20xxcKQ5QtCK8V3yvgWOIyf+/bnJZsGu
	 zZ1lVewf5+OGdz1NXBt5JAKDdakbQFXBjQU/VvXkigvM4pagHmE+GDAxYKAoOA0xvF
	 SJbda8NIulJwQUvSg36c7dLkDij8GPYTIt4dfLhH6vI3OV338Sa/EUCpCU4r3iXASv
	 ZYe+rxcP+GAKw==
Date: Tue, 28 May 2024 13:28:33 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/user_events: silence a clang warning:
 address of packed member
Message-ID: <20240528202833.GB2680415@thelio-3990X>
References: <20240527214704.300444-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527214704.300444-1-jhubbard@nvidia.com>

Hi John,

On Mon, May 27, 2024 at 02:47:04PM -0700, John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about "taking address of packed member 'write_index' ".
> This is not particularly helpful, because the test code really wants to
> write to exactly this location, and if it ends up being unaligned, then
> the test won't work (and may segfault, depending on the CPU type).
> 
> If that ever comes up, it will be obvious and can be fixed. But all it's
> doing now is prevent a clean clang build, so disable the warning.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Changes since the first version:
> 
> 1) Rebased onto Linux 6.10-rc1
> 
> 
> thanks,
> John Hubbard
> 
> 
>  tools/testing/selftests/user_events/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
> index 10fcd0066203..617e94344711 100644
> --- a/tools/testing/selftests/user_events/Makefile
> +++ b/tools/testing/selftests/user_events/Makefile
> @@ -1,5 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
> +
> +ifneq ($(LLVM),)

Perhaps it would be better if this were

  ifeq ($(CC),clang)

as that would catch both CC=clang and LLVM=1 users? I haven't tested
this though.

Additionally, I think it would be good to mention that
-Wno-address-of-packed-member is GCC's default, whereas Clang enables
-Waddress-of-packed-member by default.

> +    CFLAGS += -Wno-address-of-packed-member
> +endif
> +
>  LDLIBS += -lrt -lpthread -lm
>  
>  TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test
> 
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> -- 
> 2.45.1
> 
> 


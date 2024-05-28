Return-Path: <linux-kselftest+bounces-10761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E48D1394
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6652849AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 05:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547D83CF73;
	Tue, 28 May 2024 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CylAoe9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F53A8F0;
	Tue, 28 May 2024 05:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872700; cv=none; b=dfqrbb5pIuX6Tc2VcHW23Icply/0mXR0NKTeHC/kNswOkiakHTjjg+1zV+DT4xVHQTE12ZrhnbzYJoRVeIcAqXKLVw2qCfEltOD+U+4AAtBkHxT0Zv0D62uDCU83WLrWkGYHrVLC8D5hW0m9hsyceEnwn1C7SWURPyBznMpoOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872700; c=relaxed/simple;
	bh=2K/FMnaQ6Mh3oj1FxMCogS4VncgpJIP0YBWCZW7ObRY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hKitOEpIt+E9J6lhS+g4mOdXyzYkX6Tg6dn25JRqzaNuYP3Q0h/oEFKdoKPkI856FeBZ5LjaLF1I96gTL30w9R82iNxE9OapE915JDU8mLPjxOT+BqV+H4RikyMmyRknys7sL2/gkX5x+BceNuatxWARw9JGUH78b91K2KpsV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CylAoe9W; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716872696;
	bh=2K/FMnaQ6Mh3oj1FxMCogS4VncgpJIP0YBWCZW7ObRY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CylAoe9WpJOPueFDmgS43j8pNeU63iZjtQJFJCexRGdIJ+nURSN2lxgmOpZLeogje
	 75wIxPwtFA3+RTrva+c6YeGwKW+gXivRcsZPiJpn79axyFhLNe0f6rbKTxD3MQtcNj
	 b4KpzqYDpOvObfN4R2yxE47gbkZimvb0Ar1b1y+VyQiji072sLQNq1WGqdyyXrQu3e
	 Gf9bKnEwkvHvLHv1pd9iLD3O0G0IVch/vEzGBLuLwMkUa7QdJA3xlCy0B1XsljQikr
	 Z14lFvuQJgvdUG4Hmqxk42K1Oop6pqlDVTsM8QMnSKmhY9Z+OSWtF6ITsDzoKNXQC4
	 xDv4h1SnTnqrw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BC3063782137;
	Tue, 28 May 2024 05:04:46 +0000 (UTC)
Message-ID: <ae9de160-c8dc-4e5e-9ec9-4846a5dc643e@collabora.com>
Date: Tue, 28 May 2024 10:04:18 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH 0/8] selftests: x86: build suite with clang
To: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240501122918.3831734-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 5/1/24 5:29 PM, Muhammad Usama Anjum wrote:
> This series fixes build errors found by clang to allow the x86 suite to
> get built with the clang.
> 
> Unfortunately, there is one bug [1] in the clang becuase of which
> extended asm isn't handled correctly by it and build fails for
> sysret_rip.c. Hence even after this series the build of this test would
> fail with clang. Should we disable this test for now when clang is used
> until the bug is fixed in clang? Not sure. Any opinions?
> 
> [1] https://github.com/llvm/llvm-project/issues/53728
> 
> Muhammad Usama Anjum (8):
>   selftests: x86: Remove dependence of headers file
>   selftests: x86: check_initial_reg_state: remove -no-pie while using
>     -static
>   selftests: x86: test_vsyscall: remove unused function
>   selftests: x86: fsgsbase_restore: fix asm directive from =rm to =r
>   selftests: x86: syscall_arg_fault_32: remove unused variable
>   selftests: x86: test_FISTTP: use fisttps instead of ambigous fisttp
>   selftests: x86: fsgsbase: Remove unused function and variable
>   selftests: x86: amx: Remove unused functions
> 
>  tools/testing/selftests/x86/Makefile            |  9 +++++----
>  tools/testing/selftests/x86/amx.c               | 16 ----------------
>  tools/testing/selftests/x86/fsgsbase.c          |  6 ------
>  tools/testing/selftests/x86/fsgsbase_restore.c  |  2 +-
>  tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
>  tools/testing/selftests/x86/test_FISTTP.c       |  8 ++++----
>  tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
>  7 files changed, 10 insertions(+), 37 deletions(-)
> 

-- 
BR,
Muhammad Usama Anjum


Return-Path: <linux-kselftest+bounces-10295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AF78C783E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 16:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DC9282FA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC114A082;
	Thu, 16 May 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bn+zJ0xP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682714884E;
	Thu, 16 May 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868441; cv=none; b=mgwMgfyUYwRuKcfWfxHY+WkRk803ZRW9MX6Cbg51w4v3COZIext6Oa+2gZC4hgsVElVl8IA9wMovV+8jhg4N5nBj4vB1Dc+l3jNi67XOI0VndozRQmYOANow+iLn6OxEn8e5IltnD30ALk9c/xlWhTmiAEucj6+4sciO/HBDoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868441; c=relaxed/simple;
	bh=KiC6KxHYjfqrbyU7JMR/2JxDMnpW/3vFOgBAlktdxyM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lJYszKs1oeuo6zEVT9O3hgKLqVQFaFdreBY7LmaQLbMF53z4/eUAUR9AHibRPbWZfJ5MdhCHdA+iPXc/eMFN0p+koTK/FVM4x6j99hJIDYLlvyW8ujhVjKRHj76TUXzNtnzGmGIC15nYEw7o8fe+7CMEq2q2ePp5xXAsXRnO500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bn+zJ0xP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715868435;
	bh=KiC6KxHYjfqrbyU7JMR/2JxDMnpW/3vFOgBAlktdxyM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Bn+zJ0xPRrwPVoorLOjwckuKoIkIGn5hFNFdjaToRr70mEUgPkW2j1Wke1673sWrV
	 GD+PGWLylxDXKmGrYyghgeOiidlm4PU0L9e94CBdywSwMcvjSN3nwPfuBVRchMByCH
	 zJfEh4ws9r2jeck+Z2Xxu+vtffV1WdGIyTCB6Y8Ex1DSo6kIgZuiLz/P+Na51o3uUp
	 KVfqhlJv7ZMxwK0fCoH5MYfaKe5ZSRs/ku6/jv4t5y2Fzm68BvpwhG6TGw7N3NVSac
	 XPxAoZVe8u3dY6E10XJxzOgOk99JUQ2VbheE8lLs9M+ks8uzNgqGWifkRPDQtmhV2Y
	 8Xespj5BSoNWw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F39D63781183;
	Thu, 16 May 2024 14:07:10 +0000 (UTC)
Message-ID: <1f896922-1a62-44f5-b9b4-2e48e90e7f70@collabora.com>
Date: Thu, 16 May 2024 08:06:16 -0600
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
 llvm@lists.linux.dev, maskray@google.com
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240501122918.3831734-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/24 6:29 AM, Muhammad Usama Anjum wrote:
> This series fixes build errors found by clang to allow the x86 suite to
> get built with the clang.
> 
> Unfortunately, there is one bug [1] in the clang becuase of which
> extended asm isn't handled correctly by it and build fails for
> sysret_rip.c. Hence even after this series the build of this test would
> fail with clang. Should we disable this test for now when clang is used
> until the bug is fixed in clang? Not sure. Any opinions?
Its seems like the bug has been fixed in clang. I'll verify it in next
release and draft a patch separately to fix that error.

I think this series is good to accept then.

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


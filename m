Return-Path: <linux-kselftest+bounces-13872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 925229348A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF331F2209D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157944D9FE;
	Thu, 18 Jul 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UkhrtKUy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A71B86E2;
	Thu, 18 Jul 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287126; cv=none; b=kZYrS+uxvIkwuDyoTaAA8JFT+LIrLuIYkKmoltFE2NtxMKodPDB+TW/hqiR/RBqXfs4WoalTxngDRwjc3WF3OA7ENiILlVsHTKkg6Tqp7avkTIoi/N9HaDYdcIFYUUbv+CUpb6RYsP6nZdMpXdccz4yR7QWxddPVEUXQoC/yS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287126; c=relaxed/simple;
	bh=17AClJMgbrYZ8l+2vrWqgmX3X7uSLVnOoz9b3REvZE4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qp49c6RI2QWoxIapjsIV/letz4JqldYpB4O5pVuCg605sammcTzQvKgMQNMRDIm3ZUaa4k+URy93+ailhrkcfX+0V4TeU0C84rA2D1e6sQCOQ/NplVmklzJD9iAkOwOEpMJFLGHrLQbpEpHum+14AuPRl5Sx76a6HRLEG3W5L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UkhrtKUy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721287122;
	bh=17AClJMgbrYZ8l+2vrWqgmX3X7uSLVnOoz9b3REvZE4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UkhrtKUyFQH8NFyrbG28q3zKX/ylRsZlIKFrge/R+vx4iTMqI4QknopnYc6MFgGBK
	 IwNteOmD/BNwB3kV3u0GxZbqTNd0IsxtQ7qYtu50MINuPHmDieySJg092cpfoEECnc
	 scjQdFT/LoidfjSE3f8TDTF59xPaxJEf74JJGa8eVe+EVbw2vifvv+MUBYknsQm6e/
	 dorAh/f9RCxKXjdSh2h5j4n291xijtsRo7AGgvORG1sDwk1cUXBcnEbEmYtk5jLgxq
	 sCXoyzXiETt90tfb8Rnbb6VlyQ+HuVxpItCk14GHAzGRuGv9OVmCVIIiN13cZmWZTD
	 g7D3rt/ZaguAA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 695AE3781185;
	Thu, 18 Jul 2024 07:18:39 +0000 (UTC)
Message-ID: <3724b03d-5d19-4b7d-bc5b-80e2debecbc1@collabora.com>
Date: Thu, 18 Jul 2024 12:18:34 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: x86: vdso_restorer: Return correct exit
 statuses
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
 <20240712073045.110014-2-usama.anjum@collabora.com>
 <11c8d108-8635-4c57-b76a-8dc4a9c908af@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <11c8d108-8635-4c57-b76a-8dc4a9c908af@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/24 3:01 AM, Shuah Khan wrote:
> On 7/12/24 01:30, Muhammad Usama Anjum wrote:
>> Return correct exit status, KSFT_SKIP if the pre-conditions aren't met.
>> Return KSFT_FAIL if error occurs. Use ksft_finished() which will
>> compmare the total planned tests with passed tests to return the exit
>> value.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Same comment - here. Include before and after output to show
> how this change improves the report.
Following results have been generated in the case when both tests fail:

# selftests: x86: vdso_restorer_32
# ERROR: ld.so: object '/usr/libexec/coreutils/libstdbuf.so' from
LD_PRELOAD cannot be preloaded (wrong ELF class: ELFCLASS64): ignored.
# [RUN]	Raise a signal, SA_SIGINFO, sa.restorer == NULL
# [FAIL]	SA_SIGINFO handler was not called
# [RUN]	Raise a signal, !SA_SIGINFO, sa.restorer == NULL
# [FAIL]	!SA_SIGINFO handler was not called
not ok 21 selftests: x86: vdso_restorer_32 # exit=2

# selftests: x86: vdso_restorer_32
# ERROR: ld.so: object '/usr/libexec/coreutils/libstdbuf.so' from
LD_PRELOAD cannot be preloaded (wrong ELF class: ELFCLASS64): ignored.
# TAP version 13
# 1..2
# [RUN]	Raise a signal, SA_SIGINFO, sa.restorer == NULL
# not ok 1 SA_SIGINFO handler returned
# [RUN]	Raise a signal, !SA_SIGINFO, sa.restorer == NULL
# not ok 2 SA_SIGINFO handler returned
# # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 21 selftests: x86: vdso_restorer_32 # exit=1

Please let me know what you think?
> 
> thanks,
> -- Shuah
> 
> 

-- 
BR,
Muhammad Usama Anjum


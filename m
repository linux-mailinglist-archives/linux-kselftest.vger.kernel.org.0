Return-Path: <linux-kselftest+bounces-9255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D08B94B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 08:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0A2B21FCB
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED401527AD;
	Thu,  2 May 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qOk0oevP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44326A48;
	Thu,  2 May 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631581; cv=none; b=XDQE7Lacmi0NSfx59TjgRa825dcbdRddh/VSMkfD8eAnj/JGiaNRxoOfWRpokgsYg4ry8DwHdkwxj1NOC8CRjmJR6A0mUj7cDsUoNljUvyZxPK1XTKRIAiB0nCV5easM7+tnlXS7R/EYjrHmMICSMtKSAc6RPD0guUzcKOE8LQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631581; c=relaxed/simple;
	bh=pjIqOJEiOt9KucXTf7b55UJINUUUZE6EEFDyk2OaR6s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J3K3pvYPn4nhvDY8+tM9bEk1v2d4YaW7PtGezo3necVBMUeAIZdagyKqgdVL2+9Bg7ofXeDME9QFsw5ebW0oguwSdnVLZFbi1dxG4ajNiMwWoT4gA83cpnsepyRrqGUNt2DPSnLaejTfy4bvahP5o2tm5NqprpHwv76CBi+9UIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qOk0oevP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714631572;
	bh=pjIqOJEiOt9KucXTf7b55UJINUUUZE6EEFDyk2OaR6s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qOk0oevPJe0LgsiOcWVDLXXHzCvIYoiw1Wsitp25al+Np2Df1aAOdnCuCTASWptDo
	 nan8oK3KXH1jABC8mPxSjHiIBLj9dMW9qebrP1PX7Pk+XXJBNQxaJ1DE6v2xCL6Rda
	 FuaY7MhnChhcEoZt2qjErybB/Ezp+OFMbtGDzaWo5SJuCPr60IKfSoFa2VTm5KLElk
	 t24Fx2hliDxtO8PDOk7tf9P0MtzNAHVZyW+vHO8L9+wSK8AD5CVEvWQ5m94Gg9BooL
	 w5f3uU5JP2RAe+Ac39q5iEiLzQkQrLyP+mfTqXqS2Ow9FzdIKl4EJJbGr7lLUm1dGg
	 UAjj6nWFVe0mg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BE6D3378001E;
	Thu,  2 May 2024 06:32:47 +0000 (UTC)
Message-ID: <c9ad463f-cc67-44eb-bf94-449144e3078b@collabora.com>
Date: Thu, 2 May 2024 11:33:17 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Edward Liaw <edliaw@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Axel Rasmussen <axelrasmussen@google.com>, Bill Wendling <morbo@google.com>,
 David Hildenbrand <david@redhat.com>, Justin Stitt <justinstitt@google.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Peter Xu <peterx@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linus:master] [selftests/harness] 8092162335:
 kernel-selftests.sgx.make.fail
To: Kees Cook <keescook@chromium.org>,
 kernel test robot <oliver.sang@intel.com>
References: <202404301040.3bea5782-oliver.sang@intel.com>
 <202405011330.85D66871E@keescook>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202405011330.85D66871E@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/24 1:32 AM, Kees Cook wrote:
> On Tue, Apr 30, 2024 at 11:02:36AM +0800, kernel test robot wrote:
>> version: kernel-selftests-x86_64-c7864053-1_20240419
>> [...]
>> compiler: gcc-13
>> 2024-04-29 15:02:59 make -j16 -C sgx
>> [...]
>> gcc -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE -fno-stack-protector -mrdrnd -I/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/../../../tools/include test_encl.c test_encl_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-8092162335554c8ef5e7f50eff68aa9cfbdbf865/tools/testing/selftests/sgx/test_encl.elf -Wl,-T,test_encl.lds,--build-id=none
>> /usr/bin/ld: warning: /tmp/lkp/cct4g3SV.o: missing .note.GNU-stack section implies executable stack
>> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>> In file included from main.c:21:
>> ../kselftest_harness.h: In function ‘__run_test’:
>> ../kselftest_harness.h:1166:13: error: implicit declaration of function ‘asprintf’; did you mean ‘vsprintf’? [-Werror=implicit-function-declaration]
>>  1166 |         if (asprintf(&test_name, "%s%s%s.%s", f->name,
>>       |             ^~~~~~~~
>>       |             vsprintf
>> cc1: all warnings being treated as errors
> 
> What environment is this being built in? "asprintf" should be available
> via stdio.h, and "kselftest_harness.h" includes that (and _GNU_SOURCE).
Sometimes the order of include is as following:

#inlucde <stdio.h>
#define _GNU_SOURCE
#inlucde <stdio.h>

The _GNU_SOURCE wasn't defined the first time stdio.h was included hence
the definition of asprintf isn't present. The second inclusion of stdio.h
when _GNU_SOURCE is defined is ignored as it was already included.

This is being fixed in following series:
https://lore.kernel.org/all/20240430235057.1351993-1-edliaw@google.com

-- 
BR,
Muhammad Usama Anjum


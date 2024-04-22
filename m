Return-Path: <linux-kselftest+bounces-8587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE78AC394
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2E61F21364
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 05:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED9168DA;
	Mon, 22 Apr 2024 05:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WhZC8iu6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B69205E0A;
	Mon, 22 Apr 2024 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763024; cv=none; b=PjG1sC4F8Wux658bH7KgCEAjSv7w0OzTGXWcdGwX27IwGFjnVBtB2/u4I8v5VT5lvq30xDSQEMZaDwkzKzwGWWciwE+vnH2em64McEEQhFEH6D18f87TTDr1LIttrtz+cY3rASCsVhfEhUEIRLuv3v5IidlRkVngt+KEs4JLCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763024; c=relaxed/simple;
	bh=cMnh/49jfk+grS2ysmLN5qIDOGt2bFENRAA1wJUhvec=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XUTgOMevlV7Zyzfwx6xtWrvQ38q9Xeh/Zi01xKwZgYOECdXl3kzxCZfrwT5xafMKuJZb1ezyp74VPJGEaff3YaYUzMCjwCtX1zSiGFW7rn2pSluuI//dLcPWpSgOECuBStHchpDccT5yfh1HNyoMIk3NYOa2+SLZgWYLAu6zFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WhZC8iu6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713763017;
	bh=cMnh/49jfk+grS2ysmLN5qIDOGt2bFENRAA1wJUhvec=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=WhZC8iu68naeieHYPANQJZStUlF9dVMoUoTC5m4roTObCcoh8nouY9n+lhSosoq9I
	 4D6CanpImnxkTg5tqGQ0ROnqNd05O17ek1lBN8KgdDLr1N9nBkvHuPpRizm0LS+qn/
	 PcxykAV6YmdvknefaMiUmpHuhlU7XbOvkQu+DIdwNlj88sKjmbt0zO7agh4HUAKN6O
	 on+0y6cIUcMtlApAAIZ24pmKrFQytmsqicRSGxga3HQ/TXqzy0n9kGklWPVGA0qS9g
	 fb3G/bum1EPIr3Ur34PLe32JrnRL0ZYsquDRFR8EznmH+NsQml3WhqtRcM5tqvdr72
	 o06N/hhSbIbpg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0C28A378202D;
	Mon, 22 Apr 2024 05:16:43 +0000 (UTC)
Message-ID: <df1df586-188e-4290-9986-7b7cd31710e3@collabora.com>
Date: Mon, 22 Apr 2024 10:17:13 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH] selftests: filesystems: add missing stddef header
To: Amer Al Shanawany <amer.shanawany@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417161623.37166-1-amer.shanawany@gmail.com>
 <4b66cfb8-5d42-4432-b930-e23482a48dc6@collabora.com>
 <be7b90cd-c1fc-4e42-85a9-325d7c92c396@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <be7b90cd-c1fc-4e42-85a9-325d7c92c396@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/20/24 8:56 PM, Amer Al Shanawany wrote:
> On 4/19/24 18:45, Muhammad Usama Anjum wrote:
>> On 4/17/24 9:16 PM, Amer Al Shanawany wrote:
>>> fix compiler warning and errors when compiling statmount test.
Following can be added to the description:

statmount_test.c:572:24: warning: implicit declaration of function
‘offsetof’ [-Wimplicit-function-declaration]
  572 | #define str_off(memb) (offsetof(struct statmount, memb) /
sizeof(uint32_t))
      |                        ^~~~~~~~
statmount_test.c:598:51: note: in expansion of macro ‘str_off’
  598 |         test_statmount_string(STATMOUNT_MNT_ROOT,
str_off(mnt_root), "mount root");
      |                                                   ^~~~~~~
statmount_test.c:18:1: note: ‘offsetof’ is defined in header ‘<stddef.h>’;
did you forget to ‘#include <stddef.h>’?
   17 | #include "../../kselftest.h"
  +++ |+#include <stddef.h>
   18 |

>> The error description or the compiler with version is required to reproduce
>> the error easily. I'm unable to reproduce the error by gcc 12 and clang 17.
> I'm using gcc 12.3 (Ubuntu 12.3.0-1ubuntu1~22.04), for the error please see the attached log file (statmount.txt)
> I was wondering if it's worth adding this include to kselftest.h
>>>
>>> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

>>> ---
>>>  tools/testing/selftests/filesystems/statmount/statmount_test.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>> index 3eafd7da58e2..e6d7c4f1c85b 100644
>>> --- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>> +++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
>>> @@ -3,6 +3,7 @@
>>>  #define _GNU_SOURCE
>>>  
>>>  #include <assert.h>
>>> +#include <stddef.h>
>>>  #include <stdint.h>
>>>  #include <sched.h>
>>>  #include <fcntl.h>
>>
> 
> Thanks
> 
> Amer

-- 
BR,
Muhammad Usama Anjum


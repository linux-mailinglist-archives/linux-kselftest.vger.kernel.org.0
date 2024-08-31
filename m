Return-Path: <linux-kselftest+bounces-16886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B086966F6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 07:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7632846B2
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 05:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C9213AA3E;
	Sat, 31 Aug 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="f+f0IJjS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D013958C;
	Sat, 31 Aug 2024 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082228; cv=none; b=ehi0hXEUtwY8A/UcBdJHNb7WzM8xirv5xsxCCPw213giRKcjGxNSQpMKzniZWkW2hZx0TibcCB5B4xj0ixKZPpgHQVFficbn7+PceC6D+D7zqUMeG80TF6JqrqPLhf0BsAceYMjss7u6d9TTK3jwctYRmBUlPwxPmBkJhZQCY2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082228; c=relaxed/simple;
	bh=46mVeyoOwBQkglTLZlQCjad0Rh1l/vONvzzjbZZ1r5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3j3XJlZQlKFPN0N0u+tr4FLAi8oPT1i4/D0PzUNb8Xf4hnx/wlPeuTnTm/mpGbfFYtJfVhO9ZHlfKR+AvjRAQW9Y9SqNMNQAEacwP+/3CtDuhPUjGrAMbGzuwKOnX2I6dKIW9RwjKtyWpc1gYx1y5XvfW9IVZ0yQD6g+R+CzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=f+f0IJjS; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725081923;
	bh=pW6dqj93lXjUeIn/RRkE7E98Q1ehqQRRYqh4xeAkZ4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f+f0IJjSjO/8yS3vlsLqfkqD8AecGDMohtYagzvQ1uepjLWXTsGu+uvoxtkhjQzph
	 WN9rD9R4ch/Xzdu1DfnX5KxvWdcGpLIjQaZXC9rKk6Jx3HImFpTqGXRQwTyiOCcXhu
	 RcAvDjRBzX9bsmEV0Q53RebYidhU4OZ34cZVwNHE=
Received: from [192.168.124.7] ([120.245.115.147])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 65602CE1; Sat, 31 Aug 2024 13:25:22 +0800
X-QQ-mid: xmsmtpt1725081922tjhcs5qkd
Message-ID: <tencent_6184E8B23A2EFF54CC5F2346B7105F0C8209@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NotEQEhUzrb7BmAy7+5RohEIZ8hnTJKv5Dy9eLWqdCe/HITxr+Y9
	 ItjV05s5WL/MMdl8OpIFDq3LbA4fmqr6/Q92v++P6SfI7NFO2JMCQ67XzuyI+YMbZQzL82RCfNIs
	 59Xk1QSE91ncTgFLO6aVXTm6CV5vE8cUeI1lu77DGBbS0J3YzCwEoUaGLha+6x+cOka3c+Big1Qb
	 15ob/3qleZ83tslrLHTBAb2+kENRr3UXIv7jK/4B9wgUMGu0oOuZSm/xWnkSLF21xJiA3uQ5RbAI
	 Pxv0suUGMpKlkofUl6WpnxdvUfudswf2K06y4gNXiG2OLkv98jeBcgIRBC0q/qV6Oa/pwwDMwFVl
	 REsK6gy+nB9SJVGGLJroKfVq32V7lPGZjPnMCjJKv72inOYQrWB9Fn2j9pW9Kz7fMYfpjgVm8fQD
	 IjW9KW6bNSTdZVHc1eybn238s1VeJa/cApAphA5q7VmsvjA9Wd1lU8GWGZcsB3KPTOoZahRqJCXi
	 gdFjwcXifHxMWMvZfXMn4b2rRMOa3jQjlIIbbCnzTj7A2LxH6UxKlIcNZTPot10dKMFYAMcCAE5A
	 yoHlTaDHugkScWr6mIozJkCKswMrD0pKhgKrR5RSKZACgzNv1VOz07nUmEAX+AIOd0FpozJERP9l
	 lb7DBzLZy4Zrrz7hfk61T4+x/F/xnxCcMS6jr39fGjYBALzo2ZpqXS2odZCgWhBVipL8cASn1i88
	 My3F7qiFeezBjxj1d+Hr5nXX9LQEZaFsoVWU9YLz+IDCLwKMYYuKprIeJPXq+D1diW7TeTo6dQod
	 yr/tIsiByyuI5/J0qREHm7Z/oDT4HLp4QDWQ4SG6C2USvrekr2yqAPzBXCrmFJvpn7kfJNzzOFlS
	 cgbW/Qv75J8eq/r1mB9EPao5mUqAllgH3GndNl/i0pb+gTcWdukHaIBdHv6VG7thZE1+S/KgIgsy
	 Ny+WOZwMuXG0yRTPJqImC48LzVF/m+flu0DrJ9xeb8VIbfujp4swkl0Sz02BLianpGch0TbRiPzG
	 ihnzO2zg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <6ad6f1bc-75eb-4a52-bf55-783009e1d399@foxmail.com>
Date: Sat, 31 Aug 2024 13:25:21 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: splice: Add splice_read.sh and hint
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc: rongtao@cestc.cn, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <tencent_3E0DB88452B3022E6754AC5F8546B310BD09@qq.com>
 <c15802a1-088f-468c-afe7-fedb374bce89@linuxfoundation.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <c15802a1-088f-468c-afe7-fedb374bce89@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/30/24 8:37 PM, Shuah Khan wrote:
> On 8/27/24 21:40, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Add test scripts and prompts.
>
> Can you give more details on what these scripts and prompts do?
>
I just push 
v2(https://lore.kernel.org/lkml/tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com/)

At the first time, I just want to do the same thing that 
default_file_splice_read.sh did,

and splice_read.sh looks like useless, i just remove splice_read.sh in v2.

>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   tools/testing/selftests/splice/splice_read.c  | 1 +
>>   tools/testing/selftests/splice/splice_read.sh | 9 +++++++++
>>   2 files changed, 10 insertions(+)
>>   create mode 100755 tools/testing/selftests/splice/splice_read.sh
>>
>> diff --git a/tools/testing/selftests/splice/splice_read.c 
>> b/tools/testing/selftests/splice/splice_read.c
>> index 46dae6a25cfb..194b075f6bc0 100644
>> --- a/tools/testing/selftests/splice/splice_read.c
>> +++ b/tools/testing/selftests/splice/splice_read.c
>> @@ -49,6 +49,7 @@ int main(int argc, char *argv[])
>>                 size, SPLICE_F_MOVE);
>>       if (spliced < 0) {
>>           perror("splice");
>> +        fprintf(stderr, "May try: %s /etc/os-release | cat\n", 
>> argv[0]);
>
> Is this supposed to be usage or help message?

Yes, I just add usage() function to splice_read.c in 
v2(https://lore.kernel.org/lkml/tencent_0AEA8FB622DE1A740841643D5F36ABF8BD0A@qq.com/)

Please review, thanks.

>
>>           return EXIT_FAILURE;
>>       }
>>   diff --git a/tools/testing/selftests/splice/splice_read.sh 
>> b/tools/testing/selftests/splice/splice_read.sh
>> new file mode 100755
>> index 000000000000..10fd5d738a2d
>> --- /dev/null
>> +++ b/tools/testing/selftests/splice/splice_read.sh
>> @@ -0,0 +1,9 @@
>> +#!/bin/sh
>> +# SPDX-License-Identifier: GPL-2.0
>> +set -e
>> +nl=$(./splice_read /etc/os-release | wc -l)
>> +
>> +test "$nl" != 0 && exit 0
>> +
>> +echo "splice_read broken"
>> +exit 1
>
> thanks,
> -- Shuah

Thank you.

Rong Tao



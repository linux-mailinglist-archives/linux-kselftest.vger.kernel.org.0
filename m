Return-Path: <linux-kselftest+bounces-37954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A5B110B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 20:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3607B7B6366
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F92ECD0A;
	Thu, 24 Jul 2025 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="mKe/EQvZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta-102a.earthlink-vadesecure.net (mta-102a.earthlink-vadesecure.net [51.81.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C291A23BB;
	Thu, 24 Jul 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753380879; cv=none; b=UOuAHTWPeyy8PciXpqc+hPwDTRMvQa3J856b8bZPewbVUbDjV7U951y8AoxK+Zh4J9etcf7PexZIx4LWngR+v+mkclPD4FJNFnEFGx9jDDdfNyvlYES2UQ2SBXAO6HP28N2qotpOHu9JjMgxJQ5cUbMJoxcdTTIeekTBwZWvT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753380879; c=relaxed/simple;
	bh=9NiZupBTb15sSvM2aeLzHRnCVKFKcdvReraW1uYPJXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KH7RsGIY09e31AlQgoPTY1QLyVeaYZeJ76+pVzXaHydhhJ98/XF92CB3N8jMioD5/ci7HI7j6DQ42duhHVl0/6ZY1wPubFnKHcxZIQqyKRVjbxV+Y4OhfgGuVqZWwbgLyP9Lbnz0Z5zR6dKXvu53CcD6AbfqQYD3hDJPfnTu79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=mKe/EQvZ; arc=none smtp.client-ip=51.81.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: earthlink-vadesecure.net;
 auth=pass smtp.auth=svnelson@teleport.com smtp.mailfrom=sln@onemain.com;
DKIM-Signature: v=1; a=rsa-sha256; bh=RITGUDj3cpeoQ2n5C/PGuRMJPLQHXrN/UMr3a3
 flItk=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1753379929; x=1753984729; b=mKe/EQvZK7jMbOA51co8od4egED
 7tRrRKTyCB2xi8MkefUkYYmisSrWkwKeEdJ36/85c7/zWnyDq+2J2r4NB3S7XdYEFYgWzl5
 LqR07nY6KLK/+AivXF9tfAfDyriifKy95s19ufUc6l4zGNyoF+fWGKy9+R9nwi/e2cXWvuS
 E8EShBz3vUXeovxV1A09qXTWze5sJ4+YsRwBYdAufcQMubPUf44oQmgs/hW0cDhXSJTzS69
 nozbG6B9us1R3+Q4V4Ou8FIKFNxXuav4IJ57UgNgrDTn05f+YalB9ZOl2VYQfhFIjqi9pun
 eaRONzaKZQ3jmDQAHwlMsHEMmzeAsmg==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id 7072e953-185541c13ca8e627; Thu, 24 Jul 2025 17:58:49 +0000
Message-ID: <09d52433-74e9-4f69-9a3d-6e99a65b03b5@onemain.com>
Date: Thu, 24 Jul 2025 10:58:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: rtnetlink.sh: remove esp4_offload after
 test
From: Shannon Nelson <sln@onemain.com>
To: Xiumei Mu <xmu@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Long Xin <lxin@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>
References: <238b803af900dfc5f87f6ddc03805cc42da2ca35.1753332902.git.xmu@redhat.com>
 <aIHRwwOl-FS8KOV0@fedora>
 <CADdRzaF5Ck86fyEYaeWjvoVt=8qEhNKJ8J3ye+x0cb9EATqQ7Q@mail.gmail.com>
 <b1943474-c24b-4def-a46b-74a99e92b1d4@onemain.com>
Content-Language: en-US
In-Reply-To: <b1943474-c24b-4def-a46b-74a99e92b1d4@onemain.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

(yeah, I made the same non-ASCII mistake...)

On 7/24/25 10:49 AM, Shannon Nelson wrote:
> On 7/24/25 1:20 AM, Xiumei Mu wrote:
>> resent the reply again with "plain text mode"
>>
>> On Thu, Jul 24, 2025 at 2:25 PM Hangbin Liu<liuhangbin@gmail.com> wrote:
>>> Hi Xiumei,
>>> On Thu, Jul 24, 2025 at 12:55:02PM +0800, Xiumei Mu wrote:
>>>> The esp4_offload module, loaded during IPsec offload tests, should
>>>> be reset to its default settings after testing.
>>>> Otherwise, leaving it enabled could unintentionally affect subsequence
>>>> test cases by keeping offload active.
>>> Would you please show which subsequence test will be affected?
>> Any general ipsec case, which expects to be tested by default
>> behavior(without offload).
>> esp4_offload will affect the performance.
>>
>>>> Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
>>> It would be good to Cc the fix commit author. You can use
>>> `./scripts/get_maintainer.pl your_patch_file` to get the contacts you
>>> need to Cc.
>> I used the script to generate the cc list.
>> and I double checked the old email of the author is invalid
>> added his personal email in the cc list:
>>
>> Shannon Nelson<shannon.nelson@oracle.com>. -----> Shannon Nelson
>> <sln@onemain.com>
>>
>>   get the information from here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a1113cefd7d6
>
> Yep, that was me a couple of corporate email addresses ago. Thanks for 
> digging up the new email address.  Luckily I have a couple of mail 
> filters watching for old email addresses.
>
>>>> Signed-off-by: Xiumei Mu<xmu@redhat.com>
>>>> ---
>>>>   tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
>>>> index 2e8243a65b50..5cc1b5340a1a 100755
>>>> --- a/tools/testing/selftests/net/rtnetlink.sh
>>>> +++ b/tools/testing/selftests/net/rtnetlink.sh
>>>> @@ -673,6 +673,11 @@ kci_test_ipsec_offload()
>>>>        sysfsf=$sysfsd/ipsec
>>>>        sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
>>>>        probed=false
>>>> +     esp4_offload_probed_default=false
>>>> +
>>>> +     if lsmod | grep -q esp4_offload; then
>>>> +             esp4_offload_probed_default=true
>>>> +     fi
>>> If the mode is loaded by default, how to avoid the subsequence test to be
>>> failed?
>> The module is not loaded by default, but some users or testers may
>> need to load esp4_offload in their own environments.
>> Therefore, resetting it to the default configuration is the best
>> practice to prevent this self-test case from impacting subsequent
>> tests
>
> Seems reasonable to me.
>
>>>>        if ! mount | grep -q debugfs; then
>>>>                mount -t debugfs none /sys/kernel/debug/ &> /dev/null
>>>> @@ -766,6 +771,7 @@ EOF
>>>>        fi
>>>>
>>>>        # clean up any leftovers
>>>> +     [ $esp4_offload_probed_default == false ] && rmmod esp4_offload
>>> The new patch need to pass shellcheck. We need to double quote the variable.
>> Thanks your comment, I will add double quote in patchv2
>
> Or you keep with the existing style as done a line or two later:
>     $esp4_offload_probed_default && rmmod esp4_offload Either way, 
> Reviewed-by: Shannon Nelson <sln@onemain.com> Cheers, sln
>>> Thanks
>>> Hangbin
>>>>        echo 0 > /sys/bus/netdevsim/del_device
>>>>        $probed && rmmod netdevsim
>>>>
>>>> --
>>>> 2.50.1
>>>>
>



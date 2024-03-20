Return-Path: <linux-kselftest+bounces-6440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8D08808AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 01:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDDF1C20F71
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 00:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231B64C;
	Wed, 20 Mar 2024 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="NIrztfyK";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="oNEk2Nt0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39034629;
	Wed, 20 Mar 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.235.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895680; cv=none; b=CR8T/J9OYcp9n4JgM8HYNelWG6M75dFeA6cdufvT3iOtsKqrKkdqJoMZ5MC9tFFCy/h4g9fW4TzjXWQN0PwSResBC2zJ/Qv+iiSfgCFjE6PiBS7CinkWCF9OsZMVcAEKhChMgGVaTDlEqUjauBPOHmP0/PP/GpsiVoJymNvXu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895680; c=relaxed/simple;
	bh=GNUn5F0m1NSdDdpA3rmiVn684OoVB6CLL1oKo3QkbTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgm5tayLEvH/9HTPOz2DtBBXjWxDyjbIlFugiKeU8QGK1I17GvBGCLopv+WCgjm5NpVTNrYkdceEgVdD2nTooX2PzyUPG11FAhbtC8D3z7sp9J4oVoOiDtiRSiLfqbzpIlXwSYIjjhcfheuUimr7TDDDVw9FQ0NtbYaXtPQxumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr; spf=pass smtp.mailfrom=alu.unizg.hr; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=NIrztfyK; dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b=oNEk2Nt0; arc=none smtp.client-ip=161.53.235.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 449FA6019C;
	Wed, 20 Mar 2024 01:47:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710895665; bh=GNUn5F0m1NSdDdpA3rmiVn684OoVB6CLL1oKo3QkbTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NIrztfyKOT4mzU46ujiHR9eJFjXWQTIgS+urz7lwdT2aNmR7KS/F9AqMcRNAS6qDM
	 gdPw9+yBPd815nptOdQilTZ8GQ7ggmJMo9+i0mqlgteNh1J1oVk+tXQJAy/mwTKc3x
	 AfQ50JInr/sZst1fkVDnH09fgRfQzpnnf99pf63zisY4Arr7WleFIXcRCguP8oXXlI
	 dEDhBsppTEDGajNKq4CuNNcRcEQ8gWuvsABWE2Idgm1qTtNVjx4Xu1zVtr2ImAITdy
	 kWU+lkaHqn9Ov5Mjkz99FsqB1178LUctz8et+UXuEr5VSori7h0L41HolvhWQsIxFs
	 r/8qwHpdq3b0A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlJEwr47upLE; Wed, 20 Mar 2024 01:47:41 +0100 (CET)
Received: from [192.168.178.20] (dh207-42-61.xnet.hr [88.207.42.61])
	by domac.alu.hr (Postfix) with ESMTPSA id 3487B60195;
	Wed, 20 Mar 2024 01:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1710895661; bh=GNUn5F0m1NSdDdpA3rmiVn684OoVB6CLL1oKo3QkbTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oNEk2Nt0ojxj/eBtWTaMp8l3lFVXFncUWanhLNgX56G41nTGy4vsbZTd2PFeUzUxt
	 P0TNu8f5E4M2f59C52Pzww+fQyiIDahH1ccX4BW0H5vY3FaQVArlV9P7DZfIePtQVQ
	 EEu4LqafflIZbmV8wIISZkoZ4oQgNRhtAeKdcGZcSaZ1OtdtFr+6yyAPux6rR28R5n
	 G9teB0kt0dVE7FOstVQT59FASfDdzgjwk3zxW5OH+D5rwnLQJsG0WovEtOKDnMeckO
	 7egvjemijLTVW4OYa3mH8qZJK/iwmoVESikoD9mE3s3pOJd9UDHL7GmkRNqCtb4liZ
	 ymR6N/34ndPyA==
Message-ID: <87634afb-d14b-42ce-be25-1000591ee57c@alu.unizg.hr>
Date: Wed, 20 Mar 2024 01:47:36 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] selftests/net: test_vxlan_mdb.sh: 84 out of 642 tests
 [FAIL]
To: Ido Schimmel <idosch@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>
 <Zfe2cGv_EWFAZXAJ@Laptop-X1>
 <f005453c-c7cf-4e1d-b266-ffe1cf8fc79e@alu.unizg.hr>
 <ZfmgdVUmy-DgNklu@shredder>
Content-Language: en-US
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZfmgdVUmy-DgNklu@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/24 15:25, Ido Schimmel wrote:
> On Tue, Mar 19, 2024 at 06:05:16AM +0100, Mirsad Todorovac wrote:
>> On 3/18/24 04:35, Hangbin Liu wrote:
>>> On Sun, Mar 17, 2024 at 12:19:12AM +0100, Mirsad Todorovac wrote:
>>>> Hi,
>>>>
>>>> While running kselftest on vanilla torvalds tree kernel commit v6.8-11167-g4438a810f396,
>>>> the test suite reported a number of errors.
>>>>
>>>> I was using the latest iproute2-next suite on an Ubuntu 22.04 LTS box.
>>>>
>>>> # Tests passed: 558
>>>> # Tests failed:  84
>>>> not ok 90 selftests: net: test_vxlan_mdb.sh # exit=1
>>>
>>> FYI, I tested with 6.8 kernel with net tree. All passed.
>>>
>>> Data path: MDB torture test - IPv6 overlay / IPv6 underlay
>>> ----------------------------------------------------------
>>> TEST: Torture test                                                  [ OK ]
>>>
>>> Tests passed: 642
>>> Tests failed:   0
>>>
>>> # uname -r
>>> 6.8.0-virtme
>>>
>>> Thanks
>>> Hangbin
>>
>> Hi, Hangbin,
>>
>> I am running an Ubuntu 22.04 LTS configuration.
> 
> Didn't get your first mail for some reason.

Your organisation's Office 365 is configured against compressed attachments:

Diagnostic-Code: smtp;550 5.0.350 One or more of the attachments in your email is of a file type
that is NOT allowed by the recipient's organization.

I will try to remember this.

> Anyway, it might be related
> to the fact that Ubuntu is using an old version of libnet:
> 
> https://launchpad.net/ubuntu/+source/libnet
> 
> I remember fixing similar issues in the past:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cb034948ac292da82cc0e6bc1340f81be36e117d

I recall that last August.

> Will look into it today or later this week.

Thank you for considering this.

Best regards,
Mirsad Todorovac


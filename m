Return-Path: <linux-kselftest+bounces-40443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EFAB3E73C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 16:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E0E206D8A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB67343207;
	Mon,  1 Sep 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="i58tV0JG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83A341AC0;
	Mon,  1 Sep 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737014; cv=none; b=eeAHUpFGRpEJ/4L3qW23OGfl6rEiMsQaenMxzVWKNvu4GFL9Zp0+kS4ad0otjtEQlmEyur5LU85AQQ+nClh6S9KMddMl1MVNFG09XA4FEgHujNvtB+kUSIYhwDidNKUJ6IQ6kv+T9/qx4nrmrXwUCh5Si6CFkjR9AnuYecalr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737014; c=relaxed/simple;
	bh=qSkaqIips+4MLEo4Zp8mEeudv7ytxIUgJAsoPjt+h/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dBbblhhJIS+KkSeM0mo7sdFXzP1x9PBsX5cyf5oS+u9dXlJws3x4e6fGLAq1TVSdbJc/v56uOc+4Tz5IQITJqL5nxYbnS7e26NguptfUUG4Y3VXXWyNXRveVyDpq/EGYjlzBYyuOiXFL0txqiwAuZ3dv/gaou04S+9umQY+eGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=i58tV0JG; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756737012; x=1788273012;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=+uHBZTpRi5ucUMryB+eBopJlrYLUcWv6+yyQSUEyLxg=;
  b=i58tV0JGt5/KFwJZWTlh2842BHTFY6q2EdbQ5jr8ykJawInEw5uYEv4E
   S51sMzfU3W7ifp+KY+ycIRkIgqNIIDVfL3KC9D5f6dlS7zGgd7q4ou4iE
   q58Kqc/N5rVT4RJYN/XLCVJP3HjIUW3PtlFg2avXFjvRIJbKZvT6XsqGM
   dbI2nhN6y/n2em53rqf6z1xp6OODx2An4G0fpVmrXUO9u1pxFcd85RL5t
   zJ00jeSw5htqfJGISkesblieZ7yu2OmwynvlNa/DFkjKS2ihDmPVn0sE5
   UXcmcQrx6rqTyLi/X2ke0mohyLAYgnKna8c2qY19ci5i7Q4d4cXNt4Nui
   Q==;
X-CSE-ConnectionGUID: kiEDH9xIR0aujLgFjO6lnw==
X-CSE-MsgGUID: s9FOoKmtQR+HopUw9GuFYA==
X-IronPort-AV: E=Sophos;i="6.18,214,1751241600"; 
   d="scan'208";a="1469011"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 14:30:02 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:23272]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.43.161:2525] with esmtp (Farcaster)
 id 6107cd3d-5fbe-4c88-a87b-1e89852fe40b; Mon, 1 Sep 2025 14:30:01 +0000 (UTC)
X-Farcaster-Flow-ID: 6107cd3d-5fbe-4c88-a87b-1e89852fe40b
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 1 Sep 2025 14:30:01 +0000
Received: from [192.168.30.195] (10.106.83.14) by
 EX19D022EUC002.ant.amazon.com (10.252.51.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 1 Sep 2025 14:30:00 +0000
Message-ID: <8dd43501-80be-43bf-8eac-a4265e7595ea@amazon.com>
Date: Mon, 1 Sep 2025 15:29:59 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v4 1/2] KVM: guest_memfd: add generic population via write
To: David Hildenbrand <david@redhat.com>, kernel test robot <lkp@intel.com>,
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>, "Roy, Patrick"
	<roypat@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring,
 Derek" <derekmn@amazon.com>, "Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20250828153049.3922-2-kalyazin@amazon.com>
 <202508310252.E5uFh1hx-lkp@intel.com>
 <be511fb0-217e-43b2-9744-f9b001bff389@redhat.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <be511fb0-217e-43b2-9744-f9b001bff389@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D001EUA004.ant.amazon.com (10.252.50.19) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 01/09/2025 11:09, David Hildenbrand wrote:

> On 30.08.25 20:56, kernel test robot wrote:
>> Hi Nikita,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on a6ad54137af92535cfe32e19e5f3bc1bb7dbd383]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Kalyazin- 
>> Nikita/KVM-guest_memfd-add-generic-population-via-write/20250828-233437
>> base:   a6ad54137af92535cfe32e19e5f3bc1bb7dbd383
>> patch link:    https://lore.kernel.org/r/20250828153049.3922-2- 
>> kalyazin%40amazon.com
>> patch subject: [PATCH v4 1/2] KVM: guest_memfd: add generic population 
>> via write
>> config: x86_64-randconfig-001-20250830 (https://download.01.org/0day- 
>> ci/archive/20250831/202508310252.E5uFh1hx-lkp@intel.com/config)
>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 
>> 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/ 
>> archive/20250831/202508310252.E5uFh1hx-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202508310252.E5uFh1hx- 
>> lkp@intel.com/
>>
>> All errors (new ones prefixed by >>, old ones prefixed by <<):
>>
>>>> ERROR: modpost: "filemap_remove_folio" [arch/x86/kvm/kvm.ko] undefined!
> 
> Right, that one is not exported.

Indeed.  Having a look at other .write_end implementations, it looks 
like the convention is zeroing the uncopied part instead of trying to 
remove the folio from the cache.  Will do it in the next version.

> 
> -- 
> Cheers
> 
> David / dhildenb
> 



Return-Path: <linux-kselftest+bounces-46630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 727F4C8DF76
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A729D34E7EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E5632C95D;
	Thu, 27 Nov 2025 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eZjPoS2V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D232E13E;
	Thu, 27 Nov 2025 11:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242405; cv=none; b=rE5zgdJhRYQXisHLqCeOgkZ0SPCIZqKKsvl/RhHyU/vQZCivoi6gSCPdDwb7CbU+suCzeNuP7xCAp8z1Ztm7orURQwt8n9ftLNv1R6SKZ07A42GIEzAFXTYPjLo6APcGLVyRtP8PhARhIMVT5HrSMf32si38DciUzSmehbDdkDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242405; c=relaxed/simple;
	bh=EVAUMDD+9PtvbCzAu8DAyYzmBCBcMdH1XaG8zBfI1ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E1WIQY1uqVrObIBOWJpRBZjYBShvONX65rgkRD8vrAtco6b4Dr1O+qhecDY844cRCsjkndEHLcbyHA9YMLQs+T4HomdNV8V14wJJUjPV/C6KZALtY1+Bi9LE5J0gULdo6fBmvN8FanefRQTrVMKFReb4vxQsaONI6X9XFVZYhIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eZjPoS2V; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764242403; x=1795778403;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=+H64Ah6mYGxHQfE73KQcSigtJh1K4kxYLJX7clH3BEI=;
  b=eZjPoS2VPN4tbKai6MD1kvmBKmpZnx4nGypVuqzcSJZ/cU8Rxi2hl/7A
   9DNziPhT2Fs+vCbPSpY2TYF/Dl+jtWQuzOny9WFGHxmEbL1DOOQ4CKxrf
   jvypK0KMjdNM3gICl16NAXQJQ8WmyQLWPPFedI1sECWvlmrl6gnRgfGCE
   3Ia81QAlw/6mEbLAxpooo+0X4jwnkb96J4as0EtAjMuIJ906vTXuBzQ7t
   zKUmSgEPsBK2tkjYeEEpf7BQ4PyozZSyIE83v5DBSDyuS/ZuV1e0PCLU9
   FZ84+P2YRkXMZ3voy6f1zB0rE929e2oi2Zzl3wTQ9tOgykRvIYWbPxAcj
   g==;
X-CSE-ConnectionGUID: D+oseAjuS/CfvMD+9yRiZQ==
X-CSE-MsgGUID: 2qf8pyqtR5OsfOhqRXaxyg==
X-IronPort-AV: E=Sophos;i="6.20,231,1758585600"; 
   d="scan'208";a="5780819"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 11:19:44 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:29782]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.211:2525] with esmtp (Farcaster)
 id 162dbd5c-9963-4950-b318-3a7250b738d9; Thu, 27 Nov 2025 11:19:44 +0000 (UTC)
X-Farcaster-Flow-ID: 162dbd5c-9963-4950-b318-3a7250b738d9
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 27 Nov 2025 11:19:37 +0000
Received: from [192.168.18.64] (10.106.82.32) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 27 Nov 2025
 11:19:36 +0000
Message-ID: <13d3a7a4-5cf8-4fbe-8dba-d565525a71c6@amazon.com>
Date: Thu, 27 Nov 2025 11:19:35 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v2 4/5] guest_memfd: add support for userfaultfd minor
 mode
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, "James
 Houghton" <jthoughton@google.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
	<peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
	<shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251125183840.2368510-1-rppt@kernel.org>
 <20251125183840.2368510-5-rppt@kernel.org>
 <bafb0c9e-9ce6-4294-b1d6-e32c41635add@amazon.com>
 <aSgpo1_ZSmxf84-p@kernel.org>
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
In-Reply-To: <aSgpo1_ZSmxf84-p@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUC004.ant.amazon.com (10.252.51.178) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 27/11/2025 10:36, Mike Rapoport wrote:
> On Wed, Nov 26, 2025 at 04:49:31PM +0000, Nikita Kalyazin wrote:
>> On 25/11/2025 18:38, Mike Rapoport wrote:
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> +#ifdef CONFIG_USERFAULTFD
>>> +static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t pgoff)
>>
>> We have to name it differently, otherwise it clashes with the existing one
>> in this file.
> 
> It's all David's fault! ;-P
> How about kvm_gmem_get_prepared_folio() ?

I'm afraid it may not be ideal due to preparedness tracking being 
removed from guest_memfd at some point [1].  Would it be too bad to add 
an indication to userfaultfd in the name somehow given that it's already 
guarded by the config?

[1] 
https://lore.kernel.org/linux-coco/20251113230759.1562024-1-michael.roth@amd.com

> 
> --
> Sincerely yours,
> Mike.



Return-Path: <linux-kselftest+bounces-34791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC920AD675D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A5F17A885
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BC1A5BA4;
	Thu, 12 Jun 2025 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O9F5KGYK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889021798F;
	Thu, 12 Jun 2025 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706397; cv=none; b=nqLwfu2jO4h1OTvBpUqaPiS9h/70OB6QXd2L5HID4WxUxsCneCIZIPu2y//Y60E4H1epFDJNdbeXusvbB1rjM5S5H63Z8mv+jIUjogSocLfOt1MVxma/RvfgcE2OVsB+rWE92e3cBenl5yiyBRQtpQz1bptrnGCPccIDm/BEQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706397; c=relaxed/simple;
	bh=A529S8Vleqan1qcvH6SvHyBHA86SoltMojWhrJbIxdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVVVNoPsC6Li/5wjPWoQpl9EsMGzahM/GMoan40UoldLaqv7wTpcSp0/zBhL2N0hsFkVX/O1oio/xILOKhZ+2r64HpRCFV225Zvt6hQcNcPo7zK2wt+SxdHUx8pOZgzNLCNov2Gs5MJUHh9jNIAtZttBUoxaXR3mhyJp8/Op/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O9F5KGYK; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749706385; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LzQR66W94G4bsKpijHQpbMtp4UKrhv0jCsJboyTcvWE=;
	b=O9F5KGYKqyXXDyvJXq4/c7yMTcptWyvPffYjZCW0HDkPLwOV51NRxMWYMUKPEnUgiW8scYDXE3GpnZEAIpT/1KcJJfU7M8DLSxTlVc5DxeMUw3WENeqip8Qepe3+L266vIbHhEm1as1n5KBNZG/tUFwjTI+/7UzsLmWQ84ugn3U=
Received: from 30.74.144.123(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdfbwSG_1749706384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 13:33:05 +0800
Message-ID: <96fb6664-9bec-43ac-8327-e3f5fd7c9ae6@linux.alibaba.com>
Date: Thu, 12 Jun 2025 13:33:04 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: mm: add shmem collpase as a default test
 item
To: "Bird, Tim" <Tim.Bird@sony.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "david@redhat.com" <david@redhat.com>
Cc: "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
 <baohua@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
 "ziy@nvidia.com" <ziy@nvidia.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
 <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
 <MW5PR13MB563297B61566E15E59B02330FD74A@MW5PR13MB5632.namprd13.prod.outlook.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <MW5PR13MB563297B61566E15E59B02330FD74A@MW5PR13MB5632.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/12 12:20, Bird, Tim wrote:
> collpase in the subject line should be collapse

Good catch. Will fix the typo. Thanks.

>> -----Original Message-----
>> From: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Subject: [PATCH 2/2] selftests: mm: add shmem collpase as a default test item
>>
>> Currently, we only test anonymous memory collapse by default. We should also add shmem collapse as a default test item to catch issues that
>> could break the test cases. Signed-off-by: Baolin Wang <baolin. wang@ linux. alibaba. com> --- tools/testing/selftests/mm/run_vmtests. sh
>>
>> Currently, we only test anonymous memory collapse by default. We should also
>> add shmem collapse as a default test item to catch issues that could break
>> the test cases.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
>> index 33fc7fafa8f9..a38c984103ce 100755
>> --- a/tools/testing/selftests/mm/run_vmtests.sh
>> +++ b/tools/testing/selftests/mm/run_vmtests.sh
>> @@ -485,6 +485,10 @@ CATEGORY="thp" run_test ./khugepaged
>>
>>   CATEGORY="thp" run_test ./khugepaged -s 2
>>
>> +CATEGORY="thp" run_test ./khugepaged all:shmem
>> +
>> +CATEGORY="thp" run_test ./khugepaged -s 4 all:shmem
>> +
>>   CATEGORY="thp" run_test ./transhuge-stress -d 20
>>
>>   # Try to create XFS if not provided
>> --
>> 2.43.5
>>


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84E71B14CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgDTSiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 14:38:08 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14145 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgDTSiI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 14:38:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9deb9d0000>; Mon, 20 Apr 2020 11:36:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 11:38:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 11:38:07 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 18:38:07 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 18:38:04 +0000
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
To:     Joe Perches <joe@perches.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
 <20200417235458.13462-4-rcampbell@nvidia.com>
 <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <e2006240-27b8-ceef-68bf-2769d2a77ccd@nvidia.com>
Date:   Mon, 20 Apr 2020 11:38:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <13a8e8efd56d00945e375760f7f065fb020287a1.camel@perches.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587407773; bh=GJO2T/9pMFVSG1zuEWD7YSOrm1UFp+OyX1sarWLp1Q4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qdR0buXekI0fSG1y/vcH+5q5zr2hB8qT2ACM0FV9Z+iN+ZS5y0IF4H50jZNsBIMvn
         Mm8Dmji15xrUgzyYjObLxvQtgVRP+lsHL+3KagOM+1/lVSJqHCTjvX6OWFat9hJMjp
         ghUHzyVXNzgIDGvQSMb+VnodCQeAjhiUbO0viX7k7mvtGPM3mMxq1q6heoDuMfnIgI
         tkOow5KGZfkSD+/WL1roUKAhTSLLoM8eHzRrdV22OsCMOyClEFoi8jIwJVRacrkO2T
         kKw8H8pk1LLchbd3BY+31Y6ifu6keFUP4WK/EfAgE7m/qks2yo/8ReyGzOK0OYvOQy
         CXSFL5Rjpw36g==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/17/20 5:59 PM, Joe Perches wrote:
> On Fri, 2020-04-17 at 16:54 -0700, Ralph Campbell wrote:
>> Add files for HMM selftests.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> ---
>>   MAINTAINERS | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e64e5db31497..072921b7bae2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7729,6 +7729,9 @@ S:	Maintained
>>   F:	Documentation/vm/hmm.rst
>>   F:	include/linux/hmm*
>>   F:	mm/hmm*
>> +F:	include/uapi/linux/test_hmm*
>> +F:	lib/test_hmm*
>> +F:	tools/testing/selftests/vm/*hmm*
> 
> file patterns in alphabetic order please:
> 
> F	Documentation/vm/hmm.rst
> F:	include/linux/hmm*
> F:	include/uapi/linux/test_hmm*
> F:	lib/test_hmm*
> F:	mm/hmm*
> F:	tools/testing/selftests/vm/*hmm*	
> 

No problem. Will fix in the next posting.
Thanks.

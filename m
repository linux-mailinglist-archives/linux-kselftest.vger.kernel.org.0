Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1C2DE048
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbgLRJLs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 04:11:48 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12005 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgLRJLs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 04:11:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fdc722b0001>; Fri, 18 Dec 2020 01:11:07 -0800
Received: from [10.2.61.104] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec
 2020 09:11:00 +0000
Subject: Re: [PATCH v4 09/10] selftests/vm: test flag is broken
From:   John Hubbard <jhubbard@nvidia.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <sashal@kernel.org>,
        <tyhicks@linux.microsoft.com>, <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jgg@ziepe.ca>, <peterz@infradead.org>,
        <mgorman@suse.de>, <willy@infradead.org>, <rientjes@google.com>,
        <linux-doc@vger.kernel.org>, <ira.weiny@intel.com>,
        <linux-kselftest@vger.kernel.org>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
 <20201217185243.3288048-10-pasha.tatashin@soleen.com>
 <8879f12c-2aed-1615-1298-7cf9596acc95@nvidia.com>
Message-ID: <d0b1fec7-cc18-68d2-c574-639e665c137c@nvidia.com>
Date:   Fri, 18 Dec 2020 01:11:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <8879f12c-2aed-1615-1298-7cf9596acc95@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608282667; bh=3mPuCxRz8KYq0pwcFButq0DOd57iVq04TlvZG8ID//Y=;
        h=Subject:From:To:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=sMmU4YUHis88+7q8FOrjOMAnSAnAGKQ2GV412pBnkj07s0+IB6Dg0kzx6uXmT0FoA
         D9CtmbOLgNVPgEL4CjkpMgfDKZUoBsABCOj6FR/OT/Ayv3A7Mi/9K3LqDeVL/gVFke
         11h//FrtmvBwAkHQd9dQi5uFLVyxVWtTN0/BFa3iWKJUUNLnLaN1+yvzelntj+5Qmb
         kDkaFu3PaOExGyCeNYrlZUXyb1rhU+0ACDWvwHnqWWBu/Q9bo/NUDFniBG8FrVCx00
         pINgEsVY0Wx6JmiWmFHoZO5zfTsFHpPRXyi8VquTqtYw9OmKYL1wIDKPMQmV2kWytw
         vENCsi8xBVWIg==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/18/20 1:06 AM, John Hubbard wrote:
>> Add a new test_flags field, to allow raw gup_flags to work.
> 
> I think .test_control_flags field would be a good name, to make it very
> clear that it's not destined for gup_flags. Just .test_flags is not quite
> as clear a distinction from .gup_flags, as .test_control_flags is, IMHO.
> 

And maybe renaming .flags to .gup_flags, just to make it really clear.


thanks,
-- 
John Hubbard
NVIDIA

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D7B1B14D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDTSj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 14:39:28 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4729 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDTSj2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 14:39:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9dec220002>; Mon, 20 Apr 2020 11:38:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 11:39:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 11:39:27 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 18:39:27 +0000
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 18:39:26 +0000
Subject: Re: [PATCH v9 3/3] MAINTAINERS: add HMM selftests
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jerome Glisse" <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20200417235458.13462-1-rcampbell@nvidia.com>
 <20200417235458.13462-4-rcampbell@nvidia.com> <20200418060651.GI3083@unreal>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <95f046e5-74c4-cb34-c7a0-056d47e131cb@nvidia.com>
Date:   Mon, 20 Apr 2020 11:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200418060651.GI3083@unreal>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587407906; bh=UO48xKNQQkbx0fToE/eGIFWIt+8G+Q0r/bKLmM4b5VI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kQXIwptChFeHtXFhW/NZVAWCUcyDN1AFmkVJszwzOlnCtzrAIkZFy+p/WU8c20lX+
         gf/9Hgl4TJYcIztiIlHwN470CqvFV89LJEeDlDxO3cvWB7RKbc5UtyDgixJ4s+86oJ
         Pt+FMveMttbKPLRgnewlKXzsqf9n10I4PKFp8nbaGGe/0WpLnQlq9kmtw21bt6XXwf
         ALib0Lzlkb8/iIN3SL2T8eXrhwL+IU/MEuBp7nX/X8tpaVyJyGtlhRT3rqr3yhkpQc
         jtKCbf9qtVijfwCN8XRIQnzcH6KdGPe70Ow8YAP7fuazdUpW61tJZDqsciFGoPfzSd
         Y19u1ZETdBNYw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/17/20 11:06 PM, Leon Romanovsky wrote:
> On Fri, Apr 17, 2020 at 04:54:58PM -0700, Ralph Campbell wrote:
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
> 
> This line is not needed anymore.
> 
> Thanks

Thank you. I'll fix this in the next posting.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE83B9C58
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhGBGwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 02:52:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9443 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGBGwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 02:52:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GGQbS4ggVzZppL;
        Fri,  2 Jul 2021 14:46:28 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 14:49:36 +0800
Received: from [10.174.185.179] (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 2 Jul 2021 14:49:35 +0800
Subject: Re: [PATCH] KVM: selftests: do not require 64GB in
 set_memory_region_test
To:     Christian Borntraeger <borntraeger@de.ibm.com>
CC:     Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <vkuznets@redhat.com>, <wanghaibin.wang@huawei.com>
References: <20210701160425.33666-1-borntraeger@de.ibm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <93ff00d3-b369-e00e-f172-7cc5375a6485@huawei.com>
Date:   Fri, 2 Jul 2021 14:49:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210701160425.33666-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021/7/2 0:04, Christian Borntraeger wrote:
> Unless the user sets overcommit_memory or has plenty of swap, the latest
> changes to the testcase will result in ENOMEM failures for hosts with
> less than 64GB RAM. As we do not use much of the allocated memory, we
> can use MAP_NORESERVE to avoid this error.

Had a go on arm64:

Tested-by: Zenghui Yu <yuzenghui@huawei.com>

Thanks,
Zenghui

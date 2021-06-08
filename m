Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E356A39FCC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jun 2021 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhFHQso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Jun 2021 12:48:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhFHQsn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Jun 2021 12:48:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158GiAdW079559;
        Tue, 8 Jun 2021 16:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3MCNTxtibR4QUjCnqfXQaGQ4eGeXuS5SVA3/0ceyeUw=;
 b=kfFz+Jm65WcTnvatLmIPLfo1BGKBZvWFAmfr/o6EkzKRU1Ka4kscIowMRiv/8xTs55Nx
 qILJhIo8s0xISN50yK2fbK5QsUV2xoZM9L+csvtD1gDJWxgq6ZvhNKBH3J+QrKMdQPM8
 cLXrv08sxEbzI13ZQt4tGSh0uFezk7vzE/lvF5PUUV7v8GjbPNFIB5a2VE4RRk6XbyUr
 9NCnpNTtuA+4C7nTE+g8i2UXzbBD8vkAUQuvy1N2Tdgd53XftDoSLtyDSJipuuEgc4ye
 mMZaHNHL9FkMg/tB0j829BaOHUTyDj8uHle9WVa3h6S6FdB4xVGN2XqPsWoowzO9ZLs5 kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3914qun7pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 16:46:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 158Gj3iY167990;
        Tue, 8 Jun 2021 16:46:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 390k1r59gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jun 2021 16:46:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 158Gkh1T001132;
        Tue, 8 Jun 2021 16:46:43 GMT
Received: from [10.175.210.6] (/10.175.210.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jun 2021 09:46:42 -0700
From:   "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 0/3] Restore extra_mem_pages and add slot0_mem_pages
To:     Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        drjones@redhat.com, pbonzini@redhat.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210608233816.423958-1-zhenzhong.duan@intel.com>
Message-ID: <aee3888c-92c4-57b0-1cb4-1b15b60edda9@oracle.com>
Date:   Tue, 8 Jun 2021 18:46:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608233816.423958-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106080107
X-Proofpoint-ORIG-GUID: 54XHZbqfw9IzNlIwPx7ogwKqGUmPKvHB
X-Proofpoint-GUID: 54XHZbqfw9IzNlIwPx7ogwKqGUmPKvHB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10009 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080107
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 09.06.2021 01:38, Zhenzhong Duan wrote:
> (39fe2fc96694 "selftests: kvm: make allocation of extra memory take effect")
> changed the meaning of extra_mem_pages and treated it as slot0 memory size.
> 
> In fact extra_mem_pages is used for non-slot0 memory size, there is no custom
> slot0 memory size support. See discuss in https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/3/551__;!!GqivPVa7Brio!K2FcwkE2nzlPAWgBHh6o6jtaWe66RMlfkb-b_8mAtVa5d8ez_sArupY-EqIquuCj2sorww$
> for more details.
> 
> This patchset restores extra_mem_pages's original meaning and adds support for
> custom slot0 memory with a new parameter slot0_mem_pages.
> 
> Run below command, all 39 tests passed.
> # make -C tools/testing/selftests/ TARGETS=kvm run_tests
> 
> Zhenzhong Duan (3):
>    Revert "selftests: kvm: make allocation of extra memory take effect"
>    Revert "selftests: kvm: fix overlapping addresses in
>      memslot_perf_test"
>    selftests: kvm: Add support for customized slot0 memory size
> 
>   .../testing/selftests/kvm/include/kvm_util.h  |  7 +--
>   .../selftests/kvm/kvm_page_table_test.c       |  2 +-
>   tools/testing/selftests/kvm/lib/kvm_util.c    | 47 +++++++++++++++----
>   .../selftests/kvm/lib/perf_test_util.c        |  2 +-
>   .../testing/selftests/kvm/memslot_perf_test.c |  2 +-
>   5 files changed, 45 insertions(+), 15 deletions(-)
> 

Looks good to me, thanks!

For the whole series:
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

BTW: It looks like there was something wrong with the clock (or time zone
setup) of the machine this series was posted from since the "Date:"
headers on these four messages say they were sent Jun 8, 23:38 UTC
(while the time right now is Jun 8, 16:45 UTC).

Maciej

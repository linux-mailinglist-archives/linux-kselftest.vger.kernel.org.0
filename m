Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3121A2D50
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Apr 2020 03:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgDIBZx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 21:25:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39588 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDIBZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 21:25:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0391Do6r152904;
        Thu, 9 Apr 2020 01:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ojvWGTH16FqGalLxUHiUu7u1GemaC0gdhKfWhTg68f0=;
 b=JiM67cz8h5VnilGB4K6xUuzTNv002U18cMZdIGxzylwgK5PtRIGSwXGtSOoiQwnIO1xW
 Xu/S40UOac+gelZenkgFK+Pje+QuA0JdjIIqsHYYvkIQuDMNpS5WW4v7KrOT25PtMF/L
 i7rRCY8d9HJA/Y+V8r31M7crNoZ/+RWTVb+d8B2cvW/w0Gg8NTHoIqWlNgNQlUwMS17I
 7EDYXtHRbhNJEXsfccHBL1CSjzKvfp9bd1rwtBZ32BhiXjWKB+64BMbVEgHcHUMa76/v
 RPXD8olYyH+GVNDGsMvvbAXkORYO5MXGnNJgo83OZ1Sw277M18Mu14CTEVcmKEnajk4w hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3091m0xr27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 01:25:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0391BZY8039144;
        Thu, 9 Apr 2020 01:25:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3091m60k08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 01:25:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0391PnnR027694;
        Thu, 9 Apr 2020 01:25:49 GMT
Received: from localhost.localdomain (/10.159.148.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 18:25:48 -0700
Subject: Re: [PATCH v4 1/2] selftests: kvm: Add vm_get_fd() in kvm_util
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200408220818.4306-1-wainersm@redhat.com>
 <20200408220818.4306-2-wainersm@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <734ebc46-ff31-708b-5a2f-8bda248cd290@oracle.com>
Date:   Wed, 8 Apr 2020 18:25:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200408220818.4306-2-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090006
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 4/8/20 3:08 PM, Wainer dos Santos Moschetta wrote:
> Introduces the vm_get_fd() function in kvm_util which returns
> the VM file descriptor.
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>   tools/testing/selftests/kvm/include/kvm_util.h | 1 +
>   tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index a99b875f50d2..4e122819ee24 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -254,6 +254,7 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm);
>   unsigned int vm_get_page_size(struct kvm_vm *vm);
>   unsigned int vm_get_page_shift(struct kvm_vm *vm);
>   unsigned int vm_get_max_gfn(struct kvm_vm *vm);
> +int vm_get_fd(struct kvm_vm *vm);
>   
>   unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size);
>   unsigned int vm_num_host_pages(enum vm_guest_mode mode, unsigned int num_guest_pages);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8a3523d4434f..3e36a1eb8771 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1734,6 +1734,11 @@ unsigned int vm_get_max_gfn(struct kvm_vm *vm)
>   	return vm->max_gfn;
>   }
>   
> +int vm_get_fd(struct kvm_vm *vm)
> +{
> +        return vm->fd;
> +}
> +


I am just trying to understand why we need a separate function when the 
'vm' variable is all local within the same file. There are a number of 
places in kvm_util.c where it is used directly.

>   static unsigned int vm_calc_num_pages(unsigned int num_pages,
>   				      unsigned int page_shift,
>   				      unsigned int new_page_shift,

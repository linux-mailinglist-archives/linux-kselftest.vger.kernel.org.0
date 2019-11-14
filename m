Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64671FBD1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2019 01:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNAjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Nov 2019 19:39:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42792 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Nov 2019 19:39:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAE0dDrM002254;
        Thu, 14 Nov 2019 00:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=9d1esZB7SWlRya/YjnjIH7Q3Ck31LnlMXp8qkk7HO0s=;
 b=UY2+TF3QyowqKfFKm+/y1PC64u7FJdcEUeOB7OM/BgFFN1/hEyIWE3Vw4ZL4Fg1/XDR2
 Ya6VD5wt3MJx/+DV1uB99vbd4sEytDMlg6V0ALVEHaeAlcQoSSImX53+3BLW47q+cL4R
 wQg2/vTtst4u/T4289vQZSN0wjFXE8XtKyaumTBeTtbCH6LguzvDCI7zLL42SiKQ50eD
 LmlCZJOLPL1OTJ2Tmyhwcv8eNCdhEmF2T/Zy1MRexHWeoigZW2w8X5O09pRmFDxVzaon
 y1Q9ihKP0i5FkU1lVhv5clbZKkMhPblJ1L2Q+ZV0mOTMmwSVj/UTajoq+ApkpRONCYvR Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w5p3qyy91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 00:39:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAE0cCl3077266;
        Thu, 14 Nov 2019 00:39:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w8g18ewpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 00:39:49 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAE0dmTr026703;
        Thu, 14 Nov 2019 00:39:49 GMT
Received: from [10.159.235.45] (/10.159.235.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Nov 2019 16:39:48 -0800
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Subject: Re: [PATCH] selftests: kvm: Simplify loop in kvm_create_max_vcpus
 test
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     shuah@kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191112142111.13528-1-wainersm@redhat.com>
Message-ID: <c814d608-538d-1d1e-c3f2-92d53624cc06@oracle.com>
Date:   Wed, 13 Nov 2019 16:39:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191112142111.13528-1-wainersm@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911140002
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9440 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911140002
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/12/19 6:21 AM, Wainer dos Santos Moschetta wrote:
> On kvm_create_max_vcpus test remove unneeded local
> variable in the loop that add vcpus to the VM.
>
> Signed-off-by: Wainer dos Santos Moschetta<wainersm@redhat.com>
> ---
>   tools/testing/selftests/kvm/kvm_create_max_vcpus.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> index 231d79e57774..6f38c3dc0d56 100644
> --- a/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> +++ b/tools/testing/selftests/kvm/kvm_create_max_vcpus.c
> @@ -29,12 +29,9 @@ void test_vcpu_creation(int first_vcpu_id, int num_vcpus)
>   
>   	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
>   
> -	for (i = 0; i < num_vcpus; i++) {
> -		int vcpu_id = first_vcpu_id + i;
> -
> +	for (i = first_vcpu_id; i < first_vcpu_id + num_vcpus; i++)
>   		/* This asserts that the vCPU was created. */
> -		vm_vcpu_add(vm, vcpu_id);
> -	}
> +		vm_vcpu_add(vm, i);
>   
>   	kvm_vm_free(vm);
>   }
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

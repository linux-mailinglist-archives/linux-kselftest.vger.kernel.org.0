Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D22500C12
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbiDNLZQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242654AbiDNLZP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EF8567B;
        Thu, 14 Apr 2022 04:22:49 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EA50BD020679;
        Thu, 14 Apr 2022 11:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=prRqG1020rYLqhPnoJsW2DYEpB7dbY9CtzYY8sEK/Qo=;
 b=CGJb1O6WFoF4LkighIc400i915sMwxTG2p0VgEnjtjjCd0V9EG3CuqneOQbpivggL6SN
 FwO9jzq7gpw6TLPBc+b3zmD43m7TbvIHvZFZ1PtwVWFbkaILLB+GAIXB8Ul3zWhVZpYN
 pt83/sd+OocnoON3O0ZFZIfb5715vuA3hJAcw3RCexnZ4MhaRqFKiWJukWjJXdxvDHYr
 TScwSrlFavIVjjBjuUzJTjSH0GcxdYCrivzeAuY73yGQlbqs6bEMu2YDFvbqQg7VFOXj
 nq9y4xsszg7UxNvHtoGE0QmSJ9jVIw1TRu683XKf5+o0AkwH0P4v6fh5sEHMvVWTdAdO BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fefpgkju2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 11:22:46 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23EBEs4G013776;
        Thu, 14 Apr 2022 11:22:46 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fefpgkjtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 11:22:46 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EBHw9K024437;
        Thu, 14 Apr 2022 11:22:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3fb1s8xrg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 11:22:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EBA7ZN34472422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 11:10:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92993AE045;
        Thu, 14 Apr 2022 11:22:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 275B4AE04D;
        Thu, 14 Apr 2022 11:22:41 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.140])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Apr 2022 11:22:41 +0000 (GMT)
Date:   Thu, 14 Apr 2022 13:22:39 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Silence compiler warning in the
 kvm_page_table_test
Message-ID: <20220414132239.1653cf9c@p-imbrenda>
In-Reply-To: <20220414103031.565037-1-thuth@redhat.com>
References: <20220414103031.565037-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G-ZJuh96d7s-JRDrfilUkKPQpkL11enV
X-Proofpoint-ORIG-GUID: _PoZ7T1NFmVVAkUu_nzsq6N8pa1F0UfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_03,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140060
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 14 Apr 2022 12:30:31 +0200
Thomas Huth <thuth@redhat.com> wrote:

> When compiling kvm_page_table_test.c, I get this compiler warning
> with gcc 11.2:
> 
> kvm_page_table_test.c: In function 'pre_init_before_test':
> ../../../../tools/include/linux/kernel.h:44:24: warning: comparison of
>  distinct pointer types lacks a cast
>    44 |         (void) (&_max1 == &_max2);              \
>       |                        ^~
> kvm_page_table_test.c:281:21: note: in expansion of macro 'max'
>   281 |         alignment = max(0x100000, alignment);
>       |                     ^~~
> 
> Fix it by adjusting the type of the absolute value.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/kvm_page_table_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
> index ba1fdc3dcf4a..2c4a7563a4f8 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -278,7 +278,7 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
>  	else
>  		guest_test_phys_mem = p->phys_offset;
>  #ifdef __s390x__
> -	alignment = max(0x100000, alignment);
> +	alignment = max(0x100000UL, alignment);
>  #endif
>  	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
>  


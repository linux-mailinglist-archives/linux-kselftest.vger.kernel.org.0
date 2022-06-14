Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D812254AE8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbiFNKi5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 06:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFNKi4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 06:38:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468C35252;
        Tue, 14 Jun 2022 03:38:55 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E96fHg024970;
        Tue, 14 Jun 2022 10:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fenuCRyA2MbBa5B5nqlyL4fDAInAfNqYcCHTaK+ep6c=;
 b=suhlY2Ae8Zzv/ThqTEhWxC4kz+32aBI0a+u/g52ayzRnRcUgwGfYjNdfsv+GQ3knLuCf
 Su/MUA+K5IhD1SE1uhVqy9jrejPhLgHYMETkUib1AmrTcQMTEUzehdJca3g6KGzOYRGD
 wzOBTNc9EtDUrERKvAqu0+/gP0GaroH730HLiWUWzJ196+WIPUe7ALzwLqiJ4CZL8hiL
 nnnphSTtdiL/23YMg4dGIJ2ls56Dlp+pr1G9qVqthSZoUdSl8eMiGo0WapwpcPRdDGTG
 etsJ7AaW4r5CinIuz7BsbOdfACS2MvjWA5npXbv+OmUeb19ZAKf16IaG7eTfXoRPHTk3 JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpp6hc952-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:38:47 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25E96uKM025759;
        Tue, 14 Jun 2022 10:38:47 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpp6hc94e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:38:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EAaom7021792;
        Tue, 14 Jun 2022 10:38:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajc787-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 10:38:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EAcfks8716654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 10:38:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B9DB42042;
        Tue, 14 Jun 2022 10:38:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA8342041;
        Tue, 14 Jun 2022 10:38:39 +0000 (GMT)
Received: from [9.171.29.58] (unknown [9.171.29.58])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 10:38:37 +0000 (GMT)
Message-ID: <07576ae9-9798-316f-d33e-10c91faeebfb@linux.ibm.com>
Date:   Tue, 14 Jun 2022 12:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/4] KVM: s390: selftests: Use TAP interface in the
 memop test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org
References: <20220531101554.36844-1-thuth@redhat.com>
 <20220531101554.36844-2-thuth@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <20220531101554.36844-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nKt6VK9FhXp14FtCBnSww5of7OpRYt0T
X-Proofpoint-ORIG-GUID: citumcxVuJL2MZYB4n2rHeF_iUEaQ4ZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_03,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140041
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/31/22 12:15, Thomas Huth wrote:
> The memop test currently does not have any output (unless one of the
> TEST_ASSERT statement fails), so it's hard to say for a user whether
> a certain new sub-test has been included in the binary or not. Let's
> make this a little bit more user-friendly and include some TAP output
> via the kselftests.h interface.
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 95 ++++++++++++++++++-----
>  1 file changed, 77 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 49f26f544127..e704c6fa5758 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -14,6 +14,7 @@
>  

[...]

>  int main(int argc, char *argv[])
>  {
> -	int memop_cap, extension_cap;
> +	int memop_cap, extension_cap, idx;
>  
>  	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
>  
> +	ksft_print_header();
> +
>  	memop_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP);
>  	extension_cap = kvm_check_cap(KVM_CAP_S390_MEM_OP_EXTENSION);
>  	if (!memop_cap) {
> -		print_skip("CAP_S390_MEM_OP not supported");
> -		exit(KSFT_SKIP);
> +		ksft_exit_skip("CAP_S390_MEM_OP not supported.\n");
>  	}
>  
> -	test_copy();
> -	if (extension_cap > 0) {
> -		test_copy_key();
> -		test_copy_key_storage_prot_override();
> -		test_copy_key_fetch_prot();
> -		test_copy_key_fetch_prot_override();
> -		test_errors_key();
> -		test_termination();
> -		test_errors_key_storage_prot_override();
> -		test_errors_key_fetch_prot_override_not_enabled();
> -		test_errors_key_fetch_prot_override_enabled();
> -	} else {
> -		print_skip("storage key memop extension not supported");
> +	ksft_set_plan(ARRAY_SIZE(testlist));
> +
> +	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
> +		if (testlist[idx].extension >= extension_cap) {

This is reversed, should be

   		if (testlist[idx].extension <= extension_cap) {
or
		if (extension_cap >= testlist[idx].extension) {

I'd prefer the latter.

> +			testlist[idx].test();
> +			ksft_test_result_pass("%s\n", testlist[idx].name);
> +		} else {
> +			ksft_test_result_skip("%s - extension level %d not supported\n",
> +					      testlist[idx].name,
> +					      testlist[idx].extension);
> +		}
>  	}
> -	test_errors();
>  
> -	return 0;
> +	ksft_finished();	/* Print results and exit() accordingly */
>  }


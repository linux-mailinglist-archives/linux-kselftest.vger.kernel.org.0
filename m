Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B042538FD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343596AbiEaL3d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiEaL3c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 07:29:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4815956FBE;
        Tue, 31 May 2022 04:29:31 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VADnwf008819;
        Tue, 31 May 2022 11:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=MWJNEvmLnQ7b1SoYG+r2ZoWJVqcH6a53P8JH4dFdcvg=;
 b=EeAI+GU2aeitzyymDENs4vP/E/C4Xlo5EPydGcBJk90GDkYafGNJJuMYb8nMweaCw6JR
 8neJFL/fLusTwUuM0O2ZT3fhQ7GmJg8ivkHkKJB1nZINz6gQzx5cFHkv9zggGdQzXCf/
 ZWQDyb4rTPfSNataZpij8/qPNmiA3AupVErHFKoNtuuJGvaxv0n3XHbMYRYESQf84ICL
 xUwVlJgiRv9Iw5JJEXRkgDt8apgRqMNfPfEi2t4ATUlukhh8zLxuKguGjiXLvGn7WYwd
 EeY6TWsvm0VNCYY8g31OBkXPkecz17AXtJgGN5hDggPx2xI7ONRS/9d7gQqy4tyNq98U tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdh3118up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:29:28 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24VAFmgE018942;
        Tue, 31 May 2022 11:29:27 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdh3118u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:29:27 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24VBLkol022481;
        Tue, 31 May 2022 11:29:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3gbcb7k1xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 11:29:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24VBTMXb47644982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 11:29:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24280A405B;
        Tue, 31 May 2022 11:29:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87F3EA4054;
        Tue, 31 May 2022 11:29:21 +0000 (GMT)
Received: from [9.171.36.152] (unknown [9.171.36.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 May 2022 11:29:21 +0000 (GMT)
Message-ID: <a1b60913-c261-f8f0-d8bc-a536dcb64c52@linux.ibm.com>
Date:   Tue, 31 May 2022 13:29:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 0/4] KVM: s390: selftests: Provide TAP output in tests
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20220531101554.36844-1-thuth@redhat.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220531101554.36844-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j5mIJ4VbVYQWbpKnQvweuT8s-MBOBH7c
X-Proofpoint-GUID: 9YIdFaTq2U7r2UXf7Hy5Ab5caIFuWj2i
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_04,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205310058
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 31.05.22 um 12:15 schrieb Thomas Huth:
> This patch series is motivated by Shuah's suggestion here:
> 
>   https://lore.kernel.org/kvm/d576d8f7-980f-3bc6-87ad-5a6ae45609b8@linuxfoundation.org/
> 
> Many s390x KVM selftests do not output any information about which
> tests have been run, so it's hard to say whether a test binary
> contains a certain sub-test or not. To improve this situation let's
> add some TAP output via the kselftest.h interface to these tests,
> so that it easier to understand what has been executed or not.
> 
> v4:
>   - Rebased to include test_termination() now in the memop test
>   - Reworked the extension capability check in the memop test
> 
> v3:
>   - Added comments / fixed cosmetics according to Janosch's and
>     Janis' reviews of the v2 series
>   - Added Reviewed-by tags from the v2 series
> 
> v2:
>   - Reworked the extension checking in the first patch
>   - Make sure to always print the TAP 13 header in the second patch
>   - Reworked the SKIP printing in the third patch
> 
> Thomas Huth (4):
>    KVM: s390: selftests: Use TAP interface in the memop test
>    KVM: s390: selftests: Use TAP interface in the sync_regs test
>    KVM: s390: selftests: Use TAP interface in the tprot test
>    KVM: s390: selftests: Use TAP interface in the reset test
> 
>   tools/testing/selftests/kvm/s390x/memop.c     | 95 +++++++++++++++----
>   tools/testing/selftests/kvm/s390x/resets.c    | 38 ++++++--
>   .../selftests/kvm/s390x/sync_regs_test.c      | 87 +++++++++++++----
>   tools/testing/selftests/kvm/s390x/tprot.c     | 29 +++++-
>   4 files changed, 197 insertions(+), 52 deletions(-)
> 

Thanks applied and queued.

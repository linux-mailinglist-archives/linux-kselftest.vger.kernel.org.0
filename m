Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63E52A184
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 14:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbiEQM2h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiEQM2h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 08:28:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDAE496AF;
        Tue, 17 May 2022 05:28:35 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HCQ1Ps019840;
        Tue, 17 May 2022 12:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ldJSu8Gj38qWAQTY4CqvvEJ9n4CNuGGZuKHI4ooLuAw=;
 b=T27dey9xi4Sfno35TFM81TMa9bNQ2+sSEoizI7m5HpCRRCMU1fafCftOHdBDg9J4Ei8V
 oYSIfk261pMtDzSw+U/3BdU1MBypLIvmFSz02Gu66orbyPjnl4c6HhtInyRkHe7m4+zU
 sWJxjJhvEVZHWo10KW7UGUK9qqKq2C5MzENzrYzbY8TdaZCdKrn5hCTZPRyvwrB7Ytvz
 6HGmBrSbSJRIbeJTBs+8qjZG4NtIEOas62iN5/NKmXzrWcBLy5ZFHnHICS3ceKoX6J1m
 59JqqE0lPrWAWQUTJcvtSw47l/HtwxCke0mfLG5tj6flans7bnCIyNtVgDBDAPhmgRly SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4bq602cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:28:32 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24HCQcmX021630;
        Tue, 17 May 2022 12:28:31 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4bq602bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:28:31 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24HCNj3D027002;
        Tue, 17 May 2022 12:28:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3g2428ubv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 12:28:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24HCSQ6c32047544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 12:28:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4550752050;
        Tue, 17 May 2022 12:28:26 +0000 (GMT)
Received: from [9.171.49.46] (unknown [9.171.49.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 618F55204E;
        Tue, 17 May 2022 12:28:25 +0000 (GMT)
Message-ID: <4b780f74-ceb3-58d0-572f-7920852711d1@linux.ibm.com>
Date:   Tue, 17 May 2022 14:28:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/2] Dirtying, failing memop: don't indicate
 suppression
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220512131019.2594948-1-scgl@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220512131019.2594948-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AceFzO7f_1pGkFDxXb0lOp8WzABQ7igj
X-Proofpoint-ORIG-GUID: VAPCMze-H9zsyBaxHoDnQM3TUdckm4Cb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_02,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 mlxlogscore=887 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170073
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 12.05.22 um 15:10 schrieb Janis Schoetterl-Glausch:
> If a memop fails due to key checked protection, after already having
> written to the guest, don't indicate suppression to the guest, as that
> would imply that memory wasn't modified.
> 
> This could be considered a fix to the code introducing storage key
> support, however this is a bug in KVM only if we emulate an
> instructions writing to an operand spanning multiple pages, which I
> don't believe we do.
> 
> v2 -> v3
>   * tweak commit message
>   * explicitly reset the protection code to 0 on termination
>   * use variable to pass termination arg
>   * add documentation
>   * fix magic constant in selftest
> 
> Given the changes I did not pick up the r-b's.

Claudio, you had reviewed the first one. Is this still valid?

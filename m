Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C188268DD84
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 17:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjBGQCI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjBGQCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 11:02:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FB7ED6;
        Tue,  7 Feb 2023 08:02:06 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317FTRHs007244;
        Tue, 7 Feb 2023 16:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bmDLRTDaS2pyy0PBVJN4mT+mu+LecWrP1hk3Aqmlw3o=;
 b=VObsiA0D7HvXBfBj0zDcdSqjr8IbGuX4SeYXGrumWkkpeRmLAaXgLpNEzXavp/DmUnTR
 aZuEsMeGQNl4u/DgfyYbLSbrHPCFzXuWcFTyKbYR2wiuQdvhBkvq3WK3UD2ilxBXVnkf
 BykqVJjAaisXaSlkffXShjTRf2kBEXqjtLjMuDS/0eeUrrGWDHsV2HK5Z58GPBRGdICW
 VMopB3hBInwnU6U/NZBpmU6I6CBdL70E379hgYz+OZ9aK8hHcEaTlWVgjoxSeKnV2nbO
 99qgMMC5BiXAUt0h9GtbaFk7msDsbyGOGAgqIIIcbHkJ9jwtgE4SQDhoQXG+RLjecunR wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpktpucu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 16:01:59 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317CgE50023533;
        Tue, 7 Feb 2023 16:01:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpktpubn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 16:01:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31775LNI021137;
        Tue, 7 Feb 2023 16:01:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06kt29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 16:01:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317G1qiW40763890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 16:01:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C593920043;
        Tue,  7 Feb 2023 16:01:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA3820040;
        Tue,  7 Feb 2023 16:01:52 +0000 (GMT)
Received: from [9.171.52.227] (unknown [9.171.52.227])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 16:01:51 +0000 (GMT)
Message-ID: <3ac01297-a816-8e8e-df63-3ae54ef99c16@linux.ibm.com>
Date:   Tue, 7 Feb 2023 17:01:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 14/14] KVM: s390: selftest: memop: Add cmpxchg tests
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20230206164602.138068-1-scgl@linux.ibm.com>
 <20230206164602.138068-15-scgl@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230206164602.138068-15-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lk1_SgIPrWzKqi_A6zWkdlGMzjgsgDWc
X-Proofpoint-GUID: 9Tn9faCoWfIQfgrRyRXQigdZh5ugv0Y0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=788
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070138
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/6/23 17:46, Janis Schoetterl-Glausch wrote:
> Test successful exchange, unsuccessful exchange, storage key protection
> and invalid arguments.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

It's getting progressively harder to understand this test which isn't 
your fault. If this continues I'll need to have a closer look at the 
general kvm kselftest harness or try to find / write a new harness.

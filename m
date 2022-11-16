Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377462C90C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 20:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiKPThH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 14:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiKPThA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 14:37:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A53DCC;
        Wed, 16 Nov 2022 11:36:59 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGJMW4D029970;
        Wed, 16 Nov 2022 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DH6SSOEc4QFO33yxxehih3j5s7PtpOkQskyPJnQBR5A=;
 b=TQmEIzVllm8hp7+JycZE4usx2fsWNV+7/3rZd6+AH1zW1kZuoNJNy8CnyxiJrB7H4+RM
 2fPGZDhVAfzSzYzAmRdEc2z29vlMZqHSh9zL7JuW8Blu6Ijz/ka5g054jrYQKuQUFLIt
 JeAoF7i+Fv+Vne9AcD1r114+C8wLqijSx856Yt9oOkvloa5gzIs+WGXTxObc7JF12MTt
 wQK3CcU+4RN3u6dKdDcX34LyNmnEzFlQyeHJu/MXPZkSbxQ2jC9NOtvcpXKYEHRwbC6r
 5MU9dmwwxFg8fh3Wc5BbthfeCqBYqNRQZhX5vBRzNK4D5l7vT9OwwfaVv5JSQE+wYmRG Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw5qx0nn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 19:36:53 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGJU71F017579;
        Wed, 16 Nov 2022 19:36:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw5qx0nm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 19:36:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGJammc018205;
        Wed, 16 Nov 2022 19:36:51 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3kt2rjef2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 19:36:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGJbRUd47972712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 19:37:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE8F642041;
        Wed, 16 Nov 2022 19:36:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 117184203F;
        Wed, 16 Nov 2022 19:36:47 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.74.24])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Nov 2022 19:36:46 +0000 (GMT)
Message-ID: <8708073bdd4c90dbc25ee3711afc59585bc0d740.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/9] s390/uaccess: Add storage key checked cmpxchg
 access to user space
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Wed, 16 Nov 2022 20:36:46 +0100
In-Reply-To: <Y2J61LWSV+HolIeT@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
         <20221012205609.2811294-2-scgl@linux.ibm.com> <Y2J61LWSV+HolIeT@osiris>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8rNDyfkwXGqzGyWgjQrvZc4GBkeCgvZO
X-Proofpoint-ORIG-GUID: -2soOmSqiw_9D_UyFiUzwkIk_ugHFxkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-11-02 at 15:12 +0100, Heiko Carstens wrote:
> 
[...]

> I also did not limit the number of retries for the one and two byte
> scenarion. Before doing that we need to have proof that there really is a
> problem. Maybe Nico or you will give this a try.

I wrote a memop selftest testcase where the main thread uses the one byte cmpxchg
while n vcpus flip adjacent bits. The time the test case runs increases superlinearly with n.
With 248 vcpus, 1000 one byte cmpxchgs take 25s.
I'm not sure how meaningful the test is since the worst case would be if the threads hammering
the word would run on a cpu dedicated to them.

In any case, why not err on the side of caution and limit the iterations?
I'll send an rfc patch.
> 
> Thanks,
> Heiko


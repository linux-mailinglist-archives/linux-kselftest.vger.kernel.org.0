Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF5E516B83
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 May 2022 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383616AbiEBICU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358979AbiEBICS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 04:02:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F682C649;
        Mon,  2 May 2022 00:58:50 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2427eQU7013210;
        Mon, 2 May 2022 07:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R6Znuo0uXIGgRF6ohS4ohIBGd/RGextPHf71KJR13a0=;
 b=EqFbyO+jnAJweyJE9ZKRHbbHLnAxdVp1uLFxRBn9IbDUUiy2E+dYZGxNVUasmiMIMMlR
 EnjTqX3I79ZC5NYwa++o1R6yaHpyl55m1MGW/jqryvf1miNNcVk6LI+YyNACN5sRT18u
 9QvPFo0nDh6CqxJ4dHhKNZ7SdV+gaSZR2JVfBFDTWBNocF2zKxbBFKg3LVvWcE190nUX
 IPHZcnstRDs78UkymiVau2+P+kocpZLR/9FF5ise3cAeBOq6saDHsTU5naitij7qULrL
 5MqX4dJe7LmyaoZa/W1QrLqrddYaiAcrIkztkKuNxhlBRGnhNltng0rlfL8Dh9edwSuA sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftawsgdvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 07:58:45 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2427wjl1018914;
        Mon, 2 May 2022 07:58:45 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ftawsgdv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 07:58:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2427w9Oh013238;
        Mon, 2 May 2022 07:58:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3frvr8sx55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 07:58:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2427wgUo26083626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 07:58:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAF354C04E;
        Mon,  2 May 2022 07:58:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 287264C046;
        Mon,  2 May 2022 07:58:39 +0000 (GMT)
Received: from [9.171.12.235] (unknown [9.171.12.235])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 07:58:39 +0000 (GMT)
Message-ID: <385126e7-b74b-1826-c134-3efd278e5b79@linux.ibm.com>
Date:   Mon, 2 May 2022 09:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/2] Dirtying, failing memop: don't indicate
 suppression
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
 <8095d0de-dd99-0388-b1d4-e59b01dc4be0@linux.ibm.com>
 <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
 <1ccb1333-2233-8832-4102-a6c082b29108@linux.ibm.com>
 <40038a9a-5647-c355-bad2-297b0a2baf4f@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <40038a9a-5647-c355-bad2-297b0a2baf4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5NTPEpSkXRcq0OaGO40nmWBv0goR-Gm9
X-Proofpoint-ORIG-GUID: Oz37-pxOBfToHskwywnjIPdnyoPIKnaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=788 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020058
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 26.04.22 um 09:25 schrieb Janosch Frank:
> 
> To me this measure looks like a last resort option and the POP doesn't state a 100% what is to be done. Some instructions can mandate suppression instead of termination according to the architects.
> 
> My intuition tells me that if we are in a situation where this would happen then we would be much better off just doing it by hand (i.e. in the instruction emulation code) and not letting this function decide.
> 
> So I'm not entirely sure if we're replacing something that is not correct with something that also won't be correct for all cases.
> 
> But to summarize this: I'm not entirely sure even after reading the POP for more than an hour and consulting an architect

According to Damian, the definition in the POP is exactly the way it is to cover for z/VMs way of handling key protection for long operatings in a terminating fashion since the 70ies or 80ies.
As it is fine for z/VM (and then also for z/OS and zVSE under z/VM) I guess we can (and should) mimic that behaviour.

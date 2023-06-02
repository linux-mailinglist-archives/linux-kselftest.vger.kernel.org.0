Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD2720025
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjFBLIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjFBLIX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 07:08:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D4D1710;
        Fri,  2 Jun 2023 04:07:59 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352AqmCM014170;
        Fri, 2 Jun 2023 11:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pGya8gbdF37FSuz5J6jvG9DnJK9JltewPjXiMfAALR8=;
 b=S2KWtDBzbKLFVl9LxUYtuBRurQ8xTXbNNzKYZ/g1dSkUAoWA6cyVCiamTOvY1aTVi+MW
 edG13xljTCr0FcmRAxH18S+RaLrAWAfATxl7ZMI62HHTJRmTPm/EdBhiwEUJFYZzigFj
 yEVnyREi7k0IrIyY3CojXrXAEulALoOVbdlvzvJ+f6IxBRzI+Dbc2uD75+Kl9w80cV5s
 JTHMp+ZUOOlNoubgMC5D8Krmi43cmk43abx+9r6esX6UINNHD0Z/vMxnPtP5Codt3tY4
 w6fHUDRJ/zLgfgOuLF2oLKepqp9xFWJR0JR3ipd+rORYmbhvDcMiA/b5USwl/fL8Bclr gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyf28gafh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 11:07:53 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352AtWLg020700;
        Fri, 2 Jun 2023 11:07:52 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyf28gacv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 11:07:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3527NFDc002406;
        Fri, 2 Jun 2023 11:07:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qu94eag6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 11:07:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 352B7kqu42860992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Jun 2023 11:07:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87EF420043;
        Fri,  2 Jun 2023 11:07:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0721C20040;
        Fri,  2 Jun 2023 11:07:46 +0000 (GMT)
Received: from [9.171.82.186] (unknown [9.171.82.186])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  2 Jun 2023 11:07:45 +0000 (GMT)
Message-ID: <f0f0587b-5f19-82bd-3d58-bdb89ff59f8c@linux.ibm.com>
Date:   Fri, 2 Jun 2023 13:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602102330.1230734-1-colin.i.king@gmail.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH][next] KVM: s390: selftests: Fix spelling mistake
 "initally" -> "initially"
In-Reply-To: <20230602102330.1230734-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x0dr5-b2j6XCGUtdtX4DRET1146Shs3I
X-Proofpoint-ORIG-GUID: 7SCG-4IUZG_NfqZv6-Eo3nP17NC7wYkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_08,2023-06-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=916 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 12:23, Colin Ian King wrote:
> There is a spelling mistake in literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Hey Colin,

I'm not a big fan of such fixes since they are most of the time more 
work for the maintainers than they are worth and accepting one can 
result in a flood of similar new patches. If this would have been your 
first ever patch I might have considered picking this but that's not the 
case.

That being said, if one of the other maintainers choose to pick it I 
won't stand in their way.

Cheers,
Janosch

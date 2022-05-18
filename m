Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58952BD67
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiERNpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiERNpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 09:45:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641751C0F02;
        Wed, 18 May 2022 06:45:39 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IDcSwp005627;
        Wed, 18 May 2022 13:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=V6PGtDK1VCCS96hbIhyakpbQcaCZx/fTqzri3oe+JKI=;
 b=kMAspi2IHP4PdXm14UB/q8Oh0CEKby673X28I8+pRD3XDtgYT+akcttNbiICLWkcssnV
 j8g/1n4zSFvGAX2CUou+xRMdWL7QT0WvaG2s+L2ifbXhenLgOzFpdEZtW9w4HvwAG8WV
 PIkUyHtSSo4cN/6HdvveakU0mQmaucpbICMA7YeSP/xij5KKlpslOBkoAi1qLKCJMLii
 VDup58mwW5+M1LLpw7IJA5Lavx61w43zSuIXuJHi3j1AXup6jhWNBGIBf7uTvqO6mRwK
 jvW+n3zLqczW1utgrHd45u5NmxaFg1/uiVDa9mTi2n6nQGY31T2SClurcKuzcvtBghy/ jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g51uxr5kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:45:34 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IDclbG006083;
        Wed, 18 May 2022 13:45:34 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g51uxr5jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:45:34 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IDgsxJ016007;
        Wed, 18 May 2022 13:45:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3g2428vq26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:45:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IDiq8729884682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:44:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FE45A4054;
        Wed, 18 May 2022 13:45:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A775EA405F;
        Wed, 18 May 2022 13:45:27 +0000 (GMT)
Received: from [9.145.45.168] (unknown [9.145.45.168])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 13:45:27 +0000 (GMT)
Message-ID: <48550162-0f8c-4b23-dea4-b9060b24eed9@linux.ibm.com>
Date:   Wed, 18 May 2022 15:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>
Cc:     Greg KH <greg@kroah.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-2-seiden@linux.ibm.com> <YoTcxhulemnqiUbC@osiris>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
In-Reply-To: <YoTcxhulemnqiUbC@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aHzQbWoMDfk-vwBiUB2ssxDIqzQxyXtN
X-Proofpoint-GUID: uEfrS6DjIVrYZO9ueDhA5bJYYpaJRZ3b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_05,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180079
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/18/22 13:47, Heiko Carstens wrote:
> On Tue, May 10, 2022 at 02:47:23PM +0000, Steffen Eiden wrote:
>> diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
>> index 6cc4b19acf85..e9b9902abbaf 100644
>> --- a/drivers/s390/char/Kconfig
>> +++ b/drivers/s390/char/Kconfig
>> @@ -100,6 +100,16 @@ config SCLP_OFB
>>   	  This option enables the Open-for-Business interface to the s390
>>   	  Service Element.
>>   
>> +config S390_UV_UAPI
>> +	def_tristate y
>> +	prompt "Ultravisor userspace API"
>> +	help
>> +	  Selecting exposes parts of the UV interface to userspace
>> +	  by providing a misc character device at /dev/uv.
>> +	  Using IOCTLs one can interact with the UV.
>> +	  The device is only available if the Ultravisor
>> +	  Facility (158) is present.
> 
> Is there a reason why this is default "y"? If you think this should be
> compiled into the kernel if used, then why allow to make it a module
> at all?
> Instead you could get rid of a couple if lines of code.

There was a lot of discussion around this already and the "Y" was chosen 
as auto-loading this is a pain and therefore the SCLP and CHSC-Misc set 
it to Y and we took that as an example (Steffen spoke to Peter to get 
guidance).

I'm sure that we want the possibility to have this as a module. 
Personally I'd choose "m" over "y" since the module is only useful for a 
very small amount of users.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AD97A995C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjIUSN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIUSNb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 14:13:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B5084F04;
        Thu, 21 Sep 2023 10:37:39 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LAn48G031167;
        Thu, 21 Sep 2023 11:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=p8EsBeNIrJi9VQT0CnLm9BaoTVOkiFg8QdPNBbVzQY4=;
 b=S3h5NUBBeOy2OWmbxAgmfZe/8u0fehWLI8SSSAfMWXwNig8LRqUO8aMsJPof7bcNQVAD
 BgKx2Zyrs96OKtsfONvrEYqj0p+vK68J2WUIOdbrNRn4YlYBP/JMr+wpE9NWOqgUrGkL
 7V7K/ayr08XYl14FmYAjCUwNHsHmJrpV0ZxGS1TF9aWEMR3JvjgnZOQkbUkszZSya18M
 vbHM8IjhVHYO+gxnancZ4jjRAaYFNc76QX8suBmJCLZZxaU6hn2dYpBP9dWLBYvzDBpQ
 j0OA5jSb8nDdGoAuiUmhR1JR+YVxt6l+yBbfp6sIPns8E1dv0WFRy8/vYY6cgh9qGz1H Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t803f0b1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 11:00:28 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38LB07Yc016358;
        Thu, 21 Sep 2023 11:00:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t803f0b16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 11:00:27 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LAjd0p010385;
        Thu, 21 Sep 2023 11:00:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5rwkqsu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 11:00:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LB0P1866060618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 11:00:25 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1C105806A;
        Thu, 21 Sep 2023 11:00:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B952C5805D;
        Thu, 21 Sep 2023 11:00:20 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 11:00:20 +0000 (GMT)
Message-ID: <50798cd4558299eb62e2c3a11e367a6dbe11f915.camel@linux.vnet.ibm.com>
Subject: Re: [RFC v3 1/2] powerpc/cpuidle: cpuidle wakeup latency based on
 IPI and timer events
From:   Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Reply-To: 87a5trvw88.fsf@mail.lhotse
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
        npiggin@gmail.com, rmclure@linux.ibm.com, arnd@arndb.de,
        joel@jms.id.au, shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Date:   Thu, 21 Sep 2023 16:30:19 +0530
In-Reply-To: <87a5trvw88.fsf@mail.lhotse>
References: <20230911053620.87973-1-aboorvad@linux.vnet.ibm.com>
         <20230911053620.87973-2-aboorvad@linux.vnet.ibm.com>
         <87a5trvw88.fsf@mail.lhotse>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U6OLfEr1xVJJ58ZvUgMVyFoD8lhjrPU0
X-Proofpoint-ORIG-GUID: 4TT-OWudeNNSff_lXJVKJf0lNCiNhmfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-21_07,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=744 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309210092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2023-09-13 at 08:54 +1000, Michael Ellerman wrote:
> Aboorva Devarajan <aboorvad@linux.vnet.ibm.com> writes:
> > From: Pratik R. Sampat <psampat@linux.ibm.com>
> > 
> > Introduce a mechanism to fire directed IPIs from a source CPU to a
> > specified target CPU and measure the time incurred on waking up the
> > target CPU in response.
> > 
> > Also, introduce a mechanism to queue a hrtimer on a specified CPU
> > and
> > subsequently measure the time taken to wakeup the CPU.
> > 
> > Define a simple debugfs interface that allows for adjusting the
> > settings to trigger IPI and timer events on a designated CPU, and
> > to
> > observe the resulting cpuidle wakeup latencies.
> > 
> > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > Signed-off-by: Pratik R. Sampat <psampat@linux.ibm.com>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/Kconfig.debug                 |  10 ++
> >  arch/powerpc/kernel/Makefile               |   1 +
> >  arch/powerpc/kernel/test_cpuidle_latency.c | 154
> > +++++++++++++++++++++
>   
> I don't see anything here that's powerpc specific?
> 
> Which makes me wonder 1) could this be done with some existing
> generic
> mechanism?, and 2) if not can this test code be made generic.
> 
> At the very least this should be Cc'ed to the cpuidle lists &
> maintainers given it's a test for cpuidle latency :)
> 
> cheers

Hi Michael,

Thanks a lot for taking a look at this.

Yes, this test-case can be used as a generic benchmark for evaluating
CPU idle latencies across different architectures, as it has thus far
been exclusively tested and used on PowerPC, so we thought it would be
more beneficial to incorporate it into a PowerPC specific self-test
suite. But I will work on making it a generic self-test and send across
a v4.


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0374352CB82
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiESFha (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 01:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiESFh3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 01:37:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB69443CC;
        Wed, 18 May 2022 22:37:28 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J52hSX008300;
        Thu, 19 May 2022 05:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=b7OUvxCUC9WkFNOey00ZUwXXOtm4+PqdIf3emIXegRM=;
 b=De/LdRfKSpuWjAXOfxe5a4TbKVq97s5yvKAzP+t4U8NrKaSc09rxfEUp4++Qx7UOKqW1
 W6qjzoOyM6lZF78wnTMRRgCBUZO1+zZ5EzcVrOFq8LX65aWR8gy/IIdnGtRCk6JNsgTi
 4MuYaQ3SKnjGVsy00STWP9UeCoesrhqxKpHicHGHa6XGW5F0+jetlYARVh/RrzZU0rJV
 l7M0eL3QlK8Z0CVbhDydJ0O21uHpEiQ/+vFw2YGZmIIp+AO8JPgkEKlHhm/otybMw7sS
 hZJB9+WVjIiIXuLDF7slIZccoNRkFdQBHk3YCFNX0d+bv+HPFiZTiE7z4uHvK+ikqsoT ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5fdbrnf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 05:37:23 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24J5ZAce004235;
        Thu, 19 May 2022 05:37:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5fdbrne0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 05:37:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J5SZwX017614;
        Thu, 19 May 2022 05:37:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429enea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 05:37:21 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J5bHFO49938908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 05:37:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D06574C044;
        Thu, 19 May 2022 05:37:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 779CE4C040;
        Thu, 19 May 2022 05:37:17 +0000 (GMT)
Received: from osiris (unknown [9.152.212.254])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 19 May 2022 05:37:17 +0000 (GMT)
Date:   Thu, 19 May 2022 07:37:16 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     Steffen Eiden <seiden@linux.ibm.com>, Greg KH <greg@kroah.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Message-ID: <YoXXjC49xKY/TJ+2@osiris>
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-2-seiden@linux.ibm.com>
 <YoTcxhulemnqiUbC@osiris>
 <48550162-0f8c-4b23-dea4-b9060b24eed9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48550162-0f8c-4b23-dea4-b9060b24eed9@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jz7JwA5jEv1zW0wMfUTaz4Qn1Uqr9hro
X-Proofpoint-GUID: gbwGk3IpH3xv2KCTdaCyddvt_gpmPnYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_09,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 18, 2022 at 03:45:27PM +0200, Janosch Frank wrote:
> > > +	  The device is only available if the Ultravisor
> > > +	  Facility (158) is present.
> > 
> > Is there a reason why this is default "y"? If you think this should be
> > compiled into the kernel if used, then why allow to make it a module
> > at all?
> > Instead you could get rid of a couple if lines of code.
> 
> There was a lot of discussion around this already and the "Y" was chosen as
> auto-loading this is a pain and therefore the SCLP and CHSC-Misc set it to Y
> and we took that as an example (Steffen spoke to Peter to get guidance).
> 
> I'm sure that we want the possibility to have this as a module. Personally
> I'd choose "m" over "y" since the module is only useful for a very small
> amount of users.

Why not simply use module_cpu_feature_match() to implement auto module
loading like we do it for the crypto modules? That would require that
either the uv facility is represented within elf hwcaps, or
alternatively the s390 implementation of cpu_feature() needs to be
changed to work with cpu facilities instead of hwcap bits.
(see arch/s390/include/asm/cpufeature.h)

This doesn't look too difficult. Or was there a reason not to go this route?

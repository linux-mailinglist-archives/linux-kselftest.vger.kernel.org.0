Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D261E525D9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357415AbiEMIiO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbiEMIiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 04:38:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0602631DA;
        Fri, 13 May 2022 01:38:12 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D7Unwu006299;
        Fri, 13 May 2022 08:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ZXAqI3ht/d3z93NyFe+DB2QetlKzLu8xGrcuay8GlI=;
 b=Pf7B9JU8lwWK9Bryr5RaBEHC888WFaH/fsI9CMm/CGxQj5npMKchr2ijq8xXvHpV+9U0
 DTdoo2dj6IyTni/9N1edATfSB7lVRk7HwOmVdBH/rqP/JCub5GURg/DeTc4rqGQ0M4IA
 3mIfNO7GZnKhelZuLvJIYpbM0ZsAl8YKKhMJyTXCdx2wCqL0U6GEE20kKdEhEjjwdslu
 rbq68h5dirathgPsL1Zn8C8tIS5Uswf1jl14BwGn7tqmAIzBhEXN0kicYE1o7XcNfzk4
 78UkNsIMNmOVupDKQThm0z0ysiWHfDdCA+oPdwSMDOt9Ygi1vQ3d4O2K8MbJws8R/CZm LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1k0s1804-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 08:38:07 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24D7X9VA015934;
        Fri, 13 May 2022 08:38:06 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1k0s17ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 08:38:06 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24D8XTmI002710;
        Fri, 13 May 2022 08:38:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3fwgd8xfp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 08:38:04 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24D8c1q645351192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 08:38:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A470A4057;
        Fri, 13 May 2022 08:38:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4D01A4053;
        Fri, 13 May 2022 08:38:00 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.40])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 08:38:00 +0000 (GMT)
Date:   Fri, 13 May 2022 10:37:58 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Greg KH <greg@kroah.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Message-ID: <20220513103758.5a4baf7c@p-imbrenda>
In-Reply-To: <80afde93-b9cf-f6c4-da40-3385d7f6741b@linux.ibm.com>
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
        <20220510144724.3321985-2-seiden@linux.ibm.com>
        <20220512163327.2c86cab1@p-imbrenda>
        <80afde93-b9cf-f6c4-da40-3385d7f6741b@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UCcw4Opj_jMSaBwBR3H9HtR2bBbqQRVn
X-Proofpoint-ORIG-GUID: w7Dfq_Aq1cZIiV7YMuFsgvwTlW8IyuqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 13 May 2022 09:45:39 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> On 5/12/22 16:33, Claudio Imbrenda wrote:
> 
> [snip]
> 
> >> +/*
> >> + * IOCTL entry point for the Ultravisor device.
> >> + */
> >> +static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >> +{
> >> +	void __user *argp = (void __user *)arg;
> >> +	struct uvio_ioctl_cb *uv_ioctl;
> >> +	long ret;
> >> +
> >> +	ret = -ENOMEM;
> >> +	uv_ioctl = vzalloc(sizeof(*uv_ioctl));  
> > struct uvio_ioctl_cb is rather small, couldn't you just allocate it on
> > the stack?
> >   
> IIRC it was on stack in some previous version. We then had a discussion
> earlier about this triggered by the inverse comment and decided to not 
> use the stack.

ok fair enough

but what's the reason for a vzalloc instead of a kzalloc, when the
allocation is surely going to be small?

> 
> [snip]
> 


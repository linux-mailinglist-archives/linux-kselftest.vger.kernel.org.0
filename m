Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA03B48C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFYS3b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 14:29:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhFYS3a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 14:29:30 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PIHfKK066681;
        Fri, 25 Jun 2021 14:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=j+O/cYCsFsuCEcRnngzouHlCzfCZ1Z52WLywB4Dg6VI=;
 b=pujvexLTn5Z1jhQ38Nusv+0EOCH7mHFlyG01EJymf+fIp/YPPSC+aEINwop0eDx7NJI5
 vkU1o16IvxqasSu0w5mawTkG0zF3jLd1krbGWkEE52Iqax14cE5VU+E24q1vr7HL/xyG
 MUNXohU0nPvGTtkKcA+9G5QsOydBK8vZsddOXfG6R1KRcQiPHi1o4/fnv3e596mFaHU5
 0R1Ld9FA8cG+0qL3Xm3+K0EchhpuBS/SH2Nx9fBQrUWtDzUDZuXf7LBriBJ/NyKeZHzq
 6KWJicseC/6G12IskZrnQm8JoQ66iBPLgaDAV+pXR6i8e/05AZSkFEH3MXeYQeHPJKNl 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39dma009dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 14:27:05 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PIHr5G067038;
        Fri, 25 Jun 2021 14:27:04 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39dma009cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 14:27:04 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PIIHHi004448;
        Fri, 25 Jun 2021 18:27:02 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3997uhb5n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 18:27:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PIQxO429295034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 18:27:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE8DBAE058;
        Fri, 25 Jun 2021 18:26:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09F8CAE053;
        Fri, 25 Jun 2021 18:26:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.226])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 18:26:56 +0000 (GMT)
Message-ID: <25951cc27ce8a42893e98f9ea442296ae04b6988.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 01/12] ima: Add digest, algo, measured parameters
 to ima_measure_critical_data()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Prakhar Srivastava <prsriva02@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Fri, 25 Jun 2021 14:26:55 -0400
In-Reply-To: <20210625165614.2284243-2-roberto.sassu@huawei.com>
References: <20210625165614.2284243-1-roberto.sassu@huawei.com>
         <20210625165614.2284243-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 42B1uptXA-wFAtKBlzryfp64uWpnOmi4
X-Proofpoint-GUID: ta77Re1fJ_j3pnVE_gpDpee0U3H_Snnk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_07:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 spamscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250105
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2021-06-25 at 18:56 +0200, Roberto Sassu wrote:
> ima_measure_critical_data() allows any caller in the kernel to provide a
> buffer, so that is measured by IMA if an appropriate policy is set. Some
> information that could be useful to the callers are the digest of the
> buffer included in the new measurement entry, the digest algorithm and
> whether the buffer was measured.
> 
> This patch modifies the definition of ima_measure_critical_data() to
> include three new parameters: digest, algo and measured. If they are NULL,
> the function behaves as before and just measures the buffer, if requested
> with the IMA policy. Otherwise, it also writes the digest, algorithm and
> whether the buffer is measured to the provided pointers.
> 
> If the pointers are not NULL, the digest is calculated also if there is no
> matching rule in the IMA policy.

As much as possible, let's not define additional
ima_measure_critical_data() arguments.  Probably the only new variable
really need is "digest".  The hash algorithm doesn't change.  How about
defining and exporting a new function to return the system defined
ima_hash_algo.  In terms of failure, have ima_measure_critical_data()
return errno.

thanks,

Mimi


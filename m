Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E924121D564
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgGML53 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 07:57:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbgGML53 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 07:57:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DBV7PT010647;
        Mon, 13 Jul 2020 07:57:24 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3276buc1sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 07:57:24 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06DBepoJ050958;
        Mon, 13 Jul 2020 07:57:24 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3276buc1s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 07:57:23 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DBsY3L001857;
        Mon, 13 Jul 2020 11:57:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 327527t5nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 11:57:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06DBvJ2U62062766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 11:57:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9C6452050;
        Mon, 13 Jul 2020 11:57:19 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.49.56])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 799D25204E;
        Mon, 13 Jul 2020 11:57:18 +0000 (GMT)
Subject: Re: [PATCH] selftests/livepatch: Use "comm" instead of "diff" for
 dmesg
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20200710183745.19730-1-joe.lawrence@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <be472e58-7538-3655-6032-57219e18c9ff@linux.vnet.ibm.com>
Date:   Mon, 13 Jul 2020 17:27:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710183745.19730-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130084
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/07/20 12:07 am, Joe Lawrence wrote:
> BusyBox diff doesn't support the GNU diff '--LTYPE-line-format' options
> that were used in the selftests to filter older kernel log messages from
> dmesg output.
> 
> Use "comm" which is more available in smaller boot environments.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

LGTM. All the test passes on non-busybox environment.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


-- 
Kamalesh

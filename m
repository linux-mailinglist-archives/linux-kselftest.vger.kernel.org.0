Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E172F2E1B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 13:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKGMXB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 07:23:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727437AbfKGMXA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 07:23:00 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7CDvgf087716
        for <linux-kselftest@vger.kernel.org>; Thu, 7 Nov 2019 07:23:00 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4gtdepkg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 07:22:59 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Thu, 7 Nov 2019 12:22:57 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 12:22:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7CMruf42598838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 12:22:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 592034203F;
        Thu,  7 Nov 2019 12:22:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50A3842042;
        Thu,  7 Nov 2019 12:22:51 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.48.202])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Nov 2019 12:22:51 +0000 (GMT)
Subject: Re: [PATCH] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
References: <20191106222801.7541-1-joe.lawrence@redhat.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Thu, 7 Nov 2019 17:52:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106222801.7541-1-joe.lawrence@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110712-4275-0000-0000-0000037BA36D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110712-4276-0000-0000-0000388EF4A1
Message-Id: <97b119a4-e979-7ceb-02b9-50ed0ff1d3fa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070125
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/19 3:58 AM, Joe Lawrence wrote:
> The livepatch selftests compare expected dmesg output to verify kernel
> behavior.  They currently filter out "tainting kernel with
> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
> modules.
> 
> Further filter the log to also drop "loading out-of-tree module taints
> kernel" messages in case the klp_test modules have been build without
> the in-tree module flag.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
Kamalesh


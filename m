Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D33142CFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2020 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATOOv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Jan 2020 09:14:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgATOOu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Jan 2020 09:14:50 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KED43v026518
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 09:14:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgcnaqu2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2020 09:14:49 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Mon, 20 Jan 2020 14:14:47 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 14:14:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KEEhPm46268840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 14:14:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1038011C04C;
        Mon, 20 Jan 2020 14:14:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B45111C05B;
        Mon, 20 Jan 2020 14:14:41 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.38.131])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Jan 2020 14:14:40 +0000 (GMT)
Subject: Re: [PATCH v2] selftests: vm: Fix 64-bit test builds for powerpc64le
To:     Sandipan Das <sandipan@linux.ibm.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-mm@kvack.org, mhiramat@kernel.org,
        aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
References: <20200120135954.93745-1-sandipan@linux.ibm.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Mon, 20 Jan 2020 19:44:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120135954.93745-1-sandipan@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20012014-4275-0000-0000-000003994E56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012014-4276-0000-0000-000038AD5458
Message-Id: <4d4f9c3d-82a9-e994-1822-6dba86b233f8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=800 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001200123
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/20/20 7:29 PM, Sandipan Das wrote:
> Some tests are built only for 64-bit systems. This makes
> sure that these tests are built for both big and little
> endian variants of powerpc64.
> 
> Fixes: 7549b3364201 ("selftests: vm: Build/Run 64bit tests only on 64bit arch")
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

I was about to suggest, the missing change in run_vmtests script in your V1.

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


-- 
Kamalesh


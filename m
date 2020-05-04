Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101651C3D43
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 May 2020 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgEDOjA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 May 2020 10:39:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728486AbgEDOjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 May 2020 10:39:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 044EXBuV136193;
        Mon, 4 May 2020 10:38:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s45sqhkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 10:38:51 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 044EZof4019833;
        Mon, 4 May 2020 14:38:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5myqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 May 2020 14:38:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 044EckA060424284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 May 2020 14:38:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88E6711C054;
        Mon,  4 May 2020 14:38:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14B6F11C04A;
        Mon,  4 May 2020 14:38:44 +0000 (GMT)
Received: from [9.199.43.226] (unknown [9.199.43.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 May 2020 14:38:43 +0000 (GMT)
Subject: Re: [PATCH] selftests/vm/keys: fix a broken reference at
 protection_keys.c
To:     Dave Hansen <dave.hansen@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-kselftest@vger.kernel.org
References: <d478a2fc5d204691d0cac6e2b416f0e07a26d3d9.1588585390.git.mchehab+huawei@kernel.org>
 <bd55a74d-1305-9e23-94cd-37e59c11dfcd@intel.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <43841ceb-f682-26ff-8b57-fed545759193@linux.ibm.com>
Date:   Mon, 4 May 2020 20:08:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bd55a74d-1305-9e23-94cd-37e59c11dfcd@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-04_08:2020-05-04,2020-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040121
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 04/05/20 7:40 pm, Dave Hansen wrote:
> On 5/4/20 2:44 AM, Mauro Carvalho Chehab wrote:
>> Changeset 1eecbcdca2bd ("docs: move protection-keys.rst to the core-api book")
>> from Jun 7, 2019 converted protection-keys.txt file to ReST.
>>
>> A recent change at protection_keys.c partially reverted such
>> changeset, causing it to point to a non-existing file:
>>
>> 	- * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
>> 	+ * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)
>>
>> It sounds to me that the changeset that introduced such change
>> 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
>> could also have other side effects, as it sounds that it was not
>> generated against uptream code, but, instead, against a version
>> older than Jun 7, 2019.
>>
>> Fixes: 4645e3563673 ("selftests/vm/pkeys: rename all references to pkru to a generic name")
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> Thanks for finding this!  The patch set which moved protection-keys.txt
> out of x86 code probably just missed this when it got rebased.  It
> originated well before June 2019, iirc.
> 

That's right. Sorry about that. Must have missed it when rebasing the
older pkey selftest patches. Thanks for fixing this Mauro.

Acked-by: Sandipan Das <sandipan@linux.ibm.com>

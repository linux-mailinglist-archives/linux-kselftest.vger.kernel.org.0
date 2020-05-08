Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4331CB8AC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 21:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEHTyq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 15:54:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726825AbgEHTyq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 15:54:46 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048JW7o6109890;
        Fri, 8 May 2020 15:54:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsjxrpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 15:54:36 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048JW87r110045;
        Fri, 8 May 2020 15:54:35 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30vtsjxrnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 15:54:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048JofnI009987;
        Fri, 8 May 2020 19:54:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 30s0g5dqse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 19:54:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048JsUcI63308008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 19:54:30 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CDC111C04A;
        Fri,  8 May 2020 19:54:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E26AC11C052;
        Fri,  8 May 2020 19:54:27 +0000 (GMT)
Received: from [9.199.45.63] (unknown [9.199.45.63])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 19:54:27 +0000 (GMT)
Subject: Re: [PATCH 2/2] selftests: vm: pkeys: Fix powerpc access right
 updates
To:     Florian Weimer <fweimer@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linuxram@us.ibm.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, mpe@ellerman.id.au
References: <cover.1588959697.git.sandipan@linux.ibm.com>
 <cover.1588959697.git.sandipan@linux.ibm.com>
 <5f65cf37be993760de8112a88da194e3ccbb2bf8.1588959697.git.sandipan@linux.ibm.com>
 <87blmymhkx.fsf@oldenburg2.str.redhat.com>
From:   Sandipan Das <sandipan@linux.ibm.com>
Message-ID: <a40c364d-e204-1d63-c211-7cdfdccb32e0@linux.ibm.com>
Date:   Sat, 9 May 2020 01:24:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87blmymhkx.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_16:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005080161
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Florian,

On 08/05/20 11:31 pm, Florian Weimer wrote:
> * Sandipan Das:
> 
>> The Power ISA mandates that all writes to the Authority
>> Mask Register (AMR) must always be preceded as well as
>> succeeded by a context-synchronizing instruction. This
>> applies to both the privileged and unprivileged variants
>> of the Move To AMR instruction.
> 
> Ugh.  Do you have a reference for that?
> 
> We need to fix this in glibc.
> 

This is from Table 6 of Chapter 11 in page 1134 of Power
ISA 3.0B. The document can be found here:
https://ibm.ent.box.com/s/1hzcwkwf8rbju5h9iyf44wm94amnlcrv

- Sandipan

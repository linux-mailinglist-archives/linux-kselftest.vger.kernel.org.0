Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00BE139185
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 14:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgAMNA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 08:00:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40304 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgAMNA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 08:00:28 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DCvwqo140923
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 08:00:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfa2594bq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2020 08:00:26 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Mon, 13 Jan 2020 13:00:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 13:00:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DD0EF722282434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 13:00:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35AFC42057;
        Mon, 13 Jan 2020 13:00:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AEFF42045;
        Mon, 13 Jan 2020 13:00:12 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.42.111])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jan 2020 13:00:12 +0000 (GMT)
Subject: Re: [PATCH 2/2] selftests/livepatch: Remove unused local variable in
 set_ftrace_enabled()
To:     Miroslav Benes <mbenes@suse.cz>, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com,
        shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200113124907.11086-1-mbenes@suse.cz>
 <20200113124907.11086-3-mbenes@suse.cz>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Mon, 13 Jan 2020 18:30:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113124907.11086-3-mbenes@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011313-0012-0000-0000-0000037CEB72
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011313-0013-0000-0000-000021B9154C
Message-Id: <64ec82d8-61ea-fe2a-7fd9-794904ba148c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=869
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130108
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/13/20 6:19 PM, Miroslav Benes wrote:
> set_ftrace_enabled() contains unused local variable "sysctl". Remove it.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


-- 
Kamalesh


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74F31F782D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFLM6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jun 2020 08:58:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgFLM6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jun 2020 08:58:06 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CCjGxM184252;
        Fri, 12 Jun 2020 08:58:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ma068aap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 08:58:00 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CCjQ4Q184965;
        Fri, 12 Jun 2020 08:57:59 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ma068aa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 08:57:59 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CCvwWC030153;
        Fri, 12 Jun 2020 12:57:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s83bfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 12:57:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CCvtmb62390598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 12:57:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D375542041;
        Fri, 12 Jun 2020 12:57:55 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B242F4204D;
        Fri, 12 Jun 2020 12:57:54 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.85.84.126])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 12 Jun 2020 12:57:54 +0000 (GMT)
Subject: Re: [PATCH 3/3] selftests/livepatch: filter 'taints' from dmesg
 comparison
To:     Petr Mladek <pmladek@suse.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200610172101.21910-1-joe.lawrence@redhat.com>
 <20200610172101.21910-4-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.2006110938090.32091@pobox.suse.cz>
 <047eba61-b0b9-4e91-395f-13bafbf43af6@redhat.com>
 <20200612114706.GH4311@linux-b0ei>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Message-ID: <ba0202cf-beea-ddde-4941-053718c77257@linux.vnet.ibm.com>
Date:   Fri, 12 Jun 2020 18:27:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612114706.GH4311@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_09:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120092
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/12/20 5:17 PM, Petr Mladek wrote:
> On Thu 2020-06-11 09:10:38, Joe Lawrence wrote:
>> On 6/11/20 3:39 AM, Miroslav Benes wrote:
>>> On Wed, 10 Jun 2020, Joe Lawrence wrote:
>>>
>>>> The livepatch selftests currently filter out "tainting kernel with
>>>> TAINT_LIVEPATCH" messages which may be logged when loading livepatch
>>>> modules.
>>>>
>>>> Further filter the log to drop "loading out-of-tree module taints
>>>> kernel" in the rare case the klp_test modules have been built
>>>> out-of-tree.
>>>>
>>>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>>>> ---
>>>>   tools/testing/selftests/livepatch/functions.sh | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
>>>> index 83560c3df2ee..f5d4ef12f1cb 100644
>>>> --- a/tools/testing/selftests/livepatch/functions.sh
>>>> +++ b/tools/testing/selftests/livepatch/functions.sh
>>>> @@ -260,7 +260,8 @@ function check_result {
>>>>   	local result
>>>>   	result=$(dmesg --notime | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
>>>> -		 grep -v 'tainting' | grep -e '^livepatch:' -e 'test_klp')
>>>> +		 grep -e '^livepatch:' -e 'test_klp' | \
>>>> +		 grep -ve '\<taints\>' -ve '\<tainting\>')
>>>
>>> or make it just 'grep -v 'taint' ? It does not matter much though.
>>>
>>
>> I don't know of any larger words* that may hit a partial match on "taint",
>> but I figured the two word bounded regexes would be more specific.
> 
> I do not have strong opinion. I am fine with both current and Mirek's proposal.
> 
> I am just curious where \< and \> regexp substitutions are documented.
> I see the following at the very end of "man re_syntax":
> 
>    \< and \> are synonyms for  “[[:<:]]” and “[[:>:]]” respectively
> 
> But I am not able to find documentation for “[[:<:]]” and “[[:>:]].
> Even google looks helpless ;-)
> 

AFAIK, using \< and \> matches exact word.  Whereas when used individually,
\< matches beginning and \> matches end of the word.

-- 
Kamalesh

Return-Path: <linux-kselftest+bounces-21365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D829BAFB1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C11C21824
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28A1AC426;
	Mon,  4 Nov 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mq7F6wDI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18851AA7A2;
	Mon,  4 Nov 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712755; cv=none; b=Kdze7URo/IdqE2izEmg3rr7Awo1xBW6YwEAwZmDDnnC24fgC/qgNFk4jC8l7pPZWedA196qE8KhSjDlw9sfXkt+29lpTGfVxuofs7kJ7erwnTd0WyLC4CvvVKRf3RYMqk2c5iYU9mQNfTojqwVkuxK3f+bIsY3wIyufgW+z2qIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712755; c=relaxed/simple;
	bh=9UKvbO8z2ei27RoRSE2xCVBA6zreiwZoCehINCC+0V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLwoLgn6rGHzpLVPW0YGD+t00tpqQO3CDycjtA0eGwSHsri+5/Z60q8YmhRV435PddseWjaf8hpiGWjoAl6cEnTXdn3d391f/a/CylFHZMVYZs9VY1ALcUSd5F2xcoWlBb9ReRhPTK6TP3PQPS2o3+gNAEP3bLrwA3Y8kkyY8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mq7F6wDI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A49A2u0028329;
	Mon, 4 Nov 2024 09:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vq7XpO
	rAhxZrEh8MsbbnnyWtsYCcs6v2Cq/ffdk6E8s=; b=mq7F6wDIPY2fCWIvAWYB/V
	H8B8dzsTafxhoxYMISXjmlWk+GrlI2OILwkEMYrzpFThbXGFAic9+uLbCKLZsoW6
	bDXL7C7+uI5bCSXimbhepAeYsaYIUUl+nZH/fnQM61YALdfAgXcflhiXG9+HBePp
	5XINDetkGTGZv1YZk2Fqo1rpXuj7GsnDkS9rTcJ+4vq39EWpxJGWAn08+G13BG/5
	6Icbv61a2smRmLVRqMbLDBvJAFYm03Z0QRTjApQUWG+z3zrnVPrz2KTWJ8+2GLNk
	fMOgvbN8Br08Dm68Fpn7PpfF9w5w9pQrx70qiGqgN5OAWqIpzHCEQuLVzOPs3p9g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pud7r2hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 09:32:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A47SfrH008439;
	Mon, 4 Nov 2024 09:32:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywk3br7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 09:32:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A49WFTi58327538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 09:32:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29E0A2004F;
	Mon,  4 Nov 2024 09:32:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B60A2004B;
	Mon,  4 Nov 2024 09:32:13 +0000 (GMT)
Received: from [9.203.115.143] (unknown [9.203.115.143])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 09:32:13 +0000 (GMT)
Message-ID: <d10f4a96-944f-42c4-9886-05dfe831e8fd@linux.ibm.com>
Date: Mon, 4 Nov 2024 15:02:12 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for
 ppc64le
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao"
 <naveen@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
 <20241103135758.5a5f8f0870a139ab1a5bc7b8@kernel.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20241103135758.5a5f8f0870a139ab1a5bc7b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aEoJL43cIgdoMF8wJRPvpWSTbRrdj9xw
X-Proofpoint-ORIG-GUID: aEoJL43cIgdoMF8wJRPvpWSTbRrdj9xw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411040081



On 03/11/24 10:27 am, Masami Hiramatsu (Google) wrote:
> On Sat,  2 Nov 2024 00:49:25 +0530
> Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
>> For ppc64le, depending on the kernel configuration used, offset 16
>> from function start address can also be considered function entry.
>> Update the test case to accommodate such configurations.
>>
> 
> Hi Hari, so have you met any error on this test case?

Hi Masami,

vfs_read+8 is function entry on powerpc. So, the test case bails out at:
   "check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS"

as it allows setting kprobe "vfs_read+8 $arg*"

> Can you share the error result too?


End of the log file for reference:

"
Test command: p vfs_read $arg* $arg*
[2661828.483436] trace_kprobe: error: $arg* can be used only once in the 
parameters
   Command: p vfs_read $arg* $arg*
                             ^
Test command: p vfs_read+8 $arg*
"

Thanks
Hari

> 
> Thank you,
> 
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>   .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc    | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>> index a16c6a6f6055..c03b94cc5784 100644
>> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
>> @@ -111,7 +111,11 @@ check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
>>   if !grep -q 'kernel return probes support:' README; then
>>   check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
>>   fi
>> +if [ "$(uname -m)" = "ppc64le" ]; then
>> +check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
>> +else
>>   check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
>> +fi
>>   check_error 'p vfs_read ^hoge'			# NO_BTFARG
>>   check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
>>   check_error 'r kfree ^$retval'			# NO_RETVAL
>> -- 
>> 2.47.0
>>
> 
> 



Return-Path: <linux-kselftest+bounces-24857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217AFA17CE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 12:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49998160783
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE71F0E2A;
	Tue, 21 Jan 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZElky2AB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B101BBBEA;
	Tue, 21 Jan 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458352; cv=none; b=HKsTcA1s3P9yWxyfTT/Wge63uWmGoXPU1ijxfobsnsdfGDSWC9cF6AGh+FKBbc7mi+5PnoMr0Cly+kHAqvLhmopdb3EUNTJ754wsvwjfjn9YMVSfEU0O30PPmd3L05x3NC5mU2YdoU3dJJFPYZml4IAI35kF0v9oIfuyH8YTIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458352; c=relaxed/simple;
	bh=nyOy1p/+xcdGeeSi7NzS3/iyIKFqr3VN06dLVeBz3Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAMGbSPxocJaN2ByLYfKQylpMYc51NGakjrKwQ/v0jQ9mk203sTsnI1Z9dd4Snd3Z9OfKXbqiK4Me/ERoQgQc7+EcXVneSZSAA52esCtwtPwz28QwGxsmwAFtN5yaIqVAyb+amOJ8I4nSTUjKpTcgCeLvRl9lESN0fBy3CA8A7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZElky2AB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L2aR0l014177;
	Tue, 21 Jan 2025 11:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IWELNA
	uwWpZU72QPN45qSAZrXijn1CPGu8HSJ/93Nfo=; b=ZElky2ABh9LLxpTMf+YbHu
	3+FQLK4nYiYvA3PB8aY+psqqVDSQOdjDBWJ2FaPi5hjhTjxlNFoLIbPleO4kzc0B
	2ptkzY7B65mHXS4POlER8lGXMNj70nSDZQsyrGDdYNgdlVgQLvIYk077FQV80QcF
	4th/Wa02l5ozmputzlapYIm3F05tjjsjhOcbIog8cBeW+C9YO82tCLlLQiNmoAWk
	N0mwDlF4cZ7dAG38j92q80jft+U7cH7rIGdhT1w7LgzcylgBHx+/vtm0g94RmfBx
	H3y+zi7S/n32L1/d90iO4CofFjvD2cqaY2G/SSCT5EG/QxzobhOYN2krSI1v2Kjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449sat43u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:18:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50LAvBCK003696;
	Tue, 21 Jan 2025 11:18:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449sat43u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:18:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LAtOMY021012;
	Tue, 21 Jan 2025 11:18:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1aj15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:18:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LBIl2S17105412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 11:18:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B7658043;
	Tue, 21 Jan 2025 11:18:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6391858059;
	Tue, 21 Jan 2025 11:18:40 +0000 (GMT)
Received: from [9.43.71.201] (unknown [9.43.71.201])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jan 2025 11:18:39 +0000 (GMT)
Message-ID: <c91cc2c5-2f82-43e8-a726-bebc4134ad32@linux.ibm.com>
Date: Tue, 21 Jan 2025 16:48:37 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
To: Petr Mladek <pmladek@suse.com>
Cc: jikos@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
        shuah@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20250119163238.749847-1-maddy@linux.ibm.com>
 <Z450ohzYtxVEMh1_@pathway.suse.cz>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <Z450ohzYtxVEMh1_@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xoAhS245gN5Sx9r3gf1mf511ast3Mvlo
X-Proofpoint-ORIG-GUID: q3Nb3UwRvNy-RbDEw7KvBVwObWnBH6I8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=838 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210091



On 1/20/25 9:36 PM, Petr Mladek wrote:
> On Sun 2025-01-19 22:02:38, Madhavan Srinivasan wrote:
>> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER,
>> which adds the caller id as part of the dmesg. With recent
>> util-linux's update 467a5b3192f16 ('dmesg: add caller_id support')
>> the standard "dmesg" has been enhanced to print PRINTK_CALLER fields.
>>
>> Due to this, even though the expected vs observed are same,
>> end testcase results are failed.
>>
>>  -% insmod test_modules/test_klp_livepatch.ko
>>  -livepatch: enabling patch 'test_klp_livepatch'
>>  -livepatch: 'test_klp_livepatch': initializing patching transition
>>  -livepatch: 'test_klp_livepatch': starting patching transition
>>  -livepatch: 'test_klp_livepatch': completing patching transition
>>  -livepatch: 'test_klp_livepatch': patching complete
>>  -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>>  -livepatch: 'test_klp_livepatch': initializing unpatching transition
>>  -livepatch: 'test_klp_livepatch': starting unpatching transition
>>  -livepatch: 'test_klp_livepatch': completing unpatching transition
>>  -livepatch: 'test_klp_livepatch': unpatching complete
>>  -% rmmod test_klp_livepatch
>>  +[   T3659] % insmod test_modules/test_klp_livepatch.ko
>>  +[   T3682] livepatch: enabling patch 'test_klp_livepatch'
>>  +[   T3682] livepatch: 'test_klp_livepatch': initializing patching transition
>>  +[   T3682] livepatch: 'test_klp_livepatch': starting patching transition
>>  +[    T826] livepatch: 'test_klp_livepatch': completing patching transition
>>  +[    T826] livepatch: 'test_klp_livepatch': patching complete
>>  +[   T3659] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
>>  +[   T3659] livepatch: 'test_klp_livepatch': initializing unpatching transition
>>  +[   T3659] livepatch: 'test_klp_livepatch': starting unpatching transition
>>  +[    T789] livepatch: 'test_klp_livepatch': completing unpatching transition
>>  +[    T789] livepatch: 'test_klp_livepatch': unpatching complete
>>  +[   T3659] % rmmod test_klp_livepatch
>>
>>   ERROR: livepatch kselftest(s) failed
>>  not ok 1 selftests: livepatch: test-livepatch.sh # exit=1
>>
>> Currently the check_result() handles the "[time]" removal from
>> the dmesg. Enhance the check to also handle removal of "[Thread Id]"
>> or "[CPU Id]".
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> 
> Looks and works well:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 
> PS: The merge window for 6.14 has started yesterday. Every change
>     should spend at least few days in linux-next and I have already
>     sent a pull request so it is kind of late for 6.14.
> 
>     If there is a demand, I could still queue it for 6.14 in the 2nd
>     half of the merge window or for rc2. There is only small group
>     of people interested into the livepatch selftests anyway.

Thanks. No urgency from my end.



Return-Path: <linux-kselftest+bounces-34724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D23AD5893
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11D73A3E0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A93D28C855;
	Wed, 11 Jun 2025 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VxwUuUJa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7023958C
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651828; cv=none; b=URd/i4v+gMtKGErLJf6gKPZextLdzlVjEEc4U2h0WRNC8vBu+tk1Bp4S7fFLdzxyT0EYzT5bFJdd4ODEJQBM7OAvnrwsbc3d6uwhR49XkJHEC4Ugazt6FxpG1LGpIo5wvA2Qtyxh3SI0f86qGpVI8H8yvXWGaVPWP6jglUrOH9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651828; c=relaxed/simple;
	bh=wNT/sQxAilcYB4DtEIreX+lsymhPS7CrLb7AD+FiPmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhcsHyYkP8PIpH+9+3L3v3+rvUA5OfIJeyYjhfaouj3ocGwMtyJ5uvTAOUcSHpPG3AojvqL8aZimZcIMN9ZyRqb0Z4B48zFLT0GI0fSa+TXpz6tVdZmIZzUnr2t+L+cc/2HZM3ZdgbibITz+/eEVWERWTHao+/wJZMBwgFRYZRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VxwUuUJa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B7KRhJ027642;
	Wed, 11 Jun 2025 14:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+g6EWQ
	vcA6MF8DbCUNITBYPXL+JKeLsdTZNkai8JS7s=; b=VxwUuUJaGvwTfmrSsU/O3K
	mnIKDtrEsMGxawu4v31ZI70rJGDgH7ASW+C3GvFVrT1Ukp4M6/LDi02y39Xw9ztZ
	3YrfwurQU5QqIWxXFhOd657gIwZTCHdEwZzYlLSDEozbQN0rU2xLtkjuItOczm9a
	LsIxX5r53LIpisJXDSVJYb2YHtKpiiCa3zP9yQVP/SFDwG76VsD7YDZKXdrC8y8j
	gSxuYk5JKXvcyHxOh0BZl+P0yMifnR7CK6La9UT+Qx5MUe+HxeQ80pQZvB+HCqNf
	NraLB+ltnJCvqAdwdUe1l2UgG2aTB08NAxhOEpJZ2WLx4MXT04GvUdydIrI9m8iw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4ma6ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 14:23:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55BECEVn014991;
	Wed, 11 Jun 2025 14:23:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4ma6ak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 14:23:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCai7a015180;
	Wed, 11 Jun 2025 14:23:23 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtg9xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 14:23:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55BENNsw17433244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:23:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0674B58059;
	Wed, 11 Jun 2025 14:23:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C980B58053;
	Wed, 11 Jun 2025 14:23:18 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 14:23:18 +0000 (GMT)
Message-ID: <6f29b528-a89d-446c-ad0e-8148a8af3c3c@linux.ibm.com>
Date: Wed, 11 Jun 2025 19:53:17 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Skip uprobe vma merge test if uprobes are
 not enabled
To: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pu Lehui <pulehui@huawei.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Aishwarya <aishwarya.tcv@arm.com>,
        broonie@kernel.org
References: <20250610122209.3177587-1-pfalcato@suse.de>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <20250610122209.3177587-1-pfalcato@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6849915d cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=h6i3v21f8pZAO7MeEkkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: wKBTw5oQiynaHMLs6nGwUdXbb3j6T2Yt
X-Proofpoint-ORIG-GUID: engL8-gUt2CQUqk9B7L4HXrpkczpb7Lc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExOSBTYWx0ZWRfXxvFdLtsHF3Ue 5V4dQLkSYsxqpZoRHN8ImVU885CCFMHEweVVMKFEhvsg7/dklu4p2X1HBzS3hXH64Aakoczy/6r 0AUXK5Buyc4lZhrZpSgkUfgzVfNfMSQcesH20vKJLxXmpTDXgTy63CPm2ICThA0TIrl7pqye3SS
 IHkYlPTVYKXW0HQSxdJhHnmVQySnn32yB/NGM06EkdEuZciOgGoZRdVYeUSsiCOsij5tD+c1Uej oDYkokrYijzITaiaSjxhzsnOVbi8U2rvkskTayP1rzYrZOYeHx9jUZ0WnPPaOpvG8OP4SHcPvzP ap69exRLRzG4u5aGQHtkRA/F/4kxumB372w162WG6QZ5J14WwZKQEuu66BaW74DdL+qqjOLy7jP
 4wMk8c/MAZqAhzf/yKtUQOsv0NgJ9pIwdgu467PhZcf5ITA6gls0rRyQhVkwvqwa8tEy1D+7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110119


On 6/10/25 5:52 PM, Pedro Falcato wrote:
> If uprobes are not enabled, the test currently fails with:
>
> 7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
> 7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
> 7153 12:46:54.639306  # # fopen: No such file or directory
> 7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected
> read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
> 7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
> 7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
> 7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
>
> Skipping is a more sane and friendly behavior here.
>
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/linux-mm/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>   tools/testing/selftests/mm/merge.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> index bbae66fc5038..cc26480098ae 100644
> --- a/tools/testing/selftests/mm/merge.c
> +++ b/tools/testing/selftests/mm/merge.c
> @@ -470,7 +470,9 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
>   	ASSERT_GE(fd, 0);
>   
>   	ASSERT_EQ(ftruncate(fd, page_size), 0);
> -	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
> +	if (read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) != 0) {
> +		SKIP(goto out, "Failed to read uprobe sysfs file, skipping");
> +	}


This looks good to me.

#  RUN           merge.handle_uprobe_upon_merged_vma ...
f /sys/bus/event_source/devices/uprobe/type
fopen: No such file or directory
#      SKIP      Failed to read uprobe sysfs file, skipping
#            OK  merge.handle_uprobe_upon_merged_vma
ok 8 merge.handle_uprobe_upon_merged_vma # SKIP Failed to read uprobe 
sysfs file, skipping
# PASSED: 8 / 8 tests passed.
# 1 skipped test(s) detected. Consider enabling relevant config options 
to improve coverage.
# Totals: pass:7 fail:0 xfail:0 xpass:0 skip:1 error:0


Tested-by : Donet Tom <donettom@linux.ibm.com>
Reviewed-by : Donet Tom <donettom@linux.ibm.com>


>   
>   	memset(&attr, 0, attr_sz);
>   	attr.size = attr_sz;
> @@ -491,6 +493,7 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
>   	ASSERT_NE(mremap(ptr2, page_size, page_size,
>   			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
>   
> +out:
>   	close(fd);
>   	remove(probe_file);
>   }


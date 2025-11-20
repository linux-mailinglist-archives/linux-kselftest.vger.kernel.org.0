Return-Path: <linux-kselftest+bounces-46103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D458DC74172
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7739135124E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5433858B;
	Thu, 20 Nov 2025 13:07:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F6326921;
	Thu, 20 Nov 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644049; cv=none; b=aY7AxpUSwnBf9HdNDFlBgIx5WQhI8d3PknML6XWei9iveHq/RJnTZDwaxazGk/k4UG8ifY85Sp9VT30qs8mmsPFyIfhAzjnzvK61QICYU5Oo/borC5P/OdCTDMt1J/ZRDFuh76S4F2KtomnGgjkaPnJbcKceKtUdoXOVkyuUxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644049; c=relaxed/simple;
	bh=Vy98BGuIgp18/kAzIYVCuB3D4ca+TizYR/0pdDYCPOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSOe/r2em1Y+fUThCx+rn3l7L44FfOZruWyQ10hR+K4QsR/PgrULFw2zG4BO7iHmY1rlbOOO8G3p9uNsBckQ1iCaj5EZVoCg5Yck8fArlBJNfdQHIoRTIgN6781eJaK330JH9nY5gcHAbPQMlZGV71cQlRc3+jx1pS8Y1YNdPSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9066a3cc61111f0a38c85956e01ac42-20251120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:791ca55d-03e9-4d7b-a11c-a98e286a0dab,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:791ca55d-03e9-4d7b-a11c-a98e286a0dab,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:b172629eee40a3f1101c592b6badb9d8,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9066a3cc61111f0a38c85956e01ac42-20251120
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 460365228; Thu, 20 Nov 2025 21:07:20 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llong@redhat.com,
	mkoutny@suse.com,
	shuah@kernel.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Thu, 20 Nov 2025 21:07:04 +0800
Message-Id: <20251120130704.1554368-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5e690981-2921-4b9f-9771-8afaa15018c8@huaweicloud.com>
References: <5e690981-2921-4b9f-9771-8afaa15018c8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On Thu, 20 Nov 2025 08:51:30, Chen Ridong wrote:
>On 2025/11/19 18:57, Sun Shaojie wrote:
>>  kernel/cgroup/cpuset.c                        | 19 +------------------
>>  .../selftests/cgroup/test_cpuset_prs.sh       |  7 ++++---
>>  2 files changed, 5 insertions(+), 21 deletions(-)
>> 
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..f6a834335ebf 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2411,34 +2411,17 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialc
>>  					struct tmpmasks *tmp)
>>  {
>>  	int retval;
>> -	struct cpuset *parent = parent_cs(cs);
>>  
>>  	retval = validate_change(cs, trialcs);
>>  
>>  	if ((retval == -EINVAL) && cpuset_v2()) {
>> -		struct cgroup_subsys_state *css;
>> -		struct cpuset *cp;
>> -
>>  		/*
>>  		 * The -EINVAL error code indicates that partition sibling
>>  		 * CPU exclusivity rule has been violated. We still allow
>>  		 * the cpumask change to proceed while invalidating the
>> -		 * partition. However, any conflicting sibling partitions
>> -		 * have to be marked as invalid too.
>> +		 * partition.
>>  		 */
>>  		trialcs->prs_err = PERR_NOTEXCL;
>> -		rcu_read_lock();
>> -		cpuset_for_each_child(cp, css, parent) {
>> -			struct cpumask *xcpus = user_xcpus(trialcs);
>> -
>> -			if (is_partition_valid(cp) &&
>> -			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
>> -				rcu_read_unlock();
>> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
>> -				rcu_read_lock();
>> -			}
>> -		}
>> -		rcu_read_unlock();
>>  		retval = 0;
>>  	}
>>  	return retval;
>
>If we remove this logic, there is a scenario where the parent (a partition) could end up with empty
>effective CPUs. This means the corresponding CS will also have empty effective CPUs and thus fail to
>disable its siblings' partitions.

I have carefully considered the scenario where parent effective CPUs are 
empty, which corresponds to the following two cases. (After apply this patch).

   root cgroup
        |
       A1
      /  \
    A2    A3

Case 1:
 Step:
 #1> echo "0-1" > A1/cpuset.cpus
 #2> echo "root" > A1/cpuset.cpus.partition
 #3> echo "0-1" > A2/cpuset.cpus
 #4> echo "root" > A2/cpuset.cpus.partition

 After step #4, 

                |      A1      |      A2      |      A3      |
 cpus_allowed   | 0-1          | 0-1          |              |
 effective_cpus |              | 0-1          |              |
 prstate        | root         | root         | member       |

 After step #4, A3's effective CPUs is empty.

 #5> echo "0-1" > A3/cpuset.cpus

 After step #5,

                |      A1      |      A2      |      A3      |
 cpus_allowed   | 0-1          | 0-1          | 0-1          |
 effective_cpus |              | 0-1          |              |
 prstate        | root         | root         | member       |

This patch affects step #5. After step #5, A3's effective CPUs is also empty.
Since A3's effective CPUs can be empty before step #5 (setting cpuset.cpus),
it is acceptable for them to remain empty after step #5. Moreover, if A3 is
aware that its parent's effective CPUs are empty, it should understand that
the CPUs it requests may not be granted.

Case 2:
 Step:
 #1> echo "0-1" > A1/cpuset.cpus
 #2> echo "root" > A1/cpuset.cpus.partition
 #3> echo "0" > A2/cpuset.cpus
 #4> echo "root" > A2/cpuset.cpus.partition
 #5> echo "1" > A3/cpuset.cpus
 #6> echo "root" > A3/cpuset.cpus.partition

 After step #6,

                |      A1      |      A2      |      A3      |
 cpus_allowed   | 0-1          | 0            | 1            |
 effective_cpus |              | 0            | 1            |
 prstate        | root         | root         | root         |

 #7> echo "0-1" > A3/cpuset.cpus

 After step #7,

                |      A1      |      A2      |      A3      |
 cpus_allowed   | 0-1          | 0            | 0-1          |
 effective_cpus | 1            | 0            | 1            |
 prstate        | root         | root         | root invalid |

This patch affects step #7. After step #7, A3 only affects itself, changing
from "root" to "root invalid". However, since its effective CPUs remain 1 
both before and after step #7, it doesn't matter even if A2 is not invalidated.

The purpose of this patch is to ensure that modifying cpuset.cpus does not 
disable its siblings' partitions.


Thanks,
Sun Shaojie


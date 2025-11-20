Return-Path: <linux-kselftest+bounces-46102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3CC7415D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C3EB350304
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5F30E82E;
	Thu, 20 Nov 2025 13:06:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C71326921;
	Thu, 20 Nov 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644009; cv=none; b=dr19LPfjzAqGJHLAABLu+xYaAEBIZBNTJkfnxxlTX9zSIoHaN7i/Gi959yyAIx3yiT0xhrd9m7bE3ofrI2K2Rt03wJmC8776z9O4YnuKXi3wfIlafhDPr0FvSqX6fWA7VcEeQdwDYKqDgIKPIErEToYk8+Sk8J4MLKJPZz+ME00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644009; c=relaxed/simple;
	bh=RGvJThNDKvEi3kAIVd2ILPgKgSEI63+ebSQhKwPrN4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/bvZv9dhIVhZdEYy+p5HgVtNpwd3d/oh6vAwRtoVUAWQA1JAm9+PPKg3h2GHZzN7LeqaCflrNYE0GNkKhWUQJEMfqcKxJCz5IU4ikgQJyHAArRsTWTr7/4S5rCY3Cg96dpXLab0WYgA8R2q1+ecS74zhVcqYlo8mzSYViVyuIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b2d92dd6c61111f0a38c85956e01ac42-20251120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3c1f7f0f-3eef-405a-bbbe-3cfc40ee9124,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:3c1f7f0f-3eef-405a-bbbe-3cfc40ee9124,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:42d86bd557a3a2a23587bc6bce955fd0,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:3,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b2d92dd6c61111f0a38c85956e01ac42-20251120
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2059068899; Thu, 20 Nov 2025 21:06:16 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llong@redhat.com,
	shuah@kernel.org,
	sunshaojie@kylinos.cn,
	tj@kernel.org
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict.
Date: Thu, 20 Nov 2025 21:05:57 +0800
Message-Id: <20251120130557.1554118-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
References: <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Michal,

On Wed, 19 Nov 2025 14:20:25, Michal Koutný wrote:
>On Wed, Nov 19, 2025 at 06:57:49PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with its sibling partition, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary. If the cpuset being
>> modified is exclusive, it should invalidate itself upon conflict.
>> 
>> This patch applies only to the following two cases：
>> 
>> Assume the machine has 4 CPUs (0-3).
>> 
>>    root cgroup
>>       /    \
>>     A1      B1
>> 
>> Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus
>> 
>>  Table 1.1: Before applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>> 
>> After step #3, A1 changes from "root" to "root invalid" because its CPUs
>> (0-1) overlap with those requested by B1 (0). However, B1 can actually
>> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
>> remain as "root."
>> 
>>  Table 1.2: After applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "0" > B1/cpuset.cpus              | root         | member       |
>> 
>> Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus
>
>(Thanks for working this out, Shaojie.)
>
>> 
>>  Table 2.1: Before applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>  #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
>> 
>> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
>> regardless of what conflicting value B1 writes to cpuset.cpus, it will
>> always have at least CPU 2 available. This makes it unnecessary to mark
>> A1 as "root invalid".
>> 
>>  Table 2.2: After applying this patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>  #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
>> 
>> In summary, regardless of how B1 configures its cpuset.cpus, there will
>> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
>> is no need to change A1 from "root" to "root invalid".
>
>Admittedly, I don't like this change because it relies on implicit
>preference ordering between siblings (here first comes, first served)
>and so the effective config cannot be derived just from the applied
>values :-/
>
>Do you actually want to achieve this or is it an implementation
>side-effect of the Case 1 scenario that you want to achieve?

Yes, this is indeed the functionality I intended to achieve, as I find it 
follows the same logic as Case 1.

However, I didn't fully understand what you meant by "implicit preference 
ordering between siblings (here first comes, first served)."
Could you provide an example?

As for your point that "the effective config cannot be derived just from 
the applied values," even before this patch, we couldn't derive the final 
effective configuration solely from the applied values.

For example, consider the following scenario: (not apply this patch)
Table 1:
 Step                                       | A1's prstate | B1's prstate |
 #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
 #3> echo "1-2" > B1/cpuset.cpus            | root invalid | member       |

Table 2:
 Step                                       | A1's prstate | B1's prstate |
 #1> echo "1-2" > B1/cpuset.cpus            | member       | member       |
 #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member       |
 #3> echo "0-1" > A1/cpuset.cpus            | root         | member       |

After step #3, both Table 1 and Table 2 have identical value settings, 
yet A1's partition state differs between them.


Thanks,
Sun Shaojie


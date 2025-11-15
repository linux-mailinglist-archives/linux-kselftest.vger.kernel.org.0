Return-Path: <linux-kselftest+bounces-45688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E207C6004E
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 07:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 361154E03C0
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 06:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627A18FDBE;
	Sat, 15 Nov 2025 06:02:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51217E573;
	Sat, 15 Nov 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763186569; cv=none; b=co76+uvcj2IBjqL4xYc6aC7mIhokNDWLR5e9DeNW7/N6urtSoG4ZO71jdYFuNHLfc6HACL9JuHPnBwtVWBRl6CnWb3DDojsh/0W50q15UOhFlU5IiDXEzUPzpR0EApQs5VEWogPxe+l1jv+CMoIFmRGX1qx1Nik9shRV9wfM2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763186569; c=relaxed/simple;
	bh=HWn6RBkai68zxkPpvLLX46f2K4h5tZ4ZIf7bNJ9gNqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ND4zW9p0dTgRA1Fq8RzaRQv6C00anKRknwEb/jdkh93OqJsFoL/CV0Mooj3OMogMNoWLTY0rbO725FvVrhw5wPMdV3FcohERxniekHFtXdAEbHnrUJeg19MY7ReNh70gKW7e2+14abmUCkk1eMRKq8ryOLzdCvL+voM89rNEkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aa4f3e8ac1e811f0a38c85956e01ac42-20251115
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5720edaf-b224-413e-9367-779ab62b039f,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:5720edaf-b224-413e-9367-779ab62b039f,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:e52878ea32843cc2ad53e511f365b685,BulkI
	D:251113225812EYOJ6GI2,BulkQuantity:12,Recheck:0,SF:17|19|38|64|66|78|80|8
	1|82|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aa4f3e8ac1e811f0a38c85956e01ac42-20251115
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 237670635; Sat, 15 Nov 2025 14:02:28 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: chenridong@huaweicloud.com,
	mkoutny@suse.com,
	llong@redhat.com
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Sat, 15 Nov 2025 14:02:11 +0800
Message-Id: <20251115060211.853449-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2015/11/15 08:58, Chen Ridong wrote:
>On 2025/11/15 0:14, Michal Koutný wrote:
>> On Fri, Nov 14, 2025 at 09:29:20AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>> After further consideration, I still suggest retaining this rule.
>> 
>> Apologies, I'm slightly lost which rule. I hope the new iteration from
>> Shaojie with both before/after tables will explain it.
>> 
>
>The rule has changed in this patch from "If either cpuset is exclusive, check if they are mutually
>exclusive" to
>"If both cpusets are exclusive, check if they are mutually exclusive"
>
>  -    /* If either cpuset is exclusive, check if they are mutually exclusive */
>  -    if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>  +    /* If both cpusets are exclusive, check if they are mutually exclusive */
>  +    if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>  +        return !cpusets_are_exclusive(cs1, cs2);
>
>I suggest not modifying this rule and keeping the original logic intact:
>
>>> For am example:
>>>   Step                                       | A1's prstate | B1's prstate |
>>>   #1> mkdir -p A1                            | member       |              |
>>>   #2> echo "0-1" > A1/cpuset.cpus.exclusive  | member       |              |
>>>   #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>>>   #4> mkdir -p B1                            | root         | member       |
>>>   #5> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>>>
>>> Currently, we mark A1 as invalid. But similar to the logic in this patch, why must A1 be
>>> invalidated?
>> 
>> A1 is invalidated becase it doesn't have exclusive ownership of CPU 0
>> anymore.
>> 
>>> B1 could also use the parent's effective CPUs, right?
>> 
>> Here you assume some ordering between siblings treating A1 more
>> important than B1. But it's symmetrical in principle, no?
>> 
>
>I’m using an example to illustrate that if Shaojie’s patch is accepted, other rules could be relaxed
>following the same logic—but I’m not in favor of doing so.

Hi, Ridong,

Thank you for pointing out the issue with the current patch; this is indeed
not what our product intends. I must admit that I haven't thoroughly tested
on such recent kernel versions.

Obviously, this patch is flawed. However, patch v3 is needed. Regarding the
"other rules" you mentioned, we do not intend to relax them. On the 
contrary, we aim to maintain them firmly.

Our product need ensure the following behavior: in cgroup-v2, user 
modifications to one cpuset should not affect the partition state of its 
sibling cpusets. This is justified and meaningful, as it aligns with the 
isolation characteristics of cgroups.

This can be divided into two scenarios:
Scenario 1: Only one of A1 and B1 is "root".
Scenario 2: Both A1 and B1 are "root".

We plan to implement Scenario 1 first. This is the goal of patch v2.
However, patch v2 is flawed because it does not strictly adhere to the 
following existing rule.

However, it is worth noting that the current cgroup v2 implementation does 
not strictly adhere to the following rule either (which is also an 
objective for patch v3 to address).

Rule 1: "cpuset.cpus" cannot be a subset of a sibling's "cpuset.cpus.exclusive".

Using your example to illustrate.
 Step (refer to the steps in the table below）
 #1> mkdir -p A1                           
 #2> echo "0-1" > A1/cpuset.cpus.exclusive 
 #3> echo "root" > A1/cpuset.cpus.partition
 #4> mkdir -p B1               
 #5> echo "0" > B1/cpuset.cpus 

Table 1: Current result
 Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
 #1   | 0      |                |           | member       |              |
 #2   | 0      | 0-1            |           | member       |              |
 #3   | 0      | 0-1            |           | root         |              |
 #4   | 0      | 0-1            |           | root         | member       |
 #5   | 0      | 0-1            | 0         | root invalid | member       |

Table 2: Expected result
 Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
 #1   | 0      |                |           | member       |              |
 #2   | 0      | 0-1            |           | member       |              |
 #3   | 0      | 0-1            |           | root         |              |
 #4   | 0      | 0-1            |           | root         | member       |
 #5   | error  | 0-1            |           | root         | member       |

Currently, after step #5, the operation returns success, which clearly 
violates Rule 1, as B1's "cpuset.cpus" is a subset of A1's 
"cpuset.cpus.exclusive".

Therefore, after step #5, the operation should return error, with A1 
remaining as "root". This better complies with the Rule 1.

------
The following content is provided for reference, and we hope it may be 
adopted in the future.
!!These are not part of what patch v3 will implement.

As for Scenario 2 (Both A1 and B1 are "root")， we will retain the current 
cgroup v2 behavior. This patch series does not modify it, but we hope to 
draw the maintainers' attention, as we indeed have plans for future 
modifications. Our intent can be seen from the following examples.

For example:
 Step (refer to the steps in the table below）
 #1> mkdir -p A1                           
 #2> echo "0-1"  > A1/cpuset.cpus 
 #3> echo "root" > A1/cpuset.cpus.partition
 #4> mkdir -p B1               
 #5> echo "2-3"  > B1/cpuset.cpus 
 #6> echo "root" > B1/cpuset.cpus.partition
 #7> echo "1-2"  > B1/cpuset.cpus

Table 1: Current result
 Step | A1's eft_cpus | B1's eft_cpus | A1's prstate | B1's prstate |
 #1   | from parent   |               | member       |              |
 #2   | 0-1           |               | member       |              |
 #3   | 0-1           |               | root         |              |
 #4   | 0-1           | from parent   | root         | member       |
 #5   | 0-1           | 2-3           | root         | member       |
 #6   | 0-1           | 2-3           | root         | root         |
 #7   | 0-1           | 1-2           | root invalid | root invalid |

Table 2: Expected result
 Step | A1's eft_cpus | B1's eft_cpus | A1's prstate | B1's prstate |
 #1   | from parent   |               | member       |              |
 #2   | 0-1           |               | member       |              |
 #3   | 0-1           |               | root         |              |
 #4   | 0-1           | from parent   | root         | member       |
 #5   | 0-1           | 2-3           | root         | member       |
 #6   | 0-1           | 2-3           | root         | root         |
 #7   | 0-1           | 2             | root         | root invalid |

After step #7, we expect A1 to remain "root" (unaffected), while only B1 
becomes "root invalid".

 
The following Rule 2 and Rule 3 are alsomplemented and adhered to by our 
product. The current cgroup v2 implementation does not enforce them. 
Likewise, we hope this will draw the maintainers' attention. Maybe, they can
be applied in the future.

Rule 2: In one cpuset, when "cpuset.cpus" is not null, "cpuset.cpus.effective"
        must either be a subset of it, or "cpuset.cpus.effective" is null.

Rule 3: In one cpuset, when "cpuset.cpus" is not null, "cpuset.cpus.exclusive"
        must either be a subset of it, or "cpuset.cpus.exclusive" is null.

Rationale: "cpuset.cpus" represents the CPUs requested by the user, and the
        system should honor the user's intention.

---
Thanks,
Sun Shaojie




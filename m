Return-Path: <linux-kselftest+bounces-46104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63DC74184
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F220935066C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 13:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6C2339B4F;
	Thu, 20 Nov 2025 13:08:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E7333438;
	Thu, 20 Nov 2025 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644099; cv=none; b=IIP1PPTaGT+aHmaWHXVLddoXRr7HwJCyZq5jX6fQPyw/xHIQ3C3cMG01Ysf6rv9JnKTiSFKDJfbQW341nJecOP7j/0IJhc2RpwyKKHH/fOdPTEOF+fLmC27i6sfMer/LlVqQbzrwiIfKiRddt66yhelKcj/GzTKN7+DNd95ESJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644099; c=relaxed/simple;
	bh=lU2ZVTe+uxTYCKPyOq+n3HvyR7i812t/b1uYsH4K+s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJI8R0rfNkEScN6dLICFvy7jpxokSMiYyU6bN6ZEDM/NRC19sLDidWS5ParyUdtUC1d4E9lrNmInhEC4208Gg3Yz5bXmV8G6kDlN1IBhK7e84QqPJYilR7JrFkTC3gbXIcYg2uKEIhwLmDLqza3mgsw7nNwPqrWOwoC2XHSavnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f214ccd0c61111f0a38c85956e01ac42-20251120
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
X-CID-O-INFO: VERSION:1.3.6,REQID:d1a5438a-6d45-40c8-af73-f51ad9cee350,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:d1a5438a-6d45-40c8-af73-f51ad9cee350,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:8483b94bc1721e408cea7e78eaa79adc,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:5,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
	KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f214ccd0c61111f0a38c85956e01ac42-20251120
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 901818270; Thu, 20 Nov 2025 21:08:02 +0800
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
Date: Thu, 20 Nov 2025 21:07:50 +0800
Message-Id: <20251120130750.1554604-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <06d74676-258e-43b7-ae61-d2102bab3926@huaweicloud.com>
References: <06d74676-258e-43b7-ae61-d2102bab3926@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Ridong,

On Thu, 20 Nov 2025 08:57:51, Chen Ridong wrote:
>On 2025/11/19 21:20, Michal Koutný wrote:
>> On Wed, Nov 19, 2025 at 06:57:49PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>>>  Table 2.1: Before applying this patch
>>>  Step                                       | A1's prstate | B1's prstate |
>>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>>  #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
>>>
>>> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
>>> regardless of what conflicting value B1 writes to cpuset.cpus, it will
>>> always have at least CPU 2 available. This makes it unnecessary to mark
>>> A1 as "root invalid".
>>>
>>>  Table 2.2: After applying this patch
>>>  Step                                       | A1's prstate | B1's prstate |
>>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>>  #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>>>  #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>>>  #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
>>>
>>> In summary, regardless of how B1 configures its cpuset.cpus, there will
>>> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
>>> is no need to change A1 from "root" to "root invalid".
>> 
>> Admittedly, I don't like this change because it relies on implicit
>> preference ordering between siblings (here first comes, first served)
>
>Agree. If we only invalidate the latter one, I think regardless of the implementation approach, we
>may end up with different results depending on the order of operations.


I don't understand the "order of operations" mentioned here. After reviewing
the previous email content, are you referring to this?

On Sat, 15 Nov 2025 15:41:03, Chen Ridong wrote:
>With the result you expect, would we observe the following behaviors:
>
>#1> mkdir -p A1
>#2> mkdir -p B1
>#3> echo "0-1"  > A1/cpuset.cpus
>#4> echo "1-2"  > B1/cpuset.cpus
>#5> echo "root" > A1/cpuset.cpus.partition
>#6> echo "root" > B1/cpuset.cpus.partition # A1:root;B1:root invalid
>
>#1> mkdir -p A1
>#2> mkdir -p B1
>#3> echo "0-1"  > A1/cpuset.cpus
>#4> echo "1-2"  > B1/cpuset.cpus
>#5> echo "root" > B1/cpuset.cpus.partition
>#6> echo "root" > A1/cpuset.cpus.partition # A1:root invalid;B1:root
>
>Do different operation orders yield different results? If so, this is not what we expect.

However, after applying this patch, the outcomes of these two examples are 
as follows:
 
 #1> mkdir -p A1
 #2> mkdir -p B1
 #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
 #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
 #5> echo "root" > A1/cpuset.cpus.partition | root invalid | root        |
 #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid|

 #1> mkdir -p A1
 #2> mkdir -p B1
 #3> echo "0-1"  > A1/cpuset.cpus           | member       | member      |
 #4> echo "1-2"  > B1/cpuset.cpus           | member       | member      |
 #5> echo "root" > B1/cpuset.cpus.partition | root         | root invalid|
 #6> echo "root" > A1/cpuset.cpus.partition | root invalid | root invalid|

Moreover, even without applying this patch, the result remains the same,
because modifying cpuset.cpus.partition does not disable its siblings' partitions.

So, what are the specific issues that you believe would arise?


Thanks,
Sun Shaojie


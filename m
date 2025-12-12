Return-Path: <linux-kselftest+bounces-47501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B33CB8971
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 11:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25BEC304B951
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F475316915;
	Fri, 12 Dec 2025 10:12:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5252F6921;
	Fri, 12 Dec 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534335; cv=none; b=QDCWoekT4qm1YHo43rF66vid+gfJbE8SwPVMGQKWC1+yDqcYio9SxER3nqoM2LmAyz0AP0yxW6Kv1IpLzhfSxALtYpHT1BJ6gabdBIUmNtgQ8iPCy4+uLFfkXlqJeTig1NYjb4d+WOF4jy+73GP1t0WyzH2zljsm9MNuih0JDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534335; c=relaxed/simple;
	bh=PXnSRzi8FmadxcZpsrNXLauxd4MUDOrBRcDnmLzmsus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO9W+7UGAGbvE3ZIYXjssaqa1EyLT5flkePVE3VrcJ5jCcmSlAdeQgFeNPqUImhfC80/1H4Pb8/567lxQ5iAo5bdDs28sYERGoIZMMfRLfRby/Oc23cYZadsjpywh9xVR39pHaHfAvArvb9sG+NJIISrDAIrhx8+HBfh6f+GiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fa82ab02d74211f0a38c85956e01ac42-20251212
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:47d4b3cf-327d-4b20-8602-fd37bf6e2068,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:47d4b3cf-327d-4b20-8602-fd37bf6e2068,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:78e7f9d771334a2709eaa6ca9b9a0f49,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:29,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fa82ab02d74211f0a38c85956e01ac42-20251212
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1627458903; Fri, 12 Dec 2025 18:11:51 +0800
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
Date: Fri, 12 Dec 2025 18:10:35 +0800
Message-Id: <20251212101035.1194896-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <in2stxqa2swky4zwzlrm4h5vuz627ruedhq6zqr22xqwv5di7c@vcwc3z2sczx4>
References: <in2stxqa2swky4zwzlrm4h5vuz627ruedhq6zqr22xqwv5di7c@vcwc3z2sczx4>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Michal

On Thu, 11 Dec 2025 11:59:27 +0100, Michal Koutný wrote:
>On Wed, Dec 10, 2025 at 06:11:08PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> Regardless of whether A1 through A5 belong to the same user or different
>> users, arbitration conflicts between sibling nodes can still occur (e.g.,
>> due to user misconfiguration). The key question is: when such a conflict
>> arises, should all sibling nodes be invalidated, or only the node that
>> triggered the conflict?
>
>Any serious [1] affinity users should watch for cpuset.cpus.partition
>already (since it can be invalidated by hotplug or IMO more probable
>ancestor re-configuration). Do you agree?
>
>Then I'd say it's reasonable to invalidate all (same reasoning -- it
>doesn't matter on the order in which siblings are configured, I consider
>local partitions). What would you see as the upsides of invalidating
>only the last offender (under the assumption above about watching)?

I agree that users should watch the state of their cpuset.cpus.partition.
Moreover, assuming the user is watching, there is no harm in invalidating
only the last conflicting partition.

For example

           root cgroup
                |
   --------------------------
   |      |     |    |      |    
   A      B    ...   M      N
 (root) (root) ... (root) (root)

Condition: Node N is the last one configured by the user.
           After its configuration, it conflicts with all previous nodes
           (A through M).

When all are invalidated, the user will notice that A-M are all invalidated
because they are watching. If the user wants to restore the exclusivity
of A-M, they need to reconfigure A-M once more, as well as N.

When only the last conflict is invalidated, the user will notice that N is
invalidated, and then they only need to reconfigure N.
This seems more convenient for the user.

However, whether watching is in place is not the key to this issue,
because watching merely reveals the outcome.

If A through N belong to different users, and when N conflicts with all of
A through M, then after the users of A-M observe the invalidation result
through watching, they cannot even restore their exclusive state, because
they will always conflict with N.

Thanks,
Sun Shaojie


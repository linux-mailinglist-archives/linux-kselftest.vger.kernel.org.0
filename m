Return-Path: <linux-kselftest+bounces-46786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 471ABC966C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 10:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A2533431DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFD63016EA;
	Mon,  1 Dec 2025 09:42:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33806301487;
	Mon,  1 Dec 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582177; cv=none; b=FodiyY95jaPJEGuubk6nd8l+CZJKowjLKHKRmFKyKzc+E3a/DchiFg7c+6xaDBLyD/qs6DbxJrzPn4rl2oyu+tC70eP3q3b1NYst1drFsiOnD1tVJDdW7cV7TJgxSVbGHR7p060PaWMAzPOt1k7k3+xs8o+gd3lK3YwK9J4UXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582177; c=relaxed/simple;
	bh=c0MAN3++v0cVVysMrmKEJvtDwT5VV4WAJqdNDkvhs20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Svj30NlpRzJ/FddFO8Cf7p1VGIzmG65uMjZB3D1dFy0Rq1gknQz8IRuCV4ERcTbU3R0Y2XeGR7x97UUIDHhVQNAIWsQ53MM4Dmu1cXRofRFDWKzb++5bVTOb2xL5nxwkk+pdjOfrbq96LJRAfgIGbI6sBJkLRFz5NdnXkvwf1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 18bf3e2ace9a11f0a38c85956e01ac42-20251201
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:cfe34a1d-0e60-4cbf-b7c1-8e3460fa68df,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:cfe34a1d-0e60-4cbf-b7c1-8e3460fa68df,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:928107dbc886cf9e0df166e58e4abe66,BulkI
	D:251119212056S6LKT8LY,BulkQuantity:23,Recheck:0,SF:17|19|64|66|78|80|81|8
	2|83|102|127|841|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 18bf3e2ace9a11f0a38c85956e01ac42-20251201
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 242978694; Mon, 01 Dec 2025 17:42:48 +0800
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
Date: Mon,  1 Dec 2025 17:42:36 +0800
Message-Id: <20251201094236.108081-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <nfg4xqeoa4qqz7xypddzj756jhlsieeqfnpgvzwsltb7lnqz57@qgatuaufa7hq>
References: <nfg4xqeoa4qqz7xypddzj756jhlsieeqfnpgvzwsltb7lnqz57@qgatuaufa7hq>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Michal

On Wed, 26 Nov 2025 15:13:13, Michal Koutný wrote:
>On Thu, Nov 20, 2025 at 09:05:57PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> >Do you actually want to achieve this or is it an implementation
>> >side-effect of the Case 1 scenario that you want to achieve?
>> 
>> Yes, this is indeed the functionality I intended to achieve, as I find it 
>> follows the same logic as Case 1.
>
>So you want to achieve a stable [1] set of CPUs for a cgroup that cannot
>be taken away from you by any sibling, correct?
>My reasoning is that the siblings should be under one management entity
>and therefore such overcommitment should be avoided already in the
>configuration. Invalidating all conflicting siblings is then the most
>fair result achievable.
>B1 is a second-class partition _only_ because it starts later or why is
>it OK to not fulfill its requirement?
>

If the siblings are under a single management entity, that certainly works.
But what if there are multiple administrative users? Should we really
violate other users' requirements just to satisfy one user's requirement?
Given this, first-come-first-served might be fairer.

>[1] Note that A1 should still watch its cpuset.cpus.partition if it
>takes exclusivity seriously because its cpus may be taken away by
>hot(un)plug or ancestry reconfiguration.

Thanks,
Sun Shaojie


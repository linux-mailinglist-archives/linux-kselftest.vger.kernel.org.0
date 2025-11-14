Return-Path: <linux-kselftest+bounces-45606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 344AEC5B416
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 04:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC39534A24D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 03:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05826FD9B;
	Fri, 14 Nov 2025 03:58:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63644238C0D;
	Fri, 14 Nov 2025 03:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092733; cv=none; b=ZOFkm3Yk5V7PcExUg1+ED3PV2BQt7kxTe9DGyr28/ejLG8AF3xCoTuBzxUUjmUXbn/LN9yJBuhCUJ4OYRpZbClWRNNqozkmKEQ2xzT+dIQatWVTulxYimGkxes3KG3JqU3g+23sokucUQiwL/0TQlhT/NfCROTHrpxir8KoC8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092733; c=relaxed/simple;
	bh=jLK5SvYihbvAZZAmD1Y5pXgADx4KtTfCx42eajBhW/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvAoMxWh6ARR+vUj1vDaF/O7ZMdnDZVD36IH/JwplaAV3uMcE4M+xwEg2pKSWNLVhyF1q6W2b6w7HqvWjNCpo0jw88rSf3/tic584vzOC6dmYAYy2zgLlV+fMSEVReCwg/kXj7seTkIEuafO2HN4HinMq+DxlBc/mnAhtQ4rwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32bb2b20c10e11f0a38c85956e01ac42-20251114
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d25ded52-3a7d-48e5-aeab-296aff2329db,IP:10,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.3.6,REQID:d25ded52-3a7d-48e5-aeab-296aff2329db,IP:10,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:a9d874c,CLOUDID:a25de5dcc271b445f1a2c966e73d6fe1,BulkI
	D:251113184535IYNM5ZGZ,BulkQuantity:1,Recheck:0,SF:19|66|72|78|81|82|83|10
	2|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:4
	0,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32bb2b20c10e11f0a38c85956e01ac42-20251114
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 925737466; Fri, 14 Nov 2025 11:58:37 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: mkoutny@suse.com
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sebastian.chlad@suse.com,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] selftests/cgroup: conform test to TAP format output
Date: Fri, 14 Nov 2025 11:55:48 +0800
Message-Id: <your-message-id>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
References: <6lwnagu63xzanum2xx6vkm2qe4oh74fteqeymmkqxyjbovcce6@3jekdivdr7yf>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michal,

Thanks for reviewing and pointing out [1].

> Could you please explain more why is the TAP layout beneficial?
> (I understand selftest are for oneself, i.e. human readable only by default.)

Actually, selftests are no longer just something for developers to view locally; they are now extensively 
run in CI and stable branch regression testing. Using a standardized layout means that general test runners 
and CI systems can parse the cgroup test results without any special handling.

TAP provides a structured format that is both human-readable and machine-readable. The plan/result lines are parsed by tools, 
while the diagnostic lines can still contain human-readable debug information. Over time, other selftest suites (such as mm, KVM, mptcp, etc.) 
have also been converted to TAP-style output, so this change just brings the cgroup tests in line with that broader direction.

> Or is this part of some tree-wide effort?

This patch is not part of a formal, tree-wide conversion series I am running; it is an incremental step to align the 
cgroup C tests with the existing TAP usage. I started here because these tests already use ksft_test_result_*() and 
only require minor changes to generate proper TAP output.

> I'm asking to better asses whether also the scripts listed in
> Makefile:TEST_PROGS should be converted too.

I agree that having them produce TAP output would benefit tooling and CI. I did not want to mix 
that into this change, but if you and other maintainers think this direction is reasonable, 
I would be happy to follow up and convert the cgroup shell tests to TAP as well.

Thanks again for your review.

Best regards,  
Guopeng



Return-Path: <linux-kselftest+bounces-47657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5981ACC6FD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 11:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DF643005A93
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9E30DEBA;
	Wed, 17 Dec 2025 09:45:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B12D3ECF;
	Wed, 17 Dec 2025 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964759; cv=none; b=gl7AK6E5xZsEYj+2FHHNHWqS9kHCyCBd0tnf3eDetxL4RZu350IYAppFbixh5CL0yxoOLorcxHqxtzQbcXUU+hEY32EhR1Ps/Fb3WXtCsytzzy+VyEaoldIGkLxzvN+M/PUfjJB5mLVHtExRuPSimwEwjQ85xu5gUTw7hGoSwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964759; c=relaxed/simple;
	bh=6hvUv+VLVmmto+6G3OE/9ao0lz7vkNouNeX1B7z+www=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pn4wIE6wjedCcXARATv7IRpt0riZvwo6mZroW4WRZmc8mOMhvOdAOtkyGl0ZbelZLnVIPqNUE6nSLb+G0BASu//rcIZklyD735PyfLyRP+1sNSUuBBQPdoTfPL3IpJJ2D3YIAp3r6hkN7NYU5HAlJ7vMIpqH0CgARvBKmWBRets=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 28bfcd54db2d11f0a38c85956e01ac42-20251217
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7f0e7c3a-df2a-40cf-81ae-8b12a5b544fd,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:7f0e7c3a-df2a-40cf-81ae-8b12a5b544fd,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:268aae03b4a79f27fe08ba5b59ee7556,BulkI
	D:251217174545BJM301DX,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 28bfcd54db2d11f0a38c85956e01ac42-20251217
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(183.242.174.20)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 729195290; Wed, 17 Dec 2025 17:45:45 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: llong@redhat.com
Cc: cgroups@vger.kernel.org,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	tj@kernel.org
Subject: [PING][PATCH v6] cpuset: Avoid invalidating sibling partitions on cpuset.cpus conflict
Date: Wed, 17 Dec 2025 17:45:30 +0800
Message-Id: <20251217094530.1448665-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251201093806.107157-1-sunshaojie@kylinos.cn>
References: <20251201093806.107157-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Longman,
 
Just a friendly ping regarding the patch "[PATCH v6] cpuset: Avoid
invalidating sibling partitions on cpuset.cpus conflict" sent on
[Mon,  1 Dec 2025 17:38:06 +0800].
Link: https://lore.kernel.org/cgroups/20251201093806.107157-1-sunshaojie@kylinos.cn/

Could you please take a look when you have a moment? We'd appreciate any
initial feedback or suggestions you might have.

Thank you again for your time and consideration.

Thanks,
Sun Shaojie


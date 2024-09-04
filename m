Return-Path: <linux-kselftest+bounces-17127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CA96BEEE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B4B1C24A05
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BC1DA314;
	Wed,  4 Sep 2024 13:43:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466D1DA2F7;
	Wed,  4 Sep 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457390; cv=none; b=lgbwZGb9zd9yq1bWXnbHOobL3EtvsJgaJcAJ2SBt5QLatTlrlP8yx+7DbgGMb883Enp+bFyKLOpCN5nksXFn/7lhK9HWWmA9nzhlrboMtgdXb4Y6Gbf9kjaMWOPknEcwDc3FvnGYrHwlpVTCI6jwNICINYOOURlLXDTKSMc4lXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457390; c=relaxed/simple;
	bh=/3VH3DWsAa3brp4Q4CK/f35/uVdfNvQWVsRqLAUx9O0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twh5pOWPLOyPw9xchHJ461tCluDl/c6EwqxBwGLlMhXYvR2hwei6l7Rs0WRy3EiFiBa/Wub0fmiE6KrKvq4SOkluqMczDka8Gtc77sDkpWLH5Buo1RA8Btr6/nZ2qkxel7fMHC2Uh4UPwl+AAT58Kh6I18YUt2VBB31ie+V66sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WzNvj1tKsz1BLkL;
	Wed,  4 Sep 2024 21:42:09 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id CCBED1400FF;
	Wed,  4 Sep 2024 21:43:06 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 21:43:06 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, David Gow
	<davidgow@google.com>, <linux-kselftest@vger.kernel.org>,
	<kunit-dev@googlegroups.com>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/3] debugobjects: Add hlist_cut_number() and use it to optimize code
Date: Wed, 4 Sep 2024 21:41:49 +0800
Message-ID: <20240904134152.2141-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)


Zhen Lei (3):
  list: add hlist_cut_number()
  list: test: Add a test for hlist_cut_number()
  debugobjects: Use hlist_cut_number() to optimize performance and
    improve readability

 include/linux/list.h |  44 +++++++++++++++++
 lib/debugobjects.c   | 115 ++++++++++++++++++-------------------------
 lib/list-test.c      |  51 +++++++++++++++++++
 3 files changed, 143 insertions(+), 67 deletions(-)

-- 
2.34.1



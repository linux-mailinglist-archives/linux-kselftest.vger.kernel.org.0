Return-Path: <linux-kselftest+bounces-19436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E952E9983ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247ED1C21941
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0B1BF7E7;
	Thu, 10 Oct 2024 10:39:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568F1BBBE5;
	Thu, 10 Oct 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556745; cv=none; b=S8Sx7CF7EE0mWhGnaev66kPnUjRVHaLykHq9rD6DewWKpsw/+fNQ6lfoMxZXINsQAPI5Brjk1rYaM3RTp0Mer4SjIECQjAR8NwdZyMu9ntgTtkHjPiGMb8cEyeqZK9s9K8/oM0ZQUmmZS81Gy+AT01uoyBHsnqoVGFtwplQ28cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556745; c=relaxed/simple;
	bh=+/BA0dLgxO8wAG+3HrR28u8hSmQpVqRVWw/L70ASVVo=;
	h=From:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTJjHq14I0JHCdXqdGysBYrX0ZJbi7sW6PmsBsKBSUVDJ6eaZ2MvWTfeI4W88qEchMrNUR8FL6RBmlsYpAw+jDY9SGm1Dh2W83sjbOB6Zq74RrnrDhGRVOwdePjoSaJg1IbnRhSIJ0re7aigzoPXGuyjAv60OsCPsmsQuQO+9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPR7L5kt8z6K5s4;
	Thu, 10 Oct 2024 18:38:38 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C398140556;
	Thu, 10 Oct 2024 18:38:59 +0800 (CST)
Received: from GurSIX1 (10.204.104.168) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 12:38:53 +0200
From: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
References: <cover.1728555449.git.gur.stavi@huawei.com> <9e15c0c2cd19d94207a1791de0dc9051a5abb95a.1728555449.git.gur.stavi@huawei.com>
In-Reply-To: <9e15c0c2cd19d94207a1791de0dc9051a5abb95a.1728555449.git.gur.stavi@huawei.com>
Subject: RE: [PATCH net-next v03 1/3] af_packet: allow fanout_add when socket is not RUNNING
Date: Thu, 10 Oct 2024 13:38:47 +0300
Message-ID: <002f01db1b00$9d09d9a0$d71d8ce0$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGv7mksA7veRkl0u2n9N9OvQm77J/yjDg
Content-Language: en-us
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> Subject: [PATCH net-next v03 1/3] af_packet: allow fanout_add when socket
> is not RUNNING
> 
> PACKET socket can retain its fanout membership through link down and up
> and leave a fanout while closed regardless of link state.
> However, socket was forbidden from joining a fanout while it was not
> RUNNING.
> 
> This patch allows PACKET socket to join fanout while not RUNNING.
> 
> The previous test for RUNNING also implicitly tested that the socket is
> bound to a device. An explicit test of ifindex was added instead.

I had some mess up with the send-email. I prepared the following more
complete git comment but sent the wrong patch. The code is still the same.

---
PACKET socket can retain its fanout membership through link down and up
and leave a fanout while closed regardless of link state.
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This patch allows PACKET socket to join fanout while not RUNNING.

Socket can be RUNNING if it has a specified protocol. Either directly 
from packet_create (being implicitly bound to any interface) or following
a successful bind. Socket RUNNING state is switched off if it is bound to
an interface that went down.

Instead of the test for RUNNING, this patch adds a test that socket can
receive packets before allowing it into a fanout group. Socket can
receive packets if it has a configured protocol and is bound to an
interface or bound to any interface.

The only difference between the previous test and the current test is
that the bound interface is allowed to have IFF_UP cleared.
---





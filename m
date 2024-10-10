Return-Path: <linux-kselftest+bounces-19438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA8998557
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 13:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0B9283090
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 11:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3541C2DA3;
	Thu, 10 Oct 2024 11:49:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD577183CD9;
	Thu, 10 Oct 2024 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728560977; cv=none; b=t8e7mZz3OMUnxnfGJh1IB7yvaq8Zl9yV30iPi51YLV1D8Ek8UrWn2HAbyi9kiUmg+DZ1c6R4nuBNfUshI3PUZs8zJnLAdKoUwt+mOO9e697MhDhiyhU1Ki7OHTVPRU0CH2hUNqqDeDxaa3FynZiqVoFr/YqZ/2spl4RSqtifhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728560977; c=relaxed/simple;
	bh=dsavc7aCLpr1amf6pmWGA9HnXnSGW9kXtxo3xOPhjwU=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QG1zp0A8UsiE0RBDOek7YXLbYy+9SlyIZdhFhwF0ljm4HF4RZgJXM0KJKfZiOL6QaxxcI3EXgXaSa/0IfHEglhBKIuXibZFMHZD8pHhNRJ4yXGUZVx5fYP5Vy1B1kcw99FXhQrvOPjkcorv4vi8kgijdwaMB328Cuiw1VxzwCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPSc65pB6z6LCkk;
	Thu, 10 Oct 2024 19:45:10 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 8440E140AE5;
	Thu, 10 Oct 2024 19:49:31 +0800 (CST)
Received: from GurSIX1 (10.204.104.168) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 13:49:25 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch> <20241009065837.354332-1-gur.stavi@huawei.com> <67068a44bff02_1cca3129431@willemb.c.googlers.com.notmuch> <002201db1a75$9a83b420$cf8b1c60$@huawei.com> <67072012c983a_1e805629421@willemb.c.googlers.com.notmuch> 
In-Reply-To:
Subject: RE: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Thu, 10 Oct 2024 14:49:19 +0300
Message-ID: <003001db1b0a$77bcdad0$67369070$@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHbGWzwQMZqw76ooUWOpIJuIeDZyLJ8x9WAgAEVHYCAAHM4AIAA1CkdgABhFHCAAFwugA==
Content-Language: en-us
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500005.china.huawei.com (7.182.85.13)

> I realized another possible problem. We should consider adding ifindex
> Field to struct packet_fanout to be used for lookup of an existing match.
> There is little sense to bind sockets to different interfaces and then
> put them in the same fanout group.
> If you agree, I can prepare a separate patch for that.

My mistake: testing match->prot_hook.dev takes care of that.




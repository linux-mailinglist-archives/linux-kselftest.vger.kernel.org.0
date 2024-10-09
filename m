Return-Path: <linux-kselftest+bounces-19321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D699603A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 09:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475A32837EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0217A584;
	Wed,  9 Oct 2024 06:59:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC122EEF;
	Wed,  9 Oct 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457199; cv=none; b=IgXfOG2V77l5Cgk9PFaNgmLU6w8PkTLlPkjz8pZI7U9PLb+WrBzVnncNWaPSR1Jw5jXAnrduKT1bd1rUNfWDa/Oz3mrNSyoP/qXUuDkREqYSI1BW6cKkdpSOt9FW6FcyD+6gz02gAuNjvJNmvDVeYomO+w9PIO94vBjKH47u7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457199; c=relaxed/simple;
	bh=7RypAYANtvjscXzssx+cDk3GNauz3Z3B3l7U+b6IANM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNfbMBZKDtUxjKOWpjBwLJT6DnV2oIIVJwNwEWvoQQNEDXmu/dGxM4YaRmrzEz13dMt110pL8ppV8M9TwCS3HA55RZDvh9Sz3Wkp8znBraT3nnt4WFAiegnjmMuGEa44WQ9HAPqFaNvUfHwLotm2UExGV+lwInULFPiLksF9Q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNkDR0Xmdz6GBSq;
	Wed,  9 Oct 2024 14:55:35 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id EEDD7140447;
	Wed,  9 Oct 2024 14:59:53 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Oct
 2024 08:59:48 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gur.stavi@huawei.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>
Subject: Re: [PATCH net-next v02 1/2] af_packet: allow fanout_add when socket is not RUNNING
Date: Wed, 9 Oct 2024 09:58:37 +0300
Message-ID: <20241009065837.354332-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
References: <67054127bb083_18b21e2943f@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

>> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>>  	err = -EINVAL;
>>
>>  	spin_lock(&po->bind_lock);
>> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
>> -	    match->type == type &&
>> +	if (match->type == type &&
>>  	    match->prot_hook.type == po->prot_hook.type &&
>>  	    match->prot_hook.dev == po->prot_hook.dev) {
>
> Remaining unaddressed issue is that the socket can now be added
> before being bound. See comment in v1.

I extended the psock_fanout test with unbound fanout test.

As far as I understand, the easiest way to verify bind is to test that
po->prot_hook.dev != NULL, since we are under a bind_lock anyway.
But perhaps a more readable and direct approach to test "bind" would be
to test po->ifindex != -1, as ifindex is commented as "bound device".
However, at the moment ifindex is not initialized to -1, I can add such
initialization, but perhaps I do not fully understand all the logic.

Any preferences?

>
>>  		err = -ENOSPC;
>>  		if (refcount_read(&match->sk_ref) < match->max_num_members) {
>> -			__dev_remove_pack(&po->prot_hook);
>> -
>>  			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
>>  			WRITE_ONCE(po->fanout, match);
>>
>>  			po->rollover = rollover;
>>  			rollover = NULL;
>>  			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
>> -			__fanout_link(sk, po);
>> +			if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
>> +				__dev_remove_pack(&po->prot_hook);
>> +				__fanout_link(sk, po);
>> +			}
>>  			err = 0;
>>  		}
>>  	}
> --


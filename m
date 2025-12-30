Return-Path: <linux-kselftest+bounces-48006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E5CE94D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 11:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A21213014DF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024302D7DD7;
	Tue, 30 Dec 2025 10:07:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EF1FE45A;
	Tue, 30 Dec 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089227; cv=none; b=pwbbafM1Rh3/bp8VI3SMR/Bcys9zkYHImuj6QGvB00YdaeTxNXx2hBvAINV2Jw1zX5BwHj44cyxtsw/0X+1TFQ6svuKWgTY/AzPx/m+1mpAfNzTSOV89oe1a2fvlzWflIy63FfF3tLvQhOeHc1ni6IZjA2QH9/BGg72VwDE4B8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089227; c=relaxed/simple;
	bh=hcUsb6UIrqqfUHr3IZ1JfWQT1He7vhphorLXBxmw6s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rhCv9cyMzLQsKBP4/FysvLUkGQBiDaAXl726ydtHyqhdJOi3ONc9EgymeOXmtepEoE3+MMUqbbB+PivXxjZrPEejalRWVXu+KTLET5LbNy2KtEzcFsb2lb0d5UuhmKAtyKkxSIPHT2jkjj3ledEFr48zw1IkfXV6D9EBkcdvxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dgTJ22SrtzJ468v;
	Tue, 30 Dec 2025 18:06:10 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id B1AA540539;
	Tue, 30 Dec 2025 18:07:00 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 13:07:00 +0300
Message-ID: <266e580a-9eeb-49d3-84cb-6d9fb62a165f@huawei.com>
Date: Tue, 30 Dec 2025 13:06:59 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: net: simple selftest for ipvtap
To: Paolo Abeni <pabeni@redhat.com>, Dmitry Skorodumov <dskr99@gmail.com>,
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Shuah Khan
	<shuah@kernel.org>
References: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
 <20251225185543.1459044-3-skorodumov.dmitry@huawei.com>
 <16fa929d-db04-48f5-a350-a31d23f8327c@redhat.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <16fa929d-db04-48f5-a350-a31d23f8327c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)


>> +test_ip_set_thread() {
>> +	ip link set ipvlan0 up
>> +	for ((i=0; i<IP_ITERATIONS; i++)); do
>> +		v=$(rnd)
>> +		ip a a "172.25.0.$v/24" dev ipvlan0 2>/dev/null
>> +		ip a a "fc00::$v/64" dev ipvlan0 2>/dev/null
>> +		v=$(rnd)
>> +		ip a d "172.25.0.$v/24" dev ipvlan0 2>/dev/null
>> +		ip a d "fc00::$v/64" dev ipvlan0 2>/dev/null
> It's unclear to me why the above tries to remove random addresses
> different from the ones just added (possibly not existing)

The idea is that we are trying to create conflicts between namespaces. If we add random address, and then delete the same address - nothing interesting happens. But if we delete some another random address - we will eventually occupy some share of IP-addresses - and conflicts start to appear. I'll mention this in comment in next version.


PS: I agree with other comments from your side. Will fix them.


Dmitry



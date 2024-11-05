Return-Path: <linux-kselftest+bounces-21453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847299BCB66
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 12:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F972825D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDFD1D3181;
	Tue,  5 Nov 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Fma2B8rF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8491CB53A;
	Tue,  5 Nov 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805317; cv=none; b=LQJdk3/Z68V3kPYr8OADQoQ5cgw2wwOHUwTGTMUYoSLmOjeGbNqApEspZtGRPrd/Eq0PDpnFdr+dXrVRn1WsNx680VsPXK5kDnXR1jZ0Sb8SgWVvKvrEI/SzOiuSbz5Fx147QMBgYiTbo8FG/4gv5UJQDGMCfVd3u4qlShjkRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805317; c=relaxed/simple;
	bh=EblLCXndhY7BlXo9nQxU03D0v5JKO7gEA6yL291a3+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R/qZbtVoSRAQVfNzt1zsZOOBxJ6xwfyc5gomSHwMplPb9VDYvBzGcifLOGgPiatzBtSbVfinyre/mf0pDDUF5uSAX+6WGE3hobU7M+K81wGgfW1O/DB2fGRehYjpsqudUr/R6xBsGhRHUf/CJhHKQ5jbUeGop7qd8DymbPKaJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Fma2B8rF; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A5BEoLO077893;
	Tue, 5 Nov 2024 05:14:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730805290;
	bh=IDVspZ71dq5KAcHVIgTOcoCEUMJxMrE5sWF08fN2h6M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Fma2B8rFAMihl8HSEt6dH/hwvCAhjtKL0pZxJ6P6Sd/SiSnxOMvQ4lwG3q8vaz188
	 cUNIcr3/59gJcDG263VwRYIO5DeI79gi6YWqz8GFe0gxXlCaV7hJKULF3dmrC0l7Vo
	 6YOKf5LjSguE/EPmarxXMH0JW/nuUBbdx9LkotI0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A5BEoHX052462
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Nov 2024 05:14:50 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Nov 2024 05:14:50 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Nov 2024 05:14:50 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A5BEhKc094758;
	Tue, 5 Nov 2024 05:14:44 -0600
Message-ID: <9dbaae62-fc18-4f87-a6a9-8226e7266473@ti.com>
Date: Tue, 5 Nov 2024 16:44:43 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: hsr: Add test for VLAN
To: Paolo Abeni <pabeni@redhat.com>, <geliang@kernel.org>,
        <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>, <jiri@resnulli.us>,
        <n.zhandarovich@fintech.ru>, <aleksander.lobakin@intel.com>,
        <lukma@denx.de>, <horms@kernel.org>, <jan.kiszka@siemens.com>,
        <diogo.ivo@siemens.com>, <shuah@kernel.org>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <m-malladi@ti.com>
References: <20241024103056.3201071-1-danishanwar@ti.com>
 <20241024103056.3201071-5-danishanwar@ti.com>
 <3e443eb4-d15f-45ff-8b41-a8215fb4032b@redhat.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <3e443eb4-d15f-45ff-8b41-a8215fb4032b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 31/10/24 8:11 pm, Paolo Abeni wrote:
> On 10/24/24 12:30, MD Danish Anwar wrote:
>> @@ -183,9 +232,21 @@ trap cleanup_all_ns EXIT
>>  setup_hsr_interfaces 0
>>  do_complete_ping_test
>>  
>> +# Run VLAN Test
>> +if $vlan; then
>> +	setup_vlan_interfaces
>> +	hsr_vlan_ping
>> +fi
>> +
>>  setup_ns ns1 ns2 ns3
>>  
>>  setup_hsr_interfaces 1
>>  do_complete_ping_test
>>  
>> +# Run VLAN Test
>> +if $vlan; then
>> +	setup_vlan_interfaces
>> +	hsr_vlan_ping
>> +fi
> 
> The new tests should be enabled by default. Indeed ideally the test
> script should be able to run successfully on kernel not supporting such
> feature; you could cope with that looking for the hsr exposed feature
> and skipping the vlan test when the relevant feature is not present.
> 

Sure Paolo, I will make the new tests enabled by default. During the
test I will check the exposed feature `ethtool -k hsr1 | grep
"vlan-challenged"` and if vlan is not supported, skip the vlan test.

Below will be my API to run VLAN tests,

run_vlan_tests() {
	vlan_challenged_hsr1=$(ip net exec "$ns1" ethtool -k hsr1 | grep
"vlan-challenged" | awk '{print $2}')
	vlan_challenged_hsr2=$(ip net exec "$ns1" ethtool -k hsr2 | grep
"vlan-challenged" | awk '{print $2}')
	vlan_challenged_hsr3=$(ip net exec "$ns1" ethtool -k hsr3 | grep
"vlan-challenged" | awk '{print $2}')

	if [[ "$vlan_challenged_hsr1" = "off" || "$vlan_challenged_hsr2" =
"off" || "$vlan_challenged_hsr3" = "off" ]]; then
		setup_vlan_interfaces
		hsr_vlan_ping
	else
		echo "INFO: Not Running VLAN tests as the device does not support VLAN"
	fi
}

I will call this function after the ping test.
Let me know if this looks okay to you.

Thanks for the review.

> Cheers,
> 
> Paolo
> 

-- 
Thanks and Regards,
Danish


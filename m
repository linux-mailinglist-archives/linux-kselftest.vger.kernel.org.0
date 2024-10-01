Return-Path: <linux-kselftest+bounces-18710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C671098B1F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 03:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF7FB20BF6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 01:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6F122094;
	Tue,  1 Oct 2024 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dRYHdDRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF532C8C0;
	Tue,  1 Oct 2024 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727747775; cv=fail; b=Tp2G8my5UECortUIfDt+dd3V5xdQy/qETdVbZ0lEWN6czeyCqnP9PjeyNHnUfnhG2nO5BzK2IjwTn/M0n5OaNCacPaNm5GbCSLQXBFTmT5RpvWUORQBVaPDXr0CXocU8q4ovHMnTJc2Rfxha9RGzeHRpEve6cLnzu//jW41gq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727747775; c=relaxed/simple;
	bh=iWNc7a1RqUHn+VzwNevwztRnDAzbJaWITr552MxSXrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVCQ/zD7QyDEx7pDwrvmx72wwXP4UZgcQ4P98fBoKAdmiNpNTyEEscp9IZ16bG0aLfrKIPHrWFEJz60ns9YIzPr1gGqAuhOF5TON2194ZT4FMWFtnpLs5r5R8kqOdLtUh/6Hx9OCDf/X4bWVnAh5vZts1pTAxB2mkaLYTGJ6Gtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dRYHdDRs; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbnhMmzUvVqrBV262h7cSJlnxOCCob/S1RJ4GLLQ98KOH/AayltqwXPlOMKevSeIQowQMcpZ8n0kGLE2uFJIo3JZ+hEgsRk3tvqyyItP6TH16UStmpqkP1qc5+sAo2PUCZMgGkwAX674t6QRkzsarmIrlcPs+Cy0fAyWHWFzv2xmtLUE4lNc+hhFIRwY9R+fLMjlxa/zNDSW7VUBkVRCqPR1qXLyq2eoVit9MOByMqQVJHZDF0drXf/bktOclwIAyoRAZA2v6VgfHQ1ULYdZNskAx8bNk7vyLq+g9jay7GMbBvR4XRJwCHdIn6NTdwdzrV/wcMYp+8kseiJ4oqrc+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7ZhFSFqXUDk9BjR1Ju5k+CFbVkAQ7kZTyFybtN5wk8=;
 b=qx4nRmhwqxF0ER8xCVe2qnIHwePuo6BKPIIqwxS9hjUL0Y9s9VBW5puEROLHV6R1pMM1cUzvgjO8kW2wI9Fion8hq/7UfKh9DD86XkOyMq0ODW6xXI6Io9FhT6qIf9KWCMqOZUV3ddTXDDgOBPli9X5aIjnupykQGzwOnp2WmDNuKjKM+lmA3hZCL6YoFM2T/1j5Vd4SSmGs9DPbVonBoyaiiC8+cymiFs1IPWvlrPGWhxdTcHs+9reDF3obd3Fi7PZ1SAMUHAzqkwk07AOpjrzZpoMruAOQ7DRZpvlCnwJ544S/mNONgA1ms+AP2Q5HTsoFfj0kOXR4MOX/4fsONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7ZhFSFqXUDk9BjR1Ju5k+CFbVkAQ7kZTyFybtN5wk8=;
 b=dRYHdDRsMQCwCnP802M+P4VzJqVvpEi9DBqmgNEl6k9oQmbh6D3U9sYJ1G0j5WzfwIdzlyPdriQRLXFCTj6j6Zw6En7HA7MsUYFWVeKaIW/1Rr1WyB9afOGF8gn9p4sc9vH8kSXLucK1cDjfVQLhpPxHCaquFLJSYPXHsWI8N/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 01:56:10 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 01:56:10 +0000
Message-ID: <f6899837-b908-4401-bbb7-5e205b6b3a88@amd.com>
Date: Tue, 1 Oct 2024 11:55:59 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mdf@kernel.org" <mdf@kernel.org>, "mshavit@google.com"
 <mshavit@google.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "smostafa@google.com" <smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZuFB06X7ZTg6ZhWT@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <ZuFB06X7ZTg6ZhWT@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0053.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 969642e2-a5bb-4bab-d043-08dce1bc387a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVkyMkNIaEpBTnZ0OUhSSDlOYTNSUjJjOEJLVjJZVlZOT05vS0VyYngrSisx?=
 =?utf-8?B?NEdYa1ZVUWxKQkluRDlTRDBoL2lvdGFYLy9aYUEzYmQxL2FlWUYvTm1Vc1hH?=
 =?utf-8?B?T3hJeGo0U0RPQk5aYTg0TU5CbmEyKzU2MGUzZFZSTVNWZXhvMWZlTjVGVkI3?=
 =?utf-8?B?NnZvMnBQNlZ6Z3lSN2I0VEE4ZUhqaGNmZ1VDWFVCR1JPQzU1NmJCWkVCN3hH?=
 =?utf-8?B?ODdsM2tGQVdHZ3p4ejZDYVNJOGF1U2czVm9xQWUyQ2hoNU9pQmV0WDZDemRz?=
 =?utf-8?B?dlI3Q0l3REZmTG1LYUoweXRibm5paG9xTFA4ODNiNHpaWGw2aUNxMUZoU09v?=
 =?utf-8?B?NFl2MWhBb1M1MEZvcmk3d0dwb0JMVHU5akUvZ01yelRYVjk0S28zUitod0E1?=
 =?utf-8?B?S0hSYzlUNUQxZjExc0J6cUk3L3YvTW5NR1RzY2VlTTcwbGNTZkFuTWZXbE1J?=
 =?utf-8?B?d1FSdlhqQUl2aFRKNDhZL1R6ditSM0FwUVN5cWZBR3Fra1lnMmZ5aFNOQ2Fo?=
 =?utf-8?B?ZFcyeDRndnpGd0tXMTNXei9Tc1U2WmVLdjJ3eEprcGRaa1RDVXhTVVhtdjhr?=
 =?utf-8?B?dVdNU3NYOHhZT1VBUG1ZUmVNaGFaZVlzSStsSGNsVDJBSjF5Y2srdWZ5RnRU?=
 =?utf-8?B?TGw1ZFQzanhiSjVFT09sNUNXWXo4a3lBVlFOUHRzRmVvNVhIc1duQ1lQM0dl?=
 =?utf-8?B?Q1ByRVRmM2pOSy9BU1dOeDUxM3l1VFZSOGd2NFFROTIzNmx5eWZiYU1xdktk?=
 =?utf-8?B?NWxkelVDSkt2OStrenRLaVVRdVVMNktWQ1V5YTJzRnhIdEZmazM0NVhrS3Qv?=
 =?utf-8?B?V05oUy85U3hsQ0VNa0NyWVdRc0xhUy9DMGY5dW93a1ZUWEZIaGpjTXpxNjY5?=
 =?utf-8?B?RzAzcjByNjRYMzRpRDNYWEt4aFRyOE1ZMktvN3d4TlNmNDVuSEgveGVJc0tN?=
 =?utf-8?B?VVcxT1U5WXpuZGhReVBhUmQ4dXdjTWFNMUR3U1BZSGk3R1M3TFFNaVZXQWI2?=
 =?utf-8?B?NlJmbEF6b05xWWI3UEZMNDJQeWdvTEtsb2JhM05paGx4b3VLTXJRVm5tdjdq?=
 =?utf-8?B?a3Q4VUtQY1VUYUpjeElZcUt5U2k2ZVRBTXhXb3VZSG5rcTdQN3M0M2xqeHho?=
 =?utf-8?B?VkRnSFprcWNBSUhNRjc3QkRPa05yL2JIK1BNcHdzL1VEbzBQajFYSnhFVXZB?=
 =?utf-8?B?RGZrbjA4ZDdDc2VBMitRSFlHT0dmeFJEWUs2WkQ3RjRwN0lFRlllVmF6dUhn?=
 =?utf-8?B?QVRhbFJZRkppMHhOd1NwRjNvWE8vUEtXd3pXUHpBUkhoZnkvVEd4TnJHUkJR?=
 =?utf-8?B?a2J3Y0MrTlN0UnpiNzhBUUMxdVh5Rk5aMi9Pc0Z2VlF3TG5Ma3BaUStUa1du?=
 =?utf-8?B?MXM3WlRzUDVPcWg4RXFIQ05NM3JTaFd0dDBpaXBxbSs0VkhneHFNM1Jjd0h2?=
 =?utf-8?B?ZE01dGFMMnRwVzdGMHFWR2xHSUZHUDVzWXdxVVJyNGZhalBOaWZOTU1iR2Nv?=
 =?utf-8?B?M3Z0Qm1TbHE0KzBKMHlzRlNtNmxpVGZvTk1DdUxUb0pZZE56L3dnWlVOdE1C?=
 =?utf-8?B?dUM4MlJoZVNLb09xNXpnQW1HZzhYL0FWamRtU3p6VCs1Qi9QWm1WTWR3YURM?=
 =?utf-8?B?MHRNbU5yWFlUK05zUjJBaERramNQRVY1dGFMRnBFd2VrSFhhRmdiWGNnbERD?=
 =?utf-8?B?TG9Uc2xXallJdWxZZTlPV25kMDZGL3Z3VW5lSlgzNFlWRktEOCtNT0UzZ2tE?=
 =?utf-8?B?OGRldHFLeElMMjdSTGdoVUpIRkV2UEV4Y0lyaGFCbkYzL0M3Tis5SGlTUEdQ?=
 =?utf-8?B?UlllR0F5UFZKdTBXVHg0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TldkNm04Y0ZzTGtlTVdDeWkxSm80MlRBc1FjaldPUGpEd0UwZmNPakdSWUJv?=
 =?utf-8?B?L1hDVVFoRWk4VFc5M2RJYUEvZGNaYnozZ2l2R24rVDFPL3p4eUduNFlHZjll?=
 =?utf-8?B?clAxd2NTTWszUWlwMVdrQjlOTXduQWdDOEJIL3hNZ09OcXRJWjNVekRIV0xJ?=
 =?utf-8?B?WjZVYzVyTXRvYTNOaUgyWGNEZkUrakN3Q3RDRXhVVEFabXJhYmNPWTRxNVEz?=
 =?utf-8?B?YnR4VTQ2N3QvSnlDV1BUNXA1b1JGVjlrdmZDWTBISFUwb2p5MXFNdmQwMVBF?=
 =?utf-8?B?bjlXOS9VY0h6c21PdFdBcTJoelNSTXE2YXJNVWhwMEJpWmdvMUJwSlRmdVZD?=
 =?utf-8?B?OEtlNG42cXZxRkpGdzF5UkJrdTlDd2o3K2dicGVCSXpjTDkwcmZkNElZQ2cv?=
 =?utf-8?B?V0ZUYXgvMkNsS2ZyMDZkdHhSVmpvZkJiQU55dnBoRm5lTlM2bElUUjhJYlh0?=
 =?utf-8?B?WDNJVHlUbm9jQ0hqSmZ2Ukk3UDhleFFuc0dFSElLNnc4d25NVElURmNTVUty?=
 =?utf-8?B?cERYYkxGdDdsbm1yZzZyRGF2S01ldi9xQVlIdnd3c2lVM3lpOXJZV25DNVls?=
 =?utf-8?B?R3JLTnNoZGlLUmtjL29vUTBpSmVjZ1Q3a0EwaEMyTVIwME9RL1NBaVp3dUEw?=
 =?utf-8?B?RjAzRmc2dzFvekR3QzY0MnRIaGdFSWpmZmJVOVRrWDJMMVU3MFI0T0cvT2Nn?=
 =?utf-8?B?Nkk1Nk9UWWw0Q0hsdGdIOWluak5CNldCSTVWLzJxQWUyQTBabzFMMThMZ2ln?=
 =?utf-8?B?bXd0Wm9xYUdaUW1TbXdFMDhqc0pCTThGVHY5andvQTFLOGJRK1lnVmxiU2Jk?=
 =?utf-8?B?UWgrc2pYaGNhb1hNRjQreEdoSkZLOVU0Q0xmT01EMmdVSGxmb3VMci9NVFlV?=
 =?utf-8?B?elJEWWRhN3RYNEZqRlNjcEZwc0JZL3NQeDhIRzRUYi9QSkVUNHl0MHNkRkVr?=
 =?utf-8?B?M0IvUlpWaEpDM3JhWWlWYmdTTk1TdHE3V3RpeEp2eUw3ZkEwbWtQYk5PelI5?=
 =?utf-8?B?WFNtY05MbFRJeElDeVRrSnR1VkJaZUl3aGxBYldvNi93ZS95ZnoyV2JjTnIw?=
 =?utf-8?B?V1RpOVBZTmVnQVhwclRpTzh3bHlNMXp5b00xWURmMkRwdWhZK0tmMXVSeWsy?=
 =?utf-8?B?eG83Y1Y5UTZvb05Jb0hjWjkvVlBtVFN0aU5RNUdBK1ZmK1FCNVlPaGx0Q2Rp?=
 =?utf-8?B?cG5jTm9tKzRRM0tzQ2wxZEVkbUJSWVkxWk1xMlQ3bEh4R2pta2tBbjVMZ1c0?=
 =?utf-8?B?NCtLZXN5VHhQWHhXd3hTbGVCVGxiazZSRnEzVzU2TXlyRERPS3NPVWJiM1ZS?=
 =?utf-8?B?Tlc0MzB3NWR2bmJzQ09HcGhBbFlxRXBtU1B2WUhLZmNlenY1SFlrcklvVVpV?=
 =?utf-8?B?R1pQWTZVOGoyanFLbmNzMCtFSm9yUmpaYmNFNm9vRWJsTW5uZUZ1RTdXSFZj?=
 =?utf-8?B?aSsyQ3B1NzhqUTRiQi9OVVBMMFBsVlJZYjQvWHVSMjVQeVA4Q2gzSUpyaUJm?=
 =?utf-8?B?WUZ4eCs5NWJsTDg4RVZleWpIaXNzQ1Qxc2lnU1B4bUsxZHdtZExhUFNrWnBH?=
 =?utf-8?B?cmQyWXVUbTFRZmVUSm1TWkd4NDFwcWV1dVhpVW9rUUh0NEJzWVo3MjF0SjR3?=
 =?utf-8?B?cEJIUWtxeEk2YkEvTGkwZlRiaVkzRlNveE5UdnptcVg5dlJhaUlvUGFrSXY0?=
 =?utf-8?B?R3hXZmZVZ2J5NXlzbjRqQWdla3ErMzBLaXlnaHhBajBPZ3VEL0pEQlc1Lysv?=
 =?utf-8?B?ZjdoV2VHQ2t2VUc4OHE1UWpzUDdzODhPSDNnSllrdWxtdXFZdHp2NGdFOEs1?=
 =?utf-8?B?RlQ2MExFSGNoU0MraUlVRzNZQmRNNVA0SkVWMGozTVNvY2gwNzFFSWlWUElk?=
 =?utf-8?B?UHJxenBBWTRkRkpTYlJScXRscDlEQ1lneTZwZ3VMQmdKQk5sdUVJS0pFbURK?=
 =?utf-8?B?R1dkOTl6bE04MXh0SUJsbkEwRGhoSGVKVHkzdGJLU05qa1VEYmkzNXR6Q3or?=
 =?utf-8?B?aVlEQkptQjd2Q08vZDJUTlRjaSs0S0FadnFmNlVnbUN6bUtQTVRTMFJsRysz?=
 =?utf-8?B?MkI4dzB5dzdxeVlQT2NIV0RuRUpPUmF5elpLQ0M0R2xac05Ob1FpVjV3SGkx?=
 =?utf-8?Q?kLgV2a2Q4Qx74ZkohrrOFt3hh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969642e2-a5bb-4bab-d043-08dce1bc387a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 01:56:10.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3h83hrVCTFpEPxCezfuHdFd9EqnWjZrf3Hplbs/BvcwGlN97l7bY+Vvx/4fbvAryy3WREubcvPdmTzhDZeUUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

On 11/9/24 17:08, Nicolin Chen wrote:
> On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>> Sent: Wednesday, August 28, 2024 1:00 AM
>>>
>> [...]
>>> On a multi-IOMMU system, the VIOMMU object can be instanced to the
>>> number
>>> of vIOMMUs in a guest VM, while holding the same parent HWPT to share
>>> the
>>
>> Is there restriction that multiple vIOMMU objects can be only created
>> on a multi-IOMMU system?
> 
> I think it should be generally restricted to the number of pIOMMUs,
> although likely (not 100% sure) we could do multiple vIOMMUs on a
> single-pIOMMU system. Any reason for doing that?


Just to clarify the terminology here - what are pIOMMU and vIOMMU exactly?

On AMD, IOMMU is a pretend-pcie device, one per a rootport, manages a DT 
- device table, one entry per BDFn, the entry owns a queue. A slice of 
that can be passed to a VM (== queues mapped directly to the VM, and 
such IOMMU appears in the VM as a pretend-pcie device too). So what is 
[pv]IOMMU here? Thanks,


> 
>>> stage-2 IO pagetable. Each VIOMMU then just need to only allocate its own
>>> VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
>>
>> this reads like 'VMID' is a virtual ID allocated by vIOMMU. But from the
>> entire context it actually means the physical 'VMID' allocated on the
>> associated physical IOMMU, correct?
> 
> Quoting Jason's narratives, a VMID is a "Security namespace for
> guest owned ID". The allocation, using SMMU as an example, should
> be a part of vIOMMU instance allocation in the host SMMU driver.
> Then, this VMID will be used to mark the cache tags. So, it is
> still a software allocated ID, while HW would use it too.
> 
> Thanks
> Nicolin

-- 
Alexey



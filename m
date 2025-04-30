Return-Path: <linux-kselftest+bounces-32026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BAAA499C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012969A272B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 11:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1FB20C00C;
	Wed, 30 Apr 2025 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2vqlCsoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374F211C;
	Wed, 30 Apr 2025 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011723; cv=fail; b=AlTQRVo0iN9/E3X9agEhhedX5J8w6ZAXMTZluCqiOIvwGsG/u2/ztGcUTU/sr7n9lEkOROkyie5YYdGG32ZDvG5Te0cTauhg+xduO+IzK2SrJ7X+rQWCrJ+cxUKEO5Bv+f8pKrdI7J0spZQCvIBKKE+hYmZHHiQavH+BfTKp9pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011723; c=relaxed/simple;
	bh=G2fTHNszRzUxF8Ih//uLQP0hazW+uz3eJygdpDj+bgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EuSpH2SZ70J7j0JqUbkUcvtzyxB58pfigVECJk6QddVeWsLN4j1W7zLJk9O7W7yL9fMIyTosfUOoPbDkAycNndxR0OAPdbZtV2Mrg0Ev18CMl7AhvVkEiq6pe229v9IHjboPJXz3cqlLq/A7NdHfYxtESFxM+b9Dg7RYpis4EqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2vqlCsoZ; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+XIfuXD81xCyEN1bsMvmHL8+lWJT8PMCDIQw3AlbM7J5YomGJFG2yptyfBbIsRhlpVwToO8l6KJvWLik4q/9d0G6FoEkqYs47eUBsdFEciEXjbLnzhG4GCkSAl2uaRkBLT1uvlJOHvEx01GvLCXoXxFWYyDBUqJwNiL6QagKBIH8gVzfa50gB4XnWTd9so7+SU1dcT3Eh5cIZ0dz8JUYnartNOl8984JtYhVeLc2M9egPNkFTw6yQ2Fi1QCBgfzm7leWfGwjOmtHOw1MPy22lV3/OET2IN9ZOeLwytadypuYsuuJZYJHVl0+NszLTKpbZJm/rIxg5EJq4bK3dACfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acD1LY6KHci03d2PYWvVrIvPZItb78+MyEf1772KnNU=;
 b=B6ljVmW3mM11O93wTxs5bzU/zNENHiuq+rNQm+vv2BK7pbh6ylh56R80GWk+WAspuGw793yd7252bu1DrwvcjeyX4OZFBwvIxOX6fJjEY5ieF2KhyfAeydPQ4caC8w/Xf2tQI6xlAaqm38JDS3obD6IebxelwPsC4/SLqiTCUN/m5J3F6DqtxqcDoTd5VzoISd1r4biJEmF2uvIk9662/q2rSKsoXwwStzdp9etaxkhQq7TIpYiEdNOCAaXWfBM44gUMB/0MiCQ3B2dJnMC0+3sXRiPCy7cD0eZjIFEt+tbmSDZXv3NSsC0q0iqzmYpY/dpp4h2EXPwHoW6CgP7XVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acD1LY6KHci03d2PYWvVrIvPZItb78+MyEf1772KnNU=;
 b=2vqlCsoZHP4uPYSQINsBQt1ShdezMxCKqbjHE6XsMQuSHbuC0n7et1kVro+YRL4V4UUou+hpbLxND3ZpbNii+hOpp657r6d/a4bqsA8HNPAQctR0jKse+9rbi638hn8z/udm5d6dzeOK8wZHyKN/MmNMoRNptko3x+h2L14vpYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33; Wed, 30 Apr 2025 11:15:18 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 11:15:18 +0000
Message-ID: <61dc73ed-7dac-4ebf-a0ee-fa338c254082@amd.com>
Date: Wed, 30 Apr 2025 16:45:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] KVM: SVM: Enable Bus lock threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pbonzini@redhat.com, nikunj@amd.com,
 thomas.lendacky@amd.com, bp@alien8.de
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-4-manali.shukla@amd.com>
 <b03f3593-e56b-4a98-8ddd-e54fe7885c81@intel.com>
 <52276154-79b0-4029-8087-77ca499a12ce@amd.com> <aAkHVFTqybGc-mc8@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <aAkHVFTqybGc-mc8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: ea186df6-8927-4c37-a3dc-08dd87d849df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3FHdVVZQlRpMVI2MkxNc3ZTUjVDWnU2dGwwR3Z5NDkrYVZTSGhtTW1jUTlU?=
 =?utf-8?B?V1o4UmNHdklSc3BZcTQvYU9zK0Y4T3FaYWszQzd0anVsd0cxdDZkTFFNc1I2?=
 =?utf-8?B?WnNYdVorRkFPWHA1ekExbzlBQ3lEclFjMG9OejM0RnVreWNWUVRHREtyeGVr?=
 =?utf-8?B?QWV3NWY0Q01CclZBaWltclBsU2NMQkJrTFlNdG85TC9PU2wwYVJ2VlBzTnJ2?=
 =?utf-8?B?Y0NjUWdDUHMzSklQUXpJOXpxUFcwR0lrRUxJL0phV05waHlhQmdQYmdLdmhi?=
 =?utf-8?B?Nkd1TkhPME1FYldSSUN0dVBMTUt3czBpTi9hV3NlMUtCOWF2YlFqdjlBeEhL?=
 =?utf-8?B?OTg4d3FjeFJWTzdyNmpJTTY4TURWeXZDWkF1aXd4Y1grMVYyYkxrZWxJYmhZ?=
 =?utf-8?B?SXoyd1FUTEYwTzdvSkVWMmdPaHhqRy9ZaU1Sekp6dnluNFN1b0NOSlpWaVFY?=
 =?utf-8?B?VEtZRGQ1ZmFxVHR3U3B6NVlFV2xtdmVrNG15RWNaSWI1bnp2bURsbTA4SDVJ?=
 =?utf-8?B?Qm92elJaQVl3cEFaQVpJaE5nNERRZGZGZ3dmWC9uT3BXOG9YcGV6V0gxNERh?=
 =?utf-8?B?Z1dhVGRCcmgvbWNSZk1PczNvOUxuSUFIdUFwb29PRFNJYUhObytGVWp0c2Zy?=
 =?utf-8?B?Z09uVEJtTGdDWDdReFljdDBWMmZ3U2FoQS9zWUJYdTRFNEdPSEJxS0xFYmtp?=
 =?utf-8?B?TkkvS29BM1BmMjdZallxanYwdk9XVWFaaEhhT0MzR1JSaGxxYjJDZVpRcjBK?=
 =?utf-8?B?T3NaVWtlR1JPcnE5WHFZaUFWa1NqSUNlQVlRaHNLOHkxOFhYZE9VODJsU0sx?=
 =?utf-8?B?YW1LY3VsRU16SVVUa2pIclRWS1V3TXdwQ3o3dDVZZWdTR0xYL1g4dUVpMEFH?=
 =?utf-8?B?VXo0Z3d0d3Y2YXZQdzBuTzlqMDVPVys4d0lIV3YyR05RVFFDM0lLL3RSNGpB?=
 =?utf-8?B?SUxmMXFPbzZCamJHbStSUGVQR0ZuRVVDNVFHV1NWSUJwYURPWVRka3h5bita?=
 =?utf-8?B?UlJoRlI5dUd0dHJPT1Qzb1pWSk1Qd0x1dWM2NmM4YWg4RGFFQWhhMGEyYm9o?=
 =?utf-8?B?RGJTckZpK21MTkgzVFVMdVowZXRSMVNKUGNxK2t0U0ZRWlF4R2ZxekR1WFZi?=
 =?utf-8?B?VWFadlM0N2orNDFJa2dLMVZKZ3lRR2dyaDlkdFBYWDJCQjZ4NmF1T29nSW5v?=
 =?utf-8?B?L1o3aXpZakhRSkh0WFZjbDU1Y0hwQzUyZHlxWmhDYjk2d2NNSThDU21Ha2pC?=
 =?utf-8?B?QVlpaFEzMU5MdHdxblVCOHFMK2VzUk0vbjRXaTlISHpIc0pzVUw1OUhzdEps?=
 =?utf-8?B?V1JoVlhKVjAyak01azFZcXRVR0hyRHRnRlczeU1Hak5mT2pDTXZKejAyZmFn?=
 =?utf-8?B?VXdTd0o3WURDZTY3dzF0M1hjY2lHd1Nmam5OUWhmblRiSHozUlRRWkFYcFcy?=
 =?utf-8?B?YU9KNDVvVDA1bWhLZkxjd0VNRmZJcDdLRHlFUXZnUlBJNG9wRlAyZlZ2NE5T?=
 =?utf-8?B?QzJZR2FmQlRwYmswZDZXYTVBUm1VWWxzR2FCZTJzZEtFeEFwbkI4dGJzcXFs?=
 =?utf-8?B?RHFjTWJVSVlJYy9Ja0NNK3JuK1VnZWFuTG9PcnczcDRtbVFDYUxJVlhFVUhh?=
 =?utf-8?B?TEVWTWV6Y2lWOS9vaThiTDhlZDhMUDRvL0Fkc0tpMDRtU3RjWFgyckwxS0JD?=
 =?utf-8?B?elNpaFBJQVpYQmt4VHhrek92REVtSktPcytMZThUMWw4UERETzdEWU1ld1Rn?=
 =?utf-8?B?QitVT1hKUzBESFpsNUd3S2x3cHp2N1NWM0FSVnhWRVdCUzlDL1Y1UzdRNUMv?=
 =?utf-8?B?c2gvdTB6TEluZEdQYjV0YlZTNGx5Z1IvaXZHV0VSZXVUU0lJeGYvaUNkQWs1?=
 =?utf-8?B?UjIwNlpnbzludlg4R3FCZHo2a1BnS0xoS2luaThzR1RieUZFVkYzaTlEVTMr?=
 =?utf-8?Q?MwXJRPGDcNE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cENlNDRBUlp5cFNkbWs0K0o0eHNiZGt0Q2Z6QkRJKzBqbm5qck50UzJ6SDVy?=
 =?utf-8?B?dDByc0ZKcUN2a3Qva2tpSWxnd1c1NkkrbElQN3JzbFJMQ3BJSU1taW1rYnpL?=
 =?utf-8?B?ZllDSzBHb0d1MzMwZ0RmdHFEZWloS0FzNGl3bVhQT0hVSllTajgyclhwMnNT?=
 =?utf-8?B?OGx3d3NBaU5rS0YrSmVqcVBOWEZaMGJOVWpvWFlGZ0pnSEEyOTd0TVRwcHZn?=
 =?utf-8?B?MXkrY0o3VVduWUZ6SmREeHZuLzFFTFc0Q0NEaXR4N2FETVJJZ1hRbmxUYVFw?=
 =?utf-8?B?S3RuZXh4UzVsMFNQWEtNMVpMeGZkYUlpS3FFaElhNVlGUks3UlAyL0VOdlNy?=
 =?utf-8?B?ZmY1bEd3K3pSZzkwRTFQaVU5dDZGTjR3RmtGRFlxRGxIQTQwcWVuamhOVC9M?=
 =?utf-8?B?YjF4YzFuN3VMbjFjYnpQUzdsL216am5YNld1YmgweUhVZTVBM1AvZTByTWJQ?=
 =?utf-8?B?VThBVUM4RWtqU204UTlWMCsrc20ydVBlUTdIbVZ0aUtneXpDdjVqMmxIemxK?=
 =?utf-8?B?OXArQ3JmUnU1WW5Fa1N0dzRIcE5GamErcmdwblo1SlNIK3pYV25KbVJ6SlIv?=
 =?utf-8?B?SFVuS09tRWNoSGhYaWRoTDI3WWRBdUJoSmM1SEIrTlNPeWl1ckNCTUxDMVV1?=
 =?utf-8?B?SVNwM1VDSTZyTnhIaEJPMEM4YUhUMmdVQ1ZjY3JnM2J4MGhoOEdncERlajZi?=
 =?utf-8?B?eEFLNGhVOWFzUVFwNmdJTEtNb1NDOFUzdDQwaXRMNWFxWmQramoxbzVMR2FV?=
 =?utf-8?B?djQvZ21URmxwSG15Q2Njai9VeDVVTjI4WUs1OVRDQitZZnZEOHBjYUVqaU1F?=
 =?utf-8?B?cUhnb2hUcDhUTTd3dGVWL1E2K0xPcGh5UUJwMnhtSG5NZ1dYTnNFakpnUk1h?=
 =?utf-8?B?YklWRXpTTjZ2MWxLbTg2K3N3YjlmTTAzeklVdTVlM2pNbHYvbk9TZldiNzUy?=
 =?utf-8?B?eGFSVGlyZmozeG1CL1I3RVpFTVRHOVBhZUhZZzJBNFdnd3E4NTlnRjh4MTQz?=
 =?utf-8?B?QVhrN1FqMXZGaXNGL0dSaDZ4T2kvZHo3MWhNem5IQnFUWlU0d0kyVCtXT1Bi?=
 =?utf-8?B?MmxINncxWldxL0Q0eHA4YXdtUDQxeU5Pa3l0cUVuY1FzOWVDSEZ6ME9YejF2?=
 =?utf-8?B?Q3FHRlFBMzNUOCsvRnlUSnNmbkEzY3FaTlV3N2YycVBSQytjV3JWY3V5UGw1?=
 =?utf-8?B?TlZaMVljeVRPaDBKMVRhTmg0dzdHZW9YNmxXSE5LOFJ5Z3d2ZW8yaU4yMVY4?=
 =?utf-8?B?WU56THhBYTlqRzJRV2ZQUWsxVDkwd2VIOHBydVUxOWZkNWkzZjBFcFlsanU2?=
 =?utf-8?B?blBwckE2OEJvUTRacVFMMU9hTWxZeUlrODN5cm8xWlo1ZGo4TERKdHhVcy8v?=
 =?utf-8?B?RG1ocEFPWWMyaWpjSStCZ21nOERQandxWm1zc3VJbnZpcW9NSTJSK2RkZG5N?=
 =?utf-8?B?dWhrOEovNGlQbVVEbkRlUTJETW9Ud25iNjNxK1dJWHhzRER0c1FTcUNUL1pG?=
 =?utf-8?B?RGMwTjZOSWgzQjFlTUVUWHRaZU9XdE50WVNNWG1hdnJpeHV2dHQ0THRFeDNX?=
 =?utf-8?B?WGdGQ0xWSHo3UE9kWmtwUnJlbEt5Z0VSL1A1VkdQeSt2alJKeHNFT21oaDk4?=
 =?utf-8?B?TEtKcFFQbWV6aXVCZlhDZkNtczhjaGVZa2N5UmlhY2YwVDZZMlZkYVM5OGlD?=
 =?utf-8?B?MGswVVpMTTNnenFFay9QZnBZQW5PRFpCMjdwTFNocW9wVDhkSUtXdGdIN2Zz?=
 =?utf-8?B?OE5HNVpMVHhmZTVMR1V1eS9vVlMvZmlieUNuOXRkYjdUd0N5dXJaMmJWeExO?=
 =?utf-8?B?c3RSNllZdFRBUklEUXYvWGZEQnVFdTZkbWo5UDBlanhQL0VEcEdSOUU2NHJS?=
 =?utf-8?B?ZllmNGR0TzhoZUhWZnQyUnI2MTJqbnB4SklmckV0ZldtbEpoeXh3WXV4b3cv?=
 =?utf-8?B?L2NjakcvbHJ2MlB5MTRXdEpkcmdjRnk1eHVuVGJ1elc2T2lxOUF3djcrL2xa?=
 =?utf-8?B?OEhXaFZtekhNRnZUQ0ttemlzMW1oK3lDQ01HcHBhRzFCNEhUam5wcU5CdTRH?=
 =?utf-8?B?WllVT3c1NlV6SVJkRWhVNEJoOEJEVXFTMnVRWU96N0NKR3BpYW9BNWxVUS9l?=
 =?utf-8?Q?mVDSme32Z4sPgtHg+VuqrWpKH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea186df6-8927-4c37-a3dc-08dd87d849df
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:15:18.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiMa4sMopJRcqP57km2995X7MqDQb4FZO50I4cDZy3jdR0GkHpDPAxlnQByi0q+9P/EPuapZdgPGzmZHIrJEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194

Hi Sean,

Thank you for reviewing my patches.

On 4/23/2025 8:59 PM, Sean Christopherson wrote:
> On Wed, Apr 23, 2025, Manali Shukla wrote:
>> On 4/16/2025 11:30 AM, Xiaoyao Li wrote:
>>>>   +    if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD)) {
>>>> +        pr_info("Bus Lock Threshold supported\n");
>>>
>>> It will be printed every time kvm-amd.ko module gets loaded.
>>>
>>> I think it's for your development and debug purpose. Comparing to the
>>> existing features in svm_set_cpu_caps(), nothing makes it special for
>>> BUS_LOCK_THRESHOLD to require a kernel message. So I think we can just
>>> remove it.
>>
>> I didn't add this for development and debug purpose. I added this pr_info()
>> to make it easy to find whether BUS Lock threshold is supported or not from
>> dmesg.  I can remove it if you think it is not required.
> 
> Please remove it.  The user typically doesn't care.
> 
>>>> +        kvm_caps.has_bus_lock_exit = true;
>>>
>>> Besides, this patch doesn't ensure the bisectability. It allows userspace
>>> to enable KVM_BUS_LOCK_DETECTION_EXIT and set intercept of
>>> INTERCEPT_BUSLOCK but without providing the handler.
>>>
>>> So either move next patch before it or just merge them.
>>>
>>
>> Oh.., my bad, I will move the next patch before this one in v5.
> 
> No, do exactly as I suggested in v3.

Sure. I will remove it from v5.

> 
>  : I vote to split this into two patches: one to add the architectural collateral,
>  : with the above as the changelog, and a second to actually implement support in
>  : KVM.  Having the above background is useful, but it makes it quite hard to find
>  : information on the KVM design and implementation.
> 
> I want this (and any other arch collateral I'm missing) in a separate patch so
> that the background on what the hardware feature does is captured.  But I see no
> reason to split KVM's implementation into multiple patches.
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 2b59b9951c90..d1819c564b1c 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -116,6 +116,7 @@ enum {
>         INTERCEPT_INVPCID,
>         INTERCEPT_MCOMMIT,
>         INTERCEPT_TLBSYNC,
> +       INTERCEPT_BUSLOCK,
>  };
> 
> 
> @@ -158,7 +159,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>         u64 avic_physical_id;   /* Offset 0xf8 */
>         u8 reserved_7[8];
>         u64 vmsa_pa;            /* Used for an SEV-ES guest */
> -       u8 reserved_8[720];
> +       u8 reserved_8[16];
> +       u16 bus_lock_counter;   /* Offset 0x120 */
> +       u8 reserved_9[702];
>         /*
>          * Offset 0x3e0, 32 bytes reserved
>          * for use by hypervisor/software.
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 1814b413fd57..abf6aed88cee 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -95,6 +95,7 @@
>  #define SVM_EXIT_CR14_WRITE_TRAP               0x09e
>  #define SVM_EXIT_CR15_WRITE_TRAP               0x09f
>  #define SVM_EXIT_INVPCID       0x0a2
> +#define SVM_EXIT_BUS_LOCK                      0x0a5
>  #define SVM_EXIT_NPF           0x400
>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI           0x401
>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS     0x402
> @@ -224,6 +225,7 @@
>         { SVM_EXIT_CR4_WRITE_TRAP,      "write_cr4_trap" }, \
>         { SVM_EXIT_CR8_WRITE_TRAP,      "write_cr8_trap" }, \
>         { SVM_EXIT_INVPCID,     "invpcid" }, \
> +       { SVM_EXIT_BUS_LOCK,     "buslock" }, \
>         { SVM_EXIT_NPF,         "npf" }, \
>         { SVM_EXIT_AVIC_INCOMPLETE_IPI,         "avic_incomplete_ipi" }, \
>         { SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
> 
Ack.

-Manali


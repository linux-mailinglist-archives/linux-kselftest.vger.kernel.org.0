Return-Path: <linux-kselftest+bounces-12258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DB90F4D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51C91C21D20
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB4155752;
	Wed, 19 Jun 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UhkTffyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F05155738;
	Wed, 19 Jun 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718816965; cv=fail; b=a/6qcWnMVhtNgiDK7KzXhHqbamiQJ8SO8SNgkIH7OCEZ1E5oN3w8S4NYcL2ZmK/IomwL4lIsuP58QbMiablmI3q2+SejrhA2l6F0FUD1pBuito30zrLa4erFfZu1bHC9x0Xl36efZoPlL8+NP9OOvx/sDnr6Jrk+f+9Jz9ZTk3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718816965; c=relaxed/simple;
	bh=3aDzyRLcyWt3efiRwuC46JvVRg98+P+a3ruga0kAFSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDbqOsxV1Gnw73JS3OCDkb7NSDnyeMdBXOC8XLBYQJK+n55b/n4R6o5MNpqc9Pj5+CPMqg3bHKf7Cq52GuSG7ojtuxCdd10Sye/uCzFSVE+fCqwBEhCeiH5FY5VzMAQjeo+EWzjvVGlBE9hRYk8jg2MUkIMTLt0Zi6zJ+qfT4Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UhkTffyI; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq8s52ZeH2YqgJvqL0LLiWjb/b0X0W288ZXAy6bDqaZCw9Vxwq6kBkdvVgA+kWNWxLgafjr0cOxjnmoqj6aQPzs0glUnjRciMMoDJNB/L+V94M19kP+2Yjow4D23H3StWlAr1dhaJuswV1d2s+3rZHJqt1dykJ9gqvzDTAEEbBmBMU7JGhgDs3uytn1jF7uTp22dhpJG0x/8pIcvvncT+zu77okW2B2uOHxEhKdrzjhobxGBbhBv3yH+KHdArL/h/snJYQXcZg089eTywVSB8gAaRweR/NOJwcUPZ0kvzH3calNNS+qA88uorlmfg7b9VEtWaRQUVM8dMDyS8IvorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5wS1rjW78BNq4/clqOmhzDJ+gR4DQPp5DrBesb3Odc=;
 b=OVz5GmEMi/Sea3B+pqlD/NbhlMgtBQOhPU32i4JWOzD9j9kwIitpQBqg1YhvJ63owz1NYnVm1yq2hZjxA1uXKDfSz3cv3PcELdF0OcP5EhgveTgESoXuQbcLocDb7/K6w1zZmWHUtCMhlEYWdAIglWyAHvcKmbBMFG3sQf/wK4d71O/C4WrWlA4sbUERh6aPX/E5Y0Y+mgRaEQXHIo6gYTUFVP+ptPLt6ZXN/4DzS8+1JgEiaFL2VzHHpDUgl2HjOw5OdUgdExu6w9HRV5s26zQsbpM6lMPKWa0rVLTaIxDO6zsTidJtsjkjbvUcMYojLrSsevdLRxmO08Oif6TLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5wS1rjW78BNq4/clqOmhzDJ+gR4DQPp5DrBesb3Odc=;
 b=UhkTffyICeSam1I5Zx31P3AHfPvnUA1Mrt/Gw7Y95tdZdgXAfZN41TJ7nsSUtFhBZff1kKElvqCU0pwAkzCVP7kWibMCC9PEksutBs53CsN3/npW+8TunOFwz0x5KzCdN0hT0vg4HN5yzgdNnACokrjpSz6Lh4kvJrADkbFDhTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DS7PR12MB8292.namprd12.prod.outlook.com (2603:10b6:8:e2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Wed, 19 Jun 2024 17:09:21 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%6]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 17:09:14 +0000
Message-ID: <ac436cc5-8808-4762-a67b-c2b29f9c8250@amd.com>
Date: Wed, 19 Jun 2024 22:39:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] KVM: selftests: KVM: SVM: Add Idle HLT intercept
 test
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 ajones@ventanamicro.com
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <20240528041926.3989-6-manali.shukla@amd.com> <ZlWLupfpODawPX3P@chao-email>
 <b45bc797-9087-4456-ba18-463c3f638096@amd.com> <ZllzCoYvMQOkMo90@chao-email>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZllzCoYvMQOkMo90@chao-email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DS7PR12MB8292:EE_
X-MS-Office365-Filtering-Correlation-Id: b1782ecb-eb0a-4b7b-200a-08dc90828bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHBUYUhsRmpRdWdDY1I2WjNYM2VwWlRKVGpLK2ZoR25ZRng2TDJhTjZRUC80?=
 =?utf-8?B?TjllbE1PcnRDMjRSb1lUR3BQcWVFajJsVWUwK0g4ejkwL3ZlTnFobDRSZVNQ?=
 =?utf-8?B?Y0FrZlBQSlRmbVgwVEZUNkhlNERwa1VJUTZvc0ZsbUZzWUZFMkwycW5TUXNw?=
 =?utf-8?B?SFd2UDV4TXU0NzFhODdPdVhrbmVzbEJpODkrZ29KcklFbExuRnN2OEZWVEZH?=
 =?utf-8?B?WTRLSERQckw5WCtnaS9NeWVkajRENWR4TkNhclFyaGszU3JDa1h1UVd1dUhI?=
 =?utf-8?B?RlZyRnpiRHlkUW5UcHlWWmVpcGJBT2VwS2QyMGNJUjNDOHJLMnpXK1p3aXlC?=
 =?utf-8?B?U3ZvMU9QZXhTWmdvZnJ5WVFUdzcwcDFCMnJRYUxPaTlGaWNyeGUrc0hLUGk5?=
 =?utf-8?B?N0FFdGJHa0RIT1BlK2VhcVdqWjlLWjhZTittWXlkRTZSWFJrZFZiSVUrMGJr?=
 =?utf-8?B?TllPcDU0MlVOK3VXcXlBWE1iZlBJMzFGYmxoUmU0dmVmSzZ1L1B2dndNb25S?=
 =?utf-8?B?UlRST3JxdnNGaUJVWjd3TWZZVUE4ZnB4c0gvczRTcUJtR2VRampFVHBKTFRB?=
 =?utf-8?B?eU11UGZMMU1zSWU4bWRVTkNpRzlYUk11OHJGVUFSbzlWbFRlUmFmMFRFT2pY?=
 =?utf-8?B?UU4rSE9wSVBFa0RnbWpJZ1NvZ1lqYWE3T1ErbHQ2eVBRZjducHdPYXNCNnRS?=
 =?utf-8?B?RlFKazhJN0gyN1pQTFoxdmdBYll2elFpRU1FR01DR29RTko0ak15LzZ4NGgv?=
 =?utf-8?B?TnVkTmFBMUU1V3pjK0NZS3BBM1Y3OU8yNEpEekx5Y2RaenZWclhoSW1nZlR5?=
 =?utf-8?B?aE1iYWR3cE1nUmJnZ3RjRXd4RWxjdU1BeXhBNFcxZllLR0ZDdjc5Z0d4T1Mx?=
 =?utf-8?B?d05BL3FJZ2s0c0VBUlR2TnJpVmRkaWFnRFI1dlBXSmZheTRnSzdZVlg1cXI0?=
 =?utf-8?B?TDhUajF3WHQwaHBNN2Jsa0p4MWZOVjE1cENTV1FzSW9UczRoc2RtWlRRYzFi?=
 =?utf-8?B?RzA4S3JJdnd6cXgzK0I1akw5QTRxdmJJU01OWW4rak4vZWdiMGZ6RGRFVnp0?=
 =?utf-8?B?eTlvUDJjdm8zejJDMTl5SlNHdDNqOS9LcFBkVXg2THBUMzRrUGJxbE5YWm1X?=
 =?utf-8?B?RnQ0Q3ZISHBxZDhkQTMyb0xzaStUa2tueUpNSWlrVjhucVNPS2R5TGt4K3JB?=
 =?utf-8?B?NlZ3VEtnN1FmK1RNZ1RMR2c1MWs2aUV5bkFTV0Z6VUxqNnpieElEZnFmTHdJ?=
 =?utf-8?B?dUVpZW5YbW1qMlR5eXhGRzdDS2xBQkM2T2Eyb1o2anNvVUl4Yjg3MTNHNFBY?=
 =?utf-8?B?NHV0NSs1b0VVaUFUZDhxaURIYnhRRVlzMHpKekd6QmpTTHk4WVFaUnQ5bXk1?=
 =?utf-8?B?ZVlOTW9xWGRTZTBOVkJGUnU1ZGwxQWw0V2FCVkFuV1djdWIzMnlaTXRsUVAy?=
 =?utf-8?B?TU1IZTQ0eHhlNEVWV3p6c2d4eWJQYUNpNS9IVHlPZlladzZsRXV4MHI3SC9Y?=
 =?utf-8?B?TEhabDFhbDJVZEtpZXZJbE5TOWJBRk9MdkY5YVJWcEtmMFJwM2x3RjY0OE9M?=
 =?utf-8?B?ak1zYURRUm01bytvQkNYbEpIdERSQ1hZWHk5ZEZvVkFlaDB0RDJqanhRN3Nj?=
 =?utf-8?B?czVlOWJzTXpKWGhNS0J6aUpvVlRJdW5xckVyeU52Q1BiZ1NZL3dDa2xoYlVa?=
 =?utf-8?B?clJFNkhxaEtXYzh1eWFZaE9vY2MwNGREWkZFNlhxYnhocEpsLzk4SGxFaDV4?=
 =?utf-8?Q?rd0k3BIlT0BO6yPyy4KmH4B3YYhSCkbF2bSLp++?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNlalZpaktmVE4zVnhhT1A4ckNTdkkvamx3b293anc4MWNRUEFUaUFVaVhk?=
 =?utf-8?B?N2VSN1dPVG9HV2Q0Mlh2NktWckdUMmoxbU51Z1IxSktWTE9ZdXIwUzdySzZX?=
 =?utf-8?B?L3hqdkVnTEt4VjRjS0lHZlEwNWFuUUxoNkErSnlURnBKUmV1UXI3aHRQWCtj?=
 =?utf-8?B?czlSZkFla1l2RE5qby90eHcwbG5iN0gza2xkYlI5d1Q5T2FLY0JaZEJUc0Ji?=
 =?utf-8?B?enBHdWFPaDFBZWtVdFlnMGxsMVNhZXpYKzE1cG5SR2p3ZWtyNm9IaUcydzRR?=
 =?utf-8?B?VzU1WEpnKzhQcGdYekpYazJHYWQvSzIvazRpV3hiMUZKWnVHMTZta0M2NWJE?=
 =?utf-8?B?cysrNkdTd290ZXZLUVdYTU5XeUdzZEhCbC96eTBMQmo5ZmV5K0VyL0p5RkdN?=
 =?utf-8?B?VWU2Y0Rsbjc5bTBqZytia0VLVEVUeHNuSzRtR0RoN2pkTXZTbXY0aldabUZJ?=
 =?utf-8?B?MEU4eW0rRGNVMGhUaHgzMEZEZUZCTVMvd3EzZXZneWgvRlBLNmtibmxwbUY1?=
 =?utf-8?B?Y0l2MGpURFBHNGtKcjZVUnpudVQwOGdic3RhSS9UTXhJcUtNWW5LVUVNcmlY?=
 =?utf-8?B?aXlQbWsvM3ptcTNxUExkeERXNHk1TG01NWgxOFkvME1RVEtvbnFVb3VyS2Z4?=
 =?utf-8?B?RXN1KzJkTUZGYXh0aTNqWWR2Q1RmYkIyb2RXOURQL3V6dDk0WU1DM29zZ2ZV?=
 =?utf-8?B?NjhsajU3ekkvWlZqUTcvTjkyaUltTUM3ZDAxaStDY0lzL0prZ3FJakRJYlFV?=
 =?utf-8?B?dVhFR1pCbytpL01HUmtjTXoyWDJ3ZW0rV0kwWFRqdXEyZk1lQnhodEpjdVBN?=
 =?utf-8?B?UEhOa2RQZjZ2VFJhOEl3RStYcFBBMGZSR3lMVk1BdUsrMmtGb0RTb0NxVzJo?=
 =?utf-8?B?MUdlS3h3U0VCS28wa0dJMGhIbmhWeEJwMW53dFR5V2pCSWpaclE1VXd0dkx4?=
 =?utf-8?B?ZnhQaklnbExremVEaDlZUTJRMW56YUZDRjhDWXZtKzhndHZJNkZ1d3g1NmMw?=
 =?utf-8?B?L2dYTW85d3N5dmhSUGNvK1VXckFuVVBBYjlmY0dZcW9YWGRIcXZBUm1kdkN4?=
 =?utf-8?B?a0NvS3Vvd2c0ellLYnBxaHRUdDNZY1QrclRtZWlGNHdJRW1Ycnd3NS9POFZV?=
 =?utf-8?B?QVJ4OE1VOUc5QkNwT1J5NmxvWnduUlFTUVI1M3NlRmY4Z0wwQk5HaU1qS1N1?=
 =?utf-8?B?dlNKeVk5NUxHQ1VNaU93WmsxK2w4ZXh4SDRUeXY0Ly9XVXRyMURXenhNL0xN?=
 =?utf-8?B?bDJrbW5FOWxNY3A0U2dEZ3Bjd09VM1VEY1hxUUx4YzEyOFlHcHlxbHEyQWJU?=
 =?utf-8?B?WFBoTlVkV0hXZENlam1OSjduVTluRHkxNE00YWNKTXREUHo5Ykx1TVpBRmdy?=
 =?utf-8?B?WklDL3lxTUN1RFNHZ05kMExGSjBNTjk0ZjNUWWt0UFpRT2xNV21BS0pZckxN?=
 =?utf-8?B?NStOQVRDak5VZnphbWJmdDVDMlBXL3pwR3N1L2l2dTArR2ZKaG1sc3JBU0R2?=
 =?utf-8?B?ODQvT3FNVHQzb1lUbkhscnd6ODhPK2JWQnpvTFB3NHVpSzFLS0lyN2RWdG9D?=
 =?utf-8?B?OWJVR2tNWm1RQnFkcUlvc2J1T1RiQS96Tlc0eno5VjlIRW1ENGtRYk1sN1Rp?=
 =?utf-8?B?Rkx1S2l0YkNpRVF1VkUwOFpYMzRpcElhZUJtcWVlbzZMZFFoMTZUOWdsTnRG?=
 =?utf-8?B?czdWVFp1a283TkQxTzNTQ1liZDQxK0EwWW9sNGRDb0dKa1p2d2sxUlNiSXlS?=
 =?utf-8?B?MjdVV0VwN291N1FsNHVQUTNXQ3hqcEo0T1pNTEZhTi9MWCsxRzBLaEtZbEVO?=
 =?utf-8?B?dkxHeWtPVVVGanQ0cjhKK0kyWGo3RWxTdzlTUy80VGZveDBYL1dJM1hnZ2Vn?=
 =?utf-8?B?T1p1c003cXVBajd3MFpEQ3lYS0hSeDRRZWNoNnEzcnZ2WVlweG5lcXpqMzNp?=
 =?utf-8?B?aVhEZEM4eXphS2VMS214R2FnOEg0NHM2b1ZvUVRrT3R5VVlPS2FRQy9KTktq?=
 =?utf-8?B?RVA2NEJrcng1VTlOVmJPSy9mV1RhamdYck53UjlrZHQzTGN2eWZiRnNzcFNk?=
 =?utf-8?B?RjJubUtHNndtdEtVVzJSbUE1OFF0aXFaMTJGSzlEbTlwdkoxWjFXNVlTVGx4?=
 =?utf-8?Q?m3HciiSVXwbS0zaH6P63oR2Eu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1782ecb-eb0a-4b7b-200a-08dc90828bc3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:09:14.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pw1eVSse9uops2NAihBz/+d4ebxbPRKEXsqibU+w9cWyr6WhviepU8i9ZrGZoP4cWgh2ISXELDyxN+HwYZG4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8292

Hi Chao,

Thanks for reviewing the patches.

On 5/31/2024 12:19 PM, Chao Gao wrote:
> On Thu, May 30, 2024 at 06:49:56PM +0530, Manali Shukla wrote:
>> Hi Chao,
>> Thank you for reviewing my patches.
>>
>> On 5/28/2024 1:16 PM, Chao Gao wrote:
>>>> +static void guest_code(void)
>>>> +{
>>>> +	uint32_t icr_val;
>>>> +	int i;
>>>> +
>>>> +	xapic_enable();
>>>> +
>>>> +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
>>>> +
>>>> +	for (i = 0; i < NUM_ITERATIONS; i++) {
>>>> +		cli();
>>>> +		xapic_write_reg(APIC_ICR, icr_val);
>>>> +		safe_halt();
>>>> +		GUEST_ASSERT(READ_ONCE(irq_received));
>>>> +		WRITE_ONCE(irq_received, false);
>>>
>>> any reason to use READ/WRITE_ONCE here?
>>
>> This is done to ensure that irq is already received at this point,
>> as irq_received is set to true in guest_vintr_handler.
> 
> OK. so, READ_ONCE() is to ensure that irq_received is always read directly
> from memory. Otherwise, the compiler might assume it remains false (in the
> 2nd and subsequent iterations) and apply some optimizations.
> 
> However, I don't understand why WRITE_ONCE() is necessary here. Is it to
> prevent the compiler from merging all writes to irq_received across
> iterations into a single write (e.g., simply drop writes in the 2nd
> and subsequent iterations)? I'm not sure.
> 

Compiler optimizing this out is one case. If WRITE_ONCE to irq_received is
not called, the test will not be able to figure out that whether 
irq_received has a stale "true" from the previous iteration (maybe the vintr
interrupt handler did not get invoked) or a fresh "true" from the current
iteration. 


> I suggest adding one comment here because it isn't obvious to everyone.
>
Sure I will add the comment in V4.
 
>>
>>>
>>>> +	}
>>>> +	GUEST_DONE();
>>>> +}
>>>> +
>>>> +static void guest_vintr_handler(struct ex_regs *regs)
>>>> +{
>>>> +	WRITE_ONCE(irq_received, true);
>>>> +	xapic_write_reg(APIC_EOI, 0x00);
>>>> +}
>>>> +
>>>> +int main(int argc, char *argv[])
>>>> +{
>>>> +	struct kvm_vm *vm;
>>>> +	struct kvm_vcpu *vcpu;
>>>> +	struct ucall uc;
>>>> +	uint64_t  halt_exits, vintr_exits;
>>>> +
>>>> +	/* Check the extension for binary stats */
>>>> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_IDLE_HLT));
>>>
>>> IIUC, this test assumes that the IDLE_HLT feature is enabled for guests if it
>>> is supported by the CPU. But this isn't true in some cases:
>>>
>> I understand you are intending to create a capability for IDLE HLT intercept feature, but in my
>> opinion, the IDLE Halt intercept feature doesn't require user space to do anything for the feature
>> itself.
> 
> Yes, I agree. Actually, I was thinking about:
> 
> 1. make the feature bit visible from /proc/cpuinfo by removing the leading ""
>    from the comment following the bit definition in patch 1
> 
> 2. parse /proc/cpuinfo to determine if this IDLE_HLT feature is supported by the
>    kernel
> 
> But I am not sure if it's worth it. I'll defer to maintainers.

Ack.

-Manali



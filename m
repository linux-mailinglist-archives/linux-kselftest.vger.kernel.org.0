Return-Path: <linux-kselftest+bounces-25339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF2A20FA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 18:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A271638B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492B1581F1;
	Tue, 28 Jan 2025 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NdTCKysf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCB1EEE6;
	Tue, 28 Jan 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085715; cv=fail; b=NHuihs7iyjcUtxVjTBDeseRGnfEq2+npvslmZWJEsBCpoLr3vGgcAj4cZl/0xVREzzOJee7z6Qz0++T+ap306i6wB27up4Igjp+t/ZJFGVFqHhT/WhCfusPSx5mbMoO0B5nSalDX4IUuXJHFwYvadKMH/pKa/Jy7XVxJdp+ZacE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085715; c=relaxed/simple;
	bh=2acbzD2x/YAuh6Y41p0KXQfcoceFUctyeEej9/l1Vvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NFo+0sw3eDJIRzolHr+R0xmetlg2T4n1mIDWgdfz2IF7sZfOrB0OwIIExtfJ2di2x2J8mQHb8tuI7zZhOWxaB1o8qr7h01Y4KV+X02M9MVhygnjwOhVf8vgRI8YGZCNOK8STpTDDoU8RpaCRP/SAryVQoclygYqTSfKjt0cRTLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NdTCKysf; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDZDHA0sRNDscUgqY6OF9hMqi9fvJ2SJ3KlJgLyA3bEqEXbFUK5tHSSSRGs2B2n/cjylrrvd/p8vftiZjt19PWuZQQ6ejWo2Xe5o3pOqnqXB7Hx4MPRK0NwJp58I+Y7yDb/ZkYPeim2g3WsHoSR/D4aTggRtEt2C0RcJbEh5wn1+L+hUiYnWF8v1nQlbgnpA8qKc7koIKzGTWDpmR1OBWauWq4/mjyIrFaYtXhN8ACSu4J2s9XBwiWzGQT6lAKmtHqnycZtvGRTcC/ubVgN2wpz2k8DM4i87vF6JLTAD3UXFAIqTjH2x2jtyKWoYyRrzd3zfGZvmmaG8TyLkOAvAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFxgzwPTda+jakDHsWpUzG5AfKq/WFGtb1ojjVGxvbw=;
 b=h/1KAqJGFQ+yL7uoDFGI9f8Cu/GsWLvATou8xaIF88dwfjN7bnSQOhgB13mcIQRpfu6TWfCf+RHH1BtCGDF8amqEnGQNNi0kW0yJHxI543YZ10PCv8hUrIuspqi1paJMSEzAJ6CVBox7l1lrPBk2n72YGSJmw4Y5H6eHfnOc1FMpQ+nHcb2zxY7dXV3ELUy0CQlPzLtrRiqVhr2EG8vlAN7UdKG2kgrvsxcSpeCDNuyee5UhQUiMcyT2twYcbZ61EqZyXFKV/RxmMsC14EsOuJ1IxOxGmSPUk9QPQL9Iei6BH0LBuBrePjHTeCOC9eWxXXgPZr97RBUdUEfJ0XCppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFxgzwPTda+jakDHsWpUzG5AfKq/WFGtb1ojjVGxvbw=;
 b=NdTCKysfgC7jfZMnKWroBPGFoze4xJoL3tNfEG+cY2xFuxtnI+VKbLVi5CDuYOREG6G5kcKhjC8ojzkW1ZxMxmzckMWuTYulyhZFyG9IJ9fZvrg9v/PN2vduA75q7dKqRLNKD1FBsD5LkuPCyWRJtsjebal48BjXJAjyB0KgqKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 17:35:08 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 17:35:08 +0000
Message-ID: <60b6142d-b115-4387-adf4-6f3a160660a5@amd.com>
Date: Tue, 28 Jan 2025 11:35:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] KVM: selftests: SEV-SNP test for KVM_SEV_INIT2
To: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250123220100.339867-1-prsampat@amd.com>
 <20250123220100.339867-4-prsampat@amd.com> <85ikpzm8zu.fsf@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <85ikpzm8zu.fsf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0075.namprd12.prod.outlook.com
 (2603:10b6:802:20::46) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 78df8be3-a62e-464c-a66a-08dd3fc21c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTNxWld4VDVtbzBjUlFyenJyNGM1SmQ0M1ZEMjlDcTNzeVdSd2FXVVVmR3Ry?=
 =?utf-8?B?RytNV3V5eFBkUWRITzk1bmFqOHJxR2pMc0tNVkZKSDh1ZFY4SDkrd3JDdXF5?=
 =?utf-8?B?cXFLYVh4RVg4QWxiQnlzb1U4NjJ1Sm1EaHBZdGk3N1ZaUmVJbmNSZzJmVXpt?=
 =?utf-8?B?SkpwZzlSVGowdWd2bEwxWGtNT1N1U0tIRG4xcUJxclNuWUlHRG5vTVlaNVJ2?=
 =?utf-8?B?ZWd4VXFFdndudEliaVE5QXNabFJ3Qmt0MWljUTMxbnV3R3FodHB1YUdOeXdG?=
 =?utf-8?B?SEYvbGJwWkFKMGZpQlVTWk9iSW1jaXFWODBVV21QTmtsZWxGcjFhcHcvd0lK?=
 =?utf-8?B?RWNKM1krTmRaTVE3MkNOdGgwNVpHYmhlTzF5TEh3M3ZUUTNkUEhQMnlzWVVj?=
 =?utf-8?B?V002czRuNEJCRkpISGJ1WVlZY0xuVmFWZU8wNjNHeFcydk1UdGRHWDFPTlB5?=
 =?utf-8?B?RWtaZGZNcGtEMk5Hc2JHMlVWMFY0SDQyR1hHb1pEMGtWbk1JenoyZlZRWUk3?=
 =?utf-8?B?WGIxQWFibGxPTTR0QjhMcU0xZm0rSDRxTFpDQlkvMmUyMW5Kc0lsUEdET3dh?=
 =?utf-8?B?UnJiS2szYm9vMmY0ekFMZGlSTTcyMmpKMGRrVFR0TTN4bGRVQi8zOHhYY3VQ?=
 =?utf-8?B?RlZnSllkUnhFQldaTGJvWXBxcDk0NXMySWRDazJzU2pGUFRpbFVGZGozVnhh?=
 =?utf-8?B?R0VhSVc2RUJKVnA0TFZ6N0RXREtGZVhFMFRZT2dGSzQ0Z2ZmZVlsd1NmODdr?=
 =?utf-8?B?cm9nSXlYRlZYUFp5TGhSbVY5S1JseGRjR2lMTVVTQUpMRTVVTG1iNk10RWlh?=
 =?utf-8?B?TjVWWFlneDJ6M2lVeGkrdGhrRmdTU0Jhc05vZVBXZ2VjZUtlejZoRk9aVXlm?=
 =?utf-8?B?a1ZIYzBmQlAyUWE3QVFINWRleXoyaVhDUXBKcnNvZkZRVHY3S0JaRmIxcjcx?=
 =?utf-8?B?c21ISXFjZ21CQmo2NjJQRUNoS2VoZUZmbzRDU0NmeWdTZFQrUXdHNFBlejZF?=
 =?utf-8?B?VVhEbVE0d1NDajdGWXZmWEdsRWxoeEllQjg5bm9PS0s4Qk91Q21LOVZxay9W?=
 =?utf-8?B?eWpmUHQ2RWRBaWhXcWtXV1pubnFwNkhtbldJUFpjTEg0a2F1b3cwNUdKWGdP?=
 =?utf-8?B?ck55QXNYTTFneUFrbDNmeE9LaExoTWRpdC8wS0FxbGN2dllkdW04YVlVWS9N?=
 =?utf-8?B?UmlXbWE4cldxQkZTS1VjajFlK21ZTGE5Q2llNHNCVFozMVFsc2NXZklzV0Rw?=
 =?utf-8?B?bmpQdW9GcmpzYnlmcTNSZDN1MFNnVGpwTFl5UHBaaWs5bXQraXNEKzRuK01T?=
 =?utf-8?B?YSttcWFQZ2sya2dPTEJzTkhYcCs3Yy9iL1crZTNaU0MwUCtUZnplaEI4M0xE?=
 =?utf-8?B?TlgwMXlJZFlFdVRPdmRXTkNxVmRIaTVuTk1vRURCWWhqeHNGWit6a2dKQmJD?=
 =?utf-8?B?TFhDbXJCL21Hd0xOay9UZ2FQais0WjExajU4eVFLTERMM0VqN2psQmsxa3Rm?=
 =?utf-8?B?WC9tSC9xc1kvV2NXNGF2T0pwOW5pcDF3bWZUNkZFUS9SQ1BaaDBUZ3puNzRX?=
 =?utf-8?B?a09TT1I3NzJxUjRES2YrS29EbjZjdXRNRTEzTFFKTEFuczk3TmFGNDk1U2dD?=
 =?utf-8?B?Wm14WTdaaUZuL1JxWVdFMXo2WE9zM0d0bkl1UzVLTzVnMFlYVlZ3Y0h3R1dS?=
 =?utf-8?B?VUhwN0ZUTjFpbVo4SzNmL2h0TW5VYTdCd3FtSXhDR2FaVU1SMGhZTDM2NnZW?=
 =?utf-8?B?Q2cxNVNMb3Z1dnk1RlF4ZlFjeHB1SjFxeUNmbkdQbVhJckpqcWlzU0RuNVJR?=
 =?utf-8?B?ZlR2N09NTlg3dkdQRURseUdRakRoVjlKQ1J2eUNibTN1UmwvWDhMUUQ5aS9q?=
 =?utf-8?Q?T8zoemZY6KSP4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1ZFRWN1NjJBaG8wdjlaNHZBN21xUWtTY25Ncng4VDdVQkpyVlZUOU0rWGYv?=
 =?utf-8?B?VEx2TUlYT0VTdWxRZThLMkdRclltQ2FxOXQ0VEYxQTlUdStYNTVxZmNYTXM1?=
 =?utf-8?B?b3hEUzdPTG12OWdqZVNnb0dObXNhSzMwNklTNE5rR1VyMDZlclZZTTMxdFFq?=
 =?utf-8?B?bVNKSGVHc1VMVSsvdzBIQ1FNUkhuS0oxOHVrelBJQ1VzbjRYajN1azNvaC9M?=
 =?utf-8?B?bUVJbnBDU202VlNEL2MrUVd4aVkrbTVBN0dvUnFlYlJrK3hYNDRvOHI1d1Ix?=
 =?utf-8?B?SkFQYWtHSzk5YVgxS01mK253OWNrSGkxMnVudWdLb1VOc3pLWUw5ek1BY1Nv?=
 =?utf-8?B?eXhLclBTYUJsUG83REJvbzdPY2FpQVNqVmJBN0dEak9IVGNjRE00eTROa0I3?=
 =?utf-8?B?bmZvamR0NlpsMzdjaEZrcEtzT04yaWdkc0JRT0laVHZCNGFDUkY0c2RMTHBG?=
 =?utf-8?B?OEp1SDA4dGlKaU5YbFBib0RMYUhZYTRnZXhqVlJNN3FpVndSU2c2UHhVUkVz?=
 =?utf-8?B?SUVKVTFSMW0xcGE0cHA4YnhMTTVYa3lWSEh1MGtzK1I3WGs3M2M3S3gvNkVt?=
 =?utf-8?B?eWp6M281SVBHRVg4dXZocWpWR2MyR2xyL0lZeFhjNGJPM1JSZVcrdEc1bGhz?=
 =?utf-8?B?SHFzbTFtR0E2NldLS3Fvb204NVVPaVBBOEtsWWQrK1FXM1pYWS9vWEJFMjJ1?=
 =?utf-8?B?WFdxdkxIQ29hb1I1QlM2SjdOanZDYW8waGU1NDJOeWtweWNsYmVuWStJMGRG?=
 =?utf-8?B?d1UrWUhqdlRUWUh2NlJzOENCZVVxODQ5ZWZGdTBtYVorRjV3R2I5alB6bno1?=
 =?utf-8?B?OE1jQTAvbFptQ1AzY25xM2xFODNRVE45dS9CWTJJeGw2VFUwekpLelFXeGdw?=
 =?utf-8?B?VmtYUFROZ0l4ODNTamlFNzI0VHI5UVNGYWdVbmZCUlp2b0QzbXlEWjFNd1pC?=
 =?utf-8?B?cnBuTkR4TjFObzBGL3RyREpLWmFSOWUwdm9SdmhzNGxubjI2a0ZjczljdTZZ?=
 =?utf-8?B?QTYyOXVzcVUza0UvSzhIRDk4cHBubVBIUFVTZzUzUUV1QktMZHRvVUVPNUcw?=
 =?utf-8?B?dlNaMFVvSFZ0Z3RDUVlqTVEzK1czWDkxTUZWbGFWbWhLNjVqd2NzZHg3SW9C?=
 =?utf-8?B?QmJDdUcwbEt2cFNwR2w1Tk1rTEtWVlMzL1I1QWNjeENxS2oyMnhlVUdSQllo?=
 =?utf-8?B?alBqQ1hXazg2RHJBeTFpN2hrL0p1aHdkWXMzQnFtOTIxZk0xbklybjJweGpB?=
 =?utf-8?B?cEVjd1IybkdTUWJ1OVBxZWhRNjcwMUxxMnJFRG54SFZPS1NpL09XQnlzVDZq?=
 =?utf-8?B?OFpDeEpTeFMyeGk4VW56N0NXMW5RQituMk11dDFaVHo1R1pvdSs0eDdGb014?=
 =?utf-8?B?VjFHRGh6TGdCVU1sSnVTeEladXFLZ3FoVUFYaHFKdnFVUG45VUxuOGNOREdu?=
 =?utf-8?B?V3hZanFCdzd5WFYvMTZMYUs5YWZWRFR2ZitPNm5PTFBaRGRxNTd3SGlGUkZW?=
 =?utf-8?B?YW5JTHB3UHc3bWFRUm9ONTZiM0w0N1QveDlmWm1zckV5Z1pVa1FYdkdSdng3?=
 =?utf-8?B?cEw3ZXFJQVQ5TXpwNTRrbkhZb1cwR2JLalNiampDV25ITitFdkx6akJLY1Fx?=
 =?utf-8?B?aWNMaEhtb3dCWmRrZnBwV0x5OW9Rck1DcXcwM0V6SFB1eTMxbUJVY3BqNDQ0?=
 =?utf-8?B?bDJYNWg0UzlFNm0zNmpwOEloZHFkNGZLZFFPR2FodmtQdHlCMldDVDRIOXJB?=
 =?utf-8?B?ZHcrbE9JbzBOb3JRQkRnR0Z5dVhheDZ5Z0JQdm5JMkN0QjZudFgzV2t1K2xu?=
 =?utf-8?B?cjJwSThjOEU5VFY0dG9BMWdPbGtZdlVwQ0J1bXZ0eVRWRDdpZFk5RjN6akUw?=
 =?utf-8?B?SVhQYmVVMDAzeU84WU5yczZwK1UxTnBjQkhMQ1c0cVBFRytDbDNVMVVHNjJw?=
 =?utf-8?B?NFhOQVJaRndJTXdNcStvdFZjMHd3SUlvYWV3ZVBYWDBOV2U5eEZrZFF3emZp?=
 =?utf-8?B?U1JoRnhVaGFBREcxTXk2STBPMlZpRGtxb1YxK09XRGlHNXo5bzdqOFp3M0dJ?=
 =?utf-8?B?QVRrNkN4QXF2NWRjMS9RaTR5N3U4ZXlFL1YwZGx0RDdZd1BiblRKaEVGTjdW?=
 =?utf-8?Q?Oe3aTbCzzbTFIyYfVfYpaen0n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78df8be3-a62e-464c-a66a-08dd3fc21c1f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 17:35:08.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lz/+nfqm/yR2u+UTd/yoeOyVm6ieI6nhqzGFjIkLfw4NaLcjt4YUWBzmBPrEY/CBhp6Optg+KLl0ix0JHdGnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094

Hi Nikunj

On 1/28/25 6:13 AM, Nikunj A Dadhania wrote:
> "Pratik R. Sampat" <prsampat@amd.com> writes:
> 
>> Add the X86_FEATURE_SNP CPU feature to the architectural definition for
>> the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
>> SNP test is skipped in scenarios where CPUID supports it but KVM does
>> not, preventing reporting of failure in such cases.
>>
>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> 
> With a minor nit below:
> 
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> 
>> ---
>>  tools/testing/selftests/kvm/include/x86/processor.h |  1 +
>>  tools/testing/selftests/kvm/x86/sev_init2_tests.c   | 13 +++++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
>> index d60da8966772..1e05e610bb06 100644
>> --- a/tools/testing/selftests/kvm/include/x86/processor.h
>> +++ b/tools/testing/selftests/kvm/include/x86/processor.h
>> @@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
>>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
>>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
>> +#define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
> 
> Can we keep the naming same as in cpufeatures.h: X86_FEATURE_SEV_SNP ?
> 

Thanks for your reviews!

Overall, I was trying to be consistent with KVM by dropping the SEV
prefix from SNP in the rest of the SEV library to improve brevity and
reduce line clutter. However, for consistency with cpufeatures.h, I can
change this instance to include the SEV infix as well.

Pratik


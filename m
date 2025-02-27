Return-Path: <linux-kselftest+bounces-27719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4A5A477A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 09:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9753A4637
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE11F9F5C;
	Thu, 27 Feb 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQzMzAyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F424A59;
	Thu, 27 Feb 2025 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644529; cv=fail; b=H96QMf3O4nGYjFDkQBxjRf2bM0ThjD5rQ8voqE3+PC4brcqo0XxGOeSAdok4/KnUUbn44sYZWWcJN4fQYE2q9wK4bAf+yGexiYXPR++J3XQmhJfOughGioRx0UFiA9lr7JBJujMLxD34MJC/iFTQUdxiH0T0WE3lSZlIl28Mj8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644529; c=relaxed/simple;
	bh=kvPtxp6VRAevUwj5g3tetlC8fS2Ejt9aCyMtkyyI1HQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtYaB5qSglL+ZegxCx3YCPTN0CbD81aZFBhAZBdFusJhpCjKda6B1TiQovP1Ik0tLPUdlZZu+xT28ctk6ztOBoh3kE1tWG9sSNnbxfoXtcYyexta00xnQfaNHSAZfmnQXOvdmRlOc3Z0X5nga6UNP3rB7ZRvF0nfiRiTUwcFDtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQzMzAyl; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAIYae63ZQhd8m5D/eaF8eNwO68VROBmMhB2kfDfManL+2NfVrmvijlhdZ1T8JFLToQSp9Bxjp3gjuMNHehVbndMv8aUZEWJgqDKMP62h3WpHiThHimlyd04TglEn/VLB8i1IQfxelTvkacVbDT+pXnXhxEOB5s9e4ncx2+5hlsSeqkV2MBx28npk1oBs9XIg7kagbLzKkdurQ4IbEfZMbkIVYOXCN3Q8TcxZI6vWC1qvFASbkOgNnCrw7tiAdmMyhlc0Ot8D3gFBe8+rybyEdqAYLnvh4d6e91XJwJynF3oBC32fv0C6vlI1pnLxl7++/RE8KjhqCBJOI30Ni9aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSfzQQiZwpYkqESSaU3hcF6hC0e/oyJhUH+EIjR+9/g=;
 b=JHJ7m7XpL0LHXWmIZt0ZncGkFRQWq7XOn2hg8LYfb9rzXsLEy4ZD+2BkjV70QdDnO+RXsS9rrlWjWJcm0wq8N8EHzDrxDM9ZzMjSE5cElkTPFsQoZ76DlZAYM9tgFYuSa3cMCd2TO9t+lWRlFDTWLUjXROh/rHGv8rcAKRWvZbPNob3pAorcNO32iGf6n2cJIYyG8p6p8InoS7iGeC/CUN1KQi1vlRPTkruSuept+rRB+2SZpc2KfA8wNQiArB6gDT3gBni1lC8yNVR5uzJQcBaqWC5/Y1X26FnL+ZfAEofMvtVhLo0BpCjwku77ulc8Q8QDCK19OWx6+jG0ssnlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSfzQQiZwpYkqESSaU3hcF6hC0e/oyJhUH+EIjR+9/g=;
 b=AQzMzAyl6zDhG3zRRJBjwn9rF2Rj8mEeXYMS5gQKyJ1I6KFitXlaS6KIFUP48ZzuRz4NnwYLxF/oorQ7kVpzjUBUXns+JxAbi/+A0glCcWrVI0pIuRNfBSbdtLJKJXT2M8F8ECqC4AUFNSp3JBrb7J9f6bVfeTiitW+WPOdlm98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Thu, 27 Feb 2025 08:22:04 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 08:22:04 +0000
Message-ID: <454ba4ae-4be7-49ae-a9b9-3b25cad8433a@amd.com>
Date: Thu, 27 Feb 2025 13:51:56 +0530
User-Agent: Mozilla Thunderbird
From: Manali Shukla <manali.shukla@amd.com>
Subject: Re: [PATCH v6 2/3] KVM: SVM: Add Idle HLT intercept support
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, neeraj.upadhyay@amd.com,
 Manali Shukla <manali.shukla@amd.com>
References: <20250128124812.7324-1-manali.shukla@amd.com>
 <20250128124812.7324-3-manali.shukla@amd.com> <Z74_HQaQ1jY4eKBB@google.com>
X-Mozilla-News-Host: news://54.189.247.149
Content-Language: en-US
In-Reply-To: <Z74_HQaQ1jY4eKBB@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ef863d-68ab-414d-9767-08dd5707d142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkhzaElvZlREcHczNmdRV1pVSjhRVTlXWk44WVB3ZVdYclowMGNkK0EzTEpF?=
 =?utf-8?B?TjN6azlnZU9DZ3FNL01SMEFHR0FtSU5NZEw4dmx0dHVscVl1NThwV0FTcVRB?=
 =?utf-8?B?WXgwS1hRVW5IbDVJbmV1Vk9idHRZWUxKRDBqbi9PNVVjekJZNUo1WG9pNEpC?=
 =?utf-8?B?NUN5TGdrZUhYZ2dXOWk3K2hjaERET1JjMWhldE9LZUNacWNqRVF6Szhnbm5l?=
 =?utf-8?B?emI0ZDBHNHNTU0kwcDFKRklyVjVIOGowMzUxb1kzVHo3TDJnMHNmM3JNNVpH?=
 =?utf-8?B?dG1iZmZxa3dERGNISHM4N2ZKVHIrelE5K0dHaEVxQWQydW5GTXhrcEE3S3hm?=
 =?utf-8?B?akNrM3dGaWNLK1VaakgzQ0t2V095c29HZVZSci9TbGNhTzl4ZXhzRWdBMzdT?=
 =?utf-8?B?WGZrSEs1RVhCYmdselBEeWNYYVdOVHErOHZyMkpIdUFDQ0s2K0NROVYxUmhG?=
 =?utf-8?B?MG5KRVhxd0lWSXpobHhBVytBRThOSEtCZEJ2Tk83QWQ1Y1d5ZHZ6bGlaVHZr?=
 =?utf-8?B?TEtWSWNxWWNqYzlVc05iZjJja2lRUFNST2E5UU1RWmlCVjZWMTFjbUlZaHFr?=
 =?utf-8?B?bk43TFNSbHIyUEhjUGw2NDFvMnE3SHFQMXVvREc1OGNDdHF6SkpZVklsNVRo?=
 =?utf-8?B?SGgxUnVIZGpyQzRSY3J5Ulk1Q0M1ZVhISEoyZFNPS2k0WEwxM3g4VXJoMzE3?=
 =?utf-8?B?QS9QWnNtMW9jbFlGNWsxUHc1ZzBSdEplcFRqREJmaWs5Q2hBSXVXMjBKNlcy?=
 =?utf-8?B?ZjlBQTcwL1hZUG5veW9sUjBCVCtsOXBYZHpEeEw4WGJ5MzByV3czUktpZW1Z?=
 =?utf-8?B?clIvWjlMQWVPYmdtUU90MUQ0RkhYOVdseXlIcmt4eHZZTWR1bC9NSVBadW5W?=
 =?utf-8?B?ZG5VY05yU2gyQ3h2WE1NeHZ1dXdJM2NrN2lHL2FlWnRkYXk4VExTWFdZSXNK?=
 =?utf-8?B?Vk10OHlqWERaa05yd2dteDFJSjBuSDJSMkR3NXR0VDF3d3ptTWpHOWNOUzhh?=
 =?utf-8?B?aHBZTk5TVXJuOWc0bzJrSjNMNWx6aFhHczNoVzdEY3k2c2FuV0hlSE54cFkw?=
 =?utf-8?B?ZHZJTy9vVEdRTVJrNVdUZmIzUFM1VlEvM3BxdUduZW9PSlJKbkpXVE9hcVNz?=
 =?utf-8?B?anBybjRheVhTV0hsaTRaWnIvanJFcDdLNkZXcjNUWTh3NHBzVXBEaUw1enMz?=
 =?utf-8?B?RXN1YUJMcUp0emg5ZkNVQmlMSVhzd1UwbTMvODZXcFFQRi9WRnhVK21nT0xh?=
 =?utf-8?B?MUMybFI1Z3owNThKbjFEZ3V0bTRsYnRLdW5rWVNGem5Bd2djdWd1VFFrSThX?=
 =?utf-8?B?bWxsMG1tWG1EZXlXNzc1WWF4V21DTGxtbU1nUXlWcUZpaUZ2ejdVVlVCZGhv?=
 =?utf-8?B?Zmg5UWVkUEhzRzdyakJvMjl5TzU1bnlLNmZJRW5zR1dWQTA1K1lPODU3S29t?=
 =?utf-8?B?eHBqTDVVTHI5T0h1UWdmL1F5UXdkOXNrMFRPOFhrYSttSXVjeG1uN3RBbzBy?=
 =?utf-8?B?ZnAveWpKSDlqeU9TakR4TDN2K3VDcVZtRXQxaDU4cGFuVWVuQXo5REtCb29a?=
 =?utf-8?B?ZFVkcDVWb0owcXBOSTBmbmFpR2N2NnpGeXVlWXhzSHRXV0dGc3Z6SXBrQXJz?=
 =?utf-8?B?M2Q2U21BMXBCbTZWTjRzUjdJMFVrbDRmL0IvNW11SlVsNVRBd1YxSHpQRDVK?=
 =?utf-8?B?U2IvaDRSRlZkckVYaXNxZmZNR1pkSndjb0FmaXBUejhoRCtRcGJ4cHZlYkhJ?=
 =?utf-8?B?di82cnBsTHgwbStUaHdtejd1UEpxSzYrZmRBWjBBL0lyRWlYWktiNDJxMzhG?=
 =?utf-8?B?bHlhSmFoSVZBWjJjN0h1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVRmSENLdmpvcC9ZaVFxdUthRml5djUxV05veWNYbG9TRG9VQ1hkaWMzUmlF?=
 =?utf-8?B?SzN3allwT0MrZnh2K0ZYZ0NkZVVmQmtCWDVpN01ESldkT0dycmRhNHVodkJP?=
 =?utf-8?B?YXVhbnQ0dkZWcWF2ZUV5SFVLSi9nMVJ1Q1c0NEpXN0swTVRQbnhkVXNKYzhx?=
 =?utf-8?B?aTF3VHdtaHR4RVV3V3FmSUVuVGpsNHpnWUI5MW50NFFGb1YvUFV6Skorb3dS?=
 =?utf-8?B?M0FBc0ZUYWw0aVpMQU9MQWdBSDl5dzQwQ2pObVNSaHNzcXFmSFBlVWQ3ampx?=
 =?utf-8?B?VEtyN04wVGd1b0lHbnFDZW9kdzlQSGVKaVovTnRUSG05Umg0ZUx3ajhPcVhi?=
 =?utf-8?B?L2MwRHRpV1lNMmtsSEp3V0taRDE2Ukt1MnlhOXZRelQ2ZW1ja0grYkxSbTl4?=
 =?utf-8?B?YTJrOG5uRnhKeWN3dk1SUzN1cGhmcVJad2JDclRnTTZCRHhmOXkwSFBqY255?=
 =?utf-8?B?NVJLUWVNeVJqK3R3VnA1ZnRGSHlvb2hYd2tTOHV4M3hmVmQ2QkJzTjNLdFZk?=
 =?utf-8?B?azRQYUF2RHNXNHp6STlqcXpGeG43V08yRHdTaDVYT3RuTnp2bXAySkhNNDVH?=
 =?utf-8?B?ZnJJd0daenhjb1ZqcnhjTVdhVmhVd2JJSUs2MG1HbVFuMlBVWDNRL2xjcDFS?=
 =?utf-8?B?dlB1aVBVRmFrcUNSdTdlUWJDdWYwd053QnlQMUNkV2xuNUROZHV4UjU1OUNU?=
 =?utf-8?B?SUJhT0VMM2tweXlQdzh5OXRFaXhZNWkvdWx0SExXYzhSdS9kckhJSFNCZXB3?=
 =?utf-8?B?eW0wbmUyb2k5NVBaVlFDODhnb2JVbTNUc2lBL3JyeUxLLzBKdy9BdGdEdWwz?=
 =?utf-8?B?VHFCaWNTMTNFNTgyZmZZYlplWlM3aW96UWxWbU5MdWJUMW44dk9pc1IxeU9W?=
 =?utf-8?B?VG1Qbkt5cll4QzEvU2VhREVROWNSemFhdXRQeFhVM2wvYkR6NTBaUFhpZEJV?=
 =?utf-8?B?YW9qQ0VVRHNHYnE5UUFFZm9BRkNSSkNMVGZEUzlKVklCL1R2ejFhaDBNak11?=
 =?utf-8?B?ZEpFaHRTYnM3aGcwY1p6S25xNE4yaWYzWHBFRTNZRkpzd0p3NEtzSWl1dzZW?=
 =?utf-8?B?emtyU2g5dkZxeXZ6UUMxRjdCQVhtTmZramI4Q2NXbkdSaU5SaDFXTUtaek5W?=
 =?utf-8?B?cU1iNHFHaGgxUEdkS2dlY2hBeTR4dEdYL1BlcFZDS3UraTJGeVBaVm83Undv?=
 =?utf-8?B?TWI2VGdOSGY3MkJ1RGJFdXBHNUZ2TXNIK2lWbFR1UFVwRmtmb3VSTXNpb0ZZ?=
 =?utf-8?B?WDFiN1kvS0NpYTJEdFRxMnJ5c2owQkNIRjVhTktIVDM0RmQ3MkJTODNaZkM1?=
 =?utf-8?B?QzRZVmVmOVgyUE5MNUh0WjRsM0RpanBsWDZNcXBjcFpoUEozUHhCck5qd0w4?=
 =?utf-8?B?RWV6N1pPYmNTcjc5ajhkMVI0aEU5WlVnbW5lTGlySjBvRTdZVy92OWhPdUg5?=
 =?utf-8?B?b0x5SWV5K0N5YmNCdGozb2hjQ0Jxa2Z3Z1B3dXprQ2xLL3FvN1VCdENCdGgz?=
 =?utf-8?B?MTdOa1BibldVUmttc0pUR0paQ3hSczR0aU5XVDVPTExrNlQwT3R2Rk83UFFt?=
 =?utf-8?B?b3AyVFdxSW9qcnpzdVlNekloR1R6OFJDK3FNOTFPQzg5dTJOaVA4OXlQOGVu?=
 =?utf-8?B?K0ROSEo3QUN2YzBtVlQvejNLMzlZTXA4RXZLN2JrL3FMc1dOclVQaHZQUmxU?=
 =?utf-8?B?KzlnRldkL3NsbFVXSy9zN285S2NtVXQ1WUUvZHdzdS9WZ2EycUlmM3dQQnFl?=
 =?utf-8?B?aVEzZElIUFQzZFJqNHRENC9neFNhSVZIVnhqTkhieEpzajJjdUZlMi9jZnlX?=
 =?utf-8?B?b1ZyanBQODFodTJxQXduV1BSMEhPTzBaNWRTTzRJSGcwT3d6N1JrcFZNRDgr?=
 =?utf-8?B?VWFGL1ljYVNFZVY1YzF6VnZjS1ZnZzhBWEJHbnVLRDM1d0RiYk5zRjQ3Zjdv?=
 =?utf-8?B?clZhdGJiRFZ5RFFyQ2w3R2JzZ2RSM3EvODdkeVRPR0JGc0cxQ0FmM0Vma2cx?=
 =?utf-8?B?SUZMVkNmMnRJTlBQU3YxQmF3WEFaTnVLQkVYMlJoeVBCQ0pWM0s4NTU0Y3JK?=
 =?utf-8?B?MGZVbE1IZDJ5cll1WVdGRGExZEdhVDhRNldJbGhVaDlZa2xxWnMyQUZjVmdB?=
 =?utf-8?Q?Xe1k4I8Q+PvjnQnzUf3VTuPZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef863d-68ab-414d-9767-08dd5707d142
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 08:22:04.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRnyNLLBO4ByYjNawSP5rwkav557+cnx170BX/JAoku2CWz60zt8kEmX2yKYOmdVYE0agnrQBosV2vDCCaDgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

Hi Sean,

Thank you for reviewing my patches.

On 2/26/2025 3:37 AM, Sean Christopherson wrote:
> On Tue, Jan 28, 2025, Manali Shukla wrote:
>> From: Manali Shukla <Manali.Shukla@amd.com>
>>
>> The hypervisor can intercept the HLT instruction by setting the
>> HLT-Intercept Bit in VMCB, causing a VMEXIT. This can be wasteful if
>> there are pending V_INTR and V_NMI events, as the hypervisor must then
>> initiate a VMRUN to handle them.
>>
>> If the HLT-Intercept Bit is cleared and the vCPU executes HLT while
>> there are pending V_INTR and V_NMI events, the hypervisor won’t detect
>> them, potentially causing indefinite suspension of the vCPU. This poses
>> a problem for enlightened guests who  wish to securely handle the
>> events.
>>
>> For Secure AVIC scenarios, if a guest does a HLT while an interrupt is
>> pending (in IRR), the hypervisor does not have a way to figure out
>> whether the guest needs to be re-entered, as it cannot read the guest
>> backing page.  The Idle HLT intercept feature allows the hypervisor to
>> intercept HLT execution only if there are no pending V_INTR and V_NMI
>> events.
>>
>> There are two use cases for the Idle HLT intercept feature:
>> - Secure VMs that wish to handle pending events securely without exiting
>>   to the hypervisor on HLT (Secure AVIC).
> 
> I honestly don't see any reason to talk about Secure AVIC.  It takes a *lot* of
> background reading to understand how Secure AVIC actually works with Idle HLT.
> Critically, it requires a *reduction* in acceleration relative to what the APM
> calls "legacy" AVIC (lol), in that cross-vCPU IPIs are *never* accelerated.
> Ignoring device posted interrupts, lack of IPI virtualization means that KVM
> always has visibility into *new* interrupts.  The only blind spot is self-IPI and
> interrupts that were already made pending by KVM.
> 
>> - Optimization for all the VMs to avoid a wasteful VMEXIT during HLT
>>   when there are pending events.
>>
>> On discovering the Idle HLT Intercept, the KVM hypervisor,
>> Sets the Idle HLT Intercept bit (bit (6), offset 0x14h) in the VMCB.
>> When the Idle HLT Intercept bit is set, HLT Intercept bit (bit (0),
>> offset 0xFh) should be cleared.
>>
>> Before entering the HLT state, the HLT instruction performs checks in
>> following order:
>> - The HLT intercept check, if set, it unconditionally triggers
>>   SVM_EXIT_HLT (0x78).
>> - The Idle HLT intercept check, if set and there are no pending V_INTR
>>   or V_NMI events, triggers SVM_EXIT_IDLE_HLT (0xA6).
>>
>> Details about the Idle HLT intercept feature can be found in AMD APM [1].
> 
> This is not a useful changelog.  While I do care about AMD's motivation for adding
> Idle HLT, it's far, far more important that the changelog cover (a) what is (and
> isn't) being changed in KVM, (b) what edge cases are (or aren't) being handled,
> and (c) why the KVM implementation is correct.
> 
>>
>> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April
>>      2024, Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>>      https://bugzilla.kernel.org/attachment.cgi?id=306250
> 
> *sigh*
> 
> The inscrutable reference to the APM is longer than the table entry.  Just copy
> the table entry.
> 
>   When both HLT and Idle HLT intercepts are active at the same time, the HLT
>   intercept takes priority. This intercept occurs only if a virtual interrupt
>   is not pending (V_INTR or V_NMI).
> 
>> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
>> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>  arch/x86/include/asm/svm.h      |  1 +
>>  arch/x86/include/uapi/asm/svm.h |  2 ++
>>  arch/x86/kvm/svm/svm.c          | 13 ++++++++++---
>>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> ...
> 
>> @@ -5225,6 +5230,8 @@ static __init void svm_set_cpu_caps(void)
>>  		if (vnmi)
>>  			kvm_cpu_cap_set(X86_FEATURE_VNMI);
>>  
>> +		kvm_cpu_cap_check_and_set(X86_FEATURE_IDLE_HLT);
> 
> I am 99% certain this is wrong.  Or at the very least, severly lacking an
> explanation of why it's correct.  If L1 enables Idle HLT but not HLT interception,
> then it is KVM's responsibility to NOT exit to L1 if there is a pending V_IRQ or
> V_NMI.
> 
> Yeah, it's buggy.  But, it's buggy in part because *existing* KVM support is buggy.
> If L1 disables HLT exiting, but it's enabled in KVM, then KVM will run L2 with
> HLT exiting and so it becomes KVM's responsibility to check for valid L2 wake events
> prior to scheduling out the vCPU if L2 executes HLT.  E.g. nVMX handles this by
> reading vmcs02.GUEST_INTERRUPT_STATUS.RVI as part of vmx_has_nested_events().  I
> don't see the equivalent in nSVM.
> 
> Amusingly, that means Idle HLT is actually a bug fix to some extent.  E.g. if there
> is a pending V_IRQ/V_NMI in vmcb02, then running with Idle HLT will naturally do
> the right thing, i.e. not hang the vCPU.
> 
> Anyways, for now, I think the easiest and best option is to simply skip full nested
> support for the moment.
> 

Got it, I see the issue you're talking about. I'll need to look into it a bit more to
fully understand it. So yeah, we can hold off on full nested support for idle HLT 
intercept for now.

Since we are planning to disable Idle HLT support on nested guests, should we do
something like this ?

@@ -167,10 +167,15 @@ void recalc_intercepts(struct vcpu_svm *svm)
        if (!nested_svm_l2_tlb_flush_enabled(&svm->vcpu))
                vmcb_clr_intercept(c, INTERCEPT_VMMCALL);

+       if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_IDLE_HLT))
+               vmcb_clr_intercept(c, INTERCEPT_IDLE_HLT);
+

When recalc_intercepts copies the intercept values from vmc01 to vmcb02, it also copies
the IDLE HLT intercept bit, which is set to 1 in vmcb01. Normally, this isn't a problem 
because the HLT intercept takes priority when it's on. But if the HLT intercept gets 
turned off for some reason, the IDLE HLT intercept will stay on, which is not what we
want.

Other than that, everything looks good to me. 

> I rewrote the changelog as I was going (I didn't expect to go down so many rabbit
> holes), and ended up with the below.  Please review and let me know if I missed
> any wrinkles and/or got anything wrong.
> 
> ---
> From 05281b3782b7f880b3afd68e0074bf3abf6d55a7 Mon Sep 17 00:00:00 2001
> From: Manali Shukla <Manali.Shukla@amd.com>
> Date: Tue, 28 Jan 2025 12:48:11 +0000
> Subject: [PATCH] KVM: SVM: Add Idle HLT intercept support
> 
> Add support for "Idle HLT" interception on AMD CPUs, and enable Idle HLT
> interception instead of "normal" HLT interception for all VMs for which
> HLT-exiting is enabled.  Idle HLT provides a mild performance boost for
> all VM types, by avoiding a VM-Exit in the scenario where KVM would
> immediately "wake" and resume the vCPU.
> 
> Idle HLT makes HLT-exiting conditional on the vCPU not having a valid,
> unmasked interrupt.  Specifically, a VM-Exit occurs on execution of HLT
> if and only if there are no pending V_IRQ or V_NMI events.  Note, Idle
> is a replacement for full HLT interception, i.e. enabling HLT interception
> would result in all HLT instructions causing unconditional VM-Exits.  Per
> the APM:
> 
>  When both HLT and Idle HLT intercepts are active at the same time, the
>  HLT intercept takes priority. This intercept occurs only if a virtual
>  interrupt is not pending (V_INTR or V_NMI).
> 
> For KVM's use of V_IRQ (also called V_INTR in the APM) to detect interrupt
> windows, the net effect of enabling Idle HLT is that, if a virtual
> interupt is pending and unmasked at the time of HLT, the vCPU will take
> a V_IRQ intercept instead of a HLT intercept.
> 
> When AVIC is enabled, Idle HLT works as intended: the vCPU continues
> unimpeded and services the pending virtual interrupt.
> 
> Note, the APM's description of V_IRQ interaction with AVIC is quite
> confusing, and requires piecing together implied behavior.  Per the APM,
> when AVIC is enabled, V_IRQ *from the VMCB* is ignored:
> 
>   When AVIC mode is enabled for a virtual processor, the V_IRQ, V_INTR_PRIO,
>   V_INTR_VECTOR, and V_IGN_TPR fields in the VMCB are ignored.
> 
> Which seems to contradict the behavior of Idle HLT:
> 
>   This intercept occurs only if a virtual interrupt is not pending (V_INTR
>   or V_NMI).
> 
> What's not explicitly stated is that hardware's internal copy of V_IRQ
> (and related fields) *are* still active, i.e. are presumably used to cache
> information from the virtual APIC.
> 
> Handle Idle HLT exits as if they were normal HLT exits, e.g. don't try to
> optimize the handling under the assumption that there isn't a pending IRQ.
> Irrespective of AVIC, Idle HLT is inherently racy with respect to the vIRR,
> as KVM can set vIRR bits asychronously.
> 
> No changes are required to support KVM's use Idle HLT while running
> L2.  In fact, supporting Idle HLT is actually a bug fix to some extent.
> If L1 wants to intercept HLT, recalc_intercepts() will enable HLT
> interception in vmcb02 and forward the intercept to L1 as normal.
> 
> But if L1 does not want to intercept HLT, then KVM will run L2 with Idle
> HLT enabled and HLT interception disabled.  If a V_IRQ or V_NMI for L2
> becomes pending and L2 executes HLT, then use of Idle HLT will do the
> right thing, i.e. not #VMEXIT and instead deliver the virtual event.  KVM
> currently doesn't handle this scenario correctly, e.g. doesn't check V_IRQ
> or V_NMI in vmcs02 as part of kvm_vcpu_has_events().
> 
> Do not expose Idle HLT to L1 at this time, as supporting nested Idle HLT is
> more complex than just enumerating the feature, e.g. requires KVM to handle
> the aforementioned scenarios of V_IRQ and V_NMI at the time of exit.
> 
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
> Link: https://bugzilla.kernel.org/attachment.cgi?id=306250
> Link: https://lore.kernel.org/r/20250128124812.7324-3-manali.shukla@amd.com
> [sean: rewrite changelog, drop nested "support"]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/svm.h      |  1 +
>  arch/x86/include/uapi/asm/svm.h |  2 ++
>  arch/x86/kvm/svm/svm.c          | 11 ++++++++---
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index e2fac21471f5..12a9dde1e842 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -116,6 +116,7 @@ enum {
>  	INTERCEPT_INVPCID,
>  	INTERCEPT_MCOMMIT,
>  	INTERCEPT_TLBSYNC,
> +	INTERCEPT_IDLE_HLT = 166,
>  };
>  
>  
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/svm.h
> index 1814b413fd57..ec1321248dac 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -95,6 +95,7 @@
>  #define SVM_EXIT_CR14_WRITE_TRAP		0x09e
>  #define SVM_EXIT_CR15_WRITE_TRAP		0x09f
>  #define SVM_EXIT_INVPCID       0x0a2
> +#define SVM_EXIT_IDLE_HLT      0x0a6
>  #define SVM_EXIT_NPF           0x400
>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI		0x401
>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS	0x402
> @@ -224,6 +225,7 @@
>  	{ SVM_EXIT_CR4_WRITE_TRAP,	"write_cr4_trap" }, \
>  	{ SVM_EXIT_CR8_WRITE_TRAP,	"write_cr8_trap" }, \
>  	{ SVM_EXIT_INVPCID,     "invpcid" }, \
> +	{ SVM_EXIT_IDLE_HLT,     "idle-halt" }, \
>  	{ SVM_EXIT_NPF,         "npf" }, \
>  	{ SVM_EXIT_AVIC_INCOMPLETE_IPI,		"avic_incomplete_ipi" }, \
>  	{ SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_access" }, \
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7640a84e554a..37e83bde8f9f 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1297,8 +1297,12 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>  		svm_set_intercept(svm, INTERCEPT_MWAIT);
>  	}
>  
> -	if (!kvm_hlt_in_guest(vcpu->kvm))
> -		svm_set_intercept(svm, INTERCEPT_HLT);
> +	if (!kvm_hlt_in_guest(vcpu->kvm)) {
> +		if (cpu_feature_enabled(X86_FEATURE_IDLE_HLT))
> +			svm_set_intercept(svm, INTERCEPT_IDLE_HLT);
> +		else
> +			svm_set_intercept(svm, INTERCEPT_HLT);
> +	}
>  
>  	control->iopm_base_pa = iopm_base;
>  	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
> @@ -3342,6 +3346,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[SVM_EXIT_CR4_WRITE_TRAP]		= cr_trap,
>  	[SVM_EXIT_CR8_WRITE_TRAP]		= cr_trap,
>  	[SVM_EXIT_INVPCID]                      = invpcid_interception,
> +	[SVM_EXIT_IDLE_HLT]			= kvm_emulate_halt,
>  	[SVM_EXIT_NPF]				= npf_interception,
>  	[SVM_EXIT_RSM]                          = rsm_interception,
>  	[SVM_EXIT_AVIC_INCOMPLETE_IPI]		= avic_incomplete_ipi_interception,
> @@ -3504,7 +3509,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
>  		return interrupt_window_interception(vcpu);
>  	else if (exit_code == SVM_EXIT_INTR)
>  		return intr_interception(vcpu);
> -	else if (exit_code == SVM_EXIT_HLT)
> +	else if (exit_code == SVM_EXIT_HLT || exit_code == SVM_EXIT_IDLE_HLT)
>  		return kvm_emulate_halt(vcpu);
>  	else if (exit_code == SVM_EXIT_NPF)
>  		return npf_interception(vcpu);
> 
> base-commit: b9cd96a7ff9cc9ddf95de59d69afb174a9e90c6e



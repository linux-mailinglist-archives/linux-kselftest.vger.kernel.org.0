Return-Path: <linux-kselftest+bounces-11204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F28FB37C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1049F1F21CAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441C91465B3;
	Tue,  4 Jun 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eYGNXesJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE21465A7;
	Tue,  4 Jun 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507283; cv=fail; b=o+eY1E+JLrx9FTNaPLHRzmCdfkIOMdgCwglWzssPCjx/hz0Y9KVv7PPeXrrI0IbkZe6HpbO5yYHCukmZohRVH73nLIL30NkC1xfQ4S9yNss//2UOxBd9iInU2dM3yx3kes8S1Bsih0SiMGAL+JIG9d7HVlmoZqKk5U2fX204SMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507283; c=relaxed/simple;
	bh=Pp2nI6cGjhBiwj6mWNAlKdc3lS2feulNukqRYJ8u9tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D37VPR/L8S7aEGyBZdLroUI6wc/nz99z4RxOIk8X0En34rBGdq7gLK+NxLrNheXG9fmfpQOPFokSo90mJQjfBqq4dv7OwhAUENCsvyxaRmLVu8yNFcQwoxG4yLaNUvCqefY0q4/Fr2Jv7K2F24dzT5Modm5RyK9DHi2lAiyDWw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eYGNXesJ; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RofgbhC79ytxqUE/Cv2mias4WYMFrBdQ3HvO23/mEAXS5IjDuggGy3L99jMLIqIzoaT5j0n3jKu2nGk6mcf5BRkozHPRU1b10W9nOdMJBFqAW25SmbqFPCzP4W2gA3T+897TPrlMYkkIvJ9hSks9HNni8L+zcN3nLC9sJYgaSPL1YnmUK95d4faTmA3i7fIG0D9zxp1fS+J2SK5sZVBte+KT+Cs0+GUcCuzJb/yyyW7WSFL20rZ4GqWVtzKJa/19R+qfWGASeFOUtXdePygZjp4L5VCGLMXzQPridorB+/JgK6s4UiWVVifVI8m6GhzzqhI9dfq51epkR+VaG65qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZpNKe+kNbevzk/kZ7FYhhsyUvY3pvUwAKGx/smwNrc=;
 b=Wc2mns5ks9xX/EffiiXSSXXDnQeCKc7vaVo/f4mOBj3LWswdYbqcxAA6Q6BSoS3/Sei6mgnKPMRcZI8QPHhlQmPkpNQBfpHmKChVqeBVvEOWZJnWc29G6EyPC9+Zkx3ic685JnsEOPOQZr9yYixqtIOYCKVU9brCDLnp8WXdbipUsRiNakPycISz1KRgnfxwP3TktaYpt+Jk0qdqshdIik0yzvr/Qu9q3ubiViUp7X/5RpbGHvo5Jf88TuJj9YDacGSs4vjLS6I45U3WByrLM0/bYJKcWOKhtD8o28BrO+CS+FhryFKkm+qycm3hBiOrqDMiGPjuCDVFAdGKjmDtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZpNKe+kNbevzk/kZ7FYhhsyUvY3pvUwAKGx/smwNrc=;
 b=eYGNXesJMgDHsyhARTaEXntP4iqVnOp1peZsDaZly0+quwUsH2zGXIESO6jhXAamM9OOclmAfZRr8xVEeEzgRXmaFJvgqn9tJt74ThRYvgn5lixmhb2rHM7tqw7CvDkVx8OLU09cNrD7arZds8taJ9XV/Synjds1C5J10tHtorU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.28; Tue, 4 Jun 2024 13:21:18 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.7587.035; Tue, 4 Jun 2024
 13:21:18 +0000
Message-ID: <fb7aeac0-ea8c-40f0-969a-c21020b823be@amd.com>
Date: Tue, 4 Jun 2024 18:51:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for the Idle HLT intercept feature
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 nikunj@amd.com, thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 ajones@ventanamicro.com, manali.shukla@amd.com
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <CABgObfbz5kZZObu9dO=KPu8_mZvGmV1752SQzQckkrj5jPaTQg@mail.gmail.com>
 <Zl5kNh8znAYHHYuC@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zl5kNh8znAYHHYuC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::21) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: a868cc81-3b27-4f5c-5c07-08dc849937b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFNWXFLZFZVT0JFTW1kWEM5MkFiL2FaQU53dHZpcjB5aEZmNmFMUzJEN1oy?=
 =?utf-8?B?OVYrRWdSM2hzb2Q3NDNsUzJJRG4vc3NWazlGdnFMbVNWYldiMytZZXViSHlp?=
 =?utf-8?B?SG5mejF6anNRRXFwVUNVYlZDU1lHaTJTS0t2Z1NERSs4a3phN1p3c2RUMkNo?=
 =?utf-8?B?T1R1K0Z1MVZnZkJKVDA3TjhoUk9rT0FpSTRHbzVZczJUZUpMclM3QVRpYXlF?=
 =?utf-8?B?M0ZQb2VTeFZrakdNZWt4M0FuRmNuaUs0RUNwRi82S1pYL1lHWFBUYmVQR1lG?=
 =?utf-8?B?d0FwZlRkbmpkcVRWdU1ucVRiMFNhNWlMc3dicjdSV2xHU2RuK3NiTEhlL3NT?=
 =?utf-8?B?UU5ac0liWHAyUDR1dzRpeUNETUZPU1llak82YkxtdnNRYkZhNXRia2FMak4y?=
 =?utf-8?B?b3FCOTJzUFBZYXkzVklvYWdURkJtOG1ia2F4WE1ScWhDQmc2WjRCY1l0TUww?=
 =?utf-8?B?eWlhRTdYb0I1d1VWR1RLT0dZN0s2bDhscmtISHhKZ2lyempoYTJ1a3hVdG5n?=
 =?utf-8?B?VEpBbC9NYjJldmNuNWloM0wyeU8wQUtieE1Nb0xZV08zMXJsdTkxRVdNbFRZ?=
 =?utf-8?B?N2FUMUs2cmVubVhRMFdrejZQMngxUWRuc0FuYXM0V3lzRGVJNmJ4c1dpV25o?=
 =?utf-8?B?R3ovMHMvbkZKVlRiUkF6Snl5UTdLTjhvZTRpWm9xNlBwVDVVbXkzZU5udnhF?=
 =?utf-8?B?cTZ5ZW9Id1VLNko1bGs2UlJETWVnQThKdmxKbUlPSTl4b08yVzJIdG1NdW9W?=
 =?utf-8?B?eml6MzB2VkpVY3dXVm5DYjRoRzhNOGh5VXFoSDd3VUhzQUxER0F1NnhMRnlM?=
 =?utf-8?B?MkJ5MzZTQ3FFemo3RG9USzdCSTgyOXhlN0p4WWxJcG5JY3VKOHhYTVhhOWZz?=
 =?utf-8?B?L0JHcGxnejRmU2dMdHFpWlBnSzNXdmlab2JFbWxubnJrdWpwbEF0SSsxZTdP?=
 =?utf-8?B?WUtSVzl4bnE3amMzbHM3MFoxWVlza1N3YkIzdGtwNHZBVUNiVFJ3SWU5Y3ZG?=
 =?utf-8?B?S2lNd3BnSVB0aStneUpGNVZ6Q3ZCKzhLYWFxTDZEN2JtUkdNU3RXYlBKeGZ0?=
 =?utf-8?B?Z0FKcXpIcExkaVluVzU1SXExWWtseGZ5QWIyRUVzRXpJdU1YTHBQc0tmbXp5?=
 =?utf-8?B?R00vYUJRQWJ1VCt3LzBlY0kxbFEyL0JmOHpkcjNIcnlRQkZqYXkxYW56LzdU?=
 =?utf-8?B?VmtPY2R3dDE5TkkvZlQyRTA1cUJTSkZGbU9DYVo3a2dvc1ZycWg2UTZqT1M3?=
 =?utf-8?B?SHlqRHBnTW5vRk9tVGlBTTdlQ1RnTWdPZFg2ZzlhRTZVd2hSbkdjSzRZeDQr?=
 =?utf-8?B?VnFzYUd1UHBjQjIrdWFobVRSNVd1NWQra0lLSG9UWDU4eHErcS8vdFRwa3Jk?=
 =?utf-8?B?TXpUd2hUZlRXejhWUHZxRy9JQmM3VmlIbWY2Y2ltVExMV08yN0ZSY2RXaDRj?=
 =?utf-8?B?d0s1WXlWVjlYT21HQXNmV2ZHNXhkd0NObk9IVWpEZ3dJR1pOd094VU1aZklZ?=
 =?utf-8?B?YnJTMGV3cXZTeExxU0lJYXVWdGthZGJFY0doY05Kc0dCZmdQdGcrd0Y3cUly?=
 =?utf-8?B?OHV3Mk5ZdUtwRFErdlpiYk4vRlFVQ0pXZXI1L0kzRzBqd0p2M3FacCtvdzdm?=
 =?utf-8?B?bG5OT3pXeHBFTWRHTCt3V2Zrc3JXOXlXdkNRYjk3N0JwZ0lLaVR6WEFMRTJk?=
 =?utf-8?B?eFNyUklmN3NiYjVGdmlPdUxsTnVHQWhESWhZSDB6SnBnOU5sc1MvYXZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hoZjgwMWhuaXJWWHNYdzI1YXdKeXhUWGE5eEVWTlFtOVJta2ZwOXAwVXd0?=
 =?utf-8?B?WTh2ZENJTXVVN2JnYVphS0pXMmhhL0dxK0hXR0MvMW5zRW1FcVdaQ1VVOHRG?=
 =?utf-8?B?Q0hxVnJST1lXUktDU1d6dFNLcnhJckt0Vjg5MEJkTklrKzljRjFpQWNjZnAv?=
 =?utf-8?B?Qkc5K29YSHJpY0RCMTlac3pzdmd4aUZOMUtHM0poUW9GeDg5dGsrQWl6aDU2?=
 =?utf-8?B?R2ptdW9jcnEyMXZ3WkRDY0RxVll5a3ZmTmZIdU5maHpXaGl1NlhDMWd6MlpL?=
 =?utf-8?B?aVpTZlZhYVVSZS9ncWoxWG0rN1lEd2J0SXlJYWFWZ3ZtK3BwbjRHZmdueE5s?=
 =?utf-8?B?RXNwVUg1Qm94MDh3bXZTWEdmcmZwbXRLU0x2d0JWOUI5cGcrbHBWenRKNkd6?=
 =?utf-8?B?U3Ixd3hxOWwxMUJyTWZwQzBHMzRITGkybmNhZ0RSdHBneHBtNnNIOFVPT2Fs?=
 =?utf-8?B?bm03bGxCbFNYek1UQ2FOaU1BZzZsZ0NCTHRCS2lvRjFzVXVoSHlCYkc0R2Iz?=
 =?utf-8?B?ek8yYWJPblQyeXRBZXNpN2I3TkkxVElEOW53TllTZFNSSGJ0dG1MNVo3b05D?=
 =?utf-8?B?SmlOT0xLQS9lS3NYeGJuOURSWGRrOFAvMEttTGJ2MWhYajBRbENnbUxTcEcx?=
 =?utf-8?B?N0VyUEo0VHhLRnlsdWxVV3BpS255NXlIeFFnSlhMY05pSVlSQklpWGR5MGFH?=
 =?utf-8?B?ZWtJaUxTQXVVNHl5bSt2NnlBV1d5czE1MjhIWWlXRThTQS8xNEZEMkQyWEFi?=
 =?utf-8?B?dHpkQTFlYjFUN2RteG5Za3ZXWDRqNEZMcjh3cHBFajdOWHEyZ01sc0JFbDdW?=
 =?utf-8?B?VjdON0VockZPRmJGbWczZFR4YTN5Y2pSU3ZOZUNDaHVEWlR5cEo4ZTFlWkpU?=
 =?utf-8?B?akJnNGErZG93YXd5QVRXNDRRbVYvVldyMnVxaGpPYTUxbjQzR1ZtSGRnMzRG?=
 =?utf-8?B?OU9NVEhWQWxEeGVxS1R2UVpTT2ZMcG1xN0RWb2Jjc1VSNnRBVnp6VGpUUGFa?=
 =?utf-8?B?akd3TGZLNGlkZURsa1N2cmd5dlJlaTBRSi9FNEN4eWNyeEZNaVc3RksrWG9x?=
 =?utf-8?B?c0xpaVU0NFRtcFpTRmYrM2I0a1JTN3JqTWJ2QktLTjEvdmdjNHJneVRUOGVJ?=
 =?utf-8?B?MmNZUDV4WWhkL0tJNkdReU96UW94QktSZ1dQdVNEYldObkh4cnhUQTRXdGdz?=
 =?utf-8?B?aDZlYnVRZjFISDhudTBkeVlUOCtTSUpCZkVRZ2JCR3NKbzZWZnl5ZWQvMjJt?=
 =?utf-8?B?Mmk1K2dNaE16cGF4WW1IMkNUVkRqc3VqQ2dGR2d0cTAxMGhBTkgzdmxtcDVh?=
 =?utf-8?B?YW5pT0RBZ29vOHlFZ09ZMW1EN0MrdFJqeERnWUpjblQrVy9TMVhTbDA0MmNQ?=
 =?utf-8?B?aVB6Mjg3UnRJMDQ0U1dWa3VsUmFVYmo0TE56bzZoRi91dUx6MFUwWkdDaGNW?=
 =?utf-8?B?ZzNKc0trMGlHY0dqdjZPWlR6SmZBRlhBcitnYkkxcm5oaDBoSXJ1c0ErWWFM?=
 =?utf-8?B?eFJmRVVLRUYyY2J3cmR3a0VoRjZ6QklPUEo1dU5sd3d0ZHgrOUR2ZVN1Vkp5?=
 =?utf-8?B?TUNIcVRzSEQ3c2dEREFDZ2orSy9jR3hsR2FVZGR6eVdGYW1GaEpBSHgwRllk?=
 =?utf-8?B?WmhCTjZTakpPWGhCd01ZNUE5WWxad0o5N0c0Rk5mSnlHYmdHR0NZNzNvVnpV?=
 =?utf-8?B?N2VpQkNPTGNpaVZIRHAyY25DeEdvZkFMalo5b3VjVFQ5YlY3Z3dTRHFKSEdP?=
 =?utf-8?B?TDNQWDNiM1ZKa1F4K0dITmlzRUZEbExLZnAzTXRXM1hUYnpPZ05TUnJTdlJr?=
 =?utf-8?B?S2xBcDBTQVl3V2tNR2Y1UmlOSjVpbXpkYWdiblBtZEo3VGxFRG5BZGZqTVNQ?=
 =?utf-8?B?V3UrS1MzOEMvaFIvb2MwVGhxMlJqYUUyMXd0dlF2Wmd4eDNoNCtuNkMvUjVD?=
 =?utf-8?B?cHNGYVFvM0ZYQ0lXWmVtV05uRytEeGJIVDNZdDFTNWh3K1dDWDltYjhiQ1FH?=
 =?utf-8?B?Q0tXTTJHd0xpQTlnaDB6Ym8rY3dZemhsRDRzQmJnSGxyWHc0NE5GdmVic0tD?=
 =?utf-8?B?Wjd1TWYzRDRhbHh6ZjE0eU9ubzhNbzNhSWFhazZLVWhIcXJsc1ZPMlduRWlr?=
 =?utf-8?Q?3KDTBcLl05rR8j1yhCIs93z06?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a868cc81-3b27-4f5c-5c07-08dc849937b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:21:18.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii4tbviqjfSeNeTNmroXDNnUBbTDR6jyxLCqF6x46z7Ai4/fdR4MoWBWXea+sPkQFfZwr9VTkmT+PFmHaKJ2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397

On 6/4/2024 6:17 AM, Sean Christopherson wrote:
> On Tue, May 28, 2024, Paolo Bonzini wrote:
>> On Tue, May 28, 2024 at 6:19 AM Manali Shukla <manali.shukla@amd.com> wrote:
>>>
>>> The upcoming new Idle HLT Intercept feature allows for the HLT
>>> instruction execution by a vCPU to be intercepted by the hypervisor
>>> only if there are no pending V_INTR and V_NMI events for the vCPU.
>>> When the vCPU is expected to service the pending V_INTR and V_NMI
>>> events, the Idle HLT intercept won’t trigger. The feature allows the
>>> hypervisor to determine if the vCPU is actually idle and reduces
>>> wasteful VMEXITs.
>>
>> Does this have an effect on the number of vmexits for KVM, unless AVIC
>> is enabled? Can you write a testcase for kvm-unit-tests' vmexit.flat
>> that shows an improvement?
>>
>> The reason I am wondering is because KVM does not really use V_INTR
>> injection. The "idle HLT" intercept basically differs from the basic
>> HLT trigger only in how it handles an STI;HLT sequence, as in that
>> case the interrupt can be injected directly and the HLT vmexit is
>> suppressed. But in that circumstance KVM would anyway use a V_INTR
>> intercept to detect the opening of the interrupt injection window (and
>> then the interrupt uses event injection rather than V_INTR). Again,
>> this is only true if AVIC is disabled, but that is the default.
>>
>> So unless I'm wrong in my analysis above, I'm not sure this series,
>> albeit small, is really worth it.
> 
> But aren't we hoping to enable x2AVIC by default sooner than later?

The idle halt intercept feature not only suppresses HLT exit when a V_INTR
event is pending during the execution of halt instruction, but it also
suppresses HLT exit when a V_NMI event is pending during the execution of
halt instruction. This capability will be advantageous in IBS virtualization
and PMC virtualization functionalities, as both rely on VNMI for delivering
virtualized interrupts from IBS and PMC hardware.

> 
>> As things stand, it would be more interesting to enable this for nested VMs,
>> especially Hyper-V which does use V_INTR and V_TPL; even better, _emulating_
>> it on older processors would reduce the L2->L0->L1->L0->L2 path to a
>> less-expensive L2->L0->L2 vmexit.



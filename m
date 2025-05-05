Return-Path: <linux-kselftest+bounces-32459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2BAAB113
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BE14E2FD2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDA28F934;
	Tue,  6 May 2025 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHhteOxL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363ED3EE0FA;
	Mon,  5 May 2025 23:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488210; cv=fail; b=BCuC/mjkVNPcoraGz4Cv+WMi+Qhnup0fnyCMlazRv6rt7zVqI7batFHP0rzbOdjZQ+dErFpJuww9D5ldB+2q/JQFxkjBsL3I+Q1nW7Jsx687dlQQohtKgtCF1waM1sHnmFs4NVIoi1krWaeYfD20RqS53i6I/O2VAH97FeCzv5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488210; c=relaxed/simple;
	bh=MiOdD+tbSgVWZINlFdCqCBaND5BLkV8Rnmg7pIs1gpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SCzrQ1+6VXof8cJRTIbhRFfebiYNyYyWYGK3t+xbBFvr4B1Z603GIEiQ45Ouad6DbMS7P4e60RK4IcvEfFsc7pm2P7dbnbfSmh/tr8UcA3+UZZ//jCqEKJh9LPjNVs4e79nFR2254y5Yq1IAM5M+dmxNfimy8MVPgHDIj/QGIhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHhteOxL; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTgwao6ytNQ1CvDLRz2jE57eWN6zJs3311oYr19EQe+s4DgzvoMyIotyGp6YfP3gV/JYQpg5Ji1GZ9tVCccZKVUpH70OOcNXrQfDYaE9pk+CzOR/qNoKIS7N4uljmykC/9BjyKyMuicQiN418g/vTHlFiUkTV6ovoC+cJUzeEKj3GQvKlcN0FXS+QWWJ4uIhyw/vGhTvhp850LYsO93BzgnVN0Rf8ep5rS5Mu2AR0dZz+FvikgD00WFxYubUXBodt1czG+HYWgJWzGnFBcjxMLiEQ+r9yQd1cfdGJ2MYufv2l8bW0U7zvIzQVZRl8hhYKSwNEnxR8mlKYoU8dnFzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC9f3pZL9XWuSrCqbn4JFiD7ZeaWUWWfBUgFIfpm4AU=;
 b=VLlMvGWEhrZiek/X/PzpUeyOW6Ap/CeKSCt7K25zKj6cVbbDROrjdxbE1qs4d8Qlzu/lKWKBhNw/ukydx97kztaGLzJx9vpKLHnsUXr4SjG54jKjb1xq8317MZsLdL6LAh3Scq2kS/0Ft0uf1BgV0DshbGXLnceHlP+BnGi8cKan35a9p8z2r9zRs6yIPvaIuvARSxAU3R7KEbWEar04rn7wu7WkaBJQrMdHfAxWiPMfWudRJCC/DRng5qxiliD2dZv7rZNe+CmdiPeN878D4dYCXSGT3jHoznL9he+B6vZeqedARsTn9ncVJzZ6h20LBgH3N4Xv699NGNu+6OtOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC9f3pZL9XWuSrCqbn4JFiD7ZeaWUWWfBUgFIfpm4AU=;
 b=kHhteOxL+vR/+BeaAP5GSU1ndJIqKtPbDfxNofnP66R/IXa+iOsy5b/QQ0HWz7Ynoomqs5prE+oMSnziro/6CcsufCRSbmw6sRYyOafm9Au0uSWgMSXZM2ySbDuPgYEerQ/ITwpwQYfijk/lRr4eF2mFm55DDtqPABS6PNKxOI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 23:36:40 +0000
Received: from BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef]) by BL3PR12MB9049.namprd12.prod.outlook.com
 ([fe80::c170:6906:9ef3:ecef%5]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 23:36:40 +0000
Message-ID: <34890707-201a-44f9-afb3-b065ae71b246@amd.com>
Date: Mon, 5 May 2025 18:36:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Basic SEV-SNP Selftests
To: Sean Christopherson <seanjc@google.com>,
 "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
 thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 nikunj@amd.com, pankaj.gupta@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250305230000.231025-1-prsampat@amd.com>
 <174622216534.881262.8086472919667553138.b4-ty@google.com>
 <b1cc7366-bd30-46ee-ac6e-35c2b08ffdb5@amd.com> <aBlGp8i_zzGgKeIl@google.com>
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <aBlGp8i_zzGgKeIl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To BL3PR12MB9049.namprd12.prod.outlook.com
 (2603:10b6:208:3b8::21)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB9049:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 151f7f12-90c1-4b6a-9add-08dd8c2daf8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THhtM3ZwdGtFMktTbDRva3h4MmhTMHpuOEpQUVVWMTJpQ2RMeUUwZkVGT2pK?=
 =?utf-8?B?K0hVUzZTUSt6VU54UjJleWFoMWtwckpQcUg0Y2dPVklqTmtVVVkvVWNNUHhk?=
 =?utf-8?B?c0ZVN0cvMDFsSnIrRWE5NTcwMFNUQWM4Sk1jYkxraU9nQTh0Vjk0MG0xVldP?=
 =?utf-8?B?RGVQY1lhWEJpR1l1akJxZ2JFR0JXVGxNY01Dc0N4UGRNQk1LcXp0NjNYSkdi?=
 =?utf-8?B?Y0kzQ2Nwdy90OVl4WjdJZlZ4RXhrbWtaOEc2SFlSVkVuYnlqdXBKR2w0em5E?=
 =?utf-8?B?L3hXLzhhNlVRTDBJSDRwQ0dkaVA3dUxEVFJrRWVQYXZHMUNlNHFHRU8wVkdB?=
 =?utf-8?B?N2tzTXp0b1hoUU5HVUhFdGJ3RmlqWDVTaTdTdW10QnF4UFZ6R0lIY3BGNnJy?=
 =?utf-8?B?L1UreHNONkFBRURvWDdOaHQyY0prM01xajZFVTRzbHJwUDJWd0N2OTBaNHgx?=
 =?utf-8?B?aDdtVXJLemJ2TnBjQTQ0UnJIaGUzU24vZ0lDdk5JNDAxL0pVY0duLysvVWdQ?=
 =?utf-8?B?MnZEbTVTTHc1Ym9HM25QeDJOK2hJa2lpZU1ReW5FbktOMVpQd1ZUTmgxZStL?=
 =?utf-8?B?ZnBzOVdoMm1FRXR4QXQ3R3Jld2ZwZ2VLUndJODM0em0yaUV6eDdKaDViaFYz?=
 =?utf-8?B?Zkd1NTVkRkYrME5rOFZZZitGZnAvU1cyMUNjN1Z6TkxYVTlGQmpkVGJ5MjYx?=
 =?utf-8?B?czUwY2xoV201K3dsOFBuT3doVGhvZnM4N0VlYW1BeFhYU1NQNUpvUE92NExZ?=
 =?utf-8?B?S0kwbnVlay9wYnYvYkk3TTRNbjVidUg5V1JnWFpmYzdKWG5GRGJtWHY5MkZT?=
 =?utf-8?B?SmRydStZdkZhdStaQnZzbnN2QUthc1FxZmtLcUttQ0dGV1FyMFB4NTR6MWp4?=
 =?utf-8?B?eDRycXg3bS9mYlFuZlRSczhTSXFacXczNXRjRTNrUEFpbmEzQnR2d0VRRUd0?=
 =?utf-8?B?KzRESFRocXNPMHZuWmwrdGVrZS9td3JxeWVoK3ZMdGVWNkpId3dnNHIyWnc4?=
 =?utf-8?B?bUY4UWpIbkVaYWFoOTF2VFRNWFNzUU5yaVA5N2cydUNPakxvZXFhZ2U4V2xX?=
 =?utf-8?B?UTZNdkFmbE9jSDdZMmxGME1qRCtsVUQwS2RJdDBPamQwd0YxTmY2WnJSdWdx?=
 =?utf-8?B?c2x1eER3Tm1ZZ2NUb1UvcjFOREpPeVJEU2tkTVVrbkxLL3JCSzBwL3kyaGhD?=
 =?utf-8?B?VXIxWVdLNmgzWkc4eWJWenZuQ2FrdUhnUE9udW5jQmxJYXBTK3lpYTc1MHdR?=
 =?utf-8?B?R0RGSlRVUVBKQ0VOOEJJcUl3VUtOYjcybzFTUXpGR1MrNUZxZEw1Wks4b2tr?=
 =?utf-8?B?OGZveExwcG9Jdm80TGlCNUNOTFBaenEyTHliSE85ZGJXUVl1TXZhRFB4N2dK?=
 =?utf-8?B?SEJqY3BMcGQzV1hoNU93QXlhVVJCN3gxcEFXaS9xcjRSckQrR1J4TnFFcU9o?=
 =?utf-8?B?T2lmOUllSUIycEpOL0hFQlNncFNSdHNudjRGNW5lSElLV1ZKMFNrbnBValYr?=
 =?utf-8?B?NitVOGUxQVAwNWlVUWo3OFNJejVvWTk1dy9EZGF4OEoyY0dVWUgrZHFIR1lC?=
 =?utf-8?B?VjVjM1krcXdxcXhpbnJYRDhONWlLWDdxZ3lnc3pOWkN4LzdGVEsrdUR2d1B2?=
 =?utf-8?B?ejNWa1hQYzZPR1BBOXF6MGcxU0lUaDhDelAvc055SnloSytaeW5oYytOekw2?=
 =?utf-8?B?WnZ6UlNRZGRDL1ViS29zQ0FoVFpsUWROa1NxbjBtLzFvUHh5a045dDNYQnp5?=
 =?utf-8?B?WkM3c2NWT2NKeDl2ZndsSXhNSkxjZ3dqdmwwUElIZ0Vvd3cvaVMxTy80K1Zm?=
 =?utf-8?B?Z01MWHFnWlBzR3FOREt0bC9zcUZkRzBmaVdITzU1RjVkdUVuUzM4OUFWOUNK?=
 =?utf-8?B?TUR4M2R3WXI3NGZLWFpWS2dyWnFCcjNmQkRFYWdScHgvMDR2Mk9XbHpWRy9F?=
 =?utf-8?Q?hHOGExi872o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB9049.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEVjcGprR2NtYWplc2hnV1k2MFZKK09OMm1aN0Rzcmx1ZHV4TUhCMXNIOXVx?=
 =?utf-8?B?VUhZMHJ1dEZVbmtXTjRSbUt4NFpwK2NsWlg1SXFhckMrZG5aVnVTRUFOM0RG?=
 =?utf-8?B?dzhZbmQ5Wkc5Q3VNaFpDMDlPN0lDS0M2eGs0dW5zTm5vRElYYVcxVTBaUitN?=
 =?utf-8?B?NDZaVkZLbU9qM1psNlRwZ0tMUmtQdUVSZHpRSFMwS0ZrbTV1bnVXbjYyTGwy?=
 =?utf-8?B?SUZydWxCcDVFZWVrRXYvcVY5ZERzMGMwMVdLVUJoRDB0NHBXOVpoaG1iMllU?=
 =?utf-8?B?NFp4VDJUekJqSTVjWFZBNitOT3NtT2xsYi9qT09LK3EwcjFVM2JWcWR2UXEr?=
 =?utf-8?B?QUdleTNsYk4vdm16dHFRRlo1NENJNjRDSXVNNklSVnllelRMRUtFOC91a3Jm?=
 =?utf-8?B?WTVwWWdDc2dwSnJlMTZuU0NHTHhGTmgvSW9lR2dPeUZQU1dGM29HNU8wamVj?=
 =?utf-8?B?dlovcUF5Wm90OEY1WlhXcVdvZ3FpT2QzSWNZVW9rTXhOc2dJQ3BuR3B1YlFE?=
 =?utf-8?B?czc5b2pQbWduakhMRHdPYm5KbklYUkNaWTRURy9JbDFkVDVaSy9BR210VDdE?=
 =?utf-8?B?VVBLbDQ1YVkvZE5RdEhGczA3NndxcGhKaFZuTHRXYjFJSkRXQ2pCR0lZSlh0?=
 =?utf-8?B?MU5nSGtNY0QyYnFwNC9Qb2FORlRuMTNKdUhSZXZXNTJhTG1tTGY0bVBiUGJj?=
 =?utf-8?B?OExYeUhONnorL0xCR1ZaK2JSajcxWFFmdFdLZkxYVS9JZ0ZSaXV5bVBoQ1E3?=
 =?utf-8?B?Njc1SWhuUjBKOGRwWnhtZ0U2ZlZyc2c5ZlFYVk1sY3VyT2pNT054aG1rZ2Jn?=
 =?utf-8?B?MGRXQkw1M0o1dVlaMjdkRWJabXkrSjBBOVBvWVBDVDU5VDdQckMrTDFQMnp5?=
 =?utf-8?B?Uzc0MWNOQVIxQWdOUDZMNnMyRWJ0cnVmb2lKTUN6V3k1MUxFU3RyNzFJMjlP?=
 =?utf-8?B?ZUV5VWkybi9vdGdaU01ZejMxaGxXUm5iWWt1SU9IM0JGM05NOWpFMkM4bHVG?=
 =?utf-8?B?d2hLY1FLdURTRVdRL2NxMTBkK2xEK2g3MGhHQldhKzRMc3pUbGFyNFk3QzlY?=
 =?utf-8?B?Q2tvcU5FUzdxN0tLZXc5T2ZYbFVpaDE4ZmFSN0dudTZKNlVhRlc4VmdPYzEy?=
 =?utf-8?B?Q3gwZllsRXY5cVIrWExBeWVwS1YrOVQ2aFVxZUNJSTZoNDdhQmQyb2JVNmo4?=
 =?utf-8?B?VXI5ZEFQajF3TlB4OFl5SnJRRDlGMDZGVVVOd00rV2EyMDFpTHVtOVhJWVQr?=
 =?utf-8?B?MUt1VzEwemptTUJQaVRsdlNYSWI0b0l1WEJQWng2aXNCTzZWbWJDUk9WUE5a?=
 =?utf-8?B?OXVVY3VNR213cFR4U3BoT2hSd1RmSUNXbzJNTEFWM0dnTnlyRWdFMFZXQ0ZZ?=
 =?utf-8?B?VlF4cFlhcURUTGlTZnNSSVorRzdQWnVEVTNKM1p0eVp3Q3Y2cW9LU0RIYytY?=
 =?utf-8?B?NitONjJKVmk3c3Q1aGQvN0J0WGVDeEt0TldySG4rdzM1YVlWRFpnOHNXeXFo?=
 =?utf-8?B?TUh2WThGb3ZSYnJ6Kzg1RDhuVjI2QVV5NUFVZFgzZmlCd1czZWoxcFZ4S01M?=
 =?utf-8?B?YjVkUk9PSnoycHFJTGh6bEFXOGlRenZCWlRTVE5iT1JyQnBJeWs1RGM2WGU4?=
 =?utf-8?B?M0ZJMTA5d2xtalJVNVkza3pGRzhWSTZscTYrK3JWNTlTMHFDWFdRelRjak1J?=
 =?utf-8?B?NTBzdmtJVHpKSUtJdXhNbFZ4aDRJR2ExekFHVTNhV05wL0Q2NUQ2Y0lPZVk3?=
 =?utf-8?B?dFVQNVNmbDJkWUZOU25xZlhMcjZJMG5oaTdoYW5yRng4VnVjTXBLYW9LaUVv?=
 =?utf-8?B?OFhNaGNnR281SEFzeEpQUWZPdDgrcWlObTQyUHBjYVhwR0FYUGppRVpmVU1P?=
 =?utf-8?B?emQrY3llcWlOWGFPUUJaVlUwRWU1VWV5T1JiMVcxdWR2aFYyUHQ5aHdBYjQy?=
 =?utf-8?B?SkVGcDNtNW5CMXVDWGpITzF4WWw1Y2xESmZDRlpIMHFYS1gvMy9KbnN3M3pZ?=
 =?utf-8?B?a3EwbWdRVDRsTThGTVg0UXU1enpMNmtZanM3OWFBTHhGd1pJNFpKR2Uwb1lV?=
 =?utf-8?B?Mk9aaVZ3VjVhOWZYZHpFQmZJM1RsOXZqYlRnSzUyRWZFczlGVFpRaHgyV3VH?=
 =?utf-8?Q?laalSBcdsOGrRfAMONq1hWGyr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151f7f12-90c1-4b6a-9add-08dd8c2daf8c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB9049.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 23:36:40.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOMjD4nF+pAQGN75qzOHab+64gMpeLafZlcztXnYh8Vd/pdDBiY0ds5jVEV6ajQSl5TYVWmoTen3957tCZ+FvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

Hello Sean,

On 5/5/2025 6:15 PM, Sean Christopherson wrote:
> On Mon, May 05, 2025, Pratik R. Sampat wrote:
>> Hi Sean,
>>
>> On 5/2/25 4:50 PM, Sean Christopherson wrote:
>>> On Wed, 05 Mar 2025 16:59:50 -0600, Pratik R. Sampat wrote:
>>>> This patch series extends the sev_init2 and the sev_smoke test to
>>>> exercise the SEV-SNP VM launch workflow.
>>>>
>>>> Primarily, it introduces the architectural defines, its support in the
>>>> SEV library and extends the tests to interact with the SEV-SNP ioctl()
>>>> wrappers.
>>>>
>>>> [...]
>>>
>>> Applied 2-9 to kvm-x86 selftests.  AIUI, the KVM side of things should already
>>> be fixed.  If KVM isn't fixed, I want to take that discussion/patch to a
>>> separate thread.
>>>
>>
>> Thanks for pulling these patches in.
>>
>> For 1 - Ashish's commit now returns failure for this case [1].
>> Although, it appears that the return code isn't checked within
>> sev_platform_init()[2], so it shouldn't change existing behavior. In the
>> kselftest case, if platform init fails, the selftest will also fail — just as
>> it does currently too.
> 
> Argh, now I remember the issue.  But _sev_platform_init_locked() returns '0' if
> psp_init_on_probe is true, and I don't see how deferring __sev_snp_init_locked()
> will magically make it succeed the second time around.
> 
> So shouldn't the KVM code be this?
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index e0f446922a6e..dd04f979357d 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3038,6 +3038,14 @@ void __init sev_hardware_setup(void)
>         sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +       if (sev_enabled) {
> +               init_args.probe = true;
> +               if (sev_platform_init(&init_args))
> +                       sev_supported = sev_es_supported = sev_snp_supported = false;
> +               else
> +                       sev_snp_supported &= sev_is_snp_initialized();
> +       }
> +
>         if (boot_cpu_has(X86_FEATURE_SEV))
>                 pr_info("SEV %s (ASIDs %u - %u)\n",
>                         sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3067,12 +3075,6 @@ void __init sev_hardware_setup(void)
>  
>         if (!sev_enabled)
>                 return;
> -
> -       /*
> -        * Do both SNP and SEV initialization at KVM module load.
> -        */
> -       init_args.probe = true;
> -       sev_platform_init(&init_args);
>  }
>  
>  void sev_hardware_unsetup(void)
> --
> 
> Ashish, what am I missing?
> 

As far as setting sev*_enabled is concerned, i believe they are more specific to SNP/SEV/SEV-ES being enabled in the system,
which is separate from SEV_INIT/SNP_INIT (SNP_INIT success indicates that RMP been initialized, SNP has to be already enabled via 
MSR_SYSCFG before SNP_INIT is called), though SEV_INIT/SNP_INIT may fail but SEV/SNP support will still be enabled on the
system.

Additionally as SEV_INIT/SNP_INIT during sev_platform_init() have failed, so any SEV/SEV-ES/SNP VM launch will fail
as the firmware will return invalid platform state as INITs have failed.
 
From my understanding, sev*_enabled indicates the user support to enable/disable support for SEV/SEV-ES/SEV-SNP, 
as the sev*_enabled are the KVM module parameters, while sev*_supported indicates if platform has that support enabled.

And before the SEV/SNP init support was moved to KVM from CCP module, doing SEV/SNP INIT could fail but that still
had KVM detecting SEV/SNP support enabled, so this moving SEV/SNP init stuff to KVM module from CCP driver is
consistent with the previous behavior.
 
Thanks,
Ashish

>> Regardless of what we decide on what the right behavior is, fail vs skip (I
>> don't mind the former) we can certainly do that over new patches rebased over
>> the new series.
> 
> FAIL, for sure.  Unless someone else pipes up with a good reason why they need
> to defer INIT_EX, that's Google's problem to solve.



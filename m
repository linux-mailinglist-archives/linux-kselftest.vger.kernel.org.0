Return-Path: <linux-kselftest+bounces-24406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5459A0C26B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 21:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966AF1887960
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250531CBE96;
	Mon, 13 Jan 2025 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RJrsKrRr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EAC1CB31D;
	Mon, 13 Jan 2025 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799026; cv=fail; b=Jjv3kyhxi27HMgvC7mw/GULEsgKaOgUvt3NH797ggdAlJOSI/XgB0nPLEc3dOc/9MH5nRdLCCk7dAwvpoyf25gEYq/g+b+OgTl1jM7XK2LvHkPBcC7oWtn+2d4GMrmEeGyyERKT1By92Tt2EnPB1K8vrVs66pVHDBqdz02QPh24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799026; c=relaxed/simple;
	bh=TIE2xHHkDkqURf+SxIaVUtK+uCG7+fiZrlfoAJA2JF0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=atU41gfODYmvcX0+/gfo4eo9MRCiRQNpg0pA31Tao43BxCu9sVFvVCRPVWYoqxxaduulGctT5Tt9PHUjPdf/SkibHKAgZ9zRVo/31yCvAqCbSww8yAhLh1smKd7bC1Qly/jxO5hPFeVRVjr+yGrgQ3OhCRnCcWXFJptQ0A55YOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RJrsKrRr; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1sIAywpADqQNJFDAanAGCUwk/lZzf8PDuYiceIsl1pA/Rg3L65BUxlGUDMC7K4vl8WhzbIKyqa5/DpGLiTqGPKlk1i7PmtA1dF4zOTvR1dUfkl5+9nMpWcRBjF4SfCp4dRj2lM7GGUGiDV8D9PpEMRmyikslrLTmiQEzooo3rgfcgRr+YgBYy8GBsr387sLyKVjXRIXQHAc2A4TajvJ/kw7P5MgYCj15uzcjSF/ogywke/fyw7IRY+NWN3wjOpTphWmSdgom9tfzHVacM822uCli+wRuo7eaoEj3p4yVgcIDRKJNRWtdkxJ3XmMMiumsvioTR/cTi9OqaDTOpdTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD8l5DjS16ik3QxI2dDxwulQM89xzzmsgiQLhDKMHDI=;
 b=J1Ibx5yek+H3qNdKodtOD+6zwGEkccz5oFYwv6sYf/jcnhO+2iGMJypNm6quTsPJDucLtlZWrKMdofVWz5EDOJ2WKAbMyZ65ucv0LEskemht9QjEQVx+eMMWOuxn1VUDfVJsvl5nMRqHTBxzfO+vXlWHeGdCgzVAXb4SV213CXlmzoVVHz+FRJl15RHnIDYdNxr4DprwHfEobKUsPZP+ZIAsdFf+nV0cUBaHUtruQd4N5eHaIGBZ3t0OKnFEnPDImYEpKkCqOYCdeYGYkyyc+YGMLOAjcrL1gcQ71udEs+Z/Zgqde0NRInwpG2hxGRwMbIz4bIb5XD3hdonaH3/arA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD8l5DjS16ik3QxI2dDxwulQM89xzzmsgiQLhDKMHDI=;
 b=RJrsKrRryayzEQI1bvj1vDI7Kz6LhKfcX+iAdQRYJvv9TSe/ee22WnrlgO7EBunGx1zOhyt1U6KYn8xCoElskrzsbf/l0WeMR2a1gvNpBFiLH6id1PNiKhSp/oiCMwumvt7QS4Bd+WTG9zRjQPvL1fgUYiBVUgUWJxjMRoyqe0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:10:20 +0000
Received: from MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda]) by MW6PR12MB7087.namprd12.prod.outlook.com
 ([fe80::41ae:52ce:aaf4:eda%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 20:10:20 +0000
Message-ID: <5e3e9d9f-fa14-4744-9067-c93a210eb5f2@amd.com>
Date: Mon, 13 Jan 2025 14:10:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] KVM: selftests: Add library support for
 interacting with SNP
To: "Nikunj A. Dadhania" <nikunj@amd.com>,
 "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-6-pratikrajesh.sampat@amd.com>
 <a5aa635d-b03a-4e77-aa6a-032886d1bc56@amd.com>
Content-Language: en-US
From: Pratik Rajesh Sampat <prsampat@amd.com>
In-Reply-To: <a5aa635d-b03a-4e77-aa6a-032886d1bc56@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:806:20::18) To MW6PR12MB7087.namprd12.prod.outlook.com
 (2603:10b6:303:238::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7087:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4c1d74-f805-4dae-1e73-08dd340e4de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjlkM3hsb3lGV3JRSWpWMTZ5YzdicS9vWENWQmtrS3ZkZTg2a3lMS0o1NFpl?=
 =?utf-8?B?QndRb0ZYZ3A1Y0lJRjFyRFA5SDI5TWlrTVE3QXo1KzRCZHZQR2tjN1FuK1cx?=
 =?utf-8?B?Z1pXS1JBUEtmenEvbXBNSHZUS0MzMUE0c3hva2QxUEpUNS9sbTlJclFrWlNj?=
 =?utf-8?B?R1REYU9lNHZPUTE1TWZ4dXFGOEJjdnlWeEJxRzB0cmdmaXNuWTRFWHJxYy9W?=
 =?utf-8?B?N3VYdXoyMzJqZUtIbEo1UGhGZ0w3QmFEMTIzSjhueUlQOWc1c3NGOUE3Umdy?=
 =?utf-8?B?SlBPbHMzcWh4R1dCalZBQ0hmL0hWd2RLWm5FOVFrdURlV0hzcWpJOXg1ZUZx?=
 =?utf-8?B?dUJUeDhnQ3cwY1hoY2dYaTVwRFZ5SGJ1amFERDJFM1lDWTBUWWh1ZUhEWDgy?=
 =?utf-8?B?OVorNXZkU0JyZ2wzelFJVGJzWDBXSUx0WW93UEJqSHdoaVBLY0U4NEdRQkhF?=
 =?utf-8?B?Si9jcWJJL0dEMnZVcUthUk5BZnFLbWVPQk1VaXZaZTNLd2xGMHdSZUlmalZV?=
 =?utf-8?B?VW5wamxiS3pSUzU3ZCtvdGVia3F1SWxZRk9DTmZVYnR1MWVLbW1ZUVR1QWVQ?=
 =?utf-8?B?VERmT1hmZ3U5NlRIVmdzbXZJb0Q4eTlQK3B3bDhjcW9zbTROU0dtSS9tUmgz?=
 =?utf-8?B?NGxHanVhZzd1b2l0amluMXRBandCZ01xdWxTQWpLNForMUhOUE0rTjRueTd0?=
 =?utf-8?B?UXBROGFRai8zUVNCSEhnUG5wa1dkWENpMS94S0hhVWJocW5Kb0xrOWFuYkMy?=
 =?utf-8?B?ZXNrNzJTTzB1SXFtRnA2NlAwZkJuajZXSndSelpKOXNEWDZGeURWSmYwQmpD?=
 =?utf-8?B?dEh5ZHVhTWtobnpZYkRHQ2VqNUZ3WEpmazM3NENySHM2RlJ0eGkzM3VScjQ2?=
 =?utf-8?B?UTNaNmFDUURJTmZmd1ExdHhpMXU4R3hETy9IWmpRR3pMbWc0a2phOVFQUDhZ?=
 =?utf-8?B?TDdBMWNoM0ZmWFhQSlhiUko1blNURGF5Tzc4OVJFTnJCUHNWN0FWZHZWR2RP?=
 =?utf-8?B?dUMyMGZzcVJYWlFyME9pd1FMbW0vVUV2NDJRVjNOVTVvRCtBQnRjalZ2SDNO?=
 =?utf-8?B?b0dIVXVBa0xGTm0yTm5Cby9CdUdQMUMzZXBiMkpBMEwrZlh5UWpDaUVZc1hr?=
 =?utf-8?B?SzI3Y2lWSjJZeVdObWgyK1YwdDRNVmtjMUc4SFpHQnhHMFlVZHd6MkFkdUNR?=
 =?utf-8?B?SmdXcytvejhOcW10N3RsTHNlRjdUUHhmTjZ3cnBRSkVzSS9GSTR1eElPLysy?=
 =?utf-8?B?MnZRNnFJbllNc2g5TDhURG1pdVNBWC9JVDZiTnpjdWgvVUpYa1krdUpyb1Jy?=
 =?utf-8?B?aVgzVks3TmthSUIzT3VTeHE1eTU4S09BTVZtd3diQjd0SHA0OERmNks3azdE?=
 =?utf-8?B?S3M2ZEE2Qi9HQmErRExFQWpCM09CaS9ZZGgwYTY1RVNCZUtKeGRKQWFsSFFx?=
 =?utf-8?B?UlBjSkt0Y0ZvS0FjLzZmVE9ZbGVDVzlveVpSRUg5ZloyVjJTYXl5R0l2Vkc4?=
 =?utf-8?B?Nm1kTmQ0Q2ZDdGswc1BCSHBzV2YzeG1SaXRpeU1GWWlLbURWaE83U2p2amZQ?=
 =?utf-8?B?M2MraXhYRmc5eTNzdlBmM0NWbjlpdS93UExGdjZ6NG1jVkl0U0FFVkk5UWNZ?=
 =?utf-8?B?Ujd6TkI3N0RqZHU1ekp2TjVldHZOZW1oTCtNdmgrN1V4aXdYUENRa2RqeXNR?=
 =?utf-8?B?M2gwY1RVN2l5TTNOTkJxU1BIV1RQYmt6cFI2Nk5POHhKeTJiYkd1dTV1QUZ2?=
 =?utf-8?B?cE50eERKZjZxRjI4UzFTUWZWTnhaanUybThRcUJKd093TmZKN2RwSHJoRGtX?=
 =?utf-8?B?OG0rUTlhWENHUnhhQUE2UkRJdVNkVUpWS0N6T1pucG14ZmNtb2g4a2dwdFpn?=
 =?utf-8?Q?pZ0xRHdAOs+qj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7087.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmZEb0poRUhtOXI5RmxETHJhb3B1aEpKOVRVQmROdisxcnBFM0V3TlFnUkl4?=
 =?utf-8?B?eFEyWmlHcTF0ZExTMlFJaDhGdzdTb1FMVXdaNjNmRXY5eHlDeWpPSlZJSEMz?=
 =?utf-8?B?QTBneDNSbmJENjFTN1FUQ29nVi9EOTF3Y3RNaHgyWVdvc0RWZWZNZGZ3VDdY?=
 =?utf-8?B?cmdSYnZEdFRLQ2ZYSEY2UEt3N3liYUZ5RVllSHZEVUNubUpndnc0Y1VZSG9U?=
 =?utf-8?B?SUQrQVBFangrLzZpUDRmWVR3L1dVMWhicnJKQkJpQXdEeHZMcDdFY0J0YzhD?=
 =?utf-8?B?azAvSEVWZER3a1o2SHVMR0RXem1ZTDliVTB4RHJUTWkrVEVHTTBRVFUvNjNU?=
 =?utf-8?B?bThnMVN6OGNycEZUcytNRFAxZEs2SGw5QWs2Qzk2NXYvSEZqNlRaQThJOXE5?=
 =?utf-8?B?QUQwcThpWVZiQ3p5a1ViMFg1c05HdWhwS3pRYlVUK1lsTWM0bjM4ZFR0Q3lj?=
 =?utf-8?B?MldKcW9yVVZYVURQVC9uWDNreFlYcGMwdUd3S1dvajFFRllaaStyVzhDNE1Q?=
 =?utf-8?B?YytaRzVwcWdtdjV0dkRIc3RBMUJuSS9CSHJFYi9EeFRndUZrQWVYVW92T21x?=
 =?utf-8?B?YWpHMUNBOVN4YmoxdGh5cUxCekpucm9GcHAzQWdvMEs2NXNqSzQwL0pZd2ly?=
 =?utf-8?B?MjhPbUh3SktRVWpmeWdaVmNac0llQmJFQUFwd0xYK1NYZ0xQaitXellwaFJM?=
 =?utf-8?B?WHk4L2hqMnJrdHZwOFowSnVHVXpMaUZIOXlWU2RTVzFlZUNsQytFVEdCUFJD?=
 =?utf-8?B?NUN4VzRGM3BKSDBCeUdIMjgzdkhRTFk5L0YwYkdaYmFNK0NnY0F4L3ArQ25V?=
 =?utf-8?B?N2ZGOTREZUdRRGh1bGRWMEJScjNLNU1mY25jVXJvN0VoSlpHR1pDR0hRWm01?=
 =?utf-8?B?QWJmeTJNSDh1QWN5QlZTNFAxTzBLRFNtdXBrRE9BOUxIUko4MU5jaFhCU2Jt?=
 =?utf-8?B?ejhCb25FelVZclFXQ1pvY3QrOFZrb1laR3JOd3czVncyZSs4UDBIMzIxYXV2?=
 =?utf-8?B?Uklra2Zsay9YL1hQYlIvb0pEMDBQYmpUVldlSE1hc1psenYxdWZVc2JKMzRG?=
 =?utf-8?B?WGtNRDBjTkFvU0tuR2dMNEhodXZEZlByOHRHcUI0c2JJc0w5YTRBMjhLeDEw?=
 =?utf-8?B?WXgwQW95N2RvQkFlRC9IQlIxaGRkWWtidlRucHFDNzlSbjlJanNXZHUrZ0NB?=
 =?utf-8?B?VWZsVFBUUmtKanNKZDhRK3dKUEl1dkIrODJMUkFGbkV5UEp1WE5ueHp6NjBK?=
 =?utf-8?B?RW1WRWI1OGxNd1J5TEdPdTRwaU5odDlTV09xZkduTGJPbm5Bb3VER0pnalZu?=
 =?utf-8?B?cFgzVXdDeFBDMUtXKzdFNUdvUnlvYzJybkZDZ3l3WFFaRC8vd2ZRL21IRHg4?=
 =?utf-8?B?dXMvZUNrRllvTWhVd2pJeXRtakgyMUtxNUQzN0V3a0JmSWhBS21SVW1NUmJs?=
 =?utf-8?B?Tlk2UElSdUNFWGlKVk1ZQkd0YVlpRk9uSUUyeFYyS3RSMEprYnNoTUxJMWtQ?=
 =?utf-8?B?NWIyZkVvRVpOUnFsTnlNZXhSNWJPSVVpYWYwZVUrcUJEaEJ4ejh5ZjZ3NkRy?=
 =?utf-8?B?MXViUGNYN1VGaWEyaVgwcFVsVDhXOFlZZ2dKVldHcDFieWJ6YTY4dHhzeVRE?=
 =?utf-8?B?Tk1PMW5BUzJwV1RnbFZQb25rajlsbk44cXR3cnFBdGZCeXJQejMwd3FiVzZC?=
 =?utf-8?B?MCttclRoQ0RsL3o4c0tnY2p1ZXBpcmZXaTdudU9wQkYvNld2MVphNFZUdWU5?=
 =?utf-8?B?bU1tK2lDUHY0OG81QTBPMnE5K1VpY0wvNzRSMjZRRzQ2c2VMLytublRmS0Vz?=
 =?utf-8?B?eTAwMVJLQVhxVjFSUWh6RWRIcmhhWUsyczBFc1hrL3Bvc3ZScjBNSlNmdmRj?=
 =?utf-8?B?T3RjY0Jra0Q2a0FpdTRET0pVRHIrZktsVGN0VmRzcGF0NncxQ3ZpYVhWNzZp?=
 =?utf-8?B?cC81cGVFZjJSVC9tR2Y3ZEt6Z3RLam1VTGhmdk03bHBsZ1BXaTJSaGhTWnI0?=
 =?utf-8?B?Vno1OEZ0UGVVNXFKK21taXNUdUdtcGQ3R1RpdmxiV2plaWRRcWthUUtWamdH?=
 =?utf-8?B?cFcvY0NGbXQ5QVNJUmFqRmRGQmxLZi9BMDZtcVFZVkFzRXVFWmp2YVUyVzg0?=
 =?utf-8?Q?3DhUEWU+Ip0lqPcRlA18xViKa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4c1d74-f805-4dae-1e73-08dd340e4de1
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7087.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:10:19.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uPGmAtjGp3C0cZk7vKhykARgnQq4FRSqEaEWAxRbprN73wAZwYU3hwCo3rAVspLw6ECjp4HAwJZZcUUftGlXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300



On 1/13/25 2:32 AM, Nikunj A. Dadhania wrote:
> 
> 
> On 11/15/2024 5:11 AM, Pratik R. Sampat wrote:
>> Extend the SEV library to include support for SNP ioctl() wrappers,
>> which aid in launching and interacting with a SEV-SNP guest.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
>> ---
>>  .../selftests/kvm/include/x86_64/sev.h        | 49 ++++++++++-
>>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 81 ++++++++++++++++++-
>>  2 files changed, 125 insertions(+), 5 deletions(-)
> 
> 
>> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> index d6e7a422b69d..40b90d3a5769 100644
>> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
>> @@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
>>   * and find the first range, but that's correct because the condition
>>   * expression would cause us to quit the loop.
>>   */
>> -static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
>> +static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
>> +			   uint8_t page_type)
>>  {
>>  	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
>>  	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
>> @@ -41,16 +42,39 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
>>  	if (!sparsebit_any_set(protected_phy_pages))
>>  		return;
>>  
>> -	sev_register_encrypted_memory(vm, region);
>> +	if (!is_sev_snp_vm(vm))
>> +		sev_register_encrypted_memory(vm, region);
>>  
>>  	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
>>  		const uint64_t size = (j - i + 1) * vm->page_size;
>>  		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
>>  
>> +		if (is_sev_snp_vm(vm)) {
>> +			snp_launch_update_data(vm, gpa_base + offset,
>> +					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
>> +					       size, page_type);
>> +			continue;
>> +		}
>> +
> 
> Instead of using continue, if/else is the better code flow:
> 
> 	if (is_sev_snp_vm(vm))
> 		snp_launch_update_data(vm, gpa_base + offset,
> 				       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
> 				       size, page_type);
> 	else 
>   		sev_launch_update_data(vm, gpa_base + offset, size);
> 
> Right?

Sure, I can change that. That's definitely cleaner.

Thanks!
Pratik


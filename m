Return-Path: <linux-kselftest+bounces-21458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA719BD0D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92CB91C228D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD79E126C03;
	Tue,  5 Nov 2024 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bpjM3R38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE38770FE;
	Tue,  5 Nov 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821336; cv=fail; b=trmGIMRz4qmmumhOX/pGkogHyHwKEIqetmNWfXjM5pC1TY2rJlbwHPLO/1vgAUnhNwgoXPeWhH1OmE8GUWhq3Hn2uolCUhojLcw60hiRvOT+wg8Q9WWd12djd8P+6VZ13c93n421AaBmjDRD9pwpYu78Cxtd27gYw+gXHWnhSKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821336; c=relaxed/simple;
	bh=9jdEj8AmdOflDOvQC2M2RlSELReyQ7fDHI+795CFYfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gkY2CwuYbIiqHRqWa4fmPuSmZD0G9UNTQMtIo0VDeUckIzWK9ClGI9Cv8aKTnH8xVNWdmaH80jcDBSUeDG2tmO+Wg3tKiTaT/GciCVvnKlW7jr8SRFiYCdbqC6g3GR4CfXqXebWM+xMKCwrtnl8IPQ8DQfXiQXZlBzR7eO4imJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bpjM3R38; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nyxj95A2Kq8L8LGDgvHXCqg8aydbRVzaygLT8pL6Wpaq2shOKAKsHOAAuhTcwfDQx6RdakBV6QvZfpz0S844BWK1cffv5n4ONjKWc5NWImWE5W37Axkf1YSOqcyKEux3ZY9YnRGzf6jAXT9BZRHfHrl5Yz/tqykBJeIfNc8yR3D0PGKeKPjAfO0ybSTfP+cLp3VqzHrOtuaox7VRYCgwxo+5FKhOYJWeqoYn9WK+EuZlIyJEozCOqpRPEsnMVoXeM+BrazItPYjKR4n6PbIcwCZD7mpnBUmVuGJCb0/lkNzQEDKne5a1TqiT32PR/hY0qzojp7vXcjNkw6TBiJjz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWLf9Dk73E/GDrbdUNFMB7/nZ2pI7LnBcXcFKGyHpoY=;
 b=gdvRatuNPcVWARa2+VO2/qgdO/18AZ0i4Ns7vuZfgW/28atxx74t5qpCvP42dNLCJ8cWv4Bnpvj2TulsU9KrdASkOqutHh+3+pxwY6MeTrn4cGiigAVvl3vCMuGrJeUSinislImxV6HJaWaGwEarXzwMRUa26KTGel1XMBvbij2orUBxVKg8kyMAwNP1lHG/IGA0hWxqEDIYznxRgHBbsUL/06zGjljo4/C0qHc/w7JdHPawusB+QcuINF6q7nm7cGIaiLeVeD5gHn+PAweMDT44YEOUzGxFv8sIf7Lj71uNG4CzFNDliN64QnL1qSusCazGoHXxyFzDG8PTbO6mJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWLf9Dk73E/GDrbdUNFMB7/nZ2pI7LnBcXcFKGyHpoY=;
 b=bpjM3R38cG/r+f4W/PfQeTWUcFdrHBXxQcWjbScqZx+XHmYnv3k8V2OnUGCidSME4af621l5awiIfdDxOkXICEZJcC00wLfgMzOKKJ/+sKAyrNzcXdfdB+dWSySgOdyVii5bo8MIBO0cdF3ZHtRHG58Oasvm3sOaVUpL1aZeRUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 15:42:08 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 15:42:08 +0000
Message-ID: <631c562f-3549-42f6-b695-62b52114506e@amd.com>
Date: Tue, 5 Nov 2024 21:11:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] KVM: SVM: Enable Bus lock threshold exit
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Manali Shukla <manali.shukla@amd.com>
References: <20241004053341.5726-1-manali.shukla@amd.com>
 <20241004053341.5726-3-manali.shukla@amd.com> <Zw6rJ3y_F-10xBcH@google.com>
 <74089281-3208-435d-93b3-22f1d794dfae@amd.com> <ZymBbk829lGCY8dp@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZymBbk829lGCY8dp@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::15) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ae9a07-3b04-4f23-69f9-08dcfdb0680e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGJSTEZGZE1ENmlEb3BuUWdpR0p6bU1RSUd5azNnN0o5VzZOYlI0TS9jVlJX?=
 =?utf-8?B?WDFxbVNla0p0WTRiOTl2RGdBSFJMaVJGdnpCWFJMdkV5MVF0WjhVUHB1ZHlJ?=
 =?utf-8?B?eVpFZE1TYVp5NmJHc2xSUlllWXhTNVlhY05RVzVOUlZoemNVa0Rqd054allL?=
 =?utf-8?B?R3JmRGF3MEgxU2R0eHpDNXpqTDFKdlhHb1JJQ252dExsbHNlSjZtbDk2bXl2?=
 =?utf-8?B?N1VPVkI1SjE5OU9ROEJiMUZLT0tzcHJhRzNZRFF4dVFDM3c4aUJVWXF3bDhv?=
 =?utf-8?B?ZmllN0pnODRFd1BZTFkrc3FuSVlMeUZMc3hLUnRleER2ODF2czdVWGEzZXB4?=
 =?utf-8?B?R1R4cG1YejNZMkFyWFF2ZkEwcDJmejZaMmFad2tTLzNDS1JCN1MzWDRPQWNW?=
 =?utf-8?B?ajVhYlo3R0FpRnhaOEpLSC9kaHFWMUh0dG40MGRraXBwczJOM2lNdURZWUxm?=
 =?utf-8?B?d3A5dGllOHA5dHFVaEZxWWY4eW9tcXVXT2ZZbjFqZEJRVFh5dU5vaGx6ZUpL?=
 =?utf-8?B?THoxR2RaNTJSNllrT25lOE1PTGlWc3ZrWFZuVUgzTmFGT0UxaTl4YTRHd0VO?=
 =?utf-8?B?TkxxNGhTZ1V1bUdkbERXYkNiMUFud2NSYjhXcGMxMlFRS3BSSUZ5NmdsZ1p5?=
 =?utf-8?B?WjRWSGtPYnNGdEtyTFhBWkFLcThCcXRCZTkvQllDRlJaNXRzSWU2NUtOS1FC?=
 =?utf-8?B?aWZRaHZwRmlxRHlPRWkwT3owVjlvTnJLZUNoUm9idzRnaW1QMnVDVG80dzdO?=
 =?utf-8?B?UTFrditZaVFjM1BBM0ttRTQ1N1IyU0c4L3FTMmNoanNiS1gzaVZnRFgwT05v?=
 =?utf-8?B?ZU5PbWpYRTlaZmxrWUdOSXlXUTRJVmMwaExnUzFBYSs5Ukx6cWlqdGw3bkZ6?=
 =?utf-8?B?cy9obEZUSkxYM1QyMHl1YjJHM0xVUE1vaWJxL0xKMkxraFRkV2xuMVYvdlRl?=
 =?utf-8?B?Tm1OQ1FZMXZxM2JET3pTLytyNm1PdnYrU282WmNiNzcyNXlpRytIa0F1SEV3?=
 =?utf-8?B?RzJaMHFRY3NQZThNZjhyekpHZjBXdCt1L2JuN1NEN0pWV2Y0dVp5MnhZQ3Zu?=
 =?utf-8?B?amtEMGQwdDVRNzdyQUozcnIvWEJOMWRROGk5cmdTbmRNMmNYRERRVXdkY05m?=
 =?utf-8?B?bjZCWS9BTW02bzhnNVZqSUJVbWtWbjBCamhTMnBZb2JYOS9UZ29KZUhjUXRx?=
 =?utf-8?B?cDZNR0NxeEQweDV1a1lZbmZURzkybmQvOU5EcHFmbjBPRjVMRTl3blUxNlBi?=
 =?utf-8?B?anBtUlpScUs3a2VoTzd2UUIwRmoxcGx3SGFqdE1yZWcwNE1EOUl0ZXVvYjNS?=
 =?utf-8?B?YkJ1Myt4aENBQmJOSE1FK3J1M1VEMlIwSEh4Sm5MOHZKbVRzVzhFdFlkMFpW?=
 =?utf-8?B?eGpoVFFabVdnSHVUbjZHQU9VRVFFSjd2VjJ4d2VJQ3Zua2hrRXBvdDFvV3hB?=
 =?utf-8?B?SERvN2V5enNoUUhwSHplL20rNlVCc2tFdjROeHhoZW5RRmh1YTBibnFaaWNp?=
 =?utf-8?B?LysxUGRnbGtudVFMYThXS1dJMnlIOWJZZmhVUCtmK1dOK0ZkSDlmMTYxbGNy?=
 =?utf-8?B?eEtNV05WdVhNRVd4OXFoTVoxQXo1b0k4WUxoTHNOdlg0RThxSzJWRmNMRWgv?=
 =?utf-8?B?MU40dTMzWUdwTVh2UFAwN0dyOXFUVjlFUkkraFIrUU1aUVpPMUpsUFd3SGpu?=
 =?utf-8?B?dmtRTkkrVWVVUFdsdzMyQThwWjdyaTJWUWJFeEJCYUpUTlpCYnVwbzlpVnU0?=
 =?utf-8?Q?+Rt12d40eW6K3OZu/icJtkpAMdgKuGRkWBPoTHp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJVQ0l2d0NoYy92U3IzYmNIRmRNSXlvbGtQSmhNUlRHa0tPOEsrakVXdEpr?=
 =?utf-8?B?NkdXQ09KWG1XdzhCbE15VXduS2lDdGJLTUJnN2xpcm93UE5rMTk0VWYyalVy?=
 =?utf-8?B?aEVWcmpvcGZWbVBXU0tiUjBqLzRCWG1Gd1FLNmYzdURiVlFERWtSRDRad3BJ?=
 =?utf-8?B?ZlBGV3Z5RkJXWVFSdE5BTS9ObEJQcDZRWkFCWjRWMitCYmdMN2UzcFVGcElz?=
 =?utf-8?B?blZlQVNJNzN0ckJXcXB6L2pQVTFSazJVemNBYkMzKzMzZGJGdVNzajBsNWlr?=
 =?utf-8?B?RU15RWZUb0tIdUx0OUJaUVBZcXVzanNRd0FHSHZnaWwzbktiN2hHK28zT0M5?=
 =?utf-8?B?VFI3QjcxTGYxbVFFYXVKUkwvUlpSaTJhQlJwWWgxU2ZtR2xCUHdrQ1Bab0dt?=
 =?utf-8?B?M1M1SnpjSmRlR21HZUNKdHZHZzFNVE9Eejh6dU83RWVsakpibFJmNklNNUg2?=
 =?utf-8?B?cmc5OVN1bDlzaVJITlYvTzQ0eXByaTBWN3RRUFc1R2xGOTNtc3dTNGRXL2NN?=
 =?utf-8?B?Y2RDcDhydHc4SkJ1WndZalJ1ZnNCZHM5SWp2TEtYVjRReUxQa2U5ZjUzR2Ny?=
 =?utf-8?B?cHV5blQwdWlsQTVkeGlwZkVLVkpVMzlwVUxHK2cvU0ptd25NWUNXMnBmUzlp?=
 =?utf-8?B?VFNIVmg0M2dHeVBJYzZtZjhVMGV4OXRoeCt4SUdGOVljbVNFMHRYY1RtaVdo?=
 =?utf-8?B?ZzJlOWpGT3NzdlVRTTgrenczTDI0YStkZ1kwREM2T3E2TlkvaFh3dzRheFV1?=
 =?utf-8?B?cDFCd1RCUUtwaFBJR3krYTFGUEtZd0Jic0pTWDVpMWVFRWl4ajFERC94TVBI?=
 =?utf-8?B?eFBPV1NEUmprLzVNVHl0dW5EMG5pUlRYcXR1bEFPVStZd1o3L1cwMVJsUDdR?=
 =?utf-8?B?S25Rbks1dGZoMS9rZVdVa1NMTTIydWtIRGZaM2hjZFZ6TDB5ZEVvNFBnMzFu?=
 =?utf-8?B?Wmo0cWlUdzFSQmpmZzRYamlzTmxrWFQ5bStyeURsZklBL0hVb1ZPUVRab0Jt?=
 =?utf-8?B?S2FtSzllS3BONC8xNW5OQ2ZrVlhlMGp4UHlLL3dXNGlBaGFMQS90MEROVEhD?=
 =?utf-8?B?OUlVMjJuZk1YV1YwMUJaSHE0NVE3T1FiWXo2WDh3UU1zT2dvS0g0RkxIMGhO?=
 =?utf-8?B?cEVsREp3N1QrdXpyOEpUbDkwU1ltdGRJUmVkMVVabmhBOHpRMjRuNHJ5ZGdn?=
 =?utf-8?B?S1VUdzJGRW5tSStMQU00NWRScHEzckxkVm5FTFlZOTBaS2tXOWNkZmxIR0Rh?=
 =?utf-8?B?dmZGR0lFUWpDMC9Xd1JBMkt6YW56aGtDeDFGMzBCTUV0UjFYM1prcFgwL1RD?=
 =?utf-8?B?MXhtVkhYNEczaWVvT1I2aXp5MDIrc3JLSWRDcXUvRHdobWhGeXV1NjZaUENY?=
 =?utf-8?B?VmI5MWprNWZzbklOeE13b1NIZnhnQUx1OEpISmFpZ3pGcDdZL0NNOFhjVlpL?=
 =?utf-8?B?WGo4TzRNRFRyZ3FNbVBabkdYcWJDY0FCSVNESEJ0eDA1blU2MnVZd1A2d09n?=
 =?utf-8?B?VHM2SmdOb1l6YnhyVDkxclpxdWRqck1oRUh6VHFsYkNpL2tVcEVUclpjbmpy?=
 =?utf-8?B?dllOTzAvdW95bWZTQjJqN0phZXpGaGloanVqNUswVnZpaWJtdDdnSXVRTEh0?=
 =?utf-8?B?UHI4L0g2ZEUzMC9wZVgrZ0hvNVcrWVdPU2dLTXRLTVdIZldwRGtzWUNNazJB?=
 =?utf-8?B?RERBaVhtSmladEhQNWRYdWQxcC9kaExjR1UvMGtsRStDMlI4cy9sdHdZZnhK?=
 =?utf-8?B?TkR5YnowN2RaSGNjUC84Z0RwSG9zMVVMV1NwVE5vb255WFBsenljbjZxbmMy?=
 =?utf-8?B?RTc2RXdmbHo3N3dmd05QNEJBZ05zb3QzaGFKcWFpSW8xditzUkloQVlWVkQr?=
 =?utf-8?B?d1lWK1ZHWDBxNWtYODRmMmF4UTRMNGU4RzA1TjJ4Mi9ONEE1a3Y2LzhKZWln?=
 =?utf-8?B?OUFrbWJWTFR6V2xvRGtITHBDUXlucWF5UVU1bjZjUFBnazRSRm5Hd2cwdzBp?=
 =?utf-8?B?RytZOTBnMEFzVWhQY1VPbnhDbzNZOUhEeUxMUnIzbEI4RFozMUNMeHFUUHJH?=
 =?utf-8?B?Ui9TSlZPTXplWG1ZTW50MXpJQkJiNGxiSklDWEJ3aGhqOThGSXRCMnhsY0dT?=
 =?utf-8?Q?UNEUphgmryIYXn0WfmaFS5PlP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae9a07-3b04-4f23-69f9-08dcfdb0680e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:42:08.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdTRhuYZQT1YCK9LeIFpE5EMFktnlTdp8Fh2zcUQZfKSdsYX7DqJ5zXVpF9KwC97Jz3t//RLXCZz8MX5WsEacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

On 11/5/2024 7:52 AM, Sean Christopherson wrote:
> On Sun, Nov 03, 2024, Manali Shukla wrote:
>> On 10/15/2024 11:19 PM, Sean Christopherson wrote:
>>> On Fri, Oct 04, 2024, Manali Shukla wrote:
>> ...
>>>>  
>>>> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +	struct vcpu_svm *svm = to_svm(vcpu);
>>>> +
>>>> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
>>>> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
>>>> +
>>>> +	/*
>>>> +	 * Reload the counter with value greater than '0'.
>>>
>>> The value quite obviously must be exactly '1', not simply greater than '0.  I also
>>> think this is the wrong place to set the counter.  Rather than set the counter at
>>> the time of exit, KVM should implement a vcpu->arch.complete_userspace_io callback
>>> and set the counter to '1' if and only if RIP (or LIP, but I have no objection to
>>> keeping things simple) is unchanged.  It's a bit of extra complexity, but it will
>>> make it super obvious why KVM is setting the counter to '1'.  And, if userspace
>>> wants to stuff state and move past the instruction, e.g. by emulating the guilty
>>> instruction, then KVM won't unnecessarily allow a bus lock in the guest.
>>>
>>> And then the comment can be:
>>>
>>> 	/*
>>> 	 * If userspace has NOT change RIP, then KVM's ABI is to let the guest
>>> 	 * execute the bus-locking instruction.  Set the bus lock counter to '1'
>>> 	 * to effectively step past the bus lock.
>>> 	 */
>>>
>>
>> The bus lock threshold intercept feature is available for SEV-ES and SEV-SNP
>> guests too. The rip where the bus lock exit occurred, is not available in
>> bus_lock_exit handler for SEV-ES and SEV-SNP guests, so the above-mentioned
>> solution won't work with SEV-ES and SEV-SNP guests.
>>
>> I would propose to add the above-mentioned solution only for normal and SEV guests
>> and unconditionally reloading of bus_lock_counter to 1 in complete_userspace_io
>> for SEV-ES and SEV-SNP guests.
> 
> Yeah, that works.  Though I would condition the check on guest_state_protected.
> Actually, and this is going to seem really stupid, but everything will Just Work
> if you use kvm_get_linear_rip() and kvm_is_linear_rip(), because kvm_get_linear_rip()
> returns '0' for vCPUs with protected state.  I.e. KVM will do a rather superfluous
> cui() callback, but otherwise it's fine.  Silly, but in many ways preferable to
> special casing ES and SNP guests.

Ack.

> 
> On a related topic, can you add a refacotring prep patch to move linear_rip out
> of kvm_pio_request and place it next to complete_userspace_io?  There's nothing
> port I/O specific about that field, it just so happens to that port I/O is the
> only case where KVM's ABI is to let userspace stuff state (to emulate RESET)
> without first completing the I/O instruction.
> 
Sure. I will add this refactoring prep patch with v4.

- Manali


> I.e.
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8e8ca6dab2b2..8617b15096a6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -406,7 +406,6 @@ struct kvm_rmap_head {
>  };
>  
>  struct kvm_pio_request {
> -       unsigned long linear_rip;
>         unsigned long count;
>         int in;
>         int port;
> @@ -884,6 +883,7 @@ struct kvm_vcpu_arch {
>         bool emulate_regs_need_sync_to_vcpu;
>         bool emulate_regs_need_sync_from_vcpu;
>         int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
> +       unsigned long cui_linear_rip;
>  
>         gpa_t time;
>         struct pvclock_vcpu_time_info hv_clock;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 425a301911a6..7704d3901481 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9308,7 +9308,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
>  {
>         vcpu->arch.pio.count = 0;
>  
> -       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip)))
> +       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip)))
>                 return 1;
>  
>         return kvm_skip_emulated_instruction(vcpu);
> @@ -9333,7 +9333,7 @@ static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
>                         complete_fast_pio_out_port_0x7e;
>                 kvm_skip_emulated_instruction(vcpu);
>         } else {
> -               vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
> +               vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
>                 vcpu->arch.complete_userspace_io = complete_fast_pio_out;
>         }
>         return 0;
> @@ -9346,7 +9346,7 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
>         /* We should only ever be called with arch.pio.count equal to 1 */
>         BUG_ON(vcpu->arch.pio.count != 1);
>  
> -       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip))) {
> +       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip))) {
>                 vcpu->arch.pio.count = 0;
>                 return 1;
>         }
> @@ -9375,7 +9375,7 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
>                 return ret;
>         }
>  
> -       vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
> +       vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
>         vcpu->arch.complete_userspace_io = complete_fast_pio_in;
>  
>         return 0;



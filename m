Return-Path: <linux-kselftest+bounces-10933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E367F8D4F9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 18:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E32869E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E341208DA;
	Thu, 30 May 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CAfJFswd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DD2376A;
	Thu, 30 May 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085308; cv=fail; b=VNc5zbFTDGtq8OXkYI8Hb+qceKOxkKedleD4ZN9fWPJukMywhQCDMYUaJm+a+NK2HZ1cVAYPW6TLajMiUwKHvP91Pzu8lvtszty0as2u7XGJM/Nv1j6kIlj9b7G1dprxhmicuuvLkthFmm6ImHeXwjlPeHNcTYYYwR7JKR8t+90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085308; c=relaxed/simple;
	bh=PIEgyPmxzkwiZnmZBwc7dmglNaqDJ0mDVSwAEG053X4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KcnmCanNLYfbe5Kshoh7y11kIvZTFmEUeduEb/Il/mCfI2yDu0rIGh1l6xVvqTbY9U1DX6ALZOmVM/NThI9CjLojCrmOI/Bf1oJwWNmhwKuTJBczXyJ9gLVg/RyXewwjrOwMKW5+7NzU9F/6Bba4awnxNZewaux+3dLJov5Su2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CAfJFswd; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6mf4PcfFRBxcpN07UZejHUn7yT+brYJnWbsKJT2QFCl4p5g9BtsdeokxG7P+/BryVryRcBnbjsMQ4nTo7++o/luivhyq71MvAlDvW+Sk6+v7JYyfgQ8MG3ZxMmRFQKwCYsIOBGPPruyWeSkFiBrjuSWf2NdUAqIjg07zcmSsnFuGgOzLcrLmOxxX3XtycK2mibDHDliPaenGjPzQZeGdyltZ+inuAkiwEzYB7zUs83fREtSLVJkOvQhtBOz6KlONVZb5oPSMmorWJMmuifbK2NvG5uBlFG46a5Hxi/Px25P+AtvLh5EeeRy3YKcC8nVSK5+FcmQ2hw1lQ6ZK9vqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smZw5grcACJy6u/Li+jPu/eJz4bshR+cFTVF7LaZobo=;
 b=ORsCxO+4CyYNfcPYPQLd6fEdw31lUfVKa52yj3U9eN/Cx+SliNa5MwPX+OcPc9uaTi+SG31vxZSviA/6ybOE5mqnjBzUlyEGsK6hMdbEX8yj+F7t/rRypRGG2PSgI5Efb4GwRvcfA2wnbKeeiWQCKyRs0D1khLLom2IZseR6QxGMiW85RJG+6oyjJ2CfepwNJszjv5oCnvs35hyYXd5k2cyNRIG6Kt0Q2ynPLvwowiyomcWypsnrnyKZSJ6kVqaqAho/COkjtXAh8szopfSKRCmCRXKYqrgqhemegIxGYhrPS9ww5+XMiCb80YDCztFnQxIcnEyGCJQkiph03Veaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smZw5grcACJy6u/Li+jPu/eJz4bshR+cFTVF7LaZobo=;
 b=CAfJFswd23iAKty+OCe4AmbxvdwVMMuGPe0chb3+jg82LmzLLPcJYf8I7AUn9BxyZ/QDr2P/PAkwCyduBCvYz/ke+5eK6AekRRuaqsqwNv5vQKpUm2yf+OMaCM5rMSWori0aUpSkuncuNlqD6w79TXO8gkTRVs1rIYGYf6s93F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 16:08:23 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 16:08:23 +0000
Message-ID: <66405792-5a7e-49b0-8cce-48c24419d2e1@amd.com>
Date: Thu, 30 May 2024 11:08:20 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 3/4] selftests/resctrl: Add support for MBM and MBA
 tests on AMD
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <0367b45170fbc7411aad12c28802284a298c1c6f.1714073751.git.babu.moger@amd.com>
 <91eeb2d6-e0bc-43cd-8641-ddede63f3786@intel.com>
Content-Language: en-US
In-Reply-To: <91eeb2d6-e0bc-43cd-8641-ddede63f3786@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:408:e2::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf248e7-801b-46ca-23e1-08dc80c2bb55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkQrS012dHRMeWNyU0xja2Z6UG9hRG9HeUpFV3pYeHhRU1BrT1BaaGdoNUpz?=
 =?utf-8?B?Wjc0eWg3VlZlNyt3NnB1WW5LSktBTCtoZ2w3SVJ1a3pnaVlWNU1WTVludjBs?=
 =?utf-8?B?ZGxHT01pMEZTRDVhaERCTXBoOTZET2E3RjVEMGlWaERIZGc3OHBvQlNUVzlV?=
 =?utf-8?B?U1RhT2R3YVdvdXhHNVpzU0Nhb0oyWVUvVk8zL0tzaHFJaWNRV1J6YlFTcnMr?=
 =?utf-8?B?UjNENFZraHMyR0Z2cUIyR1ZGZ1JDWFJOVEFGNldIM0NzOVFUSENlRk5rSkh3?=
 =?utf-8?B?dE41SGtFRzM2T2dVbWY2WkVHTVJZTFh2QUxUMmFWVFRIR2xqVGxNTkNpVk0x?=
 =?utf-8?B?NVZBSkYwZ1Z5NGRoeTRNd2Y5UUxwdytOOW5haTlhRURuV3dRYWFZRTF4U2V2?=
 =?utf-8?B?Z1RHR1l2WjJNMVlJMWhTc2dLK0sydTV3RkRDTnVJR3UzWnB3K3FMRCt2d2RF?=
 =?utf-8?B?alcydEtpK3ROcTlUdlMydlR4WkNQVGpodkFJRUlpRHo5Tm1ZZWd4K3ZLN0w5?=
 =?utf-8?B?ejJSTWs1aDlpOWlJOFlEZUtFbU0xTkdVWG42eVc3TWJSQWJWekFMTnJkSVoz?=
 =?utf-8?B?UjBUbi92QTkwTGUxY0puYWlBT0VucGhuSlBwQy9CdEErbTdFTTFSYStlNEZi?=
 =?utf-8?B?bGxkcWN5WURoakh5Wml5cFZld0FFbCtpUVVzeUJUWm5UK0NTSEh2MFBTK0ho?=
 =?utf-8?B?ZkV1STRuRlZzRlpIbmZMcjJMTitJeHZFUHVhQnZEQ3hUQTh3MDVNUlRyUEF0?=
 =?utf-8?B?Sk9ZZnQ2MHMxTVZPSk1RMG5YQ25PcEtGdHBSazhjaGYxTWRSejZCWTRHbzI3?=
 =?utf-8?B?S0o5UjhQVzFUWFg2eHNFd2V4TytxUVZwc1hXUG9LWm5HaGJlazVvemhKV2Qx?=
 =?utf-8?B?Y0hNeHZxR3lIZkc1d25yNzg0QzliK1J4Q3JOZDkrcjNMRTN3a1ZEMzJYN0FZ?=
 =?utf-8?B?amd1NGlSclduZytaOEV0eFFDRFdZeDBBSWI5SlV4cXJ0azZrNlJGNkZBcmVj?=
 =?utf-8?B?aW5ISDZTMnRVWDV2SldKeFBMTzZzQi9UdkJPa1c0T2lIZDgzSmxNVE0vTVVI?=
 =?utf-8?B?OHZXTmZXL2I0dlRhRWp5SHBGUk1jczdlZ0xYYXhucUFQR2JKUlBWOXpYMHJN?=
 =?utf-8?B?M3NVbEQ5VXRqWEMxUkdYUlFuN29Rd3pGajRRMjZ4dHJFbG9QRWFNYkpEelR2?=
 =?utf-8?B?RUovTnVUZ1VmcHVQNVZjNFhvVWhBRUJQb0NkRnNGYlVXeW9RQWxGNjhaOWxj?=
 =?utf-8?B?Z0pnV21lU0lNRk14R1RRVHc2QVhqY3h5TmliMFl2WEIxNjdwZmd6MDdZM1lI?=
 =?utf-8?B?THZMNTVJb3NhcTE3Y3IwVlZtV3M1aG9WVXdFQVI2dUtlWTVnWENJOHRwbVBs?=
 =?utf-8?B?RzlvTDJGU0wydjMyeE9MWWZ1T3NuS09OcnJVL295MzdzWHIrR1d4bkNPbENk?=
 =?utf-8?B?S1NlZkJEOWpXQ3pmUGgxcGM5NDM3Y3lLeFE4RzlDOTZ6M093ZmcydTVid21C?=
 =?utf-8?B?WkZtWXc1b0YvT1hMSit0RDFXSlN3THBVd3NIalhWbWdKQmZqa0QybUdOd256?=
 =?utf-8?B?MEI2SnRJNFNBb3ZtNU0zcHdxTGlJdXVYenNQcDFZaDFHakJCcmRFRDRueEdj?=
 =?utf-8?B?cEl4eCthMVVPcmdnbVdLdC9wd0UyS3lJVGovVWtrdEo2WEZLTDBTTDFSZjNN?=
 =?utf-8?B?SWZ6dTNTR3JnakVuaGJWUnEzL2FGck1oRjc5dHZlNUoxQVltMUJkQ2dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REh1UGhQSUcyT2ZESmhlZjBSNzZpVTdPelFMZ25JRGlhNWZHeUtLcFJxOUY5?=
 =?utf-8?B?UUM1U0NsMnMyNlRudmdLWUJoMkkvdkhzWnVhK0xodlY1U2pEWGphL3hqTng2?=
 =?utf-8?B?RUxDK2V4dGlWeHYyRlAySmtHM0tLanU4SlFnVW9qQWtiSng5Wm9STldnbHlF?=
 =?utf-8?B?dmxOUmhzVmRpVUxRT1V2NXdUcFpvaVUzRXdRMnRidHR5K0UvbkV2dWQ5WU1s?=
 =?utf-8?B?WTZWam1WUGRvOXVzQUhjSFB0Sy9ZcXNPclM5b1dhdnRWTEhocFBhMEJLQWR3?=
 =?utf-8?B?Q3JQZXozaWhJcHlnMi9TMCtUbzEvRDU4c0J3TFdGYnFodVdjdU9zY0UzK2hB?=
 =?utf-8?B?aUdqZ1ZkSjhRWm5GeWtWRGpOdk45aVQ4TEFrUmcrb3FVTlo3Sml4MzRNMXhq?=
 =?utf-8?B?R0FKdGYrc0xtSmxNVStvOFlhbTNSYjM1V3NaREtZcnNqSmZndW1IblFZZSs2?=
 =?utf-8?B?NmFvdC9YQWtGQ3dhSE5iNFpFajl1eHVGZlVLcW5LT2VhZld4aUhGdCtTS1Fl?=
 =?utf-8?B?dy91M1E1cFdIT0JkT3FmNWI3MXlSS0lLZHYyZDNqak1JZjRIZmJxaE95UnNJ?=
 =?utf-8?B?ODBEeEJIYzEvTGdKNE5TWXp2Wm5rV0Y0QncxNTdVNEJicWczSnZKblBBbG5C?=
 =?utf-8?B?SUhIQkMwZnNIMXMyUzVCeEpGZUIzRnMzWFdROGtXSmVKbGJ0NXZvVzlURVQ1?=
 =?utf-8?B?UCtBd0htVnM5TkpoVU9zR3lmanVtdHJqUEhsT3BmQ0p2QzcrODNKNXh6RVZ1?=
 =?utf-8?B?WDlCeHJ2WVhENngweVJybHd5TlduTVpkVzh4UERaeDdHdVZjOFg4RS9ZMVJI?=
 =?utf-8?B?T2VrQnUyYU5XZjl2dFFFZWQ5cXk1RDRhc2F4RTlTOE9oc0JiN25VWUdua2Vz?=
 =?utf-8?B?ZW9DckpLeGxiMzczWHNHdjQrK29FQWlnTWc2YUhYU0NaZEltL3VjNEdINEZT?=
 =?utf-8?B?V200SlFtTXN3YmxIcHkxM1JIY25pK3I4RGNzN0VtOW9DN2JKaGZPeTJkNGll?=
 =?utf-8?B?R1BDTkVESEpvczFyY0d6RVE3dCs2UHNiS25zSjlWQVpxVU5ZNUp5S2k1OWt4?=
 =?utf-8?B?TnFoMFhOYTVGd1RlODA5Y2Y5L0RsUytYS2xyK01POHlLbG00dTFMcExMczZ6?=
 =?utf-8?B?OExldUMxazNGMURVRWlUeDVhWVBWcXRwdVc3UDVSMitKMjZnTjJoc0l2ajFE?=
 =?utf-8?B?UXo2aUd5aW0rTzVxSnhKakp0ODUrdE1KUzdIS1pJNmZDbnRESk1HakU2aTZu?=
 =?utf-8?B?VEdiRTZnVm9IcW53YytJUjZsZkcxeTNUNmFmdHJqbURNaUlObkYxNm5KdVF2?=
 =?utf-8?B?YmVoaGxRREVJT2FtczJyUVRmamhPTitDQkpDM29vVC95SDhhMkJuVmFsd2ZF?=
 =?utf-8?B?L3Byc1ZsZmtBR1c3ZFJMcm9kVGFoaU0wZzljZzlUWHplL2YraHl0dDhDVGFw?=
 =?utf-8?B?dVJ0UWo1aWJkSXg5QXZSc0VTOWNIZzlSZDRFL29mdlZwaVgvVDNOZlBjZ2py?=
 =?utf-8?B?cHI2ZnJvOHUzSTlQR3h2Y3F6SWMxT012NHVVL1gySEJpUVk4YnM5M2tmTjVw?=
 =?utf-8?B?MGx2VStrZW5CWWJQK3lJK0crSEY5amNpN2cxREJWa09yYS9wbWtPUHB4dzQ1?=
 =?utf-8?B?OTZtbkxTckhiS0JhajJYdGoyMWRNb2k2RWVUWkZCVGIra0dZSTl4UExWbWti?=
 =?utf-8?B?R09LcmREVXRHWTROeVJZcngrVkx6anBzMEtuOWQvcmtaajFhNkU0Yjc3eU9P?=
 =?utf-8?B?NWdxczNyeHJLR212dURtdm1mRjB3ZTdjK0swaGN4THZoS010bTYvYktJQkVV?=
 =?utf-8?B?T1hvazBsZFlBS1VNK0Y5anZhaXhFeXNaRUoxTDB2cEt5NHJKblBtM2NBV1Rs?=
 =?utf-8?B?QytreDNaamxmRkdSVDZHMzBNR0tmT1h1cWNZRGhBT3V6MVEwWjBXbTNSVFJB?=
 =?utf-8?B?MkFMQ3pLS25XOTFoeDE4TnQ0ZFVkdW42SDNpbXU5WEFCbTdScDNGdFVFZHZx?=
 =?utf-8?B?UHM5dHV2UGpKMkRlUmJCOXI1MHRGcmp4Z3dlZXBBQ0c3eGlaVElFUWtMbzdX?=
 =?utf-8?B?U212RjFEekpnNTdhS1RlK2tYUkh4V0NlQWgrLzVBU2R0S0V5TWNqZjc0TjB5?=
 =?utf-8?Q?jI+E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf248e7-801b-46ca-23e1-08dc80c2bb55
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:08:23.5883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8sw3TUuzj7QNUhCoaiDIzbb3g/COVC8cQwGyzUiMeWbd7h0Zk4gjcd7KoDFWOPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

Hi Reinette,

On 5/9/24 16:11, Reinette Chatre wrote:
> Hi Babu,
> 
> On 4/25/2024 1:17 PM, Babu Moger wrote:
>> Add support to read UMC (Unified Memory Controller) perf events to compare
>> the numbers with QoS monitor for AMD.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++++++++---
>>  1 file changed, 59 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index e3b09128ec3d..d90d3196d7b5 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -11,6 +11,7 @@
>>  #include "resctrl.h"
>>  
>>  #define UNCORE_IMC		"uncore_imc"
>> +#define AMD_UMC			"amd_umc"
>>  #define READ_FILE_NAME		"events/cas_count_read"
>>  #define WRITE_FILE_NAME		"events/cas_count_write"
>>  #define DYN_PMU_PATH		"/sys/bus/event_source/devices"
>> @@ -146,6 +147,47 @@ static int open_perf_event(int i, int cpu_no, int j)
>>  	return 0;
>>  }
>>  
>> +/* Get type and config (read and write) of an UMC counter */
>> +static int read_from_umc_dir(char *umc_dir, int count)
>> +{
>> +	char umc_counter_type[PATH_MAX];
>> +	FILE *fp;
>> +
>> +	/* Get type of iMC counter */
> 
> iMC counter?

Yes. Will  fix it.

> 
>> +	sprintf(umc_counter_type, "%s%s", umc_dir, "type");
>> +	fp = fopen(umc_counter_type, "r");
>> +	if (!fp) {
>> +		ksft_perror("Failed to open imc counter type file");
> 
> Why go through effort of changing to generic names and then follow
> by using Intel naming in AMD specific code?

My bad.

> 
>> +		return -1;
>> +	}
>> +
>> +	if (fscanf(fp, "%u", &imc_counters_config[count][READ].type) <= 0) {
>> +		ksft_perror("Could not get imc type");
> 
> Same here.

Sure.

> 
>> +		fclose(fp);
>> +		return -1;
>> +	}
>> +
>> +	fclose(fp);
>> +
>> +	imc_counters_config[count][WRITE].type =
>> +		imc_counters_config[count][READ].type;
>> +
> 
> Up to here seems to be a copy&paste of read_from_imc_dir(). Could you
> instead split read_from_imc_dir() so that AMD and Intel can share the
> code to determine type?

Sure. Will address this in next revision.
> 
> Reinette
> 

-- 
Thanks
Babu Moger


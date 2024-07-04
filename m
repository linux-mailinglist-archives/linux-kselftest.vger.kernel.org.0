Return-Path: <linux-kselftest+bounces-13159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22654926DEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 05:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CE1283919
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 03:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2018637;
	Thu,  4 Jul 2024 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqcV0VZb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCC1755B;
	Thu,  4 Jul 2024 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062537; cv=fail; b=qcSWfwJ2P2xDG5H3ssaFxwDXXsxGUc8MiC71ehovSM/9pVpJTFUUhTRX5Yd7P14tzOYg3ThgY+Osg9FczWsznc5UAOuj9bW5y1BRofZpw7Xzc/YaP9ilFGa5Oi1hRPx4LBJL0+dWyk7p9Asbk8bEMOx6xqCkCaFCuf4gpAXn+wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062537; c=relaxed/simple;
	bh=UUXEV1Mg1xQoZuz4l3z9VMjJ+z5z5Hkg40ZqRQMMsYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F6OUbzW1Mb3Eel6VMAsfcAXTzZQJaNoTukXldslwIsFlvYygRI6hJGAKpnLNlKwbzK3HY1ScoSraTn9DFwz2gd0BnogVdcXusDIn7YmTUTku2DoGByLnOlV9trbzkvgP5XbjJNBM5ZMg00OATVIcgZuMnC67skoGkr4gw0WiHRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqcV0VZb; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqIlTSLkRELk9OYuv4wTId87M8OxriD0KyZkAmT6c1rd1YiQXaIVJHsvWCy8fHhTk1EDUQZOyUjhcr/B9fe4gHD5Io6O7EweWokTyXm1t1kP14bh1ciUMZ/C+Fh3PqsHjrMnYBy06yzUeI4n/pH1GXROQBDUXSa7gBZZSGFmiBIG2uaUSs/BOkjCUNEdVgmPendhFhpy0J7JzlgiDr6sNBudj/W1lesJdvEFbsciWWUDv4+ni/dirll6S86A4Qf5cKyX2S7XdYMrKn53nUSm0joLp868HcFdVe2BS8/QkHQHPYuxBmBQHka6S7PZiU3N6+RBql+e6B9HArXRmZPHJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHr88iMOe+ZD+NDbUDNMx8Q6+TOJv1EmKWL96aKaiwc=;
 b=J9xyRlF+J7pYj9HB1ip7QdQ37pr5jrO1IMGC8lPt5Z47eP3xyK+ZeIj+t2pxNtj9eSBz9cAg93xdZjPPaQSgIU5zyWWV1uSQDv1Gsq6vTgJCDUwAneONrtVFYGOrZUVT74QRsiib2rGBeQcZUHq274jisb1wbTo2RfX29JMW0w2pNrRied7gF9sjgoNZ/aztG0Yz9oy142TGr3IQPy7sKUXAjx56A+sgNWt2EEl1if9TSmEH0t6KBc7d7e0z2XyCRq32sELet65h0lM72iV9KNqWHOLrTiksYNajm4adVF6SyXm7NrXxaL1RGOFewqwUh9qr/bwoEnyFkQN92wIlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHr88iMOe+ZD+NDbUDNMx8Q6+TOJv1EmKWL96aKaiwc=;
 b=DqcV0VZbF9+aI9KyPwLXpKk7E/QfYZYPVsv7WHfmO2boABl+Vmc0je6gGMYo59PsSsj3GCiWDcjS6T0MOYO0aZJ0DMNevGAZUddCBkA9NYsjFg11LDu8IVHDG272xwPQPiQxRtE6k6z7wdZJSXbLV+mjtTDagUu1A9gXZvNZcn0SVWbgArppahKNWL9k9M1e6M1ievtq14FtwFToM2hr+org3EA0pbAf/VZf/AkCdB0ysDoneDOHwF7Vp7JbPIgTVaB9v47KKxb/QR3G59pbrXIQFuCKRZXFy9QQD3FpynOe2FPG9oPVWS2PLvNSHeXqgzwsz8UwAHa17mujbYr0hg==
Received: from SJ0PR13CA0152.namprd13.prod.outlook.com (2603:10b6:a03:2c7::7)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 03:08:53 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::c9) by SJ0PR13CA0152.outlook.office365.com
 (2603:10b6:a03:2c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23 via Frontend
 Transport; Thu, 4 Jul 2024 03:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 03:08:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 20:08:40 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 20:08:39 -0700
Message-ID: <17675d27-6a9c-4f1d-a771-4830393465d3@nvidia.com>
Date: Wed, 3 Jul 2024 20:08:38 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, Shuah Khan
	<shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
CC: angquan yu <angquan21@gmail.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Binbin Wu
	<binbin.wu@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <x86@kernel.org>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
 <d9c56b70-6120-4de7-920b-9ece52905c00@nvidia.com>
 <64f44840-823a-4b82-8187-c94c6e021c15@collabora.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <64f44840-823a-4b82-8187-c94c6e021c15@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 246fabb9-92ab-437b-396d-08dc9bd6a225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0EybEFZbzEzTGlpdUZJblJPQlhuRWJaVlhKdllsSWZJZTd4NkhoU3ZXd21G?=
 =?utf-8?B?S1dMakROWVNCbG1pejRQNEF6Zk1BOGcwcnlMV1Nkc3U3TUl2ZFdtck9FcHQ2?=
 =?utf-8?B?ZTl1TG91QXYzcnRMSVo1OU9SWE1BdTRoWTdOSDRXaUdFZllMSzdmOGFaZThh?=
 =?utf-8?B?NHIwNGhKNGcyZ0ZDSHhmc0VVNDd2SExLSFBoYjVEZ3Vad2JMNmdSVDBwMTFV?=
 =?utf-8?B?bVAyZTNNUFhHZ2x3VTFvUFNkN3Z3ZitxWFVhTk4rMFd2dTBTMUZOMEFCcTVk?=
 =?utf-8?B?MnpPOWpXVXBtUVVxWkFXLzlNajJnTWx4ejVBQzdGb2RXSVFGckdidDlGem1a?=
 =?utf-8?B?elVJNVVtRDNWeTBjdVFRRUxSbkdIN3NESnFkdlFWMTU0SWdxOExJaVRXS1VJ?=
 =?utf-8?B?aXV0WlJzbmo3K0VmOThkUFlYMXE5WDhFUlQzbUNuSGgrd0Z5ZWR0ekFKYlph?=
 =?utf-8?B?ZmlvQVJEbitZQUl2ejRDWEZScHNPclMxblMxYXFNcmRoTDNaMUxMOWk4U2po?=
 =?utf-8?B?c2o2UkVLOXJEOFk4U1JpUlNyMGZzTk5TcGF0Q2pwSUQxSk1BdElMSWNIOUpu?=
 =?utf-8?B?UDNOaHJyQjlqdmlvVTBwalZVWEQ0ajl2TXg0TjRPamlQQXR1UTlDUkVKUXZj?=
 =?utf-8?B?RlFWcGdBcVFJOXgya1dxbjFRWWFNQkQ4MkZhbDlYZW5WalU5Mzh1VzUvMkwr?=
 =?utf-8?B?Z1d4bE9FcDhXdEM4TEF6eWtLV085OHlCK0N1M2V5bjQvRjdEUWdyRFprMkpu?=
 =?utf-8?B?T3JMbEZyelg4S1NJZDRlUlNlRUhVbkFrOFlSdTlXTnlOa0tGUjZWOUg3cDJQ?=
 =?utf-8?B?Q1lpcnZIZXJRTEdUSzRJQjFvOXYwcm93cVJIalhTWElXRktrQjVJYStXMDEv?=
 =?utf-8?B?U0FsbnJiZklQc0t6NjJiU29pVTZ6UHRBa2pvK1NWWE43bktWZzdSYUFnRDJN?=
 =?utf-8?B?eThOODEyY1lNc2IxcDBZMW9WdklhYzdGMFZaMHZ6MnBPRCs5c3hoQnlrWnox?=
 =?utf-8?B?eWVxcmJEWjREam9NT0FSU1dvYS9uM1hrb2dPZFRIZHh3VVlINk5raWIyaWcx?=
 =?utf-8?B?d1Q2MERPSjB1bTdISHZUb0tmdnZia0tYemkwSjJGdU1YbVRkZjR4RDRFcndN?=
 =?utf-8?B?bmJyeEYwR3lSdTloWUhHUWZhaHQxK1R1ZW1LcEhsbGhsM1RkSWpHTG50QnRp?=
 =?utf-8?B?L1owa1Q2bDdrMDVFY0xtZFFnQjFNd3JEU2g5dVdkOUYzMnJIS1dTRVpWeU9D?=
 =?utf-8?B?T1NLM0YvNWlvakxxWTdhbHVZVW5VTVdVQXdDVXc0SUNIWjBaWWlZMkZHL3dF?=
 =?utf-8?B?WTZub2traVVKNlMxRHNVcE1nL2syRHB3SDU0M2t2VEp6MVRjUlhSWlF4SEVj?=
 =?utf-8?B?d0xWNG9pWjhrZVBnWFpMMjZoc05XUEh0bFkrbFE4dEpRVlBLVUVmZk9lV2RZ?=
 =?utf-8?B?dGxMU3B6K3J2QmtMaG15dHJPMHEyOFhJOEY0MVh2TnNJZkcrZllTcVhScW56?=
 =?utf-8?B?WkszK09rYWlXWFBaMGV6a0wreU5RWlVxRXNQQnh5cEJrcnpVT1RFbjY1NFBK?=
 =?utf-8?B?a3ZxekppbGpnQWxnYS95dDZ5a2k4YzBIWGFRSTdqd20wSC85aWRJTkc4Wjhh?=
 =?utf-8?B?ckFaV3RBVkRJSmEreXI4V0tlNUlDeXRBcEZ6RXhKODNZTWVOblYvaDlzaFFI?=
 =?utf-8?B?bEhMSFl6c0NUWE5YcU5ia3ZBVzYvVkdKUmF6RCtWZ1ZGemQ2ME1ZOFhLQ3ZN?=
 =?utf-8?B?SmFqdm9LZmxEYUxhYVl3UnFRZEJKZHlFYXRoNnFBM3FQcmFSKzdYd1dLNVJy?=
 =?utf-8?B?elJ2blB5SnQzNHFyKzVtZ0RBOFBmMEdQVmxTVCtsYmVqRisxU2hZREdTZyt3?=
 =?utf-8?B?OU0wMDZabW1QdUtVR2FwbDQyVlpCRjlNN1BuWS9yZFlkVFpuRGlSTm02M0ty?=
 =?utf-8?Q?rIionG9fVWYHAgEUuxnCQgNn9p/bsgrn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 03:08:52.5110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246fabb9-92ab-437b-396d-08dc9bd6a225
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064

On 7/2/24 3:28 AM, Muhammad Usama Anjum wrote:
> On 6/29/24 1:06 AM, John Hubbard wrote:
>> On 5/31/24 12:38 PM, John Hubbard wrote:
>>> Hi,
>>>
>>> Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
>>> discussed yesterday [1].
>>
>> Hi Dave, Shuah,
>>
>> Are either of you planning to take this series? I ask because I have a
>> very slightly overlapping series that enhances the LLVM/clang checks,
>> that I'm about to post. And I'm not sure if I should try to include
>> a small fix that would apply to patch 5/7 here.
> This series is important. Please accept it.
> 

Hi Muhammad,

May I add your acked by to the series? I can use that as a weak excuse to
resend this, rebased onto the latest, and keep trying to get attention on
it.

thanks,
-- 
John Hubbard
NVIDIA



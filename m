Return-Path: <linux-kselftest+bounces-49150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E6D326F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B49630D3F9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F612DA776;
	Fri, 16 Jan 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EjKEG7NC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D281223DC6;
	Fri, 16 Jan 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572844; cv=fail; b=LrTqoMsZIJLwsqpyl3ZG5v8E6P7y22o7BsGRya7s/4XGtbx3pA50hia0+YThWCiutGzTIpP8TlxRBcBdPfwNUpBfgagMj/EE3y3s+C32g4JjSarfxFTT52xMyaOwVab2fNkiGEH8fIHjrzyeeXVk2B6qrUKgfUYpBa0PaneeQAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572844; c=relaxed/simple;
	bh=fJfYTmyeazJjyfSn7IkCOx3E0lSvv0MNGTR0I7Piq8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rvvGRGldSr6yT//atEL5L0jrHTtMJNLWvRPIEL+80G/akvII2pDreG8i4rHJ7zC8vklwM71UFwW3fMwq1noWejNTeO0Feunp04BdkpnxcSTxwq3WiY80VQU/DAxeV3mqDNTlGwTLw9HJexsry/N5OG0cY42r6G2q+36j/+4GxWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EjKEG7NC; arc=fail smtp.client-ip=52.101.56.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAe3V7tlOqNl/gY3o6zQqP0UEDvZwHQzyysHsAMsZO5BKLfeH3yMW79K2z9IwTgZdH7GCdd0NZE5WZPNUu3oXIDM2xuszKpTyWxwPPQYFqmrDNa1BZOw0xYKBFvPhYOlrfiqTx1JPsZAMZf2BDR+faWvjunotaUn+7AhjMzSzOu5jtfhLp19UJV4UH2pULCyD6RJZ2YA8lkU0SkPVsFsGV55lDPCQUzO5XvMbaunWMSD1AlygpA6c8WCHZVZ7z6iKQAd1E7Sa1HkkOCM5FCIgZuk4EsF2IOF4Li41fv2u36SO4n2Kgh1KDaQx+x3qZT4maTMOtDFQ1lSsyEsTlxDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UqSrlZMGjS1BxL+FjspD9U55XATKUWjJHsDPkKHFE0=;
 b=aw+4jaw/jG2j0RQgMt1CrQgE9H4h47tKiDHHL/XGAIvpX9PtX26YVG0JSpw9ysRyBoGnVyeEJsdIEl2fP0YQa9iFkamr6lAnBAqwg9dzrgAWMfa3CLhy+b+lCBJWiG2WN0SgDx1Jtb83MRX/nPqO3/yBGOz9bRU/hb6h4l5QzSp8S1RBIgPCP95CbQ4nuK9xlaE8AY8xHdGqqTaMfkx8PaXJd4uqVeIRc4oQtYCjUDH4fwipPIh10DjU4liBjPCDh1uTEpfrMZjlFmbNqOpJhnGQ/mYWJ3G+DD/t+Zk+KWtc1b7vrrQK/zWNT60fFC0H+yODEYGSFt9RqAiqPRoFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UqSrlZMGjS1BxL+FjspD9U55XATKUWjJHsDPkKHFE0=;
 b=EjKEG7NCr9A/39o1bEK83rWLfLxqqZglcUhGmIIMZznXcBLehbY52GhJnoDeoDrF/GIpST8s+TH0QqUMq2Kqbv4mEd9GWmUw2bAMMP5dmJvxJT/OmDgjxv+lULxLN+hNKySAaiWbofduJXSh0jDvhCZBPl5STKjO2icq9u3SJaBY4WVyp8AD9fZorEq2vw4lf0FaDEQNagrxcpOrpKdjTwBuTZl+avO5Xpo9VEjmFMWgE7X79fZOIplEwGa+zvvfzgYyS505Zu8VNWDWuB4z9O+e7Ob0NUvwMmsb2EyiPjwfCnq2bsCsp25Re/9zgw1J16jhgscNRS8ib4n14+eIZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:13:57 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 14:13:57 +0000
Date: Fri, 16 Jan 2026 10:13:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for
 `kobj->name`
Message-ID: <20260116141356.GI961588@nvidia.com>
References: <20260116081036.352286-1-tzungbi@kernel.org>
 <20260116081036.352286-2-tzungbi@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116081036.352286-2-tzungbi@kernel.org>
X-ClientProxiedBy: BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: fb18daed-4de3-4338-c22a-08de55097d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/5o1t0Lyb5uVNb8/THgbs3splg2wg9OgaH8ko9Ev0+ExihbIwlES11hF2GQ?=
 =?us-ascii?Q?5lmhIvUHcDJZ//dUtTg4fbCTCeRRnXlaWYL1Dk8Duqm8NNaNcFn+WPDgvqrq?=
 =?us-ascii?Q?lGXvzMv3///vSoBBQShnrY7kZr4HpvjBHVHBUpIgfLU214FvQL+qxApRVZUm?=
 =?us-ascii?Q?I1AZxBMcpeSXDu6D4LHRdqywD7wllE2R79+VeaMCeBrlKFa6qGFP2adf3XSg?=
 =?us-ascii?Q?LBW3iuTKBk7jD9fwcEfwgeN4qusuBgT9hiYh7HLutha+X5GjM99suTw9LPPw?=
 =?us-ascii?Q?nunwQl2nu2kUe0WOGIZK62957tEzGhQzDU5NT2WykuUm62So9/YJA9V4w1a7?=
 =?us-ascii?Q?3Yh2lr6iOsRtmdxweGibE3yDPHrtvluFBH6BiudEtVPFSt3IMpNoH59H0gou?=
 =?us-ascii?Q?cKr2iAh5Uhkg1gzUzrmC2+rw5oO1TSqGu9B7VnUPiw7mykEZzG7wTDj/k7Jw?=
 =?us-ascii?Q?3VQmHDbQRVRsJ6LXzqhdopbBDoYER2+seucZgPq5A8Tk9oYqm/fZLin7qcVV?=
 =?us-ascii?Q?SIlqCtpJwtnNVNDfxHCJ/HpvVj9WWl98Fvilh5BGu+azN4MZBSDF1c3QLgwO?=
 =?us-ascii?Q?cKEsBGgB1DAm7Igwd322xk9WGbk71HzfQnJ0f/5C1F5vgm4yonYkLJEcEok0?=
 =?us-ascii?Q?pFM4jiDGmlmCLKfVKf1u8xWwKla1txmai3zKsBNs+CCH6Y/X/WChkIE5kryT?=
 =?us-ascii?Q?2qCD+Twcc2XMWpUbhU2+UXuV8Mm9/L7zQfuShSNEj7c4P5rFRI2QM9rNM+8K?=
 =?us-ascii?Q?NpGyugeSqEJMlElzpYJk+HR3tYwbkl+0Ic11WfW5GZRoPOK+BH0FnVLWHUca?=
 =?us-ascii?Q?fM+EdGkO53J7SKzdlc0ZA0Pl7flZCn6F5ORdjt9MXvZuSaGvvdPS9QoWMAdQ?=
 =?us-ascii?Q?oc765itenxdDc5vT2DWWzJKjZyKgZXfdrgntUPfUq2f/ZPKO2jkZPkf3kuUd?=
 =?us-ascii?Q?LfArEavSi5FemS8Wbw9PdebLFp0TcHTFpWP0OCWln/cfaRGPhjS6gErEHK0c?=
 =?us-ascii?Q?Co4Vu2ipIsEm7dPwLq9U7UylYuvL03ky2cARswkxF+GW34ZF8skWDmS+NAIZ?=
 =?us-ascii?Q?fbSsVKUpOl1aoAEm2mPcGCxdEEqdFNSt3jBQscjjzGdkoncjSeXaB2Jfxfoe?=
 =?us-ascii?Q?c9MQ1G/Y9rbzx55qDY9W/47LCAJa+pvxZ980E9YmRW2pI0gO0VEIWVQW9fdt?=
 =?us-ascii?Q?hT4ptZxnynXLuHAaScBvcgdO6B8vnziYvsV1V5K5xrDxAQraMnZu6vl/d2PN?=
 =?us-ascii?Q?OthWKioAS/M6zmDsFkQLWNQl7VsYOq1mVhGbYW3arx6jMIJMsdezh67KbJsD?=
 =?us-ascii?Q?pMOfKkWpMJXfXpOXXiRQMr+T2LAl7AEZrrmjq3zkS9bSpUih6t1NSyjpiU2I?=
 =?us-ascii?Q?euT4AnKjlVBsgpjifNp6FlOCuIQBgrCjs/4LJtka3PrYdK0SgxlxF1q9Y4JN?=
 =?us-ascii?Q?FCQ3F2JNRPvGBPkSLolCBIg85GlADZaYVDiHhMHsD+cvay9q/zYQWW0dv0Tu?=
 =?us-ascii?Q?P9uS42qhgMl2kr5W+E6UBgvJE9jlCfdSCpEiSafcIERipnAz+xskdcdrD9d+?=
 =?us-ascii?Q?JYbxcJ3uvynQDZ+adfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BBhf5mfHGbgJeYXmQUX2MA37xySbu2KflxoQpqQy2rrCv9tLZjtHj8Vgf36Q?=
 =?us-ascii?Q?jinIE9Ywg4xsoQKg0u60m7WazgCep8ZyW3Y7yl7GiIDD5V1n4KkG7TegPObj?=
 =?us-ascii?Q?LYQpyzH0ajjFV4TS69q4m1e7xTKhOeSQTBdxvLv1LvmQVwbBG5JgAGO19wGB?=
 =?us-ascii?Q?OhfkcyUKfZstDPXzoDfiZQM7Atkyi/sSdTrNvRZ4HUBWirT0jEZ4Tm1yOlOW?=
 =?us-ascii?Q?VNBa92nCWXHlCuISjqV0jAo/I9qUtbMzinpJPOMbQHH/eI38lHi0Dfy5/JNL?=
 =?us-ascii?Q?L1PKl5Lyx6dYEGd3jHHHbwdnQyFaMglCecmr1QH/qrjKu3mIkpew13EEI8Uw?=
 =?us-ascii?Q?bbR8OIHGH3vQ/T+AsW6xUd4oxez+T507P/wCwsqj+3cOuRy8hnQAEluc6XL8?=
 =?us-ascii?Q?r++a3xWutgXW7uk7PO2PKpao7KPF5Q8RfBf4aX2JlY+msjXm6lrdcSVK9ou3?=
 =?us-ascii?Q?8dLoWqrdKdrkwVKPTfOXWL8Quzlk2g4ojfk+/pVg8KNKfi5j6LcMI5N38MqJ?=
 =?us-ascii?Q?AqS/3o2eZaJeUf1zAFczGa7CC49t35CTdFi2s3hZZxFhaPlI2A8FP9dq4Jhc?=
 =?us-ascii?Q?1kG3S8kbVpOqbWwnRxcHxVfYdnjDu5W3aLoZNHU8T6FwkJfrTBtktb+/JXI2?=
 =?us-ascii?Q?qbrXLJ6eDCL8k+JkivCBA7bOWAJn/ELQxiJM4HLSk+pLi327uW35PUBoMFAr?=
 =?us-ascii?Q?s45ee2Vsxy1TP6tIYAs4ssUXPsPnCq6CPNHT9njYHW+hCSjs6DQZmNddXtEZ?=
 =?us-ascii?Q?1BuauatbKrKI5Wk9836wYvkKPdY07RKMopOsK+pREoI1e5ltv8ZYXAciR6hI?=
 =?us-ascii?Q?fyT8dW8tNkkd05le0p3eFIQoZoExg8E0TEBLyiC2FN1/cv43vF0sbUXTRy+K?=
 =?us-ascii?Q?4uo3pST8WdPl9QHZ0Wdr7y8kqu04gqdxW0SY6WnxRqyU9lOEZz6nXrLhNKgQ?=
 =?us-ascii?Q?P05eH6+CGNruxXbR/AfC6tHFSJE0AV7L7Ohkn7qsbPOdXrPUue5j9cyD/LVX?=
 =?us-ascii?Q?HGXGWpVoKyB77gFNqDQQC+BvJmF8BrquZV4YMqfvahruCpUsAZ2+BTVoGpvK?=
 =?us-ascii?Q?hi48YZLdDC9Jm5MzpUX7VDXrUXdNz6s287hGKTof7zsYYeQtOs9a9o7zdZsh?=
 =?us-ascii?Q?Hf17q9iEjybNzfzB8uEPIIZ6Up3Rb+n/0kpUk1V3NJCw2Wfsi+aQdb8Zlqdn?=
 =?us-ascii?Q?oOFnwK/03oYWrdXSUnCYTiZZi36jYG685/07dE2RHw1o9TfBXmesaBLjJcWp?=
 =?us-ascii?Q?ETl44LGdl0BsVJy8kXLC6GUQqWDJlZy42FC2A6A3QlavYf5b/aH9jybnJIlA?=
 =?us-ascii?Q?VU5/bNaQccbcgKsYmM4dMgdBL0jIUfiseieCIn/8ZBobcIkAcpWSnJSGejzq?=
 =?us-ascii?Q?FjB/mscFfhQx1SDmwCANcNuqCpBcmfh6HFOFRXqvcRWOOuJp6wofHH3asIAm?=
 =?us-ascii?Q?L3GEdwEuT2IfzjY3WqL6NvuMlV11OgfAbh/eO7/6Zjy1b/5jxyi/FOXscRay?=
 =?us-ascii?Q?ImnoASSxWtmfAEqkRzc6O081JH4J9rD/UdScyj/EbbJ8MwKuoXaSMa2Q52Uf?=
 =?us-ascii?Q?8UzH4FFyCs/NJWqLO28jWftHjLlfABctbLq+vvOJgLvM48/PFqGZFjcGXi8h?=
 =?us-ascii?Q?/QwQeYt0NqwtDwx4KCgBPHBqMhtxbNFR3aMAahxhAkgoMyWz/Y++ZxPcyBcP?=
 =?us-ascii?Q?Kvm2CQQnLnqerH3aEozeNu7gx8b0Wt4AbBkvcY7i42jMTb7sZP1jwOsbMNNI?=
 =?us-ascii?Q?Jpgqp6xW5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb18daed-4de3-4338-c22a-08de55097d10
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:13:57.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM4WJc5NbWmWxBuTXCWRvNNwf4odXJvn6blqej/qLvAyHxWOEYwutzJUtA6xjWkf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636

On Fri, Jan 16, 2026 at 08:10:14AM +0000, Tzung-Bi Shih wrote:
> `kobj->name` should be freed by kfree_const()[1][2].  Correct it.
> 
> [1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
> [2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695
> 
> Cc: stable@vger.kernel.org
> Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix kmemleak")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5eb918da7ea2..ba9323432e3a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  err_free_descs:
>  	kfree(gdev->descs);
>  err_free_dev_name:
> -	kfree(dev_name(&gdev->dev));
> +	kfree_const(dev_name(&gdev->dev));
>  err_free_ida:
>  	ida_free(&gpio_ida, gdev->id);
>  err_free_gdev:
        kfree(gdev);

I don't think users should be open coding this, put_device() frees the
dev_name properly. The issue here is that the code doesn't call
device_initialize() before doing dev_set_name() and then tries to
fiddle a weird teardown sequence when it eventually does get initialized:

err_remove_from_list:
        if (gdev->dev.release) {
                /* release() has been registered by gpiochip_setup_dev() */
                gpio_device_put(gdev);
                goto err_print_message;
        }

If gpiochip_add_data_with_key() is split into two functions, one that
does kzalloc(), some initialization and then ends with
device_initialize(), then a second function that calls the first and
does the rest of the initialization and error unwinds with
put_device() it will work a lot better.

Jason


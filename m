Return-Path: <linux-kselftest+bounces-49003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFCDD235AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 10:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BAE304A933
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6703732D0DE;
	Thu, 15 Jan 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S0+m9qJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D033DED8;
	Thu, 15 Jan 2026 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467917; cv=fail; b=SBrtc5o7npGwmJtdAD27qKAIXN2Scu13lnx0JzXGGIfnGRGufm8dv6R0Xs8xQMv9EKfAW/t4VFtWm2/rmM1NoJFIEN+H/N0yH6xwnr8GXFZxgXhufRvMwD0Uz5l1uVFtkr0cM1DY6EM0bD2qy2uyIl6sIb3b40Yb978oi/ytMpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467917; c=relaxed/simple;
	bh=/2GX6fLuImJhFdMahrQAa9nu8XgpX2B4eIp6NRS2vyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t3flyO1WFIIevGGa93cW+xfxsEZwqyHrmUFzY0MndETNj6JVkdFtX0c9GFmTJdUe4kmGIYY4Z/3eleTDRY2Rym7A6lB1TvAxS5Ef+uTx+xIJbJZfVQ2slS8ypYX71xS7W5fkWw1M4AkLuSfhSIsdJ5w3CkrH6bYq2UjXuz/OWbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S0+m9qJC reason="signature verification failed"; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH+K0RkndseoQ4lpyXzEYN1gWXbEqkV+38Ya6u7CU70TljGFQmGSJavTP5n89EbwsYCCGsI+u6gWDoo+C4H7knIIFudMXTZUTgMM7QIgByBzi/jhCo9sLCXD671jc6r56J60W34Ob2A5QX7/DKeHnkd93reCfFeOkv80UDNNWw1IvH5J/eBhNJVtPwEz5TGX4+A3QS3Vt4J1GE0YxOdWqvpOCYFEzSIBg4CvOizk0NwRlkuDUmpipaGGt5Xqstxml5UUSYM3ppCcG4QjLdkD7Hcb0y1F/B4v299e1NFuXtIB+9GdtIozfwwvvJAzh7oeAYLahzT315OC2yuocL5yKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPHilePuc3+2YoyvZOei+4TtvUjka0nZuYXWk10+E9I=;
 b=h0eP+ocwV0v/MH28Wio6g8ExBJkDmjLZu7lM+ZIMk3RZxgcHtRmeYlsFXKnvK+/wyMBQpfkfa9xPzP0NUYgt0Cdmiud9w9n5/KQQYaGLXzThUY3ByIZidN4U1r+ZXqfk3zD+Xhvm+50Jd6/OfFHJkjDEmVsmrSNYLrtEPH66Kt2Sb1t1Ay6d/0YFnK1TpxshwucajCdOybVOcDbUwI49BF4Rvxs760xFQZfhQgqOioAauJWMC3Z8eTqWYdV1JurKFXkcRNrTKIVOKu7t/8+IhAERiRM42WbD+Ios4EynsSpCWvT0BDfcfqhdW55Y5fbnTINZZVuSc/m2S0Neb1WagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPHilePuc3+2YoyvZOei+4TtvUjka0nZuYXWk10+E9I=;
 b=S0+m9qJCzmxuWXt1JIeZKEvKE9nJcXX9/7eoHFvGW1yo3f03VfjlU04oqimp/LxxCDCIKokzDvsykLV9TrdThTmiFNfYcPTfoBKjHb6YenmmwJYO+RSQIZ9dfOPT9QXPXOd7kyYX97tymFxdMC5amjdztE4b3qFx5hCHuB3c+dCsBNLneSsyZPyoa+iSoHjR8IomAqZ1VmBaM+LpxPDWzKJzAgdlrY0aJzQowXDD1OGPN6CTqUhuD9XVf4j9HQWgxP+xuIdcUnGm2uGPKh4fBUfFK6QNkaEUXGVKan1n5325WMOJDeRdcfBNT9gRSBE+wpZNIThI5pPsMTI58QFuGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:05:12 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 09:05:12 +0000
Date: Thu, 15 Jan 2026 11:05:03 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: Re: [PATCH net v2] selftests: net: fib-onlink-tests: Convert to use
 namespaces by default
Message-ID: <20260115090503.GA834177@shredder>
References: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: fc042ec9-8766-4316-745b-08de541530c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?iQqLF4wGzGuRwwOodCzXQzNFFM3692RppJO9IdV/P9bpWJca4PF+8/xqzt?=
 =?iso-8859-1?Q?07D+xYwHJYNhbbQ3oPBf7n52k+E8cSMfY1yqoYYgMS08DSCLs3Jnf5ZDpj?=
 =?iso-8859-1?Q?3hCk2rVNB2mqzz6X7S+6VCidEvRXW1pxmimSHB4I4slqhdRWi4GmCIlJHt?=
 =?iso-8859-1?Q?auBgRNML4eKTXFElDOfu0JGn0bvgEqrMgTBcDW2xG8n9iyLgURGJzXpujs?=
 =?iso-8859-1?Q?pSqfoImESrX1BF0JMlHC3ePYqnCwTrU3aSJvn+iYyy98dfdkL3qIkavSE9?=
 =?iso-8859-1?Q?a1qVBBxJDJrjZ48Urozgr/6G7bI8S1SUmqM5KBH25PXevp7uj7YdIEz0YC?=
 =?iso-8859-1?Q?MCj7ONMj4nJOVcPnoOBjibgwBwCVbAd8vM2FUhjQMaxIqnlIeXl7uzPE8d?=
 =?iso-8859-1?Q?bvQvsPLZSWFNHhLaGjK4yzQtnBM7esutCV8ZAp9fbDuOFhTxUMl8f9FVRo?=
 =?iso-8859-1?Q?kTvr+IH1/VEouWEaaExmtDwrbU5Fut5THMEDspXYdXqaBdpn8oZ6pmO3pr?=
 =?iso-8859-1?Q?KrKCExEW4LIO++udLvTRfaNyK/pK+RueZGQkuH+b+tGSQBtPP7SQZhvM+M?=
 =?iso-8859-1?Q?zy+RzVF/QA4wnnppGrzKTcaCBraUAd6vnoZlQnfFOLySD1QTmHPRhYnSvD?=
 =?iso-8859-1?Q?6lwIT6DuPcOaLgRd9vFIn1CST6j5uHIqAitXkyH4USdQCdMGhh3vZRK3mz?=
 =?iso-8859-1?Q?qY/KCyPwLmph7saAZgDn77O8uHD6ieTTtcwL4x20gI7Pskl23chb9PAz75?=
 =?iso-8859-1?Q?yaL2V24Tl1S3VmHMHR5zA0ljlqF/Fwd0d1WkniEI6dOfE5W0G59fUPNbx8?=
 =?iso-8859-1?Q?DnA7D3ZTS0slW4w6k6CDLQWZtqojYxxcsV6iO+tWUI+4AZZtW574NO1Sm4?=
 =?iso-8859-1?Q?u3Irvj1ZsjtMggRSkG7CjuvrsIVs6rNpP2ENH9K3ouUl0Bfgn0LFolGk/Y?=
 =?iso-8859-1?Q?vga+nvPA8l+XpD5oN87BrX63gQ+5nrrxU+rd0yi7YZN2cQNpHg6/xcW9q9?=
 =?iso-8859-1?Q?C55SQ6nGlRMt9KD4hOYDeD1NI1ipoCIOj1UcZzXSrk9b+l0F85Rq5R2kMM?=
 =?iso-8859-1?Q?pLj2alwVTCaTT/rNKioJECTTqk03i9CJEqqrNAZyg4BxcuyyuXMmeN/GRq?=
 =?iso-8859-1?Q?8LTsbn3IyExywhiNn86arnY/zckoybTsg9gC7pb0+oK/w7+mn5buPDO64v?=
 =?iso-8859-1?Q?gsvCnxbEWqSyo/A8cf8Umqwuh0Qy3f3fe2MMdPButaxc9sM8vj3vfz+5to?=
 =?iso-8859-1?Q?vkszmMzyNBoE7QXVi7h35m35DZleUoId4Mp5pYwOevuiqW6EjGpbYBJtqr?=
 =?iso-8859-1?Q?qBCvvf55zgxSBLlcuxAf8kaHsFANSqBeZICtW56NLBUBNsZ91rBukGLLOt?=
 =?iso-8859-1?Q?gbtsrfHkw2VCplOIadiSso6sNoRa8g9DvdiJQ4u+UbUAufH/En1Mh5qwlS?=
 =?iso-8859-1?Q?BR1/apbvNoDh/BvcYG1ILSeQUSX1Hyls7gEM/wtRqjcwchetCD6dp0Ro0R?=
 =?iso-8859-1?Q?97qzAU78zVerJj6HX65h9+/JUv3IaiV6rDFlLBqqZ9JP4Uy+9dMjFHO7df?=
 =?iso-8859-1?Q?3xpFFD7coJR36inlua+gJG9ePI/jD6PDN3DQfXP2ywRVPEH6GKC1XO1YH8?=
 =?iso-8859-1?Q?xkpJXIN1aGhwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?UjelupJOEuLXwRWnesMWq/x4DnfU82pbQhHXRuU4UJJjxmiRl/MCXFS8bX?=
 =?iso-8859-1?Q?oVH7s/hwRdO0IMwSah97JZTINacXnSO2gxX0kCLt3JD9NsEthWOWLWl9ZS?=
 =?iso-8859-1?Q?C8AeLJzSomkuR3gqQidrH09TJZVDD1X0QAyakUEQn4dPoISXl9uKQlLdDr?=
 =?iso-8859-1?Q?WZh6el7XHsQ/rObfQZb+AnYHWdK/2KW6ZToHQ48Kd+P5i++wQxG6GoSQG/?=
 =?iso-8859-1?Q?ZwYy2BCYW6tSdCPWpmJ7cppbg/s1888v8VJ5yISWTKawxoNZ0I8cD5DAnl?=
 =?iso-8859-1?Q?ShlCTjp4LfP1IOBqcr/gh7/OqDlIB7f8EMLbQb2OupP4jWl5O2KtW727kP?=
 =?iso-8859-1?Q?Wc8/OgxfCpAXkCxXEXijiPrt7Q57QQsM2q9LN0Nql3NUuVJV5I1K8HV6ma?=
 =?iso-8859-1?Q?8hFjQCKXCT/F+MwdlT7mqCtRqPHgy0k1lGXOS/aHWya/GG61+ZOnPNICwl?=
 =?iso-8859-1?Q?DT9wIh+wefn2BZKEKwLGr9YRmS73OYv5pMbZUFqxFUuhP3ev+BaYfvh9x7?=
 =?iso-8859-1?Q?FUYNe5Mn+bVa2K5Y1B5dGLCgZK5RNPeqhVDbzaablGXgrR3FurSJzGwOlH?=
 =?iso-8859-1?Q?FOs5a+GO3LWrMFgI/UGmvRxoqpAH8STcQBVuptN8w3vIWECr2vDhpR0lkL?=
 =?iso-8859-1?Q?uIrnE2eIWJKR9WZF70X314O8n7MutiD1b596HBFlwjOrT5rpHMeV1RFinX?=
 =?iso-8859-1?Q?3/9WtbHMB2QkFdKNQ1hG8AbBVkfEw13gdAlQWlSPulvk/2M0CUHIhzUQTf?=
 =?iso-8859-1?Q?d4RQ+iVZEdYSEtg75fZiz0ZhLVg0fpv+2CHx0R4SEkc/SQ5JpKrSctWWfb?=
 =?iso-8859-1?Q?dcfVE0yQ7BW94+AX+ksiltTHcn1IfgCl4NZLzdskbFNkD0h+AcxY8PkOph?=
 =?iso-8859-1?Q?OYAyyt8JnhQQyiYiilaCwqj4TgdsUY7zSY1LEO7Cp/iqraMML7pqR9ztBX?=
 =?iso-8859-1?Q?UcZI5+Kx43vLRNonugiGSoDbk1N7owDBtbCVjmkUo6zWCZWw05apJMqMoZ?=
 =?iso-8859-1?Q?GhgiEnxFE0MPlnbElO/0aBOYMu51GEQzBEM4WQjkvutQUpmwg7v0qOSr+P?=
 =?iso-8859-1?Q?nzYlXzQpayQc2S6adA+2ph4989DwtK49brMcFoJtVzyBaIsLAfljRygEK8?=
 =?iso-8859-1?Q?hY8NyB6SFjLdJCyDQCxEN40+hLNB3D4Q105NTqsn67Q7xDFLJc+v3KsjWy?=
 =?iso-8859-1?Q?LC4gYJbIKiUYm7CmY1Db2fD2JeRTM/Ev7+npRAWgX9PoPgwEJ1ud/Z7nao?=
 =?iso-8859-1?Q?XafdWkTBJ9Wj+sMPj5YTYr5KiaGuTK7w0wOT3QOKE3nmFS9JU+Sf/5IA/F?=
 =?iso-8859-1?Q?vly26uzrV2ovRVQdC+yvwIHaPaYByzhhSmF6kQUkvXFVzl6CV0Tn9BILkJ?=
 =?iso-8859-1?Q?450Bobg4uGMRBeUT7sEiX+PWadzNvHCYsS1xNK+NFu7wjTNxS2c/TQV7xI?=
 =?iso-8859-1?Q?v7CrfKKTOs6bi7sIQnWMaBnYiUP526JK0VPLqkr0Tp3sr8a1yRIOrT7mVF?=
 =?iso-8859-1?Q?i0FohIan9my/WeThLZF5kBnb9Lg7iv76dnoy6+cOR5arRWj6xkPG+hNVBf?=
 =?iso-8859-1?Q?TL5wOiZbK6pBrLI9FBKl7mVNyhUPqk2OXwWGt4xCl4bAdnD1R5gonbm+9O?=
 =?iso-8859-1?Q?5KJw6ACm3P8inYiaLrmU3E7nW5IgGvGzPj74GY4uS/VwTY4AyZxYL52/h8?=
 =?iso-8859-1?Q?kmxpmorztvKNa4YBI3/gQKtEGCR39dlqq5aBzCg7l85MtHLRH7sYlKgu4c?=
 =?iso-8859-1?Q?Jg08ug1CsXq39e7kShPRR3zEcxIXq5ThxQlWImUgta3ZbBffMX2pYvpRx9?=
 =?iso-8859-1?Q?O/MPCnrEQQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc042ec9-8766-4316-745b-08de541530c1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:05:12.3920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnFKcq72uhwuNQ2TVT9MZJIVkkqtGtrHFVAvMzdEVa8xqFX4F9MvFILWYKuSLv0luerVbjTJiDnHLhCr+5mHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268

On Tue, Jan 13, 2026 at 12:37:44PM -0300, Ricardo B. Marlière wrote:
> Currently, the test breaks if the SUT already has a default route
> configured for IPv6. Fix by avoiding the use of the default namespace.
> 
> Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

I made some changes to this test in net-next [1], but I tried merging
net with this patch into net-next and didn't hit any conflicts. The test
still passes with this patch.

[1] https://lore.kernel.org/netdev/20260111120813.159799-1-idosch@nvidia.com/


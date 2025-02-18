Return-Path: <linux-kselftest+bounces-26878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FCDA3A3C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE143B25A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1B27FE6F;
	Tue, 18 Feb 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PuSVOf4c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A40274263;
	Tue, 18 Feb 2025 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898514; cv=fail; b=ZPy+RXavxqOvO2euv+Er/DllXOvIiljDGWPK+QgFwOlXi8WvyIyDSy0pPPzhqcLyx49LGCMLc6mZnGsaE3kPQgJK9KkSrYsHyghPLYaAVU/T+NCOLGLZn1CD+meMjjK1tbGfYDEpW3upwAscrtZoTidK+k7aZTD9zxm1r2taN1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898514; c=relaxed/simple;
	bh=MptX4xOrFxB7pZiktTHYDqvEr4csm3k/VnH7zo0XIGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSiXuRXfltF5yg5F1LldI7kJmqUpc2T959tp7tQGZjVOi/v63U+uZmJiGJx+HZEQERYiVxpX86rOTocBz82YixQmtL9+4Xc4sgEwTQvFPdb+nUw0jgxQpgplxw3v26Gy0/Spn6LH6t0YLMAywfdLJvmNGXeqggdIJubGSxW73Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PuSVOf4c; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V570NiINLPBr2+SCJR3V6Zs8FktEccXMbQ5b1FLZwErl9edgyLdJvuhq8zs1cTMcdKAT1IEKhcPMxcyNuMeGfNRNR+ERujzdvQA8Cy7QPcro+2ERBC4c+WEGweKftk7k3hQphS0tuEUczLbBmCqGpdeg8oMVlv94ysHgno7el90Q3ifKSn3oCLSEAqLDgZ5YESfZsWfQUbXXp5v9bPbfW1yMEO5lf0dFzoxbGleL1Hov6YTuxq+3NfqNGlqcF16bze5OkNf9fhggyuWVCoob+qS9D1768seHNbU4f9vMIx4FKHyp4C6JVhimLP/VZQO4nkCL5PNwN2IytbvmJn4Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxNaU9OV29UjHwyE5je611J+4y37tTgr450FhIkPLpA=;
 b=MMtbMKeCuLAz7fNSjP7gRMMWlQPRnymLy3TMFQ+PAhagYOUymLBri8aG9dvb4tthHqbch3ZH9rNLb29ngFA+AA6DMY64SyQ2OyC7s9tXwc9ufVZo/G/SvR8kOQjgJaBYICBio5w4l2ygXJ+WIIHnyZ0Dzq2ekHe4JaDtuLs3CkY06kM1a8/6Y+XicUNM+VUIG08v48142NKcPdGc8UCApdaIs37GN6uVb+PWef04mDmOBS0V/fmAn9AzZMzbS8gKRI1ni62TIbak01LoxLFuk+iNytJ/QVvEOPNwgIb+OKFUcotSNCH9ZeYbQzuJIxUdUoel9B/h6ek73YFU7mLmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxNaU9OV29UjHwyE5je611J+4y37tTgr450FhIkPLpA=;
 b=PuSVOf4cYvsbgN1wcmveI4ZGkr1mxu0X7OZc2moyuEOh99rVSxp6iGbBSgL3Axqy/zHP/HwJ54bxv4pC177R7fr11+bTtaIWfUugj+1M7N/g3tOKdAtcnI5BIfV6Oqgw0zJLSY4hgDNUho38GxtvVcZx6dmyToUqWEgiEqwh0xMI5EdIsafas4DjjFKLlqrnF4SxrtRHujNd0MQ4V1MgduAYJkzUFj7e5Rh+kdQ8Nw5HWqzQM8zVorN1ELbifyh3eTMBOIqhn26zrdwTsFQ2le7h6OjKzNqJ12vtIwalp8OU5OOwJX1nqIal/euHHkgQbeXno0ko5m7Bm82kflvIXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:08:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 17:08:26 +0000
Date: Tue, 18 Feb 2025 13:08:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <20250218170824.GF4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <d68ca2f38f28c50a3109bc5a84716ca79bc3d7f3.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68ca2f38f28c50a3109bc5a84716ca79bc3d7f3.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:23a::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: c507efb9-e3e0-4f28-49e8-08dd503edb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ho/9/94pFcsJdgyzozqA5RFBXIm0BaTKt61c7CLK1oRn24llKhJBM1v7TduJ?=
 =?us-ascii?Q?9BwIxfNjTDPaRZQtSRxmbjNVlc35irJKR4dghU+w2Ruo/facxJ4jbAEseejk?=
 =?us-ascii?Q?dG1JS5S0XAMiuPLYHQCAB8Nh7kl5lPTHLpBpEwdXHKBx7lZ30sZ4/IveS5aG?=
 =?us-ascii?Q?GF9nvFMYp+EcrN0HWlf4SYnZeYkbUTOYjRWaoPFu36OY2o5y4qlzR1pbzh4C?=
 =?us-ascii?Q?SAygd11caux7uNIWnlffaLXOGKyBZUGox9uBtRLgGcDTMouNNvGFlgXtPyVq?=
 =?us-ascii?Q?qgrQHfPk3dJ5yet9UoGq0K7k2EDEd4nlkKNco0+dTEKJhECYTQ6/YW6ZUv1c?=
 =?us-ascii?Q?0Kx/dL4mW175cI075yF3uVR1sfU3vyK/lmy6IT90W0UTPnt9HfY2jwEEECv5?=
 =?us-ascii?Q?HD3jY9vH+A7sd1/PNR9wT794YnxXJ9T8HvGaJbH+0qUB7C+tbJwdaZ0JEqis?=
 =?us-ascii?Q?VhWJ/b17xX73KfS8qmHFUylSX6jpe8o0R8tY/tKj2kFiyF/bmIOx44c1Hwe9?=
 =?us-ascii?Q?nKrFi9Nd53DJ1df+4BFtLNjXI6bZTbVJ2lORnmppN4rr+recsXKuaDZW39HZ?=
 =?us-ascii?Q?dkyChrXr31DBQBzLS0tx9HpKibatHT2yGI4MZGBUXirIY4EyLrJ6/kKt2GXu?=
 =?us-ascii?Q?Gn+5EVtViF16b59Lj9Jez3V/ZbQzq+6iGm987ua/dO/nFTvIeCxzhdWoH5za?=
 =?us-ascii?Q?0/XfwUB7vuoQpIrSww5jZ2FzB8P6VE+mr3CKS5mhYoLfMXqs/SLZURHgjvVg?=
 =?us-ascii?Q?xMvPnGM5cllvHZDw7TKH1JzEdUBSAHmw6eEpdtgNgg0+Aajt18lntMpClKuG?=
 =?us-ascii?Q?nee62LhqK5/scQJSFZg9B47RSO8LIHiAQ3HqlMzL+xyi1LruSKbfLzQHrjUV?=
 =?us-ascii?Q?2jNQuG72GAdE9X3CfzsUJMe9L4p3Ps1R0bxrIpfHuLlMIfYUvVkjJjB9Vm52?=
 =?us-ascii?Q?7AHBKxpDuN3h3QlIHz3+oV8E4ci6l8pMJnMPqE7MMkiEg8M6yuUlEle3i48P?=
 =?us-ascii?Q?0D7ukyj66yGbrftMJPWpDjGzsyzNFuKQtCj9n4iRDXeCEnQl83C7SqeowXzd?=
 =?us-ascii?Q?l9eaNnmzHA06H/JBtWAab7Zu2MQn6x6MP+b7EYAgLDKn8MTtdXsOMWk+JKtq?=
 =?us-ascii?Q?kSGz+JO8pIxTmaSKrC2ds7k5MGyYbYzfKl+rbYgwO50bfpMwKqfOohWKupwW?=
 =?us-ascii?Q?QgrdpMsP70kPXvRH7oe1cL2bSneGLVc0xeBJQW265Mrv27ybUkomGxr/Pns/?=
 =?us-ascii?Q?KSgPrj3+Di6LSMmVw+IlH2agl9wmvHkpX12yPo4yVespY2nv6mofwlAIFzJW?=
 =?us-ascii?Q?gclNSherZgbMgA5qbHMIu08JTNIueRZlViVllE9Z5SuYQdD+yjwQzuxZj1+4?=
 =?us-ascii?Q?QdPz9e0XjEuctjVc+59tnt6HGEPV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpMj6iVLUKR0JRPAmcR9RuXSt2Qywl30mA72HqUf3RE93+XJt7GrGF0xBTAi?=
 =?us-ascii?Q?dIOJ1ietBY52LQAVcrO1UjN64Kn01MRVysqXE/109ZTOfSRUshVHB15OmtGy?=
 =?us-ascii?Q?n2zvs1DDU5PO4NJ16YQ8UatruAHpNtwwYBnH6oWEhveRy/QyBTRuymI4b12c?=
 =?us-ascii?Q?eN5tUM7AodHsP7AUuBDVr0LZOjK+rQlocIN+iXU0DUgUmDhp751LOrxU45t1?=
 =?us-ascii?Q?UY4uwfPamMbvZGEuiW8sEkOOZPgi56eaJkjOT2zPdhkZf+ll7GfhHjvOs5jJ?=
 =?us-ascii?Q?svZlCUTtI4fkuxpJaILuCtU8zmwzfNetJhcK+3boHh2YWtHeU8VYyeiMFzO8?=
 =?us-ascii?Q?x9aOOF/FL9WPX1N4Ey+ISr6r65NpwH47q4J8uMqkLUnQ4aRYH+BpgiPeKV1y?=
 =?us-ascii?Q?IeQgK3RfGNVR1hCZbu8qE5xJAt/+VsrtTidBohu6NFg5H/+wPvkLF6Fvwv/Y?=
 =?us-ascii?Q?09E/lMUNAw/F168/Eci7ufAOCy3qNuM5QMcmfD3phKo44+sufkI1u7U8st/5?=
 =?us-ascii?Q?R03dAysDgvrolze5Zv+syO1EH9TCudwf60eRvaj7LAErbyNBM0E78xczFfeK?=
 =?us-ascii?Q?YAXs/sJlgeuwWtpQaPEVVgl5bAphON9hKZDjJLRKwKPIQqz21/XSnhttc8Ee?=
 =?us-ascii?Q?2w1dyllng777pQbuwjj3TDycErPHoGMquV05Ku+0u91Kk+6NOZV6ATxzrpt0?=
 =?us-ascii?Q?2wfUI4oQOeOKA94xOWsEPTlZvLnanWjETVd1Y6/HEskUldT0RGhzTX1O9BrM?=
 =?us-ascii?Q?wHLvhPBnwpdEjyFXQhED73xD2QKFf/d9n1CPEE7NfZf6SZhZwN8XDcscYxFR?=
 =?us-ascii?Q?37/T9zuztqNxiCliciJN5V3B/RNtjh5TABaXjNk3ib1fLZoocxbWnt8b2Nbh?=
 =?us-ascii?Q?7hx2ivhaTjBfn6L4Xi6yW0HcTDw1sD9N8loThLgn6FOlWOCBEtS6/ubtjnsI?=
 =?us-ascii?Q?xzSl5/ZfzdBtwZ7k3U4qVRfFtR9qihmmUhL4SN1si+a1gMxshHFyBpRmnhXe?=
 =?us-ascii?Q?Un8aOGdFNJbXWnh+dqiTnoK/0NnWdfVuxfc3jxu3+IuJW0HfsunxHvg77yXd?=
 =?us-ascii?Q?r7jwjKX3oVt5IQtgdRPkYqb5iwdI8zlyeM/JoSoijwUqoM5gBzsT34lI6aq2?=
 =?us-ascii?Q?oEbZDjKyKluxs0H+p9jn86wLblBFYPR//KJGQ67qwsHQ9SSAuxbcEdpZln8c?=
 =?us-ascii?Q?PUelT5klYjKtHqfG3ALQTEfix5NMWScHg1hiqXC+3fqZhP37KKzvb5DJKIOt?=
 =?us-ascii?Q?mfYk5bwVsxZbSEd6p27U6h0d8pmAH7n6yI2FnzXa24T432ScGggBShyzGmJE?=
 =?us-ascii?Q?YtO+9qbsh++Eg7pbypOQf+BqOJdQ1iBYF0dXz+KhrK9DBCdwksF/vJoi3FOR?=
 =?us-ascii?Q?N3PYniunbt+Mnkb5qDpVbjpkiPsLhA6LA3veJZ/RSTHmftb6RsAi8CFDU5i1?=
 =?us-ascii?Q?atrM5nohEx02NtbxSiiDPigfLYCfRZGQW37PRJImwupo4Pk1vp/3qXb5cuux?=
 =?us-ascii?Q?ygo5P8mAaGGQ726adTtStfo5Jrpnw7WMYoPZfYhOirEspGU0TMYyyU+ibRp+?=
 =?us-ascii?Q?n1gA9j+F9xTXU/Ni578CZYCPEE8WTthOnmSt4jq4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c507efb9-e3e0-4f28-49e8-08dd503edb56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:08:25.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiUjm/FT3k3mn7fQue6giFf7wk/iJYwDNROCzwPHanC/bhGkbF+Fsf1DhXUza5LY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

On Fri, Jan 24, 2025 at 04:30:41PM -0800, Nicolin Chen wrote:
> +	int ret;
>  	struct arm_smmu_ste ste;
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_attach_state state = {
> +		.master = master,
> +	};
> +
> +	ret = arm_smmu_attach_prepare_vmaster(&state, domain);
> +	if (ret)
> +		return ret;
> +	arm_smmu_attach_commit_vmaster(&state);

I think you should make this into just a arm_smmu_clear_vmaster()
with less complication..

Jason


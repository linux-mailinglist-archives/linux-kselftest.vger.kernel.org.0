Return-Path: <linux-kselftest+bounces-21214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC79B7B85
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3309D1F22937
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E644519DF62;
	Thu, 31 Oct 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="auUtfFD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2119ABB3;
	Thu, 31 Oct 2024 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380604; cv=fail; b=A6QS+ZmtHCwcugudYtyxorfMOWVmcy5ac8zYnApGbfToc59MwgKqP4jVlY5+ef8RXhWYmUmUMYcRylrAn3iGMBJKahJogp/khTB+M3ofaSpCucSCoSwQJDziDfyk0ItEUUvr8cdJp9C2w5ODV7zKtUOROP8IEF0QZqzaahvohsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380604; c=relaxed/simple;
	bh=ar2mPwMzQczu0uYA9obauxg8FuWedWZ4aa/Uza7iiIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ih2y5B5DNhABcvsIwqC1VPaE2XzvkOvMSeApVUN0ET41BmfTLCnCs6291nXSfeoX79wXxTaxFJy0j+TFi5ok0TIyb0XIJ+J9bhvR5Z8bhmaG2N//5Q/WkD2b+BP+RzVB4/tg6vWmnEo1tX+LWtjMi7PU0gyyXDcMQirfazG67AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=auUtfFD8; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJfqumvfraHT5mQ85G9lrD1STV92yhXu3UHKG+MKT1pb9tWXB2gybxJgVtYjAlzuQVz8E8eJmKydr82bT2ykh4fgJ0hQSRCLNnIBnv4F6mIy42Mbux0qqcry7ghc0qnwexnJ6f6ucutneiQE0SEzFYN/1XA0k8+Mgj9rR26oIP9k1IzJTBoWYXOCfzkGfCD4cJNwpx0lPHLfIjs2lGtdYedHbL+96dKG6A9i3N+QT704eS5NZW/sWhOSoc3hTxsV3wYsBBnGi7aaDlWb0QztoQPtBqRTSd2zRAsrsgvO8yJNeoi5MyXmO2YAXwRwzhEhQ0RuI/ISRMId/+KC08IV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG8g3gSRiAyGj0MSWV1fZTxdLCjoOfRQzy2pXuW8Ml0=;
 b=IHGqg0p13M6ffGFe5XEp7EIToeXIxsdmpjY0jYQA7jlm/XrFVZbDgGL+rgFAtbTu8ZhC10+Q7dRw/lNn33SGZgUTxC9wLbrdfX8T8ZLwka6yuXJfG2Csahhnsm5rV9un0nI08AFklrNigylDcFnJpw/jUkcBv3659jeRmBpEBXthU3yGK+KvjuxYG4x+JdaohTo8pt4q2t518DU4yG+i+awfbpMdOeIRO2qpNOT7EbQzMwK3TmVWliDRw5FWazPFHbAJtlZTcoUh6zZo7bxQHS6jBplXn09Vq2GPs8kij2gqB+0BGQrSf0JEO0CbL0YVPMtal2dOhqh/TsbXiPc6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG8g3gSRiAyGj0MSWV1fZTxdLCjoOfRQzy2pXuW8Ml0=;
 b=auUtfFD8IWvLGuo4I1mOczQG3BE4MvBxK5Bm+4bctM/rcg4rMTxEmQ9HXLh0rbxQx2Q+0WQLe6Mew8hGTEkfNWIBW9mIKM3DRFqY37dt17eSFCKKzCfHfnWfF7TKpOTCn1zFcMFyxhekIesv/7t3u8OwYF0r5xfZD2rR0qPMVjwPLGMJ1XGrPUcO4IwLsiO1nxFjzRuH3F82vfVcnLJ1VQuft60X82RFg0N0N+u+HF8sc90JAkZEhlsHhRfvcARsV128091Fs8P3NIVLmsUZjfhMdjfn+HI3PyywwKcnr2aQVL79EP3PfLQbuQKus4UiC4zPHIfyCRSH3RFKXsmahA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 13:16:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 13:16:39 +0000
Date: Thu, 31 Oct 2024 10:16:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, zhangfei.gao@linaro.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 12/13] iommufd/selftest: Add IOMMU_VIOMMU_ALLOC test
 coverage
Message-ID: <20241031131637.GK10193@nvidia.com>
References: <cover.1730313237.git.nicolinc@nvidia.com>
 <8188b47bbee49e071907e1df37a3af269bd840b6.1730313237.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8188b47bbee49e071907e1df37a3af269bd840b6.1730313237.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:408:f9::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d1cfe7-8c25-44b3-e53d-08dcf9ae4109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nHqUmXTHjsSE3OeF4FLulB+Se6Lu/bBPYioITwcT00mCdZGKtYkrGrEk3DDl?=
 =?us-ascii?Q?7SGpoJOVbazovyMnNQxHoTIdKBMdOFwQPHkjkUcBO0PPc7zVwCY6jz5J1qNh?=
 =?us-ascii?Q?R0PyOGGDypIOudyNow9KAE/K60okGP4MqC/HG/jwiARmFAUjkztZiWzE3GM5?=
 =?us-ascii?Q?XNFt51V2Ipam8ZZgeGY8OVRp2yYIRnijwlFJFhWY6v4IActBFCnW1NtPDAcN?=
 =?us-ascii?Q?RtATpMwryMwBAi/d5RAKv5AUEy3VkpLfAU+N1C8l/sypL3mn+ETFstRO2+GU?=
 =?us-ascii?Q?ne72Sl6ML32XgCPpNBfTdM0WiGGMjlMJQhOmwsy6+Foh6tTKThnn7UWYasj4?=
 =?us-ascii?Q?ckpe7Z60PFbmwoYMxCRY/TaNYm3waY4s5fDLoFxBRsBtdjsX5Aa94QIiL3Cm?=
 =?us-ascii?Q?4TOzzkFCDtOOIROb4w0XHoOmtZIABAUtZR7yENPcn/tgOCDGmjV/OpukzBml?=
 =?us-ascii?Q?jkrqJgORSF37VmZshkn4/hyEQQS+uPMjNMscn7MvGAj6yAcgwuiMQCs3FoJv?=
 =?us-ascii?Q?EgutQ36yh9+x3TCn8p+ziGIOYXMqUqWP/T96EBCCePiujkOv5xqjMGCfBxoi?=
 =?us-ascii?Q?1IGTwzRCfuW6v1qwzrYz7UbMXsYtuUPlD0j3KbBzhHgbdh9N3Lp82xVgQk17?=
 =?us-ascii?Q?yRufe8Q/3MP8nNzXk+6eKnZDWA99c8l0pJTycamReUK+pqmGy4LaPIovfI6Y?=
 =?us-ascii?Q?qVEsKvpQF9+oCS1mnZDxv6DxgB3iTDF6/o6qwMpFoHEal6Ujt/Nl8ue3SfJe?=
 =?us-ascii?Q?W9EAGyBIUtDUJTmU1VxM99ybljCb6Jxc88W3f6RVls2vTxSxvzvKQcRGIDuk?=
 =?us-ascii?Q?6j2tFOLDn/T9Jvto4Qe8gvT3CctHsyK2FGHIeWo/k6Haon732jq2Oj/jRKUT?=
 =?us-ascii?Q?6amoxo3ptE/QFM53nlEb4AjBDnF1xvDJKo/tHjkZOPFEkwGf2eIffb5Go5MZ?=
 =?us-ascii?Q?dZrQlGdX0uOI6kN1sxpd7DGsHkKUZla6lKez2wLJ/0T0HkpF2kM0Fh12s9at?=
 =?us-ascii?Q?1lSIlW7mb63s00nd0nq4SFZFNnRmLhnGY136MNR+eZz8LRpd7l8HLA3BoKTY?=
 =?us-ascii?Q?SufLifQ3rkvJI1AwqKFSGFW3YpY6w8+JdeR7AWkRj9jJz9Ff96vL/MV0tSGa?=
 =?us-ascii?Q?bUItW5mO0JNbY32MBh3oGGahShiDjUBnTAJa5lwaKvuz21nuUEc5TFHhugWq?=
 =?us-ascii?Q?kyqrL02ysJHZoHV1ZnwdBssU7fqC8bnvfsBKU2g30rNXsKJYEp85Z8II7ovG?=
 =?us-ascii?Q?52bzQRt3wUqhuv0Lp+bK6NjSXDoItilWKnb3EJlODN7SOMFMFNWWWhU3G/fV?=
 =?us-ascii?Q?WbypIahjC6CB/8lVEI+vxzGX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ce2WEcKZlBsT9gZa+Ay54WNxrEMQOVXLMoInyUyUc44Lnm/aA0IBG8kPBrY?=
 =?us-ascii?Q?HtlYSnMkhb+7rvL5Z2fIafScmrotqq8waKuSXzrACmDpTVXmxEJxe4f1kerp?=
 =?us-ascii?Q?JjM96fuU4M2DkS/A1MV9u31j9EBP5Ew0PCFpvzHjtM+yLCGpmaHlRZRZqbZS?=
 =?us-ascii?Q?JJqAINFdTqrtxXgSowcjtfNI4XO/H1RmWqcZgdgrcX8xo5RJ/rVi5Fzgrx8n?=
 =?us-ascii?Q?svRyLdYrVc+sEkkdzOrEc00YVWrB4xzwYHjcUBH7plkMA00xWsgAHMacirt5?=
 =?us-ascii?Q?hbnnPho0XgmuCTTYNPKxzGTlFYln3Brc7ihxiPOMtQ+vqniYknzj9LWxDxiY?=
 =?us-ascii?Q?k+mGdH81CbwxmmQLMlJxfw95MaDGgGBfqz62zJr6iIoYzyS7REnTe+bHMrim?=
 =?us-ascii?Q?4vEM8Rb+agT16/c40cqclM43LgFCxDjfJ52g20T1FwIgMJjpUUGn1VmkvgF6?=
 =?us-ascii?Q?qhqr2AhxdAmmK/CxzXB3I80IhyTl4JWgLviXLZbWMMTj7gL41QXnHz5V18+B?=
 =?us-ascii?Q?MFccHS6EpJsS9quxHmYcGKehE9BijCSOkvY9B1XcntO2wZQ6T5FdjZ9DrZMw?=
 =?us-ascii?Q?1/dhDN6zxdQjF8AZ+Nxx1HenhBm9tVyOR0wehC6jF4cYktq10bcFjImlD4Qi?=
 =?us-ascii?Q?xa7dUG8sSfr9ogikrRt/2cw+Y1sAfsmeH1erAZEyrViO7JjI2krD+aiYuPHm?=
 =?us-ascii?Q?mH0okBKPGFNrGUkRkARHB8ToTK4bzieILBt+Pp7PKQFMN6KcPK7A0RYgrmb+?=
 =?us-ascii?Q?jmfIOBrUhc1masmvxnZpobirCZj+lyUmf4eYwGLnpz+UlUIwNF2kSiwZcghy?=
 =?us-ascii?Q?9QyquDYvmbwMKcDZpMEDbig+hwNI5jHPoo0aFHN9e+Q6fjhrUTkrxbQ+/HtE?=
 =?us-ascii?Q?FjGZ/+OCZlsD3H4DYfz0tv7NYl5IlBVH0UtnSj1BQ7rR0PpeSqzqcmTtF/UJ?=
 =?us-ascii?Q?rRWIRJIomTMH/phYOALJQWJW0ZchoHfMxF2I4a2fwIWHCd1FNKEUcqPqx37h?=
 =?us-ascii?Q?yfC1TbcWDDT4q0HaBgd71TQm7L3qjWSqELvX8e8pfYEnOIxRFYHfcjO1fjRh?=
 =?us-ascii?Q?+zM1fQiNkV8UwOQBZK/uDUhzQ4Or0rkcm8PuViH+UYP+f2K16UDroEEPdJfo?=
 =?us-ascii?Q?kMOf+bs+9w4XHfKuqiDSX5+7QAOyWM5KkglGtOyHrZWJ7+uGIpux3hMekIkw?=
 =?us-ascii?Q?whyuXhESgy8V5xpy1jsVmGxxnWX0iAzeBDUgaXndxVl5TxgTzd6w2HRwmo5S?=
 =?us-ascii?Q?SzICso4217hB5D9AmI0im3eF/5KKXiCAmjQdfEBuaBZCZEHKKpelVP5nhWAu?=
 =?us-ascii?Q?mnp8MBfGbrCUF2EBulWQPQNIlfwSR5JpIT/e3jn3bKXFCmh5GNDPZiZblYTx?=
 =?us-ascii?Q?WPpzmGdapFzblMrMQ+GF/VPmYOa7U+QSt+MgqFEZEiC5dQ8xgm4IsfvHdTr5?=
 =?us-ascii?Q?ftnAyKtVqiMd8wHZsc7KGYNLwFlYKQQhjgKWwS886w3A5RfLECQ+RXhlFhLU?=
 =?us-ascii?Q?JKz6q5e81P77oRBLCCkuJJ+jS7OtegMCTQWpw61PJ1C74i3c6+nrao14Uanz?=
 =?us-ascii?Q?cxMxFWxB/YEGtGY3LUE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d1cfe7-8c25-44b3-e53d-08dcf9ae4109
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:16:39.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eug+bUXU7sqTjoZzX3Ii0IkO73YChaoA09HKiXqA/S27dvE/QqSIq2jQoIfkfapc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On Wed, Oct 30, 2024 at 02:34:38PM -0700, Nicolin Chen wrote:
> +FIXTURE_SETUP(iommufd_viommu)
> +{
> +	self->fd = open("/dev/iommu", O_RDWR);
> +	ASSERT_NE(-1, self->fd);
> +	test_ioctl_ioas_alloc(&self->ioas_id);
> +	test_ioctl_set_default_memory_limit();
> +
> +	if (variant->viommu) {
> +		struct iommu_hwpt_selftest data = {
> +			.iotlb = IOMMU_TEST_IOTLB_DEFAULT,
> +		};
> +
> +		test_cmd_mock_domain(self->ioas_id, &self->stdev_id, NULL,
> +				     &self->device_id);
> +
> +		/* Negative test -- invalid hwpt */
> +		test_err_viommu_alloc(ENOENT, self->device_id, self->hwpt_id,
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> +
> +		/* Negative test -- not a nesting parent hwpt */
> +		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
> +				    &self->hwpt_id);
> +		test_err_viommu_alloc(EINVAL, self->device_id, self->hwpt_id,
> +				      IOMMU_VIOMMU_TYPE_SELFTEST, NULL);
> +		test_ioctl_destroy(self->hwpt_id);
> +
> +		/* Allocate a nesting parent hwpt */
> +		test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
> +				    IOMMU_HWPT_ALLOC_NEST_PARENT,
> +				    &self->hwpt_id);
> +		/* Negative test -- unsupported viommu type */
> +		test_err_viommu_alloc(EOPNOTSUPP, self->device_id,
> +				      self->hwpt_id, 0xdead, NULL);
> +
> +		/* Allocate a vIOMMU taking refcount of the parent hwpt */
> +		test_cmd_viommu_alloc(self->device_id, self->hwpt_id,
> +				      IOMMU_VIOMMU_TYPE_SELFTEST,
> +				      &self->viommu_id);
> +		EXPECT_ERRNO(EBUSY,
> +			     _test_ioctl_destroy(self->fd, self->hwpt_id));

There shouldn't be testing in the FIXTURE_SETUP, it should just do
enough to setup the fixture. negative tests/etc should be in their own
function

Jason


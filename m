Return-Path: <linux-kselftest+bounces-27795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B390FA4890E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 20:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB49160E7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 19:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25893232792;
	Thu, 27 Feb 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fb24FcYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C78BEC;
	Thu, 27 Feb 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684814; cv=fail; b=SHlwZrpfY5AC5eel89QVE7vbEsfrNXUnjZefhgXc3tLDsNdLlTlCEnLJ/2MuBMs5ow6VMT5K/6zy8Y4gKqegBUADuUq4rRtAnGMwd7eswapeyeaNWhCbMwaDZ4w/eLipoXO5ZY4S/6ZlRTsr022hKmwYZrN99qxA2PrNO0nZch0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684814; c=relaxed/simple;
	bh=Mi46qotYVYla9rqQm7SuQt+r6noptPFJgGL4wUnmVvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIqMe6Gn12hfxVkEkjvmeSplj81inMpFn2OMdxLPe7v0924UTtmcKJoZO7oXA6ugmXejac1sJGUUXDfTCWulgT4CSYtxvzxN4wQ30xGt4eMvs0PJrRjT/MGizCL87+BiUsgY2BYYDh9TaiR81YZdMiSBjKrzpkhu+RRsNepfP10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fb24FcYV; arc=fail smtp.client-ip=40.107.101.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge6PYczU4xGoHgvRcGt6ylfBZkLmlHDCHI6shF8bjrd+xqbmkoJCUnAx6+2ym3YK6b0XEexNJmVwezEA51X9YlGTrWhFQcHntTlfB6j8qv7idIHrMaAiPdXGlcN5A/2uCqH2SskN/yEfj/o0DKnEupf4iKpAX68FRDT5suGTJWdF7MyFI+18nfqvsoKc7UyHoEWNlM9ZfiIAwV2Xr3wKmCkDK3eN0j5Ma3SkC0AqJY5H2TBOJ6cM/zGTyE+wmNFn5mWbD5D5AWhd30rq6fC8FC0exPeJnfzW0uxb0NfJFkLSiCgMwyOPaB27fJI7e3kDND6xh+aFZBRMpFPdc+FtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9ExQKJQgoa4Cjhrj1P3hV6O16SCXn4QJ0MQ1hxWQTI=;
 b=tVVv5A88dsVGNama8E4LXHdhLckE8qb61JP3OO92qvubHhf+7BmfXxYU8vxIq2nRqtqHF/3dcAF/CGlEaOz+vL8E94zHX/XQFj6U8Sk/QLqcWRIQqOffig1IsO7366uUAO6adXYQQ4B3hqNIwZnWsO7C9RXh2IBKaHILH1FZUS+39VMlttLMmKdRg8H93i82RCvMz7uQgJVIF7UO3sn1jNatLfK7H57mit9uKJ8/Dm+6TLSyCgxTJhPpp+OYknix+ivLBHjc1ipoLeAcGUeCWnx8/dJBF/q5GxIFAA1kAw1OP7F+CGRxhLwffX0UFH8QJToQrOu0NJRva14idam31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9ExQKJQgoa4Cjhrj1P3hV6O16SCXn4QJ0MQ1hxWQTI=;
 b=fb24FcYV8VODBoDW1Zv4xGqdOj5VTuMeiJ6P/wEEYsTQb4o6eNR92a8NKkNarAFdwUD/6JEFaKB78QDbHWLgVKcXhlSe/+Nrd/eYFj0CtotYNPVXOoXlU9uWg6UKouxuWVeHXH7UW4VEQ7CD9OkAzODrEz6NaVp2laG7geiLC8grwhp8y3v68dHVHmC2lImHfIhfVZmjHmbMHwRstvo/TTzzZiFMQ++XZPuVVp0Zsa3KMI37sV9gVNyzaRMUIdE//HhGSivoBF+6VzGy8nmxU9JRKKCWxd21azjFK75uq+jmaiFoxLWOpRmVXehQLndaQjuHj0tYfW6taEgUqUpAgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 19:33:29 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:33:29 +0000
Date: Thu, 27 Feb 2025 15:33:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, tglx@linutronix.de, maz@kernel.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 6/7] iommufd: Implement sw_msi support natively
Message-ID: <20250227193327.GA73187@nvidia.com>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <e13d23eeacd67c0a692fc468c85b483f4dd51c57.1740014950.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13d23eeacd67c0a692fc468c85b483f4dd51c57.1740014950.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9bc213-71b6-4b9e-a1b5-08dd57659caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wy5uOLtxwWZoQ/dspD5BiyTlKRY+jqai2qBCJk30dyhsOPYIuEiL3Sv7qpB6?=
 =?us-ascii?Q?JhT1K0RBqsquRGHZ/ljSQxjmq5Hot256e1iYy+jvSc4QBMxEsDNRXB0q6CPI?=
 =?us-ascii?Q?ghnhmEBz83mgCOvvSvpiDtQsO9SBYglWDpM39gNmrznq3tNocXkIOaOIILZR?=
 =?us-ascii?Q?gqDAhP6FI4TqsfbfGFztjmo4yJ6At27LXeQ+usbrkhbRtLbzOnwXuT9q3HP2?=
 =?us-ascii?Q?tc0p0iUEgU5LprfZ8IcO4BhNRfmpJ7aLLzr/qRls/vVMuMpV/Cp1R761kPyy?=
 =?us-ascii?Q?vbR/LgF9Tvc0JWDb2Ep2ObYevc68Go+UK6PylTIeXfZylpWgvW2DNQLKuTij?=
 =?us-ascii?Q?0xforE+KPoiiD+JAMS0TZvszZSccIYpe6PpZ7WQZNuKqX+HsX4o0tm1WueKo?=
 =?us-ascii?Q?d5gm3l9FCUzW6dRB7RX81kNAADnlp4dhp4GyAIfr18OWjENl5dS3QpNCXWWx?=
 =?us-ascii?Q?AhieG+YJC+kB/nJgsXYl5pugHlkDmZvj2yqE0SMQwKvlDzd/B4Q3j3Z1pro8?=
 =?us-ascii?Q?0JL4ruVkNUNAt0ZGFpNJRjPVPDhzsE9iWj++PQIVXso5Rq6KF1ybDf8nSsWC?=
 =?us-ascii?Q?31Z6sYqNeoWI5Dn4lvE1t8Fyl1o6yh9Xbu6pC5GrzDbXLbfmQYlSwg1hHg97?=
 =?us-ascii?Q?MpF0InZrqPlLo0HJht5oYgeR39KPJFzFLqRDEyg8/NU2mjuiT/PJEe4SofwU?=
 =?us-ascii?Q?vSxciMIp/GCNTTaTUtxC0hYpmxoqXhY1K6req9l/eINwF811edak3K6Pt/ch?=
 =?us-ascii?Q?jv66gFF38oiVEebTRbdgMKxt53pZL2kd9k36/K8Y2DYiH0EX6pmtuwwbClPy?=
 =?us-ascii?Q?u4p4WSFuQrKge+mSx/Wsm6/eRjFsLm7T30hmMgKUoO5PghjJMX2UrOYDh03L?=
 =?us-ascii?Q?hCZrVYp+gXVhS2/EYMBdoU0DTNnAvXoYE5BSm+7lDxLZBWKh/RJFTakqJm8v?=
 =?us-ascii?Q?Tt6S+Vp9xcXnXZZZa3FayIrMACY7khTxjCpO3BU/+IB6sTrUcsVgtFA9dV9Q?=
 =?us-ascii?Q?TnbhQsKcqnWV4CiAqsxDDcpmzDbX1BNKQtOaMH0tCD4cTlL9mn8NaXMJ7eo9?=
 =?us-ascii?Q?UR1uAuRsSg2BpANvgc167h7VuWwlSwb8EzpuNxdBG3jjJxtfgI9Q9A01MIlR?=
 =?us-ascii?Q?+YZbqvbpcfXhCA7ezLWCkjfLfyDakbbuXSK4g4OSOXMdsO0/aiKq6dCzcmEM?=
 =?us-ascii?Q?5h9Q9On+OYyaMDbJ7jHxOO0rkFRwpsMuDiqzcH/rsb1CzKG9L1xVttDOwBaL?=
 =?us-ascii?Q?S2gURTL7huNtF3trBYVvItfBmqbDTCy9zqQPfNVPbMKO8+p+Fr+1AYQ5eRxb?=
 =?us-ascii?Q?APgWWEdbqvvEHiOM6qnq9FLwyVtSyVAkOJCsv2dBUmNcYK97CF+aw4bb2WLi?=
 =?us-ascii?Q?j3su6uGGhi2sSnEMq6GdNmOXLQjW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o99aCfS3a9kMn7iwEejRVFr2G3Yb4L1Y49xqXaPHwoh524YnPzbFbNWYZEBB?=
 =?us-ascii?Q?4qacU7y4GBDvfvES0L0fthNkk38053dP0GlYLPbxe29efEvuWz5SThESX05g?=
 =?us-ascii?Q?4aZW3PHtnjIB975d7JcvwqXUJz76xooL4QgpQ/bQoTghFp0PYDSCtz5XgqfY?=
 =?us-ascii?Q?p8/SU9y08dekmgVHeC7ZeCAZrkppgARPF91B2ecf2qaVHO9yZ0qrv5yhDN2Z?=
 =?us-ascii?Q?keEtEDJO0HZqaNMKA9R0Nct3M5lxWnnzxlFHp5kzKRHMsigxJ9nx3bRSx21y?=
 =?us-ascii?Q?ufgbDR/8g5pMgfufUzokjOjdVduf+NAsgfpAfGAChkHmTewugY4I8xhFFjt+?=
 =?us-ascii?Q?bOGXHZ73bNtrz7qcsLIKAFUUDMr2hnvxvoJ2kF85YRBEFvy+SlyVeyoR25kF?=
 =?us-ascii?Q?04dN/CnG7HVhbzbUiIFITiwZForq8H9/wF/A6e3qo/BFRYX2gbkN9jYxob21?=
 =?us-ascii?Q?kN0Z6De5417thnAzxV2NWCLx3PH7LfA7Akaz+Ht3ohPdHwN2kyAL2UMUR7jj?=
 =?us-ascii?Q?hj70gv9/ADJXKcnZUo6OY4fvs32CyAL5dkGmHvmmUKwvj4nvthSWrr12n8K+?=
 =?us-ascii?Q?7uq7xBPi3TY0deFBysLUe/ddl9xrepolGOh+l62lICaFXofNhQbu/0gDXEhc?=
 =?us-ascii?Q?p5y6jR0an9BxkfHYG/jxOKeSmj1f8pzPoJV4Cemzws5RRyhIm8ZwqPLmz+Xh?=
 =?us-ascii?Q?B7fM8KQQ9CjjFX8iiBxn4fJyr/Chpsz/37l20sm2rKlddrKWHtFn5Btdjgvi?=
 =?us-ascii?Q?Iq0uj0Zss80txComSuDzg1Pnbj63HuTYmiNl6MN4iMNsS6fw52cPjVxgKg1i?=
 =?us-ascii?Q?/Md2GFEQp/sYX8D49bBA30tYsfyCCTqf5RdMGUE3qMTppXZ0/tQ96hEB1RhM?=
 =?us-ascii?Q?GsM72VAqng4Vh7+RkRYo94wkknpJFfzzmDM7pArnTTZptVreWB8S5iNXf+CW?=
 =?us-ascii?Q?njtulz8vY81Jqcf6I4OL7pMsyZX5UhZGKDXAuioeXskBG2ciUcOAQg715Iy4?=
 =?us-ascii?Q?M9LYii7JH0XmTayg7qFNVRP8iVAgiHBgeqFUhWV+xgWV4EYHb8ygXKydg/Wn?=
 =?us-ascii?Q?PE6OuEVsE5lVEcMAaSoy/lJ1bihCd/aam/OM1R/vSU2snOQfFYYJQnj5ousT?=
 =?us-ascii?Q?L9sgPfilVeTCIPiINSNHYHSIBYDHygoreqaxQfEjEkX4A5Xz1xHh9H/lKjoG?=
 =?us-ascii?Q?G9QimreEdwoeP8/lZl/JSaP2aFONCMgSx4IQ4ayVa5NrCrRVVkcaEsyCd1Mm?=
 =?us-ascii?Q?vUwfkwHF/i/L8plA2fEfRzxhhAjnQGXwnzL1UFOGGvY4yllxtk1w7Dbnf2Cx?=
 =?us-ascii?Q?o0VQBSpgWzkK8yyHH9urdfbX04bgp/bPN2gvbtLcqX369WlCx6lpvuuz6N1V?=
 =?us-ascii?Q?zPdeOZNbMmbhnvyeHDsz7HzhP4NTYbTwzW1vQKLKec/NbkpnlREOVGZ+a2Ie?=
 =?us-ascii?Q?iwzlcq0fRl7T8NViEa+7rRb8kmaVWlBHHuDz8FHF8ML6Wsanz+DLormDS/Or?=
 =?us-ascii?Q?mYSrXMI7FtoQr38TtRZinKQzPmGB+EC6BukwPKHOLdD7zebIuy9iIrdds+kq?=
 =?us-ascii?Q?ThsD6YCENbDFoiAxen0deZtgVoFrGbnZrQwNoMZy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9bc213-71b6-4b9e-a1b5-08dd57659caf
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:33:29.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahxFuxbYTBMgjzpPEYcb9XSZw8vq61EWx1tpXJPtbqozpDG9pngJV1qwqXkkJggd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

On Wed, Feb 19, 2025 at 05:31:41PM -0800, Nicolin Chen wrote:

> +	cur = kzalloc(sizeof(*cur), GFP_KERNEL);
> +	if (!cur)
> +		cur = ERR_PTR(-ENOMEM);

          ^^^^^^^^^^^^^^^^

> +	cur->sw_msi_start = sw_msi_start;
> +	cur->msi_addr = msi_addr;
> +	cur->pgoff = max_pgoff;
> +	cur->id = ictx->sw_msi_id++;
> +	list_add_tail(&cur->sw_msi_item, &ictx->sw_msi_list);
> +	return cur;
> +}

Dan pointed out this should have been
  return ERR_PTR(-ENOMEM);

I fixed it up

Thanks,
Jason


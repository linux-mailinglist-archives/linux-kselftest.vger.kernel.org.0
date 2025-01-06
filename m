Return-Path: <linux-kselftest+bounces-23952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F205A02E77
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 17:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FB5160D16
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80D1AA1F2;
	Mon,  6 Jan 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qi3v54Lx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6938634A;
	Mon,  6 Jan 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736182750; cv=fail; b=ajsbZ5wqfQTteq73mvTWVYNCWYsXf/bpsRM+h0ddN455HYC2fuz+RC/Uzj52js3thTzMkaR5FwNBEfyvdCOVJs6twH2nbwxUWR03eDsA2vRjuAv/RK8sWVxOCcxNwekdqAsg1Z6aQrSPi2RvDLAsbCknksak/lNgvNlEO61S928=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736182750; c=relaxed/simple;
	bh=dtJhWfYbo0Uty2eKtp6dCv/NScK4xdJ1ToUXlJQIS1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=baXrre0vyCkbpPFdrx1xvWtb/aANr9OZTC4/Gib9DqPW4DQntWz/9S0I6wx7L9QW/rsdAwYxrzExpVDph9ZJTRDwFAcb0PevIfFXB8WBXpL2IDxZw+n0HxXckQBAWUk+8D2hyJw6PN5hkE50JX5u+oO7Mh0LeeVUpKfBBf3rDy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qi3v54Lx; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAvJUy0HpfbG1TLwzbZnrUNSflx4c2deAzRMQuofTubpGcypsDjOrVzerNMCSMoPo4QujmDY1BIODLw76v3a/gFeMmeWreuEdw1w9ExBRveBjGak/2UVKryQpyPkWvBBvRBPBw+d0dBRqG1GG3HqDezMbCbTuPgRlrwpQ5++22UDltR8lIjEg1UInPVgOHLPtuolUvwpZa8QeNG0pyvumIimVRznNo7jCOMARjUZm3pMTl0c1oAwjFV19aqwXT7TdmAaWJ7fioN+VGy+puR+ghQaqu3R/MngKDwTWo79vwIVlRB5r+tI3pyjH7jsvHoLRhS7NfVkwkGlx7uaovyeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slJGIJOWFszQRBEioTpGfhmv9ZZkbVjeUUZrEkQzxfI=;
 b=UhISfMD1O7yzHuYoCAprB2DyC/KKp1O1qObIw6X+qopqvXGwlJmzaKcgJUTbTf6hyqtiXvS4iPOsR35Zwg960u+/mURxaCgG4CSVyy815rqgE+/uBTooWgi1kxqMTCV5ayqscTZEsclIwhSktUsw9TSdrJOw0WBk/VtVIrnjSXbOFcXcutYmQ/wNWCdZM69FgZBXXBDlj7dUi5QLgSYmdXGIjng8cVS+62PayP9nxkhgQDBzXtrFq7lYoaz+zgeoomPwjK1mGCv+NNIe4zv0GjyHWEMpzZ6yDj9h0kI3juzw1rgvP/GqiaXc0r9ON+DsNhb/+vqRKpiAXtIV6mBw0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slJGIJOWFszQRBEioTpGfhmv9ZZkbVjeUUZrEkQzxfI=;
 b=Qi3v54Lxg/mKMSYmZF6/5vX2QzbAl4THAvRX4n3Gvlfm/jjJoBwgQ35ehJYLiXNH9z/F6ophhcB1HDU8FnvvRFUhFlw2zUKpqxGga0RHWJl6AEevBR7jo6I0fDcTzR/a4TuMty58JEkPuJ3rq2DApMJfQLjeckfZM7NqWWaRtSrveBdo3sgd0WinkpgEQi7ykCPsKHXkNNJTtrXhGobDafjC+vbnWvA4qMTaRUkGteLx5GFcTcVIdGMynUWeANgzmGNLN7lnqSMUvzVBmmfsblVUD6ioLDHIS0PO3PjdgvnBXr9kw2Nv9g1LBo7zUk4Rll2y3E9ddmG4Pc29bgXxuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 16:59:01 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 16:59:01 +0000
Date: Mon, 6 Jan 2025 12:59:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, corbet@lwn.net, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v3 06/14] iommufd: Add IOMMUFD_OBJ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Message-ID: <20250106165900.GL5556@nvidia.com>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
 <20250102205246.GG5556@nvidia.com>
 <Z3dZzXblPIlxXEQ+@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3dZzXblPIlxXEQ+@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 5988908f-6a9b-479e-e5f6-08dd2e736b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jaP3Tdgv8yVBPIrODpietYHmJzF2hxvp53WRRdb9LOd+ghSO+FMzZd+eTJ3z?=
 =?us-ascii?Q?Eq1XDTxqO0xXSsz3E0sTtEd+mmbp4i5a7UL9FrEStkyRqusp9yqnujhfgZwm?=
 =?us-ascii?Q?wj8KcOz4J3cX0KiwOkISw45ucH4eqWgmoVVZG2RFtJCneyv8fJnUKeQhkEvd?=
 =?us-ascii?Q?eCIHE8EEfftbu4Po3IW+8o34mHNPwqaXz07UCiK9RPyTxaRQ1rS5DgywF08l?=
 =?us-ascii?Q?+tsi1q/uUOQ21dKafLz5a3RvKUcstUnOaoctNwmT/iDhGiaySIX6Yb3rxdMV?=
 =?us-ascii?Q?9kkkzetZcasCdRbxxKab7JxiGLPzsq+LxsElodoa1BXLEfvK+03bsZtE42Zf?=
 =?us-ascii?Q?i9ES6CcnjmI8HQw8oyfXURhvDqKPOT6OJmRNaMMMWdKCB9ggsN+Bof/lfClf?=
 =?us-ascii?Q?BOXPcKuLQaU7yaQFZxhjxkQZSF5Og1rFbHeHrMhDUup5kp/vSgiYUVaQz1wr?=
 =?us-ascii?Q?UwG7HWByHSEb9JuCJxyCfpMkVLyBKRgqz0nRwfOjybKtUf36588vIX75l1Mz?=
 =?us-ascii?Q?NBmFZRHlVyiniCA/gFbwwrjs70x9rQDjYuyCd9RrcGpHkdt7HEbcFwOPKZoT?=
 =?us-ascii?Q?1Geun7GV2Pf5iDuonCPAr8q/QF3pff5LqrvRbQv+QvBOEf7Al0wlGEx8YUDE?=
 =?us-ascii?Q?lfFR0WVqjVzxG4ewH1eVOYx8LRDS8pyyvJsXgHQ5s3VuAU7vXwp+OtDqthP4?=
 =?us-ascii?Q?107td79tVfQ8tfFA75tcJ8eHoRIgnOBtsPwUfTqgpCYoSBKJPsm4ENVgs1Mk?=
 =?us-ascii?Q?2mQirFgqkZ5VHh0qoRVTOxaYjTWhVG4BwRNtEdxxnOK7yQ4Dkmys2zzWZseo?=
 =?us-ascii?Q?S5gOWjKHmUbX9Ad6UKRKWQgvl5FK5H81SHU/YLvr34RAbdTDm52bXV00J1DI?=
 =?us-ascii?Q?sURiu0JBnvq2J2wRNLc5Jdj8/uKFDFR6v6l+QOTh1TO1xLZmrOBhenzAJotJ?=
 =?us-ascii?Q?Ze3hPJJQvVnoInQtxDW4EE3DCgYWxbiAFuJY81tc/U9VaQIpnsUpV5RgjnkG?=
 =?us-ascii?Q?3Lq/wn2QAcUzJ6h98/jivy3SQSJy3owq7QlueVF309mMaTTz6SR2ESpynds+?=
 =?us-ascii?Q?IRxRofvqQ6Q0uxh3impt6k00ExJQyZdfquUcm/RxAqJ7NbybkuDWFE79PBT8?=
 =?us-ascii?Q?l5OpCwwIMR7ZIygn9M4uoa91UWxrD3dm8eKtHTl8jQfdXV2rocXR1/tEsriN?=
 =?us-ascii?Q?qkwqGU5JsbYGXwNs84rbwTXU7TK13H1gF3T75EjYeFGgKHkLqBsfLrBQeAUw?=
 =?us-ascii?Q?VrHY+769xukQ2wAJzoGVeVGIU70/PWbiVzw1ZXCYCxdGTikEMasMCsUIi+MR?=
 =?us-ascii?Q?ukn8JK/Z7cOntD0swDCXodwnxlKtT2lk3zMMGtSNt4FJ4Mxxo0FMoOAJbl81?=
 =?us-ascii?Q?6HoQ4A7UMV+D9sIZaa7k/L2IPWyE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xt6xMINQ460DJEEeLt9ja9DX3h2Hlko9MY9ReFiqAYsXm3wVHLG9ryW9AfQU?=
 =?us-ascii?Q?LFSDz3vQgXmah5LHqif6L3WWzRClR91N0lzjoGX+kPLPGXvNajraXgfuFFtj?=
 =?us-ascii?Q?mAOf/0if1ObhnE1JZTEnrvOOxLgguKPxN2CD62VfxDyXXghby1//8JvZdzfV?=
 =?us-ascii?Q?BvIIHyI1nKsyp/j97oFK9SU3gXjvn6s7+vt+0UjM8SCAiPDc2Hsuy61SMfor?=
 =?us-ascii?Q?ZoOXaaTcNgH7Zo7xnELmNnfBPoeJyK17h6UTnJQ6nGCPrxFixwwErdPJ7I9j?=
 =?us-ascii?Q?zxKvguxiXIl5mFU/eoWyojcyaxG9Y1OPG3rV0o4TcyNNqrgxvZMuTPjtcsdW?=
 =?us-ascii?Q?Pf9iRcm7sQ3yhpeSaYatb9Hmnk3cUzHQYzouvN4lUTFiSArtfPwqS/y+9Y/l?=
 =?us-ascii?Q?D+4sO47x+dS7CMRE1DuNguFPWe7HAOOU8gCmedzBCar3LQY++pw5gJZaS1pT?=
 =?us-ascii?Q?KKntwIf48yVvAQ5oN4gfAtBUt+o1pfbhywXW/IUJPYpjO8obxXUTM/XHflPR?=
 =?us-ascii?Q?Slg0ucUNRFnnG1+4NcKcYlVfXiP1YhLePxNBg+IXDyBwbQP5Tge49UAppFSr?=
 =?us-ascii?Q?oNRqjSemjuBM5UZXvSAK3F8j7+xrfCVTyjKjBzYHzakU6xuVSVRRwLEIbXg5?=
 =?us-ascii?Q?B+m98RfafdmuZAFMC3Co1KGZBgTRMakDtRimTiqOxu9ZRO54un6o9voWIQE3?=
 =?us-ascii?Q?y2kCqBhvdJT6vkm5hKkHEi/5s8AC0rAfHnL4eTsE8nAx5F/RAxqNI7m3a2a9?=
 =?us-ascii?Q?aXpJPY4/SHXrfWJwzrERJ9OiUIud6ABgZL1/OZrWS0znYL2mHiZqKWc4QVHS?=
 =?us-ascii?Q?sTBsaR6B/tJ+rs523Ey0e5DV4or1VU8ub4MKekEX/q38JZs8La7V5XQgbJRw?=
 =?us-ascii?Q?PXi3rB4+dlVsxpRgZEUz3WD3/SaKN35fqy0KP38kEq4r7eJDCf/fKhYpQ780?=
 =?us-ascii?Q?CQROFGka/OBb2udwnQJv5eryR2SiptQL05YlWi85LmiUAxv4gKprupahhXQ5?=
 =?us-ascii?Q?h43Yug8ovMpM2Y7km6AQVb7YpkL43bDwRq3xk44PezBeH6ZGCa+jZgqCXGmN?=
 =?us-ascii?Q?Eu7B7jEzHEVXlYzzDP/5tZzLq4u976HwiEWSfeaYybVBFO3s/qUAUaFJAsi1?=
 =?us-ascii?Q?ybezLEhic7BogaUNq1PbW08lytdjHXsMvmuT2ycJkpva+1Hag/oY1UZB2ons?=
 =?us-ascii?Q?a9QmSYaAjm6Veeh9pfkRjxvBZcdqfVZd8VqaSXqWJOcnsfeKaWO3wv9st0ZL?=
 =?us-ascii?Q?Q52l8jd27iSxWJO033LM2D1hQFZ4V65gcpZZIhEvYsyuYTk3019honFa7XBM?=
 =?us-ascii?Q?fj9LU2iOtcFBG2bC758rRbGxkuZ6m4Tp+vPHt5IilwOe7i1l7DDubJi0GvtX?=
 =?us-ascii?Q?t/oizllgaX3pHff8/g3zpdrs5PxAPxF3ECDt9ZJodp6ujOzk3A1+DJoCm1Pj?=
 =?us-ascii?Q?8QnpxPmio8iZPpFHk1L1sLAXF/m24i9hRDXm1ZJn4uf8/h3vU2dGitZhtGky?=
 =?us-ascii?Q?Kt3pgpcPXHQ/qqubnh+BtlvpGCOGutOLhWALdzRzdP8rug1jCjNnMtflECCY?=
 =?us-ascii?Q?yp/QdI9uwala1Prht1fU4mrfU10ID8HFK7oPVocz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5988908f-6a9b-479e-e5f6-08dd2e736b4d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:59:01.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2R1r6WNZKomRJH0VUm6vqRr7AmqtShUoxr4LyOejlTjCFo1LxMv162hQmFT/e/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

On Thu, Jan 02, 2025 at 07:30:21PM -0800, Nicolin Chen wrote:
> On Thu, Jan 02, 2025 at 04:52:46PM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 17, 2024 at 09:00:19PM -0800, Nicolin Chen wrote:
> > > +/* An iommufd_virq_header packs a vIOMMU interrupt in an iommufd_virq queue */
> > > +struct iommufd_virq_header {
> > > +	struct list_head node;
> > > +	ssize_t irq_len;
> > > +	void *irq_data;
> > > +};
> > 
> > Based on how it is used in iommufd_viommu_report_irq()
> > 
> > +       header = kzalloc(sizeof(*header) + irq_len, GFP_KERNEL);
> > +       header->irq_data = (void *)header + sizeof(*header);
> > +       memcpy(header->irq_data, irq_ptr, irq_len);
> > 
> > It should be a flex array and use the various flexarray tools
> > 
> > struct iommufd_virq_header {
> >        ssize_t irq_len;
> >        u64 irq_data[] __counted_by(irq_len);
> > }
> 
> Changed to
> -------------------------------------------------------------------------
> /* An iommufd_vevent represents a vIOMMU event in an iommufd_veventq */
> struct iommufd_vevent {
> 	struct list_head node;
> 	ssize_t data_len;
> 	u64 event_data[] __counted_by(data_len);
> };
> [...]
> 	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_KERNEL);
> -	header->irq_data = (void *)header + sizeof(*header);
> -------------------------------------------------------------------------

Yeah, that's right

Jason


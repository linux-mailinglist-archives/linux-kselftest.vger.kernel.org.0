Return-Path: <linux-kselftest+bounces-33126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B4AB8FFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0798501C01
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435BB1F4CB1;
	Thu, 15 May 2025 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KFOI1EM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7B9198E60;
	Thu, 15 May 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337585; cv=fail; b=MjoD68wU4/DzRNADsow0lwvAIzRkOvmIGmu7/m9dKy/jY08VFTUUb7aK368jUFxv+JzZMt9lGoJnoz1FW2nE2kAns0/K8Z+aleAYzbVGZpYv1uowdqG5v/aiZP0f18X0d9RHyN1l1Hq2/VSml/5lM/Ey44m58Fok7c1g8DX16Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337585; c=relaxed/simple;
	bh=tUMwEUDwT0jUGnbyuWM/7/6kZqJKFKvajMrgM8vWKGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdlwcQxj0MfAWPp1Aw+qGL6pK7vt3AO64FHEw+6XTj59OTwDIWd/IJx43RbHxBAUOzx9U8IjWcPimy9SSmcZZhvaadYd0nCkPxr8XsNTR++ZoMDenV3+UxVtf/t9ymtsdhlO4RLp9icqWxjhx0xRwkzR6kiIQMcxwk76MLkJ13c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KFOI1EM1; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3m5cjD6tqi1NRXmgF4mC5CEPxRpu3PSRQ38XldCPV1xe4P2D2FPMKGBMyu/cNuJffu5hiZLtjmeYkGzW2in/ZsMNCRbOr5TkbJg+Z4XbL+i4KieZsS3hwse+vPK/vxjmSbNgmAHTgVERryFXf2RY6gh7rIJnk5GJydfh0Rj4XYio0UDMBhU80qEcMWTz9WEsaRV/Ip7u2ZKNnedNDVzpFVwTU/Nyq/FwC6W7DghgYZ+LsrQQsUEyIGaThRUhvVBGK5+WGEeAS8aBwppckFB0B2dmQomPxsq2o+d9j+sTP3+BL/lEZ8Zk0tTrFDTUO+jdxDpQ+fCvyq6qhHfWthWlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdX7k+aNFP9sgb9SP+fIqche5ANtUTH4D6W9VLQeqeA=;
 b=aauN42yYvbzpJR3J7K5X7MI1DvG3VeRrW2JI5zT8M215aJ+8txD5mBjh9i0ogiW0H2V+qAwx1fqS6MAQYBHPObBksX0BXBUA89yt7N9B5KwjgCcTOnDzl8Q8WT0pFVSe52AFB12p8iZ9czpoxodIpReibga2GhNAHDVoEKaOlwhp7eAYOsaqatH0x3jZcaQSGqocUv8NWMBAddsjmhhWOaaGwXDpUl38fGrNkYnV7XlVWHig5+6FIcw8OEFrlNa78lz5Sg7UokgD+us50HpIj6KxIVZheoonviqF4OgDItJtZTf2S4MvPCU/NVPnuH+6jwA4ppPBX38lxHQyFQeBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdX7k+aNFP9sgb9SP+fIqche5ANtUTH4D6W9VLQeqeA=;
 b=KFOI1EM1AwknGnzupBIZO4KibhnbJw0VpBTbxwUq2sIMeHCU0A/TLe0zwcP7iTTeV2wg7xegWaJl8hvVAMbosDdGuNol4BeQ1mhbQoAXKoOobTQIxb1jKc3mUDDAvFIkXcO28SljvrXvyAZ3JKPC7Y5NrSZwLYyd9WVlZViNg+abI8uZALAaDrWesD+OR1/+IN/1qXaB7H3G2olCVYl1eoeRJ8zBrIo8n6aYU9qfvCJ87ZVtyM4ntX5h0PVUp5QitmoZ3534T1C6Znd/+HF2gmymTF1Eycfj2DHxd1LwyYXWY0IB9GrBntJUNTn9jal8RcFyizKnLSsMiIesVB3sMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 19:33:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 19:33:00 +0000
Date: Thu, 15 May 2025 16:32:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20250515193259.GB613512@nvidia.com>
References: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <3-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <pntkuh63y26rygrkxegbzncvc3shtplucrnzkkz2dimpkfyn75@uekvyuz5kred>
 <20250514155411.GC382960@nvidia.com>
 <2459f14b-4f4e-47b4-8f79-6af784ef6686@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2459f14b-4f4e-47b4-8f79-6af784ef6686@oracle.com>
X-ClientProxiedBy: MN0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:530::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 113cf348-80cb-4994-6545-08dd93e74d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yxzJLUjRge+r/inoi4Ty/P0vwykObURSaQnYOH/mZep/F7HJzoU/9/uQ8Di6?=
 =?us-ascii?Q?zdTNvRO01YMVzStvvWUE8nq724IJ8Vo5OLA83VLI0W6szFUpZ9HIPJI6DqO7?=
 =?us-ascii?Q?l/9bs0e/pb2hGrOCyp8kFfySMhvoalpjzsqZvuVNvS5jQ/jqOOO68O/Yv6fO?=
 =?us-ascii?Q?BiMht9/sPIo+lfgxV8tM07X9XPTWl2gKPlZZOY+InlY25d44z9x9YZ6nrb4z?=
 =?us-ascii?Q?kG2hpm3yOPO1GCif2oQGuJ8Z5zOAoZLFt2Vvi5MxdFSgtYeSsBD78ODPSTme?=
 =?us-ascii?Q?6twQZ9cUZwS36k+N9Uza3oxWs7noaGqyQIpXk9zPjCnTZcg3HNNoemOagZf1?=
 =?us-ascii?Q?pFicZKbc71PO9da2Nb9LOUzeByyhfQeoD3ViUEvvm6VuCd4DGNZOsuv66tQG?=
 =?us-ascii?Q?VzP/ndNK2qZQupP1RMF6q0xwyqqOh/IH5Ou9eh7SFpREi/Tl51Wv/zo8Jft1?=
 =?us-ascii?Q?vtS3tX63asCC19Hz5BEWSfVg4gSmW3xINW23OLOZMTDk4tgP+UBGIW+ll5VK?=
 =?us-ascii?Q?bwQE4mOH88Rli1zYTbrNGw41HStOg++Cy/fAJdNdegEeO9pr/lrg/brpjroW?=
 =?us-ascii?Q?evg86Pczsa4b3yexXHdVcPKo+ZJCiP6G8GaK36k8C58eXCAQt1NQrfLu32+E?=
 =?us-ascii?Q?PC01dxoB5GN36KCQE+d6xbBqFIFAAvqRT1+kRG/7lJJJbIX4hkzxJ8VFJcb1?=
 =?us-ascii?Q?T5n1DGJ9/6AOcqZu/ucG8R/ThF3AQgi6cY3NLKNPiEjJUW5SXvN3hhcls4oH?=
 =?us-ascii?Q?E/22G7nl/D0lZuvceQWFPF99IGuYZAg4ukpy1Rrfnrn1pqVvHXU6oTxfrl3V?=
 =?us-ascii?Q?D1iIIWsSucOW3JuPhuI/1hhDUDW8vOMtyil/7fsu2dIW0kD/2RwY1ANi6xVj?=
 =?us-ascii?Q?Y9NaovxiEHE3LMXp/uoWrhl19vjN2Fj2r6oIUorsfdQoKEaF8GoUi5ZtufL5?=
 =?us-ascii?Q?BGPUjonk/HneSe9GT6lcuhQgfR9fIwvAJGsRXrN4oS5M8TvLzSY5f1WwCEBM?=
 =?us-ascii?Q?O8dfsUBiErt7XG0VvMvt8NXJQPvy6iJ5PfkC9xzeVgnzX4oHnrkzUxN8M/xc?=
 =?us-ascii?Q?NtdKfOeymfvNpfPa4/1UEqwM9hE9N3AxXcfBD92VDuaB3VvLeI8ufuQ3mCGv?=
 =?us-ascii?Q?3BYx+58/tMYyiBp4PNENbs8U0Gdq8T+y47x2uOELS/5+1Oh52smxS02p2x6e?=
 =?us-ascii?Q?6ElFluIwtaAFROaP0mgwa3vObi7OAhfNkqoAghdkYXOEapPdQt8Ah2NtrtMM?=
 =?us-ascii?Q?X6t+B2mnaUoZv/zLUuPayBgGIfUi1Ts3HDPDmWMmAR4qyHdFfJYzT8+bew3S?=
 =?us-ascii?Q?ZpvL9NF5kuJuG2F2ZUziP37JQii8Y5Ydi1tHwNqHlYl03HzGLqq582RMwahW?=
 =?us-ascii?Q?hxkInLz2otzCP+9kQrFl59GPqqzklvrkH156kQujwyXLOIyTR7h+pTK/vDOs?=
 =?us-ascii?Q?uzu/Fy5lghY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e76ys755dho1GcK6CDbh7qvWPvy3K87w+HAE3K1puzLBCpIy608/ch7mXGlO?=
 =?us-ascii?Q?kkoiKkJaLGAv1Jq8HazoKqQPMIEWoh+kXxlTosX7MWeu2YX+VHZi0clzkIrq?=
 =?us-ascii?Q?OPhtavXwM22ibCYpcEZzXxFeLiqe4C43omyCX0mTXb18eUoSkIH3HnomNLig?=
 =?us-ascii?Q?reVr0G2kEDPi/YM+ToZHYjEhdSzLA0nW9GE52+H1mk2edrIX4CJqBR/ewKAo?=
 =?us-ascii?Q?wpbntvQE8/stO250sJ0BLgnk95leo2qLyUlYWjmLWOvRa6a+L0lxTchghnxE?=
 =?us-ascii?Q?qtCT/J5dQwcSQQ7HKCI2CjZf4jXF1BO4346tYj/YiL9yhAkqLqOG9NpYNGUD?=
 =?us-ascii?Q?fakL2SwSal2hDTKmOmv3xWorRV7H0frF6e61+lKjpumyo50zhez0kDf6xKg+?=
 =?us-ascii?Q?leA039l474uCyaNLAW89jtrhIXNdH1Nhg/4OdNYL2ZMu1V8YN1tmo0Wq/0a8?=
 =?us-ascii?Q?5Jh3KTTwyNbgHV4pIsJZpRuj0WhwuZyvmRcu+uKg5srjzf/N5KlHtSF0odz/?=
 =?us-ascii?Q?F9lMKMvgNdoqTUbTAgCYLgZi+U/2Q0cGlL/hOAs0WaZCvyCPeeIIFqrpg039?=
 =?us-ascii?Q?apz2BI7TUx4LKOUsAwHA9wV/5n1Sm5OJZZ9k2h7NiSqdwdc6LYYcrvK+6VS2?=
 =?us-ascii?Q?fULsh8nCrWBnnYqPT+A+7K/iJX3/I0IaiBhgG2kJdoVZnfFcdKYuItQDpVux?=
 =?us-ascii?Q?6CyF4+7ldJTl7oDd4/PcN6MCeDGrQjy2fleM2UFwaED/IaluVSpTf7VWFc8N?=
 =?us-ascii?Q?oFL+S3wX0QfgskU4VA7zBKnZSLbCFRzyJ6yn8fMowabQrF31vBU9QMueUJb8?=
 =?us-ascii?Q?YqeKJ75Al1Fv/Gw/zRroDfbmBEudeeucpm3E7CMzqS9Zft4ZHNig56XLVC2Y?=
 =?us-ascii?Q?yalMH8W1rZEpLlF0no6cbKfTVAGF+YvNGc9YErEQnyias/30cN71bOVTwZBf?=
 =?us-ascii?Q?oI0YHlQEYpwl4RAfoNO9EJthPKQYCV0SQx3gJaJ6qx5CF5puspJlLOj38Jfl?=
 =?us-ascii?Q?eeVsbLZtt4s2WXCzPyB70kyGy6GHQtZUv698ISwLaZjkXm/fhanRy/tv/v5H?=
 =?us-ascii?Q?fqLZ8ML1tFqLWIjUIk2nzaQtRpKi9KYPZTpsgkdcXSo1KKRgOxSkBUtw3usj?=
 =?us-ascii?Q?mKVbVWA1fQb4STbewWcUbOZDxjTqcg3cHE1sCut0Laet6rUCvTucRcxSQKRA?=
 =?us-ascii?Q?J9D79856vD2gAk9PX1QVaR7qQ0GWRlI8fIXXaz8h4M2/CHffaQOMQVwMHFf6?=
 =?us-ascii?Q?+8yzedd+mJLq/+3v1B5afG3Lany3qS+YvTx3ZcZ8bDR0t+QVZN+A5rdwdUQh?=
 =?us-ascii?Q?VgtzkTdIQrFjGfgJm8iPhzmdCo5Hfy+usVI/nrHzdkaEpoOlKVaHblc1vZLY?=
 =?us-ascii?Q?NDTUiGCNt4mqYDcWBm1WCr/6UJwCVKscviptKN9rNaR1JoknObZbI/Pkfr3k?=
 =?us-ascii?Q?E8uzcjQXR53V3vnMRixZg0UmO0SFeiYEeffCNspoDzYfBt4eatpcT6swzUtB?=
 =?us-ascii?Q?UpEJC7DB07ZaNLIRaZfBmSmZsbhMB6Kd+UdizUopyvC7JYx1wWqMeIAbRPFm?=
 =?us-ascii?Q?eeQiI3MPimYhKKgr28ymSjdBJ1mZ6+zjAQEtkcAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113cf348-80cb-4994-6545-08dd93e74d46
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:33:00.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJojoc4iIKRjoxJDsI/Fi2kfA+102GrlEJseiovLmdJw9pkFEkPXCv4gWAuwRqZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

On Wed, May 14, 2025 at 04:08:09PM -0400, Alejandro Jimenez wrote:
> 
> 
> On 5/14/25 11:54 AM, Jason Gunthorpe wrote:
> > On Wed, May 14, 2025 at 09:23:49AM +0000, Ankit Soni wrote:
> > > I am experiencing a system hang with a 5-level v2 page table mode, on boot.
> > > The NVMe boot drive is not initializing.
> > > Below are the relevant dmesg logs with some prints i had added:
> > > 
> > > [    6.386439] AMD-Vi v2 domain init
> > > [    6.390132] AMD-Vi v2 pt init
> > > [    6.390133] AMD-Vi aperture end last va ffffffffffffff
> > > ...
> > > [   10.315372] AMD-Vi gen pt MAP PAGES iova ffffffffffffe000 paddr 19351b000
> > > ...
> > > [   72.171930] nvme nvme0: I/O tag 0 (0000) QID 0 timeout, disable controller
> > > [   72.179618] nvme nvme1: I/O tag 24 (0018) QID 0 timeout, disable controller
> > > [   72.197176] nvme nvme0: Identify Controller failed (-4)
> > > [   72.203063] nvme nvme1: Identify Controller failed (-4)
> > > [   72.209237] nvme 0000:05:00.0: probe with driver nvme failed with error -5
> > > [   72.209336] nvme 0000:44:00.0: probe with driver nvme failed with error -5
> > > ...
> > > Timed out waiting for the udev queue to be empty.
> > > 
> > > According to the dmesg logs above, the IOVA for the v2 page table appears
> > > incorrect and is not aligned with domain->geometry.aperture_end. Which
> > > requires domain->geometry.force_aperture = true; to be added at the
> > > appropriate location. Proabably here!
> 
> Thank you for pointing out this issue and its cause. I originally tested on
> a host with SCSI storage, and after your report I tried but couldn't
> reproduce the hang on a Zen4 host with an nvme boot drive. I wanted to see
> if it was a pattern common to NVME, but I suppose it depends on the DMA mask
> chosen by the specific driver.

Yeah, that's a good point

I've also been thinking that the dma-iommu.c needs some updating here
as allocating top-down like the above shows completely defeats the
dynamic top optimization feature AMD has. iova ffff_ffff_ffff_e000
will immediately expand to a 6 level table.

I think dynamic top can be made to work with vt-d and riscv with some
effort.

Jason


Return-Path: <linux-kselftest+bounces-14706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86326945D2A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 13:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122951F2254A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 11:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0B81E2105;
	Fri,  2 Aug 2024 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jbhet361"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64C1BE87A;
	Fri,  2 Aug 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597731; cv=fail; b=XqLssfneouywIVnHQO6FoCvUJ4SKQQAcTEpGCkTTEU07IWp/PovFcz6E84m9cmDkTzyd7TirB4RuVH2uJ6JOnezBi3PIRiJvuOAQjymzW27PHhu191NZ0PUBtR6AnwjnbxEGnpJjZdHGTbmxVjLJRuftLqO/eASUFz7Eb5GqOFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597731; c=relaxed/simple;
	bh=bwpaTnBtklAnGqMsa7iMAz50xx6jpLuusq21Vo2DbI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DDeI6uqvxwo3rtRW+vqYdKzx+omKvcIpKLjjw23NNdPsYDDHB7/MIFCaaywobXwLuD/juEgsQgopmIgTS0RJQW6Lazbu/mibg26KMqcyJ+Xg+Qwlot2StpjBBLr7xJOOI6czUrTMNgMtAl0EZG+drzkaMvHLBFwlEUeXKhZw3uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jbhet361; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h91MF4Rw2SMLe6bqH6MZ+qEYdDujqr1YWBFgTbRGW4TYi9Mn9mz0s4zPCXVI+per+Ul9aA8biV6h+BOcxpAy1lz0G+DRSOvJdETe+rshjPWXDpCQYnR8SUzCBMYb/iKT7Z3v+SgQvniaq6ynByOw6ufD0l/74PbXAjBtJiPCtWKQf/bywGIWbC9LkX9Zj2YTpaJuR+4N0dQ95d4Lv9jOxWhaZgvC6ZDsb0AcjgDKDbva7grwsvztv/6B3PgJDQX9/Jd197edOHlsme0OCN9fPTAfsCJvRFv0RVWRIiz0gjatHhfLC0vS6+sq3sHKKaYbvyKjKi7XTZXX1B1byQHEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alX4lXDEyzHuCyvrSAfdM1uFxUZy5Vn/2/bDNEMCTII=;
 b=ygQJggFC7PS9ntL6DWjIBZiiCTNO2Slzb0eQSWmJC/eZ5LHmfqZ+FdV7hdUaZE5TRi/ezperxE4u2685ZGjkzctvuQbTwJemQV7H+JE9mcel735HTd/o9yP+smyx8WXTPc9v1ARA50uw6QWHUkWs/Xfi2xo7EYaae+t4o7/kULjw34igqQjsukUh9ZfGQmVLoOYeDnhp69HVnRjEBcS/4oTtb4ShVZSkZvmK2KAkHLfz9AU6YSBuq8kP1qypcG5bdYxki8Q0RnBpkXHBVSTVa//7Y7719PTjlOotuinsiwOoJTGfD2IXL1fIdCn/Y7S7L95EZ6W/bO2LuGGPy2su8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alX4lXDEyzHuCyvrSAfdM1uFxUZy5Vn/2/bDNEMCTII=;
 b=Jbhet361mop4mnCm+Wvu4Pxs9roEnJpDF/bWlKZ/4nWXGHLIH2Nm3wqu8/pFrkl/kSO+kyMLOAJTm1t8SVI0Q5SBJ5+RJa3DrmWYXzS/I9Bv3UvY+10bZDkmEFGFCsFUmoKjyW3WMYIioieqihwKYnnyqnO2t4gjE8+QPfio7K8Jz7ZRiNFWeIotpSeuvlmsZNInAnAz0UQRIU5qZ5yLccruywukEyHeOjmxd39gNNgGjnfTpgpS02EOoY/ZTBgbKRmGq1nmmm1dokFrtnorMePvNDSFPCaHtpoE32aQk9/my8jwDEfM92YjCsbZ8jp8q0UD/fs6SX1UPp9xfkcLzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 11:22:06 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.024; Fri, 2 Aug 2024
 11:22:06 +0000
Date: Fri, 2 Aug 2024 08:22:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Fuad Tabba <tabba@google.com>, "Xu, Yilun" <yilun.xu@intel.com>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240802112205.GA478300@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <ZnQpslcah7dcSS8z@google.com>
 <1ab73f42-9397-4fc7-8e62-2627b945f729@redhat.com>
 <20240620143406.GJ2494510@nvidia.com>
 <BN9PR11MB5276D7FAC258CFC02F75D0648CB32@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D7FAC258CFC02F75D0648CB32@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: e59ca243-a732-4c0a-1912-08dcb2e5574d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TKgnZOI60gkPYCOilhemKhKQm9XnKeFyUIyN1EyLS2Hu4wKgzVoJysg0N8V8?=
 =?us-ascii?Q?3s4Lu46LL2dp0sHrJ9F+nVzYlQkya3fRH3kPtxP2/3FxvpbQO5fmWqNUdM/L?=
 =?us-ascii?Q?ETXaQyB7r2VNDAkY3VxeBrC3zFsDSR5FzUqIzsAqOx0O+EpIu3VizQSE5KYL?=
 =?us-ascii?Q?9D8GtUheTNyZF48jtbwy2DO7Ilb9Iu6TbvaVnz6ySmPStZfdnvpd45sIgX89?=
 =?us-ascii?Q?wJgU8g3If2+eWHzeQ8RXasgAwkD839MDCicr24zIPR1OYeCjg9LgxWNyWmGO?=
 =?us-ascii?Q?bq4XfUgAy3sMMDh35gsALnPF6i52KsaOqdnsJlSCEd+xxtAvWyhqailHlRyg?=
 =?us-ascii?Q?DcBCU96OAKaX31J5mRmujgAJH8oPrNB0sDd/NGJ9+vavVTyqfddLx+xLHsyf?=
 =?us-ascii?Q?Q4PPdRch/TJXF+bjLFNu35qVpTNEpFD7PYLSJGVtakrpeAIEZKAADcAqgZxV?=
 =?us-ascii?Q?ILcO447KcwGBjJKutzHnvFGvSWW/Wm2wriuYxAV4zpMjZpJPR64N3fx8Bh51?=
 =?us-ascii?Q?lUJQBGydSnHe86vr48MATy0meS3ILTyMIBUQ1FsQCZ+ZXuRZy/Vorg4BwbjS?=
 =?us-ascii?Q?s0EeJbJgCwAa1bEzBPTdclBC3SQuWzdt7juqJEBJHRNMSTuEYucITfMDsiZw?=
 =?us-ascii?Q?BXldSNy1kt0KE9oLGUvxxOqK76QZHqaSdCne3Ucxd7/0or/8MDZfergY9DlV?=
 =?us-ascii?Q?Lbpl0sLbl+eT7YEyV1fbxUJSqnYhZhIXjR9IR1ichTuc1wJ6ooZaax8lhJz5?=
 =?us-ascii?Q?d/0vgqNeWy1HEEqPlXUYLmHuTUedz7luK+u6RyMVJ2lK4OcohCPN+6Z/tjHo?=
 =?us-ascii?Q?5A2LulyTOmJqIg2FuX8FAc6W1J1jwPZZTnrjISIN3t/KwbIDFw8BmJ95qGnJ?=
 =?us-ascii?Q?3oZqDuuiDjmsMsO1HFj5ngckUTbW/OOzvqy06YM9Ej3cwjGNruJHqKeU1ppp?=
 =?us-ascii?Q?hPC85VW9PnfnEhmurF20faOetHe5fayTH8JoZPUnFyXlKjV/5Vx/+VXNlzMR?=
 =?us-ascii?Q?fBkjrs+PVsNnJrb+LRiW5hGX1Qba/oy3+T2swKb7f8KetQycXQfil/QPlm/d?=
 =?us-ascii?Q?xpQ8p35EIuP2vE78nReAMs/9eZeVFoVcH7eFw/WWCc4pyft8KDrJHqika2Tt?=
 =?us-ascii?Q?CtNyRiYn5h60tBPZIturJlC+mxuQRkkmpr8kRCCKDAmM3Yuj6Y30XGff7+zT?=
 =?us-ascii?Q?dJyWvmasQjX0Pix1Tx9vt0FCTrX526HBKpx0IWnvwySzi966+HKY952nJUC1?=
 =?us-ascii?Q?0aYIC8WwhZDt6OlykZTQGF7+0oUEbP3S0hZpHMGQZqvNVuEOWcalf5kD33xD?=
 =?us-ascii?Q?tMx3wiqNt83ZhkXnlVTJnbQp1MVhaMgZBB50/+U0vhVbvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LIykHP4eeyP6HvfRG668LGnh95FlSzHPoXWFqnFoPVFmJZ3oxB6DlIHW2G6G?=
 =?us-ascii?Q?W7pS9Ix0nq4mmeGNNKoT7/XxqHe8HGhjLq/h2kbXIPuh63xYBKl9oqvR3q2Q?=
 =?us-ascii?Q?ZVnUtTQz+iczoLQ+MeuVUqE67wnXk/ubGzZJop5H19iB9fbUVMhHUYZ+MQQx?=
 =?us-ascii?Q?sOEkHVuPbb2Bw/OBGks/MyxFVxzqyU2qHcXgt1QxfKgPgqHjbvrddp1JronI?=
 =?us-ascii?Q?rnu4O0N9HOy4WYV8OHrOn8vkcwSwK61mOCjcBdqVP4m5mu/aoutudKg1lQqh?=
 =?us-ascii?Q?gNK40UbUZY9JSMqBLOGBWmG7OYgqMvqQ/yDes2NE3xNDzvaQDvTutFiysaJU?=
 =?us-ascii?Q?y3kbylz+bj1taWHdRzR8Qf4+LZmEuCXUGLjtn+fCo5dv4YlHD8FiuZ/x0w+a?=
 =?us-ascii?Q?/ALGy51LEH8wXoakxrzwc/R6k1THXg2+20yfSzqwp7aiybfgbrrlkCp3r1hP?=
 =?us-ascii?Q?VVIhb1CR3lFJup3dEvmfS16b5WbOHeqpzTKnAVPhhvdWS0IaIDOdAxENTCgg?=
 =?us-ascii?Q?uFicgl9DCcKwisfZxsq8aFnk2PRv36NjZs7lbIl7Mz5G9a7AbpJuTYkIafr3?=
 =?us-ascii?Q?+hOxfNCAhh18ulAXebuQD3XSDnRXSmydJ1Fn7NWXARbAiv7U8gqMak72unT0?=
 =?us-ascii?Q?Deil9AAO70ZIaqYUMftwaKwuIbU81pIP32IxDlrl8KLwnHVQODgN6UkTEPC2?=
 =?us-ascii?Q?guyjKgc9LItIp2x4NOhsLtdvwliY+ZuO8cAQICobMeNiAB+RDC0Lb4L0RAH+?=
 =?us-ascii?Q?EV5VB63fIY2QH7GICx5uc9KcW/B9fisUo7Z2GnUY4QqsW3DkbN7Km8Lc8h91?=
 =?us-ascii?Q?L00mcYM5JNY+vvTvMzUWsaaYHHJ+6zYeUIX3oD+pd+JCYsx/BTXoHIU31YjD?=
 =?us-ascii?Q?HVR8bDqdtcIZlX+GuX5IpY4kHb+cUwu8ffDU81cWVIQVFa1K2j82Qyc1eeRJ?=
 =?us-ascii?Q?6E2PfNUkkBwPw3DsJQI9tjDJvdAJ88+ufO597K/yQC01KActbM9y5586FTZ9?=
 =?us-ascii?Q?zq/v3AuiDOzoepLb926pGlasraIdbb9UWg0geRLgYCNa1+xUwpFybw3G4tsv?=
 =?us-ascii?Q?lNx3m6HLaRhblhdrLv+vZxqd+RZ9rxmJ5NqHDr2TKn7bBbT6igcPT5411GaW?=
 =?us-ascii?Q?uyb+gYpqNfuBYE6JoY4xm/wMjcpbdlXoXx4tuivu888DHPUTo/uTsG54v+4x?=
 =?us-ascii?Q?sazw8XxS1Bybkmx6feOZ9poeK3TBdrt/rfCh1la00q/7hy5tUJvp3WX5VfuZ?=
 =?us-ascii?Q?sM+0/Krdd10b9vYDRSyByOD7jdvT9hw1hh4Oi4Pz9Mp9kwKQCK9alS9DHUBf?=
 =?us-ascii?Q?iBpZ2Gws6oWgXB/l7TttnGBB+JQPr0hlIDz+bcfML0PS+LoFbUFQsDIwo7fB?=
 =?us-ascii?Q?vvds+NBSM18ki9ybl3/FILUPtsXhGTvGnTylYrjix6eF/14U2u+DZ6RvquUh?=
 =?us-ascii?Q?UMu/LgyHnD/EAJ+T2w7MZPRoXzv2EwVuLy8uISzRzhWPk2MkJnVH+QhYcBAR?=
 =?us-ascii?Q?n7vE26gw9mZXD1LvmCjYyElI9/SI9qvOmlUdFx1+pxO28fHo6qFdKqvK2KoM?=
 =?us-ascii?Q?20oyn1PO1FmwE94IIarPLdYs0BhgQqAJpRogd/OQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59ca243-a732-4c0a-1912-08dcb2e5574d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 11:22:06.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jAlkaFG1ENblE1d7tRJaLZbeNd2sM+MIh/9nkYKtlAGhTOTmuUDSzTxeDkMEYOv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

On Fri, Aug 02, 2024 at 08:26:48AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, June 20, 2024 10:34 PM
> > 
> > On Thu, Jun 20, 2024 at 04:14:23PM +0200, David Hildenbrand wrote:
> > 
> > > 1) How would the device be able to grab/access "private memory", if not
> > >    via the user page tables?
> > 
> > The approaches I'm aware of require the secure world to own the IOMMU
> > and generate the IOMMU page tables. So we will not use a GUP approach
> > with VFIO today as the kernel will not have any reason to generate a
> > page table in the first place. Instead we will say "this PCI device
> > translates through the secure world" and walk away.
> > 
> > The page table population would have to be done through the KVM path.
> 
> Sorry for noting this discussion late. Dave pointed it to me in a related
> thread [1].
> 
> I had an impression that above approach fits some trusted IO arch (e.g.
> TDX Connect which has a special secure I/O page table format and
> requires sharing it between IOMMU/KVM) but not all.
> 
> e.g. SEV-TIO spec [2] (page 8) describes to have the IOMMU walk the
> existing I/O page tables to get HPA and then verify it through a new
> permission table (RMP) for access control.

It is not possible, you cannot have the unsecure world control the
IOMMU translation and expect a secure guest.

The unsecure world can attack the guest by scrambling the mappings of
its private pages. A RMP does not protect against this.

This is why the secure world controls the CPU's GPA translation
exclusively, same reasoning for iommu.

Jason


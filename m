Return-Path: <linux-kselftest+bounces-5181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B3B85E0D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95E21F270FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD180C1A;
	Wed, 21 Feb 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlhitgrT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866680C03;
	Wed, 21 Feb 2024 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528770; cv=fail; b=rl2ljJmOi7dqttQMtKqSz6SMVMFZR/3OjZYXIJ48q9Z15ixplHB8EDYqiMc/gwjcMSqQKbrEfmYBk7310ouqmBkQ4Gu5umlgiYIUNQuP/MbNxh69Tf0UMtEvVNfGI805QVRe7o5kEzcCvhr7z2juhfrK6Ee+2NfCzWI+3en1I/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528770; c=relaxed/simple;
	bh=5S6Sx6VfbI+dSbyKx5wk3pqWaxNTwG5G1HrROPJvv4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWCcatlSxJHbplmHf8eqy3IFIq4D2CapVNKm/rtbXG5KYisHmynkxzbg+WFEz5ye4R1O8IELwhWox6JL3LMXBQW6pc2NCO2lNaQ6gLzTpxlH1PYKDl0u2jSKTFO+KLqnzL0/m8RGlB6ZuHiafMw1joVxeImDhiFG3dZFdgZyEOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlhitgrT; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORGuw/F/13YkCX3hGnkRUnYP6zzoNn+s/I6tJKP5tAFpAA5TIIMPLdlh4xnpMwsrRvN/DpoQQWB9Ha4z+MaNOx1VlaKiaenJ1VzdXJMjtFGS7Cc74tUNpUbJ+YxNrlJLaA4ZSE3caLZEw3gFdH8SBE/Tlxun8OJ4wP7ZjmZpQAe8UDz8yHnzIB5mS0HrsmdmBCO67jcbTG9e4uLjbmNU/frLKfJKnUbZaNcaw2EV6ZA/y5rrJljrDeXnYJKtTtEH9ll+YCTvSzURPCX47ROQaujdaDNmP46vNopmK/kPGTooF+ploEpgKMQwjE/EIQfBre/G04RS2l+t3Q7BXAeQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs1hDv/XmSFfX4I9cNghM7Duy8+QAhxL+BINxyhCKd8=;
 b=EbIuZdITj/uRa9gCPEv+HQCFCmFN4XdaRgpOny0peXhIcVh+VYUZoKG1ka/1P0+hJv2Y2Mo7h395w9ahoLT/o/G7nKslwkUKElCOA9eo5m+mTIw0he4MXF+H4R6KAwi2SBDwl0kVhAvlspncDKs5HItlc5xwO9KcN5BpDAFdgafK2Pz7EMUoGl++XwPwjlbA/95Bv57hA4pezgjMk7ssxY89uGz/aAG/jkRLDOaXqdGyVOeytUOqF+9Bxw0KLZk22hFF9Sb9Oo9/tknScjZj083bIVepRH68ZeHgN5f9gngfuXOtXBnN9/LVzo4q5S9GnTkLLjFItND86qTZeEYjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs1hDv/XmSFfX4I9cNghM7Duy8+QAhxL+BINxyhCKd8=;
 b=NlhitgrTezkHsTASViztx0l3KADbnD00Oku5gaW4BjPGYWvy2CTHv/IMWz68eguXeSf92bP2rnPJvuvWAxq+bUpmN7RcUvkL+MM32FkgzbSqa2f4z2/K2LgtCXp8UPSBzp94kLCsX409ejwJL7sew4xevX7G2Bm7/76DU55wi5o47+8skSxVEUCdjGNQB+MHfPLHLV0fBVgLe5D6214m0kG1JyB+X6HVhpZ+UW2wqskLWfHTefjs+22wLEL09rfFj3PVUfdbFJ5sqgS9Q5CJWjWiKn7mqmUAAbG6HxkIGcGW/F0OnopLlkUMICjKWUdXlrGWzwOjkbMWMW6X1BODWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 15:19:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.023; Wed, 21 Feb 2024
 15:19:24 +0000
Date: Wed, 21 Feb 2024 11:19:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, robin.murphy@arm.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: Re: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent
 domain
Message-ID: <20240221151923.GU13330@nvidia.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208082307.15759-4-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR02CA0137.namprd02.prod.outlook.com
 (2603:10b6:208:35::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f860cb4-23b4-452d-82ee-08dc32f07c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r5y4RnNsPU7es/Hx1xDz4GpHevxyUBcxT+mLcJa3OczOJ/b3fEDBqXUAZ1iRTl+rAhJgVv2bZKEc75VKNIG60MEpUnBvs8Fm979KGXQvxQTediaPdn34aMoPNta3Wy4ZX6RUp7wsodLu5PhNH5sLB57V3EFFCwKRiX1ZObtRfNIg2SFd4iRJD/okX0tblZ/4Q8OiQ2pu33x6toxV4dY7tj8f/SWBQgmoqTYS7dBqdnbd+p+HuYjtqKPmhzMvfV2PDGOAjbjnOzuvHSOHG8C0+b8s9LMfsEKcboFC5Xy9QOwyVj1cgpWfxinJdl4ARQt6tBabgxW+iTDdLWvchYi00hVst8yvWHp7v9uTJhvhxUeFQBpj7Sl5TKkn3zBGEoFpmwkohF2EpEZcSk5BVs8HPWFhrccRXqkL5Pb1X3r2kSd0beC15kmyQNoO9TNpTxRY2Zmg3b101lImwvfRYc3YVFusGRCap4HqvaiWwtcXG9yiWhZORAQPjHiko6GA5Q3zKzslWcB+WFmAAcD15BdLJ6EsW/yPcCCvqUYgaGRfjKY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/rgIpN7P0XxjfAInPjoSJwjaN/0T3yUxX/Ea2w8X/oSUvcZ1FEUquMW6cZcM?=
 =?us-ascii?Q?HYeCQ4mpf8Jvq1U9cmTs/uftz3LhO5MYfTed+p6tvI0VCGZoCoFPE93aJBQ5?=
 =?us-ascii?Q?+nF7GwqPo148oE5SKPPpiqK3hG4dstiLMuyDNz9sCWHQo9cyAgsMOi/VoZNp?=
 =?us-ascii?Q?f4+5fPqRmGqJMafcFH04f0fjPICDCjE2xF83J+Jo98kNuVwH37xGZz6rFvoW?=
 =?us-ascii?Q?KD87G65Y/vbPF16yq68uyCE7fmg6PttudK0QBUPKOkDrXuHiHxftHQE35l11?=
 =?us-ascii?Q?fgnQs8FX9scLkLrOWRQ262k3CHqK03LXnoxCc90T6Kp30Lkglhif9FW1m+gY?=
 =?us-ascii?Q?3S/6ymEojujMAmcySnbLs2c/c7hRHUl53RgcewVbxJ5IsmJG4b6xoSFpRsJn?=
 =?us-ascii?Q?y0hABZ4qcChJiKr6y6xHdxV6sj3A3BtqmP3dgYGH7Oplheh4Muyx+T7HWwQu?=
 =?us-ascii?Q?uoT16groX7aYJFfSPkMHyPU9/I5auzacDDjmqGMQpgCKFacynu/YvWPiKw7k?=
 =?us-ascii?Q?CDz+ZlwQKeyqjMXZ1V348LQjlZnK/TsXoi3xHIlS1aD+UrBjVdWJ6SRSses0?=
 =?us-ascii?Q?8s/SS5dLXV6R20DzofSIxZl0Y1BUUQ42VLjxATpBFPXt1X3aXDxWC6MEhcoj?=
 =?us-ascii?Q?nmrix0kOJz3YlDoc3aWLwDdzsYq1YBw7fELjaJ7ywnp6qG6N061FMA0ioQPe?=
 =?us-ascii?Q?JkG2NH2bKbxXUk73RwxFUctwjWooH0KVNbnGqZ58ffH6IPOHUGHbyxyq6HGI?=
 =?us-ascii?Q?1iejQMrdKozklmbd4UqfLcmpusQayvuJ+VLFSdmPXHgHhkpHlNEHC6HjSwFw?=
 =?us-ascii?Q?Ig9Je39Uw08GI2yGo0wvnpE4IHUJT5NSkDoLFeAcrnkW/47OG+9uwXcRvYUN?=
 =?us-ascii?Q?D72jc8qlG0q1tPtwfdhp3jXq4P72qrGnHP++w9smZ3rEfZmThnkiFMj5o6zm?=
 =?us-ascii?Q?3nbqhJuRzcnqkb27CzSxFKuCVRkVMRyIrjVeXo09G6rCm/zbrO5pYLvC9HyL?=
 =?us-ascii?Q?xMX6NhqDW5doel0a+Ndya/RhEaa2yjcIBqqBmhfFqVM00OxHM2VazW1MmSAS?=
 =?us-ascii?Q?3YKCmSjTSzPNtWBXyGC/ZMYAcVO0lT47q2CEU39sbsgsXgLW2eizLri9FcyG?=
 =?us-ascii?Q?qvw/Soy6eLn+oJjwqywFW4vPK9++j7IyEHAHH2qjhQtad/c6dBdSF6R3shgL?=
 =?us-ascii?Q?DjIItl7UyF0JfQYkNAsU7IsCJmMLM2dVwT1mUWIHqFGUobFws++H8EOwh4bu?=
 =?us-ascii?Q?vV0BCrgP9lsasM6VtlzueArd8KdEUwjsh1hbmp8o54dK9GPV5FGmeNnBFl2v?=
 =?us-ascii?Q?tTDsPy96FnMNAP9kJdzjijlHk+24daxs2SxYD347ehgam950fYyp684UWTDG?=
 =?us-ascii?Q?rvGvN2bQiLKnR2dBnbzt06/TTZ15bRkmMDmzUYJblZeZ67ztb7FnOvoDI3T/?=
 =?us-ascii?Q?3hWvZNIa+PbmV1ucYSz5bLC65kfFz/sA6dQ4VmoguKsojEjbt4PemMQhrR/G?=
 =?us-ascii?Q?d25q+LJ9skJLJMzarH13+MUdqSSJc+SvjCR2X+1FXDfSG8o8W73JjTTJ/xoN?=
 =?us-ascii?Q?g59YX7vr4ZSDvpfE1TcJWGK3/NTY0uKWvsasLppX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f860cb4-23b4-452d-82ee-08dc32f07c6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:19:24.2154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 110qp9czq1osFlwZB1qts24y/sEk3WE1cjS9Aoiabzjt0ulCn9Uu6OkPtw/QzmfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496

On Thu, Feb 08, 2024 at 12:23:02AM -0800, Yi Liu wrote:
> If a domain is used as the parent in nested translation its mappings might
> be cached using DID of the nested domain. But the existing code ignores
> this fact to only invalidate the iotlb entries tagged by the domain's own
> DID.

> Loop the s1_domains list, if any, to invalidate all iotlb entries related
> to the target s2 address range. According to VT-d spec there is no need for
> software to explicitly flush the affected s1 cache. It's implicitly done by
> HW when s2 cache is invalidated.

I had to look this up to understand what it means.. The HW caches
per-DID and if you invalidate the DID's S2 then the HW flushes the S1
as well within that DID only.

It doesn't mean that the S2 is globally shared across all the nesting
translations (like ARM does), and you still have to iterate over every
nesting DID.

In light of that this design seems to have gone a bit off..

A domain should have a list of places that need invalidation,
specifically a list of DIDs and ATCs that need an invalidation to be
issued.

Instead we now somehow have 4 different lists in the domain the
invalidation code iterates over?

So I would think this:

struct dmar_domain {
	struct xarray iommu_array;	/* Attached IOMMU array */
	struct list_head devices;	/* all devices' list */
	struct list_head dev_pasids;	/* all attached pasids */
	struct list_head s1_domains;

Would make sense to be collapsed into one logical list of attached
devices:

struct intel_iommu_domain_attachment {
   unsigned int did;
   ioasid_t pasid;
   struct device_domain_info *info;
   list_head item;
};

When you attach a S1/S2 nest you allocate two of the above structs and
one is linked on the S1 and one is linked on the S2..

Jason


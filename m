Return-Path: <linux-kselftest+bounces-33812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10764AC435B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2953A37E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D774C97;
	Mon, 26 May 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lnf2nGgO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453DE2A1A4;
	Mon, 26 May 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279792; cv=fail; b=hnGKzd501cZkrQUzq2hJKYBRikupvvCpQGSTAwm1WL27/CynzPxLppjzh9/hra8aqXoleCeZa0aPvPYO7PY8hWFyclEtNqH2f5lxIIlRr6YFwtvctvTIh8YfqReUaGGB8BSQpC1g+cs6+OBIUkYZPAMf6cxEW4LEwYWRt+FPpjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279792; c=relaxed/simple;
	bh=TxGcjVHEUv8ag6YWU77+/AsOSlyAdvQ1G1VLk/am0Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LHu//Xn1HPccIwh0vUXhWlLZf/kA79wXeomxSkrS4M7cv46eXRO3r8WeFMdVxObFwMFMaTb29Y4DaGJQZfzVy4VlT4vzQCF+aBFFOqNft/M/EBZireQh3HheD2BEPv3HQSkzt41/PESUhDmmQSFATrczwF0gRp3hs9zBLrbhF3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lnf2nGgO; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BktK0KHYyh6YWQ+LjDqXpqzF5m6VLGPaqjbs1gbv0wuqXEJcAzjAJK6+a7+OoJMvDZ0/HRLPy7AX/5IoQGIlmGzs764YN3Fkii2w4fDs3t7BwJlE+k8+IqJPBvj1/I593iA0bF2MozLh+bkyShMkl7n0qWLurb//dZA0PnPefRZhRHcIq1NoSN4R8Ofwwb1f+59UwpaMQyNvHmXwpBQ9cpsVkWKyf3fNRoeLOt2eLIb/h36qcSNSa6pCHBLdjJMSqSuSgnjDK/fHX+w1qnPTrv1lakunCwllyUC6fJPG3PlXWfEZ+Ua3HQR54aYwEfFobv1qrGzp1R7GR6yrhOvw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Er7OXXzxQfqje8g0LwXpGgoRocuPWch1akkFzAKjPQU=;
 b=nPfSFsPWUtw2BFkGAJYXHYvzZXw23SlaHZCTtBkjxEW3nFWNkWQ5FbE069ozn+OUU5Bp3xMK0ZzfEHHwFcvQqTayPqZVPPrhqaRk5Zeiob/TSFNTfmqMRv7xzHb8Mb2lSvEY1WnvlAityqN5PkSQ+wQZUjXTUWKcQb9wIxEB7qQinU5yD6Imd6HCv5UteabC8iy/LuHIlVGeJ2PW9vy1bZ5C5WCrMGPUGSsqWRKigS9TleHsCG6Wjnwkevygfi2gr5u7z10N4JLkiWcyzIR0VPTBLe/CqFjR0+fSmHn4wIRmbqENCPL2Cl8DiHZuLVjR4BsRTe04bBWFbFvjffwYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Er7OXXzxQfqje8g0LwXpGgoRocuPWch1akkFzAKjPQU=;
 b=Lnf2nGgO4gHIt0xD3+tfq8aECoKF8DHIwxHEOH4x836rnfMzstqcXDzO8XDOFeOMEMvHGW01A5kaG6RAd/iRcgNWa4mBiEMm2zgDTR+nbYyrEwsQbw/mmSjnFFdaDABJPH+kbaRSLjWQwOp7ydvTsvFSZi1jjrtUA3MpJPRp7GX7ws8XC95Oa/Vva3r21JQ5huCKrGNiMxAHZq0P2KakIY2MWSeqVzA+OKt59grHmM+sMOTXKBjKEoJWIT4DWIM/EqlSlsqtI0TIhwRokzdWXJa5PAdYYMydpAFvNHUvQ7gHxkwaJLBJQl6xGjeTs7ac9JBZB4i2Qv6Fk53TYiMQcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 17:16:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 17:16:26 +0000
Date: Mon, 26 May 2025 14:16:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are
 mapped as 2M/1G in IOMMU
Message-ID: <20250526171625.GF61950@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-9-dmatlack@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523233018.1702151-9-dmatlack@google.com>
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: a50ddff5-61af-4a52-a233-08dd9c790bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oagmAN31poej+Ifnxrfi2VRmkD3nRArSBfxeIKvKI1yZgzqswrMW7AQTDnvp?=
 =?us-ascii?Q?Ya+l/8Tq+18/oDJIX5y+dhdziBYZGZBtaTCmift6M5bdBSKBmNwHksX1l/Gb?=
 =?us-ascii?Q?OHPibQDWKI5PlL1ydjMj64BRHuq6+GEUprwTtUYaq9vDL6F3EWMbDddPDg+U?=
 =?us-ascii?Q?VFepSrTgFJhknh2bsuYyONdEn0OZx1p46GyxjIhmDzdxbTztwKhzD+FbO8Pk?=
 =?us-ascii?Q?ZfPXOpw5a/L/Jo8RuxsIuX4Bfu+5DRnUhnuFzmY1JBKA1lD0gcs+wswJvju1?=
 =?us-ascii?Q?CixKwfP0D51Hj58JPNYZSje90OYYZHqsicrFdAdGYuIDRplpdeCWJMNjlJFw?=
 =?us-ascii?Q?EM8E9GvrXjcrkdPCInqjoPMgn4tdaawp8pbYOVRu4DmoTuWntxypCqX5w+H0?=
 =?us-ascii?Q?RzUOpwEPT4EE/qZqD1ehdx9knOwDurmoc8d6K0Dwv/8KdODTLZqrJr2wsK2Q?=
 =?us-ascii?Q?9bUNeA9YMsay/9lvsYGO5ekDMhCoik8tALyemkm+yhWkiOkBLlEqvuoev4i6?=
 =?us-ascii?Q?5aE6bE30z4pijKgHKGh8spPCxsq26Pd2PbOrRKzKCSdivH2COjCngmpI8KVV?=
 =?us-ascii?Q?+OoSh1fBSYCWF3oKQSGxcFq4/NCsMfDNL2MS7FNzg64y/BsoBc37PGCJ5IFN?=
 =?us-ascii?Q?Ao4HMeBeLNEvMV3VdYn2gHReVsMsrwTRRnhVAZVEyL38ZcAsge2z0r6NEXqM?=
 =?us-ascii?Q?O2xBI+K/N/Cv+QVhKnESzwMqRbQUNXNbH5Qq8ky5W0eeD+w4g7FlBJYJWhZB?=
 =?us-ascii?Q?Uq2QgjNrDvgktsn9tCrJiCfD4a12tbJ9iyccuuZRSUN1hSVDk1NGFgEHfz++?=
 =?us-ascii?Q?TlbXy1n5pq4iMb8RrhVSxM7ZBMPgksnT1wEzSnkNnNcfbwgH4WhVlUvr/kX/?=
 =?us-ascii?Q?FU+QtoIJNdbx3ZyaIlCkjYWduGiAxx4ByGrdVvSCLkF0WfrOaiz2MxWnxx3l?=
 =?us-ascii?Q?XPr3Blz/7151QFQDV4cEPleXLrL75Djzi4oMh+gRWhxbw+UNj4QGPgR9sTso?=
 =?us-ascii?Q?rJW6FI0tbcOUwbFKY9rEdeYuVDsLP/tovZ+iu8EnYdOtRV3A7dXHAr0pg5Ko?=
 =?us-ascii?Q?3jjQS32ufWggi9h66bRgDtD9sIw2ew3mxHRfHvYzfZquH1XXa5E7JpdvjgC4?=
 =?us-ascii?Q?7Rlw6Gvkt10ZGxJKgNnZoRjsQsTosIGhKRddnZZNBboC9w7LyETt9zP/g97S?=
 =?us-ascii?Q?K1LZKSI4BdoGPVhj/VWBAMsA7mbSfldFRCKN6xDvj7X+VfF7D8xwkw7iP/kB?=
 =?us-ascii?Q?6LIwARO3Wg9fMvjZd8tttK3GF7WmqGY/X46QGAjs1bSRyXCPlvyPYbK+s2zw?=
 =?us-ascii?Q?X8ilGp+oaYUrI/9z8zBgy/PqGZ/krvAnwloECZnfriwgkdzZXskGa0Gg8zMo?=
 =?us-ascii?Q?oO2hT2LfFFo77kOAuOqktE1CVBLG16E5GFo54uTrNwSvVDdUNnAXGr3XJoPb?=
 =?us-ascii?Q?XH8GOaZCcXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6evY4CikCj2+MzrpsW9v+rE6HATDt15kCCyQqXiHA8N4SRVft8FT1U08MTe?=
 =?us-ascii?Q?mLVLK5yrmCajQbq9xPhgadI0BZPYBbBgSvQ2UCG9aYRMwD92t2iXArkp8YN8?=
 =?us-ascii?Q?tXBKORSez6wbLfHrUISwKY85eipPcH0M0vHZeSzPjiOMUcLZdxqCmu0cwTBC?=
 =?us-ascii?Q?DzGKFI/yriXwnpk8kjZqoEzeH8I0R8yFgO127XLGza1LuxXdtuJno85tCify?=
 =?us-ascii?Q?Ator0phe4hE88LqLaYxtAsGvYtkLR9Zla4A0YhBQHBgtjw1dooIDtsMhoAbP?=
 =?us-ascii?Q?J36ME8hVetskaSWcaMQ5MWLq28QtjDnr2L3aFVl+VtPDIN6VD+Q+Qu2Z7K7F?=
 =?us-ascii?Q?Ufzl3EcHql6xYtwH5NAqWTVglV362+C30cWybRZ0gJKSXJyGEND5aBs3sx3s?=
 =?us-ascii?Q?0PfORxfwF1syTYXJq88x31++WZKBTseL33Trxm/SiGJ6R6QPvdA/oBCJisBZ?=
 =?us-ascii?Q?Z4pqifg4Qv+vB36nR/eJBO2Y6irK2InJwSlpr+WrUl1S2wdp6uygc2NueNHE?=
 =?us-ascii?Q?+JR7v0eKAbS9LfRRaVyEpecOhNdLJEXvdFBGo4OWHQhYteH0xGzsKp/cCJlg?=
 =?us-ascii?Q?tgVaUl5MgkEwOqieKEZ0CjYavQAws6Qk9RrGsFnJvmDQqjNLYs+ME7rOUDju?=
 =?us-ascii?Q?xNuU+KZwdBF+8dCF6unLXISNO0KlN2iwR0XjKjN5dHAX1T/O74aV4s6964pJ?=
 =?us-ascii?Q?6bGcKN6uSk8URIMlulgFPQXFF0mKG0gZnYhAwWwqxayNQurOq1QN4htyMHVu?=
 =?us-ascii?Q?8NONCD3mor2uMqB7Yg6UEfLqJ/ZupZsXME9XtKJzcLEezRXnZrZW5G7vj6ql?=
 =?us-ascii?Q?JdywCiZhhpCBeUOcdsNJpPJyL6V3QFvPK4+bgJ3fm5HQ3NpuB9s+9CPybT7U?=
 =?us-ascii?Q?HTA2FPf6HZwv1Z3OPcPxXxTIblEh4C1kkuIDT051MoFkiMB6RBEZ55nfMGQb?=
 =?us-ascii?Q?YyQwkb7rwb/GW/ZI6qTMBypWkvBCcai7MEYIFWIRo/MsIFf7SnjGdwOSO1o5?=
 =?us-ascii?Q?Q5Nn/xSo83XTq4pz0g4xJn7FU0BjZwxXivJwYzedztfSR76vKD4w76fG7Rhh?=
 =?us-ascii?Q?wkC9uH3NHTrnjZpoxLZK2hRAZV0r/bWXeJrm4xYbGBuKoOPJLHw2U6fOmn99?=
 =?us-ascii?Q?S9yZEWkrJ2uDmC8lh3/k+az1fSMizGOBuMCrkpCFSQIB/SsBKq2jEYFlhBsP?=
 =?us-ascii?Q?g2zlXcyHwsemqycCgAOlFb8FYJLCzCzwtw6hZh1KyYv/reb0FoQxw0LCMaUv?=
 =?us-ascii?Q?EPFIX3RaA7sDXo2x3bR+6SnpEOWUeGlBvPxvOnrW6GGIekd7cQLz9qhqlesU?=
 =?us-ascii?Q?TI1RnvSxhviJ6webIbmX3Y9vLzzoOqnslAf/RWepCJ3jNcOOfyOma3X9UFna?=
 =?us-ascii?Q?Y84u2tAIMTI0g0L+muX8O+64K3s5OCTiG7RPHsgd2nr7W1+zcAikUPaO508V?=
 =?us-ascii?Q?NwYCOd2IHK1w52EL1zqHXbgC2KITuOi9M/psZILPl+BRQWDHQowfQbex2dmV?=
 =?us-ascii?Q?vCQEHwKQ+rdiUBIiodPJYNLdhlgNBtD3EDF301fG2j106Ks+H89lI3L8m/e1?=
 =?us-ascii?Q?OkNqRdDDbSwm2eONoTQ8NSH2GpzCGsLzQPk6oBis?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a50ddff5-61af-4a52-a233-08dd9c790bf9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:16:26.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nf3oprxvR4TpubYieBSehF7hJN7SLTLjwspMoy8LCrQ8rkQFtrgIoA+9Y5eihir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

On Fri, May 23, 2025 at 11:29:53PM +0000, David Matlack wrote:
> From: Josh Hilke <jrhilke@google.com>
> 
> Update vfio dma mapping test to verify that the IOMMU uses 2M and 1G
> mappings when 2M and 1G HugeTLB pages are mapped into a device
> respectively.
> 
> This validation is done by inspecting the contents of the I/O page
> tables via /sys/kernel/debug/iommu/intel/. This validation is skipped if
> that directory is not available (i.e. non-Intel IOMMUs).
> 
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> [reword commit message, refactor code]
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  .../selftests/vfio/vfio_dma_mapping_test.c    | 126 +++++++++++++++++-
>  1 file changed, 119 insertions(+), 7 deletions(-)

FWIW, I'm thinking to add an iommufd ioctl to report back on the # of
PTEs of each page size within a range. This would be after we get the
new page table stuff merged.

Jason


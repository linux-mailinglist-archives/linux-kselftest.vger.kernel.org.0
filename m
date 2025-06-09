Return-Path: <linux-kselftest+bounces-34441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83AEAD1641
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 02:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FDB1889A6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EE9F510;
	Mon,  9 Jun 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4xOP3ja"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D22DDA9;
	Mon,  9 Jun 2025 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749428644; cv=fail; b=eyh3RVgAz71y4pZP/wNUkSnEvr+G1lNf+cUE03zoYYuULP1rpPhWHXCwvFbU2M5yr1mg7QpeJ++rp/lPap32EZYkfZFsm7C8qJfvlxPxuAxRwdYNTrJzNIJgvDFvY8ejneSjNl58shtzUGJb8itkl4FL5l8zrIV4YtYvBSvojIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749428644; c=relaxed/simple;
	bh=9N93gTF590Ei7oVgBTkMOoV00owrZ3tbJoK9GrmYunU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q/LL/gqqDJE8U3Atjqavm3EbX9HCQjqPuq5BcbToe7dc5NSgQWlo2MZTlY/MhhrMCrLRQeBhtEwOWdWg0dS7wSI3oa4dCmahuT+E8vcb8E92SgAk8drPGSWOUzoMw7g72hAzas1p2hAnOnxZFx3I0+FQr+sh8n+0kUFCn6RfytM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4xOP3ja; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIJxDWwxzuJUdpJFYw9ax4VTqbMaXEZ9gPB1wA7Oe3plsOoEOzEauYjme+zzmWwoM5tbE7IJQ+BDLxBQ+VwBP4VgdpXcTmOiPfNCqAPBNRN55EG0gdqLezuK5mZ3pwWwxGYXoMm2muZdkg51u649ztGS9BkD+CecYkHycMpQEsiD0m9hQqsxFhzl6bFB+G8JgzZJYaFtrhDaqIdU4bnDJt+r8lY/e67CXs9OfEB5mDvm8BF7ONzmfSzpDT0RfpxT4cCRaPcj4KFCMikx2Sb9g2kgXOKXWJnG5/ygU7IsBopphUIGK0sdlJtJ6wIFvNwdfRLyKyvmsCdHezG1bPu2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE3/kR7CtE9QInQfv8C+1swhaTQp8o7AHMBGNW4UDzg=;
 b=LS27L1aQf1zA58vd/Hy2ZopNs2A8SyQjqT2AcKOfeSVGziGoVdwrEjFG6Bh14Jz99NXpIANQMxYzPqwGV6CxtaSeV+TNh52RVdGCqAjhoMKDd4p7u4L1lisgAqyTxacwM3V9j/mc4lNskf/0bqyOVxzsD00VJAM6Ryj3Uj0xnUzjWwrICkRUxshJW0raZcx1X2MM4uCNXoCWHGPBbKqMaMwbTvWOa8FHgPCZrJRylAGJ4WoKEyhW4xcwUeqAXDX618Jy3tdWMxzxihnAvPBtjDJE9S4Ym9h2SLUqU5FOVxlRJoA29wcbgEJbAIba5QwLMgvgudv3H0GKrvZVmLkSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE3/kR7CtE9QInQfv8C+1swhaTQp8o7AHMBGNW4UDzg=;
 b=n4xOP3jaHYQdHG8kRgO8AFg0d2hmx0UahQ+uEYyLUvW2rlp0vYdH/6ANjHi/mNvYjxtjt8uTgS+15+Rnc/yzNN54EWNHOlWBD0pVqu50dgU2Yv3TXaUAzAA8HAyMKhk0AOvj8Ivzv6E+zvJ1zaymzG/lBG+nNaknGhNkTWlqnspVDs/DqMIXk1xcnhUZoJn0AmRI86So8oJn8uJlO7tbfQ60Xv0j/i4gobHXPHvoOm31MixMoMHenXzWMXRW5pAW66uS5jJNEk0fDc2EQSMurGl0FW9fGfMVsIM16v168AgPlp9XkgH1Yr80kQ/rbF1iAE2zm/w3ViO639eV+2ijdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Mon, 9 Jun 2025 00:23:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 00:23:52 +0000
Date: Sun, 8 Jun 2025 21:23:50 -0300
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
Subject: Re: [RFC PATCH 07/33] vfio: selftests: Use command line to set
 hugepage size for DMA mapping test
Message-ID: <20250609002350.GL19710@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-8-dmatlack@google.com>
 <20250526171501.GE61950@nvidia.com>
 <CALzav=fxvZNY=nBhDKZP=MGEDx5iGqCi-noDRo3q7eENJ5XBWw@mail.gmail.com>
 <20250530172559.GQ233377@nvidia.com>
 <aEN0Sr96nyJkN3fL@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEN0Sr96nyJkN3fL@google.com>
X-ClientProxiedBy: YT4PR01CA0201.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::9) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: a61f61c9-f44e-4ba3-f157-08dda6ebe951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mBySsqKJjNdHzUApmgkUxEbIP0ptACpnSqz7ZqO8tjCMUsCFxkZmyKGNZzkb?=
 =?us-ascii?Q?vqBbOD13kXBIiVq+RjvkNvUFgqjGtiwEdJBm+culZPniqBzQuzAeXHsjfJWg?=
 =?us-ascii?Q?CQU7KnV+oLuXui0ozvqYxvwb4frzveVQCwyFIeVeZU2eYtN1nXCSH3UdhH1R?=
 =?us-ascii?Q?C2c4UGDNYs772PIfUhRnppPQFt2NttRVwtN1XO8sYQDq4b+PhgkH0qOxkChW?=
 =?us-ascii?Q?GN6Qh9qZsjALgH2AohuZJE479uvhzL4vjPiRakT1/Q8YETFCGv/T/e+CHIOd?=
 =?us-ascii?Q?1LWszpPWBVr+W0z7EIYidyTLsomJVqdKeizc+MNYxV6uFm49xgcOpTaby2wn?=
 =?us-ascii?Q?ApTmDi1x6+BY162/wd3oy2Ayl3AtbPZ3gIqF8Fvxf+4K4PjLFjLiTeSgc9dZ?=
 =?us-ascii?Q?fsYAtrEOs3HjrOUdqiQsTwIho9GbkCtMbya+apmxyWMz8X7WcuYC3A36vfWR?=
 =?us-ascii?Q?IYY37RLK7/DkJr06j+eZCnkxsSiRn9Y5RGPMpE6gGfBHtkWIvQAvumknrMqW?=
 =?us-ascii?Q?jcbqZvoYEW9qGtzBZtpxIuFtuR+GXTDuZYGHubq8Sq+cWm7rn9rcugoMxgCR?=
 =?us-ascii?Q?1svS9rzOgyM5W4vloWOdBeiPjsO11GGFz2uLDDLxwQ2SJE62m8PrMHm96/j6?=
 =?us-ascii?Q?4eu4WQElaKdagOt9glkS/zPDUYlaYtZozDfR6tQ+gNzs5Bs/a4MeO/PrZwFb?=
 =?us-ascii?Q?QPa3kGYYFxyS6RnWfoWifjsK2emwFH2BeqdyAFWo31fo6KxcyvW8frJjXixi?=
 =?us-ascii?Q?YTuErrxgBrlO7xSUIT4TT85jEdK4ZkH84cORvE4DzPzGfNjUsDdaF3L8IKwx?=
 =?us-ascii?Q?Jip/yof2tevz7i0UkpAkRfeih4uO9eAsfPI8ZqFHLTNcWNnByfH7hk4RNsRZ?=
 =?us-ascii?Q?lcprcJ4PG9ju2YZ5M8l6vJrpX7UumD3wq4ol2i3/5AHBXTkbv/Z28va50Qh2?=
 =?us-ascii?Q?Ioy/0Htv8N5KPYqDvos+e/PyQDQsNkbNWJIQB5ehTncD2zlKy1Dlp8ZzAkRf?=
 =?us-ascii?Q?4cTc9VZuI4W4TfLJmU5xJOqNcxyHtbj+ahANKun99WE5hNiTpH5gyM2SB1s4?=
 =?us-ascii?Q?kL9IJ0OaT+lBHHIDOrt9oLc7xW9SiNNd4iBmAqzRsGKOV9qGULIOM6PdpiIj?=
 =?us-ascii?Q?N9nQEP1Lb6M4i1tOlsxDK8tJePTVYhccIOxC6jIykxSmpGuwWwI2OWvpgHk1?=
 =?us-ascii?Q?flAshm4B7gCyoKt16xH0e4rbkrIP8t8n7zSnr8trCiSAOav+M23wApEj9Rwr?=
 =?us-ascii?Q?klj7PEYS4N+3HOh/omtn9CZncD0L0+Z/SAjdIH8LuariUa7suZUrs/wk9tWN?=
 =?us-ascii?Q?ggld7dhrelGm/LUSmCmFSQuNxjAz9ZJBhBEYBY/weEZL0HquvqLtMYenDCea?=
 =?us-ascii?Q?2uXs7gpagD6K8qHk8O8xg6TrsIPJtnrjWs07kc35R5jscT2ZfTo12cQUOzYG?=
 =?us-ascii?Q?Shk1Y/Gwz6k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZA5oVPeZ+B9Q7B/woO0E/bg71+yaowPDQPE1vZq7v5nyaXXwigeBMDaj1UT/?=
 =?us-ascii?Q?gMYfd0IwuUBOBuQx6jjHarHbkLS7mJGvvfoANgBgSecUgQNtbiHroTdaoAVL?=
 =?us-ascii?Q?gNx7452uvusdP6d1VGY+1itCNjdGtdbEV/CdPiq49Ob8eB3Avsc8zubJkesW?=
 =?us-ascii?Q?gj/8UMudfJ7Wq/U1zVUa6aAAjk8plY+bOISe8KTnnyUI4O1FiGTuRFv+dZXi?=
 =?us-ascii?Q?wCSeRI/6wknU7vc13t9il3WS3FPrbUbyOwDCsGFFZBx0VIYQTz7VyWK2EWj5?=
 =?us-ascii?Q?njhhic6UJlHZsHY6e75CKdQV3grw5Q99D72StXs9Czk+N9nfnnqcDRNUjaag?=
 =?us-ascii?Q?bVoT8RE9azijH1QYZQJl0inYP9xvgvAptClZAM8TNVQFoEP0ccIr9Iq41dSs?=
 =?us-ascii?Q?b0tjDoIs2bbUZiJ/jO2GDU3jnWrVtEZrS68cJ/7dJtX3gmntbcHHIYbDS8X5?=
 =?us-ascii?Q?kk2Bw0ZSsdw57HLEmSfhq278BnUq+ZOv0w0OPrzTqv3+hfgEENtKrdc7zqQi?=
 =?us-ascii?Q?zNsgfjhyppp+5A+exrAkrov3Vyv8YZ5FYVPTxS2gIeTjzQAsFAqb1W6jtTnD?=
 =?us-ascii?Q?KPSfWAfXb0sZzfFMLJ/9UgcZ66mIPtj1hapN6jjK670ahCrCMaTKkehj/Dv7?=
 =?us-ascii?Q?T0Yt+lsQ+v956Tlm8et2RV0kUQ+LWxmgGK7LDrhBzCmZBhAoNim7TCbdzKjB?=
 =?us-ascii?Q?+tYZM+l5af2Ms+JsCYXLuWIE1XrUp6nxxFuoY9TgtSC0z+PyNzBkkxsO9VXN?=
 =?us-ascii?Q?bQ+sJoOaYOnZ1lYbKBiOcsnMz65V0lASQL7VWiZyfndVizn88uhEzcXjjzqJ?=
 =?us-ascii?Q?UeSqFTsIAW2/FcDxka+HXbAWQweZYNdv8UX9wcYs1IHoG+IJMSRxZ8ApAeOp?=
 =?us-ascii?Q?WXm0UgKqHFN91oWT/rC+yghQZool+15AJdcDf5a7dqntI5yQbl9/KcKnHl5h?=
 =?us-ascii?Q?QsqaK+GWzsQ2Zjb89mrJ9EhD2usgNOCMrP2mic0qe+XAaafpzNQIeVU3uh33?=
 =?us-ascii?Q?kQJjmuiAQQ9cRPiCGlJcW32zaNghyC1UjOwJ29zj/cBBjGfu96banQclC/I3?=
 =?us-ascii?Q?n47auWjbD5A/dNAPeHFH6FDhwWvg6drUlRWaQ9faLg1u8Fr7troXi0B5DQ6z?=
 =?us-ascii?Q?jte+WiNWbeaDX2vmY2EwAegrE8NZ1obnFToZxQVIAB0mYIY09nQqRUseUj/r?=
 =?us-ascii?Q?jygWmh+3TrXlpBNmFejt/hHMynD5BnV+DxTBT+6JoKJz+VKGdUUWtwA1Swnp?=
 =?us-ascii?Q?006TZZlwCMXKoW+1RHQ+0iC7T3GZJQL/279OHbjgeaNZiW9o1gDaYBP9Eu2H?=
 =?us-ascii?Q?XJbeePhYEiXr8jcCMSKDYOBcX6I98evTTB+70JuxMkNkE+4wiVFK92Npyl+e?=
 =?us-ascii?Q?ioz5QHSxLsahO9Hyz6Ds82fgj7EDAIWdnbtwtB7IMfxGZMKDIGxvcghKwMvu?=
 =?us-ascii?Q?OeNg87mCJQ+p3hlUErGBXxwz5H40HrMOzeorcx0HR0RRLIeRkqurwNeiKHwC?=
 =?us-ascii?Q?Gg1kTp7PZ078xu9cxlEjGhjGWcBney18fw//OF/Y2YazM2G9NIpP1jNm7Ygb?=
 =?us-ascii?Q?mK/HXSlUF+q8Myw4vi4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61f61c9-f44e-4ba3-f157-08dda6ebe951
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 00:23:52.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqcyFZhNarSUdLaj5J+AwmgsEEO8svUt0E6yNQl+wt4Q08TQfCUxMcs+LI8RZCGW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390

On Fri, Jun 06, 2025 at 11:05:46PM +0000, David Matlack wrote:
> On 2025-05-30 02:25 PM, Jason Gunthorpe wrote:
> > On Fri, May 30, 2025 at 09:50:22AM -0700, David Matlack wrote:
> > > I'll explore doing this. For a single dimension this looks possible.
> > > But for multiple dimensions (e.g. cross product of iommu_mode and
> > > backing_src) I don't see a clear way to do it. But that's just after a
> > > cursory look.
> > 
> > Explicitly list all the combinations with macros?
> > 
> > Enhance the userspace tests allow code to generate the
> > variants? Kernel tests can do this:
> 
> I got a chance to play around with generating fixture variants today and
> eneded up with this, which I think is pretty clean.
> 
> tools/testing/selftests/vfio/lib/include/vfio_util.h:
> 
>   #define ALL_IOMMU_MODES_VARIANT_ADD(...) \
>   __IOMMU_MODE_VARIANT_ADD(vfio_type1_iommu, ##__VA_ARGS__); \
>   __IOMMU_MODE_VARIANT_ADD(vfio_type1v2_iommu, ##__VA_ARGS__); \
>   __IOMMU_MODE_VARIANT_ADD(iommufd_compat_type1, ##__VA_ARGS__); \
>   __IOMMU_MODE_VARIANT_ADD(iommufd_compat_type1v2, ##__VA_ARGS__); \
>   __IOMMU_MODE_VARIANT_ADD(iommufd, ##__VA_ARGS__)
> 
> tools/testing/selftests/vfio/vfio_dma_mapping_test.c:
> 
>   #define __IOMMU_MODE_VARIANT_ADD(_iommu_mode, _name, _size, _mmap_flags)	\
>   FIXTURE_VARIANT_ADD(vfio_dma_mapping_test, _iommu_mode ## _name)		\
>   {										\
>   	.iommu_mode = #_iommu_mode,						\
>   	.size = (_size),							\
>   	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),		\
>   }
> 
>   ALL_IOMMU_MODES_VARIANT_ADD(anonymous, 0, 0);
>   ALL_IOMMU_MODES_VARIANT_ADD(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
>   ALL_IOMMU_MODES_VARIANT_ADD(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);
> 
>   #undef __IOMMU_MODE_VARIANT_ADD
> 
> Let me know if you think this looks reasonable.

Seems reasonable enough to me, not worth inventing a programmatic way to
generate them..

Jason


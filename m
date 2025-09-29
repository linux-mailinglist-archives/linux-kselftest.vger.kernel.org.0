Return-Path: <linux-kselftest+bounces-42592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5961FBAA08A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0B5189E1DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E1E30CD85;
	Mon, 29 Sep 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hoJ/FfLx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC32D3A94;
	Mon, 29 Sep 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164286; cv=fail; b=ml00AzDdSnJwGoYrVUTWGGyTtTYudxqHLBdEnLKW+xHakiIRaXXnyIThtpe7yu3GkDAjxz13pJhxe1v0a7286A4U/NTtSh7Ko9rGdF7H2HwdycbpWKbGXIu5SaeiRboMr0ICRlP25hXKdv/Yef+JpNmf8GYy1w/YCl/UwKRgkP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164286; c=relaxed/simple;
	bh=fiz7UaRnyjbwXkcKgIHIEzCBXBrcoCl34qQMcjaaZ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GDo0IoHHqmA53s3ChU+8+Avu2YvClHjbCcRMIfTCyIyusrmxajOzw9EdZs7gjdSVEC6gd+DF/yFUbPCoMX3/fLvuAklufNMCao76cYAFacT69KAl38JrMxwO5N2ROiHvC3zt6q4B90iwEBnXmjzcUI6+VgRzCg87ioymIp57sX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hoJ/FfLx; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIg+qGGbldlxTPFdiKeiK5o/5GAiyD0EitmGh7MNZDEMopQWl5+BAdR/o8ArtkdezItWM/+mUaNXEGYha8vQ+3jSZH69Mpw/PjaWoRoiQHyxMRH6fEkdx2htAPPUPxxmw04wSmsYPsEbFL4MyqO7dKyq5G5Ltu0EUVtXgljm0QO4PCyTyjx3m1Cu9IBiXypIzcaCrByDbaKZstA2VgP/ihI9uNOWQd/oQxZiXAdAKPmE2eFuogbegTmDKZRWjsunSvBjuVG0a63yv2uUC8PRTAcsncVF/x9nHTmdZaXrl1gkVA+hZiYyOrY7OttlHlmDap1vZHx1CgB34KKhDK2jVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/og7uJVaGEwXrge0wZEUST68eZLlq3WntqsbqL2l4c=;
 b=b5zF/fO+vD4eYhyMMyb0VMyHOxBpiyluY2D3eqDLlreg9njKgYdqqyWH0c9Ewqh1N1Q+nLIBZdFXdvgVZTOhkIPAxDM7tdpp7TubkyviunIPi2TYqIXXewj2hSERK7rAoN8cjUNfZ2jZH6Yu1VNx0XF4Va4jvCgsaN+23WUpBsM0JW9KGmCroQ6ghg8yiKdfwtgkSd25HmeUu4DSv6LlOmkYWWiQcFeg5UcbauQlchSWgvRonigJfrYA01293rUd5TVg1XmMrqmNp5jwwG398kaUYvjXGF/DYulB2p5gQelfp4wC87AwhK34E9RAOpBCnH40HEHV3re1b77MMWbusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/og7uJVaGEwXrge0wZEUST68eZLlq3WntqsbqL2l4c=;
 b=hoJ/FfLx8LxfaQLsU8ygYVTYgtFVn4qoz6NYzhOfuKugzqOI9efqaTtU/jg2StpR1ttasaQYI3zhcUHhrDdCtxZlJGn5dEOfMbscSbXgl0YW4wIsUIgjRbFM/8zlwvzOymVBUW7oqCpcHKCDhi2Q/AaXLLlow7b162YNBekbtkl9nd/qdme0aorSKrpB+Ig5SxkWXuKkgI5C+AWlbm9voS7NFSmhw0VCMUm0tspJFWBAKJyVsqUSPgElL7mxwW3+3aDK7DDSxWD1MZeBFj887QKck4dsdeK1GRwcAec36WWyPTbb9YfZZxVH9s9/xzmjKMw2lLsSOB6TecKmdmKrFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS4PR12MB9795.namprd12.prod.outlook.com (2603:10b6:8:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 16:44:41 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 16:44:41 +0000
Date: Mon, 29 Sep 2025 13:44:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 07/15] iommupt: Add map_pages op
Message-ID: <20250929164439.GC2942991@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527683EEF36AFD41500936C38C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527683EEF36AFD41500936C38C1EA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:208:51::40) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS4PR12MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: b29f6e7e-6168-4bba-6d7b-08ddff777c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l97MWzT+oU1e2htKs8maolfv5AJ93vLB6mDG/w+0iSOf1+x7huH5OaxS3dgv?=
 =?us-ascii?Q?wGZD/y1FErqdPMYEzZgolL1bjjouLer7Tb3mYZH/GqhXEbml2RJzUmNgttm6?=
 =?us-ascii?Q?A5xwzOgJTND/nC9EFbHxjg/xRclZ3joAyWPno2ny7fXBohMdNSz8rKdz15p5?=
 =?us-ascii?Q?gthfvL8hnk7HRPKKlQ0kZf1a4oU43Z8I9G5AGKhBSovcmLLSXsebvlWG5qFG?=
 =?us-ascii?Q?jFhv0PdDSCvBnomOBDq1TBjukeb+4ydS/byymM8KnnmUSXqM4tV3CeRPFMmB?=
 =?us-ascii?Q?5TOEyShOVoWqzc4flrZ0LgqUg5UK7EOT6MmrCCPIiJMvTGa7OagUdiZ4ycWe?=
 =?us-ascii?Q?1HKf+Qb13CfWkLidPNlYMASqU+guLHyFcwNC8kr8dplRhOEM97AmNqIseSHs?=
 =?us-ascii?Q?6AHL6P6LZBzbqRg7yX6D9t/iaBQfpgzix1CDnewVBMx9kCyf8Nv9AGzIKu1K?=
 =?us-ascii?Q?X65PVaH9OAoagNvqb/yV78NcTGLd+y0x2WW2qjD/19Tof6i7By7ijab7hMay?=
 =?us-ascii?Q?DBkfuVwiJ+Lp1pJ0mLgsKtPelSyjSxBGWZXStI2dEzI5e254ZBRjLBqimO9f?=
 =?us-ascii?Q?b1I2iChHlK+3+0xUEJonmNrDw5cX7d9XXuWnHN/32BmABn0ZxcQt1IfTBBoF?=
 =?us-ascii?Q?WzT5T8OsSBLHx8aELRHYUzrvUWkaTiVGTHNn3x+lWx9+0MD9qaRxdlz5uApf?=
 =?us-ascii?Q?12zLBWYld3MbzGfCdpSNWdilLb+wvcAwQYgofUi9Rwr/5eib3Q/h6F9KYZNW?=
 =?us-ascii?Q?wZ6EB5z2duaTKx1L4Lfhpeq7fe1k/TGVCnvs8TnZOAuPvJdrqK8RlHKE3abb?=
 =?us-ascii?Q?ET5a2TBx7Hmxj5NKT4ruoDpe5gASgD5OqV6OjU7RAOj6Ck+WobXlQpWgGer8?=
 =?us-ascii?Q?w1Ic7WvgfJwo45V+jq47wCywmu9yDkvxOcJOvNHRe2YpQ73ubqa1eWk9f/SN?=
 =?us-ascii?Q?4/7JmjT0/YJdd2rtwycGsVflGjAI106s5HtKBBqacBlRdq/qwipHw5tnONQx?=
 =?us-ascii?Q?UfwH+NfGbuzurfBymzIKlBza0aUUK/cC2a5GGwkoim6anMjzp6W+e5z7V5dg?=
 =?us-ascii?Q?sVe9G28MHa1n47rwbdp3+/WwRvgMuXEqHMuFyKRlFYxV0V3C/+dqHaCDJkkh?=
 =?us-ascii?Q?7nLyVvTuiAi6Ga+QMsRRuFGHxT0yD85npy9WjN3p59hLw301PffDompnDN7p?=
 =?us-ascii?Q?Dp/9JJpc66kjXX+4MgqMUr0IPLtU3DpoMbCyzh9N5OMEJpu78trA6N+PJJy5?=
 =?us-ascii?Q?h3DRWpX5SrY/jhlSo4nWa41XRzkKloh5FeB7czFHBw6xtHzlLtc7w2IVCTH4?=
 =?us-ascii?Q?wn0+aMglOT/fv1AFyZXk+xYBesB6KDVQbkVWPOBbtzdbJxqBu5Zh/dvD/RIB?=
 =?us-ascii?Q?i0AOtSWgh1fOc+/wrJIzw4tPzBozASBRCbW37cdY8HnTfzjMMSuoy3tG7hCM?=
 =?us-ascii?Q?HWqlNTtJWulUk3QZS3yNvKRmCemdag3q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AiFUpZYynWPnETu4iOKIs5HhJ0SbrSg5ZWOvY3RDiwe5Vi4j/Cf97cf0XkRd?=
 =?us-ascii?Q?JonLTWrvgZiFs8Fmrz1I4YU343MPPhtcAn6j5rahp/SjweYNyieaZEUyVjMb?=
 =?us-ascii?Q?0PfV1SyYfCaA6cTRQjmU8KEtZ3GZ4L0A6yFSzeZvbZJGh739DtSluq98c/wZ?=
 =?us-ascii?Q?ehBJ39YGoLezTJm5CE5NDtXDigrb59LhQ0FGjfCnDsMZAUFRbvyc5qAQsVOH?=
 =?us-ascii?Q?TQO7EJd7tYuMuu1ZMwescO+AkuQ9I340h6oRq928eyBlHd3HDh0O4CMdTQHi?=
 =?us-ascii?Q?2h80+2b+tDXZNgTUqX8NzVsbBFnLuhGakuWvBAOc+ysjU6n1AOG/4LY1pwAc?=
 =?us-ascii?Q?JqCX6lTymjFDzfLLuVr5B3pjrDUiDhzxHfHPs+xfzs28Yi9RqV6lBlVqsYu7?=
 =?us-ascii?Q?9LGZEVhTIdRSgp5S6Z5wSSoFE3uypM0hPMzVbzS7BOL12KNAzQqHlzfu8FDj?=
 =?us-ascii?Q?+eC8ol8/yP3SOr69gArsf5Ogi6L/jfx/CENsn9725oKhFOyW/dxXUWFqBU3Y?=
 =?us-ascii?Q?CCcyrmVP7IxBNcTyUUg5Awz0tWCAxEmTCFwPwM/fZw3UMv1y5sFWwMVLxyX1?=
 =?us-ascii?Q?RjxB8BtuMqNMHrHUQhy0G6LKjsUVJ0+CN5i6bHNVB2iHDVy0ywVFWqa5ATVh?=
 =?us-ascii?Q?liRNVWEiMc/0D0UQOfMzYnh5h/zQplOQq9s7oEaShF4RnMnOeRA0BaP28SGf?=
 =?us-ascii?Q?gupUpnrwY4SmarSdSGtkDth5WyJ27RA2aBMt4XnzNy7CyVm+YEX6A6tUQirt?=
 =?us-ascii?Q?htwBhkCHU+PwELpXIANEmIy+XrTQnyfblXjoYhA5VoeUC8hpltw0eDovWF6L?=
 =?us-ascii?Q?x142sdMxGhCwayTm3zMkWvwIsG3p83gLWIKaak2xbh/oiZOo7ouOrMhkHS16?=
 =?us-ascii?Q?Zo8DSVrZOckuP1shfmPMO7NpM65hDRDF2SWDCUrdhMovH5HfV85M7G8OT93o?=
 =?us-ascii?Q?mUzWz0xIAvvzVMhzzrwQ0VHc0dDC/FCy82EAx4j/iqqLoCY3WeGBy1Jjs1yd?=
 =?us-ascii?Q?asbUIwQKMABSAEZ2RuH91lgG0BNzTJNx2u/tXLULw0RZ1TP4++KLTHy8DEKS?=
 =?us-ascii?Q?S7KjhHNnor+dfRCnVhq1taXHa9JO0uCcKdzijKcvuFm3HHmp/iPAhFRjiUOl?=
 =?us-ascii?Q?S+5A4SKghneVWbsmXae0pOp5Nm+Wv04AmODK4ViYOmoKgCHMnXph8U4RZib6?=
 =?us-ascii?Q?3hl2cGR3KVcHun+WAqZUV7WY7yyALGd22WtCD999jMTC/y9vGdHr0eTj+hne?=
 =?us-ascii?Q?XXrSPCB3918oB68xCj/yjOxKQk390TFnKSr32cJpapXnacciMzof8KzDJpbY?=
 =?us-ascii?Q?5lHRcYYvF634m8VQft2QyYuu/758mHtE519p00KP3jGD3sh8A6KMZuv1IXVQ?=
 =?us-ascii?Q?BkhbHEhUqhS3bFOZMdC4qnQmC+higdC19cQsEwxofyzFZFpQ9QSsfZvYW0px?=
 =?us-ascii?Q?Q+W8sJBCujj7YD6uRS1QZqbrSnLYecFH6QzXzPPSzsyELZppJWKZgYbmpGZf?=
 =?us-ascii?Q?/I+RETGT+18YA9Bvm7gvrP2FkFe01lSlnW/ZmSA9mYDkjlswaZeGQnmEhuXS?=
 =?us-ascii?Q?o/q2zyn9aMJfWmDT7KbPUNfWOMA1xrydmZQLBR9Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29f6e7e-6168-4bba-6d7b-08ddff777c79
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 16:44:41.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfJVDkMebk0eDsqjnNUfO0khK4O5vuOF1UvdfXUJU1me9LlGz1msEKgCKpAonqRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9795

On Fri, Sep 26, 2025 at 07:47:31AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, September 4, 2025 1:47 AM
> > 
> > map is slightly complicated because it has to handle a number of special
> > edge cases:
> >  - Overmapping a previously shared table with an OA - requries validating
> >    and freeing the possibly empty tables
> >  - Doing the above across an entire to-be-created contiguous entry
> >  - Installing a new shared table level concurrently with another thread
> >  - Expanding the table by adding more top levels
> 
> what is 'shared table'? Looks this term doesn't appear in previous patches.

"shared table level". It is the actual 4k page. Shared means
more than one iommu_map() calls are using indexes in it to make their
mappings work.

like if you make 4k twice then the PGD/PMD/etc table would be "shared"

> also it's unclear to me why overmapping a previously shared table can
> succeed while overmapping leaf entries cannot (w/ -EADDRINUSE)

It has to be empty, let me clarify

 - Overmapping a previously shared, but now empty, table level with an OA.
   Requries validating and freeing the possibly empty tables

> > +
> > +	/* Calculate target page size and level for the leaves */
> > +	if (pt_has_system_page(common) && pgsize == PAGE_SIZE &&
> > pgcount == 1) {
> > +		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
> > +		if (log2_mod(iova | paddr, PAGE_SHIFT))
> > +			return -ENXIO;
> > +		map.leaf_pgsize_lg2 = PAGE_SHIFT;
> > +		map.leaf_level = 0;
> > +		single_page = true;
> > +	} else {
> > +		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
> > +			pgsize_bitmap, range.va, range.last_va, paddr);
> > +		if (!map.leaf_pgsize_lg2)
> > +			return -ENXIO;
> > +		map.leaf_level =
> > +			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
> 
> Existing driver checks alignment on pgsize, e.g. intel-iommu:
> 
>         if (!IS_ALIGNED(iova | paddr, pgsize))
>                 return -EINVAL;

Yes
 
> But pt_compute_best_pgsize() doesn't use 'pgsize' and only have checks
> on calculated pgsz_lg2:

pgsz_lg2 is the same as 'pgsize' in the intel driver..

pt_compute_best_pgsize() takes in a bitmap of all supported page sizes
at all levels and returns a single page size that should be used for
this mapping.

The single page size satisfies the same alignemnt checks vtd had:

>         PT_WARN_ON(log2_mod(va, pgsz_lg2) != 0);
>         PT_WARN_ON(oalog2_mod(oa, pgsz_lg2) != 0);

The above are equivalent to IS_ALIGNED(iova | paddr, pgsize).

If no page sizes match the alignment of va and oa then it returns 0
and we fail:

 +		if (!map.leaf_pgsize_lg2)
 +			return -ENXIO;

If it doesn't fail then it returns the single pgsize that should be
used for this mapping and then we seek to that table level:

 +		map.leaf_level =
 +			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);

Then there is another safety check during install leaf through
pt_check_install_leaf_args()

	if (PT_WARN_ON(oalog2_mod(oa, oasz_lg2)))
		return false;

By the time we get here oasz_lg2 is also pgsize.

> Looks not identical.

It rejects unaligned the same way though.

Further, this is all dead code right now, even the vtd code. Things
were switched over to map_pages() and so the core code has this:

	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
		return -EINVAL;

then iommu_pgsize() is guarenteed to work similarly to
pt_compute_best_pgsize().

Meaning the drivers can't see unaligned inputs anyhow.

Jason


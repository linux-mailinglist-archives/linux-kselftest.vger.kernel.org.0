Return-Path: <linux-kselftest+bounces-24236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C91A09C0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF993188DAC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6475E213E95;
	Fri, 10 Jan 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l1/hV63f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D7212B10;
	Fri, 10 Jan 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736538597; cv=fail; b=g3Tne0CX+jc1y1KqRoiWXTKqlwZ/0tpsgcmmiJCjEOKh1igaHnJDZCmHnSFn+jvkvRE+RownnfeUzW3/zLAZBHjCALp+D3U7yMv2LZ4YViq3W3+ylb234XCh6ujARoRzRrpKBq5gVzBXJzHTTc2r+abrnSkb055Q79jRBt21Bks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736538597; c=relaxed/simple;
	bh=KTVk3SCcDVKncd26hoTjgK2/OKpPiQ31IorMH83knuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7hfgzsjBf2U+QK5m7+2hfhm5ELpXocyqKlAyst2Ft/IozlUy8QLVvDGFTSZmvJORnbfpOPB97bLJ0R//DBCC0Zt+YfSzTv9HU6aSRFdnnEEIFACRz7PEzS7wVnXN2TYu+lW25Q2buvP9DECMAwnOakivUuZMDcp/edT8BFn2xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l1/hV63f; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQhItSxONu4SrUQaOjFebSGoqy4lKhiXuX4YNCui8j/JUAPqho6GBr5sn+5r6iOe75BX2ViYhYCZuiQslizQOxM6N64GtwVv3Y1+UVtrO2MinLyieqZs6FgO/w+eSuHSHLDGbu3WdOGBImtJaDw0JubSW25tQanEYfbO9i9x+nO/cgVtPm1vPAhXuvlhCLU+bZ+5lEejEh3GhEGE1SG4M4L2mwB6tzba39FzZN0P6Qaawx3WMcaUS0kpXViEe/YttruSZEUkop32lNfujxi56V1bpbo8vvY0pUgWy+71wLp0wDHsb3U9fIV1d+bkQk48eTk5FeQrfWAB26eGsvvs4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zITbeh+qZFfGSmmKpAr0YYLwRPPEi/KV1jKD0SygKM=;
 b=maNOiLxmqTzKtM5Ez1xqjJe3Pbj5OU3Q9BwVjw8UgahJOkTKyWSBxU4dab135hdMbC59f765F60+qx06JnAgPn0vZHbSPR48dmdlViNOLDzQPHJWNOL4Cwc0ahD1uyfINa/Uv7A7uf5Dg1mzUBiwFMEHr4F8n8/2w9/XVSQt04GeefrXrIn2LJcXAFqE99aDU961K4ViZfLGQOS+MdHh/6dfcnW+cDhfNmYyP28Jkllhz3/3JAyX518kPrhlluZ9buE8qcwYEFkkKbBv9Dk/oyUf3nekCDwmp23uVGECekIzGknqq/rxmVf6KWxQToCg2JAZbtOulzT0xOJzyF4naQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zITbeh+qZFfGSmmKpAr0YYLwRPPEi/KV1jKD0SygKM=;
 b=l1/hV63fFzupslOBm2JYyP7TUr7jsjtX2Qc5KSmupwZKieBFR/eII/sREnbj19oaJS/bGXericnYVs1vRtwlmb5OAKOBLFIvEwdvDPnfrsvBEQjWw0N/4ZrLNBdNe7D4Uhrv03mFYc8pAt8lYgHMex1SGp/+ahwQKYrDSbGd8R6VPZNHMeFvWgfG3J7OPUt8wBmTKChJtCPa9u+izy0mQVeAuECuuI6njaFTyamFM4KaOnX+RA4jCjxJ08Vpx0HsbcjxIFWUw+43597NmRCuw6PV7oJVqRi5R+al+bkl2TcuZvtolRoWhX2OvOYzaD/y9U1JibiR0uR7jdrMPFid7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:49:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 19:49:51 +0000
Date: Fri, 10 Jan 2025 15:49:50 -0400
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
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <20250110194950.GI5556@nvidia.com>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <20250110174842.GI396083@nvidia.com>
 <Z4F0uZBg05J7Nuhl@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4F0uZBg05J7Nuhl@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:208:238::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: ece62c1c-8c92-4b1c-9100-08dd31aff29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7NwmdaSy2JApM46WvZAz6AGSwcR5jNJw59Q0ZVOSnKA8j9vUiwYCw1+2DJn?=
 =?us-ascii?Q?FwKVmIZHceNBRb2XYQM03fofhLWwjBs2e9shq/Ie0FrbILmmHQHS83jEuZKN?=
 =?us-ascii?Q?PZVvp9D3y4oqQz647JIaZSa7rq0GskJxapCEiLAvqR0M847wig11T8cbOCvD?=
 =?us-ascii?Q?HmywBIYFpK6x9VCvaG7Z1uYdAfutNz81PyLHsDR9rm5/N/JCi/gwiFNg+YiF?=
 =?us-ascii?Q?mReG0ioDEioOyy78MOUtrfwDOwnn3i9/LtAx2pDDTU7ya6qWI8qO1FhepvOh?=
 =?us-ascii?Q?rL7Qhkzbbxp7a/QmehJyIgbo7OLKOC++1kL6MtTgN9hWpPvRjh9hkosDVzWT?=
 =?us-ascii?Q?vBHQqLrZ3J8jCmuIVZENBZ0DAheZ8Gb4LKW62Gnm5eR+iEwNZ78oLOByAxlP?=
 =?us-ascii?Q?JE4neB1bmg+Ejqe4PDVSxNcAD4c+9yZuk2m6TA8gYei8caHcKL+sy2KYgaOH?=
 =?us-ascii?Q?tyV9JyuaGMN7CP+tMooxW+yDmiWGsN746ifYtwe6+0yQPeuZBxylUhy8PNZs?=
 =?us-ascii?Q?PkKYqXyuOxhWVGTzvVq6G4pcS/E0aD41DCTbAQ++4UhLj6ZQnzDJ/IZ0Hq4R?=
 =?us-ascii?Q?YVCHgAVIL6R+8KFHdUY5oISG9JmfZyoQGw/MN2SN5ycjHgWJ7VZjXiYhvOtd?=
 =?us-ascii?Q?k266JSrxWDI+SGrmhwaBmoeQp+rAe5AWw8ds8LtH26knbCCmshlFVJnwdCtD?=
 =?us-ascii?Q?0HgyAvAInD2fboq++1Anoq1/NIkT1EzaDL9rOd+fZpqoEdH9DMoKC/5SHWc2?=
 =?us-ascii?Q?K2rq6eb0fUVN0X+BzhPX5JdCDYxw1NHm1qMPaCAz3tFpL6NB/sq6b9MmnSAE?=
 =?us-ascii?Q?oNW7DuAYjdLHG5ygLBovkapusS7zC5zBcorNeDNAGFRLUH0otYJ1jG/2+OnE?=
 =?us-ascii?Q?pXNFbKhiw2wgvRKUoo3cq3seXSpX/G2yZ9hH5ZA7H5kqxt9a3aZnByiPR2Tc?=
 =?us-ascii?Q?8GNCkFoT9cuAm/zwfTrNlnB6oZ9gkd3wxtdXG6d+wXXJ+BD1x4rRx2J6Ur78?=
 =?us-ascii?Q?zUdylMGEvh8RucB3e9HD6Rl/bhh7KvI02P3n7QPG9hOP3g0k+TAj2o/GtlvI?=
 =?us-ascii?Q?0DVPJ/nAwMZ6JJwbNnPKT8bNceN8Iuy64T4jFGoe438PgFkRx9DsD29EFi/e?=
 =?us-ascii?Q?BL/uhoDzKRyeggWeDorYh1rd3N7PdsHRIVhBhowMFSvufCwF20fmEIFv820i?=
 =?us-ascii?Q?ltcE997KR7Ldv/nH9XRxXrm1MMB3p87DU6P96om7/axf6sBTuU0aTw/46d/8?=
 =?us-ascii?Q?NRpkTJCveib+pAGmLKIVuWtDIvDFAlkYQ9swJHz45c+Vy8jVvxWyqFz3w2Fb?=
 =?us-ascii?Q?XCwWFAfxk5rqRq1ZGmeb1gIiv4vHS6JEZI5vW73MBuSxd1AlmP5vP+aRXz1g?=
 =?us-ascii?Q?pL1oe6AiwVQdf+96DJowXr/u3hkt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/gTm2S8oJXUUSPfdL/N7M0JZ775xHaY6NCdRNGxA1ehm7V6rJsLMeyp1EMR?=
 =?us-ascii?Q?OwNoS19sfQn/liHEgXDp41VD0iOBIQIdtxuxs5SCzGloonBjJwgY3kOTJByt?=
 =?us-ascii?Q?/2uBKpcv96HdW6EN9Q9s+5GyWyBrjHLEtOGSr4jZqXROO9gqTuo3dJE65nR4?=
 =?us-ascii?Q?B0U8wxwhKsr1jaFT2SL1xCylP0mvXUyxriXxZUG+j5wdAs+dxnsL3FnKdr7f?=
 =?us-ascii?Q?HTdLODzKOO8M8FM3Sqc5C1xiAJRB1zBWbUe/kY2igL1Lbd3McaJfACsiFSxG?=
 =?us-ascii?Q?xIN52Hs8Kzjp4czwMWuamYgbO4A1pxg+WGkyyN9wl9aTruEzBgKYPLVAkHgp?=
 =?us-ascii?Q?ipgltM0goGrEEmojMGLk3PTJ9CS0vXJKo1d650JCKKWfQ5rffdrMxUAb9SOA?=
 =?us-ascii?Q?HnS/BhJrraxZMgpWD8wipJBo8bdZRH83YIxKJ/bcDH+bZn1vAJY6mtkwV8pT?=
 =?us-ascii?Q?uuXmWSGk29ftN/iLp7xBgMBzUeB+Qw9UhrBBOK6k9NUjLe03+8NmmP+YGmQZ?=
 =?us-ascii?Q?3aVypNPnHhxbm5pmxjjNXQ1de6EqCHX+ePhr9IMgNxaKY6/zFrb4geG8K6bP?=
 =?us-ascii?Q?mlq967N0XeSoNlDZN1ap2R4/nunpPjiNb3AddEaoF+Eqd+pwtHeu7ufUb9ba?=
 =?us-ascii?Q?CLt1l9SN0eAxhCL2UTI8u9M5i9MQqu5HjNP90c/uSjymYRLixO9apfxs1mFK?=
 =?us-ascii?Q?/lqP6jnkpHduCImQASfJ4p4uOJpKawltqJJBFFqJktkh4Sr3VJMgG1Wx91pf?=
 =?us-ascii?Q?IJGdPDpZn3k2eD2LeW7Zlkn5XPghSeIcN0Ho8aed/1Non645UbnSv227yq7j?=
 =?us-ascii?Q?OxLWWlG+nvQ9Zbq+Tlyf0t2es+eg2jJouzHZW5w9q1ACDX3fdBK/bsCzgcVN?=
 =?us-ascii?Q?fDNNpoqqu/FQkNwa/hWyo7KCe09O5Bab1xJEBBw2FLHKRuuteux4viRYJvBu?=
 =?us-ascii?Q?qKjavnfzPBLwkDET56kPylmAakkRYDoFpBtNFl6Q1fIrfs1tCHVoUHwlzj0m?=
 =?us-ascii?Q?j5OTS34nCfn50OEe321laP+s5KhUdK2HbLar5XEDSaTlBQbmW6MjoakEpIdw?=
 =?us-ascii?Q?my3gEqkqKpp6pX0axN+xf+wISnBPqLPx8NYtDMEWZ8sG5HHbeKQVkTuC9//H?=
 =?us-ascii?Q?h3QaBjruCK0KliIhO5AvS+uRAGkaZWeJRv2GDhXbwJEyOkmqZ3VexPjLY3Gs?=
 =?us-ascii?Q?BdgeFSU2+OEqm8XsIUxMRhipjWcYmAGlPa+sIJnHj6dR9ug7AFaKbbi91q09?=
 =?us-ascii?Q?totXoYZH4B/ElrKZBOo7NWoqWwJpIuMynQ2Kt4uYWIhMYSdld512eORIpGCL?=
 =?us-ascii?Q?IusdouLVODjj7cDaHdCsHWoo1aoU1Rg8FYvcKLWvUzcIcIs4rIsaepUixGO5?=
 =?us-ascii?Q?R5G26hjZGi0iFKBmtxfDpZtv7A8xFiY1FAQFE7THP2N7pdsNqObpAoZFk4RU?=
 =?us-ascii?Q?13OC+SuEoBlQFWUrZB70NXUeyiRGFD26umXoSKmPnYEXzVLwSyEKiNo4qhn3?=
 =?us-ascii?Q?/VYe0OjTeMkxw5G3JTFh1u/qxJH27GBqaSestze9Dh5zHQyJKRrrcxF+5y0c?=
 =?us-ascii?Q?2B88L1642OVwFn4mDZo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece62c1c-8c92-4b1c-9100-08dd31aff29f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:49:51.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qfAc69ShrV46ZYQIfS+LmpPhy5aKxmA8UTL1YypRpkBs6XXJT44LAhh10rkFr1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

On Fri, Jan 10, 2025 at 11:27:53AM -0800, Nicolin Chen wrote:
> On Fri, Jan 10, 2025 at 01:48:42PM -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 07, 2025 at 09:10:09AM -0800, Nicolin Chen wrote:
> > 
> > > +static ssize_t iommufd_veventq_fops_read(struct iommufd_eventq *eventq,
> > > +					 char __user *buf, size_t count,
> > > +					 loff_t *ppos)
> > > +{
> > > +	size_t done = 0;
> > > +	int rc = 0;
> > > +
> > > +	if (*ppos)
> > > +		return -ESPIPE;
> > > +
> > > +	mutex_lock(&eventq->mutex);
> > > +	while (!list_empty(&eventq->deliver) && count > done) {
> > > +		struct iommufd_vevent *cur = list_first_entry(
> > > +			&eventq->deliver, struct iommufd_vevent, node);
> > > +
> > > +		if (cur->data_len > count - done)
> > > +			break;
> > > +
> > > +		if (copy_to_user(buf + done, cur->event_data, cur->data_len)) {
> > > +			rc = -EFAULT;
> > > +			break;
> > > +		}
> > 
> > Now that I look at this more closely, the fault path this is copied
> > from is not great.
> > 
> > This copy_to_user() can block while waiting on a page fault, possibily
> > for a long time. While blocked the mutex is held and we can't add more
> > entries to the list.
> >
> > That will cause the shared IRQ handler in the iommu driver to back up,
> > which would cause a global DOS.
> >
> > This probably wants to be organized to look more like
> > 
> > while (itm = eventq_get_next_item(eventq)) {
> >    if (..) {
> >        eventq_restore_failed_item(eventq);
> >        return -1;
> >    }
> > }
> > 
> > Where the next_item would just be a simple spinlock across the linked
> > list manipulation.
> 
> Would it be simpler by just limiting one node per read(), i.e.
> no "while (!list_empty)" and no block?
> 
> The report() adds one node at a time, and wakes up the poll()
> each time of adding a node. And user space could read one event
> at a time too?

That doesn't really help, the issue is it holds the lock over the
copy_to_user() which it is doing because it doesn't want pull the item off
the list and then try to handle the failure and put it back.

Jason


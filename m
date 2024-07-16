Return-Path: <linux-kselftest+bounces-13814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF549332AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 22:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415BF2831C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2733D1A254C;
	Tue, 16 Jul 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q11zwxu0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4051E1A0AE7;
	Tue, 16 Jul 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160670; cv=fail; b=Yv/lCmxVEh3/u5BDNpQu/jP+fMKDVsxEqldSrCrEpHQ638PLil9AUMDLib1LAUtkQ4uGzyMXN66QAKxoiymT8BKHfLyCnX5oHzBtEAGtpRRtJX7xnDwdkQkMRYMbvuaDHnsgDUpHOfXxIV7xvwyvWBe26TskchlGk/JR+9LzB64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160670; c=relaxed/simple;
	bh=U1bYchqiDPfUO/U6aCHYfLPKOqBtyDAGdEwpWZ2IbNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U71CYCfC8ZrZzWtBQYna9nqFdaS1vJ8XQZ3CyXjpFBr6OF7GS+RsT7vGk2uhSQU0xItCmGxE9aBVi1nLCx2GUunIa/Et1EFmf1doaP/dCJx9OE/CYc261VYK+AVMRRkYfK+OGCf1oWPvgsIxRXe+U2I+eONFr1X8NNgl9HznlZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q11zwxu0; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJnXQe7XpYrED4ckrF7ITT6tw4EFA8D9O1jknR8yqcevFUzjtltbDqfxFi0Dg9VpiQsjjPclVAIQrm4dHYuSEKT3EzS9YRROWLHukqpwwAGkp8B6DkYF7lo0XifCnOHw/hEPHE9+vPfEBWg6SLOd2HTrrNMmWLgDKGuvJI0K7C9QEdOTDBZqxs9D0LFu/g5WL2UqODZ3dXuHJ+QiMeCZcrnnLoPmNVG+rBiNEWCuANU1tEH0+5LJ9hEURsFDhMcbnGDWjXpPC8oKx352qvYaynMITpyzS5hx4lJdNY3y88xV5f60eljl0q7Zvkq1bIAmCDOgytmoMg2Cnx5YUOju+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW4nCUErxqf9EFOY5BhVz7urnYTKyG/WtrEjkwh83Io=;
 b=Z2JRW37Zn7VPLHEkDwTdta9P9teXFRoPZq3gwVO682qWCNLu1Nv/pylPignvgIuLcZeNlhlSz6n2wtXSrKxyIdd59X2m6dCjHbTdnWl9TOAT59r2JT7B66V9+3DnyGN3XUO6V+o/KSMy1wiYwxiTUPlVBvr/nq4j3vp01Wx/DSRUJQMcABTPqmdb0xJ7RtROpZHMUulTXKch2g95l67ljkFr8A08hLpIjvqCquPTPP+zFwGfVgqPCqbUK2oJjBzWJ6OgbnE2X+bElz737l7GQc7X8xC3/5eCZqsAfriuOYLsIEYseO1aacKp5vBIBTZzdSk0Cj9R9uyeIgcwsRGrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW4nCUErxqf9EFOY5BhVz7urnYTKyG/WtrEjkwh83Io=;
 b=Q11zwxu0hn9voYtc3tpnJcdWIyJjeWDhSM5a1Mg1Q2yyNpL6fnqmllv54Iy8/HfgE16mi5qY4ESe22btbtptNlCEoS4/eydNly94M9YuO3fjiPGc8YL7pZcLkabJVDnUQjrL96qMw63MSkmXI988RfVnKeUGSB7Ge+eRZonWKfqdacuKuYZDbDOHquGU2F71QHmGhahcEWD18bMckbuYOhNiujd/JkXeo/9S5Miy6RwO2eDQacQPShFzkXlQiZ/mcwQ8FTYpV6LKytoZiB3B4pvcNi3HaKchOUsp1/SxWtf0vvk/qK1c72L2qPAKhhcWeg51tKzegv+v6fZbs/Dj/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Tue, 16 Jul
 2024 20:11:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 20:11:04 +0000
Date: Tue, 16 Jul 2024 17:11:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, quic_eberman@quicinc.com,
	akpm@linux-foundation.org, david@redhat.com, kvm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, maz@kernel.org,
	pbonzini@redhat.com, shuah@kernel.org, tabba@google.com,
	willy@infradead.org, vannapurve@google.com, hch@infradead.org,
	rientjes@google.com, jhubbard@nvidia.com, qperret@google.com,
	smostafa@google.com, fvdl@google.com, hughd@google.com
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240716201103.GE1482543@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <20240712232937.2861788-1-ackerleytng@google.com>
 <ZpaZtPKrXolEduZH@google.com>
 <20240716160842.GD1482543@nvidia.com>
 <ZpavP3K_xAMiu4kE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpavP3K_xAMiu4kE@google.com>
X-ClientProxiedBy: BL1PR13CA0253.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d38fbe-60b4-4983-9f1c-08dca5d36baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLrHY2RnP9AxVmzwXjF6e/NP3cRB5GceXEMnNGiNeq3yzs2K+3/jMqN7+gfd?=
 =?us-ascii?Q?lx4x8psndBlq7vBhfpt9vJ3zlPE/f0R0A3I5aC++XFvliBi3BAZQ0mGrVi8u?=
 =?us-ascii?Q?7PsD9be3HypEasq/dIXhzfMQINnMvlTunfIAO6fQcVQ6A4kKWYsuXt04ov3S?=
 =?us-ascii?Q?DFpv3I6YmJJg9tVzn40KdE08Q4F2PevBc4nfTfYQJTqUgHHAU1osoGXBkvmd?=
 =?us-ascii?Q?4yWlVGz0MSRtKTv5Lod4/yc15D5/2k0moHESzmTu4VQtDnO2HIPbCNXOmOYt?=
 =?us-ascii?Q?706lwm+Jqmlptoh5aPORdDcj9Y76F634gpS9/6pYL2L+WX200k2Adm6gEjEH?=
 =?us-ascii?Q?Jqh5ov0LpKaCLr6vDs5g9YGDrZ8frEJG+60EVHM76hE61i1lpvxGr6zjkxDR?=
 =?us-ascii?Q?l5BRN8G+7MPeqI0UuCRY/FqlHzsG85Isa0zxFe375BKegJsb49c2VIBmLvX2?=
 =?us-ascii?Q?SDn0YIS5eKQzYOkW7OFiAWK5K88RVhfkoisoTnoEflqIbxB82hz8btSxK3fR?=
 =?us-ascii?Q?ZKWpDG+F1i3PedFYuI/39uzd8goeqLNoW3khQbRi2HseO95kAi95ervL5PtX?=
 =?us-ascii?Q?WEu9CIKnEpGczkxk+daccuwG21EEBXv3GMse3vKv/pnFT7oKbqE7PNv/CsVZ?=
 =?us-ascii?Q?58KJqdw3v7mDErYdxMUSYobZQ2ZsDZ9Jh0znA1hYGrJv2vN9ekzEGrkDI60J?=
 =?us-ascii?Q?G2uFN5Xs+i1XF9ckwrk11unYeVXI05WYxp8kP9hYo6p+WOW1mJZ+glY7ihAL?=
 =?us-ascii?Q?V8j8T0DBntk6CuObbTFBM8IPsOOq7rmPm/G/IIbdppCzWJdnxZxt1SfRyzRT?=
 =?us-ascii?Q?updckRJcdDADBGhkGO6I8oCXdo3zJtGX64NvHOov8N/qsbBRQLDicDtT1/Z3?=
 =?us-ascii?Q?fkmDI73Hag1+bLAsse2LE+joa8WmETxFcWr3kjVOen34KEwWzMQ+3qY1S6Sq?=
 =?us-ascii?Q?4er76ZMO/Ya8e2EC4xKDXYX1L3M3RrG7xGyHZO/iRp7My1S/HxVXo3/Wkq4k?=
 =?us-ascii?Q?AojN9ByNQ6oCJnFsDdW9RY0271DSiLg7xkfMjuQZ9xdX/FEiYq1lLRSl0dFr?=
 =?us-ascii?Q?UUPc/gtTRzoWP1lCVJrb2RREnAa2aNslRzA/deOJpm30aypR+CbKdEjOKjbe?=
 =?us-ascii?Q?LamaD32RFdtkDQq61+H3RcABO+hZGUF46iRbetHhxuOP5lln9tkXLnZGava+?=
 =?us-ascii?Q?BzPQl8GMpODM5RkdjoBrLHDlNIGVaN1WggikPvzRJdQrKbK3DCKQ0rPAjPMM?=
 =?us-ascii?Q?aFUtRZ8K6e/yTKKoSE1QZL055kdRg49sp9++WpzJC6Xp5rY2VsPYisLvQ+Zt?=
 =?us-ascii?Q?XFiYsM0r+XKJKdLJd5hlOFRMw5yR5ywol2k4tOwDQMhu2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7j0Eo6RKuWjS5t66Z4WncAEMvP1kAUEahmQ6GQ2EntLMXhcEsJTIP39YPxjB?=
 =?us-ascii?Q?2iotzQfdK7UA8sdp6P/JdQUqQ7nR2wt4amQX6S+xjs8wmkBQqgqUxhxquYzT?=
 =?us-ascii?Q?4aeMgLM9+9kyexUX+R9yBiT8LTLfCyZ/u9atXLuWIQxulKwGZULB0IGQS9Z2?=
 =?us-ascii?Q?AD/Vy4wyBSBySefystzZwQ6EK15jHgcVSDsF6ubQRY8nFCgjNV4Myt1mNu7k?=
 =?us-ascii?Q?WhMxnzDHWcN+BRTIPl1RZuBUdbYk3tVYMpza2BEQP2Tqk8KQ6h8vythp8fUB?=
 =?us-ascii?Q?cLvu1vduVDPgFhgw0+7btc7t2U9u4Wrr9PNspZM+Q1lj+LQja5/8hpzw85yC?=
 =?us-ascii?Q?fWzXoik2FKd0tp2Nn6zRLH8E/0UnNlJ9HJl+YNkooRc2IiLvwbMdrvzH5jp3?=
 =?us-ascii?Q?abgdBQaiSbQJiaOqeADPLAvOHZffQNv3B3hk2vdUlklaX6ilRjdb0J2gyCkn?=
 =?us-ascii?Q?J9f5aU026w4PNlkyFOc54KWc7VVJzILW97uw4QWdQEKiW1FAdPKd+rvyv2kl?=
 =?us-ascii?Q?UAjk3f2Ua1J/CPQG6LCxKuu4quQB/bVbhBPavYV6eMHgFozGMv9sFzLimcJO?=
 =?us-ascii?Q?0MXVcZXNvxCb4q3dU/Z4OWAvPCEYkgnCvhGWeMoGHmGTftqdNDAsnYIOFR8O?=
 =?us-ascii?Q?hAsdrMI94YKi4S0HfeH8eQojpuHvOM9SL/vY3f1w0P8+HLUNyoTfT+POKgTv?=
 =?us-ascii?Q?45aya+EuaJQvM7P4pyFOkvGxKpSVKG7u1hVdW7F+d/JhOHdSWtUcXRYlaPjp?=
 =?us-ascii?Q?1f2WoITnX3q1mBF+VxdcxpgqLAd6ZBJZwZJyuvAe3nY/Dq098e05OzICavFM?=
 =?us-ascii?Q?wVZXDJMw1w/mCMDpmfsup2LPCBc9GOybBtzSQc91BxOA9vAp/GGl3tChw2sZ?=
 =?us-ascii?Q?s7TreEWW1Zb6JUIHYpzs6HDGiZJwQ+GklNTEIPRybjk9GFz/5w83d91p+L7+?=
 =?us-ascii?Q?ZSVaUNc4eFfJ839fFytOiEPQMOVs1dwWtp63nxgCwfazURIXfBx2D1yQar1z?=
 =?us-ascii?Q?ZEPa/epG55djFLMcWYymFhorBdaG83uPSmifFvwPypxbWDbBgpM8eaWCCGvS?=
 =?us-ascii?Q?0cIWxa8Ka3jsgjx4HuIwygv1yvtxztWpb9nuCrz+/GpqPzTWeYFiqbt0UUmd?=
 =?us-ascii?Q?pz6xmXwaM3pPwxN3u5fgXlBzaAFxxmZNW+5Ui78M6ql92+WGjDHZ7pWFuDdF?=
 =?us-ascii?Q?0PbGzRaRoK9EXTrdSipJQ4zf5xNHdGKqHY+oGMnp+0om0myWBoRqaeTCJIiZ?=
 =?us-ascii?Q?iTw3zTKQdfvsCj2ANZArTkIWC2nUxDe6+DuPLIYmJUiWXdrEXssp7opPiK7p?=
 =?us-ascii?Q?DFnxKPJ9ZjFkrYDUlLFkRnLcdBjtdbNY0HNv+vaDowAl0/ymVreUBG7ES7vf?=
 =?us-ascii?Q?wkQX3fAaA+yPLRXstBhI5nQ5JoHRERwHsaBAOGWP3RjjN+M7IAI6p3OiAJJm?=
 =?us-ascii?Q?6yuLdn9N3bvIcq22cBCz53LpLxIvTa4kriWdtB1pP3nbQLg9yA5o/RajSO9p?=
 =?us-ascii?Q?s6OzaX3tVjoNC8/WCGEygrbZBWvMO0FZQmLgSpx8vJlyXh6glQYMKhG0don3?=
 =?us-ascii?Q?/138IALEupA8j1UTkq6gOADFmhE+bOmZvkAVKX/l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d38fbe-60b4-4983-9f1c-08dca5d36baf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 20:11:04.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt7UWUsvNp3RgCMnoJnIb6zJx8gBq9JB1+biay32aBvGGUmsKLetgej24sGLOyla
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411

On Tue, Jul 16, 2024 at 10:34:55AM -0700, Sean Christopherson wrote:
> On Tue, Jul 16, 2024, Jason Gunthorpe wrote:
> > On Tue, Jul 16, 2024 at 09:03:00AM -0700, Sean Christopherson wrote:
> > 
> > > > + To support huge pages, guest_memfd will take ownership of the hugepages, and
> > > >   provide interested parties (userspace, KVM, iommu) with pages to be used.
> > > >   + guest_memfd will track usage of (sub)pages, for both private and shared
> > > >     memory
> > > >   + Pages will be broken into smaller (probably 4K) chunks at creation time to
> > > >     simplify implementation (as opposed to splitting at runtime when private to
> > > >     shared conversion is requested by the guest)
> > > 
> > > FWIW, I doubt we'll ever release a version with mmap()+guest_memfd support that
> > > shatters pages at creation.  I can see it being an intermediate step, e.g. to
> > > prove correctness and provide a bisection point, but shattering hugepages at
> > > creation would effectively make hugepage support useless.
> > 
> > Why? If the private memory retains its contiguity seperately but the
> > struct pages are removed from the vmemmap, what is the downside?
> 
> Oooh, you're talking about shattering only the host userspace mappings.  Now I
> understand why there was a bit of a disconnect, I was thinking you (hand-wavy
> everyone) were saying that KVM would immediately shatter its own mappings too.

Right, I'm imagining that guestmemfd keep track of the physical ranges
in something else, like a maple tree, xarray or heck a SW radix page
table perhaps. It does not use struct pages. Then it has, say, a
bitmap indicating what 4k granuals are shared.

When kvm or the private world needs the physical addresses it reads
them out of that structure and it always sees perfectly physically
contiguous data regardless of any shared/private stuff.

It is not so much "broken at creation time", but more that guest memfd
does not use struct pages at all for private mappings and thus we can
setup the unused struct pages however we like, including removing them
from the vmemmap or preconfiguring them for order 0 granuals.

There is definitely some detailed datastructure work here to allow
guestmemfd to manage all of this efficiently and be effective for 4k
and 1G cases.

Jason


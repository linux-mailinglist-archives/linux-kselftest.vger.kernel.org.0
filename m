Return-Path: <linux-kselftest+bounces-6538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A788A86B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D023457FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAD70CA7;
	Mon, 25 Mar 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QBfAb9S/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357854675;
	Mon, 25 Mar 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374736; cv=fail; b=O1lP3Sgb9zyvkB2K18ReUuJrjuxnvy946va8KFcXd05RzKrmGctCgRQiYW2feDMMOw7TcK5Umv/B7Rt4H+9/cd6LJOZ931wF3VUEgukIXh0I+RktevP6Lc8Gxy2kCeeAO5n73Po8E35+tSO59y7HsmUtDEFVEDVcs+S0+FhjDxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374736; c=relaxed/simple;
	bh=vgBw/lvSPvhiZkOX73ShzmtPeo3pwn2GtgeyZllcgOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3FpcTZTnR8zA010orxleXHOcX1GQmGUfb+cmegotfrKBBUvdBNsOGVStdYIAfBdF5thJZJDi0CRQ71gMxD/v4rxXwbBzdvON4MFdx2vgV96yt2O6lro9hdxzxcFELtibPi9X3gb7kAFOT+8e4mwsjuym7+8BOnWL7rsvSwrbxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QBfAb9S/; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V63IcgneWP9NjwiBd2Fj4AdMJsQDXvyo4v+REI2cgWHgbJmVOC7t2Vi5nfSiYnOP5Xz9KdSuCnUR7Dd+o4DCltPxHtYgn/cYhHNbTzS5pmOaojCPjwcFpT8V8Tlr2Q50WlGcC7iVZ/W63AMOIyzvfHsMFyASh5Zv1jlHdVJZ2WnxAFk0v1zssh44Q5hzoadra49ireBRV8jG6UhQXLvk+FNG5pRD5KNvH4NFb1ckR76xW6lgMLWKgmhf/0vhROFkN6gC9XtSDXv+GSpV4N8bBxGH4fjuiw/gy/RQ6C0k1OG21TlUPq/GMJXufjsS0+qISvdLDPvKYZysZuY8pJy3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VInfZXlmEabrTX3WOJNt9EMrULZ7qnchyC/VuUPkElI=;
 b=RubdDLAZZH/q8UNj3Dr2kcz0l/WzOl85cQ/TFC/yUjabFgd0jBogko4J/3R3qasR2b8UrnD1qRoMQm6DnP9mvw6s9ibEmqK+EJXHuk3EEg7vjMwWufMOv/VDak6z5VcNgegsfp29G1ZhE/pOgMCX6WyXlf4bwQMk2CJNVvQ0fm6OwMwN6rXqkF16Sy6p0RFaw/YujuZdQUV0DJta3qsson53ANzOuVmnbySPeBYYEf3V3ot/Nn285VRKG/XCu+Nq+HFWRCuP9gwRgeIKNBRivI38ADjQ3NwCOvOBmnySWP/Ux3jFz1bEsnX7Y5n1rQkUeYAEInKyANIFR4UOW2j6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VInfZXlmEabrTX3WOJNt9EMrULZ7qnchyC/VuUPkElI=;
 b=QBfAb9S/GleBs2uljJBx9RKTlj9dpwWdFyJSrQcuG+ARHBxuhsqyEQMUuJCjbEzCT6sX4aPTmTJXe9sObWAvT+qJQxEO784z4Tn/J+GRQ+mC8tM1Z9y/dK/7I1lyoi9RHTTbaEDo65oyYO7o7erq1NDgxY+3ENqjoXOAXGzt4CdtmPrnhNEgulR8DVu0MN/kJ/hnMEdnZhGDm00eGCpZPUDZ8+6DVAVEexuL/yhFunjd6oHms/V0vpnXW3y/MiQL+Dv/7LJZUB68kGYoFsL739HcKW7ZS0axhPzajFYZygREitWROMne3nKd4AV+O7Syyyjma4hoTMmvbaeK36TywQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 13:52:09 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:52:08 +0000
Date: Mon, 25 Mar 2024 10:52:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, iommu@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after
 a failed assert()
Message-ID: <20240325135207.GC6245@nvidia.com>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3ae69d-5c08-4924-4449-08dc4cd2c372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FBeY9oB/9A84mNgW+IFv39AfJ2KAL2AxEgYGiYHGMgbJJPhfK4k77c7ykrnyj+lrxbs8WJ81d/uMLof0A8RRcYxLPfULHtetPoFZuATUjk7SNMnQuH9poAHDW4/xK8wy7uu6Y2mo/iAqUpFLE1Ho6eqz/jRAcOSdC3fU3SY5O//rHsVnE/um8WlOemmQLHoPYM7elaoIH/O4pp3e5FCcY3NC4u5DJKdySMLHEH5KBV+LAa5GbD4KzlRv7noxV9VrFoWxvKottrwTMBWEXY6Fql+iAWQdfNlJjcrZUNSJwDCRPArVLSqX4pP5+iuAwSbqLCAAPpXLg1oCrqUYqUxCTnTe5X4EXiKL04N2Yw+X8dTP0OeToV5GJQYKwBSEtAGvrldppuWmGwvrbcFqn0PalmIUU2R7vAAm5dxzlNl4fNlbr9cw3xRumiX5H3kIL8v5T4xbwN65e1jopl0FAp0TcSBLeHG/dDQAmyDar0WYwNyKZNNqzFJM7FIx2/EZD4qGeftmmqkScPZMXbd7LzaBBN3+aHpMhGewdCgLERFPo1kvShHgNoGGqbrjAeufWN0GpF91TKOQc127YnlucQVlEVIJjBkGCi2bkU5/XyytKNlhv+gPkH83kc7KZQynRu4uMQSemZIcbymRvr9IViGSKEV0zGuFmWhY2C0PDNXaed0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2V0U3BKdUovdC9qbFRUZFhqeXJFenYxYkxUb0U1NnRIcDArdUw2NUlkYlZa?=
 =?utf-8?B?MUtoTUZwWHBuSTY1S0NGbkhWRjFndklrdys1cG1OTkozN1NhYUdjSzRLU0xw?=
 =?utf-8?B?S1hSenp4b1JuaEVRVUdlNDhVWWUvdDJRYUZpU3lkclhYZitSZTVKSEZLV1JR?=
 =?utf-8?B?bWFDNFUrZ1dneForNW9qNElPSFhDRkpqU2xxV1JhaTFBTEdCSUpjWEIyRktB?=
 =?utf-8?B?M3JKbGNMd3VqTklqV3BKYTRXTWhkRDFhRjlpZG92U1pMcGEycjhhKzF2WDNZ?=
 =?utf-8?B?MnI1V0xhSStOVUgydlhKakFxV1FEelltQmVyWUQ0UDk0dlJvNTFaQmgxa01x?=
 =?utf-8?B?a21DNmk2YmJiRHhtSGZQT1VpcjQrdzl4Y2t1cjBoN0RYNEtBdFZjdkRPZ3hB?=
 =?utf-8?B?L3VZcFZFOUh3dDk1VWRtUUE4VXFtWWtvUVBNMFZwUW9vc1FnMnBhcHdDVGNO?=
 =?utf-8?B?RVZEWjdzTjdWV1hzR1h2MUgydHdHNE0wNDJnOUZpREJwYTQ5QnBkQXpjUFJB?=
 =?utf-8?B?czFXUXYzY1pZKzZzRmVWY3g2elY4SkxPR2VPZS9abS9tdVlDUTEyMDZBeTVI?=
 =?utf-8?B?TzdJRmVxVlVWb3VJRXl3ZFFoOHZqNHlTdExjOEZjbWRmaGo3cFd5aGNYZkN5?=
 =?utf-8?B?djBGeWFKUHFUd1RydThMNWU5eTVaMjZLRy93OC84Q0tWYUVvSFg4TW5iR2p4?=
 =?utf-8?B?ZlI3a0M0S3FvWlBvZmMrd2pOSjNuVFk1bTNpSWJnRS92OXFQVWN2amFMRmZi?=
 =?utf-8?B?cmdGNng2dkFkaStlZ2RYV2JkWm1QMkZLQVdrQlZ3M1Zjc0pMdUd6WXFTR0Ft?=
 =?utf-8?B?QW1EaWNpd2pjcFVWdUFIaEFjUE85c2xDZVBVV0NkRkdQN0Izb295dGU2S2xR?=
 =?utf-8?B?aWI4ZS9vYVpwNml4Y0laOTRFSm9ranA0dWFPbEtacG5YaU9vdmF3R3dIR2xl?=
 =?utf-8?B?R2ExK1FWZTNjdTFwaUZTeitsRUxWbUt3aUlrY2IyQktwWWZXM2FMYThwb0ZP?=
 =?utf-8?B?QW42TVA0c05UdFo5VUNYR05ZSWYxQ1BScDBPSXF5SVdFQkpyNWVHbnpzd29w?=
 =?utf-8?B?U3BMdzArQlVtTHkyNnBSc0J0R2QraHlsRS9nNXNZVnNXdVNUQjFFOFlJZWpX?=
 =?utf-8?B?VXdXVnN3S3F2OFhSbWRWK0VvRVcwS0JuWVQ5cks4Y3RDVExWOWd3aXB4RG1W?=
 =?utf-8?B?L2VnRW1Gb01GZGVWZlFyUy9Bc2s0WUZNd1cvMklWM2I0bk1CWVQ3VWxqdnFW?=
 =?utf-8?B?U1JBd09LQ3g5ek1jWldGWVRCNS9Xc21wWS9RTE1vVVBzSkpEeldZY25TeGg2?=
 =?utf-8?B?a3ExT240ck5BOUNjbVE4ZWd1VXFpZ002em9ZWjFDMjlOVkd4K1NWbDg1Nzcx?=
 =?utf-8?B?V3BpWVZmSjFhelJ1QTU5ZCtxVVhaRmEwN3Fuc2lmWkR4aDBVZVdHSlowZ2JB?=
 =?utf-8?B?T3doR0dqazJSbGJFY0d3ZkdNc0RkVjUyMHdGclNYbWY4WkFtYmd1czJJY1lo?=
 =?utf-8?B?ZmliNi9reEFTVVhwWEhqLzNDUWRWTXljbjhmdFpCT25PVVI3cTJnZisxZTR2?=
 =?utf-8?B?a3VoVjdFRjRsbVBJcmIvbVZPUGswSElzeVBkVk5lWDZLOUVvUHhUc1hBQlhp?=
 =?utf-8?B?THRXREgzclZWSEpGTFdURlkwRlNCeTdRaGJkVFN6WnYrK3RnbDM2UFA1bFhZ?=
 =?utf-8?B?TmRPRTMvaHhjSy9rNjNZaVFDdTVwMll4WGNBV1hFZlZQRlJHeGJPNFhSVjVD?=
 =?utf-8?B?MTRRbUFzNDZrSHVDa1VwWlVDOG5TUEYyRWUzWGVyU0dROVlxQzFQTDdZVk1E?=
 =?utf-8?B?SEhKUVVQVFlSVHJTYzAvZGxuUnNxSVdPajd2TUcvYjR6WXFLT0p4emVFV0gz?=
 =?utf-8?B?VE9BYXptK0dPMXNBWERVbi9jYzVSaHd1TWdVUDhjSHp5RC8rL2dNSVo2T1kr?=
 =?utf-8?B?TTFweUdPQTNxZW9nelVEakxtcVNPWWFDVVZFbmx3amVjdm4zb2JjNmFZUXNT?=
 =?utf-8?B?NXJ4VURtejg3TU5HZDJ3cExmQVdrWFlIcElUb3hlVW0wN1MrNnhPb0Ztc1Az?=
 =?utf-8?B?emlQMmFlSDdLOENxMk5oeXB5aklvSzRnMk40dHJEZlRvL3JRSHBNM1ExbzN2?=
 =?utf-8?Q?8tRzs+T6o5jmySRkmDjuhwdXs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3ae69d-5c08-4924-4449-08dc4cd2c372
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:52:08.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCxfFnT5C8rZhrZOVTnyWipPbsFLcIvA6gPTCZinJ3pIgTyb4s6ynjT+3KsbP27J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
> > However, I am not smart enough to figure out why ...
> > 
> > Apparently, from the source, mmap() fails to allocate pages on the desired address:
> > 
> >   1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
> >   1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
> > PROT_WRITE,
> >   1748                    mmap_flags, -1, 0);
> > → 1749         assert(vrc == self->buffer);
> >   1750
> > 
> > But I am not that deep into the source to figure our what was intended and what
> > went
> > wrong :-/
> 
> I can SKIP() the test rather assert() in here if it helps. Though there are
> other tests that fail if no hugetlb pages are reserved.
> 
> But I am not sure if this is problem here as the initial bug email had an
> enterily different set of failures? Maybe all you need is an assert() and it
> gets into this state?

I feel like there is something wrong with the kselftest framework,
there should be some way to fail the setup/teardown operations without
triggering an infinite loop :(

Jason


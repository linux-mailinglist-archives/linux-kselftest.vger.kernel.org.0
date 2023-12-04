Return-Path: <linux-kselftest+bounces-1046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14AB80376B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 15:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431DFB2093F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0707F25766;
	Mon,  4 Dec 2023 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q67SNI6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE47B3;
	Mon,  4 Dec 2023 06:48:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOAaG5QYo5SfkuHd+dfrpCPmqSlaqVljNFv2MV6SU69VC1VKSEsRT+AcoGvMJfqmaYnXMYlwbdOR/Nu6EKekGxDcM3beBnY6hg4PmNKSyGvfRUn4lrZExtmSFXZBbAik1eIEPy4IGZqCQY99jd4kidBNPGndT/wgsc+LaDk23hknDz1duAA/dRTOZUqjzW1a0LK37RM4RlJ+jo3ZK/7/0FR8xra8edAzEQxiDzuqXCPoG3czgqsN3SsnD6/fJJHF1GfNxvsgOASWRNDNGj0DnKvR5YB1ulm6qJlERYERWxz4RnvOAhCYbQtyzHtTHAeU9AE68Vb4z0euDOdKINXDzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMh+YR0Jc3JH783jjPtBAxK13g/llVvswqyvp3M7/uA=;
 b=eHTQ8Kosp4Z9MwNmuvbbPZmjS7fusO04RCXDC0Zz09XIYvjLGXG0gTaO0XxFG1BpsliAxJvA0LSFh+PN5EINvuimty3az73O0/Om3lqbBsZAzwOFhLr1iWtOIuSQfOjWjD0C9+0yat7XlHbtzXJ3uf9rlCKfc+VVIM21SuZzu9kLOvbIJ3sQn0VgTqhiBtqnx7P2J8dGlD1RwLNnQvWp018rkxzcO2+OJ7aXEg2CvRsNft9vh7qYlO7Zz1X+k0mTFW907nRnQopr1npuYtPJC/SGJpPZlNR0iJLnw6CY0CmG7WsilL+8dBPwDCtBer/nUsgPh4uldpHKpvVE067ZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMh+YR0Jc3JH783jjPtBAxK13g/llVvswqyvp3M7/uA=;
 b=Q67SNI6y3Yo4KlCDElTKZiLZqzemmEPPonMtNugaIbNkeTsyHJDZ8c3c1GQYkT/bsYtUTgAjDRE6A1CZ1/XdINWYDZ+yZ7GEvgXcBEHVhLJ0dDwhPZP4wxj2L/gy4zYJ6XD2svvDj+CDzVNyE92vJEHG4TpJkZPrmO8KvUmCIEnCVAZBSGHd/p4Bj4U8M1NwuKGW7/HKC5jk5rzFkL9BsA2z+nDs3pe90R3HKGhjsbByvFDiKyw293Bzz0GMmTBPgMzdjzrgbCoGZ5yuNLDMGp1tBPuhRVuseBEjLkvOmTFnroW+l2wuTubjTm/QgrCId3LNMBXanNrFj1xG/IgotA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 14:48:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 14:48:51 +0000
Date: Mon, 4 Dec 2023 10:48:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231204144850.GC1493156@nvidia.com>
References: <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
 <20231201125538.GK1389974@nvidia.com>
 <ZWo6z59tnmS8F2V7@Asurada-Nvidia>
 <20231201204340.GA1493156@nvidia.com>
 <ZWpaTD9dVge+suyv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWpaTD9dVge+suyv@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:208:51::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b58f5af-d922-4d54-00ff-08dbf4d82123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9W0wJpQGFptsDa6WFUspZWQwKx6Wih7RU9FRIgh1P3wSL2bFCX/6W8SbNZWAfENZl10jqL+RwJnGv4hz4nvhHY6zDIGb4jf01KWHytc9DXJLJEsyx7TJm0PvdKMGc4dueqCUE2rSre+9takKATJ6o14IbvXf2fWhGaG3v6YMZllr7FhKAOyULbsomChzsjGsvwZy0+CfRWpWeuLmdkkwo5ozReCFTM3RHrHj163/H1L7binwNZ8EYDdaVxd0rqfYxRdg9Nhk7xIwTxXmudsEpZFjGu/MPMw2Y2wJjkFPCptQNy/eBuPzIBIFj1gJOyPuTiH89A+yeD+XR7GgFt6AyGB2B171OS0ataMTuV/bOB0aAwulsovHOqJywVPdgoW8fYsM2Bo18dqHdR7yKBAdugGd2At8FD0a1ifpdg2wLd0DYBMavMxLGGeFGe5oRZ1qJkkHyPRTqKTOhkfOdPzc9dwlskDC6uV3NPsKMnKH5PaqA9R1F8UEvlQxNZvDSZritc8+GnftrRgpHCps8DyPf4X8oIWVgyrtjnCzu2R4x0xp6xJIlDrURPjLNJhdoW3Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(1076003)(2616005)(6862004)(4326008)(8676002)(8936002)(6512007)(6506007)(83380400001)(26005)(6486002)(478600001)(66899024)(66476007)(66946007)(66556008)(54906003)(316002)(6636002)(37006003)(33656002)(2906002)(36756003)(41300700001)(38100700002)(86362001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gFilKasyDk9XSCS9hNh/9M8U+aHkewivnDXs8zRrU12/lNa5vlz2IyxgvN0X?=
 =?us-ascii?Q?wYfpLkzUtt2B+HNnAIkOgwctcR93jUIeb+fFVsQyQSH8zfjK2R4QsYXjUAnL?=
 =?us-ascii?Q?5nCGRD/nAn04q3tz+ee6v29BniWTfWI09LVn3/ZAxx6GNHsimYPfBg8FjVaT?=
 =?us-ascii?Q?5h/m6MN3Hs793Dgo36V/+2EHIjAs6Q6wp+fIXoYtggMUxxTm9Ogg0I49MY9x?=
 =?us-ascii?Q?OALTWx1J5nYpBcD9YY3CEoqKdPI2udYYMEna/GgpVWNnixzoJ7LCdK2Wqnha?=
 =?us-ascii?Q?CtzE/XYqXUh76OEGX9SQrP2nRnefq0/7H0JSRIMHL8FKxusm3mPE+1uZM4TT?=
 =?us-ascii?Q?YaGsbDdkt4ynFt/4i6d1iVEn91Kc4ur1rrm9+PfL3Am41KQ6E+i6d63jN3Mb?=
 =?us-ascii?Q?mK+9MX7d/AuBqgoqB5suO2EkzQW0r3Gw0nrZxj72DN0fUN9cPbH2RM4oEXt/?=
 =?us-ascii?Q?PjB6Rk6WtfewSa41EHIFCo0letvbFoQGR3No0AWyi/+xADKXMQNTtVXb14Qd?=
 =?us-ascii?Q?iQNpWzTVkmsTLlfw9BFpFXM/hlOuBnnWAqQeS7lSlvxmsQ86qByBisBWWGrB?=
 =?us-ascii?Q?I7fmiJNj2Hh0QN31cPV16F4m976NnqM+Uv/A0PFhIy6RGZLuLA1fdabEvqZe?=
 =?us-ascii?Q?Kqn9/4/UEWg8gH3s436QtRBu5+aHxriigpklDjd5g91BIod1GvXnMp16CEMM?=
 =?us-ascii?Q?NL9K9DIxcAINcC9XukLdXgTUDhtFfn2PjW4jS2jJlygfK04EcXDHy7lG5kRu?=
 =?us-ascii?Q?+Yc0AEz54UBmGXHW+Ekl9VZZGHlSVHmUz/LOlfuhGqBdgYPtzRw3Zr6w+sjm?=
 =?us-ascii?Q?6hDf4gXSFdHVMGOZVnBb3sSKIedXQaCmIRUA3N9eGW4vhiqRqn/i2V8NrIse?=
 =?us-ascii?Q?7L/JeZSysprGRiEEzYlh+/CHJwAFoOQetzS6+RjYoCl1MsFaRGiTc+FBDQTR?=
 =?us-ascii?Q?6kKEvovowQGrPzwc3APh9pK2Pak1K/9jNlkc0VUIrtRok+WONWpqwxapRyF7?=
 =?us-ascii?Q?gZmif0nYBZX3BUbOfT7n61+63iFpdw07MjFd2wtBpQutCA5FZT+sdtmfQBkM?=
 =?us-ascii?Q?4WhlEOljNhK8j1hLTubtilnG5IhE7aKi4/heNHelWCP60Vvvgs/7QC+WhHKW?=
 =?us-ascii?Q?5Q1qgr6kY1BzYeoxyaOQuMg6CjdPh4D8GRkmWZcC1ogSWuRnJ9YAiUcg9BDr?=
 =?us-ascii?Q?Pzx3/m8zzqZs5X2GLCoK+aEonm1KSNjhq9EuerAXWu5cLaXubAD5X4lyZQYk?=
 =?us-ascii?Q?k3VuPp/hjrT547qLloQfWOR497iq3aLgbBswr5Q7MgHvm3Da62Lp0fMatcEs?=
 =?us-ascii?Q?qeyeFVv0gQg7nA0sDWCOIYdpXM8muajeAzZFqfrSBAIlDAk5Mq2T2WlLelf6?=
 =?us-ascii?Q?GJUMozrSWe3sNyn52tZWl4QF1LAk0HBljOC43vNAEBE/quGZ3YFq5p/OX8ct?=
 =?us-ascii?Q?xz9l2ZHNcj3uabYGf7B807F1pwdl+l0iA9IDQRLkOhCXfqz9ClLfHOSTu6OI?=
 =?us-ascii?Q?d7BSv81zxrNR0P1+EJP+nSFV/SEY+6p6dmdNDAz3vd+UjZoaYDwQVLloOEWx?=
 =?us-ascii?Q?uuNYzdgU10wBHWQ5kHjbBGBSLnC9XqyCa1q3AQlk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b58f5af-d922-4d54-00ff-08dbf4d82123
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 14:48:51.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ9R9k9YEolhksVFhps0Dyy8YfKmvbzjt5Nrx+TUefBtig2+Hc1DZGimYNqBAuzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

On Fri, Dec 01, 2023 at 02:12:28PM -0800, Nicolin Chen wrote:
> > Why is timeout linked to these two? Or rather, it doesn't have to be
> > linked like that. Any gerror is effectively synchronous because it
> > halts the queue and allows SW time to inspect which command failed and
> > record the gerror flags. So each and every command can get an error
> > indication.
> > 
> > Restarting the queue is done by putting sync in there to effectively
> > nop the failed command and we hope for the best and let it rip.
> 
> I see that SMMU driver only restarts the queue when dealing with
> CERROR_ILL. So only CERROR_ABT or CERROR_ATC_INV would result in
> -ETIMEOUT.

I'm not sure that is the best thing to do. ABT is basically the
machine caught fire, so sure there is no recovery for that.

But ATC_INV could be recovered and should ideally be canceled then
forwarded to the VM.
 
> > > As you remarked that we can't block the global CMDQ, so we have
> > > to let a real CERROR_ILL go. Yet, we can make sure commands to
> > > be fully sanitized before being issued, as we should immediately
> > > reject faulty commands anyway, for errors such as unsupported op
> > > codes, unzero-ed reserved fields, and unlinked vSIDs. This can
> > > at least largely reduce the probability of a real CERROR_ILL.
> > 
> > I'm more a little more concerend with ATC_INV as a malfunctioning
> > device can trigger this..
> 
> How about making sure that the invalidate handler always issues
> one CMD_ATC_INV at a time, so each arm_smmu_cmdq_issue_cmdlist()
> call has a chance to timeout? Then, we can simply know which one
> in the user array fails.

That sounds slow

> > > So, combining these two, we can still have a basic synchronous
> > > way by returning an errno to the invalidate ioctl? I see Kevin
> > > replied something similar too.
> > 
> > It isn't enough information, you don't know which gerror bits to set
> > and you don't know what cons index to stick to indicate the error
> > triggering command with just a simple errno.
> >
> > It does need to return a bunch of data to get it all right.
> 
> The array structure returns req_num to indicate the index. This
> works, even if the command consumption stops in the middle:
>  * @req_num: Input the number of cache invalidation requests in the array.
>  *           Output the number of requests successfully handled by kernel.
> 
> So we only need an error code of CERROR_ABT/ILL/ATC_INV.

Yes

> Or am I missing some point here?

It sounds Ok, we just have to understand what userspace should be
doing and how much of this the kernel should implement.

It seems to me that the error code should return the gerror and the
req_num should indicate the halted cons. The vmm should relay both
into the virtual registers.

Jason


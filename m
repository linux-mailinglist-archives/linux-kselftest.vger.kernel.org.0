Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9FF7356FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFSMhN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSMhM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:37:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2C91;
        Mon, 19 Jun 2023 05:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbxfVlFhu3vvsBVR5gKDxHZ32aGBzamQ/j0EYiqb8ez6dz273KU3wI4Cwm2jDL7eLnlDztQgVTRlICS5SGaxH2dZe9lRX618E8U2M5DZg/R1VHD4J5gYuG+Q6R61MR6/WYgWLAZojJBco70SDfv3ohI9OeLYPWx/pQTr3mr9iQUHHIGhbmvAcgiG7e6NyivBg+8PFk6fWBPzzF70/pGKIOW2YTLF+AEKTdOKRt8fmGSknTB/YK7eX7RFNRuWZOqwWzd9KBFF9ykpOESBYYLB1zt4nkPUQU+6VWR5g8doF7n1IQSFiLur+vhwwBEiJXG7EKjBqPDX4N7uaflDL+wcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAuyof0ipmqTj+sPabNAsJHWIfBDzCc0XRhKPt1RgOM=;
 b=c1psmZx2VijCrxjXdyJcc9mKB2uoqCCcBTABVoDgbi1Tea7RQDUwrPAsx3Ek+pl3cZISQsB1mfgCh5bIIRll5alkzPzyIpKyKbhSM8yoygN63YCeNiwuWUV30DHAt80eiCdkm4/R41mBhj5zSreXO1kYJoy33u1ATHGJAsKIV0424e5eO5f0qPv8HlDFqCuoLjVIQxJyhZ+FaRn9KFF9nlaZ82P4RsC/+oGJgr0xOqhI7/5LY17jyog3BJZ3SHtSinWTaOmFLHmdy0Z3kD/j2czhyv2LxoVE+NBtWfcJ64iC2R63e2TAHL+AuvpZD04Jg+i/RUHbvpkSy7w9ObxTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAuyof0ipmqTj+sPabNAsJHWIfBDzCc0XRhKPt1RgOM=;
 b=Nfw74zDuE50dvYyz9CIedhBgoKNNxZwOHeyWP5DwUidxPrDFrCT0BxLAhO9H9U5zbWz0RK6ViKgM9sbK/+1t7c+CLJUuK/w8NrwdNrcD3Bmzkx8g4x/5WOCONjVnaUdAOykg3Ab5lgA5gelGORpNBgnkKi2UeMjCySykMoEzRF08hvToFTc/WtnntWJafbl0h+YlJQW+e3Pym6rPk9va1S5FqSGExCMWHf/g5b8YctStx+h8KSHuGcg66hoERu4nRyYuP6YTtTqhjiQcZJwErGjpNGY226gLykJDUHquR2/zG3YTMZCuZrq+R6+tz7Cri75of+KIuxZdWjAgpBZ7JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.32; Mon, 19 Jun
 2023 12:37:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 12:37:07 +0000
Date:   Mon, 19 Jun 2023 09:37:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJBL8QLLBiwRsUSI@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:610:60::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d43756f-656e-471f-d57a-08db70c1e4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGdPEQDWGcpcksziHoncG722igoPnehJI4+c13Um+EqvUrPislTwV0ymlTZnIbMLhw5WNx2DpbXZdHij8H8A42Fxwquz/unAvg4WEXClMP0jiCbtSV4i667L3axlBqK3/UmplqI/XVQoFXDBv5GIwmpKSGT2il/dmxXrfN8HNFsBrOxD1o/f3EMSbU+SIsgPz+RC9EIaxnqKEhJO82t1NhiYkLd0GqBSSHXYVTNQS/IVxqHF+COLeSYhpRJ9naZYrkX7NR7w+YOXjCYetFIyCA3atpXUVHgqv5MHMhXa0blhjKKbji6JD9gnB9A5oDU1QfNGJJoDgaV6w10hkjxZc3TYPA487v2mgCS6a9PizpQtD7UYU13VHIEp879ELvIwz8tD1fTfjPB0G+KMSCXnIZ1O+/BGoQ0CDMWuy1cPf7osD7HzORwjtW8nRaSAtvGsLLmNMFrqqplsXcS8jZBoE6TagcUu4E6OZYPG76ZQJAM1hdyXZeHMS3xoqxdiqbCso1iJNOXvksICDf5+SkUonBwRYucjbZNAWI9FINMOnC4hbz9u2ls7/ZamEYvxLkwq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(66946007)(66556008)(66476007)(6916009)(316002)(4326008)(186003)(2616005)(38100700002)(86362001)(26005)(6506007)(83380400001)(6512007)(478600001)(6486002)(36756003)(54906003)(2906002)(5660300002)(8936002)(8676002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQVVaojLw80TopkgGkBHyAH7XPaIaTTED+A6OgjTz/TYgtQxIFDiTdfirfVv?=
 =?us-ascii?Q?N/gF/LjM2CSxi1F7BNe/cKwpehVwU6ZgxZ9VX5iVzSGLl0NN0YbzFPKyyI8u?=
 =?us-ascii?Q?d/6M1sGy6UJtMvZnYE3VykYqgSFd/dZWiB+rym1uLuHJU+rGrYLQIXZPXAyj?=
 =?us-ascii?Q?Ypp5Jn7yqLUhJijepPU98CUCuyWVvkthh9fzmEE7Xsh838Uj9u8TqT3L67D8?=
 =?us-ascii?Q?rVJkydq2ucUSovanf8OAoog1JlS+9EWtYTiCPiWeR8X66gCp3WqDad0cxPgD?=
 =?us-ascii?Q?7H6P/lMNSK5Rgui9s0tc2jTQexPrLy0H3AMNPoN2hlWP89bnEEt6crKZvFtW?=
 =?us-ascii?Q?vuugwdfPLg1iONth7bei0UeICIXTgszuz7exEka1KuhQb4TIMgd8o+JhYf7r?=
 =?us-ascii?Q?HqIxYmJJyrKGJnmySdk0SsmhnilwH0jjOAs3f2kLBYpSBTrCf58/ec7Sq7Tl?=
 =?us-ascii?Q?6iIv9N5ruzz+dN8evUD9jkRu5kqTZVhVNIAt4c3adEZEASuMthBDv2bD6FPd?=
 =?us-ascii?Q?wiFQjEJIJiT9fYT0Us4qGmsFTTq4kmUOE/MVgw2WgpVLO/6DIgqdK9qoxNNu?=
 =?us-ascii?Q?s37tOSz8s6126ngjnizEcNTGNP3dERr1rhOdOUrIEkFRCjU+u7EDlo3fkpGF?=
 =?us-ascii?Q?oh1eE4+HAMbHHKFDh5y7xLBVvIkjisu4DaRPJcEiLBcp1lDDfow5Klm9k5Ru?=
 =?us-ascii?Q?aHIQQc84degoEVcxUVoDmh/5u338S4C7EuHI9V05boiys+bsBoxHtpblx/FU?=
 =?us-ascii?Q?03Xd8bwGxjxpL5ptSn2SbyNJ+lSIoRdOMO98St5F9ThJeiDpBjgOkaYhChGa?=
 =?us-ascii?Q?avd/SZhPgtbibWBcBb055UewR3vT5UTCXted6Ob37TqZpMJ2SqcJuRhFTpWg?=
 =?us-ascii?Q?T4hAs6Y3Us01CoGCQaK5ezMq1I2y5VGmCJwwVGRJXsfA+Hyg6ZEmC8F5nM5f?=
 =?us-ascii?Q?1+NuWcP3CPMZgGn5EIRWol1UhFUIrzBy4bff0GBHGHjUX5nhee4YVAce2Jly?=
 =?us-ascii?Q?FxWdFN6EtJPlSYv8+2l+aKYtfT0cYxSTB4UpGea8dWEmaM7jehUQ78yZxWGV?=
 =?us-ascii?Q?BtZOVwvQLVZLRl9eJu1zjDFMHEKHebW3FSJjW0XoM8kaMATAT75qfUqeX7KN?=
 =?us-ascii?Q?5UqPNeSED/CUFwOOPunEumNXqlktEGNbupkBg3FAoZJd7Q+y0ae73W8xJjdt?=
 =?us-ascii?Q?WwYydYWbR5ebge8fHL3MJeE5WAdO6iRY1hTxkpJ3Mz7IOdJX9v+xDwwf6JlM?=
 =?us-ascii?Q?E+lgGQL9tRhjEky4pFvDTwWVCSZqIalrDcnrGQBvnmiPzq2qbov2vf0iL+5U?=
 =?us-ascii?Q?aCHzAB3I/UMC6vIO2g5++JCp7jX/C4Lm2d8eyG17rhaVVPnUUn8/p45EF+0l?=
 =?us-ascii?Q?6prHze0rhZLJsy0di22m7CGlG8v0DlJWDJ9bD+aUwuXSjYs4Edb7Mrzg18LQ?=
 =?us-ascii?Q?sgxglF9tXavNYMQZg/wNLzupt+lQvA8OOe4HQune5fLjuZyTxbQHCPySgb/2?=
 =?us-ascii?Q?rd7m1XTn5psghhrDI9JmDPPH7Jkxn+paautJ0gK5qMB+v3jih9KuOc7rp3FA?=
 =?us-ascii?Q?AmXgf7afxT9F/adCOrk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d43756f-656e-471f-d57a-08db70c1e4b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:37:07.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoB2dtMKg8jljQYMvE7ro/qmlPatHE7ybzT1rhJ01XQiCJ+ZLtNr97VjoDSEz4cS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 16, 2023 at 02:43:13AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, June 6, 2023 10:18 PM
> > 
> > > > > It's not necessarily to add reserved regions to the IOAS of the parent
> > > > > hwpt since the device doesn't access that address space after it's
> > > > > attached to stage-1. The parent is used only for address translation
> > > > > in the iommu side.
> > > >
> > > > But if we don't put them in the IOAS of the parent there is no way for
> > > > userspace to learn what they are to forward to the VM ?
> > >
> > > emmm I wonder whether that is the right interface to report
> > > per-device reserved regions.
> > 
> > The iommu driver needs to report different reserved regions for the S1
> > and S2 iommu_domains, 
> 
> I can see the difference between RID and RID+PASID, but not sure whether
> it's a actual requirement regarding to attached domain.

No, it isn't RID or RID+PASID here

The S2 has a different set of reserved regsions than the S1 because
the S2's IOVA does not appear on the bus.

So the S2's reserved regions are entirely an artifact of how the IOMMU
HW itself works when nesting.

We can probably get by with some documented slightly messy rules that
the reserved_regions only applies to directly RID attached domains. S2
and PASID attachments always have no reserved spaces.

> When talking about RID-based nesting alone, ARM needs to add reserved
> regions to the parent IOAS as identity is a valid S1 mode in nesting.

No, definately not. The S2 has no reserved regions because it is an
internal IOVA, and we should not abuse that.

Reflecting the requirements for an identity map is something all iommu
HW needs to handle, we should figure out how to do that properly.

> But for Intel RID nesting excludes identity (which becomes a direct
> attach to S2) so the reserved regions apply to S1 instead of the parent IOAS.

IIRC all the HW models will assign their S2's as a RID attached "S1"
during boot time to emulate "no translation"?

They all need to learn what the allowed identiy mapping is so that the
VMM can construct a compatible guest address space, independently of
any IOAS restrictions.

Jason

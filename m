Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6700706874
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjEQMoE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjEQMoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 08:44:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9C269F;
        Wed, 17 May 2023 05:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7Xac/R2GJdOSQEreqQCAzqlEF9VrAOOrwBqbiroBvapNVg5UleBetvgcMOT/B2v1LzEWk2EMeLbpCdUniuOxF5xuMMH1o/PH57nYsImRqIAh8Tdj1QglS9BxkJ7zzUJuqJXYblXI615MzcGcEMzJBAVsVDuoSun/1wux8OWKVGUqWbtqpOlGEJBBR7n6Et6GBuZ0DeLMVZLlzu3PFuuvmpMGtOZvLk9viQ/wD6pYsYnlB83tv/wXWLnemRNHfTjClCf9ZVE3Y+fxisWpoMa7Gk+jI8qpwv0QNh/t4gnnP5QuocZOMpuAy33zxRZ1l52W3Io8VjT1zGZnKWnMTq4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbuIK4v6IqhN3MaHN+TfOrqMseb+SepC+AhMyijCNJ4=;
 b=HXlLdpUbj3q/V7fCbq2C9dNfsf5XqF7Oo1U89PIge6bGngccvgvLlax5WnmrriqWUmavUszmtm5DC/kI6qMBgGV4aIAMBW5Znkh7D5H8UJUxByeFjHMlGq8J+dDwLEZk3AZl/IdNaaI31aIGsbs8ApmeTHmQWjFSrcOfu4a4Yll0VMsf1UroUKlKJiFjej+RwpJbv29NEezJcs6Pydrvo1O0kST+2vJJ0gD8bofG0HonKXU9WuWtzCXINLAXrlgzvmrLpfObER59rxG2DyaFF2JX8Qryny1E490HD42qZUWCxZDZs514nK70r4Aw1K7O7uNPDxOvEAhpAOgPuShQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbuIK4v6IqhN3MaHN+TfOrqMseb+SepC+AhMyijCNJ4=;
 b=P+jratqHfbBiNdbW5J5Q7e9NoICGNyL3aP+BfUBVzjkhPyIxmvzKyEYWZXS4dK4TPmx153mRTqzmdqcMJHGjBfnwhjZ0ePKfd0zBgNtb8TSsYiOgvApndmBgO1Ln+NTU8+8I3NmQZKZHNKALBevjOzikg5pBeWgZX1nGmuNkeutSv8ODqXBiZ3+4iEsNDvMe44Xb5HCWVXwzlZFgAX4hZitEUVvKd8p22dBZPnyDY2Kqm3BwsAmEgUqq6cT/fBYVsc3xbsmRqV1JAKF8YofEO6L/Vs2BAeyuf0VDlwY8tApNoSbt44Qs03E7CShquvyy+hNoxGNWXXoeH7E4FUll9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 12:43:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 12:43:54 +0000
Date:   Wed, 17 May 2023 09:43:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZGTMCSJKvgpyYxG/@nvidia.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
 <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
 <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DE1BC30E90B1032C0E468C7E9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:208:2d::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf0373b-4a54-4213-490b-08db56d45ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/CGflMBv+3sKuKKuSdvTo6Ew+DGZ7eMqlA9EK8puIiuRuHS/QG6vHIFCmWrCtjW99OdG58V3bKJB4K5rxmLWnxTdM+vF8GRJ8br/bQ0hKxatKKxaDpLCDbU0t9e0Kfa84rq6g5/Y3ldTzy03PQiC8iwparvgLGY3LNax8WqAlMKdMxHkkKuug0t/0CfKSgxeS9pklk1tLZDccJi3uNnEY8D/W6ghaHWTnUu+e+8Cu10miHIbXZf/AszmpGLIHvoNFytlZANNipqkCXncEMACR/d8JJqkQ3xsqtHAj5x4rDuvHnEWiR2nCgYzydP9l/6iM/y86to6Y4EEIDSw7WRQMUfV6+lB9nExia7OKLERfbrQBq7RgHpJoQXf5k13QIoDHOK7gpB18soC4pwGSeO9V6lZM34Yv2GrSzDNblaQxhlr3X7KwWkyBmswF8QovNZxlkYIQ9S9L1kbMOLzWFWdPFcz0huva23cERh04ibZ8yotaeGkBhuz5msXg9ZJpZ1scIFCEVdbmCKeKrkJO869rXlE6/mgM30/lonmYg0j7M4JOelFaJsA5lASEwurbID
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(478600001)(54906003)(86362001)(8676002)(5660300002)(8936002)(36756003)(2906002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(41300700001)(38100700002)(186003)(2616005)(26005)(53546011)(83380400001)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePT9g4lJGnLOowBeNAq4AVzT+X72tWgzynTc7XlbTUiPuJej1fT44fNB17uF?=
 =?us-ascii?Q?gtVxjVM1vV/zYHLHlIdTXkVfJnk3t+obtvgQ2lOCtzXIT9LBVHn7k6Kd+BEt?=
 =?us-ascii?Q?dB4c6RYlLdB50BCDbyV4aTWAdwXimRROnFJ17fO51z6Angkh5Z43vMNPQerS?=
 =?us-ascii?Q?6CwsTzZp9G8s8Tw/3LLZSOSXpBrjrhKhZIz/WyNdI3FgDxXgBLp3DBZ2gK2x?=
 =?us-ascii?Q?4rxOFX9QGx6YCy81CQcrHhlN/rHxw5RfvhPmEYea8KhGF4wbLI3Wds47Iore?=
 =?us-ascii?Q?uMJQHmgB3+t61o2cewlLmOdFOiLSpfWs0uduR87CjfQGX6M4tH9vS6iQ5LVd?=
 =?us-ascii?Q?Xop2m/ztgsrgxfhEuK9xnDorB0HMVu946nkdUbC1JcnP2tN7/XUU0ATa4RkE?=
 =?us-ascii?Q?WVTgW2wycKmNvtrnxGhg6rs9s1nNLhmQGovyk+EfrwXkIBTdfFB6cubgvK/c?=
 =?us-ascii?Q?yzS74+NXxcuqPpB6I3K7TXP6NrcgqRZcntqPbD3gGyaq1WWZrqANLIhGZz5l?=
 =?us-ascii?Q?9fbYMvp2wyprqfsnSKKeeL7QbShViL5IsqVVOTXvAmrDE1zz4qTovNys68EY?=
 =?us-ascii?Q?uD8ttmD8JkxZTPyeHqT+GTeEuhpdDzx1WHTbE+b555NskHDMJUPxoq+T28I7?=
 =?us-ascii?Q?byL3RFPQZX5CKRYgSXOdCbvOazyu5Y44Cxp052KXane5MYVWXBqmr0PKqGuw?=
 =?us-ascii?Q?wN0eNLQ+ViSET/H0jZnI10HoFK7K45LAmZ0SUYLV9IU6ZRFNfqsCFDoMTQxD?=
 =?us-ascii?Q?/tIAJmtIhtKXzEGUfKM1Nr1HsPQ59wkGczOsxyfDQeFfErWOGLB5EroSYbhs?=
 =?us-ascii?Q?dLQsl3TW+uun7Ky3c8jr/epM8qeqgySjhxe684qpEp8cq6AviXDEgj47YU6P?=
 =?us-ascii?Q?x8foBOeuiLOl475A8P6IezNK3LVIJIhti8e6Kv8cteCLOEGkoepHHluW2oBQ?=
 =?us-ascii?Q?ANC8LfOFjUZLOLFnsPHVjutVTd17l9mw8jQP1GTYUxTL6KQip4IEMqANYPlO?=
 =?us-ascii?Q?V+QzgfVSqUBUCTdujyWrpTOfx7ZhnyxMcCKh2MdOkrIWvymYSOPDrLReDLNF?=
 =?us-ascii?Q?3XIqGzmk4DbPSsZigYdwb636AXtVKn2XOQwU7Q+yumo7xy3+tRkMZfSxtyUZ?=
 =?us-ascii?Q?J2lOomNMlGxzM2ILMYaF3FZdOlHEpAI5TYM703L1m3oj7K3joVjnivaORbeZ?=
 =?us-ascii?Q?ydzESh6Xsvnie6gBd2+2xE0LwIm2H1V+cOI2lu4NxEjye1K1ACVLmQtixiJf?=
 =?us-ascii?Q?qmaWGDPrAdcisb+z54IncPmhQAl2tjGCX3Yr0AEjRiKryUmOeyRg3zcT3LvM?=
 =?us-ascii?Q?JXFQulgxeYr78/Ht0cDgGUipB4zgltPGm/KMC5ytuY2XKCH5LRBExGhLScqG?=
 =?us-ascii?Q?exjbqwxEbmEsJSp0jcrjOr+o0QCOIGp3Tj0W96Gf0YQev9UsnHdtji3Ld9v6?=
 =?us-ascii?Q?ftCjx0zpta+LGHWFG+5j73+TfW+07VuAFsam5ij9P7n8PrxKIfs+pJnQBAwP?=
 =?us-ascii?Q?vY9KSdAkbWvQnvY0POmnwZsiiulcHf18xevjgjnmZMkbwkITffwv8xfOKiZ0?=
 =?us-ascii?Q?Dc8dc9FcsnADWdvC7Cd5W2BB6D0mzvf+CQrp8PAy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf0373b-4a54-4213-490b-08db56d45ff7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 12:43:54.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jXDPLZoW7VddyVo20jWcjSBpxtdUWle6DBMPk79XjF/W5V/sXsGUXDeDnf1Damq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 06:33:30AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, May 17, 2023 12:15 PM
> > 
> > On 5/16/23 8:27 PM, Jason Gunthorpe wrote:
> > > On Tue, May 16, 2023 at 11:00:16AM +0800, Baolu Lu wrote:
> > >> On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
> > >>> The devices list was used as a simple way to avoid having per-group
> > >>> information. Now that this seems to be unavoidable, just commit to
> > >>> per-group information fully and remove the devices list from the HWPT.
> > >>>
> > >>> The iommufd_group stores the currently assigned HWPT for the entire
> > group
> > >>> and we can manage the per-device attach/detach with a list in the
> > >>> iommufd_group.
> > >>
> > >> I am preparing the patches to route I/O page faults to user space
> > >> through iommufd. The iommufd page fault handler knows the hwpt and
> > the
> > >> device pointer, but it needs to convert the device pointer into its
> > >> iommufd object id and pass the id to user space.
> > >>
> > >> It's fine that we remove the hwpt->devices here, but perhaps I need to
> > >> add the context pointer in ioas later,
> > >>
> > >> struct iommufd_ioas {
> > >>          struct io_pagetable iopt;
> > >>          struct mutex mutex;
> > >>          struct list_head hwpt_list;
> > >> +       struct iommufd_ctx *ictx;
> > >>   };
> > >>
> > >> and, use below helper to look up the device id.
> > >>
> > >> +u32 iommufd_get_device_id(struct iommufd_ctx *ictx, struct device *dev)
> > >> +{
> > >> +       struct iommu_group *group = iommu_group_get(dev);
> > >> +       u32 dev_id = IOMMUFD_INVALID_OBJ_ID;
> > >> +       struct iommufd_group *igroup;
> > >> +       struct iommufd_device *cur;
> > >> +       unsigned int id;
> > >> +
> > >> +       if (!group)
> > >> +               return IOMMUFD_INVALID_OBJ_ID;
> > >> +
> > >> +       id = iommu_group_id(group);
> > >> +       xa_lock(&ictx->groups);
> > >> +       igroup = xa_load(&ictx->groups, id);
> > >> +       if (!iommufd_group_try_get(igroup, group)) {
> > >> +               xa_unlock(&ictx->groups);
> > >> +               iommu_group_put(group);
> > >> +               return IOMMUFD_INVALID_OBJ_ID;
> > >> +        }
> > >> +        xa_unlock(&ictx->groups);
> > >> +
> > >> +       mutex_lock(&igroup->lock);
> > >> +       list_for_each_entry(cur, &igroup->device_list, group_item) {
> > >> +               if (cur->dev == dev) {
> > >> +                       dev_id = cur->obj.id;
> > >> +                       break;
> > >> +               }
> > >> +       }
> > >
> > > I dislike how slow this is on something resembling a fastish path :\
> > 
> > Yes, agreed.
> > 
> > > Maybe we should stash something in the dev_iommu instead?
> > >
> > > Or can the PRI stuff provide a cookie per-device?
> > 
> > We already have a per-device fault cookie:
> > 
> > /**
> >   * struct iommu_fault_param - per-device IOMMU fault data
> >   * @handler: Callback function to handle IOMMU faults at device level
> >   * @data: handler private data
> >   * @faults: holds the pending faults which needs response
> >   * @lock: protect pending faults list
> >   */
> > struct iommu_fault_param {
> >          iommu_dev_fault_handler_t handler;
> >          void *data;
> >          struct list_head faults;
> >          struct mutex lock;
> > };
> > 
> > Perhaps we can add a @dev_id memory here?
> > 
> 
> what about SIOV? There is only one cookie per parent device.

It doesn't make any sense to store a struct like that in dev_iommu.

The fault handler should come from the domain and we should be able to
have a unique 'void *data' cookie linked to the (dev,PASID) to go
along with the fault handler.

This is all going to need some revising before we can expose it to
iommufd

Jason

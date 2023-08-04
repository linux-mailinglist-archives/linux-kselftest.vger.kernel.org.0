Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475C4770281
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjHDODv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 10:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHDODu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 10:03:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AF01BF6;
        Fri,  4 Aug 2023 07:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsAaHvgW1vW4Q06D+l5NZryfOBBJHLyahboBCeNrO4JWHeMbSkAoyvU9UzuRRGc+iUnCwIte8PsDgRxYgGzkEw2kovWILypl5KQwIq3/E10CDIyvQn519u2/KTepYdtxYO6hKLHD712pl/I9Ts9mF6ZatQLatrwGtHwe4lCmK3rbB9xtSHjKrTYdNtSSAs/TiAofnebnHQ0ct4ABJdv0UHCZyu7Evyrl7psfljkQuV+HSb8acDJmoFyWU7aofxZ8WeQnJB4lySdSWZWbVqLHed3EDiy7xQ7Ejla7flVRR9E9jNMkW8YXlz4v+mNqdFhQEE6gNAjx/gUQQen/kUeshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NkCW7bpXzc+cebxVnVTxUWSK0uZOt/+TifQGuZm2us=;
 b=P8Pfcc+/+xgez2ckUPRX08+/raWxoY95YzKIpaZWthMt/w+eiEJtDbEvpVnzbD0ZO9O7QkRz86BeMShvZ7N7r/yLaTCb638qYblh0h7CRl9Di1qTRGn5fjz00hcZPnI/6+YYZkxKTYsvTbg8eNDgYqThvrS1T8T55NW6dHQhtUltZBWYn26GR0jqDnitfw8MdugxmwV2xO/3TAOn1TSVZFySPH3ojADqSCuVeS18IsjLnPs0k6gb2EpzE9piPzrV1OZYy8Ic3ysFYefmhJj9yUbeI1jH3xEBWeCdYWJGvSYOhGuLVcBLfuH4VZ8TYeSptkzUR2xfgPXZWTApw2KEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NkCW7bpXzc+cebxVnVTxUWSK0uZOt/+TifQGuZm2us=;
 b=lG+bkf5bVzQGMA7nLCgfVlL8UM66P1NaB5em6/ktHPe7argkIBFXMALsnjjT+U0cSd2DdP46Qqb0JmqMOzDZaJorxtpF4ia3V2b1uqBfQv6Dmlod/yIo0xcwpAEP8+qBuvvRrKdBnix1j4EyOEA8aYRliqh7CCms+fFSCHwNp2a3mjReUR6gHK35hRrFG4JL4qwFaC1AVrrioXmy7hw2zS/9GnI8KbmhQ/25WINN7MAXofNgsrbdRq6rhbvNzqmXAphzOZZOtk6noQVyriyCKjr+46q4AC6zPBHgSNtFrYQ7zx1/q7zUWI2g0XFG1wYi6ldPPL7CextEUG2lvxaX/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 14:03:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:03:47 +0000
Date:   Fri, 4 Aug 2023 11:03:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v4 07/12] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <ZM0FQW9qo3RoNKmX@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-8-yi.l.liu@intel.com>
 <BN9PR11MB52763681308D7950A51E18438C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMpei2/CffaW97iU@nvidia.com>
 <BN9PR11MB5276035683CE2AFB7B0F36D28C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB75295187EE9B4EB64D8797CFC309A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB75295187EE9B4EB64D8797CFC309A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR01CA0025.prod.exchangelabs.com (2603:10b6:208:71::38)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a70d8d-e7e7-4359-e01e-08db94f39f17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsqHeEPfv75GmOcNgLm9RCqHGuvkDcIx0jszy7Je7RVQFsqXhcWJykSpMKb6HQoiIkjXyIcTtc+Ym4XEu7+yjF9+Eb9LY6zHrf2eF8oGjrihNFQQaE0wq9LNjODGESHPkdsrjvNHmskP0umVYbFDN9Ybe+Jbt/Js0OTN7sY9bCjmvyRbXjwyeS/H4E444PR+H/LWxNxatv6ORryHAxV/jB/5suRXGBNLSdDaXu/dZsHWfRX4LZG1rTA32+/tCKVR5Dp+z21C881NPq066/Y3HxwOJ1hqZkywIDHH1g2LRs3MaGpnS9kc5TpQQmLgdjjlgJZ5m266t0qfN64S65YmPfI8JdJFt25lEfY87v/qoWwt2yg9AQCL5qadAQjiFTYIDIjBZf2qjOvA/LmJwlwQTXH6VGleGCpQ+5ZsTMOMZqnFVZKehNukF/xW/HIGdA7uspBReE11DbPAnGfnw1Xv1Jj2bHthrVIe3e6rSXdedHwI/Zm6m7cCYtu7BlecbGndRKLCGc+pq90izbV8pgfARo4vVU/ovUet4xjAMLR56VZr+Gqwm6XFn1O20tGXqvZM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(1800799003)(186006)(4744005)(66556008)(6916009)(41300700001)(316002)(2906002)(66946007)(4326008)(66476007)(8936002)(8676002)(5660300002)(36756003)(26005)(6506007)(83380400001)(2616005)(86362001)(38100700002)(478600001)(6512007)(54906003)(6486002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cn9bhfQRwWHQ7Cz/4KUHLqqKSICtfRHSAPeAnfAFa5d8oig2jOkWC5h3aWWy?=
 =?us-ascii?Q?Rp14AxC99PZuPfziENLnW3ztypKuQSVs5dp0Vg4KjalFDl3khEc4jhQLNAzT?=
 =?us-ascii?Q?kKwT1OokTUHHr3xRRNi/Ic+Dyw2dmr++PvnvVVF1hUoGETvVMuwgErTQ66Qk?=
 =?us-ascii?Q?wfY4b8M6s09u+t9LzlMvPLt4foyJ0OAFFy8kjM/3ssl87YjXauLUg9wY0eIp?=
 =?us-ascii?Q?BnIPzBTrQ1AvK8jTf4tZ37ra5utRDK8VMlwbHLYDmHEdXIlW2FDm9Ri7e9Ux?=
 =?us-ascii?Q?gkc6Nk76JVi6ZyEpoVZ0vkFKCgnb+9X/ZRjxM5dlF8oBJlVUotGS7UseOgY7?=
 =?us-ascii?Q?1HnlFAwwzu5xVg+g1vblZYGEK1auy41KSdOJvGoZRIsf6LI7HuQ5fRIlu8d4?=
 =?us-ascii?Q?J0jnvXU1KwXGIZ+sp9qu4wnpHfBb1oQxVQLL1EGdk7Zu0cY3RvQgykwoBUN1?=
 =?us-ascii?Q?jW6I5xJyJkaQITvlmkn9MJ7H+7T3xpFmM6K3Syz6C0/cLRmoSMXmZdvxpE/W?=
 =?us-ascii?Q?O12vUZktV4XtQPCHB/8O1FtHlW23CxQ+TCrVbhqCRBxMhfi8SzclSqtVae7z?=
 =?us-ascii?Q?0b34LmPijSInjZkL+TrhMcnmXO87AO9PKElTdGVQWPCm2uQpfVL8Mvbt/sqZ?=
 =?us-ascii?Q?F2Pvq0rDx2A9csqK/wOKD89EyjhPfVpXAv29tgn29GOOKq8gAZraxCIJCmZv?=
 =?us-ascii?Q?4/ybgCgc5b2oNEppEwmnMSWJKQ8gmf4CgmwRg90ZgQFfHwBVtz/JlNFIJDI2?=
 =?us-ascii?Q?GS8fh5vh8BnFMVlV9lq6/fpP76cKo+jI/9TVg+Iozq8ZIlZEblK6eafcB5az?=
 =?us-ascii?Q?yUzsrWrw2PAAwt20WpSCr3eCgxzE0SqbP0pS7cxyPHIEmj6EWuZlJH+wYeO6?=
 =?us-ascii?Q?5LZkCwndMz7IF32y93triAq7qsAmruUzbMEbq7Qwa+R3l/sEVYSDpswSSzBJ?=
 =?us-ascii?Q?Q6zBzmHmSMHj0t6yq+mhtRI3GQda6C+oywJDycxc1rpqqTBvuAqmiQHqoYiT?=
 =?us-ascii?Q?1NHdEwMfgSr6Us4etMGsO53yrOcNUctIIMj8ZAq+KBAJTh2eu2lXVTKHdovZ?=
 =?us-ascii?Q?oyBo6JeGiqyHNMmcHS8C6xd74cTKNz93XWuEqm4HXjIzMdgBvlc4dcnLYwU2?=
 =?us-ascii?Q?+3Jin+f6nbx/8M2Rmal7xBhSa74jZE4sgFaMEZc70KBw9naaHiM4CfrYAk6k?=
 =?us-ascii?Q?9eWRDH5W9cBEzn5Z8jf0ApZGUtfJIrp4VrUnaPGHh0BsdbEgLlvbCjBG6zqX?=
 =?us-ascii?Q?NnwcvTdDttOW8N72nenbrjBXjmHlDrrLpdJbk959GaMPoC7vhnnGkbd7YffU?=
 =?us-ascii?Q?86DVFVoPVVz5cHZBeGC7ZVekHQPv4yjeNpLd91h7gP9xfpwUkxkZkLqbST/D?=
 =?us-ascii?Q?Y9prh6iogI662xoj1zi0FFLQS9Tlf0B4azO/+VzRxP13ovC1rGJuVwl/WiYx?=
 =?us-ascii?Q?IAT4pobQvpkWpa8hS9Kw6uW8Gg0AAsfrL99H8VVHk3T9cQIsGpXi3gMGzA2u?=
 =?us-ascii?Q?6D/m2nyIRriDNeVEEKp4lwhvTkEiSn8UMpYcOIq2MklIB5fW6DpUMX8cWQWo?=
 =?us-ascii?Q?O1oIjW6Ji8DG06WY6QL6swzJlj/3p/c2kfan9Wv3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a70d8d-e7e7-4359-e01e-08db94f39f17
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:03:47.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcwKQciZfyqIzu2AYVov3T8MfhHNAGn6VKy5KGAWzJA0g0XXCEMgJ9mp2PBRDSjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 01:04:57PM +0000, Liu, Yi L wrote:
> > > Having the driver copy in a loop might be better
> > >
> > 
> > Can you elaborate?
> 
> I think Jason means the way in patch 09.

Yeah, you can't reuse the stack buffer for an array, so patch 9 copies
each element uniquely.

This is more calls to copy_to_user, which has some cost

But we avoid a memory allocation

Patch 9 should not abuse the user_data, cast it to the inv_info and
just put req on the stack:

	struct iommu_hwpt_vtd_s1_invalidate *inv_info = user_data;
	struct iommu_hwpt_vtd_s1_invalidate_desc req;

But I'm not sure about this entry_size logic, what happens if the
entry_size is larger than the kernel supports? I think it should
fail..

Jason

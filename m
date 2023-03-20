Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D606C1227
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 13:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCTMop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCTMoe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 08:44:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC19776;
        Mon, 20 Mar 2023 05:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBpiZyFo8BcasM8Qnu8OXHxecsOm3sn5FCvldJWXoZafhdKHjT2dhYOq9Oth19Q7Zeu2JzFhLJY/f2DKxjE4EzTlf9UHR14WcSfbuQngkkq7vSmiqDSymz/IqEgd8EAvgd7deN1pw4GiPMLwH64EDqdq+605xUk9cU9mBu41v6S+rC1d05M9YQI1f4FCdOaoDd6netswkFdfqgo0eoMqdZIzQrWSPhGUJWwqwXufQIIx5WF/rpTzT0zjbCD9nxcB6VR0SxUqupL+D00HdGohariVcRDMjdle6YgzxsYDe7oWrPXGJ1yGUEYOPzeHNO/3CUjgVaah91DTPs+Vva+Glg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNcx4FflPEAl2A2BI4fMhKSc/QI08KK9J2sz0PPB8xE=;
 b=ElqhNKZxcbUCShDSkw4Ct3sSXpUCJFKDvZ0DO+5sSCaTzreLRiC+ynaV5/sZEq5MT/CdpXXfQSEf0l3G/61GqjTZFoZgoUJbtKmGrvwYIiJ+kReS0wFPn9VBbOtBog408tMZFHX2jpMMHWAwjXbxYeZpGsylES6MaQPA+y9pEhbtsR8O5dG6vYsgnTo+m1Hf3p9CoApHoFLuj2gfOL2afNx2MJ/ox5POP6DsQJwJzywDafKBb9Khd1YZ0Dzy3Lfv9PExMM8tpR+zVjNCDl9DFv+W0nu3FGyuoQxCsxQSf0rq+Oz7PeBG7sid+xDWcchKoBfGq2ndvkRWGrY1CrxWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNcx4FflPEAl2A2BI4fMhKSc/QI08KK9J2sz0PPB8xE=;
 b=GR0jjq5H0zk9nwS5vFazXmh/rqRBqt8JBpc4mhWIeWnZrjBcUBUit7IopqNTW5PlIV6M8cSHfsc2IG40oADRxX6YyyHZgYLJxIMpvkuMwi9X5QVnP35+MrbaCoQjo+5ahjGpJ9kGHySRKIXkF54hQLlbnkliesCuAzuDxgEkmX7aCdETylfTqgAQwEWL/HiV9ux07AixR74lCMceP/tmenGliWAbAHXCrEMSXsbP+jzyeBSnAAK2384utTf5p/NovR8B8a4qFmw81Yx7+mb7aa+g8lQIfPKBgjQtSUHHRO67VMW0c28qye38gt2f1o0Q+Gxzx7ek+Cu/3JktzzOrpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:43:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:43:55 +0000
Date:   Mon, 20 Mar 2023 09:43:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iommufd: Add iommu hardware info reporting
Message-ID: <ZBhVCpsWF1RmvnJL@nvidia.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309075358.571567-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:207:3c::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 228c6bb2-cf06-4c88-739c-08db2940c4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcUrAACdIe2/KSAeTxPfhq+8DqNrM45Rc1lt64rJHPSdcr67Vi7wnkmJ0bnYtuW4G2P8kC5IM45sm+SxwSQeImQCsKI6kn3D8LFsFTCUmAwuFdI0e+k7DF+LqOz5zUbGbM7qPj8JFF9NO+C/TAzM/56vgzfUwHjsO/qTFxFFgzR0jreuabmu6r427zfvD+n+Tn+flhj5qCogCh4faOXjFqhrLzpA9G1xTG6z/RtwXIY2Oh9ujWE4tSy+mvIJV692YqhiR2z6FCO257GSIMCSGWqBuwwNd15dWTN0NCh5wwnaX0VkeCegUmk5QfRCd9+zNPfFnqPUdo1rtbixS40YUAugPfAUij1OCJ9ccX2UlDw+yqJFG1/gqi0Tu8v/7i2dz2Fd3A2bqIloo64nIcMry9qcH5GXTO0aLHH1lyy5TytY+5I4v1oLFr66NdVNj8nLhPMB2hckEM8EALlKNMsU0zuPHbGdmNjnjZqFam2CUKbfQ8OWqYPCNvyD2ir+nvMlTpdvehknaUXPIeZSt9s63HO5DT8ogPcB69uDlUID/SPtAqXaUEyS2wvDFMrRZ3eZOpNAXZJQ65sF5t7di7FbXp8lUvZKYuhzJ948HaY5pPkEQI6sHfrwFlRSDLQHChQ7XZ/ZyyKB84W3D/zDMVnubQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(2616005)(6512007)(26005)(6506007)(6486002)(316002)(6916009)(4326008)(8676002)(66476007)(186003)(66556008)(478600001)(66946007)(8936002)(7416002)(5660300002)(2906002)(41300700001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PWokRxRK9kH7GPh9166uB73lclDRVmbX1o27sAk2rWLSbpB+ek9dKREuXg/1?=
 =?us-ascii?Q?BMsiUAM4THvFf5F+lTRwDHZ51D0+4UpmiwLiLh5Knz+nPcsaIgK7Qr1K+Zmt?=
 =?us-ascii?Q?eEviR0SeBGhHNr2Fc4QCnxS7LfXQdcZynUwhEcrentxq3kdXZ7D/joS4o1AL?=
 =?us-ascii?Q?FV+ZfIWIQ/x7oB6xdH6NB5XBy9fJa2btVrGk2TF8uortQqiURlGLHpop85gz?=
 =?us-ascii?Q?Xrdodpi2JtIZPHxGVGXYSs6lXUmBp+mCv3c60QcyTIaihbFMK3cZ7yrNT2E1?=
 =?us-ascii?Q?WuEpbQSFg0OFG/w1RBOhl864spzGQ5QaWiVnlM8ENlAQTRpzIDOI4ck3PTm2?=
 =?us-ascii?Q?9I5Hs4tLWauhkQ5b+SeRNZTXVDAMUanFFlSupTC8cmwcEVjgyyXNCJ9auUPY?=
 =?us-ascii?Q?TSoYyPWJGUcef2HknHf+3K7HqUbppXIlX4ozx2Fs+U5TudKrDUm737ZH5MIZ?=
 =?us-ascii?Q?8g13ofLLcJKSvaly7cqD6FiS8W5gsox68NR4Ahbce6/uhZkuCL8lL1zubca1?=
 =?us-ascii?Q?tNGIsCertsURcv2TilzNk1xZW6+25g5cCAQ1prF0inNMc4FAp8ly1hCyzQID?=
 =?us-ascii?Q?0tpdnaI5tK+V1bsCV89OR+MauvVIL0BfnzdvQEmHQMmDTTDNszc+ptAWEAuv?=
 =?us-ascii?Q?fU1wL6CC3ZBlV8/XwBcgJUnnxmjEkplOs0i5ypVVx/IIt3s8ROhRT1Rk1qji?=
 =?us-ascii?Q?wUkBYmXGTwhmdNgyC+mFmy7fovpOBlNivielPhCa8CFzRw2GtQfxZxzFR29x?=
 =?us-ascii?Q?LrBA0cDRzwCoqLU8J0Zic7on1axZnRpEuEkwAKJos08BrIrjHzA7Vmgf/xKR?=
 =?us-ascii?Q?17IvKs+gXdSczjlVsWj0eW7eKXq2imAZVUaloyEu2P/d4VwLuRyo9HfOeJ4u?=
 =?us-ascii?Q?p6t/DqwnFqq/cuIuHqvKQeNpXXct21DklFLANIN4GQo9DhAtnsmah9TyOwii?=
 =?us-ascii?Q?fmHllRKi+yOivnCTD0lkLtxXB8Mr04MuOeVQ6OicEkWBpGdeAcaE6vrABOrh?=
 =?us-ascii?Q?wNR4L+H5mO+5VPUHO8SGCPlTz+Lrhmf5zjWlUmJ5Ns5CxI3Nm532vYv5HlaK?=
 =?us-ascii?Q?MP+vu3zXnQqNInMlE5qLNxvd9Ie2OcC1tkfL72sE/ppAcYJuuxSbqMHcuw7D?=
 =?us-ascii?Q?WVZPtBk99+pkvjKv6m0zkX3SBKUHAa0h42smH/Luim2fKwke4fj/vzzi9VTp?=
 =?us-ascii?Q?au3QfjwhTUM1MdC1APqEwT8lnJvEENXgGbf4W0gKkOqFRENmTRTtF9Tt/yGV?=
 =?us-ascii?Q?is2yIbRcxI8U0MY6uwLCdzpyYJmWYyDLbuXbGynX++T8KCJM1MGxahjQFDAi?=
 =?us-ascii?Q?mi2RkqY5M3k4TgcceJg8uXj29QlPFKNWkTKHqEf1H6yqc2gJzWwsaP5Y2aYr?=
 =?us-ascii?Q?K0yqgOVSUSQW9S/4TeuyoceSvbC8DB6QCm97K71XF7vBXjOsvMPHqffa/MD3?=
 =?us-ascii?Q?JCqGUABaiaEZQNr7TG0Fys65veq/Wkjn6UpOKHVxqLgoMwtHjRuA4o/yhEwB?=
 =?us-ascii?Q?Iucx0h5bao3776ribGE/17G8YblyNwt7/REUzyiEMhEK2WSOyIQqcQ8VcOjv?=
 =?us-ascii?Q?DEKdLZqKQ+wMAhIZr5h+XsWsVJcxGrh7PzArRvJT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228c6bb2-cf06-4c88-739c-08db2940c4a3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 12:43:55.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6D3Gd7mu4DpeYQ7ed2BLJaDuW2J/5KEWohcvdLMwXX8CvL1ZwF57SGNYFXbObNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 11:53:54PM -0800, Yi Liu wrote:
> iommufd gives userspace the capability to manipulate iommu subsytem.
> e.g. DMA map/unmap etc. In the near future, it will support iommu nested
> translation. Different platform vendors have different implementation for
> the nested translation. So before set up nested translation, userspace
> needs to know the hardware iommu information. For example, Intel VT-d
> supports using guest I/O page table as the stage-1 translation table. This
> requires guest I/O page table be compatible with hardware IOMMU.
> 
> This series reports the iommu hardware information for a given iommufd_device
> which has been bound to iommufd. It is preparation work for userspace to
> allocate hwpt for given device. Like the nested translation support[1].
> 
> This series introduces an iommu op to report the iommu hardware info,
> and an ioctl IOMMU_DEVICE_GET_HW_INFO is added to report such hardware
> info to user. enum iommu_hw_info_type is defined to differentiate the
> iommu hardware info reported to user hence user can decode them. This
> series only adds the framework for iommu hw info reporting, the complete
> reporting path needs vendor specific definition and driver support. The
> full picture is available in [1] as well.

Other than the small notes this looks pretty good to me

Jason

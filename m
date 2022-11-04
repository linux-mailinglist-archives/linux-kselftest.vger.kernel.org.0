Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D961A163
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKDTmX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKDTmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:42:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D660110D;
        Fri,  4 Nov 2022 12:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF/t5KGxJUnp/j+9yubWGsoN+He7TCccFSaGIv648fvfmsvmYBFmTn588iBkxUHWEunGwwFMdXyr5aMLS5WOdV/1xw4R7XYPt5N7iuAji05QsL/m+OYPG5fg0Ab+AQZgHqYT0+cEfd4Cgfk1VVv9xfeneWf5DCfd1rsLiGWvH1ojTvjh/EW61rPiK/6AVW6bNjR4Ep/NTWBqrEBP3vFbNrO1wy8PMtVEUOiU5PYJBn7DyNym03rEoweXwohbnwMJj/jCGZnBjKPBEzDHhi7dIUqlOaA+dqOGpMQLvR0oJjLS6Kjml8Z4H3LYG9YA3g9i8E8UIzHv9gOYJr5Ww94C2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbMEoeVkrrujqXBvUGz2hBHXQEM8qxATzmNaEy8OBDU=;
 b=IHXKLmL+ieNLwlXXK0JUohxk08QaIi5ouMzIvhUkDe0gVwtFx3i8asVluEVrdCVRHCbH+wJf+c8ShpEi6v/+KGwAsBhTUz8HvKE5Pz4vPTvOsKgFkhN+KxsMs0/eHh7zWIiktBvPhktSiT1XV0iSO5Br6iWf2wHqXxi2tMWaSceg/poHHTRHq4rwLZFDcEP07efpTRhfMiUnCYEJ4ywpDfUWUWFYfdVUShYCsAnTHP/0nYlR60XIwDG/Z8tgpA/EtGMSFqSDyk4aeVBac8HPzg641ZBkgdV4oS/hD+6fZxVt7UEl6Nz096459gU7qlFiT/nmdiTEs06zHzyiIOiKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbMEoeVkrrujqXBvUGz2hBHXQEM8qxATzmNaEy8OBDU=;
 b=MP2QVQHyV1pqMC2VuxAWEB456CabZlhDjsKajBgZ++OYZvx09PheSkr4YWCQthYjg+mLWooRMVmse+mZ51TWjBfUrbJZV4IjtNwoCJjQHbHMYt7toSGvJQwIYRIiADni+9ST+De6HbeAO3gfAElhSfGD+vfmOEY9i4zeoBQohQY+elbAGm4xQ6fWW9xcDrsMxaUQXcf7btk3T+eWwdRxzrvkhG7x95X2+du3BtumP/xqIhE/1ytp7t6unSHJkRDYcEl6twlMyy6/kSXWDPb0+mS05dmfpvjWSbD0D4c7BvylO0E/3aom6JdmZFFiwvoRJ7XwWGinxfvPfC32RpU53A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 19:42:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 19:42:16 +0000
Date:   Fri, 4 Nov 2022 16:42:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 15/15] iommufd: Add a selftest
Message-ID: <Y2VrFuToyJwU93WR@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2RkXV+q0Q6bdTde@nvidia.com>
 <BN9PR11MB52769FA78CA8B7FD3DB7595E8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769FA78CA8B7FD3DB7595E8C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:208:23c::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: fa79764b-d442-4044-e654-08dabe9cad3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IELeb8cKVz5CAUM5ecrepwGPVfO7iAU91sKueH2EwnvktC6SuX5q7mA86bu/CykHJ1stztYIMz5heWcYci6Mm7c7+JQ791mPN7py6NXva145Ag9GeBwGtbsV9xHnMlBwx2cPHPcng+dcxHerUXqZC/iy1YUWecc4/ZrAub4y4UUpSQxDz3Dpr8z9n/azA04cAqBWUgQMgywKZ7gORNRdCFBzmz9ojfpbnux3CTA7RosWF2DvIsde2wrmlkca2/tt2qsInA0QURb8AmAx6W7be+hYi8M16qOmyLi1VBZqt6Di7zOAR+M9PqA3wuOM6W7KXMb9satpHy7CBECyMLvZFcLRI03c8vmIWT8euIPcdh0Bby7onbu5sJtMLED7mOIkIPqW9Z/Ey2okNgZ0Lt2uImVaEvzFUkIcVOBVucGBpQGh3SNxxTUVdglrcFb01oJp2/AaNpf9dC+mYwSGy1f1n0C0FIHK2rQK6EcdKcW8ZvZzpklhfC/wBDj79s933V4ppm1kGJ39plxulh0BZ1c+3NRSELeFNgdfxbfc59PMCobwvosVddGb/5EhdrYbwVotF/ZPE3dgmOfvzNANQE84Dy8/Y8qWZO75gP8eR0hAHRFemKYkCdcKuY5Izz1mgeTUy/0VaLSHviNS5yW0LOXmWj+pS91ByAHbhFDR4xKxcFCMzn75sBrT0KKvYc+Y5HdEApVjtKAm6J62z6ZvZU3vVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(6486002)(478600001)(54906003)(6916009)(316002)(6506007)(4326008)(8676002)(86362001)(66946007)(66556008)(66476007)(41300700001)(2906002)(26005)(6512007)(4744005)(38100700002)(8936002)(186003)(83380400001)(36756003)(7416002)(5660300002)(2616005)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4l+n+GjHGDYcqsy8npVSctdu34AbHYMQJOH8lYGTGz2ZXXTHjdtfCAU2h1aD?=
 =?us-ascii?Q?0qRP64kMgD6fg3uhBL4TlTBceXjFr1i5b9Vlx+TbHD4etRHIPvTt0aV0NZYt?=
 =?us-ascii?Q?2OZ4tsYxBEdx7GHKGxF/HvkLjRTqWiZ96imYwaZON3kP6gnqs7ugely9/tPP?=
 =?us-ascii?Q?GfGI0oBG2rWEZBFwINUbfGiWng0utAlZytHCkTdjI6QgSP+C3UX19hVOEBZ1?=
 =?us-ascii?Q?Xfjd6FIMFvjJpeZzQDb31kC8gZZbYCVDgimo14UZ53S9BRYwbgYm3IzANApJ?=
 =?us-ascii?Q?Rv6GaQVQWjWpgdjY5iSjqonRZRpUWfKWfKgkiP9xX0/SJK5ruNtuOhh/DGl0?=
 =?us-ascii?Q?Zp/cbFSN7cAoon/IXBG8qgDTXBD43BP+Sd8DQIyPXXgaYq8YwmDc2vkyjNXB?=
 =?us-ascii?Q?7zgliYL7Es60uc8d5+6LjibizLRaZ2L4N0XXtqbs0A5a5wvO9nQJHr5k50vj?=
 =?us-ascii?Q?/ZjDXnFi/Hvs7PfOIIeQxTH4ec8N+RwzkgawNrZOykOMnq0r5sUluD6Xe9RG?=
 =?us-ascii?Q?s++CPb4V++FHQNI5n9b0TBNVfoaGTTePgwg4p08xznk7IgrJpbSl91gGVs45?=
 =?us-ascii?Q?SZ4Kt2HsoZHnFIMEVyYinqUOKR0DZ39yzz62Tt8HS8wRZXjqfLIRDcz2PQey?=
 =?us-ascii?Q?B7tq+KCZqFU5C3R3uwdt0v1qtM0kS6daYCOlTwK6qZBjE2bRJ6xU3o1LT+li?=
 =?us-ascii?Q?lk9AtMZ2sZlq52c2yL82eTHIOtCHsOQvnk3Zm2JiDssrm3ihmwNo87CxL03n?=
 =?us-ascii?Q?ikL0QsSXW8lZSY6Ko3i5qyT8jhK10kkQhpWzuPaP3js2te3Ug1W5MzlYscgd?=
 =?us-ascii?Q?6CeQ8vaIOmAgmrkqnh7VI83L+LpXRiK9RwUbaDqT6dkNfish2tMMBlvlsinj?=
 =?us-ascii?Q?kQ8jsOzCfWX9WgYgD9wJtN4C9SxOvr++j72MZ6ygeIXCVAfSf7/ajfB5NPM9?=
 =?us-ascii?Q?Z//kYh3Iqpzf9RvSwEZk7rH1Obrl62u0VjE5WCmOUFvRiXPyxv+K+nU15Heh?=
 =?us-ascii?Q?H9V4CQqwIBCY8wUPSCPuamSUtw+oKYVeQc/E2TKK2OP+9hT9tuwvVeOYWcje?=
 =?us-ascii?Q?auqxdQN50CXZ5znZZHPN1+Gzy9vbWnbYm3KJkfkxRj3f9/0lsN1n5+Lh+ORW?=
 =?us-ascii?Q?zu32vNL8p5dPAKyfTy4AQzspcGPOC+iGFEVvm7lHIRcSvnts45DVBNUIb+Tw?=
 =?us-ascii?Q?oEjTxTJM8UXihI5BkbdYkMdVyUNKifMYUmFyjH6fdc5pPUkX2iq5njfzsEwQ?=
 =?us-ascii?Q?0nKOxg5diIaseBn6lpoOw5BKMXpMgqyys3Sjid9bdNgSuUFdExXpRGyT1wsW?=
 =?us-ascii?Q?raner3sJUIDxb2AXWgHCYp0WPE6XuaH+t0Ff2/DuIwhUe74t4yD40/owTUrX?=
 =?us-ascii?Q?Zo/9/1Jgr82KvIPUFzxibXUSv4VuI0pk6iwN/7aAGhHohVE6wyBMSm91MiaV?=
 =?us-ascii?Q?Su1h/UB2MeAWSLggS2Hs7Szb5im/1ijP3DsIc+szDxQEp4+Ln/zpioyzDmEB?=
 =?us-ascii?Q?uqiS5jMGTQlLCi7uq7YjpagQVOeSUb+1CGxT7oioPoLs/cJFatG2IedcSX4L?=
 =?us-ascii?Q?4zRXjbz+PrzO1rJfnMo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa79764b-d442-4044-e654-08dabe9cad3b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:42:15.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPGhiqp1t26oPsvFu89Owxp0u+brLHriXEBQgreTgsFwCyRuIYLctpZicTgCbOrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 04, 2022 at 05:43:29AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, November 4, 2022 9:01 AM
> > 
> > The only way I can see to solve this is to hold a serializing lock
> > across iommufd_access_pin_pages() so that neither
> > iommufd_test_access_unmap() can progress until both the pin is
> > completed and the record of the pin is stored.
> 
> same as gvt does which maintains an internal mapping cache and
> conducts pin/unmap with cache update under the mutex protection.

Yeah, that does actually look OK

Jason

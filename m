Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04617D59D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbjJXRh5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRh5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:37:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4359783;
        Tue, 24 Oct 2023 10:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHczbHEE+ILKJiZjRK0MCvOwoq2iJWVqW9Ftb7ULCbN1uYCNf0hzqD7RxzZfgzqmSUhr9WG98AK2+tQ1EAKA926WmM2JZ06pbIGVPWYh+7GvAtRreals3zSwN/4JhmGiM3u5qUJr9Yu150eMWJvIOHZ2djb6qLyWc8Ug039tUIGb9CTT4HjGV7BSdjrDhR4uWRI2A80YOiwU4vXRSpOfIR3cvZlexWWS+7lTFrCVzxR0poAU87GXZay+qZ4Zo4tJcqldE+ur+D5JsUpICGkdW46i3b9RnEDSXn87cTfs88m5msSpZItJ+FyGNfofkzrWZdyXIn8UhJZabw6kYo8LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81MpubfqIYGouh1IQ3xSc0yLXDkNkDRWTIag0waJYEc=;
 b=Y/YXvC1HIzyIBb5oQmKXCit+HPZFUJ9sRrGQbsz9JKW3hG9cMpEkPNL4mYZSwQkus881xj5q7NrIdbn2jZ8wM91ifUW5HI5kwK6Z4Nm7pgYS7jKc6ziu89TEcN6jd7cD34fye8/nHZjCiVAMnzwzWIXGqiVe1CypMNqLB3e9P5kPkAoTraQerpLJ2OjP9qxrf3s2tOEZqojnG0/J3tbwpRwgHdRHVW6dlfz0PCSjeHFRWOFRGHQCe2QUIdDLh5oCREUJCwprrYHtPrRIRKngUM8+L+wrTa67oi93TTPbSKjBX+hA2/pCy3LFnUZy7n7KeH5oFpN93KgJX0MUTB4lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81MpubfqIYGouh1IQ3xSc0yLXDkNkDRWTIag0waJYEc=;
 b=sdz80kml7Gu4fI45rggbf4zHMeS6g8KG1yu+3u+9dU8X72vSVRGQRXG8RJ88PQeXCuJEPwNZNcWHzsfeZpHFFjyYx+LFJDwyKNvnf1RszIeK4mCPDgnIiWNijkR67o3zh3LLm4jUaKLxAxYuywgXrAHVoly2SLxFLPfYvQij6Qyw9ku6qodIhBhaZbd5O4hOigvaepk23c4WWSYn1NsixK5yN/y7BlssnPfdR61ZqedyFEOn7ps0xvIUeZ61OJ5IvZdwU6jo73YideaDfmsqZvuY2dftxynfV/khh/NosJ/c4R/LWGIgJI+fPBpi0fX8jJReLcKW2RSDscRB4A69Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 17:37:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:37:50 +0000
Date:   Tue, 24 Oct 2023 14:37:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <20231024173749.GS3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150609.46884-8-yi.l.liu@intel.com>
X-ClientProxiedBy: DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3b3acd-9fab-42bb-f358-08dbd4b7f1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YE78voNgh1bQ4bgHBdObZP3KyFrR05sU6u0UTN7CdpPMlSORSAvm2RWo7ZBNlVKS9OhJW4lLJTgiZigDhTyvq2uZDstNQovPJb5lG0c5FtKTMIc8ON4y2fsSkzYFPZH4qV0lQY+CLfnRxaKLY/SPDJjMJH/N/VTvVokU4cgznhGm5cPsNOlyEgi+wHzYBuaHWAIm2tC4Q//eJsO9gUGr19rYZcYMipiDNQ/b/ceUHLzipZPSXKn0M58alqJvljBV9mY2r41NHOKRj5Vl7a2wrIlF4Od/07CvyAas/PcfrJy2P8lncyZE+k5AKa3vfp/c+yXtHAkez2SKqC6mZ8jueFaD6lEYMBjhkJbyL3GUhH84F8q8HMYvV2wnGUFZwFWqzljiDUqOkSkCMn8zkKAyAMTPyrFR6v4O1wocOpSRTc/PmQD3KeMKZFwB1qUPVbskrACuy5uW7/PscSoUd6jiH51DDFdtkiKLk1TqdfGq1b0IhswEqP4qr+qMugfYNyANRebvASEVF30BAVMhAZVdZzUXDGUJe0CH/qMaYZ5ZQxcEL+Ed4doyNYDWSsu6l2X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8676002)(86362001)(6916009)(38100700002)(36756003)(6506007)(2906002)(41300700001)(7416002)(4326008)(1076003)(5660300002)(4744005)(2616005)(6512007)(26005)(478600001)(6486002)(33656002)(8936002)(66556008)(66476007)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPrXetCT/ExfQi5r3CWYK8trI7X1dCeSpIu7R3UmdfjfzGOsLQUC7ScDSnS4?=
 =?us-ascii?Q?bL+UjL98koVQhkpETnzuOgAh1ilElRPjIGCFPixKUw/nObMMJL3ogxP87G7B?=
 =?us-ascii?Q?RvdCxuKoQu5JWLOmiGSiXiRcX4RoBJf/NaQISbePWjAtG0HYrerYpzK0V1BY?=
 =?us-ascii?Q?gJ9wKDDaALVH+jZJGdtvyd+V8BMw/DE91ejLrt0i2HRRknCpdINNnvzl8JLw?=
 =?us-ascii?Q?eUpZkDXpo/tCI5BBo6fUUR2WgovwZ3pZNvu9dNmVkR4JqkqPpMnIrsB52mFw?=
 =?us-ascii?Q?3TkWJ2SfIQ4xWj7p6wLXJorZ5vqm3GrhNtvmYbnw9izph37tOR3Q49gzKs0Z?=
 =?us-ascii?Q?ZjYj3vm0GrJOP0mZ8IpDToeG2YLtzah58Ltj1Upqh/HSniHK1VapbrrcgGxu?=
 =?us-ascii?Q?vEiBDTxyWfluiyphaMA9FFBKgptEOhKZ7nqvAeovXlYEY3SViGVo2xXB4Ms0?=
 =?us-ascii?Q?ILUV05Bp8bUlkE5HyBKBht0XvByd+3l9H7SE9UpgX1Uxlv2DibrDMuNrLSCw?=
 =?us-ascii?Q?DRBbE2m6Zb0RQWPSDaZujiUgDoSA+pC+ZMxGmiE5xQMDNQ5QOSwWR2OCj7U6?=
 =?us-ascii?Q?07Hl5pansXcvvpEVlETCoroK2NtL0FpgLiYsKIbLqiKUmwIOwoChwG8ACtCi?=
 =?us-ascii?Q?Myg2v5Sczdvi+VZQIBDJn3KKYT5qy/YvltOwGEOmDBquE3aSyGfGTisJ7u8r?=
 =?us-ascii?Q?gBIBmrlgo4fe0WyyLC3J8fKRX0JlycMMgcANG6DBmCqc2fuDlvA2f1IO15nM?=
 =?us-ascii?Q?qpuc3wQhszxa1BYyabATkzZXQlR1R0M8C420P6BslmaPE+PS1MhDOxIU+LcF?=
 =?us-ascii?Q?X4MMdGXgT54mM9KFfuA37dgmjFFfefImU1JpbdKoMInRpywzT1mavZkL5aFQ?=
 =?us-ascii?Q?wvCsaOf2OgzXoHiW5G9TT+bseD/pFg4hmDI2XFmkZLMROcfXsrPZNqiv4sMX?=
 =?us-ascii?Q?iRXTToIMVVQ0grG9QtZp15QW5bhoDNlX8x2wFQ1HkV7XTUC8udO/HnxwUIaL?=
 =?us-ascii?Q?ylpWjHdiOZuGWfAo8L5ffcOOZkYv9MijrLgaMu/aLZUHMq/CpKGHHG1Hc21A?=
 =?us-ascii?Q?jNrze/idQRJ4wW1DkydR7En2qxmzhnIDts9mtaDg4w/YGezopfiVlAegy4o+?=
 =?us-ascii?Q?6eQMUOUBqVQl1JojjLMz8dtoPnjv8qKS9KSxbHeVt1JpSf/Wiibi7HijJ5nJ?=
 =?us-ascii?Q?ZEVqm8eSv0mYvFQWqK0rd0RafHKGvBp5NxqxJwwg/HSVMdrwGUegX/c0y1QE?=
 =?us-ascii?Q?1aOg7ncnaVtPJtXqgbTXRRAXU/ghdLtlo0EFbGeA+nPOTHbvsKRS/y66d6cJ?=
 =?us-ascii?Q?gK/SJORzjtdye27vw7QV5E2OeY3lO5N5wmJMpetsMcy3/KFGIWnrSvR22H6v?=
 =?us-ascii?Q?FJ61oRzYESXgtygl5aODoSoGFbZBmyGpcWaEXLVXMhMFZG8dRHVNozJXfpaq?=
 =?us-ascii?Q?ombsy9dcjKBTToHRiG2ANNUbjpSFMpUCmmmY5WLCAbAymNwR+2UW5VC7nkJd?=
 =?us-ascii?Q?+a15E3uTEaeXVn4U4rXPmXIJkDCsh7+IVa1xIoHLlfM3EWuMUNT6ZEHVFz/q?=
 =?us-ascii?Q?J7FWNtVSLFGqJpmmCl8sbWd4cF0ZLE9HRwjLoA19?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3b3acd-9fab-42bb-f358-08dbd4b7f1e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:37:50.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHc2a0ipHbzuARhBU2ASS7QsJC4EQTV63yZMfLxOruY9+tsAxOFpSZlypQafJmBO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
>  static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>  					    struct iommufd_hw_pagetable *hwpt)
>  {
> -	struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
> +	if (WARN_ON(hwpt->obj.type != IOMMUFD_OBJ_HWPT_PAGING &&
> +		    hwpt->obj.type != IOMMUFD_OBJ_HWPT_NESTED))
> +		return;

This is redundant, we have a C type, no need to check the type field
like this

Jason

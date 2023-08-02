Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9676DBB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 01:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHBXnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 19:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHBXnR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 19:43:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA7530D5;
        Wed,  2 Aug 2023 16:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv2fkEmXdlJ+0xwgo/IJYd2HY7iFBKA7ljDAjz2uaQXPgtX1aQIvr99W/MZMUkFfvkI/9MtIgiqlfzKT7l9xQzqlwYLDEYDA4ORUVJ9XZzYTJkrhRQ9Z1ggpkIPQcEUpKRT7NX8FWVUzAb+Tc9+kc3yBeQvpQn8bf4QI+Gzt6veO+eqwrCkYbY980dV2TjNf7Se4rt3sUkM8+2vWhG8N2etNDoYnBEyWP9nM1biw34p5S5DiCTZlxGnOdDTnDNHgWpnPn2zAJohjc3EKNBcHXDKHdOzWliGYTvmvRqlnkvVzOa7UyLK/VYhpuSMQhkjApx0K0/u6T3TYtwr4svyYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7NQi14uGu+4kOrFHYO8ZPr6czJPctAaFKl/QGHIA48=;
 b=fuRKjvhxR+J+uSaPDlODk4Wj7r4bkzaMMC5+TBcoOeksOwDORNSicZcEt+4lFsLjxxTQBSLdkYn/SSnuJ3yF2m+VUByrdXP5Fv356pMR5lk2SAyXkBeEHOAtk2Kr6Z3WQwCy/wIp6ynlmDdPSQ0hfpE3YSsBpwAVyggf8/CPpB/Xzbei9pAUnV80alAH848yOnkkUblR0RBIfyceKhZ/NHQ+dnV/uapSKSX6wuukbOCr6KzPz+IGrJrJ7jHbgtG6++nypujYTbEmVxjyaXfJ1Ubwq9OxwZOKOLEkVy4jiD0fLIRaqSX8zTe0zhc5dRk3Mu5INzKjX6W5j9mEDCT5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7NQi14uGu+4kOrFHYO8ZPr6czJPctAaFKl/QGHIA48=;
 b=sEkI309sQzzcvc3Ph5kzGqWEJnVQF0cc/BbHBSAXzuO8tDNKixMKYnNtvtL/+Qy6IaNhVFs9slhsFhYm/heH+pqq/wm0p14+hWFvqq86qEbaPcHOjwg8KHGf+kGcOxjYiORv7QQcpl15RxmUW9Lob7fj8m6Ij/ZUFqRyuISYI0nap7qtnUSpdx0isJxRWRn3yvmB/OzM9EqgwXUwo5fq4/ZU2ejPN+D93WOEmj4zGJJ5xHYSF8bQcOhiGhu+SX9SVXF4AqIxALRN9DWwA4nF6vn/6Ab8ignM2c1y4Pp49Y6lC+uQzbfDzC3od0aonZgC/dbrBci+GtO2S8iFdSKRPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 23:43:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 23:43:13 +0000
Date:   Wed, 2 Aug 2023 20:43:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZMrqEAOh82SBvyaq@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
 <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe0IQksFgV6yKTB@nvidia.com>
 <ZMrp0ofsx8M6fT/S@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMrp0ofsx8M6fT/S@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0381.namprd03.prod.outlook.com
 (2603:10b6:408:f7::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dded66e-2252-41f1-6336-08db93b23cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9D17gH1TM6kf/sRkRvhvI6QPCyMfTo6tiN8tOIpDVyVxkHMXgUvZUh66YFEEhEzs+7/EO77G4dk0C+w46KCfBfQ31qfvPu/X9i/ypuoNkQgh5iZIzFvRp1Td72SYJ//JCeBErWfFpIbkDAyvu/DbsJ0vTLONABdXAR6ztJy/KFArcJsC6Kk6azuZT4AgOYMYcH27QUe77wOdWhskuekDZCIqDBSWAmrxYZPx1KhSRNWor2ixmWzqnbI+oMyZrWkOvfDHXGchvqGyjtfNJ2lpQU1wPXhKRhsShfNM3rSwW7cYho+le0kaPjYwH7m4KiMAJk5WBv9vys1d/N7igxJV/Vq1VaqX9FMgaYqNSlrhvew+NHaCutxhqB8gCQc3ljnuYYgbfv5bg3Kw6zWTnmGq83IWzrAb87wU0N0N9wkpOTj/r00aInp6UPf1Z4YR9CWuWY+5EhC0ulDwEob79iliX/qAklbRXKCXsYYvnxDvCCOblGfJ+nQp761lXXWOa1/649RRwRluGjmembLkzA22mtYq4U+omNRRtsRvo71wA90O31/Q9/dtQanc4ppgDeOi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(6862004)(316002)(66946007)(66476007)(66556008)(6636002)(66899021)(4326008)(5660300002)(6506007)(41300700001)(38100700002)(26005)(7416002)(8676002)(8936002)(186003)(6512007)(6486002)(478600001)(2906002)(54906003)(37006003)(36756003)(83380400001)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9wGSt9J1/etbFIyr/Io0ZRZL8bUD7hDOHNH7ZaABW9YVS9Uyum53ClyVUn3?=
 =?us-ascii?Q?YbL4Fq6IVjRaMeSz+DDCqf+Ta+BkCmLULpiSVKuFl2TXPjBmWD8aPgDi/b/U?=
 =?us-ascii?Q?7pTQ3n6tgnUxRKHHjpUG0cDy2RgwvY3VAXqq1HANX6OUouP2THdqYHfeldIL?=
 =?us-ascii?Q?9nauMjgbh2joIERhZMZVNqSjaWDvS164ealbQncHRrtLISpocSdUQTokzBB1?=
 =?us-ascii?Q?31lc1Qv4mo5dfLLwKhcaYnsINPClfLobW50HennhLpoxoQCbSnFeBzC82qbg?=
 =?us-ascii?Q?rdGa5ktckEp+H224PDh48hbIeor8iheLEJb4KEVhuc/Hy6e6nAR3GjvA05SE?=
 =?us-ascii?Q?UyEuUBUM9tJlzxe5EJIG5qy3x1FdcxQEZUmdLy0EoGXQ7/qPunjpyoggyadn?=
 =?us-ascii?Q?3diHA3z1BJgMZEMFeatuCX6LJuKG3xgPy4aLqnrnaQqnR94lLkRDFV3S1avI?=
 =?us-ascii?Q?aSzXB28DLLbG6x1RRxtuc1tmNs1aEN4Hu2Pm2SIXZ1SdAZuuraQCwYU01D65?=
 =?us-ascii?Q?fYbQbBNDSMq78SM83lNtvohkhR1Edxa5kza7GvGnCJE+uHfq9CEkodg9kjay?=
 =?us-ascii?Q?53kQDR5K5huK0Ki1v2NtMyIImlMf2uN67ujEgmSwwfSdGuxbCbEitFRIIO21?=
 =?us-ascii?Q?PNvABD7BT7KYnpMVkN8l7DT0q0KKf25grf4KakRgeVFlsovDrCwQzXxh6wtv?=
 =?us-ascii?Q?P5+/4WJoLuVqiZ1116svfmQWiBB2SLTrUC68adfOgHpe1i0BWw2t060fZh/P?=
 =?us-ascii?Q?y/Mz9czRqdCpyp91ePzv4des5QxjBGGH+9aaaJ/ludy5kLBg00secStyBg64?=
 =?us-ascii?Q?KxiI46X9kQIhTDgLcswjoDTh8DNOnSpvFUadxQpBcGDPe9UBg+8J6EBzlwMN?=
 =?us-ascii?Q?AnC24GpAuPyObZzimt+0ZYvbIgyy2KR2SIvKNj/NZt+1Amlx/2vKpZM+V1/9?=
 =?us-ascii?Q?s0yWVYRlKy0xurKY+mFbp0/UzwK60KwlUySl7STyN+CaL8I+JFX38h6LaaKn?=
 =?us-ascii?Q?Y6ZM2jJlbJRDPLloKnyBeWYPhoVeObQG59qsyOpXa6sbZ/wZLrPya0Q17j/a?=
 =?us-ascii?Q?kxsvae9qhmI3fclS2XSgp0Ez/ANzCIHdT1In9cn92bDwbzxkF7icc0r5PvyS?=
 =?us-ascii?Q?0jlMYl4k4XDCPj5lkpc0YdtI90cFs4eILIsMTl+duM38e7NMGZwdV1V1hy5T?=
 =?us-ascii?Q?zlEy9v+OyRHh/e6Hg/Qq8k8YMoQRryJe22yFF7HAu2TMxf+uJTmeZ5N0trl+?=
 =?us-ascii?Q?6M1B3ovySTBAA3wYSjdtzSTSn8QqMWnFWWWsc+TL4ZZmukGHhdHeIREz95Lu?=
 =?us-ascii?Q?+KM6BLoYnPSWlhzoNZq+0G16apDvYqaBSObHBSezhC6T4hlAN/ARPNOTTLu6?=
 =?us-ascii?Q?W+aT/dgPcgezPh51I4nBKX/+H9h6hYCwNIJfHKpcMai9D0l2NDFwcMewjIoe?=
 =?us-ascii?Q?JRX1eO+3meyzuZQR07zyq+C6Zk9qI/PZjGi/T8qHfqqkHvNJG4QCnyCdNW1R?=
 =?us-ascii?Q?E139WTHXN8SLmEMSccArJ18ntBftuAJF3slZhy+5l54Kzb2O9h8XT2FBHnui?=
 =?us-ascii?Q?dhaS5AI9BcqLEUsPshlmEXPgQqALEpUKGiPYTmWS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dded66e-2252-41f1-6336-08db93b23cbe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:43:13.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQM303Snoi7xWzmzkCJ1ryeCXFgZnI/nVuvSZg+85EyAbGFKYXzidYCfdjlNYIwh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 04:42:10PM -0700, Nicolin Chen wrote:
> On Mon, Jul 31, 2023 at 10:16:17AM -0300, Jason Gunthorpe wrote:
>  
> > > Ideally expanding uAPI structure size should come with new flag bits.
> > 
> > Flags or some kind of 'zero is the same behavior as a smaller struct'
> > scheme.
> > 
> > This patch is doing the zero option:
> > 
> >  	__u32 __reserved;
> > +	__u32 hwpt_type;
> > +	__u32 data_len;
> > +	__aligned_u64 data_uptr;
> >  };
> > 
> > hwpt_type == 0 means default type
> > data_len == 0 means no data
> > data_uptr is ignored (zero is safe)
> > 
> > So there is no need to change it
> 
> TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects a
> -EINVAL error code from "if (ucmd.user_size < op->min_size)" check
> in the iommufd_fops_ioctl(). This has been working when min_size is
> exactly the size of the structure.
> 
> When the size of the structure becomes larger than min_size, i.e.
> the passing size above is larger than min_size, it bypasses that
> min_size sanity and goes down to an ioctl handler with a potential
> risk. And actually, the size range can be [min_size, struct_size),
> making it harder for us to sanitize with the existing code.
> 
> I wonder what's the generic way of sanitizing this case? And, it
> seems that TEST_LENGTH needs some rework to test min_size only?

Yes, it should technically test using offsetof and a matching set of
struct members.

Jason

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2802B76EFE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjHCQsK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjHCQrz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:47:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA31DA;
        Thu,  3 Aug 2023 09:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaIyykD9LTjypAIPFSahqsoNOS83yzHl1ZXRsyBmLWdXFMXzD/PZNNpoWNq7mK5Yoatrznkj88an8kpCpJx7bTrLzb1zlu9XJ7rj+k+PwOCugpRMR+ndrGGb+s/VgRE6wwtlbRlB2E5C/OpQ5WP9iVln+n8TWLovIXnKl2rAmQ/TxlaLZcBIUG6JkObIfvDcEg02tGMpXY8OYqj/3qR3RYAL34YE486v8pIOijZlWIP8n4LZP2tUdhnmgq9G87Wl8Bxsoh8Nlt1oXg5LcX1+8zZ7rIszMztPw680C3b1edQ1a9M9WzulobNN3ALMM3XVadhK50fRR2YpC9n8ZnN3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbcMkhYlFFKFnjE6NwOrolSHJ3TLqk6B+Sx73Ti/FGE=;
 b=NoCgU26bPjw1M/ppZfPj4Jh4qR/VNVpwcNugH80Kygxoig+8o8fwrKNvHBKpHe0cKLbPGVjbtHBQBcG8YJwtZBydv0joyNOg9Y7u7fLOBgIWYaA0UdaOG1iZ2XpDdCEkCzV8wGy5ZcFAzGb0sYk0SKuZW1OixTla02RQqoqClVwMkDMxtqHpRisC6GyZqNvV3Sj4OCXgF4LKynG6qFltlbWIe+O45WqMWPN8p+Cvr9Es8crUZd2yYfA2F9IO0yusJZTje2E15w4W+kA0NSCA8RHPxe2bdAiNWSNuJVepBezBx5VCMAxWHZiKH5EOAOxCV4fErnYXxa2uus82cqm4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbcMkhYlFFKFnjE6NwOrolSHJ3TLqk6B+Sx73Ti/FGE=;
 b=F+bwY/d676+ZN1fzwwLbr6dBXULsRdYqZ8sRGxu+h8COk/19uSkn9+otybT1Sspcv6hvdNJFT7HgT6U5qPdtGkGuhKe4+RRRMoohBn3uAgQ/VszfPoPj5XF99pluXR963ZRGtmT99pVXJpOViKM5U/86adtylTgQUHaXqKI0kcRNr1mpBPFEdQbE0sG473mqytmUKw5vxwgAMTBQXc53ueqZDT1Sr/6nbmVqTUKL0ojnvJIc0Ym0eOXPTJKz3SABV/UbZacoLAfJOVidBR+0cScFdx9JDJIge5CsAnMiM3T+9IqvfpC9nRCN90lSEo2i5iDqnFA24Q+CJqS4mW0zoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 16:47:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 16:47:51 +0000
Date:   Thu, 3 Aug 2023 13:47:50 -0300
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
Message-ID: <ZMvaNqskASX3pGuF@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
 <ZMQBLTm+U+5bgC/Z@nvidia.com>
 <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe0IQksFgV6yKTB@nvidia.com>
 <ZMrp0ofsx8M6fT/S@Asurada-Nvidia>
 <ZMrqEAOh82SBvyaq@nvidia.com>
 <ZMr6lJpRDNZsvSm/@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMr6lJpRDNZsvSm/@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: df503b35-d826-426b-0557-08db94416072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUalJmP4ebQ+lk9npchnSLr+Hem91SwQfivPqt1oTZdm968kEh0XiHMK82i0Xz/WRGjYW0u8E/mNbXvNtXpJWS5ZyNCR5PNXV6p4+vE3Fi8c6tH5dK3OJv/gPtdZKYpd3KmVLGl5pCPJX9hjM3KWl4JQ2rxYYoo+dwiLrJkBQB4Zvfb84HoUVW42jD5V/Tdctzh/kWw/+avRzZDoC32wDDP2p5d/SQ/Gz1pO/vm835aQ59YbjHco7X6UnomW8RWd8ehFqYcQFWfMQmQr6c2IgSKkGUcU1vukV4qT3SwR0+fVh6U2C9doxngyGlIphAx8ZJ41KKe3CG/eHVFyxpIIReJIpblwd14O9maO87v9Vzmg0wpYL8EAD5KTDvW0TXozXOKqyRt5elnSuUTxwc59vDy9R33COVMGwtdBU/zTdgv5V1ZSu2ZyC5P0ecanqcRwk3qE46peOfPyUci7jWASA+HfEMRFSSCgl96L6xwtgud72FSnwmgW1jexQaJSOZIR+pu5IePEasM+/rTT44qP7M9BG5LAg1VIvWBZRmXtlV9x3Ofv/2dJqeJ8AiBnTeSV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(66899021)(41300700001)(38100700002)(6486002)(6512007)(54906003)(6636002)(66556008)(4326008)(66476007)(66946007)(316002)(37006003)(5660300002)(478600001)(26005)(83380400001)(186003)(6506007)(2616005)(6862004)(36756003)(7416002)(8676002)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DTHpaui4knb0rRsxIy/z6ecOJ598EvkqwafbXjUQ9zu7mVCfBNkwdbbNazB4?=
 =?us-ascii?Q?nv6HVp5m3PSKiOffbRKha0d8pnZ9cfjG1Zj73ONt4R1BzSdGDRsUuhP4tD4q?=
 =?us-ascii?Q?ImCUjkEPFCkpxdYVShAruoYN5bl4ODbtLQwPzALDQceaVGwZk5xD7Wi3GOVJ?=
 =?us-ascii?Q?pgchpjBLdYMhTqMcyOl022GwfpsCB8hfqA+BU39smz+LLcVzFaP4LsGPqM5M?=
 =?us-ascii?Q?qjCRHtpNg89kzDZiGBrQrrzwR71KjDtGPrLJ1f7S5eS+bl621CPSvxS4MyXd?=
 =?us-ascii?Q?PAdrVW9VkzSxCkvTbw+Ol5h+tpmlg12YdEf7IETgY0xdsRQmNfrE+IIH9WQj?=
 =?us-ascii?Q?XDhWKpzu8QWa2zxgdQ1xhqUUmTWSMETav8RoVwQQQyqpMs1eXAz9cdij0UTw?=
 =?us-ascii?Q?ZCPd+myg6t/qZ9VLtfZooPZa0FvQ+XgW/sU5nisY2zmKMxBRmuUSOEwJIOlU?=
 =?us-ascii?Q?oEoosJoJclnq2v6nTt/fQyCU8ZCI0SFYMlBwBuVFO8zS02TJW0oOZWL9AOnQ?=
 =?us-ascii?Q?DJzKjHvfRDoKjZ7u9cxG6mDuHL4FXmnLX807ExrTYYs8nqcbYoCIMovHI+3x?=
 =?us-ascii?Q?TINErZyRiE20JJg9tRCpxtzRjJLAoJu3+qA36xmz6DDC394sUqWdW6+X57DB?=
 =?us-ascii?Q?kFNU46QUynrI6/+XoERzd4tSt4zWh9QeDn+o/Ssl7JiIn8y6fetMnFpo9oeX?=
 =?us-ascii?Q?T4etzrqJyWuc6Nd6wOXBf7X1Z1V3TtHmk3u7hdQApBsnixIFVCTkHyZ0mNJP?=
 =?us-ascii?Q?DPo/YWEHsHcdHpb3F7vHZzq8D+NtlKTxPV/pgxh1r0hZVJbqWyfYqnrFcB/x?=
 =?us-ascii?Q?fufPsHaVMuoWFYewIhjtXfobxaoNHJoNjxKEkCFQE8YpmStUJ7r/k0ySEmyE?=
 =?us-ascii?Q?uEbdD3ZcbG+xlcWYGm6ePi8UvZpl3PY2Z/Y1kSrmvVAC1u8uXtEUOI/dW/Yw?=
 =?us-ascii?Q?jLgzIF2Z6pI5xf5YS6JZglMjmyLw0g5n78mmaa97L48qxiHLrYr4dU27SoqN?=
 =?us-ascii?Q?FhH4+Evlh6b3HtQQzn9n+nJ9Ik7Rm7ns+ZHgfRAvDBTB+El2ZEeiuca1QSup?=
 =?us-ascii?Q?WZFAndbg7j/0ZLme3sKmZN4bcmMnPDyzTurzgXD52noXZUPk5LWStRvx1dLR?=
 =?us-ascii?Q?QeNiHLWyHAfh8jAPEV4i5POyMJLsrOoF8roK5SRlEkBYv2CmuK9qyNfd+gGr?=
 =?us-ascii?Q?Kfv6tUaFPgwMyS2r5xv0CXqV5SjFW4+cFaUxGwpYx4wXYojPbDPEqJOv0a6i?=
 =?us-ascii?Q?yXlmBKDN7zl/fdNCIaWmP+AakGVjzB9iKdr0EA+QGbFFSBLCfwvF92u7YF2D?=
 =?us-ascii?Q?bR/OHtoaSLYPF4QR5N4BSnt2XNaWSvO5SSc28lHaqfTtT9mrAcTyEtIekldo?=
 =?us-ascii?Q?afsSyAGL7vZtcWonxEFYXf0wQ2XYoUaToN7wPPsxdYw0mVL9Ub8Oyf/HA5PW?=
 =?us-ascii?Q?jU+iGhSOdrdMGO+3iGHTWu9d2vdSTOZL4J2mmR6N9cauHSCCptIAVt1LqfZk?=
 =?us-ascii?Q?spFQVzz0On6exBH59KJ+/c9ht1+TqrQHAwToRUCMIUdqWOHsawee4dX+eie1?=
 =?us-ascii?Q?jNHwKvGO5Zm5sJmbqeGtRS4Evrqt8hxTvXfKqGVj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df503b35-d826-426b-0557-08db94416072
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:47:51.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7SVeXPeNbWwSbuPVrG6WNUExWltMrZ2ForHzysisk4GnJVNr7uWy1lgt3Jx4ABK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 02, 2023 at 05:53:40PM -0700, Nicolin Chen wrote:
> On Wed, Aug 02, 2023 at 08:43:12PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 02, 2023 at 04:42:10PM -0700, Nicolin Chen wrote:
> > > On Mon, Jul 31, 2023 at 10:16:17AM -0300, Jason Gunthorpe wrote:
> > >  
> > > > > Ideally expanding uAPI structure size should come with new flag bits.
> > > > 
> > > > Flags or some kind of 'zero is the same behavior as a smaller struct'
> > > > scheme.
> > > > 
> > > > This patch is doing the zero option:
> > > > 
> > > >  	__u32 __reserved;
> > > > +	__u32 hwpt_type;
> > > > +	__u32 data_len;
> > > > +	__aligned_u64 data_uptr;
> > > >  };
> > > > 
> > > > hwpt_type == 0 means default type
> > > > data_len == 0 means no data
> > > > data_uptr is ignored (zero is safe)
> > > > 
> > > > So there is no need to change it
> > > 
> > > TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects a
> > > -EINVAL error code from "if (ucmd.user_size < op->min_size)" check
> > > in the iommufd_fops_ioctl(). This has been working when min_size is
> > > exactly the size of the structure.
> > > 
> > > When the size of the structure becomes larger than min_size, i.e.
> > > the passing size above is larger than min_size, it bypasses that
> > > min_size sanity and goes down to an ioctl handler with a potential
> > > risk. And actually, the size range can be [min_size, struct_size),
> > > making it harder for us to sanitize with the existing code.
> > > 
> > > I wonder what's the generic way of sanitizing this case? And, it
> > > seems that TEST_LENGTH needs some rework to test min_size only?
> > 
> > Yes, it should technically test using offsetof and a matching set of
> > struct members.
> 
> OK. I copied 3 lines for offsetofend from the kernel and did this:
> --------------------------------------------------------------------------
> diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
> index 6b075a68b928..a15a475c1243 100644
> --- a/tools/testing/selftests/iommu/iommufd.c
> +++ b/tools/testing/selftests/iommu/iommufd.c
> @@ -86,12 +86,13 @@ TEST_F(iommufd, cmd_fail)
> 
>  TEST_F(iommufd, cmd_length)
>  {
> -#define TEST_LENGTH(_struct, _ioctl)                                     \
> +#define TEST_LENGTH(_struct, _ioctl, _last)                              \
>         {                                                                \
> +               size_t min_size = offsetofend(struct _struct, _last);    \
>                 struct {                                                 \
>                         struct _struct cmd;                              \
>                         uint8_t extra;                                   \
> -               } cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
> +               } cmd = { .cmd = { .size = min_size - 1 },               \
>                           .extra = UINT8_MAX };                          \
>                 int old_errno;                                           \
>                 int rc;                                                  \
> --------------------------------------------------------------------------
> 
> Any misaligned size within the range of [min_size, struct_size) still
> doesn't have a coverage though. Is this something that we have to let
> it fail with a potential risk?

It looks about right, I didn't try to test all the permutations, it
could be done but I'm not sure it has value.

Jason

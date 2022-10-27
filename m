Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BEB60F653
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiJ0Lhx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 07:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiJ0Lhs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 07:37:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0385E8A92;
        Thu, 27 Oct 2022 04:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlGsgfkNiyDXSIkTrdIu93qBC5gK4NVGrcgL3f4lTrrQ3aAeYoiZPS0JfA5WYOo5veEXXOYiOZ7nQC7cuACHBRMZYFlve/MTA6vNW+Oznl+Hfg0LFoozZKzpEvWPDv1vn+D/Z250Aa4TlgsLlHpBX/0GiDbrZE/Qs30Ms2ecTp14DwWgTHcX6VLjzAyGRGyZEBn95Zi/t/06xSNCtWqVaorWt6etMkzzfzKZo7RPdHwKYAC1G6h09xX9xBZUEeGCDUg7WUd8uoS4iSc4cUGArQjYBhEgmeSSwRiEYgVsZsYdHqwutn1TOdrXN6YxJ5y0W+KKRTKrDk7nmMsifZH4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgJKFB5pGB+X/sHCfppLsTIrbT+ZsWsd8O+nLreUCzk=;
 b=UqWgoLAftWidu1w8ywerWR4TZWnOrfqiabdiOImvJ+2XNfSZju+ROGeSewiznDZC8mwmhg0+ntqQEQXjuKhTSTms4htTDe+bYSsUWNB+ti/ilisTstruFbGuJkbSLRRDtW6AE+YMfdgLN6JjW0wpmtqIDCerk4AuU5fxWoyCMi1oSyS1f2AZqsXR/LJakhSgQwWuWgBkIcYMTexAJTgLEpmwFyIYNx5qXEVEgkWfSJIRnElEuC70n7cbLTA7je6L6O/wXdRc0rZ1u5gNA5LVe6WcslWn4s9BOilFjPzZwud8EbQndk2Ws43J0FnrzdsnV+jJ9v/tYoLs/6XmZ0FyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgJKFB5pGB+X/sHCfppLsTIrbT+ZsWsd8O+nLreUCzk=;
 b=PJrN5pOeJ3IkS0b1kjyePlA717Ibg+riK1I60XZBZF7XI7OLgQJaMp+DbBPEoMDa7YWg3Nr7TjKzMar5adpzIyPqJrIiZaI9UeyHnRkycah9yA8vs/Tjzvfn8mbs/TBLfeLOglOXM7/P7r6MX1jC/LUa8ixzoKLRQvYae/PZ6kPC/X7I6eFhNGoGL+7YMc9e+xQXbEKg+p5fjH4fJzdulL9S4xiGh6h4U+OKbhW78gmY0SRX08xUHfyvP9sJkq4v9Yi+HeEBT759uuETezRIKRs68OhP5+Vb/rRPX25X+Qa6HjoM1ayhU2lU4bLy9e9P5mfi61SUVgyQYZs4lAdnkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 11:37:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 11:37:45 +0000
Date:   Thu, 27 Oct 2022 08:37:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 9/15] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y1ptiMxTfslWZBW2@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0058.namprd20.prod.outlook.com
 (2603:10b6:208:235::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 9019e03e-f3ad-487e-7bc6-08dab80faaab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgBe0JPlksVhx2irXRgynvfiK42qVp4YJUyaiq+tSnR056M1P1ADmtQRWtG+tFdLguwJLmBszluLdECHnDe7sF8ja4JEkt80eGD9NWF7sblaTkRzy29LxxMfyvXjzYfX0Mni1nMAAbFDGIDIL5lcouC256qqbALWIW1DytBA69++R79EDz1vkAMRrKPuErblAJC7Z4Tjg4tYgtjJ5NsiP0AHg4D6wNJ6AlHOswe4PNaF5KWFln8j5DCtody29hTPSWPM92BIfSnW13yM73bw6e8wfoYIzI1QP7RgkaWoAO2NHdGhsXVwuAmwGfVI59HC2fvklWvOJVLRxaoe4Pa2vlnerDciOVnE0Xg4pIAgpLj+5VZQisoTw34oQY9xkjyu7OJDoqQ2qt/kY5pgceScIn4WplCIwvlHcihP6ChnS6WmrecMKaICC87zJ16ZjbmnT3BUwP9/cBiTSmMln0AFqIeTIfKkAOP3uOux1J56T499yMb65xHsrxWQ98KxD2EUFffXzkV+j8enaIS9LGxmuJrBvkRFDjS2kpvkoGB1AXMIIdHxB+l1hLyFF7uBrOfyewvU1q9UOg1tgBsLY5jyMCXQI0th4JsQ4NzNoWY37+6nVV8va0xPmMkrA8eqaGdCyzwx6Rg5NkfgSqfYHRl31+8H625gdjGvO9cFZfakQ4ewuQR7dlyLD2IX22QlO/LRXVS3fYEWNfCUl9jugHhxaVRSxypzGB8Vkwb0VDgaYptqnyhpoiOKavZyS1BCfDHk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(66899015)(54906003)(478600001)(8936002)(5660300002)(83380400001)(921005)(8676002)(4326008)(38100700002)(2906002)(110136005)(7416002)(66556008)(36756003)(7406005)(6486002)(66476007)(66946007)(41300700001)(6512007)(2616005)(316002)(186003)(86362001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZRnTxBspg9yByjHNbhCNSCcIBpe7GREWanwM1zidoRbLHojqxspTKHZM0LcQ?=
 =?us-ascii?Q?Ar1J9+M2QnksNmLxNsTS7f4OEg7T0RbPcz4cQr8xXouEczwvmfv5fyZ/9OYT?=
 =?us-ascii?Q?+gB2N2hlomIQgv/oUbszQpivVxmr9N+vo4MAA41kUWBpRQ/AWzK8OLZbFz//?=
 =?us-ascii?Q?73U+gFCFLD8xnn+QVyBKhsGnvT7uYdRwLToR4oy6prY6i5Nne9sIi6XamEEn?=
 =?us-ascii?Q?dAoOp+RaiY6+//IH7nscwgBatH5Ed2djtuq5GqDj5Uv4v3CkYCifArO367Kc?=
 =?us-ascii?Q?PMtbU1TkheZK9kVF7UtdG/CUowEmYUBigz+WPOGNImcwG5Kf6aVta1AA+84L?=
 =?us-ascii?Q?bhPL8QqjdYsqudoqqRYqUbJMGnOY0mFIP5ZIkIxqS3W7ALsKnVKMXrm+xoOt?=
 =?us-ascii?Q?7UgdI+yYC034YVCQ8ddf0Qn8/S9EkdC7FN3TFce9CDhXVRMumehdY5FHzlJ5?=
 =?us-ascii?Q?Zh+LvLnZmm9EQdbeQFabr/d5bF2nwpQGiGr6blgZJljT/zZufM2dfV/GVXcQ?=
 =?us-ascii?Q?D8c4i5mLeajA6Ai4AQVwSkKRM+A+szpeHfG1uZYOCPNAccbNkHt0iHwVNzM/?=
 =?us-ascii?Q?qC+WcYSlwIvg58Uml0djWAIojdP97JKh2DKs7/nfAIniWUom5uGMxQxls9G5?=
 =?us-ascii?Q?+lvcFeM+XcAsBQIzMHVMYE/RsflfU0eyUAF22C3/Gi8BVD3kBbEKdb8n6fLx?=
 =?us-ascii?Q?3PqYF9cuenOCvDnR9ue3z4Zm1ZU2ni4pI1bOAaV/wj231Mq9skqH0iRtA8GK?=
 =?us-ascii?Q?wcyaGjWbHl6XBqRdwT3hGKVntx1j1lL+GzyT6g6IzbYqT439f76Z/LVlw/z8?=
 =?us-ascii?Q?kxq8I2GbftvQxZAeCPe+sCOxkj+QYVgY39l4ZB7Cem37B1f986fbICTrJcsG?=
 =?us-ascii?Q?05RamT57r+oSljX0cF20dsN2OE3qlJhZv4tR4F+XbxWk238gbfWy7QNPifAz?=
 =?us-ascii?Q?GyQV8Uw1atXHtf44GgOvVW/jmD3ZZO1c/3YnfkrejIcnkXg7+TOemPXE7Lr2?=
 =?us-ascii?Q?VJI8GCtMKeadWpupp0R3RKxT4ISqCmrECdqejp/jkHI5GCTCvAmDZg5bgKxN?=
 =?us-ascii?Q?WarncN3HfuWHSr/2N73RKMdF38QXTmkRvseC0eDJna4maBwjJ6OkEj2ZOjng?=
 =?us-ascii?Q?iDy57r/o69U+yivED5/DAGoiIMANrdQuvn7hRjEl2EBPi33Pdy7xjmd2Dopl?=
 =?us-ascii?Q?a8m9EV3iSm8vRkuvf0c07lTuC8r+gc36dnlocPkXVxPbE0Pp4Fn+DyjYEdh0?=
 =?us-ascii?Q?6hkls0Ki2hyTW5oyLq8XdQKrLny1XiND2n7oZDJCTQiilv9+8G8aKd9HSNH7?=
 =?us-ascii?Q?ig8RQJ4GZ8QXxbV45l1ayLs3pRb/HEQrHe9nV5nmuXfUBx6lxMU8cOIYJrJ6?=
 =?us-ascii?Q?sUwv2DT9lJ+0899lFBidpa9+vguTCjKMASN1EsZId7RBNtP/pAw4PAKlJQ5L?=
 =?us-ascii?Q?vOuiMbcgGYUS+NdFP5ll9i7578nA+GU7zlu73ufhjIROmvSyQudcy7x/O8Bh?=
 =?us-ascii?Q?Zvu7v/fxXZVS85yFsHU7hUzkVv8SDW/dW4Q/F3V8KGMj0NJ2CbFSvRjo860p?=
 =?us-ascii?Q?A9Ef33jPjJBfG1Wo7yU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9019e03e-f3ad-487e-7bc6-08dab80faaab
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 11:37:45.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF07YGSkNedPk0j27Hj5NhkXJxuS7Q2Na7Sd8isu4s5Gav2tV9gt9/rHypNKAxGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:18PM -0300, Jason Gunthorpe wrote:

> +static int iopt_check_iova(struct io_pagetable *iopt, unsigned long iova,
> +			   unsigned long length)
> +{
> +	unsigned long last;
> +
> +	lockdep_assert_held(&iopt->iova_rwsem);
> +
> +	if ((iova & (iopt->iova_alignment - 1)) ||
> +	    (length & (iopt->iova_alignment - 1)) || !length)
> +		return -EINVAL;

syzkaller noticed this length check is too late, if userpsace
supplies an invalid length and asks for automatic IOVA allocation 
it will trigger a WARN_ON.

@@ -177,8 +177,7 @@ static int iopt_check_iova(struct io_pagetable *iopt, unsigned long iova,
 
        lockdep_assert_held(&iopt->iova_rwsem);
 
-       if ((iova & (iopt->iova_alignment - 1)) ||
-           (length & (iopt->iova_alignment - 1)) || !length)
+       if ((iova & (iopt->iova_alignment - 1)))
                return -EINVAL;
 
        if (check_add_overflow(iova, length - 1, &last))
@@ -248,6 +247,11 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
        }
 
        down_write(&iopt->iova_rwsem);
+       if ((length & (iopt->iova_alignment - 1)) || !length) {
+               rc = -EINVAL;
+               goto out_unlock;
+       }
+
        if (flags & IOPT_ALLOC_IOVA) {
                /* Use the first entry to guess the ideal IOVA alignment */
                elm = list_first_entry(pages_list, struct iopt_pages_list,

And a test to cover it

Jason

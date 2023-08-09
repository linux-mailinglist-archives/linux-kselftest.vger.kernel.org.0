Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7877686C
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 21:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjHITTQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 15:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjHITTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 15:19:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B472D61;
        Wed,  9 Aug 2023 12:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMy9SlgSP2mZvUdaWF0WX9xgAk31M5opqcYHx89yhXZF0qKjehznK+7Ffh9ZykmBrHValdhazPMJttpDBCMP/VXPdSg/olccxbqvQAgrZ+3u0RvCYF1omewibs8wEYAznf1Pba4CYoeUn8ymFfQgvGvjUsrZzWnBluBCT//9ls+PFmpwa2Y00y+4CIfQuBZshzKaGdFIRzQ/tk0vZVg98F0h/7AGzEuaqnwbGtNAAmpLr539teh5CJwnqiPQJxhlZsIJx158JroLmVLEROuxIetyUjEKBM+4l4P9Hz1ZoyBaR+pdOul1+Huk09mzXGTdtJVdgWZapi+X/gnWKWL/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6w8XWvkuar4JM2wbmRfY8ft3B8nyqL1F1pbp2MPsy0=;
 b=Ntwfik1/FyQHZc7elXB6EJjGIGL3+iJ075Jc/qjoNOBqhtzukDCY4sq98ZgfRHmYDSNtOtiVL1SLBDEeQoKNnID7O3Pqg9Q76rMCpEtyi7rOu9LR5W9knq4Q2IaZJVW0wTCeQHWG4K8jE6qeALKmxmeozaVYTAuu/xKCGNhoeJqWDhTC4VDnhBzX/f6o/TeJJto+dW3A1lfwJNnZLcQ0IAH0Wdx1XhDbia+YEXzYWfaryP+gg+5T7XMppq7nuJL2CHWJZLDui0Z+GZ4C6FrcDt0uUzOey8jwev4VdNU2VonTO9b+m+o/ZJYM+G4v0lj/+F8fzsD5vizxTiZWgSVY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6w8XWvkuar4JM2wbmRfY8ft3B8nyqL1F1pbp2MPsy0=;
 b=KMa3ymiQgcOfFOQRYTtOtPEjd3AqfKgazCRLfcXKCqkMWm1/qsJKNWxYwaPOY7JRD/ivR/8sTvdL2eEDwxaFCnWWra5d6SYn1XXnFXqsGRqGbGyHErPcg/3xEmtdo8NKownchOjwEyUfdR1bGh71dC3CSVJ/igbPHKlPL1PH/id7e+PYS5x4qd/xfZp+o3xvhL40ZN5s3SeX7WWvRoWbrOq+pR5U+gn6ewCip52L3jj0UEe3oFdcBqXhnxHLn8zLV3di6XSmx0V7r7nmm9pjOZeUNdsH7/1lE5jfh6+KhWww8cM36sT5kjpp3HzCI9faraRedoTP5FLMoPAy+dfg8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Wed, 9 Aug 2023 19:19:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 19:19:04 +0000
Date:   Wed, 9 Aug 2023 16:19:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNPmpW3/zDnjqxyU@nvidia.com>
References: <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia>
 <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNPlGd4/72dahSs4@Asurada-Nvidia>
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 390e6b22-6727-4404-126d-08db990d7e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prRfTzPdik0I1m5z9knsGSKm1EmwFsJlyhQ2FjZrtIxTp4M0csJIR9bhNxQo4Ez0Z7WafgkHmDA4s1+s7jISRYJhy9LkY9r3YL0dzBvkySgJ6y1Ry8RKv0xpAMrFfWw3NRxMXGLdEANVnp3GubkwQqgmYPoBnj4XE+AvSDUHc3UCLx0ivphlZtXrhpwpaa2X3pR2uCUnXlXHAXAFUyEEzYY/8agOC9zFu8S/9+u4ozFRzKOPdnBbu6+8mg8dNyZUanMfWqba8YgcCLo8xDbOU7ogNbmf6NavTMyq3TK0uK7tTFLxiRb5ALb1i8zbo+9WNGDAzaJ0GvzchGpztn5yRl0FxskzlxO1CNc4sy4VmAdPQT0TrXpSDknKDU5kHd6ZWsm14Y4URXptL27T1iyoUFYoBVxmbhGvcbE8HEksSQtSzLJKSR7vLyQsl/lbUKhbOviB3ngFXQNgpFwLnH7l7FGp6TmPO5KXc6VSvhGJvqG8YB/c+Z6dkdCzPL4x8PRr2vQBrcVvdtJWDtgaZVCXU+2dPzuRr4EXjCWvkpw2umR40mjLZkB1lLmsNGDgNAWE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(186006)(1800799006)(478600001)(6512007)(6666004)(6486002)(37006003)(54906003)(6506007)(26005)(2906002)(4326008)(6636002)(316002)(41300700001)(66946007)(66556008)(66476007)(8676002)(7416002)(6862004)(8936002)(5660300002)(38100700002)(36756003)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5CZZrs0OcKD4bPVZwxVvhcepMsvVRxW+XLXVszVvZCvu0WccNXx1rLvvBDn6?=
 =?us-ascii?Q?VFeqRLrimJKkgVxWTFIT2/0kOwjzBl2RWU8UqUIEEtjrCghoMPk8367ycf6/?=
 =?us-ascii?Q?Oc3R5ER40ywb7HlxL3JdN9ee7ikHr4Fyy30W/WMVu3mi+H4+GcSYdQwDyUHB?=
 =?us-ascii?Q?kzhuIAN7AXoo+k3RVH9bqtqWFPUIt8xphCmTYZnlyyGw2V/7NSf5pgMzcp7j?=
 =?us-ascii?Q?35szILiefEz+fOeuhL3RW95CPmEnh3z2bD9tnQIpYwPdmONIleUDkhqtpKtQ?=
 =?us-ascii?Q?Qqtqbtldhld849nLE9qFZSTqj2haqPM86J6YQ9Jd+cVGCSAC9MNHrWOai8dp?=
 =?us-ascii?Q?dOXIhBCnbYgI03nnddpjjEEZ4cQIdx5+aex4Qlz0luEXOBGxmV6VG5Lno4S9?=
 =?us-ascii?Q?lByUJvWKt2eSpHGgJKx2t3cb3VS+pm0MqJa+nSdwbNxJcXk03LrtV5H9sYil?=
 =?us-ascii?Q?wpaZOTFQ7Jj7mDY2dz6N5/xbfOq5jCrMBfotWrE0KloRFd//pwqXczymkKqf?=
 =?us-ascii?Q?pVsZz2wJya3/oFaWJUSWD47z6xQe7kOBVtHOeRyIqGhnOuvw8wDLc4Bsy9oy?=
 =?us-ascii?Q?JV2s/hf4LADIoKdHz8i5HoeeMtEF3CVnbuCtBCXWygMcQNLdPd5WCEiOHqHn?=
 =?us-ascii?Q?IjvfmOWFIaHMoQhhw5FmgZYHNunengy/92NuQneDVZdW1V8iS4rIQNRgHA2X?=
 =?us-ascii?Q?kttNQTYDZLcC5GiAogpRoMKWK3PmzVDeLnwuJReZYjSoJfzyhaNPdY7q8bSA?=
 =?us-ascii?Q?0qaJHga+I0kERFAi8ZUtBtYiTk+Z8FsQwAclmV8NCpIx2KSSLKqlfzoDH7cc?=
 =?us-ascii?Q?HyV0mPLlDZoJttbWi6dbgrPrl6GYDTOokkQL2JMz1M5arhi7K/CB8mPKygo1?=
 =?us-ascii?Q?sgCLTspMczP5wqUlZaJhhmeV9O+jPL8F4QJlWHF2C+mNHTPCso52WbNpKzv2?=
 =?us-ascii?Q?Y/rpYEXX98ioHR+6LNZjlfRp73eFSNP/XijtgBd2nIA1Ofz5IF+rtbJP3f91?=
 =?us-ascii?Q?oVvf8JSyaKZh4WsV7GrrH/J2NYi2PUqaGq0LEwml/YTxAzm037igEWOUdWG7?=
 =?us-ascii?Q?F+40s5V6X3ZudWwyoOgaxLf0xSINdr1WjfPW/Z1KT/E8/9OPDcknd8YH3hS+?=
 =?us-ascii?Q?cvYJYHJSyTv0cNAg84/Q7c0BD04uXqFMgIWqxq+XhpcfpIm+QKMAgsEzTnUG?=
 =?us-ascii?Q?IAInUbBHMVu71CkHqrk0m8hw8htSmVjMKExK0Fo8pwLwY4EHmHPLddpw9+YO?=
 =?us-ascii?Q?/X+N6TgV6Fd6oq7i9xWhqT5C4z+XW+MspSpn26KCXY+4oriOpIfXVRSL4HGu?=
 =?us-ascii?Q?zvE/UWD2Q4sndNK/TCoc/0sdhvuTcJxqHD5O8bexu6Zxm0X8oH4yDPUJyX+g?=
 =?us-ascii?Q?4vwV5xUeLqfHOl/oOBsTO1/Y0MpcoUa44hwJ9q6oNdKaVgPmc9D8iLJ3RIwL?=
 =?us-ascii?Q?TLcTrNTbzZHlc1V/LanX+jLkqPnhSkuQizkXtd/aBrs+/+jVnrRJsYznJhIq?=
 =?us-ascii?Q?9MXq/x/nqde63bUKizJXraAZ1QgyxDoZe7jMAvdO+Nbt29U3qm4ngsVCHg6I?=
 =?us-ascii?Q?L9/Fwm8/PrkkX18fnFbpLUQHippj+2JzJVnhstZE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e6b22-6727-4404-126d-08db990d7e97
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:19:04.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twyotecieRmdo7BfTXUR3i1dN+8SNv/F0RPhvAOxV1q9BppGU+UPEehoR8nFruF4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 12:12:25PM -0700, Nicolin Chen wrote:
> On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 09, 2023 at 09:30:12AM +0000, Liu, Yi L wrote:
> > 
> > > Yeah, adding new structures to ucmd_buffer may increase the size as
> > > well if the new one is larger. While for an array, if there is new entry,
> > > it is for sure to increase the size. I remember there is one tricky thing
> > > when handling the selftest type. E.g. it is defined as 0xbadbeef, if using
> > > it to index array, it would expire. So we have some special handling on
> > > it. If defining the things in iommu_ops, it is simpler. Selftest may be
> > > not so critical to determining the direction though.
> > 
> > Maybe we are trying too hard to make it "easy" on the driver.
> > 
> > Can't we just have the driver invoke some:
> > 
> > driver_iommufd_invalidate_op(??? *opaque)
> > {
> > 	struct driver_base_struct args;
> > 
> >         rc = iommufd_get_args(opaque, &args, sizeof(args),
> > 	     offsetof(args, last));
> 
> OK. So, IIUIC, the opaque should be:
> 
> struct iommu_user_data {
> 	void __user *data_uptr;
> 	size_t data_len;
> }user_data;
> 
> And core does basic sanity of data_uptr != NULL and data_len !=0
> before passing this to driver, and then do a full sanity during
> the iommufd_get_args (or iommufd_get_user_data?) call.

Don't even need to check datA_uptr and data_len, the helper should
check the size and null is caught by copy from user
 
> > Similarly for managing the array of invalidation commands.
> 
> You mean an embedded uptr inside a driver user data struct right?
> Sure, that should go through the new helper too.

If we are committed that all drivers have to process an array then put
the array in the top level struct and pass it in the same user_data
struct and use another helper to allow the driver to iterate through
it.

Jason

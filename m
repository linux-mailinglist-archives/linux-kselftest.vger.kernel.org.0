Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC5561A10B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKDTcb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDTca (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:32:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37EBA47A;
        Fri,  4 Nov 2022 12:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5vNn8KH0pNC6V4eCODt693dHM5Q2YNkqj5hr7LgKzFAcqnJnSkSzWKuLA+H8aKuGa1+IgD8yq0/PXnDY+dLF170K8LW4zsL+RLNx9/dncrVrD9iKITxqDZbskHGf8iov6lvgRIb0IBm1uTturRKFqYjD8ceJBmEDabt14YPxLFzpDIEQmuFR54K5LmLsuBGr7YIZWPzgX9vwO/Ky2WrvCqXdoRDtx+Y4zZ8rw8K17gBvM2utYfoBpCe/zfaFf+Mx0heOzyt7Ipfb8KAOiwxcs3pD67HSSQxe3z2l/6ze+uUWBmQe5x1IvOBudBP3Jv42gx/yPkLS6BwGEZPxWR3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WyYvL3eajgyYS0mEj8NsMRDpRCy4img3LPhRwsvxTc=;
 b=g4r25m2qHf9lh5B80i8+0/SpCk/FuMh77PUvZTuHh9uQnpt/KPv7qW3s/DQVYChm5/8ZoLbIKy9fv11YsJ9TSIFfyRyXdsYsm2qM17AmKzUb7RLOekFUgJaqSYT1KN0R6LzGVCap38BthX7F6oMIf7/A8xd0HqEKTqgjB/Ub+JsBomOhUKDESnsmgjHGloRxzaTwQv/ToN0e/BG4JwuCf7hYxOLiFTf1f1nocCv2biMHXe0Xsql/e4q76rQR2mi+1CxA8Ogl2LB7b9Lt5DaZtgx1gjXosuhVm4Jtk05q8MrnP6se+8djfZ+ilTutJ5ynoCWxPmbYIJDpiiQPeM4+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WyYvL3eajgyYS0mEj8NsMRDpRCy4img3LPhRwsvxTc=;
 b=Kmff/2GAfhF3q9bT0U6xsqhLBS+Cu9CXgBX6vHsw1Qjzyh0iFrxJIh+ATIS0ZTdV3/onpQXQj6Ji98VwiQyj1N1PoeNO7e8YhqfW7TVKoSVzo9L7YoO7u1FYlVORRlexbi4C1QFO1/dP9qlC68R9baOBWs6OS/A6TPIvKdL9wTUPd5o6fhK8bYX7ZQM+hex2igUuR3ka13jQ+yMmNOXU29x3byWSmkP5QfUMh47YhZWKjI3OQXNamuacZqf6Y5TSC7nxGImQlTPnQIcUI+fUicZuZCoLghl5gut51m6cDEdMB6JUleZO0XoCTDk/DjB+qzh6Wk/aH12+ANjSIwrM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 19:32:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 19:32:24 +0000
Date:   Fri, 4 Nov 2022 16:32:22 -0300
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
Subject: Re: [PATCH v3 02/15] iommu: Add device-centric DMA ownership
 interfaces
Message-ID: <Y2VoxvogiyO/ua/a@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <2-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52762C2E65492270AE58FE268C389@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762C2E65492270AE58FE268C389@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0434.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d8248c-f38d-4db6-e01b-08dabe9b4c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfBc1yZ5EeW6S5avsuecpvK7UU0EHNYjZ02aesvRyuP3AsAZJeq4cCnr555ElpU9tGDn/vs8pCkV3pze0w0WbWLk6JMqrGHdb6ev4vr5J58F0qrg+nYTn8RmP6oszZHPN1EtVSRd6F8jx1jgGUVf80Kkvb34yzCzmEriDVBAYSMQEY6z0r6wQbMUJ/vu9USI1A8exWY+HGnhvpPTzrPhpB7wzofrNLibiPAPWiPo2hTOqqqXHSWbAF0nFK+4TmHcYopwPPTTyMD0XpnZTNcoMqtVH44W4re+qBSwMSR4xBz5DIdTseBzRQDrFcepNQskiLcXpE2vbOtgwt4dEcs7wL3w1Zlax0jRstJAq/lJygV5+Ol1AHLiewAQEckr6HULZAwTR+RW5eW0oQ4giUU5UM6FdFH+b4Vv9bb8iMJM8uIUoSK7BnxtzKwIdTGVmqWd3gLz5x+Vd7SLhdO0DBXxZ1qBFvszckyMpBldcNDwRb6ZIK3XLV6S0Ke11PwF+TP8yCCBNi9j9iuOiPBSVza0oZRgFfkZf/W4kM9vA/dp0xZl0Dp1O5oWb7Hwk8NyMbIFEfHMx1Aq4gdsavtDCA8GOiXWXIFQ6pQYW71RS2OBZz9dkdeqU1rnVD2GkWxnzQ6y9fRrmBGD6o9E2laGNm+jHsKeXCfiN3sloyuQswmFjOQ6McHbl7nQQy/bPTtFmyeSt49Fr6dISzsR5OyxK+obIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(66476007)(316002)(8676002)(66946007)(4326008)(66556008)(54906003)(6916009)(5660300002)(2906002)(41300700001)(8936002)(7406005)(7416002)(83380400001)(478600001)(2616005)(6506007)(38100700002)(26005)(6512007)(186003)(6486002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IHj52PGxX3nEZ3ygUcijMl5llEwU49cwAI4wTV1qiAmDUJBSPq9gwa6Ry7G?=
 =?us-ascii?Q?CsFigG4U3B4LcQLdsFHrmr1zAzxQ/fXgVQAkkrqFDfrKBmA2ROnbTnPxAddZ?=
 =?us-ascii?Q?D4FSBYGBktpaiR/RbEEAJzFW2jEd9JBEyYU6MHZBRrlZPvLIdGy9NdprNwaW?=
 =?us-ascii?Q?MEMpoSbylSS+mitWHNbqI8dSDdnumRpROaByjSfgwXSxc5m9evXcm8jnR8EG?=
 =?us-ascii?Q?owrli7NEtSPUl0IcqFQY+rWPaCkUPiIRwirO49NBqcF13gVd0gjhQtbQlNlK?=
 =?us-ascii?Q?Xpy+8YF4jXHobr52cTxUJpQTcPULMNVjHZ0P7wmSbAL0Mt3z59pNGNWG2NAZ?=
 =?us-ascii?Q?4a9LdrK5tBI5Lqc1yc6xo9OJ7dnQjQf7oSNPvOo90eJtviBUjXMREHrq6eyD?=
 =?us-ascii?Q?yn9L7j38d8jtpg75K8stwyqPrML+ccOZWyGqRPhl2AJdO+l186UytXfW1iAC?=
 =?us-ascii?Q?rMojIgXv+jc3lwDircGvn9nOU3zsyri0qXmNA93dHuO4Zvliqiq69iZrbPhv?=
 =?us-ascii?Q?iYuxjwJ7gi84uv+NHzEtRx04ar1TRQDEoG8y+m8IETVtmz+o5JMSu8M+2Bxu?=
 =?us-ascii?Q?b4ej0fdb1iX79iRAeCCRCBtN/PtwqZrQjwzz+6f0m7dlkkHXVticbboC+/C4?=
 =?us-ascii?Q?EuIanN9z8CsazVnrdrcEHxi6h+kpjhRIA7ypB+nKDpOnOJUHTd6P2DjN7s/3?=
 =?us-ascii?Q?PbKp3oSmSkYmjC/VGE4sy1SsDmNLKMIY+oyjmJ1LHmfewTW/DlAHhhXQlLC2?=
 =?us-ascii?Q?Q1eVcSmMpfTGi6uBZ2R3np+SCUlXHegnNyfFmDYyylrEbfliN7W65GqlCRTC?=
 =?us-ascii?Q?QALZ2B8aROx+UHZ8XVx2RKrfPsWKkXnnWPgHL4zrUPmE64EgUWiNnqsjWpiS?=
 =?us-ascii?Q?IwlJ3SSCG5KHtU/pVhEkwqIHEggHRc6Bb/S1qetnhu6avZRYueP/l25FcPZt?=
 =?us-ascii?Q?oiBERzHr3UBQ/zmqIOvYm3u/36KKSxr9TBU7WdAEyIVoTcWmsfoLs4Q1Ye6Q?=
 =?us-ascii?Q?NoSuxcZdleSb0w/ZbPpjSLrSvAs+yqgFJEHAS5P7lfO9/SM2SOvRUQRTA9jA?=
 =?us-ascii?Q?LOQ0Gn/R+DdOu0k6fFEQVslr2p2xy3h5f81rz5zs6gKxvigSUvQLbHBMy6v/?=
 =?us-ascii?Q?UeySoVEINnQNh3W5I72cP1HOCRmBgNa/z7GqGJm+NfzIcqMmDax4Rtgtg2t2?=
 =?us-ascii?Q?Y09rIvcSERcfpQL7p79H8Zs4yYM1pb4foNLpewFeUV4+TQMXjtjEurvjLqa3?=
 =?us-ascii?Q?nLfprWKcZta2wmUL5Wzz1VWjwOQevOFcD2nOsa3CcT5JTfbXh4hoZRZYhoHg?=
 =?us-ascii?Q?LBFKWKbi3wEBmk4tLosDn6XdSjgMFTMz66azL8/8wpybm8+Yho+rIyKR5CUO?=
 =?us-ascii?Q?36Nd4zzn0c3aVO2DV9IdKHqYB8y+SjpASQxPoElVt8AD+wDcBKj34kS24jgI?=
 =?us-ascii?Q?6sR2hDQyEddeBlHYGQclXOj234QuV7QOO9VeaZvs4kX5ggnbgaASQajoCppK?=
 =?us-ascii?Q?WsWLG96qQb8s7BlE8WfDleyRiv/5c9S0PMT7OWjskgi5T7dlA1nzoR8TGe7y?=
 =?us-ascii?Q?u0PKF0VHeAMsnUJv3ac=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d8248c-f38d-4db6-e01b-08dabe9b4c69
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:32:24.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4TVD+ZLqM0wIkILJG/MO33cp0PvzOZmncuc+QO5kgZgmal/nrRxEsjctIqgxmUb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 05:11:00AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 26, 2022 2:12 AM
> > 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > These complement the group interfaces and are for use by VFIO. The main
> 
> s/VFIO/iommufd/

Done:

These complement the group interfaces used by VFIO and are for use by
iommufd. The main difference is that multiple devices in the same group
can all share the ownership by passing the same ownership pointer.


> > difference is that multiple devices in the same group can all share the
> > ownership by passing the same ownership pointer.
> > 
> > Move the common code into shared functions.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommu.c | 116 +++++++++++++++++++++++++++++++++-------
> 
> remove the space before -EBUSY

Done
 
> > +int iommu_device_claim_dma_owner(struct device *dev, void *owner)
> >  {
> > -	int ret;
> > +	struct iommu_group *group = iommu_group_get(dev);
> > +	int ret = 0;
> > +
> > +	if (!group)
> > +		return -ENODEV;
> > 
> >  	mutex_lock(&group->mutex);
> > -	if (WARN_ON(!group->owner_cnt || !group->owner))
> > +	if (group->owner_cnt) {
> > +		if (group->owner != owner) {
> > +			ret = -EPERM;
> > +			goto unlock_out;
> > +		}
> 
> check owner!=NULL otherwise this call may inadvertently succeed
> if the caller assigns a NULL owner while the group has already been
> grabbed by a kernel driver.

Ah, this is a missed assertion we have already - basically owner ==
NULL is not a valid user owner since we are using it to mean 'dma API
owner'.

So, like this:

@@ -3112,6 +3112,9 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
 {
        int ret;
 
+       if (WARN_ON(!owner))
+               return -EINVAL;
+
        if ((group->domain && group->domain != group->default_domain) ||
            !xa_empty(&group->pasid_array))
                return -EBUSY;
@@ -3141,6 +3144,9 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 {
        int ret = 0;
 
+       if (WARN_ON(!owner))
+               return -EINVAL;
+
        mutex_lock(&group->mutex);
        if (group->owner_cnt) {
                ret = -EPERM;

Thanks,
Jason


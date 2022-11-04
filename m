Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E48A61A0F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKDT0Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiKDT0L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:26:11 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E021E2C;
        Fri,  4 Nov 2022 12:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG/sa/f5G+Cx88ylfezt9R7IjJ+Vlh46C1RTYX6LR1Ob3XmnWO74zjiffbgEqj0DCIbPfd0E1fYUG5j7zEbuRJ8/PsS+aEDeI8jsLpXXvuwbmvX4RVkURWqihP5WDtnIeN94AKfJnQxZDq/FIfqToXQCPyotmK3HFji1v/JGBl32E1VEPBxZ6h6W2dmLMggcIb2Tcfnof7oHzSGHqFIYQ8seg8Od3qH6j7XhlPda0OqB2wgHaxiz/PuCG+XTSRd3qyKjhATCferMsN0kXIil0vNYGpJotTKYwfch8JvQm6gqCHA7gNpP2uPZksGKxvXWfwRCjYJQvn3YOUJMt1oujw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tu930OvuFu3jUn0EKruj8z7OPgPu9liMfZeXGy8qZo=;
 b=NU0S6ba+3W29Axpe6TuMsMPlxY5hqznzKrnsa7gRkB1d9E+PdTtWMQ0zCUM9hJY2ovmq/c3DCcMrpo1uBt/IVlP2JuNNaQ6BlYra8LussY6cWSOkVmKS1g/BLKaSMXXJne0t1Lsmj13SOFWvwygbU406efcu6hs37oabSqBs9avTDVvEiamrbd95ybPcdaB8ggIu2YwqnxxhGkkzsDhhI17AKSzBEf3EGhNd3gnNlfc9mXpVBUd5qhoCkpKx0ABbNoSS4NXxOnqkG9qyprw8Yw0/vIxdCr/fxGfM6fKhBPwXCzBCFq1URnlusZruNl2+DQfI2+3Nn6A5jtGFzE6wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tu930OvuFu3jUn0EKruj8z7OPgPu9liMfZeXGy8qZo=;
 b=hhEBYTJnwInl1s3HayOV4a5LvCPn7gfecC9hDQwHhKm235znCA69/DysEXmHtIUb9/Y5RoaQhouE5nrM25yZ0eQ8kYq/XtsKw/rITTGNmYBfhoDpHEi0zJVClwtWalGQvYUA3DIB7rYD/RGQi9NowPwaqRosDeEHBSY94dbl5eBoEf+vRc2KFmIpXwzeWzUqmoQPHS7lrkwdezsjzmQUYijkuSDbmiWo+9IDNvxzy+u8oXJUFLzjq31txDRUCtqQZ2bgrKUz2mfDXzzN//GaXXbMtnJcnMyfxV1+BLTUdA7UfZiyuM8yx+l5GsquKSmUG2V/YptGb91mJC7Rxk/2IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 19:25:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 19:25:41 +0000
Date:   Fri, 4 Nov 2022 16:25:40 -0300
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
Subject: Re: [PATCH v3 01/15] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Message-ID: <Y2VnNJYQfQwfKiwl@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <1-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276F41D50FFAFFCC8186B238C389@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F41D50FFAFFCC8186B238C389@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:208:fc::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4311:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ab9e5c-9a8f-4249-85c4-08dabe9a5c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RYof3kHT/5xG1v5dpE9hfFOlu7hv//WpwOdSMdPx/xJFG7EHEGRFl2mAwulqTHw2MgJJ7VlboY5xOSfdDSZcRbHfAkBhBJ4gsTk/oSxfuPQ2qyv/6X4GLh5p4Z4fcxDVkjVH/vjnfZKO6brgmULLYMieQwxJwZATcNDvowLE9Pv+w4PA3mJi4is5QTJ507n09rp2X/pMwV8aleR3Ud70c4PohZ6k/iSA/eOMsqJrnX8KPk2rRdeGVw0z8Oa4NdbmAZJ5sFGU3oNv0dcOtqRaJH0oq/AEvViHbC7UC9Hyz/0q0+Rp57jL/vZqIRm59dDVYxk5Q6PVuAvGATF26V1vctRYz2J7DH/y9EAUnn+7TIkXg+hzta+qERxpMCPzOImd8J+meQNY/MrUAWeIEfM5QIGZmh1KSvo3DEngnqpimSvKhSjJpvg7M6aUy+x8Ge2K1/Ik32pShbb9rBDsAIWzXULdV78R0rI5dW51pxNr6KFhnBSp7LXK+P/uKplrJM/y14W+eNJMmVqWinPShVuMdRcpcGEaNDEWbeMwpO0XIDykAS+GOpsacQbTQkfsPm8dCNZx02N6d5Xv8GemqZozFsbQ+qryeBHzFCOhIxECAry0fSIX+wnk6eYhog//AttWNxDki/L7Er8ncS4etOWhsq3sCnlYrla7JZrsKu+UEKXomgBxFaeLVeQA5qBiRzn55h9Ta2C9GZ/KfBSZ1TZ2GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199015)(38100700002)(36756003)(8936002)(66556008)(8676002)(86362001)(41300700001)(4326008)(26005)(66946007)(7416002)(7406005)(5660300002)(316002)(66476007)(54906003)(6916009)(4744005)(2906002)(2616005)(186003)(478600001)(6486002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yyFyQvaMpZGct7Hne/EZj9HxjaAFYkbmqox4swBGXMNhDXE59WyZwvAYX3rq?=
 =?us-ascii?Q?zr6AIONCYyDh+cx4nU3jKlpWkf+8ccEfiOyq/R3gWdwTaNPkkP3yW/Es3IVe?=
 =?us-ascii?Q?8rvZKh4jlOyuawe3ifyV5VJoFh/IL/Ddo9X2hTqQmeFoUXnZ9a3uLSzRs9Ta?=
 =?us-ascii?Q?x9xHBBgXyFsnGvSqoJ3xoEfQxhAc5tmlJn0iWs2AJMNThMJdrmVTFihlKyhS?=
 =?us-ascii?Q?56AAeykQidtQtuP9ZfPYYvvMzSCI0x6s4fecpAKj26zHiO318OLI+j1DoFEA?=
 =?us-ascii?Q?9wkmYS8OfhYqvBpKIm/C29BrH8R+CAO1jrFDaD8PwHCRaDq4onKqANQfUXOH?=
 =?us-ascii?Q?UGLKkq/dgz1GmwjQCC9aKGKXUP3TIJmTGn/COPJixjFkxPkUvIjXx7x8+FEL?=
 =?us-ascii?Q?fE+ylNmoIjMkUPGRl3usObVLfVIXchsvP58NL44KsLVwCBXd+qDEbbITYCWD?=
 =?us-ascii?Q?rZlBarcXvdPI2KBS7MlvMylhqvcp8gA26Lst4LLdGthMJpfRbwkao1x4T/y+?=
 =?us-ascii?Q?7kmC0dvaxxoedfzQumwR4MPt5K3/2ccsHRUaFe3dVa9cbY426vHNCsypFlA7?=
 =?us-ascii?Q?YCLssfSItOMkZkI2zAWBrAnw0Fir5oZh1xgXBT5hNOEfPYf2nUwxTCse87yR?=
 =?us-ascii?Q?0uSvrrdxbzauE3lddlyqByb+klg8ZAJrAXD26D7ua3rNzFAJq5XPIQTloE40?=
 =?us-ascii?Q?mQeNhIy8Pur6zFdYQDZ4/mXbEzTV8nJSzALwZRnzzRR2AZ8jcvoDVVrUi1hZ?=
 =?us-ascii?Q?O9ARNSKDXl4EkLNWwKCNQJ+2k9KOevxHKT0N0wfuwUTtGb90qxn80rysMqDI?=
 =?us-ascii?Q?JAyUGCe6vEAU8qt5Alio7fbVNfL/lpxDhJjKZI5KNn08oPB/tWNvfx40mnmZ?=
 =?us-ascii?Q?Lbhx9dEFUHAIwdAjTOOslb3ROT/ejR5sFP3lYMHd11BCMii7YwZJCdJtqmwq?=
 =?us-ascii?Q?UeuF47n8ovK3PhEJtHxNGaERUAiy5hfbwcNUH6fQVKhTkyEtbD0RMxd9Ps6+?=
 =?us-ascii?Q?vtf06lCoeXqg6vYRQJBZejwprcR7PA9gaUiVaokZA923HI26yqeNtf+01VZu?=
 =?us-ascii?Q?BqCKBylnl0NnIyXJfFNSkBhbqSpfp0evfJ8U9Py6SZASoXjzki5gJFz/3+jJ?=
 =?us-ascii?Q?moVFT8lOTzPLOsvIxGK36hAyCSaA0Jn6lDfkQ5rpAQVLO6mMoU3n0D1sN6er?=
 =?us-ascii?Q?9LWSr59oxf/U/BKwrtJFf7UtPpcIeE57s3AHVzAw88Odg1nmSE+xc1UXeLPW?=
 =?us-ascii?Q?yITkhSpuNFx6CuQ1+VUjt0rqD9Jr5myV5EQZqLzoXaOWe74aMpOD378ZQjqc?=
 =?us-ascii?Q?PwzsH52w3i3YCXYNsaWxc1jNmAQpV82vRQpsgu+vB9l0x00ngmy/u6dzlAk2?=
 =?us-ascii?Q?eDTgbej1azJw0W5s31lMhnCJtpFpbcEIp8AWJO2PT2brCcmx2QRKu4JA5ntZ?=
 =?us-ascii?Q?gFLMBl6leKQlobxQq0mUqBJ1qtKAJm3XAwmypu8yNRvUXLky4ElVSF/98/mu?=
 =?us-ascii?Q?Xfd8sGKndnXXHJQ39KpbAggIC8fejV98aTJrH+36laE3Ys5e2lRO1GiksUX7?=
 =?us-ascii?Q?L3Er2ESuzuUzf6u5Wk0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ab9e5c-9a8f-4249-85c4-08dabe9a5c8c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:25:41.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffrl3EKxzoH1cRMlzzCtTQKxmSOCRc0kXL8VuFk1f/OF31YHYuS2S4UOIup/iGEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 05:03:01AM +0000, Tian, Kevin wrote:
> > @@ -4458,7 +4458,11 @@ static bool intel_iommu_capable(struct device
> > *dev, enum iommu_cap cap)
> >  		return irq_remapping_enabled == 1;
> >  	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
> >  		return dmar_platform_optin();
> > +	if (cap == IOMMU_CAP_ENFORCE_CACHE_COHERENCY) {
> > +		struct device_domain_info *info = dev_iommu_priv_get(dev);
> > 
> > +		return ecap_sc_support(info->iommu->ecap);
> > +	}
> >  	return false;
> >  }
> 
> use switch/case while making this change.

Done:

static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
{
	struct device_domain_info *info = dev_iommu_priv_get(dev);

	switch (cap) {
	case IOMMU_CAP_CACHE_COHERENCY:
		return true;
	case IOMMU_CAP_INTR_REMAP:
		return irq_remapping_enabled == 1;
	case IOMMU_CAP_PRE_BOOT_PROTECTION:
		return dmar_platform_optin();
	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
		return ecap_sc_support(info->iommu->ecap);
	default:
		return false;
	}
}

Thanks,
Jason

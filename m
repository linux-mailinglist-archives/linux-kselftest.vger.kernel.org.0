Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE55C6AE170
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 14:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCGNye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 08:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCGNy3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 08:54:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7787719F17;
        Tue,  7 Mar 2023 05:54:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j37bgBE4//8RVByzycO63y3HYNC3u/6Jgs3fCIgfPTJzD8Ms73fT/05PJppyGPB2lJFa6EDOSz9V06D14kQoVaRwZcUN4VUK64rlT8DiqJNsob2sWFyt4ELL/ePCNV82KRz31UDeKtvg6yycNvULSVft87NHDf89JJDnqLDvIIATfEfVjac9Sv5tgm/V0TRyqi/fWWqQclNrKlcMm7M0xQPCviDchVhRhKCDFYQl28HO/mFJJuJeQSXcomrNENxdfoEXHspOle061FGwOPWWOZVX65xF0KwIXVWyjGyn1DMHNCgdg25wjg2wLXpoxGJmHt/KOItjgas+vdMSV6ZdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGXDqOIrq92RR+PjnA9uAkH6v8ybKan+JYHpJm8m4x0=;
 b=YTzeuZThmTxcSIE1c9MXi2k4mgJ1VuE3299yti/UlFj3SADZPXOEkVO8ukqgvUGg/7vCFOG6y+08AME2p5XfgmVgUio3BmD3de/e8TedMLR/2l8yJZLLiohWV6YlKvrbEM6eale40A1zkg3NNs9nVE6eEfYpUuMIhXryCM+huQE6E/lulG27fjfRsrBEIrdGOqJoiuCsyPP/Cn4IXdCeYKmzMruhyHk98whyoZDmD4waXQcilXyDD+jZeSo852LMnr4lUaFA8Ug3f4WI2qJxuaT8bgPRhssX3vHa3Pp0gUR5s2A9zDj/CjMaqjvDd7G0hejDJ2/BQmwNSS6Cg/9H4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGXDqOIrq92RR+PjnA9uAkH6v8ybKan+JYHpJm8m4x0=;
 b=P67tJYOQDonjv8dS97lFYCRCZj9GjRrZoNbGLQMhe+zjmErDMgOuOW4yMhoT7e9S4sGuw+xkWhzpgT5JZaTUUdKLI5cC9R92O2jPLhXjbHnRRbWLFdjYEOD2Jk6E0RYOd/M69YCojwYkt77+dTz/sR44mAr7e75GnZ49bsocchZH4wOJvF/r1tb1Edn4/KfVJQUEBJLTzmGYLZznBDs9M2GDtaSzW1cDq19VGhLjTxp/uJfLlTUmV89k3buXMYwtlKbesgW3sZ63VNQCTCP7QlYIz2bm5gifMv9QVK2OfaGw2P58VREV0GGBDJOhGAhfVJRH5dVbv1bx3XAao/Wo9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Tue, 7 Mar
 2023 13:54:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 13:54:23 +0000
Date:   Tue, 7 Mar 2023 09:54:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 09/14] iommufd: Add iommufd_device_replace()
Message-ID: <ZAdCDWzkKqWZPxno@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <9-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB527622B6031FDB540D2820138CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAZQtNE7aPpzv5RX@nvidia.com>
 <BN9PR11MB5276E3418B829505626E43798CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E3418B829505626E43798CB79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:208:32a::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: b60b4c4b-b89a-4a0c-a937-08db1f1374f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAZ0ZOImQ4AgIsSpTdqX4QujhF7zpgZ1HKVZN0qCaN4WBoabFTHWkRk7a6kB6XYi/K6muRFP6LQZ69lq1Y87XBNWigGlEABReTrqSTKtTBuIdtRmvv/DMbmASVkaZwpS7YQWlclw/6Wzv7CVdm1NUDvlGUXum7JQrgkR0IJweb+yiud9x8MUoB0eKU0naHZ/sZBsINbNsEvmzKkRM1mogFQuLBbDfvGuZqm7g/ATZJU6QOvcjIPIkCTFjbcxvQraaAwSUkfMfGcOKPxrPJGOBqwkTQMxqxzsm6kbuyQXxyoxxjlRnq2wDAilTMFbKyS+Kn12jpkJOyhM+OOQo+w3JKQX/nPIKNerMRDZZU8Cui+fBgI9KZsdw5UW6TU0gaQADcqi9mjcTi1B1MFECaKR5L9LuSQrKVfqObgXbvOsIEkMGUm1wY9E7grbkb2RQ+eyjyzNdE0BJY07vXlX3aJy26ULE25ltQV/QxRJ/uFvgF7mhEsO7UkEY9hlexOV3n7fgVfXu8ljH9hEGYg7fm0eXCrddr7UL5bWZBjeZHzPaRQc1/SBjWCOPUxCkRBEKRmMKtH199R52fi/H1UxcYByvtsrxZ0mZuTPPxIp9mxjg97HzfGS1y6KRON7guseVVk18T6gdXEFw9G1gW082DO05Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(41300700001)(8676002)(83380400001)(54906003)(8936002)(316002)(66556008)(66476007)(478600001)(4326008)(66946007)(86362001)(6916009)(5660300002)(2906002)(6486002)(186003)(2616005)(6506007)(6512007)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YEqlPTfjK7FTwbdNluCyWuVXRrfRF+PoHBw72jO8cACKmk1WIvHO8LJjNmI8?=
 =?us-ascii?Q?PO+CJzWWJ15zuuDmPBiyGgtzliPmc5KnZzVHIgUzHaqJ4uqIApjxZKz+6uH4?=
 =?us-ascii?Q?2k+FTyE5t4e76bMGinq+XewQ+XwlwNeiChlNzCkkdErLa6gUMpyNKDlfRzwl?=
 =?us-ascii?Q?/LlCElmiOjJHpndr+fDWL11qkTNSySRJD0XdldkmKwD9iYXoKyEOo0Rnw0nw?=
 =?us-ascii?Q?o8wSe9fRA0M6FneGus/e0ICAAdYe/2QdKBKRHf/io+FTpRF0JsKI7Mk4mG8Y?=
 =?us-ascii?Q?DUqHd3BLOSuiMsxVomBWxHqigGUxe0qIFVGEu1+2vkL9BLWu9VjwrMbpkvL3?=
 =?us-ascii?Q?7lgGVVNA+TwegkkJXK/i8b1tzsWX++r2HIKJsFQu5ikaPJPWiBeUf65CgBbF?=
 =?us-ascii?Q?+OWe8/jWTU9W6ThkxbUSpn/AYA0h855tYeR/7kMtA0MLi9KL7jbCQt9rxhI9?=
 =?us-ascii?Q?favhNSMWunmhSNjZfHpyXWxkz1fNEd0CQD4qdfqL/Frwb9wSzLRek+viwPlj?=
 =?us-ascii?Q?Uo390vzX5c3f3dXNQRyVJHqq+iisUE47rgqTBCMUG8q3HXjQcmCW2dbtBSks?=
 =?us-ascii?Q?oh7P1rRBjjGneVMjUVvVd7vVzLzNcVOvJTi8jXp+LZQPGcOeLimpJjWB485E?=
 =?us-ascii?Q?lAPe/j3evGB+JHrKvDnZY2gEKM7XmoNrbnUwitZNLaApj0TmJmLR2uJGR5YG?=
 =?us-ascii?Q?wzYbx5+mCT9gTcl8JgEuvucSpfxiWS6NXMP8WeMCNpHAol/y6MjCnTLw5Y81?=
 =?us-ascii?Q?8yyAFxJmyft9SEabl3QQE4DKPzd2tr9N8xa2Yn7Yftf8o7b51eCDvfHsgRrD?=
 =?us-ascii?Q?ZR1ZjzxYqWT2K7jxk0RKjEcQVLZ9ThuPQxArIF2jJzwC87jqGA+DqVOZ33Ag?=
 =?us-ascii?Q?GQOMrJhEu+wAneyzQ3tenmNKy5fRmRXMsPqxOKK+kAez9OHvJsekV1ZhOgAK?=
 =?us-ascii?Q?CZWMFQ6+wL0ZMnD6MJoIyZC0kRdPbTMyX8Ffwrv/AU6z7tRrLd61+dPPDGZu?=
 =?us-ascii?Q?GuSfwHkR5L4cKfpdF5K2JPYPA7lOEPwNQmjzg8f7c+Agh2bE2Q0iqXYpghd8?=
 =?us-ascii?Q?BK0dBf6BizNp4AKmHLnr5VeiXxdoaMDDFWCs1v2OxAYUfnpFppP7tdc8gfKg?=
 =?us-ascii?Q?keZDk0wa82183tmdjAxeDoTSc1WV1D1Gzq+dG5dlW4+oYmuZjyII+MikE2M+?=
 =?us-ascii?Q?rTakDdukcDZzKf1JLhbBt63aMNsrCJQnT0PPKVo9ehCXX4oBPP3+LL0oUfUR?=
 =?us-ascii?Q?N4apn8hgIzC8Gm2LFYdC2A8jjE4oO3u5YOIKPXL2GlIYFz/sWgBm4XMjXpy3?=
 =?us-ascii?Q?ALbQQSIPkIceVNNilm/DogSAAwyh1qcCIbNUE6GKEP5578UC2tKRHS+PyZ15?=
 =?us-ascii?Q?UDX0oCAPqAb+JPA0T/SPzU0OUGpIk0VyGa8lUihg7YnSmfAeLeK5kkzkWYik?=
 =?us-ascii?Q?1mc0ih9Q5NG8Venqz/oasXtThd18G5KbG0bdPfANdQFdZPcvL/LbPFHkmLpS?=
 =?us-ascii?Q?5+h8pE8lIx0Hxx2UTh7cyKZLuMmF4ck9KyxGjH1FiN3CxW1CsHsGXUZNMCCY?=
 =?us-ascii?Q?tlEXIupwbm8vUqEXQUY+esvYAtLDeQTzcFV0pThF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b4c4b-b89a-4a0c-a937-08db1f1374f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 13:54:23.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFGIHk6i/q0KFWJCj0Dq0qc2aRhWP5XnRKPIlVa4+drarUP4eytl+VFWVhdaDSwp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 07, 2023 at 02:42:23AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 7, 2023 4:45 AM
> > 
> > On Thu, Mar 02, 2023 at 08:20:05AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Saturday, February 25, 2023 8:28 AM
> > > >
> > > > +static struct iommufd_hw_pagetable *
> > > > +iommufd_device_do_replace_locked(struct iommufd_device *idev,
> > > > +				 struct iommufd_hw_pagetable *hwpt)
> > > > +{
> > > > +	struct iommufd_hw_pagetable *old_hwpt;
> > > > +	int rc;
> > > > +
> > > > +	lockdep_assert_held(&idev->igroup->lock);
> > > > +
> > > > +	/* Try to upgrade the domain we have */
> > > > +	if (idev->enforce_cache_coherency) {
> > > > +		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
> > > > +		if (rc)
> > > > +			return ERR_PTR(-EINVAL);
> > > > +	}
> > > > +
> > > > +	rc = iommufd_device_setup_msi(idev, hwpt);
> > > > +	if (rc)
> > > > +		return ERR_PTR(rc);
> > > > +
> > > > +	old_hwpt = idev->igroup->hwpt;
> > > > +	if (hwpt->ioas != old_hwpt->ioas) {
> > > > +		rc = iopt_table_enforce_group_resv_regions(
> > > > +			&hwpt->ioas->iopt, idev->igroup->group, NULL);
> > > > +		if (rc)
> > > > +			return ERR_PTR(rc);
> > > > +	}
> > >
> > > This is inconsistent with the earlier cleanup in the attach path
> > > where setup_msi/enforce_group_resv_region are done only
> > > once per group (if that is the right thing to do).
> > 
> > Logically replace is 'detach every device in the group' - which makes
> > devices 0 - then 'reattach them all' to the new ioas.
> > 
> > So at this point it is still being done only once per group.
> > 
> > The 2nd idevs to call this function will see hwpt->ioas ==
> > old_hwpt->ioas
> > 
> 
> but setup_msi() is still done for every device which is inconsistent
> with what patch5 does.

There is a missing check to do nothing if the hwpt is already set

If the hwpt is not set and the ioas is the same then we still have to
do the setup_msi

Jason

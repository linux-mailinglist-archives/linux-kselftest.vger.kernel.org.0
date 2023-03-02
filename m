Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD486A7C35
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 09:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCBIGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Mar 2023 03:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBIGe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Mar 2023 03:06:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B034311DF;
        Thu,  2 Mar 2023 00:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744393; x=1709280393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v2g+rEKK0Ei53uwylbx4rNvQwwJLEuAP0Wj6Fxhw9Wg=;
  b=VjWCpX32Jb3kqr5WmBllFEVFr2XrOYY6zT2hwiTC0o8RIXTtHUBBOQt7
   OnihKwz21xxbZnXzT/rFsFyJhVlsk9BEoIwqWhRZRrmvOdQZD7sxnfDMh
   5NvTjeQ/dUPSmNTPfos6fsARAiRvW0VtSdQWN/tY9vj8AMID7Hri6pPhW
   IufLlp4pS3fXkQpaGLD4U+KQI+3gd+nDthwpFQzglEA1O1E2P/B6qQT9F
   KGrstmmQoQ3J9ru6wjy3J+1NyEDK8MB4Rczc4NOtabJFU62+1umdZBh0O
   8COg77FxHACt+TYH3CQqsDDG5I/eM5vPjXShMXxhvf52JWKXTAAtH1t2Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="315070908"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="315070908"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1004010854"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="1004010854"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2023 00:06:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:06:31 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 00:06:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 00:06:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 00:06:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGcIlDBAFvAFasvHg3XXIGQs0SibjKWoIGIoKuLFXBHnWKBCvKKLZC+g7As16jJO0IrZZrgF07C92r7s65qJoXhXDnX33IMbPthoEpUCOSLRtPxJG5F9WYT6lJSwF1OwHWPzoXn7SV3KQh85jTsZgQV3rCAFhmA+d0H/8Aa5rSGPE/g/2I+CEoKvn/LQltCt5Cv8pzeDXFHO0WeWe5dcT6Sm0DaKz0cMrA2inLgBRCjB7TFaM2lU55NjvQ1kmsMoyfb4Pt7eAF80kEQEeVG1tBWU+6vC749rbX9h1dxM1V0NhR/fVGmIVcuvCPqk6uugNqIiomjm/ekQPhaix5njCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2g+rEKK0Ei53uwylbx4rNvQwwJLEuAP0Wj6Fxhw9Wg=;
 b=aYtOxylO5CjDnf/D7gRrj0ZyQnas2FOJ1Bss51+WZ0OLpgmd+z/BTU4RlZLQOvTJKn87VWf7ftbkLzZdHnGcOruh1uZ0xPH9Y/o4Y7CK1M7/huQxtAz+xy9MDdlZIakHhTob1cNARv9P7A7P9cSzGoQPkpNA8i8AXWrs/vetr/MILxVAHHJTaUrUA63QnHPhsPG13l+sszdBl0IklkZMfhd0QNa8miigAoFSe/6HfTBcx9ja7oN29STbKw/CQReny4QNVzvlYAz1Uz86OCrkUxiUqbQ9gUk2zhZ4JKQWQ7pT37VVGFTMB/D3pVeCcGja824YbvLGgXcxOHlhLlFv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 08:06:29 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 08:06:28 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 04/14] iommufd: Use the iommufd_group to avoid duplicate
 reserved groups and msi setup
Thread-Topic: [PATCH 04/14] iommufd: Use the iommufd_group to avoid duplicate
 reserved groups and msi setup
Thread-Index: AQHZSLAO9s9EoxaOzE2w9MkhlKiB967nKSTw
Date:   Thu, 2 Mar 2023 08:06:27 +0000
Message-ID: <BN9PR11MB5276499B820C0250B4364AC98CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <4-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <4-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: 613a428f-a588-45e4-9948-08db1af50669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToKvhy30NPhL+ma3R1xYNleX7XwQtY4/WbLSMQRmt9GucoSjIS6POMGR4TZmI2fvUJaUquEGC47W4OBHlwuhPS6x2yIUPmm+tl15sSO3iZHYfWyQtTm5BixG4NYFi/OgE70hWDB6svtbKcwzUZ1A1Y6YlH90b3lnGcM8Z/kqAfa0iI8KAujyjlso9F/3YVYqCULlzDb4JEnqEP2DYlGg2nLJBDTsLlt+DxLJdghUIXx1vNwYSL1mE9hTQrKDPLEMmDZi80ybPcxXXdVJAUYvN95TlCjiG0MgALw/AuyBYlNRTxyNAU6fK9J7i0Nu8auZpTZr6mSmBi5Q2WQe74470nX6Kr6kSTh1KvEY5jtXDSaAuv1rj1NxJoLSv73hzCm5Wd0qO+OC6gii2GOe+jcWdPxY5BvDGS9Z+VuNLcC8KZJzYmfIiEJ2jqlUNrK9CemaIOFeYNTxHDc/CVSMe12+hJ9HkOSlNvvw+AE7XtZN44eiB4XiWrXBY+f9FTFsmA7bwlgkHbNeqGM+kiNnvcNQBudi5Cspd05+Niw76IyOy5eJiRrBGi7uqIXbXWOcomF59N/biq7XyjNIsnNprf66emBlRS9Gvbj+AX+NpEcOURVF2HysyctW/RzFCIuuoFEjHiwiAqL6qIa139UyrUQhBIhTPpOvQwg0ch9MNQiOLzORRUdIpFO+5nrswjuQq3YD4FFxAt5vd/J/9AcSmkdDYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(107886003)(122000001)(38100700002)(8936002)(5660300002)(52536014)(478600001)(82960400001)(55016003)(33656002)(86362001)(38070700005)(71200400001)(26005)(186003)(9686003)(6506007)(8676002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(7696005)(2906002)(4744005)(316002)(41300700001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B89xMPBXWKw6TaRh9OrhZq9yCc4RHo/2gKayf+mlw8vHAQGYFEhx9asAOeel?=
 =?us-ascii?Q?4elO5G+vnYs4D60I1qp5nuk7tGmeqYH1d/cgn+lRooUm/+JRJvaquFauUYCC?=
 =?us-ascii?Q?Hki62YOrqRLfVwYcRdnbfkIY5Ls36Nv1mSw2QmVLjKHmqYhUEFqIiZ7Z8c+H?=
 =?us-ascii?Q?fx8Vksylqn7CGEqBSK2QpFc66ZFo7TRb3nkeoxeYkCpMvtHGzpMH01xgFdMK?=
 =?us-ascii?Q?abbbWhGKnPb52GxG552fdNTq5lYld1OZlH6PnAv0emDA4X2WkvECLay+v1XI?=
 =?us-ascii?Q?uTuWrH52ukyKXWvrKcoWIluZ67t7LpgvkDDXeIsSLUHe1sxUExf7uZor3qhE?=
 =?us-ascii?Q?QUIXNPFk4GBexKOqvW+i98VpNMZUprEXZ/1zhmLG7W1Xbx/bPYKIS12jwvoN?=
 =?us-ascii?Q?mdRx3q/zONGsmclW4kTH/50wf6jmBNEZF+FaK2krhftihd82wSMV/L00cpBY?=
 =?us-ascii?Q?VBDUxqqpPaC8PsLUCSMS5PKLRcdOPaBtX0AggHFLjHAsjYFVexFjGHp4Uqa5?=
 =?us-ascii?Q?OuDG57scoftuJEIz9lCtz9Gcg+7B0mUrtYQZiMgWT5dTgp5h75quo959/SuV?=
 =?us-ascii?Q?mzftwmXCmzBJ5Gvtfi9pspstTssVETfLjzH+ehnDLs/2t5dwZVTe4k38PTfy?=
 =?us-ascii?Q?Xipb9HN6+WT1AKRPBH2fswabSd1SdQTo4IIBKZuvrBYjYTW+B2EzQk921Z2G?=
 =?us-ascii?Q?3SQ2kl8ILyVAeWYYYLPiia9QWnKs9Tx0K1uEGQDmbtGj2WftXTp1lD+nsL4P?=
 =?us-ascii?Q?pHUY5Bscd2PVCvwBZtrgqjoNIR+YtSBU2KJOrOBKLa5qRxCNoSrlEjtu8J7y?=
 =?us-ascii?Q?dxx0nTpqq8APy7QJJZBs+ji/4jwnrElbf069ZkkSkwyhu1TQfKA2zFSXEliz?=
 =?us-ascii?Q?Eb1LfmR9Jlrp8wLwdxbxada8/Qkl5yaRnNSGpqf7cQKYLMVkUg4DfgMkP9pY?=
 =?us-ascii?Q?cmD5dNj4gG/TaVKitPO9wwjqlgTELH45zJGdLkYDQ4nWYT/mDHBPWZmhZUbs?=
 =?us-ascii?Q?CUwLjtUenWA59D4klVI7YAAdvq3xZ9/6aihxByjqY2HCBy+SuzVK73P2SHY5?=
 =?us-ascii?Q?k6TCncdzpnLGtI7+JsRxW0OvVeQBuIa99PFplRILpbY7MdvPjf6V8+I9Onvc?=
 =?us-ascii?Q?ZklwjfMVFLjIGHashZkuVq6rvBT6jnW7OtLFxGZW6s5x89z7v2o5qfpH6awr?=
 =?us-ascii?Q?rBlXhLiTGXtpLYnas6eciNGIwU+6SfcVp9V7GeWzCJLoKRTeyK+CBlsZD5YY?=
 =?us-ascii?Q?cePIdiGxBPGpGdYK0U/UMzJia/QzfMusTPkiXN98fnvWpZG3zaXD4SU6Tvfg?=
 =?us-ascii?Q?Ia2A9JFR7tyNQwiGlU3f+GQ709XHXu+8CeL+TuFnVNy/CLJp9p7d305e4HtT?=
 =?us-ascii?Q?e22FKxQVdiV30dG60M16EEFUfYNyUCRM549lr9NFp+5ZM3+riOLvrlMFFogp?=
 =?us-ascii?Q?tncGCpavweiHj44DIieGLjCKCJdYNXsLdYcalcy5/620yCqxQBBr/KdUgKUY?=
 =?us-ascii?Q?cvg+eCcH9ox8nYBfyre2hek+PBwSnM1KUfBp8MeyDXZHyvTnXiNPcfpZjCau?=
 =?us-ascii?Q?Z4ORrVszvtkYoXzfUQrvTlEtfd28ic+HAAZ9SuxG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613a428f-a588-45e4-9948-08db1af50669
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 08:06:27.9638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mc/vG4L0gf1/fbYr5k2f/26aVMKI1O+FdbtO3olL/YtnJdI1WUXVtJpRL5kXVGiz6NsUBi45Mrdjz6QotbXswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Saturday, February 25, 2023 8:28 AM
>=20
> These items only needs to be done once per group, not once per device. Th=
e
> once per device was a way to make the device list work. Since we are
> abandoning this we can optimize things a bit.
>=20

Are we sure that a device hot-plugged into the group won't increase the
list of reserved IOVA ranges?

Currently iommu_get_group_resv_regions() queries reserved regions per
device and then merge them into the specified list.

Of course VFIO cannot cope with it since its group_attach() is done only
once. But if such scenario does exist then the current per-device
reservation in iommufd looks an improvement.

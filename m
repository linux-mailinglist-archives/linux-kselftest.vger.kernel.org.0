Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B76C761A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 04:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCXDEv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 23:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXDEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 23:04:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCCB222D0;
        Thu, 23 Mar 2023 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679627088; x=1711163088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iD49ji+PO3o6R7zccitugs4j1LUQnlOj3e3PufjiT1o=;
  b=eAIpNBRf+/t7Y/VhDZJQob5N4r2gJ5jssgmG6RwB748Znj9764Qmpqap
   3/veEFnNRht4UIJJx4DVlJmumF36FENL/cyNbHhYV7KDmJvg5ZihUKgOE
   9TYP9dOvSt773r59eWwUGmncbmo4aIFVtQaabzrm5xcEEx0twN6B9OPrJ
   6VhvaqsfTZYvgssbMp1D8+Ru9m4K+E3JgkB+o+D/VQWz/YiWjRdOPwYrM
   cJ9IxxuSFKPfOscYnO4H2pKqGmfFoikkjZ/ckSwaO4P1ebNaY8XQgp+zQ
   w118zR9IWiNQFd9bEIcTxqiRHK+mjUQA4i4hLVdGhX+TYLQIbtpjoPxWr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323551085"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="323551085"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 20:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="771700818"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="771700818"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Mar 2023 20:04:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 20:04:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 20:04:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 20:04:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 20:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwEeE5J5j46V4/uvs/eqpQWLNu2SYlASFbINelhcwN/OpbnGg4Q9ieYPlnz+ZEJIAJfbRgExtjlywVBdkNZ9fDOR8kcgXM7Sk1/rE6FRopoStzZy8wdfMYKlWcRWX2LkONIS5ve60tvmbAQ6a/+EkZ2qrm1o4G0oYls0yTyIHGlSTf6HoEVWNEZyStabvmkhDqy1MlU12dyZk/3T4BLD3xSeACcZJ4lmOC9RTZDnppIUKeuNre7WYJ0UbPBmonjpA//TVnYwsvYVYL6OSPTJAs4dh2KLcZMl7K8SDVd/jgIYhOLL2PYYVXVouNUoJ0g5knE9zRViuHEmfPTBosNTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD49ji+PO3o6R7zccitugs4j1LUQnlOj3e3PufjiT1o=;
 b=NECyLnbo6CZ3R0KvJ0dkKRA2voTB5Xtfs9JTGfNQZIsO0wy9ubwEFTwEHBnVeJWHuDYIP1DDfUsQN8ksWIbDcoHDZKY4j3zvDITvuLsUqdtq3UYUtpKQ9CpsAN6yySjZDyu5B12iCmEOBu0eD6iDnLjI+YVYFKMsvqcm72f5Ikawbil2CTQP22NCwzR+UlEWjF+WblQWrpWK90y+BDWOWg2h2J6+2wbZRFr+CbBKnRl5J+9XgW+mtDUxQFxowjh1MmM9f1IvfdPiTbASukDRCU88K+ql/BHjL0NVD7c7QnYElcgNmlwkZ4Xi3Y/XtlEULMSeEtG9/B+9pK043aOTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5484.namprd11.prod.outlook.com (2603:10b6:408:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 03:04:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 03:04:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v5 4/4] vfio: Support IO page table replacement
Thread-Topic: [PATCH v5 4/4] vfio: Support IO page table replacement
Thread-Index: AQHZXWJGfcKg4QLqXU6WnlngqDAL5a8JP80w
Date:   Fri, 24 Mar 2023 03:04:19 +0000
Message-ID: <BN9PR11MB527616A7E7D02A053EC30DAB8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1679559476.git.nicolinc@nvidia.com>
 <29023644817002345ab94d8916a8447debb45a95.1679559476.git.nicolinc@nvidia.com>
In-Reply-To: <29023644817002345ab94d8916a8447debb45a95.1679559476.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5484:EE_
x-ms-office365-filtering-correlation-id: 49939ccd-c547-4b24-a695-08db2c1475ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqPqUfX5LlhP2E99tZaGj8F9fzz9oo/jssQViZ3hi0ZC1t+OfbENAd2sX6UlDwM6DpSCkECalHPX9LvcenQf10ZzUFfpnBkYjUfpUtCMspNufvn0+oTtawbRHvFuavGfXZIDMJhGU8n8faV7A+YH/FKSeSijiYvrrdYud4vt+aHAS1dRijaUGj6aPoo9TRy5LNXscOJ5h3gJycphhqHSCGv4ezzjABXcF7QFlOTXl9/tKeMtNfpcYpiOifNIhKP3K1GsDOpgPsNrYIpV/5rUlk0F4zdCOYwOEwIiJlV1Ph6IP5lylVURNydoZI0AqP0nCLNy/csuea8BBaiHBtrirbdgi0uGYOjxAMNXsnPn3RNzCiIHbK1lk21nuPiGLPJRtKUOdyqrqLR4/n1w8iscYJOja1HO12J2ixd9WuZMby2CwhkrS+AZXKo8lNg/1C8FamZ7MFlNM2UrTN3LLVoYiRQDmYfl+SOJ60kRjF4clB/ljS2sx5RjtV+j424Zk7r8yDn3pWcgLw4RliN8zbBHMWKDcdo8bt/8BT0CFdoR+Vp+ZOAIOPfYkI/N4gnt9DYL2DNFDBCGBHUJc2L+DlnF06he2h++JR+FlaEzNQInyFLbtPsob/D/8IocHZRL3240q+1qFASEmLAvf3wHw8ldWIe9SUPJpArwuOp52rkw6D5bTvayn0EWaW6FDccOyxO20S4r7lJDIEQVhz7gsAFRNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199018)(82960400001)(316002)(54906003)(110136005)(33656002)(122000001)(83380400001)(41300700001)(38070700005)(8936002)(2906002)(71200400001)(4326008)(478600001)(66446008)(86362001)(8676002)(7696005)(64756008)(38100700002)(66946007)(52536014)(186003)(66556008)(66476007)(76116006)(5660300002)(4744005)(9686003)(6506007)(26005)(55016003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ETW1/NNPdMD+XBEsbfw1ubxI+Y5Y7GOZu2EWV3B7PqUXfxv+fpo0caxDog98?=
 =?us-ascii?Q?xPZKxLxT+01fa4480z3K8UZ80xQWPOyVloe5CuEnSIvozmnHl8Yvt4U1n4du?=
 =?us-ascii?Q?Vp0Ja/LexA9R1v9UvBLj3Xh0GV+lc2sM/JiaS9iw+YFPxzD1QBwXWXgT6iB9?=
 =?us-ascii?Q?l+/Ko10DWxfxsbppcixvSgUzoQAFROa9hIzOiBlPF1MMlqv+8tHMcDyXjgbh?=
 =?us-ascii?Q?AcHjI2ug1p0Qf0yvQUj9K4+E1dF9QXuvkyYzr9uUv2pUw1HK0I7KCKrMMvQC?=
 =?us-ascii?Q?jOqruZkRpZDWAAUxK0e5aI7cyAKHQK50Fptse3ww5vdao6ZulpltD6dAPKSI?=
 =?us-ascii?Q?na2tCOULBgYwLF2Pp/Hzly8+8OwrOXhboEaub8rmQ9RiD3Do+YSHILWafxbn?=
 =?us-ascii?Q?QsGW7/XhJRPleFgpoXAV9VUy0qZ1E2W+Ci7WM8RweCUiTXJTB9bQoDio3WwY?=
 =?us-ascii?Q?Bw1e4RT3NKFV1Xpt8TP0noPchFq9Bx+i5r+/EkDkolCTgUTwOOl+cbuDrXXS?=
 =?us-ascii?Q?iuOpARrefqhc8DgXrEzzY1yQXyEs1Yshv8CXvymtQQ4P70hF1x5kQcOHxPeM?=
 =?us-ascii?Q?fOa8mJueExkjn098spKaB6pdkP/tq07AKS8Uc4nKvcD3eDAI4XtC7UQWFnWS?=
 =?us-ascii?Q?cqP5yhCnw9xf41cpJTpOmKivK5Na3XZ80SSvgVTMLuHdoxi/fBkDSOLxmrmT?=
 =?us-ascii?Q?UEpcJcvz/L+kDhqyXnFjrvhn2M4sI2FJde6BEow43mHpFUZi1onB+6vHLEXg?=
 =?us-ascii?Q?X9Ko0LRvcOcwf34auzwNpd8IHfyVFjuhakyK30eqZ4Y4bg0r3WVQIKoQjWQX?=
 =?us-ascii?Q?SQzRvLNQEqkx0/Let+l7pgLpPTW9+WMo6zF+4BiZiGFWzONMg7b2CUPpTnQc?=
 =?us-ascii?Q?ZnySsQIRqyxDM9N7JugQCQEXAH0ROB6hTSapG435mxAakYCT6TwbEKa1Auni?=
 =?us-ascii?Q?T6ZuyibEPJc00NygDjvTovsKgq8vfPjfu656fC1CVLq7qXxKOU2YBfH6dH9o?=
 =?us-ascii?Q?CNGOfRDOewufIVUi1/dn4ueDwbN6Iut+YNKMnEWa/OOO6w3TbTGTIL/5EVzj?=
 =?us-ascii?Q?0k3fpzFQIOY0TuTI+ZQLBvepGMMSHC0AWMhg18b7FdvXmzBNjNXkRgljG/0C?=
 =?us-ascii?Q?1VeyEUoXC6MoKP2E44qnL8H/8+snbH+jKMWtFEeBajOtreWDA1XS97yUDK25?=
 =?us-ascii?Q?6bkerqUHqNrGifunU66KrU2uqEVafd3JDzPdb29Ih49kaBUP5FVar3GhrQPF?=
 =?us-ascii?Q?pRsNFVfAlDX22Nu9YTNCEQQWr2UGaQanGXnV92b5b8i/r+B29MdTKpTM8xU1?=
 =?us-ascii?Q?sfVl6Wc+jB1xjB5bsQvxvkGw2wzsWg47gsS7tjRut1vjmSiu/slFHR2sAzgN?=
 =?us-ascii?Q?ChYCZ5N6c4pkYdNnMDWcu6bL4ZSgWwbwTOT0V6hYGLMprnLdJQ7aV7EAlLOO?=
 =?us-ascii?Q?8UIQio6Xrv9jk/yvZe4cjO9C/FMHQ2plxj+TSxqCC6/vjyR7+SSrzP77U9Pg?=
 =?us-ascii?Q?m3RyZmadMvs3ELXnh3d/Uif0wMlK+XI1UZnkyeTUrPMkcL9N2XfKk+VxpNyw?=
 =?us-ascii?Q?EOWGAWvDC6d3c97ZmpJWmHOive4MmFpA0GoBBrEq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49939ccd-c547-4b24-a695-08db2c1475ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 03:04:19.2378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4DrX8U7DzIlIxhTgX0ACp1oW2/2TBr+SHYEvd1CHmcT9+0B8/Q3EPGhhy9zS2ClGIFhSbFbz9udrBjaJWwLKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5484
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 23, 2023 4:33 PM
>=20
> Now both the physical path and the emulated path should support an IO
> page
> table replacement. Call iommufd_device_replace/iommufd_access_replace(),
> when vdev->iommufd_attached is true.
>=20
> Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI
> header.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

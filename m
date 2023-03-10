Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB36B3CA5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 11:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCJKpl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 05:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjCJKpc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 05:45:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8EF7DF93;
        Fri, 10 Mar 2023 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678445121; x=1709981121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YAv5HfeyT58ozoIvhOaFcjp2TggUr2iGUSZyNbqLTL4=;
  b=h1xGB4+Foj1JAh6H6ZVbAJ9hUJw7/vnwgx4tJ8qHjsqmsJi3CLkliV9r
   vGb6NXiHN40ejM3+qhCJuhRHRE3kZj0p0NAL6mAIGNaf36CXGZZX1p/2m
   ah90KgUDvoQQnfsU4Ujv8h5hTcFZ/cFgSdmLkDCfPCRJ4eYOPjNYEMDh/
   ZyJnfIvyDw+e2fEX1HDYiLMm4q/8LjrDppYxGDNfgfCq+eD8YrvoNto0/
   aqiTNLoizLlu6p16uvsVl1b3VFPdvHszc/wwo5UyKpR6aqugyjkFsEnLT
   uDy6u8MCoOrqc4SD6SU5WfQtKeduVWwQea4j/947GEGuho/AWIkp1aMQZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="320554112"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="320554112"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 02:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801537361"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="801537361"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2023 02:45:10 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:45:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 10 Mar 2023 02:45:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 10 Mar 2023 02:45:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 10 Mar 2023 02:45:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsRimx+QlWRJFbxx2hIhRgg9bpB4f/r5yifGgCqYqLryan831IjAHeeYu9yvCvfTW9k4UYMi2TR9dduiZ95nHbBlDHNk7zhk5Yo4rvJLhYkVXOj4WnzTvfLiYxnB75uD6ZVJs4C9RimtgU2JZpD0HaTk4fXIJL6MxR7peY2rP8/ptlk+lsj5DrOq/imSmHcuCO5yBnjZ8Yz3NP0QLGKmjwf1hlfzdfCes6rVVxHje49uLWy2Ita5+j02M6Fx5x6DeZc0KfOOU3iFTgONdOkf9UDOajrMcZAaUYR2NNPXjaMou15mJ6T4DS6144vNlJwti9XAVhJcKAZpVBF6btFEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAv5HfeyT58ozoIvhOaFcjp2TggUr2iGUSZyNbqLTL4=;
 b=P4TCKVGVCteRMPXAOpexfa9w1K900VbwkwxXTpppgB1DidgbBmwS/jrPnM9LjtMUExugLC1UR0e/Hv5g2/OpNJSNnq2oCZu0KppGZPlKekRdphlNJ5TYHUjTRt7ZJh5Nqhkw9udFDt84WuwO6R4STmLyPYKGTSUksX08o0siCLNOx4jFepTbbdM+o5VMUPvxiDosBqeYwcdXfXcsoZq6+qd7IH9swEv0uJLm/XZHB88pBFG4pzSlkrQPauXEKcHwFfWvfwVBARuKsQWMZiXp6XZB6wAhKGhx/CH9PpygNcf35rkHXuDzyGWbJx2LC1AOjULz8do2M0pcfulCjIsrNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 10:45:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 10:45:07 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 07/17] iommufd: Make sw_msi_start a group global
Thread-Topic: [PATCH v2 07/17] iommufd: Make sw_msi_start a group global
Thread-Index: AQHZUVYANL+hJzdGV0WAbGKQWgB6367z1+RA
Date:   Fri, 10 Mar 2023 10:45:07 +0000
Message-ID: <BN9PR11MB5276ACE4719AA05FB1414EDA8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <7-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <7-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6745:EE_
x-ms-office365-filtering-correlation-id: 71c0eb4e-5c7e-43b7-5368-08db215483aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A32m5i8uMu5d2iWZc0BGHKRSA1UYPgrDtFx2dY5OGgdc1jRyW9tqgqPWp0Kj3aJDzP7dwnpI7GyJtENUKhRCY8fb+d1zXKqYqYowY+ambRwN8MaBDhIRlpJlQwu5Gk55V8R9KYxDTyjwCcacXyGuS05C78JJZ6aEnoxzUkDOPseQ/PvrdNVn6x9HXYT9feWE4xf+lB9B113SsPX/qRCjUfUmlg5K93PMFcIDwJ/ADD9DPtzj5OcZZWXU7mLSWEI3BPWkb789As3q3xfVqZD6Sp75HsORdw0vbW2Vaa0mmdbPszxnrWUZQOo8YmkGfUoFskE8arOYouNXhb0dqzjfAYw/weV8vXtIblwbavRq51/4mJqUbGI8V2REoU1Hd3hmv1DJnxBFZRcfZ/RKT1b4+rF3Cgfu835Uxf265ZvXCqSgWQQAf8SabrRKnnq93pVFhsAUFTRDZ/yiZEAevbHXevh22v3DeOKiUZEgYAFija791XHvkb/wPtk5NFZllTu1owVWqdYTJPe6jxVxfOdMRwrRB60W9Ytyb5V00rPZTMb40zlHd8ecR4MrZpzboliBHeOr+7wpZZMx2M+VW3GcaLzz1u2OgrVJrfvQJoysrreWWSllXEI7IXCmuJP0u6RnqB/7G9QMA4IUjRt9nSrxiw8Rl38pUKQaB1kBKtJ6GK5Cc9ku5ylx9ABlO5tmRfBllt3mz3H7DbHmEesdsqtOCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199018)(38070700005)(76116006)(2906002)(5660300002)(9686003)(26005)(8936002)(52536014)(4744005)(4326008)(66946007)(66556008)(66476007)(33656002)(66446008)(8676002)(110136005)(64756008)(316002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(478600001)(54906003)(38100700002)(107886003)(82960400001)(122000001)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XOo+g3Ib4JjZmowsosS0HC5w6FonJAsxeQCZNNfqGz5uVfI3ZKcINkq3cPoi?=
 =?us-ascii?Q?1YA6REp39nXYvOfU9mzNRZm/tXEmAzVB2B3O67sRKPl/LvacF2UyIcOBsKy6?=
 =?us-ascii?Q?0ACt3KBoAmgmEtnQlL6d5F2FWaAwfU9rGsf43sVH9eOnMXOUX9I2o4mqzoZ+?=
 =?us-ascii?Q?l64LUgdR+3CKm4+G9lHye4Z13UzmesOtCpzIgZTlbt4TH1evDglxezDNOSmm?=
 =?us-ascii?Q?7kKyPgQBACW6UAM5Jzv7xG2vf/iWTQXhcli7t5cOogl+XBcs2BRjmeromnp4?=
 =?us-ascii?Q?c/BjWuYmc1fMYKZ45N8zSPIpKCj8bOSsR9Ifg5JDMpGkT8DhpmqeUPVE/fiE?=
 =?us-ascii?Q?dmHIR8v4/DBHuJywDJfmxg7aZv3Pe77gAOAvPky9BC72pKyub4VVZ042w77M?=
 =?us-ascii?Q?yKmpz7XLv42JbeU6ViIAbISAs2NN7l9RXtkv7HqXEsEwBN/SOMs6WjuXwt9D?=
 =?us-ascii?Q?6Z1IUrGsKHSxcCAACtSAmTYrKsoQSuMKraMUcKLIH1O14lNH+kTj5Ks3O3OV?=
 =?us-ascii?Q?DYZPa21/SQC50hhFJi18Y0ciKUzVf8EIReCY3B/Z5vTeBZDNWR23lIXQRJaJ?=
 =?us-ascii?Q?US+kGozEmgYzYdLG6TpGPI97liwmPsBTRuOllJ3Z2EMSpR5+OZWq2lE0hLfY?=
 =?us-ascii?Q?ZaqKmoZHXbxjsTFQYi/Qp0YMesBxBqmKUDw/8hr7zQdMtYoN8KTFGOEs5uvK?=
 =?us-ascii?Q?GPlwNnvNvQzJheV9Qclm4PSm7FctwV2Wud2d8c30iZrI093DM0oxUcuCoUua?=
 =?us-ascii?Q?lVEODcCX7Vom1xaYQz9LeJxn5U6RC2Jyx6QtipVQBlOjP4+3Xxp6f9hj+08n?=
 =?us-ascii?Q?aizUEE2OTEbFAn9vUQ8kjrhIyB5vgbEGzLTs+2rQ+1JbMbpr04p1mIWIQhzO?=
 =?us-ascii?Q?SwOODg9hpnhW+4XRI9Y9ccQ3GjvsMaGdeaq52G+1f7+8GdeSoXR/r3zODhWe?=
 =?us-ascii?Q?NRCHgOsSJWFAeeEpsf9oVPLIyzZMOqaZwZt++1xnR894B1s5fJxqBAyZl6Rq?=
 =?us-ascii?Q?Ahl/FzHLG6vCRrAURXaE/59NIQ6YBvtC+OlnRtOZwFVdA9TmlZH70/reXjjl?=
 =?us-ascii?Q?WuZ/p4GnirLTxlnPmFpzeNFbQOGq0lcDG3VDHhM1OaEJYx74PqWG3k8OBwtR?=
 =?us-ascii?Q?HMvQBG21G/Aes7aBJLLwUF4ytdRhDiERog22FTIXYmcB0RbjP5wVS6VpZ409?=
 =?us-ascii?Q?F9Bu7wQCoIehASrRDPAJVHbK4zpiwevyOm+gZmruLcIrIoeXY4FJCOagWeNu?=
 =?us-ascii?Q?oC/5GKULF4TY9JWWpJms7uSIAKrjOhfB9syEyNDDfwHmWYlo5e+BxjQ3R/hK?=
 =?us-ascii?Q?wVQmrCMwg2iOBlWK0XF+reJZZlk7GuVIYeCwkH0Z76YVStMC2B+4FeQP920l?=
 =?us-ascii?Q?YHpEbP8IxCuO9b/FKHxmLO7nVenG5MVsnQvGzst/XVXA99MNoaYC6burW0wS?=
 =?us-ascii?Q?j9YHDE9ljdun5S2oLRdqSi7aTJ5gdu79zmmaNAmuCeZXrQDoDX/Q2nAhUGp/?=
 =?us-ascii?Q?Cfnkb1G7TOIpOVYQM+0SU+jrCOevtdyw/leKbyTX/BXwIbdtIXr9arSZ++k9?=
 =?us-ascii?Q?s8znuF6ZzwFiJum+zKIkHcry7rqSrGo/zFgNuGgj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c0eb4e-5c7e-43b7-5368-08db215483aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 10:45:07.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4NdL3POYCrvgwzHw7P9gCz84/jmJuwFVo8p+y1o/mhVBwHY5vRjXmgCOY9hgjlRHQASMKhdnT0X6xBeY9FgZkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 8, 2023 8:36 AM
>=20
> The sw_msi_start is only set by the ARM drivers and it is always constant=
.
> Due to the way vfio/iommufd allow domains to be re-used between
> devices we have a built in assumption that there is only one value
> for sw_msi_start and it is global to the system.
>=20
> To make replace simpler where we may not reparse the
> iommu_get_resv_regions() move the sw_msi_start to the iommufd_group so
> it
> is always available once any HWPT has been attached.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

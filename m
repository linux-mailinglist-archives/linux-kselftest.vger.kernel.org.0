Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267777AFAE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 08:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjI0GTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 02:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjI0GTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 02:19:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D597;
        Tue, 26 Sep 2023 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695795539; x=1727331539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ujq6kvxXA8855c8JWhbRz7xNKsYhxAlx/fG5SjhbZCk=;
  b=f7fPUZtTmks4rEIyhKopwkFtKtXNQ8AvI+5I959AtUc8P5qMm9VklwCj
   vOIjqcIEBiHD7G5Ha/7ORBybuSi2G05gBjnxAOb6UV7X8wsWNWinJ0/9w
   JF46pGUmXhJSuXFGen3eDwDfd9CAb06Qx1W/ySUEUzR3ZPaA7CR7HFZ99
   EVeiUTbLXd/9H8DTUzXPwaSJEuoql7gBUMXZZsCri5VHmPAUrxkNiaxD7
   6vWsLGWY76VDBJHcIY+dHYb91BjsW4CkUBUZMW1BtmDEp/MOPqKW4blEd
   oLBGokK6514xPR/zHevyJ5VE0pGvylnOmiPk69C9u8XCSPtkb7iVKIG4e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372076811"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372076811"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 23:18:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="698740316"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="698740316"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:18:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:18:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:18:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:18:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGyuWUnaMk+oPPsJf2KwJL7KOdfaq+4cY7+Yjn5bG2BDxjSzl/sO193OOsRAOMhNfgQOZ8KMhzgJDD/+uweO1NdHayMEviLHCB92YDUzCpkIKmEV5KS6W8cDliUHArxRsTNuwZWWDjSmTsc07ZYe0GZ+trdexz9lS+N1qrmO2mCBG1cFLNR7wqT51rkIYMpM6fsCVX+KVYoLYgwtddJz/Jo9xoW1AbhJhSDXkV+CD0P6BUfJhVURqYBChvmo1XQrRuJxrUDZXPAfa7Nm4/Gav8jwIzeLA3XAgBNcp2g1QeDV4pgjjSD3KklGK+fe22MgWIW/hJamQAPRaL+pwezYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujq6kvxXA8855c8JWhbRz7xNKsYhxAlx/fG5SjhbZCk=;
 b=NLi3+BbmtGDnm8vplHlOGh3X/IpQ5P5xN8BJdStXr5TpqAHxMkWn1vbmbLzxQlTjQDtMNgoy1jTwdjNgBwMdnb8IdseRg8M7QJXYiIP4LltPcJ7sVVDZ4VUOvenRNjaPh18p7HmJ8kAzggfAvEo7foa7twpjxLAHm3TLOxjq67+x02TSJrHPHTPI3/3UQto8CO9Cpd5y8o+5wL5J39a9Qpgf8C5d9IVCgDp18eeQZ8cfNwtxQbNgnjAThLQscfgkq9xXTeWW6ylGaGiXWxp41R2j8yfx7DCHjaTXSgNmXEM3hzPVek0goFFTX0S5rzhyRTa3l++QwQhIZhKV1KchPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:18:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:18:40 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v5 01/11] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Topic: [PATCH v5 01/11] iommufd: Add data structure for Intel VT-d
 stage-1 domain allocation
Thread-Index: AQHZ7GDojJPBJC/zbEmNoO8WS09m+bAuPAdQ
Date:   Wed, 27 Sep 2023 06:18:40 +0000
Message-ID: <BN9PR11MB5276B6897BC5EBF4B77CC0A48CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-2-yi.l.liu@intel.com>
In-Reply-To: <20230921075431.125239-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5005:EE_
x-ms-office365-filtering-correlation-id: a2a0cc49-3e31-43df-aa98-08dbbf21979c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IEVrQi42Y8Ig/AiqM0Zq/T/r60LPT9ZdjGlXqZEbfPPXjTvp91xIJeVyh1lZyDkFnYOOldFJq5h4ug3UGVZAzERRv74+SR0d2b2GCMUJRZxAcmLebXCfOhi+9UmhmUNzHEunIha8eEpeo1uhLlz/5Ma5UhR+vCSY62tiH02RakGL88pO8VU11Mvr/lSzycYoxijKUvYdAMpVRNYmMWu4kgM3Yq9PXz4MVNUQ/oRJeSNtk5IvzMpfQsmVQzetOYbucTjjB0+7+KgkadR8aRKToki7xoemWQDYYeR2AhnIzRcG8AQ+Z6jNZBsN1H5s/ARFNE3x5QgCTfUephMA+dN9+Kmi79MEZw8Tg8rD6+m2AHPVHhNw/0Rwy0/L1jTjnIyl9Fv7YFwNnxSahuYo4RRg/FixCBHZhl9Urb8oBVRWRPVeN49MyWPlwAGIcZr6zLB6ltV+Lm29XHtFQ2jLsPTi3li/lE5w717OfQ/WA4Q9i3VV6ZgxHv7FD38EwH3jdgODlHxHS38LxaJcXTKhySaBC2HaCsUXr4fWshdkhC147PUC645CpJJTVBIksK7hyNjOJnT78QLe6KYYQYWT5tSB3ve4Pzv1o/0tRLnP9kc9qi8tpH8dly6RZO6+dGxQRIkH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(41300700001)(55016003)(66476007)(64756008)(110136005)(76116006)(66946007)(66556008)(66446008)(54906003)(316002)(478600001)(71200400001)(33656002)(7416002)(2906002)(38100700002)(558084003)(86362001)(8676002)(8936002)(4326008)(5660300002)(52536014)(26005)(38070700005)(6506007)(7696005)(122000001)(82960400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?12/ykcr3Pxj1GprxzuTzzel8GYBkHNlAJ0JNs5lbomEzfewqIC7Yn2hlQurA?=
 =?us-ascii?Q?LHy3eb7vvKkPCxvKdRjBgYDKhVLzPb5xDChsmzJW1IMV8ay/hf0RWOVlCcRn?=
 =?us-ascii?Q?V2PTnlk53Y9U0svP9s7lNXrUKzoNSHkOqi0PQG8YMwzGyyP92/0DAQ1eSnER?=
 =?us-ascii?Q?1G+iFCVumw43evnYRRZzqTA6NIPy2ZTqZe0BzvBgRhj/DDyhCFFdKmU/UWt8?=
 =?us-ascii?Q?ydgrCGoAXuTgPtY5qHYaQw0QM6BDsLGJ0yi8FHJELc51O8qfqVj1+t4epTTM?=
 =?us-ascii?Q?ncU5Wta8AM5vgaJk601KYNjXTejIU7/8mQ9yqnoBEZUj4iyRGTX3RR9f+X0T?=
 =?us-ascii?Q?+bbnG6vjPn4gETfVHyL3q8FsOABD5vdedBqZTpi7EkLoFmpots0EOxbZeO2z?=
 =?us-ascii?Q?AdK5aZAYm3uCS0aCuac2iiah+u1o+S5cvFfiZZFscASt7Ki+Pj1WSXmzfLqo?=
 =?us-ascii?Q?QGjt3hPKbqqcAAdSFPDsIhF2M8RtSgsvHDKRI3HNko372ReBsCFfzmoXYoK5?=
 =?us-ascii?Q?dq+ZTSF2krrIkDHVSsRjRBhsVxWr+zN/3gh2uOdMNaWeNSLRo4kofJyvKK6A?=
 =?us-ascii?Q?dHGPwTICIatclxi7ayPYruotZDl7IHN3lYpW9iokUaNDQvwWUPxa0r/76Fjt?=
 =?us-ascii?Q?bvbiUwy23jgiynOHshTjfKxQQbpuXoZMqvWe/bNuNQpwDB98upLArFlLc9NT?=
 =?us-ascii?Q?s8OLiwPIpUo413bxrE9JIuLuowsYwv5iz75COYwUNrcCnH4utbZsipoPyv6c?=
 =?us-ascii?Q?RqlBe1sOgEcY3+O+Vumz+bQSvJpxFp1ymA625b/cVgpgRAJIO5uEqsSqhFdS?=
 =?us-ascii?Q?262mS14IMSwei8BtpWyPefYdFMq46+ubcnY1J94WYPB/VmdiJ1RifWOCRXUf?=
 =?us-ascii?Q?L11i5MkVJvjnPcXfRVkR9HrO2+BU6Iu2LjM/1QZAV6KY/kP1UVo1CFIjTbiQ?=
 =?us-ascii?Q?PF5frOVTSvvBXfALpVWHaSGLyx7YRwrc1nxW32Lh8uScpRCko3RyzZoCbwPx?=
 =?us-ascii?Q?xo0WcoKV22wMumt/oTeyuA1meCpU921eUmgTmUdgFT0RJ1OeUx6Gx4IB31bg?=
 =?us-ascii?Q?fQwQwVv8f66zTmf+ImO4AajQapHOOkHmwTV8FbOqmqvIfdyT/XZH6oa6//s6?=
 =?us-ascii?Q?N6QVCpShy7u5kVz3RzO7284QDUgULiiFK2UFlOr9Lvm0nGvqbD95ikUdoVnJ?=
 =?us-ascii?Q?BC6k8/cSn13tngtPF1LK0aBZ7rHzhLXllfAMTEx80Fuzg/2U3kxASUKTinTJ?=
 =?us-ascii?Q?JC/4NxPvjBdQlexFCKMQoEjh3HamRoauHV9iHXlytaO4lgBdrnYUSV73QNxA?=
 =?us-ascii?Q?j3L8owvPuGska4LvFmCyPxgaHVIVMPhzMEgd6vj0lWYqLpqF5E/Zh1woye6A?=
 =?us-ascii?Q?T2hBUFkJsGL3SpW9D6qjqBB0cwwryb7O1CWC4iSzP58MvGJNtfq0PaFUVbJy?=
 =?us-ascii?Q?SmGvBOtWrzGDL1Rdpxqh3/VAvnZylpTRXQU64ml5bvHK5ZaafAEG1vok6PvZ?=
 =?us-ascii?Q?s8VvCThsyKx4i1tcpcdCF+ZEdcSGE837CGwiqZsL5shcK8ETLilC5yHrBP82?=
 =?us-ascii?Q?n0r92JCsbm1uk2Ka1luwIyZtVE6VmirN5fwieOib?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a0cc49-3e31-43df-aa98-08dbbf21979c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 06:18:40.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/zWNdHNMr//Q5A0fci/uFoOB3oR/S1NdT8eNshTFLx5K4e2m2fqBgYFAUlQ363NoFkgD5G/QhGLRtnqcLgs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 21, 2023 3:54 PM
>=20
> This adds IOMMU_HWPT_TYPE_VTD_S1 for stage-1 hw_pagetable of Intel
> VT-d
> and the corressponding data structure for userspace specified parameter
> for the domain allocation.
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

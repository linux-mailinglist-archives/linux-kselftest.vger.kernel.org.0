Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52356E8A37
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 08:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjDTGPZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 02:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjDTGPY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 02:15:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3846A4;
        Wed, 19 Apr 2023 23:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681971323; x=1713507323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9rpuK9dQ8EB7r8r8qqnEIq4sLGoNavRS801QuKZkTjQ=;
  b=j8dPWLk5oEvlK4l9rtIW63R1Yqx9JaSgA/hLqe3hsEvBmCQMO9A3ZtPE
   VMIcvIDgChO+mZ6xNLPCCB08tDOM9uH/P5cTvU4vqylJHA/CCFr18Yn/O
   lTP6BSTEmF1D9VP4p1JE0Unz1LBAMhH8kZ9toTlsDxDhA8So13ry3i2/d
   8lwe2B+3nX1zgbsX43Nee3lFukrwpB2vSgKHPqGa2zmwR7zWpUadIjyyk
   +hEPDU5oShCa+wlvDuJKF4x+6Jppkgj46ePk0fH7O8Qd6XTJ3yVuT8yWa
   xOIF+RjmN+JgCjTDcdBwe5Ki1nY96F39Bae09KuQJF4v2XAgaJCleb8sY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334466720"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="334466720"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 23:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835590783"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="835590783"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2023 23:15:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 23:15:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 19 Apr 2023 23:15:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 19 Apr 2023 23:15:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 19 Apr 2023 23:15:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZy9WJzt7bQrATv1Uj9UJA0k4BidoseHrPWFh3UdXrPktX8LfWxUXd6b996BrPtTJNYGvxZHo5jB6vq4QBH4LA3bipfoyYpIcck2mLY4LN76hsOmzhncwbfoGYzx6ErsqAfwwFC4gyPABLcP6e8cvzQYDO3hDbt2OteQe6DlKij+YVqV0CjlLQ7vdmOUasUpY7HD36tF/1pbGcQgkAwYW25wX6RM4gKN1jmmtXXQGTqdNZs8uhHkLnsTa5TvcsqDGLYXRUvMSvPww15MYeOCCk3QrRNlkjqUOBp/Jf2vJT5mjWRgkY/T0sXmtuxLhnQYujTMSzmXiU6+r1vIfYalMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rpuK9dQ8EB7r8r8qqnEIq4sLGoNavRS801QuKZkTjQ=;
 b=dJPvoQX6RQA/ZCY8bNjpkkACKzBfblVKa5iJLBGbHun7HoqGXCesG0UdrPTdHFPSW/jnbkP8aOsl1vmXVrumiVwMr+T6J7rv/hLTfEQSI63ooRuM+sG85i540KM70TlPZwBMlWOma8hhJG+95s9pYi2w+NIcWF3h5G39JSIGc30hFoS5seNfzw2MKSS5BuDPEk/5ZxKJyUOQE74aGgvzh4W4HUQYmkCu9fiuPbafmLjjSC9hRv9+4YuF+l7v9l2urqdSlMO9BteT8O9zxoGw4DWltg3Ih97eK8O6XMbczfy6Wfit7Y/Zu/DC4efbH0a2907RvCa9weaKwTcLB8Gbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB7811.namprd11.prod.outlook.com (2603:10b6:208:3f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Thu, 20 Apr
 2023 06:15:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%7]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 06:15:16 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Topic: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Thread-Index: AQHZXCmFXuCDj8eADEa48b1mh4jx9a8H8avggB5ahYCAAStoMIAAMPCAgAD9cwCAAkyNgIAF7dZg
Date:   Thu, 20 Apr 2023 06:15:16 +0000
Message-ID: <BN9PR11MB5276DA68C8318CC3433252CA8C639@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDVvLbSN2TR1Er1c@nvidia.com>
 <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDaTY6OX8oR5w0uV@nvidia.com>
 <BN9PR11MB52762841AAA04A24F76A743C8C989@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDlVtcwhV2G8ZKao@nvidia.com>
In-Reply-To: <ZDlVtcwhV2G8ZKao@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB7811:EE_
x-ms-office365-filtering-correlation-id: 4712a602-2d2c-4cfd-409b-08db41669c08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GdQXAPYXxbBwo4dSFW7f8Kj89d38ehO6o0JRxUyPQZqSckJuUycjqFI7Lrk2E020TR2jpB26/rvuU99kKVIkf6JLXh9uUUUlxveONh8c2h4xMbzTL+F/3TuUynsFJnsnvfaiMBL+DPn+4QNDFSr3Kj0j2vaHSGVvhMLipuArsIMjscqV5IyLNqodvVvzTNtBEPGKngBKJmbogkFl8Whl/j9ddBPt8Ea8ye94dJkVp5U+/+e+2E0XSuOe3EkVpgdPcnDjkN49NKaO5wDG62HvB7CL5CgFsoPzK/s5MMiaD9SDaC2TWDdq4XvI1JMT6QUfRvFtS24tx2IE+inH+dDvP3VUoe6I6tOoJRNlwir2Zs/gSCrtEWcXMC6fNomLyrNu1vNRn8gxp9pa7CLiMmdeMXKaFhkdDxHEoeNcxoZznC2U0+RrZbGDZbh0Z6OMvhRXdsGDuJdBFllpe4nVYSfkPqRyHc7TH3xKRhCW2YFQkCf9U44aXVsoSPx/7zpJmG+pWeQI4gd7UfGVmI64nVlnaIQQMm+FOvg1xNnGXLHf1pO96fykzU+8JX5sBFk5XXacy5Cv3qRwTjT1RWijvZ+6aMv0fFo5OKoQf94wnh1xX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(186003)(6916009)(4326008)(54906003)(316002)(66556008)(966005)(64756008)(66476007)(76116006)(66446008)(66946007)(55016003)(478600001)(7696005)(71200400001)(8936002)(5660300002)(52536014)(41300700001)(8676002)(82960400001)(86362001)(38070700005)(2906002)(33656002)(122000001)(38100700002)(26005)(6506007)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlZHMGl3MG9XcWNiYlhCKzdnUHZoUG0zU1FGUWd0dGZKNlUxamlPL3dFQWFY?=
 =?utf-8?B?UlNxNHMrajlkbEJKT1E4L0RNUTVFMGlUTXlZY2U4QUJGb0taQzFKV1FsUEtv?=
 =?utf-8?B?c0FNOUhwQ3BaUGVPNkxDU0FOWUx6OUZzQUYvUjVVbDVpbXJPeFhhaUxLZkVp?=
 =?utf-8?B?bVlseTBEZjJFakRwNzZRRGg2bmJBdC9hWEVWMDVRekhGQnF4c1RDWjFyVy8y?=
 =?utf-8?B?TnlNTklJS3U5RjFLN2pET0M1aUh6YjFrOWZUcDc3aThMZkRvd3I2eVlBRU5S?=
 =?utf-8?B?Vm1tdFhZRjhZUERHUzRSdWNqZlc2d2p1NGp6TVdDOFFjWTl4NHhKZzBXU2hH?=
 =?utf-8?B?T3gzTTdmZE1Ydm9tSkZWWG04SXBOcjlaNzYrVDJNdEZ3L0wwZ01vT1pPU2M0?=
 =?utf-8?B?T09tZHYzT1JoN2Rjbkl5bERVRGJ2Znd6UFB4SEsvekorK3JyYWNiS2Z3TThJ?=
 =?utf-8?B?RnFIWlExQUNzd3dYVGNsZlhBa2ZIdWNMYjc2SlZCblg5a1BRSnBBUGVYSUZ6?=
 =?utf-8?B?TEw2SjlXUXZBak9wcHY3NXRRcFNBWkVoNnZPRGVTbFJyN093UXc0d01mS3p0?=
 =?utf-8?B?bWRyNERiUWRydFZBaHRiUy9KZTI1QzA1VDFhQU9DbmZRUjRGd1VXV3B6WlJk?=
 =?utf-8?B?SnA2MkpQaEVpelF0ZlkxVnJIVUNwVUpTZGZrUGc2ZlNxTVRhaHVxODdIRUFT?=
 =?utf-8?B?NTI5eTdNakwyRE1LUmMrakVkKyswZUE1K28rUkJKV3BraDdUVUUweGVpUUJj?=
 =?utf-8?B?Y2VjS2kxSDh1MkdPcitEaDF4Sk80ell0QVFRaHZCM1N6d3l1R0dyVk1KOSt4?=
 =?utf-8?B?RTVQM21yNEppTDVlbm4vRDZpQUN0YktPNDhzd2pGYytSWnNyZW5JWjZBQ1hE?=
 =?utf-8?B?VWV5b2xHV2tyQ0hWUmlib3Y0c0ExdnI3T0owVmwyR0VURjFESXBFVXFYSktP?=
 =?utf-8?B?QUNYUm9SblpNSGRuNDlzQk1TNWtGRkgzZ0o5RW13NWN5djhEVm9qRzVXcXBK?=
 =?utf-8?B?QlZpcFZnWDFHWitlZ3dXeHdpU00wcVRrdnhXOWlaM21ibmN1VmxxWU5aQVpK?=
 =?utf-8?B?ay9EdnEyVU41VHVZb2tkWFBhTzdCTGxYWUhIbzBTWkgrQXcxQW1uV09kYXFu?=
 =?utf-8?B?UWdvc2tiYjRzWWpBWXNBT1FhOEJ6Q0IxVkRwRCtkRUFZMk9IdFh1K2FkYWpx?=
 =?utf-8?B?dE5jVVZra1lTZUIyc1pEajRyOGhSUWFEdlkzWmdEWG1aVkpBL2pjWUtOTzV4?=
 =?utf-8?B?Ulh4NCtKQlVVR2tORFU1bk5RcGprUGwwdUxjc3NPcFBYemIxNzhhMUxFVjBV?=
 =?utf-8?B?OWJ2V1dQK1Q0NHNHREYyYml5dWdEVWl5QjNZbkJIOFBlZk1VUFpNYkRydTNk?=
 =?utf-8?B?akhhRXlyTEFqYVZNK1JyNXFOSC9QSkNSSkEwM0FwL1JvWFJHUUYwYXpvUHVK?=
 =?utf-8?B?WnBuU1NpanJoWDdqMk9MVTRHa0dMRkE1OUxPUnEyMENjU2RYSzNwVlI1bzQ2?=
 =?utf-8?B?a1ZLRnJaZi9JMlBNdzltMjZiSjhLbTFRVmRiVmR3Q0ZqTEFlNjBSQWV0bnhp?=
 =?utf-8?B?bXp6bjFuSnZkdmVYYW1oTFBYQ3YvZEdBOFFKSThLeWlpNUcyT00zZndYWGtv?=
 =?utf-8?B?UVA0TkRXN04xRzR5ai83SGU3REx4RWRvT2lqZWt2K1g5b1RJT0JjVWNNc0hq?=
 =?utf-8?B?QUNpZWxvUDN2QmM5N1U1YjlEYUppK2R4d0VwNDI1Y2pFVm90UkJHRVRGdVdu?=
 =?utf-8?B?ak1SZks3WnJIamZYb01BMDh6S05sMUdiT29GbzB0WEJtaHRIdUJvK0FhRHlR?=
 =?utf-8?B?enJxK0xvTndtdmI0S3EwMjFhUWVmclBJVHRadXJ2SXZVb2JqZUl4KzJxWlBW?=
 =?utf-8?B?R3JQcENyT21kWGFDWDNnOFpEdXhhdGNLL1lRWURVYjdsc29JWTVlaVJZUlFu?=
 =?utf-8?B?Q09EZVJKcG1wbXFtc0FOUkxDZUw5ZG1QYm9XSTdJTVM0cmp1YTdGM0tmd3c3?=
 =?utf-8?B?YkZNL2RJZzFNZVd1cGgvbGpDcXp4T1VUY3NDY0ZSQktNZXlxaVo4U0tqZmFS?=
 =?utf-8?B?VnlmdE1TVnYvTzVIWlpwZFNHSkJDV1RKbHk3aGFZc3loRmxUZXN0Wkx0d2Nm?=
 =?utf-8?Q?xRA2wxW54uaPTHO2AYTxP3FiW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4712a602-2d2c-4cfd-409b-08db41669c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 06:15:16.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMbWJxeVtJq146ktdnnzQS9ybTyU1e3uLNNkm/xd+TAjhmhWEzP3S3wc1q8riJur7NxarlG7ZsSVJ/2jc5FDfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBGcmlkYXks
IEFwcmlsIDE0LCAyMDIzIDk6MzIgUE0NCj4gDQo+IE9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDAy
OjUyOjU0QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTIs
IDIwMjMgNzoxOCBQTQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgQXByIDEyLCAyMDIzIGF0IDA4OjI3
OjM2QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwg
MTEsIDIwMjMgMTA6MzEgUE0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFRodSwgTWFyIDIzLCAy
MDIzIGF0IDA3OjIxOjQyQU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBJZiBubyBvdmVyc2lnaHQgdGhlbiB3ZSBjYW4gZGlyZWN0bHkgcHV0IHRoZSBs
b2NrIGluDQo+ID4gPiA+ID4gPiBpb21tdWZkX2h3X3BhZ2V0YWJsZV9hdHRhY2gvZGV0YWNoKCkg
d2hpY2ggY2FuIGFsc28gc2ltcGxpZnkgYQ0KPiBiaXQNCj4gPiA+IG9uDQo+ID4gPiA+ID4gPiBp
dHMgY2FsbGVycyBpbiBkZXZpY2UuYy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvLCBJIGRpZCB0
aGlzLCBhbmQgc3l6a2FsbGVyIGV4cGxhaW5zIHdoeSB0aGlzIGNhbid0IGJlIGRvbmU6DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzAwMDAwMDAwMDAw
MDZlNjZkNjA1ZjgzZTA5YmNAZ29vZ2xlLmNvbQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2UgY2Fu
J3QgYWxsb3cgdGhlIGh3cHQgdG8gYmUgZGlzY292ZXJlZCBieSBhIHBhcmFsbGVsDQo+ID4gPiA+
ID4gaW9tbXVmZF9od19wYWdldGFibGVfYXR0YWNoKCkgdW50aWwgaXQgaXMgZG9uZSBiZWluZyBz
ZXR1cCwNCj4gb3RoZXJ3aXNlDQo+ID4gPiA+ID4gaWYgd2UgZmFpbCB0byBzZXQgaXQgdXAgd2Ug
Y2FuJ3QgZGVzdHJveSB0aGUgaHdwdC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IAlpZiAoaW1tZWRp
YXRlX2F0dGFjaCkgew0KPiA+ID4gPiA+IAkJcmMgPSBpb21tdWZkX2h3X3BhZ2V0YWJsZV9hdHRh
Y2goaHdwdCwgaWRldik7DQo+ID4gPiA+ID4gCQlpZiAocmMpDQo+ID4gPiA+ID4gCQkJZ290byBv
dXRfYWJvcnQ7DQo+ID4gPiA+ID4gCX0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IAlyYyA9IGlvcHRf
dGFibGVfYWRkX2RvbWFpbigmaHdwdC0+aW9hcy0+aW9wdCwgaHdwdC0+ZG9tYWluKTsNCj4gPiA+
ID4gPiAJaWYgKHJjKQ0KPiA+ID4gPiA+IAkJZ290byBvdXRfZGV0YWNoOw0KPiA+ID4gPiA+IAls
aXN0X2FkZF90YWlsKCZod3B0LT5od3B0X2l0ZW0sICZod3B0LT5pb2FzLT5od3B0X2xpc3QpOw0K
PiA+ID4gPiA+IAlyZXR1cm4gaHdwdDsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IG91dF9kZXRhY2g6
DQo+ID4gPiA+ID4gCWlmIChpbW1lZGlhdGVfYXR0YWNoKQ0KPiA+ID4gPiA+IAkJaW9tbXVmZF9o
d19wYWdldGFibGVfZGV0YWNoKGlkZXYpOw0KPiA+ID4gPiA+IG91dF9hYm9ydDoNCj4gPiA+ID4g
PiAJaW9tbXVmZF9vYmplY3RfYWJvcnRfYW5kX2Rlc3Ryb3koaWN0eCwgJmh3cHQtPm9iaik7DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBBcyBzb21lIG90aGVyIGlkZXYgY291bGQgYmUgcG9pbnRpbmcg
YXQgaXQgdG9vIG5vdy4NCj4gPiA+ID4NCj4gPiA+ID4gSG93IGNvdWxkIHRoaXMgaGFwcGVuIGJl
Zm9yZSB0aGlzIG9iamVjdCBpcyBmaW5hbGl6ZWQ/IGlpcmMgeW91IHBvaW50ZWQgdG8NCj4gPiA+
ID4gbWUgdGhpcyBmYWN0IGluIHByZXZpb3VzIGRpc2N1c3Npb24uDQo+ID4gPg0KPiA+ID4gSXQg
b25seSBpcyB1bmF2YWlsYWJsZSB0aHJvdWdoIHRoZSB4YXJyYXksIGJ1dCB3ZSd2ZSBhZGRlZCBp
dCB0byBhdA0KPiA+ID4gbGVhc3Qgb25lIGludGVybmFsIGxpc3Qgb24gdGhlIGdyb3VwIGFscmVh
ZHksIGl0IGlzIGtpbmQgb2Ygc2tldGNoeSB0bw0KPiA+ID4gd29yayBsaWtlIHRoaXMsIGl0IHNo
b3VsZCBhbGwgYmUgYXRvbWljLi4NCj4gPiA+DQo+ID4NCj4gPiB3aGljaCBpbnRlcm5hbCBsaXN0
PyBncm91cCBoYXMgYSBsaXN0IGZvciBhdHRhY2hlZCBkZXZpY2VzIGJ1dCByZWdhcmRpbmcNCj4g
PiB0byBod3B0IGl0J3Mgc3RvcmVkIGluIGEgc2luZ2xlIGZpZWxkIGlncm91cC0+aHdwdC4NCj4g
DQo+IEl0IGlzIGFkZGVkIHRvDQo+IA0KPiAJbGlzdF9hZGRfdGFpbCgmaHdwdC0+aHdwdF9pdGVt
LCAmaHdwdC0+aW9hcy0+aHdwdF9saXN0KTsNCg0KdGhpcyBpcyBjYWxsZWQgdW5kZXIgaW9hcy0+
bXV0ZXguDQoNCj4gDQo+IFdoaWNoIGNhbiBiZSBvYnNlcnZlZCBmcm9tDQo+IA0KPiAJbXV0ZXhf
bG9jaygmaW9hcy0+bXV0ZXgpOw0KPiAJbGlzdF9mb3JfZWFjaF9lbnRyeShod3B0LCAmaW9hcy0+
aHdwdF9saXN0LCBod3B0X2l0ZW0pIHsNCj4gCQlpZiAoIWh3cHQtPmF1dG9fZG9tYWluKQ0KPiAJ
CQljb250aW51ZTsNCj4gDQo+IAkJaWYgKCFpb21tdWZkX2xvY2tfb2JqKCZod3B0LT5vYmopKQ0K
PiAJCQljb250aW51ZTsNCg0KdGhpcyBpcyBjYWxsZWQgYWxzbyB1bmRlciBpb2FzLT5tdXRleC4g
U28gbm8gcmFjZS4g8J+Yig0KDQo+IA0KPiBJZiBpb21tdWZkX2xvY2tfb2JqKCkgaGFzIGhhcHBl
bmVkIHRoZW4NCj4gaW9tbXVmZF9vYmplY3RfYWJvcnRfYW5kX2Rlc3Ryb3koKSBpcyBpbiB0cm91
YmxlLg0KPiANCj4gVGh1cyB3ZSBuZWVkIHRvIGhvbGQgdGhlIGlvYXMtPm11dGV4IHJpZ2h0IHVw
IHVudGlsIHdlIGtub3cgd2UgY2FuJ3QNCj4gY2FsbCBpb21tdWZkX29iamVjdF9hYm9ydF9hbmRf
ZGVzdHJveSgpLCBvciBsaWZ0IG91dCB0aGUgaHdwdCBsaXN0X2FkZA0KPiANCj4gVGhpcyBjb3Vs
ZCBtYXliZSBhbHNvIGJlIGZpeGVkIGJ5IGhvbGRpbmcgdGhlIGRlc3Ryb3lfcndfc2VtIHJpZ2h0
IHVwDQo+IHVudGlsIGZpbmFsaXplLiBUaG91Z2gsIEkgdGhpbmsgSSBsb29rZWQgYXQgdGhpcyBv
bmNlIGFuZCBkZWNpZGVkDQo+IGFnYWluc3QgaXQgZm9yIHNvbWUgcmVhc29uLi4NCj4gDQo+ID4g
YnR3IHJlbW92aW5nIHRoaXMgbG9jayBpbiB0aGlzIGZpbGUgYWxzbyBtYWtlcyBpdCBlYXNpZXIg
dG8gc3VwcG9ydCBzaW92DQo+ID4gZGV2aWNlIHdoaWNoIGRvZXNuJ3QgaGF2ZSBncm91cC4gV2Ug
Y2FuIGhhdmUgaW50ZXJuYWwgZ3JvdXAgYXR0YWNoDQo+ID4gYW5kIHBhc2lkIGF0dGFjaCB3cmFw
cGVycyB3aXRoaW4gZGV2aWNlLmMgYW5kIGxlYXZlIGlncm91cC0+bG9jayBoZWxkDQo+ID4gaW4g
dGhlIGdyb3VwIGF0dGFjaCBwYXRoLg0KPiANCj4gWWVhaCwgSSBleHBlY3QgdGhpcyB3aWxsIG5l
ZWQgbW9yZSB3b3JrIHdoZW4gd2UgZ2V0IHRvIFBBU0lEIHN1cHBvcnQNCj4gDQo+IE1vc3QgbGlr
ZWx5IHRoZSByZXNvbHV0aW9uIHdpbGwgYmUgc29tZXRoaW5nIGxpa2UgUEFTSUQgZG9tYWlucyBj
YW4ndA0KPiBiZSB1c2VkIGFzIFBGL1ZGIGRvbWFpbnMgYmVjYXVzZSB0aGV5IGRvbid0IGhhdmUg
dGhlIHJpZ2h0IHJlc2VydmVkDQo+IHJlZ2lvbnMsIHNvIHRoZXkgc2hvdWxkbid0IGJlIGluIHRo
ZSBod3B0X2xpc3QgYXQgYWxsLCBzbyB3ZSBjYW4gdXNlIGENCj4gbW9yZSByZWxheGVkIGxvY2tp
bmcuDQo+IA0KDQpZZXMgd2l0aCBwYXNpZCB0aGVyZSBpcyBubyByZXNlcnZlZCByZWdpb24gY29u
Y2VwdHVhbGx5LiBDdXJyZW50bHkgaW4NCm91ciBpbnRlcm5hbCBpbXBsZW1lbnRhdGlvbiB3ZSBz
dGlsbCBhZGRlZCB0aGUgcmVzZXJ2ZWQgcmVnaW9ucyBvZg0KdGhlIGRldmljZSB0byBJT0FTIHVw
b24gcGFzaWQgYXR0YWNoIHdoaWNoIGxvb2tzIHVubmVjZXNzYXJ5Lg0KDQpCdXQgSSBkaWRuJ3Qg
Z2V0IHdoeSBhIGRvbWFpbiBjYW5ub3QgYmUgc2hhcmVkIGJ5IFBBU0lEIGFuZCBQRi9WRi4NClVw
b24gYXR0YWNoIHdlIGFkZCB0aGUgcmVzZXJ2ZWQgcmVnaW9ucyAoaWYgYW55KSBvZiB0aGUgZGV2
aWNlIHRvDQpJT0FTLiBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGEgcmVxdWlyZW1lbnQgdGhhdCBy
ZXNlcnZlZCByZWdpb25zDQptdXN0IGV4aXN0IGZvciBhIHN1Y2Nlc3NmdWwgYXR0YWNobWVudD8N
Cg0KQSBzaW1pbGFyIGV4YW1wbGUgaXMgb24gSmFjb2IncyBETUEgQVBJIFBBU0lEIHdvcmsuIFRo
ZSBETUENCmRvbWFpbiBpcyBmaXJzdCBhdHRhY2hlZCB0byBSSUQgYW5kIHRoZW4gdG8gYSBQQVNJ
RC4NCg==

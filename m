Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C3C7D0699
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 04:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjJTCoG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 22:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTCoF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 22:44:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7DD12F;
        Thu, 19 Oct 2023 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697769843; x=1729305843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RO9Ok8na7RsOa8Cmh7Hv4QAMcTdsh23PHONOhb0pju0=;
  b=WtySqLoJ3bc9axF2yAw3BJT4xKU/UrKYBIu0OED8XD8bNX5bpP1lpd2B
   YGecoRyaksgIUYwj+Gc1f/LT2r3Gl1Jl5w+HH0ou89AN7B50bvA/vmjjK
   DURvFIQdiMnN6sDofNZz6mY1nPO9mWRneHvh6WttKXNTBFCtUlEkWRtzI
   GwUaoQF+hwe1VWgE3RAEeQPwDaht43i9ZuaXntkJNwU2iEGerffmyGrSx
   +ASMB9MMnLmtvdHXb5YA0oYuTUAiojIOUeHbJEuXtacLlRsZRedyIsF8j
   ptm+UuK5olS6F4cqhdRLsR32QSAtQFtQw7ruW4ugATUoa72OOJM3BE4XE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="366650499"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="366650499"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 19:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="1004456764"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="1004456764"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 19:44:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 19:44:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 19:44:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 19:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw0F5qYqWPtG0PPOcoDlNER3McYqDv262Bg51QxSBDC8Kxs9gACXgCJ17ewK6ExKGIUPwc7oDEmfNK6SF1iAPbaAYl9a9ZRHDcgoIP45JiogV2w9UROXZ4lnGa6nOt6wcw5akqDOd+EctA9hjYxrAdp+T2pR0hoN4tF4Xgg2qjrl/+rP/HIBEJNCLhgNtUJX8KVoN8xlUa2C0AyYo9EY1HiFYzLJ2U/EitrcFOQye1DMZH3JcJPThiJvAxV+duCWAMGRpJhBpNi6b6ty7SfmcK7jgRaqzcRNMQf+OElsuDkVuhDnIXqnK0be2p+kUZGBUUnwscuKY4gxLVDfuYH8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RO9Ok8na7RsOa8Cmh7Hv4QAMcTdsh23PHONOhb0pju0=;
 b=RT+H71HwcPtKjgns8Q6CV5osQ351aph6IelQAPmav5VYd1cX5GaJSeTJ4z6EZdb5dFyDRN2VxWin1y+ggYfBhMyJwBg+X7MtS4VjZC1Lj2vaMchfVyi+PNYf3f3J4EIcgxIo0J+ETvbn5QQ5Z+R49OEcU46uUFh9i020klxcabMkvsoJjor1T0yXq5BUhuWcpvW8TKup93kDzH70K2vszxWOM+x08E+OTFYOc8G+uIy3XNdoGO+86gA9lNDf1v97QHfSkDrSIJm8uv9ssPW9TysWq/gVPU/A16eETx5J0L/DIoXmmOoCzs/SfFFYtetlF6LZB3yfY6HfcjN5nSy6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 02:43:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 02:43:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Topic: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Thread-Index: AQHZ7GCNzWxyrCHnVkqPkBvqOzEqrbAsylxggBvMMACAA6lO8IAAN00AgAFSUcCAAIHKgIAARKGAgAFd9oCAAJQLIIABdF4AgAAqZRA=
Date:   Fri, 20 Oct 2023 02:43:58 +0000
Message-ID: <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com> <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
In-Reply-To: <20231019235350.GY3952@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7790:EE_
x-ms-office365-filtering-correlation-id: 84491bbc-101e-46e4-79f9-08dbd1166955
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yvf3lBIhyp5vn6UcVG9PWZs1sjq0wR3wBzxGqIVJhkDOpQxlGuDyi5IW4jmZ3oqkFi08vRycOdSzxtfFAYFcHx2UCX8KFfYXDYF8s7et1+BGq6ZNDR9xBvgSjM/J70Pb2nfhCdCAFuLTsWHe9Llp/jeWaOjyHCbX+HPuvXeQcyyhXhvUI9h2Wu0Yc7BMFyV5Al7uniRsXbr/IDSOHmMLd+LDxvdXImKkaDvdxP/4Y7QvL8XpWami0nwRN3kZ5wwT11lE/VYl9WOsa+rsU8WYsfoqiHw4LX+igbloJonA1eW73h2rzZdpp40ZuYUG8kYX0xjd4OqzS9N3KpVWek/lLl5Ij8Cw8GZQ2dIlnLILaFcburWzgtkHnrj/jWX2fyaUb/pMLtKNfD2hJgoFgLE++NTFW5IR4k/lOsgInKo/HsVrNhlk9zgMWH9ONvsPVbUYZPF1z+Tz5tYse0Hi+IggMUQ+gHof1DBr/0zjz6KlGl/OXjIW4aPe4Nlk9abaBh6rbgQJX9dJWprgmG7dVVxOkAonvHMxgzpWJ/BqLr/2hdG3ulxT1lEbR/ymwPtYqAxOwIh0xnfeGbJjgK9zOP3t1flEjo5GKJxeVNcvgqJ+ZBkaJlPwQTHemlVMvjHAr1Oa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(122000001)(6916009)(478600001)(82960400001)(86362001)(33656002)(5660300002)(52536014)(8676002)(8936002)(7416002)(4326008)(41300700001)(83380400001)(2906002)(38100700002)(9686003)(7696005)(6506007)(71200400001)(26005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUNUTW9VQ01veU5mY0oxZjN4eE1mUDYwWW10NFNKZnV6WHFIQk4wZGJwRk93?=
 =?utf-8?B?aUg3S0JRcHduekFyWG1aOCtRek9yNzBDOStBSmN0VElsSU5OU1lkUE9JU2ls?=
 =?utf-8?B?R0kxeVoxQk16Y2lPeXVqSThUR0RkNHppSlBTNXcyc0J3Y2RobmlRUW1nK2Ny?=
 =?utf-8?B?c3ZPTWdiakpxVHk1enlzOGc1MHJDaUJqNTBaMTRHRzhjbTcxV040M1FxcTZp?=
 =?utf-8?B?VC9TQ1ZjbTlnNW1yNlRVOE9UcisxNENibnJ0VFZaSVNoeW9vaTJ0dzNEMlVZ?=
 =?utf-8?B?WTU3ZzlybCt4WHhaUStabFBiS1hUcU1tOW9PZFB0TjdQQzhwczJodG9YNWRV?=
 =?utf-8?B?bnVIbU5xUXd4a3ZyMTM3R1JoN3R0Tmw2MEpMdHN1UGZma245S3lnMTE2d1J0?=
 =?utf-8?B?TTM1K1ZZYlJpNkVJUmIvMEVXOFhyZmtCcXFkR1I0V09QbllaQk9DNWEwSFN2?=
 =?utf-8?B?YmJ6bkNpenlqc2FGWitNeENlSjE4UUNDNlcrWmV0bEw0MTJBenU2MnEvZXN2?=
 =?utf-8?B?Y09vSHdkYmhiZGFxYkJvL0hYdEVFSjk1U3BZZll3enJjd3JUMzZLRXBHM3JV?=
 =?utf-8?B?TWcwbi9kb3M0WGVLdXJFK2w0aE4xcjdKelJRaG5YZUUxdzE1TTh2UVNHUFBw?=
 =?utf-8?B?N2VLQTJlWE5LV0xOV1g5N05kbkpwamZjUG1DSDdFb2JrMi9HcWRpRFBqWTlV?=
 =?utf-8?B?NElQVm83NWowbWs4cEpmTlQ2cVVsdG1ZWTA1QkNIeVBoQktlQThJT1RKS1NU?=
 =?utf-8?B?NVlJZExMbkdmUXBpSnpZWE9NcTlkZnozSkFHck1EK2ZuNFZHYWlqQzg2Q1N3?=
 =?utf-8?B?RjVOTlRCNUVqZXBGK05DRG9udU5Ud0xBWkFnS0VmTlJ3MG1xK3BqWHZoSERz?=
 =?utf-8?B?dnhUSWR6eE1JMHdPeEhhdlR3WlFFUjIrM3BiQXF3ODh2THNGMDJSU3N2UFZn?=
 =?utf-8?B?Sm5QVXB6YzVscEQ5YzJ1ZEtBSWZ3MXBTVG1Sd3NKbUIvM24xZE5oRkpBSTlN?=
 =?utf-8?B?TmUwQXdyek5TVlBxbm5EQVhZVmljdFpaaG5TV3BmaHE2L203cFRoMC9pK1BI?=
 =?utf-8?B?RWlvRVJvVnZHVmx6bUlUQ294VTk0bE4xNXNObGsrcU9BZ2RFQnNGa2xnNTRP?=
 =?utf-8?B?UkE4NzE2T1BvamVaZ0R1WTFnNnk5Yk9BODJqcDE2cXZGcUdxOG5uL0lWT1Ew?=
 =?utf-8?B?UWhhMlRkNlNJNTV3KzVtV2FsY3Jjb2pKeHh0a1pVaFNSZCtSdFZ1emJQMmNj?=
 =?utf-8?B?Z2lSS25sY2UraDd5Uno4L0lXdHFRME02V0xsdml0U085Q2JTUEhEQk4rbDl4?=
 =?utf-8?B?cWZiTkxZckpvcEQzNkcxRytsUzRGWWFpR2dJU0FNaS8vRXNDQUsxZ2g0K2FE?=
 =?utf-8?B?QjB3NmM2UGsyNm94WWp0b0diUktvcFg1a1RhcFMzclNMMzZVamJUeW9JZS9R?=
 =?utf-8?B?dW9TVUpTc2FPWFNYUUQwUFMxUk0vSENKMXZBanJsZTBQZjJhSEhOZk1rOWti?=
 =?utf-8?B?dUVBVm9UREpLVHpZRW4yQ25pMmhkZHJDS3h2a0g2QmNjRTFMem1UUm9yQWcy?=
 =?utf-8?B?c2V0ek1SM1NPNERzc3RLbnpPNWZKRkhjNllIN2ZzSDhKZWdSZGpNL3lqZVhJ?=
 =?utf-8?B?b1JuOHV3Qm0xWU9pVWZjUVl4RmJmVVpWY2xHbVltTUFoS3UvVDdSelZnSGtl?=
 =?utf-8?B?V3dTbTNYZGRhb3pEZ3g3bWt2V1JmQkNTUnI2MnR0bVpTT3JlN1d1eEVHMURF?=
 =?utf-8?B?UjVpMFZ1cVhYbUQ0VkhpSm1OdDNKVFB3L3hSOWNvRkdxUWJ6QjViUStUQ3hR?=
 =?utf-8?B?eXlzRnFZQUtYdE0way82SGpoY1l6NkhKUStXcFJwRTByVUxzeUNHYXFYTk1N?=
 =?utf-8?B?dERlMWlSUVRoM3NUYlF5MW5icTJDRk5TMEdUV2xkK3dMZEZZWmdoek4vdzV0?=
 =?utf-8?B?VXlzcTFLTFNzSE53S0hKV2NDSE5UZitTMGsrajU4NVlxSHdRL1VuYWoyYU5t?=
 =?utf-8?B?dzdsdzFoWC9TY3FtODhXR3F6NzQ1MnNOdTJJVFBwajhDY2svZ09tY1VUcGlE?=
 =?utf-8?B?OW1JdVEzWHVWM2NjN3hOanVidXpzTVlTMEVKd0RWOFRuM3IwN2tqRHJsL05y?=
 =?utf-8?Q?nPJyuRKkrQEID4IFeCErLcier?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84491bbc-101e-46e4-79f9-08dbd1166955
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 02:43:58.9534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEtKmWyuPs3uEEL4w0/au7V/7+g4vhljN++W4Y462OBcaFO5VmN++NBxNMuTk5Nk6EPLxf6jGlyu3qFXvKOKSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgMjAsIDIwMjMgNzo1NCBBTQ0KPiANCj4gT24gVGh1LCBPY3QgMTksIDIwMjMgYXQg
MDE6NTY6MDFBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiA+ID4gT3RoZXJ3aXNl
IHdlIGhhdmUgYSBwcm9ibGVtIHdoZXJlIHRoZSBvcmRlciBkZXZpY2VzIGFyZSBhdHRhY2hlZCB0
bw0KPiA+ID4gdGhlIGRvbWFpbiBkZWNpZGVzIGhvdyBtYW55IGRvbWFpbnMgeW91IGdldC4gaWUg
dGhlIGZpcnN0IGRldmljZQ0KPiA+ID4gYXR0YWNoZWQgZG9lcyBub3Qgd2FudCBDQyAoYnV0IGlz
IGNvbXBhdGlibGUgd2l0aCBpdCkgc28gd2UgY3JlYXRlIGENCj4gPiA+IG5vbi1DQyBkb21haW4N
Cj4gPg0KPiA+IGluIGF1dG9kZXRlY3QgbW9kZWwgdGhpcyB3b24ndCBoYXBwZW4uIElmIHRoZSBm
aXJzdCBkZXZpY2UgaXMgY2FwYWJsZQ0KPiA+IG9mIGVuZm9yY2VfY2MgdGhlbiB0aGUgZG9tYWlu
IHdpbGwgYmUgY3JlYXRlZCB3aXRoIGVuZm9yY2VfY2MuDQo+ID4NCj4gPiB0aGVyZSBpcyBubyAi
ZG9lcyBub3Qgd2FudCBDQyIgaW5wdXQgaW4gYXV0b2RldGVjdC4NCj4gPiA+DQo+ID4gPiBUaGVu
IGxhdGVyIHdlIGF0dGFjaCBhIGRldmljZSB0aGF0IGRvZXMgd2FudCBDQyBhbmQgbm93IHdlIGFy
ZSBmb3JjZWQNCj4gPiA+IHRvIGNyZWF0ZSBhIHNlY29uZCBpb21tdSBkb21haW4gd2hlbiB1cGdy
YWRpbmcgdGhlIGZpcnN0IGRvbWFpbg0KPiB3b3VsZA0KPiA+ID4gaGF2ZSBiZWVuIGZpbmUuDQo+
ID4NCj4gPiB0aGVuIGluIHRoaXMgY2FzZSB0aGUgMm5kIGRldmljZSB3aWxsIHJldXNlIHRoZSBk
b21haW4uDQo+IA0KPiBUaGVuIHlvdSBoYXZlIHRoZSByZXZlcnNlIHByb2JsZW0gd2hlcmUgdGhl
IGRvbWFpbiB3aWxsIG5vdCBiZSBDQyB3aGVuDQo+IGl0IHNob3VsZCBiZS4NCg0KSWYgdGhlIGRv
bWFpbiBoYXMgYmVlbiBub24tQ0MgaXQncyBwZXJmZWN0bHkgZmluZSBmb3IgdGhlIDJuZCBkZXZp
Y2Ugd2l0aCBDQw0KdG8gcmV1c2UgaXQuIEFzIGxvbmcgYXMgdGhlcmUgaXMgb25lIGRvbWFpbiB3
aXRoIG5vbi1DQyB0aGVuIEtWTSBoYXMgdG8NCmhhdmUgc3BlY2lhbCB0cmVhdG1lbnQgb24gd2Jp
bnZkLiBJbiB0aGlzIGNhc2UgdGhlcmUgaXMgYWN0dWFsbHkgYSBiZW5lZml0DQp0byB1c2UganVz
dCBvbmUgbm9uLUNDIGRvbWFpbiBmb3IgYWxsIGRldmljZXMgKGVpdGhlciBub24tQ0Mgb3IgQ0Mp
Lg0KDQpXaGF0IHdlIHdhbnQgdG8gcHJldmVudCBpcyBhdHRhY2hpbmcgYSBub24tQ0MgZGV2aWNl
IHRvIGEgQ0MgZG9tYWluDQpvciB1cGdyYWRlIGEgbm9uLUNDIGRvbWFpbiAgdG8gQ0Mgc2luY2Ug
aW4gYm90aCBjYXNlIHRoZSBub24tQ0MgZGV2aWNlDQp3aWxsIGJlIGJyb2tlbiBkdWUgdG8gaW5j
b21wYXRpYmxlIHBhZ2UgdGFibGUgZm9ybWF0Lg0KDQo+IA0KPiA+ID4gSG90cGx1ZyBpcyBhbm90
aGVyIHNjZW5hcmlvICh0aG91Z2ggSW50ZWwgZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgaXQsDQo+
ID4gPiBhbmQgaXQgbG9va3MgYnJva2VuKQ0KPiA+DQo+ID4gQ2FuIHlvdSBlbGFib3JhdGUgaG93
IGhvdHBsdWcgaXMgYnJva2VuPyBJZiBkZXZpY2UgaXMgaG90cGx1Z2dlZCBhbmQNCj4gPiBmYWls
ZWQgdG8gYXR0YWNoIHRvIGFuIGV4aXN0aW5nIGRvbWFpbiwgdGhlbiBhIG5ldyBvbmUgd2lsbCBi
ZSBjcmVhdGVkDQo+ID4gZm9yIGl0Lg0KPiANCj4gQSBub24tY2MgZG9tYWluIHdpbGwgYXNrIHRv
IGJlIHVwZ3JhZGVkIGFuZCB0aGUgZHJpdmVyIHdpbGwgbGV0IGl0DQo+IGhhcHBlbiBldmVuIHRo
b3VnaCBpdCBkb2Vzbid0L2Nhbid0IGZpeCB0aGUgZXhpc3RpbmcgSU9QVEVzDQoNCmlvbW11ZmQg
c2hvdWxkIG5vdCBhc2sgZm9yIHVwZ3JhZGUgYXQgYWxsLiBUaGUgQ0MgYXR0cmlidXRlIG9mIGRv
bWFpbg0Kc2hvdWxkIGJlIGZpeGVkIHNpbmNlIGNyZWF0aW9uIHRpbWUuDQoNCkJhb2x1IHdpbGwg
Zml4IHRoZSBpbnRlbC1pb21tdSBkcml2ZXIgYWNjb3JkaW5nbHkuDQoNCj4gDQo+ID4gdGhlcmUg
aXMgaW5kZWVkIGEgYnJva2VuIGNhc2UgaW4gS1ZNIHdoaWNoIGNhbm5vdCBoYW5kbGUgZHluYW1p
Yw0KPiA+IGNoYW5nZSBvZiBjb2hlcmVuY3kgZHVlIHRvIGhvdHBsdWcuIEJ1dCB0aGF0IG9uZSBp
cyBvcnRob2dvbmFsIHRvDQo+ID4gd2hhdCB3ZSBkaXNjdXNzZWQgaGVyZSBhYm91dCBob3cgdG8g
ZGVjaWRlIGNjIGluIGlvbW11ZmQuDQo+IA0KPiBUaGF0IHRvbw0KPiANCj4gPiA+IFJlYWxseSwg
SSBoYXRlIHRoaXMgQ0MgbWVjaGFuaXNtLiBJdCBpcyBvbmx5IGZvciBJbnRlbCwgY2FuIHdlIGp1
c3QNCj4gPg0KPiA+IEludGVsIGFuZCBBTUQuDQo+IA0KPiBOb3BlLCBBTUQganVzdCBoYXJkd2ly
ZXMgdGhlaXIgSU9NTVUgdG8gYWx3YXlzIGRvIENDIGVuZm9yY2luZy4gQWxsDQo+IHRoaXMgbWVz
cyBpcyBvbmx5IGZvciBJbnRlbCBhbmQgdGhlaXIgd2VpcmQgSU9NTVUgdGhhdCBjYW4gb25seSBk
byB0aGUNCj4gZW5mb3JjZW1lbnQgZm9yIGEgR1BVLg0KPiANCj4gPiA+IHB1bnQgaXQgdG8gdXNl
cnNwYWNlIGFuZCBoYXZlIGFuIGludGVsICd3YW50IGNjIGZsYWcnIGZvciB0aGUgZW50aXJlDQo+
ID4gPiBuZXN0aW5nIHBhdGggYW5kIGZvcmdldCBhYm91dCBpdD8NCj4gPg0KPiA+IEkgZGlzbGlr
ZSBpdCB0b28uIEJ1dCBzdGlsbCBub3QgZ2V0IHlvdXIgcG9pbnQgd2h5IGFkZGluZyBzdWNoIGEg
ZmxhZw0KPiA+IGNhbiByZWFsbHkgc2ltcGxpZnkgdGhpbmdzLiBBcyBleHBsYWluZWQgYmVmb3Jl
IHRoZSBvbmx5IGRpZmZlcmVuY2UNCj4gPiBiZXR3ZWVuIGF1dG9kZXRlY3QgYW5kIGhhdmluZyBh
IHVzZXIgZmxhZyBqdXN0IGFmZmVjdHMgdGhlIGRlY2lzaW9uDQo+ID4gb2YgY2Mgd2hlbiBjcmVh
dGluZyBhIGh3cHQuIHdoZXRoZXIgd2Ugc2hvdWxkIHVwZ3JhZGUgaW4gdGhlDQo+ID4gYXR0YWNo
IHBhdGggaXMgYW4gb3J0aG9nb25hbCBvcGVuIHdoaWNoIGltaG8gaXMgdW5uZWNlc3NhcnkgYW5k
DQo+ID4gTmljb2xpbmUncyBwYXRjaGVzIHRvIHJlbW92ZSB0aGF0IGNoZWNrIHRoZW4gYWxzbyBy
ZW1vdmUgdGhpcw0KPiA+IHBhdGNoIG1ha2VzIGxvdCBvZiBzZW5zZSB0byBtZS4NCj4gDQo+IEkg
ZG9uJ3QgdGhpbmsgd2UgY2FuIHJlbW92ZSBpdCwgaXQgaXMgc3VwcG9zZWQgdG8gcHJvdmlkZSBj
b25zaXN0ZW5jeQ0KPiBvZiByZXN1bHQgcmVnYXJkbGVzcyBvZiBvcmRlcmluZy4NCj4gDQoNCldo
byBjYXJlcyBhYm91dCBzdWNoIGNvbnNpc3RlbmN5PyBzdXJlIHRoZSByZXN1bHQgaXMgZGlmZmVy
ZW50IGR1ZSB0byBvcmRlcjoNCg0KMSkgY3JlYXRpbmcgaHdwdCBmb3IgZGV2MSAobm9uLUNDKSB0
aGVuIGxhdGVyIGF0dGFjaGluZyBod3B0IHRvDQogICAgZGV2MiAoQ0MpIHdpbGwgc3VjY2VlZDsN
Cg0KMikgY3JlYXRpbmcgaHdwdCBmb3IgZGV2MiAoQ0MpIHRoZW4gbGF0ZXIgYXR0YWNoaW5nIGh3
cHQgdG8NCiAgICBkZXYxIChub24tQ0MpIHdpbGwgZmFpbCB0aGVuIHRoZSB1c2VyIHNob3VsZCBj
cmVhdGUgYSBuZXcgaHdwdA0KICAgIGZvciBkZXYxOw0KDQpCdXQgdGhlIHVzZXIgc2hvdWxkbid0
IGFzc3VtZSBzdWNoIGV4cGxpY2l0IGNvbnNpc3RlbmN5IHNpbmNlIGl0J3Mgbm90DQpkZWZpbmVk
IGluIG91ciB1QVBJLiBBbGwgd2UgZGVmaW5lZCBpcyB0aGF0IHRoZSBhdHRhY2hpbmcgbWF5DQpm
YWlsIGR1ZSB0byBpbmNvbXBhdGliaWxpdHkgZm9yIHdoYXRldmVyIHJlYXNvbiB0aGVuIHRoZSB1
c2VyIGNhbg0KYWx3YXlzIHRyeSBjcmVhdGluZyBhIG5ldyBod3B0IGZvciB0aGUgdG8tYmUtYXR0
YWNoZWQgZGV2aWNlLiBGcm9tDQp0aGlzIHJlZ2FyZCBJIGRvbid0IHNlZSBwcm92aWRpbmcgY29u
c2lzdGVuY3kgb2YgcmVzdWx0IGlzIG5lY2Vzc2FyeS4g8J+Yig0KICAgIA0K

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478296C61A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjCWI3F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjCWI3C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:29:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8AA15C8F;
        Thu, 23 Mar 2023 01:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679560141; x=1711096141;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ipQl/2QuuSErDwe3ZHAP627ICp5i8lxPj1AJTDCvJLE=;
  b=fSggHi/j59+NbOiHl3DLrhLAyQP2yap2wyONjPYjAXYTwJwHWm07fuLq
   Pw65Lc17C7FRlxHAtJ2Ntxc4hI9Q7rcgY528ts9qCrZPHSTI2oAul3ZZN
   uA/Sl39blmq0IIZ/TEk61G5hKDah/IC4j9OMD1HT0uIOwPp+Wh6YSdae5
   F0voh+VCGSvYNDr7iRQHqw7bC87rwN/B3L2Rj7lRmT3bjbtXU8T+JAXmK
   WiIjRvp2IA0YOjdN+VAdreus3pV8AsXs3NZtAdnPG/o7Nuo76bCoyOEsr
   Acxk14Mgue7becV23kdOtnpiGJ1YkkRpao5ErHGcC+bZPy4FzwdIE1imL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319080986"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319080986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 01:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="751398492"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="751398492"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2023 01:28:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:28:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 01:28:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 01:28:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 01:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRrgMi1elAKUYwgtRjdID9FXBQWWHiQIwe9pl27zkBNkezXzv5MXSI3ysWfppL1cAnYkNXm3x69K97/OBmVA55ub0w+7HCKXLkVtTxldb5qRzG1rvdpJhh4lAj1vRMFCOhdGgLbSLF4dXNwIhT1FR/JUYgZi3C4/rxh30Y/WkgemW5/+bQxWH/Dwo3KRtjlG+kpHXX9n2zyl7Q0D7AMmzTxcaLEJGzAMvpE+dA2moHAPlJP8ILkkA9mK9iyys5XMADeln5VYZvtTLhgFO69MHFmsTjjopAbbImk32tLQrt/RfFzFyk7k9dRs9lJ4a2uByJQcS0QI4I1ZDOX01FfItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipQl/2QuuSErDwe3ZHAP627ICp5i8lxPj1AJTDCvJLE=;
 b=MBN5b8qTMojIO7AgY5sIzIEr7bfmxNp+T1aXflGx2Jq3uKrFuRRUN31OVKXHwiUt3mHMov/MieA2nRwRswT1pd+7cvvNMgaJfSnWs1jfNiJjLGd7vrihPA7VaIbK/htgp8+YK96TJ4g+GEVIR0Efddd3UD8Cv2wmpHh5nn4CMSbiTsnfqC1th3WlIOX0G8h2zHfu6cLBT7GJPZUn06yHdQGQxYaZzc0lnEQGbK5PW7wzfx3dlhzUTU7TmnbMng7lONMR2UYItBp5SKH8AdFli5qTJxM+1oNwQjhtd+TLYRyIMrrCFublrrRkBit8RU48jXorYfFXWYLJnRjSknLh9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4991.namprd11.prod.outlook.com (2603:10b6:a03:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 23 Mar
 2023 08:28:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::6f7:944a:aaad:301f%8]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:28:39 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Thread-Topic: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Thread-Index: AQHZUl5/crYV8FrgA0CauavbhCdtA67zSlUAgABKJICAFIFFUIAAA92AgAAERLA=
Date:   Thu, 23 Mar 2023 08:28:39 +0000
Message-ID: <DS0PR11MB7529C206C62FFEF3D37EEE7EC3879@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
 <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
 <ZArTN9tIDKuvmuje@Asurada-Nvidia>
 <DS0PR11MB7529C74B5A37F745AD822C5FC3879@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZBwJ3SrTZpM1fW8D@Asurada-Nvidia>
In-Reply-To: <ZBwJ3SrTZpM1fW8D@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4991:EE_
x-ms-office365-filtering-correlation-id: b47ab272-df81-4a4b-7655-08db2b789ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zRR4NgUyYv60soTCs8wj0jqixqCaAeDpZwtjHOegYby1sijnKyv2qxvd6TTcz1yJVMIBGMqGzpJf4lg/iukUV+Exdym9TMRuInDRKSCBBL2dMCH1HqE+TaPqEuvZp37lgUGh5sxfKqCmFB8dIRjnvOswldSNblOespCTAPaU/MP73Cm7RqcO0uqzTj/JVK6bx4giVstrHDJDnd8+FL35UqMEPC3KdMa1wVsSQuq/WT7sn8hJh1EvpHTYIKGVLUFVNIBTLlDT/SpOaf5ZpBdhv5x7Y1EnRZxrCSjCOElGZZhn4ogdAU0uEjRqFmR6+mXY14cLAVoIcG1i8Ski9g6o0vBSQbXuezgRnjLsaEoAw8n1Zu0EIXnvqOgyWjEgegsxRckKD23nfBQn0gTqxCsI3aLYhD1EcEaIoq7Ff121pExf7kG6q/fCb0pT+kiuGus2qHPVEzoSIgTgV3/s6yxwsxpxEtb7It/xkIZV2TAwY3zPfKS4zdxwJBs6vigUT+ZJTUcL0Cbu+gGRd8mEEGamNADtvo5MPXjY9iTp7OMzAwwETrVXGTquQO6IV/+I+PumhvLJpo8+LhFbLjXUpG+GWuRBeTqcgZneE8aTVFbM9CqCsny6MBdugjEsxqf5O+iKifCpD87buOsLzGSqoDJgFdl5yn7J0QAmjc6lyaj313cYtX9CIwJtm00Cs8NIVS9qZIAJDGNkqm2bAnY6UOdk/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(38070700005)(82960400001)(52536014)(2906002)(122000001)(33656002)(8936002)(41300700001)(76116006)(54906003)(9686003)(53546011)(5660300002)(186003)(26005)(6506007)(316002)(83380400001)(55016003)(71200400001)(478600001)(8676002)(64756008)(6916009)(86362001)(7416002)(66476007)(66946007)(4326008)(66556008)(38100700002)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1lZWGRGN09ZY0xwY2Jya0dSYWZWVnpVeUJQd2RlTHlKVjlNWEl4Q1FtdnF4?=
 =?utf-8?B?a05DNjhkNlo5UnVEUEVrMkx3MkVYbTB2bU9TeVFXcW92YnZGWlU1ZkNlSU05?=
 =?utf-8?B?K0trWTVvYUJ5Q2o4NUw5RjQ3S0M5bVRMeGVNWHNURXJXUU5iMFlFYmJOUzVM?=
 =?utf-8?B?Vmt0WTFNWGRSVC9zaFJ0Yk9Sc2hwemdRZlVuNXZZWE5sZkFGWlpVSVlYUi8w?=
 =?utf-8?B?R3B1aXNsdzFhZUVBeVk0YzI2dHRCMnNtSEIxWjU2MVNxZElPUVljQ1phUHQz?=
 =?utf-8?B?Y0IyTS8zTmVxaU9haTBvTTZNYUMzNGdyQWQzdXZ4QkJ0MWx0alg5QVExQzlh?=
 =?utf-8?B?bnVLeVltNHdJYkFxNzlna1FwSnU5a3lHYnVjYW94V3hON1huTmh2M1VUM0NB?=
 =?utf-8?B?UjB6Zngrc2p0eEpnMFJDeGF6NTZRNWxVc1hPU0g0dDZKOS9YSmR2Q3BSTVhp?=
 =?utf-8?B?S1E5RHFOZDdkWUlFbWhDS1pGZ2FGZmUxUWliWGdUdFI1czZaZUE1RlY1UDc4?=
 =?utf-8?B?b0ZUZlpSMnZpcWpXVGNyTjh6NnpWdUNsNG1oM0ZYbDk3ZTRoWFp3NVBpWkt4?=
 =?utf-8?B?ck1aMmRtT0RjOXFzNCtjTUJDUElndGdyb21GajlGU0prMnB4WCtlbFVNNFhM?=
 =?utf-8?B?eXMyc0FMNEZDR1RCNmFCdXB2a2dzZ1cwNXArK05nNXFpckRWamo0T2hkeDRx?=
 =?utf-8?B?eUxVZWgyVk1TU1BoNHVXelM3dUc5a0J4VU1nSkpyWU9vdCs5ZzlQR2s1VTlR?=
 =?utf-8?B?NTM5SW80WGJmQnVVZ0RrVGJKaFNlR2Z4OWVCTWNjM3RtR2FHZlFmWE9HaHpO?=
 =?utf-8?B?RHVlVWlpTTBqN2ZqRjdScEJyWlFmazJISzU4S3BXamxrelBwckJGdVlKdENX?=
 =?utf-8?B?MWVmZlA5QzRYd3NsRElScU4wb0dIZlVwZEtUT1lqU0UyaHpPR2ZacXRGWEVm?=
 =?utf-8?B?MzV6MFdKbExSZmNjMFRTOG12TmV5cUJmVnljb0FnRDRnZ1MvMC9IZ0hrY1lv?=
 =?utf-8?B?WWovcHkvVDNsWnlSbzFqQURYNjlXS21xZ0Z0Mlp4eFQxVms0bjgyc0lyY05V?=
 =?utf-8?B?ZlZwZDllaE5paG1zUHliVGVJM3lFVDdIOUpvSFdUQXNUdVVXTHpLQ3FiblNF?=
 =?utf-8?B?UmVBblNRWmtCczR3NzF1Z05HdzMvcWwwdVZxbWhMMHhQTnNQU1BHdEtsSmRt?=
 =?utf-8?B?bjFCYU5wQkFHNjFyd0dpditYSXZ6bElhSmczN1VtelJENm1pMk8vai9ycVBO?=
 =?utf-8?B?eDM1Y0ZHTkxlSmhUdVJJRnpWQ3FDbHBKMDFPRWlkM1M3U3ByWEF0Ukx2VVkx?=
 =?utf-8?B?SEpQR1BVNGIxd1RtMCtyemxlM1BBNFBuQkp5Sjl4MlliTjRLL3BGMENLaFdR?=
 =?utf-8?B?MTk5eTNxTUJVUmxDQzhJUEZneW9haHNFRVZ1RzI3WFczT2ViRmIxQTlhNzdI?=
 =?utf-8?B?WDlKY2pFMlJMclk1UnR2TVNpQTh3bUtZanQxaEd4Yi9sMU5IdkVLYjZWVWty?=
 =?utf-8?B?bE9hZ3RaOVBTSE1aM2JZaWhPSUNxZ3FDaG45Z2doZ1FNVDg2c2pMa0tuSFlY?=
 =?utf-8?B?QkxMREU1bWdYR0NjN08yK0w1NmI1ZjJ2aHVkY3VDalAybW5UUVJOSHVvRXJM?=
 =?utf-8?B?b21IcEVReEJYU0UwK1ZTeDFTb1IyMUlqV3F4M01JaW1QZTlTd3lvT3VOdko5?=
 =?utf-8?B?WDlNdElwaFcwM1hqOThxek9BTC9neHQ4VVlBVktpbkdpV1R6aXdER0dldXdC?=
 =?utf-8?B?dGxPSFJ2RXlrRGVBYVh4Uk1RdkhpbDZzd2M0U1lkNDlJK1dGV2svZ0VTcjRW?=
 =?utf-8?B?eFNURDlrdGMvbFdvRStnWk0weldsTEx5akNuYVdGZ0Iya1djc1h6VVdWTEVk?=
 =?utf-8?B?Y0Q1UFZveUQvOFhiejNaWUJVUWpNeTdQNUJvaVZLRVhrYVlrYnlCc3p5dkUv?=
 =?utf-8?B?TVZvU2gzeUc4OHM4N1pzNXVhS2tzUGFKN29OcFBRTFBOTzR6VFRzUit2Mm5y?=
 =?utf-8?B?ZHpXRWhsWG5NRURNQVltTEMwbkdxMDlrS2xOMFI4RjRqQU1LWVFHSUtDanhS?=
 =?utf-8?B?WDZhcTlobUFtcWhrcXE1SFY3WUdONDZVMkQwQVY4ZDNTU1JQZWFCL3ZXV1Uv?=
 =?utf-8?Q?/J5r0lb7hMTEKk7UxSitPo0/2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47ab272-df81-4a4b-7655-08db2b789ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:28:39.5003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoMAO8BgVtIffInkCv+QxL3vwdD4AXx/Mg5baA6lsRBKVqz2ieXOmnIcRc6IMyD+vCJ4rzVA/br7vWDMvGBV7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4991
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAyMywgMjAyMyA0OjEyIFBNDQo+IA0KPiBPbiBUaHUsIE1hciAyMywgMjAyMyBh
dCAwODowNjoyNkFNICswMDAwLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPg0KPiA+DQo+ID4g
PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4gPiBTZW50OiBG
cmlkYXksIE1hcmNoIDEwLCAyMDIzIDI6NTEgUE0NCj4gPiAgPg0KPiA+ID4gT24gRnJpLCBNYXIg
MTAsIDIwMjMgYXQgMTA6MjU6MTBBTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4gPiA+IEV4
dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE9uIDMvOS8yMyA0OjA5IFBNLCBZaSBMaXUgd3JvdGU6
DQo+ID4gPiA+ID4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gQSB1c2VyLW1hbmFnZWQgaHdfcGFnZXRhYmxlIGRvZXMgbm90IG5l
ZWQgdG8gZ2V0IHBvcHVsYXRlZCwNCj4gc2luY2UgaXQNCj4gPiA+IGlzDQo+ID4gPiA+ID4gbWFu
YWdlZCBieSBhIGd1ZXN0IE9TLiBNb3ZlIHRoZSBpb3B0X3RhYmxlX2FkZF9kb21haW4gYW5kDQo+
ID4gPiBsaXN0X2FkZF90YWlsDQo+ID4gPiA+ID4gY2FsbHMgaW50byBhIGhlbHBlciwgd2hlcmUg
dGhlIGh3cHQgcG9pbnRlciB3aWxsIGJlIHJlZGlyZWN0ZWQgdG8gaXRzDQo+ID4gPiA+ID4gaHdw
dC0+cGFyZW50IGlmIGl0J3MgYXZhaWxhYmxlLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+ID4gPiA+IC0tLQ0K
PiA+ID4gPiA+ICAgZHJpdmVycy9pb21tdS9pb21tdWZkL2h3X3BhZ2V0YWJsZS5jIHwgMjANCj4g
KysrKysrKysrKysrKysrKysrLS0NCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9od19wYWdldGFibGUuYw0KPiA+ID4gYi9kcml2ZXJz
L2lvbW11L2lvbW11ZmQvaHdfcGFnZXRhYmxlLmMNCj4gPiA+ID4gPiBpbmRleCAxNmU5MmExYzE1
MGIuLjZlNDVlYzBhNjZmYSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lv
bW11ZmQvaHdfcGFnZXRhYmxlLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lvbW11
ZmQvaHdfcGFnZXRhYmxlLmMNCj4gPiA+ID4gPiBAQCAtNDMsNiArNDMsMjMgQEAgaW50DQo+IGlv
bW11ZmRfaHdfcGFnZXRhYmxlX2VuZm9yY2VfY2Moc3RydWN0DQo+ID4gPiBpb21tdWZkX2h3X3Bh
Z2V0YWJsZSAqaHdwdCkNCj4gPiA+ID4gPiAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gPiAgIH0N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ICtzdGF0aWMgaW50IGlvbW11ZmRfaHdfcGFnZXRhYmxlX2xp
bmtfaW9hcyhzdHJ1Y3QNCj4gPiA+IGlvbW11ZmRfaHdfcGFnZXRhYmxlICpod3B0KQ0KPiA+ID4g
PiA+ICt7DQo+ID4gPiA+ID4gKyAgICAgaW50IHJjOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
ICAgICBpZiAoaHdwdC0+cGFyZW50KQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgaHdwdCA9IGh3
cHQtPnBhcmVudDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgaWYgKCFsaXN0X2VtcHR5
KCZod3B0LT5od3B0X2l0ZW0pKQ0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
ID4gPiA+DQo+ID4gPiA+IFdoYXQgaXMgYWJvdmUgY2hlY2sgZm9yPyBJcyBpdCAidGhlIGh3cHQg
aGFzIGFscmVhZHkgYmVlbiBpbnNlcnRlZCBpbnRvDQo+ID4gPiA+IHRoZSBod3B0IGxpc3Qgb2Yg
aXRzIGlvYXMgaW4gYW5vdGhlciBwbGFjZSI/DQo+ID4gPiA+DQo+ID4gPiA+IElmIHNvLCBpcyBp
dCBwb3NzaWJsZSB0aGF0IGh3cHQgd2lsbCBiZSBkZWxldGVkIGZyb20gdGhlIGxpc3QgZXZlbiB3
aGVuDQo+ID4gPiA+IHRoaXMgdXNlciBod3B0IGlzIHN0aWxsIGxpbmtlZCB0byB0aGUgaW9hcz8N
Cj4gPiA+DQo+ID4gPiBJdCBtZWFucyB0aGF0IHRoZSBod3B0IGlzIGFscmVhZHkgbGlua2VkIHRv
IHRoZSBpb2FzLiBBbmQgdGhlDQo+ID4gPiBod3B0X2l0ZW0gY2FuIGJlIG9ubHkgZW1wdHkgYWZ0
ZXIgYSBkZXN0cm95KCkuDQo+ID4gPg0KPiA+ID4gV2l0aCB0aGF0IGJlaW5nIHNhaWQsIGFmdGVy
IEkgdGhpbmsgaXQgdGhyb3VnaCwgcGVyaGFwcyBZaSdzDQo+ID4gPiBwcmV2aW91cyBjaGFuZ2Ug
cmVtb3ZpbmcgaXQgbWlnaHQgYmUgYmV0dGVyLiBTbywgaXQgY291bGQgYmU6DQo+ID4gPg0KPiA+
ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gKyAgICAgLyoNCj4gPiA+ICsgICAgICAq
IE9ubHkgYSBwYXJlbnQgaHdwdCBuZWVkcyB0byBiZSBsaW5rZWQgdG8gdGhlIElPQVMuIEFuZCBh
IGh3cHQtDQo+ID4gPiA+cGFyZW50DQo+ID4gPiArICAgICAgKiBtdXN0IGJlIGxpbmtlZCB0byB0
aGUgSU9BUyBhbHJlYWR5LCB3aGVuIGl0J3MgYmVpbmcgYWxsb2NhdGVkLg0KPiA+ID4gKyAgICAg
ICovDQo+ID4gPiAgICAgICBpZiAoaHdwdC0+cGFyZW50KQ0KPiA+ID4gLSAgICAgICAgICAgICBo
d3B0ID0gaHdwdC0+cGFyZW50Ow0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgaWYgKCFsaXN0X2VtcHR5
KCZod3B0LT5od3B0X2l0ZW0pKQ0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiA+
DQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPg0KPiA+ID4gSSB3YXMgY29uY2Vy
bmVkIGFib3V0IHRoZSBjYXNlIHdoZXJlIGEgZGV2aWNlIGdldHMgYXR0YWNoZWQgdG8NCj4gPiA+
IHRoZSBuZXN0ZWQgaHdwdCB3aXRob3V0IHN0YWdpbmcgYXQgdGhlIHBhcmVudCBod3B0IGZpcnN0
Lg0KPiA+DQo+ID4gSSB0aGluayBJIHdhcyBjb252aW5jZWQgd2l0aCB0aGUgcmVhc29uIHRoYXQg
dGhpcyBoZWxwZXIgbWF5IGJlDQo+ID4gY2FsbGVkIGJ5IGFsbG9jYXRpb24gZm9yIGJvdGggc3Rh
bmRhbG9uZSBzMiBod3B0IGFuZCB0aGUgbmVzdGVkDQo+ID4gaHdwdC4gU28gbXkgY2hhbmdlIHdh
cyBub3QgZW5vdWdoLiBZb3VycyBjb3ZlcnMgYm90aCBjYXNlcy4NCj4gPg0KPiA+ID4gQnV0LA0K
PiA+ID4gdGhlIGxpbmsgYmV0d2VlbiB0aGUgcGFyZW50IGh3cHQgYW5kIHRoZSBJT0FTIGhhcHBl
bmVkIGluc2lkZQ0KPiA+ID4gdGhlIGFsbG9jYXRpb24gZnVuY3Rpb24gbm93LCBub3QgYXR0YWNo
KCkgYW55IG1vcmUuDQo+ID4NCj4gPiBOb3QgcXVpdGUgZ2V0LiBUaGlzIGhlbHBlciBpcyBhbHNv
IGNhbGxlZCBpbiB0aGUgYWxsb2NhdGlvbiBwYXRoLiBJcw0KPiA+IGl0PyBBbnlob3csIHdpdGgg
SmFzb24ncyBjb21tZW50LCB0aGlzIGhlbHBlciBtYXkgYmUgcmV3b3JrZWQuDQo+ID4gV2UgY2Fu
IHN5bmMgbGF0ZXIgb24gdGhlIG5leHQgdmVyc2lvbi4NCj4gDQo+IFdlIHByZXZpb3VzbHkgaGFk
IHRoaXMgbGlua19pb2FzKCkgaW4gYXR0YWNoKCkgcm91dGluZSBzbyB3ZQ0KPiBuZWVkZWQgdG8g
bWFrZSBzdXJlIGh3cHQtPnBhcmVudCBnb3QgcG9wdWxhdGVkLCBiZWNhdXNlIHRoZQ0KPiBkZXZp
Y2UgY291bGQgYmUgYXR0YWNoZWQgdG8gYW4gUzEgSFdQVCBkaXJlY3RseS4gQnV0IG5vdyB0aGlz
DQo+IGlzIGluIHRoZSBhbGxvYygpIHJvdXRpbmUsIHNvIGJ5IHRoZSB0aW1lIGFuIFMxIEhXUFQg
aXMgYmVpbmcNCj4gYWxsb2NhdGVkLCBhbiBTMiBIV1BUIG11c3QgYmUgYWxsb2NhdGVkIGZpcnN0
IGFuZCBwb3B1bGF0ZWQNCj4gYWxyZWFkeS4NCg0KQWhhLCB5ZXMuIPCfmIoNCg==

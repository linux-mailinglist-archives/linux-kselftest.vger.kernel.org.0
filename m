Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2236691D3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjBJKu5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 05:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjBJKux (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 05:50:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5C87070B;
        Fri, 10 Feb 2023 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676026249; x=1707562249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a55fRo74+8Mu1QNnkzCq6AXB9Re5vV/B9Z91bJdAQnM=;
  b=baeNdGndIY1uiI4Pl93kYkcmPlKpyOG9IY3yyJ7Z9ggEOG3iq7TM+pTx
   xyLKoavct7auocW2vSUZzgyFrHye2pC5X9W35ANzr9nYPKYx57Xt1t3fc
   un/3/Gb/L8gln92Iqf7eH+UwBtBt3GPHojl/cP9rmAYUwPvqPlnusFS6H
   GPDRZjRjmgXGTNeZdFo0/gy6SeWMdKDGvRlOfaAlAcIcNS8m3roeBLwoS
   X0PLuy0CYg2P8lz2MrjmeS3l9qFrOQArY5UQziH7KBXiadjQ97FOrhqUP
   Q/Zj7LbrBFnjepG3p9JESaHMRC7zBNGPRILoM7DexL5NQDRPNSNJU6BJM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="394996516"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="394996516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 02:50:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="698393216"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="698393216"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 10 Feb 2023 02:50:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 02:50:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 02:50:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 02:50:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7/GZvgErLiQ2x5MpiI7cwv3cxLtfkqfig+wHKrOQ1MXGn3dzc1d4aQcL2jbXhvpsEaXBs0z+JJwXoxRGK/stXglhpxRXBPiIZD01kXgS4YHzAj0yMrE9s7il5AHVtvM4NWHspDDoklwa0PUvJsq/3VeqetZjh+kKUcQ2ZzRam8E9sxO+pJ7nRj5lCx9awFvpKRBmyT1YNdNKq7NaXLqKZPRgbOwkreeWInoYz+El/TOzSDNhV8vmTcHr1kp+pYeNYSyHsIYNF+wAdEddrti1ePocldjzO/N6xfS6gstw9WF0u9mbmE8qDU6FvBPL9kiRqDjmF4gjkk7yECZ3XZXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a55fRo74+8Mu1QNnkzCq6AXB9Re5vV/B9Z91bJdAQnM=;
 b=ZU7GbN9d6YX+i0hPKUQA1YHvvXhlu4K7ZwJ0IFHlk2ttRWXWozeHWr7iiy0ohjfFfwsTr5zXu0WATFwTz9BhWh0qspf/Q7aNtvCz0rOYtCIGvxKu34I13rhbrEp8zYBp1TH4kqZQLvN9BR4bNwu7AozVViXQj3JNwmmWk8VAsrPfNLyQMptb6QTwxvoylbmKkiceSbaVIVEa0ksp7dhBJbwZseM/fsXEum6djiX58+/ncwDJ11kV6tbaNFtNhFXi3L+htvBGTvPjaS6JYKDSyGZF2vsKYgY67h1xbo5KKrW26lPqezchujvPX4Cm9Pq5G+MqGEtv3pXtOXqgVGtc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7438.namprd11.prod.outlook.com (2603:10b6:806:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 10:50:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e1fa:abbe:2009:b0a3%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 10:50:45 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Matthew Rosato <mjrosato@linux.ibm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Thread-Topic: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Thread-Index: AQHZPD99j/B0LRcf/USAxI2Rmg3VDq7G6CYAgAAKS4CAABTfgIAADXGAgAAcugCAAM+uEA==
Date:   Fri, 10 Feb 2023 10:50:44 +0000
Message-ID: <DS0PR11MB7529C0BFC9527D6A64DE20E2C3DE9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
 <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
 <Y+U9QX4p5YX3/B3k@nvidia.com> <Y+VOw6dTnGapMm9L@Asurada-Nvidia>
 <Y+VaCV7DRR1+mLYY@nvidia.com> <Y+VyIvKYmCdMG5i7@Asurada-Nvidia>
In-Reply-To: <Y+VyIvKYmCdMG5i7@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|SN7PR11MB7438:EE_
x-ms-office365-filtering-correlation-id: 6b318280-9f54-44ac-9396-08db0b54a923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jS0X/GkIwKPprH8pSBCYXQgWgd4fevzeAMOADO3J1nfQ+tlVulWZq0V9IEk5ghJw5Im8WRZ1zIPhzSr3sGgNav65ujPZG7WRAXHsGy1RqBbII48xpfwVFjmLnWJbJkgleA6dKo4inqayNz0Phy7fS0+jOfl0sWC3hcIZYckeAs7SrdpDzCNW3UBo7GhaX96Is4/4BxVglidDlAVKR/Y0UEO9rwcmhKxzADV4NkrrCHULz8nEl1jPzrNd1XhIz13jdrEeZJhhxUwtamCkkyUUJZ+e7xqvptXzfsH8dzVD8/r15TgWXbmiXuJFvdBGwVDPPKzEAvpOQJPoibdEbcv4LNV2k7kMmMWUj+TkKcqXxmULDEsfZtPLVIb5F4sSIYRYtCjpBxCEdBD8FDWrVjRKXADVEofe4ZcrYYyaGrzuye6zp+T2/jKKQM8nmHUCWcRQ4m1dx6oS2Kw6U6PqVDfTASIZNjqS+cNjercb9IshDGnjno0LLuEvI26r1pP0CTUn4RNG/yHZYviJdbhTIWC2rMa+jXGLDDhwHrGG+R2ZGaK/rLURJt807uZisSSksX9gOoo8umu6dqxAjckZRBbrjJUIeVz5oHgFRtDP2w9l8AlhRXJuLmpHCsujQWmMWed+iD3ugv+SsHHEyaGY14iCuWsj8IyedCbadtKVjs3xoBYIQeFvFFX8Wv0KOoUVpE8kcheif0mMgdGg3lN2UW0V9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199018)(38070700005)(5660300002)(55016003)(26005)(7416002)(86362001)(186003)(8936002)(122000001)(38100700002)(9686003)(83380400001)(33656002)(76116006)(41300700001)(54906003)(110136005)(66946007)(4326008)(316002)(64756008)(66476007)(66446008)(8676002)(66556008)(6506007)(7696005)(478600001)(82960400001)(52536014)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2V1RGJWYlAzRGlBZFZTMUlFOUtYZTRYcFFpZWMxWTJ6K1Y4RVQ2ckMwQkhB?=
 =?utf-8?B?ZkpkRDJKc0kxRU16SXJjNmhNc1Y3VDlwREN5RVdZK0hJSGVRdUVQTFgrbXFy?=
 =?utf-8?B?ZWY4aDlZVWQzdDJrUDgwekFtWnhwV3NDa1RlckhxSSs5TFY5ZEdDUDBObFhj?=
 =?utf-8?B?WjNScnNXN1pLRCtJMTZyUmF6WEFNdnc0T2VpMzFyQStFNmpqSXcxSGxRYUtI?=
 =?utf-8?B?ejBzSkZUVDRJd2JrMFdvNEREc0ZPRWZLdUVBaHQ1WEo5SmtiM28wMFFCb2VV?=
 =?utf-8?B?OW0yQWE1L1Q1QlpvQUtMNzdVNmh3MkFzNFc3cXRCc2lpbnYzaG5TSTcwcm9u?=
 =?utf-8?B?K2doSm15ekZzTUp4RDlvNnhBeGRWd0JnZUVBWmFnTVdiZU5HU3FNdzBTbjBv?=
 =?utf-8?B?ektwQ05qOFdHdTh4OTBoRkNmbUV3ejF1QzNGNEVaUWNkR2EzYjRDK0hpT0xE?=
 =?utf-8?B?aDVSSTR1RDRrQ2lSdVlySGhsT3o0eERzUDQzRW55RHdwVWlyYzYva1JQMzdB?=
 =?utf-8?B?cEg3QWNlSEhldEJGdnkyODVycWwvaUFBNC8wVnJJVmZtU09lWHlnSjRDZFdJ?=
 =?utf-8?B?Q3BZSXdyOFNxc0g3azdMQTI1ckJxdFIzazMxVFh2RDVINWsvaTVLU0NicE5L?=
 =?utf-8?B?VDJsWU05TzVaWHcwM1dnT0grWDhtYVFMK3hlYS9sOUY4NGtnQnhGbkZ0aVRG?=
 =?utf-8?B?WlJFbTFZSDJGMFc1MHNlVG9vN2FiT01OKzY0N2dwWHBYSkNZbk5LNllLcEhi?=
 =?utf-8?B?blJsd05wdUJXODQ5Z3FyRU5EVGJrSmpzWll0R01haTBPMXI2WjUxOVIrS1Nj?=
 =?utf-8?B?R3NLc3JYSk50WFpFOW92b1hJMjB1a1FML01KWXFGM2tDUlVIdEFaSU9HN0dt?=
 =?utf-8?B?cUpQU1Fpb05NR05zWWJoUTZURitiajNCQTFacndQbnhJVk1JZGU2N0VGQncv?=
 =?utf-8?B?Skw0ZzFERkJSc0M0UXlQb3k5ZWw0SFM5YWQrUmRPS0YvSllKN2NrWnE0c0k3?=
 =?utf-8?B?ditESUFUM3FwYUNheWdBa0E5VUV4dnRoVnl2bEZrVElxdjVGSkM0cGVjanpD?=
 =?utf-8?B?c3dwRTlLL2ovZkZJckkzNGt0cnpaODAyL0V4Tng3TnJMN2dZOXluTEJBVit5?=
 =?utf-8?B?SHlCNFBBVUd4YXFPcFRjN1lBYUFJUVcvSUc1R1FIT1dPV1REOWwwZWNxZ3RT?=
 =?utf-8?B?VmdyN2NFbkZzcFdJVVpMdk4yTWF4Q2kwd3dlQ01FbDlhMDF3NkdMdGJXSEVw?=
 =?utf-8?B?aC9wWGZuTFVoTDFvMnZlV2VYTUVockEzMlA0L3FueU5XSVduTDdkYklKTTkr?=
 =?utf-8?B?NlNUQ2xlb2lrdXRiSUdOZEpTYkNpSHhqN1V6TmZpcGhZS1cxYmZzbGRZUnRj?=
 =?utf-8?B?bVNaSVpoL1lCN2c5dW1IZ2RTTjZ6Z2hNb1JqS0dsWDZ0OVloaTJ0NUpKQVVX?=
 =?utf-8?B?NWp4WUJvUTBIWEd6d0VlYXNNRHpVcWFqclFEQ1A3SjRFOEVzYmZjZDgvbGRM?=
 =?utf-8?B?c0xrUmFlUFIrUHA5M1ZybWxZbW9hV2x5eTNQVENFcmFJNXRXeG9FS1cxVG5B?=
 =?utf-8?B?UG1WMDFETVRkMy9rSVBPck95Y3pFUUQxY2p2NEh4U3lFUDd5N2xVU0c4ak11?=
 =?utf-8?B?VHk1S3RXNGpaUlhQYzhYVEdQcjlJbGdIRllyWGgzSGNQcHRseG4yaGZRbGor?=
 =?utf-8?B?Tk9HU3FTVGRaMmFqb0NScFN0NkpuWmJkcFRQSE5XYUpReTA3dEJzV2padmZV?=
 =?utf-8?B?Q2xqZ3JMZWswSE1jejB6WmdmSEVDNjRoa2FLaUFpWTVlTEFvLzhSNmg1VU9o?=
 =?utf-8?B?eSt3K0t0QUJ4NjJLZ3ZWMW5wZTU4V1V0OFFhUTVrby9LalBlVjRXWWVENmIw?=
 =?utf-8?B?MGN4Q2NLUHBZc1hwbm92Qk1DTHk2ZXVtRms5eEMzUXdIaTIrUTdZUVc0RzdH?=
 =?utf-8?B?WFVybExBTDg0dGxib2hZcUVRVVVNYnRTWVNvdllITjhIMVhzdDhkNzZSM0pi?=
 =?utf-8?B?czVleFdBUG85ajhLMUVMOGhLTEp3ZUhWMTMwODJLNEtHMHh4WUxQSmhJbUZ1?=
 =?utf-8?B?NS9xc1N3RFlDRitpZ1BVei9qSUNpdGY4bjlTeFkrUjRjV3EwM1dhdHp3QjJJ?=
 =?utf-8?Q?A6aDhMXYh1rOtQOZ+qgC3GIUD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b318280-9f54-44ac-9396-08db0b54a923
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:50:44.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWqXCbS2vTxo/EcQUMHtju2/TyWY6OdiV8ngOqsKE3ZbPrQ/odM2Hj9rQGU4aNyrIpsIk0s2izXXLjRj66HbdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7438
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgRmVicnVhcnkgMTAsIDIwMjMgNjoyMiBBTQ0KPiANCj4gT24gVGh1LCBGZWIgMDksIDIwMjMg
YXQgMDQ6Mzk6MzdQTSAtMDQwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFRodSwg
RmViIDA5LCAyMDIzIGF0IDExOjUxOjMxQU0gLTA4MDAsIE5pY29saW4gQ2hlbiB3cm90ZToNCj4g
PiA+IE9uIFRodSwgRmViIDA5LCAyMDIzIGF0IDAyOjM2OjQ5UE0gLTA0MDAsIEphc29uIEd1bnRo
b3JwZSB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCBGZWIgMDksIDIwMjMgYXQgMTI6NTk6NThQTSAt
MDUwMCwgTWF0dGhldyBSb3NhdG8gd3JvdGU6DQo+ID4gPiA+ID4gcmVhbGx5IHNob3VsZCBoaWdo
bGlnaHQgdGhhdCkuICBPdGhlcndpc2UsIGNvbmRpdGlvbmFsbHkgY2FsbGluZw0KPiA+ID4gPiA+
IGlvbW11X2RvbWFpbl9hbGxvYyhkZXYtPmJ1cykgd2hlbiAhb3BzLT5kb21haW5fYWxsb2NfdXNl
cg0KPiAoaW5zdGVhZA0KPiA+ID4gPiA+IG9mIHJldHVybmluZyAtRU9QTk9UU1VQUCkgc2VlbXMg
dG8gcmVzdG9yZSB0aGUgcHJpb3IgZnVuY3Rpb25hbGl0eQ0KPiA+ID4gPiA+IGZvciBtZS4NCj4g
PiA+ID4NCj4gPiA+ID4gWWVzLCB0aGF0IGlzIHJpZ2h0IGlmIHRoZSBpbnB1dCB1c2VyIGRhdGEg
aXMgMCBsZW5ndGggb3IgZnVsbCBvZiAwcw0KPiA+ID4gPiB0aGVuIHdlIHNob3VsZCBjYWxsIHRo
ZSBub3JtYWwgZHJpdmVyIGZ1bmN0aW9uDQo+ID4gPg0KPiA+ID4gTWF5YmUgSSBhbSB3cm9uZywg
eWV0IEkgcmVjYWxsIHRoYXQgZG9pbmcgb3BzLT5kb21haW5fYWxsb2NfdXNlcg0KPiA+ID4gd2l0
aG91dCBhIGZhbGxiYWNrIHdhcyBpbnRlbnRpb25hbCB0byBydWxlIG91dCBkcml2ZXJzIHRoYXQg
ZG9uJ3QNCj4gPiA+IHN1cHBvcnQgSU9NTVVGRD8NCj4gPg0KPiA+IEkgdGhpbmsgd2UgbW92ZWQg
YXdheSBmcm9tIHRoYXQgdG8gdGhlIGlkZWEgb2YgdXNpbmcgdGhlIGRtYV9kb21haW4NCj4gPiBw
YXRjaCBJIHN1Z2dlc3RlZC4uDQo+ID4NCj4gPiA+IFRvIGJlIGJhY2t3YXJkLWNvbXBhdGlibGUg
YW5kIGNvbmNlcm4gYWJvdXQgU01NVSwgd2UgY2FuIG9wdCBpbg0KPiA+ID4gb3BzLT5kb21haW5f
YWxsb2NfdXNlciB1cG9uIGF2YWlsYWJpbGl0eSBhbmQgdGhlbiBhZGQgYSBmYWxsYmFjazoNCj4g
PiA+DQo+ID4gPiAJaWYgKCghb3BzIHx8ICFvcHMtPmRvbWFpbl9hbGxvY191c2VyKSAmJiB1c2Vy
X2RhdGEpIHsNCj4gPiA+IAkJcmMgPSAtRU9QTk9UU1VQUDsNCj4gPiA+IAkJZ290byBvdXRfYWJv
cnQ7DQo+ID4gPiAJfQ0KPiA+ID4NCj4gPiA+IAlpZiAob3BzLT5kb21haW5fYWxsb2NfdXNlcikN
Cj4gPiA+IAkJaHdwdC0+ZG9tYWluID0gb3BzLT5kb21haW5fYWxsb2NfdXNlcihkZXYsIE5VTEws
IE5VTEwpOw0KPiA+ID4gCWVsc2UNCj4gPiA+IAkJaHdwdC0+ZG9tYWluID0gaW9tbXVfZG9tYWlu
X2FsbG9jKGRldi0+YnVzKTsNCj4gPiA+IAlpZiAoIWh3cHQtPmRvbWFpbikgew0KPiA+ID4gCQly
YyA9IC1FTk9NRU07DQo+ID4gPiAJCWdvdG8gb3V0X2Fib3J0Ow0KPiA+ID4gCX0NCj4gPiA+DQo+
ID4gPiBZZXQsIGV2ZW4gYnkgZG9pbmcgc28sIHRoaXMgc2VyaWVzIGhhdmluZyB0aGUgUEFUQ0gg
MDcvMTcgdGhhdA0KPiA+ID4gbW92ZXMgaW9wdF90YWJsZV9hZGRfZG9tYWluKCkgd291bGQgdGVt
cG9yYWxseSBicmVhayBJT01NVUZEIG9uDQo+ID4gPiBBUk0gcGxhdGZvcm1zLCB1bnRpbCB3ZSBh
ZGQgdGhlIG9wcy0+ZG9tYWluX2FsbG9jX3VzZXIgdG8gU01NVQ0KPiA+ID4gZHJpdmVycy4NCj4g
Pg0KPiA+IERyb3AgcGF0Y2ggNyBhbmQgOA0KPiA+DQo+ID4gQ2hhbmdlIHBhdGNoIDEyIHNvIGl0
IGhhcyBhIHVuaXF1ZSBmbG93IHRvIGFsbG9jYXRlIGFuZCBJT0FTIG1hcCBhDQo+ID4gSFdQVCB0
aGF0IGRvZXMgbm90IHRyeSB0byBzaGFyZSBzbyBtdWNoIGNvZGUgd2l0aCB0aGUgZXhpc3Rpbmcg
Zmxvdy4NCj4gPg0KPiA+IFRoZSBIV1BUIGZsb3cgc2hvdWxkIGFsd2F5cyBqdXN0IGNhbGwgYWxs
b2NhdGUgYW5kIHRoZW4gbWFwIHdpdGggbm8NCj4gPiBlZmZvcnQgdG8gYXR0YWNoIGZpcnN0LiBU
aGlzIHdpbGwgZmFpbCBvbiBBUk0gU01NVSBhdCB0aGlzIHBvaW50LCBhbmQNCj4gPiB0aGF0IGlz
IGZpbmUuDQoNCk9rLiB0aGlzIHNvdW5kcyBpb3B0X3RhYmxlX2FkZF9kb21haW4oKSBzaG91bGQg
c3RpbGwgYmUgY2FsbGVkDQpyaWdodCBhZnRlciB1c2VyIGh3cHQgaXMgYWxsb2NhdGVkIGluc3Rl
YWQgb2YgZmlyc3QgZGV2aWNlIGF0dGFjaGVkLg0KDQo+ID4NCj4gPiBBbGwgdGhlIGV4aXN0aW5n
IGNvZGUgc2hvdWxkIHdvcmsgZXhhY3RseSBhcyBpdCBpcyBub3cgYW5kIG5vdCBoYXZlDQo+ID4g
YW55IG5lZWQgdG8gYmUgY2hhbmdlZC4NCj4gPg0KPiA+IFdoZXJlIHRoaW5ncyB3aGVuIHdyb25n
IHdhcyB0cnlpbmcgdG8gc2hhcmUNCj4gPiAiX19pb21tdWZkX2h3X3BhZ2V0YWJsZV9hbGxvYyIs
IEkgdGhpbmsuDQo+ID4NCg0KU3VyZS4gDQoNCj4gPiBEb24ndCB0cnkgdG8gY29uc29saWRhdGUg
YXQgdGhpcyBwb2ludC4gT25jZSBhbGwgdGhlIGRyaXZlcnMgYXJlDQo+ID4gdXBkYXRlZCB0aGVu
IHdlIGNvdWxkIHRyeSB0byBjb25zb2xpZGF0ZSB0aGluZ3MuDQo+IA0KPiBZZWEsIEkgdGhpbmsg
dGhhdCdzIHRoZSBvbmx5IHdheSBvdXQgZm9yIG5vdy4gVGhvdWdoIEkgYW0gbm90DQo+IHN1cmUg
YWJvdXQgb3RoZXIgZHJpdmVycyB5ZXQsIGhvcGVmdWxseSB0aGUgU01NVSBkcml2ZXIocykgaXMN
Cj4gdGhlIGxhc3Qgb25lIHRoYXQgd2UgbmVlZCB0byB1cGRhdGUuLi4NCg0K8J+YiiBob3BlIGl0
Lg0KDQpSZWdhcmRzLA0KWWkgTGl1DQogDQo=

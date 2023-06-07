Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE2E7257D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjFGIek (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 04:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbjFGIei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 04:34:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804E1BC5;
        Wed,  7 Jun 2023 01:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686126869; x=1717662869;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dim8hDoeevF2OcnEXgNvFXv25mOiavWh6U2rsgtT/Mk=;
  b=RQWw7ScOiMJpUDBgoMYWHZFvTcyX7ke4dLRtiTOUfgx+hMyk1UMe6YRa
   AfmOqf6pHRx3TJb/yW/rp0yApv0uJO20xzelzQteP227QCqItTdjBYoQn
   JSqYK/i1cUq9ij57PVwRBfvTS4XAL8d8JhQvzIKOefSTL+EmxeqVzfYUn
   b3R3lsIhNel9roDqST9fWp/4HQA/FwdOybJ/rMikOSnLzx1h8phMs87Wl
   UUpPEZ68PSe4/Z0zUdmlfFQAqxLYvGQ3JHJNnil8q1bRp5vSkC8IIO1Ee
   eRF8SifFWB31zOS8XRgkFLZR3UvsS5ZAAGdOwug3NpxtCE2Ga7G42hP9T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385244667"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="385244667"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 01:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="822022366"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="822022366"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2023 01:34:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 01:34:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 01:34:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 01:34:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 01:34:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRTRcyC7RHFjKLBUhL2QTS6THr8K/QYUPqxarFTkQsnSGzwrxuzCtce/vKIR0XUxVA7vUqDgjJLs/65aYOjN+ScUBlaj3d5Aex+KBw2JHaACa5dHsrxR4R2y2pTlP+qOc61jblx5sxrEWqbi4gG9wKBqCf/gUXcoMl2yyuXs8u5IhKtiCjlgcNpyDOHVjN2SKGEiDJQR+tV7z4PkPhniH1QP2LR1L9cSwHQE2AMYDFwWGzIqX01e7dDUfzLxlDYiKMxb//c6SaE2TNHi6SHGHAhsrY6AgydqYptr8iPIkLGQdTYu8taEgQ2OIXbi0PlOskCeYFGA6aLvcq5UPX189g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dim8hDoeevF2OcnEXgNvFXv25mOiavWh6U2rsgtT/Mk=;
 b=YjE/hnGvCsa0kd5AAE5Jk6yfg0d8GXEXOtRUlZZ7wXOSPQiRoONDDrq0Xv16XDVGG8bh9qVJJstj0c1nDTOndxzW+TLhN9XZhAPB3JVse50YiRgHjDQzasiT2oc9hLa7SnJrvMhHH7Aav7hM594a4Hj6kAAhmKnwdGA/uwCgK/uIRFUtspQ6uSeEg+6D/2vQOMdfBtV0fNpxGBbkUZl1LB0Wr0WylVoywOqKiIHGR+fVClqsMf7kx4Q7qv0QKY2V/UXmIGEJ8r0TrH9R9WQ42rAaWMw9/GY1bVfdsVAHXQyd6nedy1oOBQyzpvctrjLg5epSerU3J6qA8ZeXMLQk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 08:34:23 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:34:23 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Topic: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Thread-Index: AQHZhBgTX2uvl5TO/kuvRR0OMeFUCq9pFzmAgALyQQCAEyLzAA==
Date:   Wed, 7 Jun 2023 08:34:22 +0000
Message-ID: <DS0PR11MB75299F04622CD9E6633C6464C353A@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-5-yi.l.liu@intel.com>
 <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
In-Reply-To: <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CH0PR11MB5300:EE_
x-ms-office365-filtering-correlation-id: b1757a9c-dcf0-459b-ce87-08db6731fed4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkzktE8tvxCqKhBJB0GEXhfOECkkbcgRfMQii3inoK/6pdVak3tlTTe0BRjmr4JCQCk+Or8+Ofey0ss45MKCaxyq4VMe9o13ceADJ5r7a8cMIciuQxy1+l2EiHBAvnixCxKf+cJLfrnZxzXjTfo87rUjwiD43xLAQDAmyURqGZqrrR1XBrZr0Kj9BI9bToaz//ovxMwd4q9yCQ/Od9PVyiqFuLh7D1FX449gyjABsB80nMlYxKOEeKNpfKMbsy1tHNpgHbz4mr8GzKCMWYtlZYpcnYqX4C3ltgYoMHx3mMTHbIqAQogNd4putJnh+d/W6p3BR0aeviBcwBPuGiuafv16JA3EPoisCqVRtAl0YqL3d54RlD8gOAJBAo4Otbr491bRh8Bu5Pv6yCUmV/l1UprGSDQDlp83uBYSiUjDbxIvaWBMqfMUfA9/tLYU9EujlGxOPlNyKcQKkbOHBrEBOc/kCvc1UOaekq9765Ag+ao48Iw89VeYUzg7TyLM8U0NIRY84E3Q7tTf73mXMWxsGrRUx9e4nYbtMH5JTo1aEzetTjfFcsjgz22pN/LJIi2Tk06gNULp+V6ycsy8pzc7wPgcs6LROu9c+NyTuUc/luE7fpKz+KTOX+X429Crjpj+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(186003)(38070700005)(4744005)(2906002)(86362001)(82960400001)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(71200400001)(4326008)(122000001)(110136005)(7416002)(83380400001)(26005)(9686003)(6506007)(52536014)(8936002)(8676002)(33656002)(41300700001)(5660300002)(7696005)(55016003)(478600001)(38100700002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXV6ZzBFd1hmdlBFa2xEeWx3ZGZkSXFPeEJ0RTYvU29ORnVsTlhWUXJ5T3F4?=
 =?utf-8?B?N3lVZExvUS8yb1NqeXhvMFhJSnAwS24vQk9PbkJrNkFaVzZWZ01BcndpREV2?=
 =?utf-8?B?Z2p3eVdnTUdjNXluWnRzZDFpWlprNStwRytzS2ZselZ1SFB0amkzRmt2RFE1?=
 =?utf-8?B?NFpSTGxpUUgvWnFVRzdldVZaZk55eGgrSHlNbzhZcWdwQ0RHS1FUeDFPaEhp?=
 =?utf-8?B?SlJrWTYvLzlMNlpkMUR1ZDlBT0p6TGxLdnUwNnNvZzF2MlZ3bHdRT0ZLbDNq?=
 =?utf-8?B?YWIrZVBuakJVbk11ZU0zYUNhQ3Z5d3pacGZHWkNSbXFkQWI2VEk5UHNLcnJ4?=
 =?utf-8?B?LzhwN0RnYUMrM3NBTFlTMTJMT2Y2NU1QZ250c0krQ1FLc0ZzVjUxUWhKN0xT?=
 =?utf-8?B?cGQ2eDVkRHgxbGo5V2U5WXlHY0VTNEV2dGFFdzFESURrS1MwUlY4TENGWjhy?=
 =?utf-8?B?TkhBYnZ6ZHJScUV5ZkpqK0ZyOTJUZXdMVFd5UDUxdE53VzF5dlBFTHJHTE5V?=
 =?utf-8?B?cFRxYnIyUXZhN3YyNlhoRStpS3QrTEpvV29YeWcvL0phQXRjV2RFNDNLa2Ir?=
 =?utf-8?B?Sjk3b3dJQ1BZWTRtcW5WTXcxY25GQ2Izb2cvWjViQ01vSWN6N1BRcHI3ZmhO?=
 =?utf-8?B?OUJNT0ZqaWZnMGxPRSt1UGtJNTR4WThleTRLTVZ2WmloREJKWE9NZklyN3FB?=
 =?utf-8?B?d20rRkl4ajlJajJ2aWphS3g2cFJmVU9OMUQxc0w4bThsYzFXRnFDT3JQYnBQ?=
 =?utf-8?B?aTZjdVNZTXJkckFkWnFEOUpkSXhvQ3N1OERKWmFLb3B6Rk1BSzRhQWsrZ0NR?=
 =?utf-8?B?dlhyemxmdUNXRlp4aEpESURrNy81L0FxY1ZqTk5xQmpUaTZOTWxkTXRLZnV6?=
 =?utf-8?B?Ry9iRnVSMXJWYjRPbFVRVS9UYmtPRDljdnJMbG85K0owclcwZEswUkhEVVY2?=
 =?utf-8?B?RTFqNXBSTzJ3RktRbG1kT2VBYnliSUsxb3JuSmdycnVrR3R1RjRMbWNBR2dp?=
 =?utf-8?B?RG1MNER4N2VUOFozM2oxMDljb0RZeFVnU2k2eElxZkF5RWlJU1U5Wm5DcGJk?=
 =?utf-8?B?cWNvUElWUmlpWHMzdEtGY2VCaDBOaEtvLzJOVzhHMmF3TTBYRi9vR0dkTGto?=
 =?utf-8?B?bjR4TjhnNWVFbDJpUDE0bEJvdUd3TW1OM2dzY3YzbU5LQk1LZ0E3YzRWUVJi?=
 =?utf-8?B?WThuUmtrQnEyTkVkcThoeHY1ZjhSRGFjZkV3OGcxZEMrak1kZTJQQVVwUVd6?=
 =?utf-8?B?aHhuRW5wSlZad0czUHZlbXl3eEE0bkJRSmxpUHZYKzdSVWRXcjFzemlFVVo0?=
 =?utf-8?B?TVUzZTVvVjVvQldPaUJIZUtDMklldUVCTnJKdUI1KzlIQ084WHRZeWFzR01I?=
 =?utf-8?B?QmJEZjBxWmhIdklXY2dreWh3MmE1NzdFZ0ltcDBXZjlOWmx2KzN2RmdTcTZL?=
 =?utf-8?B?bytTUVZjaUx1MG9qL0piTENhcm1lZlVCdTlqM09kSjZtZTM5MkJINlNjUVJ4?=
 =?utf-8?B?NTVXWWkrY1dEK251ZEN2cGFGYlFpdFRTZzQxVWhQS1JzTDRpMUtMRVhRbXpH?=
 =?utf-8?B?LzlsNDMxcWowS2dsd0ZtUXNWc3pMQmVMd0ZXdktVdE5VNHVHZmxnV20zRlVL?=
 =?utf-8?B?b1RUUWEvVlhuYzVpWmFUM0hqK2NpQ01RYUpnSXd6NDBvZHl1N0RXajhQM08v?=
 =?utf-8?B?cU9GTDN1RnljQU5ydTBUak1rajVUREI1SURkN1pSS01WR3FBaWRKM0dGWWF3?=
 =?utf-8?B?dmZFdDZpbjdnZXlRdkEyUE9kUHRPV1JpUGxUSnQrSEswV1liZjhTU3pSN1ZF?=
 =?utf-8?B?djBwOGVGM0MwQnJjU0dyd0tRWHJjR1JQSW5SS3l1M28rbHJnK25VajlhRXFp?=
 =?utf-8?B?cDFvMUJXSE5qWG9YdzUvZTBGOXErOVBNRlBSdC9qZmNwcTM2Q091d1BBUGxC?=
 =?utf-8?B?alVQUWNOQ2RXZnE2WW5YZ1MrYWRqdzRMNFlyMS8xNFJsUlZKSCs5OUpuRkxq?=
 =?utf-8?B?UUdQZlVtVDFaVEQ3VjR1b0VoRWJvQ1FaOVRyenN0c3B4c3crS2VJdlBTSXVD?=
 =?utf-8?B?ZGo0T3BremczTlY5amlYZmFMcGxzQnF6blp0RVFvMmRQeUM0ZU42bjVQNzR4?=
 =?utf-8?Q?HJSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1757a9c-dcf0-459b-ce87-08db6731fed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 08:34:22.8948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0uHdXI1vB5b408mhYcXuIjGPMBkurPFXqqcXLUHuNacobEA4L4dNfyoaPm+8u3mE3rBRP6JjQnm4/SUQZhoZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSAyNiwgMjAyMyAxMjoxNiBQTQ0KDQo+ID4+ICsNCj4gPj4gKwkvKiBGaXJzdCBsZXZl
bCBQR0QgKGluIEdQQSkgbXVzdCBiZSBzdXBwb3J0ZWQgYnkgdGhlIHNlY29uZCBsZXZlbC4gKi8N
Cj4gPj4gKwlpZiAoKHVpbnRwdHJfdClzMV9ncGdkID4gKDFVTEwgPDwgczJfZG9tYWluLT5nYXcp
KSB7DQo+ID4+ICsJCWRldl9lcnJfcmF0ZWxpbWl0ZWQoZGV2LA0KPiA+PiArCQkJCSAgICAiR3Vl
c3QgUEdEICVseCBub3Qgc3VwcG9ydGVkLA0KPiA+PiBtYXggJWxseFxuIiwNCj4gPj4gKwkJCQkg
ICAgKHVpbnRwdHJfdClzMV9ncGdkLCBzMl9kb21haW4tDQo+ID4+PiBtYXhfYWRkcik7DQo+ID4+
ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+PiArCX0NCj4gPg0KPiA+IEknbSBub3Qgc3VyZSBob3cg
dXNlZnVsIHRoaXMgY2hlY2sgaXMuIEV2ZW4gaWYgdGhlIHBnZCBpcyBzYW5lIHRoZQ0KPiA+IGxv
d2VyIGxldmVsIFBURXMgY291bGQgaW5jbHVkZSB1bnN1cHBvcnRlZCBHUEEncy4gSWYgYSBndWVz
dCByZWFsbHkNCj4gPiBkb2Vzbid0IHdhbnQgdG8gZm9sbG93IHRoZSBHUEEgcmVzdHJpY3Rpb24g
d2hpY2ggdklPTU1VIHJlcG9ydHMsDQo+ID4gaXQgY2FuIGVhc2lseSBjYXVzZSBJT01NVSBmYXVs
dCBpbiBtYW55IHdheXMuDQo+IA0KPiBZb3UgYXJlIHJpZ2h0Lg0KPiANCj4gPiBUaGVuIHdoeSB0
cmVhdGluZyBwZ2Qgc3BlY2lhbGx5Pw0KPiANCj4gSSBoYXZlIG5vIG1lbW9yeSBhYm91dCB0aGlz
IGNoZWNrIGZvciBub3cuIFlpLCBhbnkgdGhvdWdodD8NCg0KSSBkb27igJl0IHRoaW5rIHRoZXJl
IGlzIGFub3RoZXIgc3BlY2lhbCByZWFzb24uIEp1c3Qgd2FudCB0byBlbnN1cmUgdGhlIHBhZ2Ug
dGFibGUNCmJhc2UgYWRkcmVzcyBmb2xsb3dzIHRoZSBHUEEgcmVzdHJpY3Rpb24uIEJ1dCBhcyBL
ZXZpbiBtZW50aW9uZWQsIGh3IGNhbiBkZXRlY3QNCml0IGFueXdheS4gU28sIEkgdGhpbmsgdGhp
cyBjaGVjayBjYW4gYmUgZHJvcHBlZC4NCg0KUmVnYXJkcywNCllpIExpdQ0K

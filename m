Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105F463A419
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 10:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiK1JF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 04:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiK1JFz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 04:05:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06003140E0;
        Mon, 28 Nov 2022 01:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669626354; x=1701162354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XvxlA+juhQq/cm6MrLg4Sr7KWfQT6qQUVvmDJscPV8E=;
  b=k+eH04zywoB0kzCQ2MhVdeaQgvrS+daN3e3a/GTZf4lVaZvSphdgmZ3l
   0HSAxPViERi19nFQmThOLhlEUmhBy1jnKGcj/7ZydiaxbC9HVAmG5PO0i
   aMTLx9aZzahcuwFND+ijW6dkaWz78sBLGU1pO03Z0mIx8XWxm1EP8zGU2
   y82jPl8tfl3WOYq6C43H0EWD9DH6NO8ovLEk70SHxTT7H63IpGFhjk7V5
   YVdBVJFBdI6KPS3r1BQtzXSBGLyep0fk0W4Ms89rA9ZEd1MH7WMHc4LQk
   0z13qPgyj/7bqIu9rWYslKdKEd5Z9/1hzwgAWewNb68ou3cm/Zu5S48SC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294486907"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="294486907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 01:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="620976651"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="620976651"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2022 01:05:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 01:05:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 01:05:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 01:05:51 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 01:05:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqluySPEqRmtrh2ereJAXh3GZLDJACjXk4NewuvN6GkCq+IZQfdQeCLfnb9QXw6ABhwOcPAjRZIaSASl2oFtScBPWMwD/+9fA6dAvEgRcJIpMaevdWs8xoWmd1EXem0P8lcKG4+JURjsynYH2EDddfOG1V0EWIEYybxuhYCgQgO4Z2LnaRvz7Od3JI/+fQuNahm2+hPu86ksq0iuDXVoFXPm9WQf4k0hLdZWQmeuwoDcQlFWnU0H9lBLF2kAjh3DUOZxRDPxKm9ebvirROpG7lA7dbtrHnlkJhjl5b9bfWjTXJLM0TPCdCgYSlbYUV9RstlFCLpe/towEwtb7zhE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvxlA+juhQq/cm6MrLg4Sr7KWfQT6qQUVvmDJscPV8E=;
 b=gWmImxR0etQv1u60D3Pt3TLO2E1ixIO8La015MLmTv626fOtxnezbXbZ74aXTQReAvYfFcE9nNP/WUyYLFs/bLdLwE+oLMdf3jjA2XzfPPIdYnuoryaVMYZ0uCt/iOKkEoLRkf9HM9AnuJvAPk5/ss+pJthBgRkRYnawpbDQYPvxMaCDtTLATcristXLlV2Npi6lSPaiLu85jrmjm01WFF7WP1gBUZ0fObJZHws7yVGeWTQzsPxpJ/d+o9RaI9vvFVQTZlSRoTZ2fSwCU+VYkjHiiL/lMilCT01WNV0Z4vtM9nUsirm2eh8K7iQUwFGcIlid8RwWZ0860eIooatDiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 09:05:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 09:05:49 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v5 11/19] iommufd: IOCTLs for the io_pagetable
Thread-Topic: [PATCH v5 11/19] iommufd: IOCTLs for the io_pagetable
Thread-Index: AQHY+f/Tzbd60/PmH0uUc2fq1I1b8K5THTKAgAD+1/A=
Date:   Mon, 28 Nov 2022 09:05:48 +0000
Message-ID: <BN9PR11MB5276E400C99C0933E00FB9E18C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <11-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <16bcfd63-2803-8000-7725-b42cd05061fa@redhat.com>
In-Reply-To: <16bcfd63-2803-8000-7725-b42cd05061fa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5356:EE_
x-ms-office365-filtering-correlation-id: a0ec6f8a-4216-45a7-9225-08dad11fbe11
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxP1fqcshT7LF+/A/TuBGHfubSt+3q3MlVVS7FMOs3SFcQa32EYr2pq9K3WXZjl0xL6yXdOAEFzKITI2qUUlvrOwGG3lNzVZkraqwDI1DF6KFYvmE4EDzvDXd1OOzUqsicYPmi7HlEEawlzYyHHu0nQ06apDIMCAcMIoMQrmPD356qqjSL3zw0tocTnT1kZjEbEwkbbKRS3YRVO88y+zmiNNmkXtD1tPXXL5vmGoxuv28TxMZC7m4lAy9m7+1sTA8P+42qKITE36GMwOncc2TTwQ8lnV9uECIksnLLDylessafdI6CKd64Fib3YtTphVOXO0sPTv5UsegTnPpIDx85FyFEdoOPclV1Y8nRLgTWvjZpvuP6R+zoxrBKU1RPb1UNfCzUvG4KaH3NesHPzdd2AF+jJArQCCTdWxJj9ijcBkYdkaRwvw8bkhglwZ+JbKkgk/Nf8nw87Vbjz6oLleZwCpDtmofPtbfH56lVl/+nI9W675MqanltPIwrz6jYlJtF9gtOY+cb6QmQKIioRNUyVs3p73K69a8TVwd8UldHHKt9AbydzETqQWSzO6VxYClxO1YfcEfIZc8DdE+APit76wIJ4jtx+YXo0QXtlLNOArfs7Oe89XnWcV2Q3i/B78lHWmlkxW5Kfc1acHKkihEE/N5Fm8mUXuwheatayGkCSIce8QrJmO8grdEMlTn4eS0AbXUzNP8HDQnlwmgrUOwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(86362001)(478600001)(71200400001)(6506007)(7696005)(54906003)(26005)(9686003)(316002)(110136005)(52536014)(41300700001)(8936002)(7416002)(5660300002)(4744005)(7406005)(55016003)(33656002)(82960400001)(38070700005)(2906002)(38100700002)(921005)(76116006)(8676002)(66946007)(66476007)(64756008)(66446008)(66556008)(4326008)(186003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUJQR3ZiWGZ3bXJ2NWJVd3h3SC9oYmxiSjhidm81UDA5TUZqaGlHTU85YzJm?=
 =?utf-8?B?MmY3aTdyY1FLMDhVeWRQcCtqcmhlTnVCYmFlL1RyaVlsK3djbk1VVlQ1QXk4?=
 =?utf-8?B?UG1OWEVZaEUxNU1lRXFvZmJ6dk51TFVtYTVTT1ZUS3JYc3RpTVB4L1JXVzZE?=
 =?utf-8?B?TklBQ3hqNzMzQ2JKdUV0ZzlJcHVjSzBndnBkbnVyeXNVWm90VVFRYmhYemlF?=
 =?utf-8?B?SWZhaVZGRlhIN0VoYXNvWkhrd1piTktocEpYa3hLY0x3cjNGMEh6SzhLcmxK?=
 =?utf-8?B?OEhubTRKNktQKzBDWkt2QlRkZnVBOHRTM25ORUtQZmVQbGlXRDFSUXJmN2xR?=
 =?utf-8?B?TmFFSzlzR3BDbVpkYmtTaEhLVVpWenJ5M3N0cmVZRXF3WUFkcUdSeXdQOHdn?=
 =?utf-8?B?SGwyakNNSkxkY3hsa2xKOVo0UVZTRXhIQ3hPRVNwRk5QbzQ0dklXU3hrSlZZ?=
 =?utf-8?B?SjRyN21yczU5akRCZWhYbjAvZGFFV09CakliYWN2Wm1sL1c1SmFQSnEzME5U?=
 =?utf-8?B?aVIvejJkV1FWY1lEVmFDR3p0dmxIYkQ3M1J2WHRsa0MyRHo5MzhobzUrRlRL?=
 =?utf-8?B?cXYvWHVyR29UZjVYV0JsNTFjNENiZFlDQVppNUtKNkxFdVU3ZC92d3Jzdy9o?=
 =?utf-8?B?bWRlOUNUODlENlp1MmhXTDgzZmEzUGhKZEI2VnRQYnRHYlJBSktuTlp3amJ0?=
 =?utf-8?B?U0VGRFU1WWJ3N2RoQjVBN3FzMXRSckJGeGN3ekNSdzdXS3pzMGJLL1hFS1VX?=
 =?utf-8?B?NisyRGxzRnJyQm80RWI3TmdUQUpkemY0NDJNTnZ6RjZ6Z2YzZkxVdDhxMDJX?=
 =?utf-8?B?WGkzZi8wUG9ZZ283bnBidS82WUp2M05PSXM5MThvd3FNQ21nWjZ3TGRTTHE0?=
 =?utf-8?B?YWR4OXduREdXMjUxbkhWTWFOUzdQUE12QyszZllFVm9XVFFlVmZWSlJCQU8y?=
 =?utf-8?B?aElWVHdsbURic0tIN011TXZnVEZzTUNwdFZ2RmpMOTc4Q3JkNXR2MnA2Q1Ey?=
 =?utf-8?B?UGh1bkRSemxKTHdMKzZOVTZWNzBySFE5Q2VLOWYvZTZ0SDZwWmxhczVJZ2o5?=
 =?utf-8?B?cUNMNklZQmJGd3BQaXR0K1g5b0FWQWErcnNYU0ZXV2RnWE5JNUpndmFCVFBO?=
 =?utf-8?B?MWVHVUMxTWRPS004L1pBRWprQzFROTltUHdhb0ZaUFVQMkFyYzlVZm1KWnd4?=
 =?utf-8?B?VCtVZ1hDeDk3LzN1RkpzSDJiYnVITTdGUFl6OVo1L0NMajA5dGtqL3daK1Fr?=
 =?utf-8?B?UGVGbkU3SUZrYlNSOEJEc3NESEZ6WkhMYUJPMHJDWjhROFNBVy9ROStvYWFj?=
 =?utf-8?B?eVowcFZ5VGdNOUZzVzRSL1BxSWdJTi8wYm8xYURKY0ZPUXFJLzMxbC9scXF2?=
 =?utf-8?B?MXRjczh5SlphNXovZHRYb0Y5NVVXQnpUSzdyQlkzVVJrWW50KytHcTdNYXo0?=
 =?utf-8?B?YXRVTDByd1BFZHJJYko5VGhQbm5GM1RsMDlwZVBGUTc2Yk4rNXR3cWM1UWpK?=
 =?utf-8?B?NDJaUmxQc3hqM3V3YVdkdytxWUoweFljN2FOZ05RRk4xYVRKV0JiQWFHRlVk?=
 =?utf-8?B?QldQTEVXYVorOWw2WUJKdyt6VUx5TEhvZ2hkU0cvQ29kMXlsYjh5TVd0S2dU?=
 =?utf-8?B?YmZFV2ZiSHVEOUpnYVR4QXltKy9yWFJORUswMkt3bytLNTFNQ3lLU0QwOEts?=
 =?utf-8?B?Y2ZybVB5aldqeWNHWkJYc1BhVjJrQ1BOWVRkZ3ZKdzJ1eHJiMldiNTAzZGFa?=
 =?utf-8?B?eXY2bWdibXVJbXN3TjBEdkMreTBxN0xBYVM4b0lnVFV3bm1yYWtIM0NtOGRm?=
 =?utf-8?B?ekkvckRLa1E4YTlmYXhXMllEL3ExYWhMaDdMZGlGZHNlWVJHaTFMeDNETU1i?=
 =?utf-8?B?N1dpSUgyQWl2TlV2MEsyaXdpOHZxRVBRVWZrS2JJV0plRS9Gdy9sUElveGI1?=
 =?utf-8?B?N0N3bUdxS2MzRVp6aWUwTFI2cE44THFnOGdwSnp5eGlDekkxcnZEUWpOY1hB?=
 =?utf-8?B?bE5iTlpJZmZYc2s5c2tCZU1jOE1QT3pVSG5RVCtnOUQ0RmFtaVRpTE1CR2Qr?=
 =?utf-8?B?dkRBNVhwa0l0dktpQWsyRTE1ZWlCRUt5TWNqL3l1cENJSnhrY2pDRkNuTGRs?=
 =?utf-8?Q?8bb4hF88gGDQRvMMgRsaZdn1k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ec6f8a-4216-45a7-9225-08dad11fbe11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 09:05:48.9204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cGJPfho8WlChYFhC6PtY6Lm1BLn8b8N551WoomxaBf7Yws4unja25UwDgB1UGx0DcXU4yosnxh5VnWqk1hsJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgTm92ZW1iZXIgMjgsIDIwMjIgMTo0OSBBTQ0KPiA+ICtzdHJ1Y3QgaW9tbXVfaW9hc19jb3B5
IHsNCj4gPiArCV9fdTMyIHNpemU7DQo+ID4gKwlfX3UzMiBmbGFnczsNCj4gPiArCV9fdTMyIGRz
dF9pb2FzX2lkOw0KPiA+ICsJX191MzIgc3JjX2lvYXNfaWQ7DQo+IGlzIHNyY19pb2FzX2lkID09
IGRzdF9pb2FzX2lkIGFsbG93ZWQ/DQoNCkkgc3VwcG9zZSBzby4gaW9tbXVmZF9pb2FzX2NvcHko
KSBzaW1wbHkgZ2V0cyBhIHJlZmVyZW5jZSB0bw0KdW5kZXJseWluZyBpb3B0X3BhZ2VzIGFjY29y
ZGluZyB0byBbc3JjX2lvYXNfaWQsIHNyY19pb3ZhXSBhbmQNCnRoZW4gbWFwIGl0IGludG8gW2Rz
dF9pb2FzX2lkLCBkc3RfaW92YV0uIEl0IGRvZXNu4oCZdCBtYXR0ZXINCndoZXRoZXIgaW9wdF9w
YWdlcyBjb21lcyBmcm9tIGEgc2FtZSBvciBkaWZmZXJlbnQgaW9hcy4NCg0KVGhlIG9ubHkgcmVz
dHJpY3Rpb24gaXMgdGhhdCB0aGUgc3JjL2RzdCByYW5nZXMgZG9uJ3Qgb3ZlcmxhcC4NCg==

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1B7D454F
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 04:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJXCHM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 22:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXCHL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 22:07:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6809CD79;
        Mon, 23 Oct 2023 19:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698113224; x=1729649224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aDRqTLEi0N6aAPEdoD6GyYH75tEHAqH2eK8z0QhjR+E=;
  b=jOQTz4V2eH2B26EKZdY4i7fwuj9hewom66ZU0JPVQsohXQJtjQluJDyJ
   PYBK02G85oTOelUox08dcvQeru+t/VD7EZkQFJ7q6D6bIDqwdzoc85MHI
   YtgamHB5I/p67zNHyxu17ycWipRSq8ECRzJ/4/M9e18pZ7xW+cr45ndam
   c1t0T5JLboipKw5pIez/FMVHBykjHTAiUkX4P3WUVc47q/a2HB/Lmrhup
   qJOgaHH/8md9uFbcwuMXdLUan7fWy6foEwVOGOO9lKXeAmHykzDlDgSC2
   BvaK6uOXVBbwAaP9b+lDayJ4Hp5GEhYPkEH8bQHy8NVAo3Vnb9hObu1e+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366314085"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="366314085"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:06:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="6012169"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 19:05:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 19:06:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 19:06:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 19:06:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXz5E+StGuFLglbZCcAHA/Glk2ZdpdG0ol+ckySxUVJWJGwRIXEjiodwpHLiNnJoaEPHag9RLjFnXOmwYdDkw2hSagw66NKjtPjsl96U5bUH3pPYr27elhSanWBaGbyNvAM+NtNBC94Sn5fOYn7YfUlQjDOqRgWwcqcHXnGHt/1itMnew84dG0Xx0IuVjVuiF4XrCJ0ujMTi7V8JPcR14GndDoYmtsBto2/3APB+O4BwFTrajiPDsz7zbXMptymE0zoDzA9xu9dHjN38f28s03WHZJEy/r66UrgYlrNfr6kvqtiTFfLvzKnTRbWNuqad6vCzTMWBPAacdU3FsEfpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDRqTLEi0N6aAPEdoD6GyYH75tEHAqH2eK8z0QhjR+E=;
 b=e36Y76kfPsdolTw65tVt0VbxQecsQBHAClPvDt+J/bbph0gimAwd04vvNTjPRTwoHNcgiCJUOCAtMh2v7x1i9Kukv98ASbmrS+9bAFNVxmbV2gp3PrZd0rCnXL10AxnhShaSphVCEBCFADKOs3nHs7wslffh10BF5zBo019NUJoXaebHkow97N69FKjgPPnrjlwSFPIp8bPKcMqN7E+RAv426M50/iWLziiWAeDsOpZ/Ve2Ia9g9KHkkkYtJBsjHJEH1r1UKPhLKAyCeKtd6n4VQtY+/0yuKSwYnJLknof1BFURi1PGtTzJv/k2esdY+OTFqnMYzDmWVD21wylLchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS7PR11MB7690.namprd11.prod.outlook.com (2603:10b6:8:e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 02:06:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 02:06:47 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "Zeng, Xin" <xin.zeng@intel.com>
Subject: RE: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Topic: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Thread-Index: AQHaAzhwl7VoudF1h0uHI7SB5pBrdbBTlbGAgAOntGCAABIgAIAA5REQ
Date:   Tue, 24 Oct 2023 02:06:46 +0000
Message-ID: <DS0PR11MB75290CA351F72B3299CFB3B4C3DFA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-9-yi.l.liu@intel.com>
 <23133231-c6d7-469e-8f55-2e7667acb097@linux.intel.com>
 <DS0PR11MB752977275A0791296C115FE6C3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <f041d424-ade2-4959-a677-01e3d7dd699b@linux.intel.com>
In-Reply-To: <f041d424-ade2-4959-a677-01e3d7dd699b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|DS7PR11MB7690:EE_
x-ms-office365-filtering-correlation-id: 8ace2372-b9e5-442f-e3ae-08dbd435e066
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kutkANyB1/+A284y4a8ESligAuaEPHA5jOFzD3Oc6XIiVNcjwVF/S9DSF2FxHoF/t2YRh/mxtgKXaR6fb4FDUtY78LMtW6TiBio35LWuxfWM/up6AlpV8b8Wm777skJZwLuVlqfKqd1L5D5aN7qz99uUK8T7LHM6bIGSmrgh7eqn0GjEMWh5IbDUGSGCm3PSzO+xMAOgI1xDWOKey/OqztsgkBXqqQMFcIjhr0eyXsJu5O7PtC5Pxmpcw0vNzhjELegxkSDPmxfm7dhJ4BZsfX9bgERDwnRcxIxHRAKJGGewvVBDZ4fqYYgfkV8VGMUkTDhrgsYXwFbYn6nLa78T3Qc2rpOoFYi8n2+mqHnRMZMCfdXWOxDJWKRAVuFWgHUeMj7KoElM8k8k4CwAti7gqkptaRCqKKi0KdpN5O5/4qXLIT/nJVAdr0FgvVohRQaCRpgqMn5NgFUR7MHd2juOKjkqyw5r8+Xkl3TJ/c2QclRgSoENrDplDJQZXj93aCEbdPQR/PRhgkD29d/XkmmoVAHs9hwVHv29FOoHLcC2lc1kQEXuUsysUkCkOIMZ97xcVbOmUBw5bTLVdtcVVlmHiQD+4FIs3K1pcHkMWo6Pne9UPEgtrrIT7/kHN5/es8KL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(55016003)(8676002)(52536014)(7416002)(8936002)(5660300002)(33656002)(6506007)(41300700001)(4326008)(26005)(9686003)(53546011)(2906002)(38100700002)(71200400001)(7696005)(86362001)(66446008)(110136005)(66476007)(54906003)(122000001)(64756008)(82960400001)(76116006)(478600001)(66946007)(316002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXB0K0lLOUhXclgvUkhFMGNuQlVVZHJRZ2VsblN4U2dhaWI2ejVHL0RoY2d1?=
 =?utf-8?B?NzhKNXBHaWp4ZG54cVAyWG9Nd3BsNG0wU0hxNko1TGN4ZWdlME9xYXhhOG42?=
 =?utf-8?B?cnpZM2pCMWRPcmJJMEtKaHlZL1BlcFM2NGVpOUk1Ym1BVk5sbFFHVmpRNi9U?=
 =?utf-8?B?UG9zZHRqSHA1a0Fwb2pOQmZCZFh6T21oMGhpcFJpY1BQUXN4eWVCWjFJbjgz?=
 =?utf-8?B?WDRiaG5GYWZ0RHBmK1drYVZjRU1wOU84V2lpN1R3S3lRcXpGZjg0SlNmS21Y?=
 =?utf-8?B?WTJjbWg3THh1eTMwREpjV2JHOXZSYTV4WlFGOStlUXhDRTFQbU1reUNUcW1H?=
 =?utf-8?B?S3h1WjJmV1lvT2V0WEpNOXk0eVZ6RXpWL3laVVJVNHFOM21DbDFOZm5pdkFm?=
 =?utf-8?B?ajhDcktPNU0yVXFVcGd6U2M5b0NSL0c5b1RxOUh4WUFkUjBYWCsrSllFNXFl?=
 =?utf-8?B?bDRYL3prSDFQcklGM2hJZ3FIVmlVNlJnSFpqcFFieXl3TCtBOG5IeURwY0FR?=
 =?utf-8?B?dWFjMk5FYjBtODFpYmcwbGhucU03bExLcFdBQ29zenUraHZUbk1QZ2VmaDYv?=
 =?utf-8?B?cXA2a3c4M0E3bkJKVFVnaWY0Zjhoa0pLcjV4UWw1eVZMaU96OHowbVNjdFYv?=
 =?utf-8?B?bCtoWFdablNGVUpKT1JsZkpBZmU4NWpnOGhFSHJDSkFlZnlyVGpncmVPNGNU?=
 =?utf-8?B?MUZHTTFzbDlsQ3hlcUZXVHRxL2ZDYlZlaTFkWmhBbUtzQ3VLaXd3dnN6ZDJX?=
 =?utf-8?B?cjF0bE5vRkdodkR2Wjh4QUllcXAvN24yREdmWmxKamZaRFpFZ0lpTHN3MjMw?=
 =?utf-8?B?bjRzZ0NEc2s1UWU1ck0zQ1daOHJwSUdYZEY5cGExOFU3aFZLWkpjUkRFUlpB?=
 =?utf-8?B?akFuK0ljV3NTcGlsaG1jSEo1QVpJOHBHc0hsdk1hTnMwbjlZMVFLMURMMzRv?=
 =?utf-8?B?aXhsZ001NFl3ZkpxOVNweWtHZzhCeERxRld3ekRpOXpmZWhRTCtjYjBMQnpB?=
 =?utf-8?B?MXMyT1dBTFFHS0laL05mbWhUbTd0cnVWTnlTbnFkRS9mR1hZK05JQ0MvUVZi?=
 =?utf-8?B?OWtLNVkwYm0yZWd3OHlDU0RiMEh4NzVZT3BuOTI3NjloRy9QcEJmcUJhOU9h?=
 =?utf-8?B?UFVPZWQzMENwYlUxV0ZGRlFLdTV2SHV6YUVIbzc3QUpjaVI0bStxT2szbDJr?=
 =?utf-8?B?SXhJVkZuQVZUdTQzR25kOHhBRjZTc29SL1phYkxqZ2FkMU52YVpiWWlZQWpD?=
 =?utf-8?B?eVlGSUc1OFJQdVJWQjRMYWN2OUdGMnlQTnNrM0plZmhNRVF4RmVVbEdxL29x?=
 =?utf-8?B?M29iRk1hVWpiYVYvTU9IdjI5eStaSXNZZ2dKWFBHMjU0WXpBM2ZMaHJ0dEF2?=
 =?utf-8?B?SHBmOU94ZWFsQjd5emRXNkIyandNRU4rYmZIcGZRMWxqNEJNL1Q2dm1mOUE5?=
 =?utf-8?B?aWI3N0Vwb2ZBZit3RTVIUzBKSWQ3cnFGcDl6U1c2QWoySmo2UXpsT2JDUDVi?=
 =?utf-8?B?TnNhcjV2ZStNVC9CeXdxUTlUQWt6RDZIZmZYbXBxd2x6bG1YbGtqWnc0U3FW?=
 =?utf-8?B?MUIySHJHL3hydGcrcXRlc1dWU2hnaVY4RXRpWnB4d3p4S1F0cm1zZmhtNVhi?=
 =?utf-8?B?MXVSV3Z1UStEK0E1Y2VzSW1JYzdvOHQ0dWRqWi93RW16cis4ancxUjBja2xr?=
 =?utf-8?B?VkNCeXc3cFBzaGNCYkdsTWlvNjhtVE1MekM2U2ZmbUhzSkV3dW8rdFJkYWZZ?=
 =?utf-8?B?TzdyQkV0dmZ0a3M1dVJxd0JpL3BBTTcyYTZHM0YzK2hnU2E3NlFOVUoyQkJI?=
 =?utf-8?B?emRwdUNQcW5OWmJVR3oxTXpVYVdjYzJGaXJ6aVJERXN5RFA5OWpxOXVyK0VH?=
 =?utf-8?B?eVJsU3VXRlhya0tpSnZhbXRpTnIxSnJMSkFRenZ2RE1pWVl5dk4wM3hCdEJP?=
 =?utf-8?B?NDltUXB6dk15eHA1YUNQbHZma3ltOVZ4UGFzUXBndEQ5OElTSkRzVFc4WC9M?=
 =?utf-8?B?SlFrOEl1OE1tT2tFRTlva1I0S2V0TnowelhtWFYxY2ljRDc2VzgzNk5XRldp?=
 =?utf-8?B?VjZmK1lHS05ZWDQ1blB2M3VzTlU5UGwxOERlcUFpcWFZOVJ0aXk0TWVKd0VP?=
 =?utf-8?Q?fR4C9+mEI+G/SUBsTYmjImPsl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ace2372-b9e5-442f-e3ae-08dbd435e066
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 02:06:46.5783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiQ6WP5vsZ2B8qvakq6vPqiHIsVT5IrFo++KoaImDTn91EGO+G1Fs+bR1e7W6hsWua/P23v6zJ3O4e7RivXZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE9jdG9iZXIgMjMsIDIwMjMgODoxOCBQTQ0KPiANCj4gT24gMjAyMy8xMC8yMyAxOToxNSwg
TGl1LCBZaSBMIHdyb3RlOg0KPiA+PiBJIHdvdWxkIGFsc28gcHJlZmVyIHRvIGludHJvZHVjZSBp
c19uZXN0ZWRfcGFyZW50X2RvbWFpbiB0byB0aGUgdXNlcg0KPiA+PiBkb21haW4gYWxsb2NhdGlv
biBwYXRjaCAocGF0Y2ggNy84KS4gVGhpcyBmaWVsZCBzaG91bGQgYmUgY2hlY2tlZCB3aGVuDQo+
ID4+IGFsbG9jYXRpbmcgYSBuZXN0ZWQgdXNlciBkb21haW4uDQo+ID4gQSBjdHVhbGx5LCBubyBu
ZWVkLiBUaGlzIHNob3VsZCBiZSBhIGNvbW1vbiBjaGVjaywgc28gaW9tbXVmZCBjb3JlIGFscmVh
ZHkNCj4gPiBoYXMgdGhlIGNoZWNrLiBTbyB0aGUgcGFyZW50IHNob3VsZCBiZSBhIG5lc3QgcGFy
ZW50IGRvbWFpbiwgb3RoZXJ3aXNlIGFscmVhZHkNCj4gPiByZXR1cm5lZCBpbiBpb21tdWZkLg0K
PiA+DQo+ID4gKwlpZiAoIXBhcmVudC0+bmVzdF9wYXJlbnQpDQo+ID4gKwkJcmV0dXJuIEVSUl9Q
VFIoLUVJTlZBTCk7DQo+IA0KPiBJIGtub3cgdGhpcyB3aWxsIG5vdCBjYXVzZSBlcnJvcnMgaW4g
dGhlIGNvZGUuIEJ1dCBzaW5jZSB5b3UgYXJlDQo+IGludHJvZHVjaW5nIGlzX3BhcmVudCBwcm9w
ZXJ0eSBpbiB0aGUgdnQtZCBkcml2ZXIuIFRoZSBpbnRlZ3JpdHkgb2YgdGhlDQo+IHByb3BlcnR5
IHNob3VsZCBiZSBlbnN1cmVkLiBJbiB0aGlzIHdheSwgaXQgd2lsbCBtYWtlIHRoZSBjb2RlIG1v
cmUNCj4gcmVhZGFibGUgYW5kIG1haW50YWluYWJsZS4NCg0KT2ssIGlmIGNvbnNpZGVyIGl0IGFz
IGEgcHJvcGVydHksIHRoZW4gaXQncyBmaW5lLiBBdCBmaXJzdCwgSSBqdXN0IHdhbnQgdG8NCm1h
a2UgaXQgYXMgYSBzcGVjaWFsIGZsYWcgZm9yIHRoaXMgZXJyYXRhLiBCdXQgd2UgY2Fubm90IHBy
ZWRpY3QgaWYgdGhlcmUNCndpbGwgYmUgbW9yZSBuZXN0ZWQgcGFyZW50IHNwZWNpYWwgc3R1ZmZz
LCB0aGVuIHRoaXMgZmxhZyBpcyBhbHNvIG5lZWRlZC4NCg0KUmVnYXJkcywNCllpIExpdQ0K

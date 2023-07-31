Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEB4768C09
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 08:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGaGbe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGaGbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 02:31:32 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F11BC;
        Sun, 30 Jul 2023 23:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690785091; x=1722321091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34OKR+PA7pbzLcl4H4KM63JyCM1Q3mpwj2Cb4NGgYqE=;
  b=Cyyb2XH5RDG3ImdRHnIxv6o5oC3OxegP5QQVEOF/Nlmmdn4Qy/Ic6COV
   5Uz2R7MjCfNtPjMjmdQI+JrJF3qcqTJBU5IhJYsI6clvk5+j49KT1JCe6
   9GQhdSt6PaE8nnj4fHaEbIxzoNiIIXFXB61movXr1OcH4q4il9iaAp3W6
   iUsoB0qVCGIJFFOyJFCxyC7fmIQtoX4au7sG0rVZ76Ihn94+udO9SNvem
   uit3KWCp/0he9PQFDt5/brXvirOfQqkMCVOEZGLr7Kie0aHiEkRX4IxGu
   VWZAO+qSuJhsWy26uWrgJCjYtnQa18k9g7TXdrMmsTokUMb9jk90qqrB/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="348532220"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="348532220"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 23:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="763247129"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="763247129"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2023 23:31:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 23:31:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 23:31:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 23:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghuLGj0H2N2SUojIqahoVJtNYT2N92y2NP4Crri07oUzYFI/Qng5CnFzGjm28rzhtcksTUtkhyNGtOz2RA04+Sii6Twq+X/pzCU6h2zRq4SGAI+QG7G0RWvEAe3r0VgqRUZmuAHP9+jLNSs0C+6/Z2JkWePvNaIEUf5t/7WVdYrKIbhH2HldeOwpMw8oAS+TgiyfPs4qN3fM30zSDrD8C0kWgBjFGuRnHwQWECyBPw9XzKBSr9XH1ARPHq4NpSxbRyOlgQ224L7sxp9djfhoY0YsQoh6VMzDEksX4JFEdv6jFhDpEBtdCbYJ6DFPH+n2lEVjZtga5iJsDVXLJiXRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34OKR+PA7pbzLcl4H4KM63JyCM1Q3mpwj2Cb4NGgYqE=;
 b=QMaHC0xthqv2lI7LVKX7qGhYcuGdNLVeL+PkhyA8dtFKAvz4eWS1kaRk8tglPNOJBmndRU8fUZ0oEPKDM7hGvkq3JBek/pZ7NUi2CFRPaOYzfVbBpbweYwvJ6p76UrMLVE6lDShL4dbgIjhtqDPEwd548dR6y/lZMIXu1g4sN4e4lv4L8AntBRvqlw/mDyyHqRoXAX1PEnYoADNrJf0ReU8BnnWgBi0t9w+c8h5liqp3rI9Dt3/yj7T6eN2WsMrTGkOTvu79n8OnOavJucVdmF89XhbkeZPNde4jhb3v9zA2ca77javOSGaKVguk7eNy5vzwe4TH4S/3cY2Sr6Uqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.39; Mon, 31 Jul
 2023 06:31:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8b87:d7d:f095:e3f9%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 06:31:20 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Topic: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Thread-Index: AQHZvh6gRIUXrS8FTEq0LBGdPa9/j6/PfUiAgAP1GUA=
Date:   Mon, 31 Jul 2023 06:31:20 +0000
Message-ID: <BN9PR11MB5276C84452E56AB03B819D208C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com> <ZMQBLTm+U+5bgC/Z@nvidia.com>
In-Reply-To: <ZMQBLTm+U+5bgC/Z@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5073:EE_
x-ms-office365-filtering-correlation-id: 69ad1953-5e97-4e0b-bb3e-08db918fc0b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UneI8gnHyY4dZD+cTDuH0EiYOHVPtb+w2O023Ml7uUhNUOS9pSmLddDkJEopyT8jfeLsMkFSa2gr/VXdxySq4W4QKeqYmTavZc21UwSDiJNVd2+3QhDYx+QPn37v8bvvs6BdViFSReXqAKoDCbqcDYf2MNgDreZJ6jVSUhjykgnT8i0w51dMPDwcMZbLQEn+EG/QaOJWI1I9CbKyIs9VC0w5Q3i1W5Vz33Mw2IqJlzviri+Fs+OwgbtjKSCejCPEAp96gyZ485Vg3eaGDbAX0edx+jOmaG+j7CgTT8H2jZ0LAEJcXF76kxdoXQKeoHNt7Ymy28JjLEZuCfCr/GJzk1sz1oN/FJRx3ZPs61qIljswKTvm1z1pxpM3+fTBwWnxJLJr/aciBlwm7AJRQIM3C7hxztGWPJi3VJP2MpKbFW5M8Okz6zHaAZyBN+LBqdnQbis8HQdChxeL7NR5YugQo9ZKU8nMJL+RhFA+jcCw/p0erpzFTdoFDY1oZd5lALG0idDyTSDuCYcG3QNZ+aTD4wmfCQ9Zibhf9iEFGJoevOc14hU5AqPsA89SPNhvn7fTcWLkiw8Sz/YkJIvMeYHXnfNgsN+tXprXSqR72fNifipERlJj609E3mW0BdGFzyfb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199021)(66476007)(86362001)(41300700001)(8936002)(8676002)(316002)(5660300002)(6636002)(4326008)(66446008)(64756008)(7416002)(122000001)(38070700005)(33656002)(66946007)(66556008)(52536014)(76116006)(54906003)(110136005)(82960400001)(478600001)(66899021)(2906002)(38100700002)(71200400001)(9686003)(7696005)(6506007)(26005)(83380400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGNIckx5WVFOc3NSTE9FdG1zcTQ3cndXcnF1dTlFQVkwNzVDRFVHblBDT2JR?=
 =?utf-8?B?bFBIZkF5SGxhMmhHaGdGZEhPL05KMFRTN2VnOUpxMVRlNTgrVXFpVnVJa0J0?=
 =?utf-8?B?Zm9rRHVLYlZyeFprUUl2ZGVpa1NWcVNWK04rVFE4Z0VpZzRHTTAxK0l2VmlM?=
 =?utf-8?B?d0g0R3BiSHYrN3J4Wjh3aWZ4eXU3N2w1c3ZxNlN3NW9wVXdKdGxrSFdFRW5a?=
 =?utf-8?B?ellIdVQwdzhmR2tacWlhdlpaOHRkQVZ2NS94ZHlscDVHY2RPNFVjeldZSWZZ?=
 =?utf-8?B?dFBtcVlOaXpEQnJqNElCTmRwWFVuUnIzeU91Y01LOWs1Q3YvNnVETjJ4UzJD?=
 =?utf-8?B?MGxjbXpFNUVoR2xySmltMTFHbkdxT1h0YVJPa2IrT3F6Ni9HcldjV2hRMlpI?=
 =?utf-8?B?TG9MRlNXdjhITTA0dWxKb1JkU3lMSVA3WmhDY2M5RTVYRGhBNStLU1FHNVpl?=
 =?utf-8?B?MVcyMjRYUG1VV3VkUy9ESDVHZ0ZTaThJVDBqWDZPRFNaZVQyekxYUCtsOEhm?=
 =?utf-8?B?cHNnZTFLVVNjM1ZUSXNJT1phVm1KbXRrcnEzNTZjQS9CTVpYSFo3RC9EQlBw?=
 =?utf-8?B?YmtUc0VqcFVaTE1YaUxHZXNEL00rakxOUXhNUE1iZTduVW42R3kyTFVWU3h3?=
 =?utf-8?B?Z3VkaktrQTZwQ3VPc3BWM3Q0TGk3R3lQcDBMWTJnTFQxVUlCT2xGVnJvTGI2?=
 =?utf-8?B?QnlFdTQxaU5KS24waktpa3NieVFPSlRxTVZFcWkyZ3RlR3d5ajQxTFdMUmxz?=
 =?utf-8?B?UUZnNXQvTkhUN2lQQkpvWURyWEc3Y0ZGa3p0dFlWV2J5QkpFa2R2OWU0ajlk?=
 =?utf-8?B?TENxdFI2a1FISitVUnFURnNRQy9HdXhFKzA0cnFHSi9CeERuSWRlNHovK1Rp?=
 =?utf-8?B?Y1Fsa25zaHZFeTN0RTQrczBUanNESVdTYjZmZ0ltbFdpb2x5ekpHSkYyL2Ux?=
 =?utf-8?B?UUlWQXZ1S2JORmMreGpXQlVFVjl2eHFRTnNWK1JORm4weXdGZkFvN0JCaUxB?=
 =?utf-8?B?WUFIMUh2dkhzSENBWGZaQ1oyc1RKck5LdEIwYzR0Vzc0U29HMy9YbTlTc3lU?=
 =?utf-8?B?TEdTRk9aMUdxVmlWZkZLeHR3N1o4VFQzWjMvcXF1OFVnQlpuY2xHd2pmbjN2?=
 =?utf-8?B?aXk3Rnp4RDBsSVR3Q054YjVkSzdTQ3AwTUdmQ1hoK1BuTUpubk1aZ05rdFls?=
 =?utf-8?B?UWlPZkQrb1pOYXc3Q1dUUXV2U1pDeWk3aVZjUVVOVHVrVm0xSTBtSWxWL3Js?=
 =?utf-8?B?NGM2cjJxZ3N6WXIvSFgzM0dNMDNUQmZDeHpXeVJoUXZKcisrbkVMMWE5NmtD?=
 =?utf-8?B?VWYzQnFJcXdaZDY2Q2tzVEM3Qlpud0E2KytSK3JIb3o3MlJEcHdZQVRUc3hx?=
 =?utf-8?B?dG1aZ3E0ODM0K3J2QUl6ZHdTVmpNeVlrS3ZvdDhvVS9IWU01eXdYMFM2cGFu?=
 =?utf-8?B?NlZBMkE5UzFMMWRNV2lSeG8yYUZrcHZBdWZiMWxBejYxSkdhL0crdzYvblEw?=
 =?utf-8?B?enYrWmJ5MjZSNS9NVXQyclZBdVU2dThhUGUyaDJOSmh4bEcrYlpOSzdacTFr?=
 =?utf-8?B?NzRVUmM4S05BTEw0QlhjWWg4ZFV4bE9Eb0FJMFl4QzkvVjRGRmpOTzRLYTlh?=
 =?utf-8?B?WWE1UldkV0ovZytTYWZyUjhMR2YxVkpuTmJBd0wyZVo4UC9XWFZ0dEpoays1?=
 =?utf-8?B?bTc5TGduWFpBYWdOVWt2ZkFTZkJiU292Ymlmc3dtNHN0N1FWNVhMbjVYZjFZ?=
 =?utf-8?B?Vmlac1ZYbTdlTlF5VjltQ1RXMzdKT3F1blo3K1BLWXp5TGc4Yk12Mm9pRkgx?=
 =?utf-8?B?YzlRdUNybEE1b2tWUE4xQVB0TkthUEc1VjJRS2lLWVRLZjl3d2ZGVTBWdmhk?=
 =?utf-8?B?MzBsVTVubkV5bnpIeURBcnV4YVpVbGY1K1hBQ2Z4eTZQa1BZWWk5RlphVm5G?=
 =?utf-8?B?VHZmNjlvcDhFTmpONUtYc1d1K3Z0NXBKdllRQ0o3U09seXhLa29vWjU1NXc4?=
 =?utf-8?B?NDRHdUtVYUtBZzVRemgzOE5QNHVTeDBmZWR3MUZXeE5KS09nOFBzUVd3TVJM?=
 =?utf-8?B?ZWlKNGJyYnZWVkwrMlEvQWlNVVY5L0FtYm43VzBpekNNT2k2emhQTDFsY3pL?=
 =?utf-8?Q?HuQpxmjCjVNwMepD1Nqgn7ln2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ad1953-5e97-4e0b-bb3e-08db918fc0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 06:31:20.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuGlGSmOL3LwDT/+P1q0WQo6seKwHkleT5V71ezgkF359FLFmJ7CaWiTLQqwsMstNgW6HtNXDUeBmDwpDEh+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBTYXR1cmRh
eSwgSnVseSAyOSwgMjAyMyAxOjU2IEFNDQo+IA0KPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAw
NDowMzo1N0FNIC0wNzAwLCBZaSBMaXUgd3JvdGU6DQo+IA0KPiA+ICsJc3dpdGNoIChwdF9vYmot
PnR5cGUpIHsNCj4gPiArCWNhc2UgSU9NTVVGRF9PQkpfSU9BUzoNCj4gPiArCQlpb2FzID0gY29u
dGFpbmVyX29mKHB0X29iaiwgc3RydWN0IGlvbW11ZmRfaW9hcywgb2JqKTsNCj4gPiArCQlicmVh
azsNCj4gPiArCWNhc2UgSU9NTVVGRF9PQkpfSFdfUEFHRVRBQkxFOg0KPiA+ICsJCS8qIHB0X2lk
IHBvaW50cyBIV1BUIG9ubHkgd2hlbiBod3B0X3R5cGUNCj4gaXMgIUlPTU1VX0hXUFRfVFlQRV9E
RUZBVUxUICovDQo+ID4gKwkJaWYgKGNtZC0+aHdwdF90eXBlID09IElPTU1VX0hXUFRfVFlQRV9E
RUZBVUxUKSB7DQo+ID4gKwkJCXJjID0gLUVJTlZBTDsNCj4gPiArCQkJZ290byBvdXRfcHV0X3B0
Ow0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJcGFyZW50ID0gY29udGFpbmVyX29mKHB0X29iaiwg
c3RydWN0IGlvbW11ZmRfaHdfcGFnZXRhYmxlLA0KPiBvYmopOw0KPiA+ICsJCS8qDQo+ID4gKwkJ
ICogQ2Fubm90IGFsbG9jYXRlIHVzZXItbWFuYWdlZCBod3B0IGxpbmtpbmcgdG8NCj4gYXV0b19j
cmVhdGVkDQo+ID4gKwkJICogaHdwdC4gSWYgdGhlIHBhcmVudCBod3B0IGlzIGFscmVhZHkgYSB1
c2VyLW1hbmFnZWQgaHdwdCwNCj4gPiArCQkgKiBkb24ndCBhbGxvY2F0ZSBhbm90aGVyIHVzZXIt
bWFuYWdlZCBod3B0IGxpbmtpbmcgdG8gaXQuDQo+ID4gKwkJICovDQo+ID4gKwkJaWYgKHBhcmVu
dC0+YXV0b19kb21haW4gfHwgcGFyZW50LT5wYXJlbnQpIHsNCj4gPiArCQkJcmMgPSAtRUlOVkFM
Ow0KPiA+ICsJCQlnb3RvIG91dF9wdXRfcHQ7DQo+ID4gKwkJfQ0KPiA+ICsJCWlvYXMgPSBwYXJl
bnQtPmlvYXM7DQo+IA0KPiBXaHkgZG8gd2Ugc2V0IGlvYXMgaGVyZT8gSSB3b3VsZCB0aGluayBp
dCBzaG91bGQgYmUgTlVMTC4NCj4gDQo+IEkgdGhpbmsgaXQgaXMgbG9va2luZyBsaWtlIGEgbWlz
dGFrZSB0byB0cnkgYW5kIHJlLXVzZQ0KPiBpb21tdWZkX2h3X3BhZ2V0YWJsZV9hbGxvYygpIGRp
cmVjdGx5IGZvciB0aGUgbmVzdGVkIGNhc2UuIEl0IHNob3VsZA0KPiBub3QgaGF2ZSBhIElPQVMg
YXJndW1lbnQsIGl0IHNob3VsZCBub3QgZG8gZW5mb3JjZV9jYywgb3IgaW9wdF8qDQo+IGZ1bmN0
aW9ucw0KDQplbmZvcmNlX2NjIGlzIHN0aWxsIHJlcXVpcmVkIHNpbmNlIGl0J3MgYWJvdXQgbWVt
b3J5IGFjY2Vzc2VzIHBvc3QNCnBhZ2UgdGFibGUgd2Fsa2luZyAobm8gbWF0dGVyIHRoZSB3YWxr
ZWQgdGFibGUgaXMgc2luZ2xlIHN0YWdlIG9yDQpuZXN0ZWQpLg0KDQo+IA0KPiBTbyBtdXN0IG9m
IHRoZSBmdW5jdGlvbiBpcyByZW1vdmVkLiBQcm9iYWJseSBiZXR0ZXIgdG8gbWFrZSBhIG5ldw0K
PiBpb2FzLWxlc3MgZnVuY3Rpb24gZm9yIHRoZSBuZXN0aW5nIGNhc2UuDQo+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11ZmQvbWFpbi5jDQo+IGIvZHJpdmVycy9pb21tdS9p
b21tdWZkL21haW4uYw0KPiA+IGluZGV4IDUxMGRiMTE0ZmM2MS4uNWY0NDIwNjI2NDIxIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9tYWluLmMNCj4gPiArKysgYi9kcml2
ZXJzL2lvbW11L2lvbW11ZmQvbWFpbi5jDQo+ID4gQEAgLTQyNiw3ICs0MjYsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IGlvbW11ZmRfaW9jdGxfb3ANCj4gaW9tbXVmZF9pb2N0bF9vcHNbXSA9IHsN
Cj4gPiAgCUlPQ1RMX09QKElPTU1VX0dFVF9IV19JTkZPLCBpb21tdWZkX2dldF9od19pbmZvLCBz
dHJ1Y3QNCj4gaW9tbXVfaHdfaW5mbywNCj4gPiAgCQkgX19yZXNlcnZlZCksDQo+ID4gIAlJT0NU
TF9PUChJT01NVV9IV1BUX0FMTE9DLCBpb21tdWZkX2h3cHRfYWxsb2MsIHN0cnVjdA0KPiBpb21t
dV9od3B0X2FsbG9jLA0KPiA+IC0JCSBfX3Jlc2VydmVkKSwNCj4gPiArCQkgZGF0YV91cHRyKSwN
Cj4gDQo+IE5vbm8sIHRoZXNlIGNhbiBuZXZlciBjaGFuZ2Ugb25jZSB3ZSBwdXQgdGhlbSBpdC4g
SXQgc3BlY2lmaWVzIHRoZQ0KPiBoYXJkIG1pbmltdW0gc2l6ZSB0aGF0IHVzZXJzcGFjZSBtdXN0
IHByb3ZpZGUuIElmIHVzZXJzcGFjZSBnaXZlcyBsZXNzDQo+IHRoYW4gdGhpcyB0aGVuIHRoZSBp
b2N0bCBhbHdheXMgZmFpbHMuIENoYW5naW5nIGl0IGJyZWFrcyBhbGwgdGhlDQo+IGV4aXN0aW5n
IHNvZnR3YXJlLg0KPiANCj4gVGhlIGNvcmUgY29kZSBlbnN1cmVzIHRoYXQgdGhlIHRyYWlsaW5n
IHBhcnQgb2YgdGhlIGNtZCBzdHJ1Y3QgaXMNCj4gemVybydkIHRoZSBleHRlbmRlZCBpbXBsZW1l
bnRhdGlvbiBtdXN0IGNvcGUgd2l0aCBaZXJvJ2QgdmFsdWVzLCB3aGljaA0KPiB0aGlzIGRvZXMu
DQo+IA0KDQpJZGVhbGx5IGV4cGFuZGluZyB1QVBJIHN0cnVjdHVyZSBzaXplIHNob3VsZCBjb21l
IHdpdGggbmV3IGZsYWcgYml0cy4NCg0KdGhpcyBvbmUgbWlnaHQgYmUgYSBiaXQgc3BlY2lhbC4g
aHdwdF9hbGxvYygpIHNlcmllcyB3YXMganVzdCBxdWV1ZWQgdG8NCmlvbW11ZmQtbmV4dC4gSWYg
dGhlIG5lc3Rpbmcgc2VyaWVzIGNvdWxkIGNvbWUgdG9nZXRoZXIgaW4gb25lIGN5Y2xlDQp0aGVu
IHByb2JhYmx5IGNoYW5naW5nIGl0IGluIGN1cnJlbnQgd2F5IGlzIGZpbmUgc2luY2UgdGhlcmUg
aXMgbm8NCmV4aXN0aW5nIHNvZnR3YXJlLiBPdGhlcndpc2Ugd2UgbmVlZCBmb2xsb3cgY29tbW9u
IHByYWN0aWNlLiDwn5iKDQo=

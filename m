Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822B73638A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFTGW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjFTGW1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 02:22:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD110DD;
        Mon, 19 Jun 2023 23:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687242146; x=1718778146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ioizTEEf5CGFGsU2oMQZuHq/Dvm3qxf1vLwLAeXrJoI=;
  b=g8wEFOsNDnLqn3IeMucXZP6UoLmcSwz5VBuT3I23aZ59T54YUlVboQKH
   43HIpvrhSJ4Lct6yzC3qjDFb2gme899pRs00RXMTn2WCsUkg+nCrbViTx
   jQ67fS3of8Fd23BT4FSitX5JEry29Ke5LUPVLMK0RZW9TBsmj3j6Sfwu2
   66cP0+C1ueiMyQZW0k9q0Zx4ilqskOcKlGdNbbGmWiYRVOsEXeW4MAFVK
   oN8aVRb0bCEA/+k78pGwzLAgm7mzHOjFYVT6krM9kwZktcPB+lXBc9+N2
   Nl9ZvKx8YOdlgqMOAKp37CNYq75kgVAh1uwB1Wuq/QkyeCBqSSQPqMl+e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="388958320"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="388958320"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 23:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="713919189"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="713919189"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2023 23:22:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 23:22:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 23:22:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 23:22:24 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 23:22:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIli3fNokcDpvSpL+EEC4kJEpjuuYjYXW6kHtfTOVzL4X88IaU9aGwlvQ4MfBA6Ox3H7SslZde8fe9euQnQwTr5DslpND0Kcx/zHVy55kRvMTYnTm9mY8V06zxkr5Z0Wb9ElBZmiuqxd3nbgEVAGYA0r0nW0PbydpAgNJXZYWyByDWBkca2sjGqiH6fb9iH2nyxm++laZoJE4Ls9JJeQuVwPksVXqWLYtTtZxGEro9P+wqCgBeZ6p+Q1I1ltUWdCaPu/r6JXXV4ri+gNC0sEQiWixHTL44vFFuDoVjMeyoh/r2HvRtUVBZog3OBATHXbsYcMMT49vbavh7gWbkhIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioizTEEf5CGFGsU2oMQZuHq/Dvm3qxf1vLwLAeXrJoI=;
 b=J3Qe8pmO/gmG8VbWjYsm/jxly4NRN4B7TTOMSfcjeLcP0Sv5r7Uwlrnf+lCiNP64NgORrwcpni588AybmnBf64wv81vuqYdulilKdtqktmQl67lnIMIdMu+to2gFcpYBjw8b/GC+nKnmz+LdVXM3climXXP+16XuYpbfjW56jp+4jspEt/MnMSoSJ/KdzzwQhBhVDFz6mN5PKFhPXUfcgiTOIwvn0n54GrqXMZaJnlAQEuTIsYr+ZIHm+McizNyXvRjIi3VErQs1v7+tgTF4ukCWPsEPXKUsfixT0+WXcLQQLXKLn1Duwzc7fe7IVvtkdVHN73RnpFP3qdB9GbHauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 06:22:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e7db:878:dfab:826d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e7db:878:dfab:826d%3]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 06:22:21 +0000
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZhBgR7oRrGL/nhU610QGcca53Ma9pG/AAgBeLNCCAABE6gIASvWqQ
Date:   Tue, 20 Jun 2023 06:22:20 +0000
Message-ID: <DS0PR11MB7529E0EEFC3E33549875549CC35CA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-8-yi.l.liu@intel.com>
 <BN9PR11MB52768C95F6E9B943066F39218C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB752919431F624E8E3EFE1C38C350A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <097a2abf-e817-99ca-1f31-dbd439aaade8@linux.intel.com>
In-Reply-To: <097a2abf-e817-99ca-1f31-dbd439aaade8@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CO6PR11MB5586:EE_
x-ms-office365-filtering-correlation-id: b034da16-4ce4-4e05-8cf1-08db7156b460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hC/ynwiGbMVqDM2ur3IwxGHhDBXDGV1vRJ0h24Vu161G1vaRGVe5/7jXBH341pMcTnlYXWrgWInQ6ugRjJo/m/1DWXMEa2Ur8vU3G0AfvuywSsoEPjEeR3z3Njy2TS3CnMXspYMV1MFZLL0jP+YS+ENu1qzEaC4PP6wF8uNEYhHxPTp7sNDU/fF/CuWUkTtlto7slH5AyxC5JblpnINm8bmyQJq34O1CdesQrFPS9M5FuXwfHBQELlPowcrXC8K/fFPvCewlgFRLnZ6rToOr/Uit+vSzvWVhUGhX/pYkaSWIs08n6QHQMgXu4iImismfRTKOSr5tqlmvz1eYYaxvmCAEtirr/MhuUBTrtAj9Br5T5WCPJvSQstLUO5cSufNSaTR8T9k6Hy4PWQig02sl7mCT7w3rOsfEbkOuEttGA9rUxRArnedUwXff5qfN61a72huo8zbYqahAf5csT5fxt+YJXaU4rb3qDZKFoFSh7UlYAKM6oZn/BcslsUsYhsvemNv4arpoA5xW+yJ2nvkR58qHFCrDWnrWkaqewZTDBtSVvh2gvQ7KOcjYNT9HJ5aLfdMpIKtGXXAJB/KNyLqRBZwucAF5/v6DZlAjVpmjDu14fiFexLGlxmnlPMxeUa3A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199021)(5660300002)(52536014)(33656002)(66946007)(316002)(4326008)(76116006)(66476007)(66556008)(64756008)(66446008)(7416002)(2906002)(8676002)(8936002)(41300700001)(55016003)(110136005)(7696005)(54906003)(38070700005)(86362001)(478600001)(38100700002)(122000001)(6506007)(53546011)(186003)(9686003)(82960400001)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNjV3hVcHEzakg4Y3J4bzJ5Ly80SS94eEhXUjA4NjMvVVVwbkFiMjRGd2VD?=
 =?utf-8?B?RmoyV2YvWmtjNUtZVFZBcHk4MlRpait0ZkFGemk1MmRkaGNoU2ZXTTZLaVF6?=
 =?utf-8?B?UVZucmI3d2VVb290RUFTQUdUQmhlalRPL0ZDREczam96cndLUDh5UWY3eStu?=
 =?utf-8?B?ekRsb2pMMGlrUTVjdVVmT2Jyd09CeWY5dXdoaGN2RU5UcEFsQkdKUllCY0Vz?=
 =?utf-8?B?czN4MWdrbjdjek0veUw2QmJTZ1h2UzVSYXovcFR5c2tRYm54M093dzhId0xQ?=
 =?utf-8?B?a2JzbTIzTnpKV3NUSndIMXRPd2tiYjVGMjZONE1aMVBjcUd6NGgrZVcyYzcx?=
 =?utf-8?B?U3BpaWh5KzNZeUw2Vnk4NzI1SDhWZEFjOEhad2RKUldtbnpxMkZOcDFVUVRs?=
 =?utf-8?B?YWFoeFZQRSs3aXFuSkYxYm9jVmlHMEtwVm0vNERTOUlFbEMxaXdqc2UzbUVZ?=
 =?utf-8?B?aXBSRmFlYitWV08zMzFZR2tkR251SlFhWDFSQllNZjNVY0xrcTVHbnBWRXFw?=
 =?utf-8?B?cUlwVEZOc3NJWDQydkM5QW5XWmZYQ0p2eE1Ua0s4THBHUmJhQXJYK2t2aFhr?=
 =?utf-8?B?ck5wbEZ1M0JhVWVYU3pNYnlIVUNYUDRXZ3lIUEJxM0RKcjA5WklwR0Z5bjNI?=
 =?utf-8?B?QkxBZUdGR0VRZXVDNFZncXc3bjF4a3V1Tm1jRXkyNTNtbTAxOW9sMzI5eEw1?=
 =?utf-8?B?YTVULzlvVUxlY0xDMXhNTTJxbUM3VldlemdCU1VBRkhMcU5VUzd1TGw1cU1j?=
 =?utf-8?B?WHpONWpySkNIVnlFSWNFbk4rMWdGTE0vRFE0Z0taRGFRK1hjdHpWaEszZXhs?=
 =?utf-8?B?ZklxWExOSTdKVnZVdjJNSXIwVE5ReW8vcEdFcWJDUEdlYVJiNThHUUVVM2Vt?=
 =?utf-8?B?RHgrdWpkVktTMGQwNHc0UkVTazRKdm1XNVhIUEt2ajd5T0t4dWhOYVNZRU5O?=
 =?utf-8?B?QWx1dlc0QXZENUlZMWNLeFVuMkMyQ0t1bzlhaGxKaVV6blhpLzZCVmd0ZHlR?=
 =?utf-8?B?Qm1xQWdodkxiM0NNa3dFZ1RVTmhuK0kyZ3ZqcTdFTms2UXFldnlzWG5CMXVF?=
 =?utf-8?B?djFqTHNMVXhORnMwMS9kNU1LUnF5NmN2d1RnTVhWMUFyVUR0bnpJWEtzb2w5?=
 =?utf-8?B?L3dReWgwSWpRTk45VXJQTDdPSlZZcUFjZDBIUGtHRmFtR2tvelVIYjZiTWVa?=
 =?utf-8?B?YmowSVRCb1lBaUo0d3FiUUZnYXV3TXJXRWRuRFhaTzJqNGgwd2N5UXlvV0Fh?=
 =?utf-8?B?VHUvZjEvdkhhTjB0NHRhWnhvQ0NYaGZRY2JvMTlIa1cvTDlQcTZjMXpCeTls?=
 =?utf-8?B?Z0hlaVRHOUhNM1RUTEZ6YXEwYmtZd1JicHNKRkJYazB1Lzd6S1lRdStJaDVs?=
 =?utf-8?B?L09hNGUxTHVHU2F4LzBWaXk5aWgzMVpIbUl0eER3R1hjZlI0bkpVYjh2ZEk5?=
 =?utf-8?B?MzBaZTNjTG9XNGRQTTdZaHp0QjZwc0FOSW9KUDJkL3BlWnJlZHptQ1Jxa3dm?=
 =?utf-8?B?S1ROamdtbGhyNlpPcXJaQnhnZ0tQajlIYnV6UDhnM3NTdWJuSUhMc3pUd1I5?=
 =?utf-8?B?a0JkUUw0em1LNUVmYlRaRncveVJzdzRMOVJJTlp1SnZiOGZVbmZxSlBXOXRw?=
 =?utf-8?B?cGdXK2pueUFyRlhxc1c5ZXlrY3JqaTZ4WHBDeS9yaHUxM2NiZm15MDcxcTQ3?=
 =?utf-8?B?VWZoVzBRRW15bDhIVkl2d3l6WkdsdVoyUXdwWjlOc3c5bkZNWk0yUVh1Sytt?=
 =?utf-8?B?bVhVR3J5Njl0eUE3c1FTVmprUUhsaWlROFNzeCtSbkh2RStBaXd4aGJwRXYy?=
 =?utf-8?B?cFM0cjdCRHJvdENSc2NLVkFTVFR3K2NJczFLRlY0NmtoNXJyKzJFTi83akhp?=
 =?utf-8?B?Zk50WGpLQkdSNnBTKzBPdHVodUJ3dVFkNnZSNkZhZnJUWEZ4bkkwbzN2SlYy?=
 =?utf-8?B?d3FJdDhqTjlLdTRENkJMRFNWSDVWWXFHWVRsSWkxTHZtSGF2Yys3Q0VIWXd5?=
 =?utf-8?B?SGR5ZmVnbFdZaXlSRmpSMlNnY2RIZjlUMjN2VllneW9oRlIvNzdpajU5UUZP?=
 =?utf-8?B?OHIxNTdERDdqSDBRaXZBTXgyZUdva3RoSUROUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b034da16-4ce4-4e05-8cf1-08db7156b460
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 06:22:20.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QhY0jO+dH6aeL4qKo4eoanA0FVt+enq5Vdu1p1vegJjSbmBB6mbU1g7ZTBtc3+Lck0mF5NQZofOGD/ADKnebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,TRACKER_ID,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSA4LCAyMDIzIDQ6MDggUE0NCj4gDQo+IE9uIDIwMjMvNi84IDE1OjE0LCBMaXUs
IFlpIEwgd3JvdGU6DQo+ID4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RhZ2UtMSBwYWdlIHRhYmxlIGNhY2hlDQo+ID4+PiArICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW52YWxpZGF0aW9uDQo+ID4+PiAr
ICogQElPTU1VX1ZURF9RSV9GTEFHU19MRUFGOiBUaGUgTEVBRiBmbGFnIGluZGljYXRlcyB3aGV0
aGVyIG9ubHkgdGhlDQo+ID4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICBsZWFmIFBU
RSBjYWNoaW5nIG5lZWRzIHRvIGJlIGludmFsaWRhdGVkDQo+ID4+PiArICogICAgICAgICAgICAg
ICAgICAgICAgICAgICBhbmQgb3RoZXIgcGFnaW5nIHN0cnVjdHVyZSBjYWNoZXMgY2FuIGJlDQo+
ID4+PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICBwcmVzZXJ2ZWQuDQo+ID4+PiArICov
DQo+ID4+IHdoYXQgYWJvdXQgIkRyYWluIFJlYWRzIiBhbmQgIkRyYWluIFdyaXRlcyI/IElzIHRo
ZSB1c2VyIGFsbG93ZWQvcmVxdWlyZWQNCj4gPj4gdG8gcHJvdmlkZSB0aG9zZSBoaW50cz8NCj4g
PiBBbGwgb3RoZXIgY29tbWVudHMgZ290LiBGb3IgdGhlc2UgdHdvIGhpbnRzLCB0aGUgdHdvIGZs
YWdzIGFyZSBmcm9tIHRoZSBJT1RMQg0KPiA+IEludmFsaWRhdGlvbiBkZXNjcmlwdG9yLiBQZXIg
YmVsb3cgZGVzY3JpcHRpb24sIHRoZSBoYXJkd2FyZSB0aGF0IHN1cHBvcnRzIG5lc3RlZA0KPiA+
IHNob3VsZCBzdXBwb3J0IGRyYWluIGFuZCBkb2VzIG5vdCByZXF1aXJlIHNvZnR3YXJlIHRvIGFz
ayBmb3IgaXQuIFNvIGl0IGFwcGVhcnMgbm8NCj4gPiBuZWVkIHRvIGRlZmluZSB0aGVtIGluIHVh
cGkuDQo+ID4NCj4gPiAiSGFyZHdhcmUgaW1wbGVtZW50YXRpb24gd2l0aCBNYWpvciBWZXJzaW9u
IDIgb3IgaGlnaGVyIChWRVJfUkVHKSwNCj4gPiBhbHdheXMgcGVyZm9ybXMgcmVxdWlyZWQgZHJh
aW4gd2l0aG91dCBzb2Z0d2FyZSBleHBsaWNpdGx5IHJlcXVlc3RpbmcNCj4gPiBhIGRyYWluIGlu
IElPVExCIGludmFsaWRhdGlvbi4gVGhpcyBmaWVsZCBpcyBkZXByZWNhdGVkIGFuZCBoYXJkd2Fy
ZQ0KPiA+IHdpbGwgYWx3YXlzIHJlcG9ydCBpdCBhcyAxIHRvIG1haW50YWluIGJhY2t3YXJkIGNv
bXBhdGliaWxpdHkgd2l0aA0KPiA+IHNvZnR3YXJlIg0KPiANCj4gTWFrZSBzZW5zZS4gUGVyaGFw
cyB3ZSBjYW4gYWxzbyByZW1vdmUgYmVsb3cgY29kZSBpbg0KPiBfX2lvbW11X2ZsdXNoX2lvdGxi
KCk6DQo+IA0KPiAgICAgICAgICAvKiBOb3RlOiBzZXQgZHJhaW4gcmVhZC93cml0ZSAqLw0KPiAj
aWYgMA0KPiAgICAgICAgICAvKg0KPiAgICAgICAgICAgKiBUaGlzIGlzIHByb2JhYmx5IHRvIGJl
IHN1cGVyIHNlY3VyZS4uIExvb2tzIGxpa2Ugd2UgY2FuDQo+ICAgICAgICAgICAqIGlnbm9yZSBp
dCB3aXRob3V0IGFueSBpbXBhY3QuDQo+ICAgICAgICAgICAqLw0KPiAgICAgICAgICBpZiAoY2Fw
X3JlYWRfZHJhaW4oaW9tbXUtPmNhcCkpDQo+ICAgICAgICAgICAgICAgICAgdmFsIHw9IERNQV9U
TEJfUkVBRF9EUkFJTjsNCj4gI2VuZGlmDQoNClRoaXMgc2VlbXMgZGVhZCBjb2RlLiBCdXQgaXQg
aXMgdGhlcmUgZm9yIGEgbG9uZyB0aW1lIHNpbmNlIGJlbG93IGNvbW1pdC4NCg0KYmEzOTU5Mjc2
NGVkMjBjZWUwOWFhZTUzNTJlNjAzYTI3YmY1NmIwZA0KDQpSZWdhcmRzLA0KWWkgTGl1DQo=

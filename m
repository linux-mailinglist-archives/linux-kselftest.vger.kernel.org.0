Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55012693C60
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 03:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBMCeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Feb 2023 21:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBMCeX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Feb 2023 21:34:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C08E3B3;
        Sun, 12 Feb 2023 18:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676255661; x=1707791661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VIjQ4UHkh1N5Q1gzb1J+wKglLLxCUr3DhDWs1piR7Wo=;
  b=OeoVQAWyZP7ejhIDKFtvjl/GuS+bepPqY2Rlpa9qOiVKY+T1EUt9UVTX
   ejYUMg/RvE+JI3rH7kE+Ih/U/rSA4C6KEa4mGsdpkEJxpSMdY44HzSs2V
   fOsDjBOnATSntc9bwUGsM7WCrDpqSJj0zZpSS3wWHxN7HlEVfoN5YfnBg
   dDoSf6P1DbopOLQ32E1GK0hDnJs+UjHoqNQXu+h+2cneZwjVwX6FPGPD1
   uieau4EMn1AFBi3YXEYDn+6FetcB8zdvLZ5gaCrKL612rACn0cj4YPWWn
   GczxQ4cdHUBZbyLH5WWiGv+KqXVgBd+1OAsIOSlZMhXF7+T9uobVOVCBM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="318816860"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="318816860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 18:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="777646955"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="777646955"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2023 18:34:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:34:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 18:34:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 18:34:20 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 18:34:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCWS+PY5H+4ZKuE15/vBYyvHvVWatmLWn5g6ro6WPQQprGVV9m3o0IYetFIGB9Cj5rHr7bwagHEkXHiHlbplTtdrjoA4hIwddO5/DO9rjoA/xai+ZRDo7HI5rEt8o4RRlES8rWNiokeks8hRp4gxt2F/d6lTN91BXrm5WJt5MtkjxDxzVm/48gLxZ7sgtd/7w3aiLGDI1FEEsQY+dKykTyrVSQPoE+lQn1NsAfzwNJHRkvYq8OtX5Woi7uzp5W3eVe8B2P2CrET9KyV0qpFfIyIlhm2s4FObnHQ1KVV1o38bluLgWkzi/0yixrxNp//FJfuiuF/FQtk1EKX3plWN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIjQ4UHkh1N5Q1gzb1J+wKglLLxCUr3DhDWs1piR7Wo=;
 b=hZKH+tPucEjiieSpukyKE6Al1rKcuucqgi/v1btJOfcsom+dzoyxjwsXF+eB3tgEDPSv7CXDPJN8UCyd3um8bNf/yFo5Z4cHDijYKTbCJjH1PBaV9XjMT24hcRhh1Q1+o1dFQBoVKB6V0I9f4dny8MjFD5+mpDOFfA2dKxRuoJNlPxrQDt2klxyP1I1npMmPrjDz3gxtrWhhsAjTcVqWexWmQUrDRG/a2xMulT9YSm2ZeH7IIvztnoxKAiWGeRHBIG/YRFsQ3jzVh0v9g+EgTev2bj+6RSu+NlcUHO0lXbf68cB8Vzz12ndtnEDJrjsmZtYf3CpJ+gknROanuAoeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SA3PR11MB7415.namprd11.prod.outlook.com (2603:10b6:806:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 02:34:18 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::38d9:ca7f:b9fc:ef7f%8]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 02:34:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Thread-Topic: [PATCH v2 08/10] iommufd/device: Use
 iommu_group_replace_domain()
Thread-Index: AQHZOzoV+UAbwLQwnEuO17sJd5b+0K7F+NzggAEnS4CAAE2/cIABdh8AgANLy2A=
Date:   Mon, 13 Feb 2023 02:34:18 +0000
Message-ID: <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
In-Reply-To: <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SA3PR11MB7415:EE_
x-ms-office365-filtering-correlation-id: 694cb586-f31c-4005-c02e-08db0d6ace79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBRyyufvxWE8+0ols3gAQOzXmpxw/ntAkrWysHoNJmnTGU+DmNGhkljkB6Po5Cvi+OQ00CXj1tpmDhgllwLWpawKeNVOkTOMZ3aGBsIcvYesH3DTD5uMV6AqeMWpGIyHs3k5RJGg5sNTdNyinnJa5phRwmOBNEZqyZt3AurIaELbl8n49w8XZuIAE+BM+Y0Upyi+Q8LvpAbXO33rawRFshDyDD+ZKoFdaWLXP+UHKw7UPPPNYxjbnsEa88B2fsvzqJmtriyIlC7S6IoijbTLWB0edXiP3fOgpy+cFpyB96EX5jtJT9LHLqKWX7VlcJ2z0P54JpsLX3es+r40p2E908a/RQiiM5OmXtmY1Cl9IivQI+y/VZJqIyT6f4LnN2VZ00GiYfLc81dO6IELJ8nlTzslrQvu3wqspo7QVZisPiC8+6DhclVisffGAhZFcZinlbjPJlQ74SR9fKUzlTUFkSjKMig3efN6P0ctKTL0lGrJlzMZnmilJN/vAIpVcp6qLVxYDvOSbhpYGM3c1SYQGHc4sjJeS6kinn+rBVcnL6GxagV3UJrUNqmX6NToo1jx9zrMWFz/pu/udGuos1dAu7AVh6nInZliicFl+wXbqREJnq67qbyGZC/ywBF7hujX/+g9QMpMICrtjadzC9U1GBJ64i8CYdvME7neodIu4Y5Xd9rw+gftNyhueyUtLqupdL9wPCvLBWkqHdy8Ai1mfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(41300700001)(7416002)(66446008)(110136005)(52536014)(66946007)(54906003)(66556008)(64756008)(8676002)(66476007)(316002)(5660300002)(8936002)(76116006)(4326008)(71200400001)(2906002)(7696005)(478600001)(26005)(186003)(9686003)(6506007)(33656002)(55016003)(82960400001)(38100700002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VW1CdHRsRDRpM3hSbnRLNUlXeExKN3FtQ0xCRjRFMVBqUFp1VHczcUNVNHFH?=
 =?utf-8?B?TmVPVkRTSU9sK25VTHBGT2VsVmdIZXpoWWVISW5PVmM3dGZTMFhmSGZKQThO?=
 =?utf-8?B?N3p6M2tmVFNYaFlMK2FqZVROY0JuYStZWlhrWHdkZ0FmYWJGSS9zaUFnTEJw?=
 =?utf-8?B?aFo0M2R1enpBSXIzVEsxZ1drTzh4V2IrL0t5MjI1NXo4Qmdwa2x4bDNDZzdk?=
 =?utf-8?B?MXJ5TXFlVTZwY0tKbnBVVTlpM0hmV2lxbE05WmdRZnhaaEl4a3VVMy9lQVVo?=
 =?utf-8?B?RUhQdHJEakNsc0NHTVlLbTRrNURsNHdJa2syRU4rcGpEYXZOM2xzbjdxMzRo?=
 =?utf-8?B?U1dsZDZQSnVIR1BZNHY2NDNqSHBrem9ueHRqN0xUeUhlMi9uT0pSSlhyeXVF?=
 =?utf-8?B?M3hQSElsT1lZVE1QNXNva1o1c3hFekNuNkZURXRVN05ncERSOXFmUzVsbll5?=
 =?utf-8?B?RW1RUk04bTJUTmQzbllHUTlRZ1d2d0F5UXlHc2tOTEVPeUlQNmM3K1kwRVlj?=
 =?utf-8?B?dWdDejArRU5mcEZCejFNSHFDbXIweVlSb1lrV2RqOEUwUGFKeGJFdG9TRmRY?=
 =?utf-8?B?V1NxOVd1WGFLTHpHNHArSXZlZlRPUEliWFhJZ2RXMGdZbEtvM0FtNThjUWZl?=
 =?utf-8?B?RmhPNkNlK3RTTXhMbVdaY01nNTdlUklBZGVCaVJ6SDkzRHJwWXJjZ1FlY1Fm?=
 =?utf-8?B?KzZEVlJnWmppVDU4Mnd5eVNPdlQxNWJUeUVYQVlsTjRnYnlJTUtqVVUvNDhQ?=
 =?utf-8?B?cWtiSzNwY0JmeXJGMEMwMzJvRnNDVVpYMjZMM3BVMjNjb25HSGZaSHBzNDFK?=
 =?utf-8?B?RzdldVZWNHB1K2xkZkd6VFp6akVieGg2YTlRTU1mRHNFdFJhTEtzZ1FQMDF0?=
 =?utf-8?B?VStveUljZmJSRU9sNVRwbS84QjNhS1ZyMkg3RFZ4ODNkTDdScy9qMmgyeWky?=
 =?utf-8?B?RUFtQTlUK3F0bXU1dUJMdU01K25ISk9sTmlXN2JmYTM2Q00xYkJqM1ozak0y?=
 =?utf-8?B?Z1VkOWtwM3ZJVkRxUDVQTWxyV0l1R0xDeGpNeVUvbWViZi9xZUlmeFErbURH?=
 =?utf-8?B?SmRUWjErdU9IcGJKTzNPNFhWbWtlcktDWElrV25HZmRWWS80S3B6YXZqRFor?=
 =?utf-8?B?MmVqQ2hRNXZRYXBGRFhjUkJ5R25PeFZCeGorMkR5eXRnSGtIbEZhZWRYREFJ?=
 =?utf-8?B?d1RqdzVobzc4TnVRNWNGS2s4R3J5Y2ZOK21LWDF2c1Foc05Qc1dDU0RIUnRj?=
 =?utf-8?B?YlRyR0pJWG5FaldUY1k3YzBJUUh1NTVlVGZvMXlBdU9IdDR3MndMQnZRLys3?=
 =?utf-8?B?S3BOKzh5T3pTYVJuaWxURTVDbEFJRWZmRWxId3Q3MTdObTZzUUU4Qy8rSDdo?=
 =?utf-8?B?Yk5uekpBaDQ4bU5uL1FTNjJkMkFPeGQzdWI5Y091M251NXhJU3hXQ09mU3dC?=
 =?utf-8?B?dTNPVmowSVJGRVVXTzhwcXY2WGg2YTd1M25OSFNOelRlcjRmaUE2UG0yeU5s?=
 =?utf-8?B?QitNTVZmNFFEY3FHdzRiVWRMZUdQVFlHZlVUMjZIWGNuM2d2OTFQVURCbTdC?=
 =?utf-8?B?RXBmZG5teXlWajhva3ZHV0ZRSitibVcwbnV0eEc3WXF0dEI3RUY1SGFWVjM2?=
 =?utf-8?B?NDhZWEVzc3hiYVY0ZFozbHU1bldCdnc0QVNoandyR0YxZWRINVhHZUUwSDV5?=
 =?utf-8?B?ZjM4WkRJOUdDNXk5RU1pc1VhVlAwcHVBVzZuSGU0ak03TWNsTXhBRXJ1RVI4?=
 =?utf-8?B?bXkwL2lXNjhYQkloTUxMYzlHdXFzNllJQnlqWnE4NC9Kem9WbVZLQ2NQZGEx?=
 =?utf-8?B?cFhJOGdQVGNwR0l5R3JRaDJuT1V6V0ZaNFZvN2kxUEpHZjkwbDB5UjBkYjNZ?=
 =?utf-8?B?SzEwQXl1eDlXS29vSDFuL092d2JoMHNuZVU4czFNMEJuY3E5bWlseVU2UE9R?=
 =?utf-8?B?UzhTSHhCMGlpZGQ0dGk3L09HTVJyQ2N0MTV1cXhQWlhPNUIyWTVGNGc1bGJV?=
 =?utf-8?B?MWZQTytYekNGTGhEMFpvZTN0RTlXUE5LbUplY1BIMU91S1QxaURDYUk0RUJV?=
 =?utf-8?B?RlhsWXRxekI4YjdDUXJIZUlTeHA2UVJaYjFhTDYrZC9teXcyQWRUaUt5WEEv?=
 =?utf-8?Q?mEGhBFIWLzXYrhiAk1Jui0+et?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694cb586-f31c-4005-c02e-08db0d6ace79
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 02:34:18.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2d7kZh+qR/lTLEhiU291cOitqKsDN7JVBOPXGQ+09hDsispaLIy0LsAhqdgtbPLjLt5kYkr1ucXEey+TbnL62g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7415
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFNhdHVy
ZGF5LCBGZWJydWFyeSAxMSwgMjAyMyA4OjEwIEFNDQo+IA0KPiBPbiBGcmksIEZlYiAxMCwgMjAy
MyBhdCAwMjoxMToyM0FNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gDQo+ID4gPiA+ID4g
KyAgICAgaWYgKCFpb21tdWZkX2h3X3BhZ2V0YWJsZV9oYXNfZ3JvdXAoaHdwdCwgaWRldi0+Z3Jv
dXApKSB7DQo+ID4gPiA+ID4gKyAgICAgICAgICAgICBpZiAobGlzdF9lbXB0eSgmaHdwdC0+ZGV2
aWNlcykpIHsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgaW9wdF90YWJsZV9yZW1v
dmVfZG9tYWluKCZod3B0LT5pb2FzLT5pb3B0LA0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdwdC0+ZG9tYWluKTsNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJmh3cHQtPmh3cHRfaXRlbSk7DQo+ID4gPiA+
ID4gKyAgICAgICAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+IEknbSBub3Qgc3VyZSBob3cgdGhp
cyBjYW4gYmUgZnVsbHkgc2hhcmVkIGJldHdlZW4gZGV0YWNoIGFuZCByZXBsYWNlLg0KPiA+ID4g
PiBIZXJlIHNvbWUgd29yayBlLmcuIGFib3ZlIG5lZWRzIHRvIGJlIGRvbmUgYmVmb3JlIGNhbGxp
bmcNCj4gPiA+ID4gaW9tbXVfZ3JvdXBfcmVwbGFjZV9kb21haW4oKSB3aGlsZSBvdGhlcnMgY2Fu
IGJlIGRvbmUgYWZ0ZXJ3YXJkcy4NCj4gPiA+DQo+ID4gPiBUaGlzIGlvcHRfdGFibGVfcmVtb3Zl
X2RvbWFpbi9saXN0X2RlbCBpcyBzdXBwb3NlZCB0byBiZSBkb25lIGluDQo+ID4gPiB0aGUgaHdw
dCdzIGRlc3Ryb3koKSBhY3R1YWxseS4gV2UgY291bGRuJ3QgbW92ZSBpdCBiZWNhdXNlIGl0J2QN
Cj4gPiA+IG5lZWQgdGhlIG5ldyBkb21haW5fYWxsb2NfdXNlciBvcCBhbmQgaXRzIGltcGxlbWVu
dGF0aW9uIGluIEFSTQ0KPiA+ID4gZHJpdmVyLiBPdmVyYWxsLCBJIHRoaW5rIGl0IHNob3VsZCBi
ZSBzYWZlIHRvIHB1dCBpdCBiZWhpbmQgdGhlDQo+ID4gPiBpb21tdV9ncm91cF9yZXBsYWNlX2Rv
bWFpbigpLg0KPiA+ID4NCj4gPg0KPiA+IE15IGNvbmZ1c2lvbiBpcyB0aGF0IHdlIGhhdmUgZGlm
ZmVyZW50IGZsb3dzIGJldHdlZW4gZGV0YWNoL2F0dGFjaA0KPiA+IGFuZCByZXBsYWNlLg0KPiA+
DQo+ID4gdG9kYXkgd2l0aCBzZXBhcmF0ZSBkZXRhY2grYXR0YWNoIHdlIGhhdmUgZm9sbG93aW5n
IGZsb3c6DQo+ID4NCj4gPiAgICAgICAgIFJlbW92ZSBkZXZpY2UgZnJvbSBjdXJyZW50IGh3cHQ7
DQo+ID4gICAgICAgICBpZiAobGFzdF9kZXZpY2UgaW4gaHdwdCkgew0KPiA+ICAgICAgICAgICAg
ICAgICBSZW1vdmUgaHdwdCBkb21haW4gZnJvbSBjdXJyZW50IGlvcHQ7DQo+ID4gICAgICAgICAg
ICAgICAgIGlmIChsYXN0X2RldmljZSBpbiBncm91cCkNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXRhY2ggZ3JvdXAgZnJvbSBod3B0IGRvbWFpbjsNCj4gPiAgICAgICAgIH0NCj4gPg0K
PiA+ICAgICAgICAgaWYgKGZpcnN0IGRldmljZSBpbiBncm91cCkgew0KPiA+ICAgICAgICAgICAg
ICAgICBhdHRhY2ggZ3JvdXAgdG8gbmV3IGh3cHQgZG9tYWluOw0KPiA+ICAgICAgICAgICAgICAg
ICBpZiAoZmlyc3RfZGV2aWNlIGluIGh3cHQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
QWRkIGh3cHQgZG9tYWluIHRvIG5ldyBpb3B0Ow0KPiA+ICAgICAgICAgQWRkIGRldmljZSB0byBu
ZXcgaHdwdDsNCj4gPg0KPiA+IGJ1dCByZXBsYWNlIGZsb3cgaXMgZGlmZmVyZW50IG9uIHRoZSBk
ZXRhY2ggcGFydDoNCj4gPg0KPiA+ICAgICAgICAgaWYgKGZpcnN0IGRldmljZSBpbiBncm91cCkg
ew0KPiA+ICAgICAgICAgICAgICAgICByZXBsYWNlIGdyb3VwJ3MgZG9tYWluIGZyb20gY3VycmVu
dCBod3B0IHRvIG5ldyBod3B0Ow0KPiA+ICAgICAgICAgICAgICAgICBpZiAoZmlyc3RfZGV2aWNl
IGluIGh3cHQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgQWRkIGh3cHQgZG9tYWluIHRv
IG5ldyBpb3B0Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBSZW1vdmUgZGV2aWNl
IGZyb20gb2xkIGh3cHQ7DQo+ID4gICAgICAgICBpZiAobGFzdF9kZXZpY2UgaW4gb2xkIGh3cHQp
DQo+ID4gICAgICAgICAgICAgICAgIFJlbW92ZSBod3B0IGRvbWFpbiBmcm9tIG9sZCBpb3B0Ow0K
PiA+DQo+ID4gICAgICAgICBBZGQgZGV2aWNlIHRvIG5ldyBod3B0Ow0KPiANCj4gT2guLi4gdGhp
bmtpbmcgaXQgY2FyZWZ1bGx5LCBJIHNlZSB0aGUgZmxvdyBkb2VzIGxvb2sgYSBiaXQgb2ZmLg0K
PiBQZXJoYXBzIGl0J3MgYmV0dGVyIHRvIGhhdmUgYSBzaW1pbGFyIGZsb3cgZm9yIHJlcGxhY2Uu
DQo+IA0KPiBIb3dldmVyLCBJIHRoaW5rIHNvbWV0aGluZyB3b3VsZCBiZSBzdGlsbCBkaWZmZXJl
bnQgZHVlIHRvIGl0cw0KPiB0cmlja3kgbmF0dXJlLCBlc3BlY2lhbGx5IGZvciBhIG11bHRpLWRl
dmljZSBpb21tdV9ncm91cC4NCj4gDQo+IEFuIGlvbW11X2dyb3VwX2RldGFjaCBoYXBwZW5zIG9u
bHkgd2hlbiBhIGRldmljZSBpcyB0aGUgbGFzdCBvbmUNCj4gaW4gaXRzIGdyb3VwIHRvIGdvIHRo
cm91Z2ggdGhlIHJvdXRpbmUgdmlhIGEgREVUQUNIIGlvY3RsLCB3aGlsZQ0KPiBhbiBpb21tdV9n
cm91cF9yZXBsYWNlX2RvbWFpbigpIGhhcHBlbnMgb25seSB3aGVuIHRoZSBkZXZpY2UgaXMNCj4g
dGhlIGZpcnN0IG9uZSBpbiBpdHMgZ3JvdXAgdG8gZ28gdGhyb3VnaCB0aGUgcm91dGluZSB2aWEg
YW5vdGhlcg0KPiBBVFRBQ0ggaW9jdGwuIEhvd2V2ZXIsIHdoZW4gdGhlIGZpcnN0IGRldmljZSBk
b2VzIGEgcmVwbGFjZSwgdGhlDQo+IGNsZWFudXAgcm91dGluZSBvZiB0aGUgb2xkIGh3cHQgaXMg
YSBOT1AsIHNpbmNlIHRoZXJlIGFyZSBzdGlsbA0KPiBvdGhlciBkZXZpY2VzIChzYW1lIGdyb3Vw
KSBpbiB0aGUgb2xkIGh3cHQuIEFuZCB0d28gaW1wbGljYXRpb25zDQo+IGhlcmU6DQo+IDEpIEFu
eSBvdGhlciBkZXZpY2UgaW4gdGhlIHNhbWUgZ3JvdXAgaGFzIHRvIGZvcmNpYmx5IHN3aXRjaCB0
bw0KPiAgICB0aGUgbmV3IGRvbWFpbiwgd2hlbiB0aGUgZmlyc3QgZGV2aWNlIGRvZXMgYSByZXBs
YWNlLg0KPiAyKSBUaGUgYWN0dWFsIGh3cHQgY2xlYW51cCBjYW4gb25seSBoYXBwZW4gYXQgdGhl
IGxhc3QgZGV2aWNlJ3MNCj4gICAgcmVwbGFjZSBjYWxsLg0KPiANCj4gVGhpcyBhbHNvIG1lYW5z
IHRoYXQga2VybmVsIGhhcyB0byByZWx5IG9uIHRoZSBpbnRlZ3JpdHkgb2YgdGhlDQo+IHVzZXIg
c3BhY2UgdGhhdCBpdCBtdXN0IHJlcGxhY2UgYWxsIGFjdGl2ZSBkZXZpY2VzIGluIHRoZSBncm91
cDoNCj4gDQoNCkphc29uIHN1Z2dlc3RlZCB0byBtb3ZlIGh3cHQgY2xlYW51cCBvdXQgb2YgdGhl
IGRldGFjaCBwYXRoDQppbiBoaXMgcmVwbHkgdG8gcGF0Y2g3LiBQcmVzdW1hYmx5IHdpdGggdGhh
dCBmaXggdGhlIG1ham9yIHRyaWNreQ0KcG9pbnQgYWJvdXQgaHdwdCBpbiBmb2xsb3dpbmcgc2Nl
bmFyaW9zIHdvdWxkIGRpc2FwcGVhci4gTGV0J3MNCnNlZSBob3cgaXQgd2lsbCB3b3JrIG91dCB0
aGVuLiDwn5iKDQo=

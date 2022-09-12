Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C915B554B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiILHYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 03:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiILHYE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 03:24:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54047303D2;
        Mon, 12 Sep 2022 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662967290; x=1694503290;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dYgvQwdhbAA7zA7AkPIEulMYjZjK3x+PFiwbH8QcZS8=;
  b=GdQOlDJVd3Nh/W2aBckawdOru95i7bv74MXVXnNa4c8fu5VjYvEfYlbs
   zUj8a8qWr0A02MpiEDAXmdWMtnt284oZUTLUYJmngqr4rhvS4AwqMKXVv
   SPzzyHqM9aZPPJ2S36GF7QJanS7N5I6t9ookCrfBKip1ffoejVfSpihah
   GmA20Qbw7r/mOch6h3ZOPdM1tLkeuHIlTRY+4TjyXEGu7ABtP7lLyRQn6
   b5R9sX87vRqVZCPoeexUyEL3ybJLcuO6ZHGSHytyCXAJdjTYF4NxXlPSG
   mBit07oaaBsRS/Tkgh4otsUr8TfxdUr1evZYHgIw3YUCLgMMQ5S759cTz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="277536895"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="277536895"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 00:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="791457977"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 12 Sep 2022 00:21:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 00:21:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 00:21:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 00:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNrUbyxTcXY4akOO2/e8pvaYSmBHP2v1a0qTQLoWE9ENDsGmm9EpxSbcSDctzLOyul2sXUtm3ER1HMMUVQrDyLCSW48biBnxPfGJCTcG9cjs76oPViPq8f6rKVyWstTmYjEY8btLIFKP2+VnGPgZUqt6pk63WrGOloKw5CYPNg5VIbdyc/x9/pU19uPvZ163vafJiPChfX9FMSNcig0/P17EETYfmYuXj+IP72a3LV3KF5nW03/UKM32FKWnMtySPzLdanvorKgjptr/3YvfwMHCWDQiW6tec2xbBlXZzhpAGB8pk+c4gFnAphCBaeVSSpUCXOjvjLS2RovIej7Pog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYgvQwdhbAA7zA7AkPIEulMYjZjK3x+PFiwbH8QcZS8=;
 b=ZTPBpkoWmqAZg6Z2kCzdv+mh8QcDnC9mICzxAcYyu70jhOIr+KPW+hVMciHmmSML3qz7nzg3WIx9LG9NP/jsuklOXGd5ZRIgoc5KdFGMuaSfHrtonzWb/oS88JoZwHUEOVJ0KswDH5ZKuNazs63PtHj5BgmVvh/fIzMSquWoyMzMtYRZmv5+edfF2NufsK5lyv96mr/KjIC8eYPfRNhBytsnXH3ZaaQK2Mdvfc/EXC+vp7UN3vnccNOoHcX31ClNWtOwF6mntmRuTUUlHE18l1s5rpR+ixQOn+mVWd0sLcAfSsPRLLmJhip4sugk3CNw0sAwP0QkXzRThgvZfEvqMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Mon, 12 Sep
 2022 07:21:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 07:21:13 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Topic: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Index: AQHYxII0tYXIMKuy6U6cCAuVrVQNk63bZ3QA
Date:   Mon, 12 Sep 2022 07:21:13 +0000
Message-ID: <9983d33b59668cfa3bc1d36beaf13f5a4180bad3.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB7056:EE_
x-ms-office365-filtering-correlation-id: 456ef93c-b4c0-4e91-5e47-08da948f5fa0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4CFkaucXEgN5pzwA54CPrYOTmrLaznPtd4rbR556+64b6dqFxe3w6DIXr7exTFDpxG2KA5cPaUpUd6HWFDELnaHLjT/yzFpSUXUGpx5nWyaiQ4YYdMxctjSJ76ayTQg1IqtJz0Rf2PEbYSSmIly+ttFn5Jw+6Mr278fBGkcELwmQ1PQl4E828Yr2O3Afr+bwo5IzY+G1JVNEZW7CN/PXoNuF4/SJe/Y7PbakLNoYFeOZHntE8sBj1XH4cmMN4sk4EY81kuoIOtRd99+jyWO7DnDfYmJBVTjqLHJi+B7/Gfy+lEJ2GRopNnZy95AM3hSxobJHVsF9hbKAMXjpCLgEp4k+N2+s5E0DtOhx5kS93t5v1a107yjjM+aZ42OzzQhucl1iIMI3SPc4hdW4oUsQOK+oLAf0QWq/NvjfjoahnGhsVJ69ISIbkhC5o00ni7///l/OBI+Jw81o00TvPNHe9Ak7CAIYCkBNAmX9XUe/9Qs8P7ksKQKuYpypgKPrqFLFhlI3ZUoTSJZUNK3PQNsB1g1WRGLb4WZGvDSN9/UpvCEqrqz6qdgrPmgYpL25zUuq0sdDnjMHzUf8elX8M69V243hnnDtlXAMc7/tE/aIPJc1ZiUlqpURAyMn0E7I6GgaboyusCZS/dKaeo8OBmUqA9bByqvyPTxUgYNWzewOvk5X4znVYkVOG08udLP2NfGghKzXQeKar7cdMdapw4LxdCS0JQ4DoJj/3ugRd74a1x0eVZXJdNgtdjjsFXHlvjnDdDjsh1z7nJuBkeGD7scpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(6512007)(91956017)(82960400001)(8676002)(316002)(38070700005)(66946007)(66476007)(66556008)(6486002)(4326008)(66446008)(71200400001)(36756003)(41300700001)(76116006)(110136005)(478600001)(54906003)(64756008)(6506007)(5660300002)(26005)(86362001)(7416002)(8936002)(2906002)(4744005)(186003)(38100700002)(122000001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHZJd3Z0OEIyRERtWXc2L0NEZjZ1TWJLZUg2djVKUjRQeTdQaDBXeTdsaVEz?=
 =?utf-8?B?ak5KT1dRZFR3M1ovREJnUVNwODNVaTI1L2IyeUlWSDJZWlh5bWNqWDhEVEMw?=
 =?utf-8?B?WFBtWnNTK043R2l6WmZCTWc4c1hBRjRPVnBuVkVjWVh3bDRKNmdYQ1ZaS2lQ?=
 =?utf-8?B?bHFxUkx3ODlUbmJTdUkwNUhPUzl1Y3h3akF4ZlVuVmZaS3QyenBVejFYVFRZ?=
 =?utf-8?B?MmZKMHBZalhvbUVLYmdMbE10Mld0R3JsaUYyUFk4Nmh6ZklOU1ZkTGRPeVRD?=
 =?utf-8?B?d1kvTkVBZVdLVlRuUnFoSERBOHFjbkFKdWdIOXhaYzBSSmp1RU9FTGd3TWRj?=
 =?utf-8?B?S0xlODdjeDYyK1M1TjZHL0cwaUNpWDcvdUN6dTEzM3JWYTYrSWNuYUVTakdu?=
 =?utf-8?B?cmYyMDZqNmZSVU0rQ3FmeHM1NXZ6ZWd2NTNPTUdHeVRxa0RJWU1RK0w1dUJW?=
 =?utf-8?B?QmErREVCVTdQWHJVQ0phd1lqU253K3JoTnVQY2xZQmZ3bldLYTNQY3drdWlS?=
 =?utf-8?B?R1ZxVGcwRDFXS3R0di83REpPRGI4ZTFJeVhLWm9mbWgyaFR4OHlocEJMaSth?=
 =?utf-8?B?c1BVZTBqd3hBbHJPa3pLQXowL1pCeEdBamtuM1VlZ0o2V05WNFFHeFZ1eHNK?=
 =?utf-8?B?Y0tVaWpQQnNpK1VCWXFXclpzN0daMVJKN1NETFB4TTlrT1pkQjhhVjlRRXQ0?=
 =?utf-8?B?TnE1aWU5UndhbDRuRGNadmFva0FQczNxc2Q4R1FTUDZuTHJhSGlqT2RjN1lR?=
 =?utf-8?B?ckFiZlpKQVp6YmhVK25EQjZDbW5nMjRuQmJ0YVNZZ2lOUGQvVXU5Tm1pcERZ?=
 =?utf-8?B?NVhiN1E2U3VIaW1nRWpiYkN0NmpFM0ZqdFpWVEpnZW9yZTlhMWJvS09tQVkz?=
 =?utf-8?B?UG9lSXU5U095Z0RUdnM4NlhEL29kbzlqSWNpdXdscHNoUVkwVy9SWHVCL2NZ?=
 =?utf-8?B?eHdkQUlYM0JJUHpBUFFGRjdkMWgzRGpESVZjcnRmdTlHODkyNk01d080UFNH?=
 =?utf-8?B?Q2lnc2huNWdjUWFWQlRYZjFUemxXYXVpVDVZVXdjeDJ6RTVUWmUveXlyM3Fi?=
 =?utf-8?B?U1lGTW9oLzZVZjdiYmt0b01lT2R6bmFGY0QyNUxoRVFiVHh4WDJHZHFoVUV6?=
 =?utf-8?B?NHNtNTZnMS9POWg5YmN2MWE1VXJEaVlhVzRSMWVmQ0plNFp0VkVhUERyTERr?=
 =?utf-8?B?QkhGRnlWdXFsTlk5SDJNMzFoNlB0NzRtOHJTMWVCL1VVcjRIU2x4OHo0dS9h?=
 =?utf-8?B?NlA4dFp0RnIySG54Q1Ixei90K2d6UmxMQXNTN2NOZDVQSitGd083SWdXK2hl?=
 =?utf-8?B?ZWpPdDliZzJkWlVUY0pMd0pKcXdzWlNaRkwvTVVaTVRHRTV3MmNrWlFBd2Nz?=
 =?utf-8?B?OWhSbUhJQVl1S2FXTm9UMWpvVmNIWWlKNURZbmwvN21oNDI3QmJWYkhnWHFW?=
 =?utf-8?B?MVlpSm5aS1oxc3dGUStBZUlubjBocmI2MytxNHVHNklsRDNPbmo5Rml3TkZ0?=
 =?utf-8?B?OWREQlR5aENDR3NFSFpXMjluZEJlN0t6MSszNFlCN3NOUXJGRUhZS0JKeG5G?=
 =?utf-8?B?ZHRhblJ5akJQYmJqSUZZNStaRndUazgyUmFqZjEvekVSNmZOTkpHK2Y0MWR6?=
 =?utf-8?B?ZDNtK2lZUjFWVlpHMllmaHNra0Z5cTI1WHhySzlFS1ZJRkJIZU1RR2xjdjFy?=
 =?utf-8?B?bjA5UGVOaDBDWnFYU2hVaDFkNTZNa01kV3lNOElwSytlUWF1QjlhUk16VHNV?=
 =?utf-8?B?Z1lxZWQvV1V5cWkzVysvMHFORlRucW9VbXVYa1VPL1ovazFkOHNTdEdZTkxs?=
 =?utf-8?B?UVVUaklIS1NvMXZaeVc3djlMSksvMERGamlYaWlzcjhXVksyQVhGRzd0R2ha?=
 =?utf-8?B?WGFaaHhOcVRwdWY3ZnFTcm4wbE5DbFZtWHJrU21NTndhTDhpWWtNb3YyUkQv?=
 =?utf-8?B?TGNSanhaVThtTkp0Yk4zRXJQQTBJQlQySnBERUdkcW9rc0E4bVpaTmhvUTlw?=
 =?utf-8?B?VTBHWjI4L296bXg2T0wwRWUxa05pdDVaK2RqWVVsRXk3dGRDMUd5dG1YK29u?=
 =?utf-8?B?UFdOeXowTnpMMUhhMmkvRFFTMzZzc2IrTlFqWS9UUDdpTUdQY2ZpL1pjVEhQ?=
 =?utf-8?B?VmM3OW9UQUU3RHlybmNaWkpieVVZZ0o5ck4yY0wvKzhkRWtUbXcvNHcvbStP?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6A98E755B5524DAAD9D930640B7FAE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456ef93c-b4c0-4e91-5e47-08da948f5fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 07:21:13.1301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oyAHPQMC4n0eu0ohBV3/BPaTcICssuJNMoQDgjTO+QIC+MHiL+SmgfjW+rLVkHpED3Fu1D5w7Oxertgpv53r4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDEyOjI3IC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gSW50ZWwncyBURFggZ3Vlc3QgZHJpdmVyIGV4cG9zZXMgVERYX0NNRF9H
RVRfUkVQT1JUIElPQ1RMIGludGVyZmFjZSB0bw0KPiBnZXQgdGhlIFREUkVQT1JUIGZyb20gdGhl
IHVzZXIgc3BhY2UuDQoNCihTb3JyeSBtaXNzZWQgdGhpcyBvbmUgaW4gcHJldmlvdXMgcmVwbHkp
Lg0KDQpBbHNvLCB0aGUgSU9DVEwgaXMgdG8gcmV0dXJuIHRoZSBURFJFUE9SVCBfdG9fIHVzZXJz
cGFjZSwgYnV0IG5vdCBnZXQgdGhlDQpURFJFUE9SVCBfZnJvbV8gdXNlcnNwYWNlLg0KDQotLSAN
ClRoYW5rcywNCi1LYWkNCg0KDQo=

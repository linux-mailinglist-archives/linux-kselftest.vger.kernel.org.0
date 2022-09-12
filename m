Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBF5B63D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 00:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiILWzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILWy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 18:54:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95216596;
        Mon, 12 Sep 2022 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663023297; x=1694559297;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FUNc+5evWRhb6DBMDhEAbwo1UXcgPvAEU6biLouKMYo=;
  b=ejXmoEpDQrwiGMYH/UAoLaOTfQaPBneeKb44TDlBqtOB1hIQUwpEGE8+
   3HEaVWni85jeDSFtu3bSTdiPHrrKJCF+DSBgayueloyKNzQroxqxJK2Xe
   dhqjhAeqW9gtBwvFxf0IAQ0LTjYQkY+tst0WU0LDzcN9qNBrA6MaaP2nu
   9gHm2jKJJ96ENYm7g/mUl7/YXqsPzTOcTv4fFZ/uN5HcjFk33UqSQjTc6
   CutZ+De346F/mUTrGCNT4SYRnDo9WTgt5fKDJ3W0IXxY7VPOeCrk1ohwT
   JM+fJvToIYYL2qjveFytNxBmUSZ+H+PWaTbR99Z9aMuA7ENjrArPG/6gR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="296723202"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296723202"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 15:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="944817549"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 15:54:57 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:54:56 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:54:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 15:54:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 15:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlrJQCnnEP75N5IjGSJuwThAF1BdtybOftMIW/OyPIkepFgweF/P2xYwd+BLo1YFi1UHxle7gDlhUQDR38AQ6Svm57Veg6qUc23MHk272Iqtd3ho0jb9N7F7Ymx82xr9oM+bJgRQAapuuw1tNscHqKowlPkQpDhjhQwz5RjJhjb3MocUvk9lUpKX63PFY7oaIUkzT2olyz/YgA0qpvgSyUd+NWmB67+rlatNbd5gRNn2SnPILPHczL6jm7rp5LCWaWlCi9N241w8dIgzVhMKpQbfuhTf+NmEl9kG3gW2cPhjpCeD+Cb42iHJCy1zDzyzlZ7Jc0UNu5zFmJ5kpbDimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUNc+5evWRhb6DBMDhEAbwo1UXcgPvAEU6biLouKMYo=;
 b=V3mi6yfjbb3EezoaJIBCXLqhY1Ib2DNzcpaea1oa+K6hf3cx2zg0hOX4xFUzxAVdwrKoebAUAwtJA/VXvqCONQ+wbl3FKr/Z2ZcmrLrgipbxX73ee87QNRwd/yridUdsnhTXHD3zPue8L6jG21EmERD5GKLsDGbwzrYhK9QPwX/OXeprEYnVb4ebnNloyGYdI/G74DG8RqNmsR0qw4XDr9b3efr7edsKzbiP8zOUyfYV+Jv0/iXaF0OCS5n/Tv0U8j42bMRtzJcXetR01URuKeN+n0rUwXkQ301H8jHWDcWQ87Riv3fnOw07Fw/aTmYqCm+rupL117oJbIEKOKm/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5292.namprd11.prod.outlook.com (2603:10b6:408:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 22:54:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 22:54:47 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Topic: [PATCH v13 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Thread-Index: AQHYxII0tYXIMKuy6U6cCAuVrVQNk63bZk6AgAD4XYCAAA2fAA==
Date:   Mon, 12 Sep 2022 22:54:47 +0000
Message-ID: <2379fc61dea736ff1a5260997869c45ab7e01a0d.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-3-sathyanarayanan.kuppuswamy@linux.intel.com>
         <73c43175226bb0f9a9dcae8ba953b213db47fbc8.camel@intel.com>
         <7600f26c-d107-a0ec-f601-9bd8c203fc81@linux.intel.com>
In-Reply-To: <7600f26c-d107-a0ec-f601-9bd8c203fc81@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5292:EE_
x-ms-office365-filtering-correlation-id: cda3851b-b467-45a8-3c03-08da9511ca9f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urHfhGmlZmud8IbDw/FaWXHAjIKSvMh894g1NcHdC0WWx50DM/3i3rJLiGZrncuPq7cJb/FP09lQ16mFioeaogxNFNlNLRk7o25ms1c6IM8TcWQ8itfccm24mD/sGzA8zHneuYMN55SK2rU9FNiKXRIAdFm10+k4qz7gUtR/m3zD74PxD80Ge9veLVHuHnzSwoiawwKo/DY5xyx5Cs1LAt59jbIjy8LaKXzqhBNNTPkxE/cW+n1x9dSBcuHzTWp29OOjbaOqkdNL0F56OSW2ZK1MX4joXAuMDOdMflyQvmvqixUZhyefS81PEjr/YMpNSQTNmmDHzQ75O1wJ8aPsT09dYgCu+fLYuUnz5b7LijaoLgLs8Z2iV9qxytYwaP5R6ptVMSTSJQMHx9OMIkZ/Vjik5ZcIh9VTdbztzN6b734/md6ROqWeKc5zMw1d447w8JYDuesnlDPoN4j642UuigPmJXsHof6hDnr9g0TEfyMvhb/QeHGdVPJbB7iauMbnl3SvloQ6E1bN6Xxoi+rWAjT8ls4qvIcNGo+4/ECyr1vcCkkfHkP/sIZ+UCMmOSJ3GEtiO/ZsunESmMMvVmYHHyOnObhqQKxQNtZUWvvWRb1O0wqPrwY9oeQXCUOjc+etnS8X5BgBFdV9fXAwAWgQxas9LSWvkjfE2ouX8ByKNov/iVw7ArEdwCHz8Xy0E1/hMHM126+BtOfT/6ovhBVT9fAZgwU8xtDscvnJlahXpbEtn2dlLCzf1XWZy2zFbwSmyHo5wTz0nF0o+TdemQOdog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(8936002)(6512007)(38070700005)(26005)(66476007)(86362001)(91956017)(66946007)(2906002)(82960400001)(38100700002)(2616005)(41300700001)(64756008)(478600001)(6506007)(66446008)(76116006)(122000001)(6486002)(8676002)(66556008)(71200400001)(186003)(36756003)(110136005)(83380400001)(316002)(5660300002)(4326008)(7416002)(53546011)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0VnRTY5akhWM2dOR3h2Tkt2b3Y1Qkl2M0M4YlFkRU5XSFlnMTZtd2IrTllL?=
 =?utf-8?B?anFEMDUvYytISmxXQmhORG5ZUWVWd0ovdTVlcklhUlhqQjZ6b0w3a3hQZUxh?=
 =?utf-8?B?YW04bGhxSjJMb2hGUzFrdWxuWmZqWktacXduYWJTNmo5Ni9VSXNaejk1aXBw?=
 =?utf-8?B?N0NwUkcvZCtsWWxDZHFEd2tKdEhHZWNvU05pWWNHNG44RG5XbktjSVBDSmpu?=
 =?utf-8?B?azZoOGI5UXFlVFJzb2NhNzdrcWg0UjhMV2Z5aDY4VkNOYmNuZjBaS0QwLzli?=
 =?utf-8?B?ZS9PNlpjZUh6Y0VkZWZxQ2s1Y2R1UzhaMnQvTUpQT2ZiTlMwRnd6OVNHRm56?=
 =?utf-8?B?U3ROckZLZ2tBSDVoU25weGw3Q3pJU3M4Z1dJS0ROb09ObXJrUE9MZGxWeFM3?=
 =?utf-8?B?WUZaWFM0T04xdktFVFp3cE0vRGgybXE4ZDg3SnVSVzVjZjNKYUR0cmcxVG5x?=
 =?utf-8?B?bDJ0M3pPK0RMS243S1F3NklDY1ByRGp3WE4yMldBdHZGb1MxTndXZkFwOUlB?=
 =?utf-8?B?dnRvUW9sWXkzRHNvd3dYbmtJK0NKajB3dE9XMnRvY0tiak44VDRjVU9iZExj?=
 =?utf-8?B?eEZ4bkJEdnc1YlBKVDUvK3gyU3d6UFBpK2FtN2lHZjR5bDQ5WDRlbXdScWJB?=
 =?utf-8?B?eGQrcnVtTm9HZjY4MWR4TWFmVTgwcndHTGQ5MldabW04RkR5TlFwSEk5eHg3?=
 =?utf-8?B?UUFqSFg3aW4wb3BrTnhaMkJwSTc5UklneStsU0dJYWhFUWRVZGhFMDlBWUVS?=
 =?utf-8?B?T1NPb3lEWnBiTTB1VVNmRTJvNkIzcThFSDl4bzQzbm1uYWZxMlJuTERLV2hp?=
 =?utf-8?B?SFRuNlREOXN3Vk01dWw5SUFia2tzVGFjaHlsRVdJcDFLM1BGdFJZeExkYWNE?=
 =?utf-8?B?VXFNcDZURWhXTTZzbExsbkZtcWVuVkZYUHdQRU1Ea1RZN0dtang5c2dNSDRM?=
 =?utf-8?B?Ukh1ZTJEL3BnZVRmMWtEODVMLzdTdmUwSEZYWTJPVXpvZ1IrMmo0VUg5Yk9Y?=
 =?utf-8?B?bXJ0U0lIREVDUkRRUjJIam1zTHRVQVdYczAzZXl1L0s2cHVQQXBjOExWNzc2?=
 =?utf-8?B?VGZoWjB6cEsxdkdOSW9PVk82bHpxbFVscStFbUJGaTVCUFBBUi94ek5wK29z?=
 =?utf-8?B?aEF3SExTNGtVSllqMEFqMmZFNGJibHZKYlROdFRqUFpablVsSUpDdmN0Y0Zt?=
 =?utf-8?B?bFVYakYyOXhha004UmR0LzRlOFdWcFVzWW4zai9yNmpTWGFlV08vK2w3MmhE?=
 =?utf-8?B?ZXRPRExPa2x1NDlsOFlQbVFhc3ErL2dqKzFzeldpSkJmNFlGNEs3cG5UMzND?=
 =?utf-8?B?NGg0K1YxNDJ5emFsNEN6OThqMG5TSlh1Ylh4SG9jMjVabFpHS0tKZ01IZ0pu?=
 =?utf-8?B?Z3M5VnRRcTZpUzd3M3JoSjVJcHc0NHlONFJCZTVFemEvUks1YnFpZE9XTzBS?=
 =?utf-8?B?SmROa3RBamJTcFV3WWFtRGtzMkJVRTZEWC9LRTVDWnZtdThSVkZXVWtYdnFq?=
 =?utf-8?B?Q293RGJTWnQyR2VxeVBWTHc4dkJzSTg2K2F2K2gyUFlIOGhXSW5vcVVEREpm?=
 =?utf-8?B?WkxqczBZVnJ3RnV1VGZVT1RuR0pCcWJLYVJQVWl0N1pCVWoyMjRwcTR3ZkJ5?=
 =?utf-8?B?S1E4YnFXV1VuTmpJLyt0bGlqSUNwSEVTRytuWmw0MFNMSXVDRnlrOTBHNkhW?=
 =?utf-8?B?cjhJTTlvbGtvSFg2NDVNS1FtRms4MUhHQTAyeGl2RUlxRlVOWEdSRUMyNTUz?=
 =?utf-8?B?Vm1VbXM5bmh6bWNncndxTmpVOXF4d3QrcVp1dDd4ZVZqRUpWR001SWRXeDNR?=
 =?utf-8?B?MXljYktibEUyeVpjaHN0UllPL015aW1YS3lWOE4zeTVPUzhQVHB0L3c0S1R3?=
 =?utf-8?B?NkYzQzRxTWNaUHdNVGxndmgzakpmS0VQV1pQQkEycnF1Tys1MndGV1ZNamxW?=
 =?utf-8?B?YUdmQnlqWHplQ0t0bHJtSlNMSGs1ZDlIM3lETFJ6VU9HeVBRamFIbTdEWS9t?=
 =?utf-8?B?RVVBS1oxd0FVY1U5ZHFEVFExdXBlRnJtODZEN0hmSUJNSFJBeXI1UStraEFB?=
 =?utf-8?B?S3JWdEJUTk4yNUF4eWlOLzFoZjZEYUJZeklqeGJRQitVUC9tTmMwNUpxOUhM?=
 =?utf-8?B?dno4bk1HV3h5Wm1aeWpQS2tBczRVNXdaWWt4MVdmd05LdHpqWmhwcnovbnNW?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F12C6083F1C4FD4DA45DAC98C2163408@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda3851b-b467-45a8-3c03-08da9511ca9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 22:54:47.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtkuFN1xhH3q627HDiS8j333MpMUY2ywyDKB+G9rBM6Cu/Ge+/8DPzzoga7fQut5VA64Q/Ryix9dfaRWNGGSWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5292
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDE1OjA2IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gSGkgS2FpLA0KPiANCj4gT24gOS8xMi8yMiAxMjoxNyBBTSwgSHVhbmcs
IEthaSB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjItMDktMDkgYXQgMTI6MjcgLTA3MDAsIEt1cHB1
c3dhbXkgU2F0aHlhbmFyYXlhbmFuIHdyb3RlOg0KPiA+ID4gQXR0ZXN0YXRpb24gaXMgdXNlZCB0
byB2ZXJpZnkgdGhlIHRydXN0d29ydGhpbmVzcyBvZiBhIFREWCBndWVzdC4NCj4gPiA+IER1cmlu
ZyB0aGUgZ3Vlc3QgYnJpbmctdXAsIEludGVsIFREWCBtb2R1bGUgbWVhc3VyZXMgYW5kIHJlY29y
ZHMNCj4gPiA+IHRoZSBpbml0aWFsIGNvbnRlbnRzIGFuZCBjb25maWd1cmF0aW9uIG9mIHRoZSBn
dWVzdCwgYW5kIGF0IHJ1bnRpbWUsDQo+ID4gPiBndWVzdCBzb2Z0d2FyZSB1c2VzIHJ1bnRpbWUg
bWVhc3VyZW1lbnQgcmVnaXN0ZXJzIChSTVRScykgdG8gbWVhc3VyZQ0KPiA+ID4gYW5kIHJlY29y
ZCBkZXRhaWxzIHJlbGF0ZWQgdG8ga2VybmVsIGltYWdlLCBjb21tYW5kIGxpbmUgcGFyYW1zLCBB
Q1BJDQo+ID4gPiB0YWJsZXMsIGluaXRyZCwgZXRjLiBBdCBURFggZ3Vlc3QgcnVudGltZSwgSW50
ZWwgU0dYIGF0dGVzdGF0aW9uDQo+ID4gPiBpbmZyYXN0cnVjdHVyZSBpcyByZS11c2VkIHRvIGF0
dGVzdCB0byB0aGVzZSBtZWFzdXJlbWVudCBkYXRhLg0KPiA+IA0KPiA+IFNpbWlsYXIgdGhlIGNv
bW1lbnQgdG8gcGF0Y2ggMywgSSBkb24ndCBwYXJ0aWN1bGFybHkgbGlrZSAidG8gYXR0ZXN0IiBw
YXJ0IGFzDQo+ID4gb25seSB0aGUgdmVyaWZpY2F0aW9uIHNlcnZpY2UgY2FuIHRydWx5IF9hdHRl
c3RfIHNvbXRoaW5nIChJIHN1cHBvc2UgdGhlICJTR1gNCj4gPiBpbmZyYXN0cnVjdHVyZSIgaGVy
ZSB5b3UgbWVhbiBTR1ggUUUgdG8gZ2VuZXJhdGUgdGhlIFF1b3RlKS4gDQo+ID4gDQo+ID4gSSB0
aGluayB5b3UgY2FuIGp1c3Qgc2F5IHNvbWV0aGluZyBsaWtlICJURFggbGV2ZXJhZ2VzIFNHWCBR
dW90ZSBtZWNoYW5pc20gdG8NCj4gPiBzdXBwb3J0IHJlbW90ZSBhdHRlc3RhdGlvbiBvZiBURFgg
Z3Vlc3RzIi4gIEFuZCB5b3UgY2FuIGNvbWJpbmUgdGhpcyB3aXRoIGJlbG93DQo+ID4gcGFyYWdy
YXBoLg0KPiANCj4gVGhlIHBhcnQgYWJvdXQgbGV2ZXJhZ2luZyB0aGUgU0dYIGluZnJhc3RydWN0
dXJlIGlzIG5vdCB2ZXJ5IGltcG9ydGFudC4gV2UgY2FuDQo+IGV2ZW4gZHJvcCBpdC4gQnV0IEkg
d2FudCB0byBhZGQgc29tZSBkZXRhaWxzIGFib3V0IHdoYXQgd2UgZG8gd2l0aCB0aGlzIG1lYXN1
cmVtZW50DQo+IGRhdGEuIEluIHRoZSBmaXJzdCBwYXJhZ3JhcGgsIHdlIGhhdmUgc3RhcnRlZCB3
aXRoIGNvbGxlY3Rpb24gb2YgbWVhc3VyZW1lbnRzIGRhdGEuDQo+IElmIHdlIGRpcmVjdGx5IGp1
bXAgdG8gYXR0ZXN0YXRpb24gcHJvY2VzcyB3aXRob3V0IGV4cGxhaW5pbmcgdGhlIG5lZWQgZm9y
IGNvbGxlY3RpbmcNCj4gbWVhc3VyZW1lbnRzLCBpdCB3aWxsIGJlIGEgYml0IGNvbmZ1c2luZy4N
Cj4gDQo+IEhvdyBhYm91dCBmb2xsb3dpbmcgdmVyc2lvbj8NCj4gDQo+IEF0dGVzdGF0aW9uIGlz
IHVzZWQgdG8gdmVyaWZ5IHRoZSB0cnVzdHdvcnRoaW5lc3Mgb2YgYSBURFggZ3Vlc3QuDQo+IA0K
PiBEdXJpbmcgdGhlIGd1ZXN0IGJyaW5nLXVwLCBJbnRlbCBURFggbW9kdWxlIG1lYXN1cmVzIGFu
ZCByZWNvcmRzDQo+IA0KPiB0aGUgaW5pdGlhbCBjb250ZW50cyBhbmQgY29uZmlndXJhdGlvbiBv
ZiB0aGUgZ3Vlc3QsIGFuZCBhdCBydW50aW1lLA0KPiANCj4gZ3Vlc3Qgc29mdHdhcmUgdXNlcyBy
dW50aW1lIG1lYXN1cmVtZW50IHJlZ2lzdGVycyAoUk1UUnMpIHRvIG1lYXN1cmUNCj4gDQo+IGFu
ZCByZWNvcmQgZGV0YWlscyByZWxhdGVkIHRvIGtlcm5lbCBpbWFnZSwgY29tbWFuZCBsaW5lIHBh
cmFtcywgQUNQSQ0KPiANCj4gdGFibGVzLCBpbml0cmQsIGV0Yy4gQXQgZ3Vlc3QgcnVudGltZSwg
dGhlIGF0dGVzdGF0aW9uIHByb2Nlc3MgaXMgdXNlZA0KPiB0bw0KPiAgYXR0ZXN0IHRvIHRoZXNl
IG1lYXN1cmVtZW50cy4NCg0KWWVhaCBmaW5lIHRvIG1lLg0K

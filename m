Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D27E661A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 10:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjKIJCo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 04:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjKIJC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 04:02:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5D211B;
        Thu,  9 Nov 2023 01:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699520546; x=1731056546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WLu2mjWtgwM2MjK26ypiwWfSLV+UHpiftKKpPqM04t4=;
  b=UsoJv0aSRrBVW8QApRNsIL29V/9W8tcJFyWpXOKv1cvsGaO/tDRv1XXC
   SBv8jNGVbbCbX/ExWumX2yiP29Fk6q1MYtQncviHb2fxVAu7YxPDZQOc/
   S39uhiXXzdQpAtto5MFfZpcCR5/KryzkSNquPbGeyEc0eDqyXaYWftDDW
   KrvlJLVp/oXHTXhXlqpuWjskIWjTXE28sgIBke2CB3mdMYJnsQXiCAwYQ
   CxqPhAJ1rqBKzwdAYWlFodjG3rJ9SNe7CugOx99msihx4gJkCf2R1NRfy
   d4+5rf+vGokmFDu9zW559CCdgIn8glkIiGVd56d1h2L7fKqhgbij6y/sr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="8594847"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8594847"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="833769378"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="833769378"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 01:02:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:02:23 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 01:02:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 01:02:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUynA/Txdw19AWbYwtfPeFXjbOSCb7tC9zvCm8xIAYff9Uj32e3D9KltuYpXLsIQHUefJ/MUUwfM5J3+OPipnj+8NNYWNII2iKw0cpHbMKTWC8xycNmiHLtMahLTvakgLFOWyF4PwX19Z1yp+LdAO3kYekqJ7C47HIO3Q0nxDbJdCyBE3cOs/YkIA1Rjnjp/Q6hkMgXBXcbHfjeM5YAiys3cvz+XVtZv98z5vAMwIBRkQMnqUoCAx8ntn9N+ARgX1ZssFMw/O7AthBecW634egQuQz2zy5J+miExkQW9tACwVf1GEk9SB1oop9YqKJWZoAoCPPkknl2FtODxIAY1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLu2mjWtgwM2MjK26ypiwWfSLV+UHpiftKKpPqM04t4=;
 b=LgAJ8D7asVPVjFzeTxX8tSy/kSFiFCfl5xHFcG9DgaT0WnvpMnJO4JTzHRUCIaLEF2/7XCBkD3C51ZvysRkedUR5h3ByIgEIO/oG4fXId8Vfky7g7jwTE+b3ThzF4xaTPVo5Elj7qvzUXtsqYJ72n/Lm6qSNePEKXyNhVV/HDfiSDCHmbhiY64UuSAFaqbiuekh9Q3EvM55lPnWsVQRGXSBlt8vEZsKlOU1MsddgbPgAc8ImaTvLN3nkZJ7A7tKlHL9J7ttNGGvJ+1xE+1KgZygWbVSYEWoBvreuN2+miiPtwhUWLIMK3ySA9aPd7HWSXMDRLLM+hwDYwjsQJESQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB7374.namprd11.prod.outlook.com (2603:10b6:8:102::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:02:21 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e10c:91d7:d34b:aa1d%6]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 09:02:21 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "shuah@kernel.org" <shuah@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "tj@kernel.org" <tj@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
CC:     "pehunt@redhat.com" <pehunt@redhat.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Thread-Topic: [PATCH v2 0/4] cgroup/cpuset: Improve CPU isolation in isolated
 partitions
Thread-Index: AQHaB3DhoxQclDG7n0mOBs83axt7CbBxyAGA
Date:   Thu, 9 Nov 2023 09:02:21 +0000
Message-ID: <98bea19ca5eb5c19ef0ea55f5167237cc841fe9b.camel@intel.com>
References: <20231025182555.4155614-1-longman@redhat.com>
In-Reply-To: <20231025182555.4155614-1-longman@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB7374:EE_
x-ms-office365-filtering-correlation-id: e50deb2a-c44c-4b91-b064-08dbe1029522
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oF1BLDIHnO6/JASye18Bhydjsku+GCjxIrEgOMP4B7eZLWJ/EhmUvchOjL8tnymq2EWOoDhI2KpwTLv7wjtErzZcmmN0fxcFQyTraJdpg+KZbzn/xTJQQebNUYs6xJDGULp9xIXlO1qCFMQO596JPqZQ9F0ed81kf8nptapGLZ+vhjSeu6DGcl8djQZTHZDVV+mP4UJPEbBQeJQGGdCN/6KeFq93oc6NpYE8b9uXm9aWlKrG/oa2hvSBLkvhhpyynxHaANrn0XnZXVx4yEjUs67Yj2wFM+dhSu5RL7W/iMdBdAJ3lxJInKFYUyaqIjbe84bfpPu0S3dsoGUIFBSWoY49uAbRP+vgvU4AR1cMYRsvPLOfXDptq4aLCCOexPZjgBpc2C7frG8s1aTct0GEM8/bVQSUHA8N5SZ4ZdugCevt+RX0Y8mbH4Ls6Y2fbHeJWbP2U8mpRWazn//SqnW6J20HIXtO/yE3kAnqupZy4d0ssJI6ETed4gbQuCqNS9iTjuk91sIfo3HI/kK2149Xq6kHZuPY6FCj/OBTYqHeHdXP2WzwBknYBv5fysD7kpO/sDT6crQfrOHfPcAZKham8r0hbbxr7BtEb5M9Gu22E1jI+2S23ddZrXW12yoTP3ZL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4001150100001)(2616005)(6506007)(6512007)(41300700001)(26005)(2906002)(8936002)(4326008)(8676002)(122000001)(5660300002)(6486002)(71200400001)(7416002)(66946007)(478600001)(316002)(110136005)(91956017)(66446008)(66556008)(64756008)(66476007)(38070700009)(76116006)(54906003)(38100700002)(36756003)(86362001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3Z6NlZVUG5IUmJYemhSdW1Yb3Y0QTN2eWpudVZpUUh5TjloNk1zWUxGVTBy?=
 =?utf-8?B?ejU5RlVvUitMRExHQjVlZFBvbDVyd0FGRGd6L2psTU1ha0tzM2ZRbjFVNVZl?=
 =?utf-8?B?dkpJR3l2NlF2VXNBbXczTnJwZS9WWWpaSkRHM241c295aUVoUzMrVDEvTnFi?=
 =?utf-8?B?ZStJYnFkUjRHWjluSVY3Zm50LzZCa2h3Tmx6NXFzOFE0aXNabVNzaE11enht?=
 =?utf-8?B?TUREZW1kRHJTY3M1bWQvODNBcFhESkJ4T2RQbHlud3YrT0tVZE1JTldiVkFQ?=
 =?utf-8?B?cTdMVmNPVkJWWm9HbWNReDhhRkZXTlBsa2NUZndCYi9SaDRHZnBIZERxWWdv?=
 =?utf-8?B?T0xBK2hNSVVBb1hKUlBrWFMzZitpZ1BGQ0gwMTVPSkRGekJQY3hrTjA3OHQy?=
 =?utf-8?B?NG9CNzlmcEdUZWw4MlNMK1E4NUM2K1pQcTVYM1FWOWRON09PWU12SVpmY3Jr?=
 =?utf-8?B?eElRMjJBY3NJQ3MwVVYzWEZDekUxaW5DY0p1Z2taYTlMempnb0s5TEFGaDRM?=
 =?utf-8?B?Tm9IdDJ2cG5sTVBGU3VWeXBZOUE1RVNDbGkyUzZQZmJNOUhoOXdldlZ0SlNm?=
 =?utf-8?B?emtSM1BxV1VTd01hbi9QZWN2Y3Rnc3BaOTU0YTF6Z203TG5scENmUE5MM1JU?=
 =?utf-8?B?SVJ4V1Z3cERUb1JZSkVaTm0rNFd2L2t6Sm4rWklqejMvQUJNK3MxamdlS0xM?=
 =?utf-8?B?MXVQY0VGQVYwYlhPYnNmN0dCRFh3OE9CNVFndGpvVlRPSkhEN2U4TDV3aW14?=
 =?utf-8?B?T1NtUHFROWFycTNjTFBodFlVR1F5YnNlSnFFQUZ4UUJSaWppN2NVUXN5SG9w?=
 =?utf-8?B?Zm0xL0xhVmlQYzM3dHJmWTZhMjJIcVM0TW1MT0MyWHdzRjZaelJMRlFMOHRV?=
 =?utf-8?B?YVpNdzZOejcwbUx5RkJia09VQVZ2RXpHbkVaNWlqU2d5SUZ0ejFzd3lhY1NT?=
 =?utf-8?B?eWtoYlNleGcrTlFuaURTRzhLRlpDNmY2c1c5Sk8xSkF1Z2NsdkVIM0taTU1j?=
 =?utf-8?B?V05QZnpiUUxXenpHVzMzUmF1NElpK2dwQm15SFB4QkJZSkVEeWFlSnRCSmc1?=
 =?utf-8?B?RERmSit4SGZ3VlE0aDF1OVo5RStaVmplOVdxKzRvMDhqZzZweTBwYm1XaCtH?=
 =?utf-8?B?RDA1RE9pVWJNZThqVU5FdVJma3pnVHlZc0FOaVh3Nk9aVEEyY1MyaFRXRDJV?=
 =?utf-8?B?ZjNRci9oUmQ2ajIwbEFzZTkvV0dPMWhWM3VLdFZDQUJ6SjEwczJFUzcxTzlS?=
 =?utf-8?B?NzZEUzJld1hjRy9xaG5kS0wxN1VHUmE1NTEzM2dhdnVCVE9FV0tNVXdHNlU5?=
 =?utf-8?B?QVBiSmhDK1BNa21kd0FkTFBaYWdMelJtYzFkM1FKTk9NcHJvS210Y0Q4cy9O?=
 =?utf-8?B?ZlNBVlFVMlFRU0toc0JyVi9Ka3JuSVlIbkdMTU8wSXBEeTNjSnBRRkxWVk95?=
 =?utf-8?B?dzFtVS9nc09vZElMbjRiTzQwRUlNRE5rWHpxRGJ1MEV3QUx5akdYbDFVUjRo?=
 =?utf-8?B?RzdmRGxPcmg2TVRPcmNYbldnTlFEL1lWdFhrVm1aaTBWRW1FbWFnSlM2Rm03?=
 =?utf-8?B?Qm9va0Vxa0doM0tKNCs0S3EyZk1IZUx5Ykh1d1A0VVVBaHdaNS9vUDljYklH?=
 =?utf-8?B?TklJTFZhY0VHN1BMSUZwQTdwam1Ud2d1cGJrbmVsVTFpaHpRTzEwQ242RGZw?=
 =?utf-8?B?UGFIWG5RdGxFckJUZUE5ckREZUVDYUhMcFVDWGRYUkw2MGZIcXNqZGV4cERt?=
 =?utf-8?B?QVFHNjFHNXBxL2V4ZmFSdWVEMEpkNE9aM3hKMStQUDF6Vk1IMHRoaS92Zllp?=
 =?utf-8?B?NUFjWDdwUnF5MlFUTFNBYitsVmJBV3djbkZZSVV2OUpaR3IwcVNjVG5MQmhE?=
 =?utf-8?B?eFdLQXRvQlR2SnZXd3F5SWpMbHI1WnJORW5razRnUmtHcmVXNzduQ3JyMHVa?=
 =?utf-8?B?MGlDN1IyRWVqdXJWcVRpckV3RkptK1o1cjRmNG1hZFF2Z2ZhQUVyZ0tlOFhB?=
 =?utf-8?B?WGQxaWZldmhZOXdHT21LOUpaMDBCajlkUlZOQ05Da1B1cEszRXlFWWRZZVMw?=
 =?utf-8?B?SmFTSXZqUkY3aldXTE0xUFNDd2toNDBWaHhrWDhPY3dMUWh4aWloelN6VFhp?=
 =?utf-8?B?S2RZWmF3YXNPR0t6RjBQNVVJb0ZBcFo2SUh5ZEVaTzAyRTJHQkc5TjZaT0Na?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4662B3DC8A2F6043AE56F1B4BD8B618A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50deb2a-c44c-4b91-b064-08dbe1029522
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 09:02:21.0896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZLAH7AJqysoMcX4BLQIyRUVQEpyzObcc4rnsNlFKrvARU0KX7vAJ/iSBKhK/h8FXj9GNQeU7Lmpy9IwKpFG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7374
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGksIFdhaW1hbiwNCg0KTWF5IEkga25vdyB3aGljaCBrZXJuZWwgdGhpcyBwYXRjaCBzZXJpZXMg
aXMgYmFzZWQgb24/DQoNCkknZCBsaWtlIHRvIHRlc3QgdGhpcyBmZWF0dXJlLCBidXQgY2Fubm90
IGFwcGx5IGl0IGNsZWFubHkgb24gdG9wIG9mDQp2Ni42Lg0KDQp0aGFua3MsDQpydWkNCg0KT24g
V2VkLCAyMDIzLTEwLTI1IGF0IDE0OjI1IC0wNDAwLCBXYWltYW4gTG9uZyB3cm90ZToNCj4gdjI6
DQo+IMKgLSBBZGQgMiByZWFkLW9ubHkgd29ya3F1ZXVlIHN5c2ZzIGZpbGVzIHRvIGV4cG9zZSB0
aGUgdXNlciByZXF1ZXN0ZWQNCj4gwqDCoCBjcHVtYXNrIGFzIHdlbGwgYXMgdGhlIGlzb2xhdGVk
IENQVXMgdG8gYmUgZXhjbHVkZWQgZnJvbQ0KPiDCoMKgIHdxX3VuYm91bmRfY3B1bWFzay4NCj4g
wqAtIEVuc3VyZSB0aGF0IGNhbGxlciBvZiB0aGUgbmV3IHdvcmtxdWV1ZV91bmJvdW5kX2V4Y2x1
ZGVfY3B1bWFzaygpDQo+IMKgwqAgaG9sZCBjcHVzX3JlYWRfbG9jay4NCj4gwqAtIFVwZGF0ZSB0
aGUgY3B1c2V0IGNvZGUgdG8gbWFrZSBzdXJlIHRoZSBjcHVzX3JlYWRfbG9jayBpcyBoZWxkDQo+
IMKgwqAgd2hlbmV2ZXIgd29ya3F1ZXVlX3VuYm91bmRfZXhjbHVkZV9jcHVtYXNrKCkgbWF5IGJl
IGNhbGxlZC4NCj4gDQo+IElzb2xhdGVkIGNwdXNldCBwYXJ0aXRpb24gY2FuIGN1cnJlbnRseSBi
ZSBjcmVhdGVkIHRvIGNvbnRhaW4gYW4NCj4gZXhjbHVzaXZlIHNldCBvZiBDUFVzIG5vdCB1c2Vk
IGluIG90aGVyIGNncm91cHMgYW5kIHdpdGggbG9hZA0KPiBiYWxhbmNpbmcNCj4gZGlzYWJsZWQg
dG8gcmVkdWNlIGludGVyZmVyZW5jZSBmcm9tIHRoZSBzY2hlZHVsZXIuDQo+IA0KPiBUaGUgbWFp
biBwdXJwb3NlIG9mIHRoaXMgaXNvbGF0ZWQgcGFydGl0aW9uIHR5cGUgaXMgdG8gZHluYW1pY2Fs
bHkNCj4gZW11bGF0ZSB3aGF0IGNhbiBiZSBkb25lIHZpYSB0aGUgImlzb2xjcHVzIiBib290IGNv
bW1hbmQgbGluZSBvcHRpb24sDQo+IHNwZWNpZmljYWxseSB0aGUgZGVmYXVsdCBkb21haW4gZmxh
Zy4gT25lIGVmZmVjdCBvZiB0aGUgImlzb2xjcHVzIg0KPiBvcHRpb24NCj4gaXMgdG8gcmVtb3Zl
IHRoZSBpc29sYXRlZCBDUFVzIGZyb20gdGhlIGNwdW1hc2tzIG9mIHVuYm91bmQNCj4gd29ya3F1
ZXVlcw0KPiBzaW5jZSBydW5uaW5nIHdvcmsgZnVuY3Rpb25zIGluIGFuIGlzb2xhdGVkIENQVSBj
YW4gYmUgYSBtYWpvciBzb3VyY2UNCj4gb2YgaW50ZXJmZXJlbmNlLiBDaGFuZ2luZyB0aGUgdW5i
b3VuZCB3b3JrcXVldWUgY3B1bWFza3MgY2FuIGJlIGRvbmUNCj4gYXQNCj4gcnVuIHRpbWUgYnkg
d3JpdGluZyBhbiBhcHByb3ByaWF0ZSBjcHVtYXNrIHdpdGhvdXQgdGhlIGlzb2xhdGVkIENQVXMN
Cj4gdG8NCj4gL3N5cy9kZXZpY2VzL3ZpcnR1YWwvd29ya3F1ZXVlL2NwdW1hc2suIFNvIG9uZSBj
YW4gc2V0IHVwIGFuIGlzb2xhdGVkDQo+IGNwdXNldCBwYXJ0aXRpb24gYW5kIHRoZW4gd3JpdGUg
dG8gdGhlIGNwdW1hc2sgc3lzZnMgZmlsZSB0byBhY2hpZXZlDQo+IHNpbWlsYXIgbGV2ZWwgb2Yg
Q1BVIGlzb2xhdGlvbi4gSG93ZXZlciwgdGhpcyBtYW51YWwgcHJvY2VzcyBjYW4gYmUNCj4gZXJy
b3IgcHJvbmUuDQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBpbXBsZW1lbnRzIGF1dG9tYXRpYyBl
eGNsdXNpb24gb2YgaXNvbGF0ZWQgQ1BVcw0KPiBmcm9tDQo+IHVuYm91bmQgd29ya3F1ZXVlIGNw
dW1hc2tzIHdoZW4gYW4gaXNvbGF0ZWQgY3B1c2V0IHBhcnRpdGlvbiBpcw0KPiBjcmVhdGVkDQo+
IGFuZCB0aGVuIGFkZHMgdGhvc2UgQ1BVcyBiYWNrIHdoZW4gdGhlIGlzb2xhdGVkIHBhcnRpdGlv
biBpcw0KPiBkZXN0cm95ZWQuDQo+IA0KPiBUaGVyZSBhcmUgYWxzbyBvdGhlciBwbGFjZXMgaW4g
dGhlIGtlcm5lbCB0aGF0IGxvb2sgYXQgdGhlDQo+IEhLX0ZMQUdfRE9NQUlODQo+IGNwdW1hc2sg
b3Igb3RoZXIgSEtfRkxBR18qIGNwdW1hc2tzIGFuZCBleGNsdWRlIHRoZSBpc29sYXRlZCBDUFVz
DQo+IGZyb20NCj4gY2VydGFpbiBhY3Rpb25zIHRvIGZ1cnRoZXIgcmVkdWNlIGludGVyZmVyZW5j
ZS4gQ1BVcyBpbiBhbiBpc29sYXRlZA0KPiBjcHVzZXQgcGFydGl0aW9uIHdpbGwgbm90IGJlIGFi
bGUgdG8gYXZvaWQgdGhvc2UgaW50ZXJmZXJlbmNlcyB5ZXQuDQo+IFRoYXQNCj4gbWF5IGNoYW5n
ZSBpbiB0aGUgZnV0dXJlIGFzIHRoZSBuZWVkIGFyaXNlcy4NCj4gDQo+IFdhaW1hbiBMb25nICg0
KToNCj4gwqAgd29ya3F1ZXVlOiBBZGQgd29ya3F1ZXVlX3VuYm91bmRfZXhjbHVkZV9jcHVtYXNr
KCkgdG8gZXhjbHVkZSBDUFVzDQo+IMKgwqDCoCBmcm9tIHdxX3VuYm91bmRfY3B1bWFzaw0KPiDC
oCBzZWxmdGVzdHMvY2dyb3VwOiBNaW5vciBjb2RlIGNsZWFudXAgYW5kIHJlb3JnYW5pemF0aW9u
IG9mDQo+IMKgwqDCoCB0ZXN0X2NwdXNldF9wcnMuc2gNCj4gwqAgY2dyb3VwL2NwdXNldDogS2Vl
cCB0cmFjayBvZiBDUFVzIGluIGlzb2xhdGVkIHBhcnRpdGlvbnMNCj4gwqAgY2dyb3VwL2NwdXNl
dDogVGFrZSBpc29sYXRlZCBDUFVzIG91dCBvZiB3b3JrcXVldWUgdW5ib3VuZCBjcHVtYXNrDQo+
IA0KPiDCoERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2dyb3VwLXYyLnJzdMKgwqDCoMKgwqDC
oCB8wqAgMTAgKy0NCj4gwqBpbmNsdWRlL2xpbnV4L3dvcmtxdWV1ZS5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+IMKga2VybmVsL2Nncm91cC9j
cHVzZXQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
ODYgKysrKysrKysrKysrKy0tLQ0KPiAtLQ0KPiDCoGtlcm5lbC93b3JrcXVldWUuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOTEgKysr
KystDQo+IMKgLi4uL3NlbGZ0ZXN0cy9jZ3JvdXAvdGVzdF9jcHVzZXRfcHJzLnNowqDCoMKgwqDC
oMKgIHwgMjE2ICsrKysrKysrLS0tLS0NCj4gwqA1IGZpbGVzIGNoYW5nZWQsIDQzOCBpbnNlcnRp
b25zKCspLCAxNjcgZGVsZXRpb25zKC0pDQo+IA0KDQo=

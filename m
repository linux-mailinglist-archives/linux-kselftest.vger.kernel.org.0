Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DA76E2454
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDNNes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 09:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNNeq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 09:34:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D886AA;
        Fri, 14 Apr 2023 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681479283; x=1713015283;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Njxg/rIBOsPqOQECpWr8oHLCU6zW2gVYUS5KIuQWHNk=;
  b=eUIPZoJsHLgg6eZxMMBgmNGMp6XcH5daKIdPS8dq9ZSC8kyr5kF21fWK
   v3NCkVqvZmyoKw/YzYgLRaNtVPDMorNtx1/WcHltpZCEhTJgTVlTfWFQk
   YPTYRX/Ve5fWEb5xbNRV3O1ZiM3Pj/Lfp67DdpxXVxLWEplmDuf62xZvA
   4+2+wuSVRV35OJZS+jY34QzqJdX5DrwGUJYvS/eY/2uuN+QRLDljsL7jh
   oWOQfXVLfhDYMWTi8wbjoEbl3psVydKtmgZOdAVGr85B0rgjfmS+ih0w0
   E3UUD6gqTkFH7zHVrLzzGwtX0IZJ2aSrHg37W/RotH9Pf1lQGnFbp8Tl3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="343222658"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="343222658"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 06:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="692417532"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692417532"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 14 Apr 2023 06:34:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 06:34:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 14 Apr 2023 06:34:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 14 Apr 2023 06:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQqkvBnzENEnPxmwQPmeVSyDbkz+xQHUIdFfGxIn5Zq7mrgqlwqwh6IIPBWvyrjOlqzQAZA1AdDwA8jG2XwytNCyWosIrPws5NqOl0h1yDvS3YGHCqUIC/WUF4sBKaNxPtdD23ijWx0inuZO1/WRe4q6iHdnbPys/iqueOwmse2gEQ99rdqnZytWuQiCklqo7kzl8SE57co8wPHr6ogZG9dCcz+wyUkRueO9V8cPcyYLQ++vzSWrbwa3JK47B+p/c2h3fdxAathn8fR53gIohUUop7pEGlNKDXTgw04JKLCfHzpToysQWS4NNOT8dJGo/kjBy5GmYze5mzonUJcCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njxg/rIBOsPqOQECpWr8oHLCU6zW2gVYUS5KIuQWHNk=;
 b=Ejh3T2pq8EYl4tmyHDRRfN72gfCdNpy+C/c7PVux0kmwYCznNrAFor5qEgYgChO+oI4kuzU7S7KHuXVIZmXeAEg0zxt2EcvSyk3pG3YDu3GWPAAfPNlstqp6Hz78fJCMarEIMYXpYevCbiKFbPZywwx9BGOAX1AnFzzz0GRcq6oJCUO2+v04HH983ntW35lRu9DzDEB3fxbr3YAbrjbOxS5UrdfgEVBfdxxcFbDu+m+UWkXh4G/KdOFHCX4PbrPwYneVy0P4+g3dG4juvdUUxyX04WJ+xlm4sTPVh8RgPbZG3S0T6x96Y40jQeaTt71sutWeSGD0ui1koKl9BftSCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 13:34:37 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3c9e:36da:562b:f1f5]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3c9e:36da:562b:f1f5%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 13:34:37 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: Re: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZbbn0bzmMFjR3OEyC2JtDS40vY68q0D8A
Date:   Fri, 14 Apr 2023 13:34:37 +0000
Message-ID: <632a9a27abb5da053caedbbc6bcb7d5e15b2322c.camel@intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230413034108.1902712-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230413034108.1902712-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5420:EE_
x-ms-office365-filtering-correlation-id: 8ae9f5e3-ca66-43e0-2b0f-08db3cecfdc8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsoyyaXBVoFeMvQr7GEsZQc18HA8z9Zgb4ogpzb8T0IKnzjWPlTK9+5ouw0ZsUGuOQ4kz5zb5r6U/G5C7vPiI/eZWdqy7Nl6+Wf81p5JcSEVIlSVHdkDRRZjuw8I6QnyMb5ET+rwpRgc/3lFwx+yvk2Ccr+eYzLXLjnsMTAHOyX9CL5NVl9mzqZFBgzLAEaFLusrWkoj+w6hE3V7E1yvXViFcbi4IAFWUYoAw7kDHcTZZlEoRyqPJV3fXpqeZv/1ozk46b5OsH6V+Iy2XvUq0193RIyCxcdqL3tdBn5XvTDFgsa31KVsM+nk5Zg4hFFQPBYNxLu9ZG0doCs36a2N5V8D9aVeAsqG8yFRCjNNm4BdgfAvpfFhAGyWZDDFQoFu0ZssjKaKa8AEaTOpO+c89dP/l891oYjH7A/I82SLQ0e8BTmeeHsmVxfD52FgrvEFbYXhjupIkF7sM795I/j3H6F/nESnl6V28SSJchAVLhhyeFTQfBB6Rx4269umyEl5Klu+oTFclB2MWMZ6Jd90pgzuAp9hDURKg9cQUPZo6ppXMYqZWxsIFxHCHa4NZxEcyTwieTIekLS+jsb+k5YwVj26zRjqBJYV2ldlIpzI2gKzNPtu1MWR7omQ9kwntlG9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199021)(110136005)(26005)(6512007)(6506007)(54906003)(186003)(83380400001)(2616005)(71200400001)(6486002)(5660300002)(41300700001)(82960400001)(316002)(8936002)(8676002)(38100700002)(38070700005)(86362001)(122000001)(478600001)(66946007)(36756003)(4326008)(66446008)(76116006)(91956017)(64756008)(66556008)(66476007)(2906002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlM0cE12SDZLT2lncXJuVDlRYlA4dTFnMWEweFo1Y0ozd0lsRFBrY1JOUHZR?=
 =?utf-8?B?a1Nrcyt0cU1ZSGNZQnBBQytZcGJEbHp0QURzd2ExS09jMWpHbmhMRDFCamJp?=
 =?utf-8?B?aXJBOFV0RkFtampSbXdIVmh0ekZtNmxTOEpTelZGdkY1elM1ZzRCc2FjczlK?=
 =?utf-8?B?MjlTdlZ5TTdRSTVJclc2aElFOWVNUkw2TC8vTko5c0toQmZkb1BLYWVOZ0J4?=
 =?utf-8?B?S0lScElBVUtYQU1kdS9rMkNpNjMvNzRuSVB6N0xLZ2ZEQUdZVTJHUG1EaFlu?=
 =?utf-8?B?L0dlczI5c2kyWC81N2Jjcy9Ha3lUM3VNMk1oU041Z0VrcG1HNDN1V3VWRC9i?=
 =?utf-8?B?bXJKMVl3bXZKRmVXTlFEckNsRW05UHQyMzlQUVJIVm1RdmN1MFNpdllMeEN1?=
 =?utf-8?B?TnFyRFErV1J5akQ1a0FKS0luekNEUzVUU3R4WFBNdXlFaGlRUTdLbHRmcXhS?=
 =?utf-8?B?OUZEeDR4S0JoWENFeFhSd3BXeHFmMzA4VjMzUmtxZ25UbWdBU0Rpa2U3VVpH?=
 =?utf-8?B?bFoxQW9pOE53dG1CeVI1Z2NndFJyT0QwMU1ZU1MxUGxSZXpBbGxUQWxrUFZR?=
 =?utf-8?B?d081cGk0SlRaNTVnUFlMYUkzTG5OUStJTThBTkJ6QVFIV0QyUzZtU3VYaGY5?=
 =?utf-8?B?RkxvZUVkRTlqTTB0eWpZL0l3bDJDZUNRdG1lRmhWN2Q2dDcyVWg1enVscWFS?=
 =?utf-8?B?Y01XNHlGMnkybU5BNnpBNWNQdGxEazVQUEg5NlJtSmRzRmN3WkhFNiszQXN4?=
 =?utf-8?B?K1JRaGtyU1hraDFBWVBMY3FvOWJpM0F2ZStxVHJadnR2R2oyYVprRWFaRGh4?=
 =?utf-8?B?NlBFR0tYbEI5VEZ6d2xrNDNjT0IrN3JUdkZyTStmVktVWW0veDIwL2IwUnJj?=
 =?utf-8?B?R0ZTS0ZVdDUyaGppeVVXUjcwWVdSbWdKc205ekJ2UW9sNzNlQWhCbDdtN1lM?=
 =?utf-8?B?WmRYMlpWUVdBZnRmank2a2E5VmV2NHlOSGRFZkFkdGE4TlB2Y0lScHlMaThW?=
 =?utf-8?B?dDJycTI3VkhpZGpOMjFyU1NpYmF3L3B3N3lDY0ZXTnh0UU5vU0V3NktDRG1q?=
 =?utf-8?B?dkIrWVYxYjlHU21BNm9iQ2huRWppSWl0SW1GcnVtMjVucHNZVmVjVm1naVFs?=
 =?utf-8?B?Y3NnTnI0TzVwNEhPUnZUUThOQmFyN0JyWHp5T1I2ZHd2SWpDYlJuZHdYaURE?=
 =?utf-8?B?K24ydzdVMEdRRU1ab1luSEpLQldwZ2VJcy9XU0F1SWdTTEVkakdRdHhkT3hP?=
 =?utf-8?B?bmN0cnVGRUZ1ZzQ2bG82V005SWFNc2I4dFJDTjJuSG1nc1ljVC9WQy9RaHlE?=
 =?utf-8?B?L0drdzkxZkYzZUR2clYzdVFBMHFSbndYdzEvUXB5cGFESzlEMCt2Z2s0YVhs?=
 =?utf-8?B?eVIrZll1N0JqZW5UZGlOUzR3YmlDZ1JwQ0tSSXNoc3htYVd3SERuT3J5SWF4?=
 =?utf-8?B?dk9QN0RXVDhkbWxVanZlckNFRWQrUGkrbWVYcmZvejRISkRrRFBVLzZRUmdC?=
 =?utf-8?B?SzVTczIwUld0VHRXZ0tlZDV3ZEhBYU04c0RrVFBaUGJBei9kUDdFSmh4aDVa?=
 =?utf-8?B?RmJocTlqWXJ1ZGdoWC9SUlpTSnZLYjBQcklKMHkwVDNqWTZiMXRHSnVDZ05E?=
 =?utf-8?B?SEtvMHJaNEd1T0NCbThJa1pkZFVyaW1ua1RmdDBUZmVaRVJNa2x1SWJGZlFG?=
 =?utf-8?B?TXZqdnZQM0JIa2JwUHFwdm50WUVzbFhFc1FaK3BmcHNSMDdpNDZndEpvNE52?=
 =?utf-8?B?cHAxVlVtT1g2cmYzVFA3Y1dibFYvVDJKYVZiU2Zqd2tkd3ZHTTRRMDlWMklk?=
 =?utf-8?B?ZmliNnFDeDhDSUtoTDA2RHdCNlFzeEZWWGVNKzlOZHZnSWc5QytYUGY2ZHV2?=
 =?utf-8?B?d296Y2ZNaHhBc0dqYjBHeHp6YSs5MkZkY1lhcDBpbXBUYXM1cCsrRisxa21R?=
 =?utf-8?B?amNWYXF3bCtESE9ZUmYvbHh4cWZ2QTJUbDVJYXk2ZnNzTVJmVEJsZWEyTWJO?=
 =?utf-8?B?cnZpK0RQYkhiaUJ3dWV2WjlMc0luQ0RpTVhxazFoQlByOTN1dFNRTDduSjBu?=
 =?utf-8?B?dlJMRVpzL0R6UG1nanJ4ZGhmU0x0bU1ycm1kdS9oZjd2eWdGWE1SL0JMVjNU?=
 =?utf-8?Q?/ph3AI+oMMubto4+kk+qHF1Ek?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C09B23BE26A72E41BB103FCF8743B052@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae9f5e3-ca66-43e0-2b0f-08db3cecfdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 13:34:37.0569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAU1JxS5eGXoOga+UecXrtJmHevtIlYlHpBX1wdRzmThizlxsxSDPMWKosnRinJRr7v63gug0LJBRQ5fwzyM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
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

T24gV2VkLCAyMDIzLTA0LTEyIGF0IDIwOjQxIC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gSG9zdC1ndWVzdCBldmVudCBub3RpZmljYXRpb24gdmlhIGNvbmZpZ3Vy
ZWQgaW50ZXJydXB0IHZlY3RvciBpcyB1c2VmdWwNCj4gaW4gY2FzZXMgd2hlcmUgYSBndWVzdCBt
YWtlcyBhbiBhc3luY2hyb25vdXMgcmVxdWVzdCBhbmQgbmVlZHMgYQ0KPiBjYWxsYmFjayBmcm9t
IHRoZSBob3N0IHRvIGluZGljYXRlIHRoZSBjb21wbGV0aW9uIG9yIHRvIGxldCB0aGUgaG9zdA0K
PiBub3RpZnkgdGhlIGd1ZXN0IGFib3V0IGV2ZW50cyBsaWtlIGRldmljZSByZW1vdmFsLiBPbmUg
dXNhZ2UgZXhhbXBsZSBpcywNCj4gY2FsbGJhY2sgcmVxdWlyZW1lbnQgb2YgR2V0UXVvdGUgYXN5
bmNocm9ub3VzIGh5cGVyY2FsbC4NCj4gDQo+IEluIFREWCBndWVzdCwgU2V0dXBFdmVudE5vdGlm
eUludGVycnVwdCBoeXBlcmNhbGwgY2FuIGJlIHVzZWQgYnkgdGhlDQo+IGd1ZXN0IHRvIHNwZWNp
Znkgd2hpY2ggaW50ZXJydXB0IHZlY3RvciB0byB1c2UgYXMgYW4gZXZlbnQtbm90aWZ5DQo+IHZl
Y3RvciBmcm9tIHRoZSBWTU0uIERldGFpbHMgYWJvdXQgdGhlIFNldHVwRXZlbnROb3RpZnlJbnRl
cnJ1cHQNCj4gaHlwZXJjYWxsIGNhbiBiZSBmb3VuZCBpbiBURFggR3Vlc3QtSG9zdCBDb21tdW5p
Y2F0aW9uIEludGVyZmFjZQ0KPiAoR0hDSSkgU3BlY2lmaWNhdGlvbiwgc2VjdGlvbiAiVlAuVk1D
QUxMPFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQ+Ii4NCj4gDQo+IEFzIHBlciBkZXNpZ24sIFZN
TSB3aWxsIHBvc3QgdGhlIGV2ZW50IGNvbXBsZXRpb24gSVJRIHVzaW5nIHRoZSBzYW1lDQo+IENQ
VSBvbiB3aGljaCBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IGh5cGVyY2FsbCByZXF1ZXN0IGlz
IHJlY2VpdmVkLg0KPiBTbyBhbGxvY2F0ZSBhbiBJUlEgdmVjdG9yIGZyb20gIng4Nl92ZWN0b3Jf
ZG9tYWluIiwgYW5kIHNldCB0aGUgQ1BVDQo+IGFmZmluaXR5IG9mIHRoZSBJUlEgdmVjdG9yIHRv
IHRoZSBDUFUgb24gd2hpY2gNCj4gU2V0dXBFdmVudE5vdGlmeUludGVycnVwdCBoeXBlcmNhbGwg
aXMgbWFkZS4NCj4gDQo+IEFkZCB0ZHhfcmVnaXN0ZXJfZXZlbnRfaXJxX2NiKCkvdGR4X3VucmVn
aXN0ZXJfZXZlbnRfaXJxX2NiKCkNCj4gaW50ZXJmYWNlcyB0byBhbGxvdyBkcml2ZXJzIHJlZ2lz
dGVyL3VucmVnaXN0ZXIgZXZlbnQgbm9maWNpYXRpb24NCgkJCSAgICAgIF4NCgkJCSAgICAgIHRv
IHJlZ2lzdGVyL3VucmVnaXN0ZXINCj4gaGFuZGxlcnMuDQo+IA0KPiANCg0KWy4uLl0NCg0KPiAr
LyogUmVzZXJ2ZSBhbiBJUlEgZnJvbSB4ODZfdmVjdG9yX2RvbWFpbiBmb3IgVEQgZXZlbnQgbm90
aWZpY2F0aW9uICovDQo+ICtzdGF0aWMgaW50IF9faW5pdCB0ZHhfZXZlbnRfaXJxX2luaXQodm9p
ZCkNCj4gK3sNCj4gKwlzdHJ1Y3QgaXJxX2FsbG9jX2luZm8gaW5mbzsNCj4gKwlzdHJ1Y3QgaXJx
X2NmZyAqY2ZnOw0KPiArCWludCBpcnE7DQo+ICsNCj4gKwlpZiAoIWNwdV9mZWF0dXJlX2VuYWJs
ZWQoWDg2X0ZFQVRVUkVfVERYX0dVRVNUKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwlpbml0
X2lycV9hbGxvY19pbmZvKCZpbmZvLCBOVUxMKTsNCj4gKw0KPiArCS8qDQo+ICsJICogRXZlbnQg
bm90aWZpY2F0aW9uIHZlY3RvciB3aWxsIGJlIGRlbGl2ZXJlZCB0byB0aGUgQ1BVDQo+ICsJICog
aW4gd2hpY2ggVERWTUNBTExfU0VUVVBfTk9USUZZX0lOVFIgaHlwZXJjYWxsIGlzIHJlcXVlc3Rl
ZC4NCgkgICBeDQoJICAgb24gd2hpY2ggKHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgY2hhbmdl
bG9nKQ0KDQo+ICsJICogU28gc2V0IHRoZSBJUlEgYWZmaW5pdHkgdG8gdGhlIGN1cnJlbnQgQ1BV
IChDUFUgMCkuDQo+ICsJICovDQo+ICsJaW5mby5tYXNrID0gY3B1bWFza19vZigwKTsNCg0KSSB0
aGluayB3ZSBzaG91bGQgdXNlIHNtcF9wcm9jZXNzb3JfaWQoKSB0byBnZXQgdGhlIENQVSBpZCBl
dmVuIGZvciBCU1AuDQoNCj4gKw0KPiArCWlycSA9IGlycV9kb21haW5fYWxsb2NfaXJxcyh4ODZf
dmVjdG9yX2RvbWFpbiwgMSwgY3B1X3RvX25vZGUoMCksICZpbmZvKTsNCj4gKwlpZiAoaXJxIDw9
IDApIHsNCj4gKwkJcHJfZXJyKCJFdmVudCBub3RpZmljYXRpb24gSVJRIGFsbG9jYXRpb24gZmFp
bGVkICVkXG4iLCBpcnEpOw0KPiArCQlyZXR1cm4gLUVJTzsNCj4gKwl9DQo+ICsNCj4gKwlpcnFf
c2V0X2hhbmRsZXIoaXJxLCBoYW5kbGVfZWRnZV9pcnEpOw0KPiArDQo+ICsJLyogU2luY2UgdGhl
IElSUSBhZmZpbml0eSBpcyBzZXQsIGl0IGNhbm5vdCBiZSBiYWxhbmNlZCAqLw0KPiArCWlmIChy
ZXF1ZXN0X2lycShpcnEsIHRkeF9ldmVudF9pcnFfaGFuZGxlciwgSVJRRl9OT0JBTEFOQ0lORywN
Cj4gKwkJCSJ0ZHhfZXZlbnRfaXJxIiwgTlVMTCkpIHsNCj4gKwkJcHJfZXJyKCJFdmVudCBub3Rp
ZmljYXRpb24gSVJRIHJlcXVlc3QgZmFpbGVkXG4iKTsNCj4gKwkJZ290byBlcnJfZnJlZV9kb21h
aW5faXJxczsNCj4gKwl9DQoNCkZpcnN0bHksIHRoaXMgY29tbWVudCBpc24ndCByaWdodC4gIFRo
ZSBAaW5mby0+bWFzayBpcyBvbmx5IHVzZWQgdG8gYWxsb2NhdGUgdGhlDQp2ZWN0b3Igb2YgdGhl
IElSUSwgYnV0IGl0IGRvZXNuJ3QgaGF2ZSBhbnl0aGluZyB0byBkbyB3aXRoIElSUSBhZmZpbml0
eS4gDQppcnFfZG9tYWluX2FsbG9jX2lycXMoKSB3aWxsIHNldCB0aGUgSVJRIHRvIGhhdmUgdGhl
IGRlZmF1bHQgYWZmaW5pdHkgaW4gZmFjdC4gIA0KDQpUaGUgY29tbWVudCBzaG91bGQgYmUgc29t
ZXRoaW5nIGxpa2UgYmVsb3cgaW5zdGVhZDoNCg0KCS8qDQoJICogVGhlIElSUSBjYW5ub3QgYmUg
bWlncmF0ZWQgYmVjYXVzZSBWTU0gYWx3YXlzIGluamVjdHMgdGhlIHZlY3Rvcg0KCSAqIGV2ZW50
IHRvIHRoZSBjcHUgb24gd2hpY2ggdGhlIFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQgVERWTUNB
TEwNCgkgKiBpcyBjYWxsZWQuICBTZXQgdGhlIElSUSB3aXRoIElSUUZfTk9CQUxBTkNJTkcgdG8g
cHJldmVudCBpdHMNCmFmZmluaXR5IA0KCSAqIGZyb20gYmVpbmcgY2hhbmdlZC4NCgkgKi8NCg0K
VGhhdCBhbHNvIGJlaW5nIHNhaWQsIHlvdSBhY3R1YWxseSBoYXZlbid0IHNldCBJUlEncyBhZmZp
bml0eSB0byB0aGUgQlNQIHlldA0KYmVmb3JlIHJlcXVlc3RfaXJxKCkuICBJSVVDIHlvdSBjYW4g
ZWl0aGVyOg0KDQoxKSBFeHBsaWNpdGx5IGNhbGwgaXJxX3NldF9hZmZpbml0eSgpIGFmdGVyIGly
cV9kb21haW5fYWxsb2NfaXJxcygpIHRvIHNldA0KYWZmaW5pdHkgdG8gQlNQOyBvcg0KDQoyKSBV
c2UgX19pcnFfZG9tYWluX2FsbG9jX2lycXMoKSwgd2hpY2ggYWxsb3dzIHlvdSB0byBzZXQgdGhl
IGFmZmluaXR5IGRpcmVjdGx5LA0KdG8gYWxsb2NhdGUgdGhlIElSUSBpbnN0ZWFkIG9mIGlycV9k
b21haW5fYWxsb2NfaXJxcygpLg0KDQoJc3RydWN0IGlycV9hZmZpbml0eV9kZXNjIGRlc2M7DQoN
CgljcHVtYXNrX3NldF9jcHUoc21wX3Byb2Nlc3Nvcl9pZCgpLCAmZGVzYy5tYXNrKTsNCg0KCWly
cSA9IF9faXJxX2RvbWFpbl9hbGxvY19pcnFzKC4uLiwgJmRlc2MpOw0KDQpQZXJzb25hbGx5IEkg
dGhpbmsgMikgaXMgbW9yZSBzdHJhaWdodGZvcndhcmQuDQoNClVzaW5nIDIpIGFsc28gYWxsb3dz
IHlvdSB0byBhbHRlcm5hdGl2ZWx5IHNldCBkZXNjLmlzX21hbmFnZWQgdG8gMSB0byBzZXQgdGhl
DQpJUlEgYXMga2VybmVsIG1hbmFnZWQuICBUaGlzIHdpbGwgcHJldmVudCB1c2Vyc3BhY2UgZnJv
bSBjaGFuZ2luZyBJUlEgYWZmaW5pdHkuDQpLZXJuZWwgY2FuIHN0aWxsIGNoYW5nZSB0aGUgYWZm
aW5pdHksIHRob3VnaCwgYnV0IG5vIG90aGVyIGtlcm5lbCBjb2RlIHdpbGwgZG8NCnRoYXQuDQoN
ClNvIGJvdGgga2VybmVsIG1hbmFnZWQgYWZmaW5pdHkgSVJRIGFuZCBJUlFGX05PQkFMQU5DSU5H
IHNob3VsZCB3b3JrLiAgSSBoYXZlIG5vDQpvcGluaW9uIG9uIHRoaXMuDQoNCkFuZCBJSVVDIGlm
IHlvdSBhbHJlYWR5IHNldCBJUlEncyBhZmZpbml0eSB0byBCU1AgYmVmb3JlIHJlcXVlc3RfaXJx
KCksIHRoZW4geW91DQpkb24ndCBuZWVkIHRvIGRvOg0KDQoJaW5mby5tYXNrID0gY3B1bWFza19v
ZigwKTsNCg0KYmVmb3JlIGFsbG9jYXRpbmcgdGhlIElSUSBhcyB0aGUgdmVjdG9yIHdpbGwgYmUg
YWxsb2NhdGVkIGluIHJlcXVlc3RfaXJxKCkgb24NCnRoZSBCU1AgYW55d2F5Lg0KDQoNCj4gKw0K
PiArCWNmZyA9IGlycV9jZmcoaXJxKTsNCj4gKw0KPiArCS8qDQo+ICsJICogU2luY2UgdGR4X2V2
ZW50X2lycV9pbml0KCkgaXMgdHJpZ2dlcmVkIHZpYSBlYXJseV9pbml0Y2FsbCgpLA0KPiArCSAq
IGl0IHdpbGwgY2FsbGVkIGJlZm9yZSBzZWNvbmRhcnkgQ1BVcyBicmluZ3VwLiBTaW5jZSB0aGVy
ZSBpcw0KPiArCSAqIG9ubHkgb25lIENQVSwgaXQgY29tcGxpZXMgd2l0aCB0aGUgcmVxdWlyZW1l
bnQgb2YgZXhlY3V0aW5nDQo+ICsJICogdGhlIFREVk1DQUxMX1NFVFVQX05PVElGWV9JTlRSIGh5
cGVyY2FsbCBvbiB0aGUgc2FtZSBDUFUgd2hlcmUNCj4gKwkgKiB0aGUgSVJRIHZlY3RvciBpcyBh
bGxvY2F0ZWQuDQoNCklNSE8gdGhpcyBpcyB1bm5lY2Vzc2FyeSBjb21wbGljYXRlZC4NCg0KSW4g
ZmFjdCwgSU1ITyB3ZSBjYW4ganVzdCBoYXZlIG9uZSBzaW1wbGUgY29tbWVudCBhdCB0aGUgdmVy
eSBiZWdpbm5pbmcgdG8NCmV4cGxhaW4gdGhlIHdob2xlIHRoaW5nOg0KDQoJLyoNCgkgKiBURFgg
Z3Vlc3QgdXNlcyBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IFREVk1DQUxMIHRvIGFsbG93IHRo
ZQ0KCSAqIGh5cGVydmlzb3IgdG8gbm90aWZ5IHRoZSBURFggZ3Vlc3Qgd2hlbiBuZWVkZWQsIGZv
ciBpbnN0YW5jZSwNCgkgKiB3aGVuIFZNTSBmaW5pc2hlcyB0aGUgR2V0UXVvdGUgcmVxdWVzdCBm
cm9tIHRoZSBURFggZ3Vlc3QuIMKgDQoJICoNCgkgKiBUaGUgVk1NIGFsd2F5cyBub3RpZmllcyB0
aGUgVERYIGd1ZXN0IHZpYSB0aGUgdmVjdG9yIHNwZWNpZmllZCBpbg0KdGhlDQoJICogU2V0dXBF
dmVudE5vdGlmeUludGVycnVwdCBURFZNQ0FMTCB0byB0aGUgY3B1IG9uIHdoaWNoIHRoZSBURFZN
Q0FMTA0KCSAqIGlzIGNhbGxlZC4gIEZvciBzaW1wbGljaXR5LCBqdXN0IGFsbG9jYXRlIGFuIElS
USAoYW5kIGEgdmVjdG9yKcKgDQoJICogZGlyZWN0bHkgZnJvbSB4ODZfdmVjdG9yX2RvbWFpbiBm
b3Igc3VjaCBub3RpZmljYXRpb24gYW5kIHBpbiB0aGUNCgkgKiBJUlEgdG8gdGhlIEJTUC4NCgkg
Ki8NCg0KQW5kIHRoZW4gYWxsIHRoZSBjb2RlIGZvbGxvd3MuDQoNCj4gKwkgKg0KPiArCSAqIFJl
Z2lzdGVyIGNhbGxiYWNrIHZlY3RvciBhZGRyZXNzIHdpdGggVk1NLiBNb3JlIGRldGFpbHMNCj4g
KwkgKiBhYm91dCB0aGUgQUJJIGNhbiBiZSBmb3VuZCBpbiBURFggR3Vlc3QtSG9zdC1Db21tdW5p
Y2F0aW9uDQo+ICsJICogSW50ZXJmYWNlIChHSENJKSwgc2VjIHRpdGxlZA0KPiArCSAqICJUREcu
VlAuVk1DQUxMPFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1cHQ+Ii4NCj4gKwkgKi8NCj4gKwlpZiAo
X3RkeF9oeXBlcmNhbGwoVERWTUNBTExfU0VUVVBfTk9USUZZX0lOVFIsIGNmZy0+dmVjdG9yLCAw
LCAwLCAwKSkgew0KPiArCQlwcl9lcnIoIkV2ZW50IG5vdGlmaWNhdGlvbiBoeXBlcmNhbGwgZmFp
bGVkXG4iKTsNCj4gKwkJZ290byBlcnJfZnJlZV9pcnFzOw0KPiArCX0NCj4gKw0KPiArCXRkeF9l
dmVudF9pcnEgPSBpcnE7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArZXJyX2ZyZWVfaXJx
czoNCj4gKwlmcmVlX2lycShpcnEsIE5VTEwpOw0KPiArZXJyX2ZyZWVfZG9tYWluX2lycXM6DQo+
ICsJaXJxX2RvbWFpbl9mcmVlX2lycXMoaXJxLCAxKTsNCj4gKw0KPiArCXJldHVybiAtRUlPOw0K
PiArfQ0KPiArZWFybHlfaW5pdGNhbGwodGR4X2V2ZW50X2lycV9pbml0KQ0KPiArDQo+IA0KDQpb
Li4uXQ0KDQo=

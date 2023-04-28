Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD396F19FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjD1Nu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjD1Nu5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 09:50:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BB171E;
        Fri, 28 Apr 2023 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682689856; x=1714225856;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vQrGx9IzTShAjTzNp0RUQu0i1vEEoU4P3f2Um+jQSdI=;
  b=fRUCe5srf7yhdnno8l5Pxc/NSqWZo82YcTk3mGPaEV65DzQaZKmiUseA
   KL5Ce+d4haYsBFoGLzJO/33WOI4U6FZVIL2YFDeaLu6OJN8rw83yL9gqM
   l+d/7J3/48WOCSZFPuNZJzse1jj97DJZuBF+vE7JbBlwdRCnOrmPoRtID
   wL/v1iSV38Ptmv2qZ4G5G3Vc5KP57q/pPYOcoGcvzHQPXgkVCx+SAvg54
   8KkmxyIkrKDaQaHApx6X3XgEeNjSNUCdxfTijk7GAXLiEKWDKZHgUxm7k
   KM7af1w7LfGF7T4LEHdzfgMRuXGqZ7MOb6HzzhtiWVzjgxOe0oAUGwSOQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349777907"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="349777907"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 06:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="1024605974"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="1024605974"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 28 Apr 2023 06:50:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 06:50:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 28 Apr 2023 06:50:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 28 Apr 2023 06:50:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYVG2iJAiJfNSc1Y4L1f6kOtJfSWoVR82AhrGni1PG/pZH+r8DtGv0Y/kJYhTU6m2ika166CzuFQBs1H9f29Lco92cjNm7yYs6cyBSZWlzyuvnez59GlQpokXTS6PlL21QePJuTfmWhGhosUuuJd+GwI6RLEs8kq4Xcl5bSjK9+4D7X7YI9irI864koRvvvgG+S4qGQj4dkbl7kbEq0mKDk3eHQqoTGyQEas5gIRpR/Kje90NhiMrzR2YrEcc8nYQ/MQ4fT772kYphAC+yIZpR3nicc08wG/1+VZq2h+HrzHRWkvRZ9i8NDIA2eY0qHPUrps5M5m1zO0mUwi7+/eLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQrGx9IzTShAjTzNp0RUQu0i1vEEoU4P3f2Um+jQSdI=;
 b=cEUlwgoLp7ZENr+mEBmLWlDEr/IPp2XuMdBhYO8RhTPHh2+5fyap+8/DaEE/cLN2FV5IwgQTF52HKJS2mB4SS8JiY7NuGBs3+BKPbxgbC1vzk+g+UKiPidsFQLwo3Y3s/+SCzG5XorHOrDgHH4vtxY0JXnLpqnbv0bSkXxTG4ZVomJZMlbt2HFQZULJNsBWxsKzJ7koiq0kmBfaLmib78JWA3XD8ApNRu+0T4kIN8erLzYgg+nklYuXMFyNZJU9h3dO4jFerS4SXSlDJlr2tKi53fQGIJQ7vHtT/7uHKTGlLW05CLZTHXtrv67WohvOHFLtL997wr3bxr8UP1RKkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5451.namprd11.prod.outlook.com (2603:10b6:408:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 13:50:52 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3a8a:7ef7:fbaa:19e2%5]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 13:50:51 +0000
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
CC:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>
Subject: Re: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZbbn0bzmMFjR3OEyC2JtDS40vY68q0D8AgBH04YCAACTMgIAARVSAgAOmKwA=
Date:   Fri, 28 Apr 2023 13:50:51 +0000
Message-ID: <11b38df4d91b1a85cec500d5fae9ab2242361f52.camel@intel.com>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230413034108.1902712-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <632a9a27abb5da053caedbbc6bcb7d5e15b2322c.camel@intel.com>
         <0da37de8-6036-f475-d80d-92c77fb7cbaa@linux.intel.com>
         <40b6ca5df5988305fea734e559fe5c8b3a22df78.camel@intel.com>
         <80718d6c-9e53-d549-bfe2-6c10d618acb1@linux.intel.com>
In-Reply-To: <80718d6c-9e53-d549-bfe2-6c10d618acb1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5451:EE_
x-ms-office365-filtering-correlation-id: 0ab3c1cb-09dd-4dca-0b92-08db47ef948e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHzDasganCJKF+8fe7ZsYRRfl+Z663PjAeFw9lKSy430PGQIHp9pZq1qhyTtqzizogL/PsKbtn5zI3AEcGz+PRKRCsAtQVRFAUifCbVo5EQ7TRl+VgSMlh6ROJecZODmxtRNlGQxAOFyO22ZB5wE0Djs13egdQyPTffiWznq0CK2bMESch0TRlhGU+3NGFSilsFE1VPB6Nm+z5KBCRkCEkjaDEsajJ4VPkNAKc3r77vIUhXw0jNrIosYENEoO9mLm8X1iJUYVz+vHvBjHEWbfJlfsIpVY7xJgcrkOJZfYmJzflWs2Yy5C++a3SUXvTM/36LzUHOud+QsmXn8cNwvgA1Ns6BTE7W4qSaSF/fgpV34pht+G+ZKJRuWtqJv43jws1nN7zwwP7mjli0GV3Ql/X+lXZqN+dJm6ujaego2aG65hnTktz3PnEYZFxlaN2d8iVTPM/nYStEyK2s+XS7C91/37ZjolnwbwJ073K5ZZ7ahedVplw9q5nWOt77gPPHoN6qYjCeSx2UrUr13BP4KW/ovnaeVBfwU05R+kK561a29xFAv3MDAXMhC5XiW2TH9i0w9/6yGYtua8FDMob9whQaet1/bNKttsHPAICLHwPKZqOHuQ44DljLC2N1f9uz9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(91956017)(110136005)(54906003)(478600001)(5660300002)(8936002)(8676002)(36756003)(38070700005)(86362001)(2906002)(7416002)(38100700002)(64756008)(66446008)(66556008)(76116006)(66476007)(66946007)(4326008)(316002)(82960400001)(41300700001)(122000001)(186003)(6512007)(26005)(6506007)(83380400001)(2616005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHlVdUx4RDhRWlM4T2Y0NldsMzVGVWJ0MTJ4U3NkWmJmdlVOVVlQekJDSXR3?=
 =?utf-8?B?aUdSeVdhTEZMV3RENUZWZjVybzRKTDhtbjZSaU40Wnl1c0dZbFJNN011a0tt?=
 =?utf-8?B?eW5iSUtBN1p3RkdXN2gwYm9xdkpFRzAvWkpYb2xzRDR0ek1pdi9VRE94OFY2?=
 =?utf-8?B?QWJTL3ZHV1lQKzVqRm9RYW5BWDBmZXE1Qmw4aDY2azF1Qm1OdVVFVFYzWTNZ?=
 =?utf-8?B?TE50MStuQUZxVWdEd0ViNHZUWW5XeVYrTkwxKzVNVTZ4UFdaMFY4aEREZFU3?=
 =?utf-8?B?Y3ArRy83WXJmZkovQUxrZ0ZhSXZ5cFl2SFd4dWZqQ2p4WEt5ZTd6RkJ1UGYz?=
 =?utf-8?B?Y0dOTjJ4Q082S0dWc3lxVDI5bWdPZk4rMjJ6bm9JZHVTcjNtN0orYk9vMStS?=
 =?utf-8?B?aWRrREs4NUtMNjZLZlJnNXNSZVZzT2UrbEJydVBadkhlekZSRHQ0R2VVeEsz?=
 =?utf-8?B?UllyVXVmaENQYXk3RXJBSjV6ekZXWWRLbFUyYW9PVmlXaytjNXFFdkM3WXRi?=
 =?utf-8?B?WjAzalkySjJ4WFJMT3dpYTcvbnpEZnhGS1owYVk3NkkrR1JpbUo3ZnZ2MEgw?=
 =?utf-8?B?RVRKaGRPYzFVQ0lvcVdGd2Nuakt6azJNR1BKSldxN0EvOHFpdXZiWG5ZKzFF?=
 =?utf-8?B?TVdqSXB4Sk9IWFo4dGYwNVZKS0Zla2dxbkFyb0RENmVJbnc2ZzBybWRIMVdQ?=
 =?utf-8?B?L3hrR3NvYm1GRm15d0FRM0c3dHQvb2VSS1gzMGdUUFdvekVzREZFMUp5TDdq?=
 =?utf-8?B?bi8vN1AyU3BHNmpCb3hsT1p2blR4bjVXUlorTE5jbVNySjRVQitGYnk1QmVU?=
 =?utf-8?B?ZGFrMWFyUGFvZUswbGkyWnc5cDN0cUUwQmppS1JYWlBSNVNteUprZnBqanZK?=
 =?utf-8?B?YnBpbHlMaXVjUFRkb01hUkdIOHpHTkt2WXp2YWNPVkdOZ1k2R3RrY3JuOWlS?=
 =?utf-8?B?b1hRMTFRdUpoWVhUdUhQQjJmR3h1VFEzVXRGc2tKbS9LWHV1L1I2K0hiRm5G?=
 =?utf-8?B?MkoxeW8xT2lLZmtqaTU5akdBZ055U2NKb0NDUkNNYjdwYk42clVMS3Z5WWNO?=
 =?utf-8?B?M3hCMHVyTmlNTFVmOTZCMDNVb2IzY3hqbTI1ZnlEQ3NJVDFOa25oNzNyS2Y1?=
 =?utf-8?B?UUhyQUhCQnlDK2Z5VnY2MlA4Yy9EdW1Bc0tGckdzc0pEK29IZDJNQjUrT0tu?=
 =?utf-8?B?dUlsa2ZSNFVMYzFzWHBIWS9QNEliWjJUQ0dkdk0wdDNxNHdmQnNocGxIMEhj?=
 =?utf-8?B?TnF1OEk1T0ZLRTRLbFlRWVVZenBGdnVoTmlQb0wxR3V6TE9Rd2xxU1RGTlFZ?=
 =?utf-8?B?SE1tamJxaVg1c3FyWXV2bVBYdVVHSFNncHhlR1NxbWlyMyt4amplc3dIZk9O?=
 =?utf-8?B?RG55TEJ5YUF4UDJvUW5haTNxQXV4RnNYMnVKb3pwUkRqL2pVcjdRVi9SYkUy?=
 =?utf-8?B?bm9qQWdVdjJrWFRkODJwWmI3U24wS2RJUkRZaFVHQlBVRC9UN1lobEhDTDBC?=
 =?utf-8?B?NVZxVEhOaVVXSVQ1V1Z1UHBZVGF2VlVSeVRJK1BDd3gwMUxTZE5ueTZqWFZT?=
 =?utf-8?B?eW9VeUxIeFltYVpWMUpjc1ZyMldYcDFNSHFua1diSDNWcGYvcmlRdGdEUUo5?=
 =?utf-8?B?cEZzVUhBRDZtUjFNOGxsZDRTNEZ6Qmp0MjczandBdUh2UEViWThieTlDcklD?=
 =?utf-8?B?SnI5YjIrVEhxVk5VckN2Zm42MlJXSEdkYzc3anB1NlRoVGE5RTJzSUF2ZGYy?=
 =?utf-8?B?QXNqUGFhN2hkZkp2Y0gvOWdPNlRsS053RGRUZ3lKNG1jZVRKZUplK210VDZW?=
 =?utf-8?B?bWh2S2N4NVMxTHpFSU1vcTR1dk9ueWFDc2RzdU5qdkdTbGFweUJwQ0JpY0hB?=
 =?utf-8?B?cTlNQUpaMWczN3VGSlN2elA2UExtZGRwazVTQ1I5SWNBOVRVZyt6aHdobkpu?=
 =?utf-8?B?NkRqemlkTHB1NGxPM2lsNDBVWllUSHVIdFljdUZGRzluMTZOVDhwWHdMZHhI?=
 =?utf-8?B?bmpXZWNNY2ZOTXBrU2lmaFJDRDZFcTlvandiM1VsaFRsZVhXWjU5eXZoc1FC?=
 =?utf-8?B?Ty9CcUhreHEyUjh0Wk1JeUk5UGpOaW1CbmN3emkraVUxdDVjbm1qd3NlY0g3?=
 =?utf-8?Q?Bw4ti4QjNcZXP4OjxlBlBc6S4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <267FBE06E99C71418B613E4DB7275706@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab3c1cb-09dd-4dca-0b92-08db47ef948e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 13:50:51.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qImcabSY/9x92jmh9NKp7z+ITYi0QF1kquks+5e/hO2sPb609DT1ZN25bZ0dHR3x0iK9pu6XZlX9FaVEQzN4ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5451
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTI1IGF0IDIzOjA3IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gPiA+ICsvKioNCj4gPiA+ICsgKiB0ZHhfZXZlbnRfaXJxX2luaXQoKSAt
IFJlZ2lzdGVyIElSUSBmb3IgZXZlbnQgbm90aWZpY2F0aW9uIGZyb20gdGhlDQo+ID4gPiBWTU0g
dG8NCj4gPiA+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRoZSBURFggR3Vlc3QuDQo+ID4gPiArICoNCj4gPiA+ICsgKiBVc2UgU2V0dXBFdmVudE5vdGlm
eUludGVycnVwdCBURFZNQ0FMTCB0byByZWdpc3RlciB0aGUgZXZlbnQNCj4gPiA+IG5vdGlmaWNh
dGlvbg0KPiA+ID4gKyAqIElSUSB3aXRoIHRoZSBWTU0sIHdoaWNoIGlzIHVzZWQgYnkgdGhlIFZN
TSB0byBub3RpZnkgdGhlIFREWCBndWVzdA0KPiA+ID4gd2hlbg0KPiA+ID4gKyAqIG5lZWRlZCwg
Zm9yIGluc3RhbmNlLCB3aGVuIFZNTSBmaW5pc2hlcyB0aGUgR2V0UXVvdGUgcmVxdWVzdCBmcm9t
IHRoZQ0KPiA+ID4gVERYDQo+ID4gPiArICogZ3Vlc3QuIFRoZSBWTU0gYWx3YXlzIG5vdGlmaWVz
IHRoZSBURFggZ3Vlc3QgdmlhIHRoZSBzYW1lIENQVSBvbiB3aGljaA0KPiA+ID4gdGhlDQo+ID4g
PiArICogU2V0dXBFdmVudE5vdGlmeUludGVycnVwdCBURFZNQ0FMTCBpcyBjYWxsZWQuIEZvciBz
aW1wbGljaXR5LCBqdXN0DQo+ID4gPiBhbGxvY2F0ZQ0KPiA+ID4gKyAqIGFuIElSUSAoYW5kIGEg
dmVjdG9yKSBkaXJlY3RseSBmcm9tIHg4Nl92ZWN0b3JfZG9tYWluIGZvciBzdWNoDQo+ID4gPiBu
b3RpZmljYXRpb24NCj4gPiA+ICsgKiBhbmQgcGluIHRoZSBJUlEgdG8gdGhlIHNhbWUgQ1BVIG9u
IHdoaWNoIFREVk1DQUxMIGlzIGNhbGxlZC4NCj4gPiANCj4gPiBJIHRoaW5rICJmb3Igc2ltcGxp
Y2l0eSIgYXBwbGllcyB0byBhbGxvY2F0ZSBJUlEvdmVjdG9yICJmcm9tIEJTUCB1c2luZw0KPiA+
IGVhcmx5X2luaXRjYWxsKCkiIChzbyBURFZNQ0FMTCBpcyBlYXNpbHkgZ3VhcmFudGVlZCB0byBi
ZSBjYWxsZWQgb24gdGhlIHNhbWUNCj4gPiBjcHUNCj4gPiB3aGVyZSB2ZWN0b3IgaXMgYWxsb2Nh
dGVkKSwgYnV0IGRvZXNuJ3QgYXBwbHkgdG8gYWxsb2NhdGUgSVJRL3ZlY3RvciBmcm9tDQo+ID4g
eDg2X3ZlY3Rvcl9kb21haW4gYW5kICJwaW4gdGhlIElSUSB0byB0aGUgc2FtZSBDUFUgb24gd2hp
Y2ggVERWTUNBTEFMIGlzDQo+ID4gY2FsbGVkIi7CoCBUaGUgbGF0dGVyIGlzIHNvbWV0aGluZyB5
b3UgbXVzdCBkbyAob3RoZXJ3aXNlIHlvdSBuZWVkIHRvDQo+ID4gYWxsb2NhdGUNCj4gPiB0aGUg
c2FtZSB2ZWN0b3Igb24gYWxsIGNwdXMpLCBidXQgbm90IHNvbWV0aGluZyB0aGF0IHlvdSBkbyAi
Zm9yDQo+ID4gc2ltcGxpY2l0eSIuDQo+ID4gDQo+ID4gPiArICoNCj4gPiA+ICsgKiBTaW5jZSB0
ZHhfZXZlbnRfaXJxX2luaXQoKSBpcyB0cmlnZ2VyZWQgdmlhIGVhcmx5X2luaXRjYWxsKCksIGl0
IHdpbGwNCj4gPiA+IGJlDQo+ID4gPiArICogY2FsbGVkIGJlZm9yZSBzZWNvbmRhcnkgQ1BVcyBi
cmluZyB1cCwgc28gbm8gc3BlY2lhbCBsb2dpYyBpcyByZXF1aXJlZA0KPiA+ID4gdG8NCj4gPiA+
ICsgKiBlbnN1cmUgdGhhdCB0aGUgc2FtZSBDUFUgaXMgdXNlZCBmb3IgU2V0dXBFdmVudE5vdGlm
eUludGVycnVwdA0KPiA+ID4gVERWTUNBTEwgYW5kDQo+ID4gPiArICogSVJRIGFsbG9jYXRpb24u
DQo+ID4gDQo+ID4gSU1ITyB0aGUgc2Vjb25kIHBhcmFncmFwaCBpcyBvYnZpb3VzIGFuZCBubyBu
ZWVkIHRvIG1lbnRpb24uDQo+ID4gDQo+ID4gQXMgZXhwbGFpbmVkIGFib3ZlLCBJIGd1ZXNzIHlv
dSBqdXN0IG5lZWQgdG8gYXQgc29tZXdoZXJlIHNpbXBseSBtZW50aW9uDQo+ID4gc29tZXRoaW5n
IGxpa2U6ICJmb3Igc2ltcGxpY2l0eSB1c2UgZWFybHlfaW5pdGNhbGwoKSB0byBhbGxvY2F0ZSBh
bmQgcGluIHRoZQ0KPiA+IElSUS92ZWN0b3Igb24gQlNQIGFuZCBhbHNvIGNhbGwgdGhlIFREVk1D
QUxMIG9uIEJTUCIuwqAgT3IgcHJvYmFibHkgImFsc28NCj4gPiBjYWxsDQo+ID4gdGhlIFREVk1D
QUxMIG9uIEJTUCIgY2FuIGFsc28gYmUgb21pdHRlZCBhcyBpdCdzIGtpbmRhIGFscmVhZHkgZXhw
bGFpbmVkIGluDQo+ID4gdGhlDQo+ID4gbmF0dXJlIG9mIHRoZSBURFZNQ0FMTC4NCj4gDQo+IEhv
dyBhYm91dCB0aGUgZm9sbG93aW5nPw0KPiANCj4gVXNlIFNldHVwRXZlbnROb3RpZnlJbnRlcnJ1
cHQgVERWTUNBTEwgdG8gcmVnaXN0ZXIgdGhlIGV2ZW50IG5vdGlmaWNhdGlvbg0KPiBJUlEgd2l0
aCB0aGUgVk1NLCB3aGljaCBpcyB1c2VkIGJ5IHRoZSBWTU0gdG8gbm90aWZ5IHRoZSBURFggZ3Vl
c3Qgd2hlbg0KPiBuZWVkZWQsIGZvciBpbnN0YW5jZSwgd2hlbiBWTU0gZmluaXNoZXMgdGhlIEdl
dFF1b3RlIHJlcXVlc3QgZnJvbSB0aGUgVERYDQo+IGd1ZXN0LiBUaGUgVk1NIGFsd2F5cyBub3Rp
ZmllcyB0aGUgVERYIGd1ZXN0IHZpYSB0aGUgc2FtZSBDUFUgdGhhdCBjYWxscyB0aGUNCj4gU2V0
dXBFdmVudE5vdGlmeUludGVycnVwdCBURFZNQ0FMTC4gQWxsb2NhdGUgYW4gSVJRL3ZlY3RvciBm
cm9tIHRoZQ0KPiB4ODZfdmVjdG9yX2RvbWFpbiBhbmQgcGluIGl0IG9uIHRoZSBzYW1lIENQVSBv
biB3aGljaCBURFZNQ0FMTCBpcyBjYWxsZWQuDQo+IEZvciBzaW1wbGljaXR5LCB1c2UgZWFybHlf
aW5pdGNhbGwoKSB0byBhbGxvdyBib3RoIElSUSBhbGxvY2F0aW9uIGFuZA0KPiBURFZNQ0FMTCB0
byB1c2UgQlNQLg0KDQpTb3JyeSBJIG1pc3NlZCB5b3VyIHJlcGx5LiAgT0sgdG8gbWUuDQo=

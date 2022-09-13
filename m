Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9713E5B6510
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 03:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIMBZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 21:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIMBZo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 21:25:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348C43307;
        Mon, 12 Sep 2022 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663032343; x=1694568343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mb2ASpEIC1Vc8lWwcu1e7tkgpTPyCd0hOuwaw93KttY=;
  b=Ufw27lcyVNIX3j47gLpMuUEZP/bB9nMcPAbe5C26COc7tnLIO6vgbqbf
   UHXjSKlYTZkaDXNXWsz0FTLUTPH0qCeBmD7GAkEMNp0WG1JMH6QtD/Zsn
   B4EUjWLNyhYXQ+wEdlFIB023AXHETsAjJ67n9gQEr6txWPNLWFNtMmFzn
   gIaXP8uZUnuRtknSwqe3qTSayqcZ+DDMFRF9oy/hMGj99km6vHa3puoTR
   vVqEH0dVnWyBOsiRMOlKVTGaA8CgFyDTf5zvogEda82EsxBDrEKijlTo4
   Td57USVr/+b+ELdzImYFp+rkt4xYsB9vG4EK1I8YN0bMvU837OXM6gpNA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359736037"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="359736037"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 18:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="649465919"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2022 18:25:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 18:25:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 18:25:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 18:25:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 18:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmS3HbEiGntJt+ozszlM3Wv86hh6w6K6bme+8BwoGWQJC9TnzITJqsIMw3teqB5NxHzl+y9TXqBrokPH/7UjK1/l+w2LSkgMPU57PvQLEb6k9a1yHx5dSnSr37An+eAddy65qZT+UfsgVCf69S5ecpIfw2L0JStPvJZhr0ijfZrDTxPiYl+devMy+DwuFrOWgjIH/wfBirLjxCcNg+5cFNX7X8O/gbizNPh6/o+sNjBFHshaJxgM7h8h+wWLDs5I34lnbPSbaavHJ8xTyp0OaP4OCeRqsObNpxyEm4O+IxxL2YVZDLDmaJGkyGjTbtulEF+07UgbfBj7hCkAb1AEFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mb2ASpEIC1Vc8lWwcu1e7tkgpTPyCd0hOuwaw93KttY=;
 b=A9Mm5SrezGGSWES8Jw7jpd5aExcdahR+07e3ck17fHyjV4vV7epPLW5qB0KcgmK2+eBTQf94ovQJiEs0TuZEnvpwD5cbHGCwSVnBmNX/4TlUy8mNfor6knAQR8dR1ImAyE81BT6xPBGegFCsHOLFbARoKK1t5ugtfXxpY4M/Zmv20JzEHS/aXT28mR56csM5/76pjqsUJwGAUP2HrF8YoRtmkMj7Imh82PmjAJIC+ZUM7Sb/L1ise/tw0KH8GbjO+Mq1xSqKomUMChLBC+v08U79Fwf2cpNGb7NA1sF9NEQQUCF0DSV5rd+dwkCvmq7y9DW45Ztn4psCG1n/5qCUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4778.namprd11.prod.outlook.com (2603:10b6:806:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 01:25:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 01:25:13 +0000
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
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Topic: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Index: AQHYxIIyxYOV36dpZUWRedR8nabxRq3cllIA
Date:   Tue, 13 Sep 2022 01:25:13 +0000
Message-ID: <f85dbb3636ad199ff5f6ea9bdf5e17261f66945d.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA2PR11MB4778:EE_
x-ms-office365-filtering-correlation-id: 46ac5749-3a47-47d5-5c2c-08da9526ce98
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LCdTf/b34ImZhNhV4coBfEod/sWgrhwN1glErOnyydIflO2CsRUL8ELR9I14OBNTOJHSFeOaT5mIbKmr4KodeuJwADTp9ojsV6yofkhepDx2BT3mv4tkUgkmkow+w1Tq2i3nmLd8F5Law3F8Q3mAn50PAHKSWwbOxbrR5JuudR5bzyo3DFxNd8/VjxgWV3LMhU7eoElqEWRcAPwm315zMEbpZmRroOQR+3aRTy7nj+rnDfk32rPURiBVojp1HcA5sN5pGmMJqwRFE/16RQPo3TfwqRBXVnLb6+ay3AblTmyvA1qcqOEs9Y10I68B3sRV9aPFzHVbR6HmZ94wW/wvCfl5GoSUgxNCVKB78M88ANH2c7LlnCKL+48jz+1PSO+8gey1ljHM8AgLpnt3iGki/YpHtld1HOychBrp7lfF5K5ao2bzt0t1FQ6d2dp4yHQ07dj+n1gYMT+O5WJKbwJcFvw4AbFofJA386q5yyedPxBFm8CpZ8yFMdOdCjV0IgvJ7AMbM/oYjmJK7oUMSDN9bM1WNxXDr+/BSCh9RbNZsFmUYey6M16tyLcKRYm+aFI3/cWLMl8SDvYFg7z4LCeBN6xwcow9ZESal8uy21Spc4jyJDfntUpvHBXoeaQRtyL5lHkzny37J/RMwxN7JSnUeMVUbPR+K4Uzmoae/s0nlhkAnKkGjppJJU+ix7KgZLa4MP08+4C6EQp/tlB6Ve0ShM05++nzgVpdVdtOYBNhgkLYbfKUVSWijXLsrMeqGFsfVUvmBc8Ua9pOWRU/O7UhpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(38070700005)(41300700001)(66946007)(76116006)(86362001)(91956017)(110136005)(6512007)(122000001)(4744005)(26005)(6506007)(82960400001)(54906003)(66446008)(64756008)(2906002)(478600001)(71200400001)(8676002)(6486002)(4326008)(2616005)(186003)(38100700002)(5660300002)(7416002)(316002)(8936002)(36756003)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UitoYWFwZFQ3ZWg5Rkw0K2U4RzhKMXJ2ZVBIWUI5bzlmKzBNa3lWczNMRFVJ?=
 =?utf-8?B?TjBwQUFvSFVJMVBzdHA5TjUwVUlwL2FGZG5RWVdLME5XdXpLdnp1MWJRcVl0?=
 =?utf-8?B?dDBKckxxbnl4dVdwZmVZZ0J0dDJLNE4vRGlxQmUrS0VPQ2pSUE50Y1FCcXdP?=
 =?utf-8?B?eVNsY00zTjlRb0ZqejJZZGFBUDVLcU84WWpDY2FuQ0owVXFneVN6a3UyanNz?=
 =?utf-8?B?R3JBYWRhaXhPMHduMjJsWTZZSDJ3YUorbzcwanZ2Z3NoZ0NDc29BYXVGZmpG?=
 =?utf-8?B?U1B6UUx1ZkdYTzk5cmFCTGJsSEtFbUVINHlzNWRYSnVFSHN0aUJTQTh0TWRp?=
 =?utf-8?B?WCs0L3lKZDJXZFFyclhZd1NyUFV5eUYwYXVFVXJoT3ZoNzhHNCtUVnNocHJa?=
 =?utf-8?B?ZkN4QzJ6c3djaUNscmY4ZExNVHRDZXQzSEtBWnVLeGMxQ2tEckovSkhxT3o5?=
 =?utf-8?B?YzhJYnJ5ZEZGc1V0TXdzUVo0QzlxcTZFU0hvQnpSOFcyalZadHozVmFFQ0ZH?=
 =?utf-8?B?Yythc2JSQTV5VW1lQ2NWN1RjekNUUmVidHFrUEYxTTJ2VEJocXd3U3hqRlRy?=
 =?utf-8?B?Qml0Yk1EQkFIUWlKb1UwbStMT0I0VlgrdldjVDlXT0ZGVUZJZ1lIb25HbVdB?=
 =?utf-8?B?QnAxdmZ3SURRR1ZyWHNJOGhVNk1FVEgvaWUvblNnN1BjaXpvZ29xSzdSR29U?=
 =?utf-8?B?RHU1MHp6SzdSVTNDN1JYcUg0L2RPc25tTWZNc1FtVThvclRMTnM0c0xmWGF3?=
 =?utf-8?B?ZWVnNGZOSkdOU2VIczlvU1VTc1lFZmw0SkE3NnNYajZLZTc0L2o5N2lzVEdn?=
 =?utf-8?B?NzdyYjlpRHJtempuN3FUSnU2THg1dW8rWmtmWE1tcERkeDEvcUdZSW9XUmZm?=
 =?utf-8?B?L3hIMXh2VUdxMmJXZHRzMkF2Vk9VallmTlY1QnF5Ymx6Sk9XOVZUQ3pqbDdh?=
 =?utf-8?B?U2VmK0QxQzhrWUhsVURNK05CLzAwZ0J3b2swRmtGMjgzQUcyaFJKVFEycGFG?=
 =?utf-8?B?WlNNVkFqVVArekJEc3BvTWRqeFNQL3Jqek9FODB0L0tVZy9Hc2N1UDZSWnc5?=
 =?utf-8?B?Tmd1UXZjTTZtYTdjVlhJSGZqRDhZUHo0SlVPeXRvU1dpTCtWYnNMWWF3WHYv?=
 =?utf-8?B?L3hLb1AwN1lMeEJnM09jYXJxNVdXZkZJcmxZMEFsNjhEanh1YlN1c3F0U0Nw?=
 =?utf-8?B?QWxDeUVTK2FrcWY5bkpQNTF6Y2xXN0w5dHYyR3RSczArNXArejlUd2lhd1ht?=
 =?utf-8?B?T2VjQVNmM3c1aEFSalZhZU1HV3BrMjdYK0xWTFkxK1NoMkRkNXNtZ2JjaUhC?=
 =?utf-8?B?L0pCQnpoQmlnb09jUzVjakE5QlJkd2V5WW5DUGptT2J6WDNiRlRvZXhoOU5p?=
 =?utf-8?B?VHBnbVcyenc0T1dzaXN6SjZlbVFwT3d1a0k1VWhUMC9NK1ZVYTR5SE9sT0JP?=
 =?utf-8?B?YURlM0FSWTFGTktRSzRwS0FlYk16cGpzSXBKZDhOK1lmWjdmQUJzblZwNE00?=
 =?utf-8?B?aFc0YldKR05vaVV1WFFWSkdITXA3SDFUdFdEY21FSU1BRElMK2hpbGdUL0lP?=
 =?utf-8?B?ekN2N2dYWGZUeXBNcHA5elE4WDZmWHRXcU1FTmJmRjlMMEdRcU9Id0FsRXlo?=
 =?utf-8?B?NmVrNzlMTjVJM1A2N3AzVDQrcEhOUEwyaXVCQVg5MkFTTElwRlVWZXNhaFNk?=
 =?utf-8?B?NHRaQ0ZEeGRlOVJTZWs0ZXE1cTdzS1RBVkFCNzRqekIxalg4QmhCSC9RTSs1?=
 =?utf-8?B?RUZHT0d0NGxuYWxadk56NmppZXpJaVhuYjdBTjh3MEtoSHJhVXZyd0pJQ284?=
 =?utf-8?B?RmRnY1pBTVFDQmFIdTdYN2I0UHlmUWV6QlNhZDBHaVFBMUZDa24xWkw1OUFT?=
 =?utf-8?B?V1VSZExsQU00R29oaWxEYVdXMmZNUW02aFNlOUpUZUsrYnRmbk9vWWFUbnMx?=
 =?utf-8?B?S1o3Vm1LVkYzUUJhVzZGRDcyWlZSenIveG5FSlFCRnVuWGVrYUxSNnllck1D?=
 =?utf-8?B?U0ZlMHd0TDFzZ2VwZy91WTNMcmx4MFJHNTRPOFVzTUl5bGwyeHJTMHNtUjNT?=
 =?utf-8?B?MC9hS3Y2dllCMlFmOUZ4bUNBQUxVYUVSVlljVjV1Mm1XVzdPZzZkQnpNTjZ3?=
 =?utf-8?B?eTRkdUx4MW5tSHBkN3BZMTYrbjVGVm9rbzhGU2JTM2pBMzMrT01WU3ZsRnpr?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C51246C8E039A949874095FC19D8EAC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ac5749-3a47-47d5-5c2c-08da9526ce98
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 01:25:13.3265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqOSFaPSd5pOh2m5M68Ogyib1dVNlRNlobVqj+aauPZs2b3NpYsnrf5/ebezOX3TVU5+lSXFj1qhNHB9eXz1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4778
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

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDEyOjI3IC0wNzAwLCBLdXBwdXN3YW15IFNhdGh5YW5hcmF5
YW5hbiB3cm90ZToNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jIGIvYXJj
aC94ODYvY29jby90ZHgvdGR4LmMNCj4gaW5kZXggOTI4ZGNmN2EyMGQ5Li44YjVjNTkxMTAzMjEg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gveDg2
L2NvY28vdGR4L3RkeC5jDQo+IEBAIC01LDE2ICs1LDIxIEBADQo+IMKgI2RlZmluZSBwcl9mbXQo
Zm10KcKgwqDCoMKgICJ0ZHg6ICIgZm10DQo+IMKgDQo+IMKgI2luY2x1ZGUgPGxpbnV4L2NwdWZl
YXR1cmUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9taXNjZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvbW0uaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9pby5oPg0KDQpTb3JyeSBwZXJoYXBzIEkg
YW0gbWlzc2luZyBzb21ldGhpbmcsIGJ1dCB3aGF0IGlzIHRoZSByZWFzb24gdG8gaW5jbHVkZQ0K
PGxpbnV4L21tLmg+Pw0KDQo8bGludXgvaW8uaD4gaXMgZm9yIHZpcnRfdG9fcGh5cygpPw0KDQpB
bmQgc2hvdWxkIHdlIGV4cGxpY2l0bHkgaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPiBmb3IgY29w
eV97ZnJvbXx0b31fdXNlcigpLA0KYW5kIGluY2x1ZGUgdGhlIGhlYWRlciAoPGxpbnV4L3N0cmlu
Zy5oPiA/KSBmb3IgbWVtY2hyX2ludigpPw0KDQotLSANClRoYW5rcywNCi1LYWkNCg0KDQo=

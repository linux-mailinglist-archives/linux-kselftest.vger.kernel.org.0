Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066D63CF0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 06:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiK3F76 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 00:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiK3F74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 00:59:56 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02151CF2;
        Tue, 29 Nov 2022 21:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669787996; x=1701323996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hr16P7nRjVnfFwu/lPEt7DCHYLRR1JsJUqh+prbOZzY=;
  b=NcHg1ABK5Hus6huSQulIxDJ8bOjGwnuQ58GNn/Ekhrlur5leyh+aYOIZ
   mLWVXm49m+VNO0nX/cmUookBc9NyufI9UP6ETMKA4xZSEfq5qfE/9/KIO
   cYsDabKfO/maWBAnLJZMJFVWWHOFvMmlKEKtaKn2GrF3QBYjWHKwAlbPi
   Zyw7lXqM8vYHvyxuITEEgLYMdFQwJL0h6RJga9X9ajvyBP7iFD+7wVhhT
   QZXj5vCdI3vvCjlH/cU8ldhRYxiorFNvkeNHTwKhGfiI5T7t1O1lpOedb
   eh8euFpbf7qOr9r5pb1SQ2AOFTKgdA+qPBG1TWCcBYYp47pieQvgYe8EW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="298682362"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="298682362"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 21:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="889159080"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="889159080"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2022 21:59:30 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 21:59:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 21:59:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 21:59:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inwMDpkRRAYSmkE/4VIOnKeS/uu6tbHLmaI8YJTehNFeo/IDXGan6nZS8n/HtTo9toBkxaKLty8S74Q/ttUXiwAshl/Tn5H2bWLFziEzn7L+8kmsb9BMRH4XvS0ICh/SDB80MCbBQf3p3QboRz3ZRXRUe2+UYmwTLvq0LTDINc+TCv9nW+yZQek4ymRUY7K+BKoUjq7tU/ub7D3+TPQbJnDvVUpC7NCANwfwO2aGYFxRpkixKhqfUhQgP1dkuHm+uP+oDm9W7DKJdm0CqhKYr3RFC4ZUTYp/o+R19OoZFwTdvE754uX6mAyLGOMs9+90B+MQC7D5GbKyxXMX4a4sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cWrpm5x2s0sptRoOC2ue8WZ74WdaVf/bMGfAeP5yOw=;
 b=ON/N8C89Hg4VhOUPhg8mBUWn/Ui0NwpdSJzT8FBlDiQDC/+O5x3G4Q2KqnDZ/Gy2SIt2gSlLBrWHds7lWhVUTxHrEelRhmR7iQwv0c164zIg1cQmo+wPDzkOePUqf7a71ayO+hhnU7SQXmyqVaQIjk28rcs7NedXU6aTedKpojTUrD5Gj2emCE0+2isRABMxmxP5OIfQ4QEVDE6sL7PUbC9N+Gc6uUEQeR4SMIDdHbmZZJFZYb+Ue9mN6DFAvzj7wekBSW19VxxOc38bP6dfDXHk8c+L2PpAy0e9GJG6BjHjCGtUqLV3L/AN/2bWuXrcPGzocKwX5ZKejrrZV2Gx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by PH7PR11MB6769.namprd11.prod.outlook.com (2603:10b6:510:1af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 05:59:28 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437%11]) with mapi id 15.20.5857.023; Wed, 30 Nov
 2022 05:59:28 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: fw_fallback.sh test failed in Debian 11
Thread-Topic: fw_fallback.sh test failed in Debian 11
Thread-Index: AQHZA5lIOHIFr50OcUq4S5sLOYsQua5VjYWAgAFsaHw=
Date:   Wed, 30 Nov 2022 05:59:28 +0000
Message-ID: <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
In-Reply-To: <Y4W+/TfM4F9TdSnZ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|PH7PR11MB6769:EE_
x-ms-office365-filtering-correlation-id: bbd84e0d-77b9-4212-c529-08dad2980aaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sGtZ167wjLSRi9XffC29mxmAt/2L9E/iQ1cGc152OfCfrb0Xuirq0w/FnQ95lkJgC0TW4Nx9Xqun7/QaCNyaIgjcdVyaHjLTLiOEsJNO6K0f81J0XUDe39w/Fon6eTmJoeGLqkqhVKljf6eojIk3UEJ9NcU2+0aVeqKHuhVp0tf1bCljlbuQqGph9au/SrW33Ae+uXXZdhTvS3CVxos5JzeUVDR4GA7M3Ti6XXFe7WfGIxhr1Vqswdwn9L+uXVhE6nZzrSwAEVnkHnn3wVRVhDslCM3uuFOxrp4UlwVp9Ky61EARpGWDtDUNBYz6lyXmUfLqnaNwqTjVyWZzCV36e2yU55jM6yO87abWKN1MGdmuQuPypZxNfNT5yowjNYK8q4sbStVCM8F7bR7Hi+fEikV//Mgsz/117N/ybOzAofvZ7YuhD3Yi6P8qWk0VATfHDSzT38DE1KmUO1Ny3nk4Sk5OPuuii8uxBpJnx2NG8y7pytpGBJQOvT0SMvnsQ9eP+/DKKV9MMNTAl3ZHFZLwMLbEMit8vGXxzSbBnyZKv+8XoHrfwhjyTj9R1CaSqwmOmlXlIpdb+0rxUdMe46kPw8KVstVyWVK97AQQ0Q7uwCySBus3HLYl+AFA2Ps4oZR0NvF5NxHJy+ivkEN0ks40eSMP0baqivw6HtJMFEgU8WWPyjfJXmlqA1X9GT3w3ZnXA1ankzDH2j5Gu9Wv7/qZWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199015)(2906002)(316002)(66946007)(52536014)(8936002)(186003)(83380400001)(64756008)(122000001)(33656002)(86362001)(5660300002)(38100700002)(41300700001)(66446008)(55016003)(38070700005)(8676002)(4744005)(107886003)(82960400001)(66556008)(66476007)(6916009)(54906003)(6506007)(4326008)(478600001)(9686003)(76116006)(26005)(7696005)(91956017)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sZmDxJk7ecjD7j31vj6j9qUJAnRhKTCg3jXbCBk0g8b5e3NX2dwMZDXqFW?=
 =?iso-8859-1?Q?fQ4ohC+8cZtmjNvOlaePjueTdME/V/f2L4BhF3AnbfxWqBZOAMf+MHDUUB?=
 =?iso-8859-1?Q?sLqOE4dBxw3DKNu+OH+8XyZVG3eoa+S7FHq1HaGJSHMjivuGWYAEWBH3LL?=
 =?iso-8859-1?Q?VpnXFoDrtqxILqEdtj1zNvzkZmoPApLnS82EFizildprmqghx+JS11/+mV?=
 =?iso-8859-1?Q?HOfEoEM7mX5Y+m3jEeeCzBLWrL2xL/AiNdSMsWMD4kD9G+JME0Viyv5eWu?=
 =?iso-8859-1?Q?8jPDGuleOKAAX8N2CisOipn6CZa6xamhSdZvnMF0MghOVpZK9EJp1xg8mC?=
 =?iso-8859-1?Q?fg7CHghEZLN1hoZA07KwhVs708nUBlZG5tr5fbqKnoZ9GyE16CKngIKROD?=
 =?iso-8859-1?Q?7APezLX/R2YciMvHLdqzSF/GZdtE52aFIJSCGS/mma75hYfKgqGD9MgRTo?=
 =?iso-8859-1?Q?vP6rN7EsZwv2RAoCC44wrd/vTFRtk4yHLnqrdwM5f2w8Fbo+tZ70+xq+Wn?=
 =?iso-8859-1?Q?lWYwgC3rlYsj/tr9Ck0ocQgqLPiMH8rcOrQQ7yGhVB/l1MfEjkSipdbHLu?=
 =?iso-8859-1?Q?p/fti3yCXVWsVQ18yeRYO6Rt2A3loYRP6osIARMaVbLAKV1CNePW0ATRhE?=
 =?iso-8859-1?Q?xKGPTUPwrMsME2BsqKxCL0RnHAN4qR3vrAKL7+dBi6Ys12wtVIS+DaunIy?=
 =?iso-8859-1?Q?IXSmlBnUSvyQtqFUCbV6T3mOt4wgNU71lIKVNA8bg2Qb0R4kor25mnYLZX?=
 =?iso-8859-1?Q?3KSoPmgdPwR8/h7Z2aIoUmt32MR28ThvRt0cRXq+KNeocvUU+4zX3PpRyK?=
 =?iso-8859-1?Q?JlMOFvRNq4Ib0jU4SLARwM2l975BCznWGh0gT5ChVjmV4GL9Qw6k+eFdh3?=
 =?iso-8859-1?Q?dVnGOz5GQoGmiXy1XEKXFqXqaKg8sSIsUzmgjbwuFEAq2fnl5sifbPozhP?=
 =?iso-8859-1?Q?B+Iek2NPE7OlPGWWaf3H8vTiJSHG+IzPm9gmehVST0P0T/96mwW2feEXAn?=
 =?iso-8859-1?Q?nZjyNeAflWWQEuixU9I4OjnclTKp09SVtlcdaULZ/00OeA7iu27a9sQYgK?=
 =?iso-8859-1?Q?auPCFMX6VtE72CDLA5CAtuR49AqeuWnLSPeOXK30RHrIUuHHgLVSdJn+PM?=
 =?iso-8859-1?Q?XACI1Jn2nGuMIDesymxSIJRFUdLWixSGzIOwnxhddZJFvHtnO0AxxI+OZO?=
 =?iso-8859-1?Q?NeqnkzBYm/m1tBU67v/4ViNacl8Dcv9qcKnq++6pmcuXSWZ5g55zlSANbz?=
 =?iso-8859-1?Q?JylUE6RaVq4dOvjljQxeKBBxq2SZXFImwk3dh45AX+dQoT0Zov9kxdzmWr?=
 =?iso-8859-1?Q?aTtqCqkpdoPCZk4E7grTgWI3Sgu4mfmGJnZaXSZVnxuHJzVCPXOTJaWcwg?=
 =?iso-8859-1?Q?9p4QMgc7leE4tdxkysAYHI9/eXufefYC5nMRYgyLesZFIbD0x2eOKLhNBP?=
 =?iso-8859-1?Q?F2yYeHFnDN7HjFgf5JL36oubF8IDD64ZxPX3ONqsluDEjWY2g4gpIGs8b9?=
 =?iso-8859-1?Q?Jyev74/eV9yl70uUFNMSSN/avN4otnm3CuiNermi16laRwQNnhg97f7jG2?=
 =?iso-8859-1?Q?Ddiv4gmzIC0YSYEJiPAh/KMYkJg14OtaG5gCCNPBSgZjUts4t9smEaUbn8?=
 =?iso-8859-1?Q?o6T6T0T0OFYnDsFcL58/yMX4cwUNUOo5k0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd84e0d-77b9-4212-c529-08dad2980aaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 05:59:28.2031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RE09GUURGSfyZDS2zBgu0IKCSEzrffkKrx5dSGae4MrAi/9JDpiNwn5yIcWO/+XiqWunIhWbrnWeT69GrURcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hi,=0A=
=0A=
>Are you sure you have the proper kernel code loaded with the test=0A=
>firmware code that creates this sysfs file?  Without that, this test=0A=
>will not work.=0A=
=0A=
I checked following config options, and they all enabled.=0A=
=0A=
tools/testing/selftests/firmware/config=0A=
CONFIG_TEST_FIRMWARE=3Dy=0A=
CONFIG_FW_LOADER=3Dy=0A=
CONFIG_FW_LOADER_USER_HELPER=3Dy=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
CONFIG_FW_UPLOAD=3Dy=0A=
=0A=
best regards,=

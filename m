Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4303B5B671D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Sep 2022 07:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIMFEO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 01:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMFEN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 01:04:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F723E77C;
        Mon, 12 Sep 2022 22:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663045452; x=1694581452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VrcaZ+tfsIzRUDZ/grzSXLQIB186wDk/MSojhDowmlc=;
  b=Ig+yn3cpJklGrDfMkNEW2Sq8G6SGSgiDrmN5zj0gUu4UIBJ4MIfieLbB
   DA8EuH48ZoqjVr6Vo9Him1nG5tVtE+3tL2T6M4YskS3qWnvApEYWzKVbg
   35nBBaVjIrZjjhvzxNkGqEkBOeiGa+gjJ3CqEgaWXaunYti4k7+w4TbEh
   HQzpNtV4EKQ9VGmm90Gy7FRsLJax23GL94Bar2ZNKE8upP7oHFb0fhikZ
   pAr29EphJBpGSfwx43JkIXPTRYhLTuqAbaR/LpxcLq49lIqeKThkdBo7F
   u2qPAfYow9jTWgdAatZAnshMRWMd5CNsN8Sg3TatKUyTMGEVB4Zdex7kz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298040607"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="298040607"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="646766878"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2022 22:04:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 22:04:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 22:04:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 22:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goNpc17Z9KcMjKjhCMSrRlLpn9znSDtbF2xBP3x8u+1I8S6ZLGdmFwErT0sS7USV4AzldmcFPUcdEttqJrR7HBxTmYj1O9Ad4ZD0/T/fCm4u9n7KVveayKdIN0+B6vRzS91D2plEU1jMpkhijvsFtSJldmg07nqR8CpMeRPIEk2nijNNBkSXSjLy+LBawiechh7b2FIV5x+5ah2UsrPjXtzpZZsrEFKdj3gjf2x/51YCo7tzKp3AmIXvNb3vlop5QcAtqWZkvcVOuIjSPw0/03DJNm3EnX8kSmzJYoG9I+k+wnEQUJKaBXOfHZdj478xW4RnoREVZOFm7gMA2jSXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrcaZ+tfsIzRUDZ/grzSXLQIB186wDk/MSojhDowmlc=;
 b=cb9WkseGlvhZ5YhdE8W3TMNNLFY/sPF+xVf7jmVAw0WULhQ7y/Y5NzLVLyyhdEe/5UmfRxa9n0XTFQPVEaqoASB/sHjHY5kOHfcEstBqBuoFpCxVVxq62MDAsm9o1VLgj2E9RYiu8a5Ufb8//wWAed9PPG7deKSuzZJ4NeldWIC48iweNfIm7h8INE5JZmL2JYKK5GqAQD8ak+S/BLljwKvNYHk56WZsKqLMIvgILRvzgbMqQ89RaRoCi7QUU6d7PDieMxImh1y0oiXZTmKfdk7+P9E3hqo9YBsUA3iEEcCFYYNpfUTV8kLNOHRaoV8GfrRQNroPUsuur4N0h+qnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 05:03:53 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 05:03:53 +0000
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
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Topic: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Thread-Index: AQHYxIIyxYOV36dpZUWRedR8nabxRq3cllIAgAAWDQCAACcLAA==
Date:   Tue, 13 Sep 2022 05:03:53 +0000
Message-ID: <e7131ce1fd0a24f51450ffe5cc4c4f9d7a3411ad.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <f85dbb3636ad199ff5f6ea9bdf5e17261f66945d.camel@intel.com>
         <d67b4273-e0a6-6b24-b96c-7a3193ae52f9@linux.intel.com>
In-Reply-To: <d67b4273-e0a6-6b24-b96c-7a3193ae52f9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5545:EE_
x-ms-office365-filtering-correlation-id: c79660c9-027b-4541-8975-08da95455aba
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLQe98NDEE4krAmgGwPnJzKC3WvUKtJauWhhcNZJMBEb0ujy4tmqcfsQNmbmq5XwAm5QBEsNqkubMRoZ1mVuDtdmNqdJqUWUm+6vWQjYU24VOhHSUy0uq3yw4gjnf63iZhk371kH4cQwFZjlmYPDSi865KkCjDQGLy5V/m5DG1SM7EOf8s6XanKOiPZmo3mKNRJLv7wH/tIK2DMSAAYtB1bKGVNn257I/tAcGLH5GaVAM1AJ6+NIXXGbQuh4mtgJaGawEMLy/W4sqEQzsVzLxxj7hXQOlvDyRQfFIGcs15ZtQjI1bft26NaD0CTZFwX1rJzJyJYxU+Ww5884GQl5dQ1Mr7LXU2858/xvHnBNsZW7gIeEFm03hgSVyJUs44lBpOtFSpO7PotlwEhYHPDuiEQj+nZqZ8iuT3wfsZDoNa0aPizQkrlpRqYvsfV2FGW8s8YPp13sSCol4lhvmobfe2SxSlWDykL7MpQQeDIPNf0PeVL42NoFPJlMco3vnNqgu+ehB5ZJA7A7zJ6OFGLMJlLr2PWzjjKVXeyjrc1NtsIzMswVta8sWGWzoeEXnCb3jldHWLtaEXJq5NygP0a/TXEMKRqyC5hFlpE2M5Jm9gN/3mIbtizC5f1rezJA01jwhAeuGWPgfczdMSaJar3JTcbPlzSJvRvOO1JLaTGJie/zMC+r9xaPHasDWO61oALyjtC74LQ9xiQsX1ZENH+1ggzeyy4AgstExzoDwFM91sTPE13I1VhxTtqdmvqlWTEzJFmWIKbpULP5hp1frl5WyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(316002)(8936002)(76116006)(66446008)(4744005)(122000001)(41300700001)(6506007)(7416002)(4326008)(64756008)(66476007)(8676002)(54906003)(66556008)(66946007)(86362001)(6486002)(38070700005)(5660300002)(2906002)(71200400001)(36756003)(110136005)(186003)(26005)(38100700002)(6512007)(82960400001)(91956017)(478600001)(53546011)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlQdXE3ZktsRm1OcUxqZU9pQk4vaGVndGE1ZTJEQzFOcEtQOXJhWHc2a09H?=
 =?utf-8?B?UUVBdXJaYy8waGZvcFlhOVFBdGZGMlRwWlRHNkJlQTB4aGxCcFE0bVhkY3dm?=
 =?utf-8?B?VFNPVjZDRWM0ZHFXSU1XOVlYWjZ5Ry80NGFYRVQ0Rkc4czk3a3ZOcExrWFNx?=
 =?utf-8?B?cXY5VFpwSkVtZUFGVkVkempBckVkK09QQ2hoUDJoUUlGK1hhR1NXQXNvd0gr?=
 =?utf-8?B?VnpHaWdtVlZERGQzNmNmTEd2YkJJdzExOG42YzN2WS9rdFhRRlhnOS9YTnQw?=
 =?utf-8?B?OXdEaS90NU56QnU1Um1RQ3piT3pmT3NjSmtWTU5RNlpBWGNEYmVnUEVkQ3Ir?=
 =?utf-8?B?MkR4ZjVjbmU5eGc3N2g2SGJDck91RHVmcFVWQ0IzTjc4R0ZoTGRuMHFjcHEw?=
 =?utf-8?B?SU5aRzIrdzlkeXVaeFBvVGJGN2g1a2ZJeHhFTnl2azEvbzUrK1JXUGh4VTJm?=
 =?utf-8?B?a1NIUVZHM0JyZFE2Z0xFdmJ3c1FKUWFmRk0vbXhhNllEL00rUEdXVEZHM0Jt?=
 =?utf-8?B?QkFrQjF5dDU1MHBZUk5YM2FRdVlzRzVscWllc1ZmVy84MjVKcEd4anh4c2Fk?=
 =?utf-8?B?Y00rcHNkTzhkOE1CUStWc21QV082QkV0eUxuZmlvMjJKeVV6S2RIdFozdFVn?=
 =?utf-8?B?UGFZWlZoVzFBQ3V3MERVM3dRcDd2bmtwa05RV3p0NWJjS3VieXBtcStFZ2Ro?=
 =?utf-8?B?MWlQY1d5WC9pQjg0MUtHU2VRRXZsVUFhNUhBc1lzMHZUYmtvUnFtbGxlbE9u?=
 =?utf-8?B?NHVnRzQwQWRSZ3g0Y2FtODM2NVZuYU1HZmJaVjg5dmNjbjQyZCtpRUorcDFB?=
 =?utf-8?B?dUgrRXFWYXRYSjhPYTgwWHl0QzhJdGFSeHlFUUdWbmRGb1VsOXJ6RXZzSVEy?=
 =?utf-8?B?V1d5bUZJdTljZkFYc2RCNFZxakx6QzBCRUNKSytkaXl3TEcwMDRZN05iZ1hI?=
 =?utf-8?B?VXBTd3NOTitNK0I4ODFDdUpYZFZITmpFRHdFZDhqTGRvZktVKzRMZ2k1cGFG?=
 =?utf-8?B?OFpyd29TS2FkRGRoZklTbm5zTmJBVDZRdzh6cCthRkZhVS9uUHgxWGltSllV?=
 =?utf-8?B?Yzh2VkhacVVySGhjbTEyZGlyekJMQ0xITUtMb3dUb2FnSmpqL0V5Q1F4OUtK?=
 =?utf-8?B?U3BIVHVhQXJyM1ZwaDIyTDU1TnBEaE1rWW5BYnI4SytDbHV5UEFLdEYzRnk1?=
 =?utf-8?B?YlF3bmZoaW16eTZyQVFwMGlkR28zY2hYSnA3eDlZRkxVTU16dVo0UGJNbUlV?=
 =?utf-8?B?STV3eElQL0s0aDRxenNWNVZ2U3JUUVU1SXBJZlk5dG9FcWR4WWlFUTVvZWRO?=
 =?utf-8?B?MXdmMlVSQW8vOUFtbGUxMjF0RnoxWDU1azJUM3Z2OWh5Wjg3V1BQVXFOalYr?=
 =?utf-8?B?WVJmL25nV0tkSDVPZ1V1WkZyVHRmUmJiMFFvQnlrUW96ZUVwQVNsSjF2a1d0?=
 =?utf-8?B?YjBsSDBWai9DbEFvOCtBVExTSFUrNVFNTkRJcTVQeFcwQmxNYTV0eVE2MTQy?=
 =?utf-8?B?MHZRRUJkaWprTm9jV1RaUWVISjVJd3NEcjRNTC80YnJ4NS9YSlI0OFFGNllE?=
 =?utf-8?B?OTNUemNJMVJOdjF2ejdWcmtmRE1ZM2c2M3dwOG9yM0E2SFJNLzRxZytaTTJl?=
 =?utf-8?B?ZWNqM1d1cUxoRGhlSnRHZmpKNzl3YUdkNUxCSTFrcTh0LzVyenlZZGs4aHBr?=
 =?utf-8?B?TlVOTEI5YldoQndablRqTmY1VS96WVJUakt5TXIydzZjSFg3eDN5RVA4YXFE?=
 =?utf-8?B?ZFhzTU1wV3JlTkU2S0pZTkRNQkZKTmE4UWFxeGY1Uk5seXE0WExEVFo1UzNK?=
 =?utf-8?B?a1RmeVVveGoyMHM0SXhVY2dxRWR5MkdER0hCRmhCZWFYUUk5RUI4WUNRK0RU?=
 =?utf-8?B?UEtOaXRQK25sQVE5Wmp4VHB6SHJKWFJxcFB3Y3JZd05wd0pHLzNDd3RrTVBU?=
 =?utf-8?B?VWdUNEtqK2tLZ0lnUE1ZLzc2QitXREY1NGZVbWZ5QjZrRU1BU2RTaDZGUStz?=
 =?utf-8?B?UEl3OFZkY1RvWDBnNGpYcjJISklWS2JNemV0NEVLSWpyN2VTRXVtQXRUbWpM?=
 =?utf-8?B?SERLYVhJMkxBN2tBVnVndFBlSzd2Y3R5aDlPL0c2SGJ6dDhJK0JGUUZsKzRY?=
 =?utf-8?B?YUQ2cmd1NXVUNmtYVkpHeER5Q25zWUdPZXZjV3k3cjUrbCt5eU82L3JIUGlj?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7F0B0DC84B7F0479028A2FB1E1837CA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79660c9-027b-4541-8975-08da95455aba
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 05:03:53.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGeCBJQZ3MkKUqDGPVRjYYRL3DPI+SsmWIDWHa3NgEK1hNAvz4vyTDz84yVbUvqxFUaceqGiPTpjKDceO1Jmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gTW9uLCAyMDIyLTA5LTEyIGF0IDE5OjQ0IC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gDQo+IE9uIDkvMTIvMjIgNjoyNSBQTSwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyBiL2FyY2gveDg2L2Nv
Y28vdGR4L3RkeC5jDQo+ID4gPiBpbmRleCA5MjhkY2Y3YTIwZDkuLjhiNWM1OTExMDMyMSAxMDA2
NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+ID4gPiArKysgYi9hcmNo
L3g4Ni9jb2NvL3RkeC90ZHguYw0KPiA+ID4gQEAgLTUsMTYgKzUsMjEgQEANCj4gPiA+IMKgI2Rl
ZmluZSBwcl9mbXQoZm10KcKgwqDCoMKgICJ0ZHg6ICIgZm10DQo+ID4gPiDCoA0KPiA+ID4gwqAj
aW5jbHVkZSA8bGludXgvY3B1ZmVhdHVyZS5oPg0KPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9taXNj
ZGV2aWNlLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+ID4gPiArI2luY2x1ZGUg
PGxpbnV4L2lvLmg+DQo+ID4gU29ycnkgcGVyaGFwcyBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBi
dXQgd2hhdCBpcyB0aGUgcmVhc29uIHRvIGluY2x1ZGUNCj4gPiA8bGludXgvbW0uaD4/DQo+IA0K
PiBJdCBpcyBpbmNsdWRlZCBmb3Iga21hbGxvYy9rZnJlZSwgZmlsZSByZWxhdGVkIHN0cnVjdHMg
YW5kIGNvcHlfe2Zyb218dG99X3VzZXIoKS4NCj4gDQo+ID4gDQo+ID4gPGxpbnV4L2lvLmg+IGlz
IGZvciB2aXJ0X3RvX3BoeXMoKT8NCj4gDQo+IFllcw0KPiANCj4gPiANCj4gPiBBbmQgc2hvdWxk
IHdlIGV4cGxpY2l0bHkgaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPiBmb3IgY29weV97ZnJvbXx0
b31fdXNlcigpLA0KPiANCj4gbW0uaCBjb3ZlcnMgaXQuIFNvIEkgZG9uJ3QgdGhpbmsgd2Ugc2hv
dWxkIGV4cGxpY2l0bHkgaW5jbHVkZSBpdC4NCj4gDQo+ID4gYW5kIGluY2x1ZGUgdGhlIGhlYWRl
ciAoPGxpbnV4L3N0cmluZy5oPiA/KSBmb3IgbWVtY2hyX2ludigpPw0KPiANCj4gT25lIG9mIHRo
ZSBwcmV2aW91cyBoZWFkZXJzIGluY2x1ZGVzIGxpbnV4L3N0cmluZy5oIChJIGFtIG5vdCBzdXJl
IHdoaWNoIG9uZSkuDQo+IFNvIHdoeSBpbmNsdWRlIGl0IGV4cGxpY2l0bHk/DQo+IA0KDQpPSy4N
Cg0KLS0gDQpUaGFua3MsDQotS2FpDQoNCg0K

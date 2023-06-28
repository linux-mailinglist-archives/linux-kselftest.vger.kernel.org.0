Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6118740DDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjF1JxA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 05:53:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:51635 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbjF1Jpm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687945542; x=1719481542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AJvwSpYpypbUz8/oB7VCBkUMHpsGfX0mLzSAtVlTGWs=;
  b=M4dn9yZUM54kpbruYNm4lscolxC2Yp96gG+Dt0Kaxq3WHEUj494CiHM/
   nk8GettyE9KI0W8k0GW7WD8wCWdcMP3Y/wrbZv5jslQKjtmav3azArGr5
   PVSvDM2u02FV2vYWu1OhlcJ43UjTVCj7G2FSWFeK9tK4fLXkx6mYeAQuN
   R2YscZu4pK/bc5JhkM46cDRRwRJhnpG+UmIH3ISYmfEwwm1k/rrLtqwQc
   9eEcfJAAk2hfZUQU0XEUvoxFZvtiY9CKc3nHzG5t1Piqort6DuOCY1S/G
   T9kD0hIjzsWgVwN5Mpyhc75GXl7KO2NMYNgnIpz7Ql9Ez4HgH3k8F08SI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="392523331"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="392523331"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 02:45:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="1047331312"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="1047331312"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 02:45:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 02:45:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 02:45:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 02:45:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiolXSwoYnVI8tF9Cwm71dpacEoXfc8GjZLNDyDma5kkejarHRUuajsT/G01oEy1ScrKvGU/8QXy6ICBuTfwmzlSslTjWmhsIOJxpnAq3FIfDsKkEN1+geNFrZ7xsLAI7kJhUrA931se21Boyrrl9SX3DnuO/gHEh+NzESGai17ut+juHWZq7y6YYVckeGV+0WYcXvu5l+nt0okMsJ7styrwTTBM4cp7k1/TK+Z7JvFdzgPL63j/4TLHq7JFza0G4041RGpusdYuocNd0n8Uoor48KDXuM9SdYXxKQhlo5Fbh1s8wL/t6+ZHRj/cjwLEBsi2B4fRu8wEo02anfRUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJvwSpYpypbUz8/oB7VCBkUMHpsGfX0mLzSAtVlTGWs=;
 b=SxGNPsTc4NGviDhQM+rDWaGc+CyHegpy4My7+u23kk4S3n9MutScRs4Tn8uDbFVx2pIae5LRp7AZXNjyY1wU6LDtpMx8stivXOAEpxu45ZBKUvAROvmYe4W67Tz7xUgmpj0qlDS8FEJIo5xTp8NGgsGMz2ra7lZtLnngWscjJ1f7XJ0goloETz+7YJxECFQn5LPebOOBLyv0+nOIGYLhRnHhbg0zz2gJsPdzMvQGprvBAKQzMblwgRbLErPyKUfFA9byI16VKD67rfjyOrvlBmQs/+7WpQGt6eWDyGCopzYx70vpI/VeMNM1ZXQgMKP34RIChemIJQ9JNmRXV8R9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 09:45:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 09:45:34 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "Du, Fan" <fan.du@intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Topic: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Index: AQHZhjUev+9U/9vzEkKqwBILfHYrRq+HtK4AgBGCl4CAA3KQAIABCfuAgAHp14CAABfAgIAAC1WAgABLSQCAACRpgIAAAbAAgAAMBgA=
Date:   Wed, 28 Jun 2023 09:45:34 +0000
Message-ID: <45d9214d845ba2ab048f215e95dac751f07bfd8d.camel@intel.com>
References: <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
         <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
         <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
         <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
         <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
         <c85324480053af20e6f0409e28fbc5e156c54143.camel@intel.com>
         <2023062805-drove-privatize-ae2c@gregkh>
         <e30fb40d736ccc60672316c5d20aaf1ab7c94dcf.camel@intel.com>
         <2023062825-rebel-happily-09fd@gregkh>
In-Reply-To: <2023062825-rebel-happily-09fd@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6478:EE_
x-ms-office365-filtering-correlation-id: f4843844-2673-46f3-3f00-08db77bc6bbf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOffXsG1y/0AQZ506DnjmnTviyaAuYCvYZVAHXGsPoc5bxQdTJ1hTrdB/jXAQBtpU5Y90lE8pwG/DIVVY8G8cOtPiCntaz4EFw9xVXJIqQ52DH84yBsi9kxMGgH3yxlQYDUHbxJ58N3rmPKT2OM8d+0zH9hA8dGKNCwyPAJrYZP/MY+ZNLWYnzqnmapryRp/COBBzA1ySJ2+pYV0QtDAINQhDICilNQ9uM+HzdJ35pfEXC08k4lNhBU+276fGg+GWfGPePmdgfMtZ+RdnS48Xnv7gX3N0mVSpnzAIt3GOzmazDhiI0GfH+G3e0FYQsI0tQROIiWeqT+8ni0E8z3sHngwsOvNiXphWfRgE+uXwGjsdv2/pj7JzYfJOp0ANWd7+ony7pYJXj6lv2mXuLBLIYhi7zoODmrrxdPLXq4YZPqvCbPHYxaZcktLmfJtS8ptXVOr/+8zPTuIzGDqGN5OotoaLY9N7A6dIl0wUra1M8swNBbSAmS8iCyqAmkaan6+mI4UC7lcscQY89eQWvyVbiN/8sHZILdWM1ncOOJ9NFN+/0ORNeY+yTY0MT+v9x/xohXw+nk6FE1zieWwFKxAne4wfG/3W0lPHy17JhwMRKM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(5660300002)(7416002)(6916009)(66476007)(64756008)(91956017)(66556008)(76116006)(66446008)(66946007)(316002)(478600001)(36756003)(2906002)(4326008)(8676002)(8936002)(6512007)(966005)(41300700001)(86362001)(38070700005)(54906003)(38100700002)(6486002)(186003)(6506007)(26005)(82960400001)(71200400001)(122000001)(83380400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUpXeEtOOGRKL2NIZE9JMytmZmtJL3NuRVBKb1RNRXhYOE9lVnVVd2F3ZGE2?=
 =?utf-8?B?anJFVXZ0UFpZL0dyTmNUVjM3aHcrY3doUjRBZmtJRWhJd2xqaEk1UXBDS0to?=
 =?utf-8?B?Y2pyRWJQby82WjloQmhYRHlFZ0NxVFdPNUpKRHFoNXJOazI4TDBTSm5CQUZS?=
 =?utf-8?B?Z0M5OEN4bnN4TUhCNXJ2cGF0TUxQNm1VS0xESnlzdlFPWHJGZ3ZhU2E5WFYx?=
 =?utf-8?B?Vzh5UjIyOUd0TjdveEhMaktWQlg0ZTJYNDBhT293SHExOVBMN3hnTHVGY3Ft?=
 =?utf-8?B?MzQ5N0ZZTGppalBESlNMVElvR2dwSFpKV1ZmbG9iWVRBWnJ2YmtjMytjRXZO?=
 =?utf-8?B?SE5idWlNVTRUbTIycTRUYjFpNFVRYytnTG9IMllBL1RBVEl0MEJiN2VGclk2?=
 =?utf-8?B?dmNqZ0pFc0o0V29oQ0VKaE9sRVVWMkYwYzJldFFXRVJnTktzN3oxWGtqODZ4?=
 =?utf-8?B?TnNCS3RJTHFHS0UycmNzbXBSOXQ4VFI5N1BHSVk2azJnWnQ1Q1VSSzVDUkNQ?=
 =?utf-8?B?SFVGbEcwLytFTHB0M2UxNG5lWE9MdXdaSFhwWkZEelFlbThtL2RtN1lveUtL?=
 =?utf-8?B?b1ZvUnNwR0QzZjJrZFBYM2ZCdVNjYTZmejU2NjdVREhhZjFXdlpscVVISVhK?=
 =?utf-8?B?T05MSmcyeUpXUVpCMzVCZlFWWUFFcDFCRExLZ28rd3RuY25JUzRnT0Vyb1Mr?=
 =?utf-8?B?VmhLUExNUDhJWHVsSUxuQjdqbHFoTmIxanBGdGFiYmFVNUVpU21CcDdISzBw?=
 =?utf-8?B?cDR1MDgvcXAvUnllMXR2RE1kc3BSSDBUQlk5ODhJNURpSkFWeEM1U3FBcmdL?=
 =?utf-8?B?blF3OGZJUWp0NnJDbUFSM1dUMndXbWJYcFJERGJHa1VKNVpsY1RPcm1QWWlr?=
 =?utf-8?B?RG1ZSHl5cmgzVEM0d0FaMjB1U3VRUnVWM0NKS0RUWFNZNFF4bTZYM3cwblc0?=
 =?utf-8?B?WjlqZ2JlVXlQOTJoSDNiZTlUbVNFb2t2UC8wRnFPNmJqZExKR1BIekNkeHFr?=
 =?utf-8?B?Qk5XTmtoajVKVlU2NGtFdUZyajJIRmdqR2dQR3ExUnhWMWdDeXZFVVlGTE5l?=
 =?utf-8?B?M0Vtb2Z4Y1AzM0JPK25peXVHcWxVdGszS3QzbDZMaTdRUnZMSzhLZ2hJbEw4?=
 =?utf-8?B?Y29KaWhDbUtkdGQ5ZDZLbU0vWCtoOXRjNDQ2bnBsT2c2THRmZXAwZHNmdVZO?=
 =?utf-8?B?VVVISURiTnZIY2dhWHpkekpQYWlMdS8wZDQ1eitKRVlGWlduUmg0NkpOWWVw?=
 =?utf-8?B?UW9lcUtSUkpYNElLaFZRU0NKbkcxWGFnajladkViTGc3WmV1SWVpdzhQL2VO?=
 =?utf-8?B?RnlDS3grTzV1RUVCdExkSCtDM29RdFlIN3hYYU9xSlcrdm9DSXN3OGFJbW00?=
 =?utf-8?B?ZUFUblF1MUgxVnlKNmFmZXZxWGFJVVNneEYxVk90NENHNU0yODdPaUZNTm0y?=
 =?utf-8?B?cW9BQlVNSUQ5S3o0SngrS0ZvR3VDcTh6UHIvdS9VU1BoZnVTRUZwYmpoeDVH?=
 =?utf-8?B?YkRDSzZPdUhLVUc3Q3lES3VGazJjTml2blNaUnFwdTc5aEVLbVpwL0hKNWRO?=
 =?utf-8?B?cmNMd1VvTnRtOGR4OFgxeERSVmxMYUNQckV5T09jYmN5ZjhxQzY2VEhScEhx?=
 =?utf-8?B?aVVZOFRsQU1Tc1ZCeE1kbDRvbVYwc212V1J0dGtzV2dwTVR0ZndsUTdReVJT?=
 =?utf-8?B?Z3FQSWVoalZZMWdtdGE1bkFvZzMvNjV6WDhmcFJwbkhTaDRlTWhOV3JYOUsx?=
 =?utf-8?B?OXQ5NGNvcUpFSjBqRVlTcVgyVlVRMjNRc0o4QXhZZnQ0bGNOdWhnbmwzNmZz?=
 =?utf-8?B?MXVmREpseVhjQTFHd3BpUEpNeDlXMEYvZlo0K0F1TVRuSHBrNVo4T0YvdDND?=
 =?utf-8?B?MXpzSXdaOEozS2lXWW9wQTJuL1ZWSTN6N2swT1NYbEdMaXQ0SmkxUU40eWZK?=
 =?utf-8?B?ZVlOZWJZaEVrZHlLaVliaFNVWk54cHNkbHRhQUtjSTNDNGs1SFI2RmQzZ1h2?=
 =?utf-8?B?anU3NCt5L1diUlZHSldhNkk2K1JzSk9HYzZYUGtwazh0Z0M5YnVSNEFVM3E0?=
 =?utf-8?B?eHV4aGFCRm9heU85R0UrRmFGVXlxYUNWUnZSZ0ovNjlhTW1tYm9Wa1FDRXhn?=
 =?utf-8?B?M0VTdnNkVllNUEMrV1JpaGlFUEgvUHMwVWZLQ2ZqZWlrR3lwdmNkbkNJTUx5?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67CD300DCB87D5409C64380DF48B6E1C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4843844-2673-46f3-3f00-08db77bc6bbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 09:45:34.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyvE5cPuzmWd/cBkAPLxUaPa2Ihj1UhiZyQ3s1RqyzAGUkjVV/Qd+hI0cUN5QHWgMLpzvXzzJ2bP3vshlzbFJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTI4IGF0IDExOjAyICswMjAwLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gT24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMDg6NTY6MzBBTSArMDAwMCwg
SHVhbmcsIEthaSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjMtMDYtMjggYXQgMDg6NDYgKzAyMDAs
IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBKdW4gMjgs
IDIwMjMgYXQgMDI6MTY6NDVBTSArMDAwMCwgSHVhbmcsIEthaSB3cm90ZToNCj4gPiA+ID4gPiBZ
b3UgcmVhbGx5IHNob3VsZG4ndCBiZSBwdXR0aW5nIGF0dGVzdGF0aW9uIHZhbGlkYXRpb24gbG9n
aWMgaW4gdGhlDQo+ID4gPiA+ID4ga2VybmVsLg0KPiA+ID4gPiANCj4gPiA+ID4gQWdyZWVkLiAg
VGhlIGRhdGEgYmxvYiBmb3IgcmVtb3RlIHZlcmlmaWNhdGlvbiBzaG91bGQgYmUganVzdCBzb21l
IGRhdGEgYmxvYiB0bw0KPiA+ID4gPiB0aGUga2VybmVsLiAgSSB0aGluayB0aGUga2VybmVsIHNo
b3VsZG4ndCBldmVuIHRyeSB0byB1bmRlcnN0YW5kIHRoZSBkYXRhIGJsb2INCj4gPiA+ID4gaXMg
Zm9yIHdoaWNoIGFyY2hpdGVjdHVyZS4gIEZyb20gdGhlIGtlcm5lbCdzIHBlcnNwZWN0aXZlLCBp
dCBzaG91bGQgYmUganVzdA0KPiA+ID4gPiBzb21lIGRhdGEgYmxvYiB0aGF0IHRoZSBrZXJuZWwg
Z2V0cyBmcm9tIGhhcmR3YXJlL2Zpcm13YXJlIG9yIHdoYXRldmVyIGVtYmVkZGVkDQo+ID4gPiA+
IGluIHRoZSByb290LW9mLXRydXN0IGluIHRoZSBoYXJkd2FyZSBhZnRlciB0YWtpbmcgc29tZSBp
bnB1dCBmcm9tIHVzcnNwYWNlIGZvcg0KPiA+ID4gPiB0aGUgdW5pcXVlIGlkZW50aXR5IG9mIHRo
ZSBibG9iIHRoYXQgY2FuIGJlIHVzZWQgdG8sIGUuZy4sIG1pdGlnYXRlIHJlcGxheS0NCj4gPiA+
ID4gYXR0YWNrLCBldGMuDQo+ID4gPiANCj4gPiA+IEdyZWF0LCB0aGVuIHVzZSB0aGUgY29tbW9u
ICJkYXRhIGJsb2IiIGFwaSB0aGF0IHdlIGhhdmUgaW4gdGhlIGtlcm5lbA0KPiA+ID4gZm9yIGEg
dmVyeSBsb25nIHRpbWUgbm93LCB0aGUgImZpcndtYXJlIGRvd25sb2FkIiBhcGksIG9yIHRoZSBz
eXNmcw0KPiA+ID4gYmluYXJ5IGZpbGUgYXBpLiAgQm90aCBvZiB0aGVtIGp1c3QgdXNlIHRoZSBr
ZXJuZWwgYXMgYSBwYXNzLXRocm91Z2ggYW5kDQo+ID4gPiBkbyBub3QgdG91Y2ggdGhlIGRhdGEg
YXQgYWxsLiAgTm8gbmVlZCBmb3IgY3JhenkgY3VzdG9tIGlvY3RscyBhbmQgYWxsDQo+ID4gPiB0
aGF0IG1lc3MgOikNCj4gPiA+IA0KPiA+IA0KPiA+IEkgZ3Vlc3MgSSB3YXMgdGFsa2luZyBhYm91
dCBmcm9tICJrZXJuZWwgc2hvdWxkbid0IHRyeSB0byBwYXJzZSBhdHRlc3RhdGlvbiBkYXRhDQo+
ID4gYmxvYiIgcGVyc3BlY3RpdmUuICBMb29raW5nIGF0IEFNRCdzIGF0dGVzdGF0aW9uIGZsb3cg
KEkgaGF2ZSBubyBkZWVwDQo+ID4gdW5kZXJzdGFuZGluZyBvZiBBTUQncyBhdHRlc3RhdGlvbiBm
bG93KSwgdGhlIGFzc3VtcHRpb24gb2YgIm9uZSByZW1vdGUNCj4gPiB2ZXJpZmlhYmxlIGRhdGEg
YmxvYiIgaXNuJ3QgZXZlbiB0cnVlIC0tIEFNRCBjYW4gcmV0dXJuICJhdHRlc3RhdGlvbiByZXBv
cnQiDQo+ID4gKHJlbW90ZSB2ZXJpZmlhYmxlKSBhbmQgdGhlICJjZXJ0aWZpY2F0ZSIgdG8gdmVy
aWZ5IGl0IHNlcGFyYXRlbHk6DQo+ID4gDQo+ID4gaHR0cHM6Ly9kb2NzLmF3cy5hbWF6b24uY29t
L0FXU0VDMi9sYXRlc3QvVXNlckd1aWRlL3NucC1hdHRlc3RhdGlvbi5odG1sDQo+ID4gDQo+ID4g
T24gdGhlIG90aGVyIGhhbmQsIEFGQUlDVCBJbnRlbCBTR1gtYmFzZWQgYXR0ZXN0YXRpb24gZG9l
c24ndCBoYXZlIGEgbWVjaGFuaXNtDQo+ID4gImZvciB0aGUga2VybmVsIiB0byByZXR1cm4gY2Vy
dGlmaWNhdGUocyksIGJ1dCBjaG9vc2UgdG8gZW1iZWQgdGhlDQo+ID4gY2VydGlmaWNhdGUocykg
dG8gdGhlIFF1b3RlIGl0c2VsZi4gIEkgYmVsaWV2ZSB3ZSBjYW4gYWRkIHN1Y2ggbWVjaGFuaXNt
IChlLmcuLA0KPiA+IGFub3RoZXIgVERWTUNBTEwpIGZvciB0aGUga2VybmVsIHRvIGdldCBjZXJ0
aWZpY2F0ZShzKSBzZXBhcmF0ZWx5LCBidXQgQUZBSUNUIGl0DQo+ID4gZG9lc24ndCBleGlzdCB5
ZXQuDQo+ID4gDQo+ID4gQnR3LCBnZXR0aW5nICJyZW1vdGUgdmVyaWZpYWJsZSBibG9iIiBpcyBv
bmx5IG9uZSBzdGVwIG9mIHRoZSBhdHRlc3RhdGlvbiBmbG93Lg0KPiA+IEZvciBpbnN0YW5jZSwg
YmVmb3JlIHRoZSBibG9iIGNhbiBiZSBnZW5lcmF0ZWQsIHRoZXJlIG11c3QgYmUgYSBzdGVwIHRv
DQo+ID4gZXN0YWJsaXNoIHRoZSBhdHRlc3RhdGlvbiBrZXkgYmV0d2VlbiB0aGUgbWFjaGluZSBh
bmQgdGhlIGF0dGVzdGF0aW9uIHNlcnZpY2UuIA0KPiA+IEFuZCB0aGUgZmxvdyB0byBkbyB0aGlz
IGNvdWxkIGJlIHZlcnkgZGlmZmVyZW50IGJldHdlZW4gdmVuZG9ycyB0b28uDQo+ID4gDQo+ID4g
VGhhdCBiZWluZyBzYWlkLCB3aGlsZSBJIGJlbGlldmUgYWxsIHRob3NlIGRpZmZlcmVuY2VzIGNh
biBiZSB1bmlmaWVkIGluIHNvbWUNCj4gPiB3YXksIEkgdGhpbmsgdGhlIHF1ZXN0aW9uIGlzIHdo
ZXRoZXIgaXQgaXMgd29ydGggdG8gcHV0IHN1Y2ggZWZmb3J0IHRvIHRyeSB0bw0KPiA+IHVuaWZ5
IGF0dGVzdGF0aW9uIGZsb3cgZm9yIGFsbCB2ZW5kb3JzLiAgQXMgRXJkZW0gQWt0YXMgbWVudGlv
bmVkIGVhcmxpZXIsICJ0aGUNCj4gPiBudW1iZXIgb2YgQ1BVIHZlbmRvcnMgZm9yIGNvbmZpZGVu
dGlhbCBjb21wdXRpbmcgc2VlbXMgbWFuYWdlYWJsZSIuDQo+IA0KPiBTbyB5b3UgdGhpbmsgdGhh
dCB0aGVyZSBzaG91bGQgYmUgYSBjdXN0b20gdXNlci9rZXJuZWwgYXBpIGZvciBldmVyeQ0KPiBz
aW5nbGUgZGlmZmVyZW50IENQVSB2ZW5kb3I/ICBUaGF0J3Mgbm90IGhvdyBrZXJuZWwgZGV2ZWxv
cG1lbnQgd29ya3MsDQo+IHNvcnJ5LiAgTGV0J3MgdHJ5IHRvIHVuaWZ5IHRoZW0gdG8gbWFrZSBi
b3RoIHRoZSBrZXJuZWwsIGFuZCB1c2Vyc3BhY2UsDQo+IHNhbmUuDQo+IA0KPiBBbmQgRGFuIGlz
IHJpZ2h0LCBpZiB0aGlzIGlzIGhhbmRsaW5nIGtleXMsIHRoZW4gdGhlIGtleSBzdWJzeXN0ZW0g
bmVlZHMNCj4gdG8gYmUgdXNlZCBoZXJlIGluc3RlYWQgb2YgY3VzdG9tIGlvY3Rscy4NCj4gDQoN
ClN1cmUuICBJIGhhdmUgbm8gb2JqZWN0aW9uIHRvIHRoaXMuDQo=

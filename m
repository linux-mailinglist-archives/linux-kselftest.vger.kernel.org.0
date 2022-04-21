Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5448E50AC4F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbiDUXtz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 19:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiDUXtx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 19:49:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56AE3524C;
        Thu, 21 Apr 2022 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650584822; x=1682120822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0dmsFYhUQHQV/j+0NEXoatlRdNJBpPU8fMxvoO4k22w=;
  b=igN+KigRO8P/zKq3rwLBT0jVm75vWmOnrW+Oaae1mUvF1rS6v6AkhmQD
   6yDu4Ne9eD87UGjKUTLzBXew7qKCm8t+NU+GR71Knj5E1fyPl1x1te2bs
   FBEX7ZhQzgvytpmsPKW+WjKGOW76KhWijxL/Xc0tCirjEEyFi/645gCY9
   tHjy8bpEyTvHFHNHsDzoU3TrgXJYnfKIXy3MlajVSrFFM1aNm2Rw5EoF5
   Fqju2mgjOBKwCRilDhnM4mmjYHq2uby22Hp2vn6BLGF/01yYO8xVW74MX
   mNZWPMk1VIkF+x89Lna8ag7qL30w4jZdY2FkJDM/ts695EExZIxMhopqv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350955424"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350955424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="648357542"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 16:47:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 16:47:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 16:47:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 16:47:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 16:47:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwCU/uL7HgVWOrlj++9PjBWuEsLaM7OEKODmfHyv8itQZPMKr4+36XKTBpze1uPMJ4OmjSvFAK7PnjXBMHVzhEG6HSCEqp/N5tomdntPf8woTLlh8pBMRi1GrJMd6YbC7m4fOC2ry02x8eoGUO3uZGQaMqU3ULvsKgu+d6YMJsL2wOjXNVryZ+QqsSGkYIJxd4wV//CoeNrZDsbYGXfOw7PZX3gEMsEtbI3b9z6sIjS289kWgBJDnVdK5WOgW3OmsVRmeCqIMYqdzxnDRUFmiRBeO5kSeXWNt71heWvcfZ8q0yq5graooCjU1YXutW+sE5IGQTx+QhJlP6UkDTR38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dmsFYhUQHQV/j+0NEXoatlRdNJBpPU8fMxvoO4k22w=;
 b=MhFxyj/Eql3Wl7O258FnMHJbfa+LEaFyWjdNyCfD3xTIQh4v7YuUDzxoyj3d5sRTjv4bXvY6jm/PrVsGumzhz6WdstMLd5ZLl3m6jj/4JOhU17fYKte5hYSMrTC6/5TuCTk/gvzxW57TU7IwuQKl2X0br0eRWOYJcWsygsA4meVHKcTDVhjKUn2AL4wgXAx8CKTx+San3nKzlc0GvP1sfdFa/q+5n4lcH1E8/zsqYk29zUn/5FAjJ6d3uIbkvLCBChPU4TAPpviD5SBwP4z4OWZx5R8JlulqKwIPmkRoL33oHV/WOlpHdZSyF3JE3EMuVCriSebTXzNehdWnQJ0lvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 21 Apr 2022 23:46:57 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::14a4:94fa:fcb7:3089]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::14a4:94fa:fcb7:3089%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 23:46:57 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shanahan, Mark" <mark.shanahan@intel.com>
CC:     "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Thread-Topic: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Thread-Index: AQHYT3rxs23shhvg+k2Ofp5Co3ZiHKzvRb4AgABWSQCAAAX2AIAAGVGQgAR87oCABtb/wA==
Date:   Thu, 21 Apr 2022 23:46:57 +0000
Message-ID: <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
         <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
         <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
         <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
         <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
In-Reply-To: <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: mark.shanahan@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8746be5e-01aa-45dc-f2ee-08da23f13910
x-ms-traffictypediagnostic: MW3PR11MB4555:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW3PR11MB4555AE7638865A1140FC554EF6F49@MW3PR11MB4555.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7s5I2T2n2ktEWGNwDIy0BbSRBF8DsojepQouBGgpU1EdpSQPelikHE3RlLapBKT5rD5pQDDHKZor4Oz3RcuqhKIAb0rMoIOQc9x8mE4w1GsmqREuzWmqeT4ufROUA05ZmJMrpEkQEdiP97cgkoK6ABCXl2SpzXP1WWk+nL/rlmCn/loI+8jAsofByBM7D/hiaRqwXcjATC7FBq9sBx3xz/xKP+fMY88vXCOmhqe597PZu+0EcKMo9bM+bMVfRiMAQNzD9kUcY3JYN2SmSGK7LByZwPwl/yXcrCMOzswykdNBCNiMrBmEsKfXp7m0qEMB9Zja0dArJL6Nwn8D7elsOf11nFsc3ZoG8xQR/1wuUQoBoHRFtABZwdYFy0GTh920zu5GFi3os1g9L2AmMFmIL8+HSsvTs/e0SdV86Pf+hqzd7gFqNKwmC762FC5coeW30T/mpLId/+2BIM3EC18l0JCjzGcU7ddUU/tkN5PcrOJZ+RUfjH79At0/2ALhWl0GuYV808M8vKmG0n6MyVe3i+p9K49BWv1yBR8Iaiw/4mcFHJk301PwTPW4IY84gFMvKSlLJGsMvewky8FDjXqGUKZttLBzMXo5IQ2jVUcWbRCH1PzmUmiFRT7CxmOl0pXSloGIjRuXsx1vXJK8BaGg9bZQeF+uLkv4jmYRMfqaUnmZrea+GyTRhtvO0iWc19odgCsQO5m9aSPTJg4WUtt7cq+Pjx6n8V4nmLSX9Gk2Ig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(83380400001)(921005)(508600001)(86362001)(7416002)(5660300002)(9686003)(52536014)(33656002)(38100700002)(38070700005)(316002)(55016003)(7696005)(26005)(6636002)(110136005)(2906002)(82960400001)(71200400001)(8936002)(122000001)(8676002)(66556008)(66476007)(66446008)(4326008)(186003)(54906003)(64756008)(66946007)(76116006)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmNKQk9jSGRjMEU4SUpHdk1rdytuTDRIdTJIRXdSMk0xa1R6ZG9hUndnT3cy?=
 =?utf-8?B?L2FZd1dHdW13WVF0MkNVSUEzY3JVVEo1Q1lPLzFwQm1Nd1VmWklTcVFsUmNH?=
 =?utf-8?B?QlFRMGZhQmZOaDdwQTJYdVlDSURpaGN1MzRvZFdmbUVFcVRveHlSS1o5NFlT?=
 =?utf-8?B?OS9zRWtvTHB3aG5rZWFQVURmYkVDdTdVVHBXMHFkRlhKTDd3MFhJOVlQU3RG?=
 =?utf-8?B?aTRhZjQ2d3kxdDVJL2ZHSVRMOStqNXAvQTBaOVFGKzljSGgrWWVYdjdrK1Qr?=
 =?utf-8?B?NWNxdGFLM3I0aXlYcFNPNzExSGt1VURGNUdKaGNxODBIazdQOEI4TFc4NnFs?=
 =?utf-8?B?RUtFd20wN2pEbWw2eXhsSW9RYkhUNkxWWjNjUTlpSktyVUN2T0lkQ0NXWitI?=
 =?utf-8?B?MWlFSis3VzZCaTNVdmg5OHR3RlViakNPVmxGTFlQNzZyNmhiVnJReFlxUitv?=
 =?utf-8?B?MXcvanFLMERjMWw2SEhvd1I2QmNCbVprdXVLU1dHRVYxVGIrMVNndk9VYkNN?=
 =?utf-8?B?SU40NkhuRVNYSTMyeGs1a2xQMkhnV08rTTBZMC8vbDBRdGQ3OEEwZ2lxSGwx?=
 =?utf-8?B?SVRtdTJJUTFNQ1BVVGpyZXJPQkRKaEhaM2ErbG1VbWFjTmhxS3lXQWFIVitv?=
 =?utf-8?B?eTVESGRVMDFqam1XN1MzK2R1ZkRoYWE3bytrUkx4RnVhbW5BMnBFS0RzOWFl?=
 =?utf-8?B?UElzWHpxYTI5NFZ0elVaT1U1OUdJV1pGWWZ5SEJHSDY0dGdVQmhTS3V6bld5?=
 =?utf-8?B?YnJFT0UyUFFucVFXZE82dHdwd3FaM3A3MnlHYzcydE80OGZyTFVrQ3pNVW5h?=
 =?utf-8?B?UEVZUER5RGlLRExtWVJtRENWYzN4Z0ZqYWNhWXR4MGNpUXQzTHlpb2tGZUtF?=
 =?utf-8?B?MVp1SThKeEpjMFpUanoxeVRiZThXb3pJeVdLVGo3VEFyN2huM0MzYXl4YmR2?=
 =?utf-8?B?TE51NDEyZlFrVUNxRk1pUy9qaUpWL1ZpYitwdVI5RHZwSTFkTUREMmxreXdH?=
 =?utf-8?B?YlFVWGVQT1ZjUTUyano5ZnhqekNnNlgvM0FmSjgxZ3REOUZxd3R5SWt6RWo2?=
 =?utf-8?B?V0hibEFkeU9ReERLam15bVNUWTFDdmw5K08rWHR5SjJwK1JROWZiS2tkVUZJ?=
 =?utf-8?B?bVA5U3NURzdQRG9paGFtNjMxYWJkSnEvd25XNldvaVlVQXNLRDY4WFdXVWx1?=
 =?utf-8?B?R01IcWZ1VkpkekNmSDM2K01waExtR1o4OVZDUE1yYUd0Rk94TE5ic1pZanNQ?=
 =?utf-8?B?bmNaTXV2d1l6a1JBcjFyd2hrYjlhR1lONEtIa0tyczR3d0QwQjJyRXF5N0tV?=
 =?utf-8?B?MlMxb3NoZ0QyV25zMFNaUTNLcWFrNlcyd3pLYXUrNkdGajU5a05BZlRyL2gx?=
 =?utf-8?B?eXllUnR3Z20ycUJKMnhDZnhSWld4T0pKTDhYYzAvQndPbHNaa1VJWWp6ejQ1?=
 =?utf-8?B?eVFlVkpJQnc4dWRHc25QUmt2cmJZRXlmUFNyV1hRYjIwU1lZMDhwYjE4Sk5U?=
 =?utf-8?B?emhjeFR2YWQzWTVqY2cxbm54dEZuaXNJNnRBbnd5aE9QYmhSSTVzclMrbUdv?=
 =?utf-8?B?RE0zbVNBNEpvVytpb3RVWjlWd1NYWW1SdG5Kc3hDMnI5dXJuNXloRW5HcjF1?=
 =?utf-8?B?cEc3T1pGMU1NdjZTc2orWFd2OW9VYnY4czBuWDMxRHB4c3BqempiaXYyNk9G?=
 =?utf-8?B?d00xeWRWVWo4aVM0NXFMZUtLV2ZJcXljeGxtSTF2UGpWTk9SRE9YTmFzamVZ?=
 =?utf-8?B?L0l2MERjVGNWdjcrK2paL0tMSHNvRk9XOHJma1pCYWRVVnpaQkliclBtd2hp?=
 =?utf-8?B?SGJ4YW9OVkJtbUtaQUt3VXd5cnF5SWhxbGhLTnl1TFpSYUZwTkZtbFBFRXpl?=
 =?utf-8?B?OGVhUUJ6VFA4K01ESzU5c3Y3YUZpSlZyN0gwdU9kRW1iYUlISEY2TlNXMk9w?=
 =?utf-8?B?cTN1ejdPa20zeVRDbHNCWmwvV2ZXMUtGMTNLeTZxRXEvVUZSUGxHMU9MRXJE?=
 =?utf-8?B?VmdNc1pxekdIL05VNUJSaGV5VUliRnhDR2dUMERQMzBVOVRqQi9IcHNHZW93?=
 =?utf-8?B?TGNnTktvbjdBTzQrZ3VhWDdZY2N1QUU0a0RkL0FBL0wzYjNPUEVNcnQ5Snha?=
 =?utf-8?B?b2oyb1lIbEg5YXdpWE9GWVJMRkN2UUpuTEUzOFIvcjdSQkRSYzBJZm1DNUpQ?=
 =?utf-8?B?bE1ZM3NFQmJlUkZTWHJZOVI2K3VNaTR0S0FXMHF0VlRYWTg4MXNuYmQxODFy?=
 =?utf-8?B?b2xKRVZTZzhvbTZqUEJ5UVVHYU9rVkEyQlIxNm5YVzJOL1hOdk5WMzVObk5o?=
 =?utf-8?B?b20wQ2RBdG9LdDJUcjZhZEhHRmZjTTZMbWxuMmFKcndxeDlwSXpGQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8746be5e-01aa-45dc-f2ee-08da23f13910
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 23:46:57.7223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnbhWXZt/J7NaPyasLZvm1bci7uTFNyg3GZQBeHJuTAlzjthqWxJzUM8aQRs3EMWRkm0BLmxx+zY37Osgt0ojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4555
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgQWxsLA0KDQpJIGV2YWx1YXRlZCBWNCBwYXRjaCBjaGFuZ2VzIHdpdGggR3JhbWluZSBhbmQg
cmFuIGludG8gYW4gaXNzdWUgd2hlbiB0cnlpbmcgdG8gc2V0IEVQQyBwYWdlIHBlcm1pc3Npb24g
dG8gUFJPVF9OT05FLiBJdCBsb29rcyBsaWtlIHdpdGggVjMgcGF0Y2ggc2VyaWVzIGEgY2hhbmdl
IHdhcyBpbnRyb2R1Y2VkIHdoaWNoIHJlcXVpcmVzIGtlcm5lbCB0byBoYXZlIGF0IGxlYXN0IFIg
cGVybWlzc2lvbiB3aGVuIGNhbGxpbmcgUkVTVFJJQ1QgSU9DVEwuIFRoaXMgY2hhbmdlIHdhcyBk
b25lIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgRVBDTSByZXF1aXJlcyBhdCBsZWFzdCBSIHBl
cm1pc3Npb24gZm9yIEVNT0RQRS9FQUNDRVBUIHRvIHN1Y2NlZWQuIEJ1dCB3aGVuIHRlc3Rpbmcg
d2l0aCBWMiB2ZXJzaW9uLCBFQUNDRVBUIHdvcmtlZCBmaW5lIHdpdGggcGFnZSBwZXJtaXNzaW9u
IHNldCB0byBQUk9UX05PTkUuIA0KDQpUaGFua3MgdG8gQFNoYW5haGFuLCBNYXJrIGZvciBjb25m
aXJtaW5nIHRoYXQgRVBDTSBkb2VzIG5vdCBuZWVkIHRvIGhhdmUgUiB2YWx1ZSB0byBhbGxvdyBF
QUNDRVBUIG9yIEVNT0RQRS4gR2l2ZW4gdGhpcywgY2FuIHdlIHBsZWFzZSByZXZlcnQgdGhpcyBj
aGFuZ2U/DQoNClRoYW5rcywNCi1WaWpheQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1
bmRheSwgQXByaWwgMTcsIDIwMjIgNzo1OCBBTQ0KPiBUbzogRGhhbnJhaiwgVmlqYXkgPHZpamF5
LmRoYW5yYWpAaW50ZWwuY29tPjsgQ2hhdHJlLCBSZWluZXR0ZQ0KPiA8cmVpbmV0dGUuY2hhdHJl
QGludGVsLmNvbT47IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj4gdGdseEBsaW51dHJv
bml4LmRlOyBicEBhbGllbjguZGU7IEx1dG9taXJza2ksIEFuZHkgPGx1dG9Aa2VybmVsLm9yZz47
DQo+IG1pbmdvQHJlZGhhdC5jb207IGxpbnV4LXNneEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJu
ZWwub3JnOw0KPiBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwu
b3JnDQo+IENjOiBDaHJpc3RvcGhlcnNvbiwsIFNlYW4gPHNlYW5qY0Bnb29nbGUuY29tPjsgSHVh
bmcsIEthaQ0KPiA8a2FpLmh1YW5nQGludGVsLmNvbT47IFpoYW5nLCBDYXRoeSA8Y2F0aHkuemhh
bmdAaW50ZWwuY29tPjsgWGluZywNCj4gQ2VkcmljIDxjZWRyaWMueGluZ0BpbnRlbC5jb20+OyBI
dWFuZywgSGFpdGFvIDxoYWl0YW8uaHVhbmdAaW50ZWwuY29tPjsNCj4gU2hhbmFoYW4sIE1hcmsg
PG1hcmsuc2hhbmFoYW5AaW50ZWwuY29tPjsgaHBhQHp5dG9yLmNvbTsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAwMC8zMV0geDg2L3Nn
eCBhbmQgc2VsZnRlc3RzL3NneDogU3VwcG9ydCBTR1gyDQo+IA0KPiBPbiBUaHUsIDIwMjItMDQt
MTQgYXQgMTg6MzUgKzAwMDAsIERoYW5yYWosIFZpamF5IHdyb3RlOg0KPiA+IEhpIEphcmtrbywN
Cj4gPg0KPiA+IEkgYW0gd29ya2luZyBvbiBlbmFibGluZyBHcmFtaW5lIHdpdGggdGhpcyBFRE1N
IHBhdGNoIHNlcmllcy4gSSBoYWQNCj4gPiB0ZXN0ZWQgd2l0aCBWMiBwYXRjaCBzZXJpZXMgYW5k
IGl0IGxvb2tlZCBmaW5lLiBXaWxsIGV2YWx1YXRlIEdyYW1pbmUgd2l0aA0KPiBWNCBwYXRjaCBz
ZXJpZXMgYW5kIHBvc3QgbXkgdXBkYXRlcyBpbiBhIGNvdXBsZSBvZiBkYXlzLg0KPiANCj4gT0ss
IGdvb2QgdG8gaGVhci4gTG9va2luZyBmb3J3YXJkIHRvIGl0Lg0KPiANCj4gQlIsIEphcmtrbw0K

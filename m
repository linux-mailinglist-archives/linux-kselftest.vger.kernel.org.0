Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86326D7293
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 04:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjDECpw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 22:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjDECpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 22:45:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5588840F2;
        Tue,  4 Apr 2023 19:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680662748; x=1712198748;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QiBXzqZcAgEmJVUdgPAgn0FRqme0J/cjDCX/FEpm1Qw=;
  b=dd6reCDaEw4c91XP1x5qjU9k5mq8+h84PPtY6STIHtI3vE2O8v4EiHuj
   ULgHt0PItWPFOqxl9pnDYaDJhvx8cQRv+YPdTxXUNHgDbp1sxLXY/4pc/
   IYwfqhsTbmOzX8DUN2TjL3MjwKZU/L9Gmeiep4qLDgFw5NWTyORI4UlXv
   LYY/qqp25E93aiX3S8wGppfJKe21T0fr05JSlbXiXGOzY6jFjzQktKj9v
   JSO1wYSAX9bbYWbqyirIqt21T27Ob9FAFetwdMD7/pUsZWMpd6DZqVXVn
   F4C4yLQmbPv2Y6LsMDZWwsJpzRuEb3M6QX/MTg/LZKoMIot8syCPgykDz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="330953820"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="330953820"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 19:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="689107687"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="689107687"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 04 Apr 2023 19:45:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 19:45:41 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 19:45:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 19:45:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 19:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3EUd9V0jfU9fAOh5rw80uz+JAoiuAQ85A/ciy7odb8aIJuiEFfQrZsBA2eTcIaxp7iW7/j8+fTdeYO9sa3DzIU6g5+mCDbogNeIsMX6ktPitMFAq+z8j0C6SqG2Ua1AdhbfT3o682KuuLKJIE/u7V/L7VHCaPcs+j4SGAi3By6qosv3dI4FKlXiZWQNin2t+Op0woZKQP3wMOfjboV5u+K0qTshFNU7FILry4jyCD2+gzqc1dGMaSUtxmfXsR1vWob3uGLcXiKPn3hGvg3bIWe6sMlISFKjgzRVVlg+I4e4qA5J/+m4+zwFrVGeBiYq4YTrqRkO9A+Dk+JDDa8gDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiBXzqZcAgEmJVUdgPAgn0FRqme0J/cjDCX/FEpm1Qw=;
 b=AfmPTuctd0IJIhSEJF5gh+xFP1oQ9e5D6bbhaB/oSAPHFnH9H1cEBEKMedTBwLCtanc5jpj+YAZlX7dkbBhmJ3O0+1gjPf+KjHpjqNNpVO+JAr+lxy1TQ4qORK1dubjDhgEqPjdP5y684Y6NHKSbG5ABM6wKFRKPA2ZJJdHYQGN8bxFew24j9e60ptUY/2Yt6kGM+J7A4LjqLxT9sl1LnHuTuRDHRB1aeu4abdzDX32J5euRd6Bgwk8lXOipziP4M/9absxsNSXiS2pNkMDRzs/rLGNrlhr7y3aqRVMLuJYEaEtCqJ6pEjhjj/AYUxaMjRUlKkUAU9jsObTwDr8Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 02:45:34 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::f403:a0a2:e468:c1e9%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 02:45:33 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Du, Fan" <fan.du@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Topic: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Thread-Index: AQHZX6sop/+L0HR+ikaJZEYejVYN468PfV2AgAADagCAABQ0gIAMYE6AgAAcvwA=
Date:   Wed, 5 Apr 2023 02:45:32 +0000
Message-ID: <be6482713dad31bba416d8f5f9c0901051b3c915.camel@intel.com>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20230326062039.341479-2-sathyanarayanan.kuppuswamy@linux.intel.com>
         <3c88945515eba868056906f4a269e6ffcf49e1ec.camel@intel.com>
         <c49727dc-1fe8-2214-07c7-e3be269030af@linux.intel.com>
         <7aeac332d8be1e99d78997638354342dc55dfe8e.camel@intel.com>
         <e90d74cb-3220-e34d-81b4-5a15cdb2eb01@linux.intel.com>
In-Reply-To: <e90d74cb-3220-e34d-81b4-5a15cdb2eb01@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6566:EE_
x-ms-office365-filtering-correlation-id: 80be5481-f102-4ce4-e921-08db357fd386
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COKlZDoiAwjuw/eOT0BUx7V0BAVDgp3UwVeWsqpzHqDznrecPqIgVgCKLZa34AOLjWwdTJjITx9QmWpvbmKLiF2n8ArG3ksWzlw+jaWrRi6oNyRQ+IqkzLG67Ub5KmY5qtr2YvultnG1SV+MhMpmirzcxrs7zWrnAzPE7cplvN5Wc5zwN8vtJVqDIRBIa2MBpi0kSUxdW2mH9hy+e90Bgf3xjpJKbyzPtkdHUiL1tBOvNwM44+EfkhG4cFOCVuV8iHOGXYWbmVVYSO0h8jjcPm8bRHk20Qkph1TP1ZXL3GBkxcg1nUkYijCH5LscTV306o7mWEqvq8rP6UB5lGcLL+fwUkPWsT57VWKgX6qy+XDjfsZVEpIg670QvGPgAvMMmxuqyjsSNrH8GNtiwUWjlxHZ32enzShAFx3C+SV8VZZ5hmF18/nMQLE7SU3CxyPKKQf7IXeF2nNJS4wWUqIh9+/ex5679MAx3xVa4n+/LsRohsBHemn8lfGBsh59bteUWvoGDERkK82Ld98EeJ9WjgANtuNTF5KRDUPHflGqoMY26aYSOGRuVEL0UV6i5FSBGIIkIH/rK4TU3As+BhJHBnFtrkW4PQAkLzIG/Nb/0V8vL4/cA9TNUhWg7gojCQ4WjTALRq7Rpsp0ReEWvSlYSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(4326008)(478600001)(8676002)(66446008)(66946007)(76116006)(66556008)(64756008)(66476007)(54906003)(26005)(53546011)(966005)(6486002)(6506007)(6512007)(86362001)(2616005)(36756003)(186003)(71200400001)(316002)(83380400001)(91956017)(110136005)(7416002)(5660300002)(8936002)(82960400001)(38100700002)(2906002)(122000001)(38070700005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjNjRSsrdTZRditoaDFlbDJvRmt6MXB1OGdKVDlVR0xMcTNVdUNSSUkxWngx?=
 =?utf-8?B?akxPNkZEOU4vUXUxbHJEU0poeFoyZ2FiTVRXaitwQTF2bmNiOFpXV0cyb0dl?=
 =?utf-8?B?MVc2NzlvZ0p4dmFza3E4emU5UzYzVFd3Mm15K0I1UFZCSTgvdHRNK2s4T21C?=
 =?utf-8?B?S0ZMOUxKenpEcHNUUExmZXEyWGs0NWxMNjhoazMraVV4N092VU1OdCtLYndC?=
 =?utf-8?B?eEduNCtncGorM1h4TCs2UjZyZm80aStPK3NnZFVHYmpkK1VQcVRTcCtOTUJU?=
 =?utf-8?B?eEY5QUlpaHhNQW5HZWl3QXhPTVZGUlB4MUJEYyt4NVU2eXFadkhPVlp5b1Ex?=
 =?utf-8?B?Z0Vhako0Y2xNRGFhZkFNam85bzdscW0xSnNrWmYya0VZOHNTZWV5UW1hN2ZI?=
 =?utf-8?B?ZEduYUtzR05FS0dFM1R5WTRNandWaXdJMHJrS0kwS2NaS1F5YXlMNzhBL2tW?=
 =?utf-8?B?cnJpY2M2bVhmOGFoenNVZ1VwRURXdkZWZ2JMQnVpVWlpNDd3RGhMZW1qcFhI?=
 =?utf-8?B?dWdvdnZ4am9VM2hIL2RIOVU3dDQ4Ui8zS0RyVmFpUG5FZ1I1Y01OMW9MeFFo?=
 =?utf-8?B?c21aeDlsM1FOclNGZlcxZ3pvU09vZTNmY0VYSlZhTlk4VFN5bkk0L3JYWmUr?=
 =?utf-8?B?WVY3TXJXeGxWS1VKSFdxalFQUHJFdDhKOVFsZFRqQTUyU0w1MWZWcW1JZmRj?=
 =?utf-8?B?UU9sdEt4Yk1oVm9KaXc4WDlLYnZqTWNmTnlYVUttRnNyOGlJQUQ0UzFHd2dM?=
 =?utf-8?B?b01ScElWeTNRWklzeTVIb2pRRXp5RFpTV0UwZitBNTJsaGY1bEpFQzB6V1pV?=
 =?utf-8?B?TXJWaDU0TGN2OFEyS1RLa0Q2cnAyNU5pVk1RdkM2aGpIMmpJaWdjYXFabmxG?=
 =?utf-8?B?U3p3Z1lFeDZBY0s3V3c4d2hZTnhqY0dKeFd6RHp4RUQyQzJIRU42SGN3NUk2?=
 =?utf-8?B?SHBVVkZ4WXZRQitjdTErSUhYWWRFWGVwV2V0OGdQQStwMGk1VUZTQU5FYnFP?=
 =?utf-8?B?R3NkNVZvOVRMdzRiTGErS2JQWnY0dEVkcXozVWplZ1crQy9IdjRDL29ZTkhz?=
 =?utf-8?B?aU9Yc3c3dnZBM0NxbitPcGFrVE9vQ3BuSTlOL3VhR0FvMzZ2aVlLWloxZ0I2?=
 =?utf-8?B?Nmd2Q2hnSjVoQzlQTWJQTVpybzFMRTg5dldWNlYrV1VBT05kNWE5UkoyZWU3?=
 =?utf-8?B?WXFnYmhkMVZkVUo1RWc3cFhsY01KdXpMV2JaWWRpb1QvSUUzZDJtdk1wUUxV?=
 =?utf-8?B?TlhJbVBoMGlBek50TUVFNU8zM0ZKbzFGR3ZNeUVsdXlIcG9SUUNSNlZ1aTNt?=
 =?utf-8?B?YUo2RWxFSnVmL3UxMzNDN0dqcjBRRVdyNERDV2ROS3N6aXcvOFhlRE1sNUJP?=
 =?utf-8?B?ZUJTUnR2a1FhVlJZT21NejVER3FHTG5OeHpuWGJIZjY2bVlJR0FEQUJyYk9B?=
 =?utf-8?B?eUZjQ1FXOUJhQ0R3ZVhDY2JFcVZSZXdUWDZtb2d5QWhIUkNQTlNMWm9nTlV6?=
 =?utf-8?B?cVlvaUpzSVJZbkJNZm1ZOW1ueWJPbEdPWjJ3M29kNHpkNFJzY1F1K0M1UUxh?=
 =?utf-8?B?RmVpZUV6ckRLeGV3Q2RiMmlDSzZyRHo3b2x3eW9TajhCdlFSMUVkVnBzc3hr?=
 =?utf-8?B?ZnRmVUlJSXFlcHVNano0bENZVnJBTWxjalFoeXhSKzNWTFVhWHU2STd5TDRm?=
 =?utf-8?B?b0RNcVJvWG9jbFQ3ejdiN3lIMlh6L1hFTm5iN1ROcGd2QUQzYng1Y2dEN2o2?=
 =?utf-8?B?eFgyR2Z4UENYSHZOR3p1K29CWDkxc1JqU1gxUDl0NGNBd2JUOEE3SnR6dkdT?=
 =?utf-8?B?YVlZMXVXSmhrVWkvRDB3M0JXZ1BFcTJ6bzI5cEhGd2RBQ0tMQW43VkhqcnZ5?=
 =?utf-8?B?aGY2ZGNrblNDbXAxQ1podHQ0b3VqWXFVbTQwTEVpaHNVMGFxbTBQU3JHZ2xL?=
 =?utf-8?B?OUczV2F2MnJqbXNEYlZ4YVhJck5tU2srVXZuRGdtU09mdDRZMEpOZVd0Z2hl?=
 =?utf-8?B?ZUdIczBMVzBiTEkwcVZOVXJYS0RTbUZ2em1hRWhaem9oWDVDRWJ5VHpnQ3pF?=
 =?utf-8?B?OTBQU0J2TzJCN3Z3d2RmOCtZR1V1QVpVeVhLVGZCb0Jid3NXYWw4SHhwajE3?=
 =?utf-8?Q?J4caaob/Vn7gdwT4vJERMrNKI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24A3A7F550BF88478DA40D11B8AF2508@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80be5481-f102-4ce4-e921-08db357fd386
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 02:45:32.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqbhElN5Rkap541hak8CjrCKmQdc6cwqdZJkh5LCkwYImMe+TocYNmf49ewUQnLnaPfMoSz36/U+sgeSKPtdOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIzLTA0LTA0IGF0IDE4OjAyIC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gDQo+IE9uIDMvMjcvMjMgOTowMiBQTSwgSHVhbmcsIEthaSB3cm90ZToN
Cj4gPiBPbiBNb24sIDIwMjMtMDMtMjcgYXQgMTk6NTAgLTA3MDAsIFNhdGh5YW5hcmF5YW5hbiBL
dXBwdXN3YW15IHdyb3RlOg0KPiA+ID4gSGkgS2FpLA0KPiA+ID4gDQo+ID4gPiBPbiAzLzI3LzIz
IDc6MzggUE0sIEh1YW5nLCBLYWkgd3JvdGU6DQo+ID4gPiA+ID4gKy8qIFJlc2VydmUgYW4gSVJR
IGZyb20geDg2X3ZlY3Rvcl9kb21haW4gZm9yIFREIGV2ZW50IG5vdGlmaWNhdGlvbiAqLw0KPiA+
ID4gPiA+ICtzdGF0aWMgaW50IF9faW5pdCB0ZHhfZXZlbnRfaXJxX2luaXQodm9pZCkNCj4gPiA+
ID4gPiArew0KPiA+ID4gPiA+ICsJc3RydWN0IGlycV9hbGxvY19pbmZvIGluZm87DQo+ID4gPiA+
ID4gKwljcHVtYXNrX3Qgc2F2ZWRfY3B1bWFzazsNCj4gPiA+ID4gPiArCXN0cnVjdCBpcnFfY2Zn
ICpjZmc7DQo+ID4gPiA+ID4gKwlpbnQgY3B1LCBpcnE7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ICsJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX1REWF9HVUVTVCkpDQo+ID4g
PiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJaW5pdF9pcnFfYWxs
b2NfaW5mbygmaW5mbywgTlVMTCk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJLyoNCj4gPiA+
ID4gPiArCSAqIEV2ZW50IG5vdGlmaWNhdGlvbiB2ZWN0b3Igd2lsbCBiZSBkZWxpdmVyZWQgdG8g
dGhlIENQVQ0KPiA+ID4gPiA+ICsJICogaW4gd2hpY2ggVERWTUNBTExfU0VUVVBfTk9USUZZX0lO
VFIgaHlwZXJjYWxsIGlzIHJlcXVlc3RlZC4NCj4gPiA+ID4gPiArCSAqIFNvIHNldCB0aGUgSVJR
IGFmZmluaXR5IHRvIHRoZSBjdXJyZW50IENQVS4NCj4gPiA+ID4gPiArCSAqLw0KPiA+ID4gPiA+
ICsJY3B1ID0gZ2V0X2NwdSgpOw0KPiA+ID4gPiA+ICsJY3B1bWFza19jb3B5KCZzYXZlZF9jcHVt
YXNrLCBjdXJyZW50LT5jcHVzX3B0cik7DQo+ID4gPiA+ID4gKwlpbmZvLm1hc2sgPSBjcHVtYXNr
X29mKGNwdSk7DQo+ID4gPiA+ID4gKwlwdXRfY3B1KCk7DQo+ID4gPiA+IFRoZSAnc2F2ZWRfY3B1
bWFzaycgcmVsYXRlZCBjb2RlIGlzIHVnbHkuICBJZiB5b3UgbW92ZSBwdXRfY3B1KCkgdG8gdGhl
IGVuZCBvZg0KPiA+ID4gPiB0aGlzIGZ1bmN0aW9uLCBJIHRoaW5rIHlvdSBjYW4gcmVtb3ZlIGFs
bCByZWxhdGVkIGNvZGU6DQo+ID4gPiA+IA0KPiA+ID4gPiAJY3B1ID0gZ2V0X2NwdSgpOw0KPiA+
ID4gPiANCj4gPiA+ID4gCS8qDQo+ID4gPiA+IAkgKiBTZXQgQGluZm8tPm1hc2sgdG8gbG9jYWwg
Y3B1IHRvIG1ha2Ugc3VyZSBhIHZhbGlkIHZlY3RvciBpcw0KPiA+ID4gPiAJICogcHJlLWFsbG9j
YXRlZCB3aGVuIFREWCBldmVudCBub3RpZmljYXRpb24gSVJRIGlzIGFsbG9jYXRlZA0KPiA+ID4g
PiAJICogZnJvbSB4ODZfdmVjdG9yX2RvbWFpbi4NCj4gPiA+ID4gCSAqLw0KPiA+ID4gPiAJaW5p
dF9pcnFfYWxsb2NfaW5mbygmaW5mbywgY3B1bWFza19vZihjcHUpKTsNCj4gPiA+ID4gDQo+ID4g
PiA+IAkvLyByZXN0IHN0YWZmOiByZXF1ZXN0X2lycSgpLCBoeXBlcmNhbGwgLi4uDQo+ID4gPiA+
IA0KPiA+ID4gPiAJcHV0X2NwdSgpOw0KPiA+ID4gPiAJDQo+ID4gPiANCj4gPiA+IGluaXRfaXJx
X2FsbG9jX2luZm8oKSBpcyBhIHNsZWVwaW5nIGZ1bmN0aW9uLiBTaW5jZSBnZXRfY3B1KCkgZGlz
YWJsZXMNCj4gPiA+IHByZWVtcHRpb24sIHdlIGNhbm5vdCBjYWxsIHNsZWVwaW5nIGZ1bmN0aW9u
IGFmdGVyIGl0LiBJbml0aWFsbHksIEkNCj4gPiA+IGhhdmUgaW1wbGVtZW50ZWQgaXQgbGlrZSB5
b3UgaGF2ZSBtZW50aW9uZWQuIEhvd2V2ZXIsIEkgZGlzY292ZXJlZCB0aGUNCj4gPiA+IGZvbGxv
d2luZyBlcnJvci4NCj4gPiANCj4gPiBPaCBzb3JyeSBJIGZvcmdvdCB0aGlzLiAgU28gSSB0aGlu
ayB3ZSBzaG91bGQgdXNlIG1pZ3JhdGVfZGlzYWJsZSgpIGluc3RlYWQ6DQo+ID4gDQo+ID4gCW1p
Z3JhdGVfZGlzYWJsZSgpOw0KPiA+IA0KPiA+IAlpbml0X2lycV9hbGxvY19pbmZvKCZpbmZvLCBj
cHVtYXNrX29mKHNtcF9wcm9jZXNzb3JfaWQoKSkpOw0KPiA+IA0KPiA+IAkuLi4NCj4gPiANCj4g
PiAJbWlncmF0ZV9lbmFibGUoKTsNCj4gPiANCj4gPiBPciwgc2hvdWxkIHdlIGp1c3QgdXNlIGVh
cmx5X2luaXRjYWxsKCkgc28gdGhhdCBvbmx5IEJTUCBpcyBydW5uaW5nPyAgSU1ITyBpdCdzDQo+
ID4gT0sgdG8gYWx3YXlzIGFsbG9jYXRlIHRoZSB2ZWN0b3IgZnJvbSBCU1AuDQo+ID4gDQo+ID4g
QW55d2F5LCBlaXRoZXIgd2F5IGlzIGZpbmUgdG8gbWUuDQo+IA0KPiBGaW5hbCB2ZXJzaW9uIGxv
b2tzIGxpa2UgYmVsb3cuIA0KPiANCj4gc3RhdGljIGludCBfX2luaXQgdGR4X2V2ZW50X2lycV9p
bml0KHZvaWQpDQo+IHsNCj4gICAgICAgICBzdHJ1Y3QgaXJxX2FsbG9jX2luZm8gaW5mbzsNCj4g
ICAgICAgICBzdHJ1Y3QgaXJxX2NmZyAqY2ZnOw0KPiAgICAgICAgIGludCBpcnE7DQo+IA0KPiAg
ICAgICAgIGlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9URFhfR1VFU1QpKQ0K
PiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiAgICAgICAgIGluaXRfaXJxX2FsbG9j
X2luZm8oJmluZm8sIE5VTEwpOw0KPiANCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIEV2ZW50
IG5vdGlmaWNhdGlvbiB2ZWN0b3Igd2lsbCBiZSBkZWxpdmVyZWQgdG8gdGhlIENQVQ0KPiAgICAg
ICAgICAqIGluIHdoaWNoIFREVk1DQUxMX1NFVFVQX05PVElGWV9JTlRSIGh5cGVyY2FsbCBpcyBy
ZXF1ZXN0ZWQuDQo+ICAgICAgICAgICogU28gc2V0IHRoZSBJUlEgYWZmaW5pdHkgdG8gdGhlIGN1
cnJlbnQgQ1BVLg0KPiAgICAgICAgICAqLw0KPiAgICAgICAgIGluZm8ubWFzayA9IGNwdW1hc2tf
b2YoMCk7DQo+IA0KPiAgICAgICAgIGlycSA9IGlycV9kb21haW5fYWxsb2NfaXJxcyh4ODZfdmVj
dG9yX2RvbWFpbiwgMSwgY3B1X3RvX25vZGUoMCksICZpbmZvKTsNCj4gICAgICAgICBpZiAoaXJx
IDw9IDApIHsNCj4gICAgICAgICAgICAgICAgIHByX2VycigiRXZlbnQgbm90aWZpY2F0aW9uIElS
USBhbGxvY2F0aW9uIGZhaWxlZCAlZFxuIiwgaXJxKTsNCj4gICAgICAgICAgICAgICAgIHJldHVy
biAtRUlPOw0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgaXJxX3NldF9oYW5kbGVyKGlycSwg
aGFuZGxlX2VkZ2VfaXJxKTsNCj4gDQo+ICAgICAgICAgLyogU2luY2UgdGhlIElSUSBhZmZpbml0
eSBpcyBzZXQsIGl0IGNhbm5vdCBiZSBiYWxhbmNlZCAqLw0KPiAgICAgICAgIGlmIChyZXF1ZXN0
X2lycShpcnEsIHRkeF9ldmVudF9pcnFfaGFuZGxlciwgSVJRRl9OT0JBTEFOQ0lORywNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgInRkeF9ldmVudF9pcnEiLCBOVUxMKSkgew0KPiAgICAgICAg
ICAgICAgICAgcHJfZXJyKCJFdmVudCBub3RpZmljYXRpb24gSVJRIHJlcXVlc3QgZmFpbGVkXG4i
KTsNCj4gICAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfZG9tYWluX2lycXM7DQo+ICAgICAg
ICAgfQ0KPiANCj4gICAgICAgICBjZmcgPSBpcnFfY2ZnKGlycSk7DQo+IA0KPiAgICAgICAgIC8q
DQo+ICAgICAgICAgICogU2luY2UgdGR4X2V2ZW50X2lycV9pbml0KCkgaXMgdHJpZ2dlcmVkIHZp
YSBlYXJseV9pbml0Y2FsbCgpLA0KPiAgICAgICAgICAqIGl0IHdpbGwgY2FsbGVkIGJlZm9yZSBz
ZWNvbmRhcnkgQ1BVcyBicmluZ3VwLiBTaW5jZSB0aGVyZSBpcw0KPiAgICAgICAgICAqIG9ubHkg
b25lIENQVSwgaXQgY29tcGxpZXMgd2l0aCB0aGUgcmVxdWlyZW1lbnQgb2YgZXhlY3V0aW5nDQo+
ICAgICAgICAgICogdGhlIFREVk1DQUxMX1NFVFVQX05PVElGWV9JTlRSIGh5cGVyY2FsbCBvbiB0
aGUgc2FtZSBDUFUgd2hlcmUNCj4gICAgICAgICAgKiB0aGUgSVJRIHZlY3RvciBpcyBhbGxvY2F0
ZWQuDQo+ICAgICAgICAgICoNCj4gICAgICAgICAgKiBSZWdpc3RlciBjYWxsYmFjayB2ZWN0b3Ig
YWRkcmVzcyB3aXRoIFZNTS4gTW9yZSBkZXRhaWxzDQo+ICAgICAgICAgICogYWJvdXQgdGhlIEFC
SSBjYW4gYmUgZm91bmQgaW4gVERYIEd1ZXN0LUhvc3QtQ29tbXVuaWNhdGlvbg0KPiAgICAgICAg
ICAqIEludGVyZmFjZSAoR0hDSSksIHNlYyB0aXRsZWQNCj4gICAgICAgICAgKiAiVERHLlZQLlZN
Q0FMTDxTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0PiIuDQo+ICAgICAgICAgICovDQo+ICAgICAg
ICAgaWYgKF90ZHhfaHlwZXJjYWxsKFREVk1DQUxMX1NFVFVQX05PVElGWV9JTlRSLCBjZmctPnZl
Y3RvciwgMCwgMCwgMCkpIHsNCj4gICAgICAgICAgICAgICAgIHByX2VycigiRXZlbnQgbm90aWZp
Y2F0aW9uIGh5cGVyY2FsbCBmYWlsZWRcbiIpOw0KPiAgICAgICAgICAgICAgICAgZ290byBlcnJf
ZnJlZV9pcnFzOw0KPiAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgdGR4X2V2ZW50X2lycSA9IGly
cTsNCj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBlcnJfZnJlZV9pcnFzOg0KPiAgICAg
ICAgIGZyZWVfaXJxKGlycSwgTlVMTCk7DQo+IGVycl9mcmVlX2RvbWFpbl9pcnFzOg0KPiAgICAg
ICAgIGlycV9kb21haW5fZnJlZV9pcnFzKGlycSwgMSk7DQo+IA0KPiAgICAgICAgIHJldHVybiAt
RUlPOw0KPiB9DQo+IGVhcmx5X2luaXRjYWxsKHRkeF9ldmVudF9pcnFfaW5pdCkNCg0KSSBmb3Vu
ZCB0aGVyZSdzIGFub3RoZXIgc2VyaWVzIGFsc28gZG9pbmcgc2ltaWxhciB0aGluZywgYW5kIGl0
IHNlZW1zIFRob21hcw0Kd2Fzbid0IGhhcHB5IGFib3V0IHVzaW5nIHg4Nl92ZWN0b3JfZG9tYWlu
IGRpcmVjdGx5Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzg3N2N2OTlrMHkuZmZz
QHRnbHgvDQoNCkFuIGFsdGVybmF0aXZlIHdhcyBhbHNvIHBvc3RlZCAoY3JlYXRpbmcgSVJRIGRv
bWFpbiBvbiB0b3Agb2YNCng4Nl92ZWN0b3JfZG9tYWluKToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDIzMDMyODE4MjkzMy5HQTE0MDMwMzJAdm0wMi5ndWVzdC5jb3JwLm1pY3Jv
c29mdC5jb20vDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIG1vbml0b3IgdGhhdCBhbmQgaGVhciBmcm9t
IG90aGVycyBtb3JlLg0K

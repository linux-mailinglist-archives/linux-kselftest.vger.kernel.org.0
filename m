Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119274081D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 04:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjF1CQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 22:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjF1CQv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 22:16:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A3E68;
        Tue, 27 Jun 2023 19:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687918610; x=1719454610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BgbZF1UKWZ/AOmxTlHINtVJ5bCziMuV/w+AzY3qlmEA=;
  b=eh3plLNviSOiCtKQOmmBfD0uoRzIye05TwsOAbQV0TJI1mAaG499ccKy
   28LbLd5/gK+sQWt6By7P3o/UNL8qYezW/xjLckYHrTW/5iwyl/bZ4Ksrn
   dMmUbvMQ7pqZ1RiSidqfNFZfHTE7GW4gjIF776Ryr38HmLzAgtzfMOuhV
   8Co5NK5GsaHy2FmyvIaU/HqHydu8GYjFdfkyRVaO6EWcrfko3grEYMg7b
   8mOU/vgskLIwWO5MQYenPmhKykt/kUU/JrpszK02Wsus7nhDVKcuG33fH
   7WCck5UDPWEKpvqXgzj8vC+5rbKwrH12En6G5kVw7jM2JDadRftt63ONp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="425400756"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="425400756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861324213"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="861324213"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 19:16:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:16:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:16:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:16:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9KlI7GeCikcXK7XZGh54O7cGbYj7O2/1C/C/htffHL0WUe3kZMlE8COBgfKhkUO/v3FvMMi4VcjVx6qsC/17HJPO90OnJ8X/tU/18SfgqRRC3GqJBIsxfPdkJ+yNO/lZXe2nSvRx/PbuxLTE8yjK/2d2Nwvmswr+NhYYpkGzj2RJ9NvD2nvDFRslPfduuVnwNvcO+n9BzWwIUI9Me8UYDg+0lVIqosrqe6FvtjXje8jKSZrEXOBdaWx3DdIiR3Xhc2BoWO5bLm+R87KUtQ4dgHfaEx+woq7ZAYoCC10szlwkdnsieAoDI51j8bvOApq2K05JTM+sq1uf2PCJmWFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgbZF1UKWZ/AOmxTlHINtVJ5bCziMuV/w+AzY3qlmEA=;
 b=j6QymceMyKZu9uClt+R2TrT1bTN8M3Ado4l+hLPxVJMP27fV30kYJYrgDGKFAcAUZI9+p62MWftArJxCR8Lq/lyslNd808rkl2GAmH2cpiqtUq0H87FpaaoKkglKJePRNouKN5COflaoRkDLLIG6vwATRycKUB11RYOwBPOAQo3VDdJeCWCm4QTtVR+8B17KsshU6OZAWjsYNEctlBNBvnLGUN9yEhKsqK+syYi9kKJWjDUMfQNDIsL3/zUo/WgofUDHhZpf7zuzoA3tAoILzU5SRLWZdEk2u/cV5ckr0Wq6A9X9A/8A0K30jbsScOMZQjeTjALhyBvPljpPUtgVhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 02:16:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::19b7:466f:32ac:b764%3]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:16:45 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Du, Fan" <fan.du@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "joey.gouly@arm.com" <joey.gouly@arm.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "atishp@rivosinc.com" <atishp@rivosinc.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Topic: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Thread-Index: AQHZhjUev+9U/9vzEkKqwBILfHYrRq+HtK4AgBGCl4CAA3KQAIABCfuAgAHp14CAABfAgIAAC1WA
Date:   Wed, 28 Jun 2023 02:16:45 +0000
Message-ID: <c85324480053af20e6f0409e28fbc5e156c54143.camel@intel.com>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
         <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
         <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
         <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
         <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
In-Reply-To: <CAAH4kHY1-N+HOxPON6SuXE3QPowAGnwTjc5H=ZnNZwh7a+msnQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 (3.48.2-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CH3PR11MB7345:EE_
x-ms-office365-filtering-correlation-id: ce389ec7-97fc-4247-9bc3-08db777db8de
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXGrNpHzQczs+yrzkJbwtxyQSLQHrRPPL0GBtLAnk2qXT/XvRlhZngZYyqZE4m44yv+DDp9iuVC+dzYkoKqVwGJgxNsHBWWm/sos1g+9uPuPyJyqV/OGS2gWQSTmqxfeGhul2951cskEoIwzdfaG3aP83n7Z9uRjdPehdupHXOzY+w2J7hZQSpOC9h7VwQkATD7exMTlCXwNX1IkTcmkXRb9Am5P7VGy2N/ERREhywEj4zu2hpZRCn6h4/BE4EDX0kbgkpPAMJXfe4Lj9EhMTIVaAHMHgWkXqBDTvlbLD694t6CgrLpSiL1VVlhHEZ1EKDScEWHv7hNAvkxOEQBhbkELBdMEgbS7RHpWBibyWGD86hcUydpwr4t2NaFbsU5tWFoZcvPeHwNYNd7BtKXS5JzjUsnIReyg/uGRJSMRy/h9LsKSVIYLgUXZ21cUFgHZ4NtF19nlCMyS0HcXm+7dmS8fxS4kQn2vN7Ykd7C4mgZBBgedbz8B4egZubde2Kl67g16eLV8pJ+chBozSsrRLjvfP03OG7vlLogjGvGtv5FaA3rvXGX9VcJUIgD2bF/6okJJryMpkLnm/9Jn4DfGUY9Mhts4ii3zjHhDnMDSlA0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(2906002)(186003)(71200400001)(6486002)(122000001)(38100700002)(83380400001)(2616005)(82960400001)(6506007)(6512007)(53546011)(26005)(86362001)(110136005)(38070700005)(54906003)(41300700001)(478600001)(316002)(36756003)(66446008)(4326008)(91956017)(66946007)(76116006)(66556008)(64756008)(66476007)(7416002)(5660300002)(84970400001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2kyY0JLa28ybE1BNHR3YU16ekpONktrMkNlcmJCSFMySnpmeVpiWC9vTi8v?=
 =?utf-8?B?ZktPUVE0L05ubUdOZ3dGRUJ3bEFobGJwM1hTenhRTkxOQlZ5SHpueTVXTVVD?=
 =?utf-8?B?bWNBelB3WFNaZFowU09ZU0dKaktodEVGUmVzN2czM0JORE03RjZpSlNRbm9j?=
 =?utf-8?B?VDJEKzM1dVlqSXlxbkx4c21iVzQ5cGg5bVBraTcrSXhoejVJdUIrVEJDeUtv?=
 =?utf-8?B?Q1N4VXFTSU55bzA1YmNMck9UT2tzVXdSd3puR1IwdXIyVXYwUFpEdUVKSDNq?=
 =?utf-8?B?Z2tmOEQxTEtsb2U0ZlRzaDg2NmlkNHNtS1dJNGJMcjZzendxU1R5dTdSWGFN?=
 =?utf-8?B?UlRTNFhBNWZUOCtmU29VZUpmRTlzNUxuc0k4L21uNmZ0NStrQlV6dkg3aXN4?=
 =?utf-8?B?OGo1TjRBa3Q5RS8zNTlaNmRxeXFxWTdtUCtUU2VJQi9zTXRnZ2ZFWkphSld4?=
 =?utf-8?B?VWVpZDBsK1VyZy91YWNIU0d2WDJiNkRqUGhkbXJoZkxqeXlMK09iNDZvYkV6?=
 =?utf-8?B?SzFUS0FIS1RYMXN5SXdWbFFDRnpEUGRaOVBzS3dqd0VqV1NLVHE1ZVNna1R3?=
 =?utf-8?B?RENsV2NHbnZFS1VuRU1EQWdnc3F1MExqRk1HOXNGc1RtVlZ0Nk5tMTRDcUpJ?=
 =?utf-8?B?dWpoRE8xQUtmcEl5S1FBSGJqdnM3eURzcXlpWDU0d3ZaWE9hc1ZuSVo3a2J1?=
 =?utf-8?B?SkJla05FaHVJczVCeXNjRndzampGUmY0RkV4K1MvZU9wSzJOcUVHTUF5TE9q?=
 =?utf-8?B?TEt0a3NPQ3ZlYWVYL2cvL09xMmRYcEh2ZE5HQUNNQUJJOFIwbEFyNVZoR2h6?=
 =?utf-8?B?c0N6ZlNZRVg1cEoxZ2ZCWTVLMTRNWk9lRGg3QnpaaVBWWDNNU1J6Q2tUK2hP?=
 =?utf-8?B?d1VYejNaQXNHNytqUDcxaC9HR1d0Z2x2bW5HY29DNExObmw4SW1Da1VzNTBF?=
 =?utf-8?B?WElEdVMwUUhEaERVTXhEUmNpam5LcjdmalFRMFJRM2g0UlU4WjI3V0JzWHZP?=
 =?utf-8?B?eFBjWlB4WENoQ1B4Y3hyQjRKOTFUR3kwSW1XSzBOcUl4OW9uSkFHTER4NWt2?=
 =?utf-8?B?SkZtNVd3MDc3a3RMdk5vSW1sR1c3bHQ3eVZ1b25xM3RtcUE3b0ZhR2l5Q3Qy?=
 =?utf-8?B?T1FSejJIc1hmWThKMnY3K1IwdGRmMVB6NERBb1locWdvRHNVbFAvdVF0RmRE?=
 =?utf-8?B?WVVCWm94RkxqZ2xrRmRhUDFYQk1UTmczKzlNc01CSm9CRzgwSjFKOE0xVkQz?=
 =?utf-8?B?T2xZU2ZNRXRBbE83dHc1aHZjSzk4eGRXdnJ0ZnRhSFEwN1U1Z1pUTmpWaU9O?=
 =?utf-8?B?aUNCeXQxN3VSQlRuZkZuVU9ORVhONjdnMkU1WVJXTjFCa24zTEdjNk85Q0px?=
 =?utf-8?B?L1hBWVJLUXJ5QnZZcjFhbSt1amh0TWFmdjdZeXpUeENvcm1Cdmk3dE55d0FH?=
 =?utf-8?B?NFFVK29wYWlrbWIvU1dCWFFVQkxzcWlPZGVQMGdSSFcxWUI1MXR4V0s0V3Jo?=
 =?utf-8?B?TGhITVpUT3NhRGRtTVRoeHNzQUUvb253OVROZnZ6NHoxSDRPK1VVSHV0TExR?=
 =?utf-8?B?OE9qZjlpQnljeGF6K3ZHdjAwVEpUV0k4S3RPQnA4VUx3azBVdWhuTm44enBC?=
 =?utf-8?B?RlVTaFQ0cTdkcVJTVkdnRHE2T3FSOEJVei9rWGRzNWs2U2N6SFo4c2JWclVS?=
 =?utf-8?B?d2E2Qyt4VUFOdVprRS9vOSszMEZXMDhXbEFoYUwxamxkNnJqbHhmWmlvWEVV?=
 =?utf-8?B?a3ZMRzBwUkRXcnJSN09ES2R1eXNJNlpJQXd2cTNkVW94dTZldm4vdWFPNWEv?=
 =?utf-8?B?eUJ3WHBEaGVBb3JkRVBhbnZsOVl5MjBGcnZGT1cwRkVYREltN08yZnRNbnAw?=
 =?utf-8?B?bnZmMG5lYTJ2Rlp4YjMvWmUwKzBIQk1WZnRMMVNFOWZjZ0kyeWJodkgwaVRY?=
 =?utf-8?B?YVRNMThPN2pLZWVLWTJrakdYWkdmUG9ocWhQb01GOUdmNTFDU1ltTi9WcTRJ?=
 =?utf-8?B?bTd4MUJwRUtoblBJVnBnUWh1eEVNMWJndGN0Qklka2ltd3JhU0U2bFhSRG44?=
 =?utf-8?B?M1RTZjR5OGNsY0tYeVVCaGRpUlVGSG9vbFkzbGtKb29ISnE1QkdLMkpscFNq?=
 =?utf-8?B?cGIraGpyTXd0bmg3THdJVzFQT0xVS0tMRlp0aTRuMTlZQkgrRnhlWThBbDRK?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CDB2DF5C6E2A14A8A1C16E9762B5ABE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce389ec7-97fc-4247-9bc3-08db777db8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 02:16:45.9206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyqbnyeVl+0fXYEbb8v7Nd4uDd4fMsSI/xKKc34+mjHqprEEsmczEXSOhULlGhrhTIh8H6dU0Yr+A/ZwyBr0qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTI3IGF0IDE4OjM2IC0wNzAwLCBEaW9ubmEgQW1hbGllIEdsYXplIHdy
b3RlOg0KPiBPbiBUdWUsIEp1biAyNywgMjAyMyBhdCA1OjEz4oCvUE0gRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IFsuLl0NCj4gPiA+IA0KPiA+ID4g
VGhlIFZNUEwtYmFzZWQgc2VwYXJhdGlvbiB0aGF0IHdpbGwgaG91c2UgdGhlIHN1cGVydmlzb3Ig
bW9kdWxlIGtub3duDQo+ID4gPiBhcyBTVlNNIGNhbiBoYXZlIHByb3RvY29scyB0aGF0IGltcGxl
bWVudCBhIFRQTSBjb21tYW5kIGludGVyZmFjZSwgb3INCj4gPiA+IGFuIFJUTVItZXh0ZW5zaW9u
IGludGVyZmFjZSwgYW5kIHdpbGwgYWxzbyBuZWVkIHRvIGhhdmUgYW4NCj4gPiA+IFNWU00tc3Bl
Y2lmaWMgcHJvdG9jb2wgYXR0ZXN0YXRpb24gcmVwb3J0IGZvcm1hdCB0byBrZWVwIHRoZSBzZWN1
cmUNCj4gPiA+IGNoYWluIG9mIGN1c3RvZHkgYXBwYXJlbnQuIFdlJ2QgaGF2ZSBkaWZmZXJlbnQg
Zm9ybWF0cyBhbmQgcHJvdG9jb2xzDQo+ID4gPiBpbiB0aGUga2VybmVsLCBhdCBsZWFzdCwgdG8g
c3BlYWsgdG8gZWFjaCB0ZWNobm9sb2d5Lg0KPiA+IA0KPiA+IFRoYXQncyB3aGVyZSBJIGhvcGUg
dGhlIGxpbmUgY2FuIGJlIGRyYXduLCBpLmUuIHRoYXQgYWxsIG9mIHRoaXMgdmVuZG9yDQo+ID4g
ZGlmZmVyZW50aWF0aW9uIHJlYWxseSBvbmx5IG1hdHRlcnMgaW5zaWRlIHRoZSBrZXJuZWwgaW4g
dGhlIGVuZC4NCj4gPiANCj4gPiA+IEknbSBub3Qgc3VyZSBpdCdzIHdvcnRoIHRoZSB0cm91Ymxl
IG9mIHBhcGVyaW5nIG92ZXIgYWxsIHRoZS4uLiAzLTQNCj4gPiA+IHRlY2hub2xvZ2llcyB3aXRo
IHNpbWlsYXIgYnV0IHN0aWxsIHdlaXJkbHkgZGlmZmVyZW50IGZvcm1hdHMgYW5kIHdheXMNCj4g
PiA+IG9mIGRvaW5nIHRoaW5ncyB3aXRoIGFuIGFic3RyYWN0ZWQgYXR0ZXN0YXRpb24gQUJJLCBl
c3BlY2lhbGx5IHNpbmNlDQo+ID4gPiB0aGUgb3V0cHV0IGFsbCBoYXMgdG8gYmUgaW50ZXJwcmV0
ZWQgaW4gYW4gYXJjaGl0ZWN0dXJlLXNwZWNpZmljIHdheQ0KPiA+ID4gYW55d2F5Lg0KPiA+IA0K
PiA+IFRoaXMgaXMgd2hlcmUgSSBuZWVkIGhlbHAuIENhbiB5b3UgaWRlbnRpZnkgd2hlcmUgdGhl
IGZvbGxvd2luZw0KPiA+IGFzc2VydGlvbiBmYWxscyBvdmVyOg0KPiA+IA0KPiA+ICJUaGUgbWlu
aW11bSB2aWFibGUga2V5LXNlcnZlciBpcyBvbmUgdGhhdCBjYW4gZ2VuZXJpY2FsbHkgdmFsaWRh
dGUgYQ0KPiA+IGJsb2Igd2l0aCBhbiBFQ0RTQSBzaWduYXR1cmUiLg0KPiA+IA0KPiA+IEkuZS4g
dGhlIGZhY3QgdGhhdCBTRVYgYW5kIFREWCBzZW5kIGRpZmZlcmVudCBsZW5ndGggYmxvYnMgaXMg
bGVzcw0KPiA+IGltcG9ydGFudCB0aGFuIHZhbGlkYXRpbmcgdGhhdCBzaWduYXR1cmUuDQo+ID4g
DQo+ID4gSWYgaXQgaXMgYWx3YXlzIHRoZSBjYXNlIHRoYXQgc3BlY2lmaWMgZmllbGRzIGluIHRo
ZSBibG9iIG5lZWQgdG8gYmUNCj4gPiBkZWNvZGVkIHRoZW4geWVzLCB0aGF0IHdlYWtlbnMgdGhl
IGFzc2VydGlvbi4gSG93ZXZlciwgbWF5YmUgdGhhdCBtZWFucw0KPiA+IHRoYXQga2VybmVsIGNv
ZGUgcGFyc2VzIHRoZSBibG9iIGFuZCBjb252ZXlzIHRoYXQgcGFyc2VkIGluZm8gYWxvbmcgd2l0
aA0KPiA+IHZlbmRvciBhdHRlc3RhdGlvbiBwYXlsb2FkIGFsbCBzaWduZWQgYnkgYSBMaW51eCBr
ZXkuIEkuZS4gc3RpbGwgYWxsb3cNCj4gPiBmb3IgYSB1bmlmaWVkIG91dHB1dCBmb3JtYXQgKyBz
aWduZWQgdmVuZG9yIGJsb2IgYW5kIHByb3ZpZGUgYSBwYXRoIHRvDQo+ID4ga2VlcCBhbGwgdGhl
IHZlbmRvciBzcGVjaWZpYyBoYW5kbGluZyBpbnRlcm5hbCB0byB0aGUga2VybmVsLg0KPiA+IA0K
PiANCj4gQWxsIHRoZSBzcGVjaWZpYyBmaWVsZHMgb2YgdGhlIGJsb2IgaGF2ZSB0byBiZSBkZWNv
ZGVkIGFuZCBzdWJqZWN0ZWQNCj4gdG8gYW4gYWNjZXB0YW5jZSBwb2xpY3kuIFRoYXQgcG9saWN5
IHdpbGwgbW9zdCBhbHdheXMgYmUgZGlmZmVyZW50DQo+IGFjcm9zcyBkaWZmZXJlbnQgcGxhdGZv
cm1zIGFuZCBWTSBvd25lcnMuIEkgd3JvdGUgYWxsIG9mDQo+IGdpdGh1Yi5jb20vZ29vZ2xlL2dv
LXNldi1ndWVzdCwgaW5jbHVkaW5nIHRoZSB2ZXJpZmljYXRpb24gYW5kDQo+IHZhbGlkYXRpb24g
bG9naWMsIGFuZCBpdCdzIGdvaW5nIHRvIGdldCBtb3JlIGNvbXBsaWNhdGVkLCBhbmQgdGhlDQo+
IHNvdXJjZXMgb2YgdGhlIGRhdGEgdGhhdCBwcm92aWRlIHZhbGlkYXRvcnMgd2l0aCBub3Rpb25z
IG9mIHdoYXQNCj4gdmFsdWVzIGNhbiBiZSB0cnVzdGVkIHdpbGwgYmUgdmFyaWVkLiBUaGUgZm9y
bWF0cyBhcmUgbm90DQo+IHN0YW5kYXJkaXplZC4gVGhlIENvbmZpZGVudGlhbCBDb21wdXRpbmcg
Q29uc29ydGl1bSBzaG91bGQgYmUgd29ya2luZw0KPiB0b3dhcmQgdGhhdCwgYnV0IGl0J3MgYSBz
bG93IHByb2Nlc3MuIFRoZXJlJ3MgSUVURiBSQVRTLiBUaGVyZSdzDQo+IGluLXRvdG8uaW8gYXR0
ZXN0YXRpb25zLiBUaGVyZSdzIEF6dXJlJ3MgSldUIHRoaW5nLiBUaGVyZSdzIGEgc2lnbmVkDQo+
IHNlcmlhbGl6ZWQgcHJvdG9jb2wgYnVmZmVyIHRoYXQgSSd2ZSBkZWNpZGVkIGlzIHdoYXQgR29v
Z2xlIGlzIGdvaW5nDQo+IHRvIHByb2R1Y2Ugd2hpbGUgd2UgZmlndXJlIG91dCBhbGwgdGhlICJy
aWdodCIgZm9ybWF0cyB0byB1c2UuIFRoZXJlDQo+IHdpbGwgYmUgZmFjdGlvbnMgYW5kIGFic29s
dXRlIGdyaWRsb2NrIGZvciBtdWx0aXBsZSB5ZWFycyBpZiB3ZQ0KPiByZXF1aXJlIHNvbGlkaWZ5
aW5nIGFuIGFic3RyYWN0aW9uIGZvciB0aGUga2VybmVsIHRvIG1hbmFnZSBhbGwgdGhpcw0KPiBs
b2dpYyBiZWZvcmUgcGFzc2luZyBhIHJlcG9ydCBvbiB0byB1c2VyIHNwYWNlLg0KPiANCj4gTm93
LCBub3Qgb25seSBhcmUgdGhlIGZpZWxkIGNvbnRlbnRzIGltcG9ydGFudCwgdGhlIGNlcnRpZmlj
YXRlcyBvZg0KPiB0aGUga2V5cyB0aGF0IHNpZ25lZCB0aGUgcmVwb3J0IGFyZSBpbXBvcnRhbnQu
IEVhY2ggcGxhdGZvcm0gaGFzIGl0cw0KPiBvd24gc3BlY2lhbCB4NTA5djMgZXh0ZW5zaW9ucyBh
bmQga2V5IGhpZXJhcmNoeSB0byBleHByZXNzIHdoYXQgcGFydHMNCj4gb2YgdGhlIHJlcG9ydCBz
aG91bGQgYmUgd2hhdCB2YWx1ZSBpZiBzaWduZWQgYnkgdGhpcyBrZXksIGFuZCBpbiBURFgncw0K
PiBjYXNlIHRoZXJlIGFyZSBleHRyYSBlbmRwb2ludHMgdGhhdCB5b3UgbmVlZCB0byBxdWVyeSB0
byBkZXRlcm1pbmUgaWYNCj4gdGhlcmUncyBhbiBhY3RpdmUgQ1ZFIG9uIHRoZSBhc3NvY2lhdGVk
IFRDQiB2ZXJzaW9uLiBUaGlzIGlzIGhvdyB0aGV5DQo+IGF2b2lkIGFkZGluZyBldmVyeSBjcHUn
cyBrZXkgdG8gdGhlIGxlYWYgY2VydGlmaWNhdGUncyBDUkwuDQo+IA0KPiBZb3UgcmVhbGx5IHNo
b3VsZG4ndCBiZSBwdXR0aW5nIGF0dGVzdGF0aW9uIHZhbGlkYXRpb24gbG9naWMgaW4gdGhlDQo+
IGtlcm5lbC4NCg0KQWdyZWVkLiAgVGhlIGRhdGEgYmxvYiBmb3IgcmVtb3RlIHZlcmlmaWNhdGlv
biBzaG91bGQgYmUganVzdCBzb21lIGRhdGEgYmxvYiB0bw0KdGhlIGtlcm5lbC4gIEkgdGhpbmsg
dGhlIGtlcm5lbCBzaG91bGRuJ3QgZXZlbiB0cnkgdG8gdW5kZXJzdGFuZCB0aGUgZGF0YSBibG9i
DQppcyBmb3Igd2hpY2ggYXJjaGl0ZWN0dXJlLiAgRnJvbSB0aGUga2VybmVsJ3MgcGVyc3BlY3Rp
dmUsIGl0IHNob3VsZCBiZSBqdXN0DQpzb21lIGRhdGEgYmxvYiB0aGF0IHRoZSBrZXJuZWwgZ2V0
cyBmcm9tIGhhcmR3YXJlL2Zpcm13YXJlIG9yIHdoYXRldmVyIGVtYmVkZGVkDQppbiB0aGUgcm9v
dC1vZi10cnVzdCBpbiB0aGUgaGFyZHdhcmUgYWZ0ZXIgdGFraW5nIHNvbWUgaW5wdXQgZnJvbSB1
c3JzcGFjZSBmb3INCnRoZSB1bmlxdWUgaWRlbnRpdHkgb2YgdGhlIGJsb2IgdGhhdCBjYW4gYmUg
dXNlZCB0bywgZS5nLiwgbWl0aWdhdGUgcmVwbGF5LQ0KYXR0YWNrLCBldGMuDQo=

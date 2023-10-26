Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17447D8C3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 01:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJZXdK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 19:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJZXdI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 19:33:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE91BE;
        Thu, 26 Oct 2023 16:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698363187; x=1729899187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SBnJOtFvWJSdmAHcJxdu/uE34snxCc4huZD9D3YY/5I=;
  b=RCYAVhUAuyMdIgXSh7u6FRjLJRSLmC5cchMQo3DkBlvpQTwuVuFVBr0b
   fIeVp+l/aAmC/k+yyFMNsa54ysmqSYkVK5IINArVjKCeWFfGEg5SbtqPt
   UF37s7ErgPHY0C1G9dZd/MfV2JbUFoRVx1JkkOUYM4qtzdx42QAnG1Xlc
   Jx/SY+RJUhgkmN8ahY2DGE63rsYPMx7IN6+bmLFP9GZwcueUvEYjuNkHR
   D98sTHHszRjXaLEmg6c0iM4MUX4mBkB4vZ53t9ZUp56HzJYTo3FByI8oP
   HpTeLzhE9C7ybHOxgmliDznPY/OW18or9kctgq5R8pX0xV9GqPAR9ilGA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="6299865"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="6299865"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="829792013"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="829792013"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:33:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:33:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:33:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imodfNyOIPgBWpLosPOXOv3iEezkWo51BfxqmpCK9GqjIFfDAPMQuGSoIUxvdwXpHhALU0a+NMFwso7A04lKhf8LHgfnEwK1Ng+9GNAAGWaC0js32ZGMcITH+aU4l+7wzCCfiM0pIUM7SMPBaB6flll06nMrJOSS2C1cz8APvixjJxsveSo6Ky7d+vUh3CLPC/BGb7fRPVDiUMcbgzN3v9nqDg5NH5CNz8FtJ+pGtjCBc3C7GxdLRD/tUidZ2YtYNU5HF34Xji/ufkNeUk4EtvlykfjXcbNtAz/kw3ZU+sx0EE+gcvqh7x6v1/dCKCsBNgBI5jQGewOaiu68VisqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBnJOtFvWJSdmAHcJxdu/uE34snxCc4huZD9D3YY/5I=;
 b=lD1EPgyTGehudTdie14UpWJA9hvSl/NjQE/HTpevkJFFsfTg2uRzW/c1nHeee70ZVBCqlbkbkFnm4FrtEuwszW3rGvVSWyoJBQvCrI2BTv2+O83+w01OcJJ1sI8oyygxlNRhxPa+XgNreC3eW7YlZMN719jjn3lGGrVnAvg/+z7+xqHeixbsedAvBHvsM0hv2IajSlKnAu09Rq1wqCP25XLSU4hBvOgjU16TJ0hc88jKNG5qQ4OkjUmEjqX6OCvFnLYk3HeFZsQK0CixFQsoFSa1svXXq+QbUT/iVCn7A3gikD/27EUZ+5g9BLkak98+qvi3Tcam7Y7z8i8CJKitwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 23:32:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::4d44:dbfa:a7b4:b7c1%4]) with mapi id 15.20.6907.028; Thu, 26 Oct 2023
 23:32:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Thread-Index: AQHaBbRTBvR+3Qu63E+MwFOmoT8P7rBXkZMAgAAhcgCABKBHAIAAC/yAgAAupoCAADAgAA==
Date:   Thu, 26 Oct 2023 23:32:51 +0000
Message-ID: <22bbdd904da3673797fe8593cf47f7cd8ff54ea2.camel@intel.com>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
         <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
         <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
         <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
         <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
         <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
         <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
In-Reply-To: <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ2PR11MB7475:EE_
x-ms-office365-filtering-correlation-id: b5a8ec98-5755-4585-8275-08dbd67bdedc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDZcniqvAPr4r3gqqBKbwWCBLVmRxQVaJyoG1lncMl6lg1Lfkf9suuykM/VEtsvDHTYC+0QR85dfQt2jjFzMant1XOB/vCmbA8zSnoDypGUuSvufih58MvO0mCIzy6uas64HVm+Z/eInzS0scXPeIAkOOW9dfnI+AegZS86FSGMV4BRSDfibqZCjISJa0eFMXNPRxj7JfIjlElomXlAPOlFFNeLc4fOlfrpUjH6ZLGdHvnGZIVCVVpYhcX4DEnPcvoEezi0omi5I9XTT8WxbDRNxpPq3CGvJXeN56A4Eja+YyHxQ+7cVpjOZDWcU25FVz0JdOGxSnynMCEk6uGWfnlLhLd9gmTjEf7N73+reK99O0e2L70K477oBJzYSV86Mfg9CaSbs1Il/n/QZSibnvBVEXq5N2guyvyq7DGfvL0VaIC61WnJQHB6rPmndInNBeBTIViJIzcG+3ITabHutij/3wr8bWu8tvz1KDCVc6QWXWfttAjF0F6arzLZ3EUa/AHULaxdbtZTZoC6dE7azauqPuZjF0FSkVYDRgxJlbq1cX2FpwdkS8oDeMLk3z5Y6oAlZi25QaMMFYNflFgwWwwGoziBaRV8Zmwu2bCvFQsg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(41300700001)(8936002)(4326008)(8676002)(38070700009)(7416002)(4001150100001)(4744005)(2906002)(5660300002)(6512007)(83380400001)(6506007)(71200400001)(36756003)(122000001)(2616005)(38100700002)(82960400001)(86362001)(26005)(316002)(478600001)(6486002)(54906003)(66946007)(66556008)(66476007)(91956017)(110136005)(64756008)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bit1bk5xWkY3bkUzQktBdzZ6QjJlSWtkL0dVRnRpa1dkWjFvUWNrK3hWZk5N?=
 =?utf-8?B?VCtjUnJkcEROTis2WUlCYmJ1UjRFN1lTRis1ekc2U0FLbWdJSlFINHdDZys3?=
 =?utf-8?B?M3VDa2Q0T3hBOGZIdW5zaG0zRVhyc2djcmJaS1UwWnZkUkNtRFpQVlUyOG53?=
 =?utf-8?B?V3hCMGhKUzdjeGxTODNodWhIYzlocUUvcWl2aFA2dmtvaEtTbnRWZjFEbE9I?=
 =?utf-8?B?R0x5UTArMEE2TG41UktRYUsyRTB1Zkd4VTczWjhKY1ZoZ2lLR2YyUjdHWTRG?=
 =?utf-8?B?cERVSlpoUDJMR3RFRXFIRkZnZDFZb2VtTXJ3ZFVGTjNEVU5Ga012cmcyZUVo?=
 =?utf-8?B?THY4b3BwQjFJdVRrTlVLZ1R6U3FBWlJ3ZTVzSG0zYncyMEc2OEt3UC9LRFJG?=
 =?utf-8?B?RTUzemdmSmFoRzJJMjYxUXVRZlIrOFFGaDc3bURVNUt6Z1hDNkdtWk4xL1JJ?=
 =?utf-8?B?dkdhWXlIUFNsRUtCQy94ekF2c0MvNzFQSUZCZjEwRlNZQmlqZCs4TGNHZTBl?=
 =?utf-8?B?NTgwTmd1RWFQb0ZSemUvVENmQzNFOGFaYzgxTXJnb1ZUbmVxYVM4aHJaUnA1?=
 =?utf-8?B?MlNQOGV5UEpyN2IxMUtEWDBwdjR0Mnd4eGRnd3pHREU1VnBXNmhpTnpITzFL?=
 =?utf-8?B?MmRRMHNSZE1DcnpSV1F4d0hrcEVjZG5ZT0VzbUg3Nkt4Vm5DcFFqWFlOV1hn?=
 =?utf-8?B?cWFFaEtNYkNIV0tTU3hOenJWNzRGeWE1SjgwblpJbmVXNURsTDBhaXYxUEpM?=
 =?utf-8?B?eHR1UjZzQStuU29ETUZUTFA5emg4YjBwYkxOWmtCbDFTQTdRalB5OXNuR2RD?=
 =?utf-8?B?TXpvejNPK09DNTBNbHM4cWNOTUdnTXZyalZuVVJLZklCNUZicnlkSm9mUy9D?=
 =?utf-8?B?UC8wRk9qdzg5Ny8rcXNXVHlsbkZvWnZyU2pRVWI0TmNmZktTR0lSTlh1NmdV?=
 =?utf-8?B?ako4cFdwN0NSK1VsdEFlNzh5MWNPTitOb050dnc2RWJiQzFCaXNCNUtKaDZm?=
 =?utf-8?B?Sks0Smx5MysyQ0FvNGdpZDlnaUZBWU9yaEkxOFNQTkJVUmI0a2w3eFQweExw?=
 =?utf-8?B?bXVJSjNHNmZMazlDd3Z1R2hqamdKK3R1ckxXYmJWQ0Q2UWIrOWloeHF1eFZt?=
 =?utf-8?B?Mmd4Uk1PTXFxVlpYTFBXSmhjcmM2YzNXODJCVkREQTR5dlZGYWo4K3Bqb1NG?=
 =?utf-8?B?Y1lrY1NraXp4OGdZYk5qcCtRc0grVUMrSGdPZjBQUEg0bE9keGI5RldJYkNa?=
 =?utf-8?B?UDl1cUNaVE5OanZ1c2J1SjV0Vll3cnh3aFJXeElnZjJrVnU2RlIrN0xHOTBk?=
 =?utf-8?B?MldKVktYN1JleHI5cEMzb1VNbW9mMWxjKzJudXc0RDM0QWtXbTFvSkhYV0w1?=
 =?utf-8?B?eWYwUGVFNWs5ZkZsaEVVdHFhNHBKQVgvTGFqNlNvcmI1WjdVd25wV3BRdmU3?=
 =?utf-8?B?ZkUxVE9DMjBNbGp5enBmRHY1Nk5zR3hiWFZaL004MUh0NEFZeDcyU1FTTE9F?=
 =?utf-8?B?TTkwaHdoK0V1SUpEN1JMSExlR0hMcVNZTUpHS1A1MW1IMFErSUJpREpETlI3?=
 =?utf-8?B?VU1xczVLL25PdjZ2bVZJMVl6MDZ5RW93am5pZW9QRng3MTJKMHJvS3dQRG9Q?=
 =?utf-8?B?eWZXbDEzT0tqOXBYNHQvd3hMd1pKYmJ2TTd4d01PRjJYWGNOMCt6L2NsMG5p?=
 =?utf-8?B?M2wvSXpCbmNTS1JPOTFKcFd0TFlmWWcwVU5JSm5kQnVHRGQrM1ppdWxVRTlB?=
 =?utf-8?B?bVlXSGJXUDhQTXFCRHpyTHI4U24zUmErRHFHSkZrdzk3aVhsaTNkRkdGN1dr?=
 =?utf-8?B?MURLdjYvZlU4R3BhNlNCSWZJVmk3WWF3OUlVWE5mK0tYNTUwU2tXL2pXR1cx?=
 =?utf-8?B?ZVFoNUZYbEVTdTd1WlR0S0xCb0tYMDZEbVFDZWNWQ1BpNzFpaHFqVUNoUURT?=
 =?utf-8?B?N2FXbGNPZ2U0UHd1dzNEZmZCWmE5M3ZwRjdFcG4vaU5BQTVPN2hUNno1eXk0?=
 =?utf-8?B?KzdOcHZDMFlOd3pwS1A0dGFVNytCaFM2cnRZVVoxVTVDbXZoakgwem13WGFq?=
 =?utf-8?B?ay9rYnAzU1djK2dDeVE2dm5mN2NDNU9kNlI2QWptRWZucTAwTGJmckEyV3hp?=
 =?utf-8?B?QTdKZkJQYVRQb1dDYXBnSitYY2Z3NXVocHdBbjBTTE1qNUJaU2ZqTGJXbkpQ?=
 =?utf-8?Q?x8gmKk3xogCS7tbACR3wxME=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADB583182FAECA47A378822C7A50922E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a8ec98-5755-4585-8275-08dbd67bdedc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 23:32:51.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7rQmCiT4e/IWOcPfxyopTFzMS2M6mhE35X4WGmkQ8/hgN8Ys0jv3Ozj+jHJ6hsoIIizBiu3XKuGOM8rxvCKnnEdR+1fPuAKTZaDnSF7pWc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDEzOjQwIC0wNzAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IA0KPiBGV0lXLCBmcm9tIGFyY2ggc3BlY2lmaWMgcGVyc3BlY3RpdmUsIFJJU0MtViBzaGFkb3cg
c3RhY2sgZXh0ZW5zaW9uDQo+IGhhcw0KPiBgc3NhbW9zd2FwYCB0byBwZXJmb3JtIHRoaXMgdG9r
ZW4gZXhjaGFuZ2UuIEJ1dCBJIHVuZGVyc3RhbmQgeDg2IGhhcw0KPiB0aGlzDQo+IGxpbWl0YXRp
b24gKG5vdCBzdXJlIGFib3V0IGFybSBHQ1MpLg0KPiANCj4gwqBGcm9tIHNlY3VyaXR5IHBlcnNw
ZWN0aXZlOi0tDQo+IFNvbWVvbmUgaGF2aW5nIGFiaWxpdHkgdG8gZXhlY3V0ZSBjbG9uZTMgd2l0
aCBjb250cm9sIG9uIGlucHV0LA0KPiBwcm9iYWJseQ0KPiBhbHJlYWR5IGFjaGlldmVkIHNvbWUg
bGV2ZWwgb2YgY29udHJvbCBmbG93IGJlbmRpbmcgYmVjYXVzZSB0aGV5IG5lZWQNCj4gdG8NCj4g
Y29ycnVwdCBtZW1vcnkgYW5kIHRoZW4gY2FyZWZ1bGx5IGNvbnRyb2wgcmVnaXN0ZXJzIGlucHV0
IHRvIGNsb25lMy4NCj4gQWx0aG91Z2ggaWYgaXQgaXMgcHVyZWx5IGEgZGF0YSBvcmllbnRlZCBn
YWRnZXQsIEkgdGhpbmsgaXQgaXMNCj4gcG9zc2libGUuDQoNCnN0cnVjdCBjbG9uZV9hcmdzIHNo
b3VsZCBiZSBkYXRhIHNvbWV3aGVyZSwgYXQgbGVhc3QgdGVtcG9yYXJpbHkuDQoNCj4gDQo+IFNp
bmNlIHRoaXMgUkZDIGlzIG1vc3RseSBjb25jZXJuZWQgYWJvdXQgYHNpemVgIG9mIHNoYWRvdyBz
dGFjay4gSQ0KPiB0aGluaw0KPiB3ZSBzaG91bGQgbGltaXQgaXQgdG8gc2l6ZSBvbmx5Lg0KDQpT
ZWVtcyByZWFzb25hYmxlIHRvIG1lLiBJdCBzdGlsbCBsZWF2ZXMgb3BlbiB0aGUgb3B0aW9uIG9m
IGFkZGluZyBhbg0Kc2hhZG93IHN0YWNrIGFkZHJlc3MgZmllbGQgbGF0ZXIgQUZBSUNULg0K

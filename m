Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94573C445
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Jun 2023 00:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjFWWtm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 18:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFWWtl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 18:49:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B028B26AF;
        Fri, 23 Jun 2023 15:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687560579; x=1719096579;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=boe/dZFczhSto53rnAuFxVnVRcSGEeZ/XSMeBttfYB0=;
  b=dj8po9bfj4P0dGr7yxXgaKbV3djTfNw9xvTS2/H/3i2vKavvnJ1bpdZD
   TyGps/XUYT6GAzlZNPZaLZtzwyai0UvuLSxjOSGPZEmPa3vciQwnt3L5A
   0PGn5M69emy4hp+UaFge6cqxObMLe0uEHKDztrNzccZARijB6tFP/EeEs
   BQb+o22VgT6NA1ZXsQqA8mprzEfW7lb9n2uv/DlwtdaCU8qWe8p5g5dbG
   TpnX7mqKcLf0M1kXXUIcMTdxhWi2XKwUw8DQDe/WRpgB2iDKwQLPEWv82
   pJR/5wrEXi3Ha15k/nYddTzzV70j/oYWxQqeiZiKX/5vZ7Xv0Zl6v5KG6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="426865290"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="426865290"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="805354953"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="805354953"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2023 15:49:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:49:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 15:49:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 15:49:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:49:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQQxVxNSPys9WyhB8qRCgjU425XITaQEzMR4NcVsG2/QbDTi423UpV9ygpge9Q92QqTo4hpi7radE+wrx/r0qB5OQTVkqG24ps+E8eJejJdUtQNExa0lv/cE/q9y7XhUYZrr0M19mGTpJ5RACOO3Bqyyln/1/bbVOlZ1X0BJ+PYzQ20q4W0DgvqlOM+eVAXJsZsLt06+t+ZPvMOK2QOD4SKGT3T2NkLocLTGaYJfudA5oER+DCdZNnQ56s82z2Ot6jQFm6TXf7dgMB5BfLfbmApFumr/Bv1HueweJnbKa4jO3RgEuAF26MfOSKs0QhqIhq+IZ015NPm1WqvpgkbtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fp57ExPHLE1ezzGcVzlCXaPUXCcRaEzKE0f5Sr6UEk=;
 b=N/mbm615Q6Odt3PSQkE+BsfHvCkga/e9MPfV202+r6oL3VYgmhhA/aazo8WjehUnb3rKQxs9mDhw4iIX3+MoDlknUTy/Ce3K3/UU0sgfAcO5fqz8RlwhA0CO8ps1702GnEueASB2llub/DxIEapqVoERjbCcCr92dcN5lTo6LlZz5mKkRX8YAKlWmK+0I5InHo7C8RKkJe8NB6XvzNBas2oUel5jm0HQfp63/rEOHP25Ru/dCvU9v678h1zJI0zjzdGSdahSBuXH6k6Fu1XHdPuA7fKKZYcu3vdaZuwbzQ1RdF1yEIOOIgdNss2PqaXqzH2OhYHMUliNyxsF3kTKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 22:49:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Fri, 23 Jun 2023
 22:49:26 +0000
Date:   Fri, 23 Jun 2023 15:49:22 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Erdem Aktas <erdemaktas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <dhowells@redhat.com>, <brijesh.singh@amd.com>,
        <atishp@rivosinc.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <649621727f833_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <CAAYXXYyK4g9k7a78CU9w6Sn9KTBdoNLOu9gcgrSHJfp+3-tO=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYXXYyK4g9k7a78CU9w6Sn9KTBdoNLOu9gcgrSHJfp+3-tO=w@mail.gmail.com>
X-ClientProxiedBy: MW2PR16CA0068.namprd16.prod.outlook.com
 (2603:10b6:907:1::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 934753a0-9e4b-4057-42de-08db743c184b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMc6P2LgCDwlxuM72lWxzHa2KvtV2ZOgTCcWnRsFVgDeiSGXpXxKbt9TMzbEqfg83eoKbOqrGr45mdooT2+9/TFkSL8AqCtdCub/RqdFy6FarLEsqNEZ9Gt7DDfxTynuruJRbeVAu2gckbAuvwnnL2uBR7fjXIzTnY/uUZoeDF72lq57oBICt2le0ptOukucE3G/3MQC/G9X040+H2J0HoDl/Vz1r7HSviJ68L/M39vqZcF5EMdfFmMe+9CRgWHRrsooh8AgUhKWBY3XUM7ZDzMD3P3zU7nTc30ZQ5oUc5Mp4gweeB3siqRGc9NYzZAvmFJ6G1TQsOYzM+N/6VHLorc76R4Ft+kjrVp8Mkig4OQa3Zb62UluSBkBB2snqLZznnDaBb1D0hqZ3XM05e7vWx9a4BKGuytc+ymSV7Osg8JOo9ij1JMVvXVBf6znlnekk4XF9dvg8TRyvxEOyVcR3Tfc6mI8bKxe6lbb90jdNzWdOIDIf0OhTDWg9xkhzcxQfaXdsLmT1nXWXRvnBodeEam4e79THw5KGDdAFheFv0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(66946007)(4326008)(66476007)(186003)(6506007)(8936002)(26005)(9686003)(6512007)(53546011)(41300700001)(8676002)(66556008)(110136005)(478600001)(54906003)(6666004)(6486002)(966005)(2906002)(316002)(7416002)(5660300002)(82960400001)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnA2ZjB6dC93Zm1Wd1laOWZERnpqZlIrQkF1N3Q3ZHlFaFJUY2FjdUxWdnE2?=
 =?utf-8?B?bzJtQzBRTEQ2UkxSOHhEVWFvTXpJTDlTbkRGcmxwSXZsLzYxMHFQQmMyUDhG?=
 =?utf-8?B?aWswK3ozWWF4ai91ZVBhRHlKcXdxV2E1WFNIRWI3VWdZdTJrblNYNWpNWWFJ?=
 =?utf-8?B?VFJYR2hTbHlZN3g0SWk2SnR6N0I2ZGJFTnhLRzdoTU01ZzlYdWNUVTI3cXk1?=
 =?utf-8?B?dXV3em02VDE0NUdZZzZNZ0JiOS9YYklmNXhnSmxJWVZKUFNDRVE1V0ZKM1F0?=
 =?utf-8?B?V2dFREo3OUJLclQ4Q2FkcUJVdlhjMnJTWnBlYjhaVG5UdWRNUlh6ZFh0WFNI?=
 =?utf-8?B?WDhGLy8rUzhKcWRkZWRJZkZaMXJNeWZyVmNPNmRHQXhFRHY3TlV5cy92d1BE?=
 =?utf-8?B?UlhrajhmK3BwNXBxM3VSVnFhUEtROVd5ZXJxQkRrcjNJUGlDU2pHZEtLTkN5?=
 =?utf-8?B?aTE1MHRQdGhBaE82UlAzdGVaZFdHemcxM2paamwzTGpEQlFIUUZ1ZVJjUHMy?=
 =?utf-8?B?KzVoZXl2VFVqTkZUaTJoVEI4NTJUQS8wRnpmWGZvS1dyNW1VVmtXT3MvM3hL?=
 =?utf-8?B?N1ZmdXVaaXU3SXlKRGVVbGZ1UWd6Rk8xbmorNmFkMkNucUhPd3lBVTl6ejha?=
 =?utf-8?B?TVlBNkJCNFlRZnVEYnUrUURPQWQzZVVnOGNKNWhHVWRuNEJJNWN1N2FQN2xN?=
 =?utf-8?B?eWZPSGNvVFUyNVJ3aEhDbEJOdGg5N1hySUs4Zi9mWWR1cHl4NlFCVVlmdzhM?=
 =?utf-8?B?ZzhQMWJjbFFDc3Y1Skc4T2pZTWg3RzlZTUVjeml2MUlDU0Y5akIxSFBoN2pH?=
 =?utf-8?B?ZjQrMXd6ckhxeW5LWktKV2hJcitON3p1L1lERzlFMWowYktWVmMwNTBYMDFn?=
 =?utf-8?B?MWFnOE4xTE5GOTVGdkZZYWd6WE0zUVoxaWtJNjFCd0RyNlhaNHBHZWVDNmZt?=
 =?utf-8?B?UW9HS1Y2RnVWL2RmS1NudnNsQUh1MlB0ZTVDRURmLzFESnBmV21IaXZaMlhO?=
 =?utf-8?B?RjZEOE45Q2tKa2syU1VGRFZyS0llTzRnajdFUHdET2hXYjUrS3hjbWtzVkhj?=
 =?utf-8?B?MERneXg3OHgzVG1VaG9wMUtvT1Vrbjg0L3V2UDlLd2F5NmVJUmtZK1FIS2d5?=
 =?utf-8?B?K1l4TThkUG5MeWpDeTNEcWwrckg1ZGJLd1l4ZU5vZVVFV0E1eURwU3VpaTRw?=
 =?utf-8?B?SFZ2WERCNVNaTHo4c3BJZ21wa0x3R3NTUHdaOG16YTRvbHUrMVFPUUJUU1J2?=
 =?utf-8?B?TUFBTmtLWTU1NTRBMW4wTGlYYnE5Qjk1Yy95TGdkUFhMRVZMQkxLNnZhbnJI?=
 =?utf-8?B?NjVtVFNQWkhGR0FFODRNRFdVc3ROemVTOFc5a3dLb3czOVFBdG11dnZNb3d6?=
 =?utf-8?B?WllCZnJwNEI3L243SmM5eWJwTG9YejhPbjhEaHVPVC9pOG4xZXI3TU5OemZT?=
 =?utf-8?B?OVlxNnpnNDZiRmRKTEFZU1JRcWJWb0xqVkJQVUhncHpOSEIyQ2xaUlkrQWpx?=
 =?utf-8?B?OXlocUpqbG9tNmxqTXBadlpKdjdVRmE3NXRyd1BSY3l5UndJLzZvV1JmUXZQ?=
 =?utf-8?B?TnQzY0NvaDhyVXlRODk0TTlIWlhMeHZwaytySDVENFNIK2RzSjVvbkEvbzNM?=
 =?utf-8?B?MFBpdkNTY3QyVzNtcTlZUUM5U3Q2dnYwMTJqcHhaT05OMzMvYjY2b3pZL2h4?=
 =?utf-8?B?OUVKbm04amdjVUFSMG0va295ekxvRDUyUm5vWThkeEk1Wm9BV2xVS1ZBMEsz?=
 =?utf-8?B?TjlMYWc2N0xxV0NLUkx1emtYaHdzYjZYM3ZmVkJzbFdURXNhb0RJWU9CSUsz?=
 =?utf-8?B?ZnN5THJmWFU5c0pUOW5iWjNpN05NbWJGZ2N3enpWbk42RmI2cnR5UkVTckdB?=
 =?utf-8?B?VjBkbU55SU90YjdvTHF2RmtJbDAzMFdibDNZbko5UlRUTGFTYTRRcE9PVjFB?=
 =?utf-8?B?dzBaY1NUY2YzZ3FJYW00VjA5YVJvL2dBanJqTHVSaE1lMjVzV0tsbU15U242?=
 =?utf-8?B?dG10S2VQVE45UzBFdW5RNWVKMllCNWhGUWtlN1F1ZmpJY2F0bzROYnBPRlAw?=
 =?utf-8?B?dUZPNmpmaGRXczB0Qnh0bEM5KzV3WnhBcndQOHh6ZU03Z1d4ODYweUhQemhY?=
 =?utf-8?B?Wk5oSTZTUWxnYm13QlgzZDB3UTVsMW05UHhoa2l5RENzNEhGR0tOc0YzVGFw?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 934753a0-9e4b-4057-42de-08db743c184b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:49:25.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 900qYzP5HH8tjgxqCtXy+3zj3me7imHjbabO/wTqpZF8SZwyATzK12H0H3Tf5dwMed75zPMsz2LoRUbPkNGjeZvoWq5MjZxlSZF3w/Q+Z9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
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

Erdem Aktas wrote:
> On Mon, Jun 12, 2023 at 12:03 PM Dan Williams <dan.j.williams@intel.com>
> wrote:
> 
> > [ add David, Brijesh, and Atish]
> >
> > Kuppuswamy Sathyanarayanan wrote:
> > > In TDX guest, the second stage of the attestation process is Quote
> > > generation. This process is required to convert the locally generated
> > > TDREPORT into a remotely verifiable Quote. It involves sending the
> > > TDREPORT data to a Quoting Enclave (QE) which will verify the
> > > integrity of the TDREPORT and sign it with an attestation key.
> > >
> > > Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> > > allow the user agent to get the TD Quote.
> > >
> > > Add a kernel selftest module to verify the Quote generation feature.
> > >
> > > TD Quote generation involves following steps:
> > >
> > > * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> > > * Embed the TDREPORT data in quote buffer and request for quote
> > >   generation via TDX_CMD_GET_QUOTE IOCTL request.
> > > * Upon completion of the GetQuote request, check for non zero value
> > >   in the status field of Quote header to make sure the generated
> > >   quote is valid.
> >
> > What this cover letter does not say is that this is adding another
> > instance of the similar pattern as SNP_GET_REPORT.
> >
> > Linux is best served when multiple vendors trying to do similar
> > operations are brought together behind a common ABI. We see this in the
> > history of wrangling SCSI vendors behind common interfaces.
> 
> Compared to the number of SCSI vendors, I think the number of CPU vendors
> for confidential computing seems manageable to me. Is this really a good
> comparison?

Fair enough, and prompted by this I talk a bit more about the
motiviations and benefits of a Keys abstraction for attestation here:

https://lore.kernel.org/all/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch/

> > Now multiple
> > confidential computing vendors trying to develop similar flows with
> > differentiated formats where that differentiation need not leak over the
> > ABI boundary.
> >
> 
> <Just my personal opinion below>
> I agree with this statement in the high level but it is also somehow
> surprising for me after all the discussion happened around this topic.
> Honestly, I feel like there are multiple versions of "Intel"  working in
> different directions.

This proposal was sent while firmly wearing my Linux community hat. I
agree, the timing here is unfortunate.

> If we want multiple vendors trying to do the similar things behind a common
> ABI, it should start with the spec. Since this comment is coming from
> Intel, I wonder if there is any plan to combine the GHCB and GHCI
> interfaces under common ABI in the future or why it did not even happen in
> the first place.

Per above comment about firmly wearing my Linux hat I am coming at this
purely from the perspective of what do we do now as a community that
continues to see these implementations proliferate and grow more
features. Common specs are great, but I agree with you, it is too late
for that, but I hope that as Linux asserts "this is what it should look
like" it starts to influence future IP innovation, and attestation
service providers, to acommodate the kernel's ABI momentum.

> What I see is that Intel has GETQUOTE TDVMCALL interface in its spec and
> again Intel does not really want to provide support for it in linux. It
> feels really frustrating.

I am aware of how frustrating late feedback can be. I am also encouraged
by some of the conversations and investigations that have already
happened around how Keys fits what these attestation solutions need.

> > My observation of SNP_GET_REPORT and TDX_CMD_GET_REPORT is that they are
> > both passing blobs across the user/kernel and platform/kernel boundary
> > for the purposes of unlocking other resources. To me that is a flow that
> > the Keys subsystem has infrastructure to handle. It has the concept of
> > upcalls and asynchronous population of blobs by handles and mechanisms
> > to protect and cache those communications. Linux / the Keys subsystem
> > could benefit from the enhancements it would need to cover these 2
> > cases. Specifically, the benefit that when ARM and RISC-V arrive with
> > similar communications with platform TSMs (Trusted Security Module) they
> > can build upon the same infrastructure.
> >
> > David, am I reaching with that association? My strawman mapping of
> > TDX_CMD_GET_QUOTE to request_key() is something like:
> >
> > request_key(coco_quote, "description", "<uuencoded tdreport>")
> >
> > Where this is a common key_type for all vendors, but the description and
> > arguments have room for vendor differentiation when doing the upcall to
> > the platform TSM, but userspace never needs to contend with the
> > different vendor formats, that is all handled internally to the kernel.
> >
> > I think the problem definition here is not accurate. With AMD SNP, guests
> need to do a hypercall to KVM and KVM needs to issue
> a  SNP_GUEST_REQUEST(MSG_REPORT_REQ) to the SP firmware. In TDX, guests
> need to do a TDCALL to TDXMODULE to get the TDREPORT and then it needs to
> get that report delivered to the host userspace to get the TDQUOTE
> generated by the SGX quoting enclave. Also TDQUOTE is designed to work
> async while the SNP_GUEST_REQUESTS are blocking vmcalls.
> 
> Those are completely different flows. Are you suggesting that intel should
> also come down to a single call to get the TDQUOTE like AMD SNP?

The Keys subsystem supports async instantiation of key material with
usermode upcalls if necessary. So I do not see a problem supporting
these flows behind a common key type.

> The TDCALL interface asking for the TDREPORT is already there. AMD does not
> need to ask the report and the quote separately.
> 
> Here, the problem was that Intel (upstream) did not want to implement
> hypercall for TDQUOTE which would be handled by the user space VMM. The
> alternative implementation (using vsock) does not work for many use cases
> including ours. I do not see how your suggestion addresses the problem that
> this patch was trying to solve.

Perhaps the strawman mockup makes it more clear:

https://lore.kernel.org/all/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch/

> So while I like the suggested direction, I am not sure how much it is
> possible to come up with a common ABI even with just only for 2 vendors
> (AMD and Intel) without doing spec changes which is a multi year effort
> imho.

I agree, hardware spec changes are out of scope for this effort, but
Keys might require some additional flows to be built up in the kernel
that could be previously handled in userspace. I.e. the "bottom half"
that I reference in the mockup.

This is something we went through with using "encrypted-keys" for
nvdimm. Instead of an ioctl to inject a secret key over the user kernel
boundary a key server need to store a serialized version of the
encrypted key blob and pass that into the kernel.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCA740710
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjF1ANR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1ANO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 20:13:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C14E8;
        Tue, 27 Jun 2023 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687911193; x=1719447193;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8CzNOU/BiDOEWQwzvKn9MkuKCLmhbDN9RAQPEeP+H5w=;
  b=hhvXyxDvuBJHoABSGXlUDFWhMvIzT8J4mNTWZSSeDGUzpR4J9QMVT3zd
   vze+lWeBdTCSpntkhMWJ8ruazugaCgKNc6Np0l7sm0boC4ht7VHsFG+y7
   4LjuAiRNLE+Z9+NHZKtJdbvympUq2iWsb8yScIFa12KlFyB6lF1uu3v06
   LyfDIVCzIQLgH94CwJhFaf37o9sTc2P4O213z0nGPN6Np1+TVUXz9Qjt+
   SyTMgAVroGTVnrTKzHMq1UjWWxj0IUldUZJ0a3hLzSevKiWD3rHUEzBsa
   QEbfeRhSixFvEHVCAomPHTw70XBYbazb48olv4UKE8p4wQM7udja7uXwX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365167062"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="365167062"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 17:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="666896043"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="666896043"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 27 Jun 2023 17:11:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 17:11:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 17:11:16 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 17:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7O+vhz4X1E8n86ucuUj7P+il1PSjUXWawmWazjOzLm5EZjmTt7fri+XyYf/EcpUA1DjUSY4Q0AhGY/U89KHXxRYpB0Z1GRFez/nhZVb5mzU1kvpz/GepMOGQxa7o4WyU4UCws2rEkf1Qm8Pz1NdolcBhIuokI/xHP7dkMpRXafOtljAWDkaHdwkfVnq28QriH8Mj9vvQFwpjrBRWAiQYNTOBZviQ97suw0F6ACRqgwMwiVrBnhGaL9aoZL9Aw97CQytbNXlBuAq/+IvNOCpM3YWMJ8g45wX2ws1eRDhLks2nxq9ehvWX+yR5Ii8OZtc71RR8yjIMoAXaD00snRUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fa+ExTECRz196bk7FE5imQx/BdkbJW8JXLcY4AoJpKE=;
 b=di30sVNNh9AmsrgQ2R/Uom94ocaSLjqPkskp6DNF80YvWvVucdKYsD0vHWs18J2FMyVv8vkq4zztl85E8nf6LW+0164osx6TqGL4Jvulw3XbtKC/Wa/h39VVejJR+cz5TwsH/7MmJJFiSprQY4hiSBui6rvt39HU31x0zQgHJQmTh16OWwlPkyNjtVlvTkUQl1cQ/Hux97ejzJywklQlrRSQDAQr21fgAXDoY1NTqakzTdyEFiq41iagL9PxxG/Jrny+PoLVjN8xC0zjAPQpdqbBnenybWtNOi6orOKC/NL/MaGjCysyWpPPw+JK8nw4YEZQrbqGdK05wqCXO+/Rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 00:11:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Wed, 28 Jun 2023
 00:11:12 +0000
Date:   Tue, 27 Jun 2023 17:11:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        "Chong Cai" <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <dhowells@redhat.com>, <brijesh.singh@amd.com>,
        <atishp@rivosinc.com>, <gregkh@linuxfoundation.org>,
        <linux-coco@lists.linux.dev>, <joey.gouly@arm.com>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <649b7a9b69cb6_11e68529473@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
 <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHa85hCz0GhQM3f1OQ3wM+=-SfF77ShFAse0-eYGBHvO_A@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ec5c63-328b-4556-e1e7-08db776c2e27
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljJJ1lQXAN1425wfHQRkt/AnN9pXKNLMoZwMPFK2kyu10sKc7rr81MWCiEmzJRZvZCNZHNpsWb6MErRC4Vdl2r3V7n8qvaiZLxAkRop7+CORaoZjWtIGFsVNe3htTnIqo/UdmZ+INf21931+VlIki8fq+j9eQGkxbX87i2zp0JJWnVH0D876VI8xEbnRil1xZkpf8fmJCCb+G1LBLUFTCWbhLVJiAnHGgxMegeiOuIvFDZ16v1ErGnQi4m7lHbfD9Ho2NL+KmNRZ7oaCXExyAZc65FkA0ehM+puKTYvi2vTklJiORg1v0cVlp0EwvgsNuB/iu7Oyh7mSK9kYJ44PyQxi0PjnV5Erp3vJRAiOsvEG+AYk4QUFIbgYv9/HMZfIS6BH9+o6N8PpOmkY4pjsdbkfgGRrDVXl8qVvGMS258RSjL7nbFqXzKNKqNer6TdKXbFjZWETVIUocK2JOkap9QixMT37+4RVxbyHJIG3BVD5orzo/pAX/OOycrxcKuvuFRfDXyfpr9m0zzJOvmcdwA6BaUzJjVnmY5hgHa34a+776nDL4kdp/jvMDm7u8rdZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(83380400001)(110136005)(54906003)(478600001)(6486002)(6666004)(9686003)(53546011)(6512007)(66556008)(2906002)(66946007)(26005)(186003)(66476007)(6506007)(316002)(7416002)(38100700002)(41300700001)(5660300002)(8676002)(4326008)(8936002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUd5Rkw4ZWE4NHpWbGJvVlNhZWFoeFNCMmx3MC8vZHV2Q0pTVGRaRWE3bkN1?=
 =?utf-8?B?aUYrRE5GU2x6aWRWZXNlSHBueUs3YW1pTUg3YThTalQ4cW83TEZ1enVCU1Vq?=
 =?utf-8?B?Vyt3ZU9VR0NyNzlMMWl6dDNuLzB6cjgzVFVhUlo2UkNBdHZXaUptRWFYckZ1?=
 =?utf-8?B?ZmE0dUY3U2xFTjN2ZGlJWTJrMytQcUlBbUNpbzNKdGsrTVFYc0EvTEhhdFY2?=
 =?utf-8?B?N2EwRDNLd0h1bDdYL0xpdzZMWXZsanVQendqVUZXanZYZG11MXcrbHRpcUpt?=
 =?utf-8?B?dXdlNzBHOE5mVXRxTjVtcGR5QnBROEFnVVpxQlRMVC95YnVHdkxEK3FTYVcx?=
 =?utf-8?B?M3JOaXFIRXV1QlVybC9aTUdjK1RaWE1nZVBMMElUU1QvUm0vYUFqSk5kb2E0?=
 =?utf-8?B?SmJGVEV4aE8zYWgvMEF2N3ZFc3dBUTRzT0ZKdUFPMEJydGJBWjU0MGZ3UEx4?=
 =?utf-8?B?ditwTG5nN3pudkNmQVNWNDZOKzRtdm5wUWlubDJ1QytuQm1wenlWT0l1QXhL?=
 =?utf-8?B?K25CRXhrWHF5ZU9jaU1GaDAzZW5xMG5ZSlpmL0NlV1ZsclZEdkJRNkNsNkZa?=
 =?utf-8?B?UUdISXJpMjRTSGlwU25lNXZlWHYzZGIwQ1FFMVRlV2JyWFNQWTVGVWJxa0ty?=
 =?utf-8?B?b0xZS29YdmtBUEFwS3o1bjhuQ1Azay9nUytnM09RaWpZc3NCWUdWZ0lXb085?=
 =?utf-8?B?c0tyZlRTemtiYTBGMlpoQlpNbjR4N1JoMEtkVkFpelpIa0FqNG0wUmIzMW5i?=
 =?utf-8?B?aGRiL29xZTlKRzlnVzI0N1RJY3JIcXkzYXk0dlBFdTRCWlA2OFlnYWI3cHpx?=
 =?utf-8?B?aUJzNndZRFdmb05yZ1piRTlkdnRsaGZBdWxKSHVSa2M0SEh6NkZ6MlN6OURG?=
 =?utf-8?B?S0pXY1NOc2dMcTZIc0pBNnYyeXFLbnlnMVo3eU1JZkYvdkxzcTh6Zmp3SkZa?=
 =?utf-8?B?NVdYcG4vdmhBcEpSRHd6Q0ZkRFltdHdBQy91bGlrUlllNHYwejU3RmlsenJp?=
 =?utf-8?B?Y1pwUTZ3MXRYeXRKSFFNS3YvdkxzOGgxWU9uUlFvZDQ4YnIvb3Q0Y0ZVSm9m?=
 =?utf-8?B?ekJzUWo4VUhoOVpwQXlEb2RKOCsyTG92YnBDM3E3RVVUamYyZ096WUEraTZm?=
 =?utf-8?B?RjhNK0lQQ0xHaVgzZkQ1ZkVzMlJxQzlZanBzOHJDNFdXUTFSRno4K0M3NHhV?=
 =?utf-8?B?YnlxUnBVcXpFcnZGWllYSkIrQUxQVzNJQnoyOWRZT1JJSnBsbHBTaG5IVkVI?=
 =?utf-8?B?cTRTVURqS3JneWRBbWRCYWI0cTFqVEp3Q1cvMHdSTzNvTTRZS0xVYXZaTTlp?=
 =?utf-8?B?YytJMjVNK0hjTU50cWxHNG1LV2k0ZHJFNklSVEJCUUhmWlQ3bXJiK3Q4cmd0?=
 =?utf-8?B?NjRCQnI3Um50eU9jZ1V4TjNqNUo0STdtZFhTMWNqRzJEL1RKVzM5dmNsMXI3?=
 =?utf-8?B?eVFsMTZoRTg0S2FHenRKTXh3bTUrTDVmOHpNVFZ2a1pTd1c4V3lJVjFHSWRH?=
 =?utf-8?B?cXQzRCt6OTRFMTRVa1Faa25iNUNOMlEzR2NlYzVRUkcyWXN0N21tODBiamt1?=
 =?utf-8?B?QVoySUlPUlgzdGR6UUQ5a0J4RHdDK1BKejZTaW5aSmVpV1RPM1hxODZNeUxY?=
 =?utf-8?B?VWVCU2tWU3JHVVNWeFlLVjFFRDlLN2tWNUJzaXFnZFhmMjZRREtuMG11OGpR?=
 =?utf-8?B?UFQ5Mk1qUzBZSC94ZmxCaXgxdG9XQ2RaR1d4bzVtSm4xZ3BsNm5EUGlIQmsv?=
 =?utf-8?B?TUhqMW8rdmhweVB2M25oTkFJTHNxSUNHN01iMzk3aElNZ2tTL1RvRXJBNUZW?=
 =?utf-8?B?WlVWVkZKMkhBQ3dscGlYMWNLTGw3YnpiNCtaV2h5Q1VSQkNzeFU4R21Tbk1Z?=
 =?utf-8?B?MlF4UG5NZG4wY2JCQzV5dkF5NWZDVWxZRDlHV0w4eU5tbXRVMW9vZDR3V0dm?=
 =?utf-8?B?YnJhcUprbWE0aFljaXZpK0ZleWlZY1pTaHp3cU5lUVJkZC9DaDg1SVBrSS9C?=
 =?utf-8?B?U2pXTWRxNXA3a0RsOFhEZHgzQ2s2ek9aUzlDODVQQ0YvcEFCc0prak5zak5k?=
 =?utf-8?B?cUhLNUYwRzVnWnh2T3Vod01KMjBtOGpsdG1vMzQ3T20vZVRycVNLR3V6N3RI?=
 =?utf-8?B?akZZaUF2NFM1SlBYZmU1eEZJNS83cWxjMmlMbDUyajUxZFEybGNQMzM5cjE4?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ec5c63-328b-4556-e1e7-08db776c2e27
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 00:11:11.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuiAp7VFaDWTqrVjCaWWaL37xQbXbZ1pTMRsTSyRO+dxfCdV9kQM8UtfJFo1u8QBhdDE336BH0HxqzcwkKytiSxqltO8dX5ke7FLuNttqfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
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

Dionna Amalie Glaze wrote:
> On Sun, Jun 25, 2023 at 8:06 PM Sathyanarayanan Kuppuswamy
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
[..]
> > Hi Dan,
> >
> > On 6/23/23 3:27 PM, Dan Williams wrote:
> > > Dan Williams wrote:
> > >> [ add David, Brijesh, and Atish]
> > >>
> > >> Kuppuswamy Sathyanarayanan wrote:
> > >>> In TDX guest, the second stage of the attestation process is Quote
> > >>> generation. This process is required to convert the locally generated
> > >>> TDREPORT into a remotely verifiable Quote. It involves sending the
> > >>> TDREPORT data to a Quoting Enclave (QE) which will verify the
> > >>> integrity of the TDREPORT and sign it with an attestation key.
> > >>>
> > >>> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> > >>> allow the user agent to get the TD Quote.
> > >>>
> > >>> Add a kernel selftest module to verify the Quote generation feature.
> > >>>
> > >>> TD Quote generation involves following steps:
> > >>>
> > >>> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> > >>> * Embed the TDREPORT data in quote buffer and request for quote
> > >>>   generation via TDX_CMD_GET_QUOTE IOCTL request.
> > >>> * Upon completion of the GetQuote request, check for non zero value
> > >>>   in the status field of Quote header to make sure the generated
> > >>>   quote is valid.
> > >>
> > >> What this cover letter does not say is that this is adding another
> > >> instance of the similar pattern as SNP_GET_REPORT.
> > >>
> > >> Linux is best served when multiple vendors trying to do similar
> > >> operations are brought together behind a common ABI. We see this in the
> > >> history of wrangling SCSI vendors behind common interfaces. Now multiple
> > >> confidential computing vendors trying to develop similar flows with
> > >> differentiated formats where that differentiation need not leak over the
> > >> ABI boundary.
> > > [..]
> > >
> > > Below is a rough mock up of this approach to demonstrate the direction.
> > > Again, the goal is to define an ABI that can support any vendor's
> > > arch-specific attestation method and key provisioning flows without
> > > leaking vendor-specific details, or confidential material over the
> > > user/kernel ABI.
> >
> > Thanks for working on this mock code and helping out. It gives me the
> > general idea about your proposal.
> >
> > >
> > > The observation is that there are a sufficient number of attestation
> > > flows available to review where Linux can define a superset ABI to
> > > contain them all. The other observation is that the implementations have
> > > features that may cross-polinate over time. For example the SEV
> > > privelege level consideration ("vmpl"), and the TDX RTMR (think TPM
> > > PCRs) mechanisms address generic Confidential Computing use cases.
> >
> >
> > I agree with your point about VMPL and RTMR feature cases. This observation
> > is valid for AMD SEV and TDX attestation flows. But I am not sure whether
> > it will hold true for other vendor implementations. Our sample set is not
> > good enough to make this conclusion. The reason for my concern is, if you
> > check the ABI interface used in the S390 arch attestation driver
> > (drivers/s390/char/uvdevice.c), you would notice that there is a significant
> > difference between the ABI used in that driver and SEV/TDX drivers. The S390
> > driver attestation request appears to accept two data blobs as input, as well
> > as a variety of vendor-specific header configurations.
> >
> > Maybe the s390 attestation model is a special case, but, I think we consider
> > this issue. Since we don't have a common spec, there is chance that any
> > superset ABI we define now may not meet future vendor requirements. One way to
> > handle it to leave enough space in the generic ABI to handle future vendor
> > requirements.
> >
> > I think it would be better if other vendors (like ARM or RISC) can comment and
> > confirm whether this proposal meets their demands.
> >
> 
> The VMPL-based separation that will house the supervisor module known
> as SVSM can have protocols that implement a TPM command interface, or
> an RTMR-extension interface, and will also need to have an
> SVSM-specific protocol attestation report format to keep the secure
> chain of custody apparent. We'd have different formats and protocols
> in the kernel, at least, to speak to each technology. 

That's where I hope the line can be drawn, i.e. that all of this vendor
differentiation really only matters inside the kernel in the end.

> I'm not sure it's worth the trouble of papering over all the... 3-4
> technologies with similar but still weirdly different formats and ways
> of doing things with an abstracted attestation ABI, especially since
> the output all has to be interpreted in an architecture-specific way
> anyway.

This is where I need help. Can you identify where the following
assertion falls over:

"The minimum viable key-server is one that can generically validate a
blob with an ECDSA signature".

I.e. the fact that SEV and TDX send different length blobs is less
important than validating that signature.

If it is always the case that specific fields in the blob need to be
decoded then yes, that weakens the assertion. However, maybe that means
that kernel code parses the blob and conveys that parsed info along with
vendor attestation payload all signed by a Linux key. I.e. still allow
for a unified output format + signed vendor blob and provide a path to
keep all the vendor specific handling internal to the kernel.

> ARM's Confidential Computing Realm Management Extensions (RME) seems
> to be going along the lines of a runtime measurement register model
> with their hardware enforced security. The number of registers isn't
> prescribed in the spec.
> 
> +Joey Gouly +linux-coco@lists.linux.dev as far as RME is concerned, do
> you know who would be best to weigh in on this discussion of a unified
> attestation model?

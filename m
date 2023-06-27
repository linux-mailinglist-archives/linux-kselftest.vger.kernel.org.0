Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D887406EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 01:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF0XpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 19:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0XpK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 19:45:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB71FEB;
        Tue, 27 Jun 2023 16:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687909508; x=1719445508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jr3RvPfScT+lUoT8dexj7Eaw0nVNg8YfRia3Cr00ioM=;
  b=bcLkSfJ5WjY8yAHl199atL829TJhwCDX1ofxOooe3WPZKfeTNIF3OPwf
   fjz0P3LQaQruvfhbMjz4pfWG2T07F1Mqo33h+Zfk5nH1XFCqbhNZqCf4g
   slG4hdeDJCXg9vxwl4/zi+O1Ba1vt3ZyHgH60Mf65XhVVyWri+kq5QaJV
   DzE0YPRhaz6ziSgsR+5nYmQpxwYfst/OmnB9MDeQt2Qd23Q+d8wRotSVP
   JXUd9czBTqsPXPa5t4aMcrfBaHhWmk+Ram4ruRJKRpFf6Lr/ipS+KINVN
   rmvY87L4xe7gYN3gFn55FlkwEfLTu/vY7g20zwVGU9C0+uXU5ormecaIl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="346469682"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="346469682"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 16:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="861286792"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="861286792"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2023 16:44:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 16:44:59 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 16:44:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 16:44:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 16:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEFCZjYe/W0mNW0bY2IPm+EgadIEvxDMHTS/TDisOLU0g3G2Q1Ivtxwyo6iPrZuM6Qhf8tCAJ+pIFbdr+ku+0ozGlusgHTHm+gweafjuwfn1+qCdlcmMaP5Otnsiw7cxVTy4fxguVOTJ47VAws9SaGjRuJ+iBCXMDM+FvOXA2e+9kUd/tbwRgrpSjBFqZiF2NxzrhL0JZ2ZID24xGmJb3lrqPf6CS1XfRG5OCqWLzWlGvtD1YRRlmNge3tq9+vCnI/JIEdVcQjixz+lNeB0PcFAIj8JB1MR3/4z6dYMj9aOYs/q9sfN/orhCrOFYrPSMERXJ/Gx+qXyzsg/Sy9SumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqRZCKb//heZpjgsBlrFCDBo5KWGOexU885mEHIvvAk=;
 b=hxaIpVvJk4GxigiNZaAgAOJtQ1eMhji9jSh6u8goNJVUDOPRfrRgB66e3XorhqVrDTFfCO2g43ZtosAyAU11LThRejkJYUnlSLUNMpYYRFBF7reo1KNnighGhHQExQIr7Z/vjOsH90FVOkElQ65F91nOuon/nvX+TQ3xtR0xw1FBYAlvBnz+3EZBXcv3CtJcFf2m1HWdG7eVUP5fFFNTlMHB5jkymuSCs1bExCRpC9vK3NabV3cnuR9P6CAaFQ3MxZVtLt/vZ6ll8N2bscl2itXH9eSNjelF6vHOcpPPxXUq9XRWgjoPpNAuAc7D8SoeNwwy+ujWbJNW3FqMzqjW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 27 Jun
 2023 23:44:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Tue, 27 Jun 2023
 23:44:55 +0000
Date:   Tue, 27 Jun 2023 16:44:50 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        "Du Fan" <fan.du@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <dhowells@redhat.com>, <brijesh.singh@amd.com>,
        <atishp@rivosinc.com>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Message-ID: <649b74724043c_11e6852945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <972e1d5c5ec53e2757fb17a586558c5385e987dd.1684048511.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <64876bf6c30e2_1433ac29415@dwillia2-xfh.jf.intel.com.notmuch>
 <64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch>
 <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9437b176-e15a-3cec-e5cb-68ff57dbc25c@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e57984-7ede-4cbc-d198-08db776881f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY3W1uJ/2T0dBU8e+Cqk4hQ8fZEiif/v2nhCvwVy9B+GHgR52LdarblL/2EiYcOXvAghNC2rNwakJwlnAFLWtjW5gZSNSpkq7BcMPDKPVKvlWBBlOvmwGNgVbK17HfSlFOG0qL4Y2zSpepicn5RgDHAe/EuF/mloQl4grF/t6xx4hNm5rplER+eRXOwjWBSkfeDnTnQzw2ph3NF61FwQQzfhvh4gLs6pL8Oqf3e1P9PTO6XbqlzwW1gQ6+bbQ1wkcPov90W0mov45ileXHQKUOgQ2yz20PDu317lDKWM3HfiYgCUDcexDSwoOPTV+bUxJm7egxa/jb0YKllOm/cPsBe66rWz//0Y9CG0sA2QBtK7aefJOfj8Sse5sJrSnY9Krha702GY7gGf6PXoZVpc1LrL3RBJcYF6o4QJoZx6/XbdXT/xO5JGjWpjfVNV8syXKTjLP9qxLqzTK1/HbI0Wv01xihK9YK0wMu/OYuPPKxHle0K5oOBALn0ErUBSjERdOnDAIfF3HjTEUC0kABKVaR8kwlG3o4tJLzB9vqNptxT2rF6BNBHj8Kt5NgBVozOYNKhn33WJt8e96pcvwKbRU0D0e6lmBO3+BjhYydCooRfSKvA0KQela8CSJgs7CkNT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(396003)(346002)(366004)(451199021)(83380400001)(110136005)(54906003)(478600001)(6486002)(6666004)(9686003)(53546011)(6512007)(66556008)(2906002)(66946007)(26005)(186003)(30864003)(66476007)(6506007)(316002)(7416002)(38100700002)(41300700001)(5660300002)(8676002)(4326008)(8936002)(86362001)(82960400001)(505234007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZNp+Eje93zC33Nw9xuN5SS0Sne8WpPZqLKfvSuW3ujhqMzgnqWjdjj130m9?=
 =?us-ascii?Q?O1X2nxlvXNww/obdbKyz5Iw4d7Nqqw7kE7zX1mu6QThXxxJ05COY/I5ijsqS?=
 =?us-ascii?Q?hAFtD+rdaC1d3Ki6Tq4rrSz9q+Z/7pOPRrlQbapMrABKsuQWikoHV8kyXnRW?=
 =?us-ascii?Q?9P6CZCk+fOqLwX3FSeBIaLWNm8/df9KEpKG72drNyLRmg0jJERClJbKvorgp?=
 =?us-ascii?Q?d6ENqxIhOeyGYWy1td1QuZQOcIC5fgNBKmvPEt1hAcQuVWa/FDGMIerU43pO?=
 =?us-ascii?Q?2dPesiCTrhwDdc7UuEtRvfnDFQNpadGItgBgiLyxojSUPSyTBHB9qh72bc2h?=
 =?us-ascii?Q?frfMkn1mC3hJTJ6Q9vnP1SzqL8qkPQd/R/bgHNJqlXicL0qlzSQWMAqDzUbR?=
 =?us-ascii?Q?MGYzE9Mg5XZH8JEvN2mo9AQKP01OSIcYffx33xnDql/7V0YEJ2rZP/7t7hNm?=
 =?us-ascii?Q?ZHDrq4LmFG0SfTKcckfZR2UjnCZOrCjN+R/fzgkEbDf0jvjB9rcYRDUUhvrJ?=
 =?us-ascii?Q?Tx0AZQiqbOBmKzI6V4bkbRw81rz2a1rbeAc5j7imHWdD0HztyivFJddy6HOT?=
 =?us-ascii?Q?uB/TQFmYjEMyPiMMd0lo25C5rUbS5catBQolRb8Bk3pmzywnSDZ286SQVY54?=
 =?us-ascii?Q?fyHxaV8wn1SoXREXaQMoqSItgX/yVNu7Q6IGNtDZnIEBWcl5DRR4x6hmu6Sq?=
 =?us-ascii?Q?8vATU3Xj9TFjqax0m4cm0W0USt69smJhueQMbDsluvju9rVLFyCZiyYze5ec?=
 =?us-ascii?Q?Y6GD9QZua9nWZGMfKxd84EItDfOK3ysXL8tHx+4izhVHMxZfA2AuJkk7ROTE?=
 =?us-ascii?Q?vtUhc/agQHsEvdg1r4LsNM4qsWbY+9avKn3h5nu+JUtBSscVAqbLbgkKBcT6?=
 =?us-ascii?Q?qup7NXxFei2SSWQLuftXRId9MQu2emapqf0qHWc+TnRhgFa9cPXec2hGi+ia?=
 =?us-ascii?Q?JTqWbyQgIMg9Wk+TvFLwwMHC9nVHtQ/74cZgTbD9uktCNRMFB8F1legpX9U8?=
 =?us-ascii?Q?/k25a2rqfIAd8ZDTLu9xvT2W7/5Unb8TtFsMB3G8r9ZR229Gu+yl8hZCMEQj?=
 =?us-ascii?Q?7g3Mbsbha28GxU0DcgGtzKVHxInfhCtDHUUtIQi2ACuzgvB5cyUnGPu/EA1X?=
 =?us-ascii?Q?MKPFq+5qTLrcoHbGwtAbvp7IwWhr7TYAO78J1DQkra8en/hRM76eaDW88QGx?=
 =?us-ascii?Q?jSMU3jofvlXVsNx+SGZCGVeAA6GiKNBi4VUEa//6iPOu5F5jo7E++r4lb3kL?=
 =?us-ascii?Q?HO8wiEjUGG7oM66uKMNmbZBH62bZ04WFHEjNRi1tz8/VBpVV3CPsZooo9+X5?=
 =?us-ascii?Q?lO3Fl7ktVE+BazuEd3U8oG7FmFqSu2ZUw4s6g0F1Qjzm8nG0zdXm/JBC/S+E?=
 =?us-ascii?Q?BhUpOawkZhRtep/JXTw6iFKFJxucSctYpZg0PtrWS+i2TlfR53Av1wRdLHlW?=
 =?us-ascii?Q?7POrYqp/7MImIvDGuy5AepNUFAx54gjK3jHqUPKOGfI7qjg7VXB/1MPC9rAp?=
 =?us-ascii?Q?rhUF7nKB7N17jxpoQXLxMCWHtNMPoxMP5kQ9w+Ehl8CS5azCCURln5g7zbUs?=
 =?us-ascii?Q?V5CE+Iz6e44CywjzFCX5i/lqoCKF6fkztMp+uRzDMWb+BnHeXqDSVdCTvZ4Z?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e57984-7ede-4cbc-d198-08db776881f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 23:44:54.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDOmsjps4XA5nI+SkTHQL5p+bM6TkSXW1Ye2Vs9iQt3ccSQr8JTCXpuK7P2c1say0oQu7EDp6E55KnBOPmuUIfdQPt+zFx0TCBjPrMD93jI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sathyanarayanan Kuppuswamy wrote:
> Hi Dan,
> 
> On 6/23/23 3:27 PM, Dan Williams wrote:
> > Dan Williams wrote:
> >> [ add David, Brijesh, and Atish]
> >>
> >> Kuppuswamy Sathyanarayanan wrote:
> >>> In TDX guest, the second stage of the attestation process is Quote
> >>> generation. This process is required to convert the locally generated
> >>> TDREPORT into a remotely verifiable Quote. It involves sending the
> >>> TDREPORT data to a Quoting Enclave (QE) which will verify the
> >>> integrity of the TDREPORT and sign it with an attestation key.
> >>>
> >>> Intel's TDX attestation driver exposes TDX_CMD_GET_QUOTE IOCTL to
> >>> allow the user agent to get the TD Quote.
> >>>
> >>> Add a kernel selftest module to verify the Quote generation feature.
> >>>
> >>> TD Quote generation involves following steps:
> >>>
> >>> * Get the TDREPORT data using TDX_CMD_GET_REPORT IOCTL.
> >>> * Embed the TDREPORT data in quote buffer and request for quote
> >>>   generation via TDX_CMD_GET_QUOTE IOCTL request.
> >>> * Upon completion of the GetQuote request, check for non zero value
> >>>   in the status field of Quote header to make sure the generated
> >>>   quote is valid.
> >>
> >> What this cover letter does not say is that this is adding another
> >> instance of the similar pattern as SNP_GET_REPORT.
> >>
> >> Linux is best served when multiple vendors trying to do similar
> >> operations are brought together behind a common ABI. We see this in the
> >> history of wrangling SCSI vendors behind common interfaces. Now multiple
> >> confidential computing vendors trying to develop similar flows with
> >> differentiated formats where that differentiation need not leak over the
> >> ABI boundary.
> > [..]
> > 
> > Below is a rough mock up of this approach to demonstrate the direction.
> > Again, the goal is to define an ABI that can support any vendor's
> > arch-specific attestation method and key provisioning flows without
> > leaking vendor-specific details, or confidential material over the
> > user/kernel ABI.
> 
> Thanks for working on this mock code and helping out. It gives me the
> general idea about your proposal.
> 
> > 
> > The observation is that there are a sufficient number of attestation
> > flows available to review where Linux can define a superset ABI to
> > contain them all. The other observation is that the implementations have
> > features that may cross-polinate over time. For example the SEV
> > privelege level consideration ("vmpl"), and the TDX RTMR (think TPM
> > PCRs) mechanisms address generic Confidential Computing use cases.
> 
> 
> I agree with your point about VMPL and RTMR feature cases. This observation
> is valid for AMD SEV and TDX attestation flows. But I am not sure whether
> it will hold true for other vendor implementations. Our sample set is not
> good enough to make this conclusion. The reason for my concern is, if you
> check the ABI interface used in the S390 arch attestation driver
> (drivers/s390/char/uvdevice.c), you would notice that there is a significant
> difference between the ABI used in that driver and SEV/TDX drivers. The S390
> driver attestation request appears to accept two data blobs as input, as well
> as a variety of vendor-specific header configurations.

I would need more time to investigate. It's also the case that if both
major x86 vendors plus ARM and/or RISC-V can all get behind the same
frontend then that is already success in my mind.

> Maybe the s390 attestation model is a special case, but, I think we consider
> this issue. Since we don't have a common spec, there is chance that any
> superset ABI we define now may not meet future vendor requirements. One way to
> handle it to leave enough space in the generic ABI to handle future vendor
> requirements.

Perhaps, but the goal here is to clearly indicate "this is how Linux
conveys confidential computing attestation concepts". If there is future
vendor innovation in this space it needs to consider how it meets the
established needs of Linux, not the other way round.

> I think it would be better if other vendors (like ARM or RISC) can comment and
> confirm whether this proposal meets their demands.

The more participation the better. Open source definitely involves a
component speaking up when the definition of things are still malleable,
or catching issues before they go upstream.

> > Vendor specific ioctls for all of this feels like surrender when Linux
> > already has the keys subsystem which has plenty of degrees of freedom
> > for tracking blobs with signatures and using those blobs to instantiate
> > other blobs. It already serves as the ABI wrapping various TPM
> > implementations and marshaling keys for storage encryption and other use
> > cases that intersect Confidential Computing.
> > 
> > The benefit of deprecating vendor-specific abstraction layers in
> > userspace is secondary. The primary benefit is collaboration. It enables
> > kernel developers from various architectures to collaborate on common
> > infrastructure. If, referring back to my previous example, SEV adopts an
> > RTMR-like mechanism and TDX adopts a vmpl-like mechanism it would be
> > unfortunate if those efforts were siloed, duplicated, and needlessly
> > differentiated to userspace. So while there are arguably a manageable
> > number of basic arch attestation methods the planned expansion of those
> > to build incremental functionality is where I believe we, as a
> > community, will be glad that we invested in a "Linux format" for all of
> > this.
> > 
> > An example, to show what the strawman patch below enables: (req_key is
> > the sample program from "man 2 request_key")
> > 
> > # ./req_key guest_attest guest_attest:0:0-$desc $(cat user_data | base64)
> > Key ID is 10e2f3a7
> > # keyctl pipe 0x10e2f3a7 | hexdump -C
> > 00000000  54 44 58 20 47 65 6e 65  72 61 74 65 64 20 51 75  |TDX Generated Qu|
> > 00000010  6f 74 65 00 00 00 00 00  00 00 00 00 00 00 00 00  |ote.............|
> > 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> > *
> > 00004000
> > 
> > This is the kernel instantiating a TDX Quote without the TDREPORT
> > implementation detail ever leaving the kernel. Now, this is only the
> 
> IIUC, the idea here is to cache the quote data and return it to the user whenever
> possible, right? If yes, I think such optimization may not be very useful for our
> case. AFAIK, the quote data will change whenever there is a change in the guest
> measurement data. Since the validity of the generated quote will not be long,
> and the frequency of quote generation requests is expected to be less, we may not
> get much benefit from caching the quote data. I think we can keep this logic simple
> by directly retrieving the quote data from the quoting enclave whenever there is a
> request from the user.

The Keys subsystem already supports the concept of keys that expire
immediately, so no need for special consideration here that I can see.

> > top-half of what is needed. The missing bottom half takes that material
> > and uses it to instantiate derived key material like the storage
> > decryption key internal to the kernel. See "The Process" in
> > Documentation/security/keys/request-key.rst for how the Keys subsystem
> > handles the "keys for keys" use case.
> 
> This is only useful for key-server use case, right? Attestation can also be
> used for use cases like pattern matching or uploading some secure data, etc.
> Since key-server is not the only use case, does it make sense to suppport
> this derived key feature?

The Keys subsystem is just a way for both userspace and kernel space to
request the instantiation of blobs that mediate access to another
resource be it another key or something else. So key-server is only one
example client.

The other reason for defining a common frontend is so the kernel can
understand and mediate resource access as a kernel is wont to do. The
ioctl() approach blinds the kernel and requires userspace to repeatedly
solve problems in vendor specific ways. They Keys proposal also has the
property of not requiring userspace round trips for things like
unlocking storage. The driver can just do request_keys() and kick off
the process on its own.

> 
> > 
> > ---
> > diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> > index f79ab13a5c28..0f775847028e 100644
> > --- a/drivers/virt/Kconfig
> > +++ b/drivers/virt/Kconfig
> > @@ -54,4 +54,8 @@ source "drivers/virt/coco/sev-guest/Kconfig"
> >  
> >  source "drivers/virt/coco/tdx-guest/Kconfig"
> >  
> > +config GUEST_ATTEST
> > +	tristate
> > +	select KEYS
> > +
> >  endif
> > diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> > index e9aa6fc96fab..66f6b838f8f4 100644
> > --- a/drivers/virt/Makefile
> > +++ b/drivers/virt/Makefile
> > @@ -12,3 +12,4 @@ obj-$(CONFIG_ACRN_HSM)		+= acrn/
> >  obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
> >  obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
> >  obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
> > +obj-$(CONFIG_GUEST_ATTEST)	+= coco/guest-attest/
> > diff --git a/drivers/virt/coco/guest-attest/Makefile b/drivers/virt/coco/guest-attest/Makefile
> > new file mode 100644
> > index 000000000000..5581c5a27588
> > --- /dev/null
> > +++ b/drivers/virt/coco/guest-attest/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_GUEST_ATTEST) += guest_attest.o
> > +guest_attest-y := key.o
> > diff --git a/drivers/virt/coco/guest-attest/key.c b/drivers/virt/coco/guest-attest/key.c
> > new file mode 100644
> > index 000000000000..2a494b6dd7a7
> > --- /dev/null
> > +++ b/drivers/virt/coco/guest-attest/key.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +#include <linux/seq_file.h>
> > +#include <linux/key-type.h>
> > +#include <linux/module.h>
> > +#include <linux/base64.h>
> > +
> > +#include <keys/request_key_auth-type.h>
> > +#include <keys/user-type.h>
> > +
> > +#include "guest-attest.h"
> 
> Can you share you guest-attest.h?

Apologies, missed a 'git add':

/* SPDX-License-Identifier: GPL-2.0-only */
/* Copyright(c) 2023 Intel Corporation. */

#ifndef __GUEST_ATTEST_H__
#define __GUEST_ATTEST_H__
#include <linux/list.h>

/*
 * arch specific ops, only one is expected to be registered at a time
 * i.e. either SEV or TDX, but not both
 */
struct guest_attest_ops {
        const char *name;
        struct module *module;
        struct list_head list;
        int (*request_attest)(struct key *key, int level,
                              struct key *dest_keyring, void *payload,
                              int payload_len, struct key *authkey);
};

#define GUEST_ATTEST_DATALEN 64

int register_guest_attest_ops(struct guest_attest_ops *ops);
void unregister_guest_attest_ops(struct guest_attest_ops *ops);

#endif /*__GUEST_ATTEST_H__ */


> 
> > +
> > +static LIST_HEAD(guest_attest_list);
> > +static DECLARE_RWSEM(guest_attest_rwsem);
> > +
> > +static struct guest_attest_ops *fetch_ops(void)
> > +{
> > +	return list_first_entry_or_null(&guest_attest_list,
> > +					struct guest_attest_ops, list);
> > +}
> > +
> > +static struct guest_attest_ops *get_ops(void)
> > +{
> > +	down_read(&guest_attest_rwsem);
> > +	return fetch_ops();
> > +}
> > +
> > +static void put_ops(void)
> > +{
> > +	up_read(&guest_attest_rwsem);
> > +}
> > +
> > +int register_guest_attest_ops(struct guest_attest_ops *ops)
> > +{
> > +	struct guest_attest_ops *conflict;
> > +	int rc;
> > +
> > +	down_write(&guest_attest_rwsem);
> > +	conflict = fetch_ops();
> > +	if (conflict) {
> > +		pr_err("\"%s\" ops already registered\n", conflict->name);
> > +		rc = -EEXIST;
> > +		goto out;
> > +	}
> > +	list_add(&ops->list, &guest_attest_list);
> > +	try_module_get(ops->module);
> > +	rc = 0;
> > +out:
> > +	up_write(&guest_attest_rwsem);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(register_guest_attest_ops);
> > +
> > +void unregister_guest_attest_ops(struct guest_attest_ops *ops)
> > +{
> > +	down_write(&guest_attest_rwsem);
> > +	list_del(&ops->list);
> > +	up_write(&guest_attest_rwsem);
> > +	module_put(ops->module);
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_guest_attest_ops);
> > +
> > +static int __guest_attest_request_key(struct key *key, int level,
> > +				      struct key *dest_keyring,
> > +				      const char *callout_info, int callout_len,
> > +				      struct key *authkey)
> > +{
> > +	struct guest_attest_ops *ops;
> > +	void *payload = NULL;
> > +	int rc, payload_len;
> > +
> > +	ops = get_ops();
> > +	if (!ops)
> > +		return -ENOKEY;
> > +
> > +	payload = kzalloc(max(GUEST_ATTEST_DATALEN, callout_len), GFP_KERNEL);
> > +	if (!payload) {
> > +		rc = -ENOMEM;
> > +		goto out;
> > +	}
> 
> Is the idea to get the values like vmpl part of the payload?

No, to me vmpl likely needs to be conveyed in the key-description.
Payload is simply the 64-bytes that both SEV and TDX take as input for
the attestation request. The AMD specification seems to imply that
payload is itself a public key? If that is the expectation then it may
be more appropriate to make that a separate retrieval vs something
passed in directly from userspace.

> 
> > +
> > +	payload_len = base64_decode(callout_info, callout_len, payload);
> > +	if (payload_len < 0 || payload_len > GUEST_ATTEST_DATALEN) {
> > +		rc = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	rc = ops->request_attest(key, level, dest_keyring, payload, payload_len,
> > +				 authkey);
> > +out:
> > +	kfree(payload);
> > +	put_ops();
> > +	return rc;
> > +}
> > +
> > +static int guest_attest_request_key(struct key *authkey, void *data)
> > +{
> > +	struct request_key_auth *rka = get_request_key_auth(authkey);
> > +	struct key *key = rka->target_key;
> > +	unsigned long long id;
> > +	int rc, level;
> > +
> > +	pr_debug("desc: %s op: %s callout: %s\n", key->description, rka->op,
> > +		 rka->callout_info ? (char *)rka->callout_info : "\"none\"");
> > +
> > +	if (sscanf(key->description, "guest_attest:%d:%llu", &level, &id) != 2)
> > +		return -EINVAL;
> > +
> 
> Can you explain some details about the id and level? It is not very clear why
> we need it.

@level is my mockup of the vmpl concept, and @id is something free-form
for now that the requester of the attestation knows what it means. This
id-scheme would follow a Linux-defined format. More discussion is needed
here about what attestation data is used for and opportunities to define
a common naming scheme. For example, what is the common name of the
guest_attest-key that supports retrieving the storage decryption key
from the key-server.

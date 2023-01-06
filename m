Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AA165F86F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jan 2023 02:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjAFBAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Jan 2023 20:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjAFBAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Jan 2023 20:00:37 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1692F792;
        Thu,  5 Jan 2023 17:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672966836; x=1704502836;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0b9xfC+GjgDFSB5V/RacZDvfaZtGuGlB/6pLG3MqCzc=;
  b=Ulfb/KnEf0iXFa2sw0Giy1UhqBb83P+hQEIWHv4SbPFA06NxRyyBoaLg
   Vvwqgvpxwdu8V+VN3ZfAGucEBl5W5qvb1U2JPIoJSH+G5D7D+ulhjsN0O
   zylOnj8U7BLfqURIlKuZfRXZEi3mjywlPu98jHZYvXfP+H7Y0qgZazAte
   muz9kXFKZIkpBIunj/n/BbZ0KPJEHyWV/izR/Ftlqf+Rgwm/PphM+Awx6
   50806HhE2oKT7MQ9fZHuERxlMAbNdKDuQHzBb/u0E+QY+5Q69IKknE3fy
   3UCFS2gcn79xbp0EHTO534RscMQhk3U3gUHZpAK45ZdCO+pge66YI+R4G
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305885953"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="305885953"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 17:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763344803"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="763344803"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2023 17:00:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 5 Jan 2023 17:00:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 5 Jan 2023 17:00:34 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 5 Jan 2023 17:00:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqlIsgWMlwcP7KjqSlYJZ+mQSQLABg/q9KlpzgvLu9D2Az55qJjnuSj+9l8h0neDYAe1n+zYs8WDHcaqnLvvd3wJe7Rjv9jw7FgCJbvkuLu3jsNnGENO9epSjncS+uCwOnbkOANJHF6kZ3C+5J8eq23Tos6IGg/PZnK9dHmyu0Xj3p+qgEyTJVKKyjCVjQhO7MC4meVCgJ56e6P28zQv3I/9DRlnpIlMHXqyfZzRSnAgNmPmVtUDj24dMeVigdQ/oOIL11IQG4lTgnWNPYt3yeuRGLQZv/qP/Sc8Tdwvt3NQnnQF+GenGbEF/H59jjT/Z6ukUH+zLzwEvpj8Ht/4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQz1biJvGl+ygb4NPr1ozzBjISJCFOWGrYpwAvfYApw=;
 b=hvdxSkQ+g+pA9E8u0GG2X+THmRx5nxFFBOjp/YxgCv4AjHLPU0xyFFZYKkE8Hck9vrScdrDvdGq3ssLvLXMQnx7z+gxjfTPw3JP4w7j8G+WFiIWllsQ3fqV9+8Fydu4qZXE2yZev9Ze9wuSX1KJFg/mMsJ+VHY/MEztMlXCkD9FPnVR5hra9YXa5mQZs+kJA24BlHwoA7Tm5fUmsrCV+N0m77B6ggn//I3/W6/Qv6NJJOUKVbMTfvOcVBenJnwXQINOUEpZgELkVyQ497kr5/V61V9wLsk+3bOJrdfkvOku61s3PKcJQCZ7ur9avh0ML6+zAXgKv3Wppap1Qo2rksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SJ2PR11MB7617.namprd11.prod.outlook.com (2603:10b6:a03:4cb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 01:00:32 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::e478:cda7:b9c4:c457%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 01:00:32 +0000
Date:   Fri, 6 Jan 2023 09:00:21 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y7bg5sxEZDIaGoXK@kroah.com>
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|SJ2PR11MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d2befe-e291-4ee2-ac41-08daef8168fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVoLvfmgBPpw+Z74kbi/K53nAJrXh6dJGR7lq12U4Qide1GIv2AaN++9umqzchkEhx3CKY68zwKiEJkug07eHudky96NclueCGBfO8alHRznmo4dTcYXv414tuFHCkRvxaD/ae1qMbyEDbBo2eJIu8PYw/mZs7Eozl0hq1jhe3NOfN3+u0Ea4dnxc8YVieBnvHLVKBcoNeDZTNGb/ZTOuTRNuerx0hx+B9S5FvdCQUbjFPv9H/ihnpD60zD8fEemfgXE7qjwqwDr/bKaqNxniDP008f+pZf0aSakEsHS2H/i8FETafPUhDjTd9Gzyj3EQ8DggBjhOMwnNzaozeHAn23qq8NsncM/SMJJJNJH4KXHiVTnaveijOBTdmciW8IQx94CeVXCo+nUTJMuk/V7hoWjXNEyRp7qORUe0lwrlzaCB547Y6Sd01g6owkrSl8KuDvd3VEeI/QxRalp9b8NFcPr4E9aBU+NTrCd3SoWCYHxPdz3N18S9/aTmFl17w7yQfGDTbCZoKZG+bSmax6ReRhZBiDcuPpQdOc6+bhKZic48gF6sX01Lj50LTexKmEsJvKFS0V3yB9rVRWxbYDGfmJycvwbolS6xGc4OJkyWhoTqcL0YQpyYDKcQTN1LVNx4dqcF7NKoQDDSpp7D19iWZilj2ChgK/W3fFIAN0SQjpMlempo9+yLVwucOrnC4hdxPaNu9zRwgncbEqlBF3x4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(83380400001)(33716001)(86362001)(66556008)(66946007)(66476007)(38100700002)(82960400001)(8936002)(8676002)(9686003)(4326008)(2906002)(186003)(44832011)(53546011)(316002)(6916009)(6512007)(5660300002)(6506007)(26005)(41300700001)(6666004)(54906003)(6486002)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYuQxTfPnGzLDpAG1TcQJ4Upxmt1Kp8kyjh9JKyba2fumq2le+56Ia/yFkye?=
 =?us-ascii?Q?WATvKf1AGaI9f6l23cYaYn1bMb5Debxh8L19KGhrheqiBQ9Ri7XR3/5wqo/U?=
 =?us-ascii?Q?vT899mL9nLA+Q+aZVTsURCaxGg3RZg1/NLIX6otOM9MY4AiMwjzrSffu2Wcq?=
 =?us-ascii?Q?a4BoVnPU4QgbHta3EvQVVaz8wpUlbJnRwPMcgjtJmcIZFVRpNN3H2j3ijKVv?=
 =?us-ascii?Q?3bIr0o27cwuJEoChCX2EGN1j8wubKl2PcM7kHExdrwTYSRtNYcyKo/7TnAE2?=
 =?us-ascii?Q?4Q2UoFxD9+4H0wjHW22+Gre39i8aIvLvto9nttjuSXlunzEubwGfwM5V4A0Z?=
 =?us-ascii?Q?wUOp8IOaOQ9e1MWacIqZ3e4Uxrjze+3lY885MfdVph9Fb1stqidTcjuX6HFH?=
 =?us-ascii?Q?68J9gmRNChKl+JS+tiU77ht6RgVACAHIO0fSJJk7bAdS0xZk5ZNnDPn6iATd?=
 =?us-ascii?Q?QquNJ12hhTGTspUcGf295kbUHfLLmjmrhpegHhC44JIs8IbA5iazXkstqDS+?=
 =?us-ascii?Q?SJpalbC7IhrxDiPyxjsRL9EXf1mcwOcP6+k/H6M2HYk69WJZGZ8A27Jq6V8l?=
 =?us-ascii?Q?11RUeFV3HCEdG/M8zvjN4dGD8etrqSB4Gt6W5GfHD0d9omfDh9ZHu9HL9I+3?=
 =?us-ascii?Q?FFPuGawgMXhuvZq6+26KHzTGYySjkjn3Ws1qlILG64pbg7rNkGZPbT7VP5rA?=
 =?us-ascii?Q?nU9y0uYZzi4C82ZU6DMxYQ9i1yzUouwKcYkwxpMBjK1GxdzRy7LPjP3OCZOQ?=
 =?us-ascii?Q?mUSTgf5uRX/snm0sTwxTYWUenzgkmSaP+6N2CeVb8yaLc1jt+jO89hqytKvn?=
 =?us-ascii?Q?xpQG9AsRSACkRCJ8H43BZDtrBD7blq/A4Ev9uulsBFee3GkBHDsngAw3M2LG?=
 =?us-ascii?Q?uvvvAqPlrZrrGgLqRIPoD9Zp/7mZNFY7mWfYzlJeYHv11sKiktQd3FhvyqUw?=
 =?us-ascii?Q?usLQStF3Vs1R+CDot3al849iF1bvjkB+XbBQpwCuISutYYObhXQ9W7M2wyTN?=
 =?us-ascii?Q?vnRsXDQsC3wxkt16StIgLdfiOpyJ4Mzi+kaueq0b4IiZArRvHdNusJEsBqrG?=
 =?us-ascii?Q?MiGgaQUyXrsRQuirHvCGx25idluwiP8edoClgnLklD53z/l9bdiPKPAfTA1k?=
 =?us-ascii?Q?88ZD7hj61Dy2kX7Y5nI1QlEXLIZ+8zOj5DJEYYSBMKEf6n1DAsfvmEkW0Hn8?=
 =?us-ascii?Q?GXFUhjrUDNKadATM4G/L1hzrPHU7KuuksvhwlMfw5mDiZDv3AitBNOTIT1gx?=
 =?us-ascii?Q?GSN4Omk48cSVDHbAPF6x8iKmL5WsDrjJCY70sOLbk3IK6FQ8RPM2q+NpT3SC?=
 =?us-ascii?Q?4sknyWeeaHCWKBEQqF6XOWDbFmVRCpl2AJKogoJbIlqxru3maybE9WD+Evob?=
 =?us-ascii?Q?CYCE2VAXDYPjSfEWt+kQXEEpXTPqYfml8sUoD+/Sk5Vhuoy+V8IeuCn66SA3?=
 =?us-ascii?Q?z1MfZjYKcigFUlSdcuPVKQq7mDHDaViZljfz6xQD+IGgyC/Wwa4Ft9EZkTYE?=
 =?us-ascii?Q?1Ob+Q/Rh6W78OLKSAgMl1uEf1p105dxnUP+Nj4BzKKrNkvvVWz2guA+oeRf9?=
 =?us-ascii?Q?lmBKIpXljumtMPNcRfwcWiA5IXCeq3/OqKtTd8vI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d2befe-e291-4ee2-ac41-08daef8168fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 01:00:31.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GttUSQnua4tdoWka2rWjYSQ0P8BsJXWyJIv1oUMRFl3/CtGbAhqLkeaVPiK2woeFRj5Ph5ybXX25QSj88brWrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7617
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Greg,

On Thu, Jan 05, 2023 at 03:38:30PM +0100, Greg KH wrote:
> On Thu, Jan 05, 2023 at 11:11:15AM -0300, Raphael S. Carvalho wrote:
> > On Thu, Jan 5, 2023 at 10:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jan 05, 2023 at 08:35:05PM +0800, Aaron Lu wrote:
> > > > To capture potential programming errors like mistakenly setting Global
> > > > bit on kernel page table entries, a selftest for meltdown is added.
> > > >
> > > > This selftest is based on Pavel Boldin's work at:
> > > > https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c
> > > >
> > > > In addition to the existing test of reading kernel variable
> > > > saved_command_line from user space, one more test of reading user local
> > > > variable through kernel direct map address is added. For the existing
> > > > test(reading saved_command_line) to report a failure, both the high kernel
> > > > mapping and low kernel mapping have to be in leaked state; For the added
> > > > test(read local var), only low kernel mapping leak is enough to trigger
> > > > a test fail, so both tests are useful.
> > > >
> > > > Test results of 10 runs:
> > > >
> > > > On v6.1-rc8 with nopti kernel cmdline option:
> > > >
> > > > host              test_out_rate_1    test_out_rate_2
> > > > lkp-bdw-de1            50%               100%
> > > > lkp-hsw-d01            70%               100%
> > > > lkp-hsw-d02             0%                80%
> > > > lkp-hsw-d03            60%               100%
> > > > lkp-hsw-d04            20%               100%
> > > > lkp-hsw-d05            60%               100%
> > > > lkp-ivb-d01             0%                70%
> > > > lkp-kbl-d01           100%               100%
> > > > lkp-skl-d02           100%                90%
> > > > lkp-skl-d03            90%               100%
> > > > lkp-skl-d05            60%               100%
> > > > kbl-vm                100%                80%
> > > > 2 other machines have 0% rate for both tests.
> > > >
> > > > bdw=broadwell, hsw=haswell, ivb=ivybridge, etc.
> > > >
> > > > test_out_rate_1: test reports fail rate for the test of reading
> > > > saved_command_line from user space;
> > > > test_out_rate_2: test reports fail rate for the test of reading user
> > > > local variable through kernel direct map address in user space.
> > > >
> > > > On v5.19 without nopti cmdline option:
> > > > host              test_out_rate_2
> > > > lkp-bdw-de1            80%
> > > > lkp-hsw-4ex1           50%
> > > > lkp-hsw-d01            30%
> > > > lkp-hsw-d03            10%
> > > > lkp-hsw-d04            10%
> > > > lkp-kbl-d01            10%
> > > > kbl-vm                 80%
> > > > 7 other machines have 0% rate for test2.
> > > >
> > > > Also tested on an i386 VM with 512M memory and the test out rate is 100%
> > > > when adding nopti to kernel cmdline with v6.1-rc8.
> > > >
> > > > Main changes I made from Pavel Boldin's meltdown test are:
> > > > - Replace rdtscll() and clflush() with kernel's implementation;
> > > > - Reimplement find_symbol_in_file() to avoid bringing in LTP's library
> > > >   functions;
> > > > - Coding style changes: placing the function return type in the same
> > > >   line of the function.
> > > >
> > > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > > ---
> > > > Notable changes from RFC v3:
> > > > - Drop RFC tag;
> > > > - Change the base code from zlib licensed one to GPL licensed one.
> > >
> > > Sorry, but this still gets my NAK for the issues raised in previous
> > > reviews that are not addressed here for some reason :(
> > 
> > Greg, the selftest is no longer based on
> > https://github.com/IAIK/meltdown/blob/master/LICENSE, which is
> > originally zlib licensed. In this version, Aaron is basing the test on
> > https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c,
> > which is indeed licensed with: GPL-2.0-or-later
> 
> That's not what the submission looks like, it looks a lot like the last
> one from the first defines and variables...
> 
> But hey, what do I know, I'm not a lawyer which is why I keep insisting
> that one from Intel actually read over this submission and sign-off on
> it to verify that they agree with all of this.

As Raphael has kindly clarified for me, I'm now taking GPL-2.0-or-later
licensed code and did some modifications and then released it as
GPL-2.0-or-later, I suppose this is legally a right thing to do for
anyone?

If you do not trust what I've done is what I've claimed, now the
original author Pavel Boldin has given the patch a "LGTM" tag, does that
address your concern?

Thanks,
Aaron

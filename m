Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A153654A2D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 01:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiFMXln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 19:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiFMXlm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 19:41:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8900C2DA85;
        Mon, 13 Jun 2022 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655163701; x=1686699701;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dahoyOZG5/ZmSCjvnRXG/F2LkR+typ8rF7AGzP/X7Xk=;
  b=Y2SMhwjaISUfBbSDkrnn5wd7bRzhfkiJwrZ0vZ19HNLGoXZKJM1UdQ6j
   AceoEBDxf+TMbB5Oad2SzT3ftEmbnfVm47/SKPb4YhcW5KST5d/MU0Z+q
   cVFe0A17CkZTY3gTrAR3zLd+hihe8UCKiKUJe0/xXdbZtf7jVvj0eav9D
   gpq3kTtpBrXHIgKz89y58I+qFsZgCBkrRcaGX1GoAzuPFi4fEWuo7XTLt
   gJ0iuiQPC8cwOdDpoSa02lpFi2BbahPgHvraPiG4Osl8lYFSPQHcHe/qf
   5uctlTyQbKrV/E4VXnBtky/38j9f2PlAT6yTnILw8OQla6Dg7oLr2Rw99
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278479207"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="278479207"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="651683809"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jun 2022 16:41:41 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 16:41:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 16:41:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 16:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWgr6L+jd69B81/GnAnsv9cqMETDXgI2GcK2TZqBHQG0BM9/xjrJJo+q7hi6ICGCf/ZtkGV0m/yk/Pn5V9/cVDIrJU1kEmJtHgzDiC/e1sE8u5ZvQG6GlXE113zfF/ih8r+mg/ziPKbtvQkVWkExphZEaMYiqQwRNGtOGJasd+J88njsepjrXUFlu3+ErpEM0Dpuxt6BaLaQbpcsf8z3kgNW4tBuVzF8ty78JTYrYzcy0TOmiyYOgNVj/apg+DfV2CpIaiMlj1AxXMqo8OjsJcPkx5kyma1D0Lqyr2QLydgCXLFv92ya5RYRiK+TRdYiRLpR6ziBHITijDJvyWngTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEUD36kV6lGCiEyGPKVfpQxFdehmSh5FPH5H8l6WNeY=;
 b=MSHCa3KpOXlHnfv10XVrjU4xo+GMt+iZZdr0w8MyPIL8mtFWPUQFY7WdfUvZcnAn/ifeKaF7yvA6fJoOAgc8zoH94LJjJtdgwPhJ7ylT67GWoyAzJin0dogrYb8enY3wZP32zzp5eOhfqBNJMRaDDezByaQd57lvITZGz85cwNLoLnpTUiV8hGIsVqARHwlDpFZPQY6jwOAUL495Feu195MNXfyrwO8qrgr+e0lSgLiIdhhpvmLAkCjS9tDNmcIfDsVlr5CAFY4Yz1g87eP186fWeH5cH2d2CET2rCY+N0jxFdHIO5QibMvOAin2IK7MOvguGXXxPlHk5RtD9KKnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Mon, 13 Jun 2022 23:41:39 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 23:41:39 +0000
Date:   Mon, 13 Jun 2022 16:41:35 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     <linux-api@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        <x86@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 1/6] testing/pkeys: Add command line options
Message-ID: <YqfLL2IyMWWWkvQd@iweiny-desk3>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-2-ira.weiny@intel.com>
 <951dc92e-b4fe-71fb-4601-d9df1319a9ca@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <951dc92e-b4fe-71fb-4601-d9df1319a9ca@intel.com>
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c46df0c-c38f-4678-3004-08da4d964322
X-MS-TrafficTypeDiagnostic: MW3PR11MB4587:EE_
X-Microsoft-Antispam-PRVS: <MW3PR11MB4587EE4389B9DF1B1D2F6879F7AB9@MW3PR11MB4587.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy3rXr7AKLywkDTNwPquLyOeGVYgWjBLIUMBDlFOg5EnyK8MrQdrP5Jh6GUUEtgru3+acDhoYp/j0BZg+0h5dwb4umd6gzdjTP3AsupT7OtEedYts60BYJb3efWw1+Pv2H3KwGQbS6XOBRKSbDcSsksXEn2pgrVXwJJMJHVEot2qxKgRwNvdKIIo6hD3mqcXBpJCneuaAK9Ha+JfLtESoOGmqPJSkVGji2VLglb8Bdk4NUE5nAtj/k6N/zKsMiB7ENdar79Il/fH1GdmciCRQ0/9KfXPhgILAYlbNKPJ2RuhZI8NuihtHFi7uCShmHCIeVqr4md6tBACNn4YwdeS/k94h0EKN0iF8vlILAWntHwm44eGNzxrXMqqcyitLTr7XWa1MpwefOCEbcAyar1PW3iya7L0GUJAxthS2Uvgr7X/X81hpFvEKHpNZ8HljyuihZmYDLxsZ0gpjKikGu1g4/Tkm7PbM6jzNzMre2eyjujijYNkRFf0FKKknIILDbIl7RVBd/QQPmys+fjt+jGWTq3E8Hz6igoi6bYBWReT8qlV/q/A25RxYpbLJim7cF/odpFF9DW+tODIkp3kURNmHTCxP0DzMIQRJRbpcu1Dqgg26YfTlV89cysIXF4J3aeNnkRyvgJV+o2e9j0ebn/tf6KrmfrQSSjXffAQfoz0xuSS4APj36FuoWl/5u/rFAAP6mndWbZgvc1bvOVISmMbFV05UNrMvjiXweZUreQ6Lkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(9686003)(26005)(53546011)(6512007)(4326008)(6636002)(66946007)(54906003)(38100700002)(66476007)(6666004)(33716001)(316002)(66556008)(8676002)(82960400001)(86362001)(44832011)(5660300002)(8936002)(6862004)(2906002)(186003)(966005)(6486002)(6506007)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wNzB1b82465olZpga5YftUpxF8cRreyTY6fTSwU3DKktdb7gpc1hzmiFLl0E?=
 =?us-ascii?Q?Voh52F+z2SWwm3Mf9Wyu3RGrtu+m2oRXtVWTWvUe7eAb0Wttol17lblIT8oY?=
 =?us-ascii?Q?ppO/8CQaOj3GULMkHsyctfoMEviXBBhnuhCDn+M7FM7djx+lhtZFVm4oFfpd?=
 =?us-ascii?Q?BeVkjiESA/kLUBT4+DHBy7vsLN4TfaL3du7dqA2kVq7dPTJFaPhgf4rmCu2e?=
 =?us-ascii?Q?NZgIoSWQUC+DJMt+JI8thI+szjaM2eaBSgY8SPhduxEXmkozvtgZVOM0EtR+?=
 =?us-ascii?Q?SRLm28c4fex+Snymt6gcx5XvlRb05p/HtfOnONqqVuumecmpO/po66isCpRJ?=
 =?us-ascii?Q?PE+WIscgyGHPGHWiySckqNwesJEqjKeimWp2yHIEmZKHpj6Cij6ucrq035JD?=
 =?us-ascii?Q?RPxRAlFofaUwYnLI6NV6EGcMeqGQaJpnC4Dvc2TUyupj0rrwco1Za8H62onX?=
 =?us-ascii?Q?3BKE0jsbtUr7KV19vB61+TWuBDvDTMRkiPrUTi5ZMYBKC7W6BCnTKnT1JSlG?=
 =?us-ascii?Q?jv942dBlsZE0uqC7xCI2l5Lo0iakoaflWs+MHV6VLNFv8Ykmj0z2XHshP778?=
 =?us-ascii?Q?TfPFWTnGAe3lWEogns10V+DTWvzIXGpU8qx4OKYNdgFmV9chmmEbK/+dBNtL?=
 =?us-ascii?Q?Tykg4gDdbe6Rh+LPUuR5Ufu9yr+pt5syGw0M7dNWDS8zkPllRw7ucoBJwRAT?=
 =?us-ascii?Q?8qBwQcQxqHV/8YwH/9KyREbWRyE4rwPa/pMVIYfFtUKd0BN+JUK6CsL96TlV?=
 =?us-ascii?Q?PRlTiYGmqx1/wA1zzPVT+sFIH6ru5mZQKBQHSeBHKD/7sRpoJJpiwdVTison?=
 =?us-ascii?Q?iK8PEAVMkqbqiMZ0p6yly70G8tZ5DvBrq8yIJPlNxnDGl8dAyzNhWbmf4u7d?=
 =?us-ascii?Q?jZsf873845gxJ8E3flJcTMe2wsrB1acfErJzp2WtN8YlEk/We7jNvD6CmJ7a?=
 =?us-ascii?Q?enn9X4mj1DMdzugG/hzw9Euwa/TPn0p137T+/e8tgf4MTU+flSnlsJWsNU1j?=
 =?us-ascii?Q?06V/htgcgrsfCZLGzjSy9dRuKdPgQvwQOBZ4YHO1q5l8k45cowTdUzekQWrB?=
 =?us-ascii?Q?t8h55qgvIbt4VjoogSl58HL9TiIc8crjN4wwQQO5gUFWOmyET9U5SIzXo9h7?=
 =?us-ascii?Q?14WJCum0dOI6BUoiZMjYmbDClBf/AvYmkbuiedNQRUQh7jbjNZAUvO7g11qc?=
 =?us-ascii?Q?k8/0sdgI3jKl168XxLOkum2q4gjdnesKMNb+CNtYzuUEnSuKkj/aQpZnRzGf?=
 =?us-ascii?Q?mOaepg7qWn++4eWAFpQY8ivqdWLHyk758i/g8FU4AJPL8bldctmFilNPokDM?=
 =?us-ascii?Q?n4yigBvtm4RJdzHuf9FO3LiLNgxbo4XBKNm+cQpJpmRFnvSQTBvZvbbvMCHc?=
 =?us-ascii?Q?MKbaPGzyvccfMpL5F3fc26zIT9aB25RLhnxm1bYDZ3J7dgjCLTkYne3GA8jc?=
 =?us-ascii?Q?p62rSAn7Ft2pRGtk6bITEzuQaLuNHmrl/nn81cWKMimvuWW4Oh4g9L3gWJtS?=
 =?us-ascii?Q?PJN/o223cytj+4r0tAfbij5lhbJtD/HSKRxId1o8nwuzyEE37TX1gjYNQE7l?=
 =?us-ascii?Q?dk/7QH4bSxaSzxboaMg04bLVEnOhl0azOrBm5sVcl1cWK+ukmOCJBgIplpHM?=
 =?us-ascii?Q?2+l3sEKnoY623q+eay8CS7ajdrtCLf/3ONg9CpwjQxJq4QsOMBt3eq1F1sB/?=
 =?us-ascii?Q?urVObm7hsbjgs0Fy2v4xxbLdbAv4a99rWwO+51j6oG2nZioUrVCsTvwPi1fu?=
 =?us-ascii?Q?Dv5Cb2NbLA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c46df0c-c38f-4678-3004-08da4d964322
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 23:41:39.4187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3qwfGQ2zySBhbsY4XBIcweIurCNVdQ8nmgc+VxoQMuqRHlOE1dnb9atkzEn+odDOlbPGacfydLlgCvaxRlmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 13, 2022 at 03:31:02PM -0700, Mehta, Sohil wrote:
> On 6/10/2022 4:35 PM, ira.weiny@intel.com wrote:
> 
> > Add command line options for debug level and number of iterations.
> > 
> > $ ./protection_keys_64 -h
> > Usage: ./protection_keys_64 [-h,-d,-i <iter>]
> >          --help,-h   This help
> > 	--debug,-d  Increase debug level for each -d
> 
> Is this mechanism (of counting d's) commonplace in other selftests as well?
> Looking at the test code for pkeys the debug levels run from 1-5. That feels
> like quite a few d's to input :)

I've seen (and used) it before yes.  See ibnetdiscover.

...
# Debugging flags
-d raise the IB debugging level. May be used several times (-ddd or -d -d -d).
...
-v increase the application verbosity level. May be used several times (-vv or -v -v -v)
...
	- https://linux.die.net/man/8/ibnetdiscover

But a much more mainstream example I can think of is verbosity level with
lspci.

16:29:12 > lspci -h
...
Display options:
-v              Be verbose (-vv or -vvv for higher verbosity)
...

> 
> Would it be easier to input the number in the command line directly?
> 
> Either way it would be useful to know the debug range in the help.
> Maybe something like:
> 	--debug,-d  Increase debug level for each -d (1-5)

I'm inclined not to do this because it would encode the max debug level.  On
the other hand I'm not sure why there are 5 levels now.  ;-)

Having the multiple options specified was an easy way to maintain the large
number of levels.

Ira

> 
> The patch seems fine to me otherwise.
> 
> > 	--iterations,-i <iter>  repeate test <iter> times
> > 		default: 22
> > 
> 
> Thanks,
> Sohil

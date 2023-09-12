Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1B79C6F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjILGer (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjILGep (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:34:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179CAF;
        Mon, 11 Sep 2023 23:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694500482; x=1726036482;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7E0H9ixOKV6DqCMSKJwANw3YhruT4j+FU2cfqV1zMW0=;
  b=gk8kPDOQT1hTCHInVTjJsQwWHbZ6Npca9ze0YZTpF5xxke611g19/Fjr
   DaQ5/1NcpSt/dTZopj2Db2FIZmRUNRa0ETBynIfFSxSLCp3KTRfWkIYQ5
   IXW6Fzr0akUiblDl1QNszFPZOc6bt+MYX8xuv95pUUJZpxTenc7ZSqeYn
   dX/NFZhTiWjOGJANsLthdcuM35+c6Yl1CnL//GYmTMEMJq6ESZaPrTxmJ
   UdSeHgdko6fNORGB1ju/VY2BZ2SSSUcrjipAdcOZK7S0wA5Pq/y656vaS
   oFGEPCzP39oxNfLjvtwkZe0FWIV35Ef8A3asr1/uaW9R7HNQ1NSlKBRvl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375619884"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="375619884"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693381754"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="693381754"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 23:34:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:34:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 23:34:34 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 23:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfrh37eMkPwpUAR2bZ9ZZDSXHNk3JfK77rZPLSxP1sxt2OukwwEoPKHYVeAeodTcfOflW3Bi0A8ASKhxBw/chhkSR0+0KEAwGbhlN+dOCrW+k4p4mTR71it4m7iNR/tAzA+6uvjpcSe61cdUUyJB1cluhoQWLN7xGHpiTc+Y8WyDav0ybPEf2gGjq4rOAaA/8Ntk4qXRr+zaWGdYnHqpF6b6a82OPXeRoHO5NgHbvy9oRP2KOAA9s7mhr0bReAEnoJcq8dt7VN0zPLD7uaxVa8cxA3Ru+hOKjUHZFKdGvz5IE4z5pFNwrwxyLH8JXWfGXuPw+z3rM2hbQJMfy7lyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0811dn8HyBlGyFRNy+doyvnGXVOx2dvmbDmq2+ETfQs=;
 b=YnKDNxTuKgWS5t9pPiwiz1yyffFzQ9VqcnxRh8WYW2Y8lJeRMhMeM9sKHrPVpCFjINApeYlJulgZUx1RF3MXz4gQtOCsAC/S1R2gVRnN4fz6SAMjaerfdIRJKhVH6ggK8Lu08rxIRit6sbnd6FGzu0ZwiJiZuEeG1ewvDZQfUvxXY9jDaR/jG21B/S9+DD3u4RSC0TtUUKQVgoEjbk4qckrkuUTzwz7IaqQMkrr8gffLz79bNPt5n0mgawjS+6FNuXWytkcrOB6ClCTPoEGxOTtX2BmUbGWI3tlkqqOKlp5ZUysRueHZvVZxCrE+h43tkiBs5k0I3fVKV8ZTJRLoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:34:32 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:34:32 +0000
Date:   Tue, 12 Sep 2023 08:34:21 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH RESEND v3 2/2] selftests/resctrl: Move run_benchmark() to
 a more fitting file
Message-ID: <gjyv2lwrrw3n5n3olcedjjvhbyqqikic5fvuquc74srybgylq5@uxpvgadeuhhp>
References: <cover.1693575451.git.maciej.wieczor-retman@intel.com>
 <7026d06ce116c4c5b5454c814cda69387c54e2a0.1693575451.git.maciej.wieczor-retman@intel.com>
 <e0fa9375-0b50-af89-81d3-eaaecf19a788@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0fa9375-0b50-af89-81d3-eaaecf19a788@intel.com>
X-ClientProxiedBy: BE1P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: b644a9f5-b27d-4a8b-4fe8-08dbb35a5324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7/iZranWPfanlv/EpseyPLYqBprzUD+xCJvcntxmsO/A8I3usZyA3IZdxK3P1uOUIgnbaZjW1irM7zmWGZkL5SYnyw0+PUlkaFCPnNx0En9o5SJZMPok8cW1QfTwQt7dg158EIL45dYev2CXx/aRyug9BdoOPita7uq9sRyO2WZIoLT2Z9mN4QJyoYvZpTiJH9rXz2DKHN3GVnP/2wgFCFWU/l0KZe6c8j2enmSWAy/3/u4UAwBT6zS9+N+t1ZfLdTU5eSb0uCScau4dcH/l724nxXGDz/j8XhuDf8S0HAz0C6AayK+adb+wvqlTkZPx9LIQypI9Q14qCAL8ydFsicNh8bJvzccZgV/eZ7YU+r7NyDYCbObJj9C22iKhF2IXn2kbaSNrXRHfhq5RKxJrqmBDBAXVKhtuXsfnHTduG3KNPITanSKtrGaPErdCogoUBsU1oVaLMepmyhZRufb5FIn1C2h5F6MXEPT4xUlviZ7tuigAVYwGfpASkJgtxBgKO3DFvyvm8i/p+kG74+NTM6MW5WmX8SwVYH+rKltuvAdgtaR+mk2foOMVO3GtMN0Ur4wgc7G2g1LyndimAa1RwkkIlV9PBJvSaTpyoBZFQ+ZlUCeGw8rj8u4QlKNs2St
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199024)(1800799009)(186009)(66946007)(6506007)(6666004)(66556008)(54906003)(66476007)(6636002)(53546011)(6486002)(6512007)(9686003)(316002)(41300700001)(478600001)(8936002)(8676002)(4326008)(6862004)(66899024)(26005)(5660300002)(82960400001)(38100700002)(2906002)(33716001)(86362001)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YtWFAVrY9OjB5B1fX6M+frCYAwf2joUI6WwpcLhGZ9rN9yR71agBCK2mb0?=
 =?iso-8859-1?Q?OEJdBcuXNXYx8RENRvd0wgkUWAoCpYYS8QGwxBgSmRLEsFF506Ie7O9Rud?=
 =?iso-8859-1?Q?FjzdVVKadC53DGFDDQgaWG4sp1OQGAVekkEGTcGd6sYtx0/MReyKl7YIDw?=
 =?iso-8859-1?Q?8d3JvZRCPtZNygMYYIs6MroETtD2bG1sMBABTPZY9heZsihqqNvVsyEpI5?=
 =?iso-8859-1?Q?ANRQqKb8fdBwvA71DBVSG0xuugo7oaN9LbtkavFYcaGMaSxSXHyj79bI11?=
 =?iso-8859-1?Q?1RvFKve68oDcHfQEaW+zNLyHj7s5dYlQcXCayVFmzqrbfU80xeLMXXaMjY?=
 =?iso-8859-1?Q?/oO4EipaDgPlAj1ERoQUVJB+jfgL9aguQl5gQf4vOMRb8X/DehhRBjMIXb?=
 =?iso-8859-1?Q?7C9ffGqWXe2qDQisDxrrb/tXjxCwO/aZjcrMMFCtzarOw6vxH439Tx/nn7?=
 =?iso-8859-1?Q?RTCxYfvjarW9jNDi6sv21+tjBAsZ2kCllzvA0hUMHyfcnJL5KFkNKSH8tZ?=
 =?iso-8859-1?Q?K2ofvxcJeOyS/Q7YIcDTPau8c19fFP06BlYFGoeFnxD2r3L6C966Q7WIme?=
 =?iso-8859-1?Q?UDWbQryGqA2BXr4Vb/aYmF3eiLi45aEvMIDxCEuw+6W2AVSwB7mZa5fwXC?=
 =?iso-8859-1?Q?SW8ZWeaFcEWQedwYhI1sBP9s5J+K8UGunHMi1JBOKcdKvazhNmI690bEZG?=
 =?iso-8859-1?Q?UtYsUoTgjRHNAxgjAD55cQ3LYcjW5RTRzKMP8uWCt5jJFzKLWZoxQd65yT?=
 =?iso-8859-1?Q?+aqOisQPVNlxJGg4UoK3qq5PkQNOXxZGXxaihr5BEBioJPAh9TVIy4qNv8?=
 =?iso-8859-1?Q?KhnJG1l7Lwj5q/qJy9RkJYon399spivzWkQabTeVwO+iuAxhhUVvy7eYhA?=
 =?iso-8859-1?Q?hLMoNpRfyzQiq37J2K2lfMdKm1VZ7C+HCowbB4XiyY/FAW6lP1oKfswyAZ?=
 =?iso-8859-1?Q?fEOnsajOK85w+dEIqtAYYlkNNN4ZDXY3txM7ZXzWrcq7OLZocjkUI0XQQs?=
 =?iso-8859-1?Q?ePKd51cTaFf7AjmpLjMCNFSZUvczmsqfQvXsYJ7lyDcURNSOpZBX7+KYF7?=
 =?iso-8859-1?Q?1u5RipqmeROztm220Z2PfSvs2H4/bkTlkQ4VyIerHIK6vHaOdtU8nSCi/1?=
 =?iso-8859-1?Q?duiurGjq/LYIW4MMlzXZQvyKI3/VZr9JrBjM4DGcnnpTC9bTZg6+jKTQXf?=
 =?iso-8859-1?Q?+PvjPqw1jn4rdSzdNSn1F2lvxSELnfn0kMFKGjbZ/DrR2NifSvsZAeBcxn?=
 =?iso-8859-1?Q?8qpSGAEq8nyw0uTuqe8QqT7DiewpCbkbm2Hp94ytsYoEYjmTyU3LwRWsXe?=
 =?iso-8859-1?Q?Yi4bXSchYPQIS9grXnvm/294xLhOQ16hYOHFkoo2JEMqjDxS7bFIdD/5mW?=
 =?iso-8859-1?Q?UVe5rlBKM91HcwGZ8joH/t0v6QJGV+nOjYeACZR3DNa2trrlltHDh4CuhF?=
 =?iso-8859-1?Q?l4wg0udcgihWTGXk+WAP6dzGz48O2uOiDY4RetElE2Y4jWKYpNabCKBqbi?=
 =?iso-8859-1?Q?U3Ev3abL1wL0Wv2aaGtgLw5UCXKZDCmuaSeYut4wJDcfvlo5o4WaksIPcP?=
 =?iso-8859-1?Q?Dzucsuo8TJvlvydOu6kawaZWLSIx0dCcRVb2GBaSUrvlJZqoEeeeqCqFqW?=
 =?iso-8859-1?Q?t+PaQTlARBGOhbdDDdERO/vFmfRwALcB8RbF3DZ+29lizJuctt09leyKBI?=
 =?iso-8859-1?Q?ogQxuvTkCSfQI0ojplk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b644a9f5-b27d-4a8b-4fe8-08dbb35a5324
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:34:32.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NN55S6kumbCz1ZgAkzfBNMaRmX52uc7nKEC3iTm3z4gOQGI74VCb4vCXxdRNWGMHCrlmkuMKLCTcRV/54+hrH35Dgdl5LmDfQxGkeaiy7yU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 2023-09-11 at 09:59:31 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/1/2023 6:42 AM, Wieczor-Retman Maciej wrote:
>> resctrlfs.c file contains mostly functions that interact in some way
>
>This can just be "resctrlfs.c contains ..." (no need for "file")

Right, sorry, I'll correct this and the one below.

>> with resctrl FS entries while functions inside resctrl_val.c deal with
>> measurements and benchmarking.
>> 
>> run_benchmark() is located in resctrlfs.c file even though it's
>
>same here
>
>> purpose is not interacting with the resctrl FS but to execute cache
>> checking logic.
>> 
>> Move run_benchmark() to resctrl_val.c just before resctrl_val() that
>> makes use of run_benchmark(). Make run_benchmark() static since it's
>> not used between multiple files anymore.
>> 
>> Remove return comment from kernel-doc since the function is type void.
>> 
>> Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>
>Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>
>Reinette

Thank you for the review!

-- 
Kind regards
Maciej Wieczór-Retman

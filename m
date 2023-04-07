Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353F06DA6F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbjDGB11 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDGB10 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 21:27:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334083C0;
        Thu,  6 Apr 2023 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680830845; x=1712366845;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qe8hCKCwuiZDXDM7gYixz5iIt5q+1TItp2JgxYgacng=;
  b=DAoWr+x1cmZHZHNvL8pKaPtBZwyf7w8M7+vYNrAJ3FdbVJWBV/O4S9J4
   73lz9jOsq2I6VdgVcjhD5JajIbAgviWqc+Fk0NtX6RrQG8WxTiI1lRfKc
   xzV+BQ6FRORuKgIOAESkYFY0Dg60Zpm5cbLQhJ/UAJ5JMlP2HRoykdLjb
   VWdExO6yiPV2Xm00cQh4XbeQvDBPsmXKc/W2iHDvCtZahs19BZHQPm8bh
   fwPARCwmdgHWHveWTOKmOjbwG3WjMMX1Aev4N1tmEhuFXN/9+rEDWq2n1
   twGaehO+FBhvRgye9nUmud4o837p9Y5R1TS6D4HwkSKO3jWachBX/3osF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="331527538"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="331527538"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:27:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="637531408"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="637531408"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2023 18:27:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 18:27:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 18:27:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 18:27:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 18:27:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIQk/Ee+B9okzr5t/2N89QYK87nw5m3HxJs5Pt3Od4vluMl4AOdbCGb+YJnq2EcsVD6Zz7Yfs1N9JKQTiP3aNVIjM67D5T1kFpvlJaU2QQScPxskmmg41pJvz+zVDwlm8r4FUPo5TO6rCinOLkO3jhaXGZNAMlqCV83tbgR7nZjyYf9xMLWqzXxnE57pcqbRDkR3y7U4Rvutb8v0rm9MSQRmXNJUpmcsbA8qoZx3vtInPTkDFvZ9YSBpRQPGInCs9d0Bv4jXvC5KuZo+liMlDwYt9Aly6JUzgq2UvLi9yrFnQvSX3nGjcznyA9eIIVEB8UOrdGiCmDjZjZmTdp2fNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQEQhCXg+I5rQXYjeTmIXUQm8ImUko6yK8SCpaHq5YI=;
 b=NnMeF3FZqEIhdt1EltSncQUuU+krMnTXO8gdbvkVmFegIxVrh6vm3rEiuKc1v3NW4jLdMhZ1MLELUP/cxQpYQhiUkDm1y6iJhvtPCMsVxxLubKXzYROm7pLhJsS8Hj+Mqv8E7alKD1t9AVitH6Xu4ub1pnCjDYX/R9HZhfiRM8lTNdtq2r71sTRZ84glgarjqhBc3Zupu0fVTkCjMVnUgvv9Epfpn/F6KARzAPUSDPzV2ZjmDu1JaR9IkM+etdaZ9Xvl+bS2xBJZSSeJvdjT2b5kqYXKJBrGE4ZD/qf743CNei3tET7aYcxk/prjoW3WPz8Avuhq3kjeMjt/dqHCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Fri, 7 Apr
 2023 01:27:15 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%8]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 01:27:15 +0000
Date:   Fri, 7 Apr 2023 09:28:50 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, <linux-kselftest@vger.kernel.org>,
        <lkp@intel.com>, <linux-gpio@vger.kernel.org>,
        <john.fastabend@gmail.com>, <edumazet@google.com>,
        <yi1.lai@intel.com>
Subject: Re: [gpio kself-test & bisect] gpio-mockup.sh kslef-test failed in
 v6.3-rc5
Message-ID: <ZC9x0lQuE9Ds9Ory@xpf.sh.intel.com>
References: <ZC6OHBjdwBdT4sSb@xpf.sh.intel.com>
 <CAHp75VebjkJZkC=0ubGSVYm75M6sFAHt3kq=WqqfDmtBJrvVDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VebjkJZkC=0ubGSVYm75M6sFAHt3kq=WqqfDmtBJrvVDQ@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0251.apcprd06.prod.outlook.com
 (2603:1096:4:ac::35) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH8PR11MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 45bd04cb-87d8-480a-f36a-08db37073801
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ENMwvYqt4oh1q7SbcJ4r+o4ZD9x/u8lU87y0QSNMnBd5tt2Al8I9t9Skkou/yrfTYhrJQFI1SzGmkkTBqhA3s3thfJVHt21fPC/g7KmIXZxLecnCRPMulponwrsY+hfX+/GaQYfam9OT68kzArVatpXfTBLJTId8w4BMktNmvgEGT8nvjbSBVbe0iS/fD4M20wJ5m3hNT+azOyMg8x6jTzTWF6O/3Tfbo01ah9+3u06w+3gHio5/6BgSF4631ZsXSJ1fVwMYvBUCPt52mpvySIJrpbWqq41T+xLWNBS4pV343dLRPcOsgQuxRDMjYMWgT1yIPYqCp4bNS/fD5O9wVMMtTUIONj1RLIpE82YOQmq3gRhsi5R31I+UerqhF0EtLqfQ5O2gY70/kXxkahHHWVUOtg01/O2Wt0oh7O6fXArZF01jcmSgrUBPo4sobt+tlxP3sjzFbA7M//vTODL9OgPeHcRJr1osHnP59nmRM0E/i0mfdmpja8EjaUnLzIeeaqw4kl8eQkm1AETMbOBgDDxRxFJc+KQDXmn0GIiyhRJMcegW+eJtIzKN1Lvo7tl6hpkVPl16qcggs+QPJ9GCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(26005)(186003)(107886003)(6666004)(53546011)(86362001)(8936002)(8676002)(5660300002)(2906002)(66476007)(316002)(66556008)(44832011)(4326008)(478600001)(82960400001)(66946007)(83380400001)(6512007)(6506007)(41300700001)(6916009)(38100700002)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNnU0l3cHk5ZjBQeG9uUElMK1o3V3BNRVBtUDBHbytrRmJmTWxFOVlYV3FN?=
 =?utf-8?B?RUpWOGRWVWc1b2hXVjZhNlhrSE1COWVHcGtSY1pkMVBGVndwYU1EYnc0cjc5?=
 =?utf-8?B?WUI1TldPZGhBREtaSGNiM3ZTREFSNXpYM2x2Vi9HRVlJYnUxR0IwY2hlTXl1?=
 =?utf-8?B?VGdVcmo5QkpqUC9IQkRzdTR0T1N2Uy9aVG1WeUNCQzM3ZXJHZThGODFqaWV0?=
 =?utf-8?B?Yk1Id01yMnROZnIwbTRONWF2ODVqNnU2RjhyL2lBdml2dWg2MGhDakppRnZQ?=
 =?utf-8?B?ZG1oM1YxbXRCTDZpSUZrNzR4c3lMcm9MOTFsajZNdFd5eXZQaVJKUDFWK2tW?=
 =?utf-8?B?ZGEvdjJHR3pNWjZyaG1JSXUyQ1llMkNybkpWL0pkUDlGdkFFd0liWlgwd1NH?=
 =?utf-8?B?RHNJV0hBTk41VUNraHUrdkdzMVBVSUhIY3Z4SkllMjhPRFBqZTVUTmxqeG53?=
 =?utf-8?B?enJSS3FycXc3MzJRbHphRTN3QllqVVgvTWlJbXJNREtWRXJ0cG82aXdTTXlj?=
 =?utf-8?B?NHRIZlI4Zi9MVDNWYm1KNG8wRkpNSU1sNUplKzkrbzN3bWQrRU0rYWNPbkt6?=
 =?utf-8?B?Y2VqRUF4cEpaeWNBYm12UWR2QVVIZXZsZ2xZMzlBTXFPTDdKcEJMQStCNzVq?=
 =?utf-8?B?MzhSNGVKY1YwdUJUTTB4RUJBcVhyUUcrY1hzc2lwWHpVb09QOC9tWjJ2N0Zl?=
 =?utf-8?B?V0Y2NUpjbWI3czA0ZmdmNk9vUEladlQwL0ErQWt6NWk0T0lUeHRyNXVwUUVa?=
 =?utf-8?B?bmVvZExyeGhSWEJ3SDlNZm1Wdi9qbG5OMURrSmhHaTk3YU8vbnFmeHMzdzhN?=
 =?utf-8?B?dHVETXpvVkYxVW1iamd1VTloVzFhaUdKdVNyanBxNm9yTzBUWDNva0t6MlNt?=
 =?utf-8?B?TEdUYlpEOWVGTEFnTTRPRjM0ektTamduTzBVZ2VqZVZ2ZGtzTFkxWUNaSWkw?=
 =?utf-8?B?SUlsc3FmT2lMblBSY1ZqaXhqaDN6NjRtT3VxTVVFdkpCVUR3cGlaQWJQMGdX?=
 =?utf-8?B?bmp0UmpUVlAxM0hnUGRFUGo0K2t4dnNONm0rTG5ZdXBHYnR2Z1ZLbjk1YllO?=
 =?utf-8?B?cnVOWDhCRTlnZXdUNWdyR1BlaFlTR0cvVXZvUUJjcWUrL2dyYW13QnI1VXNJ?=
 =?utf-8?B?MEFRTm5kYTBTb21DM1VCTHZVRkxvcUd6czIvSGFHSTBSSUNQSHBmcEhDRTEv?=
 =?utf-8?B?Z1RnNjNYMVJOWUR2eXJlSm5pOE5GSmNnK25QTjFWdmpwMTVwSzZNOEFsM3FY?=
 =?utf-8?B?elZQbFZKK3RJaU9JVXcwSFB0dGJteUdKcWFpa25QOHR5bVRKZ3daSVludmdO?=
 =?utf-8?B?RjYzeEdCMDhCc0tBTk1TaFRFTi9hKzNpeUhRWEM4N29xaDVWbDZjYmcxZjBO?=
 =?utf-8?B?ZWtObWtseW84ZllhY0VuRXNJVFFhUlZ2MjlVQzY1dzZxN3ljdncxb0NrOEli?=
 =?utf-8?B?RCtEcHlkNGVSZzhZbjdvRTljS253Z3hENXIvMENndDBzVjNnUU9xanUyOGg1?=
 =?utf-8?B?TUk3V2wzU1IxYU1DVEJPMGRhYWx0K0tXZ1MvV0JUbXlZMzI2azZ5VWQvVFZ5?=
 =?utf-8?B?SEJzVG1VWEliNzFjS3hOYkZGN3h6QVN6S01rdkJJSTI4eUttZk1lUWU2U2hG?=
 =?utf-8?B?eUY0MFcyWmJPcHBrUnF1dHdTb0o4RmhPQjVBeGRsdWZmQThRd2hIcjhKSkE1?=
 =?utf-8?B?NVNFdHJxQm96OUF5eUpCK2hYSXp6bzRSSlI5SzZINURCUURkVFFtNFJaYkxh?=
 =?utf-8?B?bHRaOVhqeU5iZWdHRmZ4dVdqdWkwdGJTMEcxWEZPdktnUFpmMk5hWGtocyty?=
 =?utf-8?B?WmRtV0o0L3llZ3JVSjBmOXQ5UGhoUDVYYkhJRnBZVjNmVHE1U3l4QzNiUlZG?=
 =?utf-8?B?b0tHTnRTMy9kSEdPN2w1OUtPa1Bwc3Z1c2Zqa2tHMU1qSzQ1WlpKeGJmeHpi?=
 =?utf-8?B?aFJjY091R0tTVGhQakZqbWRhRyszamVlN1o2VlI3YVZwWTM5SXBPV2lKRjd2?=
 =?utf-8?B?VS9QOFNoelJsSzR0cTJnRVR3RnAxaVc1TVBvNWZIMllGYXFKT3gzaW1GWmJv?=
 =?utf-8?B?Z1ViODhhRkxlem51YlBPaE9ickpFRGFKNkZmNEVKa1JUM2ZSSG9jUmgyTFJY?=
 =?utf-8?Q?W2C8g1IiCkX0j7YDHq8DNZFd/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bd04cb-87d8-480a-f36a-08db37073801
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 01:27:15.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WbowanmpRhvOoi8dWP111P7cOtwh2GboS5KtQwa8CAdH3UiRn9ImdjKpI7N3T9KpHIcoUpzTLbLG6YBsEHnaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
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

Hi Andy,

On 2023-04-06 at 13:26:36 +0300, Andy Shevchenko wrote:
> On Thu, Apr 6, 2023 at 12:15 PM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Christophe Leroy and gpio experts,
> >
> > Greeting!
> >
> > Platform: Tigerlake-H and so on x86 platforms
> >
> > All detailed info is in link: https://github.com/xupengfe/syzkaller_logs/tree/main/issue_bisect/230406_gpio-mockup_kselftest_failed_bisect_v63rc5
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/issue_bisect/230406_gpio-mockup_kselftest_failed_bisect_v63rc5/bisect_info.txt
> >
> > gpio-mockup.sh kslef-test failed in v6.3-rc5 kernel.
> > gpio-mockup.sh(gpio overflow test) in kself-test could reproduce this issue:
> > cd linux/tools/testing/selftests
> >  1.  ./kselftest_install.sh
> >  2.  cd  linux/tools/testing/selftests/kselftest_install/gpio
> >  # ./gpio-mockup.sh
> >  1.  Module load tests
> >  1.1.  dynamic allocation of gpio
> >  2.  Module load error tests
> >  2.1 gpio overflow
> >  test failed: unexpected chip - gpiochip1
> >  GPIO gpio-mockup test FAIL
> >
> > And the simplified steps to reproduce this issue are as follow:
> > "
> > # Load gpio_mockup with overflow ranges -1,1024:
> > modprobe -q gpio_mockup gpio_mockup_ranges="-1,1024"
> >
> > # Check is there some Call Trace generated in dmesg
> > dmesg | grep -C 5 Call
> >
> > # Should not generate any gpiochip folder like /sys/kernel/debug/gpio-mockup/gpiochip1
> > # Because load gpio_mockup with overflow ranges -1,1024
> > find "/sys/kernel/debug/gpio-mockup/" -name gpiochip* -type d | sort
> >
> > # Unload the gpio_mockup module
> > modprobe -r gpio_mockup
> > # Check is there "Call Trace" generated in dmesg
> > dmesg | grep -C 5 Call
> > "
> >
> > Actually the judgement "gpio-mockup.sh" test/bisect judgement point is that:
> > Should not generate any gpiochip folder like
> > /sys/kernel/debug/gpio-mockup/gpiochip1 after load gpio_mockup with overflow
> > ranges -1,1024.
> >
> > I met gpio-mockup.sh test failed but there is no any "Call Trace" dmesg info
> > sometimes.
> >
> > So the shortest check steps are as follow:
> > "
> > 1. modprobe -q gpio_mockup gpio_mockup_ranges="-1,1024"
> > After above gpio_mockup module loaded with overflow range "-1,1024":
> > Correct behavior as previous v6.1 or older kernel:"gpio should not load "gpiochip1" due to overflow range -1,1024";
> > Wrong behavior in v6.3-rc5 kernel: "gpio *load* "gpiochip1" with overflow range -1,1024 and "gpiochip1" should not be loaded".
> > The underlying problem was already buried here.
> >
> > 2. Could use below command to check if "gpiochip1" generated:
> > As before v6.1,  there was no "/sys/kernel/debug/gpio-mockup/gpiochip1" sysfs folder due to overflow range -1,1024";
> > Wrong behavior in v6.3-rc5 kernel: "/sys/kernel/debug/gpio-mockup/gpiochip1" sysfs folder generated as follow command check:
> > # find "/sys/kernel/debug/gpio-mockup/" -name gpiochip* -type d | sort
> > /sys/kernel/debug/gpio-mockup/gpiochip1
> > If there is gpiochip* generated, gpio-mockup.sh kself-test would be failed also.
> > "
> >
> > Bisected and found the bad commit was:
> > "
> > 7b61212f2a07a5afd213c8876e52b5c9946441e2
> > gpiolib: Get rid of ARCH_NR_GPIOS
> > "
> > And after reverted the above commit on top of v6.3-rc5 kernel, above
> > gpio-mockup.sh kself-test could pass and this issue was gone.
> >
> > Now gpio-mockup.sh kself-test is failed on almost all x86 platform from
> > v6.2 cycle mainline kernel.
> >
> > I hope above info is helpful to solve the "gpio-mockup.sh kself-test failed"
> > problem.
> 
> Thank you for the report and full analysis of the root cause. I think
> we may fix the test script however the gpio-mockup is obsoleted and
> should be actually replaced with tests again gpio-sim.
> 
  Thanks for your info! So we should ignore the gpio-mockup module related
  test next time and the gpio-mockup kself-test is not necessary.
  My colleague "Lai Yi" also found this issue.
https://lore.kernel.org/lkml/ZCvusEIauvO8BLM5@xpf.sh.intel.com/

  If there is a patch update please add:
  "Reported-by: Pengfei Xu <pengfei.xu@intel.com>
   Reported-by: Yi Lai <yi1.lai@intel.com>
  "

  Thanks!
  BR.
  -Pengfei
> -- 
> With Best Regards,
> Andy Shevchenko

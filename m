Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B378DADD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238092AbjH3ShS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbjH3NkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 09:40:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB71B0;
        Wed, 30 Aug 2023 06:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693402822; x=1724938822;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mGUvoLw8hw2TWDxXd0tp7T6XOlpg2G3FqdXCCbW83WE=;
  b=NrfY4Yfr64aLjQBwOz6ogKJNT8o98W575pNcGnG5YlLpCyQnUBinQuvC
   h+BLb2RWOks+JAPcnMnHE27L2+Uz5qWHcx4p+4S/ns7zUcwqtzCFw0xTM
   b/UlV427NgPkOPDglY7f7VzKR8Qqc02JaRs5uwei8YgAcr+VsHWkpwLHi
   dSnWiR62mxbygKAqVSguotT1xJr3jnWN2NI/BwOYPkKEZWLLx504/mjSC
   mSHfab59hFe0SpL1tDaO/u1aGygkvtasI7B3QT2Pu1xgfHZRNaQ5vUTDA
   jZfb6wkMvwfX1uK5ia6MTbb8s9QbK8rXU/F+RgGCMNfdW3lf5diW75mAn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374556041"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="374556041"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 06:40:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="732634790"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="732634790"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2023 06:40:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:40:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 06:40:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 06:40:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 06:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koC0TQ56D7KHMAu/xMmKyIDhAjvBzD+1IjLTFAtItIjhsNKgr59Se9+ln1ipvqTNkgQBbjmLW+n+ES00G84mqYAoWArurCmmblTSeUeZf/EdU59InqxJl23wCK+ui0eSUbCcvhyWD2UvgY9jj2wA2q6vUvmGiMHxhr5ujfDMAG9b43lPKJ+gk9HQHNJIQjRVsSUEscyGry219UEy3Exw4NBOXuOtwKFTOajtv9pU5OgbURabVzQlZX/PswITKmd0QK4asnrJVLPfFiB34qWF2YqsId8rjH24C4lFDt+OgtFgZgSmVBH/ttxuI3Ov/ERLx10uDjk2DsT/UYBEofnY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vrutIHB8GJljhEyHIHyE0nB4zB+ASrA7HHF1K2205w=;
 b=ANW44ds/FGzoVDZXUtvFFUF4gDNV3LwQaapBrEEgByzKjXYZ4jVhQsuLTXbDU6fDrjNWHmMpmKZf7qIArXRVLdQ58aKrfqSeblQYq8EJb//BA483Lwj7wf4WuzoxfJqISvxtcSxvJO7Kt9CqeysY9aFfiFBGP1AdHKVOBvYcSq7toUiT+ag9kW7zshnNZhUeuYiDIWAXCDRqnNrYxD+94MtzjhrRng5vjs9dHYwd3OkmBE6oNIya9nyyZXUfB1H3AkSR6pnM8S1QW5NfMwVkfGk/hECjgmsqlpr5ZAqL2L9KbOCwnf36tL22yzjvhlW/m4PrkOtue6KnjbkYJphx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 13:40:18 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::8a29:8895:64:8fd7]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::8a29:8895:64:8fd7%5]) with mapi id 15.20.6745.015; Wed, 30 Aug 2023
 13:40:18 +0000
Date:   Wed, 30 Aug 2023 15:40:10 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] selftests/kvm: Replace attribute with macro
Message-ID: <fw6nuuhzmkp36bumrn6xuy7etxslr2iybazigaoo57iy22x2k7@nord6jkch73n>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
 <82ed62dd7070203701b4ca326e62862404dd5f72.1693216959.git.maciej.wieczor-retman@intel.com>
 <fc618e8c-f8b-c339-9aa6-1d2c2865b42e@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc618e8c-f8b-c339-9aa6-1d2c2865b42e@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::15) To DM4PR11MB6239.namprd11.prod.outlook.com
 (2603:10b6:8:a7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6239:EE_|MN2PR11MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 92640114-b954-4694-f486-08dba95ea5b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aj5oto1aWzZ8J90ILzyx8L64VfRCFvGDVbAaYgMvnj7BxRiIyiC+jUC0vVjY5eX1XB9+DsEtoHM/YDMXU9zo2HiQ83+HJQ4KJKOR6xx9eNu1ggu47oY8NRYiRVSHLnEclUVxbYkyqucFsBEUzVCzK6iYTfcYg4XPwFnWc9pBUMDgThQRpixgDjDGkDUkUsjpUJBXsUmCgSA4fXVMTB9h2hjgzctEFUEAE2cXzMLBQCCY1ulOvlL1wp+LOi/8SGd422+0+PABCMz2HtTVVdNzfZBmuec8XHYJCLL4tt+FTTSWMOEQits8avsr+mCe7/6T8XiLFn4vJ/JP4INQ4dDybV+zoG2reMaEwbyVdw1BNASYCtTjP9mzM0x4134iliGUDZBVrpkbulLxZ5a4EpMzDPiPI97A+9Ya2Car/aOyVQ/TarFNvuZHO5KxsHEpDMsxDtH7ZIkTfsN4WdXjGI/tCB714weK5GI9HeCGb42zpyyfHG7jzK1U88LnG9m3JoOUv/YqFtao2FCCheocZK2QnWyCgvO078HsHK4nsXuDvrv6G9R2eRPhkJ8OL0S99COU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(53546011)(478600001)(6506007)(66556008)(66946007)(66476007)(54906003)(6486002)(6916009)(316002)(38100700002)(41300700001)(82960400001)(9686003)(6512007)(8676002)(5660300002)(83380400001)(2906002)(33716001)(4744005)(86362001)(26005)(66574015)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fOXWyvaiWWb6QtLJtRJZw+gEZ/NDkz8ZSlQJoBFIQuAk3LsjsJaCb07VYB?=
 =?iso-8859-1?Q?Z5QdW4aq3cj9LrERDnH8o/LL/KgxC06gNyJlV5pWWcISClV3UZh8Y4zCvg?=
 =?iso-8859-1?Q?ioWlldd/6EepFWlxMgzU9LJfEUqzknajS/cDITNI/tULqI2CwZkT5SFMY3?=
 =?iso-8859-1?Q?UoPbi0uoC2469gUpKINhzF/Kmyh5Y6ktBQH/Ep+SV2veZZAzaun6VsDWBS?=
 =?iso-8859-1?Q?3MQFQF85Oeu1+w1Qx8tphOuPMTIEesyOHyjhiIhYPUZfz19CwjjK6JMQDI?=
 =?iso-8859-1?Q?E02ZOx8A6cjFUhHPrg8JR3DTSEvuGUVDzIwOU5c2HkpkJ5YCZQ63Mxd2w5?=
 =?iso-8859-1?Q?DjmEmfaHmBh9FRPUqNCvsH7tj0/e35gaXySwdve5P8ENrJX6kWyUluzD/Q?=
 =?iso-8859-1?Q?sqYW+ztOYzPBILogZZNtF/jvoBYN7C+x8GlsmJ/qk8nFgW7Ph7BNdq+9+f?=
 =?iso-8859-1?Q?aYGWdttckUu0+3XEVV60IMPFPF97kvgBz+8BCZ/TixnNMYK05lj0noXpVZ?=
 =?iso-8859-1?Q?vh36iQge/B17feosb8Omfm7lSNmq//n46bp5yYsEikxHov6CEtJAldSpIk?=
 =?iso-8859-1?Q?1cYP3wg7dBBJqj3nETkjoyUHKfEyPU1ilcrcT7gQBpt58dHccstA7drGAd?=
 =?iso-8859-1?Q?fGLTnTSntcYcBmGh5/C4rp4o7vnxnohi4+uG9UMkEGHGiYxd/J+anby3t9?=
 =?iso-8859-1?Q?i5HJyK4VHnOcL7ZCyeS+xdqbIGffEqvW7McA9gvbCl9SjgEjDhtyfz5kF9?=
 =?iso-8859-1?Q?ZfgGt0Mma9eLk74sJjFUgCvG6zsQh86VdQVqe+XiyvipcqenZ0s0gi14j+?=
 =?iso-8859-1?Q?Lu22X+iP41G/XahOYgkq1XUEXwHg413AR1QQPKgS6L9dg9QUa9xtapfRPb?=
 =?iso-8859-1?Q?/tLlx9vtOOQR1twpf+aZxJSLnhs3F3j2aIrjKJjMxQMpjU1lsSlZ584P0v?=
 =?iso-8859-1?Q?XCtUt05zGKHr28KTu3S5RgzLMVmzs9CtQ4e6KAsgXw16jDt+5SRFkBE1fX?=
 =?iso-8859-1?Q?Hq9Zfm4OB5S7HOrJLNA0NUBQDeLMGJ/Ks+esTV1D5KCRB9sfxKNuzvwDno?=
 =?iso-8859-1?Q?aeAQQgN1Evw9V/5eYf2AMCT9xzkBU0eAop9dUugt5gvNKSMEGWws0hE1qf?=
 =?iso-8859-1?Q?kpLmgOh8zcT1ZnXol+B5KEfSMA3QU8k/dDMQ+y73tII22igSFReShxIi2k?=
 =?iso-8859-1?Q?+WiP+iLrD1IbxgtP1KhoYyhfhwspBHnP347NOebwEIQ++3v8VyeHGdMdDb?=
 =?iso-8859-1?Q?NF7pmIQ1mNkqlVrMuyH9o6ivhr8/IN7DOmvbcBJvSeXXf/b+OdolmNk5hL?=
 =?iso-8859-1?Q?jbvhuuX3pELhGBXGnNuHsCKMplr+jy04M25b9aPy2V6uZWV/Yo5Rdnm445?=
 =?iso-8859-1?Q?c3RvvZbPOvKbD8xDeDDWLG6w7PjzEiglrwKlCOwtHNC2S6/kvTNow0Qj4l?=
 =?iso-8859-1?Q?W4DN8C7ftDblzrwZCLc1XFwM9TmV6YWgVV6l87VyABRphE2giOPajsoKjj?=
 =?iso-8859-1?Q?9wCtfcI53oGm3VcB/GtPjtr5ba+CRuxpG1bBteyOCdJhfMIaihmXiUckdz?=
 =?iso-8859-1?Q?OSmiheww5ePW4xUW+3uBzBGnyUrl0MbxxxKAGs3Uj/VRMpfFq+7nyqUw2g?=
 =?iso-8859-1?Q?uQFJUcfwysb85cq5k4VVXv+GY35tM4unmOxyGB+pP6XA3QfEIAc81+L8OR?=
 =?iso-8859-1?Q?PTG0tkvw19QbkXmlVLU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92640114-b954-4694-f486-08dba95ea5b9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:40:18.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBGWtS8rZZg2O573dtxzRsXF8bA1YURe6EnDAGF8UFd3OzuMV8DomeUB/G/XBu81fteqPMVnAGOUoQDDRCJ1pGRj3meb0ITfIYNsZFWZmL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-30 at 15:22:57 +0300, Ilpo Järvinen wrote:
>On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:
>
>> The __printf() macro is used in many tools in the linux kernel to
>> validate the format specifiers in functions that use printf. Some
>> selftests use it without putting it in a macro definition and some tests
>> import the kselftests.h header.
>
>"Some" and yet this only converts one? Please be more precise in the 
>wording.

Okay, I'll mention them by subsystem.

>> Use __printf() attribute instead of the full attribute since the macro
>> is inside kselftests.h and the header is already imported.
>
>IMO, this would be enough:
>
>Use __printf() from kselftests.h instead of the full attribute.

Fair enough, I'll change the paragraph to that.

>Was there a reason why you didn't convert mm/pkey-helpers.h one?

Sorry, must have just missed it somehow. Thank you for pointing it out.

-- 
Kind regards
Maciej Wieczór-Retman

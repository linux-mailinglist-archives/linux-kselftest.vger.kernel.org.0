Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9A6D927A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 11:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjDFJQB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbjDFJP6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 05:15:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770C5FE1;
        Thu,  6 Apr 2023 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680772549; x=1712308549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KmJ1hCYyfweWECEfN1HrHix6txcodlhxuTf5v7HRlcs=;
  b=adOu9hPCGQ/JfJkNgbjS3oWCCnIPtjVcvIwMBzxnV/Ug9Jel1YebaTjD
   60NxpHMWphwo85tMc1G7Hp0j+9UOaVWCdgW38oQbGZR7nLHL5R2VLpFAM
   fryzLY6IlvqW8AsoDuxksEzx/kJmE4SbQ3/5tV7vjI2Q1lI0ROSPVqtqj
   RPXPeMHNKhZ6K8lfgpRHq/1PKeYZLmO+yfCCc0eeIRjL8EmgSOKSkvtNr
   q9pEgWccysE7+Mj8WY5rJGJdgs2ZSUmh+7hCt85wFzA3cLDWgu08ExHph
   2IaO9MS5+wwgn5aGhDRIyIGhVh91lZ8Ow42c+yl01RgDQ5WyK3nGBaHZN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="405474414"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="405474414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 02:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="717379482"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="717379482"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 06 Apr 2023 02:15:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 02:15:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 02:15:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 6 Apr 2023 02:15:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 6 Apr 2023 02:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3iKckddIKgvnbf9KQ2nMwghVa2Hkyb4HICANJZfqo7783Mev1qtYkXZ6p83I69qXhpdbZyUCHshiFU5zLTq1726ctLtu6QS9amZSf9n3VKryWxYvOqftur1U1J43lciZpv0tI9vD3BfUS/ap+utckZrp2fchbWQV5NUjZ9N1vE4seozMtMeISaelmlcts4X+wnAE52WQQVgceNC0e5V9QVT51/gGPuPGhhBcR1lh14TKYEXYs7WI9jBljWCmvdffq1V8IHjBgM0qosT4JYx+qhoZLaroSVSBdjI2IKX7L56uqneaqm721XU2AfIyXHwqgXjpba3dw43C+bYJpzK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8b58Eq4f4LcYex4ciLfMkx7V7xpJhyHl4cveEjTDdc=;
 b=j5N471lDB+K3hwyVwH57LCQbmvMhmhsf03JOVPSflnTxHY62JScmWcOwRtArm4PaP1vwDTfmHTBZrJntMOJsKJkVvsmrE/MKDdlqXPd6kcjNp9T7UlmAhHI1Kp/zeXBRouaF3XBRKJBikf0XO9Sahl4Xjd3Ddy8Vdc3DRYFlR5mZ3UvDPf44fekJt53cTjIEVrhL7KjKPU3NMiEsILJgv35ZOnBd+ATylJO+0llPjld/20udCsQffL/5MVCq9DZBRjARciwQEUoQX9xmTorAnFpvwJs1AQFhTJ2RJQ7r6vBvjNFgwgd/9Lh9PW4URW5zRBHkd/Lyzx3jo5RUDBvMRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY8PR11MB7289.namprd11.prod.outlook.com (2603:10b6:930:99::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Thu, 6 Apr
 2023 09:15:45 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%8]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:15:44 +0000
Date:   Thu, 6 Apr 2023 17:17:16 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <christophe.leroy@csgroup.eu>
CC:     <andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, <linux-kselftest@vger.kernel.org>,
        <lkp@intel.com>, <linux-gpio@vger.kernel.org>,
        <john.fastabend@gmail.com>, <edumazet@google.com>
Subject: [gpio kself-test & bisect] gpio-mockup.sh kslef-test failed in
 v6.3-rc5
Message-ID: <ZC6OHBjdwBdT4sSb@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY8PR11MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e4bb89-6504-405b-df1a-08db367f805f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XhPtE1KNLQoX5duVZKy9LNKC7M9HHYBGfdJC6SR81Wq8NQ9fkBCTOl3vJeVMTT4N9Bzf+WBLwDD9R4OW+HMzxzAhwD5W3cflxXQIG9yZtvR+SseoLpZ41nFYHGb1n5gEUw2GqwPD1l08U0MR6x1VmS2VG9kP/HUKNLryJR1IGspOpFQc8UL6x8u4Z8C6iOl1xtxn9GtTo4WFDiYCPY3nuyW+Eu9p0+7KYg3HbOSRTXt4fl6zcgTy4m6vI/gWZKAoHunBeqSnFK/5HOYbPqNBtZeezTFxgiV3oleK36x2fJctbPuVfOz0OcEoubgS/Abs0SQNi9OPtG9Uz7HuOSHbmsE2rT3/7XgP2sl2E5h7R88uuPiPtk0zk9k593TK833z9hpYR3AIM1DZ/zXA7Xff9Oc7smIH0fhmCmWLSdA5g/36WlQPS9jQMI3VKwgSFeokBNMcfq4spM0QUT+X90D2fesMqjGlQ4RWL2/awj9l8nZTDlU6r73LI05BSBxLbtZLsLUKB/h4CI49rVGdnf4Z2CV8zfT63hyafDewfAi7KL8B3cyRgVO/nlMou6BeDAzBD1qkMJnjFDVopdNw7wAoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(478600001)(2906002)(966005)(6486002)(186003)(6506007)(26005)(316002)(6512007)(6666004)(66946007)(66476007)(66556008)(82960400001)(5660300002)(41300700001)(44832011)(8676002)(38100700002)(4326008)(8936002)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yj5LQEslvrjLWmfSQvYgVxLVz88czT2mFiuGzehqqWbb463OR9NeiczHH/of?=
 =?us-ascii?Q?cOWDXOobjmgx7/8jTkURp/ok5wCq8jZCWN2xPmScNWu/d7KuFpVQ0mz7WAAA?=
 =?us-ascii?Q?xhcFFoSgn5WdyEVBjrCXRcE4h7HOR++77TAmFfnWYsxbm6lM8fiWOAxkHECS?=
 =?us-ascii?Q?h1ATDY6VA9bLtYiwBe4vQbUIlK8R7UljOouz6r/JR9YYvkTNFLzmWvSH6PcG?=
 =?us-ascii?Q?IViao18rX+vcgDsBIBg78KZsebG6HPj5taddVTIA1W5PeczUz+yhiEsI2y2n?=
 =?us-ascii?Q?EQpag4Hq3WiZZFx3ymP5m2a8vAwcYw9l7/yEocrI5aWUqjgAQrXiMNfbA4YH?=
 =?us-ascii?Q?zMK8uUZZFQIKGNbUe6A5lagUN/XX2CtD/HtwXgP8LIrPlwYdRLe+dsLZa0Lu?=
 =?us-ascii?Q?mAfSA2S9PXytBRIgBn342XvN+6vAcNB61AhAQp8o8qy20f0AB38wCrINO/tM?=
 =?us-ascii?Q?BNtO2MQVrGiUv1RT5H/pMCaa2vM1liyr9VE/r8W+ybIjPIFhydoMpdqIJMo1?=
 =?us-ascii?Q?6mA0/1ZR8QCJM/tFvle0gdmvSVvpRXq/EkPt+/UByUVqmexAXc1s15IL2PXH?=
 =?us-ascii?Q?dhr9tSpGB+pjZwXVUZqAdSIozaB3Qf+Bx9INM5qen5J8+fRQBgxVqe0o0X0N?=
 =?us-ascii?Q?PzN2gU35TdkqphDaHzmOpNkTaqjioHtLVcaXS5N1To58KkdP3PcEeSW+Wx1L?=
 =?us-ascii?Q?PEsOzxikN/ktyDilhbBvhie1sa2CI73Dy8Aqlyxvht0gWEAwgz/L3aY/jfqd?=
 =?us-ascii?Q?KKg6ZYwEzOnIl7iiBdFyJpSs3u8TukOJIVfeFeijDkF/FHtS4/XjRtn6zqbU?=
 =?us-ascii?Q?4h+WACr+hHk+z44EXhiNt9GfdzA4XUD7hr6/L+/Z28caGkhvASaDk+wUAQqp?=
 =?us-ascii?Q?8ViNyI24pkS+NDzflE6lvWs9anX1NJRf5yYw98A4W3D2R/PHBvPfGgPAfZNf?=
 =?us-ascii?Q?I2K3zAwT6ykQvD3G8EWH6OWgQskR9Bo17uzhFrdR19d8RTDRkZQfwgfGO11u?=
 =?us-ascii?Q?riADcS9gM6/yCVJ67yfnVXugdUnqPonpIyFURw/8ECn5/aPZgApMxvr6yknf?=
 =?us-ascii?Q?CkLdgf0TwFgzTkeM2zfMKmDAsy2IJgSd9jvMH0ELC3/TqzNx4ANoNA+d3W9M?=
 =?us-ascii?Q?yxdKGzKboI96jZGTMDT89Jw1O6lYdeNn0Q10rUpWD79jxIug8mOGf+Wt2wJK?=
 =?us-ascii?Q?BEvOIweLiZ0EbzuVrMrupC+Gkszo9Kp7QxOiPQAd4uBOLp621DGOHkpY0HXe?=
 =?us-ascii?Q?rocPltKpt3hN6zkwwHj3LGRAO7v/DTJa3ehD5omogHaboeH8F2Cbv6eGQj8s?=
 =?us-ascii?Q?jQg5eWTCdCFVxqRjmhfp+X7AB+pAvONwK6FziGI+8WVKU3JFRpDO3LUT5ed1?=
 =?us-ascii?Q?IAkJvw4sSE5WALEvsSPqsxWiQ5VEi3JEg/An4N/8J0zGlUcTUO/OSFSbaHT/?=
 =?us-ascii?Q?1XKpPrz5TvyccHXyLza9q/SpqnYqfIraVlHM+93AsZoRrNfMfFgi4486EXjj?=
 =?us-ascii?Q?Mh723HEw6Tk3jK0K9IrHWC8lqKdWRGtgNIeEwb5PB+GtrVQyk7Dc7kwrKpiI?=
 =?us-ascii?Q?Bs/64hU9j2wo1dFLbxfd2w/3tVJLRf3fDhnfAOtS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e4bb89-6504-405b-df1a-08db367f805f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:15:44.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3LwqO7FZMlvad28mA6iJ3xadIGzXYzz1XJVOtNcOufP4sxtl3SK0tHBKYFD65fDdqtZp+NknKVCJpG1ScDKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Christophe Leroy and gpio experts,

Greeting!

Platform: Tigerlake-H and so on x86 platforms

All detailed info is in link: https://github.com/xupengfe/syzkaller_logs/tree/main/issue_bisect/230406_gpio-mockup_kselftest_failed_bisect_v63rc5
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/issue_bisect/230406_gpio-mockup_kselftest_failed_bisect_v63rc5/bisect_info.txt

gpio-mockup.sh kslef-test failed in v6.3-rc5 kernel.
gpio-mockup.sh(gpio overflow test) in kself-test could reproduce this issue:
cd linux/tools/testing/selftests
 1.  ./kselftest_install.sh
 2.  cd  linux/tools/testing/selftests/kselftest_install/gpio
 # ./gpio-mockup.sh
 1.  Module load tests
 1.1.  dynamic allocation of gpio
 2.  Module load error tests
 2.1 gpio overflow
 test failed: unexpected chip - gpiochip1
 GPIO gpio-mockup test FAIL

And the simplified steps to reproduce this issue are as follow:
"
# Load gpio_mockup with overflow ranges -1,1024:
modprobe -q gpio_mockup gpio_mockup_ranges="-1,1024"

# Check is there some Call Trace generated in dmesg
dmesg | grep -C 5 Call

# Should not generate any gpiochip folder like /sys/kernel/debug/gpio-mockup/gpiochip1
# Because load gpio_mockup with overflow ranges -1,1024
find "/sys/kernel/debug/gpio-mockup/" -name gpiochip* -type d | sort

# Unload the gpio_mockup module
modprobe -r gpio_mockup
# Check is there "Call Trace" generated in dmesg
dmesg | grep -C 5 Call
"

Actually the judgement "gpio-mockup.sh" test/bisect judgement point is that:
Should not generate any gpiochip folder like
/sys/kernel/debug/gpio-mockup/gpiochip1 after load gpio_mockup with overflow
ranges -1,1024.

I met gpio-mockup.sh test failed but there is no any "Call Trace" dmesg info
sometimes.

So the shortest check steps are as follow:
"
1. modprobe -q gpio_mockup gpio_mockup_ranges="-1,1024"
After above gpio_mockup module loaded with overflow range "-1,1024":
Correct behavior as previous v6.1 or older kernel:"gpio should not load "gpiochip1" due to overflow range -1,1024";
Wrong behavior in v6.3-rc5 kernel: "gpio *load* "gpiochip1" with overflow range -1,1024 and "gpiochip1" should not be loaded".
The underlying problem was already buried here.

2. Could use below command to check if "gpiochip1" generated:
As before v6.1,  there was no "/sys/kernel/debug/gpio-mockup/gpiochip1" sysfs folder due to overflow range -1,1024";
Wrong behavior in v6.3-rc5 kernel: "/sys/kernel/debug/gpio-mockup/gpiochip1" sysfs folder generated as follow command check:
# find "/sys/kernel/debug/gpio-mockup/" -name gpiochip* -type d | sort
/sys/kernel/debug/gpio-mockup/gpiochip1
If there is gpiochip* generated, gpio-mockup.sh kself-test would be failed also.
"

Bisected and found the bad commit was:
"
7b61212f2a07a5afd213c8876e52b5c9946441e2
gpiolib: Get rid of ARCH_NR_GPIOS
"
And after reverted the above commit on top of v6.3-rc5 kernel, above
gpio-mockup.sh kself-test could pass and this issue was gone.

Now gpio-mockup.sh kself-test is failed on almost all x86 platform from
v6.2 cycle mainline kernel.

I hope above info is helpful to solve the "gpio-mockup.sh kself-test failed"
problem.

Thanks!
BR.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E97D98E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjJ0MsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjJ0MsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:48:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789A0121;
        Fri, 27 Oct 2023 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410900; x=1729946900;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=isTjSjpUne/akJA3hN2qWLqlUNQTnfdYQYpdFHrrEwQ=;
  b=dz5KGHqlbHKl2jK8izDChiRf/g8ORc4IONeMGFNWo0j4AwgZf9Hy82tl
   ge/rB4KmcO6UCGfrESogUKLq/gD9b/XwCcxovzqObgBwSu1zZC12mfLKW
   SgpEoRLkIFWsV1+hUQnvAACZxK0I8qXrpQ3rkSN04oKQNXO5m0zmzIVpy
   mNj9xpWeKxICE9ah8jtQEzO5BcaoKM4lkvGoofNB8iEBxxHRplHa+b2BI
   w/qwCoyCNd0EDqH7OcfgzoVUhj4qynH2H5u9rh6IzgNIqRdL6ZwMpIgHo
   bnufukNLHPODWpiZ/KHCEbZhx1nvOMjpPI4An7P4p44UCy1WDE1Bk/5M4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="559888"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="559888"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="709402049"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="709402049"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:48:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:48:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:48:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9DoYdp0lmg5MKNJE3tWUrwtxWuhFVCrI+5j+/BjIRDRLZQvHgtTFAciwI7AG5SAShDTl+ImG73dfysnS1BqV7/xX7sa+HyDPEvjXUbukceZ9hIi551iq4XNx2ZbeVUmu3US3mbUnEztIr3+0lIo1P/KCX08fDPYil3vkyN/OHtb32U8eXV7RE9mcImiAV/IzCfDdrXSBmreJMGNxKlvPT+1IXBqj+Hg3Ce4KT/uxBKlT6RZts3yiDHdUafLDvI9Z53x7HiFLrDJY4aZjHUh/YR/c6bKGd/DICrUhX2ozFhRcrPlU+ywZcMMvrnPV76UIzfXpfW+sZyG+wTswysniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py+mq3/L0YJ5QU41c/MBeS3Fy+KiUnHmst5uQl8Bfqk=;
 b=ThJRy6zFL/MXCIYZAW7b54JOBv2hm6k7xBCIoY9hr6tB0/yIgvEluB8AKvrAwp2vgH6yFIQfqOlM1X54QGp3KGNNvqxl1g4JZszxo6ZWELqD8NBsJTOM3P1DAfIJ7++wT1YXq8GeJVz7zOKlHVs+qarETlRfCa1G9GgH9C0X9T6xsAOESPoKNY9+awtJ1m0irJOc3vBiqS3EIWoyS8nIpRYr2qQTxSuXIKqb9TrOxFpk4ANj4lSp+PKPEBED6xsBGVrZqD78o4RNdjbBuuH661e92DD6LV/k8A08MUakJypgrUL6u2i0oRwYoGGQYg1ODnPptmUqvrm739I9PhEyoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 12:48:15 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:48:15 +0000
Date:   Fri, 27 Oct 2023 14:48:11 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 24/24] selftests/resctrl: Ignore failures from L2 CAT
 test with <= 2 bits
Message-ID: <4fzenvxymygmfr6xwlrgwjyapk5or42cu452vs7f3dhetsynxv@zrm3mmce6i4a>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-25-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9db7e8-3786-4d7b-bb88-08dbd6eafc7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZrLT3jpNeqA2zbXRL+WeKPKXyQVKOn0Do0B/dxdksY+fJvsgj4XsaDdyvJcxXirRvs1R6LZcJxnFFy4lhnPFy7U3ws7JsZ7+/XMbYJeijEUeHuqvwt6nw6yt8MCo9Gqef3dRu5eIGYPHIdjXZqUEp8bDzsVeylusVE9klj3Z8z7NFRxrD45HeJN2CKLTphlUJ9/yVTw+UDhV5QICZ7JGCXW9UqhkqTY06bOC6QUr/pEF5Msdlql14na+HFCpuKhTQi5irEQS30riZyAsYucLgTeZCNg7bCxIOrE/aStS0lDhpN+ry8CCT3BiawM8jZsx7ymTX0CFIOL7swplpazmAKTnaLwBYv+iRnp93QtQGMaybmhUAyp+anQSvOldJw5VXUfGOlB76CdsvvJMZFFiXMMwJheyJYS8+AeU1LDKFnucbGc+mOQzLRKivlIZrhvIyOeq6KSRUlOVpUsfvVzbG9BbSjMFV4oncYz31tXgviOtNFuAegqOlcxLEgwFMND5iF7gELigphYTjo6q8kuzOFSiNzjPkHReErgK4byeL6hIo+qi8kNstW7L9uUM20R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(5660300002)(83380400001)(316002)(26005)(53546011)(66476007)(9686003)(6512007)(54906003)(6666004)(82960400001)(478600001)(38100700002)(66556008)(6486002)(6506007)(33716001)(41300700001)(8676002)(66946007)(4326008)(86362001)(8936002)(4744005)(6916009)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?a4f3yiTI/Ye2Tf2YbQ5c7LFgGBe6YwvxfylcMOz5c0X45gRkmEPwXIz44I?=
 =?iso-8859-1?Q?sa/2BteHt3I5MJtZIGrQ2weNNRcYd4wb43o6KcBrpQMLN6j9gswUe3tyQw?=
 =?iso-8859-1?Q?HfGOzb8RnERaljkDYbK6uyhSitSq7Y6fIBDz99QMWjtdljABvjbckiBmHZ?=
 =?iso-8859-1?Q?1WlQN4/G7wX4AwnNfDgKo8MirvGyVR/71/F10UmFBHfroyEfCJYFhBaD5C?=
 =?iso-8859-1?Q?pSIKnfjKlY4P3hwOfsEqH1ICGQ7Bjc7WotS5OCKlI0/TbzgyrvNduKAEL4?=
 =?iso-8859-1?Q?M0hphwQqocHIerIX293cb2xXuO88e/KV0EBexzT+DDHiHQmySXPfkDW/sd?=
 =?iso-8859-1?Q?M2HoD4TN4LCTHsICCu3IkRWiNncFdefRydz6vFvdCRqhAkxP01kcsEk5nN?=
 =?iso-8859-1?Q?ofvfxnaZoXSPCqshnXDkmJ1ank7jmZRUDmODfSWJIQFLDhH0YFKYE2bCZk?=
 =?iso-8859-1?Q?cIm6VQxDKCTwYPrICdd2qWDg9UI0LacBZyc0KGmH4bF/d8FRoh7VkqAn4L?=
 =?iso-8859-1?Q?lSdsJyiaeJpHozVqaND2mk2Bih+B38ML4opO9WgHutOtBr+A1sAkT2gUEU?=
 =?iso-8859-1?Q?33sMERhWZ7TaaYudQi5NXbTohvQ00ALcNMZknttb7O80/Ny9F4urmz1Fb7?=
 =?iso-8859-1?Q?Ahb1J7ZWqN2HBmbMOPHqfUxyiYE1Gn8Gen685O+RMPr27lUD7hzrCZgC5m?=
 =?iso-8859-1?Q?UQ6l0u+Qew6TzX8Qa2h61nUuL2pSZb6Giqh2JdQsX2RZ1up8ZoVMflJFbp?=
 =?iso-8859-1?Q?mcvx4s7tq2DskF9h1I/Nko6lLK+gPqVr99+ABXOLst16l/YqMt7lm+zSlm?=
 =?iso-8859-1?Q?NMWwVi7kIZSqgvkkZP4Zyu1BM9LnkB3WbViZN2oCoSlBTG1FxRgT3Ee0u8?=
 =?iso-8859-1?Q?RQJSBzzaq9CX89UxBO124WZG19gKu/I4PHUm4ek6T+YZn7OzIuZd9/r7qI?=
 =?iso-8859-1?Q?UPBc0JvUJFpEN2XMKM1iN/LmTR0+U1+Ux9b1XiBWyaJAeW9vbigMBHQ84y?=
 =?iso-8859-1?Q?KFybSYL6Sz4DeRcqLcar57bGIX3Ha4nVIjMQS6sN9zaZpVTQlBmpqRqijd?=
 =?iso-8859-1?Q?R6NhEg+ZjDLOpDdUgaJsxOt/Jghq82Ae/rPCMOVklQ119cLNQHrgzcltwA?=
 =?iso-8859-1?Q?bdYJgG34JJpG/gcaf+fPQUE99sGWooYHCSUmkz0mTwM0Wqrun3rsGNSC1t?=
 =?iso-8859-1?Q?ouFNbO1Ga3GyA/KYfDBnFNNTJQCBnoEzQ7830O2sPWxlM7kxR3iqM86BQH?=
 =?iso-8859-1?Q?W/87HZDwLzHjt5BBCiVvPNSywpo6mvE68KuegGpwl/jFNMjbCAWrFB1nME?=
 =?iso-8859-1?Q?8t2fjx2VcXUhba3yYax+pLKxe1ZaVRJMHBv8J/mKJVIt/jjGDGf+3Rj1iY?=
 =?iso-8859-1?Q?Bi2QfMouC0ZwrVilDk0jJ4gAweCB70Azi9b2jPTYAS9Y7v/sTrZEEh1me6?=
 =?iso-8859-1?Q?HhcSgpsJwtaGzKWj9aTqUj6tXB1duVUFiRzcdJw+u2R79JHdTNq+WUP3OF?=
 =?iso-8859-1?Q?Bpn97oUetkGRP5cuI/6sfI1W0I85wNUBv3caurwSbB0fhU6puP1MNuwuWW?=
 =?iso-8859-1?Q?fBpzppb/nSG5XOlmtwjlWvnE7tvUF7Kl7H4Z5B5lY2Nq/ZKCPGiPtbETqd?=
 =?iso-8859-1?Q?WtXmr+qfzxEZCfa2XZg5i+i/F89y9GeK4IEHcJSgt8r6KurZ6d1/Ez9ODN?=
 =?iso-8859-1?Q?M2XxSnaBd7Utuookw7g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9db7e8-3786-4d7b-bb88-08dbd6eafc7c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:48:15.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwLl7vgJf4xMr3wjkUt3z51IMfW/mTpi8KBGVc7D4dLHKhdXrjTYlDhvwUTSfgeftkUc+dMik7KdaEYif5HZIU2UIctYOUEYGc8K+Obq49k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:34 +0300, Ilpo Järvinen wrote:
>L2 CAT test with low number of bits tends to occasionally fail because
>of what seems random variation. The margin is quite small to begin with
>for <= 2 bits in CBM. At times, the result can even become negative.
>While it would be possible to allow negative values for those cases, it
>would be more confusing to user.

"to user" -> "to the user"?

>
>Ignore failures from the tests where <= 2 were used to avoid false
>negative results.
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman

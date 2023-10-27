Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18037D9683
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjJ0LYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjJ0LYt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:24:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472B4129;
        Fri, 27 Oct 2023 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698405887; x=1729941887;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CMgdPGem7rAKsTxbeFwp8JOr71l8DAKlmTqtVCT2T/U=;
  b=JP+ZHBKFzgtLZukOMEROWtns4phxRr0zvO9DuL/zOH4F7fbY5XHqcSza
   ZYLJGmZoEkLAwXNOsBnWwe9IaQZgrTpHjNs/ekE0cz62vbKuvau15glSc
   /Cgl3iQSHyxTdSBHm2lUCBEUWQ2qyAgMUaaIrW9/5EJ9bXBRkUJ6aTCoo
   k1bdaHdrR1ERwCwDkc2T49wo2i5FVfhjwem96ttAIeWZVVQgY2xfb5zKD
   YXQweg/FLN7nuE3xVojwSqW5LqmgSJQqPo1/tsLw4EqzF9Wl2dZtguKvJ
   f+bPthvdlL6jJnsTmYOK98nKFbAb83AVLZYG/Q05s+j5JCcylGRD2qIJ+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="454220706"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="454220706"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="876305132"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="876305132"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 04:24:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:24:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 04:24:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 04:24:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iudDwkpolMv9vR5b7XjQ4/gbE2XUNEUBtH/K7wy7XHUsVrwOf49gTa3QKXUXFgWJLnEGXeyCu/Cdr07mN28Rxz5jW+/Abgl3Yyr6GeRMhijFVKh3GHYyeCBlYmb2hpYyq/WYmtFgjyODJ83OybTCPnR3pgkdmNiDQTkqfVq31+L+wGOoa3q3ySkgdV0kBzn+ynDVspsVyKEdh69sZYIV/SYTPWqho4IhLfYH8j9pEhAsKYyXEyV0EsIdWot5UU2HmvL4Q6xQxyIYk+LZBzQfn8Wd9G3zjxQM5BEJ3E1o+b+mceSFNxaeALcgQq86oJyBt5cA2OyGpxy1BHqSjrpULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgsYM/1Udg+6NA6hiMCH+KK0Wg6NQGidX6BtCB01sjE=;
 b=bkNewOomTZ3Cjx9dpDfaioGNChkuqawKVMerQw1rxgseAbfkV5X5DLNRIIz64R3QVE3DgEfvsp8UXMqj9ZpyQTmKK8jmdTfoUVUj/GE0tZyRRqVGWQK9ho8xhOkFw2gXHc3eHpwrKlGMDdbQNqvxsjeI8I8jerBl0T/ccoDnTH0MBUbhi9ZlAiMutE6LFvetG5eCISK4nfCZoc2DtZZKEmJaU7sZOINGITCTm97kd8eDMQmRk3nWI4EQeE3Uy2zkJ+61ezBjC6beHh97B9LC8K1evklfCA3zLWhtJvJUUlErLrOA1E9nSffRXLpkDj0ouSdLx8TH4gT/wWswp7sAQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:24:44 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:24:44 +0000
Date:   Fri, 27 Oct 2023 13:24:37 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/24] selftests/resctrl: Split fill_buf to allow tests
 finer-grained control
Message-ID: <uoy7hy42xmx6ptsczpaaexkghtnscnwn5ho2jvjy7trgn4y7dw@mkcluknnxr7n>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-2-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 052330e7-9db0-4efb-f274-08dbd6df50a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0mNztUqBFIxstpr75tc+y6mOXMkQeZrfeg21P1M9BPkelw85BEwwUA0UeVJdCd+BeN9CIrFLhopchqcBjkvd2diewMHJhO1T17/9TudtscyxHxvhsIL9BQTgi+rAPWMdqz25r6gLKYWxAbjsiUi2uPQTvDuCC5NpiKGzXZQLOdEdePuBntVaa3OF5Y9eg3haoeWLzKIjTvcmPHgnRiA2zR+2uEX2tDsIeP2GNMjiZ+vKq8At3b7B78GQZY/NNCtRHH736rlr5W/ZWV4q14XlkQk+DkzpA7JrjWRcnec0X6iB4CBQTiwbDdZpewekZW320tlv/nAcm+GgkoGvBr55XsOGeLtBauIcpIUAQN1fIoVrciNFNahxdlBIZz8o0cEcPN/gIMEh35XOWJZw9lg4I3Zkskk7KWhirlI1wXTNfd2q4P88bWqyxCIsBXkgAZhn+kbDeSaolN/ba9Egeu7KN3jyFVR2ChicYoUVGRPhqItffecNKmeZZFx3FOOmPL3BkUDOzXpP85t+zUvwVhp6gsjSAN/my/M1qePB/E7/+ePRLVai0p6f3AsR4abCHpt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(26005)(6916009)(66899024)(6512007)(6666004)(6506007)(316002)(54906003)(66556008)(66946007)(66476007)(38100700002)(33716001)(86362001)(9686003)(6486002)(8676002)(2906002)(4001150100001)(83380400001)(4326008)(8936002)(5660300002)(41300700001)(82960400001)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?JdkF/KkumbNQ9WzS7WpgEhKrC6+HrKguyRAFYJ2Hj+NpL0kbDWK+CVpvGS?=
 =?iso-8859-1?Q?hdpglycRYJI98l2rWXksXGFP/QpFEqttG0TXfyq2vx3R4Cxm0GEuiy/mov?=
 =?iso-8859-1?Q?IHDeuocTBtM3+TTMPW58OYfBjWUgQS8A23LkYpDyf18qhBt7YHb9jlHn2g?=
 =?iso-8859-1?Q?9y086VrPhsGqh+iqSLs7Ydq7S2FbzCE+A+5M/NDH5/ZDRJLOY1a0K/TFwJ?=
 =?iso-8859-1?Q?idtfBDBeSaYccU/d3mEc4aMSR2xDhXPusGm/sFf3t2seapjgIrff/6UYNU?=
 =?iso-8859-1?Q?PEiypqCcGfn7lEKoUNabXnUl88lTMz2M8sIdEB+dA0WLqUpO8HQMQjSFsb?=
 =?iso-8859-1?Q?yICoKfD09eqqy8SsnmP8EuGmaFajwjVwKX0fGjMgP5TVDFPwf6WosZ+JPI?=
 =?iso-8859-1?Q?RZ6M+afWzr1dpD/IGwyY2FDyNTA9NUNiYWQ3sebj22DCRi9yK7Z9dD25Iw?=
 =?iso-8859-1?Q?ksTBhwCbjRjiMXwEfDis9zQ5ryUVq4pwv8VFVA8ZRw5lWgkDPy/dsfQR9Z?=
 =?iso-8859-1?Q?gg4qYHCAPsplBTTmC8/uBYh7Emek9BHSkrTv4/IZlP69Xo15ot+KdQdEfu?=
 =?iso-8859-1?Q?ODuV4h1qwSubTxNVn5pfik8HTyBksDTveCgvpvmSG57HCrqPnb9pItZk4Z?=
 =?iso-8859-1?Q?XAiAv12RQiaRWN8HAobGOQiG0MIpCbS/aDszlu1Ah1nGp7aP+I12sYNqlK?=
 =?iso-8859-1?Q?YUtbzBhiiMAWSHIzSfxKFbGmoMA9mCQas181KXGKC/DTwhpbbf1H5kTz3h?=
 =?iso-8859-1?Q?OZyD0cbuDbCyDDbB3cAwTgo6b+fSuWeVR6RSrM7WgbpKhM/CV2TEzYNJZB?=
 =?iso-8859-1?Q?B0Q+joaJkfaDnUMaOQO54uImym5Z2HCLrk/zJJCKJT8q895a+aTSTgfHtP?=
 =?iso-8859-1?Q?zCrjm95nHVAmjQUGvB7fdv74MOvb3P7JuohRrSjBfyUKw2E71EiiJcEiaK?=
 =?iso-8859-1?Q?fZ2WdlGp65yCoI2iMAHVScfWw9L7wiXI6CO7/PsP7aWamxVzKPgGSFsfsy?=
 =?iso-8859-1?Q?DeX5PihiIOJtKi4RrlSU2CcSr6mFBvl0/PQqkmrncUat3ODpfW74fCyzlY?=
 =?iso-8859-1?Q?s5vZTlz0drtDoqkhita5QB/r1lg4qLUTF4HL05A6LCf2qzkwfBwzGStaR8?=
 =?iso-8859-1?Q?Nz9d5M25dhDvOUCitiQJuFItt5PCdby/B/R4may2jftMOwO3p8L63mWKqi?=
 =?iso-8859-1?Q?kgIhoYoUU2nt+VjxHLvpb0bpHTfYKerSYNUv3Oj65wyPrpGeoevfvlpDYZ?=
 =?iso-8859-1?Q?xTX/EgKcYK7NsTE6DMBv+iYusu28OU24r+KjuM5A3kvgUmFAG4h0wYCqnN?=
 =?iso-8859-1?Q?7/fpzjuTxuvTx77RLWR8uxmgP4wg7d0mm6TK//Y8T9tSsVCOyLBjKPSUAr?=
 =?iso-8859-1?Q?frP6DHgqZODiP6I6naKKq0b+86eSUX+9cWE1Fqf5hX6Kk16zw9SpfUYRxB?=
 =?iso-8859-1?Q?Ne5zvQlIHCTgPzp7/oQN3P4ILZzV1zuPuRQKrxSJj2qHnz4/73dzP/8EEt?=
 =?iso-8859-1?Q?t7hMuFQ3luW4AhSNIOOr4XJKC6lQbzE/wXQpasgjOA7sbWiNiBHQBLqTG+?=
 =?iso-8859-1?Q?WEXKNW20tJqEsY3Pcxk/KFNVI/5FV+ypmOsum6jcvv5p+z2rlxVSktbQ52?=
 =?iso-8859-1?Q?Ujp2UktT7g3E1Syjj2c67HuF1hjaXyDbz221z58i2umoGxWFPdjbVHYRCa?=
 =?iso-8859-1?Q?V7McuAXM01U/Egwm4D8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 052330e7-9db0-4efb-f274-08dbd6df50a1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:24:43.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrrCOuU8nC40hYQEY8aRWlPvcVgMOgP77TRg/lAi2hBUbmBqCL4pfXQJ7dpK263QRBsjAJf0+Eo1b65lk16F4iIaW6VGW2q5q8s+URTBOho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:11 +0300, Ilpo Järvinen wrote:
>MBM, MBA and CMT test cases use run_fill_buf() to loop indefinitely
>around the buffer. CAT test case is different and doesn't want to loop
>around the buffer continuously.
>
>Split fill_cache() so that both the use cases are easier to control by
>creating separate functions for buffer allocation and looping around
>the buffer. Make those functions available for tests. The new interface
>is based on returning/passing pointers instead of the startptr global
>pointer variable that can now be removed. The deallocation can use
>free() directly.
>
>This change is part of preparation for new CAT test which allocates a
>buffer and does multiple passes over the same buffer (but not in an
>infinite loop).
>
>Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
>Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>---
> tools/testing/selftests/resctrl/fill_buf.c | 26 +++++++++++++---------
> 1 file changed, 15 insertions(+), 11 deletions(-)
>
>diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
>index 0d425f26583a..f9893edda869 100644
>--- a/tools/testing/selftests/resctrl/fill_buf.c
>+++ b/tools/testing/selftests/resctrl/fill_buf.c
>@@ -135,33 +135,37 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
> 	return 0;
> }
> 
>-static int fill_cache(size_t buf_size, int memflush, int op, bool once)
>+static unsigned char *alloc_buffer(size_t buf_size, int memflush)
> {
> 	unsigned char *buf;
>-	int ret;
> 
> 	buf = malloc_and_init_memory(buf_size);
> 	if (!buf)
>-		return -1;
>+		return NULL;
> 
> 	/* Flush the memory before using to avoid "cache hot pages" effect */
> 	if (memflush)
> 		mem_flush(buf, buf_size);
> 
>+	return buf;
>+}
>+
>+static int fill_cache(size_t buf_size, int memflush, int op, bool once)
>+{
>+	unsigned char *buf;
>+	int ret;
>+
>+	buf = alloc_buffer(buf_size, memflush);
>+	if (buf == NULL)

Maybe just do:
	if (!buf)?

Checkpatch also seems to suggest this approach:

CHECK: Comparison to NULL could be written "!buf"
#65: FILE: tools/testing/selftests/resctrl/fill_buf.c:159:
+       if (buf == NULL)

>+		return -1;
>+

-- 
Kind regards
Maciej Wieczór-Retman

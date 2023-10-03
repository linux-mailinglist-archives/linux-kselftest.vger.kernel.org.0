Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5107C7B66B6
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 12:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjJCKsP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Oct 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJCKsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Oct 2023 06:48:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6A7AC;
        Tue,  3 Oct 2023 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696330089; x=1727866089;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hiYxDxq1IKJ5AQNpXDJeFJIdOZFeDtLBY72EIiEnMqs=;
  b=HH7rDlsWau46tVH5KwjaIw+Zox4hXRhWAogEeHp19g3pinkmkro0spEW
   vyTa+hHgBtTRrHLJrEkr04+uDINTHhE59ADa6KKgSBSlD/s6mMPhVUMbV
   fvqClV6FTnQWXO4Y09bIEY/Xkif/8Ice64S0sS+9BpRWpqll6ee+Ou0Sq
   OwkkFsF8M3vl6vFWovN7bu1AnpkJHcuvGEOZjClaTlpyxSzunCsUKvaqt
   j7b6/uk3zURAtOF1XJJMLUinUAT2sXWe+maZyA+U3LDwwimhbaUY0hnRn
   C6LCa7n7KcC8ZBYULobcNgr06NPFNDoLS+CiwwUX6yNELIQdASAtROAvg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="385668156"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="385668156"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 03:48:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744457944"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="744457944"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 03:48:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 03:48:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 03:48:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 03:48:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 03:48:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2vKQyarWXXS6uZvxfUWVYSX7xY5ja9zghjBaXgTpb1cI1kxcEze8+3k+xVZIsy6iMZq/LFht1/JAu0ToMCtsTbPNDNPP0jcDmnSH470MdgtJd5YT+dteN4+Wj00Fc79PFhXg1Av+gaDL5fQY3cF900J+Ax2oz4yiX6J0mYiB70yTrw02RMoRLwkccvnsimVmwOYBL7SVp4B+EHsC3cJvAB5uAAz4yeB1Y15v8HSC5Yr5IAAIzmQ5id/9fyfGv6FQYlAnYAdMy9SZU7rG71R0pGQRVELvCsgeHITDBQhV8B1F04S96JedzlLCm/hmQQTShxHuiJBaGsJYMpwsyj3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwKTla/hnAP+6ZdUyo0+ncdo5GXLc5Z0ihxl1PVDYFs=;
 b=AseSC7Mofvd00Y4Jdb2w2rMWT0C1iZAutqmv+U6Zl9wbTnNxaS4DBPdS5VD7zmea4pr3T3tGgQIS60old+/RGKYcorLCv1bWxQffjrfQTH+PkNF9nDfL167IeoUPxXq820h1n3vB5q6D4ZM5zwlBfvPly7Ll0iIh05EqmIsBYasNdArxhXdsdnTgsGO34UGQc/NMKmH0CNFqT4PMIevDiPNnujskUENFREKBLdOKfaip3fQpJtnAIQEtciTlWHrPf7e7kKJSbU8KLvaJa5HugBtlo6TpeHJhDyoY3qTBuTP8ePFT0+iAIeGluxKd5gSdwalIMA2BoW+YF6bg0zKqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA0PR11MB7694.namprd11.prod.outlook.com (2603:10b6:208:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 10:47:59 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 10:47:58 +0000
Date:   Tue, 3 Oct 2023 12:47:50 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] selftests/resctrl: Fix schemata write error check
Message-ID: <da3f4meb46bxnv4rkntirtiskn23gsegj4n2nnxp355kgiaen2@j62s7xfa4iql>
References: <cover.1695975327.git.maciej.wieczor-retman@intel.com>
 <f1f8f4132d6e6cdb1438186cb40c5d78b94acd5f.1695975327.git.maciej.wieczor-retman@intel.com>
 <b4fe7970-06ce-43eb-a972-eb7cad26ff34@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4fe7970-06ce-43eb-a972-eb7cad26ff34@intel.com>
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA0PR11MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d1d273-98b1-4e0e-502f-08dbc3fe3524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXdhZEBj1aD7TtKfVfB3WFMuxDq3g1N8pecI2/YlCU0UKyQEVz7jYEnADdLJEBecBWNx+d505V1BYHDQsr/TWylrzbjv9IiImhAcYAQSaKF5PEyDIPIXFS7IY9YCM0b5cY0EETY7D9f/EAdD9OHUF8sXDadcAHYXQWwkpEV2IEqVZ4p4xZJCvbX7s5QQAyto4qXpVJxaBJNozmUKs+A5UnYVagmRDlZFMpOvrq8tNrkjCJryKYRuIAUuyu8WScTqO7ioTdtlgN6IeTid427yvHYSmjxrT65Qc5KdYnq/zflCNIu5AxqrNeAIHFO+jo0yxmw97ciqccglHUz8VY0aBhBlX3PCQx/PQbwUxNNg7VoPh1crx7N3SPDdzt6CQUwdqUlqhhtK1fxlVGgHrLCfAv+Cv1Dueo+lMt8HL0G/8viRp8qdh/rLJWyUtpzKuZ+AFTuB6aXm6Aox2h7nnvbvwg6mo0CyeGfza/H1Q+ThVRVQjLUBOAXInS7nTGAe1gI6mknjRJ/DjzPS7087o1sLFdsHIRcx/UzdGNcuA7K/6kUKALe7cP7stknfAB48zZgb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(54906003)(316002)(66946007)(41300700001)(66556008)(6636002)(66476007)(2906002)(6512007)(9686003)(4326008)(8936002)(6862004)(8676002)(478600001)(6666004)(26005)(38100700002)(6506007)(5660300002)(6486002)(53546011)(66574015)(86362001)(83380400001)(33716001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bFp2ncacaXeyZwdR7ICRPOUKr7zS7Abf4ENeXWm9k1oJaRnPNm6m7Qv5EY?=
 =?iso-8859-1?Q?qRVZL8l2jeIpGbatft7d/d2dV1MJuSSPQ/c0H29RXUd64i9XCibrywI3u1?=
 =?iso-8859-1?Q?Kh5/NhGLnShZNeZhQ5jaQqoorGJFDS572EaMnDd6QVMVKeL89xFcAO4Jw/?=
 =?iso-8859-1?Q?Z+1OefzwHqs4bN7pOJeeNwfxggiox3q7QKdFh2JCXEYKZ0FxODhc8EARVb?=
 =?iso-8859-1?Q?fWAw919kFcieD9G9ex4ZgTMfSe7h4XkLLeeyIqYoKt1PmzY6o9K7SaazR0?=
 =?iso-8859-1?Q?C6MaCti2fPA17CV7YlBj1gzzexiJHQT06RcOm6JaYv6IJoMrOA1Tp+ST9F?=
 =?iso-8859-1?Q?YCbEyta2YFNwVHzxJRTE+HLJvHaSaqf1VdchRhR/Oc4kvxyP+BiG1iL7oo?=
 =?iso-8859-1?Q?A6zJpsznNHs3hMETteb1Vhv57lJR8M9jlcq9YRohQb/xG9tXD4IzBG6MvR?=
 =?iso-8859-1?Q?YHDn3bw1MDDU6B8+1R6Wadqnzg+jorg3Ad6qNmBLJ7Kr5JV/6FWWMaHyDe?=
 =?iso-8859-1?Q?FRfki3oqRdgCT14G2IdggPFSlfzotTWW8qpmk/ZLBS1yQOBQ12dHZ575gd?=
 =?iso-8859-1?Q?oP1KDWVFFW49VI92nwiXeSwnl0MDKEcOV3fLxpAO5DAFBnQJOz3k2sGb+u?=
 =?iso-8859-1?Q?7WJpd+0F5ekj/B8qnK7VPw0JcwW5f+k8sZWePzqrUaIJnTWcEh4abRYRpc?=
 =?iso-8859-1?Q?tWtwoMZ54g3ukJiJIdHVH623XfPaQiV7nSCJjnCg1IUvBtvYtXIpIot7ws?=
 =?iso-8859-1?Q?jxUwVWj1E6Sh/Za3d4lO8mJ7z02+w4JtCdxW2kwsL6Z6wpBN4TcQor3A6c?=
 =?iso-8859-1?Q?aro8TrB2z+ADXSGzh2u0FWKEvnAK2iOcyJk8rnQwrNBydr3X1ycEh+JE/d?=
 =?iso-8859-1?Q?yPI8cqeLTcFbt5Y+IJlfY0+bxv75fQyDsJLH3WFu/NkDp7jLNTml55+UKk?=
 =?iso-8859-1?Q?WS5IZb9ChnZwsxD5ngcBMN0eH0QXHzbYrVaSFeZN8k1d4GsMZHLB8EzU74?=
 =?iso-8859-1?Q?TIGbqVe6B70JYdwiB08n+SrsI/l/TZl2Dassv7HsylSiw27j99exgjTiNH?=
 =?iso-8859-1?Q?JGPogcesxiPbnULpEcQVNYIeWhtHxPw5P3AMGtk8iJ+bDCEo1nnTkbNvBz?=
 =?iso-8859-1?Q?oOqpBvQWrOasZRs9q6nDVrF015HqSaCMEeGKNb9qM8nMDGsAetAot9IGy/?=
 =?iso-8859-1?Q?Jj7DEgFrSGtpMTtrQ2PMRNc0PKw1i36OjfrgdeJD6PtBNJBJ1Pb+htKDuX?=
 =?iso-8859-1?Q?0Mru3ncMz/7Ju7OcV6m4h9WLSLaAnoUTb3NpV/fKIhi0pdzdnvQpZ1872m?=
 =?iso-8859-1?Q?ysmVAH3fZMJU37Kx5O7zlnIvF5MeQ/liqaaOnl1UU8G58iV6NkYbwh7pMG?=
 =?iso-8859-1?Q?j9fIDr/AieTGjxc0tCsGITov/lsjvenV09wGbF6qCR9M6gb0HSS04vlTY4?=
 =?iso-8859-1?Q?Z/JmwyhwyZElfzlN8vVW8sHgvuyB7wbBb1ABTAguCFRL9QIQ40W8rc2MA3?=
 =?iso-8859-1?Q?Mp1x+GHZ0ysFR2yd+Yq3/X0ZEXr3n7sECncllFpQnVhVu9bpJFpAxdM0Lo?=
 =?iso-8859-1?Q?jiiBGOcots229qZ9XBt0pVwdoSHoFLQvmxuGrp8nG/zl53IzcZqqLk8A09?=
 =?iso-8859-1?Q?InQ4+Zcao3pMyFIqvHpqZPLLg5vZ1FuDaSwK7cpllABKxKC1mdfuwtl3t3?=
 =?iso-8859-1?Q?w7WT6Iq4NgVoyy8JqDE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d1d273-98b1-4e0e-502f-08dbc3fe3524
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:47:58.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1daghwqTw8BpLN6uLWXoISUXq+NAEiNYgxrgs09PER9xKbuxrdyWPu4Wf71RgO7Reog8sueRj11UhxYz6d0hyr2+KvTWpbQEnLxQFlyHOkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello!

On 2023-09-29 at 10:04:21 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 9/29/2023 1:21 AM, Maciej Wieczor-Retman wrote:
>...
>
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 3a8111362d26..342a3dbcdbb6 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -8,6 +8,7 @@
>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>>   *    Fenghua Yu <fenghua.yu@intel.com>
>>   */
>> +#include <fcntl.h>
>>  #include <limits.h>
>>  
>>  #include "resctrl.h"
>> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>   */
>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  {
>> -	char controlgroup[1024], schema[1024], reason[64];
>> -	int resource_id, ret = 0;
>> -	FILE *fp;
>> +	char controlgroup[1024], schema[1024], reason[128];
>> +	int resource_id, fd, schema_len = 0, ret = 0;
>>  
>>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
>> @@ -520,27 +520,37 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  
>>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
>> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
>> +				      "L3:", resource_id, '=', schemata);
>>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
>> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
>> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
>> +				      "MB:", resource_id, '=', schemata);
>> +	if (schema_len < 1) {
>
>I find that this complicates the code since this is not the typical snprintf()
>error checking (0 is a valid snprintf() return). I think it will make the code
>easier to understand if it sticks to snprintf() error checking and initialize
>schema_len to match. What I mean with this is something like this:
>
>	int schema_len = -1;
>
>	if (...)
>		schema_len = snprintf(...);
>
>	if (schema_len < 0 || schema_len >= sizeof(schema))
>		/* error handling */

Okay, I'll change it to the more typical error checking then. I suppose
it's not possible to write zero characters to "schema" so my " < 1"
won't be useful.

>> +		snprintf(reason, sizeof(reason),
>> +			 "snprintf() failed with return value : %d", schema_len);
>> +		ret = -1;
>> +		goto out;
>> +	}
>>  
>> -	fp = fopen(controlgroup, "w");
>> -	if (!fp) {
>> -		sprintf(reason, "Failed to open control group");
>> +	fd = open(controlgroup, O_WRONLY);
>> +	if (fd < 0) {
>> +		snprintf(reason, sizeof(reason),
>> +			 "open() failed : %s", strerror(errno));
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -
>> -	if (fprintf(fp, "%s\n", schema) < 0) {
>> -		sprintf(reason, "Failed to write schemata in control group");
>> -		fclose(fp);
>> +	if (write(fd, schema, schema_len) < 0) {
>> +		snprintf(reason, sizeof(reason),
>> +			 "write() failed : %s", strerror(errno));
>> +		close(fd);
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -	fclose(fp);
>> +	close(fd);
>> +	schema[schema_len - 1] = 0;
>>  
>>  out:
>>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
>
>Also please note that _if_ there is an early exit then uninitialized schema
>will be printed. Maybe this also needs a schema[1024] = {} ?
>
>Reinette

Thanks for pointing it out, I'll fix it for the next version.

-- 
Kind regards
Maciej Wieczór-Retman

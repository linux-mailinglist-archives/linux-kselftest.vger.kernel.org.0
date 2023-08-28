Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CD178B120
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjH1Mzh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjH1MzR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 08:55:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17840107;
        Mon, 28 Aug 2023 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693227315; x=1724763315;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=NIQUuYSN6Mmy/dHiDTFXRsHeLp+cTNTj1FiuaEXyphY=;
  b=AT4idK6DIWgMa/jFWICqmAiRuz80mUIHBbek4SCgYcfnBNiCMKs5cFbk
   Lc4UZfE2flnEJ1sfq25wyrqDemqN40IBBlg2Y4DTTHtHZFa48k0OYVlw5
   m3QQS0o2l0PY9xnNzqXqkOA5xf/04VLUPm9V5U4EDwdVvURBoGuMu2Dc+
   hh9g+GSzxrZn2JZFEvNjS9sWVLAeujw3c44k4dVioW6maOeuq1HkrySwc
   6J9irj1ldrDFaPUpqkETRKT86DHdcw7tix8lDZ/2Y+wQ4MhOtxGA4X7lj
   bxLT1QHm9ffGARvbp84C7x4aN4kacgzaSr6ziZkHFuhhcOGHHAwF1Bwcq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="354614361"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="354614361"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="984865108"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="984865108"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 28 Aug 2023 05:55:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:55:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 05:55:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 05:55:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 05:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgdNuTHNABmgHEIzN0Kk1g9bmyRRyNWZ8OgPgD92+qx6bW+MT/hIqQV+1PK6H+jYy9dIyUz0HKHJSr96k2eYngvsYX5aHQvFunnLX0MRVS+SeQDehyqjIGWLJvp9MQ7qC7tncM9LZUQIlMJV6f6sfla5Fqz6dTxoso0YFdUH7z3NKBYNj8jATnJ6++/mIC8e3ePBbhah3EDx8Vr9r0KcepFwTVW+rQ2fTGrD2x4PdxXGrNlxD64smadBoIDOcvNUSGeZ1oHVEkIuaxLOJ2vUimZ7xhyEWdT8LnZcbgXWdQlx0BAW3Qahzd2fKGaHF7SDwy3C05vVQpcnQbkmpZ5e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgl0aSH5oQnVweVLzQePmsioUM/lnR0SdS3rFSPE3IY=;
 b=G7ISgys3q/UD6jHifbXfX8N75LglrYLrqqKRBejCrwNiOAO+5Qp52guomnFRJ+NHPK0CZ/rFCsPx1p2VmZckC2yL2v2pIvw309mmPgIc5PZfflvDqxzDzU0JpJINPyHazePnAzp+E6vZtmpryEQiRDOjlKN5Qr+0X6gMYJYZwi2b5+9JlHocSPGqanaq9cSZngG55ObiCNCfROLn+TWW+JVu0bdHCKUN3kfv2+2vszNHqybnlvtlAJRSqmvwDq1j+XCyz8ZIBOddFoMDb69zhCYHXql4Ccyk+BpWmLDJGxJJim9CtsOiRYGCIUhIYTpazZOgOiY8RJjp0PAdtYLezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MN2PR11MB4629.namprd11.prod.outlook.com (2603:10b6:208:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 12:55:11 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 12:55:11 +0000
Date:   Mon, 28 Aug 2023 14:55:05 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
        <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Fix schemata write error check
Message-ID: <tqdf3l4kwkqzdiks2pddtze6xunmqtgogslupvvjyskexfhkdo@dtxmzzegsxt4>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com>
 <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
 <ba3f3a7c-fe41-20b8-6999-492718d7a83a@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba3f3a7c-fe41-20b8-6999-492718d7a83a@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MN2PR11MB4629:EE_
X-MS-Office365-Filtering-Correlation-Id: a2265033-72c9-4c9d-ec82-08dba7c603f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UCTeH2m+0q+/jmRWz6tZoP/wye8IpOSrsme339Gngvh/xfuE/LKukgvluuKahpM4Efd9aquPBF33IT2Rc3RpiYdf6PBaGlW7xi2zumeEICAZbWVOIkBo+5LJBGrmL1N6XFcIzBh44cKz2JCrTIcXHASN2Ua9I26hOnfLjUkanRsyIeW1Flyvh0wi7ttfjUury7sKvL+bPlc2chPBerDI2oRrViDUBcK+WMnrgEMOynJoMFClVaD2fE6+tfLz9BUYVQXPm943o/NaE6al6f1znRyv3Ywe8rOr9NNCoy0pKl7q5I+uOVrxGr0mii9LjuEbPAeTfCNMrRh/BySar5zy8YnoDQHi6wTkQ1TK95gYuSl4M5N6e15G++Bp2Hc7+0Ip/v0JJjbmyUKcsBkslBAArsiVz5YDO/4ayy92T6zwQ1jd6EXxiaDq8Gy5sS/OUoYZB/KRL4zp25pn3YOWUVlGkhdPs8AkUeus3S1rAeN+qZ4VOz0xdUl1Mkn6gFbYkNjLE/aUygyxDTYP4nZzjeQqDiV3x1MLZPRgnCX7BMkbrNDxLvulM5XipeB89x2abNm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(366004)(396003)(39850400004)(186009)(1800799009)(451199024)(41300700001)(33716001)(38100700002)(6666004)(86362001)(66574015)(83380400001)(82960400001)(478600001)(26005)(9686003)(6512007)(53546011)(6486002)(6506007)(66946007)(66476007)(54906003)(6916009)(2906002)(66556008)(316002)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AQRvddfYoSmAlcwu5DtdWkG6200F8oX+ufcITqPd1aW4NTdt0Q+vSwIONN?=
 =?iso-8859-1?Q?DpswkMVW7t73/04xYKBb4BcBuok5HmdwIvfh5U5PaBRMPGvUVTYx+31Kdl?=
 =?iso-8859-1?Q?+Dp288IaP+vLwU9rrLt4qGE5wvPFr+n+Ok8oF0ETaEjKSsiLTGBfPAudCO?=
 =?iso-8859-1?Q?AhT5PP4xNTfujHirRkhDY05MnhkhVCPQ4l3FdgJMeMnuIsVfjHzmEv0sk1?=
 =?iso-8859-1?Q?E42uHIo+YvuxuaOkac0tgJsBub2l/R5lISIMi0zfm+H0lxqSDahsr2X9h5?=
 =?iso-8859-1?Q?bvd/nZw7d9aiLQor4C9ddZser/auRbU/03WLyxe0xF8qOmpxGtg5BhzZNy?=
 =?iso-8859-1?Q?8lbgxKAnQyoULiX+mwINdBM4D85DzDsH6vwq0QkgqiCtZFZv4nRCFjT/jD?=
 =?iso-8859-1?Q?QEUWLl7viKI9zD4bUBIvj9bO1YcwyRdUHACQiaOhKTPnjydFwwC14+2BRR?=
 =?iso-8859-1?Q?9Xk3ND+o/25lKCpN15s5THbOvaNavoQ9yjUBomC3k2foeSakpFQ+I/X7lC?=
 =?iso-8859-1?Q?NdK1HsixH9Vi6r92p+1zbsEgpZJccP+bhb5YmlNYHpSVzOWvBjYq6Q0WJE?=
 =?iso-8859-1?Q?imbUQR+p7iIPQ8+nYeanhsFJOVnpXiIEcqrQCKT1TbndI+dzDhjGkEyjez?=
 =?iso-8859-1?Q?J49w9mTuNV78nGJkjoW6WaOUjmjXOjW4Um2/7epy335F+ROivhS2oC0nCL?=
 =?iso-8859-1?Q?BiWKXgTzckHpwGFvGQvzLLoPQT2pfUrl50Dp7nfOK7xr6Vfv+Pna2DHI5R?=
 =?iso-8859-1?Q?dibtrqhmKjr34pVz7iUXw3UXvZ24KDXP+3aatzmWHkbzUhQJ2pzQ2qh87s?=
 =?iso-8859-1?Q?fzVpIQAdwZ8/ktxbDbG8igM/F2s05efDeYCvt/kwkaE6TsVZ+0Cxzoz3wF?=
 =?iso-8859-1?Q?iHcRESILWB1MY8Opqkxt8YZUGBE9ZKWO4iZgiLLUNuaQjJ00/iX8qmjbBn?=
 =?iso-8859-1?Q?qyXfOfG9obQMmhN8IErnHWcdpqOyv1p82cFGcRKe0oMsbHLCuV/itCTED+?=
 =?iso-8859-1?Q?zaca0t83s/sIyJ6crlC3ZJVVnExKzeT4rmeoDI4b0ujLnBInYU4pj3x1KG?=
 =?iso-8859-1?Q?Q6zi5Cy7dfJTful3GweF6qI3nwqhXQszWqTt1vZ3JwIYilUQpcKpMdSpr0?=
 =?iso-8859-1?Q?lmBDNUDNRzRwN3vHrX3ESozKUppgfRmlP4+COMcFWKk2UKPC5ggqpTv4cU?=
 =?iso-8859-1?Q?GTsTCqfjhzrjoOowoFDWM9Y2oV2uPhPCg6bQTU8Hoq536pfbCU1y9E8zgd?=
 =?iso-8859-1?Q?GoN1cwcX+EQ8f84XI+4Re00fUXaN0NBrwrfIZlse09GcLqL7NMWo/cQKzT?=
 =?iso-8859-1?Q?3KObpmFNRk1swxcta5hiE4sTInVbbYX9NSGjy1nan3V920FLpq5yb+KLKv?=
 =?iso-8859-1?Q?cnaWtjrzXPE3fkHW7Kfk1A0xkllhjvbSg3sdroh3DWlUnmkmM5R9+BX38M?=
 =?iso-8859-1?Q?3oQtvWdMK0R6jmym6GIZFhuLJbVfe6lgwBTJsZmUehQNaSkyDM4xOwowRC?=
 =?iso-8859-1?Q?wG5bamZdJqJ87fRga5x23NaO70G2I2A5uqYwtYQrmQS2dsa6tMVfKfRR25?=
 =?iso-8859-1?Q?wPpdVo9oYNBqdu0nYZUR/xc9Ud4HUQyCA4bRr5wu2gXhozPBgiQA4CdnnZ?=
 =?iso-8859-1?Q?Ox/y/3AzG5EoQNz0lOnNPkzIKNFpYXVgnxFZh4h1HODASOfmp17q4eZfdi?=
 =?iso-8859-1?Q?7favgJlpBODhvHcQO40=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2265033-72c9-4c9d-ec82-08dba7c603f0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 12:55:11.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4QgfBhQOmgFoEUQdSPyIsB1SX+dXK6zuNxEmtdQ6XQjUM+F/f4sB5YWcJGaZJ4AcLPIagm0Pwo7ZCR9MfgmmNzOk7g1yl/zAu08ifxhSvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4629
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-28 at 13:43:05 +0300, Ilpo Järvinen wrote:
>On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index bd36ee206602..0f9644e5a25e 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -488,9 +488,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>>   */
>>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>>  {
>> -	char controlgroup[1024], schema[1024], reason[64];
>> -	int resource_id, ret = 0;
>> -	FILE *fp;
>> +	char controlgroup[1024], schema[1024], reason[128];
>> +	int resource_id, fp, ret = 0;
>
>fp -> fd to follow the usual convention.

Okay, I'll change it

>>  
>> -	fp = fopen(controlgroup, "w");
>> +	fp = open(controlgroup, O_WRONLY);
>>  	if (!fp) {
>>  		sprintf(reason, "Failed to open control group");
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -
>> -	if (fprintf(fp, "%s\n", schema) < 0) {
>> -		sprintf(reason, "Failed to write schemata in control group");
>> -		fclose(fp);
>> +	if (write(fp, schema, strlen(schema)) < 0) {
>
>snprintf() returns you the length, just store the return value and there's 
>no need to calculate it here.

Thanks for the suggestion, tested it and it works fine, I'll add it in
the next version.

>> +		snprintf(reason, sizeof(reason),
>> +			 "write() failed : %s", strerror(errno));
>> +		close(fp);
>>  		ret = -1;
>>  
>>  		goto out;
>>  	}
>> -	fclose(fp);
>> +	close(fp);
>> +	schema[strcspn(schema, "\n")] = 0;
>
>Here too you can use the known length/index instead of strcspr().

Same as above

-- 
Kind regards
Maciej Wieczór-Retman

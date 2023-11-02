Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539AF7DF098
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 11:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjKBKti (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346817AbjKBKti (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 06:49:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17415133;
        Thu,  2 Nov 2023 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698922171; x=1730458171;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xSjQjq1nVdANl7GLlGhOePY8otiX0CzDLdMC6Mzahu8=;
  b=NHAjg+vl3F0rOHc2jMvaPN9oOHGRBcvOl+YW2mjmpQlHhyATFW5GMDMh
   C23k4+XvphH7PmCb2GfQhG4ByqerFnCwwLQz0DoS0qIjc4x49+14yRG7n
   Y1Djn33/0XJC7H0W4nBvriLmSk6ffana4M9/twqvgZZ8IZ9cMY24+hbje
   fPnp5iZIYQT1e79ydZHmrBqVEhBViHj4Wk96jkm0GN4oGP9cLZO6T1FiS
   pCOtDrl80vlG8/0fQmuzG2own0XSTCY0vQOn11x01G7xW8QsXk/2yreX0
   ZDNlrWOlL9Zo28FC4z9QOlM31BpUsCnXrK1cAd7z1x3/bgao41iwebdOt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="419796007"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="419796007"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="790352209"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="790352209"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 03:49:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 03:49:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 03:49:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 03:49:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPdbrwv41FXBtdFjE9JwXDFVkZ9aH5YV+Yp/ugp4UPjUWaho01h8P9YImvMg5YTV01M1CrlB5wotbE/E8Pl/w8ZVvzcI4yyX4IlsjPw3y5I6kacEz+zBrB+X2UWoUnD6UD8BAzfeqIL08DKc9taXS1hZVeb3huPMVevJMBbviBHfO0cWoQ03K/y8QoOoOSTtaR08uDxh2Iw5jMOGr2wvf5z/FZo1qYDxZPXaoWWp97XddQRIU1co1aaUBsBt0I+VzQoS0jxg/0EISfpp2NRPB3Ze9qzb4u6/seyHaJRugQsKdtptcv4K9G3XDDh9SlE73c75Km4ezzaohmiijqmmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+8Ulax1owvpa1ziSyr6rEn1zwt45av0bOWUauSywuo=;
 b=cUl6adXl9hZxTx8ulCo3A/hjui30yDVmBEBtedN1F9YgohuNMejIIks/jr2OqEvpSBNo0YFiPGqiNhov86ThQ+z3h4R+d4kqo3SiXINjCImtyJeYkL1boQKKFpJJVVGKoeL0JM4Pmcgxuc6N1eCOmj5K88a9TJbv5ZzfgT7kHwwgeVhkmjDSmVVxAL3cRWq73TxhJSa9zQ8pul0E+qXzNNugHSn+Hhjz1Zp7vXTB55wTYNJD+uOuCWi+Smsu9HtMXzPiogG2a6QLRfPbvS2zErfd6a8h8KE8sC+fTeBux/iCj+thdQIO52WW+xde2rQK5D5AExa+j31GAXGnLSFvNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7550.namprd11.prod.outlook.com (2603:10b6:510:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 10:49:27 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%6]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 10:49:27 +0000
Date:   Thu, 2 Nov 2023 11:49:20 +0100
From:   Larysa Zaremba <larysa.zaremba@intel.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        <netdev@vger.kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Alexei Starovoitov <ast@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] selftests/bpf: Fix broken build where char is
 unsigned
Message-ID: <ZUN+sBGnyT2Op7r5@lzaremba-mobl.ger.corp.intel.com>
References: <20231102103537.247336-1-bjorn@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102103537.247336-1-bjorn@kernel.org>
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfc200b-e4ed-4c9d-f725-08dbdb916275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1W6QM13CQW8Q2EH3WGoR1iB/kDAPrOmrUtVhqWLn3sUJIqaAISD+zS/T+r90Ng1aFeNdA9OhkdTceib2UYERegUBkTHHaFwBgUJ6nPlyfZEVk/ODpj8QY8SUKkdJHYKxGe9JNL8CuFpuFzZOG/z90bvvJfw4eVQ4mF7XjyA4t0gXGHRA+xwVFvAq2QubYRWKjIX2PXRRZBiZsdbnlQFgixSnlewdA02hdxEn3v5pY57k/rWPxLp+8pDD8bylBxeURi9fRsrduw8ruWDBF3Li729XAla8JiuomPZhGv/CoUs1MB7ayg2sInbCwFBx0ZKCr0ROqLcnCIc58yIOQu/NvJAXcmo5TfqGaU0H9ySbXGuYu23P6r+z70IQ22FA09f/uwrFH+ZRd3FjIJGIc4iVxSMg2qC9bIiOpvx//pp48eAf7r4twalcbaU72vQVLxCy5wQIgku23XoC8/yN5fvyFIpGRBdmA7X/WH4rAG9LagXM+tC9X2+slTAB+sZeokk93GDhn/c/QSFIhmUi0QiykwkY8OsGhZmau+gOwV+5dAzuBJ0u6oGWGgxAqF42bLfDYbVEHEdxSyjHyw6XZ/zV1IqMCXG+DtGtzmviICw960c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(6512007)(316002)(26005)(38100700002)(86362001)(2906002)(7416002)(5660300002)(6666004)(6506007)(44832011)(66574015)(8676002)(4326008)(8936002)(6916009)(54906003)(82960400001)(66476007)(66556008)(6486002)(478600001)(66946007)(41300700001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ySHDhGMj3vQaYPT35jEK9+JZEPocBswT8mB57HWfp13Dyl0r0nXw2JewFJ?=
 =?iso-8859-1?Q?14KrGoQT/7atAlMYf+NsgLS44XH+Z59pSSv8Nky0cehVGvOb25hJSN5vlw?=
 =?iso-8859-1?Q?fb5Jj4D7SoEWi2TPh1IkIHtO4yQmW4PqSUwQ1PYK0XdREGcG4Bi5ba8tAB?=
 =?iso-8859-1?Q?hPifBcCFAu+On7d9i2WswsDOXk2DcLa1Th3Kpm4JLmW3JEssIJd0HieX6b?=
 =?iso-8859-1?Q?lkukYd7Yg3KdiUihiqjk/ZYYZemL7P2Zd72F6o5rPAPniH//8j9CRyqT7h?=
 =?iso-8859-1?Q?avNFF8GJhIillsBti+rZy17B27XTjn+iVd7LMuhcO/HJ4XzXOtKF+cjT+C?=
 =?iso-8859-1?Q?HMmHyLp3cV06861kz/0uq3/l+xZYt+oh1XT5VUy0oDrazWzmkqMjRFMUaw?=
 =?iso-8859-1?Q?fv+M1ZuEbrg8UOUtw3WVFGODhwrDxf7PD5D70JeHPdfpJqFzaQGPIOW8+7?=
 =?iso-8859-1?Q?VxKavtIYciQVRJqhBs9zv52ocR1W2epQkNjIA/gTwkAh0dqiOwimYraiuU?=
 =?iso-8859-1?Q?kX9fiPpk6HNnDf1B45tZZSNWBrmQRDVRwUOfyAz6cwVFiZldBUA7QJkqkx?=
 =?iso-8859-1?Q?bRM+dWhQNC24kdJZADvkl0Wr5NXtioXfGuAX2qN3no84xQi0eGlDXTXwC/?=
 =?iso-8859-1?Q?Ftn34is1pMkThzae7XSH2JjfaQbkX8ToHn+lKWBbiJx/UC170bZKTf+7fE?=
 =?iso-8859-1?Q?+pk6EYYcS0GdWVRVgDWZz042ytXSTNlC/INgABL1l39Um83kz5Dm+Nvh/X?=
 =?iso-8859-1?Q?9uvU4ZRViS7FhhImSvsPL5qo0Hw68THuysoUo6+zz+U9aSKkBieWe3C2yU?=
 =?iso-8859-1?Q?IJPmPyCHhxhV4qVyTfjHPJHaXFG2065OtYY0vlIRPTlJMAoU0Gkt3KGgEB?=
 =?iso-8859-1?Q?Cb+lpBMx4FMf9azAsm6bBxV+ZlLVhn1weWWvFnF4BtwmhtMgF23t+l6epP?=
 =?iso-8859-1?Q?T8mH6A29hAl7p3vekK5/+KHFRmdF8qKSx2tNkdFl/O91dTJte/E/HtUpXp?=
 =?iso-8859-1?Q?FFNct+t9ni3D7HXdDxnLJYfhzqPz0eHh1fxtD0P+oVKqabzZwi7SHj+KYk?=
 =?iso-8859-1?Q?ldNxlkr/vGqVjVNgVgxWGJsVazcZVkT8J3eewN1JYTl3vcBFGYoykknAUV?=
 =?iso-8859-1?Q?rr1aPQrlJ9MT1K3a/s7bBCdYb7HE+tyYAd0ow7UsP7y+JUeGWzyTjgUz8V?=
 =?iso-8859-1?Q?K+SbHmL/13ZvvJ41eTatL5jQmpWLBYVwrS675ZqyHKEqB1J2kL9Yvwd+ZW?=
 =?iso-8859-1?Q?zIlHiINlSGqove6V0h/L7zwt/qyppBMZc/UEomsdxhLOnVnm1Qw8hQWvqq?=
 =?iso-8859-1?Q?wgogbb7glMFMbYaSVg7pGY5zl4C0IIB+4xqau8Vm0ICqd1XnuLowpwaogm?=
 =?iso-8859-1?Q?Eq8vEUdS723f3w09yHlwqfJ3xHPYWpr4XYEWMIEoypqcRJNcIPpr6HlWyp?=
 =?iso-8859-1?Q?DOLXXfv5AsTWf8vE5m68KdPfpx9XxBhdUgtUDYdQWgDqOoGL+wVl6uYaTT?=
 =?iso-8859-1?Q?ZQKI/4nYBLRNMUJlB97kBi4Orn6xBgQFekCE3lbpdoxSaztMJYz4ua30UN?=
 =?iso-8859-1?Q?g56xxkurUuVA8nEXl8joQgSZwNjMmjXJc9YGa/7xFUqUCE3no3n8OtwMGn?=
 =?iso-8859-1?Q?iJ/yASTyBMLawIt/n1HrcNfUtyn16fueVEf70g6QxZXaIpsx4EZrZAbg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfc200b-e4ed-4c9d-f725-08dbdb916275
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:49:27.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64c9X8sFm3NJ3E8BHQGTKeHPYYXDBp3fEv34Jxwlge+ZpPmK1hB1oRAXmuLmL9UxLiq7Q9kGQwvcvYwCzIKuB+TfuRUd+99Oj90fIBDGw00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 02, 2023 at 11:35:37AM +0100, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> There are architectures where char is not signed. If so, the following
> error is triggered:
> 
>   | xdp_hw_metadata.c:435:42: error: result of comparison of constant -1 \
>   |   with expression of type 'char' is always true \
>   |   [-Werror,-Wtautological-constant-out-of-range-compare]
>   |   435 |         while ((opt = getopt(argc, argv, "mh")) != -1) {
>   |       |                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^  ~~
>   | 1 error generated.
> 
> Correct by changing the char to int.
> 
> Fixes: bb6a88885fde ("selftests/bpf: Add options and frags to xdp_hw_metadata")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>

Acked-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 17c0f92ff160..c3ba40d0b9de 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -430,7 +430,7 @@ static void print_usage(void)
>  
>  static void read_args(int argc, char *argv[])
>  {
> -	char opt;
> +	int opt;
>  
>  	while ((opt = getopt(argc, argv, "mh")) != -1) {
>  		switch (opt) {
> 
> base-commit: cb3c6a58be50c65014296aa3455cae0fa1e82eac
> -- 
> 2.40.1
> 
> 

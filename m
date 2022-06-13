Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6115549C85
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 21:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbiFMTAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiFMS73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 14:59:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1C8E195;
        Mon, 13 Jun 2022 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655136994; x=1686672994;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q03VEoc5MNS4PxJVkJNGtQifuU3RXSsSLPUiX8TLnHc=;
  b=isICdvooa7tkiZhdksknonktBCJW8bgJ0PIb2z5KMV0PyGWpCKQpWqCD
   j3AwN999rW1ucXLuTThj6SLfrcKtFaXoF2C1sT7m9ix0J3K2CW2XszrSz
   8toaWkaysijb9QujJkrSIAYzjrkwCfJuWSTvH8ekOVYQLymlaz1q4yKxd
   ZS/2DMlHLFhhNk0Wfiq619tYq9zjozjIJ94XSso3dOW5ydMlBmVoC/S8t
   xtW/1F2v5CDy3yjChCIFiHddfY7qr6RDlB6t8UBMbDFMcIIvZ2+O2c0Wf
   FdtKMbKdFLZrWuvJs38MmcU45zP4Zhz+eVxu2Dx0cKLACVUsvGJ4CUN6D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278368659"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="278368659"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:16:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="568098463"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2022 09:16:08 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 09:16:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 09:16:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 09:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpEdCQg1llJC1d+dpRSM3OHVoFrzQ/O8FENRDrIKCOVHj0XyYO2WYvzIHPFuybP9AEiMfYDiUbdkrGdBxabXaVRIr4DTGjI/nreUqLm+CooSUAvu5EAawzOL+DCfBv6M/rd4doO+VIPT9opDIGqKC0+QicznJ2qyJ8ReWfFHRE6cYBl82Akj+4Z+EievAF5vKUJd3+kiFpXBOIlZLbgHzltw10kASuPbG+vJfADZJKX73qAXtA2vUTQekNN4NU1y0rOe3506wI6h1ZYcu32ZqlmQUTZ/q3DCTdLkeJEpK6oaTFbG2VM0W9uyPkJl4c90Lt7a6XH1xrpqoShpbCKBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaKKrPF5MtbKacJrZJxKpvigdXx5rxsoodWNbzvU2Gs=;
 b=Yehsx50H4H+ehvGRCgJYKrEHZ90k1vyNCh+tocOaZZ8NipZsGXTdixnF/QQNRPF6WOgvnnKE6dIS+VcGS6P3FD5PMxqdADEuSW3PnDyZ76SOXgTWw4FvlLsPrERB6JXl+6tJDcLlzzx/+UMq4TJ+kcQshP3AgG4tdvI+mG4ZH+CCBSIY3OuTNJ0qjaOneHOK69Etd7JbSZy5PFUkJMXo3FGZuKZP0Nqx/cC3ugvdJl8UcX+pmrTdCoL8YerkC/bETOUgJjAh3PPB0BPRMyxu66a2Yf7YBTxiHkex9u1PSOxfPLcMohcHeapw7wnIZM0/SpXKLZKOh/A63zSro9ud2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 MW3PR11MB4762.namprd11.prod.outlook.com (2603:10b6:303:5d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Mon, 13 Jun 2022 16:16:05 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 16:16:05 +0000
Date:   Mon, 13 Jun 2022 09:16:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Sohil Mehta" <sohil.mehta@intel.com>
Subject: Re: [RFC PATCH 6/6] pkeys: Change mm_pkey_free() to void
Message-ID: <YqdiwVQE9jzf++jQ@iweiny-desk3>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-7-ira.weiny@intel.com>
 <af035c24-36f6-7d55-5be7-b52cfe26e2c6@csgroup.eu>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af035c24-36f6-7d55-5be7-b52cfe26e2c6@csgroup.eu>
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fccd6a2-2e3a-4f8f-85c7-08da4d58049a
X-MS-TrafficTypeDiagnostic: MW3PR11MB4762:EE_
X-Microsoft-Antispam-PRVS: <MW3PR11MB47624F6C776982BE43C87852F7AB9@MW3PR11MB4762.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzHV700DCwVcve2+B/cjOh19o7+eb4GGsAJRvDDosWPBgs8UH/+c+/Hwv7jP50cVwRmpzT3XjGIHFrgCuUwBVAKsMYcyGxSxrxNN8l6GW4GgJc+4dQBwvvRZa4BNvLIQioMKUNLnzzA2L/jNtMrOz8IwmYoM7Hh/8/RUZaVUL7zQCqLRuR7Y3tyVPK4nRp/khjLrL2uC7lKeaNBMqtknN2xmIxPWVzBvU7GwLcA48ekI9sXW+Cu0cSqX43+hgdEiMctCitxlPfplgq/OetOuR5Y94TmWWu4ZrbgcT3qgk4rvvFPjwOeuILlLk5Q7NJqDk58urmsG1FGkDrQgu20CXF859RaY+LDBH+51qmxS/tqUB29Rec3HIQcKWPtW8HXhcrzGHxSfMdpMB77CTVTvbyb6By5N1LprLEnGUl7RaDPhqEBrt+s9NdlViOWt1wXT+1MIj+R3FvED4pBoIsCALm22FWGZBvn44Mb+hE8bNB7L3JRDUBnHA5/ju73O2i6eWOYG+sUC4taPA8gCaoGCsDWKPG7Aa8XSMFRsoczEZGuMc7zb//8DqJSSP9g6ZlUOD0Q049fsWpefN7DkNc7Qpw6JyZJ7AqInDBB3tm/gMejAauf1sV3+Na/QxPABhHn2Cu0Y8O335RRBdKLznwsvHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(26005)(86362001)(6506007)(6916009)(6666004)(6486002)(33716001)(8936002)(2906002)(8676002)(38100700002)(66556008)(66476007)(54906003)(4326008)(66946007)(66574015)(82960400001)(316002)(44832011)(6512007)(9686003)(186003)(83380400001)(508600001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?J5o6WREwYcXVpo0ra4wv4TX7gWep/6nRK6KlvonYFK1zUPSaWh7sBw7Ou6?=
 =?iso-8859-1?Q?UaR0JHAEO6nAZAOo5U5mlD+CwXHQkXwac92rkiopygUlo8m14oEr/Oja1o?=
 =?iso-8859-1?Q?QivF9abJbRfG5h3a/tzNHqpdvsNeyVtFo+3eVEpu8ztoOseCPR/h4sMgpW?=
 =?iso-8859-1?Q?K0G7fzk4xY7WNPvBFNLEmiT0b5UZ7+XDhJv+evF85DaxFnGSBU4I6I1igL?=
 =?iso-8859-1?Q?wCJABMtO5zPpukwevrPxAEDjcrdlr6IXIjkCTHAoFkkH7awILTfuoq2IdP?=
 =?iso-8859-1?Q?lFBas2QoydNc3Jx/oQN5aukU0AFvv+qi4tDqRIyWFz/BX/rUHYrOcN74Fk?=
 =?iso-8859-1?Q?ewIJCP4XX5hq60pZv8BWYYySWmQlZKqACDetr0Xim4LlhPNb81VD1vMs+3?=
 =?iso-8859-1?Q?bAfj4THUM1dcFfO5DcRH50ucfVvJXjk3fKspOj478pEkEIa944SJnCceAq?=
 =?iso-8859-1?Q?dK7igC1eNkU5H4s+fhXScwD+Mt9OkqyHY8cEuWkE6cubKou0LtNa19rh+W?=
 =?iso-8859-1?Q?VNSUdaMuPs73GNuA3Ujy3gzn/fjCmQGfL3fIE9xqhbqv+daWuJ20f4hQxh?=
 =?iso-8859-1?Q?/XRgjOoavkdrzOxJWOvSTjBtmogoC77EGU9PjfYSBvHocnlCsl0pZwLoDg?=
 =?iso-8859-1?Q?Sop8fIT02oWWOw2raCW3a7hqdD0EDjam+k6/K+ur77ThQ4qmnV5D8nfGXo?=
 =?iso-8859-1?Q?EC+4OakN6In69DLosTiJ7bVeyvaD7FzaA+/dHjY3vzvdmqRHFRHFUbDHC9?=
 =?iso-8859-1?Q?1IAmRi9dCs1XUEbpI7x5U/UCbjWrE2LsGZ2EkRgFP9ApfrwvEb0JWBF5gL?=
 =?iso-8859-1?Q?5M6SW5H6wGJEdjqXRZ3AGMYSRUs3ZY+J0VRVWkas7l6xYSK8nFvioBIPTX?=
 =?iso-8859-1?Q?5tHbuIa827/kRY02imoxXyDHSYLfM1kHYlAyKDysUQwgLHhQ7M7M07ejtK?=
 =?iso-8859-1?Q?tVcpegLm3DXQFc0UDa5CnnhJfrrdZszMWRJYMAisc1Dm5jzSOUXlWCcyGw?=
 =?iso-8859-1?Q?nfOY3MWnmhRUtAcNVUoCJr0lJItVijO0bkWILPYchGjDsocQEkFMRh0zeH?=
 =?iso-8859-1?Q?nvFhS+THpTEYZkjor8Tj2XKnWxwGCNJGi8csEN+0OtY4bnairTUCJY/Tvj?=
 =?iso-8859-1?Q?wIop42kuXjxG6QXDVgHHGfNMPGx1en6dq/Geo7sik/C3vBJilBo1GGLm18?=
 =?iso-8859-1?Q?+xExeAYyphQPqoMITVfhn41p2m2ColvJvVSfvC3c6O1BNqGRPAatUOHuMs?=
 =?iso-8859-1?Q?/CqLe14qPsoyTT+xSnSlytgBMqWtBYsQKVFfP5FmRIXnXU0um+2YPAfrS1?=
 =?iso-8859-1?Q?siYc4fMwTeDc9ycQCY4YwHKWCTQa/Gz6O6eMLEydAQ2+s53eAbLwMniP7m?=
 =?iso-8859-1?Q?kTHkDRV6eA27qLgJ/Fp1En5PwYdOxNneEgWhbZnSGGKAlsUpXZgz7GIGNp?=
 =?iso-8859-1?Q?Fy8Kv7Lww2inivyNcESG5BPWnmKMez4Sd8ZhljZgIbTH6GYLGw/NYl0T2O?=
 =?iso-8859-1?Q?brb5ObjcdC4b8IapgtkRBL1bgK4kGuu7jYAwzbPbVa19fSavjezxBEo1CO?=
 =?iso-8859-1?Q?YEFOFfynaltueSp0DNZnKy23nMxbWSdU4LrC3HFFz7v2m8UQGukfKAH1KP?=
 =?iso-8859-1?Q?FrOINgzlsakr2PSl1kjSH9Gxr7IjbF/3bEMcpZU4/vm4PC2L70KPntNgBb?=
 =?iso-8859-1?Q?I4Gy3eFWjsIw7XP0164TFLstzYGHUCACLorIs+F2DOZOnYMlv+sjm3SVOV?=
 =?iso-8859-1?Q?bz7YLVdttVxzCcOEpG9PDRrfRa5oKVdfOus2tJP7Hq7DF9g4A29FjYwQKp?=
 =?iso-8859-1?Q?ZCx4FpI8Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fccd6a2-2e3a-4f8f-85c7-08da4d58049a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 16:16:05.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8gtuFI0cEQ/shvEQjiniZ0Nd1G0z8PEagSxK+RMc/oQAf2GtOlXxmoxtep+jlmPAq0hC3gTVMAbsBmZYT2ibw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4762
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

On Mon, Jun 13, 2022 at 09:17:06AM +0000, Christophe Leroy wrote:
> 
> 
> Le 11/06/2022 à 01:35, ira.weiny@intel.com a écrit :
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Now that the pkey arch support is no longer checked in mm_pkey_free()
> > there is no reason to have it return int.
> 
> Right, I see this is doing what I commented in previous patch.

Yes because it was suggested by Sohil I decided to make it a separate patch to
make the credit easier.

> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 41458e729c27..e872bdd2e228 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -809,8 +809,10 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
> >   		return ret;
> >   
> >   	mmap_write_lock(current->mm);
> > -	if (mm_pkey_is_allocated(current->mm, pkey))
> > -		ret = mm_pkey_free(current->mm, pkey);
> > +	if (mm_pkey_is_allocated(current->mm, pkey)) {
> > +		mm_pkey_free(current->mm, pkey);
> > +		ret = 0;
> > +	}
> 
> Or you could have ret = 0 by default and do
> 
> 	if (mm_pkey_is_allocated(current->mm, pkey))
> 		mm_pkey_free(current->mm, pkey);
> 	else
> 		ret = -EINVAL;

Yes that fits the kernel style better.

Thanks for the review!
Ira

> 
> >   	mmap_write_unlock(current->mm);
> >   
> >   	/*

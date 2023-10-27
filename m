Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC187D96B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJ0Lcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 07:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0Lcm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 07:32:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD84E9C;
        Fri, 27 Oct 2023 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406359; x=1729942359;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Fq3u5+0QHJ07UEC9v1ESXoidxk9dRMYMzL3riu+5DI8=;
  b=ONHIlfuyeNBsdpP6FXREM6VVJdd80KoP2OgMe2YpmdVU/O0M0xOKO4eE
   g9urxrEkretd67B7tsOi/QZkMiBXkSFacrwimhkrDwk98HPiAzLX9F6Yj
   4+Y950IRwqx1KofiBhr2O/AFs7YB7MCVmzGf7vTQpXO4hHh9iSyGxYhj5
   x0+z47O7yqylM2JFcMQpWmGVWAoK2l7Jo3/ZcV6MKRyh6EBhfNNWpaRkT
   h0FsGc8v0j6W0JSTgjlxoQBCjUnOuwyjEYoe7x3o9wdzXMTIUjqi+1XY3
   oxJYOJcGa6QNIhYiMRN/vWfquRR+knqUFgPi66Vv7GEw44HndFFsyy9RL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="372808723"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="372808723"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763188292"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="763188292"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 04:32:39 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 04:32:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 04:32:38 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 04:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBNViMt1ex8oKdaG3sehquZuepNbyG2iVU8bXyjcLcbBT1LDf0EfcX4K3yveSzGNc/ofyGWUjKP4wxjN6OtREoR/zgAQsAi/kRdzZnCUHLJz9WCh60e84lqss0yMOR8eA5gaj6jhHRPLO2+ZxVpIcl5fOQm6Ng7o4qqd0W39eR8JaZMlDy4sbwoMbwd9e0LalKjJB+qsQJB7e+K3RMKjyTRPiZlmPDWenzhhHYq3sqaoSzBeLTiUg1rKSyM4pF6GesgE/UUMaxQw5iiyFWDEVwGlyxPs83bcTiK3O+mGnx98Q9Qgs+0I6cguAs1E2JUwySSnhE6fCR2Bo87bRUeXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iXJZVvD++eW/RhgFemp97S9r22vcRyRrBvfyPMbnXY=;
 b=TsoXsc+ftBHGvnEVH2XgPmnagcgEv0sas0A0Zm8sXekZyfc2brfX/its6dlUWpWZ9uvwLm0beIxE7wvb+HqPH40L29Umh7mrcZILvUyv1TedY+6DewKXKnjFHsRxwvN0RDQrS4H9In6dmQ5ALyLfcSGdKuSIqXMNs2HXyZl1F2Rumd1zp6+1g6jSkVmTU9E0rqCOVgixB4QuWh149ZAeao9TqNhs9rIHFZWAYjj0bsmBSTxrLF7qsnj0CzVSon363trpsELDic/ZuNss6kOunyqbtBVfnXdiAuAkoRzGf8SVmVy6f5gyJyuoUE2fslYYpx9D0yTg+E6C3W3Wgk5R2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5893.namprd11.prod.outlook.com (2603:10b6:a03:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 11:32:36 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 11:32:36 +0000
Date:   Fri, 27 Oct 2023 13:32:31 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/24] selftests/resctrl: Refactor fill_buf functions
Message-ID: <v5jdxr2sayffhq5sslyn2f5x6ogynosuhjxgdmfwzwdpvejngu@aahvjgz3sqcp>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-3-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 76596a66-bb53-4462-6c69-08dbd6e06b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1q+zdj8Hp2PKLO01yGAEfi4j1TYiIXxIw+4j9pw2afWOTWqATSyQYlrqJx+IFYfMuEXiSe3MIx+Yw700hM1brPKw5NXPTn7f4Sibw/DeYtXBDFys0OmWxdqqZkdDaGchSm49ctuPfPwRsRbbFN/Osb7/mX9vIGqBdxKMUTnNWU7DxcJ95Gj5j++r5QFEkc/7EmrnODdnHSH+kmsD6YBwpKfDK0vej/7K7AdB4MSUGVu3btUfKJkhd0BIqX9nMUpMB2StnMdCyG1lrbZs0R30MXe2Sq62b9QZvG2+THY50EJdEfd2IPXy5Z2d8CHc7K4XctnxPuY0Q0O71oQddDnsYe+4DMD0kM/XtxVa3yKGbEJe810SzDnzUY4v3AuGa/vmyO0rb7EQD5qKNaYJ+cR/a8dGR03DkTunN86sEx4DN4shizjxA0jXw9NTutNm7uZJQwOGdxsPaghTCkgbXQwOA0ZWYgaMesffKkHpxTQpAxqkaMzG/Bl0q39xPK7sTVthOgS9Njr7xrFRX5Sroi49FhbVWnwfg+F65/8KJxOs/3A6vvnShUsv3Sa1z1Sv/Lq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(5660300002)(66476007)(54906003)(66556008)(66946007)(316002)(8936002)(6916009)(4326008)(8676002)(33716001)(4001150100001)(2906002)(86362001)(26005)(83380400001)(38100700002)(82960400001)(478600001)(6486002)(9686003)(6512007)(53546011)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?I5UZpOdDM8IfcWc1r61VnFEhUmdWLOTbPH4RDzTW22dMnaEnvPw+2AvKOD?=
 =?iso-8859-1?Q?NWV8nYAygF7NzFy7pq5w9g6r4Mg9EI6m4WnoUE4IC3R4tS+KX1N4nqSTvZ?=
 =?iso-8859-1?Q?46y8cVvGxvfFlq9CHTGuuoy2+wf+w+19++heNQtTDNqoSWTFkTD1j4X0tA?=
 =?iso-8859-1?Q?ZuVLgB4mVwxtbrhFK2wyB+3mKJ59FwedjSw7nxNr/nVzWaYZ3/1q1GAwtl?=
 =?iso-8859-1?Q?VHMeME1FkyUY/XEC59D3vyjdAuARx2DnWTQiFCeMYpcVooZr6eU4ZfEUz1?=
 =?iso-8859-1?Q?SuW7RZCOcdYSxttwDBeqIkNBVHDGFD8oeGe+K8nblSmqsRH7aDp3TYeaob?=
 =?iso-8859-1?Q?KYXPcdzr5uqD3gJ9E1FDcGq/+Qo4QBApLvE7mvCaw6N0B+ag6s+YR/slmr?=
 =?iso-8859-1?Q?GDjL3Zs3J25eXqyUbbWZCYN6fv+UJS7OUUPP0WaIgunR1NjOkFiU0/GGiJ?=
 =?iso-8859-1?Q?UfFRGlE0dncoBQxW3Crhb+tuc1rMsGw1JJ7Ch6RR9F+av+nlbf3g9U52z9?=
 =?iso-8859-1?Q?YQWhO3tEjU67B/DDCA2UYT2kPQOvWdaqPDQDqVyZVWmC6QnbUiJc+rHD9E?=
 =?iso-8859-1?Q?JdnfuqBAgeqUlMZaqHOt4WhUFKydJL0GwV9nbCkgrI15ATaJRUKBXKm6w+?=
 =?iso-8859-1?Q?wp35MVP7RvleG1hor+zjdMJ7FAJfdexHXnf0FvOdRvv+0YNmvD0fk60aZJ?=
 =?iso-8859-1?Q?h+DfQl0T0ky/T3acnnjQSO+JX351X5xwCgWBlkZEKNU8z4/cTZ3Kp77/dW?=
 =?iso-8859-1?Q?hCdHtHSdiRjNAqG1Ajea2Y3h+kzrkg8EC8W+VIeh5G0EPt0ydryaEPkBIl?=
 =?iso-8859-1?Q?JHQ9kT2ly4iU0TceY/8dPiV+QSfooW8BS4amvEoTe71gcgJ31Z+wqQAUVS?=
 =?iso-8859-1?Q?3IUv++A4830DbDsDD9CqqZWoZbJJb8Z6plOEhQmzoaGuIeCfT8kMSkCNSA?=
 =?iso-8859-1?Q?G2K9UhQOvLcSVqMacTdgvQ9N67uJzTQVn+27fqwR1vSAMbHvMrmUDC8NxT?=
 =?iso-8859-1?Q?tN7v/6jGcHOmjf3GxMzXWlpQrJsbwmqr26lEww/q7QDToFv5CVkOBmDVj8?=
 =?iso-8859-1?Q?G2NtS86j7iXTfagoHulwJtGvmEbylq0sy5ZRKkSBLmU88/LiTUfYmkdjZo?=
 =?iso-8859-1?Q?B58ypROxBDRdKNdhCuue08p9w545A1FE9BcWr3e2AAX65Pc+BR78Mlnqf8?=
 =?iso-8859-1?Q?e2xaMFg77l9l+Mn02VlA7FaR638SZ5m5yFRD/+RJJA/uE/007fhoTDtfge?=
 =?iso-8859-1?Q?gOMlN9MStf2lqcz6Hd6bsyYxEhmBTgenxySoFt/9We9oHxN8WNXmZZfR9n?=
 =?iso-8859-1?Q?2vTsuf7w1jBDYSRvvdJ3VhdbpjCEhoQVbZlodaPqnlWENc+1JQxjTkTnIf?=
 =?iso-8859-1?Q?yFeaH+9P/WtaJCPvj3Wy9ey2W2Rdo8y+MyC4INljne2+KSyybr2roIcaAy?=
 =?iso-8859-1?Q?69BPZ3uCxJek6Z1RcAogI7+f++8ephU6+YiBXB/VNF0UvF3iclPJRefUWs?=
 =?iso-8859-1?Q?SndTNmUnnGBYBTSh4dyQMn+lxM6wM/ys7YOck+qUFEITj97mxQsdkhZwSS?=
 =?iso-8859-1?Q?Zy1G74aDeMglwf61zUVJVyLHP+ZHI703fe1vfbtJ4FawQLtjR+OtlunUnn?=
 =?iso-8859-1?Q?LjguqC8UrhkKUbbq3pYj5wMFEohsQWWWELQgBlD+u2R0XlIWucsMCWsLEg?=
 =?iso-8859-1?Q?fc4lhA9TmKXf+ytoR4k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76596a66-bb53-4462-6c69-08dbd6e06b52
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:32:36.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gr+C/QfmXN7ifcS9G7qUAskNeqQ5YYvy/mGacttmCigWYhiBl8bc8hOMGKtOp2C0OYf3N+W+Q/LVVKM/hRkfpsQ7A4VfbeGxUBZMk1ZY0cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5893
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

On 2023-10-24 at 12:26:12 +0300, Ilpo Järvinen wrote:
>There are unnecessary nested calls in fill_buf.c:
>  - run_fill_buf() calls fill_cache()
>  - alloc_buffer() calls malloc_and_init_memory()
>
>Simplify the code flow and remove those unnecessary call levels by
>moving the called code inside the calling function.
>
>Resolve the difference in run_fill_buf() and fill_cache() parameter
>name into 'buf_size' which is more descriptive than 'span'.
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>---
> tools/testing/selftests/resctrl/fill_buf.c | 58 +++++++---------------
> tools/testing/selftests/resctrl/resctrl.h  |  2 +-
> 2 files changed, 20 insertions(+), 40 deletions(-)
>
>diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
>index f9893edda869..9d0b0bf4b85a 100644
>--- a/tools/testing/selftests/resctrl/fill_buf.c
>+++ b/tools/testing/selftests/resctrl/fill_buf.c
>@@ -51,29 +51,6 @@ static void mem_flush(unsigned char *buf, size_t buf_size)
> 	sb();
> }
> 
>-static void *malloc_and_init_memory(size_t buf_size)
>-{
>-	void *p = NULL;
>-	uint64_t *p64;
>-	size_t s64;
>-	int ret;
>-
>-	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
>-	if (ret < 0)
>-		return NULL;
>-
>-	p64 = (uint64_t *)p;
>-	s64 = buf_size / sizeof(uint64_t);
>-
>-	while (s64 > 0) {
>-		*p64 = (uint64_t)rand();
>-		p64 += (CL_SIZE / sizeof(uint64_t));
>-		s64 -= (CL_SIZE / sizeof(uint64_t));
>-	}
>-
>-	return p;
>-}
>-
> static int fill_one_span_read(unsigned char *buf, size_t buf_size)
> {
> 	unsigned char *end_ptr = buf + buf_size;
>@@ -137,20 +114,33 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
> 
> static unsigned char *alloc_buffer(size_t buf_size, int memflush)
> {
>-	unsigned char *buf;
>+	void *p = NULL;

Is this initialization doing anything? "p" seems to be either overwritten or in
case of an error never accessed.

>+	uint64_t *p64;
>+	size_t s64;
>+	int ret;
> 
>-	buf = malloc_and_init_memory(buf_size);
>-	if (!buf)
>+	ret = posix_memalign(&p, PAGE_SIZE, buf_size);
>+	if (ret < 0)
> 		return NULL;
> 
>+	/* Initialize the buffer */
>+	p64 = (uint64_t *)p;
>+	s64 = buf_size / sizeof(uint64_t);
>+
>+	while (s64 > 0) {
>+		*p64 = (uint64_t)rand();
>+		p64 += (CL_SIZE / sizeof(uint64_t));
>+		s64 -= (CL_SIZE / sizeof(uint64_t));
>+	}
>+
> 	/* Flush the memory before using to avoid "cache hot pages" effect */
> 	if (memflush)
>-		mem_flush(buf, buf_size);
>+		mem_flush(p, buf_size);

Wouldn't renaming "p" to "buf" keep this relationship with "buf_size" more
explicit?

Or is naming void pointers "buffers" not appropriate?

> 
>-	return buf;
>+	return p;
> }

-- 
Kind regards
Maciej Wieczór-Retman

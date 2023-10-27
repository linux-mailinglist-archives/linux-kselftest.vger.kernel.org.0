Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1A7D98D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjJ0Mql (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbjJ0Mqg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:46:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF7E1BB;
        Fri, 27 Oct 2023 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410793; x=1729946793;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BwVLgubuASjfEoRXu2ltxilKleLf1lqJQ9o2uDN/PSw=;
  b=F6TXrgMIrgN94BLh79Yiu2Qi29vDI3jTXpUtRqIJrim/SX6nwMa3xThS
   B9Hvx/lco7Ky43P5lOj3WshTKn6nP3lw0xRJHDQaGVqEB3ACTUxyGricG
   ngVTk2iuN4JPtBtWSLGBjVhGMCz+lUg0J0uweJQo9oPP3dJrWnqHuQ6k3
   8gr4WsGwL+9b6CIwD4QnYFc31PUjAGmi4KjHLxUNztKNpkO1vHe68o7is
   IZwgDPf9PoFxNEdSl7gcSSt1qzjNzg0n39Mt2vqPHxML4PtjApQjsAiT3
   lWUvpcTHf6/YbDFNRvq8L5OeQ4n8/Gs4NGiAYRAt//4RyEsfA1++Fv984
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="378136375"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="378136375"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794574411"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="794574411"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 05:46:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 05:46:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 05:46:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 05:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYcVq5cdvvdRyym5tuxjNJi3C0wg4NCa+fDJ2YT6bjERCz1iejc++3tnh0niNkVOY7XQfKsjB4tCOC2idXY6NkeZ90qWHEnIV6/a8vivMYKKBV/eOGpPuNzJYxzG7ZOIOJIxcWxymW1MnoIPt13H1bSxJIRiV8OhpIy0it1G19N++6VFRrdAXw4kpJhrOCGhJtKieluqFSe1dSs0FHnCC3FjPpZoo7xN8+2JBB8/88T1qOMXCJ4IkSV8HkmVZbhL/Q05RjKGolqbSbPjEGdGIo1JRbk8BMig97gXjrpKqVOcqcuRxM/CkBhIHLGn5SyIAUs8RJwcJIy6OusveLWouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnPzUGeDhftwXaGuBI5INAwGZQLKoJrlaacJKEyjyHY=;
 b=g6cg10F+OOHb4XhS3wifWtxEWI7WI/bDtnN6l4rX0blQlBjZsm3Ppv25K2TUvOMiUuBnbMTztQKFHzHRGZZjFD54gSBIVYDrdAiGvR/gJEDokXglNZY99QOFAZm0lA/iOQb6Vfx0vkIoGki8hx4PNkAFtV1JiT15rECHSGbaAynY0mJejpGfR/0gweRgbDyM4MgyFFYkhWeI3ovOuxAczLsnhyo3xKbmbZZdb7X6lQS7QD/RYk2DeV+yfQUSEGVJ+wo8eUuHBd3uRDdvWK7qWMm9VB0vX1IgKQiJT3CkTXHACo37pQqdMdahzJxeEqsGmWnj7FsGqgHkzbE1BhoTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 12:46:29 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:46:29 +0000
Date:   Fri, 27 Oct 2023 14:46:25 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     <linux-kselftest@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/24] selftests/resctrl: Add L2 CAT test
Message-ID: <62jl5abkirflkzq7mqo7wh3gqir2o6af4cch565xnojaszhur4@nvdx4gvmempi>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024092634.7122-24-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e065d56-bdca-4a73-d1d1-08dbd6eabd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pCHHJeKOlkeKIbv32TngS+w2as/hyZehopWCQ6Fm81Hv8qfRtCiKJf1pB+IWxWxklzi0tp2gZJAt9230jvdslVyyixDIBUcTC23IwNsV8TxsXS8/YKjT69FFzBCJULVAOxiJ39YTOOqC57wIdTRkf8oABz+Z3+fhpeiFIDsCAidNzy/cuuGSxoGWwGx9RHGlNGqK57PD2yh6peFrXlKhNFueuN8lFW4ajcPxKDKvagUAsGXAXDvxtqnUnMXaJSI653T9sMoTJbumZpTXMi74QfUH6U5ErABrKUZZz1lje3hJcFh0ArUfJ96i8/9/YWw1vfhmoc7X+em0YrP39w/aWnnGIm3L3pLuWlzJ53MktQZSE3DgSZ43uMLBcxk3tXI/e2SAa9QkMm1IuL01EzKMIVzLVIpkvOlxskWcTEbRjdG5I8ZQU9KBNWTX7Thivu3JpVT2SWaS+NVjycW+yDc/Y7b7+I1Z1YpHjvTqc3Wu4LGms6/xq4SrSzfNcFKuNJg8gaAi9ZsLpHMLmhxv0ngiP+Irwd5IxtfK3c/l1InzRJGzxmQL2vnnQ9rdrUgsxyX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(5660300002)(83380400001)(316002)(26005)(53546011)(66476007)(9686003)(6512007)(54906003)(6666004)(82960400001)(478600001)(38100700002)(66556008)(6486002)(6506007)(33716001)(41300700001)(8676002)(66946007)(4326008)(86362001)(8936002)(4744005)(6916009)(4001150100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3/lboIpV7fjEYpS9AfcmABms+n/WBxQn1Ros4wWz9O0LTU7srDsnwZvMYx?=
 =?iso-8859-1?Q?LKSa4RvLguD5RU6vApp2NI/w/cmGsnqsM0TjQPANE14oAOOd1AmJrssxbF?=
 =?iso-8859-1?Q?e3PF245F+5ysEXVFxJMXWkS4Enz67kvxe+AFnVz9htZEgMjxroZibI32GA?=
 =?iso-8859-1?Q?/0KKl0vGYXW9dAi4KGBliIlGkjejPYC0jh/E5GbDehlmfHup1Exbcgf8lp?=
 =?iso-8859-1?Q?Nb61mSksnkojjVFY5Y/2XQ/gOXctTZY2hwDJlVOD+VN/6Cf0LwL258lQl7?=
 =?iso-8859-1?Q?/a9THVTfoy+6O2LHQg4vUrZnyu6HMO1r58oEbyshJEZF1QUr92lrk056C9?=
 =?iso-8859-1?Q?JlC5vlZtQytU6bGT8sbImnX9g+eK2RAV1oe/M2n7LLkX5JEhY5L8mPH6tS?=
 =?iso-8859-1?Q?zn+7k1j2AER6C/kVgauwSSY8PEccRVnxFYIEhi9bqFSO6cTsTi7eDQ0kgU?=
 =?iso-8859-1?Q?FjDbfUQzyWxyV9Q9HSgBvk+diAunQ/QxyoQjRBsqM3Rpb+K2z4vq3F/v7b?=
 =?iso-8859-1?Q?IW11vJcEsJ6FC3L9ASmrUk9bs9FKKnIpvLCoOkqyPuhi30zCwKfQ18w5W4?=
 =?iso-8859-1?Q?6oLT92c5qqpwNlQ7H/cNmMFYuHE1yqM83HZq7+qniFwZ6H5arplqEwtBXK?=
 =?iso-8859-1?Q?iI514oJiaphtSWjtuo6HfHJpQGgeFj6xezUA3om1kdcAOAf8n3w8+jbE4K?=
 =?iso-8859-1?Q?eWGVCt+c6LkKaqKZaZcQhJeuooCNGEulX/CqOXzVKiyqLJKWpCA1x0rSGb?=
 =?iso-8859-1?Q?nYGPQfZaetP0uiYJ8qCMX29F7mucdVofubLhOn5pcJY2IPjZ4HOPIITs8n?=
 =?iso-8859-1?Q?z+LHurtkW3mzK3OI1PONm6F3N0uQDoaC/VbppgsnG/RDeCwtWzQfdnSZPl?=
 =?iso-8859-1?Q?620Lh6Ao7LKsc5VpeuS3nlBgSUB2vKUPsmfciMZEaKtW6Ddgzf+kDXpjxp?=
 =?iso-8859-1?Q?3nMOAxwyeeC23nDSWA35MyS64P8etnKph/lms/D9h3E+AxX0ygaoHZ6bDl?=
 =?iso-8859-1?Q?IkJTjSFZuqU6PaVX4MkDHHC+Zn2VbcjXEHf9HIZIga+FE3WtImK4zvrGlb?=
 =?iso-8859-1?Q?AkaKDuUdMNivbt7ChAJXtYoWZe4HbHpQlaP1tPh12uW/rHg1/jsIEbBuDf?=
 =?iso-8859-1?Q?kdm2sTLR7s1fQOfxT5B3seL0xo5Q2AzkEqKlpIG6wD8afU7XdSk/Ot5nco?=
 =?iso-8859-1?Q?gm2t+RwevTwyaFpjLUWP8VEkgE+IH/fkjrCJv4dn/E1DkZmKoKK3jbzYgj?=
 =?iso-8859-1?Q?hvX38tbChlGMTVUt+Ij3ntnfM8mUt9LhX/drFt+xge6BG1VpajwsvmX9Fh?=
 =?iso-8859-1?Q?2STrLgZbTzSQiRODyPg12OKI9ZtD3qBnf8to+dg1uqHCQq+jus67VD3KJH?=
 =?iso-8859-1?Q?3bNnbExQtxNBwXgbIPXZFuI8YHTIS4Tawy5W9ZGhhIFKbw0N0m9zoBvFRg?=
 =?iso-8859-1?Q?9x/kX716Z8uOxPcmpYkXmVBNtr2K+wdMg7KbTyGePisvlfEWw5JroCPKmm?=
 =?iso-8859-1?Q?GwMoi8Z2K2zCFzknLIBZngkzQkIf6qWtefEz02YhWoXqOyotJLst0a/m4X?=
 =?iso-8859-1?Q?S6yX9O1OHYzjkLaa5N8KLfwGoozX3ZegI3eJJb7EzGsnhYdIFVP0F78VGo?=
 =?iso-8859-1?Q?juodIjEgn8qeOB3ToFdxvZgnYFCNcLJ/oiW4SyfWj6Xl7JSfsHartvw3uc?=
 =?iso-8859-1?Q?3/r6xAQ1GAP5mSP5LjY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e065d56-bdca-4a73-d1d1-08dbd6eabd82
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:46:29.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjA/TUdElnur0g4Ezy6sVgAMHIqAVyqZda6rBfSqAsVZcsOjIiAtzM1bHEArwCwN7S7FNSni0TV5E0H4iwpU+C42lhivwCTWqHKeBN8FXRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-10-24 at 12:26:33 +0300, Ilpo Järvinen wrote:
>CAT selftests only cover L3 but some newer CPUs come also with L2 CAT
>support.

Is there some some defined line since what CPU model is L2 CAT supported?

In my opinion, from the perspective of someone digging up this commit a couple
years from now it could be handy to have something more specific instead of
"some newer CPUs".

>
>Add L2 CAT selftest. As measuring L2 misses is not easily available
>with perf, use L3 accesses as a proxy for L2 CAT working or not.
>
>Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
Kind regards
Maciej Wieczór-Retman

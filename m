Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8C54A2FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiFMX7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 19:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiFMX72 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 19:59:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28752CC91;
        Mon, 13 Jun 2022 16:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655164767; x=1686700767;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xyOvQDkKtSPXP1+AojOnT8M23Es00UpZ29kvrxncnBQ=;
  b=aMuSfZYAwO2FNk+cTnE0d3GMvO60bjjjvXPuBveaMnKdLeuZJpJFBYjC
   1lgxXo6kFhtSFuLxO57FsyMUZEPBkwbuyz5MzE+X4q/DRVAsTNcIKWVe8
   Qoi4CEG/vky5njNfLhQ9K7BDqrKJYVQbNd6urS1twu+cpVvCKr6iAWuVy
   aooNruwFzZ9CwWtC/uRq9NhK+ATC7ggWzG7dg7RRQvGo8SuvhQpu7IVQn
   NXrg5YXLD3axXtfCm1OILzPFYs8Ejz3J08jWKtVs9Ck6Sg5Q/jFdCajcN
   ZweNFyjYlRqehX7Me11St8cHjT1e3iGXHmKyepNgi+QcgAUWADPZAa0OR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261484134"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="261484134"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="558060587"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 13 Jun 2022 16:59:27 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 16:59:26 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 16:59:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 16:59:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 16:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8To1KufLJ9o6ZcLO/s1lfNea1P3FK4Ny/d6wadMRJ4UVGnnzRKg1NvQ1iadjiD0EnGWF0eM+o2Zoyv/5FaJA5wQTnqwLqyaDgnwTf8VDU/KSK25w4D9XCkDn3Sap73ZFXhfHyX59Ry4hdKz/fbhS6SNFhdqSeZLjrdq9KemlqoEMDDfLxwyYFv/jo4CtQds0NvVQr6vY1k5VMVI7RMV40Bf29eSd2iXW4M0mJxKSf9m8OvOWhdKaBREEgRw9RX+90jrmUFyfYovgkUv8VSJGIZwfQfQO9jl5BzFaqQR+nlPDcgWn6/Cyh8xXbge9WrF3fB88owpAaHks5RYWEIZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b0pWpQvticPybBZ1P1jsVe2b6o0Lpy87wMWqLOWnAA=;
 b=FQ3qIUe/El3IJNru1/gugBg/O6vzqVVvqeREsVfeU82pq9CuCKIEwrCoV7ty3ZaBdos1ZzFzsaRdu2xZQdvBF6JBWSAaS/NJGYepkC1l+ZcTO6gefTpaiimXkmHLbNumYGVVCJD1pShXrkGd6kiOuGpL1n1bJTDAUR/cR8qrWJkzJSKEHHlHZxGem4LoLRKsHzXOBgM6Cg4QdI+7B279POU5B4sCtwdw7qdQx9iW397PYkOV866D9ICSh+xLaDvGeH6fmjkF/wOyAasbRNC5Va8dTw67cfCy8kFiqnFijAaPqeajifUxlaibKeJqStIe43X5WQ1mvz3vqSJRB0+GiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BYAPR11MB3431.namprd11.prod.outlook.com (2603:10b6:a03:8d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.17; Mon, 13 Jun 2022 23:59:23 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::d4e9:9ae1:29b2:90c%5]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 23:59:23 +0000
Date:   Mon, 13 Jun 2022 16:59:19 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Sohil Mehta <sohil.mehta@intel.com>
CC:     <linux-api@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        <x86@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 2/6] testing/pkeys: Don't use uninitialized variable
Message-ID: <YqfPV3AGo6ZWCsr7@iweiny-desk3>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
 <20220610233533.3649584-3-ira.weiny@intel.com>
 <86c1b1fe-0dca-ce26-874e-aa83e3c77e6e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86c1b1fe-0dca-ce26-874e-aa83e3c77e6e@intel.com>
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a7744df-1415-411a-126a-08da4d98bd40
X-MS-TrafficTypeDiagnostic: BYAPR11MB3431:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB3431F51CEE37C45A4446FC33F7AB9@BYAPR11MB3431.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCjkMQGnFDcuZBQ2PCdA3SvUosKbp+sjJns/oYm2zxWUOuee9YSOrjh67utxenEM3PEkge+oTn+oj7IlA3A4zPWq2TTLgQwPr0DNmf8oVa5S5hCxlE8EHOMyunYWohCak1f9J3TkasswnlnVbx87Z1RtBqIXO5IU715m2Vq5wCZkwXd4Ty7DKrKr3XzKplloCS+zLwYhkWx7K++jIdyndjWqGBeTPJJIdzKvy7JmGX4ks1QiEfAdnwqLHHdYqPVmYeoJLwSZrF9UDGtNzNUpYMsxhGauB4wjUJDyIX3NoplQ3UD8GmDQ8oniosWV6owX2pZSxJpClpBOw//64moeTLb2GXMF/QG+M0wEym/700zH+sCQ6u88Hh+dZP7i1AEKy627yixZilbRsZ1C55TyBROiv1zBudSK+WhlJireBfzkv1Wk4BaLubElO9rWke5Hwsehx8FqVr+Y846loz6mp7rnaCrUunRw3dtpLZKU5XF/DsT6TFxRJPi+OoPx+dZtfmZ8aPsC7v4qdBALg105+mZMEsBAa3SYuAEo9ndXE721EmvRt6J+FKhrXZS6GA+3F3hKGcDa/nbj1PD9fmQywsI/JV3b2sgecbS4bUkkIRyX3cw3ly48SfCITFvG0xjH8P2CsQe+k8ZRrm+6VUrqjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(4326008)(86362001)(8676002)(44832011)(33716001)(5660300002)(66946007)(316002)(8936002)(66476007)(6636002)(66556008)(2906002)(508600001)(6486002)(6862004)(26005)(9686003)(38100700002)(54906003)(82960400001)(186003)(6506007)(53546011)(6666004)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xY558uuTdAC6krx5h4DuGF4peKd1HcWdJ9NovUXD2mlMAeO26+ubS+n5/sd4?=
 =?us-ascii?Q?+/VkdrJSw+bg5VjWpKP4qzxPFiMUuLzHF4KiRqHJNKtPGuojVLstCTbkj9Gu?=
 =?us-ascii?Q?ZOWEqFpmu1fscuMzNmaD1te+buColQ7MipUfiuBeUXVzQNwTpgHYbMsBY2c7?=
 =?us-ascii?Q?vAVey/3Qm9lE4OIRu9HrI3SpTxrKkzClCCwiBHFjuMFEQ81jz8cMZSUUTDj3?=
 =?us-ascii?Q?iswzWN5jxoywr6jR1G+VUxhsL3c4yx+UZksbJiD50pqJ1Hv7IJt/H5kyKnzK?=
 =?us-ascii?Q?fEp5UEn1FVtH78/wYEo0wmJ4UkIRU98vxRzxno3sqr1QKfagcJO6UNfpE3Of?=
 =?us-ascii?Q?z2SYRkIVwNUvlR7c6vdS06qMJvXiXFkZFrtY9E7mv33efuA12+sLFDyKXBp4?=
 =?us-ascii?Q?5o28FTBhw2su3DRVavaEDFMVHcDFyLQPID98CV9X5/EO6eYoD8RnakvlBBXu?=
 =?us-ascii?Q?tqZjIs4P7tzVuhACd5khrFCr3Cp/+xlKvHwoU3kC4G8YEUSikOU/VfjzIDKi?=
 =?us-ascii?Q?Xgco2WB226QeUATSI6m0Lgf/v5rF62oJT7Pwo3PFuRM4QO4JwNUYlj/LYnMA?=
 =?us-ascii?Q?9Rty3HyC2qwKBAui3/8zFYCIRqUDUT0PAzCZj3j/Ya0H7DV8cYxqn7uhUiZO?=
 =?us-ascii?Q?+zkU2mRMecJfXY87bqmmlpBwXwypCEb52wpnJn1aP0xs36h67yO4pyjK5L8U?=
 =?us-ascii?Q?Ok0GTRGkoNS4PdoHjyeZeN7G72ICSEINDPeRlbUl+TzhZiZY5U7I1greByT8?=
 =?us-ascii?Q?kfXjguYvEj88HPHOWkjEIE2kC6bso7BGcj4a7BTeo1/FI33n8RNLGW9TiAac?=
 =?us-ascii?Q?6x1u8r5FpXOoxLiPSy0690B8Oen/eTAu4HOlvcXwp5cncajywcrkZNFHkZ17?=
 =?us-ascii?Q?yUrsT/xbHePmyAe/FzH9PfNjvuS7cPWB0fft8wQ8r1wwNSyDRiIRi6xPDgkq?=
 =?us-ascii?Q?MiSfJ/1qjgyn0HwLdvuxVw6yGM/K4KF/KxdsimDn5JtcSx8mXjq41qNhe5+E?=
 =?us-ascii?Q?8l9ubc3hYNxP7fExC8UWUmA7fHGyh2mJjmerbNM7zliJchmQIE5QdT68oO1g?=
 =?us-ascii?Q?E1b5s4tJpXFQETp2ZtAiBIZjb4HhqgMZvp1TJndTL28S2WADAB9EHh2aYdEg?=
 =?us-ascii?Q?/BFLADkCzrAWDg7mPflclE6AB3N1oEDvJpAL0QFONPAW9DNahleLRpNqYzYn?=
 =?us-ascii?Q?IpqS0aLGVAUaMeNJeFeGBAYFwYM9wDQM7CsIZKsdXuYUIg9ODZTvYnMFO2t/?=
 =?us-ascii?Q?HnTKeNd06aSsf03tqirKvk4xedeJvAim44nRXoqMMdmuRroUv/Pi3hpSVucV?=
 =?us-ascii?Q?Va3GnurCe/hJ8/9UD6xTcw7jscDiGK7vBxJhB+pUeSg6gY3X9Vbbb6IcCOhl?=
 =?us-ascii?Q?G5f9uh8XknyNwot+NHKofMPSQ56QoKOuw9dSQvjnwUS5Q8NwRt4it8ZXs09X?=
 =?us-ascii?Q?tUcQ4oBro0uHivZK8AH1VnFDS2kUEdPlfrhkkw81QXgpdWAw0x93oRVt10qe?=
 =?us-ascii?Q?QM5zjFi67gUVPRPF2DMv/IZmQVB9HBAsJ6TWhPiDLptm5zhXDHvigguQblja?=
 =?us-ascii?Q?jTGQYc3oUwdGahU26OYUIhO7lLuGvtfUaPkpB07Xrba0WqlHIe57TrhmAr6R?=
 =?us-ascii?Q?3iFmAeNlHfPdTrOLkLSnOf/PQptr8xjg7lZ+jyVvMhAlS4hdktMd1Ti4TQW3?=
 =?us-ascii?Q?muIuZS6K9nonsuTMtCXczptoZs8yEeu00UkjCSMDLltfmRh0TA4GVtjNykGK?=
 =?us-ascii?Q?uisAxABxLQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7744df-1415-411a-126a-08da4d98bd40
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 23:59:23.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkaeoJV5N7monQ8yIb3lRf2fG9jZFnFsPDB3xRNl/j/eZn6pIAChLjCKCjBXTdcqXddTurh9+OiY4qxV3eKIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3431
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 13, 2022 at 03:48:56PM -0700, Mehta, Sohil wrote:
> On 6/10/2022 4:35 PM, ira.weiny@intel.com wrote:
> > diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> > index d0183c381859..43e47de19c0d 100644
> > --- a/tools/testing/selftests/vm/protection_keys.c
> > +++ b/tools/testing/selftests/vm/protection_keys.c
> > @@ -1225,9 +1225,9 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
> >   		int new_pkey;
> >   		dprintf1("%s() alloc loop: %d\n", __func__, i);
> >   		new_pkey = alloc_pkey();
> > -		dprintf4("%s()::%d, err: %d pkey_reg: 0x%016llx"
> > +		dprintf4("%s()::%d, errno: %d pkey_reg: 0x%016llx"
> 
> What is errno referring to over here?  There are a few things happening in
> alloc_pkey().

Good point, but the only system call in alloc_pkey() is pkey_alloc() so it will
be the errno from there.

In test_pkey_alloc_exhaust() we are expecting the errno to be from pkey_alloc()

...
                if ((new_pkey == -1) && (errno == ENOSPC)) {
...


> I guess it would show the latest error that happened. Does
> errno need to be set to 0 before the call?

Maybe.  Now that I look again errno is printed just below at level 2.

                dprintf2("%s() errno: %d ENOSPC: %d\n", __func__, errno, ENOSPC);

I missed that.

> 
> Also, would it be useful to print the return value (new_pkey) from
> alloc_pkey() here?

Yea that might be useful.  Perhaps change err to new_pkey instead since errno
is already printed.

Ira

> 
> >   				" shadow: 0x%016llx\n",
> > -				__func__, __LINE__, err, __read_pkey_reg(),
> > +				__func__, __LINE__, errno, __read_pkey_reg(),
> >   				shadow_pkey_reg);
> >   		read_pkey_reg(); /* for shadow checking */
> >   		dprintf2("%s() errno: %d ENOSPC: %d\n", __func__, errno, ENOSPC);
> 
> Sohil

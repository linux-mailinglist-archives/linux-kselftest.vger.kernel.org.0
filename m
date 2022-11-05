Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00661A6C3
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 02:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiKEBs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 21:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKEBs5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 21:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0972252A;
        Fri,  4 Nov 2022 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9U5xi3PcgZdoJ36o8T9jPl/wvWDSsiwJ5sUl4RJdjZk=; b=ePD8DfII+AqMG+pbpQoEpH39TY
        s+hVP+5iEsxjJ8oU86NNuGgxNscBI7RVuaMQbhuxsUyc/NKsegOoKTu/d3lCJQEInm5686UJ6Wa2e
        p0O0X1IJWg4TguqnCcpF2gp22n3prg5INmSuVElNXeIumuzFhWMKz93GgmUd124H5vWdo9DX2GC/Q
        L6RAQPhrX291UPkprEzJu1CtIYExY65loSeybACFw2S2XzgqwWva6KN++Siq3RaGhJlXWgJofVPCm
        v29GnWL13GD+OZXJbOGFp2kJC0vlR+ZkeoBgCdlerynfZczDbJysumW3Tp8rsw/r4ky5ORlT1kUl/
        ze9pMWlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1or8IR-007rC4-5c; Sat, 05 Nov 2022 01:48:31 +0000
Date:   Sat, 5 Nov 2022 01:48:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 03/15] interval-tree: Add a utility to iterate over
 spans in an interval tree
Message-ID: <Y2XA702nWRGfP7mo@casper.infradead.org>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527666424E77F8417DF1BF4C8C389@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y2VqK3m9i6FlQd9+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2VqK3m9i6FlQd9+@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 04, 2022 at 04:38:19PM -0300, Jason Gunthorpe wrote:
> On Thu, Nov 03, 2022 at 05:31:17AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, October 26, 2022 2:12 AM
> > > +/*
> > > + * This iterator travels over spans in an interval tree. It does not return
> > > + * nodes but classifies each span as either a hole, where no nodes intersect,
> > > or
> > > + * a used, which is fully covered by nodes. Each iteration step toggles
> > > between
> > > + * hole and used until the entire range is covered. The returned spans
> > > always
> > > + * fully cover the requested range.
> > > + *
> > > + * The iterator is greedy, it always returns the largest hole or used possible,
> > > + * consolidating all consecutive nodes.
> > > + *
> > > + * Only is_hole, start_hole/used and last_hole/used are part of the external
> > > + * interface.
> > 
> > slightly better readability if moving this sentence into the structure as
> > the break line
> 
> Do you mean like this?
> 
> @@ -37,13 +37,16 @@ interval_tree_iter_next(struct interval_tree_node *node,
>   * The iterator is greedy, it always returns the largest hole or used possible,
>   * consolidating all consecutive nodes.
> - *
> - * Only is_hole, start_hole/used and last_hole/used are part of the external
> - * interface.
>   */
>  struct interval_tree_span_iter {
>  	struct interval_tree_node *nodes[2];
>  	unsigned long first_index;
>  	unsigned long last_index;
> +
> +	/*
> +	 * Only is_hole, start_hole/used and last_hole/used are part of the
> +	 * external interface.
> +	 */
>  	union {
>  		unsigned long start_hole;
>  		unsigned long start_used;

Or you could kernel-doc it ...

/**
 * struct interval_tree_span_iter - Find used and unused spans.
 * @start_hole: ...
 * @start_used: ...
 ...
 *
 * This iterator travels over spans in an interval tree. It does not return
 * nodes but classifies each span as either a hole, where no nodes intersect,
 * or as used, which is fully covered by nodes. Each iteration step
 * alternates between hole and used until the entire range is covered. The
 * returned spans always fully cover the requested range.
 *
 * The iterator is greedy, it always returns the largest span possible,
 * consolidating all consecutive nodes.
 */
struct interval_tree_span_iter {
	/* private: not for use by the caller */
 	struct interval_tree_node *nodes[2];
 	unsigned long first_index;
 	unsigned long last_index;
	/* public: */
	union {
		unsigned long start_hole;
		unsigned long start_used;
...
};


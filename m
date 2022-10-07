Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D565F7B0E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Oct 2022 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJGPxn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Oct 2022 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJGPxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Oct 2022 11:53:33 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C8FC1E9;
        Fri,  7 Oct 2022 08:53:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8B99E5814F1;
        Fri,  7 Oct 2022 11:53:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 07 Oct 2022 11:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1665158007; x=1665165207; bh=9t
        sb9wlbhg2wmiRG5Nzf9i4BhlbHxnw5RiWDYkRyQr4=; b=HOo2Y3LHzDs++1CDaT
        XlrzXDxCnCzURKKnIunCuyCe6ZeVbhfIyJ6xBxtYPKfXNr7hWpOhGQV3Xi89eknW
        SOTY0RmVXcD5mTAgdgmROucP+VtPrTRI8LxFES4DREYvjpX+td5ji3/cKXus0Asw
        85eySAj2G6/kXjOC72tME2Z4Y3qmMZlJdXJSKc+o8NjiWnufcrX/JX7gbERka3M9
        RJQO38bqW6lTm7g3knzSafmkYGQxEZFY9lPvemFMJeZwUMPcKyEtUoj5cCgU5lzA
        VBWnrcVnMi1o4aqHMybNWjZvc1lEyOiDp9eYkVnT42FHgjEbfAMlMeJ3+1SDU/Ld
        kX8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665158007; x=1665165207; bh=9tsb9wlbhg2wmiRG5Nzf9i4BhlbH
        xnw5RiWDYkRyQr4=; b=cXollEPasIrg+MdFe3Iq3JxE6gyZ/zuLfdrdi3ASj99v
        u8GKHKtKfNGWtbaavynzepBNvnozmYrZL/81RK6VRHb69CRHN0H4piErTt6Kqk6U
        NsNWM03IiBMtlWYBSOvI7OIGMKvz7uifxWzaOeRGiVY3Z7T1NEkMB6VFLBTcEEZe
        dbD3yt3p4zUL4XMC+1dtPmYRFTPAFKAq8y/CoXut5GWjqk8+JTfuyjrbH+g3ibEp
        ecyAm0lMvFvDJZ9XwrT7BtVYEuf23geAMROw1iKl6bfYKU7AkBpNyaOo7UDkeuhC
        aK6QUh11Kdglggjb8/MTdyqBnUhkOY2RHzA2QEaXhQ==
X-ME-Sender: <xms:dktAY--KYvIks7O1_qXPTIOiZOJPw0b4HNfaA2umMKUikTPc3xVOBg>
    <xme:dktAY-v9EVs-Zf2XItFfro7rmXvMfN_vpibeSY32Wy6zutu-hpFroRU5gSAdHVqGc
    mF_4MzsJubCzKyqK0k>
X-ME-Received: <xmr:dktAY0CXzsYAyOz6VCG0HMj09CFbbtFoVqPGy4HPB5JihrtOl1JKd5DswzhnkTTG5zK4eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:dktAY2dSvXWnJp59P65-wWErWt9P_xlR0C20caECkyaVblbl0FvkBg>
    <xmx:dktAYzNk3L5pABrC9oXWo03BSE_dvAXmGDM2xDJY3ZcupDrTOsRHgw>
    <xmx:dktAYwkYx18CAqSc1VsDQ_0wlMYROw53ltogGQk6T2jaGLAHbbo6Dg>
    <xmx:d0tAY2M_O9EHiuHwJ--kc3klBkOc3A7JdF7ncuCvKyUEyWp2Uvb0Og>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Oct 2022 11:53:26 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CD00E106002; Fri,  7 Oct 2022 18:53:23 +0300 (+03)
Date:   Fri, 7 Oct 2022 18:53:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Subject: Re: [PATCH v9 2/9] mm/mmzone: Tag pg_data_t with crypto capabilities
Message-ID: <20221007155323.ue4cdthkilfy4lbd@box.shutemov.name>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <20220704135833.1496303-3-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704135833.1496303-3-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 04, 2022 at 10:58:26AM -0300, Martin Fernandez wrote:
> Add a new member in the pg_data_t struct to tell whether the node
> corresponding to that pg_data_t is able to do hardware memory
> encryption.
> 
> This will be read from sysfs.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  include/linux/mmzone.h | 3 +++
>  mm/page_alloc.c        | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..6fd4785f1d05 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -883,6 +883,9 @@ typedef struct pglist_data {
>  	struct task_struct *kcompactd;
>  	bool proactive_compact_trigger;
>  #endif
> +
> +	bool crypto_capable;
> +

There's already pgdat->flags. Any reason we cannot encode it there?

>  	/*
>  	 * This is a per-node reserve of pages that are not available
>  	 * to userspace allocations.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3df0485..147437329ac7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7729,6 +7729,7 @@ static void __init free_area_init_node(int nid)
>  	pgdat->node_id = nid;
>  	pgdat->node_start_pfn = start_pfn;
>  	pgdat->per_cpu_nodestats = NULL;
> +	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
>  
>  	if (start_pfn != end_pfn) {
>  		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
> -- 
> 2.30.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F326F0CBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 21:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbjD0TyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0TyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 15:54:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2CC1FD0;
        Thu, 27 Apr 2023 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682625240; x=1714161240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xrpkglXBXdbRV9vHfNaD13CAR/JYQfpf3YtjUI/QnLs=;
  b=N47z1GSYJfe1JwaHTEQ95lZBZ5PvUXVVLW4faM3mnNVDB36zA0e5/7mR
   7eoTgaKrGUS3Y+tZQITNVIqnvSvu/2ZvKVpqLL6ZLkW4sOAxjY1c77MGY
   EkorYG1laZPAd1yN/0qwWkSNqhl2gwetx69YtM5v7Oidx7jr8uKzWipfS
   zCHvDvuPra5407EZdUEr7ZPIeuD8KddJjpnQ9RSwqbAft43BbrnMubbVK
   rf06vHKvyBnHrcagZ3x7Vgpi40RJMLXAfLqGh2Fkrgk7GeEZ0pT5c/9mx
   /2Tne53rNIg38+dvJSd6OMc/cSKuN5VXKGNvHjk0BT8dCVWWG/IfWuw9G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="410614059"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="410614059"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:53:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="725068190"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="725068190"
Received: from jonnaman-mobl2.amr.corp.intel.com (HELO [10.212.24.30]) ([10.212.24.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:53:58 -0700
Message-ID: <10248ba6-c5d4-47dd-03e0-0500d4c4a621@intel.com>
Date:   Thu, 27 Apr 2023 12:53:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Chong Cai <chongc@google.com>, Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAH4kHb_PAhR5jLFi2KsGku9ALNtjtxb-JO-k1ULK-Mj5mi=pw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAAH4kHb_PAhR5jLFi2KsGku9ALNtjtxb-JO-k1ULK-Mj5mi=pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/26/23 08:47, Dionna Amalie Glaze wrote:
>> +/* Helper function to get TDREPORT */
>> +long get_tdreport0(int devfd, struct tdx_report_req *req)
>> +{
>> +       int i;
>> +
>> +       /* Generate sample report data */
>> +       for (i = 0; i < TDX_REPORTDATA_LEN; i++)
>> +               req->reportdata[i] = i;
>> +
> Shouldn't req be zeroed before populating reportdata? We wouldn't want
> uninitialized memory to leave the guest. I know this is just a test,
> but it's best to model good practices for anyone that might
> copy/paste.

It's leaving the guest and going to the TDX module.  What's the problem
there?

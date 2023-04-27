Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288186F0CC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Apr 2023 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbjD0T5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Apr 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0T5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Apr 2023 15:57:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DF1FD0;
        Thu, 27 Apr 2023 12:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682625420; x=1714161420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=haUZlRZVpKJjs4ThNpRF4P6XcJnbRFVkaRfj4rKvGQM=;
  b=Tt8qcUcYkXFpLJ4j3rDUq1mJ++3CQ4IHBrXyhcIqKzLLFcmYePmf4fOu
   FXKqk5dDER9tk4WZjRi2x6ffIY7m/K2APq60GhSC/DFAOX6Wy7YNjW7Dl
   YaqF2fcP4YJJWE7PX3pUqfkxEv1sR3KvIj02g1ssg9svgekTbIGPAbuOV
   6Q0PbiwJLSZ4B9YHs0WRmNCI4HyAGB3NB3QKrgeCOR7QLJU4fb6+mdwPS
   8x5Xp/+Q/dtSPdK3SHUlaZ5364TqFfLQOWbcNGoYlyazEOiWe31woRvZh
   owrS23sNdh2qe949qrjLuwS42QNbJ+yKjdX5AJmq4DQj5MJsOI6txZVj4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="336556487"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="336556487"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="868857114"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="868857114"
Received: from jonnaman-mobl2.amr.corp.intel.com (HELO [10.212.24.30]) ([10.212.24.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 12:56:58 -0700
Message-ID: <7d3f1877-8762-34f4-f1bb-c5c2924c2b77@intel.com>
Date:   Thu, 27 Apr 2023 12:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] selftests/tdx: Test GetQuote TDX attestation
 feature
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
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
 <a418c2d3-e333-fe3d-63a5-c6e555f81fc7@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <a418c2d3-e333-fe3d-63a5-c6e555f81fc7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/27/23 12:10, Sathyanarayanan Kuppuswamy wrote:
>> Shouldn't req be zeroed before populating reportdata? We wouldn't want
>> uninitialized memory to leave the guest. I know this is just a test,
> There are only two members in struct tdx_report_req (reportdata and tdreport).
> The reportdata has already been updated here, and the tdreport will be updated
> by the kernel on output. Since TDX_CMD_GET_REPORT0 IOCTL handler uses an
> intermediate kernel buffer to the TDREPORT and copies the generated report back
> to this user buffer, this uninitialized tdreport data never leaves the guest.

Is that really even relevant?

I mean, we could implement the whole thing with get_user_pages() and
then just pass the physical address of the reportdata and tdreport down
to the TDX module.

It doesn't matter either way.  The data is going from guest userspace to
the guest kernel to the TDX module, all of which are trusted.

It's a selftest.  I'd just leave it alone.



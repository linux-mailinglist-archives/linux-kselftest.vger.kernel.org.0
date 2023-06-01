Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB39B71EE9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjFAQUS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjFAQUR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 12:20:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ADF12C;
        Thu,  1 Jun 2023 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685636416; x=1717172416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=66IbxJcu+ERP7iDReAuuseWeSYepw+/LOPDcQLh6/HQ=;
  b=cQMgBE2wPwabOoxsqdvdV0HK9JzB/E25Aiz2JnLsAHxW301ib0A0g0Ws
   JLipOHlD4uKXnpvr/NaWWsBq6qnjpi8d3q908UMbSvFC4uVOcHdiTfW7+
   89i6XwssIWsRqZVQ4LfO1IEjUPAY2si1OIyOpoAzGICsdYN2aXzV/C8CV
   ivVr0kpBwofVYYfuTART+fK8nI7UrTBgOnIzgLhjO3Ff8cYHAoSVcaVdc
   iD+QStK4AlHcepQ3TWONa4pAjzZuAdJf+F9q6LP89FUilPy6JI1kVlttI
   00exzl1ZDTsDLMMeF7BU/IjJQkoET7NDi9AdavlZupquxvV9TvhWtXyYK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="383879560"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="383879560"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737160337"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="737160337"
Received: from jdboswor-mobl.amr.corp.intel.com (HELO [10.212.227.45]) ([10.212.227.45])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:16:03 -0700
Message-ID: <d29492e3-b071-7b16-41ec-c499d6802257@intel.com>
Date:   Thu, 1 Jun 2023 09:16:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     Jeff Xu <jeffxu@google.com>,
        =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>,
        luto@kernel.org, jorgelo@chromium.org, keescook@chromium.org,
        groeck@chromium.org, jannh@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
 <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
 <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com>
 <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
 <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
 <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
 <CABi2SkVmAw379G-o26sZnmt5p2FY8atoDfRMfKv0yFsfJOe7rA@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CABi2SkVmAw379G-o26sZnmt5p2FY8atoDfRMfKv0yFsfJOe7rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/31/23 18:39, Jeff Xu wrote:
> I think this solution should work.

By "work" I think you mean that if laser-focused on this one use case,
without a full implementation, it looks like it can work.

I'll give you a "maybe" on that.

But that leaves out the bigger picture.  How many other things will we
regress doing this?  What's the opportunity cost?  What other things
will get neglected because we did _this_ one?  Are there more users out
there?

Looking at the big picture, I'm not convinced those tradeoffs are good
ones (and you're not going to find anyone that's a bigger fan of pkeys
than me).

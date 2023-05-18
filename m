Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C6470851B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjERPh4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjERPhz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 11:37:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36E123;
        Thu, 18 May 2023 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684424274; x=1715960274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z8XR62TLbLJfdA4SZDksnAzekPNNuRvRVdCm1RoqboE=;
  b=exF7QXgaHhCXF2x0xEDoyF18czKv63XQmiBdnOxPIs3D1DAkVz6+ST/S
   zEJJUVito1s2g29lkmyIL7nSg0pzRJ9KqsgUNeVyn0zQnP8AflmQlFoba
   yvm00VsSV15huvpVoUSvTd45Xuzg5ujR+rtxhGxNk3eJqVHRIUROXINZ2
   TanaJl1kuynwbA7OHBc7ix/zL3Lbr7ET47cFJ8q+Ge5qUNKSJUol9TDpB
   ghpWKnbBRTNvUdoM1C3R1F+vmCMY4IYnHORbgopY+vVLYT/n40da80FIA
   DOL9xxd9gAxek2nAgt780FHBJJvQpFq4QiugOgDJlaIa+5UkcbOcGQSEz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336686063"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="336686063"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="826428246"
X-IronPort-AV: E=Sophos;i="5.99,285,1677571200"; 
   d="scan'208";a="826428246"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123]) ([10.209.81.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 08:37:52 -0700
Message-ID: <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
Date:   Thu, 18 May 2023 08:37:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
Content-Language: en-US
To:     Jeff Xu <jeffxu@google.com>
Cc:     =?UTF-8?Q?Stephen_R=c3=b6ttger?= <sroettger@google.com>,
        jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com>
 <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com>
 <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com>
 <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/17/23 16:48, Jeff Xu wrote:
> However, there are a few challenges I have not yet worked through.
> First, the code needs to track when the first signaling entry occurs
> (saving the PKRU register to the thread struct) and when it is last
> returned (restoring the PKRU register from the thread struct). 

Would tracking signal "depth" work in the face of things like siglongjmp?

Taking a step back...

Here's my concern about this whole thing: it's headed down a rabbit hole
which is *highly* specialized both in the apps that will use it and the
attacks it will mitigate.  It probably *requires* turning off a bunch of
syscalls (like io_uring) that folks kinda like in general.

We're balancing that highly specialized mitigation with a feature that
add new ABI, touches core memory management code and signal handling.

On the x86 side, PKRU is a painfully special snowflake.  It's exposed in
the "XSAVE" ABIs, but not actually managed *with* XSAVE in the kernel.
This would be making it an even more special snowflake because it would
need new altstack ABI and handling.

I'm just not sure the gain is worth the pain.

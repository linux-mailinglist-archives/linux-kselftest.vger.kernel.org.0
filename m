Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E86A4982
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0SVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 13:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0SVw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 13:21:52 -0500
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 10:21:51 PST
Received: from out-47.mta1.migadu.com (out-47.mta1.migadu.com [IPv6:2001:41d0:203:375::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CE223330
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 10:21:50 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:15:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677521754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1FqEARzb0Q6bxxQRwlEFlZpVOXV7iA8ldzvL5C+2zTY=;
        b=Tpv77X0esdfptb1uj8Rrr0hRzuL5puORlWX8o5J/DfmWTURVT9shN0EbHrTP11S++Sbdu8
        v/9OzxLRjdNJyX+p364t2Jge4JmkLORX1/Q3vZ0Q81liICuuAU+++u9EL7Y4uEcNtPJhYE
        mgqS0a16KP0cyGPiUzqotahGbhpspBc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests: cgroup: Add 'malloc' failures checks in
 test_memcontrol
Message-ID: <Y/zzVWJ5PHs5My6x@P9FQF9L96D>
References: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Feb 26, 2023 at 04:16:33PM +0300, Ivan Orlov wrote:
> There are several 'malloc' calls in test_memcontrol, which can be
> unsuccessful. This patch will add 'malloc' failures checking to
> give more details about test's fail reasons and avoid possible
> undefined behavior during the future null dereference (like the
> one in alloc_anon_50M_check_swap function).
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

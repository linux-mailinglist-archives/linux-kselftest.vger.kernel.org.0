Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE915B97CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 11:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIOJpk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIOJpZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:25 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25F98D34;
        Thu, 15 Sep 2022 02:45:18 -0700 (PDT)
Date:   Thu, 15 Sep 2022 11:45:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663235117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XlqEnKpZ9ugZmlMX1I7D2QnaJ+3qHNvf2M9fSgqrqNQ=;
        b=KJbrkTQxEYc31EkZdgKAe9XBfiJzrf7+Q2Y/GvUZhwOw//VMY4cqLoiLXIDlAITwdv2S2W
        4LkpqeYfs6X6ccFY1dRFzDq6Ew3SbzdlZlxaKxBE6+loWDMEdTD6m8OtMyeKzhjsXVLXPB
        TrKxzmOasxTAkx5b/bAPqazWdtWHJzE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Subject: Re: [V2 PATCH 1/8] KVM: selftests: move common startup logic to
 kvm_util.c
Message-ID: <20220915094516.cvyslkqz644hpg7a@kamzik>
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-2-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915000448.1674802-2-vannapurve@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 15, 2022 at 12:04:41AM +0000, Vishal Annapurve wrote:
> Consolidate common startup logic in one place by implementing a single
> setup function with __attribute((constructor)) for all selftests within
> kvm_util.c.
> 
> This allows moving logic like:
>         /* Tell stdout not to buffer its content */
>         setbuf(stdout, NULL);
> to a single file for all selftests.
> 
> This will also allow any required setup at entry in future to be done in
> common main function.
> 
> More context is discussed at:
> https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

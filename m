Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7555FDBE1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 16:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJMODI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJMODH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 10:03:07 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF76B8E9;
        Thu, 13 Oct 2022 07:02:36 -0700 (PDT)
Date:   Thu, 13 Oct 2022 16:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665669658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O111GOzeXT6/nF6FQ9N+CVN5GCvOehyfupR39VAXVFU=;
        b=TnxEBg2+FA1sGGlVy4l5wiJsIgq0l11ODMeIeh+IW3VLgbMOZXI05APl/yFEG3rdVbaWbE
        bmSxuEZS0aIc8Mi8UJv25Bx+JHLjyP5NH9zIbuH9zd+glTRiUwrljwVZDLyXomNY9fl4t7
        1vCYxojorBHZ9nhKmQ3GPxhHSlK7R+c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Subject: Re: [V3 PATCH 2/4] KVM: selftests: Add arch specific initialization
Message-ID: <20221013140056.a6nw7fouxp6yuqx2@kamzik>
References: <20221013121319.994170-1-vannapurve@google.com>
 <20221013121319.994170-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013121319.994170-3-vannapurve@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 13, 2022 at 12:13:17PM +0000, Vishal Annapurve wrote:
> Introduce arch specific API: kvm_selftest_arch_init to allow each arch to
> handle initialization before running any selftest logic.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h      |  5 +++++
>  .../selftests/kvm/lib/aarch64/processor.c      | 18 +++++++++---------
>  tools/testing/selftests/kvm/lib/kvm_util.c     |  6 ++++++
>  3 files changed, 20 insertions(+), 9 deletions(-)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

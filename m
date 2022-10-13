Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0025FDBE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJMODR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 10:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJMODP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 10:03:15 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC913F2C;
        Thu, 13 Oct 2022 07:02:44 -0700 (PDT)
Date:   Thu, 13 Oct 2022 16:01:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665669674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tHlnrI7eL674lyUrWdWRUKxazO85mvtfxyUIHjcF/TA=;
        b=ICQ5dnOgne9v6P5D1aQUE0LJhd8bIzhKmohSZsWTvSHlvuwFGdejPaUdbeYb9jokKCUURx
        PcoqbC/yMcAunGuC4VtzPBSo00XpGMEokAvE8tV5xCIB6OGe1QXoQDJ9n8xrMoOH3OI5eg
        zDidpnIj3uzF9YEIooxMruIv3UjxGuM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        dmatlack@google.com
Subject: Re: [V3 PATCH 3/4] KVM: selftests: Add arch specific post vm
 creation hook
Message-ID: <20221013140112.ppm6jgoxd5oqvlgw@kamzik>
References: <20221013121319.994170-1-vannapurve@google.com>
 <20221013121319.994170-4-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013121319.994170-4-vannapurve@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 13, 2022 at 12:13:18PM +0000, Vishal Annapurve wrote:
> Add arch specific API kvm_arch_vm_post_create to perform any required setup
> after VM creation.
> 
> This API will be used in followup commit to convey cpu vendor type to the
> guest vm.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
>  tools/testing/selftests/kvm/lib/kvm_util.c          | 9 ++++++---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c  | 6 ++++++
>  3 files changed, 16 insertions(+), 3 deletions(-)
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC23B5F50E6
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJEIdk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJEIdR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 04:33:17 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF54174363;
        Wed,  5 Oct 2022 01:33:15 -0700 (PDT)
Date:   Wed, 5 Oct 2022 10:33:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664958793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wpSXCaaCB/VFL9sIVAMJTZUul9wxcN8fQGhYLRUi+r4=;
        b=FDVCTTET0Ie3fW08AizwI0u/MEGtdWVO+PXUVsCzpLY27gQl2gJ3Zt5597bMoDf50Ssrrs
        s8zT2z/jaMWoS9RCGgqz5nRZR+NEctw8q03ENwaGMItpU1fT4KdVDv+0sNlq8ALWLwndfL
        dzX5tVHD/gfW2jDmBL2QddrB/p0Rx4M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: selftests: Use TAP interface in the
 kvm_binary_stats_test
Message-ID: <20221005083312.dnblbpe6wabspkzk@kamzik>
References: <20221004093131.40392-1-thuth@redhat.com>
 <20221004093131.40392-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004093131.40392-2-thuth@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 04, 2022 at 11:31:29AM +0200, Thomas Huth wrote:
> The kvm_binary_stats_test test currently does not have any output (unless
> one of the TEST_ASSERT statement fails), so it's hard to say for a user
> how far it did proceed already. Thus let's make this a little bit more
> user-friendly and include some TAP output via the kselftest.h interface.

I like the idea of switching the entire kvm selftests framework and all
tests to the ksft TAP interface. But, if we want to do that, then the
question is whether we should start by partially using it for some tests,
and then eventually switch over the framework, or whether we should try to
switch everything at once.

I think I prefer the latter, because without changing the framework we
can't provide full TAP anyway as TEST_ASSERT exits with 254 instead of 1
for a fail-exit and it doesn't output a final TAP test summary either.

All that said, this patch doesn't make the current situation worse and
it may help inspire the grand conversion, so

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

Thanks,
drew

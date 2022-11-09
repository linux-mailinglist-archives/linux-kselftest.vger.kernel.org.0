Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2E6220D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Nov 2022 01:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKIAb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 19:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIAb2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 19:31:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45B361765;
        Tue,  8 Nov 2022 16:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 661FAB81CB9;
        Wed,  9 Nov 2022 00:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3ABFC433C1;
        Wed,  9 Nov 2022 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667953885;
        bh=60CWbc6xEw7X0NYzHrj2+bHlAe/BjGKdikDuaZWCdT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ii1ohMOHnQ8+KT4qO4mP0IdkzvaPjv1FVWeOaqhWtiqul1mOCqa5sVXVUcR20GnNE
         AxOIPigKUIHP6ez22gsA1jnva00qAOLrlvg8rJ4nNizVN3c4lL/daeimNBTLOZzrFT
         zl9HMzebVg7z6yvXdiKS4Ndi4uuAIjfp+eohzf14=
Date:   Tue, 8 Nov 2022 16:31:24 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <dhildenb@redhat.com>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH linux-next] selftests/vm: calculate variables in correct
 order
Message-Id: <20221108163124.a54f932f8f79f9c1d6e63903@linux-foundation.org>
In-Reply-To: <20221028132640.2791026-1-jsavitz@redhat.com>
References: <20221028132640.2791026-1-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 28 Oct 2022 09:26:40 -0400 Joel Savitz <jsavitz@redhat.com> wrote:

> commit b5ba705c2608 ("selftests/vm: enable running select groups of tests")
> unintentionally reversed the ordering of some of the lines of
> run_vmtests.sh that calculate values based on system configuration.
> Importantly, $hpgsize_MB is determined from $hpgsize_KB, but this later
> value is not read from /proc/meminfo until later, causing userfaultfd
> tests to incorrectly fail since $half_ufd_size_MB will always be 0.
> 
> Switch these statements around into proper order to fix the invocation
> of the userfaultfd tests that use $half_ufd_size_MB.

Does this fix address the failure in
https://lkml.kernel.org/r/202211021026.61b267d1-yujie.liu@intel.com?

Thanks.


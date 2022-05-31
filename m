Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9653965E
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 May 2022 20:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiEaSk1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 May 2022 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiEaSkZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 May 2022 14:40:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFECE915A5;
        Tue, 31 May 2022 11:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8762EB815F3;
        Tue, 31 May 2022 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F420BC385A9;
        Tue, 31 May 2022 18:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654022422;
        bh=tXaUGqk9As9IrFhg9p2k/6RaYYsLKhRUJfNXVwHGvb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TZHNhO0fPHVcQR7T6BtPA70+UpK0C1F+3xMic4eiSH5SvH/GK5T0CY+RANvC+oKEi
         k3Y2SXzbM0zeMV3R3hF5YMb+Bbk59VY0gVQlw/RsAdr0B3OL43F58bU6fYqIOo/GOR
         89ES1JLYOuqHvSM/ywW4HD/LLB2jQgLdzY/JfkEM=
Date:   Tue, 31 May 2022 11:40:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kalpana Shetty <kalpana.shetty@amd.com>
Cc:     <shuah@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/vm: Add protection_keys tests to run_vmtests
Message-Id: <20220531114021.25a8ab92ad112a4b9f985ebe@linux-foundation.org>
In-Reply-To: <20220531102556.388-1-kalpana.shetty@amd.com>
References: <20220531102556.388-1-kalpana.shetty@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 31 May 2022 15:55:56 +0530 Kalpana Shetty <kalpana.shetty@amd.com> wrote:

> --- a/tools/testing/selftests/vm/run_vmtests.sh
> +++ b/tools/testing/selftests/vm/run_vmtests.sh
> @@ -179,4 +179,11 @@ run_test ./ksm_tests -N -m 1
>  # KSM test with 2 NUMA nodes and merge_across_nodes = 0
>  run_test ./ksm_tests -N -m 0
>  
> +# protection_keys tests
> +if [ $VADDR64 -eq 0 ]; then
> +	run_test ./protection_keys_32
> +else
> +	run_test ./protection_keys_64
> +fi
> +
>  exit $exitcode

So we're presently not running this test at all, unless invoked by
hand?

I'm thinking we should backport this fix - have you any idea when we
broke it?


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A1C52FD13
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiEUOBu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiEUOBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 10:01:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4E237BCF;
        Sat, 21 May 2022 07:01:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 4D5FE1F45985
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653141707;
        bh=bRgwLFLkiauCbXyihimErrttLo91tws84Q5eVV4ePsQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=QMt257LM9O7uhUZ0il2kM2g42JZW0uaFL9+D3OM1Piezy1z3sbUqr1uQIN5D62j5+
         q2RiSw9kg/vP8US2mmcqXrKJ6byRIR2PvvDFj1w/tJtUglA011Watq8CMh8AHkDuO9
         GnXVfnftWJCX5zBWQNmAbJv5UTffp7RfOpEZEXGEpAhNVTzHKFcyxVuNHMvWI00Snz
         jMjA18KPwqvS9Oykj2hZtbYnKyESerX31uo8wRi8f8khVJPsfZQrqq6sKy9ha7phL3
         MeCZUQAWDzHl78m7VlOcbRzsrT1oCsQOYFYOCnLMiAsfMfode+LFv44wcYYcFJAIfJ
         s/eoHUfgdmmaA==
Message-ID: <27062abb-4ca1-b017-448b-f5529232cbdb@collabora.com>
Date:   Sat, 21 May 2022 19:01:33 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        minchan@kernel.org, kirill@shutemov.name, aarcange@redhat.com,
        brauner@kernel.org, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        peterx@redhat.com, jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/1] selftests: vm: add process_mrelease tests
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
References: <20220518204316.13131-1-surenb@google.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220518204316.13131-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/19/22 1:43 AM, Suren Baghdasaryan wrote:
> Introduce process_mrelease syscall sanity tests which include tests
> which expect to fail:
> - process_mrelease with invalid pidfd and flags inputs
> - process_mrelease on a live process with no pending signals
> and valid process_mrelease usage which is expected to succeed.
> Because process_mrelease has to be used against a process with a pending
> SIGKILL, it's possible that the process exits before process_mrelease
> gets called. In such cases we retry the test with a victim that allocates
> twice more memory up to 1GB. This would require the victim process to
> spend more time during exit and process_mrelease has a better chance of
> catching the process before it exits and succeeding.
> 
> On success the test reports the amount of memory the child had to
> allocate for reaping to succeed. Sample output:
> 
> $ mrelease_test
> Success reaping a child with 1MB of memory allocations
> 
> On failure the test reports the failure. Sample outputs:
> 
> $ mrelease_test
> All process_mrelease attempts failed!
> 
> $ mrelease_test
> process_mrelease: Invalid argument
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

-- 
Muhammad Usama Anjum

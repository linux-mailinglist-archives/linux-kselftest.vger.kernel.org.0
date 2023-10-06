Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A137BB09F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 05:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJFDzv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 23:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJFDzv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 23:55:51 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB40DB;
        Thu,  5 Oct 2023 20:55:49 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qobwJ-0007zW-2p;
        Thu, 05 Oct 2023 23:55:47 -0400
Message-ID: <6ab947df00886d80bd476121cd2c703eda91f318.camel@surriel.com>
Subject: Re: [PATCH v2 2/2] selftests/mm: Add a new test for madv and hugetlb
From:   Rik van Riel <riel@surriel.com>
To:     Breno Leitao <leitao@debian.org>, mike.kravetz@oracle.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Date:   Thu, 05 Oct 2023 23:55:47 -0400
In-Reply-To: <20231005163922.87568-3-leitao@debian.org>
References: <20231005163922.87568-1-leitao@debian.org>
         <20231005163922.87568-3-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2023-10-05 at 09:39 -0700, Breno Leitao wrote:
> Create a selftest that exercises the race between page faults and
> madvise(MADV_DONTNEED) in the same huge page. Do it by running two
> threads that touches the huge page and madvise(MADV_DONTNEED) at the
> same
> time.
> 

>   ----------------------------------
>   ./run_vmtests.sh: line 186: 595563 Bus error    (core dumped) "$@"
>   [FAIL]
> 
> This selftest goes together with the fix of the bug[1] itself.
> 
> [1]
> https://lore.kernel.org/all/20231001005659.2185316-1-riel@surriel.com/#r
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-and-reviewed-by: Rik van Riel <riel@surriel.com>

-- 
All Rights Reversed.

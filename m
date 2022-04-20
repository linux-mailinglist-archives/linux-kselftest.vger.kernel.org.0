Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D06850835E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 10:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiDTI2t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376691AbiDTI2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 04:28:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79535267;
        Wed, 20 Apr 2022 01:26:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 93F3F1F43067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650443159;
        bh=MgSbLWfAifI4DFaTIg3jOQ8OVtknhW15URbnIfz+19I=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Xfm58R44mhuC4me/qgex0MH4rrK3lfxKTeqb0UeHrnT1HSbwI2wcEr5rFvjG2r/Jc
         tg/XPFZw5q+7z3O6gmwtVuflrSK1yDmtnRzZ6eTjA6j1krphZZMkQ8VIJG9MlDJHlq
         f87PqwpLPGgCMW57dmIbcDZyAoM47dkPXSuuuVz6dbBPb/DdiTvObtrB54cIIdTA8r
         SEaz+UPbOtITcFeJh+lgw1ot25/an7S6f5nFymxEhQfbDMFcKNSPOx7gydfas5bv2O
         eaNEIpnKNsam7AhnibAZ9eANbJePzCFUOEGvqhXOZjUZuw23kaQFjHM54zuXhtedxK
         oMzukw1st5zSA==
Message-ID: <2d83eab4-3ba9-6947-690e-2b0fd7de0653@collabora.com>
Date:   Wed, 20 Apr 2022 13:25:53 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        david@redhat.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V5 2/2] selftests: vm: Add test for Soft-Dirty PTE bit
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20220317103323.94799-1-usama.anjum@collabora.com>
 <20220317103323.94799-2-usama.anjum@collabora.com>
 <87ilsbyshs.fsf@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <87ilsbyshs.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/19/22 12:23 AM, Gabriel Krisman Bertazi wrote:
>> +static void test_vma_reuse(int pagemap_fd, int pagesize)
>> +{
>> +	char *map, *map2;
>> +
>> +	map = mmap(NULL, pagesize, (PROT_READ | PROT_WRITE), (MAP_PRIVATE | MAP_ANON), -1, 0);
>> +	if (map == MAP_FAILED)
>> +		ksft_exit_fail_msg("mmap failed");
>> +
>> +	clear_softdirty();
>> +
>> +	/* Write to the page before unmapping and map the same size region again to check
>> +	 * if same memory region is gotten next time and if dirty bit is preserved across
>> +	 * this type of allocations.
>> +	 */
> This reads weird.  It should *not* be preserved across different
> mappings.  Also, we are not testing if the same region is reused, we are
> depending on it to test the sd bit.
> 
> /* Ensures the soft-dirty bit is reset accross different mappings on the
> same address.  */
Soft dirty bit is always set for new regions (reused or not). I'll
correct the comment and improve this sub test.

-- 
Muhammad Usama Anjum

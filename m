Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F736C728F
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 22:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCWVtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCWVtN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 17:49:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE18198B;
        Thu, 23 Mar 2023 14:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129F7628CE;
        Thu, 23 Mar 2023 21:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBD2C4339B;
        Thu, 23 Mar 2023 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679608151;
        bh=kqWpXBUkjVmg+UudoHAqa4FqE+KlPoTSpTis0nKts0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o/WAp15jQ0TO7wkH8Q2NwQYDNppRaF2KOJ/MmbVgp3SEniJJgdAXTa/cLTc5zlxTF
         Vzkp4N+x/k9VendSbkxWVBhg1PK3a+jmH16n0Ax3HBeW0kDhTG5I4uk2cyhNXMqMoB
         4VmJCL0C2Yj5AKIROnddIG2WyeRZJz7wuOobuUzY=
Date:   Thu, 23 Mar 2023 14:49:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] selftests/mm: Implement support for arm64 on va
Message-Id: <20230323144910.b07df164acc1d85bc76dc933@linux-foundation.org>
In-Reply-To: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 23 Mar 2023 16:22:38 +0530 Chaitanya S Prakash <chaitanyas.prakash@arm.com> wrote:

> The va_128TBswitch selftest is designed and implemented for PowerPC and
> x86 architectures which support a 128TB switch, up to 256TB of virtual
> address space and hugepage sizes of 16MB and 2MB respectively. Arm64
> platforms on the other hand support a 256Tb switch, up to 4PB of virtual
> address space and a default hugepage size of 512MB when 64k pagesize is
> enabled.
> 
> These architectural differences require introducing support for arm64
> platforms, after which a more generic naming convention is suggested.
> The in code comments are amended to provide a more platform independent
> explanation of the working of the code and nr_hugepages are configured
> as required. Finally, the file running the testcase is modified in order
> to prevent skipping of hugetlb testcases of va_high_addr_switch.
> 
> This series has been tested on 6.3.0-rc3 kernel, both on arm64 and x86
> platforms.

Would it make sense to get this series into the ARM tree, so it sees
more testing on ARM?

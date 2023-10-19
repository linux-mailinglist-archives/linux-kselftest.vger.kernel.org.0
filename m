Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D81B7D0048
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjJSRMH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 13:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjJSRMH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 13:12:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A9CA;
        Thu, 19 Oct 2023 10:12:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07CFC433C7;
        Thu, 19 Oct 2023 17:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697735525;
        bh=iCAlzJOz5As2YBNfu33bAM6oWeWAG5tVTYiluUL9E/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IldT7onLI/yGS+hbpdK1tfaZCkJkGq1In9vATKNbQXBmzmudox1TAV7DxrLBPQxac
         Nmw6D383OryGicrO28YWMkTEP0gA+YtR3Sa3oC+EPE3UlseYpiMd2iCX+FdDuzU5sB
         Lvq4VUUQQlB6pSMITesivcWcnRWM0aD0Al+BtNhg=
Date:   Thu, 19 Oct 2023 10:12:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v3 0/5] workload-specific and memory pressure-driven
 zswap writeback
Message-Id: <20231019101204.179a9a1d2c7a05b604dad182@linux-foundation.org>
In-Reply-To: <20231017232152.2605440-1-nphamcs@gmail.com>
References: <20231017232152.2605440-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 17 Oct 2023 16:21:47 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> Subject: [PATCH v3 0/5] workload-specific and memory pressure-driven zswap writeback

We're at -rc6 and I'd prefer to drop this series from mm.git, have
another go during the next cycle.

However Hugh's v2 series "mempolicy: cleanups leading to NUMA mpol
without vma" has syntactic dependencies on this series and will need
rework, so I'd like to make that decision soon.

Do we feel that this series can be made into a mergeable state within
the next few days?

Thanks.

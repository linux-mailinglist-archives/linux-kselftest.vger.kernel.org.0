Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59574E3372
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 23:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiCUWy2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 18:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiCUWyT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 18:54:19 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A137380F70;
        Mon, 21 Mar 2022 15:33:00 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647901979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4OY/H+zb0RIXu5WxaVqPmTsIU0BzpBHr2Aoo03K23OQ=;
        b=lWfBFFlwAImoY6uLwKWFs0S0tB3p39fYyxokhIeIaZPj4jja16BD+f2jryUMXCpvSoQH58
        KeNgR9rDqZZ733hMRZ75cM3upum9/Xboyi1T1hrsp4FdNCyEUqd/OOG+FlIywmGiFjuF4e
        0dwiI5FqWUCpfqADo77fjlQiIREimSI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] mm: truncate: split huge page cache page to a
 non-zero order if possible.
Message-ID: <Yjj9FaoChB3u0Gbh@carbon.dhcp.thefacebook.com>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-5-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321142128.2471199-5-zi.yan@sent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 10:21:27AM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> To minimize the number of pages after a huge page truncation, we do not
> need to split it all the way down to order-0. The huge page has at most
> three parts, the part before offset, the part to be truncated, the part
> remaining at the end. Find the greatest common power of two multiplier of
> the non-zero values of them as the new order, so we can split the huge
> page to this order and keep the remaining pages as large and as few as
> possible.

Would you mind please to describe the algorithm in more details?

Thanks!

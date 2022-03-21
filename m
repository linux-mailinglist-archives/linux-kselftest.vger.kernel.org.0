Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893CF4E30FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Mar 2022 20:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352854AbiCUT4V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Mar 2022 15:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345508AbiCUT4U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Mar 2022 15:56:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C3217DCAA;
        Mon, 21 Mar 2022 12:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4efTTqCS4Gsyb7wXaU8yL8zAGuclTlr6Cip6vqeSx5U=; b=gGjMpvSX+0ScawY3AAK5s8QnbO
        XilmRzJ+bqBsjUujrCWbfeV/tiRX+pQZDKbIS1SYRtDXXz1K9KLWQrCrfPxGmLQfFztXcAsXJ2Ddo
        l4tFcS3eTzqbtxZbVV5mTyle4MnmSMieKmIpHog/hTDlWj7SWmzHTxHQWMzK7iDKSGEKFuCuCF/9W
        coeGAeogiJmc3cJpJwW11rZXRiUcEkhs/lgHGb9qR0vtxf8I6ssv8JvulnzZxoy9KoA+SjsZE3S7Q
        24osUQanD2wp6GrgKEPW9Zicp2W4mjDyhuUcBHe/T+iGNKsM6u29kq3/ct+LGca1//oM3Lch994Ro
        fcXZH5cw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWO6v-00AtdF-9P; Mon, 21 Mar 2022 19:54:37 +0000
Date:   Mon, 21 Mar 2022 19:54:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>, Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm: memcg: make memcg huge page split support
 any order split.
Message-ID: <YjjX/bZrUmQfFjHC@casper.infradead.org>
References: <20220321142128.2471199-1-zi.yan@sent.com>
 <20220321142128.2471199-2-zi.yan@sent.com>
 <YjjKh2NoWGcq28Oo@carbon.dhcp.thefacebook.com>
 <0001CABA-9436-4EFF-9C7F-F67300D09DA1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0001CABA-9436-4EFF-9C7F-F67300D09DA1@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 21, 2022 at 03:07:46PM -0400, Zi Yan wrote:
> Yes. Will change it to new_nr to be consistent.

uh, you're going to call ilog2?

I think this would look less inconsistent if 'nr' were an unsigned long
(how long until we need 16GB pages?  Think PPC already supports those)


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F872A51C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 23:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjFIVIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFIVIq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 17:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C01FDC;
        Fri,  9 Jun 2023 14:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5357B65B87;
        Fri,  9 Jun 2023 21:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312F0C433EF;
        Fri,  9 Jun 2023 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686344924;
        bh=khMjJZ6SbRtiHSzoAiJYcCLwvpHE55DPi59sRUk9SnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPwq+3SVS8hpxxiCv7rr8f9wFYJwjqxeQoWOBcRM374UN7xGFI1xqLQix1de/69rs
         mzSKQ2vsWaothpzV/NFEyqhlOanSvTSMOsuJjwPr3fNID8aTiJBypYwjufjDvFM/SO
         /VDFyzRbixe+F1NWRWKhzGNQUNVq0yLdyVmmHwJ0qoTO1YRqU2wm9DkbMj+3sgEBsI
         yWoBtYIC1jxiyzAzp8N+onYpJng/asUqh8dxb0fbpTm3J+IM0DuAyBCExuuU3IHD+V
         RB52HW+NYCIG4Ye+w1p8jQuYEdC/Y8pGUd9yUkj2zYf9hIAlH7PN4PeuQ/JXbSs7Ab
         3klNk7thwj8Xw==
Date:   Fri, 9 Jun 2023 14:08:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Magali Lemes do Sacramento <magali.lemes@canonical.com>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        shuah@kernel.org, vfedorenko@novek.ru,
        tianjia.zhang@linux.alibaba.com, andrei.gherzan@canonical.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] selftests: net: tls: check if FIPS mode is
 enabled
Message-ID: <20230609140843.4444e444@kernel.org>
In-Reply-To: <CAO9q4O1SctX1323-8JDO0=ovsLfNpv4EjOSdP_PwYDJ76tAQiQ@mail.gmail.com>
References: <20230609164324.497813-1-magali.lemes@canonical.com>
        <20230609164324.497813-2-magali.lemes@canonical.com>
        <20230609105307.492cd1f2@kernel.org>
        <CAO9q4O1SctX1323-8JDO0=ovsLfNpv4EjOSdP_PwYDJ76tAQiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 9 Jun 2023 17:15:38 -0300 Magali Lemes do Sacramento wrote:
> > Eh, let me help you, this should really be part of the SETUP() function
> > but SETUP() doesn't currently handle SKIP(). So you'll need to add this
> > to your series:  
> 
> May I add your Suggested-by tag to this upcoming patch in this patchset v3?

No strong preference but sure, why not :)

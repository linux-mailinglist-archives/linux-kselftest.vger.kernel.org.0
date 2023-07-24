Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714D175FC4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGXQiT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjGXQiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 12:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65274125;
        Mon, 24 Jul 2023 09:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0343C6126D;
        Mon, 24 Jul 2023 16:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE2BC433C8;
        Mon, 24 Jul 2023 16:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690216685;
        bh=OvYkPoZW+1SHJA0MsHLxvmm52xGTvCvbDEGY8hy65AM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2Wwk5JpmDGrFnpm+gtjLVk/HOmKFqx0Lhy2yJ9WRAeH4JhrPuJ2cMlOCFUUo2a0c6
         jIIwQ06fq9FaWJrutjtsikmd5nHQZyq9zcvExonjQvZGf8z6gpbc9Q3DMPifUnr8Ke
         anmR03lkDFx+gPnpmLjjG+dTzNiIttA+OOoH24fE=
Date:   Mon, 24 Jul 2023 09:38:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     "Shuah Khan" <shuah@kernel.org>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        "Peter Xu" <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/8] selftests/mm fixes for arm64
Message-Id: <20230724093804.bbe8bc2a83d4575f17778eb0@linux-foundation.org>
In-Reply-To: <20230724082522.1202616-1-ryan.roberts@arm.com>
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 24 Jul 2023 09:25:14 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> This is v3 of my series to clean up mm selftests so that they run correctly on
> arm64. See [1] for full explanation.

Please don't do that.  Please maintain the [0/n] description alongside the
patchset and resend it each time you resend the series.

I could go over and copy-paste [1] into this patchset, but I don't know if it
is fully up to date.   I'll leave the patchset intro blank for now - please
review/edit [1] and send the result in reply to this email, thanks. 

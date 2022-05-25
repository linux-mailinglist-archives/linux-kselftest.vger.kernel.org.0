Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310EE53354F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 04:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiEYC14 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 22:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiEYC1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 22:27:22 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3586694B0;
        Tue, 24 May 2022 19:27:20 -0700 (PDT)
Date:   Tue, 24 May 2022 19:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653445639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4066BGZ8t4evPhN+kvOPiP4ga7qn2RnpU+mzq2WHHA=;
        b=ExVRcGzrJWaKWhcD0ImJnXvrBDLjziAH68cY6nCdV5SjH+A2LeFR9fbfB8Eays4nF1EQfj
        lCPNnubliAFrIL/aBIrdvLa3jrFmO3f/Dt20FvV6NnMy84+E8syKARZcAIapqXIkbzwdQs
        /LChnQJ04QdOtK4KdVJWAh9tCQR8JJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v3 2/5] selftests: memcg: Expect no low events in
 unprotected sibling
Message-ID: <Yo2UArXnJ3YsVicX@carbon>
References: <20220524162955.8635-1-mkoutny@suse.com>
 <20220524162955.8635-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524162955.8635-3-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 24, 2022 at 06:29:52PM +0200, Michal Koutny wrote:
> This is effectively a revert of commit cdc69458a5f3 ("cgroup: account
> for memory_recursiveprot in test_memcg_low()"). The case test_memcg_low
> will fail with memory_recursiveprot until resolved in reclaim
> code.
> However, this patch preserves the existing helpers and variables for
> later uses.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> Reviewed-by: David Vernet <void@manifault.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

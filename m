Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63E152C317
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiERTKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbiERTKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 15:10:22 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB1587A37;
        Wed, 18 May 2022 12:10:17 -0700 (PDT)
Date:   Wed, 18 May 2022 12:10:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652901015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MU2xzwxn+O+SnkiosYFY4pTWce0HMP0+oO1iGAYdJtU=;
        b=NelAPc5Q/waJa9uHLmhBkiqS/W10UEhrTS/tzmxD8ZMX3pQJpBpLunViUIR4z2937q4EeN
        +NrUnLOlu40gjz+zP5EV1sGM3VYcd+lbOOuzpJEOGb4j+x1Rrwlyqkdvc5qYQRFP5Cygcj
        ffbi3QzkdhpwFQuAVmy4DkGdU22RrK8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH v2 3/5] selftests: memcg: Adjust expected reclaim values
 of protected cgroups
Message-ID: <YoVEkES9+22RrhBR@carbon>
References: <20220518161859.21565-1-mkoutny@suse.com>
 <20220518161859.21565-4-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518161859.21565-4-mkoutny@suse.com>
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

On Wed, May 18, 2022 at 06:18:57PM +0200, Michal Koutny wrote:
> The numbers are not easy to derive in a closed form (certainly mere
> protections ratios do not apply), therefore use a simulation to obtain
> expected numbers.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, Michal!

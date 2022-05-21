Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A919752FD25
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiEUOLg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354873AbiEUOLM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 10:11:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A476911C2D;
        Sat, 21 May 2022 07:11:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id CCDB91F459D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653142268;
        bh=RDsDMjrHSRLHyJKnvADs831SvV0UdrfBeeTlvj8a10A=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=gEIIZW9x52qLWyJAJicELkBZ/pVegfBArBv1xXiTVsC4HCzRLC1XXaWVd75WtBwtE
         28l2Qg/rQMHz7tSmEadoaq0lJGVgkJZZ3d0LutBOEuwX1FujikjEguKbjHuU2XVoX2
         1ZgZvvVaZMZI4sWLrm1iEi+g99YJb6qzve7plDCT+Ppga9Bdy/O1N+rfUTMWenvg2Z
         gG4lgrMoKwTAEP1o7InyvQi/muAeAxKrVgEHJWAuk+/2V7Q54i/r7m/bLji+OY7aNV
         Aq9+K4ABKOjBGWHileB2ERmD7Y/XqHVHmWcGWs5KwNyWFtfEcIHS4J/y1HB9ayyk79
         lDkqcP/S2R9yg==
Message-ID: <5242b7ab-d6b6-55d4-c211-ec27293be795@collabora.com>
Date:   Sat, 21 May 2022 19:11:01 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     usama.anjum@collabora.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH v2 1/5] selftests: memcg: Fix compilation
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20220518161859.21565-1-mkoutny@suse.com>
 <20220518161859.21565-2-mkoutny@suse.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220518161859.21565-2-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/18/22 9:18 PM, Michal Koutný wrote:
> This fixes mis-applied changes from commit 72b1e03aa725 ("cgroup:
> account for memory_localevents in test_memcg_oom_group_leaf_events()").
Shouldn't the Fixes tag be added here and in 2/5 patch?

-- 
Muhammad Usama Anjum

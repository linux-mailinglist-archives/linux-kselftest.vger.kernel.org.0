Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945514D5F3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 11:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbiCKKQ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 05:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiCKKQ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 05:16:27 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04591BF937;
        Fri, 11 Mar 2022 02:15:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 67D121F4651D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646993722;
        bh=CXbZB2r1b/1g4K17WHONm0b5nTskHWpS/0PWyWxfnbw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Npwdv59rYQ7Dmv7mWYlsndREOIgJHVXQgzGaYT/brUiy0Oz/liLZsMkYVfWTOGrVX
         FoRlINRSCIlQzKNj9oesYuZBEgedx0m80gUWgUhp9BFlWbz2oP9QdDZKS82th77vLB
         tOgoDQolfIP5BSsDPIpuRBwv7MprHXmwVhrY0b9JjAhTVb0jYed01u7QWNALwSHT2I
         zCEBWtXOvIsREoGGBmkMmsh2gxQ6MVPMvg+AhIECH6ooiW1SpsF9rA4YYRGujYrQoj
         3JOLGInucafLslSQFV41qDhzSXLs6/XKngiplp9mhvFb7DxNt+02T1kBIX5n9k4u7d
         iiYkYodl4BeVw==
Message-ID: <89e684cb-8cac-541b-10f0-39a6ba1089d3@collabora.com>
Date:   Fri, 11 Mar 2022 10:15:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] selftests, x86: fix how check_cc.sh is being invoked
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
 <20220225170305.de0aa0dc898ca583d8a83e5c@linux-foundation.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <20220225170305.de0aa0dc898ca583d8a83e5c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/02/2022 01:03, Andrew Morton wrote:
> On Fri, 25 Feb 2022 13:15:43 +0000 Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> 
>> Add quotes around $(CC) when calling check_cc.sh from a Makefile to
>> pass the value as a single argument to the script even if it has
>> several words such as "ccache gcc".  Conversely, remove quotes in
>> check_cc.sh when calling $CC to make it a command with potentially
>> several arguments again.
> 
> This changelog describes the fix, but it fails to describe the problem
> which the patch is fixing!
> 
> Presumably, we're hitting some form of runtime failure under
> undescribed circumstances when running selftests.  But that's just me
> reverse-engineering the patch description.  And me reverse-engineering
> stuff is a gloriously unreliable thing.  Please spell out the problem.

Thanks for the review.  I've just sent a v2 which is rebased on
other changes in linux-next and with a reworked commit message
which should hopefully be clearer.  The issue was seen when
building some kselftest binaries and $CC is defined with multiple
arguments such as "ccache gcc".

Guillaume

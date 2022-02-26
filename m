Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B380E4C52E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 02:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiBZBDl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 20:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiBZBDk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 20:03:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CB51BE138;
        Fri, 25 Feb 2022 17:03:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B08C61AA0;
        Sat, 26 Feb 2022 01:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A965C340E7;
        Sat, 26 Feb 2022 01:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1645837386;
        bh=43pC9PdIzse0ZGz/ZNK8Q2fCOABbfYyUP49hGYhr+JA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m8uVK/IXP+hcQZtmdTES0fUSK/NmDeUqxCfezFUmK1NZO/9GClJWz8A5Sq2KgwOnZ
         bNwqN+Tq9mT436P9e5HntTMXhPo488hm0F7i2/TdRR1lzwjBb55qxhLiwF0rCGouku
         oiilh/6zQKhlEE2qCeCLWAbFaNbxUYlYWRID6W0g=
Date:   Fri, 25 Feb 2022 17:03:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests, x86: fix how check_cc.sh is being invoked
Message-Id: <20220225170305.de0aa0dc898ca583d8a83e5c@linux-foundation.org>
In-Reply-To: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
References: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 25 Feb 2022 13:15:43 +0000 Guillaume Tucker <guillaume.tucker@collabora.com> wrote:

> Add quotes around $(CC) when calling check_cc.sh from a Makefile to
> pass the value as a single argument to the script even if it has
> several words such as "ccache gcc".  Conversely, remove quotes in
> check_cc.sh when calling $CC to make it a command with potentially
> several arguments again.

This changelog describes the fix, but it fails to describe the problem
which the patch is fixing!

Presumably, we're hitting some form of runtime failure under
undescribed circumstances when running selftests.  But that's just me
reverse-engineering the patch description.  And me reverse-engineering
stuff is a gloriously unreliable thing.  Please spell out the problem.

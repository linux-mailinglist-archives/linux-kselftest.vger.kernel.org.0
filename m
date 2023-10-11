Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A7C7C5DBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 21:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjJKTlT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 15:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJKTlS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 15:41:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCE94;
        Wed, 11 Oct 2023 12:41:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80806C433C7;
        Wed, 11 Oct 2023 19:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697053275;
        bh=wyUZr0T2KKwwXCDYer3RRt6Sel9/hsansQuF2CNrmtU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I9ADnPXsjFXvnmubhrjROigjHerM0TGu995M83tV13RmcZYKfisoONeqOnjXipMNM
         wZsPfYrMC4OC3hq0HKKKG0r/nvT2gp5LXVOr9fLAcylOnOcNvVKzPoaQiOvU7LWvxd
         Las82HeLIh7OIh5e2bSB0zQ8yFNqJuUkMTp1svH+AbFlMZvPC8AnqL/xBHYWfkJuvW
         Nv4OdhY5aBOPZP/1k8LZmqZBTW6mCv7BnKwNvTPmtQH2oc6ieAHgPgTKLZ0XLzWHVC
         BSi6fjq6Syn2H2ohjmQ3ia3FGlwN5ftnr5FSiNK0bUzYyer3UvjiI7l194BfwT69Sw
         Vj+e8JUiCla1A==
Message-ID: <a2a5cb05-8604-4303-9802-573359c68368@kernel.org>
Date:   Wed, 11 Oct 2023 13:40:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] selftests: Add printf attribute to kselftest
 prints
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     ilpo.jarvinen@linux.intel.com,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
 <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com>
From:   Shuah <shuah@kernel.org>
In-Reply-To: <13a47130763d109aa40de153ecbee9ede22d8356.1697012398.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/23 02:23, Maciej Wieczor-Retman wrote:
> Kselftest header defines multiple variadic functions that use printf
> along with other logic.
> 
> There is no format checking for the variadic functions that use
> printing inside kselftest.h. Because of this the compiler won't
> be able to catch instances of mismatched printf formats and debugging
> tests might be more difficult.
> 
> Add the common __printf attribute macro to kselftest.h.
> 
> Add __printf attribute to every function using formatted printing with
> variadic arguments.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changelog v4:
> - Fix typo in patch subject. (Reinette)
> - Add Reinette's reviewed-by tag.
> 

I still need information on how you found these problems. Please
add it to change log for each of these patches.

I am seeing checkpatch warning:

WARNING: Prefer __printf(a, b) over __attribute__((format(printf, a, b)))
#102: FILE: tools/testing/selftests/kselftest.h:81:
+#define __printf(a, b)   __attribute__((format(printf, a, b)))

thanks,
-- Shuah

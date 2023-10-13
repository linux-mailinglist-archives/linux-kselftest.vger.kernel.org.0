Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4D7C8EA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 23:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjJMVD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 17:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjJMVDZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 17:03:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8FBE;
        Fri, 13 Oct 2023 14:03:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C614C433C9;
        Fri, 13 Oct 2023 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697231002;
        bh=Plf/zX3o6rIrvL3UB/Tp2mhFXD/6OyB/+JAGi9E0v/c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OleojuGZ5LGLye6eZ0op0LEpWHQS69DAz/iOIFDBqKztG2EX1a2XXahca+MTQS+GU
         1N7Sh85xf5dHzuX5QjRJ1OEks4uvkYPHf9EkU8iv6+FqqNWkLEHEw7my2gGZ4+Vj+i
         msTPnov7b9jpTJD0I9ADQisauHtxpUEvqakMaTMxP6LfR1umthhH4UXNAQXaz7MSBl
         kviUv4vvTPCN428G7CTFqZ7E6wk3NBiy9ultxWF82ZmfSld43Tey5sl/L8+vML32t4
         Bp/YlplKFAxVav5HNp4RJqDPd7BvrfbejFitwzpcUQokqOjub9oNgX/ZtTGFSLQw6N
         8au63rlRqKSAw==
Message-ID: <0efe3ba3-b62f-4447-a195-2447e1152a22@kernel.org>
Date:   Fri, 13 Oct 2023 15:03:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Add printf attribute to kselftest functions
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        akpm@linux-foundation.org, christian@kellner.me,
        fenghua.yu@intel.com, keescook@chromium.org,
        ndesaulniers@google.com, coltonlewis@google.com,
        dmatlack@google.com, vipinsh@google.com, seanjc@google.com,
        brauner@kernel.org, pbonzini@redhat.com, hannes@cmpxchg.org,
        nphamcs@gmail.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
From:   Shuah <shuah@kernel.org>
In-Reply-To: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/13/23 05:36, Maciej Wieczor-Retman wrote:
> kselftest.h declares many variadic functions that can print some
> formatted message while also executing selftest logic. These
> declarations don't have any compiler mechanism to verify if passed
> arguments are valid in comparison with format specifiers used in
> printf() calls.
> 
> Attribute addition can make debugging easier, the code more consistent
> and prevent mismatched or missing variables.
> 
> The first patch adds __printf() macro and applies it to all functions
> in kselftest.h that use printf format specifiers. After compiling all
> selftests using:
> 	make -C tools/testing/selftests
> many instances of format specifier mismatching are exposed in the form
> of -Wformat warnings.
> 
> Fix the mismatched format specifiers caught by __printf() attribute in
> multiple tests.
> 
> Series is based on kselftests next branch.
> 
> Changelog v6:
> - Add methodology notes to all patches.
> - No functional changes in the patches.
> 

Applied this series and the following three - all 25 patches are
in linux-kselftest next for Linux 6.7-rc1.

[1] https://lore.kernel.org/all/cover.1696932728.git.maciej.wieczor-retman@intel.com/
[2] https://lore.kernel.org/all/20231002094813.6633-1-ilpo.jarvinen@linux.intel.com/
[3] https://lore.kernel.org/all/20230904095339.11321-1-ilpo.jarvinen@linux.intel.com/

thanks,
-- Shuah


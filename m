Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4D1190199
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 00:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCWXL1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 19:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgCWXL1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 19:11:27 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307EB20409;
        Mon, 23 Mar 2020 23:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585005086;
        bh=Ou977Sqn9Fa+b2IjVCFdOdSQbvwqI6VOCwZuG8bCp2I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ICeANoF0S5FEGhCpYA4soaB8ax67eDqLpfttwTTHW3Y3yujYPIejqHKcnToCjMPKw
         GiasSoKirngcEqpjIqLbZHErqtaAH1x4UJB7Bqf9du4yKUM2aDhbSF3Cc92NxcS0xz
         yzsfWL2mo/ZgMl1GLgVPX2lmLrP9MzUkg9CEGm9c=
Subject: Re: [PATCH rebase v2] kunit: add --make_options
To:     Brendan Higgins <brendanhiggins@google.com>, gthelen@google.com,
        natechancellor@gmail.com
Cc:     linux-kselftest@vger.kernel.org, davidgow@google.com,
        kunit-dev@googlegroups.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200323190459.64737-1-brendanhiggins@google.com>
From:   shuah <shuah@kernel.org>
Message-ID: <db463fea-3cd0-5e10-02b2-950782437dc8@kernel.org>
Date:   Mon, 23 Mar 2020 17:11:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323190459.64737-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/23/20 1:04 PM, Brendan Higgins wrote:
> From: Greg Thelen <gthelen@google.com>
> 
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
> 
> This allows use of the clang compiler for kunit:
>    tools/testing/kunit/kunit.py run --defconfig \
>      --make_options CC=clang --make_options HOSTCC=clang
> 
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: David Gow <davidgow@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Thanks Brendan!

Applied for 5.7-rc1

thanks,
-- Shuah

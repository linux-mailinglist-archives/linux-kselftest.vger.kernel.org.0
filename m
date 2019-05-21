Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C849251A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 16:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfEUOMz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 10:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfEUOMz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 10:12:55 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB042173C;
        Tue, 21 May 2019 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558447974;
        bh=uwra/JKga2ionRs42M1c8l3BWk/ikA/Yd/7mumUTucs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=InrOCWr3zavWXHydsL/SXX38I3acl9WDeDEb+x1PIlZT2hiJU76sg8XX+kPTUAUuw
         jjBV/WQN3bLwKHd6t/XHeEF1b4gMKR08dwW0bl9jMN+y+XnJ/c+HB8zun3+2+/uyHd
         c8WcSWh2oNB61F+VPBsSlT/1D9bufXPHM4zrE1h4=
Subject: Re: [PATCH 1/2] selftests: Remove forced unbuffering for test running
To:     Takashi Iwai <tiwai@suse.de>, Kees Cook <keescook@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <20190520223749.13476-1-keescook@chromium.org>
 <20190520223749.13476-2-keescook@chromium.org> <s5hlfz0757d.wl-tiwai@suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <e6a41345-7c98-751a-80bd-34d96e6de001@kernel.org>
Date:   Tue, 21 May 2019 08:12:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <s5hlfz0757d.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/20/19 11:21 PM, Takashi Iwai wrote:
> On Tue, 21 May 2019 00:37:48 +0200,
> Kees Cook wrote:
>>
>> As it turns out, the "stdbuf" command will actually force all
>> subprocesses into unbuffered output, and some implementations of "echo"
>> turn into single-character writes, which utterly wrecks writes to /sys
>> and /proc files.
>>
>> Instead, drop the "stdbuf" usage, and for any tests that want explicit
>> flushing between newlines, they'll have to add "fflush(stdout);" as
>> needed.
>>
>> Reported-by: Takashi Iwai <tiwai@suse.de>
>> Fixes: 5c069b6dedef ("selftests: Move test output to diagnostic lines")
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Tested-by: Takashi Iwai <tiwai@suse.de>
> 
> BTW, this might be specific to shell invocation.  As in the original
> discussion thread, it starts working when I replace "echo" with
> "/usr/bin/echo".
> 
> Still it's not easy to control in a script itself, so dropping the
> unbuffered mode is certainly safer, yes.
> 
> Thanks!

Thank you both.

I will get this in for next rc.

-- Shuah

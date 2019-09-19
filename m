Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87142B7FB5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfISRJL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 13:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391867AbfISRJL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 13:09:11 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA3420644;
        Thu, 19 Sep 2019 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568912951;
        bh=i47DafbV/d3Qe9fcajwsSj8c4rgxc5Rv2f5aucr6OF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=y0kS2eejiOAQDHwJwUiAzyZ1tREHU/RW3tJa98y85YB2Pbfv+WI/5fzPwpw0qWpuj
         J6rg83zIPQuWKfdKirhR8OrwenAvCKVej5y1s703Ja+hPeDrSDRE+JO4oABTLlEvYh
         GEpI+jlTrNJmtcpJrqyHpEeLLMs6j92wwmxqmFfs=
Subject: Re: [PATCH] selftests: update .gitignore files for selftests/bpf and
 selftests/zram
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, shuah <shuah@kernel.org>
References: <20190919082902.GA15755@yogzotot>
 <CAADnVQK6FjwivxDsmoskH_Zwr+Q730+H9u_5hBBdyzzDP1vyRg@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <56fb689c-428b-ad1a-6f25-48422420e4c5@kernel.org>
Date:   Thu, 19 Sep 2019 11:09:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQK6FjwivxDsmoskH_Zwr+Q730+H9u_5hBBdyzzDP1vyRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/19 8:39 AM, Alexei Starovoitov wrote:
> On Thu, Sep 19, 2019 at 1:35 AM Anatoly Pugachev <matorola@gmail.com> wrote:
>>
>> selftests: update .gitignore files for selftests/bpf and selftests/zram
>>
>> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/.gitignore  | 4 ++++
>>   tools/testing/selftests/zram/.gitignore | 1 +
>>   2 files changed, 5 insertions(+)
>>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> could you please split this patch into selftests/bpf/ and the rest?
> we'll take bpf bits via bpf tree.
> 

Yes. Please split them. .gitignore changes for each test need to be
in separate patches.

thanks,
-- Shuah


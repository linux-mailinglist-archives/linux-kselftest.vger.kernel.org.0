Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52661A8CDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633398AbgDNUwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 16:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633395AbgDNUwN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 16:52:13 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAC52074D;
        Tue, 14 Apr 2020 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586897533;
        bh=UNAynrifsyrl63+WA+Z6q40CoIdb4PxkQRzhNgu9FRk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dm5y+ThhW+vRmynXiHvgCKGwq2G2cQ1F8s1xmhdUMO+psCFELoh54cRe4ZgdeZXBF
         yR0JVYeIEDk5FZOQaN0kEmypiQH9DOkDH21WLrUw53Qzdc4Tw8Ya31r4SIKFlhC88M
         BpFCZPAyaC07c2kpRZEM4NfjOGF3SAD3n/UF4JdE=
Subject: Re: [PATCH] Revert "Kernel selftests: tpm2: check for tpm support"
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
 <3921a93f-120c-0201-4af5-591bf4e6a0b0@kernel.org>
 <20200414193722.GD13000@linux.intel.com>
 <20200414193800.GE13000@linux.intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <ac896427-581d-6fd0-e088-3bc519b6ed66@kernel.org>
Date:   Tue, 14 Apr 2020 14:52:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414193800.GE13000@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/20 1:38 PM, Jarkko Sakkinen wrote:
> On Tue, Apr 14, 2020 at 10:37:25PM +0300, Jarkko Sakkinen wrote:
>> On Tue, Apr 14, 2020 at 09:12:05AM -0600, shuah wrote:
>>> On 4/12/20 8:23 AM, Jarkko Sakkinen wrote:
>>>> This reverts commit b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc.
>>>>
>>>> The original comment
>>>
>>> commit I assume.
>>>
>>>   was neither reviewed nor tested. Thus, this the
>>>> *only* possible action to take.
>>>>
>>>
>>> Bummer. I will apply this right away.
>>
>> No worries, and fine with the change as long as I'm able to
>> review and try it out :-) Sorry for the dull tone!
> 

I usually wait for test authors to do the review. This patch
was sent a while back and I ended up picking it up. It stayed
in next for a while. It is fixed now.

> I mean refined change after this revert has been applied.
> 
Of course. I applied your revert to for my next pull request
to linux-kselftest next

thanks,
-- Shuah

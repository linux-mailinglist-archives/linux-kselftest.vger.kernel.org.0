Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA9C5F3A1C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 22:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfKGVKa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 16:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfKGVK3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 16:10:29 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE8D20869;
        Thu,  7 Nov 2019 21:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573161029;
        bh=Smshkf4bpuB9OzX8GhkdOLFzAGkF60wT47h/fzpfwKY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mYOfvann0nGvFTLrOfANUBmsNGQAXdDD8djVAXBskTgPzqNcw8L4fzqNLigqDOzeM
         qrIJzIisz+zZwkHkLnsbXsMaXU9JpzT2u9eSyqIQ+mYABD+Zj6tbTYFoA8yrd/1JEP
         NBLEJJcdmHcxy3PBopVt2tQYLdQgiyeJX9Cxk7W0=
Subject: Re: [PATCH] kselftests/dmabuf-heaps: Fix compiler error in one
 condition
To:     John Stultz <john.stultz@linaro.org>
Cc:     Xiao Yang <ice_yangxiao@163.com>, linux-kselftest@vger.kernel.org,
        philip.li@intel.com, shuah <shuah@kernel.org>
References: <20191101020450.12948-1-ice_yangxiao@163.com>
 <e343dbf7-323f-c513-50ca-feda4f0ab6ec@163.com>
 <1386a7d3-1114-d0e5-65b0-d81c032ac657@kernel.org>
 <CALAqxLU=fwt77mC0CJRgtVAzLhAUHou01J_cDSoc2kx5=ArrGw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <456379e0-9c7f-212c-c275-afac67cd5943@kernel.org>
Date:   Thu, 7 Nov 2019 14:10:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLU=fwt77mC0CJRgtVAzLhAUHou01J_cDSoc2kx5=ArrGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/7/19 1:39 PM, John Stultz wrote:
> On Thu, Nov 7, 2019 at 12:37 PM shuah <shuah@kernel.org> wrote:
>>
>> On 10/31/19 8:25 PM, Xiao Yang wrote:
>>> Hi,
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>> Do you plan to send another patch? I don't understand
>> if this meant you think this patch doesn't fix the
>> problem?
> 
> I've actually folded in the fix into my patches.
> 
> thanks
> -john
> 

Thanks for the clarification.

-- Shuah


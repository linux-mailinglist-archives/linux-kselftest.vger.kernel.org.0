Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55055A711
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jun 2022 06:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFYEcj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 25 Jun 2022 00:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFYEci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 25 Jun 2022 00:32:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07F4DF69;
        Fri, 24 Jun 2022 21:32:37 -0700 (PDT)
Received: from [192.168.10.5] (unknown [39.45.253.181])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCCAD6601811;
        Sat, 25 Jun 2022 05:32:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656131555;
        bh=0bJ0WTsjXAzIthDQKAnCzdLh+ZGj1p0umyUumYFMZEE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=lLREcU27lpNxQCD0L3lvQm5jvlyMV1piiJWi5JHI3iL46Sym5LzL6NDnapC3KqVFl
         1vAGNq7OdNf6IQ6G2qfpzCPJkv29NZo54kJR245DR6HSJR35Ri38l5lbo9jpIi3Iyk
         mWqt5OCVWur62RsTtAY+d+cZRhClFKOU6qBI+MbUOak9VYYmUEg662woyHPwRJovag
         ag0Rjwb065JlPSiyR6EfqdWc3LhmzvREYSUn0e4vus3IWIS0reknCHp6bjWDzQjND5
         syQ9Hu5DDUScB9NzU1aM5EULlzciXhIHMA6nTtIxxucQ6Jo4Ze2FTLeCtRbiKLumGn
         V8S59VPM9AKTQ==
Message-ID: <272c88a5-95ec-de7f-7069-09921d2518d3@collabora.com>
Date:   Sat, 25 Jun 2022 09:32:29 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        bagasdotme@gmail.com, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] docs/kselftest: add more guidelines for adding new
 tests
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
References: <20220521073651.4191910-1-usama.anjum@collabora.com>
 <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
 <63fc263d-c06a-2974-298c-5da80322411a@linuxfoundation.org>
 <0e8ea624-3cf0-7c63-9b24-8c4109096d3d@collabora.com>
 <87letl3kqx.fsf@meer.lwn.net>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <87letl3kqx.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/25/22 12:49 AM, Jonathan Corbet wrote:
> Muhammad Usama Anjum <usama.anjum@collabora.com> writes:
> 
>> On 6/8/22 2:41 AM, Shuah Khan wrote:
>>>
>>> The change looks good to me. I am catching up on patch backlog after the
>>> merge window and vacation. I can take this through kselftest or if it
>>> goes through doc tree - here is my
>>>
>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>> This patch hasn't been accepted yet.
> 
> I've applied it now, thanks.
Thanks,

> 
> jon

-- 
Muhammad Usama Anjum

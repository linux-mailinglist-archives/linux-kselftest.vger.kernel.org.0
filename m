Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B695960C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiHPREJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 13:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiHPREH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 13:04:07 -0400
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 10:04:06 PDT
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB1B63F2F
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 10:04:05 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M6cln54vQzMpt3w;
        Tue, 16 Aug 2022 18:57:57 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M6clm72F5zlrKcf;
        Tue, 16 Aug 2022 18:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660669077;
        bh=ItNs1VClTElb9GbmQtUWYRm4sVyD9RDhwp130K74DTQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ANmOyZVK9yyjJfUGOtw52JuJYVxVPT3kXa+6/TkXC8s1U9frbRTKh+4P0HH1jOUGL
         Ipunpjnk0/GtGlmdFLUjQac2DkvOqJxmhRN5T/sKpQh7kTVwv26MLc/VO52TdE1lXk
         aMJvVVC0DV6OhwQv/5iVX/SfVuU0at21RcYGQ+uo=
Message-ID: <e897f023-66a9-416c-2846-cd3be42a30bd@digikod.net>
Date:   Tue, 16 Aug 2022 18:57:56 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
 <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
 <76a2ac43-6e3d-0b62-7c8c-eec5f247f8f8@collabora.com>
 <3de9a64e-6f27-8f76-9626-6ee082d382ea@digikod.net>
 <c0c65ade-1d2a-5466-2c12-8e016904817f@digikod.net>
 <32f7befd-19be-19aa-6db6-7b1fd670166e@linuxfoundation.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
In-Reply-To: <32f7befd-19be-19aa-6db6-7b1fd670166e@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 15/08/2022 19:17, Shuah Khan wrote:
> On 8/12/22 9:29 AM, Mickaël Salaün wrote:
>> Shuah, do you plan to send a pull request before merge window closes?
>>
> 
> I was hoping to do so and missed the window. Looks like more discussion
> happening on this change. I will get this in for the next rc

Yes please, this is a regression fix. I cannot reproduce the issue 
reported by Anders Roxell.

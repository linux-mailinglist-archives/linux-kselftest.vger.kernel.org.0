Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0256AC070
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 14:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjCFNLO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 08:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCFNLN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 08:11:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E342D167;
        Mon,  6 Mar 2023 05:10:59 -0800 (PST)
Received: from [IPV6:2001:861:4a40:8620:49a7:8b15:c488:a958] (unknown [IPv6:2001:861:4a40:8620:49a7:8b15:c488:a958])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C65A16602EB0;
        Mon,  6 Mar 2023 13:10:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678108258;
        bh=0tMcyeiNW99YWWVLTGwnfutRuQu8PUN4S9RDqb8qBL0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NIalrTy4J5NhxwbF3U4UfRW8nwtIcJ0VM6B/jZ/jQb6bHIi/XThooH5tX8AWhgJSy
         xXMSFozLhDQH2ol1lZ4lXjCjRga/wxDn37SmDB9p0yZpJyAR9MYGnxDoB0w4+oBQmR
         ytj3MIdSQWhKzqM6ypv+vP5F1hReBrmg5R5A2+m2kalPzJC9Ob8ysrW0FYlXwgMBWF
         KQUfC4WSM1AX/CY//tlKwZs1ePtyTZsC03TTDVJm+ImpQJ0rg3jAxLCoVMpSRSBENw
         vbxKpjLFa9I9H3guIKIBwOFr53/ER9XxR76ghHqlFyKzNi3/uFMd/ns+63RsLjMmhA
         jXKpuEcLrcjhw==
Message-ID: <9bd18c62-d922-992a-a776-a3064d4c2d73@collabora.com>
Date:   Mon, 6 Mar 2023 14:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests: amd-pstate: fix TEST_FILES
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Doug Smythies <dsmythies@telus.net>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
References: <20230204133454.260066-1-guillaume.tucker@collabora.com>
 <ZAGOQznWjSNuhn73@amd.com>
 <3d051308-382f-0f90-41b3-e1ffdd6f11f7@linuxfoundation.org>
Content-Language: en-US
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <3d051308-382f-0f90-41b3-e1ffdd6f11f7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 03/03/2023 21:29, Shuah Khan wrote:
> On 3/2/23 23:05, Huang Rui wrote:
>> On Sat, Feb 04, 2023 at 09:34:54PM +0800, Guillaume Tucker wrote:
>>> Bring back the Python scripts that were initially added with
>>> TEST_GEN_FILES but now with TEST_FILES to avoid having them deleted
>>> when doing a clean.  Also fix the way the architecture is being
>>> determined as they should also be installed when ARCH=x86_64 is
>>> provided explicitly.  Then also append extra files to TEST_FILES and
>>> TEST_PROGS with += so they don't get discarded.
>>>
>>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
>>> Fixes: ac527cee87c9 ("selftests: amd-pstate: Don't delete source files via Makefile")
>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>
>> Acked-by: Huang Rui <ray.huang@amd.com>
>>
> 
> Thank you both. I will pick this up for 6.3-rc2

Great, many thanks.

Guillaume


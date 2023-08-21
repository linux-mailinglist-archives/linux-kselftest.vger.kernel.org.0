Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DE782BCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjHUOaH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjHUOaH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 10:30:07 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ACEE7;
        Mon, 21 Aug 2023 07:30:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 45E3D60171;
        Mon, 21 Aug 2023 16:30:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692628201; bh=oSPplMj6JiN29yImBwTkca9NYstY8Lb3leUY+tHT4N4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jvyEoALt0CbC2Hr9pvIl1PSKcF8NPpWag4gAiTtnAcDmTHIOA2+zmh3fq12qF2Pp1
         6smCfOLG3hDOlElZ/DBaEtlF337uz8EZ6CHkBwTHuLq62SgMvBu6ny1RqfXoykNIyw
         NOdaOxSloCo8nURT0y0LWPN6MuDvi7pGfiELLP+KGqKDvS9OLNeqwbut4lA+FmvbIC
         zthGcw0DqJlpSam4Yka1sRrn9oJjPpHlj/uM43msqd4sYZseQRcsJV7+AjJh7+uVhn
         G3/Ek9eYgBtOeUIFND+6p+QyiKXQBChTYHBSiv7RBaBVEjooYvhcQn3IhlK+r07b6R
         GGKrGjx5ymH2g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YY40GYvPZslv; Mon, 21 Aug 2023 16:29:58 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id CAB816016E;
        Mon, 21 Aug 2023 16:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692628198; bh=oSPplMj6JiN29yImBwTkca9NYstY8Lb3leUY+tHT4N4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ANgQE+yMTMK765FH2ehCEQna308yFALx18kR98/tXPdH/Uw4VSr5NHQKVii4mJhb+
         3StqXJx6psFSkD8h5aMkwXE7ZJhHMiICXZxlnyNYzzBnCa4RjXLjLRK2CT1nrrlpFO
         ZdnTIq0AR8ypcBaLB6Ts8kkTBCrxpzyMcImv8YGK/Sdx7EgVlCYszp+Kv5okbJUUox
         dK4a4nCUlt88B0agPwb4aqdot4ufYUMfk19mw5oQbmjw8bHXOXjp9TDGc/MpnkMx0O
         kCUe6czYCJNT+S6GbO+v8l2e0PXH9USyZFG7d3Fz1BBkkl0aA8a+0EdjJwkNzHvv6B
         FpKVmQLraLfbA==
Message-ID: <061db38c-631b-82d3-789e-6203cdbb81a5@alu.unizg.hr>
Date:   Mon, 21 Aug 2023 16:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4.19 1/1] test_firmware: prevent race conditions by a
 correct implementation of locking
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
References: <20230816212717.817202-1-mirsad.todorovac@alu.unizg.hr>
 <2023082127-granite-emporium-b3e7@gregkh>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023082127-granite-emporium-b3e7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/21/23 15:22, Greg Kroah-Hartman wrote:
> On Wed, Aug 16, 2023 at 11:27:18PM +0200, Mirsad Goran Todorovac wrote:
>> [ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]
>>
>> Dan Carpenter spotted a race condition in a couple of situations like
>> these in the test_firmware driver:
> 
> Both backports now queued up, thanks.

Hi, Mr. Greg,

Thank you for the update. I think we have now completed the backport of this patch series.

Kind regards,
Mirsad Todorovac

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2C772DDC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjHGS2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 14:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHGS2j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 14:28:39 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9D10DB;
        Mon,  7 Aug 2023 11:28:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 053A660171;
        Mon,  7 Aug 2023 20:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691432908; bh=+h9eEP/ZmYdTuhaB6Ft3TqSCoC6idCxuVPLw06kDWT8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KEsOfbFH0QeQgljUnJmvUKUkXtsJ/5k+6r2/aRm2doyEtWYZYjc0E5UdZPPmAC3JF
         9sD38srBpM2J7550at1wtGZ5KoVOiF/gf3VbD4bVvzWiPl2HI0LjTXj5L8e2l0JiYN
         g60AZrxCEy78yiR48GjrRe2dzterDJbLYwlCFi9+vjBW+og6y6sl6RunajM0AliJE8
         C010G8jXu4hz27av/t8yOYyXHR0VGNp+j5pTrSr0DSNb9/TAwLlTrl6KEOSz62RdUu
         +Ld+HrHOgaiM1UBh7ZTo4SUrgHEw/wAEB3Hf30NmOSPCug8NmvvBRZr2pe5ZkWjhxy
         r8zUVdBai7r5A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wZltFuMJG8Ts; Mon,  7 Aug 2023 20:28:25 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 76A656016E;
        Mon,  7 Aug 2023 20:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691432905; bh=+h9eEP/ZmYdTuhaB6Ft3TqSCoC6idCxuVPLw06kDWT8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zkJ/T+MtZKGdboju85D5JB24Ea4374paBE6rYI/Mx4MMYxh92e9BQb8NF6y2WWWlt
         9f/IuMvcxpdkeA7lNHjnj/Gfqqxk/JNs0a9iyUgKk5Jq0J5FY/a37H94OJ6BW6laC5
         auHd0T5vpMT7xC9iu5RWqjaOhYwLSe+VAfwbqaQCegVRSy8SlTQ+Vr454mYor3+yYv
         NXsDx4QyqyeYcA06e0LpTOoxmB1mO8AQ0rl8p1KUj/V/wWU9qeeq/PcTdez6i+rZuQ
         b6Soze7dKfP6IfeN5Cfn9erLgF/t2oR58hEDlxaOr3QQCfA+VQpb9MyEAicwN7mXQ3
         n2xBepXBLJMBg==
Message-ID: <a9e443c7-c7b5-63ce-08d9-5604ac545bf6@alu.unizg.hr>
Date:   Mon, 7 Aug 2023 20:28:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4.14 1/1] test_firmware: fix the memory leaks with the
 reqs buffer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
References: <20230804170017.92671-1-mirsad.todorovac@alu.unizg.hr>
 <2023080705-poet-nickname-5e08@gregkh>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2023080705-poet-nickname-5e08@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/7/23 11:15, Greg Kroah-Hartman wrote:
> On Fri, Aug 04, 2023 at 07:00:18PM +0200, Mirsad Todorovac wrote:
>> [ commit be37bed754ed90b2655382f93f9724b3c1aae847 upstream ]
>>
>> Dan Carpenter spotted that test_fw_config->reqs will be leaked if
>> trigger_batched_requests_store() is called two or more times.
>> The same appears with trigger_batched_requests_async_store().
>>
>> This bug wasn't triggered by the tests, but observed by Dan's visual
>> inspection of the code.
>>
>> The recommended workaround was to return -EBUSY if test_fw_config->reqs
>> is already allocated.
>>
>> Fixes: c92316bf8e94 ("test_firmware: add batched firmware tests")
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Russ Weight <russell.h.weight@intel.com>
>> Cc: Tianfei Zhang <tianfei.zhang@intel.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Colin Ian King <colin.i.king@gmail.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: stable@vger.kernel.org # v4.14
>> Suggested-by: Dan Carpenter <error27@gmail.com>
>> Suggested-by: Takashi Iwai <tiwai@suse.de>
>> Link: https://lore.kernel.org/r/20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr
>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>>
>> [ This fix is applied against the 4.14 stable branch. There are no changes to the ]
>> [ fix in code when compared to the upstread, only the reformatting for backport.  ]
> 
> Thanks for all of these, now queued up.

No problem, I should have done it right the first time to reduce your load.

I really believe that backporting bug fix patches is important because many systems
cannot upgrade because of the legacy apps and hardware, to state the obvious.

I know because we are in that group. :-)

Kind regards,
Mirsad Todorovac


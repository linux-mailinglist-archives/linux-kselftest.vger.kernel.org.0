Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35D4AE08C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 19:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353170AbiBHSRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 13:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiBHSRk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 13:17:40 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623FFC061576;
        Tue,  8 Feb 2022 10:17:39 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebc2.dynamic.kabel-deutschland.de [95.90.235.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C5C4F61E6478B;
        Tue,  8 Feb 2022 19:17:37 +0100 (CET)
Message-ID: <4c02f06b-bae2-e8a9-6c77-71dd669342f0@molgen.mpg.de>
Date:   Tue, 8 Feb 2022 19:17:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] rcutorture: Add missing - to `--do-allmodconfig` in usage
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220208105240.43600-1-pmenzel@molgen.mpg.de>
 <20220208180503.GR4285@paulmck-ThinkPad-P17-Gen-1>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220208180503.GR4285@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Paul,


Am 08.02.22 um 19:05 schrieb Paul E. McKenney:
> On Tue, Feb 08, 2022 at 11:52:40AM +0100, Paul Menzel wrote:
>> The usage currently lists `--doallmodconfig`, resulting in:
>>
>>      $ tools/testing/selftests/rcutorture/bin/torture.sh --doallmodconfig
>>      Unknown argument --doallmodconfig
>>      […]
>>
>> Add the missing dash for `--do-allmodconfig`.
>>
>> Fixes: a115a775a8d5 ("torture: Add "make allmodconfig" to torture.sh")
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Good eyes, thank you!
> 
> I will add your Reported-by and your Fixes line (with attribution) to
> this commit in -rcu:
> 
> dbc3fa1ffb4b ("torture: Make torture.sh help message match reality")

Oh, I missed that. No need to amend, and sorry for the noise.


Kind regards,

Paul

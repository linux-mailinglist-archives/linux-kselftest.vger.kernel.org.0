Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9677C4920A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 08:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiARH42 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 02:56:28 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:58267 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230082AbiARH41 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 02:56:27 -0500
Received: from [192.168.0.4] (ip5f5aeaaa.dynamic.kabel-deutschland.de [95.90.234.170])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D1DE561EA1BE6;
        Tue, 18 Jan 2022 08:56:24 +0100 (CET)
Message-ID: <d744e653-5e8f-b874-6991-3005e6b8afd4@molgen.mpg.de>
Date:   Tue, 18 Jan 2022 08:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Problems with rcutorture on ppc64le: allmodconfig(2) and other
 failures
Content-Language: en-US
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <36bd91e4-8eda-5677-7fde-40295932a640@molgen.mpg.de>
 <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAABZP2wxXW2RqpKevt9erkYg3po0ByUEFvYsgy3cRty5Rt1Qyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Zhouyi,


Thank you for your quick response.


Am 18.01.22 um 08:34 schrieb Zhouyi Zhou:

> I have studied the rcu torture test recently. I am also interested in
> this topic.
> But I can't open
> [1]: https://owww.molgen.mpg.de/~pmenzel/allmodconf-Make.out.txt
> [2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture-log.txt

Sorry, about that. I should have checked those. I had put them into a 
directory:

[1]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/allmodconf-Make.out.txt
[2]: https://owww.molgen.mpg.de/~pmenzel/rcutorture/rcutorture-log.txt

I am going to try to test your suggestions at the end of the day.


Kind regards,

Paul

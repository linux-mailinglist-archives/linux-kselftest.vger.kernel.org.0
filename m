Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4888712D5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbjEZTZq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 15:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243605AbjEZTZb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 15:25:31 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC5D1987;
        Fri, 26 May 2023 12:25:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 28AC360204;
        Fri, 26 May 2023 21:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1685129104; bh=TirXeNXcSGysUY1U4xKNK2JClyX6eQNssWqvDCuEisI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xs9isNSuXwNC3VD26JSpsggNq7hTq8uqKje9Olf9r6lM3aAps7x85uuB9nBfAB9B7
         t1uoB10GnW38VwABiY1vUhgB9IRWMlWgD/Gu+vjcMnLrTO0u0hiUEEgx7hm2p9JK36
         fbwDHrKBGPGuFRcCabwDOVyg498bdu9lia/5qCZmi/g/Nyj+gcmYgyj0CLsQnkLgo6
         XYHxbiSjFpw7ElgbjbNOqsYfPM4M7XFD8nZ7Iq0ZF9zd7k/+hJu3d3gvcYWds52tK0
         C9z3svxc/VW3c1jy7nR2dm4gouDBMiUic6ZWrcVBu5mC6tVx0ppawIVN6TMggzDGR+
         vYfE1X62Y+7SA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F9xZedwACIwM; Fri, 26 May 2023 21:25:02 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id 9403D60203;
        Fri, 26 May 2023 21:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1685129102; bh=TirXeNXcSGysUY1U4xKNK2JClyX6eQNssWqvDCuEisI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=0lmiMCYu2YDUtravjkwoTBqXhgjbhmCZsWkhQe5smuIlPTvCelwf02jGYMRDdvpyI
         VE5fd4LY0kxYQjYEUcvLLfVjdDQ+Q2CCnMQ9sheuyVaerVrb0nr91Fi1HYxuDZTmQE
         maCzKbWIx0O/1kY/YdMqhyE9hOaqLdeeC7EfT2VrEEman1n3RLjncTUTVebu1Fm37X
         BoMqq8KJ2D9KtN1BRVMDAxO1YQkmLrrx8vfDKEqTFCs4gtord8s0EsDfCTJpibbio5
         sECRViI+RRsQIjRQtjbJAW5bHH8562yQzxMxI/D2AFE8JkKUB84bDlpuMOa8cQ+Dvx
         U+ZQZJVks0g5g==
Message-ID: <00be4091-0119-c9dd-c632-079d2943c5ca@alu.unizg.hr>
Date:   Fri, 26 May 2023 21:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] selftests: alsa: pcm-test: Fix compiler warnings
 about the format
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230524191528.13203-1-mirsad.todorovac@alu.unizg.hr>
 <9c82296b-4682-49e7-8302-bd678135f1b4@sirena.org.uk>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <9c82296b-4682-49e7-8302-bd678135f1b4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/25/23 11:22, Mark Brown wrote:
> On Wed, May 24, 2023 at 09:15:29PM +0200, Mirsad Goran Todorovac wrote:
>> GCC 11.3.0 issues warnings in this module about wrong sizes of format
>> specifiers:
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks,
Mirsad

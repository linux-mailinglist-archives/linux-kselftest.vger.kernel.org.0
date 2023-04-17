Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5007A6E5583
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjDQX5y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 19:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDQX5y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 19:57:54 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516AB4EE6;
        Mon, 17 Apr 2023 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sZOpuzwL6J8z7LygT/lrP8vyUSOBcCMAz7NoAyrs1kU=; b=Ee20hJURHEVAoTTC/8x7O7fp3b
        UO/bnjw1kqg4RQqqW8HrT68+C5UH4ESCCort/Sc5iXO1YjZr6VB/hXeDrQgJ44sh1gtuwSgiPEQYm
        w4vOweemlxuNTHeRJv55tnHHV9TBQy2x8UajYA7Q07KZpNYjRd5Hkhdzgh3kn2r9WFWRQYu8nXSB7
        az6zEXgBh6Ll4XHx9zlzk2NZkGnWSJB9aWPEBDIyyt+JLZtn0CEZogWKE97EtpDCsfmNcsbIbMHtz
        j+h7P5zTL4gi26INE+t7T0EMagw1zD2xcvMVxZXqvoJrbPzh6V7k5oAbtRDtbBAhAX0h1G/Soe2Xw
        h6IVas5w==;
Received: from [191.17.235.153] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1poYil-003jfR-K3; Tue, 18 Apr 2023 01:57:19 +0200
Message-ID: <2ee0c706-a97b-a881-4116-dec4d163ded7@igalia.com>
Date:   Mon, 17 Apr 2023 20:56:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] selftests/futex: Fix pthread_create() error handling
Content-Language: en-US
To:     tavianator@tavianator.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <42a8405a78936a3ec96bbd0c6b5d983291faf646.1681766292.git.tavianator@tavianator.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <42a8405a78936a3ec96bbd0c6b5d983291faf646.1681766292.git.tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em 17/04/2023 18:28, tavianator@tavianator.com escreveu:
> From: Tavian Barnes <tavianator@tavianator.com>
> 
> The pthread APIs return error codes, rather than setting errno.
> 
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C026CBBF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjC1KHP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjC1KG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 06:06:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6216A5E;
        Tue, 28 Mar 2023 03:06:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p34so6577395wms.3;
        Tue, 28 Mar 2023 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679998014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73pdQE2RorPp4K5P6rPxPM8jjQELSWY3LdlpO/znf2s=;
        b=jIeDIg0n+1dtLzvxv8SXyDJE3eRt4Dzewm6GLazGgsBbOZ9ppZWKv5KtAD1w3LLLAr
         Lc7zqbdjgahli2/kitRIz9gyGhRalA5zOY2guWt01QY1weRHtrw5mT0fyko536pO38uR
         r5a7l1S9rZcB210OwnRlLjXgK15iAcYy8dQNk8QRQqtcI5ZS05smmDZu7csBDRLB3Id+
         W/L0U9i3SQ3rtgyr1AMHPiL3X3AzC/zKL1sBnOW94pzwYdKCur3plME6WeVAed/VagvQ
         deTvx+2RhEKl1uL4AAfauhp0HcOwrCYuk/F2pRMK1mxR1wZflnPihIWZV19UtYUG4JcO
         FXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73pdQE2RorPp4K5P6rPxPM8jjQELSWY3LdlpO/znf2s=;
        b=xjtbiwOKFGoEQiw84nEuaUOp/sXhKw0ZlOEZKHQ0wBNmIyWJmduRcjeFe3VBpdkKrj
         EJqHNXFmvHglvXKWRXxMs0iKhpB2sbzXJB/M7VlDN5UnQD9m6xoBjum9LgzZMxv+FDgF
         gO3E099+tZ3RUG3WDO4HY6ti8aV5JJXbwdycD+fL2iv2WhqU0S/oXtMEywW6pD3UI7lp
         O/AewbGTLhOainaknMzE/GwyxbJmcmw5443h/ZCWlvZDrKJT4GsB9DyS6olGupXwVYDN
         mNQmMNlXhCc8CZGuQG90RYprEvbLmYT4THWYHj5RcRLpaGLp8jAikIS/v3xDaPzPPZ1a
         I3eg==
X-Gm-Message-State: AO0yUKUWOLoVB9kB7G1K+Rd17A8+3kzCg/DuiFJbcaSI7rGXkAFKSQKM
        gW31DwDzBYWccV9ZxBCIXyc=
X-Google-Smtp-Source: AK7set8zILEWsxEHvYfLQ0pLB68ehJg+eI8U12Z4Kyzq3vzt+0ZKzp4q4oKQ0yAEwmxFCTjm+YTZ4Q==
X-Received: by 2002:a05:600c:2114:b0:3dc:1687:9ba2 with SMTP id u20-20020a05600c211400b003dc16879ba2mr11027722wml.35.1679998013685;
        Tue, 28 Mar 2023 03:06:53 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c214400b003ef62deb830sm10531539wml.25.2023.03.28.03.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:06:53 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:06:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [BUG] selftests/firmware: copious kernel memory leaks in
 test_fw_run_batch_request()
Message-ID: <26fd581a-1b9f-4960-8457-61d725511cee@kili.mountain>
References: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 28, 2023 at 11:23:00AM +0200, Mirsad Todorovac wrote:
> The leaks are in chunks of 1024 bytes (+ overhead), but so far I could not
> reproduce w/o root privileges, as tests refuse to run as unprivileged user.
> (This is not the proof of non-existence of an unprivileged automated exploit
> that would exhaust the kernel memory at approx. rate 4 MB/hour on our setup.
> 
> This would mean about 96 MB / day or 3 GB / month (of kernel memory).

This is firmware testing stuff.  In the real world people aren't going
to run their test scripts in a loop for days.

There is no security implications.  This is root only.  Also if the
user could load firmware then that would be the headline.  Once someone
is can already load firmware then who cares if they leak 100MB per day?

It looks like if you call trigger_batched_requests_store() twice in a
row then it will leak memory.  Definitely test_fw_config->reqs is leaked.
That's different from what the bug report is complaining about, but the
point is that there are some obvious leaks.  It looks like you're
supposed to call trigger_batched_requests_store() in between runs?

There are other races like config_num_requests_store() should hold the
mutex over the call to test_dev_config_update_u8() instead of dropping
and retaking it.

regards,
dan carpenter


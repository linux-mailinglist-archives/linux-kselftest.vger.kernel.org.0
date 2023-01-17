Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6C66D9A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjAQJPy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 04:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236545AbjAQJPa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 04:15:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F293CE04;
        Tue, 17 Jan 2023 01:07:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mp20so27172210ejc.7;
        Tue, 17 Jan 2023 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fu40KvQods0f8+f4pClm3XB2VIfGWpRE1TO7X5DnksY=;
        b=F337AvHuIwnYmV6Vd1NkpkROLrRrtw3hFucTWByWJwBEdyfpSeSpQl7htMKc5ycrXb
         jGGq6WYPZbwKGTCn2wFAMccvmGy6+0NlNK1vqTYRv0Wa2BxqeMSu8M0RZ8pD4sj436TK
         txw73PqxI6pfZLw23NN5Jpf7K8DETEbYVxoz3/+mUO44zZrvJZx/XQzJL7B+bXq0kN2S
         PA4dk74VsLGMSxTBJ0MqzPejMps8HWRVhPjy397ehx15HyB2pL3IjLru8SF5mVTqCVwr
         v4Sp+OnJFK95cR24e6KFlLrjaHuAiyYvmSqFffFYOv29Eur9rD0BQ10Z/hvlirUfxQt9
         gu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fu40KvQods0f8+f4pClm3XB2VIfGWpRE1TO7X5DnksY=;
        b=ccJZ5EvFzOtoy72rT+HoMUCxV9xcbCbfWwQr8lNOYu3MTMt2dWl1XE/IxEmE4zcq/f
         HlQrQ4bk5B/cqbXJ0bBC+h6TPjN4A8K1y1qqrk3zGPkbfBMI2G/bIaV4qPd6USyX5+Hp
         2VDT52epzB3OoC79m+lW1+S8SBeKgmTNVMzp0iA6hg6CCjhFY03KADQwgb+qx49Esb+o
         3FGUkJAXOhwYRWUM/LCqQkWZOrWjFO8Ec4LlUZgOmdhvykuKoqzmAS+lYeF75jdFOl0z
         VgvJUkcyDrH2esk8w8hZTm9r21TuZq2BSTLCgVGnEy5IgjnbpHmR4myrEI5+WnA9dLXb
         26cQ==
X-Gm-Message-State: AFqh2kpjVED7AGgHAnz0wXIaFtc0Q/Oeg5jn2u8JHGEN/fOVyFGj0tsE
        sqskKDcCa+AqmwpYaBJlC6F6lgUa51M=
X-Google-Smtp-Source: AMrXdXvWe1xTCoV3Dt1xTDPw5sA577HJxS77ZsddbAWFzuWfnHh+rJlqzPEogdpojkWJ03oLe6HprA==
X-Received: by 2002:a17:907:d606:b0:86f:b541:cd02 with SMTP id wd6-20020a170907d60600b0086fb541cd02mr2382239ejc.28.1673946421996;
        Tue, 17 Jan 2023 01:07:01 -0800 (PST)
Received: from gmail.com (1F2EF7EB.nat.pool.telekom.hu. [31.46.247.235])
        by smtp.gmail.com with ESMTPSA id k22-20020a1709063fd600b00862497eafb2sm6815655ejj.103.2023.01.17.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 01:07:01 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 17 Jan 2023 10:06:48 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <shuah@kernel.org>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [tip:sched/core 7/28] rseq.c:139:37: error: 'AT_RSEQ_ALIGN'
 undeclared; did you mean 'R_SH_ALIGN'?
Message-ID: <Y8ZlKOsN1wGk9tTc@gmail.com>
References: <202301170348.7WLKH1pl-lkp@intel.com>
 <bfa719c3-bd1f-5fc4-40ab-6dc6822b7628@efficios.com>
 <4449d8b5-b7a5-0f09-5b42-7b70ba00f8f6@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4449d8b5-b7a5-0f09-5b42-7b70ba00f8f6@linuxfoundation.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


* Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 1/16/23 13:18, Mathieu Desnoyers wrote:
> > On 2023-01-16 14:40, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> > > head:   79ba1e607d68178db7d3fe4f6a4aa38f06805e7b
> > > commit: 03f5c0272d1b59343144e199becc911dae52c37e [7/28] selftests/rseq: Use ELF auxiliary vector for extensible rseq
> > > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > > reproduce:
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=03f5c0272d1b59343144e199becc911dae52c37e
> > >          git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > >          git fetch --no-tags tip sched/core
> > >          git checkout 03f5c0272d1b59343144e199becc911dae52c37e
> > >          make O=/tmp/kselftest headers
> > >          make O=/tmp/kselftest -C tools/testing/selftests
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > In order to fix this, I need to change -I../../../../usr/include/ for $(KHDR_INCLUDES) in tools/testing/selftests/rseq/Makefile
> > 
> > I can find 25 odd uses of the same pattern in the kernel selftests. Should I fix them all in one go ?
> 
> kselftest build depends on headers installed in the root directory.
> The main makefile enforces this dependency. If this test is being
> built without installing headers by itself, I think the scripts that
> build individual tests have to makes sure headers are installed first.

Why isn't the Makefile saying anything about it & enforcing it? self-tests 
are usually self-sufficient to build in the individual directories.

Thanks,

	Ingo

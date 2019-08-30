Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CDCA2EC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 07:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfH3FTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 01:19:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36269 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfH3FTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 01:19:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so2920092pgm.3;
        Thu, 29 Aug 2019 22:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1nctaoN3PaUf098PRZ6JFogZTWSv7+XUi6YwJP4fCAo=;
        b=DKCR1YXjk42QY0bZpDUjncMm/nHWi8O87jMZLfrRO9o4C0nEVEuv/VZ+ymLqBVwONH
         v2D/G+Nja5J3Ep3PXCkKQU5c0AYV+a+l0mhOUmF4XLAVooQ35ycFtDyO50pQ5TzA09e/
         CB3MLBG7htyZ74WKCjb8pfVCJ8VCM4SpEFPlDMKUC4cyOmFtaYy8x9kTepngQP+FgN5u
         FROcQQ6MP2CTox/uFHafR3YISBspQYruMf2zQw6b6X4XGCjiuT++WRHo8QEA8g1dM1c/
         0k8jvpJoPAkFOX7tT4jLVYa61yWEIH4oydgjkvpPYaKliOSWtB3XQF7pqW2VnfiiGzl8
         7qIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1nctaoN3PaUf098PRZ6JFogZTWSv7+XUi6YwJP4fCAo=;
        b=qH71cPPA0zS5MdrprpbPLNLJQ/VbMg7DOTS42QqWOfKl2Hlste08yLNsDkF7G9A7Rj
         iUbNGKkfWHqCmmhduwlfnb8I9o7Yvb1NOw590y0UkTFQd/C3mVizVfMi4M1Z0a2qpp0G
         ZTR/WyUzjTXgINVZ4SB6WF8Z8fNXz5RrXMq+WrSWiA25XhXgatfW5enZXw8XO6YFJBox
         Eadlem631AZIJwWs2UToWsb4QMjqae7+tYOlv82sh2wbAyIleLtYLnVkhr1Dcna/Zt9x
         fwZCsOtGXTSGUn7eHjLCUATRo6kAzSbuiGTy6P7aRPE6BVXQEgfk3P2X46fY35pco6sM
         V+YQ==
X-Gm-Message-State: APjAAAW8WR5pC1CCKIPQLfb1PXMxjxQJEgYhbm2IlvUjbsdbf6OQ4mlQ
        MViV5S8tzQNf2vwevEolbEM=
X-Google-Smtp-Source: APXvYqwrlazBAEqMED3dDkkzhOf+gi/L0kA9lWE56MAUp8nBmFG+olBHMTwReevYZ5zmNCsMMcMVWQ==
X-Received: by 2002:a63:724f:: with SMTP id c15mr11855879pgn.257.1567142392183;
        Thu, 29 Aug 2019 22:19:52 -0700 (PDT)
Received: from localhost ([175.223.26.233])
        by smtp.gmail.com with ESMTPSA id f27sm3865245pgm.60.2019.08.29.22.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 22:19:51 -0700 (PDT)
Date:   Fri, 30 Aug 2019 14:19:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Joe Perches <joe@perches.com>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frowand.list@gmail.com, sboyd@kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
Message-ID: <20190830051941.GA3598@jagdpanzerIV>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
 <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2d63bf-56cd-e8f5-e8ee-2891c2c1be8f@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (08/29/19 11:01), shuah wrote:
[..]
> Hi Sergey,
> 
> What are the guidelines for using printk(). I recall some discussion
> about not using printk(). I am seeing the following from checkpatch
> script:

Hello,

> WARNING: Prefer [subsystem eg: netdev]_level([subsystem]dev, ... then
> dev_level(dev, ... then pr_level(...  to printk(KERN_LEVEL ...
> #105: FILE: include/kunit/test.h:343:
> +	printk(KERN_LEVEL "\t# %s: " fmt, (test)->name, ##__VA_ARGS__)
> 

Oh, right.
So we sort of want people to use pr_err()/pr_info()/pr_"level"()
because, otherwise, when people use plain printk(), they tend to
forget to add KERN_LEVEL.

In kunit case everything looks fine. KERN_LEVEL is there so I'm
fine with the patch.

You still can switch to pr_info()/pr_err()/pr_etc, just to make
checkpatch happier, but that's up to you.

> Is there supposed to be pr_level() - I can find dev_level()

No, not really. pr_level() stands for pr_"debug"()/pr_"info"()/etc.

E.g.

#define pr_emerg(fmt, ...) \
        printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
#define pr_alert(fmt, ...) \
        printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
#define pr_crit(fmt, ...) \
        printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
#define pr_err(fmt, ...) \
        printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
#define pr_warning(fmt, ...) \
        printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
#define pr_warn pr_warning
#define pr_notice(fmt, ...) \
        printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
#define pr_info(fmt, ...) \
        printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)

	-ss

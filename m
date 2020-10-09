Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8664289076
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Oct 2020 20:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390290AbgJISCU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Oct 2020 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgJISCQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Oct 2020 14:02:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3958C0613D5
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Oct 2020 11:02:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so7785118pgb.10
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Oct 2020 11:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fps3PqFaysle0PRgPWn697Q6yTfHdUTrcLR8SfGSjDI=;
        b=J4UrOZFfjvg9i76n7Ym5mqm8RLf9OMc2L/LhCwWyI2J+T0aryrUTB4LXPDfIP5r8H4
         SCr7j/xrmFs1AByYCLLafZoAi7YLzBTbTrRyUoqesu/cZLZbFYpLxBb5mxmN4CcG221s
         CXRW9jeyAar4k0bFs1FYRmVrlSzD0rhQ1OlII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fps3PqFaysle0PRgPWn697Q6yTfHdUTrcLR8SfGSjDI=;
        b=qOCGoHu4RGsfcgxTb7EKNwFZzZvUZ+I1IZLc2cMjY2RqvW78T70sT3hmiGY3hHKACU
         /YoNdsHrIFju2Vh/6vZLl4xV9KNeV+MMvrpU/RtwUkjqzU3unvy76cg0I923SrSw8d04
         XgK3rNEEOhM0RE9a9FtgICRpf2uav+tCsARjsWAmR75EgWuzAAXhOzPRiCLYlBzUgFMK
         sWZMiS6jLGRbh+prG0oGZO4hC3iv01YrbQPx/s8dLoaGYYQNro5cdJ6BkgP3hR0j8DWa
         ynFtJKOSSCWyTk0BsFS/s77QugLw9hS0NGfcGlmRYmyzAJjg8Kn65xKxz/Ic9m3dfFha
         Ha0Q==
X-Gm-Message-State: AOAM532k3AbtSSd4vemRbQu8+qpTuDeAQRY7Ua3PWpEaVoUZhVxy4zJ5
        Nd9tqL/DE16St4vlJiNr3MmmwMLwA399LA==
X-Google-Smtp-Source: ABdhPJywxDSyJysznZQyNAhMTDcr5kiIlix/kWmii64iJd+8gbW9LAMhhTxCfCY+YJpdCpgSrxNt2w==
X-Received: by 2002:a17:90b:ed3:: with SMTP id gz19mr6086256pjb.53.1602266534262;
        Fri, 09 Oct 2020 11:02:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm3952110pjx.4.2020.10.09.11.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:02:13 -0700 (PDT)
Date:   Fri, 9 Oct 2020 11:02:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/11] selftests:lib:test_counters: add new test for
 counters
Message-ID: <202010091102.9073C41@keescook>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <688424d7ff981d34523cd6794d7ce3c27cfe57b4.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <688424d7ff981d34523cd6794d7ce3c27cfe57b4.1602209970.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 09, 2020 at 09:55:57AM -0600, Shuah Khan wrote:
> Add a new selftest for testing counter_atomic* Counters API. This test
> load test_counters test modules and unloads.
> 
> The test module runs tests and prints results in dmesg.
> 
> There are a number of atomic_t usages in the kernel where atomic_t api
> is used strictly for counting and not for managing object lifetime. In
> some cases, atomic_t might not even be needed.
> 
> The purpose of these counters is to clearly differentiate atomic_t
> counters from atomic_t usages that guard object lifetimes, hence prone
> to overflow and underflow errors. It allows tools that scan for underflow
> and overflow on atomic_t usages to detect overflow and underflows to scan
> just the cases that are prone to errors.
> 
> Simple atomic counters api provides interfaces for simple atomic counters
> that just count, and don't guard resource lifetimes. The interfaces are
> built on top of atomic_t api, providing a smaller subset of atomic_t
> interfaces necessary to support simple counters.
> 
> Counter wraps around to INT_MIN when it overflows and should not be used
> to guard resource lifetimes, device usage and open counts that control
> state changes, and pm states. Overflowing to INT_MIN is consistent with
> the atomic_t api, which it is built on top of.
> 
> Using counter_atomic* to guard lifetimes could lead to use-after free
> when it overflows and undefined behavior when used to manage state
> changes and device usage/open states.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

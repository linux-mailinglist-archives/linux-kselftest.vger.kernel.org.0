Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23341ACF0E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 19:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405358AbgDPRpo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Apr 2020 13:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436526AbgDPRpj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Apr 2020 13:45:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24079C061A0F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 10:45:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r7so8706399ljg.13
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Apr 2020 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNf+O79dxYvL9upUNIRS+k5/S1UjI4y44sK7fhayR1c=;
        b=yhuejy7C49EgHspat4U3jEapm5Mwx72TiEXWSd/E+JkFxuW54VToaZeqmpgHO9awa4
         B8KIPl/0skwI5l8MKZBwPWl2ouP9Ag8DEz0hepOepQOQQRuWZ05dtw/1PqzXx1O9iuzO
         e9pOPFmWfQogTHkA5DsEvC/7H5HoQgZov59RRldnV7rAJejBuuDUfCwOwRfqrK9aneqX
         /MdkS3FtkTaT1af0mUT3saqaE9SpuPzwd44Tu1EFw9TOQspF8GfPUjGdzH5WjcTuHzyN
         S4ZHToOtpkkDw7xauUnfBITP01N85mgxeKExbMZFwIfsCYHn0fk6s7ctr86ivxg7GGus
         XwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNf+O79dxYvL9upUNIRS+k5/S1UjI4y44sK7fhayR1c=;
        b=DSFK65QDn4ATGxjGMeZ9oCvuczsV/kYcqv9BmnrkxN5EUCcncbpDtZ2AU8GcnGjGzj
         7uGDQwu0PnpSd6NecN7Oo3FnXdAEo7Hf2UuwVC1K07pbR2h67DXxXPIwn75BG6LJXA+W
         F1OCFvpEj/17ePUSnkreQMCIjdFrhjwwhgTyagResT19LGqa+w1sQr/rAD18e2DbxPpV
         bKyJ3Sbf8TJFdnGqeN9k6icsCDp8WMjb0H/RStmrtMQn2LTUKq+DBobaTMBPkr/RJWgm
         TWdxf8XTVfN+ivkpLIT3Ds6LNHkz2ZB0bVWOC/OhAOpM7xY8tyH5GNxwxqKoT6RwURr6
         B2xw==
X-Gm-Message-State: AGi0PuZzn81w8vaxxhH5Dm/PizMsZj/1A3ZB3CJxRBSJmXztdN71HdCL
        SMl465y1gF6AHBt9qzIn0VDR6MOSoT2+vKsEeI0j/g==
X-Google-Smtp-Source: APiQypJGuJOqkYj/Ehe30t1U9ZuH6dYK9mTv6Ks/1KBhVVrW2UXVfGzjV05x98HDEPK+WR5eLGwOBhDPQRAntg4Ru8g=
X-Received: by 2002:a2e:8e85:: with SMTP id z5mr6778180ljk.165.1587059134502;
 Thu, 16 Apr 2020 10:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt7-R-_fVDeiwj=sVvBQ-456Pm1oFFtM5Hm_94nN-tA+w@mail.gmail.com>
 <CAM_iQpXQdgwFwUONX+za5vJbcXP9krwz_--pG+z_Etf_v8K2mw@mail.gmail.com>
In-Reply-To: <CAM_iQpXQdgwFwUONX+za5vJbcXP9krwz_--pG+z_Etf_v8K2mw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Apr 2020 23:15:22 +0530
Message-ID: <CA+G9fYtCV55uuArU4OLCTaaBPk7BDeZyOBUHoScN4NsbQeuPhA@mail.gmail.com>
Subject: Re: x86_64: 5.6.0: locking/lockdep.c:1155 lockdep_register_key
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        Netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>, lkft-triage@lists.linaro.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 11 Apr 2020 at 02:20, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Apr 7, 2020 at 2:58 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Linux mainline kernel 5.6.0 running kselftest on i386 kernel running on
> > x86_64 devices we have noticed this kernel warning.
>
> This is odd, the warning complains a lockdep key is static, but
> all of the 3 lockdep keys in netdev_register_lockdep_key() are
> dynamic. I don't see how this warning could happen.

I request to provide a debug patch which prints a detailed log.
Happy to test it again with your debug patch and will provide more information.


- Naresh

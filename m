Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952DA36A940
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Apr 2021 22:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhDYUsC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Apr 2021 16:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhDYUsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Apr 2021 16:48:01 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285DC061760
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Apr 2021 13:47:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id l21so10757020iob.1
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Apr 2021 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mf3PfXpISSLDZMwm9YZTjHVTAuZA/fvHBTlgaYQIzcI=;
        b=X5AVotbEK6atQhNjrhtrKs3bygci5Hs9SdVKnTVbPJDpTIwFNEExX/mnZzzaIdYN56
         We87O01mb+dinYzuDIkE/XV7X1vEDC4s4HdXwijqqdwtS7HAUrVy61RfAHMqoCuGCyo0
         iXVBDvNwY6dcWBtMwEGuEjADsc3EnDeqpmfm5IkABz+d0gjFduOp8i+EaHSzTxCvrlwt
         ooTjGMtdNMvWmGYsWaV6hnPZ/DCQkJBFckbUYsB9c5m9gRat1RJ1MjNwU2LYK+qcjiuv
         jfeJiTcUhCgFaBjwR7/Yy/+1OUwpC3KXdnCJfaYrniNABJ5m94F47gR+DlhbLbzH8XNu
         xCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mf3PfXpISSLDZMwm9YZTjHVTAuZA/fvHBTlgaYQIzcI=;
        b=UajuWZYFqHO7MeNvwtpslPtEM2Lrk+N/Bd1g9DzN/TbMaDnZGF0bd8Hg6Em/RdHGEn
         YhV6Jd+xGbgHCw/IOkhS/E23yTrB+gog5qLPgPAZjmCEFv6HzuwigjbkgIe3qWqwEoRO
         g5/e/cxZ8xdKoe7thPMj5ZKzlgZMFQaHzvD00Bc/g69k9BZ5XmPVk3b8vQIwzM05NJZu
         pOjcNSapalVKgB5biQEdoFMOJ2KIwCkjKxbnBqB+55bA04TkoJB5oePeRXZ95FwXc/32
         N05C9MZraCXmSQXAZuJQjg27/xw81ZY4MHlEODLxcjVq6FKg1ET3f7g8wPPKPUHRmQEG
         Qnfw==
X-Gm-Message-State: AOAM533L1pVN1FZFEyCStPeb9LmnR4eRvECPgG3YMvVHk3HuUjqmKD+v
        vPVLgT/AGzr4zJ29Fo07fScrOJEcBckpnHbeqGsrHg==
X-Google-Smtp-Source: ABdhPJygw52SbW2dXW+oPoyP50PRJ3SqpU5dALd4uwGiFSlA85XNU5GjOTBuXNctFj4gYs+N1Ax+fsUeXxWS12NU3Ec=
X-Received: by 2002:a05:6638:2044:: with SMTP id t4mr13460135jaj.12.1619383640861;
 Sun, 25 Apr 2021 13:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210412074309.38484-1-psampat@linux.ibm.com> <20210412074309.38484-2-psampat@linux.ibm.com>
In-Reply-To: <20210412074309.38484-2-psampat@linux.ibm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 25 Apr 2021 13:47:10 -0700
Message-ID: <CAAYoRsVcVnrBSNu=umdVWtRw3PyuD=c4uaCCcoGQpSWgq3AH=g@mail.gmail.com>
Subject: Re: [RFC v4 1/2] cpuidle: Extract IPI based and timer based wakeup
 latency from idle states
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pratik,

On Mon, Apr 12, 2021 at 12:43 AM Pratik Rajesh Sampat
<psampat@linux.ibm.com> wrote:
>
> Introduce a mechanism to fire directed IPIs from a specified source CPU
> to a specified target CPU and measure the difference in time incurred on
> wakeup.
>
> Also, introduce a mechanism to queue a HR timer on a specified CPU and
> subsequently measure the time taken to wakeup the CPU.
>
> Finally define a simple debugfs interface to control the knobs to fire
> the IPI and Timer events on specified CPU and view their incurred idle
> wakeup latencies.
>
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>

Reviewed-by: Doug Smythies <dsmythies@telus.net>

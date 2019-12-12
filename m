Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80611C22D
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 02:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLLBbk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 20:31:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37743 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLLBbk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 20:31:40 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so225214pfn.4
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2019 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7BY6Zcq9XcTFG0Efu7gJTSZE5NTVFX3CybfHRAtqtY=;
        b=UQbDOg483encmWh2POkOoxh3EtPNdlowu1onPBvjs+LEHmho0x1YQHxScWT8Lw2ZYa
         amX44rro/c8kF1RngDJ4y7YLNnOkInXJR3Xf42xL/HFiM0ThutqYXs0pkYpOpDo2vcp8
         pkKdibHstn567lChfANcg93TN51oSPI9dObLCNYs3FETzDV8qmA/lWDAS65BG9AdRErg
         9KIgjG81kXN11FlfsMNKnN3iw9bePVKFWXMb8lww+N4ihJFE3FUnsdnHeh6v9NVRDewc
         3wX7KipMI53+sCF3NtOh8RTHE7cvEDUnvdEUx7KfyYNzuodiEd3yr0yLkjI3Iq2Tgv6S
         8iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7BY6Zcq9XcTFG0Efu7gJTSZE5NTVFX3CybfHRAtqtY=;
        b=VVFLDIWsfoeoo+LLDdfSLPTLt3Eygd3Qsz+mhHUh5ReONBjk9F8wQk1E1UzpgWqDby
         1Iaus0bpU2nUbALQ8tmmHnjQEA2lKDjERm98a3OEvNvDCK/RE1eqlFovZo/NfeieEb0L
         9cAuLRHowQXP/wE0TMXdBPj0FSxl+buonjbKhJ/Yc39DbQPbNX/gaF5zzuiAO25hMTO9
         HwCZBbbNeZT1pScvb8hXbeDVBZtqHMzh9Plykj8chjrkHMu9m5/nvuGxotqV9SPV5x7B
         TJbcsc4po8mQfrzPDGMDWYLViFaKINyI9P6U6GMPSyuZAPI9gX+mxisULp9bwQd9cdOW
         Ogkw==
X-Gm-Message-State: APjAAAWyxqq/R3P97sdC0zqvjeC/eRU+wstpIhLGABhbqWHeNdMbK4zd
        /SZn0vzjRiEKr5GYRY+/c67QFAnrmNrLMNgBjak8ZA==
X-Google-Smtp-Source: APXvYqzyx0bJdLaOoxD/m3x6xqpPQF57TiXxv/pys7PBdDRAXjsm1+KcpFNaAqUbxMNbAJJ7ANa4I+kOvw45zq9nDgs=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr7136357pfg.23.1576114299143;
 Wed, 11 Dec 2019 17:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20191205093440.21824-1-sjpark@amazon.com> <20191205093831.22925-1-sjpark@amazon.com>
In-Reply-To: <20191205093831.22925-1-sjpark@amazon.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Dec 2019 17:31:28 -0800
Message-ID: <CAFd5g45fBjcVV-ZTvYVOM=1sbdCnjQdcEs5KQ8cXz5JJUdoSrw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] kunit/kunit_tool_test: Test '--build_dir' option run
To:     SeongJae Park <sjpark@amazon.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, shuah <shuah@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 5, 2019 at 1:38 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit adds kunit tool test for the '--build_dir' option.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

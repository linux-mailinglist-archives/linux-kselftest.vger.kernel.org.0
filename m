Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B8E3119AF
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhBFDPn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 22:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbhBFCzl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:55:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4235C08ED7C
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:30:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id j12so5322889pfj.12
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uuoZTsAa+emkzSEvsXs+jp0cxHIStdgFTDYBF0y1Zlk=;
        b=NTIMc7RAPHbP2GpsLMJKNE5NEpWhtHXYXweLonU3exUG9mrQEI/lgsYuES3XleG1bw
         H6l9w+gwvYXrJF9ZdVktEQ92iXFmxPl7DlrKnwyWveIQepKjR9bN+Vy3ttJ3hySBk81O
         rAm4TA41vyNkj0TbmBwixq5dcD9Yy3rcB0acNEHGaEUKLGknNLr8H2i8iXBSNO2b/BA0
         7BJWJDcsvBH1q/hqQmEkDDdX5LcARAtnYDyqEY+/BzQyEnwzulTCY6QnfdRYdGyxI1gb
         ah9yPJDUuPoymKa9QFv2SZSgFiDk44WDGNvONTcu7vOC8b2ASSvpNWsqp88S0rTNpTs5
         JEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uuoZTsAa+emkzSEvsXs+jp0cxHIStdgFTDYBF0y1Zlk=;
        b=WyOQReGBv6WbJluZ5p52YoSfy+BJ6XEt48rN6TvMsDHN0YOmiwQA+Z+I2wNSFN86/d
         1NGJ4A4v9TmszzdljRP4SoU73G52LRYehKjLGhkNxAJp9Wu5uwEoMRaZ0Hjx3N1CHOCf
         HbO+uXTZBl6WrHu7LP1Dn+xng3MhbF1hri2kMEGdF5kbyb5x48xii76puXyB6zFJhQQx
         NQ5tSoC5I5EbimnbENrzODDEK4i59ihoUQXtf7og5O/4tXzqxRGDQp/Z/qqszr67HXJU
         wT5xXlO2a21vHkAwdq/7w3auRXv/yesXx1WdpQxA4ULK5S1BNm7uCBAbTgpsASGkwJ8M
         7wGA==
X-Gm-Message-State: AOAM530Mr1f59bZsh8KuhzIl5QWOksWZ+Fx/PcQlVnyVpddLVx7AvyXC
        IFBL2e6hctGW2JjsgcIHn1twiJzaynrqnaJFPe/cZg==
X-Google-Smtp-Source: ABdhPJz7fjyjm3zP1E+EhYMfal+dyUbCIoiAkSjxIRFTTVzV+vtyVuFOVRJZrajRJRodu6bhYCLn4XUNuyE+29+NJQs=
X-Received: by 2002:a65:4184:: with SMTP id a4mr6772997pgq.384.1612567812337;
 Fri, 05 Feb 2021 15:30:12 -0800 (PST)
MIME-Version: 1.0
References: <20210119235226.93280-1-dlatypov@google.com>
In-Reply-To: <20210119235226.93280-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:30:01 -0800
Message-ID: <CAFd5g44PkcWQG9SQdkUFjV_pttJr==6+R14w5NBOifK_hwDStw@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: make start.rst example Kconfig follow style.rst
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 3:52 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The primary change is that we want to encourage people to respect
> KUNIT_ALL_TESTS to make it easy to run all the relevant tests for a
> given config.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

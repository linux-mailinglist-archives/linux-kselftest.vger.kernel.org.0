Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBCE10E392
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Dec 2019 22:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLAVKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 16:10:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37184 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfLAVKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 16:10:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id u17so10223524lja.4;
        Sun, 01 Dec 2019 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6/nAJ7zRWy4qKArDtOklB/XBpnc4q8n7RTEqKD0nxA=;
        b=oLf35IhQ2D095BBBi8WNjU8LKJG5D7kAgMegcF33QwoIOJC66xYI1ZGwNATONXYEOE
         Vg+Ms8f5SaV+fMXWGAz5x6zLNurAtprVN5f4AyDGahxOBNgPxJF+G1eJvjA7vtyzgsT2
         nosG37knd2kyq+ILkvs/5BO/ApsfPP1aCiKBGjMBgjkJhlhyn0OwQclwKiKBGMmsnwJC
         RlVwePhLN6t5rmna5MEx6kN5xmMVk7zlxZaNsv/ELutPGbeXAc1RsPRimv2gxUHFFsco
         TNhhl0BZ4ynJRe0ykYFXolqQrEzPSSEHaEUeSAITP87mbUl9Z8Wy9NeFhnMnOtNNT1IO
         ivLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6/nAJ7zRWy4qKArDtOklB/XBpnc4q8n7RTEqKD0nxA=;
        b=OFZ0K+Rz1v6yLqj5nduqRd6kVnivf2tntS6cwEHLOMwXxJfcl9tA/vf8t6uBRyUYzv
         S2nKe3saeQrkKXj6H0zrV7IiKzMrMKgTqhggY11tVyzZzTTrWy2a481I/Um19lUv4Fth
         FltNBxIfU3HLNjAmu1QVZDf7RN6dQ+vb2RhACZmvWQlLwPJRG+KXpItj21nPVX43Q1F+
         6vRO502D4I8QDpHq+j7YlnWMGWKe0Gy5plT/0AuEAlgBwOQ/wflD1Z7v0a3G7UokNkfp
         8wQsCja/OrbvBLvF4vy5+ND1ya7eEKllq3Skh5GSzgs/L+Xzb1IPZVWQTI8BaeocCvvk
         xwQw==
X-Gm-Message-State: APjAAAVae2qiMIGePvK7/CF8kDtR3QaQ+4kP5fmKJHQvNK+QGO51HZZD
        S8BN6u+mmqsnmm/5I4YOMT1KCgBz76OWu1MowP72RsGsyV0=
X-Google-Smtp-Source: APXvYqyv5egh0CvwLiCaZRW7xONp7kzvGwnRIbz0FdAUGD+mjp2m58+YnCjWj/b/Q0OMmUUt7Y5wOVY81fwn86LVQo0=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr4851595ljc.161.1575234644720;
 Sun, 01 Dec 2019 13:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20191127231926.162437-1-heidifahim@google.com> <CAMVcs3vKjd8XVku8VUq2R-OKKSq-X2L=h4niFxuoPBe_D63JAA@mail.gmail.com>
In-Reply-To: <CAMVcs3vKjd8XVku8VUq2R-OKKSq-X2L=h4niFxuoPBe_D63JAA@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Sun, 1 Dec 2019 22:10:18 +0100
Message-ID: <CAEjAshrJy00VjDu3GY3gV6hu7J8PVcw=1jAeA_-GL02kvXTemQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: testing kunit: Bug fix in test_run_timeout function
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 28, 2019 at 12:58 AM Heidi Fahim <heidifahim@google.com> wrote:
>
> On Wed, Nov 27, 2019 at 3:19 PM Heidi Fahim <heidifahim@google.com> wrote:
> >
> > Assert in test_run_timeout was not updated with the build_dir argument
> > and caused the following error:
> > AssertionError: Expected call: run_kernel(timeout=3453)
> > Actual call: run_kernel(build_dir=None, timeout=3453)
> >
> > Needed to update kunit_tool_test to reflect this fix
> > https://lkml.org/lkml/2019/9/6/3
>
> Wrong url, here is the correct link to the fix that caused this bug:
> https://lkml.org/lkml/2019/9/6/351

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park

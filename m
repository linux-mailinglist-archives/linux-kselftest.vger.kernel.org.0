Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9509E10F80C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 07:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLCGsm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 01:48:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38429 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLCGsm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 01:48:42 -0500
Received: by mail-pj1-f67.google.com with SMTP id l4so1116358pjt.5
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 22:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrUEQpnhjssA5H4ckLx1/FL4yMnKDJVtL3vS1urgk3c=;
        b=OOLlVpJm+w4AJN2yx2hZrTcrZJ3k3sy8lSHYPpvN6XZ9ploTJEIEA7bBYCzbBRt7yG
         24G1DjY1sW2lu77gPUtsz6b0HFGxKaD2CDltSF7FiVg5kyy0WpmKqHSo2uS1s9Qa0ZRI
         6F+OaGm8aksg028LhkmscCBPzYA1s+22EsdOvkMPfszSgKbHt0vqHVyByeBT31r1L9eu
         6ESyJXHpUka2Uj7ErZ7hg0iKSOdeypmLfgKoQ5qMSCSX7+yiKAzJKerBv5kNPr/PYc42
         F+oP+an8sZM6y4mFx1/AKjeYQZ5kNyGFVTretLd/mhbZmPFF82g/Wmwt1fKOT6SONTVV
         kQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrUEQpnhjssA5H4ckLx1/FL4yMnKDJVtL3vS1urgk3c=;
        b=E8F2o0kEt1dL8wZLrhfkhEyf0lIKk7FoW7c1Iq37FzQT6ZClJ1AlkX0QqVa02J0tSv
         etpAD0PVyW2/DAvLy+q4YVlMP5sSztRlcl04kO1LPXZiNRw9yAyr4AW7GUbikYCUfg6b
         MHfQPRK0Y1Xic91u69/qt8EELFDPnUc7JW3aT1bdbvgS/eMqrwCKS2aRq7CqDDw3dUi6
         7HnfYkE+u0PZbzTPwhjZUKeCCuv+llpVLe9as9LXyOtBQwTKhSHFbUq+8lVoCQNcQ776
         6jYWHBpgRGZsAml3gACEivugwbPnQD+2otYmamZ2CjeviHxYxQqtw065OzIdGFV/h5hL
         4Bhg==
X-Gm-Message-State: APjAAAX28Ii1hzCViWJADY+8BQt6BqrcIr8KSXJ7gj9PhEe9AkMjO8YA
        GHkCdHBWKZ4CbniK9VFrIxetng4dTZgaK5/Mj3x25w==
X-Google-Smtp-Source: APXvYqxg5MdII+ViMW9PQ/XsBs5+SO2UZbHgYTN/T+GWkJaALLpc5gamk8VhBLGEjzYRqnWtES6UF8zeBKnnFHqZ+9E=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr3467227plq.325.1575355720790;
 Mon, 02 Dec 2019 22:48:40 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-6-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-6-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 22:48:29 -0800
Message-ID: <CAFd5g46TH31RkdFk5L4OFsuMmOA9SKJG_-g5bkehP1Z4uugrGQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] kunit: Place 'test.log' under the 'build_dir'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> 'kunit' writes the 'test.log' under the kernel source directory even
> though a 'build_dir' option is given.  As users who use the option might
> expect the outputs to be placed under the specified directory, this
> commit modifies the logic to write the log file under the 'build_dir'.

Good idea!

>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

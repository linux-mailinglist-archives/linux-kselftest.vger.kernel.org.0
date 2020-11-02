Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAEA2A2F34
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKBQFd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 11:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKBQFb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1EC061A48
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Nov 2020 08:05:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a7so18082365lfk.9
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 08:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9U519WWw6TDZQ33OGLBJjsTVpJX0KjTb47DTCYLn51c=;
        b=XBV11D3hMt0/lfz9orFTgOOHlkoSQTctDbSg30moLGCdPgHOGNBT6FfCLaCAVj4WGa
         GhjwiMUe5h5n0Vn+tEGbS1TbCOIYAom6xf5QDMiiPS7g5zXqzBnsmmJ3l2IN489ApUv5
         k7cWGSbweRACd/yeHVpAPke8JH1ybfrvlMjFy6VaYUdHVc4lnjLUev7mJ01y71mXtQpQ
         2t670Gw5HTK1J4kDdJrS4wSKcDirN+bzET+JNUBw3+eHGYYQjwP4InUCC7MtoJtv9lQf
         FaBPFNc81s1hN8+Gb4+UHQxwj80ShQtGaNH70Wf/eus0CYugdc6oCSVQZ6R2quU62Ds9
         8REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9U519WWw6TDZQ33OGLBJjsTVpJX0KjTb47DTCYLn51c=;
        b=W+opMe47PK8irYJdV6Ku1hahWtTPznKjwMJgoblTTb1607obILnFARFSeVATNQhz2m
         /jI+7bpLRtHS9jeH9/8DsXL0Vx2Mb2fSEx6jkm6vGEoT5s1O7WqoXnjmcvO7C7n0/N+k
         RIszLFYUCth7Uo7jUm8DxIny36YcPOC9RppBvqouqcl2/zauj2IfjCMECatmMBCe3nIN
         dxBOzmi1h3uZS6Y/CIUHlsnLyLr23NxsJ8pPTNP/1VI/PdcI7WnBZ4W6/596DMX71GT+
         /aNZPYn6PpVV3jvBfaEyIg33HZ2kzfPWCJPQDLbS+4fov3aRNlKDGFVrXCs+p+MxMj7M
         4lRQ==
X-Gm-Message-State: AOAM532gLeuOrj8/Z/cRN+jDum6evFhdduPoK7nbOz9XwHIaux47+ERj
        qowuNJqJryJS7m/K4QXTv7/1kf1OJQd6MA8jJVq9Ig==
X-Google-Smtp-Source: ABdhPJxjYJNDcYkH0qMdTqpGns+/hG9ww0wj6ml3rzKOFmjcnOaTneJ5oikwOAMEMuPoUy/AsnwP0V3wKqrSsAp0hkQ=
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr2342827lfb.576.1604333129223;
 Mon, 02 Nov 2020 08:05:29 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 2 Nov 2020 17:05:02 +0100
Message-ID: <CAG48ez2A6o423ySWfdX7s3fzrMSVn1YLYk2EnE1dV0fgZQS45g@mail.gmail.com>
Subject: ASSERT_GE definition is backwards
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ASSERT_GE() is defined as:

/**
 * ASSERT_GE(expected, seen)
 *
 * @expected: expected value
 * @seen: measured value
 *
 * ASSERT_GE(expected, measured): expected >= measured
 */
#define ASSERT_GE(expected, seen) \
__EXPECT(expected, #expected, seen, #seen, >=, 1)

but that means that logically, if you want to write "assert that the
measured PID X is >= the expected value 0", you actually have to use
ASSERT_LE(0, X). That's really awkward. Normally you'd be talking
about how the seen value compares to the expected one, not the other
way around.

At the moment I see tests that are instead written like ASSERT_GE(X,
0), but then that means that the expected and seen values are the
wrong way around.

It might be good if someone could refactor the definitions of
ASSERT_GE and such to swap around which number is the expected and
which is the seen one.

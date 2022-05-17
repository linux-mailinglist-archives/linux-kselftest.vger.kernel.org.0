Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70352ACEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 22:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352698AbiEQUpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbiEQUpO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 16:45:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C1517D4
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 13:45:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so36914836ejd.9
        for <linux-kselftest@vger.kernel.org>; Tue, 17 May 2022 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSbaj6m8IruioDruqyoSFgzsLFTHdPcEb55nsCK4TWE=;
        b=gIJl50Eulc8Vsdg9AlkQITMqbdDAC+WLftF0jWbwTU2Ox6ZAesuN7rpCB0FMaRU0ku
         lJ4nDGxYlUcGBrMF0OBIcV7BVZ/6dQhxV8Y0AN9udmHCOs/hbsS8QNfTOzm42DOyD04B
         INwkuTN7sK2mchrwYyIFLcP6G7cfMdvJzdCsNO6DHF0vKZ31XkNnoK+uC/5SjLn6IjFW
         LYxNgm+TAwk3YHjlV0dMNF83/wQ0tz2C2XtfpIqEIso03Z3DCFpUgCW94yJNGTqJgJ1H
         adGsX1arLF1hk3vyAaddUCxOoag3FN3FPGl5vEZnxDkCBBx+fmhj7tk5jbSySPZDtWuo
         qm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSbaj6m8IruioDruqyoSFgzsLFTHdPcEb55nsCK4TWE=;
        b=VghMENEY9QU5R/kRYPebI/pBblXf/0pYU++xGrGHWCO5ypqiA6E7l6nUkRK9ThvqZW
         Y3+w0IX6jb07FpZP7wCTqFnBrMyzGcbaG0XVSmtEGNZSmvIBnvTa7G3fbEspBDU62ajt
         duGRwy3L22Byv38L2Yqo3xX0RX278i9hW48IET1q16a25I7OxnRTvoBkJHDQ23wJGJAQ
         FXtx1MMfHJNY9uEd1d7KuQfdYAW8R1eHJyQsyIbTmjxWn0tgW+M3gGfzJqhFQCTp3Dn/
         3dhbs2bVT42C854vkEOL1TwKetkI8LljPEGAma2is4nVslrZdhMlbNi8Y7Bjdw6lH0rV
         xDWQ==
X-Gm-Message-State: AOAM533Km5uGPi59dAOGEBemHSkACSK6pB0RmnsP0JP9sVBsYLG66i+r
        a8WBJnMfo5kfnDU0EG83MFhLGL8u7p8KpurohEMYbA==
X-Google-Smtp-Source: ABdhPJyUT7v/+bRMzp2NCjUfzxBgDqk4IrNgbSICl9zfGmBkyXaJdmW22wa6lYaF7OVZbcBIcBpg8Xk/VoVYzb5Je8E=
X-Received: by 2002:a17:907:1c89:b0:6f4:4089:8256 with SMTP id
 nb9-20020a1709071c8900b006f440898256mr20602107ejc.60.1652820311327; Tue, 17
 May 2022 13:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-1-davidgow@google.com>
In-Reply-To: <20220513083212.3537869-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 17 May 2022 16:45:00 -0400
Message-ID: <CAFd5g46dQ=q5UuXaoXwh32kjGoFi0m59L-frm6T5Xcwo81m0Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] panic: Taint kernel if tests are run
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 13, 2022 at 4:32 AM David Gow <davidgow@google.com> wrote:
>
> Most in-kernel tests (such as KUnit tests) are not supposed to run on
> production systems: they may do deliberately illegal things to trigger
> errors, and have security implications (for example, KUnit assertions
> will often deliberately leak kernel addresses).
>
> Add a new taint type, TAINT_TEST to signal that a test has been run.
> This will be printed as 'N' (originally for kuNit, as every other
> sensible letter was taken.)
>
> This should discourage people from running these tests on production
> systems, and to make it easier to tell if tests have been run
> accidentally (by loading the wrong configuration, etc.)
>
> Signed-off-by: David Gow <davidgow@google.com>

Aside from Luis' comment (which I agree with), this looks good. I am
not an expert on the taint mechanism, but this seems pretty
straightforward.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

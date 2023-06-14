Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237CC73092D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 22:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFNUct (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjFNUcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 16:32:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997712132
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:32:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bce1d7a8d2aso1153078276.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774742; x=1689366742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=G7nM3HJOnTFO/r9nAs3VZ8ncUNpyRX/dBLh4cUcJcmbenazk6RT3d0BY4kl05VgC7M
         hNG3l1eFIHZy0gEKps3DT5vySPcxIostlF906zTm9a6QCda+Q5I9tcCdRY8YWvhUYCUW
         lsOxSdJQJNcHDnkCz4F10A5UyoXfstoJTMP4CDGufudVQ0bYtp3EOIDQWs1ea1W8e2lO
         QIxDHcHSEKPBkMjJd96eewXi0JWcq53nWPUQ5+57RZZSBUkQyIVjvR1yEgLxFtsud9z1
         bS9oAGiiTJRrGkQXaK5TaTs/QZsSEcsG9PMfGSVuk52YwGs5GnAvb4usttTNRyYt2s4Y
         0hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774742; x=1689366742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=i3hLAIUGZI3H24YN0oekMLs+6c8ttixUEEPtztv3+jLSvVupGnZ0v5hPgTgQFm8U7C
         JKi/DNbXeAPisiU5Nk8l80MfU2Dxy2xLIbIJ8f5u11mcX+v7zq7Ikx6UU4sqzQy2GnCG
         S2wZOh1Xa4Ntbl1RZAVBUhiaG3GXfltp24TU9V+dVKlh1lSZKISCWAZRLtlCpWxH0H7F
         6Uab+8lhjeJJQW8iLvFdHaFtlT+WFnb0NkJQav7YS0eXGYt+73q9lVzcb0eQXb3GZ+E/
         JvoXBz4j7ViNSETbSvRjl+OgrCTcGy/Dh0pnMkXMYONiJ85AhnWa6v0aTNTej0GQr9/y
         cP/g==
X-Gm-Message-State: AC+VfDwEG3eW6mxT6Y5eQvR3uJZXYD5rW8EE+SVUXZDt6mqiNaWMxtjf
        h1ozH+k67O4FQHfaSBbq+V6rcRloAf4+bO8=
X-Google-Smtp-Source: ACHHUZ7nhMzTUUAXeFrCWZk+JOE1hhfH3uptvV1wMpqo0Q8CgtIthBnY4QgsVNVwEM46C0usmP5m88ATIWqIRW0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a5b:d42:0:b0:ba1:d0:7f7c with SMTP id
 f2-20020a5b0d42000000b00ba100d07f7cmr460247ybr.2.1686774741924; Wed, 14 Jun
 2023 13:32:21 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:32:19 +0000
In-Reply-To: <20230614180837.630180-3-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230614180837.630180-3-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614203219.2909087-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/6] rust: str: make doctests compilable/testable
From:   Alice Ryhl <aliceryhl@google.com>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brendan.higgins@linux.dev,
        davidgow@google.com, gary@garyguo.net, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        nmi@metaspace.dk, patches@lists.linux.dev, philip.li@intel.com,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:
> Rust documentation tests are going to be build/run-tested
> with the KUnit integration added in a future patch, thus
> update them to make them compilable/testable so that we
> may start enforcing it.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


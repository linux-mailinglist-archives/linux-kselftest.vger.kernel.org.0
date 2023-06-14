Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512BA730930
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjFNUcv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjFNUc0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 16:32:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBA2132
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:32:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bce829aca1bso1240164276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774744; x=1689366744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=rqUNnuSZmxyZA+3FLRLmQGXXAuPP+K6OhcSMkEMWjmz/+X0E9WWAWceF6qaPJbCEf/
         +LcOMoxwadWXOKYaeGEP5rRGpXeZIo2Ksngu9HPwa+EZT5o3QpyOEXoCV4P6jyxRyf4z
         yWVmZv74htbg2qR4hiKLnGjDsjcl3vWgVEkG1DzdRTsfbNLSgOcTuO26AXNwqwdXtcOA
         UeAJLb8lLD0tGurvvkXdA0mc9wvIPjhd6tj4jtVcOfnRz2vdzx++nU84LteJJPgzAW96
         UR/fgVmwczusNfVrjQz9DGIvzbZpSABZQs7RTDWi/j6hWmRIFZ6+FWkU5QfTKYLLs45R
         1Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774744; x=1689366744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=i1pL4NtBFUjyB7VkfnhEo8s5At/NlMk4KTho7Q0+rrLTlhXWpfGf8T/e7AwbySJjkv
         fNhqFn/TTw6FgZy0e2sFrgWQcwhK5PqzgcGbSmmG9Z6uxPX8ixYnWFYgNBDVaMHdtmT9
         oKqw1QIoII5db/jASYyI+Ay7PcdMvKZTHY4tFng1mlGxMqBptouaTkL885YazAlx/LLK
         K+3hx4v15mYbfoXuG6F5V6TNXfdQrdDREikSi2ZAjpEOvatT/wheCAYtCg87STo3CISJ
         D2epLLmGIv+jJL8ojL1uRU2zhW+02xEb6SRwn5UqZX5RYNyssKdCEc7YQWVsxcqIpNFx
         8NVQ==
X-Gm-Message-State: AC+VfDzcHuMoljNr6gb7l0jMKCa5Jf6Zdvxe3GcnfC7ouxaFv1dIHG7p
        Gwtl5Nz5YNSaUo3TBCe58ekRYUQwgDEytOw=
X-Google-Smtp-Source: ACHHUZ4lKrCgpFpHSKe1jrlgkrwHsdQtUzGMLfno8/6282W4EFvNEysptvz1ncztZ8ndlqxGsU2He2vAPn/OwjA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:5087:0:b0:bc5:9faa:24d4 with SMTP id
 e129-20020a255087000000b00bc59faa24d4mr482042ybb.11.1686774744749; Wed, 14
 Jun 2023 13:32:24 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:32:22 +0000
In-Reply-To: <20230614180837.630180-4-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230614180837.630180-4-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614203222.2909418-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/6] rust: sync: make doctests compilable/testable
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


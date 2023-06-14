Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05F773092F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 22:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjFNUcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 16:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjFNUca (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 16:32:30 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0492137
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:32:28 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-977e50b0120so104133666b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774747; x=1689366747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=xTtVN4Z1Q88g5rTsccodRHtuT93zYjcUCBrJT95LZIYNDADStxnQxZyTD2EJ2BW+EQ
         gG9WCiqzycuFhB6BgXwWMlIppjT0CNI8UMkUsdxitpwlvLRaBXOIX+CaKxN3iL8IawY+
         4esEjsAM7hRAtYvRzMgVmR9vSolLSnj+kPwM1wlEcomxT4tuscwRvYZ30cqXIjRZ7AFw
         wpfkcDaqNEGH5bwnGlHbj6F5zl51FHU2M19UQIGZSAKRHHsbwNEwK/7ilANmFsnAOzJU
         vDutlW9DFkMHsGVZF254iPq8SURQag7SygVMF8UeUTIN8cRHVAUiAvVUpGHKMl83Fcch
         heGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774747; x=1689366747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=YtJzffO4ir1yxO0tq1Vv9DYqtwawya9TaVhMDcZLASdSLGl0P4EebtwlYpxlzBT5On
         Zu0/tEx4M+4ykueVsi1cvLXE/Z/K/ndVbrdb1KjZymmXP0IP+2q+8/YHRKnacZL7H8tL
         OE0kCQ3aOSBmy3iEo4LN1wHWDtM3oX60XKXOXrQUGUGaHnV8GgGy2sRCQUawpClzyOPG
         dyhmca6PIMunXX8TYRuZNy7+Fhy9z78GzaWp2QBVPgSCo8+bjcwbmSqdzLF/bPvfp8/i
         LhBvn4RGr5PMpLUejP7ozE3Ee8KvwC0qqpWnt9VOX1VBp3GMRan4X+yuybS/iUlrOzXD
         6vwA==
X-Gm-Message-State: AC+VfDy28e6es4hduBHVf3kVJ+0ih9AP2ChNiK9RpeL/XF69vrYCQFwA
        qbEOo06zOxi79BhChi2uimv/FZ43BfO7hN8=
X-Google-Smtp-Source: ACHHUZ6QRTP5WMGlZF6ouKyzQXFEVXAvPfgRaI2C78nvnu3bQtIOBOvXIr1gBV+MPRyzc5u+ThXTy0T5ROzw65g=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2bf0:b0:982:9e1c:ddc5 with SMTP
 id gv48-20020a1709072bf000b009829e1cddc5mr8045ejc.0.1686774747408; Wed, 14
 Jun 2023 13:32:27 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:32:25 +0000
In-Reply-To: <20230614180837.630180-5-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230614180837.630180-5-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614203225.2909756-1-aliceryhl@google.com>
Subject: Re: [PATCH 4/6] rust: types: make doctests compilable/testable
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


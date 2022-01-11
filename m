Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AC448BADE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 23:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbiAKWmV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 17:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346539AbiAKWmV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 17:42:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338BC06173F
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 14:42:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso8188079pje.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jan 2022 14:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwqBNYhhx4LE2Q00Aa+qVN3GUI2qvxluJTLGPSUcyrY=;
        b=dk1c69wDz94cB+AtBa6EngbMy8gi4wtrEwYbwANuRyE43zZLaH36pEPqFpPJ6xMoOB
         0yw/6glpIgoVNDtgetOp4iCCaYXUU1ex4vE5IrpnCUcW4ZhWfRytw+dRSqODEHZg/drE
         I0gY80Ee/kiDJ+uC2yjWdne2XThUzw8H2gjky/X0IYPdZWqBYj+BlzZtDpAwk86f7+Fl
         Pk4VCWS1+Kzp8YlkXYbcsyl/0Gk2oW99RsPE4REneZtX5lbL0GGbgjl5nHVm22PDig1u
         USBA7lSvf/AoLYulAxUT7JdASHMJS7M6YV4CXFuqbes36/dzqBC/5+88LAWjZ10RYcpg
         yMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwqBNYhhx4LE2Q00Aa+qVN3GUI2qvxluJTLGPSUcyrY=;
        b=pmgUVRkor2iWpDIJL02bLn24PsNY0wJj3S+in94WehfOunXwBsmarWzNiZXuGBY4sp
         G6WltiP+nCYeveeo+qGQHskBYrfqsm/jrf91LpEOnPUSWRureAQdczf3fEjyEIJQ257z
         qtkkd2CbQoGtevTJ6PV9ZadI1g9uZz2V2t/RMBEsb+DIe6dp6I/LRzT0Dg2xj4t3eG8i
         ZQ5zI3bo80RDJL7ZlNwVNlOIeM7l5T8zHpUmJx1Hx0eyTuYvvZV2Yl6h+/z8BAkG2f2s
         CPBiSouJuihqxhsRmf7RQ3C2hcBaomDU8YqcKwPURFXQK4+apT6VHBTiceLXfmUGluVp
         Ag6w==
X-Gm-Message-State: AOAM533uqmR6XIjyRvWPnaeeFy1QD+KY+M/aRHudAZjxYhpH9mDDslOI
        OEgiMGJreYYl3JYEVc6eLRM0Wf9YcJkiyCjWT2wwaQ==
X-Google-Smtp-Source: ABdhPJwCPWZ1hi/U13Gu4RKBQPDXeV2RrfcrRKri5cqEHFmAq4J88AI+Gs5lqvMdaWYCb0ndPk3liRfCrky6Vnx27fM=
X-Received: by 2002:a17:902:8601:b0:149:ee23:890a with SMTP id
 f1-20020a170902860100b00149ee23890amr6361943plo.12.1641940940584; Tue, 11 Jan
 2022 14:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20220111194231.1797841-1-dlatypov@google.com> <20220111194231.1797841-7-dlatypov@google.com>
In-Reply-To: <20220111194231.1797841-7-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Jan 2022 17:42:09 -0500
Message-ID: <CAFd5g47LdAp2xn4GsRBz7RCqQq-6NZO-ESNNFL_AKasG1D7ARg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] kunit: drop unused assert_type from kunit_assert
 and clean up macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 11, 2022 at 2:42 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> This field has been split out from kunit_assert to make the struct less
> heavy along with the filename and line number.
>
> This change drops the assert_type field and cleans up all the macros
> that were plumbing assert_type into kunit_assert.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

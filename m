Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84025F1E80
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 20:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJASAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJASA2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 14:00:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702152E6A3
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Oct 2022 11:00:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nb11so14962490ejc.5
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Oct 2022 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Bl8Fuk+Wt6jUa3TDAfDFoX2FZNxP/enu0dcwtqyz7lQ=;
        b=LAj5/wYQW+g7G7cWNCyQVaM3sPZr0O2loM1xXLc+9xxzUaEv0/SdAs9iD6pKeeBlsX
         HY0/31eFDPMgBbu17vb4RYs/su95HpSw74OsbElWNGqYYUd/3iaAInVMtLDnJHLs5wdi
         LNtufLCX9onmC6fjaU/xXTes7LBClEkU0Ulwxwl6PLC2l+y6zfXyaoGHryJsuCOFKqq0
         UukvuDKN+aKLr4tTk8rfN1O1BXKc/kl16qUMZ5+GnLL/sHDHIVEJaT2lViDlmET25LfN
         wuIKa/+Tq/fwq5wjlYxfyaqU9+JKZhQyJIF0vQWwCRl6SdPc2O8jA0IYNdl++fO2bFdr
         McQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Bl8Fuk+Wt6jUa3TDAfDFoX2FZNxP/enu0dcwtqyz7lQ=;
        b=J7Bobyr0b55AD0bgfRHjTsut3QXi/0g8MfIikay8HHGs8L8ma13FUrse1722bfAfUx
         pfxBFgYSb4MjgId2P0tiSaNkL/bWACoZwqyiZGiHD0Xj1d1/s3ebUuIHA2UpIHzSNnsK
         i3m00bGZg0MM2hlHNSUJkdJRe+OtBdpf+dqdNHhoAaR5WbmvMUaoiCUlW5gwoSUyEN8l
         YqI8IcBIvuKMlfC3SaaDaoj2l2LniQNfaXkQiZAAuzCEm6CnHIMnFC6S7t8KD3DX5822
         2kzGrQABTGXwypZGXWCL0XvOzOnFBbUiCx4k+iZQ1kxL/9BluK7MYuw+Yrfr6v0yohgC
         2P8g==
X-Gm-Message-State: ACrzQf2irWA1eC3VYg5ECEV6cZcFfbPCPOMu8tJTgNqFEniWl3+0JxPV
        1YVc9kLzBm0RHzQSTBjTNL+6HC/mjLsOoTmXdW84Xg==
X-Google-Smtp-Source: AMsMyM60dQdVmC4T15XjDaLbKD9eQkJk3OfvjwVfPIshLbNkxnQ01b7b4S8g/loPaU1LNZC6nkoDqVPw9ouObY8wPNs=
X-Received: by 2002:a17:906:5a4d:b0:76f:bb35:48f4 with SMTP id
 my13-20020a1709065a4d00b0076fbb3548f4mr9940776ejc.686.1664647225890; Sat, 01
 Oct 2022 11:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221001002638.2881842-1-dlatypov@google.com> <CANiq72nU-eDOT94q26dTVgCFA_Hs1cGiLpDCmQ5n-cCVKAcsqQ@mail.gmail.com>
In-Reply-To: <CANiq72nU-eDOT94q26dTVgCFA_Hs1cGiLpDCmQ5n-cCVKAcsqQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 1 Oct 2022 11:00:14 -0700
Message-ID: <CAGS_qxqVUmjxULZ_Kt-gWRJb=+EYpG2_K89sQTq0BYbUighn5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] kunit: more assertion reworking
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Oct 1, 2022 at 3:15 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 1, 2022 at 2:26 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Note: this does change the function signature of
> > kunit_do_failed_assertion, so we'd need to update the rust wrapper in
> > https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs,
> > but hopefully it's just a simple change, e.g. maybe just like:
>
> Yeah, should be simple. Thanks for pointing it out!
>
> The series looks like a great cleanup on top of the stack reduction.

Thanks for taking a look at the rest of the series as well.

While I have you here, any thoughts on how to coordinate the change?
I made the breaking change patch#1 so it should be easier to pull out.

One option I was thinking was:
* wait till this lands in Shuah's tree
* I create a Github PR that contains patch#1 + a patch for kunit.rs

I was not clear on how the RfL Github pulls in upstream changes or how often.
But my assumption is patch#1 would fall away naturally if rebasing
onto 6.1 (and maybe we can squash the kunit.rs change).

Thanks,
Daniel

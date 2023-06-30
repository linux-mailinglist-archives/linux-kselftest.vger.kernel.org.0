Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421674420E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjF3SSF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjF3SSE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 14:18:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0AE3AA7;
        Fri, 30 Jun 2023 11:18:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9926623e367so253298466b.0;
        Fri, 30 Jun 2023 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688149081; x=1690741081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqvAUyb2tsPBhVSd0pIEgVQNyRCdhhmwRegA/E/fvz0=;
        b=duN6wGf0bxxTJFbCNwVHPjr7piWFkTJPQZgv1afCEzKQwDw2lMrEF4OAbr2HfhaUYO
         jh1l0QSgxaxHS98eIs1HPD6HdKQIHWxS+07MIZxUX/1iFNd9QHrzRh2dAeD6EGhY48/a
         lDu1N5z37d2hHaPoFA9FAzXklnk7gw/2jVeZKpiHZ/UsT8NYih5egxqa1LM46oK2CRn2
         0yquiQaU1DnmIP6JZXLb1G6mjm7s/1amNXQGGLuWXC+75LdLsQFlwtUbJfV2X3Qnoo1d
         fogyq6pGmOxyC3U8EdekDn4KS7hP0zlhLulQVu1kqHoExtNaH+fbsskVmMt+BExs4div
         KoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149081; x=1690741081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqvAUyb2tsPBhVSd0pIEgVQNyRCdhhmwRegA/E/fvz0=;
        b=fdkjAAs4J6U3yq9k/8nv67NlOpMY7rTDK+qgvyNupqgNl1KcJCL/Oybk0my5DfCO3g
         8/Pvm72guToAcdqVSa80UIGYaeW6WFHCSNNiQUAR5gs8mRhLqFWmmpfbxxu20lppEsux
         xHTSR2+4P8GM2bkEKxL48LxECupDpqrJRVBpNRz1+aHjtqFRLrYCedXvOXQqV39ERFz0
         b7D42V7bLzCg0oE70s7oISWF7PpuicE/sIkGUM+BT1hII2NozsRsBPB9Gy2mDN+zyYm+
         q2zWYVOV8au0Ep2gEYA7ICo7a59/PFrj+GxYHBbAXPJvUhofGUeEUSqCRYehfsFa6oVk
         x+Jg==
X-Gm-Message-State: ABy/qLZdTuT+F7hHcai98N52+5ArHDgfTIBthAV9teEXTlMGhz4rjyLi
        FWgq6K0Le4JxeKvJS4h6pn4=
X-Google-Smtp-Source: APBJJlGtB9G3yRkfYsVLgiguvw7i3+UIzHgYg4xyjSXgx8V5csjh4PZAF8vuBRPuGUQixHBPlWhhBw==
X-Received: by 2002:a17:906:4e52:b0:992:9a5e:3172 with SMTP id g18-20020a1709064e5200b009929a5e3172mr2089125ejw.59.1688149080879;
        Fri, 30 Jun 2023 11:18:00 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b0098d0c01d9aasm8319773ejb.87.2023.06.30.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:18:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 86A5827C0071;
        Fri, 30 Jun 2023 14:17:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Jun 2023 14:17:57 -0400
X-ME-Sender: <xms:UhyfZPpQEaPpLULou0AlaB4w_kc4Q7a46gTT5jxcRJL35CRGbSfX8g>
    <xme:UhyfZJoyjreAsALv6A2JpNpR_k8e-9_TTRzs-VxgVK6vKLq47Mcygqlp6yITzf4cQ
    S1nuiAR__7Tsg9wPw>
X-ME-Received: <xmr:UhyfZMM_WhLpbSVNgrmF8VPFBle0Ke85DhZgCeB4hOzXVUSMXKrCYp95unU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:UhyfZC7EXQzf2J3GAyTRcHrj79MN_2U5H9y4l00GrjaFJYmWjmdgkw>
    <xmx:UhyfZO6f2XwVe1s6RCy-O24q5gpuG9Rr7dpuyl8ocrgN3OmSC5sI2w>
    <xmx:UhyfZKiIpwLmYeD3v-UymYYio3cXox6chlW8RfnExEa2jCzS8blciw>
    <xmx:VRyfZBr4Luyc2-jW86YWefXHSznNUKPv1jnDUt6VTJq0d02fDbD1Ug>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 14:17:53 -0400 (EDT)
Date:   Fri, 30 Jun 2023 11:17:25 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
Message-ID: <ZJ8cNUW3oR2p+gL1@boqun-archlinux>
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-6-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614180837.630180-6-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 14, 2023 at 08:08:29PM +0200, Miguel Ojeda wrote:
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bb594da56137..49a5e1a4f0ae 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -18,6 +18,7 @@
>   * accidentally exposed.
>   */
>  
> +#include <kunit/test-bug.h>

When CONFIG_KUNIT=n, the above file is mostly just a function that
returns "NULL", however, since "NULL" is not defined: kunit/test-bug.h
includes nothing if CONFIG_KUNIT=n, bindgen is not happy about it:

  ./include/kunit/test-bug.h:63:67: error: use of undeclared identifier 'NULL'

, we can fix this in Rust side by adding linux/stddef.h before
kunit/test-bug.h as below, but maybe it's better fixed inside
kunit/test-bug.h?

Regards,
Boqun

-------------------------------->8
diff --git a/rust/helpers.c b/rust/helpers.c
index 49a5e1a4f0ae..048d11c7d796 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -18,6 +18,7 @@
  * accidentally exposed.
  */
 
+#include <linux/stddef.h>
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>

>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
>  #include <linux/err.h>
> @@ -135,6 +136,12 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +struct kunit *rust_helper_kunit_get_current_test(void)
> +{
> +	return kunit_get_current_test();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust

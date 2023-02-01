Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157B686B03
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Feb 2023 17:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjBAQAO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Feb 2023 11:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAQAK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Feb 2023 11:00:10 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AFC2137
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 08:00:08 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5063029246dso251809817b3.6
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Feb 2023 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WhQ1Ee4LLK1kS+iLl0ypqNTcaPW0swiiMAeM4qNO1x0=;
        b=ZuJ6hfKixfCR8eRtPorkBH+0LBGtz2T01ts/KGzMJgVgZdeT+2RaoLi+/gD4/aIHrE
         grNdiJG2U4UyNgy5nZ6QlEI+wcjygwuWEypAH3UNixt+sBtOYaHNWq8hvrD4WjoSesCt
         wBB4t2iSY+QymEd4EGTfXs1oKwOZnJE89QP+ThYqKEGhC0daIpl80BLdwzeLLZsyPzLT
         bWm5yef8G/kzfGSBLAkzZzyrTcGeRkhvNIGUDKyfyQBSw3jFibu7bo3hi9d5sg/Nbcd2
         wBVDUyQOnoPjUeQHvJJ+TJi6f59TPdbmUyZ2sMn1y8+4YmcxnpPzEIx9ObqLTNo3gA56
         qpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhQ1Ee4LLK1kS+iLl0ypqNTcaPW0swiiMAeM4qNO1x0=;
        b=PdtxG8wss5BGEVMHIpYHYhqgjr6DzWNpj1sa/fVKyc50B7oEFKjjiYVR6OLkD85NDb
         pfQxOuXQ6txh4UgreQ9MS4Sv5938udjDWNlI039FVLBUnyIjG7hWFc9eV2tjnVSbuzHB
         2GfnbGqVRN0AQt4z+FMnoma9KIFQHQxcgUvt82+Vfe8UmmAn2hwiwKX1sBSqBS5TbafW
         YfG2M8IlRO8ziSTxiD5QMlvX9FabM9ZTRBHjuatyFOl/5qXe3uGt4x9RC10Glr7LgoBz
         XebvtyKIzEj+QbDA0JzVagfBw+bbZU5X0NDemQ+9HbvzmF/yay21Igh1L7cDaWC8NGIU
         B81g==
X-Gm-Message-State: AO0yUKVboayc7cyNT8iWatWKwBo6OU+xHaNbi0yTJLRkBu6rkVkNKUq8
        mxAQ7ApdRgYJe/OcLRR0sus8Is1A+vr/1VkEqb6lPw==
X-Google-Smtp-Source: AK7set8VLqG28iKN+AIlAC7bpaZD8Nv0jXcErIJZStDGyHs3T/Ubbv5KszE/fNkUhDBcyR81IeQGtsQq6UskLEyruDM=
X-Received: by 2002:a05:690c:446:b0:506:3acd:e022 with SMTP id
 bj6-20020a05690c044600b005063acde022mr246450ywb.228.1675267207966; Wed, 01
 Feb 2023 08:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20230201054522.162611-1-shahuang@redhat.com>
In-Reply-To: <20230201054522.162611-1-shahuang@redhat.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 1 Feb 2023 08:00:00 -0800
Message-ID: <CAHVum0eH_XrrPiviYYWEu=FouhEXeWq1mcx0=BoiF8NaoyVj_g@mail.gmail.com>
Subject: Re: [PATCH] selftests: KVM: Replace optarg with arg in guest_modes_cmdline
To:     shahuang@redhat.com
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 31, 2023 at 9:46 PM <shahuang@redhat.com> wrote:
>
> From: Shaoqin Huang <shahuang@redhat.com>
>
> The parameter arg in guest_modes_cmdline not being used now, and the
> optarg should be replaced with arg in guest_modes_cmdline.
>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/guest_modes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
> index 99a575bbbc52..1f2dca4520ab 100644
> --- a/tools/testing/selftests/kvm/lib/guest_modes.c
> +++ b/tools/testing/selftests/kvm/lib/guest_modes.c
> @@ -127,7 +127,7 @@ void guest_modes_cmdline(const char *arg)
>                 mode_selected = true;
>         }
>
> -       mode = strtoul(optarg, NULL, 10);
> +       mode = strtoul(arg, NULL, 10);

While you are at it, can you also change strtoul to atoi_non_negative()?

An underflow negative number will print an error message with a wrong
positive guest mode ID not passed by the user.

>         TEST_ASSERT(mode < NUM_VM_MODES, "Guest mode ID %d too big", mode);
>         guest_modes[mode].enabled = true;
>  }
> --
> 2.39.0
>

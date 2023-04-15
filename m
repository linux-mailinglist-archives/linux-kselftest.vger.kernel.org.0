Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F186E2EC3
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 05:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDODYO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 23:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDODYM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 23:24:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B84C3C;
        Fri, 14 Apr 2023 20:24:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id fw22-20020a17090b129600b00247255b2f40so6608698pjb.1;
        Fri, 14 Apr 2023 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681529051; x=1684121051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNu94NMQ9GzAL+Jkh37nSsTNhTljtl3TXqyNQLLmIlA=;
        b=gBOEzXcpc3N8u612RDt2T+UAxswu/9qsTeAFMEE92vl3q7GGWsz7C9Weah0pfMmtJv
         U4bsnRLxmZl1x0KyTuZcXGtIZ+WvjcM3Gbjn/NwpScQgKmpmurUX2mASZ6nD9jP3TdU7
         fDZ+AdeTMa97PU3R79YevKvaj7ml33u5CoK33GfgBtXVSoG7mnWJS2jiHbJYP22OrBXg
         ehyT1xgCyJbh2x76n7PB4iz8+UtnO7v6/bXEUE+mVAn9g+KkQWlfwzF+AkCqk7hNiq1I
         qErHOBfqbAD0e+VQWU04dEl58eLSkxCEHbt8W/InjBfh8zcEN9vMs7BUPaXahXVOYWNM
         WrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681529051; x=1684121051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNu94NMQ9GzAL+Jkh37nSsTNhTljtl3TXqyNQLLmIlA=;
        b=avdfb7/5xZp2yCKJLg1UUIrj+8CGoLCZ+/b9MokmMtJzmWRx/1/TTttKcufEO/BpHO
         4LuTuNJtns4f6DyirF0bzNtnTrUC5M6pjvvPBn+77peqi4JnLN+lJVBg6A5AeS1VkblI
         ZrAKHZMzqgYCdPNWYv2dIOKB7ranS5Sf0akk1ODp9yhCuDnFcb4fvhIdAPN/9FjI8zxa
         BgoumJoKXGkdjWDBz/8QgDjGt5AIVBQQRHy5RP70B8YTX6P9DD7EIVX6K9l6bZvSMDkG
         zntzzH3lWbJJ2jPbzd5OeZSf5Yl+tpsxvlWYjieZOEphVHGMTp8GLLJ0y7V3dLyjqxsr
         fAyQ==
X-Gm-Message-State: AAQBX9f3taFv+dlJOCTWnH9TDAO0qMjMHV2c4WeybH31QyFUAWsW7dY0
        B7gjSss1Er0okYcooKU6VIE=
X-Google-Smtp-Source: AKy350ZNOpTIV/cBRWGo0NPV4VfQVAkM+q4dx1s4qoFTG25nPW6JaCuowr4Pf17IV8cncLbpIJY9jQ==
X-Received: by 2002:a17:90a:ba13:b0:247:160d:3a8e with SMTP id s19-20020a17090aba1300b00247160d3a8emr7894574pjr.22.1681529051023;
        Fri, 14 Apr 2023 20:24:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-65.three.co.id. [180.214.233.65])
        by smtp.gmail.com with ESMTPSA id oa4-20020a17090b1bc400b002469a865810sm5331106pjb.28.2023.04.14.20.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 20:24:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1EB9D106677; Sat, 15 Apr 2023 10:24:06 +0700 (WIB)
Date:   Sat, 15 Apr 2023 10:24:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] KVM: x86/pmu: Add documentation for fixed ctr on PMU
 filter
Message-ID: <ZDoY1hOJfMwJk1SQ@debian.me>
References: <20230414110056.19665-1-cloudliang@tencent.com>
 <20230414110056.19665-5-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414110056.19665-5-cloudliang@tencent.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 14, 2023 at 07:00:53PM +0800, Jinrong Liang wrote:
> +Specifically, KVM follows the following pseudo-code when determining whether to
> +allow the guest FixCtr[i] to count its pre-defined fixed event:
> +
> +  FixCtr[i]_is_allowed = (action == ALLOW) && (bitmap & BIT(i)) ||
> +    (action == DENY) && !(bitmap & BIT(i));
> +  FixCtr[i]_is_denied = !FixCtr[i]_is_allowed;
> +

As kernel test robot has reported [1], you need to wrap the code above
in a code block:

---- >8 ----
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 036f5b1a39aff8..b5836767e0e76d 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5126,7 +5126,7 @@ Via this API, KVM userspace can also control the behavior of the VM's fixed
 counters (if any) by configuring the "action" and "fixed_counter_bitmap" fields.
 
 Specifically, KVM follows the following pseudo-code when determining whether to
-allow the guest FixCtr[i] to count its pre-defined fixed event:
+allow the guest FixCtr[i] to count its pre-defined fixed event::
 
   FixCtr[i]_is_allowed = (action == ALLOW) && (bitmap & BIT(i)) ||
     (action == DENY) && !(bitmap & BIT(i));

Thanks.

[1]: https://lore.kernel.org/linux-doc/202304150850.rx4UDDsB-lkp@intel.com/

-- 
An old man doll... just what I always wanted! - Clara

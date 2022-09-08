Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8E5B29C1
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIHW6k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIHW6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:58:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B8F326D6
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Sep 2022 15:57:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso3753087pjk.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Sep 2022 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/UkehsXQHuR4Idp4x5z8yZPfpovB5B00gX0cZoxw3sE=;
        b=JFvI+LBe3owau6mC8Hz2QOh23QeexiSC39e4tw2Z1hpnN/sR+ZM2Kv4IbYWTkOADmZ
         PUdGVuiSHsU8ngaqvH1VvONQidNiXcSKaI60RTqrzsTEDcSIMfZjjsOchRtQi65RkkTc
         RbiwviSZSb7qeCkWe+Hd9x7Keh1oSYFYeLRRDYDyWSLJ89hC6c7ulvfaI48q3ZIqyKiT
         5SIysznhIUMJme4VSYyJitjDc+prT2A5qdlNkkujeb/PR04WOhN6ueR5j0awqRYhPqmL
         pRJYcHSTtA8Kf4Zse7r34GsjUNJeq/8n3GnSnolTvUqZfE9TVVzFL7MCKD4dzR+N/1pj
         AyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/UkehsXQHuR4Idp4x5z8yZPfpovB5B00gX0cZoxw3sE=;
        b=B2i7DpAKATOs7N5C+hvKHt2jz1QavpKVwxy1Xx5mIWaOb5G8xJraLzRVaHMmCtk7mV
         Dz2InQie9TvxN0ObNd6NFVQdN3ZmSlgf2J+rA7+AwZx3TqEGUXUOmPE2u51E5jUHG4aB
         jirClKl60lNO/6OPnJJ3hHCnGwEV62wDiVEGtqz1TQRObq3JTSFF8mlYT/sZwrhwNXbw
         Z/Bh5CGctm+PnM1CjrKI1wMvYXbF3UNaI99heOv6fg2hRD9VO6c+6o4tpLeGZKiz3tMP
         xqZTHRU5nLtzpAXqBcHmUG0kLRfLOyiQ4C25sCA6a90bg/bQkFk9f913/5BccFSWw4HK
         qYOw==
X-Gm-Message-State: ACgBeo0cV44wTxiLJMrirqP+AmOzljnm00lrBDP6fWdwgjIHSRzNlQT4
        rHf9xKnYoHFKzoGIfiw0npHWCQ==
X-Google-Smtp-Source: AA6agR7KtwQ1kgqa9eVdvNOQiZbjLUejfBGPF5svnseUZ/OpS3g1QYPHiKXHFrc2rnPT+VfdLDmx4g==
X-Received: by 2002:a17:902:d4c9:b0:176:e833:4efe with SMTP id o9-20020a170902d4c900b00176e8334efemr10497775plg.108.1662677852858;
        Thu, 08 Sep 2022 15:57:32 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902a41200b001750361f430sm45085plq.155.2022.09.08.15.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 15:57:31 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:57:27 -0700
From:   David Matlack <dmatlack@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, seanjc@google.com,
        oupton@google.com, peterx@redhat.com, vkuznets@redhat.com,
        drjones@redhat.com
Subject: Re: [V1 PATCH 3/5] selftests: kvm: x86: Execute vmcall/vmmcall
 according to CPU type
Message-ID: <YxpzV1Ir15n41gGK@google.com>
References: <20220903012849.938069-1-vannapurve@google.com>
 <20220903012849.938069-4-vannapurve@google.com>
 <YxpysbHZb2G56K+f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxpysbHZb2G56K+f@google.com>
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

On Thu, Sep 08, 2022 at 03:54:41PM -0700, David Matlack wrote:
> Please use "KVM: selftest: ..." for the shortlog.

Doh. "KVM: selftests: ..."

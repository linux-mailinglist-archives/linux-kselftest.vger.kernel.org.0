Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B814176D953
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 23:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHBVSz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjHBVSy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 17:18:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BCC2137
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Aug 2023 14:18:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d326cb4c97fso233296276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Aug 2023 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691011133; x=1691615933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy83P9oplZVK/HLt8eR0veDAizYsIGOwrmQzznNbk3Y=;
        b=KgkO2geO/ZBk5bazDydQOW2OA+ObGf/KDuyZJJ7rUjfiWg3T08mM/WJu1y6PwiFDRY
         0yYKAnyGSUXmM0tjj6HVMqoLanZK3nzMQhh3g4oynVg0VE/3i7G0VNoNdvQMRE5J4NIR
         ThY/dsHhLSF3qu2yWvJPJtXBXJe8lZG2ghj6tyLMc0xGLpa+fB73cPOTcXkUb/kJKLZq
         cG3zxBw15KkxT/cWrNVzufXq2znM8KjG0AbKwT4RFHTxBijU7evo+3VAlHV6MdXksJQR
         NI/2KTpytLU1+LfojoHyySd3Gemo38aqusVLCnx54BLJwMnbyVbfq2OXGSkIjHTec1iQ
         utmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691011133; x=1691615933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy83P9oplZVK/HLt8eR0veDAizYsIGOwrmQzznNbk3Y=;
        b=SmkME2Ea3rGoYntuCsPcFJA9FuHksq7SSiBYTBd3Xp8EfiiGbGHAzUkPqFebTBagon
         2sl6ZfWkGZXUBFeNmpzmSbSeS2J/wFN0PLdUpCHcUwW0eaWgDwmP53yh5KtmU7VBinMZ
         UZKQRjfiAv2MmlUAjpYwsY2sYBkQWrAB5yJYxLLPYKGfNFqLbTsl6w4dns6neBFZyGIJ
         AZU/EjN0OlxOqClCkXTRCFf5jB+dpOWGJfPKHDNUU4MEAvVit5MPauK6YSKgwofvhMXK
         vaTCykHpWtNRjkzacjaIyR0FhyyBNpjrArIGwyIuM+HiexISVo8JIuYzkmt4TjOuh1K3
         9Tzw==
X-Gm-Message-State: ABy/qLbU00T/b3Hr1vglAusYLbf8r2EsEVjNur7bvdnMVnomYOMhUmI9
        JykPBVVEeM/zkCcFRo/Ue1uP38XX+zU=
X-Google-Smtp-Source: APBJJlH7JmfON0JMQ9P4y/J+/y6zreNPhQVHfUsgw6JZ5uUJNyyH0464Q7Jk7VGkg8zVRVS1gLuWQFJhaEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ce91:0:b0:c4e:3060:41f9 with SMTP id
 x139-20020a25ce91000000b00c4e306041f9mr128345ybe.9.1691011133093; Wed, 02 Aug
 2023 14:18:53 -0700 (PDT)
Date:   Wed,  2 Aug 2023 14:18:30 -0700
In-Reply-To: <20230704122148.11573-1-duminjie@vivo.com>
Mime-Version: 1.0
References: <20230704122148.11573-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <169101110045.1746914.18074564882174503013.b4-ty@google.com>
Subject: Re: [PATCH v1] tools: remove duplicate assignment
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minjie Du <duminjie@vivo.com>
Cc:     opensource.kernel@vivo.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 04 Jul 2023 20:21:47 +0800, Minjie Du wrote:
> Fix: make 'nodep' remove duplicate assignment
> 
> 

Applied to kvm-x86 selftests (with some massaging of the changelog), thanks!

[1/1] tools: remove duplicate assignment
      https://github.com/kvm-x86/linux/commit/7e4966e6e13d

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes

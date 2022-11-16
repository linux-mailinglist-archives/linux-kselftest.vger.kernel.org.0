Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D79762C71B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKPSA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbiKPSAk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 13:00:40 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0A560690
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 10:00:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id v3so17380742pgh.4
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Nov 2022 10:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZ4ednm6peE6gbmoqpZClMscPku5YJZ1wCBTU6Ikzio=;
        b=WTdulvpvTtll9lziEFDV50ImfoMCVIGbLflaO//uDyLKMCD+NXKNZ28jPPeof7JS/L
         b6QUxEh0GHceWpIqWY/8VM6LGkqwASDX7+axp36Vvd+kha4FZDgmLT6LfN1ZeejIQEp6
         lCThel7lsl3F5Eq0LHZTUlpaSkg1uZrR9fLNnqts3WyUvwFb3tpFV2nuAc+CoQduJbrd
         Ft3i+l4mEMchOWLw/4hyupeES7aGDgWTiTpKqKoI9l7c1wqGRLnU7okFktuqirDsgXpo
         m18yTtuzDY6o/awieSAPFYsaixsAeqZCiqqz5EkWeRgsScVh25AUPKUuaixjw0+1sOoK
         MChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ4ednm6peE6gbmoqpZClMscPku5YJZ1wCBTU6Ikzio=;
        b=AUL+b/hZeSGV82Pi8oaUbVtExFivyoLv5Kjxlxoyr2cRm69jCgcdpMCQHGVZbIjs/7
         CjZshMRjZmTRwJ/pzVV4vOG+tgZ9VUUcaHa+WjhFzI8DEfkVH8lW3fxeIqOnkwJ2u4nj
         HETS51kTfiE9P6ogcU2Nis/pfBzwoW0OLQX0pJmQCtyFRkCboup9YkXK3paii+93yeue
         jsGa7sUABjZTdnHlkI4dq54WcIa+3j3kvMRiIv+2EtkBUEEZmXKGDBjEJPuwslQN+hBi
         Hf/HIBg+ZYyZvEmo4H62nyXbLnsImDd2HSnyMRjMRL+nJ55uk61TEFFb5izk3RjvQ+Kp
         ALtg==
X-Gm-Message-State: ANoB5pm2Tg1YoLaMUQbvTxfxkh9WYxr586hNVAnLAzBuoAz3Sa3oYTua
        6M6wWPC5tXqsAVaYwMHeDvk8jyvHHDAW6A==
X-Google-Smtp-Source: AA0mqf6IW9b5cDWoM0bmrA1MVnJz4YY7y6phqjUqJJfwjTXzvzEY3JYpg1jW4Ijnid60/ii3HFAzdw==
X-Received: by 2002:a63:135f:0:b0:476:a62c:b2a6 with SMTP id 31-20020a63135f000000b00476a62cb2a6mr9582900pgt.588.1668621639185;
        Wed, 16 Nov 2022 10:00:39 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0017a032d7ae4sm12685441plg.104.2022.11.16.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:00:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 18:00:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com,
        pgonda@google.com, andrew.jones@linux.dev
Subject: Re: [V4 PATCH 0/3] Minor improvements to the selftest setup logic
Message-ID: <Y3UlQ0xSV9H3S4xz@google.com>
References: <20221115213845.3348210-1-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115213845.3348210-1-vannapurve@google.com>
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

On Tue, Nov 15, 2022, Vishal Annapurve wrote:
> This series is posted in context of the discussion at:
> https://lore.kernel.org/lkml/Ywa9T+jKUpaHLu%2Fl@google.com/
> 
> Major changes:
> 1) Move common startup logic to a single function in kvm_util.c
> 2) Introduce following APIs:
> 	kvm_selftest_arch_init: to perform arch specific common startup.
> 	kvm_arch_vm_post_create: to perform arch specific common setup
> 		after VM creation.

Looks good!  A few uber nits, but nothing that can't be fixed up when applying.

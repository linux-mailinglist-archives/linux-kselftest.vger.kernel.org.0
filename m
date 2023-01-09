Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3F662E8D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 19:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjAISRh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 13:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjAISRE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 13:17:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A677FEDC
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 10:13:05 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id h7so2585335pfq.4
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jan 2023 10:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpn7ULQKJRqA1WM0tl+JngZoSM5Eptcl4R1Du6qoFI4=;
        b=AKN88fz1MiNhQ6ouB3BqRSNX7WRkDgF0tCX0XphKDMLbqHyhd6bv57i4iwXJZuPYM4
         yngwuoJCvJdVD0bi+itrlOheBlmNUA2w740CjP7T7cfg8J7sJWGWDUgS5EDlGSdkWbE+
         OgSn0CvLy3GKdnj8LOgsjyzqlxc04zc4QxsY1irNTx3WlvJo5iiroQPUHwpaoPxZs0oj
         a2cHGVXtnL+MDWF5ONxUn9bUireONe2jrN3aSY/a5+o14bLrKG4X07Ka5X08lkYMgwHR
         l99hXqTB/S4q+t1d2ZvRB+oUhmGysXIZWC8qr9sHmbEckp500IVfnt13Q0iMJVn7jrYQ
         U0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpn7ULQKJRqA1WM0tl+JngZoSM5Eptcl4R1Du6qoFI4=;
        b=n5TIzUM8DoawNHvvewrpSsjPrd+uYk2fWFDkTFK6iMRBMFVSjQ6eZFMffwhGm6KE4c
         Q9lRB5G6mYCCO46PfuBkc2jVPUkLNqjZ6TdeNOB0Fir+k/nXi3mpM98/fIMGakiH81VE
         wO+9Sto4a2E9Ki3Kollkr85OPB6zPUaSTYyPO7FcFxGi/71KqcPBRgNB6aJ4bf5weg46
         sedIt+FpC1uVXG7JESzGhdxRblCCqAg47hUn4kGZ9Uit1e8avdY66xIXx8eFv3qw8yrl
         brUPpJBp+9u5+79TCv9qVpxxRC0Jn8LbyMQd1sxb8I+6GEZ5l2i9rCxENprODxFBSc3E
         q3bA==
X-Gm-Message-State: AFqh2koNKyIiP8NWlWamfPOShkn6Gz6kINZEn+l0U7WWL+f0zUuUZwu1
        3bqHzFTiqcSgHj8OMjuPyn/vSA==
X-Google-Smtp-Source: AMrXdXup4DR+qZjngNVx+JPw5c4h9yACEBJF6kWBNAK7bW2VPxRan8XLDCFWcPWHF/Qy1DAXlfuO+Q==
X-Received: by 2002:a05:6a00:1948:b0:581:bfac:7a52 with SMTP id s8-20020a056a00194800b00581bfac7a52mr704444pfk.1.1673287984757;
        Mon, 09 Jan 2023 10:13:04 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b29-20020a62a11d000000b005769ccca18csm6321096pff.85.2023.01.09.10.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:13:04 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:13:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
Subject: Re: [V4 PATCH 2/4] KVM: selftests: x86: Add variables to store cpu
 type
Message-ID: <Y7xZLB+1isqZTJCj@google.com>
References: <20221228192438.2835203-1-vannapurve@google.com>
 <20221228192438.2835203-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228192438.2835203-3-vannapurve@google.com>
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

In shortlogs and changelogs, try to provide a synopsis of the change, not a
literal description of the change.  As suggested in the previous patch, this:

  KVM: selftests: Cache host CPU vendor (AMD vs. Intel)

is more precise (vendor instead of "cpu type") and hints at the intent (caching
the information), whereas this doesn't capture the vendor part, nor does it provide
any hint whatsoever as to (a) how the variables will be used or (b) why we want to
add variables to store

  KVM: selftests: x86: Add variables to store cpu type

On Wed, Dec 28, 2022, Vishal Annapurve wrote:
> Add variables to hold the cpu vendor type that are initialized early
> during the selftest setup and later synced to guest vm post VM creation.
> 
> These variables will be used in later patches to avoid querying CPU
> type multiple times.

Performance is a happy bonus, it is not the main reason for caching.  The main
reason for caching is so that the guest can select the native hypercall instruction
without having to make assumptions about guest vs. host CPUID information.

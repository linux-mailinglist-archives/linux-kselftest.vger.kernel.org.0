Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF79662EC4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 19:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237557AbjAISXE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 13:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjAISWl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 13:22:41 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480961D0CD
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 10:21:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r18so6450584pgr.12
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Jan 2023 10:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkS2qBI0dPZQnMdkME3l6hJQoHppmeAwetW1iOaX8Co=;
        b=LffKF0uSUV5ZGDd/s4y0yatOiYa77VSJRn8yhrQnwLIA0k1ivjED1LKDPHLMWOFF8G
         jm/0rQXfEBHpIegKAqLXyxk50UFweQI9fSGzpg6/9KN/RGIik4kPJk0QO1K8g/Q2Jh8o
         08hOjpjnPUYprOEirByqVRrdXT8ZsSGxoMO8sUuJON9ECKwhXT0FwB3YbQNyUeGgTJtB
         adt2WRSOfm41/BtO9jtNJZ712KQakOx6bkjURsURpDvjBj6gUta8Z2FaMRcjP6QxBMtP
         v8zPDzbsnTqv/D12BkVNpklTWs4VOgx9Ru76PQgxuw6lFJKzsAb1nJACV8Mr3Ifbl98z
         865w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkS2qBI0dPZQnMdkME3l6hJQoHppmeAwetW1iOaX8Co=;
        b=8KJdOA0XSyOcr0fRDv/uL96IhoPQF7oOUBSlpjXY0tGLjVXJQRznVoFAEf59Selvne
         72igldbUn6E/8kE2K1Oe7By6eB967H/pOZDVTHOSK46R1Q6FbxkfU8du47VqAF/BfEJa
         5kkZXmVecLK+UXLxaGU5pV/0B/dXz2c0QyOv1hznYPWjR+m+GeEADe+WghW/ywRfFd/T
         sp4cPMIaBnJFyzuSjKTyUfyHXyJhfAwBf2TdalAQmNVIOJIqHNnKqN89Lu1rEBHwXoYa
         +FN+3Y5WK6Ku7gJlicBxtdvoejwXDUxa/5S4iV5bwnzyGp4XHQ4sEdjYZkJSb74myHd1
         aZ3g==
X-Gm-Message-State: AFqh2krKDPVO2gXxjXKkP6Sj9VzvBUBwXvpvNJNFodbjVAXP8TgzHsxj
        M19kc/DDP0EF6TOKmMwNDCChow==
X-Google-Smtp-Source: AMrXdXul7Y8Jh0boCRot2sqQHcG57lN6uNJsmvgpsrZXnnvp9Wda6tvdyU4i9IHlP+euhRZa1qwedA==
X-Received: by 2002:aa7:8f2d:0:b0:582:13b5:d735 with SMTP id y13-20020aa78f2d000000b0058213b5d735mr761256pfr.0.1673288463680;
        Mon, 09 Jan 2023 10:21:03 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e2-20020aa798c2000000b005829c60a838sm6345515pfm.183.2023.01.09.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:21:03 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:20:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org, bgardon@google.com, oupton@google.com,
        peterx@redhat.com, vkuznets@redhat.com, dmatlack@google.com
Subject: Re: [V4 PATCH 4/4] KVM: selftests: x86: Invoke kvm hypercall as per
 host cpu
Message-ID: <Y7xbC+leVdO0TRVE@google.com>
References: <20221228192438.2835203-1-vannapurve@google.com>
 <20221228192438.2835203-5-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228192438.2835203-5-vannapurve@google.com>
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

KVM: selftests: Use host's native hypercall instruction in kvm_hypercall()

On Wed, Dec 28, 2022, Vishal Annapurve wrote:
> Invoke vmcall/vmmcall instructions from kvm_hypercall as per host CPU

() for functions, i.e. kvm_hypercall().

> type.

s/type/vendor, "type" is too generic.

> CVMs and current kvm_hyerpcall callers need to execute hypercall

CVM isn't a not ubiquitous acronym.  I would avoid it entirely because "CVM"
doesn't strictly imply memory encryption, e.g. KVM could still patch the guest in
a pKVM-like implementation.

  Use the host CPU's native hypercall instruction, i.e. VMCALL vs. VMMCALL,
  in kvm_hypercall(), as relying on KVM to patch in the native hypercall on
  a #UD for the "wrong" hypercall requires KVM_X86_QUIRK_FIX_HYPERCALL_INSN
  to be enabled and flat out doesn't work if guest memory is encrypted with
  a private key, e.g. for SEV VMs.

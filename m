Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC797CF072
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 08:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjJSGwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 02:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGwI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 02:52:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03F119
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 23:51:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so6476085f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697698317; x=1698303117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mw4Ufl/cOqWrZrf06coK8u2YQD70TRL1KhrXVtvZNrw=;
        b=nsUsNCHZFTEW7NrHc+xLEg94MIbZEvhG0XTqLEf4/mQVG826I9Zx6/dJjVJ2XTE1dK
         U4ezwvNwlGi70f4bRGI5jo5RvcFWCkzz8TFj0n/ymYdItVbq7H1cbm62uSaIaRarkYDe
         IoYLkzdC1sMQ+OXGGAULWL11HQ+0//3zL3A614dvTxMT2+Va2XUttM3PiyWdhK0i4XU3
         OqlfQhVf7tBd/itKq5ScC8o/GDuCXzQapUoCjZgWPWKKPHMLnl1loQaQ3gLlFUJiQUvi
         ArgyVvSZaiXH/AxQAPrzH4LgarMhNNH1zNCtqfvPXtIsdE8KtA6nUEbtaVxGmaAizjXF
         sMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698317; x=1698303117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mw4Ufl/cOqWrZrf06coK8u2YQD70TRL1KhrXVtvZNrw=;
        b=Tt8FQ2fHtnoWr2UUAVUmukbNBcq5+nBXqGNr4qUv+Dfg6kFY3zNVsa0XqCAO/33aQ4
         xVIbePoLvkxqqyDICNXS5Hfzg7f7tC7F/7QTpo2WgK76XxkYWqRGdAmVLCUIxOcVQ05L
         jnvx8tr7JtgOI5dT8aISyHA1GECGQA+N9EJiiEagAVHjr/zG+fPSW423GDqjFtKlsBLV
         7VRW0lEKj3m4rOps+VQivD9RRSTvXfCSdQI0D2xqA3aHO+9vSE8hfWhxIW3hiD9mR0Ig
         uxyaxIs5E+J/W+xlFrLFUQXYyVS+QAzVC4ZRpQKwyA2o48VmRkFiyXZ+Hqqeubf0xu1U
         RJag==
X-Gm-Message-State: AOJu0YzCAfbra0l9WPI2aEwDohbNNdNKFFrYB3yj8kQ/UDNoDF1FVKKE
        wpA0uWBWzF3rvmX2M8za5/r8IA==
X-Google-Smtp-Source: AGHT+IFGx0X/DCQzpamvzML5eVZXREJOW7/gfUas0fSutEbwJ26Qfuw+v6wfWgMQ1KlpLCIJu+0MUg==
X-Received: by 2002:a5d:630d:0:b0:32d:87c8:b54e with SMTP id i13-20020a5d630d000000b0032d87c8b54emr860927wru.1.1697698317404;
        Wed, 18 Oct 2023 23:51:57 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id i3-20020a5d6303000000b0032db4e660d9sm3710915wru.56.2023.10.18.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:51:56 -0700 (PDT)
Date:   Thu, 19 Oct 2023 08:51:55 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, shuah@kernel.org, dwmw2@infradead.org,
        joe.jin@oracle.com
Subject: Re: [PATCH 1/1] selftests: KVM: add test to print boottime wallclock
Message-ID: <20231019-f96a45af9c235d89be644e67@orel>
References: <20231006175715.105517-1-dongli.zhang@oracle.com>
 <ZTA3W-f4sOX3LHfi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTA3W-f4sOX3LHfi@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 18, 2023 at 12:51:55PM -0700, Sean Christopherson wrote:
> On Fri, Oct 06, 2023, Dongli Zhang wrote:
> > As inspired by the discussion in [1], the boottime wallclock may drift due
> > to the fact that the masterclock (or host monotonic clock) and kvmclock are
> > calculated based on the algorithms in different domains.
> > 
> > This is to introduce a testcase to print the boottime wallclock
> > periodically to help diagnose the wallclock drift issue in the future.
> > 
> > The idea is to wrmsr the MSR_KVM_WALL_CLOCK_NEW, and read the boottime
> > wallclock nanoseconds immediately.
> 
> This doesn't actually test anything of interest though.  IIUC, it requires a human
> looking at the output for it to provide any value.  And it requires a manual
> cancelation, which makes it even less suitable for selftests.
> 
> I like the idea, e.g. I bet there are more utilities that could be written that
> utilize the selftests infrastructure, just not sure what to do with this (assuming
> it can't be massaged into an actual test).

Yes, there's definitely code overlap between selftests and [debug/test]
utilities. For example, I snuck a utility into [1]. For that one, without
any command line parameters it runs as a typical test. Given command line
input, it behaves as a utility (which developers may use for additional
platform-specific testing). It seems like we need a way to build and
organize these types of things separately, i.e. a utility should probably
be in tools/$DIR not tools/testing/selftests/$DIR. For [1], I don't have
much of an excuse for not just splitting the two functionalities into two
files, but, for KVM selftests, we'd need to find a way to share the
framework.

[1] https://lore.kernel.org/all/20231011135610.122850-14-ajones@ventanamicro.com/

Thanks,
drew

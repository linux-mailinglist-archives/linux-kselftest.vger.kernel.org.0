Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86E87320
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405776AbfHIHgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 03:36:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34415 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405582AbfHIHgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 03:36:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id p17so91248176ljg.1
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2019 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXqS2DL68BnoaWC7BPpejArIxz6sqUi2fc/63WuQaUE=;
        b=QKL0hpgsd+0DNocYhr0sEvnxDUB9OXgs3iaJcewg/PpKtcZDd9q9ztHww7OdRd8K1x
         EsNY858u9uPhQWSOAVrxpmMIUu5KUzwaV3TsHkDCS1t3TCobq/9PGwCabM7oU8ARaMNf
         M8TmaT+8j2S7leYm4lrZuMoQyyDppVz5G/6gHWkJamj1HsNdShB8on/i+0uX0I6felNt
         seus2hiiiuYCV5cZO2OpOQTu+nPXKojbfezQmKNtqns0RTRELCP/y5WoSbMDbCsUQDL7
         xLOJABYKiF1x5K7QwK36deq4e1LaIpzb8TQQ9upjahFFRuEioMivr1TwvLkKnpeAgCfN
         PQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXqS2DL68BnoaWC7BPpejArIxz6sqUi2fc/63WuQaUE=;
        b=ZwwaUuxpo+9b72nn0dyaL31RhvV3LomBV0hPxFptSSlXaVYXxRovcE83ViDns8CQPS
         h9xVuWWDRvDXMkLddl1qvyMGnmi5Wr0Cf3oS0bXhykue+lBrgSeRrdPmfsFGc17FW1A4
         +c2j4uHv0vAsHYAhU31FssIOt5zrOVtsB8GuwO2jshgdIT0NYLLcoExUjsBKOplS21gU
         IRvCW1FWx9NTm6labAZ5FeZY0ZeQ21M/pnETlyjJZqcbYS2aNps15NulJG8VUrCNVn51
         ToXsAzHsoqsWesEUP9+iYsDPczOZSFE6r35/GSVbZIqeDKU+T7JnuiyBc+TvI6gv0oB1
         yEKw==
X-Gm-Message-State: APjAAAUJRDyQtpgpIPtL2OAuXfDArrmBlquxX2kPvS0BMpUEm5a9znqt
        We6RpF+x/jiQwpb0PamxLAcyUq2tv4dPJ3oYoKtQhg==
X-Google-Smtp-Source: APXvYqzeqLykT6zxNpcnNSzGlO76tabSwRrSF7hhpaCzhGrqiXaDTvhfTN7tkmBVUZHwxkSdgdismvv4yqPs8ykrJOo=
X-Received: by 2002:a2e:6e0c:: with SMTP id j12mr10467584ljc.123.1565336170583;
 Fri, 09 Aug 2019 00:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190808123140.25583-1-naresh.kamboju@linaro.org>
 <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com> <b34e8232-ccfd-898c-49de-afef4168a165@redhat.com>
In-Reply-To: <b34e8232-ccfd-898c-49de-afef4168a165@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 13:05:59 +0530
Message-ID: <CA+G9fYv7RZgm36fbQU5yH=58sX84TxgE93SneB_UhRsD1ivGhg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andrew Jones <drjones@redhat.com>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 8 Aug 2019 at 21:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 08/08/19 17:10, Andrew Jones wrote:
> >>
> > What does the kselftests config file do? I was about to complain that this
> > would break compiling on non-x86 platforms, but 'make kselftest' and other
> > forms of invoking the build work fine on aarch64 even with this config
> > file. So is this just for documentation? If so, then its still obviously
> > wrong for non-x86 platforms. The only config that makes sense here is KVM.
> > If the other options need to be documented for x86, then should they get
> > an additional config file? tools/testing/selftests/kvm/x86_64/config?
>
> My understanding is that a config file fragment requires some kind of
> kconfig invocation to create a full .config file.  When you do that,
> unknown configurations are dropped silently.

You are right on this point. As you said, unknown configs getting dropped for
arm64 cross compilation.

- Naresh

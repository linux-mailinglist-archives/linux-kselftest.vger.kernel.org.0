Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D761FC28F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQACr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 20:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFQACr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 20:02:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F3C06174E
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 17:02:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ne5so135064pjb.5
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oe/hKAKHGvJszycxiAbC2N5QfwK/kv0uW4M610gYZnY=;
        b=Uzye1Hii/AU8ot5ff4TsthmYVWhTUyRMrsmmfyHoIJqYq0Eczq1dwhp+mbdXjzxeAk
         9wtUHLgg37QXJIUyFQ6rDtjQp3FQFt9exXKj6glBGuADuVrm6eo0dkXUYsQLogY6rCI9
         BpLcmQTqsen/Cx1v4BpvB1mjEzFdSmlc8bDSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oe/hKAKHGvJszycxiAbC2N5QfwK/kv0uW4M610gYZnY=;
        b=DdO3ccxh3rbEAKkhdITQw1Bhl2xzAh9NIQcZ52w5cIxNbOYslQr3AWpjrBR/XoXffH
         k4dO58Mzo4EyojRKF33dNOH+qfyn2gpLvkc25PithZ+F+HH2VmHIx/ogmvWXCn2wVuOP
         dhu38H7jMPemeAkihFIiHyHTc8nLA25J0mpEccBL4CypCw5MOoRihMn8ilsC8Mcl1hSZ
         KNsviTpEtJyI7vIRJj5uLH6SGxWoH/94ST4RbNQSQMwMhGFX4ZmU3/bBPIGlR6witleY
         5bt8QGvJbPGAneN51NGu23JQI9xcz0JniXIbgBuH6IEtGT5bRsAmhrigNRzyWWmU9hns
         l32g==
X-Gm-Message-State: AOAM533eDuqptzZ109AQ9fxmDBmxooWnZ5jZt65Ck1w1IbpW5NFp5bff
        TAmNa/wkJ+Dwxwm+W/HPUIPrZw==
X-Google-Smtp-Source: ABdhPJxoKbB2AxNcWqAGD8BdmcD9iQ3Qib8cSe2Dw81g0u/XxRdehdq7O3qmk9pRWtrwZeHldhqg5g==
X-Received: by 2002:a17:90a:be09:: with SMTP id a9mr4981100pjs.43.1592352166752;
        Tue, 16 Jun 2020 17:02:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 10sm17861488pfn.6.2020.06.16.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 17:02:45 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:02:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006161701.685284F@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CABVgOSkrKHs_uWLZ++_fBC_mfe3RgDxmCvnkcyn1P_wjXTV9Og@mail.gmail.com>
 <CY4PR13MB11756803217A9D20456E826FFD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g458XTDftQAOm-K4Squ5-ZuZnZcFdVUG0JtUWF56cODOVg@mail.gmail.com>
 <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175CB6221D5859AAC9920C6FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 08:37:18PM +0000, Bird, Tim wrote:
> One thing that needs to be rationalized between KUnit and selftest
> is the syntax for subtests.  KUnit follows the TAP14 spec, and starts
> subtests with indented "# Subtest: name of the child test"
> and selftests just indents the output from the child test, so it
> starts with indented "TAP version 13".  One issue I have with the
> TAP14/KUnit approach is that the output from the child is different
> depending on whether the test is called in the context of another
> test or not.

Right -- I'd *really* like the subtests to be "separable", since the
primary issue is actually that a subtest may not know it is a subtest,
and passing that knowledge in may be difficult/disruptive.

-- 
Kees Cook

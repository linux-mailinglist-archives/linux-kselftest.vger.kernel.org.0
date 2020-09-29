Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6327B95A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Sep 2020 03:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI2B1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 21:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI2B1o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 21:27:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5830BC061755;
        Mon, 28 Sep 2020 18:27:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u24so2502166pgi.1;
        Mon, 28 Sep 2020 18:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=haBHYNhGyPDlpdCEcHOoSLCHhaYXNjWfLyF4J9/wU0M=;
        b=nqNVNfAc7trRJ8ELoXvA2l0ORldRE8sJpjt7nLGhGL+CWYopAosU/XnJuncU+gCN4v
         c1O5D/gkag2cBPT5YkU6P5vxFFF9c6MOA6mpMdoFwWoIi7KpKtKlRMw8Y10a7FFdVmuA
         xZD3kwUENIcV8odQSIfEy1ARotNtGjnK48OQmHcp68rMk3zH5JfjB6QFKIEvP1t+sodO
         Ge661L9mb3P654FmmO8kw0BMx5XuUUoXSj9JkuamXBbeF5qlu//CKY2MGFF4dhSPf1hK
         U31w9QriOFnlYwX86xeHiAxt2PJBnpIRrLqar2iKhDaa3YMA+kDW8/+neN9rpswpt1xR
         7csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=haBHYNhGyPDlpdCEcHOoSLCHhaYXNjWfLyF4J9/wU0M=;
        b=PCc0ia2mCMEz/IZCi/P9z73JzN5JoR2R2O1dsu9n/hnEj8hpfO83pNbb4eKQ/j0Wge
         4O6D/tWjFoA5nruMiHuJugROrzcdjuc6kKGXmP4WTJE3FK+vNLAxQUFtjXbgv74lQ2c7
         NNacs0pKVZF9pVOfZ5CBK4eJZlI6CEZI/R5zmnpKMgS3Fix0eo97qTBUgIwixk6XovCz
         9egbt2gwNMRmHnXTg7jc9+XNxnY3likUADz8reMG06RaeI53EMjhLDruQ9kOcXzWYW62
         NODg9O9DuwXR/uRh8dFXRQxThf6GaAmq3hLt3goNxFZSG5xQBcHrerHJGSKTTOFiipE8
         ZTgQ==
X-Gm-Message-State: AOAM530qH+Til+IiOkViB8S2kFxzUdd7QB6qv0IGeLtj3ILgv4G4Os8l
        inogv/wNtqOKbkJVsWHUNxY=
X-Google-Smtp-Source: ABdhPJxAFUoStsPpjfspG7G2Tgct9zO/DSeQ4pDbiiKDUYg9tJO5ut3kzNKyDZpzsxD5QUpQUL5uiw==
X-Received: by 2002:a63:121d:: with SMTP id h29mr1314164pgl.285.1601342863833;
        Mon, 28 Sep 2020 18:27:43 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g9sm2502607pgm.79.2020.09.28.18.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 18:27:42 -0700 (PDT)
Date:   Tue, 29 Sep 2020 09:27:31 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-doc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, Tim.Bird@sony.com,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCHv5 kselftest next] selftests/run_kselftest.sh: make each
 test individually selectable
Message-ID: <20200929012731.GE2531@dhcp-12-153.nay.redhat.com>
References: <20200914021758.420874-1-liuhangbin@gmail.com/>
 <20200914022227.437143-1-liuhangbin@gmail.com>
 <CA+G9fYvT6Mw2BamoiVyw=wLUqD-3LB2oaDqcuabOyWfFxEN1qg@mail.gmail.com>
 <202009251414.15274C0@keescook>
 <20200927015334.GC2531@dhcp-12-153.nay.redhat.com>
 <202009281305.E6F9595@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009281305.E6F9595@keescook>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 28, 2020 at 01:06:15PM -0700, Kees Cook wrote:
> > I'm really sorry to make this trouble. And I'm OK to revert the patch.
> > I just a little wondering how do you generate this script.
> 
> This issue is with which shell is used. I suspect your /bin/sh is full
> /bin/bash, where as Naresh's, the CI's, and mine are /bin/dash (which
> lacks "-e" support for the built-in "echo").

Ah, got it. Thanks for your explanation.

Regards
Hangbin

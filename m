Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C687F17A5BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 13:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEM4q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 07:56:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34095 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCEM4p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 07:56:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id x3so1879062wmj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HjCIB0cRkswxBHicvx3GUv0HnHsmCo8E8PgbIAIILt8=;
        b=Gt/cWQhhASP5bBzj8TNSd2HNFVxn+yN97a2l6r9ou6WkoZ9ke+th42t11blcXXVp0B
         ghq7GvlWbyevzK+R8YSdaHLsREQV69CgCzV5gnte0XYqag7edAbdx3NksGubzTbhrC6C
         L7WDW2T91Hh7BuiXiHZj3m41Zjzb2ehCS0iFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HjCIB0cRkswxBHicvx3GUv0HnHsmCo8E8PgbIAIILt8=;
        b=TQnZLTIhPU4sZB9PQq3XU5z+BcDJQxHA4R/TyqzUeDEHtmdE6LNigq2fZQa1gOpm++
         59W65obAGdzhcjq8E0uv/TC8beIHFtUxZxF3tEqSPU3DO58g2SOPj3GEF1ubVpyspMg0
         ARRYrPqli7VJaqwwkPZPCN7m4TB1+YXZWa//98Hle3kLKz7hQsI0dlcOWmcnuFou/29g
         BlFtKSTI1vpXtePBVYwoLtYVHQpT2bKM0fG7W6jdZi000souoH5pr7PuCxJr64JpkGD8
         7TQaD30YQNaAvOKLpL/Sy6satUr4sqm1OS7+hO5fzcf7dEU5+Wc9hfnDusdkfDsLpWel
         6Nkw==
X-Gm-Message-State: ANhLgQ18LN55tZfWFWbRc/ZyP49ZRvQIt+WFRAybXmkE/qROwpSw1TN7
        AOi3S//tDroqgh6vfjhOgNhZog==
X-Google-Smtp-Source: ADFU+vtTdXrgymK5ixyZsrcFBHG6FINonOFExU1Faxcsm81kgoO3Fs/OiO+Ghm8rTSqRlerFLgFhTg==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr9810661wmd.160.1583413003982;
        Thu, 05 Mar 2020 04:56:43 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id s5sm42900540wru.39.2020.03.05.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:56:43 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-12-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 11/12] selftests: bpf: enable UDP sockmap reuseport tests
In-reply-to: <20200304101318.5225-12-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:56:42 +0100
Message-ID: <877dzzyn79.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Remove the guard that disables UDP tests now that sockmap
> has support for them.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]

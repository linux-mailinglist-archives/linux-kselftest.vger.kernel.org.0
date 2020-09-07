Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF06126009C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 18:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgIGQvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730992AbgIGQvX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 12:51:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9DBC061575
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Sep 2020 09:51:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so12677465wmd.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Sep 2020 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MkAhet+wlF++7FXN/+TlBF4gd0vCDBXRks1SAOZwHBo=;
        b=msuXnHFD7qVdbxah+AfMpKoWioy4ntWc1e+qaUJe457XpG07QWuqkCUbHKklZiU7X/
         XfRHgmy8FjJuYRyoyO0PDVVqS8Sv7U9kkFMgFIuroa9UXAU1ylCab7e1eMHVkZpDQYuP
         U9R89KcpNBvN2Uin1XuUuE/s2Ez/+q8kECql5LrwzMOka2Y3lUJx7vPuICrkDQ1R2xyz
         fA+lmIl7+MtE19uhdyzFKhKIitVpQpg2c+SHjblJb0+Csrdr24StPy0kMWPz/gNzwAAT
         7QN4fCdDUgiaG9R6VxvcxhWZpVYVSM/T0V8iGwhz8mglr8v1SKLS5BdYO/p3voDif3Gb
         wNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MkAhet+wlF++7FXN/+TlBF4gd0vCDBXRks1SAOZwHBo=;
        b=LsKm8KDvEbyHuvtcLiZ5lmQNezFpbi2/nLLZls13LwjkbdcRgiOu61PcQo7jcunmd1
         JBZzeds5QO/tP4H6RS6xwCGbgJhxAR3nBL3X5YwQJt8hjyhmKXoUST60sxd9AYSMqLV2
         PXnSoSJSepxUUdkCxsKGJUJDd2+KDBskxzmtSDLzztTcCFqilj9mHMDzX1Oil21+d31U
         TpQ1jOthQrOzBM0pk4gj0NEaUlbioVe8PeLWJNAhVqLQalgyzi1ZRnOpgIdEZ1vyXW/L
         VANzwA+hqHo+ejHyGLUnDHl9apeYbHKBJwxGgCIzEIey0QULeNEmpnMJejxFd3Xc5SHM
         7xfQ==
X-Gm-Message-State: AOAM531JN1rSfWReELqrNPdr1CUnc+w6C9T8P1bj5qbDPdS2wz4tTj5X
        c9NOOwnPqQ6fMXT0YVonMaRHeg==
X-Google-Smtp-Source: ABdhPJwnhG+q4RURga4Peq9RwwUWPja6cnlXV5h0sMrqUKnxF3s+3ta2GRXU/c+paOwv5zDODpupZw==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr243417wmh.14.1599497481336;
        Mon, 07 Sep 2020 09:51:21 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id h6sm27190637wmb.22.2020.09.07.09.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:51:20 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] xfrm: Add compat layer
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        netdev@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20200826014949.644441-1-dima@arista.com>
 <20200907094314.GI20687@gauss3.secunet.de>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <2804926c-47cd-9756-065e-e17c517e31eb@arista.com>
Date:   Mon, 7 Sep 2020 17:51:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907094314.GI20687@gauss3.secunet.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/7/20 10:43 AM, Steffen Klassert wrote:
> On Wed, Aug 26, 2020 at 02:49:43AM +0100, Dmitry Safonov wrote:
[..]
> 
> Thanks for the patches, looks good!
> 
> Please fix the issue reported from 'kernel test robot' and resend.

Thanks, will do!

-- 
          Dmitry

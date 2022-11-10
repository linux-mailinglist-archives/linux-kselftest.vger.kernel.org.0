Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6998623A43
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 04:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiKJDNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Nov 2022 22:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiKJDNX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Nov 2022 22:13:23 -0500
X-Greylist: delayed 225 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 19:13:21 PST
Received: from 002.mia.mailroute.net (002.mia.mailroute.net [199.89.3.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2E71B7
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Nov 2022 19:13:21 -0800 (PST)
Received: from 001.mia.mailroute.net (001.mia.mailroute.net [199.89.3.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by 002.mia.mailroute.net (Postfix) with ESMTPS id 4N76JK0y1Mz25hcv
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 03:09:37 +0000 (UTC)
Received: from localhost (001.mia.mailroute.net [127.0.0.1])
        by 001.mia.mailroute.net (Postfix) with ESMTP id 4N76JH6BH9z2KY2f
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 03:09:35 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 001.mia.mailroute.net ([199.89.3.4])
        by localhost (001.mia [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id aU_I3qaVFN7I for <linux-kselftest@vger.kernel.org>;
        Thu, 10 Nov 2022 03:09:33 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 001.mia.mailroute.net (Postfix) with ESMTPS id 4N76JF4yK5z2KYBj
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 03:09:31 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id q6-20020a170902dac600b001873ef77938so438965plx.18
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Nov 2022 19:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AuiViQRfjQWppeuMf+SuKMxRs2Z0h2rUhwj+YwxMN+Q=;
        b=ZOzYNOyPUL86aMpUAd4XjGErMSbBUc0vDEIQhzMVYTWyFZUs7+uJvfXLDYDab3S30M
         pqEums169lSyyGP+0cSuKTJPAmqq9ZXE875Tr5bQo439GO8j56Wq3QRm96BtWfePsuh2
         qHxCAPCT+lYszZRA+8ZqUc0A7yB36GkHH619IYIAFTCelusuA74bw9OZ7GU++puzp3mU
         PmQ7eA5JIdcwxGSWTvf7A9RIne9I2gteQCBV+qm9XyjlLak5qDFiRtXhj54VvOj6t5Hc
         dcMmLuF/Ihc2ftQGchbIwVrmQFyvZAWUYdV3/ia14tTG4l4K8R05XwsyTsxkhFxdQIa3
         v0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuiViQRfjQWppeuMf+SuKMxRs2Z0h2rUhwj+YwxMN+Q=;
        b=q7A5eBpn4zZg4x76cYaquKtvF68dWi1AzTY9XtFcEpMZubdPxTGtd6QHnIwbSZYBh0
         Jjo8U3T8/i28ynRJGO9CjZPQowP8yvREAfw/bcwxQOG32fXYw5H0cYmauDppRjAn5VXT
         d35wLnf+pkvb8NOs3QiO8pAG1tR4V1tAw0FU7/Pmc5VUpslivl7Mj3gcHe/pdL70B7H/
         itQxCRrxM1lvl/j/ciECU2pw5w0HbzIlEW+cGo+y9ZoOTUZZdPTGzdT2LsUTg3aqFKO8
         Pz4btUesH9jWC+wcrSnRuzNxQm5vMpGdf46AmN1gzaqhhkk5b2ljf3CJHPO6OjNQEvg5
         kj/w==
X-Gm-Message-State: ACrzQf1oYAfANMIYA5esYdalmzmbBDetzPEcqPLXZw18jv5W+vkbfF/j
        vzgMTqbiV7SRCEbmXtTRHD4W8yD2NdibF1QV3vpkfgFsEEWmbXxN31Rpx6UbHqbCF02+M/on0Md
        xlNaYdL30Dz5Vc3tQcpDkz6OF28UM0M4K3qTKpj/W7c3nv9uaoh4lBzod1iw=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id y8-20020a1709029b8800b00188620d90fcmr33540711plp.61.1668049770058;
        Wed, 09 Nov 2022 19:09:30 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5MPTE7vJnNKQyRhDyXmGFH3IT7hkXHK7Q739qTyDGWXmwovs1ft2TUvAhGlVQjgAfn4MFVQBNYTTlImv+kXpo=
X-Received: by 2002:a17:902:9b88:b0:188:620d:90fc with SMTP id
 y8-20020a1709029b8800b00188620d90fcmr33540683plp.61.1668049769748; Wed, 09
 Nov 2022 19:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20221107063807.81774-1-khuey@kylehuey.com> <CA+pv=HNPDvr_SV0f6RSBz2A3qBQQLBXaaxTPPT4FABQhwQwuHw@mail.gmail.com>
 <6d29eadd-69ef-343d-fcc8-b0432d604e92@intel.com>
In-Reply-To: <6d29eadd-69ef-343d-fcc8-b0432d604e92@intel.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Wed, 9 Nov 2022 22:09:18 -0500
Message-ID: <CA+pv=HMUmSBJcJnVOxpZecVJFO_oLC7Of+LVdJyTuu2zut_fgQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6] x86/fpu: Trying to fix writing PKRU through ptrace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        "Robert O'Callahan" <robert@ocallahan.org>,
        David Manouchehri <david.manouchehri@riseup.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 7, 2022 at 3:52 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> Thomas had some strong opinions in the area, so I've been neglecting it.
>  I'll put it in my queue to take a look now, though.

Awesome, thanks.

-srw

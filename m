Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B963145E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 02:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBIBz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 20:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhBIBz4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 20:55:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E3C06178A
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 17:55:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so10929730pfk.1
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Vb2nlQGaP26yPlUIcez5sRj184B9EgE/jeGXiB1oSwU=;
        b=KDHCzh7PFsqmsUNzwhs/0SaFtOeHp5NK39m/SWsVxNCMkMQCBJOThPz9AT8UCS1v0K
         lzdYXIJlBuOviEEuWWmSrVnU18ki6NjaJJRE9b4gemyDD+hHqlp+xnsunzIyJtD7Jv1y
         N8l19/Pg+7WHf0zDqu93BsYmen6Dl2oFrLGcnCuJr4sQgoFNupTePeXDlUkVi8D982ye
         vPgbJTp+uekwQ9rE12FqMZuIV4PZpOk2Ymx1LTQ75SHsn4UJvW2jRo8L56Psoq3KTkGx
         72+PO0cilAlVo0HaDzRejUEAL9jg2Utpp9F2MFTIc47HK/k+JsdLdhDsBSR1xwdqlnkH
         LnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Vb2nlQGaP26yPlUIcez5sRj184B9EgE/jeGXiB1oSwU=;
        b=aKO1N0aJ/GAYIJeSVrRvDj9weLRVGui08XrU5s0is/TNkZmluN+FG2RQ18aGd+aWJn
         eqsieIt/kCdoznpayg62La2ibM6dwr8uqqDEIZ4GvnODGs7B3bHtwwGNbF8HlmVK+Vxe
         R4VO4HKoFRCdoIdfXxVxx1MXp5u0SxLahWMkl3sNE7jDiN8eYHiw8Dp2M1ayAFOdAkfp
         aKPll0JSa1ZKQ0D+jA3RmVkq4oTcFPSokTw6uPRb3Iw1UcfAXpjw5V7v0nSiPWgk6l9j
         S8mB8VHWA8/ajFFbucBBrCzrdjVD2zVt1RE/UswzKQD4Q+s1m7VlY71OtroVcmOXzviJ
         yMhg==
X-Gm-Message-State: AOAM532XA9OFvSJhw+6EOppQOFknFDSNS0biYVw6I9qaJ+TVkQC67Ad5
        a9tmLirXAueycZOiUKXiQLjDgA==
X-Google-Smtp-Source: ABdhPJz5tJe/wnpCrfYutRhPvkqG17RyE0LdVbep6txq+E9zTwTkas85e4iOsPhlMDk3hdBq3cChvQ==
X-Received: by 2002:a63:134f:: with SMTP id 15mr4132329pgt.128.1612835715181;
        Mon, 08 Feb 2021 17:55:15 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 74sm3895691pfw.53.2021.02.08.17.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:55:14 -0800 (PST)
Date:   Mon, 08 Feb 2021 17:55:14 -0800 (PST)
X-Google-Original-Date: Mon, 08 Feb 2021 17:55:11 PST (-0800)
Subject:     Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
In-Reply-To: <5a8923b2-0c5e-ab6c-52fd-f00bc1361a3f@linuxfoundation.org>
CC:     tklauser@distanz.ch, shuah@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, vincenzo.frascino@arm.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, skhan@linuxfoundation.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     skhan@linuxfoundation.org
Message-ID: <mhng-6ff7da88-6f30-4910-833b-b4a9a4eb71e4@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 08 Feb 2021 15:37:24 PST (-0800), skhan@linuxfoundation.org wrote:
> On 2/5/21 12:57 AM, Tobias Klauser wrote:
>> On 2021-02-05 at 08:06:37 +0100, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>> On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:
>>
>> [...]
>>
>>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> Thank you!
>>
>>> Not sure if you want this through the RISC-V tree, so I'm leaving it out for
>>> now and assuming it'll go through a kselftest tree.
>>
>> Either way is fine for me.
>>
>
> Thank you. Applied to linux-kselftest next for 5.12-rc1

Thanks!

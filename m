Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723191EC2FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 21:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFBTl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFBTl0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 15:41:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F10C08C5C1
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Jun 2020 12:41:26 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so4351813oic.9
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jun 2020 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dxHzvSblnkcYW/wmcNUppzoyDk3DR31hUrJu+JXhQLU=;
        b=F0jV6T5QCA+YNsQ3LVDb7Lhr7qtUYZ1w1DRaaWfX7iZwINO63+RGeKTe37zJTuzSyJ
         BLWv+LXkPOf1uxy+byvaFBimaXmUmdiWF0GEHglgAIF6MgZbNHnUEpyz1s8GwQ2u7juy
         /Wv8a/kVxDHaVoy8WM/OensLNkYsfmYPibmCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dxHzvSblnkcYW/wmcNUppzoyDk3DR31hUrJu+JXhQLU=;
        b=eYVETW6PwHYSypEqExlqB+5OSIHhuyB2V+Bg4VKhsMzJHqYD/cLQiWdvYBKWNnXoMt
         fOqBEsDVPGQZ24FKdIi7lvRCdKKf3cruiJHNpBMdCoZYd77Im0JbTDa1EPulccFGTYMM
         cOfVNtdfUOpZ7jk8ppACGOaf+CZMpiLiLX/1oDi5TVHFE6Urc+7rkTNtHRI3lTxMPaU5
         PPNOKO6ZWbZFErP6+RtevV1fH/fAvUFvghB0O4W1rIZYIPxh9tSyGA565sQTGJSFxDEu
         QPeVBaoGDXrJ1f7WkAPb4Uo0c5DvQtz8g04EnEdC58oqDKfPSKD/yRhKsZJEXjNVEBBr
         Ba5w==
X-Gm-Message-State: AOAM533FLaH+YZMYJt/UKZfFf6ftJufcwvvhIAAjjyqMH82AeJMPApig
        XVziDakMGzhtcOZWbzA//Y6jopBfpzk=
X-Google-Smtp-Source: ABdhPJwoiUfhmrhw3gvKvLm0/TnJeYPXJ2a6WEYTX85rqgL8nQDXSlQ9L0nFByJnJ/KgagaHyQmsmA==
X-Received: by 2002:aca:c704:: with SMTP id x4mr3919833oif.92.1591126885918;
        Tue, 02 Jun 2020 12:41:25 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 10sm848509otq.52.2020.06.02.12.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:41:25 -0700 (PDT)
Subject: Re: [PATCH] kunit: Fix TabError, remove defconfig code and handle
 when there is no kunitconfig
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200529192845.60468-1-vitor@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ce991545-b849-1afb-8e20-839ce7a38eb9@linuxfoundation.org>
Date:   Tue, 2 Jun 2020 13:41:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200529192845.60468-1-vitor@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/29/20 1:28 PM, Vitor Massaru Iha wrote:
> The identation before this code (`if not os.path.exists(cli_args.build_dir):``)
> was with spaces instead of tabs after fixed up merge conflits,
> this commit revert spaces to tabs:
> 


Applied to linux-kselftest kunit branch for Linux 5.8-rc1

thanks,
-- Shuah

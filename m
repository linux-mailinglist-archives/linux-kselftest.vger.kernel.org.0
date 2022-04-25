Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFF50E9C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiDYTx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbiDYTx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:53:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4EAE4F
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c11-20020a9d684b000000b00603307cef05so11551137oto.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+Ynvk9k1i6GQRM+MV2+9dS2nsvFZOplFS8XjPwj2JY=;
        b=GPpJwnCA0IxWGmcqd1hVFKoiy5X3+AVVBOkwbZ/JEOUEubYt1lAPeL97pgFt/nzeFc
         wxnIjUzDR8+z/RBbbYsj0N5yJMPdrFRt0OqkYA844bieBt10LtJerxKhrvk/YDLbLJ0t
         s2oyhy/wqR0WZad03VhvPHIhR/GG6TEXSTSi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+Ynvk9k1i6GQRM+MV2+9dS2nsvFZOplFS8XjPwj2JY=;
        b=PCIQAfLJ/qEGFjt8ApHXLUpaPvuAw4tLssB8sPZVl/Ys8xLOdlFoCOwr9RvFhoAN85
         cMYnlrcas9agFF05pTqFID9l0dTOF8NwiKLZRAwLSKrDggOqndBPHzK6xSDyAyceXWKr
         rpVjaKB7WH2MOImRzgkQL3wKI7mhv6EYkSC8OafkCY0hXXDzvm1AdVJsVilPcEnMwvGo
         NJoQ4wtkrVRh8hXhYm0p5J5lKFIB/kkG45hooRaD/5dVtxmqwz6bDsNAtZHcctKu1C7d
         FOAi6swf5xRx0wSAktlI1yecxi8lCDmstEwjiiDou1D/9l3IMqk70cPe3xROYk8pLl0a
         Ri7w==
X-Gm-Message-State: AOAM533G4fachw7SbzGTT6M6eFQfLOfd0ufi48f8lOj4jThbm86+zX6W
        V0H6FzojK/plnPGMycpu3kD1ng==
X-Google-Smtp-Source: ABdhPJzTgZoKtLqoY7J9I5gpYl71byRdQ1d52bOYMiiAaw+SjxaTSA+6aWkNJpJtbdSDGr7PsZYj8w==
X-Received: by 2002:a9d:6283:0:b0:605:4ee4:6d56 with SMTP id x3-20020a9d6283000000b006054ee46d56mr7042496otk.89.1650916220282;
        Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g11-20020a9d5f8b000000b00605bff9c2dbsm768166oti.42.2022.04.25.12.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:50:20 -0700 (PDT)
Subject: Re: [PATCH 5/5] selftests: firmware: Add ZSTD compressed file tests
To:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220421152908.4718-1-tiwai@suse.de>
 <20220421152908.4718-6-tiwai@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e629df2a-93f2-8e82-31c5-ceb5b295f71b@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 13:50:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421152908.4718-6-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/21/22 9:29 AM, Takashi Iwai wrote:
> It's similar like XZ compressed files.  For the simplicity, both XZ
> and ZSTD tests are done in a single function.  The format is specified
> via $COMPRESS_FORMAT and the compression function is pre-defined.
> 
> Link: https://lore.kernel.org/r/20210127154939.13288-5-tiwai@suse.de
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   .../selftests/firmware/fw_filesystem.sh       | 76 ++++++++++++++-----
>   tools/testing/selftests/firmware/fw_lib.sh    | 12 ++-
>   2 files changed, 65 insertions(+), 23 deletions(-)
> 

Thank you.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF250E9BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbiDYTvY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiDYTvW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:51:22 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9BC2E0B7
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:48:17 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v65so13610721oig.10
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/EnU/d9QKnTLGmWwNJUz7mMlNpL7+lEmIj3Fglf+wp8=;
        b=XBki7vtLbTutCNRtm9fAJvrXKdYc5O24CoQ6wpErn5btmCvGDTWk5f9Z9EE2dfJw09
         Zb4fpeO3zq+RG/fwXraU10vtIBTAQg+sVWqI/PqW0Rg4qnoNJ7/j4YzZfDNYekyHcsom
         dUSZW+Yarzf18DVQVjnCDT1r6dxlQ485YXozQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/EnU/d9QKnTLGmWwNJUz7mMlNpL7+lEmIj3Fglf+wp8=;
        b=e2dm5HuDZDvTu/dj994qmCU6LZdHKaIRr+oZEkdVeX0t2ZCRmZJZanTrw+HjYTOJt2
         k4bYOclva4LBLozD1hYlRDskt8a6Dlb6qzrAa4uVNThy/9E/2y7QZgoPwY07YUqBeAPe
         XYDmNGkBeHpsT6N083qVBMXXJ7Igp7cbMrZUMLaA2d3c7Q/iJd7q1WG8CCHwxGyf5T9b
         rCmWQ+dRvEckiXu2H8JNayFgsnhCgsA8u51ed6PbYYEmcgT4feRbGc+2PW8ffC3q6j9d
         OEdmapzqpqXXAGx2RX4WhwIezEg3E56J4Uyc5gcHYl+UKfazZGCDn+0mv+0mgGzb4nst
         Ri7w==
X-Gm-Message-State: AOAM530Gk/l2H6VtuZBzrh7VeHweI/eIw+IAt78JhHrs/WEBllJCEkEu
        wSWtJgPnq+290T3KkXjxs7dSxg==
X-Google-Smtp-Source: ABdhPJzPlw4OkeMbu2IN5y9SG5J7CK4Z09Bz5TRASuvuJMOTrcFBIiDDiy67wK6SD4ZhcSIoxuso7w==
X-Received: by 2002:a05:6808:218d:b0:322:be7f:e113 with SMTP id be13-20020a056808218d00b00322be7fe113mr13077064oib.246.1650916096507;
        Mon, 25 Apr 2022 12:48:16 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id eb2-20020a056870a88200b000e686d13884sm43403oab.30.2022.04.25.12.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:48:16 -0700 (PDT)
Subject: Re: [PATCH 4/5] selftests: firmware: Simplify test patterns
To:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220421152908.4718-1-tiwai@suse.de>
 <20220421152908.4718-5-tiwai@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <46b53735-5232-17ef-f8c1-d603aa7739c4@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 13:48:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421152908.4718-5-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/21/22 9:29 AM, Takashi Iwai wrote:
> The test patterns are almost same in three sequential tests.
> Make the unified helper function for improving the readability.
> 
> Link: https://lore.kernel.org/all/20210127154939.13288-1-tiwai@suse.de/
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---

Thank you. It helps with maintaining this code easier.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

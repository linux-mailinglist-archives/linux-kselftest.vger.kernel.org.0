Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6C3ED06E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Aug 2021 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhHPImM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Aug 2021 04:42:12 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:60732
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234025AbhHPImL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Aug 2021 04:42:11 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id E388D40CAC
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Aug 2021 08:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629103299;
        bh=+xUEc/qm1PzDJP5u3baZXXtjTc7h8rBhDiakdDHi1yM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=pnAUd2JV346AM2Zd1HY1VEMopx6ly3bxdpElZxYAgiC4Gt9uopwvgX4M5gguwynQp
         gQGW/RSCAxlpgVN9QhmwnXJqekZLjuXMI0r9aljvrlV2/oZjkK04Bi+O79SM2GX00Z
         h19nzNcvnwm/vFXMLPpwnfK7LDeib5x7FSwoefrnxbDgmxD+wnZzM4zZ9s2bjFktAL
         3i5QEaM1KjWJO8/QEJiTa5nN8NiVUVpHqjO1EONR8PZuUcPzOluoSxOIm+BiuqcnBF
         nWYErUUureMUHX240NlYF5x4uQxE9I+AVA6whd6KC8tQ0PeedXaHuGL6cDHcjZKmUL
         O36vUCVww0OxA==
Received: by mail-ed1-f70.google.com with SMTP id e18-20020a0564020892b02903be9702d63eso7304523edy.17
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Aug 2021 01:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xUEc/qm1PzDJP5u3baZXXtjTc7h8rBhDiakdDHi1yM=;
        b=ToiypjjkQcqsEA5lgecdezD3f2K10JMkhLLeikEbNwH3drkYT9wa618cBzTz1lKQYO
         nqD+iANXBpvG5I2JOU5HczQEbp3ZnlbUq2mAXNF4tgihUDdZYzyl6VqIwUa/JW/u4VFY
         EfBWax4gJZd0oDY2mLoa+ktuGYWBeE6Lx+B3B8bNf6qs9Zf7MiqoOk2QnbNr5fN5aKqK
         uhVcgqAx6ckCVatWUovnneckBKaQjqDGQkYBpgEEwE0O1HZaAY3mc8/L0Tn+/N8jN8HO
         Z5MMbO+ZAwX5TKq818EOM8tr07bGdGjsHq1CvDOdDAXROc9uci2Jop/Bc6jupZxzH0UF
         hs8A==
X-Gm-Message-State: AOAM532MWq2B1tGdukXm8f1HIK/x97ZQDEb/A23p7uQc2mftQMNEI3QS
        9Vyu4iNMB7Dg+ZH/bvZXLnLQMXCJaE5vYMccNCcqcxZLwZPjmFCMHcm4o1zYSoa+6tZIpPf3JFt
        XacdNcfRGUvXvZkl2Z/+eU3F9kBUC1wJwbFy0SJQJ6JzpSQ==
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr15069798ejl.278.1629103299687;
        Mon, 16 Aug 2021 01:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh6pMzFSVOs7lSNGbKe0iJwJ55gCTC/3pF7/7l+/UXo12eilgMq1CpfKKWMAKorkvgL73RVA==
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr15069783ejl.278.1629103299522;
        Mon, 16 Aug 2021 01:41:39 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h13sm1523571ejq.77.2021.08.16.01.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 01:41:38 -0700 (PDT)
Subject: Re: [PATCH net-next 2/3] selftests: Remove the polling code to read a
 NCI frame
To:     bongsu.jeon2@gmail.com, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-nfc@lists.01.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Bongsu Jeon <bongsu.jeon@samsung.com>
References: <20210816040600.175813-1-bongsu.jeon2@gmail.com>
 <20210816040600.175813-3-bongsu.jeon2@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <03cfd784-72ce-9835-a6b4-3af6ed34f092@canonical.com>
Date:   Mon, 16 Aug 2021 10:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816040600.175813-3-bongsu.jeon2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 16/08/2021 06:05, bongsu.jeon2@gmail.com wrote:
> From: Bongsu Jeon <bongsu.jeon@samsung.com>
> 
> Because the virtual NCI device uses Wait Queue, the virtual device
> application doesn't need to poll the NCI frame.
> 
> Signed-off-by: Bongsu Jeon <bongsu.jeon@samsung.com>
> ---
>  tools/testing/selftests/nci/nci_dev.c | 33 +++++++++------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 

This depends on the patch 1/3 (the NCI change) so should go via the same
tree probably (or cross tree merge). Looks good to me:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519840734A
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Sep 2021 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhIJWUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Sep 2021 18:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhIJWUx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Sep 2021 18:20:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF3C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 15:19:41 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id q14so3586484ils.5
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Sep 2021 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q2q2tt2mrZO6cCReszztSL4ypwEDswnrQTtGtJCGJUE=;
        b=FN/Bo/Y2mKvITk5fX4RDdo/EOjbEl5HNP693ui7alCsnUPzSKnjXQSGDxopPyoPNfy
         S94yPZdeW/9/oxkiNatiRrCQM1uYOYRCMx3cb1/kZYqRBuQhZkDv4W3crFmeQPDjLj5o
         6Kpg1SJgeCbqCD9paidrzFq/vI3kfCkcc3d0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q2q2tt2mrZO6cCReszztSL4ypwEDswnrQTtGtJCGJUE=;
        b=UuG/I5bqslbre5OWKBghMW9QLrCau1BDmpXx32p//tToPiV2Sf+KibYqC6oixS5q9b
         LKyl935LEByoIkOulL/n/MAKYDgB7ykhVbaj9ECcKSuwhHosRxM2mVK0j5b+tvQY8X1T
         Cwq7jeduTODONkKxpnNO1HucBiVpOKxecbOxLmBDHPVFgUvm2XWzG64bwgZfciRXZcPK
         xXsF9xzQw31XuCAiZWpXKb7vpPfpVcKXiECqsKCTLBzSdeKcHF6Im+XuOIqLUcDwjvw0
         UhClMlodz992mNTNF3RUiYp90kDmACRoRONcEh5Tw3D9+gNP5GN8dxj36FOsYNKa3Iis
         mV0w==
X-Gm-Message-State: AOAM530GvAze7lDXdPlr3CVfMg0wuVLY8ZjHiGwv9pln57Q6zNpNYBw1
        iIdKdQxJ8GyzNQVU2CcEEirFhA==
X-Google-Smtp-Source: ABdhPJx5czYfpKhMlBBPu5m4CeFhOqRAnbQlMHVCkvr1ENOs2XiZ7N3+pkrA4pjeydS3feFdfRlyig==
X-Received: by 2002:a92:d852:: with SMTP id h18mr8339299ilq.211.1631312381107;
        Fri, 10 Sep 2021 15:19:41 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id n11sm3165349ioo.44.2021.09.10.15.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 15:19:40 -0700 (PDT)
Subject: Re: After KUnit update for Linux 5.15-rc1 - unable to share VFAT
 filesystem via samba
To:     Brendan Higgins <brendanhiggins@google.com>,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        David Gow <davidgow@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <6A72EAE4-A0F7-4CD2-89BB-36A8F4A7D321@internode.on.net>
 <CAFd5g46N6PuOrEyaqK4jRx1_NyVqgtPWvRc2=8vQ8xu2iS3Low@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fe9eaf40-bb77-ec3f-a5db-859b2e045327@linuxfoundation.org>
Date:   Fri, 10 Sep 2021 16:19:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g46N6PuOrEyaqK4jRx1_NyVqgtPWvRc2=8vQ8xu2iS3Low@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/10/21 3:23 PM, Brendan Higgins wrote:
> +David Gow - just FYI since you are the only KUnit person who touched
> VFAT. PTAL at other emails in thread too, please.
> 

Agree. Arthur confirmed CONFIG_KUNIT isn't enabled.

I requested for a quick test with (repeating this for David's benefit)

reverting the following one
at a time to isolate:

b0d4adaf3b3c4402d9c3b6186e02aa1e4f7985cd (this is the other one in
you bisect log)

c815f04ba94940fbc303a6ea9669e7da87f8e77d (This is the KUnit patch)
(This one shouldn't be in play without CONFIG_KUNIT)

thanks,
-- Shuah

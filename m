Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409191D1BEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 19:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389872AbgEMRJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEMRJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 13:09:14 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196AFC061A0E
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 10:09:13 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id j3so361041ilk.11
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OTwSFldhDgwfKavCOIqhkMtsv6Uf6dH3DgyIcps1eeU=;
        b=UoFwJ9P6t9qDrTAAi/bsDKZIYtkB3BOvVi3IZm4PBCwU9m/CWIgvpZHwAtNVrcsuBY
         VzkhnJUppqGiGUb8UBnF+yGIIn7MJ2nBDzvTtFkDQbXqqzQZMaodIo5rIcfIcQ9ZPwJI
         TrXHmQSzYqCHcF9yf7jkXjt9piz+fao1PBF9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OTwSFldhDgwfKavCOIqhkMtsv6Uf6dH3DgyIcps1eeU=;
        b=ouRJG2sdIdGDd6c3mkVIl5rgNXFoXSF3SHAnSZ9yFVO4SDYvSqSTe876ypTQwrSuRD
         1M9DQdbYeovHHLsJzFPHD2FCOA5uAP6tb+oiZ1ebes6/wW+7wnK//kYCg4G37OthiOR7
         lgj2gT+GK+0uli6vE1/DEN2h6DFLZPKDSw5poCTMppq07CYJ86HGdFnSF9Jd+UD+HGzv
         BQmBvzBJTV25sOtMuG/vT3jjAT3xyR7w7bvbQ83gXxFWXYhm+STIjF1wJeF3TeR7naL1
         5LOyUng1uuPceArDDLmcm9vSThXR2831Z4GDwP2RqDfvxT2f2MFNfHeHoIrRzSeACWE0
         tgZA==
X-Gm-Message-State: AOAM532RNiRc/6wuacnti6QNofttebmgn5lJu6SYjWMzcwhuZsuwnwOr
        ISLNflLpK4U1pnzb/98WTo5LEg==
X-Google-Smtp-Source: ABdhPJynHhzvyR2M0NLPpd7dWtvx0skkR3CAGs3ixp/82ITq2HUgE8/zq9IrmNdukPRZ1FYPD56CLA==
X-Received: by 2002:a92:6c11:: with SMTP id h17mr487372ilc.178.1589389752280;
        Wed, 13 May 2020 10:09:12 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k11sm97413iom.43.2020.05.13.10.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 10:09:11 -0700 (PDT)
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jukka.kaartinen@unikie.com
Subject: [ANN] linux-arts v2.0 update
Message-ID: <0c3bb5e9-d372-782b-2499-41ee61080c11@linuxfoundation.org>
Date:   Wed, 13 May 2020 11:09:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

linux-arts git has been updated with the new reproducers from
https://github.com/dvyukov/syzkaller-repros.git

- a total of 1138 new linux reproducers
- new script to collect reprogs from file system
- updates to README.md
- Updates to README on how linux-arts is synced with
   syzkaller-repros.git

This update can be found at:
     git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-arts.git

thanks,
-- Shuah

-----------------------------------------------------

Author: Shuah Khan <skhan@linuxfoundation.org
     linux-arts: Update README with process information

Author: Dmitry Vyukov <dvyukov@google.com
     linux: add 170 new repros from syzbot

Author: Dmitry Vyukov <dvyukov@google.com>
     linux: add 270 new local repros

Author: Jukka Kaartinen <jukka.kaartinen@unikie.com>
     Add reproducers from local builds

Author: Jukka Kaartinen <jukka.kaartinen@unikie.com>
     Add script to collect reprogs from file system

Author: Dmitry Vyukov <dvyukov@google.com>
     Update README.md

Author: Dmitry Vyukov <dvyukov@google.com>
     update linux reproducers

-----------------------------------------------------

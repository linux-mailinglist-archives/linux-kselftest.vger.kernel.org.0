Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3741E299522
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Oct 2020 19:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783973AbgJZSTT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 14:19:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783966AbgJZSTT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 14:19:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id 19so6503325pge.12;
        Mon, 26 Oct 2020 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0DNJ0t/C1pzRa+JekKOelQmdqY3jAoAvJFAIIwjzcxI=;
        b=c6YDideimVC9ltOEOo02MEpJTj4DfpF8esGdeorn6b8AKxkF2pvnqUpE2QT2H0erxX
         JoRwY66KYwZpVjGGuFaiKtUdcK1R875E38C++N6APPb6fh37p/ISu9OpW3OFJs3l55Gc
         2BSdnrzHCzSj6cBpdG3Nnhs/EFC+eu7Rh5cO0hesmHY6IW/xm5CVqaWmiCegmyrdUFcf
         Fsm8Nn6CPL3CZwXwunfBaZPVDe9wuDPlMlYK7mI6LsBq+xxaGzUS0VExrUKeLPbFOQWm
         6hNrp5T6GQ3lz0sXYDGDXjxHAr74WIyJhsmVJmkvE9KXA6Lf3VQQOuSzoI+Sr1B7Khjr
         3CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0DNJ0t/C1pzRa+JekKOelQmdqY3jAoAvJFAIIwjzcxI=;
        b=U0KU0N4M/cAQqhVLU6ypO5Y5AnsOLMUDuF2NBMW0TmK4Y7sW08avof+KsGeyQjTo0+
         bmaIBiEgcmmyLRTCwvOAC1sEEERXMsUlVSdQcWqYRcKQ1iZwNk0PbUxKlI9g7EXK99J+
         Ufbwva+xNUvO2sSFk8BmTOMFUxQw+2BBvdgT1zB5ttn+625xEGpZNynjENLEYyiB9Qyk
         v7nbJxTwR4hddekGLEYy4GO//yNr9CMjV1dmoxDJDgLSGdgJuPe4TN/aO0Y2uHJ23ePT
         JqCSUvWUreWu2EG7MfxC9+KenMef/keEI/gOH+3FESKztJpunuxV4nEBhhZ5JobroAd1
         AKPA==
X-Gm-Message-State: AOAM531iGl4MiDE5sqqIh8jGuNlBXlrSyFkpyY7HBXBjK5arNSCB+/kz
        KyQwmlpf1ZEIL3MzPIBkrWO1bGJFhgxj5LP6
X-Google-Smtp-Source: ABdhPJxICrpTjoswgcTyvvddScL1O78vUFhyOoRXNVbMst8q0gBSG2wFlklT73LGt3dE4sOW1OvFKw==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr18174458pgl.305.1603736357935;
        Mon, 26 Oct 2020 11:19:17 -0700 (PDT)
Received: from [192.168.86.81] ([106.51.240.100])
        by smtp.gmail.com with ESMTPSA id q13sm12604702pfg.3.2020.10.26.11.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:19:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Iurii Zaikin <yzaikin@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20201023150536.282568-1-98.arpi@gmail.com>
 <20201023150634.282631-1-98.arpi@gmail.com>
 <CAAXuY3q6c3d5kkLOqsG2LBmBYS4d9qRuEeZ2ChpJF1OVTkV5gw@mail.gmail.com>
From:   Arpitha Raghunandan <98.arpi@gmail.com>
Message-ID: <d3e31145-9286-a81d-3e76-8f23d6f6211f@gmail.com>
Date:   Mon, 26 Oct 2020 23:49:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAXuY3q6c3d5kkLOqsG2LBmBYS4d9qRuEeZ2ChpJF1OVTkV5gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/10/20 11:41 pm, Iurii Zaikin wrote:
>> +static struct timestamp_expectation test_data[] = {
> Can you mark this and the rest of the hardcoded values as the const they are?
> 

Sure, I will make this change for the next version.

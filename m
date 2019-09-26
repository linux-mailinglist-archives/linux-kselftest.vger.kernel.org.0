Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDABF7B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 19:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfIZRl2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 13:41:28 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:36060 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfIZRl2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 13:41:28 -0400
Received: by mail-io1-f47.google.com with SMTP id b136so8805581iof.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2019 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XCD2xeyPn+9SlMl+6tWPk/w4mgLYZgUgG9fP/+jHp2o=;
        b=baxHxB4Rlw7tG/EPVqBEdgNik5cSRnK+RIlWcRHg0973CSvw2W88u9DHRyBuEof7ej
         tL3T3T4fJ6IMo9CfD6wmUKHCvF1emLTG/QNyawFrUqnltB2yX7abe09yCsnzpSHk5ZnS
         vbtu/UZ0CAQWR0NGpPKm6yanDn4gy4jDd5/n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XCD2xeyPn+9SlMl+6tWPk/w4mgLYZgUgG9fP/+jHp2o=;
        b=a+GSLy4ZKcPnK8FKjPSfBjPLdNoM1qEbnHxGriFZvSTSQCVh/MC1seCnmA/EoLjA+g
         XrDg/ZgnZswDD4lWlnt5hFfpPQ4WUoduyLXRhQkanJfnBlZCDfDIf6t2hRC+taNz/9Gg
         sJw09G+eeAUfDlM+1pn1TZSku1J6OonjqcqxdHWuxhcPS5NehFkNky7tzd68RVsy5MB1
         pZr6SgzLXZlVw3XWX+apPT+oHYZCWb2re+YIrN/y1V0uFHsPNxEsK/AKyci2/BpNMpSQ
         ON0OHp4Ikp+/F8JiV8CKDkp1vyyfLMtB2PkhoSYXeMbAXkPZlYUeuA8P8c2qDJx3fL/z
         tH7g==
X-Gm-Message-State: APjAAAWXkofNIVQUs6Q3Q8sbI1r5L2fi1Smn7oiE2rLR/vCrAaYfuJJE
        X/OzceryVHPW7QMkAlPozfLRlw==
X-Google-Smtp-Source: APXvYqx/koFgVWPKTpLAEmigcGzPpnXH6yWphZJAuo49B1qLun85bmt3YrE2S6vhKb7Cq/R+XIbwAA==
X-Received: by 2002:a92:1794:: with SMTP id 20mr3547589ilx.62.1569519686624;
        Thu, 26 Sep 2019 10:41:26 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r141sm1628669ior.53.2019.09.26.10.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:41:26 -0700 (PDT)
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.4 kselftest known issues
Message-ID: <a293684f-4ab6-51af-60b1-caf4eb97ff05@linuxfoundation.org>
Date:   Thu, 26 Sep 2019 11:41:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here are the know kselftest issues on Linux 5.4 with
top commit commit 619e17cf75dd58905aa67ccd494a6ba5f19d6cc6
on x86_64:

The goal is to get these addressed before 5.4 comes out.

3 build failures and status:

pidfd - undefined reference to `pthread_create' collect2: error: ld 
returned 1 exit status

Fixed: https://patchwork.kernel.org/patch/11159517/

bfp (two issues)

1. "make TARGETS=bpf kselftest" build fails
Makefile:127: tools/build/Makefile.include: No such file or directory

This is due to recent kbuild changes and I have a patch ready to send.

2. Related to llvm latest version dependency. This is a hard dependency.
Unless users upgrade to latest llvvm, bpf test won't run. The new llvm
might not be supported on all distros yet, in which case bpf will not
get tested in some rings and on some architectures.

gpio

"make TARGETS=gpio kselftest" build fails

Makefile:23: tools/build/Makefile.include: No such file or directory

This is due to recent kbuild changes and I have a patch ready to send.

kvm

"make TARGETS=kvm kselftest" build fails due --no-pie flags.

I am working on a fix for this. no-pie-option defines aren't working
correctly and I suspect try-run miht not be defined in this kselftest
build case.

thanks,
-- Shuah












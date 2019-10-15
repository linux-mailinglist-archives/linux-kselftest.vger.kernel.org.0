Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58F4D7C21
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfJOQlj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 12:41:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37928 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfJOQli (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 12:41:38 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so47389653iom.5
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2019 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=tRzSr9D7wq6z+hebwYsgqPVMbJW75tZmFtmWm+HmcRg=;
        b=MSB81nUi5E4dUM7zV8rA6mfRRJbgHvySFiFsku1+kqg1dHP/zczas3djEbkwSZ+3Au
         +p9nn7KVpOsEkgflSVCFoy9OY18rW/x3y965HrVkRFnlZc3qMhtKxHGeJQRYWLzBt/sn
         ghb+wFWU9814QseWDGp9/tW+BNd6lRHwiPFbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=tRzSr9D7wq6z+hebwYsgqPVMbJW75tZmFtmWm+HmcRg=;
        b=CzgsonFALcLzhCmPLV2IkI3xOSjvU4PeH+PC2RKJySWk3rjKa4YRnBuPE85z+rzPmm
         VrFmYI2Y3MNTxUKma6JPsezopBZizJMGBpci7gi+MzeYpvA+in2pMuxCEjYrNNGn2Dbj
         3ErZJEcwG/FqER2zrEyN8Eztzq+FVa6GY0js22/02NoSlhbbDl+uxATvQDJBAiSXAcTk
         DBH6jMnjl9ID827jla+RZssvCRMZQ0HvSpUlImgrQcMg2af/ve6imBeiz6pBv3rGVHow
         SMRh0D5TiqW8WKqSssLBekQC0xFp+4Gw9/qHVUPTOL2p/KeAHk7oSg+GF0zG3ElL8gz8
         VEpg==
X-Gm-Message-State: APjAAAVSZRewTgQdwr1/D82GNz3wyoE2B+AcpmXg8bjAJhC6d0Aw5KPR
        1bqVK5mW+ESWnEELViUh9abkKg==
X-Google-Smtp-Source: APXvYqw6CUQBw83V8tWrlHbd72VWppzU9L3PITMpeFb5Lee1Y55NrGO+Qieaq5jMqOqctsz+OD/PVw==
X-Received: by 2002:a6b:5814:: with SMTP id m20mr22851617iob.242.1571157697917;
        Tue, 15 Oct 2019 09:41:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 28sm3483829ilq.61.2019.10.15.09.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:41:37 -0700 (PDT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [ANN] New git repository for Autogenerated regression tests
Message-ID: <190423b9-b363-a769-64b8-935b2632441e@linuxfoundation.org>
Date:   Tue, 15 Oct 2019 10:41:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I created a new kernel.org repository for compiling and preserving
Autogenerated regression tests. This is an outcome based on decision
made at the Maintainer Summit to preserve and use the autogenerated
reproducers for regression testing.

Linux Kernel Autogenerated Regression Tests
===========================================

linux-arts repository is dedicated to preserving the autogenerated
regression tests for regression testing.

Automates testing entities such as Syzbot generate reproducers to test
the kernel. It is a manual process to download reproducers and once the
bug is fixed, kernel developers loose track of these reproducers.

As per the decision made at a session at the Maintainers Summit 2019,
this git repository is created to preserve the reproducers.

Please find the details on the discussion that lead to this decision
at https://lwn.net/Articles/799162/

Please find the new git repo at:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-arts.git/

The initial commit pulls in Syzkaller reproducers from Dmitry Vyukov.
As per Dmitry's request, the run and build scripts have been updated
to with just the syzbot link.

Thanks Dmitry for compiling these reproducers and working on the
framework of running and building them.

As for reproducers, each .c is specific to syzbot report and named
with the syzbot bug report ID.

Please play with it and let me know if you have questions. README
has the details on where to send patches and regressions tests.

thanks,
-- Shuah

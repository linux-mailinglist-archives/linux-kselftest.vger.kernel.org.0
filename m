Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C20CEBCB4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2019 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389640AbfIXP0U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Sep 2019 11:26:20 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45983 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389582AbfIXP0T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Sep 2019 11:26:19 -0400
Received: by mail-io1-f53.google.com with SMTP id c25so5375522iot.12
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2019 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Yr5Mo3WHl/yOvwgg0YNpmUPu8Tiu07BhSBPPa7tP7Zo=;
        b=NiCQajc4fyS6M4O7Vawf3lQ6n/SbhZ3/Wr+ouArIYjeiepO+92iV2a5Kxqd7SJ8iTf
         WNncpTHlX2UwXBkC/saKz2Ujx7GvX8+p5z85E946S1iVTT1t0q5wb4cHqlaE1/ojjcyc
         yltjsNL8zppqTV3i81NQ8ExrqweP41gy5R5Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Yr5Mo3WHl/yOvwgg0YNpmUPu8Tiu07BhSBPPa7tP7Zo=;
        b=iXqlKyf6aMFps8vfVFlNHD9TuqNVrP6OscTVJfL/NiCI/AD0HBAqQTfGa1qmj7SJPi
         M+7v9rdR3A98MOlO7CimYyoIjJLsne+Y8cRFNIHiFjgrHTNyhAwzTFoQMd6Ih6xYNabQ
         75pnr4dIczOmouyu2bc1JyeNWzzUn7L8I/vTd4BLXP95CC9/zV3Aq8b3timh5FnbHboq
         qLnmsAGnTwnhgG8HCDzz+v59EpaR/6JEAvI2wZ/r+5cTTnv1O4+4KscNcba1ngbYUN+z
         w1pii8I1xn9wE8Me68vuPUxSJWgd/PoxQ8d6dIpP18iImTvVmgcpFhtrDw1gufgsp/Tx
         CQWA==
X-Gm-Message-State: APjAAAWTNsFTsdKSZgXHGXb0IVRGMnwUhqFsotClUSPCuC3wtv83cpqI
        F1J4TP5lZdDx82Mf19wWy4o/BDXrKm0=
X-Google-Smtp-Source: APXvYqyWy6+zyZGvmi5rliR5Hyl2Lq8/pIrijIw+kfxBTPTALATUU/CPnahSq0l8mq1FbjXFFwI5IA==
X-Received: by 2002:a02:a612:: with SMTP id c18mr4246484jam.109.1569338778311;
        Tue, 24 Sep 2019 08:26:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l186sm3864317ioa.54.2019.09.24.08.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:26:17 -0700 (PDT)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.4 - bpf test build fails
Message-ID: <742ecabe-45ce-cf6e-2540-25d6dc23c45f@linuxfoundation.org>
Date:   Tue, 24 Sep 2019 09:26:16 -0600
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

Hi Alexei and Daniel,

bpf test doesn't build on Linux 5.4 mainline. Do you know what's
happening here.


make -C tools/testing/selftests/bpf/

-c progs/test_core_reloc_ptr_as_arr.c -o - || echo "clang failed") | \
llc -march=bpf -mcpu=generic  -filetype=obj -o 
/mnt/data/lkml/linux_5.4/tools/testing/selftests/bpf/test_core_reloc_ptr_as_arr.o
progs/test_core_reloc_ptr_as_arr.c:25:6: error: use of unknown builtin
       '__builtin_preserve_access_index' [-Wimplicit-function-declaration]
         if (BPF_CORE_READ(&out->a, &in[2].a))
             ^
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^
progs/test_core_reloc_ptr_as_arr.c:25:6: warning: incompatible integer to
       pointer conversion passing 'int' to parameter of type 'const void *'
       [-Wint-conversion]
         if (BPF_CORE_READ(&out->a, &in[2].a))
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./bpf_helpers.h:533:10: note: expanded from macro 'BPF_CORE_READ'
                        __builtin_preserve_access_index(src))
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning and 1 error generated.
llc: error: llc: <stdin>:1:1: error: expected top-level entity
clang failed

Also

make TARGETS=bpf kselftest fails as well. Dependency between
tools/lib/bpf and the test. How can we avoid this type of
dependency or resolve it in a way it doesn't result in build
failures?

thanks,
-- Shuah

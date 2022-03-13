Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98714D76A3
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Mar 2022 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiCMQLE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Mar 2022 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCMQLD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Mar 2022 12:11:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB5726115
        for <linux-kselftest@vger.kernel.org>; Sun, 13 Mar 2022 09:09:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 4BB1A1F43C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647187793;
        bh=vh+NG2iUylxYDfw9WycUZjfrDY36iF77QQdLF5UdAyM=;
        h=Date:Cc:From:To:Subject:From;
        b=SeTcLr79BCa7PZZATIf2LhPNSAWls7Id2+yXENWN0AVJLJzpIL/g7q+YVW+keWrr3
         PoDCsFzFPt+bazK96yqkbUkhgjZ+nNEjxZ26epISuKGrjKAI0BaEylwVbjUjTd3S46
         Zvx7tOCdsqaAYms8fERqKwbQrdx5TtD5sjCO/LcVXj8uu4lx9l8+MIa9r4J4Ki6GrE
         eX8YrdQwGMbDrohnRDqUIzTmAitkD9f/CB3EnY+epiFpPT/v9VjrMkALE+lKpv8N6N
         qSnTfbn+9OjSIStolMpXgc3SeE/CHbGveiX8p/Z66+frOyoiTVTid1V1juvny3nzAK
         JLq9AOc7dZ9nQ==
Message-ID: <8907d4a9-2a3f-3442-2c5e-6c34f196d2a8@collabora.com>
Date:   Sun, 13 Mar 2022 21:09:44 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com, Shuah Khan <shuah@kernel.org>,
        "kernelci@groups.io >> \"kernelci@groups.io\"" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>
Subject: [bug report] selftests: futex: warning during build with multiple
 jobs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On linux-next
cd tools/testing/selftests/futex && make clean -j 32
gives warning
make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent
make rule.
The full logs with with different reproduction steps can be found here:
https://storage.staging.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+kselftest/gcc-10/logs/kselftest.log.
Usually this type of warning shouldn't come when $MAKE is being used
instead of make in Makefile.

Maybe `define CLEAN` inside override construct defined in parent
makefile is not getting jobsever information when child make process
executes. I've enabled verbose mode and tried with other makefile flags
(-p, -d etc) as well. Documentation mentions that if make is unable to
identify the child process correctly, this warning will appear.

Please share if you have any thoughts on it.

-- 
Muhammad Usama Anjum

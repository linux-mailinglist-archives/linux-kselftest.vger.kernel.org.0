Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAC5FC71B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJLORn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJLORl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 10:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972F6558E
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Oct 2022 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665584259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PqNcyRrP+8DZEGChD9ht0LMFr5rp4+16v3Kx7IRTLeU=;
        b=KTwpm90HBMTVVpdgmrx+obfr+NtqLm9lgi+GsumtzE7p65S3EAVc2UW8bqOCDWy4d9646c
        AfvXbO5wYmd8yBmzbatVvc7CDrKrpDFDymPiFeo6lQwkMdpzR/MMMI8swKUPBHWXaAue/U
        Cbw2sza7Jr5WGnVXc1pSGpfHXy3s650=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-zlOX9nvwPfmVT8roPrHPIQ-1; Wed, 12 Oct 2022 10:17:38 -0400
X-MC-Unique: zlOX9nvwPfmVT8roPrHPIQ-1
Received: by mail-qk1-f198.google.com with SMTP id bk21-20020a05620a1a1500b006be9f844c59so14249430qkb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Oct 2022 07:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PqNcyRrP+8DZEGChD9ht0LMFr5rp4+16v3Kx7IRTLeU=;
        b=FID9Wxz9hw9zR/Xq5d2xU3hR4RJj7wIgJiGkmMOsBFUN6xzkfBTdk2LTWqK6lXjKkm
         ec4KyKVQ/uUCveXrZxKgb0wmd7hMEqZoM17c+7SAzsiCtNXDMCwqCPQvmo02+DMic9lN
         yCN7CIJGK6qN597J31UFZpBTWrFCgieCkdJdGLiGMQY39G9rfvmry6u6FAo69ttekQ6j
         kVlVJ5UJj1rz7330X/0nFzxw3YfivXjmahrw84U438+g5FId8sY9z1bH3a4vsOinaFvM
         MB4hR5Bv/ZqwJi71hsogFPDqGmdKamO+LBj/Lc3ROguSgEpcBc+HE17NoiUxfbRBzgI+
         5Q2g==
X-Gm-Message-State: ACrzQf2RquMsjgNDPfGOeM5zQN2NbwreTfeHPpHThTSp23jM5QdWYOzL
        XlSMJzvEicR+Wc1u7Hd3w5keVCLICXw6CUVKkD0ePKwHxJ8FByP+PQSgxbPbCfPq6VGs2hkk20D
        RsKNMqkgLwYbFsWFBMnBcUOfVdOIK
X-Received: by 2002:a05:620a:4389:b0:6df:835f:98d1 with SMTP id a9-20020a05620a438900b006df835f98d1mr20056744qkp.169.1665584258030;
        Wed, 12 Oct 2022 07:17:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FxTwZZi39mwa8PKie9WngIRS/F/Oe7XY167zbsWAmD5qRGj1LNwyKjGPVfYRIbfgKqM+izA==
X-Received: by 2002:a05:620a:4389:b0:6df:835f:98d1 with SMTP id a9-20020a05620a438900b006df835f98d1mr20056727qkp.169.1665584257817;
        Wed, 12 Oct 2022 07:17:37 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id de14-20020a05620a370e00b006e07228ed53sm12251619qkb.18.2022.10.12.07.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 07:17:37 -0700 (PDT)
Message-ID: <40f04ded-0c86-8669-24b1-9a313ca21076@redhat.com>
Date:   Wed, 12 Oct 2022 10:17:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
From:   Jonathan Toppins <jtoppins@redhat.com>
Subject: kselftest: bonding: dev_addr_lists.sh doesn't run due to lack of
 dependencies
To:     Benjamin Poirier <bpoirier@nvidia.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When kselftest for bonding is built like:
$ make TARGETS="drivers/net/bonding" -j8 -C tools/testing/selftests gen_tar

and then run on the target:
$ ./run_kselftest.sh
[...]
# selftests: drivers/net/bonding: dev_addr_lists.sh
# ./dev_addr_lists.sh: line 17: ./../../../net/forwarding/lib.sh: No 
such file or directory
# ./dev_addr_lists.sh: line 107: tests_run: command not found
# ./dev_addr_lists.sh: line 109: exit: : numeric argument required
# ./dev_addr_lists.sh: line 34: pre_cleanup: command not found
not ok 4 selftests: drivers/net/bonding: dev_addr_lists.sh # exit=2
[...]

I am still new to kselftests is this expected or is there some way in 
the make machinery to force packaging of net as well?

Thanks,
-Jon


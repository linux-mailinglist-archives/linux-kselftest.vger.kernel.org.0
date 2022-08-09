Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5354D58DBC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbiHIQUV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244942AbiHIQUS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 12:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2813DCB;
        Tue,  9 Aug 2022 09:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0008B81627;
        Tue,  9 Aug 2022 16:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5148CC433D6;
        Tue,  9 Aug 2022 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660062014;
        bh=pH94ZgNSPsft0KMGKgNtAAy5I1z5p+RQ7sS2YK/gSFA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KzaIq/DjAPWWMODx0NABsh615wiKrLh3RKkH1WfZpnARD84xYVrv2HCtf+SNjD7tx
         OJ03GVvaQjO1E9TZ5PMAhlhG4SIkummt3jUGCPyxynksYTlamx3y/BSraS8+09CuX/
         ywBaMi7L/xRaKm3lpN//DKdEuLhbz6p34ZTAk1i4ZHARb6DSOSXhlA+lFoH+olJ0aq
         tOf9OEQS6eQZFaDgZBQS65RW9bwIAjAuA8pLMEN0iIrWPiNTglaXsMWXXEveanGbTG
         C1xjhCiJ1Dcaw/kmR2O+qqDU7YSV5TU8hbg2FtDoRJMYpIZR0hMI8sUNAtNR5xYstN
         i1ti62C1lp60w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35F78C43140;
        Tue,  9 Aug 2022 16:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 00/10] bpf: Add kfuncs for PKCS#7 signature verification
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166006201421.29142.5957999549167447991.git-patchwork-notify@kernel.org>
Date:   Tue, 09 Aug 2022 16:20:14 +0000
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
In-Reply-To: <20220809134603.1769279-1-roberto.sassu@huawei.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, corbet@lwn.net,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 9 Aug 2022 15:45:53 +0200 you wrote:
> One of the desirable features in security is the ability to restrict import
> of data to a given system based on data authenticity. If data import can be
> restricted, it would be possible to enforce a system-wide policy based on
> the signing keys the system owner trusts.
> 
> This feature is widely used in the kernel. For example, if the restriction
> is enabled, kernel modules can be plugged in only if they are signed with a
> key whose public part is in the primary or secondary keyring.
> 
> [...]

Here is the summary with links:
  - [v9,01/10] btf: Add a new kfunc flag which allows to mark a function to be sleepable
    https://git.kernel.org/bpf/bpf-next/c/fa96b24204af
  - [v9,02/10] bpf: Allow kfuncs to be used in LSM programs
    (no matching commit)
  - [v9,03/10] btf: Handle dynamic pointer parameter in kfuncs
    (no matching commit)
  - [v9,04/10] bpf: Export bpf_dynptr_get_size()
    (no matching commit)
  - [v9,05/10] KEYS: Move KEY_LOOKUP_ to include/linux/key.h
    (no matching commit)
  - [v9,06/10] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
    (no matching commit)
  - [v9,07/10] bpf: Add bpf_verify_pkcs7_signature() kfunc
    (no matching commit)
  - [v9,08/10] selftests/bpf: Add verifier tests for bpf_lookup_*_key() and bpf_key_put()
    (no matching commit)
  - [v9,09/10] selftests/bpf: Add additional tests for bpf_lookup_*_key()
    (no matching commit)
  - [v9,10/10] selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



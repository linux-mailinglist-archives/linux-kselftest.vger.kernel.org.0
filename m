Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D315E57C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 03:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIVBKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 21:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIVBKW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 21:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D8DFD0;
        Wed, 21 Sep 2022 18:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE15B63343;
        Thu, 22 Sep 2022 01:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11191C433D7;
        Thu, 22 Sep 2022 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809020;
        bh=JQYpUNVHmmWqqXAXWDbpfQz1G7DdV3xIEvXth+vs+eE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c0PJHJkL4zQlong+cLZwqtdSIVI1lzbtkLA2s3IdFJOKBUq2IL6fozJFi4bAp9yQI
         2qBAluRvsHqdjKJOPdnM14aGcMdp+0EifvqIQ4bG4w/gHxuxmmmRiC8wR4TXn8qv12
         BiXIYJ4+/47tqw0RsBTBktnTbDqtJdBS7A8ew/GDFOJwEhYkv2lmsgVVaPmqWrxUlE
         KJoe/CFeVri62F4CZHA6ei5JhDZf35duMIEQgqi15k0ZATIf6VZZt+9x3q3+YpDcLE
         MJzIo+cqgNfmTWz7+NAbjU1UlpnbLSIK1t0DD96PXhQf9IvYeAuwscpkkCHbFJe9JZ
         nSSdkyw676YnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3658E21ECF;
        Thu, 22 Sep 2022 01:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v18 00/13] bpf: Add kfuncs for PKCS#7 signature verification
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166380901992.22214.9738927038585872619.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:10:19 +0000
References: <20220920075951.929132-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220920075951.929132-1-roberto.sassu@huaweicloud.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com, roberto.sassu@huawei.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 20 Sep 2022 09:59:38 +0200 you wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> One of the desirable features in security is the ability to restrict import
> of data to a given system based on data authenticity. If data import can be
> restricted, it would be possible to enforce a system-wide policy based on
> the signing keys the system owner trusts.
> 
> [...]

Here is the summary with links:
  - [v18,01/13] bpf: Allow kfuncs to be used in LSM programs
    https://git.kernel.org/bpf/bpf-next/c/d15bf1501c75
  - [v18,02/13] btf: Export bpf_dynptr definition
    https://git.kernel.org/bpf/bpf-next/c/00f146413ccb
  - [v18,03/13] bpf: Move dynptr type check to is_dynptr_type_expected()
    https://git.kernel.org/bpf/bpf-next/c/e9e315b4a5de
  - [v18,04/13] btf: Allow dynamic pointer parameters in kfuncs
    https://git.kernel.org/bpf/bpf-next/c/b8d31762a0ae
  - [v18,05/13] bpf: Export bpf_dynptr_get_size()
    https://git.kernel.org/bpf/bpf-next/c/51df48657185
  - [v18,06/13] KEYS: Move KEY_LOOKUP_ to include/linux/key.h and define KEY_LOOKUP_ALL
    https://git.kernel.org/bpf/bpf-next/c/90fd8f26edd4
  - [v18,07/13] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
    https://git.kernel.org/bpf/bpf-next/c/f3cf4134c5c6
  - [v18,08/13] bpf: Add bpf_verify_pkcs7_signature() kfunc
    https://git.kernel.org/bpf/bpf-next/c/865b0566d8f1
  - [v18,09/13] selftests/bpf: Compile kernel with everything as built-in
    https://git.kernel.org/bpf/bpf-next/c/94fd7420faa0
  - [v18,10/13] selftests/bpf: Add verifier tests for bpf_lookup_*_key() and bpf_key_put()
    https://git.kernel.org/bpf/bpf-next/c/7c036ed9e006
  - [v18,11/13] selftests/bpf: Add additional tests for bpf_lookup_*_key()
    https://git.kernel.org/bpf/bpf-next/c/ecce368d6e6d
  - [v18,12/13] selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc
    https://git.kernel.org/bpf/bpf-next/c/fc97590668ae
  - [v18,13/13] selftests/bpf: Add tests for dynamic pointers parameters in kfuncs
    https://git.kernel.org/bpf/bpf-next/c/b94fa9f9dcf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



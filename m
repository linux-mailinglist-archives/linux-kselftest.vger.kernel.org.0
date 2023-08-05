Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333D1770CA3
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 02:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjHEAXs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 20:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEAXr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 20:23:47 -0400
Received: from out-67.mta0.migadu.com (out-67.mta0.migadu.com [IPv6:2001:41d0:1004:224b::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58534694
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Aug 2023 17:23:45 -0700 (PDT)
Message-ID: <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691195024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eUPA7Rbj5jk/MQgWgg+tKqw5KVGmICrIzOFj3UTUAGM=;
        b=FMHWlSfzy1ema2iNWXS3cVRO55vunCyX23YpRCcUf0/fa1sl2w6jsF7fSBZwDCRpY8O/D/
        5rP/MpM2zW1gjLe3Tz2hWCPiehr5qwYBnHJysFDtQgOo4Y6t6HPHYVjqdEbz9hyzVcknx6
        GC0H0RtkOPxfj0cMf2/v1V6Oje/VOlo=
Date:   Fri, 4 Aug 2023 17:23:32 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name for
 mptcp
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Simon Horman <horms@kernel.org>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/3/23 10:07 PM, Geliang Tang wrote:
> Use rand() to generate a random netns name instead of using the fixed
> name "mptcp_ns" for every test.
> 
> By doing that, we can re-launch the test even if there was an issue
> removing the previous netns or if by accident, a netns with this generic
> name already existed on the system.
> 
> Note that using a different name each will also help adding more
> subtests in future commits.

I run test_progs repeatedly without rebooting qemu to save time. If there is a 
test did not clean up its netns, I would rather uncover it earlier and fix it 
instead. Randomizing the name is hiding the issue and does not help to uncover 
the broken test sooner. Although this change is to mptcp test alone, this could 
be referred in other future tests.

afaik, I don't remember bpf CI ever run into a test failure because the picked 
name had already been used by the system. It seems you ran into this issue a lot 
with the mptcp test in your setup. Could you explain a little more?

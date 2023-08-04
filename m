Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C676F8EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 06:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjHDE2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 00:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjHDE2U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 00:28:20 -0400
Received: from out-64.mta0.migadu.com (out-64.mta0.migadu.com [IPv6:2001:41d0:1004:224b::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7D35BE
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 21:28:18 -0700 (PDT)
Message-ID: <9c0782dc-fdca-0d1c-cff4-ae1d6d719be8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691123297; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbgBz/V1FEoSIgXNZpUefJzk9EepjHTLpSPYF/inviw=;
        b=VBGFNtfKWDJkAJ2SKUFiYOZh1haS80rSUi2y5XNqMSQZey40nygqXeA58PP85P37CaHihX
        LSXTA36qw/+YjWfW5UPZeU6vM0SReqMgwn7/i5DCWow8pjLQFcZQZM4cP4x/4UsufM8uhk
        7tOZuRKCG8BRiB9czPaRkqG9qpRJGKs=
Date:   Thu, 3 Aug 2023 21:28:00 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v10 1/5] bpf: Add update_socket_protocol hook
Content-Language: en-US
To:     Geliang Tang <geliang.tang@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
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
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691113640.git.geliang.tang@suse.com>
 <079989b68ddded562b9f2149cc50642072575001.1691113640.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <079989b68ddded562b9f2149cc50642072575001.1691113640.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/3/23 6:55 PM, Geliang Tang wrote:
> Add a hook named update_socket_protocol in __sys_socket(), for bpf
> progs to attach to and update socket protocol. One user case is to
> force legacy TCP apps to create and use MPTCP sockets instead of
> TCP ones.
> 
> Define a mod_ret set named bpf_mptcp_fmodret_ids, add the hook
> update_socket_protocol into this set, and register it in
> bpf_mptcp_kfunc_init().
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/79
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

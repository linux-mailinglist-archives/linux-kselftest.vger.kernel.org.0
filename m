Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7520742588
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjF2MRG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 08:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2MRE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 08:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E811430D1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688040972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRtfZg4SPW/dfExfHKxyTm+z8to08LGorkhnQOIa1Ew=;
        b=DcXCcey3hZQkbG7IOdhT4/gA367sqKMgOz7kmRT3lXwccO6FcRg1ZyjjL8FOcFsa1XDwhp
        YUZNvWnJR+bpfUn4EH07EkBEGs4fgJCt53mjC0WgBUETTb/F2m8Q5J8NYi6l30NKssgIE5
        fxQ5AjZNxUCJizzbVQfxdcFofdrsetk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-aqz3mhXbNSuAWIPFWbQuIg-1; Thu, 29 Jun 2023 08:16:11 -0400
X-MC-Unique: aqz3mhXbNSuAWIPFWbQuIg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-98864f473c7so43278366b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688040970; x=1690632970;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRtfZg4SPW/dfExfHKxyTm+z8to08LGorkhnQOIa1Ew=;
        b=Ntzk/VBQ40xhN7vE2SJuZbcwR1QSxSmFhxDIwUm6kVfx8UHL5IQfPthiaWCgeggry+
         vZfs59XAOJFYPjeD9RV1ltN46Y5tgbMRsOd2l5mLNOt1QbDCcuhUvPhhkRS57swLVP3X
         RU5OQoR9fAzXWFKxLifAS72a1mFqSG2HyzD2x6i6/lVDWJ0+Y8NC74mrPVYsTncRu34A
         BifuMouV3Daaj2op/vqDnN34o6OfocprITmTvC419NoYiaaRsMLeKeVbfV01eEOfXAW+
         LDabLvBDPFYIIv6e3MoBBW0jcjM+8T3ktUwDCG82yLYZluxar4gGzTA+cIsZSZSK43UP
         8Niw==
X-Gm-Message-State: AC+VfDzfvxQxF7GR+hgNKuMh4YxmeA9ppvmgHqHPfXYXuhCuTFYHnxlE
        xcKrrL8YFIZ4f7Rw3SrusUWHZAHmqdKhtO0ly17q7E0PLb/bX1y2d2zMODP1aK7qPW90LmMk4fC
        hnhuF00MXSJ+W2EJ3Og2bIbD5reHeoygboom0
X-Received: by 2002:a17:907:7ba5:b0:982:9b01:a57c with SMTP id ne37-20020a1709077ba500b009829b01a57cmr35983865ejc.12.1688040970185;
        Thu, 29 Jun 2023 05:16:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ440Dob8tg/t5hFb4HMywtZ2vhJhTJbVaJ/t/Vr2iJNg951ErahzdstJyCHl3lyIqlaAIFN+A==
X-Received: by 2002:a17:907:7ba5:b0:982:9b01:a57c with SMTP id ne37-20020a1709077ba500b009829b01a57cmr35983845ejc.12.1688040969798;
        Thu, 29 Jun 2023 05:16:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qq2-20020a17090720c200b00992aea2c55dsm589147ejb.153.2023.06.29.05.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:16:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 940D2BC0450; Thu, 29 Jun 2023 14:16:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, fw@strlen.de,
        daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <20230627154439.GA18285@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz> <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Jun 2023 14:16:08 +0200
Message-ID: <87o7kyfoqf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> > The basic idea is we bump a refcnt on the netfilter defrag module and
>> > then run the bpf prog after the defrag module runs. This allows bpf
>> > progs to transparently see full, reassembled packets. The nice thing
>> > about this is that progs don't have to carry around logic to detect
>> > fragments.
>>=20
>> One high-level comment after glancing through the series: Instead of
>> allocating a flag specifically for the defrag module, why not support
>> loading (and holding) arbitrary netfilter modules in the UAPI?
>
> How would that work/look like?
>
> defrag (and conntrack) need special handling because loading these
> modules has no effect on the datapath.
>
> Traditionally, yes, loading was enough, but now with netns being
> ubiquitous we don't want these to get enabled unless needed.
>
> Ignoring bpf, this happens when user adds nftables/iptables rules
> that check for conntrack state, use some form of NAT or use e.g. tproxy.
>
> For bpf a flag during link attachment seemed like the best way
> to go.

Right, I wasn't disputing that having a flag to load a module was a good
idea. On the contrary, I was thinking we'd need many more of these
if/when BPF wants to take advantage of more netfilter code. Say, if a
BPF module wants to call into TPROXY, that module would also need go be
loaded and kept around, no?

I was thinking something along the lines of just having a field
'netfilter_modules[]' where userspace could put an arbitrary number of
module names into, and we'd load all of them and put a ref into the
bpf_link. In principle, we could just have that be a string array of
module names, but that's probably a bit cumbersome (and, well, building
a generic module loader interface into the bpf_like API is not
desirable either). But maybe with an explicit ENUM?

> At the moment I only see two flags for this, namely
> "need defrag" and "need conntrack".
>
> For conntrack, we MIGHT be able to not need a flag but
> maybe verifier could "guess" based on kfuncs used.

If the verifier can just identify the modules from the kfuncs and do the
whole thing automatically, that would of course be even better from an
ease-of-use PoV. Not sure what that would take, though? I seem to recall
having discussions around these lines before that fell down on various
points.

> But for defrag, I don't think its good to add a dummy do-nothing
> kfunc just for expressing the dependency on bpf prog side.

Agreed.

-Toke


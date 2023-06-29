Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4948F74288F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjF2Ogz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjF2Ogt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 10:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06374359B
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688049339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8R5NWbxG8vczdgWdFQsQrHOmepgax0uH77iAdWT6/Y=;
        b=SvKgEmJ23/JFk8w3EWorMgAsWunEXyovlF1SsCt3sFhOjWuFBaGkh7X4IC9f6M2c0PHvF6
        DRDun8y3YnywwY7jpJoCFNCWWiu/cZdp54kFiIZx902HCwdyRbrZ36TVvVr2nc3EnLJAA0
        seNNlXPHoXh3CpuQ2SCAGQrN6BhjFT8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-Yg_jywAUO5WBqpqmTgkzmA-1; Thu, 29 Jun 2023 10:35:38 -0400
X-MC-Unique: Yg_jywAUO5WBqpqmTgkzmA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fbb0fdd060so3980625e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 07:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049337; x=1690641337;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8R5NWbxG8vczdgWdFQsQrHOmepgax0uH77iAdWT6/Y=;
        b=Aul014vMXNQCCDE8RvaQ2/WHRLfAzovabx9MsJQFfEFvn6jhwWnFEmGbJUQq46nJFS
         Os50xGmVg+fpYzckM+uK+twxPG9eDNgKMSeio5OjJ6rfwrgT2n1DImYkrCgZ3jk96OD/
         kBKYpqaurReWDcQE0OgCfuUCTxNZEYX2fK+/Yo88vl8Mh9cPGNdFMa7hpXgKUkWG8NDg
         e7n7PzAN4/OMgLfPBijc8dZyNQOp8K1J2IamAQg/Za3mw0oIvwLdaLbh6k5d6HUuP447
         vQi2VX88lRoWl3mePi+NAb7EOgr/2swZrt0cZhWIn3iZMfzFYl1yWY+Fw3GNgpttPWvU
         jaTg==
X-Gm-Message-State: AC+VfDxXcDC6JB6U0+yCgomfy0xTA8HO6WPxZtIvqO0gzrl+1M+3cD5v
        Md2rYZot32P41zHaWpBIkTH49SYftjlpNSOwQ9RMW3o51fBbBQMikCuYe535xnoIXm+EFCT/cqk
        Isbum2yaCiOmJQYsj2AfcJb7SilG3
X-Received: by 2002:a7b:cd1a:0:b0:3fb:7184:53eb with SMTP id f26-20020a7bcd1a000000b003fb718453ebmr7354223wmj.18.1688049336966;
        Thu, 29 Jun 2023 07:35:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6h7QlIhkGzTRnVyTU2NsDFOF3dILJkeijSsCDj9Q06ewfBcGoUzfIOspcHXewvLQsf+b6htQ==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:7184:53eb with SMTP id f26-20020a7bcd1a000000b003fb718453ebmr7354206wmj.18.1688049336544;
        Thu, 29 Jun 2023 07:35:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003fba92fad35sm4237514wmi.26.2023.06.29.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:35:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5FF87BC0476; Thu, 29 Jun 2023 16:35:35 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     Florian Westphal <fw@strlen.de>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in BPF
In-Reply-To: <20230629132141.GA10165@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz> <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc> <87o7kyfoqf.fsf@toke.dk>
 <20230629132141.GA10165@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Jun 2023 16:35:35 +0200
Message-ID: <87leg2fia0.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> wrote:
>> Florian Westphal <fw@strlen.de> writes:
>> > For bpf a flag during link attachment seemed like the best way
>> > to go.
>>=20
>> Right, I wasn't disputing that having a flag to load a module was a good
>> idea. On the contrary, I was thinking we'd need many more of these
>> if/when BPF wants to take advantage of more netfilter code. Say, if a
>> BPF module wants to call into TPROXY, that module would also need go be
>> loaded and kept around, no?
>
> That seems to be a different topic that has nothing to do with
> either bpf_link or netfilter?
>
> If the program calls into say, TPROXY, then I'd expect that this needs
> to be handled via kfuncs, no? Or if I misunderstand, what do you mean
> by "call into TPROXY"?
>
> And if so, thats already handled at bpf_prog load time, not
> at link creation time, or do I miss something here?
>
> AFAIU, if prog uses such kfuncs, verifier will grab needed module ref
> and if module isn't loaded the kfuncs won't be found and program load
> fails.

...

> Or we are talking about implicit dependencies, where program doesn't
> call function X but needs functionality handled earlier in the pipeline?
>
> The only two instances I know where this is the case for netfilter
> is defrag + conntrack.

Well, I was kinda mixing the two cases above, sorry about that. The
"kfuncs locking the module" was not present in my mind when starting to
talk about that bit...

As for the original question, that's answered by your point above: If
those two modules are the only ones that are likely to need this, then a
flag for each is fine by me - that was the key piece I was missing (I'm
not a netfilter expert, as you well know).

Thanks for clarifying, and apologies for the muddled thinking! :)

-Toke


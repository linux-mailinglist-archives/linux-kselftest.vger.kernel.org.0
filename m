Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6447598D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 16:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGSOwz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjGSOwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 10:52:25 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BD10A;
        Wed, 19 Jul 2023 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Kqsb0fKqXuddaGLRwkdYnwQAM8mRnY5GWRE0NyPAsTA=; b=nhHbNdt/DyZ/I6ng+OyngPze8D
        Vdv/VkVPTd2pV16U0xpAGakdfaIsi3jZviBeJPdnrKBgEMJFTE1AKrHW+U6pYBxAFfB7QESgSb2/D
        qLFaHVonxam59UdGHvY1No8cpGir1LoNscJj4TJ24fcHyAUbydy6cH6zX6j0sLk+yJQuoJrOg3GVl
        SVFzTW/YW55trd/4DvTNoMFofZJEylKruG85JoCFu7JLyWAElm6W4kafJzGn1l/4ti4sYR1yzvLx4
        CQ1j5rpLoWzDGyvp9+Ozj5rYlsvs8ULGdTBHWmjgbgSF68yCmEt19j3gTOvHLam+8L811m43UlGrC
        bqmfsHPw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qM8XL-000FxS-G6; Wed, 19 Jul 2023 16:52:19 +0200
Received: from [124.148.184.141] (helo=192-168-1-114.tpgi.com.au)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qM8XK-000RUH-5H; Wed, 19 Jul 2023 16:52:18 +0200
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
To:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20230502005218.3627530-1-drosen@google.com>
 <20230718082615.08448806@kernel.org>
 <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
 <20230718090632.4590bae3@kernel.org>
 <CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
 <20230718101841.146efae0@kernel.org>
 <CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
 <20230718111101.57b1d411@kernel.org>
 <CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
 <20230718160612.71f09752@kernel.org>
 <CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
 <20230718162138.24329391@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bcc5fbaf-83f3-cc05-67b3-512b44818321@iogearbox.net>
Date:   Wed, 19 Jul 2023 16:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230718162138.24329391@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26974/Wed Jul 19 09:28:18 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/23 1:21 AM, Jakub Kicinski wrote:
> On Tue, 18 Jul 2023 16:17:24 -0700 Alexei Starovoitov wrote:
>> Which would encourage bnxt-like hacks.
>> I don't like it tbh.
>> At least skb_pointer_if_linear() has a clear meaning.
>> It's more run-time overhead, since buffer__opt is checked early,
>> but that's ok.
> 
> Alright, your version fine by me, too. Thanks!

Looks good to me too. Agree that the !buffer check should not live in
__skb_header_pointer() and is better handled in the bpf_dynptr_slice()
internals.

Thanks,
Daniel

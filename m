Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67A2580DC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiGZHcf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 03:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiGZHcD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 03:32:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0E2ED77
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Jul 2022 00:28:02 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r3so23982131ybr.6
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Jul 2022 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvOrjB34rm7PzOpcu5vN7H48T73Za5L36kUOrTOg6ZU=;
        b=UYCAqLQdkCe++bxbvoqb8ja13KXFhIBaW0rC+YYqYq4gvHo+TFgKPF/GZuT91VmSB8
         C1W+AZw4l9ok/cijI6EPFtIFecx9ElKI75nt3EZmXPMl0ME3rxCMtwt6FCqEcqAzlXgc
         L7pKvLgAUNdI/gsvxXkfFlg5biXeIuPvgjq6OlZZ2cbEWC7jVJ6RmvIswJs0R1wPEInh
         sNGMWt8YNJtmjzLBgsGVFMhf8MoqqCx0CeHLgs7fbxPF4hIut+LmlvHlIRh5UZesH3nX
         o77xUb6eSknQa9/tZQ3BGK1QZOpg9ZmseIfEITeaJYNYQSmSvHlSqBbMN8jvoIXgWsY1
         JjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvOrjB34rm7PzOpcu5vN7H48T73Za5L36kUOrTOg6ZU=;
        b=SVBw1L4WKhhv9LTNS6SPNX1Ilh9eBmUeCuQnp4CZWTIvE5i+6PFDR/a09v+TuqCrsS
         02BZ4kfyajmmI3Oq6ANLXJD9ZlAKGGEwKDl/jd3QbfsPE34BAMW025oSB/6yqW3BU0F4
         Fuy4QWyqX3R7OaYm0UWP3jUSYD5DI9SL8DSEQD9f6H6D4gcvf+Cfo+D2l5eynwWuCMb6
         atTNMV+tnKz8GbbnU0yV2kIOqPkO1s+/FRlRMBGcGK24/IVYgmNL5zJ5q25U35ipU93b
         NMak6AtB1zajnQgcztMmJqD66rXpJ9FgHJFpMyONn7tl1sWuFT7wJQd7KVn/bJxi2xs7
         C8zQ==
X-Gm-Message-State: AJIora+Stzk+F/zEkojOUSdP80IE9AAAMByRyvXQzDa9J8/AVOHg0loR
        pVib0rfkJ8HUI1Jk3kbhJ4YwPsnIJwqwQ5Ibx62Jxw==
X-Google-Smtp-Source: AGRyM1uv33zE0Yb5is3EhxTK8li350eCyxt4TvCNmDbhnKmlwtoEaE5nifSRGC+74wymZu7Olm8dTCRPLhrYeL6/L+k=
X-Received: by 2002:a25:13c8:0:b0:670:6a55:5fad with SMTP id
 191-20020a2513c8000000b006706a555fadmr12357687ybt.598.1658820477779; Tue, 26
 Jul 2022 00:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658815925.git.cdleonard@gmail.com> <ad19d5c8a24054d48e1c35bb0ec92075b9f0dc6a.1658815925.git.cdleonard@gmail.com>
 <CANn89i+ByJsdKLXi982jq0H3irYg_ANSEdmL2zwZ_7G-E_g2eg@mail.gmail.com>
In-Reply-To: <CANn89i+ByJsdKLXi982jq0H3irYg_ANSEdmL2zwZ_7G-E_g2eg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 26 Jul 2022 09:27:46 +0200
Message-ID: <CANn89i+=LVDFx_zjDy6uK+QorR+fosdkb8jqNMO6syqOsS7ZqQ@mail.gmail.com>
Subject: Re: [PATCH v6 21/26] selftests: net/fcnal: Initial tcp_authopt support
To:     Leonard Crestez <cdleonard@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, Philip Paeps <philip@trouble.is>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Yuchung Cheng <ycheng@google.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Ivan Delalande <colona@arista.com>,
        Caowangbao <caowangbao@huawei.com>,
        Priyaranjan Jha <priyarjha@google.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 26, 2022 at 9:06 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Jul 26, 2022 at 8:16 AM Leonard Crestez <cdleonard@gmail.com> wrote:
> >
> > Tests are mostly copied from tcp_md5 with minor changes.
> >
> > It covers VRF support but only based on binding multiple servers: not
> > multiple keys bound to different interfaces.
> >
> > Also add a specific -t tcp_authopt to run only these tests specifically.
> >
>
> Thanks for the test.
>
> Could you amend the existing TCP MD5 test to make sure dual sockets
> mode is working ?
>
> Apparently, if we have a dual stack listener socket (AF_INET6),
> correct incoming IPV4 SYNs are dropped.
>
>  If this is the case, fixing MD5 should happen first ;)
>
> I think that we are very late in the cycle (linux-5.19 should be
> released in 5 days), and your patch set should not be merged so late.

I suspect bug was added in

commit 7bbb765b73496699a165d505ecdce962f903b422
Author: Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Wed Feb 23 17:57:40 2022 +0000

    net/tcp: Merge TCP-MD5 inbound callbacks

a possible fix (also removing an indirect call for IPV4) could be:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ba2bdc81137490bd1748cde95789f8d2bff3ab0f..66b883d1683ddf7de6a8959a2b4e025a74c830b1
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4534,8 +4534,14 @@ tcp_inbound_md5_hash(const struct sock *sk,
const struct sk_buff *skb,
        }

        /* check the signature */
-       genhash = tp->af_specific->calc_md5_hash(newhash, hash_expected,
-                                                NULL, skb);
+       if (family == AF_INET)
+               genhash = tcp_v4_md5_hash_skb(newhash,
+                                             hash_expected,
+                                             NULL, skb);
+       else
+               genhash = tp->af_specific->calc_md5_hash(newhash,
+                                                        hash_expected,
+                                                        NULL, skb);

        if (genhash || memcmp(hash_location, newhash, 16) != 0) {
                NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D467860CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 21:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjHWTkg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbjHWTkd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 15:40:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507EE6E;
        Wed, 23 Aug 2023 12:40:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fee8b78097so38840875e9.0;
        Wed, 23 Aug 2023 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692819629; x=1693424429;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZSBOiLjL7l4F5q6riFKLA/ZyFchhCDJyrcaJS20FpE=;
        b=Q7c+th06liDrGKX59Uzi5rXxttPg1iqISxM15+Jq+aB0TfOeh4bkBa2ZLINqjE7wWX
         jCNS0fAxlK1BQvlLtPDPOYVxFHLOCtEw2y51RwVfRaDWJWGsJx1IhZTYZliINrNXV1yU
         RTWRAT5xEfOgO96iBgkdvT2Ovhd/rTrLH0MNCJN08op1yL0yhfqtC6gJMaLjxgdurNSh
         FrJGFt5IakrtZJZ+zS3pOETgKN4f5uyvYNJ/yUrv6XSQyKQvsl2fmUPuZ8RGj75dJa/Z
         juGJHUwVpfpSWhJfXUha7lIDJtPl0V5In9oz6iLERTSi/czSVBdKPN+7HZC5OtUdK1g6
         P0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819629; x=1693424429;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZSBOiLjL7l4F5q6riFKLA/ZyFchhCDJyrcaJS20FpE=;
        b=SeVwLHRc2ljd7sLqgyfsdNSTMiuxidT8xJGWII5ZtgrmVgUmtfO9WbP3oSex5RAj+J
         xZpUrFLcmTUKBaMBeIQZ7aoe1Dtf0D4m27fkoprf7rSumflZ8VuBzKQkckK4VbrPv8yQ
         /HOpPEjxVdXIybLSg13ARys0Si82yejQ3dtUdt0bUM+lCBM1Rs2rVM4fEjbVxgBAQm5S
         jEgKBJf2ReQ/yLwkUszeT0Aql2wTQN76MWfgyNRNkIXIA77MZZQ9VeolzpgfP3A7iuMW
         Y7tqOzVJLLurnb3aoOU+QL8EUDNFaZPd29g18tDFKH3UvB1fnQE5mQMYsoSk6mJhvKYR
         OjyA==
X-Gm-Message-State: AOJu0YwSKJVcfujzSsd96q6N53zbKdgW1VLmgqBuXJUbdrosVZ0pgwgD
        DafMzeaA88XHPOOG/Ohr7VI=
X-Google-Smtp-Source: AGHT+IFzQqUZNW2Ms4UX0ii01iwiE4BupQm9WH+y8SjsIil3cZMc3ISo746anHc7lRrm7ibTKpTnyA==
X-Received: by 2002:a05:600c:d8:b0:3fe:e812:4709 with SMTP id u24-20020a05600c00d800b003fee8124709mr9585282wmm.12.1692819628516;
        Wed, 23 Aug 2023 12:40:28 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx ([2001:8f8:1163:806e:99f3:c946:a43c:e1e3])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bca54000000b003fe3674bb39sm503196wml.2.2023.08.23.12.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:40:28 -0700 (PDT)
Date:   Wed, 23 Aug 2023 23:40:23 +0400
From:   Mahmoud Matook <mahmoudmatook.mm@gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] selftests/net: replace ternary operator with
 min()/max()
Message-ID: <20230823194023.zc3p6g2atwjz6hbp@mmaatuq-HP-Laptop-15-dy2xxx>
Mail-Followup-To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-3-mahmoudmatook.mm@gmail.com>
 <64e22ce99cfa6_35801629446@willemb.c.googlers.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64e22ce99cfa6_35801629446@willemb.c.googlers.com.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/20, Willem de Bruijn wrote:

> Mahmoud Maatuq wrote:
> > Fix the following coccicheck warning:
> > tools/testing/selftests/net/udpgso_bench_tx.c:297:18-19: WARNING opportunity for min()
> > tools/testing/selftests/net/udpgso_bench_tx.c:354:27-28: WARNING opportunity for min()
> > tools/testing/selftests/net/so_txtime.c:129:24-26: WARNING opportunity for max()
> > tools/testing/selftests/net/so_txtime.c:96:30-31: WARNING opportunity for max()
> > 
> > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > ---
> >  tools/testing/selftests/net/Makefile          | 2 ++
> >  tools/testing/selftests/net/so_txtime.c       | 7 ++++---
> >  tools/testing/selftests/net/udpgso_bench_tx.c | 6 +++---
> >  3 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > index 7f3ab2a93ed6..a06cc25489f9 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -3,6 +3,8 @@
> >  
> >  CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
> >  CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
> > +# Additional include paths needed by kselftest.h
> > +CFLAGS += -I../
> 
> Why this, instead of the existing include with relative path?
>
no big reason other than that version was added in a previous patch that was accepted 
https://lore.kernel.org/all/168972782004.15840.17484255346823026.git-patchwork-notify@kernel.org/#r

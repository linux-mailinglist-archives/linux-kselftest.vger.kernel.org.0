Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F970A54D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 06:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjETEWx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 00:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjETEWv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 00:22:51 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F6E40
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 21:22:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-563b1e5f701so10993767b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684556569; x=1687148569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtTOSvtfQG93Oel0meKxRB+k4uCHs3I7uk0ZTZm75x8=;
        b=Q1EECUwMrhw+/VXBEDI08aoB2G39WG+y6CST9973Czb0jNct9GJ8fvqXwZQ02FdRM3
         cKLG5mt5dpzf002oCDfbU9jbnIZTqsxzdoQXfTG73/oJYi0BZ/JZMm9ASd56fOw4H4Nz
         LLq9BTdtd8cU7BNRVp9zQyK8+mPz4vJYBcLFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684556569; x=1687148569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtTOSvtfQG93Oel0meKxRB+k4uCHs3I7uk0ZTZm75x8=;
        b=S2VR25qXlObD0WmO1bFJPYmgm6om1QW1ZlqivDr87HcE8Y9D38NCZIjfndeGv9+jMx
         T8I+gcbFKuIeY53o/iEzKEe8XE+DUlNdSUteIVjZsMOzu8xsjNzp8Zdq+16x8pzZJ0ws
         7BClMaf4Lsb5tJ52/YaX/fDNVFWb8rgZdJfMDowJnoamk1UKMVjWzkvgBS9LTM0hNFrA
         wgzZd0mrfuTugHTY8zOYl8lGN/xK4kKPgFRzkbh5jzrE9ACCZUiU/OaVEa/BAK7pzekR
         EcHjvmX+UeL+LIrTTBSjxP2S9UE3iqyTx6yyGClwEqoJFq0DZJ4+yTXJSQaa/SxshDZc
         vO0g==
X-Gm-Message-State: AC+VfDw6HAoRh750NrMAc4A7xxuacNJhsWu/4j9GPLj+bD4m9Yxl1Dhh
        Q7JEHKOBoH3bbExg+WlYItDDZ75iL2KctUxNj6Bh8o573rSL4sl56QI=
X-Google-Smtp-Source: ACHHUZ4NMcs0KKTciTfhFcPKbClou7h2OuXMWrw7zvwLfXuyRiIvLoBZUabWp3vqHHxnFyfuxaywKWAJmJPzE4ag+II=
X-Received: by 2002:a0d:e288:0:b0:545:637c:3ed7 with SMTP id
 l130-20020a0de288000000b00545637c3ed7mr4458531ywe.1.1684556569453; Fri, 19
 May 2023 21:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
 <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
 <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
 <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com> <CAEXW_YS-ScBYeTtj7PTZSSYXeApsZ1vhTpBFtq5jNA_R9055=Q@mail.gmail.com>
In-Reply-To: <CAEXW_YS-ScBYeTtj7PTZSSYXeApsZ1vhTpBFtq5jNA_R9055=Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 20 May 2023 00:22:38 -0400
Message-ID: <CAEXW_YRbekxrn4iUvWGzJBfwMButjT=srHZS2H9P910K8YmH=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 20, 2023 at 12:14=E2=80=AFAM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Sat, May 20, 2023 at 12:01=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, May 19, 2023 at 8:57=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > I also realize that I don't really need to check whether the masked
> > > source address falls under a VMA neighboring to that of the source's.
> >
> > I don't think that's true.
> >
> > You can't start randomly moving other source vma's that may have other =
contents.
>
> If the beginning part of the PMD is not mapped at the destination, I
> thought maybe a whole PMD could be moved to it. But I guess not
> because we don't want those contents to be accessible. So then in that
> case we have to forbid the optimization for all intra-VMA moves except
> those involving the stack. I will think more about it.

Duh, we can't move crap from the source like that also because it has
real data. I think I got confused between "moving" and "copying". I
feel silly, maybe it is time to go to sleep and live to fight another
day.

 - Joel

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0F5BCAEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiISLkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiISLkv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 07:40:51 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054AD15FFC;
        Mon, 19 Sep 2022 04:40:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 198so37036033ybc.1;
        Mon, 19 Sep 2022 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=99zbpHyljYgorKF920Y7sKiR42NQt8fjAj417BqAEvM=;
        b=B9YfLnYqiSoPPoQXpq9fMjhAnUNXVLaypeVd33fU7AzcEi7beWb1nDqIheJCZ0D9Bo
         851PwQhks1dvH9DHcYEZi6d9Jy6bhe+8ELmEBzUe1KpjHUNRK6ZJ/ZL5uxSBoRc5YzU5
         6X4LrUlaug4JFSGW8RIUBn8Ffyp+7TyKkH4E78EcaGnsFRznqGdFJojxk/G0lZFUpvqq
         ctGiFaYlpPUngHdZ0xlITcXJQDQkfZB1CH//gDHJKsSbu03IO2Q6Gl1BjHaUPjRQrmco
         nsFpZnwjy/X034T6aUiPGOtEp/O1H2Ifm+EQNe7q/5v6Q5L4iISnBs/WZgMh7qWHhm3A
         tRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=99zbpHyljYgorKF920Y7sKiR42NQt8fjAj417BqAEvM=;
        b=Xb3SDiu+iBLiP4AFsEsPW0rz5Eu80J0cTS//vx/fLAPfdT5zNo56oIgnQOyq39VTWZ
         OU8pTJpNV4kpMpQcAER35jaVja3VA6Ukai7mGjcSpXL7zSyYLU62bC1bzl8jJ2JYowg3
         h6Hj/qt8DskK9BPAL2L2aStORA7rTFs6eS4x05ys7nu/sk6ih6RrO7FV9ZGk+caL6egu
         SBmnTZ6UDe8KI9udsGZ/jUOWBZWv1aaNm1Hp8I0s+ZgBDZjyiYTKJtahEepkNIHg1E4g
         d6tcCRTLmZkkPO8k/eEdwb63KBd+yIUcf9J187K2HEm/piZLjyDM+PNh7nCo7SskJc7n
         4P8w==
X-Gm-Message-State: ACrzQf3ChMApoX14PaO2KnglauUuwzTF6AP3YsDk3kMqHB/yALGiNDiG
        QPIV6BcVYd9134lPNmwdk4igR2qPfxu4XNTVC2rN/BGPGz8=
X-Google-Smtp-Source: AMsMyM5TdD4vl/dOOkzUqbZdwVEK/mnJxlfCKc3Bik1j5Kp9r99vkYfgD0J1ICbJ+yjVv/CCrpb97bj8pqhiRoXr1FE=
X-Received: by 2002:a5b:107:0:b0:67c:4077:17f0 with SMTP id
 7-20020a5b0107000000b0067c407717f0mr13252085ybx.363.1663587650140; Mon, 19
 Sep 2022 04:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220917071427.28499-1-akinobu.mita@gmail.com> <93c044ca-7d2f-e23f-8eb4-72c133737a15@redhat.com>
In-Reply-To: <93c044ca-7d2f-e23f-8eb4-72c133737a15@redhat.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 19 Sep 2022 20:40:38 +0900
Message-ID: <CAC5umyhhnoJvoGT5NQX8VNn4QT_3qA1nY5tnZre59pL7vbMpzg@mail.gmail.com>
Subject: Re: [PATCH -v2] lib/notifier-error-inject: fix error when writing
 errno to debugfs file
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, osalvador@suse.de,
        shuah@kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

2022=E5=B9=B49=E6=9C=8819=E6=97=A5(=E6=9C=88) 18:20 David Hildenbrand <davi=
d@redhat.com>:
>
> On 17.09.22 09:14, Akinobu Mita wrote:
> > The simple attribute files do not accept a negative value since the
> > commit 488dac0c9237 ("libfs: fix error cast of negative value in
> > simple_attr_write()"), so we can no longer use DEFINE_SIMPLE_ATTRIBUTE(=
) to
> > define a file operations for errno value.
> >
> > Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple=
_attr_write()")
> > Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> But shouldn't we fix simple_attr_write() instead?
>
> I mean, simple_attr_read() might use attr->fmt to print a signed value,
> but simple_attr_write() fails on signed values now?
>
> I might be wrong, but there is a disconnect. I feel like
> simple_attr_write() should similarly make decisions based on attr->fmt.

I agree there is a disconnect, but I have no idea how to fix
simple_attr_write().
(strcmp(attr->fmt, "%%lld\n") is ugly)
If no one seems to come up with a good idea, I'll fix the similar problems
in fault-injection the same way I did here.

Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E643B5ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Oct 2021 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbhJZPqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbhJZPqL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 11:46:11 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57BC061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 08:43:47 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id f24so10836486uav.12
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 08:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VyoOlx1f4bY9qJ0WEn854eIaH9saJD/psl6FGa9mBmM=;
        b=PYjGf1rSfLl3AT/XmHIgxkE/MkWPrNFapw7LKRlbQJnDGsCzRlzTcKlcjl6drzLmpD
         PIHMrLFga8mSRuUiu9HJWk01nPt2tCeS1E6yGe+cvrht/eEWwL7KvFbiU7gw6HQ0RUSN
         w3mK4wQiXtLieIbNccbZnXpAcH5AXCYX8OVE1H650IO8A0VK3uTskGzQLLL0W6Peyj4k
         rhllbJzUdxQeUHiBTMd1gGoYURUeXOMKSQwwI7vgJUJe5FEmfk8/ll4xo9r1+SiYAxK8
         Ef4GIKcv6u07n/azdD3Rq65MZok0yaFabVd8E2JTn7XZgb7WdkFLvxaEt2AaDyoBQ3ja
         s+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=VyoOlx1f4bY9qJ0WEn854eIaH9saJD/psl6FGa9mBmM=;
        b=rCuysWEwXdHF+pywdsVs+Nit7LZw8zN9OVGal3J6/raVSagewe4DB94lnv7uSKZi1c
         nfWjH5UyuzrwmMnVvQ0W9D7QYKVplmSOUHjCbiYO/OBpvAKocpHeEJknrckfqc7n/uMG
         ryTD2+718lbHkK843cw1Hx30qUVLkfQJLZFH3uIpiSgsohQfnXXnu7X8s+/CfyELMpyd
         ghe6VvDQZcgC+ZBv2WlHoqCbjqZBt0OzWwEyr/1sfP6C1cgr9yPEiiMoaB1043bDYEY3
         6y+6gMUPO+v6vkJe5qalJqOvrAqOcZuJPPaCkeqVyp7Zi8qekYBTGnt3YpF7PzrzHvDK
         /hDg==
X-Gm-Message-State: AOAM530BedTzXsBgINdxLIfCFkeUlvPTr3QvHaCRFRvfWKBKme7VAX9h
        Zak1RfRj1qFZY/8iL3OV34tQLnDWaNOrIHk8xB0=
X-Google-Smtp-Source: ABdhPJyNYtmw60n6JU2ln4cM/jqvgxUV9T9jjXbRo/qFYUyUZkmh1kEAHX72WvC+m2CrsAeao5HU9LfWXSEnfEp4QNM=
X-Received: by 2002:a67:c205:: with SMTP id i5mr24319494vsj.19.1635263026437;
 Tue, 26 Oct 2021 08:43:46 -0700 (PDT)
MIME-Version: 1.0
Sender: aishagaddafi1056@gmail.com
Received: by 2002:a59:cf85:0:b0:235:f6e1:247f with HTTP; Tue, 26 Oct 2021
 08:43:46 -0700 (PDT)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Tue, 26 Oct 2021 15:43:46 +0000
X-Google-Sender-Auth: La5vyoLeifJCpfF95J7FaooDtgw
Message-ID: <CANtwLy3KoG-xoW4nZgjy2ttiKzG8hi8gXR6HE2CXZpgEtwQXqQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello my dear ,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Mckenna Howley., a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina Mckenna..
